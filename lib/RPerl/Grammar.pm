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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\=\ sub\ \{|package|while\ \(|elsif\ \(|\$TYPED_|undef|else|if\ \(|\(\ my|qw\(|use|\@_\;|our|\%\{|my|\@\{|\.\.|\;|\}|\]|\))}gc and return ($1, $1);

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
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(\+=|-=|\*=|\/=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LEFT_PAREN', $1);
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
  [ 'Operator_93' => 'Operator', [ 'OP05_MATH_NEG_LEFT_PAREN', 'SubExpression', ')' ], 0 ],
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
	OP05_MATH_NEG_LEFT_PAREN => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 9,
			"package" => -20,
			'SHEBANG' => 4
		},
		GOTOS => {
			'Critic' => 5,
			'PAREN-1' => 8,
			'CompileUnit' => 7,
			'OPTIONAL-9' => 6,
			'Program' => 3,
			'ModuleHeader' => 2,
			'PLUS-2' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 9,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 6,
			'ModuleHeader' => 2,
			'Critic' => 5,
			'PAREN-1' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"use constant" => -25,
			"use" => -25,
			"use parent qw(" => 12,
			"our" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Package' => 13,
			'Module' => 15,
			'STAR-10' => 14,
			'Class' => 11
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 17,
			'OPTIONAL-3' => 16
		}
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		ACTIONS => {
			"package" => 18
		}
	},
	{#State 7
		ACTIONS => {
			'' => 19
		}
	},
	{#State 8
		DEFAULT => -3
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
		DEFAULT => -23
	},
	{#State 12
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		ACTIONS => {
			"use" => -27,
			"use constant" => -27,
			"our" => -27,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'STAR-11' => 25,
			'Critic' => 26
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			"use strict;" => 28
		},
		GOTOS => {
			'Header' => 27
		}
	},
	{#State 17
		DEFAULT => -6
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 19
		DEFAULT => 0
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
		DEFAULT => -203
	},
	{#State 23
		DEFAULT => -202
	},
	{#State 24
		ACTIONS => {
			")" => 32
		}
	},
	{#State 25
		ACTIONS => {
			"our" => -29,
			"use" => 35,
			"use constant" => -29
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 33
		}
	},
	{#State 26
		DEFAULT => -24
	},
	{#State 27
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 36
		}
	},
	{#State 28
		ACTIONS => {
			"use warnings;" => 37
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
			"our" => 43,
			"use constant" => 44
		},
		GOTOS => {
			'Subroutine' => 42,
			'PLUS-13' => 41,
			'Constant' => 40
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 45
		}
	},
	{#State 36
		ACTIONS => {
			'OP01_NAMED_VOID' => -11,
			"%{" => -11,
			'WORD' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"if (" => -11,
			'WORD_SCOPED' => -11,
			"my" => -11,
			'OP01_CLOSE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"our" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP05_MATH_NEG_LEFT_PAREN' => -11,
			"while (" => -11,
			'LEFT_BRACKET' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"foreach my" => -11,
			'OP01_PRINT' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			'LEFT_PAREN' => -11,
			"for my integer" => -11,
			'LEFT_BRACE' => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_OPEN' => -11,
			"use" => -11,
			'LITERAL_NUMBER' => -11,
			"## no critic qw(" => 9,
			"\@{" => -11,
			"undef" => -11,
			"use constant" => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED' => -11
		},
		GOTOS => {
			'STAR-5' => 47,
			'Critic' => 46
		}
	},
	{#State 37
		ACTIONS => {
			"use RPerl;" => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 28
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
		DEFAULT => -28
	},
	{#State 41
		ACTIONS => {
			'LITERAL_NUMBER' => 52,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 51
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
			'WORD' => 55
		}
	},
	{#State 45
		ACTIONS => {
			";" => 57,
			"qw(" => 56
		}
	},
	{#State 46
		DEFAULT => -8
	},
	{#State 47
		ACTIONS => {
			"our" => -13,
			'OP01_CLOSE' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP05_MATH_NEG_LEFT_PAREN' => -13,
			"while (" => -13,
			'VARIABLE_SYMBOL' => -13,
			'WORD' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID' => -13,
			"%{" => -13,
			"my" => -13,
			"if (" => -13,
			'WORD_SCOPED' => -13,
			'LITERAL_NUMBER' => -13,
			"\@{" => -13,
			"undef" => -13,
			'OP01_OPEN' => -13,
			"use" => 35,
			'OP01_NAMED' => -13,
			"use constant" => -13,
			'LITERAL_STRING' => -13,
			"foreach my" => -13,
			'OP01_PRINT' => -13,
			'LEFT_BRACKET' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LEFT_PAREN' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			"for my integer" => -13,
			'LEFT_BRACE' => -13
		},
		GOTOS => {
			'STAR-6' => 58,
			'Include' => 59
		}
	},
	{#State 48
		ACTIONS => {
			"our" => 60
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
		DEFAULT => -30
	},
	{#State 52
		ACTIONS => {
			";" => 62
		}
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 63
		}
	},
	{#State 54
		DEFAULT => -205
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
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
			'OP01_CLOSE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_OPEN' => -15,
			"our" => -15,
			"\@{" => -15,
			'LITERAL_NUMBER' => -15,
			"undef" => -15,
			"use constant" => 44,
			'LITERAL_STRING' => -15,
			'VARIABLE_SYMBOL' => -15,
			"while (" => -15,
			'OP05_MATH_NEG_LEFT_PAREN' => -15,
			'OP01_NAMED' => -15,
			'LEFT_BRACKET' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"%{" => -15,
			"foreach my" => -15,
			'WORD' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_PRINT' => -15,
			"for my integer" => -15,
			'LEFT_PAREN' => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			"if (" => -15,
			'LEFT_BRACE' => -15,
			'WORD_SCOPED' => -15,
			"my" => -15,
			'OP22_LOGICAL_NOT' => -15,
			'OP10_NAMED_UNARY' => -15
		},
		GOTOS => {
			'STAR-7' => 67,
			'Constant' => 68
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
			"our %properties = (" => -54,
			"use" => -54,
			"use constant" => -54,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'STAR-21' => 71,
			'Critic' => 70
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
		ACTIONS => {
			"my" => 74
		},
		GOTOS => {
			'TypeInner' => 73
		}
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
		ACTIONS => {
			'OP01_NAMED' => 80,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			"while (" => -143,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 89,
			"our" => 43,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 116,
			'OP10_NAMED_UNARY' => 95,
			"if (" => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			"for my integer" => -143,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'WORD' => 121,
			"foreach my" => -143,
			'OP01_PRINT' => 101,
			'OP05_LOGICAL_NEG' => 120,
			'OP01_NAMED_VOID' => 119,
			'LEFT_BRACKET' => 100,
			'OP19_LOOP_CONTROL' => 99,
			"%{" => 118
		},
		GOTOS => {
			'Operation' => 117,
			'Subroutine' => 103,
			'Statement' => 102,
			'VariableModification' => 90,
			'Expression' => 115,
			'Variable' => 96,
			'Literal' => 94,
			'OperatorVoid' => 114,
			'HashReference' => 97,
			'Conditional' => 83,
			'ArrayDereferenced' => 85,
			'PLUS-8' => 82,
			'LoopLabel' => 109,
			'SubExpression' => 110,
			'WordScoped' => 112,
			'Operator' => 111,
			'ArrayReference' => 87,
			'HashDereferenced' => 77,
			'VariableDeclaration' => 79,
			'PAREN-38' => 106,
			'OPTIONAL-39' => 81
		}
	},
	{#State 68
		DEFAULT => -12
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		DEFAULT => -51
	},
	{#State 71
		ACTIONS => {
			"our %properties = (" => -56,
			"use" => 35,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 123,
			'STAR-22' => 122
		}
	},
	{#State 72
		ACTIONS => {
			'LEFT_BRACKET' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"%{" => -43,
			"foreach my" => -43,
			'WORD' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_PRINT' => -43,
			"for my integer" => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'LEFT_PAREN' => -43,
			"if (" => -43,
			'LEFT_BRACE' => -43,
			'WORD_SCOPED' => -43,
			"my" => -43,
			'OP22_LOGICAL_NOT' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_CLOSE' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"( my" => 125,
			'OP01_OPEN' => -43,
			"\@{" => -43,
			'LITERAL_NUMBER' => -43,
			"undef" => -43,
			'LITERAL_STRING' => -43,
			'VARIABLE_SYMBOL' => -43,
			"while (" => -43,
			'OP01_NAMED' => -43,
			'OP05_MATH_NEG_LEFT_PAREN' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 126,
			'OPTIONAL-16' => 124
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_NUMBER' => 89,
			'LITERAL_STRING' => 78
		},
		GOTOS => {
			'Literal' => 127
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 128
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
		DEFAULT => -136
	},
	{#State 78
		DEFAULT => -207
	},
	{#State 79
		DEFAULT => -147
	},
	{#State 80
		ACTIONS => {
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 130,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 74,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92
		},
		GOTOS => {
			'ListElement' => 134,
			'ArrayDereferenced' => 85,
			'TypeInner' => 135,
			'ArrayReference' => 87,
			'WordScoped' => 112,
			'SubExpression' => 132,
			'Operator' => 111,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133
		}
	},
	{#State 81
		ACTIONS => {
			"for my integer" => 140,
			"while (" => 143,
			"foreach my" => 139
		},
		GOTOS => {
			'LoopWhile' => 138,
			'Loop' => 137,
			'LoopFor' => 142,
			'LoopForEach' => 141
		}
	},
	{#State 82
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 116,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 92,
			"if (" => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			"for my integer" => -143,
			'OP01_PRINT' => 101,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 121,
			"foreach my" => -143,
			"%{" => 118,
			'OP19_LOOP_CONTROL' => 99,
			'LEFT_BRACKET' => 100,
			'OP01_NAMED_VOID' => 119,
			'OP01_NAMED' => 80,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			"while (" => -143,
			'' => -18,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108
		},
		GOTOS => {
			'HashDereferenced' => 77,
			'VariableDeclaration' => 79,
			'PAREN-38' => 106,
			'OPTIONAL-39' => 81,
			'ArrayDereferenced' => 85,
			'Conditional' => 83,
			'LoopLabel' => 109,
			'Operator' => 111,
			'WordScoped' => 112,
			'SubExpression' => 110,
			'ArrayReference' => 87,
			'VariableModification' => 90,
			'Expression' => 115,
			'Variable' => 96,
			'Literal' => 94,
			'OperatorVoid' => 114,
			'HashReference' => 97,
			'Operation' => 144,
			'Statement' => 102
		}
	},
	{#State 83
		DEFAULT => -144
	},
	{#State 84
		ACTIONS => {
			"my" => 145
		}
	},
	{#State 85
		DEFAULT => -134
	},
	{#State 86
		DEFAULT => -130
	},
	{#State 87
		DEFAULT => -133
	},
	{#State 88
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'LEFT_BRACKET' => 100
		},
		GOTOS => {
			'Variable' => 146,
			'ArrayReference' => 147
		}
	},
	{#State 89
		DEFAULT => -208
	},
	{#State 90
		DEFAULT => -148
	},
	{#State 91
		ACTIONS => {
			'WORD' => 148,
			"}" => 150,
			"%{" => 118
		},
		GOTOS => {
			'HashEntry' => 149,
			'HashDereferenced' => 151
		}
	},
	{#State 92
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 120,
			'OP01_PRINT' => 153,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 152,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'HashDereferenced' => 77,
			'SubExpression' => 154,
			'Operator' => 111,
			'WordScoped' => 112,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 85
		}
	},
	{#State 93
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'SubExpression' => 155,
			'Operator' => 111,
			'WordScoped' => 112,
			'HashDereferenced' => 77,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashReference' => 97
		}
	},
	{#State 94
		DEFAULT => -131
	},
	{#State 95
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98
		},
		GOTOS => {
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'HashReference' => 97,
			'HashDereferenced' => 77,
			'ArrayReference' => 87,
			'SubExpression' => 156,
			'Operator' => 111,
			'WordScoped' => 112,
			'ArrayDereferenced' => 85
		}
	},
	{#State 96
		ACTIONS => {
			'OP08_STRING_CAT' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP19_VARIABLE_ASSIGN_BY' => 158,
			'OP18_TERNARY' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP03_MATH_INC_DEC' => 159,
			'OP16_LOGICAL_OR' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP12_COMPARE_EQ_NEQ' => -132,
			'OP04_MATH_POW' => -132,
			'OP02_METHOD_THINARROW' => 157,
			'OP17_LIST_RANGE' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP19_VARIABLE_ASSIGN' => 160,
			'OP15_LOGICAL_AND' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP09_BITWISE_SHIFT' => -132
		}
	},
	{#State 97
		DEFAULT => -135
	},
	{#State 98
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 161,
			'ArrayReference' => 87,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94
		}
	},
	{#State 99
		ACTIONS => {
			'WORD' => 163
		},
		GOTOS => {
			'LoopLabel' => 162
		}
	},
	{#State 100
		ACTIONS => {
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"]" => -186,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_QW' => 165,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 130,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 74,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'HashReference' => 97,
			'ListElements' => 167,
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'HashDereferenced' => 77,
			'TypeInner' => 135,
			'ArrayReference' => 87,
			'SubExpression' => 164,
			'WordScoped' => 112,
			'Operator' => 111,
			'OPTIONAL-49' => 166,
			'ListElement' => 168,
			'ArrayDereferenced' => 85
		}
	},
	{#State 101
		ACTIONS => {
			'VARIABLE_SYMBOL' => -114,
			'LITERAL_STRING' => -114,
			'OP01_QW' => -114,
			'OP01_NAMED' => -114,
			'OP05_MATH_NEG_LEFT_PAREN' => -114,
			'FH_REF_SYMBOL_BRACES' => 171,
			'OP01_CLOSE' => -114,
			'OP01_OPEN' => -114,
			'OP03_MATH_INC_DEC' => -114,
			'LITERAL_NUMBER' => -114,
			"\@{" => -114,
			"undef" => -114,
			'LEFT_PAREN' => -114,
			'OP10_NAMED_UNARY_STRINGIFY' => -114,
			'WORD_SCOPED' => -114,
			'LEFT_BRACE' => -114,
			'STDOUT_STDERR' => 172,
			'OP22_LOGICAL_NOT' => -114,
			"my" => -114,
			'OP10_NAMED_UNARY' => -114,
			'LEFT_BRACKET' => -114,
			"%{" => -114,
			'WORD' => -114,
			'KEYS_OR_VALUES' => -114,
			'OP05_LOGICAL_NEG' => -114
		},
		GOTOS => {
			'PAREN-33' => 169,
			'OPTIONAL-34' => 170
		}
	},
	{#State 102
		DEFAULT => -83
	},
	{#State 103
		DEFAULT => -14
	},
	{#State 104
		DEFAULT => -166,
		GOTOS => {
			'STAR-45' => 173
		}
	},
	{#State 105
		ACTIONS => {
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'SubExpression' => 174,
			'WordScoped' => 112,
			'Operator' => 111,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133
		}
	},
	{#State 106
		DEFAULT => -142
	},
	{#State 107
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 175
		}
	},
	{#State 108
		ACTIONS => {
			'FH_REF_SYMBOL' => 176
		}
	},
	{#State 109
		ACTIONS => {
			'COLON' => 177
		}
	},
	{#State 110
		ACTIONS => {
			'OP15_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => 185,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => 182
		}
	},
	{#State 111
		DEFAULT => -126
	},
	{#State 112
		ACTIONS => {
			'LEFT_PAREN' => 194
		}
	},
	{#State 113
		ACTIONS => {
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136
		},
		GOTOS => {
			'HashReference' => 97,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94,
			'HashDereferenced' => 77,
			'SubExpression' => 195,
			'WordScoped' => 112,
			'Operator' => 111,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 85
		}
	},
	{#State 114
		DEFAULT => -146
	},
	{#State 115
		ACTIONS => {
			'OP15_LOGICAL_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			";" => 196,
			'OP17_LIST_RANGE' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP08_STRING_CAT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP04_MATH_POW' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP12_COMPARE_EQ_NEQ' => -129
		}
	},
	{#State 116
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 197
		}
	},
	{#State 117
		DEFAULT => -17
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'LEFT_BRACE' => 200
		},
		GOTOS => {
			'HashReference' => 199,
			'Variable' => 198
		}
	},
	{#State 119
		ACTIONS => {
			"my" => 74,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'KEYS_OR_VALUES' => 130,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			";" => -116,
			'OP01_QW' => 165,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ListElement' => 168,
			'SubExpression' => 164,
			'Operator' => 111,
			'WordScoped' => 112,
			'OPTIONAL-35' => 202,
			'ArrayReference' => 87,
			'TypeInner' => 135,
			'HashDereferenced' => 77,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'ListElements' => 201,
			'HashReference' => 97
		}
	},
	{#State 120
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98
		},
		GOTOS => {
			'ArrayReference' => 87,
			'SubExpression' => 203,
			'Operator' => 111,
			'WordScoped' => 112,
			'ArrayDereferenced' => 85,
			'HashReference' => 97,
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'HashDereferenced' => 77
		}
	},
	{#State 121
		ACTIONS => {
			'COLON' => -204,
			'LEFT_PAREN' => -202
		}
	},
	{#State 122
		ACTIONS => {
			"use constant" => 44,
			"our %properties = (" => 206
		},
		GOTOS => {
			'Properties' => 205,
			'Constant' => 204
		}
	},
	{#State 123
		DEFAULT => -53
	},
	{#State 124
		ACTIONS => {
			"for my integer" => -143,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			"if (" => 113,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			"my" => 116,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED_VOID' => 119,
			'LEFT_BRACKET' => 100,
			'OP19_LOOP_CONTROL' => 99,
			"%{" => 118,
			"foreach my" => -143,
			'WORD' => 121,
			'OP05_LOGICAL_NEG' => 120,
			'OP01_PRINT' => 101,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"while (" => -143,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 80,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86
		},
		GOTOS => {
			'Operation' => 207,
			'Statement' => 102,
			'VariableModification' => 90,
			'Literal' => 94,
			'OperatorVoid' => 114,
			'Expression' => 115,
			'Variable' => 96,
			'HashReference' => 97,
			'ArrayDereferenced' => 85,
			'Conditional' => 83,
			'LoopLabel' => 109,
			'ArrayReference' => 87,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 110,
			'PLUS-17' => 208,
			'HashDereferenced' => 77,
			'VariableDeclaration' => 79,
			'OPTIONAL-39' => 81,
			'PAREN-38' => 106
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 209
		}
	},
	{#State 126
		DEFAULT => -42
	},
	{#State 127
		ACTIONS => {
			";" => 210
		}
	},
	{#State 128
		ACTIONS => {
			"\$TYPED_" => 211
		}
	},
	{#State 129
		DEFAULT => -40
	},
	{#State 130
		ACTIONS => {
			"%{" => 118
		},
		GOTOS => {
			'HashDereferenced' => 212
		}
	},
	{#State 131
		DEFAULT => -129
	},
	{#State 132
		ACTIONS => {
			'OP23_LOGICAL_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP15_LOGICAL_AND' => -85,
			";" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			")" => -85,
			'OP04_MATH_POW' => -85,
			'OP21_LIST_COMMA' => -182,
			'OP08_STRING_CAT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP18_TERNARY' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP14_BITWISE_OR_XOR' => -85
		}
	},
	{#State 133
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 157,
			'OP04_MATH_POW' => -132,
			'OP21_LIST_COMMA' => -132,
			")" => -132,
			'OP12_COMPARE_EQ_NEQ' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP03_MATH_INC_DEC' => 159,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP18_TERNARY' => -132,
			"]" => -132,
			'OP13_BITWISE_AND' => -132,
			'OP08_STRING_CAT' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			".." => -132,
			'OP23_LOGICAL_AND' => -132,
			";" => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			"}" => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP17_LIST_RANGE' => -132
		}
	},
	{#State 134
		ACTIONS => {
			'OP21_LIST_COMMA' => 213
		}
	},
	{#State 135
		ACTIONS => {
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88
		},
		GOTOS => {
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'ArrayDereferenced' => 85,
			'WordScoped' => 112,
			'SubExpression' => 214,
			'Operator' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 136
		ACTIONS => {
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'WordScoped' => 112,
			'SubExpression' => 215,
			'Operator' => 111,
			'ArrayReference' => 87,
			'HashDereferenced' => 77,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94,
			'HashReference' => 97
		}
	},
	{#State 137
		DEFAULT => -145
	},
	{#State 138
		DEFAULT => -158
	},
	{#State 139
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 216
		}
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 217
		}
	},
	{#State 141
		DEFAULT => -157
	},
	{#State 142
		DEFAULT => -156
	},
	{#State 143
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108
		},
		GOTOS => {
			'Operator' => 111,
			'WordScoped' => 112,
			'SubExpression' => 218,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 85,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'HashReference' => 97,
			'HashDereferenced' => 77
		}
	},
	{#State 144
		DEFAULT => -16
	},
	{#State 145
		ACTIONS => {
			"filehandle_ref" => 219
		}
	},
	{#State 146
		ACTIONS => {
			"}" => 220
		}
	},
	{#State 147
		ACTIONS => {
			"}" => 221
		}
	},
	{#State 148
		ACTIONS => {
			'OP20_HASH_FATARROW' => 222
		}
	},
	{#State 149
		DEFAULT => -198,
		GOTOS => {
			'STAR-52' => 223
		}
	},
	{#State 150
		DEFAULT => -137
	},
	{#State 151
		DEFAULT => -193
	},
	{#State 152
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 74,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 130,
			'OP05_LOGICAL_NEG' => 120,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86
		},
		GOTOS => {
			'SubExpression' => 132,
			'WordScoped' => 112,
			'Operator' => 111,
			'TypeInner' => 135,
			'ArrayReference' => 87,
			'ListElement' => 224,
			'ArrayDereferenced' => 85,
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'HashDereferenced' => 77
		}
	},
	{#State 153
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 225
		}
	},
	{#State 154
		ACTIONS => {
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184,
			'OP11_COMPARE_LT_GT' => 192,
			'OP15_LOGICAL_AND' => 191,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 193,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189,
			")" => 226,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP04_MATH_POW' => 183
		}
	},
	{#State 155
		ACTIONS => {
			"]" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => -100,
			")" => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -100,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => -100,
			"}" => -100,
			'OP15_LOGICAL_AND' => -100,
			";" => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP23_LOGICAL_AND' => -100,
			".." => -100,
			'OP09_BITWISE_SHIFT' => 193
		}
	},
	{#State 156
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP08_STRING_CAT' => 178,
			"]" => -99,
			'OP18_TERNARY' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => -99,
			")" => -99,
			"}" => -99,
			";" => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => -99,
			".." => -99
		}
	},
	{#State 157
		ACTIONS => {
			'WORD' => 227
		}
	},
	{#State 158
		ACTIONS => {
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 228,
			'HashDereferenced' => 77,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashReference' => 97
		}
	},
	{#State 159
		DEFAULT => -90
	},
	{#State 160
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'STDIN' => 231,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'SubExpression' => 229,
			'Operator' => 111,
			'WordScoped' => 112,
			'HashDereferenced' => 77,
			'SubExpressionOrStdin' => 230,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashReference' => 97
		}
	},
	{#State 161
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 192,
			";" => -109,
			'OP15_LOGICAL_AND' => 191,
			"}" => -109,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 193,
			".." => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => -109,
			"]" => -109,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -109,
			")" => -109,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189
		}
	},
	{#State 162
		ACTIONS => {
			";" => 232
		}
	},
	{#State 163
		DEFAULT => -204
	},
	{#State 164
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189,
			")" => -182,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP21_LIST_COMMA' => -182,
			'OP04_MATH_POW' => 183,
			"]" => -182,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 193,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184,
			'OP11_COMPARE_LT_GT' => 192,
			";" => -182,
			'OP15_LOGICAL_AND' => 191
		}
	},
	{#State 165
		ACTIONS => {
			'LEFT_PAREN' => 233
		}
	},
	{#State 166
		ACTIONS => {
			"]" => 234
		}
	},
	{#State 167
		DEFAULT => -185
	},
	{#State 168
		DEFAULT => -177,
		GOTOS => {
			'STAR-47' => 235
		}
	},
	{#State 169
		DEFAULT => -113
	},
	{#State 170
		ACTIONS => {
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 74,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 130,
			'OP05_LOGICAL_NEG' => 120,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_QW' => 165,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 94,
			'ListElements' => 236,
			'Variable' => 133,
			'Expression' => 131,
			'HashDereferenced' => 77,
			'ArrayReference' => 87,
			'TypeInner' => 135,
			'WordScoped' => 112,
			'SubExpression' => 164,
			'Operator' => 111,
			'ListElement' => 168,
			'ArrayDereferenced' => 85
		}
	},
	{#State 171
		ACTIONS => {
			'KEYS_OR_VALUES' => 130,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			"my" => 74,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_QW' => 165,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'HashDereferenced' => 77,
			'ListElements' => 237,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashReference' => 97,
			'ArrayDereferenced' => 85,
			'ListElement' => 168,
			'ArrayReference' => 87,
			'TypeInner' => 135,
			'WordScoped' => 112,
			'SubExpression' => 164,
			'Operator' => 111
		}
	},
	{#State 172
		DEFAULT => -112
	},
	{#State 173
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 240,
			'OP03_MATH_INC_DEC' => -167,
			'OP14_BITWISE_OR_XOR' => -167,
			'OP07_MATH_MULT_DIV_MOD' => -167,
			'OP24_LOGICAL_OR_XOR' => -167,
			'OP18_TERNARY' => -167,
			'OP19_VARIABLE_ASSIGN_BY' => -167,
			"]" => -167,
			'OP13_BITWISE_AND' => -167,
			'OP08_STRING_CAT' => -167,
			'COLON' => -167,
			'OP04_MATH_POW' => -167,
			'OP21_LIST_COMMA' => -167,
			'OP02_METHOD_THINARROW' => -167,
			")" => -167,
			'OP02_HASH_THINARROW' => 239,
			'OP12_COMPARE_EQ_NEQ' => -167,
			'OP08_MATH_ADD_SUB' => -167,
			'OP16_LOGICAL_OR' => -167,
			";" => -167,
			'OP15_LOGICAL_AND' => -167,
			'OP11_COMPARE_LT_GT' => -167,
			"}" => -167,
			'OP19_VARIABLE_ASSIGN' => -167,
			'OP06_REGEX_MATCH' => -167,
			'OP17_LIST_RANGE' => -167,
			'OP09_BITWISE_SHIFT' => -167,
			".." => -167,
			'OP23_LOGICAL_AND' => -167
		},
		GOTOS => {
			'VariableRetrieval' => 238
		}
	},
	{#State 174
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP12_COMPARE_EQ_NEQ' => 182,
			")" => 241,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP04_MATH_POW' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 192,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 193
		}
	},
	{#State 175
		DEFAULT => -89
	},
	{#State 176
		DEFAULT => -88
	},
	{#State 177
		DEFAULT => -141
	},
	{#State 178
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107
		},
		GOTOS => {
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'HashReference' => 97,
			'HashDereferenced' => 77,
			'ArrayReference' => 87,
			'Operator' => 111,
			'WordScoped' => 112,
			'SubExpression' => 242,
			'ArrayDereferenced' => 85
		}
	},
	{#State 179
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'Operator' => 111,
			'SubExpression' => 243,
			'WordScoped' => 112,
			'HashDereferenced' => 77,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashReference' => 97
		}
	},
	{#State 180
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 244
		}
	},
	{#State 181
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'Operator' => 111,
			'SubExpression' => 245,
			'WordScoped' => 112,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131
		}
	},
	{#State 182
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'HashDereferenced' => 77,
			'ArrayReference' => 87,
			'SubExpression' => 246,
			'WordScoped' => 112,
			'Operator' => 111,
			'ArrayDereferenced' => 85
		}
	},
	{#State 183
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 247,
			'ArrayReference' => 87,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94
		}
	},
	{#State 184
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108
		},
		GOTOS => {
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'HashReference' => 97,
			'HashDereferenced' => 77,
			'ArrayReference' => 87,
			'WordScoped' => 112,
			'SubExpression' => 248,
			'Operator' => 111,
			'ArrayDereferenced' => 85
		}
	},
	{#State 185
		ACTIONS => {
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93
		},
		GOTOS => {
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'HashDereferenced' => 77,
			'WordScoped' => 112,
			'SubExpression' => 249,
			'Operator' => 111,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 85
		}
	},
	{#State 186
		ACTIONS => {
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'Operator' => 111,
			'SubExpression' => 250,
			'WordScoped' => 112,
			'ArrayReference' => 87,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94
		}
	},
	{#State 187
		ACTIONS => {
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'WordScoped' => 112,
			'SubExpression' => 251,
			'Operator' => 111,
			'HashDereferenced' => 77,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashReference' => 97
		}
	},
	{#State 188
		ACTIONS => {
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78
		},
		GOTOS => {
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'HashReference' => 97,
			'HashDereferenced' => 77,
			'SubExpression' => 252,
			'Operator' => 111,
			'WordScoped' => 112,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 85
		}
	},
	{#State 189
		ACTIONS => {
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100
		},
		GOTOS => {
			'SubExpression' => 253,
			'WordScoped' => 112,
			'Operator' => 111,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 85,
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'HashDereferenced' => 77
		}
	},
	{#State 190
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 254
		}
	},
	{#State 191
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94,
			'HashReference' => 97,
			'HashDereferenced' => 77,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 255,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 85
		}
	},
	{#State 192
		ACTIONS => {
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'SubExpression' => 256,
			'WordScoped' => 112,
			'Operator' => 111,
			'ArrayReference' => 87,
			'HashDereferenced' => 77,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94,
			'HashReference' => 97
		}
	},
	{#State 193
		ACTIONS => {
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91
		},
		GOTOS => {
			'HashDereferenced' => 77,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94,
			'HashReference' => 97,
			'ArrayDereferenced' => 85,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 257,
			'ArrayReference' => 87
		}
	},
	{#State 194
		ACTIONS => {
			"my" => 74,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'KEYS_OR_VALUES' => 130,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP01_QW' => 165,
			")" => -123,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84
		},
		GOTOS => {
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'OPTIONAL-36' => 259,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94,
			'ListElements' => 258,
			'ListElement' => 168,
			'ArrayDereferenced' => 85,
			'Operator' => 111,
			'WordScoped' => 112,
			'SubExpression' => 164,
			'TypeInner' => 135,
			'ArrayReference' => 87
		}
	},
	{#State 195
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => 185,
			'OP11_COMPARE_LT_GT' => 192,
			'OP15_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => 182,
			")" => 260,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 187
		}
	},
	{#State 196
		DEFAULT => -82
	},
	{#State 197
		ACTIONS => {
			'VARIABLE_SYMBOL' => 261
		}
	},
	{#State 198
		ACTIONS => {
			"}" => 262
		}
	},
	{#State 199
		ACTIONS => {
			"}" => 263
		}
	},
	{#State 200
		ACTIONS => {
			'WORD' => 148,
			"%{" => 118
		},
		GOTOS => {
			'HashEntry' => 149,
			'HashDereferenced' => 151
		}
	},
	{#State 201
		DEFAULT => -115
	},
	{#State 202
		ACTIONS => {
			";" => 264
		}
	},
	{#State 203
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -92,
			'OP16_LOGICAL_OR' => -92,
			")" => -92,
			'OP12_COMPARE_EQ_NEQ' => -92,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -92,
			"]" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP18_TERNARY' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP23_LOGICAL_AND' => -92,
			".." => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP17_LIST_RANGE' => -92,
			"}" => -92,
			";" => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92
		}
	},
	{#State 204
		DEFAULT => -55
	},
	{#State 205
		ACTIONS => {
			"our" => -58,
			'LITERAL_NUMBER' => -58,
			"our %properties_class = (" => 267
		},
		GOTOS => {
			'OPTIONAL-23' => 265,
			'PropertiesClass' => 266
		}
	},
	{#State 206
		ACTIONS => {
			"## no critic qw(" => 9,
			")" => 269
		},
		GOTOS => {
			'Critic' => 268
		}
	},
	{#State 207
		DEFAULT => -45
	},
	{#State 208
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 99,
			"%{" => 118,
			'OP01_NAMED_VOID' => 119,
			"}" => 271,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'OP01_PRINT' => 101,
			"foreach my" => -143,
			'WORD' => 121,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			"for my integer" => -143,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			"if (" => 113,
			'OP10_NAMED_UNARY' => 95,
			"my" => 116,
			'OP22_LOGICAL_NOT' => 98,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"while (" => -143,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 80
		},
		GOTOS => {
			'OPTIONAL-39' => 81,
			'PAREN-38' => 106,
			'VariableDeclaration' => 79,
			'HashDereferenced' => 77,
			'ArrayReference' => 87,
			'SubExpression' => 110,
			'WordScoped' => 112,
			'Operator' => 111,
			'LoopLabel' => 109,
			'Conditional' => 83,
			'ArrayDereferenced' => 85,
			'HashReference' => 97,
			'Literal' => 94,
			'OperatorVoid' => 114,
			'Variable' => 96,
			'Expression' => 115,
			'VariableModification' => 90,
			'Statement' => 102,
			'Operation' => 270
		}
	},
	{#State 209
		ACTIONS => {
			'VARIABLE_SYMBOL' => 272
		}
	},
	{#State 210
		DEFAULT => -41
	},
	{#State 211
		ACTIONS => {
			'WORD' => 273
		}
	},
	{#State 212
		DEFAULT => -184
	},
	{#State 213
		ACTIONS => {
			'OP01_QW' => 165,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 74,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 130,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118
		},
		GOTOS => {
			'HashReference' => 97,
			'ListElements' => 274,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashDereferenced' => 77,
			'ArrayReference' => 87,
			'TypeInner' => 135,
			'Operator' => 111,
			'SubExpression' => 164,
			'WordScoped' => 112,
			'ListElement' => 168,
			'ArrayDereferenced' => 85
		}
	},
	{#State 214
		ACTIONS => {
			'OP21_LIST_COMMA' => -183,
			'OP04_MATH_POW' => 183,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189,
			")" => -183,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP14_BITWISE_OR_XOR' => 188,
			"]" => -183,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => 185,
			'OP11_COMPARE_LT_GT' => 192,
			";" => -183,
			'OP15_LOGICAL_AND' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184
		}
	},
	{#State 215
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP18_TERNARY' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP08_STRING_CAT' => -85,
			'OP13_BITWISE_AND' => -85,
			"]" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			")" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP15_LOGICAL_AND' => -85,
			";" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			"}" => -85,
			".." => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85
		}
	},
	{#State 216
		ACTIONS => {
			'VARIABLE_SYMBOL' => 275
		}
	},
	{#State 217
		ACTIONS => {
			'LEFT_PAREN' => 276
		}
	},
	{#State 218
		ACTIONS => {
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189,
			")" => 277,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184,
			'OP11_COMPARE_LT_GT' => 192,
			'OP15_LOGICAL_AND' => 191,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 193
		}
	},
	{#State 219
		ACTIONS => {
			'FH_REF_SYMBOL' => 278
		}
	},
	{#State 220
		DEFAULT => -188
	},
	{#State 221
		DEFAULT => -189
	},
	{#State 222
		ACTIONS => {
			'OP01_NAMED' => -191,
			'OP05_MATH_NEG_LEFT_PAREN' => -191,
			'LITERAL_STRING' => -191,
			'VARIABLE_SYMBOL' => -191,
			"undef" => -191,
			"\@{" => -191,
			'LITERAL_NUMBER' => -191,
			'OP03_MATH_INC_DEC' => -191,
			'OP01_OPEN' => -191,
			'OP01_CLOSE' => -191,
			'OP10_NAMED_UNARY' => -191,
			"my" => 74,
			'OP22_LOGICAL_NOT' => -191,
			'LEFT_BRACE' => -191,
			'WORD_SCOPED' => -191,
			'LEFT_PAREN' => -191,
			'OP10_NAMED_UNARY_STRINGIFY' => -191,
			'OP05_LOGICAL_NEG' => -191,
			'WORD' => -191,
			"%{" => -191,
			'LEFT_BRACKET' => -191
		},
		GOTOS => {
			'TypeInner' => 279,
			'OPTIONAL-50' => 280
		}
	},
	{#State 223
		ACTIONS => {
			"}" => 282,
			'OP21_LIST_COMMA' => 281
		},
		GOTOS => {
			'PAREN-51' => 283
		}
	},
	{#State 224
		ACTIONS => {
			'OP21_LIST_COMMA' => 284
		}
	},
	{#State 225
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			"my" => 74,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'KEYS_OR_VALUES' => 130,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 165,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86
		},
		GOTOS => {
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 164,
			'ArrayReference' => 87,
			'TypeInner' => 135,
			'ArrayDereferenced' => 85,
			'ListElement' => 168,
			'Variable' => 133,
			'Expression' => 131,
			'ListElements' => 285,
			'Literal' => 94,
			'HashReference' => 97,
			'HashDereferenced' => 77
		}
	},
	{#State 226
		DEFAULT => -138
	},
	{#State 227
		ACTIONS => {
			'LEFT_PAREN' => 286
		}
	},
	{#State 228
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP04_MATH_POW' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP15_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 192,
			";" => 287,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 193
		}
	},
	{#State 229
		ACTIONS => {
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 193,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP11_COMPARE_LT_GT' => 192,
			";" => -139,
			'OP15_LOGICAL_AND' => 191,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP04_MATH_POW' => 183,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP14_BITWISE_OR_XOR' => 188
		}
	},
	{#State 230
		ACTIONS => {
			";" => 288
		}
	},
	{#State 231
		DEFAULT => -140
	},
	{#State 232
		DEFAULT => -121
	},
	{#State 233
		ACTIONS => {
			'WORD' => 290
		},
		GOTOS => {
			'PLUS-48' => 289
		}
	},
	{#State 234
		DEFAULT => -187
	},
	{#State 235
		ACTIONS => {
			'OP21_LIST_COMMA' => 291,
			";" => -180,
			"]" => -180,
			")" => -180
		},
		GOTOS => {
			'PAREN-46' => 292
		}
	},
	{#State 236
		ACTIONS => {
			";" => 293
		}
	},
	{#State 237
		ACTIONS => {
			";" => 294
		}
	},
	{#State 238
		DEFAULT => -165
	},
	{#State 239
		ACTIONS => {
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 296,
			'OP05_LOGICAL_NEG' => 120,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105
		},
		GOTOS => {
			'HashReference' => 97,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashDereferenced' => 77,
			'ArrayReference' => 87,
			'Operator' => 111,
			'WordScoped' => 112,
			'SubExpression' => 295,
			'ArrayDereferenced' => 85
		}
	},
	{#State 240
		ACTIONS => {
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88
		},
		GOTOS => {
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 297
		}
	},
	{#State 241
		DEFAULT => -93
	},
	{#State 242
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -97,
			'OP08_STRING_CAT' => -97,
			'OP13_BITWISE_AND' => -97,
			"]" => -97,
			'OP18_TERNARY' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP21_LIST_COMMA' => -97,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => -97,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => -97,
			")" => -97,
			"}" => -97,
			";" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => -97,
			'OP23_LOGICAL_AND' => -97,
			".." => -97
		}
	},
	{#State 243
		ACTIONS => {
			'OP16_LOGICAL_OR' => -103,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => 182,
			")" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP04_MATH_POW' => 183,
			'OP13_BITWISE_AND' => -103,
			'OP08_STRING_CAT' => 178,
			"]" => -103,
			'OP18_TERNARY' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP23_LOGICAL_AND' => -103,
			".." => -103,
			'OP09_BITWISE_SHIFT' => 193,
			'OP17_LIST_RANGE' => -103,
			'OP06_REGEX_MATCH' => 190,
			"}" => -103,
			'OP15_LOGICAL_AND' => -103,
			";" => -103,
			'OP11_COMPARE_LT_GT' => 192
		}
	},
	{#State 244
		ACTIONS => {
			'COLON' => 298
		}
	},
	{#State 245
		ACTIONS => {
			";" => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP15_LOGICAL_AND' => -96,
			"}" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => -96,
			".." => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP18_TERNARY' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP13_BITWISE_AND' => -96,
			'OP08_STRING_CAT' => -96,
			"]" => -96,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			")" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP08_MATH_ADD_SUB' => -96
		}
	},
	{#State 246
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => -102,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => undef,
			")" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => -102,
			"]" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP18_TERNARY' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => -102,
			".." => -102,
			"}" => -102,
			'OP11_COMPARE_LT_GT' => 192,
			";" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP06_REGEX_MATCH' => 190
		}
	},
	{#State 247
		ACTIONS => {
			'OP17_LIST_RANGE' => -91,
			'OP06_REGEX_MATCH' => -91,
			";" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP15_LOGICAL_AND' => -91,
			"}" => -91,
			".." => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP18_TERNARY' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP08_STRING_CAT' => -91,
			'OP13_BITWISE_AND' => -91,
			"]" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			")" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -91
		}
	},
	{#State 248
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 190,
			'OP11_COMPARE_LT_GT' => 192,
			";" => -107,
			'OP15_LOGICAL_AND' => 191,
			"}" => -107,
			".." => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP09_BITWISE_SHIFT' => 193,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP18_TERNARY' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			"]" => -107,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP12_COMPARE_EQ_NEQ' => 182,
			")" => -107,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP21_LIST_COMMA' => -107,
			'OP04_MATH_POW' => 183
		}
	},
	{#State 249
		ACTIONS => {
			";" => -110,
			'OP11_COMPARE_LT_GT' => 192,
			'OP15_LOGICAL_AND' => 191,
			"}" => -110,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 193,
			".." => -110,
			'OP23_LOGICAL_AND' => -110,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			"]" => -110,
			'OP21_LIST_COMMA' => -110,
			'OP04_MATH_POW' => 183,
			'OP12_COMPARE_EQ_NEQ' => 182,
			")" => -110,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181
		}
	},
	{#State 250
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189,
			")" => -111,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -111,
			"]" => -111,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP18_TERNARY' => 180,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP23_LOGICAL_AND' => 185,
			".." => -111,
			'OP09_BITWISE_SHIFT' => 193,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184,
			"}" => -111,
			'OP15_LOGICAL_AND' => 191,
			";" => -111,
			'OP11_COMPARE_LT_GT' => 192
		}
	},
	{#State 251
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP08_STRING_CAT' => -95,
			"]" => -95,
			'OP18_TERNARY' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			")" => -95,
			"}" => -95,
			'OP11_COMPARE_LT_GT' => -95,
			";" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => -95,
			'OP23_LOGICAL_AND' => -95,
			".." => -95
		}
	},
	{#State 252
		ACTIONS => {
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => -104,
			'OP11_COMPARE_LT_GT' => 192,
			";" => -104,
			'OP15_LOGICAL_AND' => -104,
			"}" => -104,
			".." => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP18_TERNARY' => -104,
			"]" => -104,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP14_BITWISE_OR_XOR' => -104,
			")" => -104,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => -104,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -104
		}
	},
	{#State 253
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => -106,
			")" => -106,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP21_LIST_COMMA' => -106,
			'OP04_MATH_POW' => 183,
			"]" => -106,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP18_TERNARY' => -106,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP23_LOGICAL_AND' => -106,
			".." => -106,
			'OP09_BITWISE_SHIFT' => 193,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => -106,
			"}" => -106,
			";" => -106,
			'OP15_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 192
		}
	},
	{#State 254
		DEFAULT => -94
	},
	{#State 255
		ACTIONS => {
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			"]" => -105,
			'OP18_TERNARY' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP16_LOGICAL_OR' => -105,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => 182,
			")" => -105,
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP06_REGEX_MATCH' => 190,
			"}" => -105,
			";" => -105,
			'OP11_COMPARE_LT_GT' => 192,
			'OP15_LOGICAL_AND' => -105,
			'OP23_LOGICAL_AND' => -105,
			".." => -105,
			'OP09_BITWISE_SHIFT' => 193
		}
	},
	{#State 256
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 193,
			".." => -101,
			'OP23_LOGICAL_AND' => -101,
			";" => -101,
			'OP11_COMPARE_LT_GT' => undef,
			'OP15_LOGICAL_AND' => -101,
			"}" => -101,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP04_MATH_POW' => 183,
			")" => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP18_TERNARY' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			"]" => -101,
			'OP13_BITWISE_AND' => -101,
			'OP08_STRING_CAT' => 178
		}
	},
	{#State 257
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			"]" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP08_STRING_CAT' => 178,
			'OP14_BITWISE_OR_XOR' => -98,
			")" => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => -98,
			";" => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP15_LOGICAL_AND' => -98,
			"}" => -98,
			".." => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP09_BITWISE_SHIFT' => -98
		}
	},
	{#State 258
		DEFAULT => -122
	},
	{#State 259
		ACTIONS => {
			")" => 299
		}
	},
	{#State 260
		ACTIONS => {
			'LEFT_BRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 301
		}
	},
	{#State 261
		ACTIONS => {
			";" => 303,
			'OP19_VARIABLE_ASSIGN' => 302
		}
	},
	{#State 262
		DEFAULT => -200
	},
	{#State 263
		DEFAULT => -201
	},
	{#State 264
		DEFAULT => -119
	},
	{#State 265
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 304
		}
	},
	{#State 266
		DEFAULT => -57
	},
	{#State 267
		ACTIONS => {
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 305
		}
	},
	{#State 268
		ACTIONS => {
			'WORD' => 308,
			"%{" => 118
		},
		GOTOS => {
			'HashEntryTyped' => 307,
			'HashDereferenced' => 306
		}
	},
	{#State 269
		ACTIONS => {
			";" => 309
		}
	},
	{#State 270
		DEFAULT => -44
	},
	{#State 271
		ACTIONS => {
			";" => 310
		}
	},
	{#State 272
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 311
		}
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 274
		ACTIONS => {
			";" => 313
		}
	},
	{#State 275
		ACTIONS => {
			'LEFT_PAREN' => 314
		}
	},
	{#State 276
		ACTIONS => {
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136
		},
		GOTOS => {
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 315,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 85,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'HashReference' => 97,
			'HashDereferenced' => 77
		}
	},
	{#State 277
		ACTIONS => {
			'LEFT_BRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 316
		}
	},
	{#State 278
		ACTIONS => {
			'OP21_LIST_COMMA' => 317
		}
	},
	{#State 279
		DEFAULT => -190
	},
	{#State 280
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84
		},
		GOTOS => {
			'ArrayReference' => 87,
			'SubExpression' => 318,
			'Operator' => 111,
			'WordScoped' => 112,
			'ArrayDereferenced' => 85,
			'HashReference' => 97,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashDereferenced' => 77
		}
	},
	{#State 281
		ACTIONS => {
			"%{" => 118,
			'WORD' => 148
		},
		GOTOS => {
			'HashEntry' => 319,
			'HashDereferenced' => 151
		}
	},
	{#State 282
		DEFAULT => -199
	},
	{#State 283
		DEFAULT => -197
	},
	{#State 284
		ACTIONS => {
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'OP01_QW' => 165,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			'OP05_LOGICAL_NEG' => 120,
			'KEYS_OR_VALUES' => 130,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP10_NAMED_UNARY' => 95,
			"my" => 74,
			'OP22_LOGICAL_NOT' => 98,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93
		},
		GOTOS => {
			'ListElement' => 168,
			'ArrayDereferenced' => 85,
			'Operator' => 111,
			'WordScoped' => 112,
			'SubExpression' => 164,
			'ArrayReference' => 87,
			'TypeInner' => 135,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'ListElements' => 320
		}
	},
	{#State 285
		ACTIONS => {
			")" => 321
		}
	},
	{#State 286
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 74,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 130,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			")" => -125,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108
		},
		GOTOS => {
			'ListElement' => 168,
			'ArrayDereferenced' => 85,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 164,
			'TypeInner' => 135,
			'ArrayReference' => 87,
			'OPTIONAL-37' => 322,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Variable' => 133,
			'Expression' => 131,
			'Literal' => 94,
			'ListElements' => 323
		}
	},
	{#State 287
		DEFAULT => -174
	},
	{#State 288
		DEFAULT => -173
	},
	{#State 289
		ACTIONS => {
			")" => 325,
			'WORD' => 324
		}
	},
	{#State 290
		DEFAULT => -179
	},
	{#State 291
		ACTIONS => {
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 130,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 74,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91
		},
		GOTOS => {
			'TypeInner' => 135,
			'ArrayReference' => 87,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 164,
			'ListElement' => 326,
			'ArrayDereferenced' => 85,
			'HashReference' => 97,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashDereferenced' => 77
		}
	},
	{#State 292
		DEFAULT => -176
	},
	{#State 293
		DEFAULT => -117
	},
	{#State 294
		DEFAULT => -118
	},
	{#State 295
		ACTIONS => {
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP04_MATH_POW' => 183,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			"}" => 327,
			'OP15_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 192,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 193
		}
	},
	{#State 296
		ACTIONS => {
			"}" => 328,
			'LEFT_PAREN' => -202
		}
	},
	{#State 297
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 188,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			"]" => 329,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP15_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => 185
		}
	},
	{#State 298
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 330
		}
	},
	{#State 299
		DEFAULT => -127
	},
	{#State 300
		ACTIONS => {
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_NAMED' => 80,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			"while (" => -143,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'WORD' => 121,
			"foreach my" => -143,
			'OP01_PRINT' => 101,
			'OP05_LOGICAL_NEG' => 120,
			'OP01_NAMED_VOID' => 119,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP19_LOOP_CONTROL' => 99,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 116,
			'OP10_NAMED_UNARY' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			"if (" => 113,
			'LEFT_PAREN' => 92,
			"for my integer" => -143,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91
		},
		GOTOS => {
			'PLUS-44' => 331,
			'Operation' => 332,
			'Statement' => 102,
			'VariableModification' => 90,
			'HashReference' => 97,
			'Expression' => 115,
			'Variable' => 96,
			'OperatorVoid' => 114,
			'Literal' => 94,
			'ArrayDereferenced' => 85,
			'Conditional' => 83,
			'Operator' => 111,
			'WordScoped' => 112,
			'SubExpression' => 110,
			'ArrayReference' => 87,
			'LoopLabel' => 109,
			'HashDereferenced' => 77,
			'OPTIONAL-39' => 81,
			'PAREN-38' => 106,
			'VariableDeclaration' => 79
		}
	},
	{#State 301
		DEFAULT => -151,
		GOTOS => {
			'STAR-41' => 333
		}
	},
	{#State 302
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'STDIN' => 231,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'SubExpressionOrStdin' => 334,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94,
			'ArrayDereferenced' => 85,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 229,
			'ArrayReference' => 87
		}
	},
	{#State 303
		DEFAULT => -171
	},
	{#State 304
		ACTIONS => {
			'LITERAL_NUMBER' => 339,
			"our" => 337
		},
		GOTOS => {
			'MethodOrSubroutine' => 336,
			'Method' => 335,
			'Subroutine' => 338
		}
	},
	{#State 305
		ACTIONS => {
			"%{" => 118,
			'WORD' => 308
		},
		GOTOS => {
			'HashEntryTyped' => 340,
			'HashDereferenced' => 306
		}
	},
	{#State 306
		DEFAULT => -195
	},
	{#State 307
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 341
		}
	},
	{#State 308
		ACTIONS => {
			'OP20_HASH_FATARROW' => 342
		}
	},
	{#State 309
		ACTIONS => {
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 343
		}
	},
	{#State 310
		DEFAULT => -46
	},
	{#State 311
		ACTIONS => {
			'OP21_LIST_COMMA' => 345,
			")" => 344
		},
		GOTOS => {
			'PAREN-18' => 346
		}
	},
	{#State 312
		DEFAULT => -206
	},
	{#State 313
		DEFAULT => -120
	},
	{#State 314
		ACTIONS => {
			"undef" => 86,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_CLOSE' => 108,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 130,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 74,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92
		},
		GOTOS => {
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 164,
			'TypeInner' => 135,
			'ArrayReference' => 87,
			'ListElement' => 168,
			'ArrayDereferenced' => 85,
			'HashReference' => 97,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94,
			'ListElements' => 347,
			'HashDereferenced' => 77
		}
	},
	{#State 315
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP04_MATH_POW' => 183,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189,
			'OP15_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 192,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 193,
			".." => 348,
			'OP23_LOGICAL_AND' => 185
		}
	},
	{#State 316
		DEFAULT => -161
	},
	{#State 317
		ACTIONS => {
			'LITERAL_STRING' => 349
		}
	},
	{#State 318
		ACTIONS => {
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP11_COMPARE_LT_GT' => 192,
			'OP15_LOGICAL_AND' => 191,
			"}" => -192,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 193,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP21_LIST_COMMA' => -192,
			'OP04_MATH_POW' => 183
		}
	},
	{#State 319
		DEFAULT => -196
	},
	{#State 320
		ACTIONS => {
			")" => 350
		}
	},
	{#State 321
		DEFAULT => -84
	},
	{#State 322
		ACTIONS => {
			")" => 351
		}
	},
	{#State 323
		DEFAULT => -124
	},
	{#State 324
		DEFAULT => -178
	},
	{#State 325
		DEFAULT => -181
	},
	{#State 326
		DEFAULT => -175
	},
	{#State 327
		DEFAULT => -169
	},
	{#State 328
		DEFAULT => -170
	},
	{#State 329
		DEFAULT => -168
	},
	{#State 330
		DEFAULT => -108
	},
	{#State 331
		ACTIONS => {
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"while (" => -143,
			'OP01_NAMED' => 80,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			"}" => 353,
			'LEFT_BRACKET' => 100,
			'OP01_NAMED_VOID' => 119,
			"%{" => 118,
			'OP19_LOOP_CONTROL' => 99,
			"foreach my" => -143,
			'WORD' => 121,
			'OP05_LOGICAL_NEG' => 120,
			'OP01_PRINT' => 101,
			"for my integer" => -143,
			"if (" => 113,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			"my" => 116,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'HashDereferenced' => 77,
			'VariableDeclaration' => 79,
			'OPTIONAL-39' => 81,
			'PAREN-38' => 106,
			'ArrayDereferenced' => 85,
			'Conditional' => 83,
			'LoopLabel' => 109,
			'ArrayReference' => 87,
			'SubExpression' => 110,
			'Operator' => 111,
			'WordScoped' => 112,
			'VariableModification' => 90,
			'Literal' => 94,
			'OperatorVoid' => 114,
			'Variable' => 96,
			'Expression' => 115,
			'HashReference' => 97,
			'Operation' => 352,
			'Statement' => 102
		}
	},
	{#State 332
		DEFAULT => -163
	},
	{#State 333
		ACTIONS => {
			'OP01_CLOSE' => -154,
			'OP03_MATH_INC_DEC' => -154,
			"while (" => -154,
			'' => -154,
			'OP05_MATH_NEG_LEFT_PAREN' => -154,
			"else" => 358,
			'VARIABLE_SYMBOL' => -154,
			'WORD' => -154,
			'OP05_LOGICAL_NEG' => -154,
			'OP01_NAMED_VOID' => -154,
			"%{" => -154,
			"my" => -154,
			"if (" => -154,
			'WORD_SCOPED' => -154,
			"\@{" => -154,
			'LITERAL_NUMBER' => -154,
			"undef" => -154,
			"elsif (" => 354,
			'OP01_OPEN' => -154,
			'OP01_NAMED' => -154,
			'LITERAL_STRING' => -154,
			"foreach my" => -154,
			'OP01_PRINT' => -154,
			'LEFT_BRACKET' => -154,
			"}" => -154,
			'OP19_LOOP_CONTROL' => -154,
			'OP22_LOGICAL_NOT' => -154,
			'OP10_NAMED_UNARY' => -154,
			"for my integer" => -154,
			'OP10_NAMED_UNARY_STRINGIFY' => -154,
			'LEFT_PAREN' => -154,
			'LEFT_BRACE' => -154
		},
		GOTOS => {
			'OPTIONAL-43' => 356,
			'PAREN-40' => 355,
			'PAREN-42' => 357
		}
	},
	{#State 334
		ACTIONS => {
			";" => 359
		}
	},
	{#State 335
		DEFAULT => -80
	},
	{#State 336
		DEFAULT => -59
	},
	{#State 337
		ACTIONS => {
			'WORD' => 54,
			'TYPE_METHOD' => 360
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 338
		DEFAULT => -81
	},
	{#State 339
		ACTIONS => {
			";" => 361
		}
	},
	{#State 340
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 362
		}
	},
	{#State 341
		ACTIONS => {
			")" => 364,
			'OP21_LIST_COMMA' => 365
		},
		GOTOS => {
			'PAREN-25' => 363
		}
	},
	{#State 342
		ACTIONS => {
			"my" => 74
		},
		GOTOS => {
			'TypeInner' => 366
		}
	},
	{#State 343
		DEFAULT => -66
	},
	{#State 344
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 367
		}
	},
	{#State 345
		ACTIONS => {
			"my" => 368
		}
	},
	{#State 346
		DEFAULT => -48
	},
	{#State 347
		ACTIONS => {
			")" => 369
		}
	},
	{#State 348
		ACTIONS => {
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 370,
			'HashDereferenced' => 77,
			'Literal' => 94,
			'Expression' => 131,
			'Variable' => 133,
			'HashReference' => 97
		}
	},
	{#State 349
		ACTIONS => {
			'OP21_LIST_COMMA' => 371
		}
	},
	{#State 350
		DEFAULT => -86
	},
	{#State 351
		DEFAULT => -128
	},
	{#State 352
		DEFAULT => -162
	},
	{#State 353
		DEFAULT => -164
	},
	{#State 354
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			"%{" => 118,
			'LEFT_BRACKET' => 100,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 372,
			'ArrayReference' => 87,
			'HashDereferenced' => 77,
			'HashReference' => 97,
			'Expression' => 131,
			'Variable' => 133,
			'Literal' => 94
		}
	},
	{#State 355
		DEFAULT => -150
	},
	{#State 356
		DEFAULT => -155
	},
	{#State 357
		DEFAULT => -153
	},
	{#State 358
		ACTIONS => {
			'LEFT_BRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 373
		}
	},
	{#State 359
		DEFAULT => -172
	},
	{#State 360
		ACTIONS => {
			'VARIABLE_SYMBOL' => 374
		}
	},
	{#State 361
		DEFAULT => -61
	},
	{#State 362
		ACTIONS => {
			'OP21_LIST_COMMA' => 376,
			")" => 377
		},
		GOTOS => {
			'PAREN-27' => 375
		}
	},
	{#State 363
		DEFAULT => -63
	},
	{#State 364
		ACTIONS => {
			";" => 378
		}
	},
	{#State 365
		ACTIONS => {
			"%{" => 118,
			'WORD' => 308
		},
		GOTOS => {
			'HashDereferenced' => 306,
			'HashEntryTyped' => 379
		}
	},
	{#State 366
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'WORD' => 23,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_BRACKET' => 100,
			"%{" => 118,
			'OP01_NAMED' => 136,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84
		},
		GOTOS => {
			'ArrayDereferenced' => 85,
			'ArrayReference' => 87,
			'SubExpression' => 380,
			'WordScoped' => 112,
			'Operator' => 111,
			'HashDereferenced' => 77,
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'HashReference' => 97
		}
	},
	{#State 367
		ACTIONS => {
			"\@_;" => 381
		}
	},
	{#State 368
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 382
		}
	},
	{#State 369
		ACTIONS => {
			'LEFT_BRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 383
		}
	},
	{#State 370
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP04_MATH_POW' => 183,
			")" => 384,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189,
			'OP11_COMPARE_LT_GT' => 192,
			'OP15_LOGICAL_AND' => 191,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184,
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => 185
		}
	},
	{#State 371
		ACTIONS => {
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 86,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			'OP01_CLOSE' => 108,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NOT' => 98,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			'LEFT_PAREN' => 92,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'OP05_LOGICAL_NEG' => 120,
			'WORD' => 23,
			"%{" => 118,
			'LEFT_BRACKET' => 100
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Operator' => 111,
			'WordScoped' => 112,
			'SubExpression' => 385,
			'ArrayDereferenced' => 85,
			'HashReference' => 97,
			'Literal' => 94,
			'Variable' => 133,
			'Expression' => 131,
			'HashDereferenced' => 77
		}
	},
	{#State 372
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => 185,
			'OP15_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 192,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP12_COMPARE_EQ_NEQ' => 182,
			")" => 386,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP08_STRING_CAT' => 178,
			'OP13_BITWISE_AND' => 179,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 187
		}
	},
	{#State 373
		DEFAULT => -152
	},
	{#State 374
		ACTIONS => {
			"= sub {" => 387
		}
	},
	{#State 375
		DEFAULT => -68
	},
	{#State 376
		ACTIONS => {
			'WORD' => 308,
			"%{" => 118
		},
		GOTOS => {
			'HashDereferenced' => 306,
			'HashEntryTyped' => 388
		}
	},
	{#State 377
		ACTIONS => {
			";" => 389
		}
	},
	{#State 378
		DEFAULT => -65
	},
	{#State 379
		DEFAULT => -62
	},
	{#State 380
		ACTIONS => {
			'OP04_MATH_POW' => 183,
			'OP21_LIST_COMMA' => -194,
			'OP12_COMPARE_EQ_NEQ' => 182,
			")" => -194,
			'OP16_LOGICAL_OR' => 189,
			'OP08_MATH_ADD_SUB' => 181,
			'OP14_BITWISE_OR_XOR' => 188,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP18_TERNARY' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP09_BITWISE_SHIFT' => 193,
			'OP23_LOGICAL_AND' => 185,
			'OP11_COMPARE_LT_GT' => 192,
			'OP15_LOGICAL_AND' => 191,
			'OP17_LIST_RANGE' => 184,
			'OP06_REGEX_MATCH' => 190
		}
	},
	{#State 381
		DEFAULT => -50
	},
	{#State 382
		ACTIONS => {
			'VARIABLE_SYMBOL' => 390
		}
	},
	{#State 383
		DEFAULT => -160
	},
	{#State 384
		ACTIONS => {
			'LEFT_BRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 385
		ACTIONS => {
			".." => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP09_BITWISE_SHIFT' => 193,
			'OP06_REGEX_MATCH' => 190,
			'OP17_LIST_RANGE' => 184,
			'OP15_LOGICAL_AND' => 191,
			";" => -87,
			'OP11_COMPARE_LT_GT' => 192,
			"}" => -87,
			")" => -87,
			'OP12_COMPARE_EQ_NEQ' => 182,
			'OP08_MATH_ADD_SUB' => 181,
			'OP16_LOGICAL_OR' => 189,
			'OP21_LIST_COMMA' => -87,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 187,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP18_TERNARY' => 180,
			"]" => -87,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 178,
			'OP14_BITWISE_OR_XOR' => 188
		}
	},
	{#State 386
		ACTIONS => {
			'LEFT_BRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 387
		ACTIONS => {
			'OP01_NAMED' => -72,
			'OP05_MATH_NEG_LEFT_PAREN' => -72,
			"while (" => -72,
			'VARIABLE_SYMBOL' => -72,
			'LITERAL_STRING' => -72,
			"undef" => -72,
			'LITERAL_NUMBER' => -72,
			"\@{" => -72,
			"( my" => 395,
			'OP01_OPEN' => -72,
			'OP03_MATH_INC_DEC' => -72,
			'OP01_CLOSE' => -72,
			'OP10_NAMED_UNARY' => -72,
			'OP22_LOGICAL_NOT' => -72,
			"my" => -72,
			'WORD_SCOPED' => -72,
			'LEFT_BRACE' => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'LEFT_PAREN' => -72,
			"if (" => -72,
			"for my integer" => -72,
			'OP01_PRINT' => -72,
			'OP05_LOGICAL_NEG' => -72,
			'WORD' => -72,
			"foreach my" => -72,
			'OP19_LOOP_CONTROL' => -72,
			"%{" => -72,
			'LEFT_BRACKET' => -72,
			'OP01_NAMED_VOID' => -72
		},
		GOTOS => {
			'MethodArguments' => 393,
			'OPTIONAL-29' => 394
		}
	},
	{#State 388
		DEFAULT => -67
	},
	{#State 389
		DEFAULT => -70
	},
	{#State 390
		DEFAULT => -47
	},
	{#State 391
		DEFAULT => -159
	},
	{#State 392
		DEFAULT => -149
	},
	{#State 393
		DEFAULT => -71
	},
	{#State 394
		ACTIONS => {
			'OP01_CLOSE' => 108,
			'OP01_OPEN' => 84,
			'OP03_MATH_INC_DEC' => 107,
			'LITERAL_NUMBER' => 89,
			"\@{" => 88,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 78,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 80,
			"while (" => -143,
			'LEFT_BRACKET' => 100,
			'OP01_NAMED_VOID' => 119,
			'OP19_LOOP_CONTROL' => 99,
			"%{" => 118,
			'WORD' => 121,
			"foreach my" => -143,
			'OP01_PRINT' => 101,
			'OP05_LOGICAL_NEG' => 120,
			'LEFT_PAREN' => 92,
			"if (" => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			"for my integer" => -143,
			'WORD_SCOPED' => 22,
			'LEFT_BRACE' => 91,
			'OP22_LOGICAL_NOT' => 98,
			"my" => 116,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'LoopLabel' => 109,
			'WordScoped' => 112,
			'Operator' => 111,
			'SubExpression' => 110,
			'ArrayReference' => 87,
			'Conditional' => 83,
			'ArrayDereferenced' => 85,
			'VariableDeclaration' => 79,
			'PAREN-38' => 106,
			'OPTIONAL-39' => 81,
			'PLUS-30' => 396,
			'HashDereferenced' => 77,
			'Statement' => 102,
			'Operation' => 397,
			'Expression' => 115,
			'Variable' => 96,
			'Literal' => 94,
			'OperatorVoid' => 114,
			'HashReference' => 97,
			'VariableModification' => 90
		}
	},
	{#State 395
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 398
		}
	},
	{#State 396
		ACTIONS => {
			'OP01_CLOSE' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 84,
			"\@{" => 88,
			'LITERAL_NUMBER' => 89,
			"undef" => 86,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 104,
			"while (" => -143,
			'OP05_MATH_NEG_LEFT_PAREN' => 105,
			'OP01_NAMED' => 80,
			'LEFT_BRACKET' => 100,
			'OP01_NAMED_VOID' => 119,
			"}" => 399,
			'OP19_LOOP_CONTROL' => 99,
			"%{" => 118,
			"foreach my" => -143,
			'WORD' => 121,
			'OP05_LOGICAL_NEG' => 120,
			'OP01_PRINT' => 101,
			"for my integer" => -143,
			"if (" => 113,
			'OP10_NAMED_UNARY_STRINGIFY' => 93,
			'LEFT_PAREN' => 92,
			'LEFT_BRACE' => 91,
			'WORD_SCOPED' => 22,
			"my" => 116,
			'OP22_LOGICAL_NOT' => 98,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'Operation' => 400,
			'Statement' => 102,
			'VariableModification' => 90,
			'HashReference' => 97,
			'Variable' => 96,
			'Expression' => 115,
			'OperatorVoid' => 114,
			'Literal' => 94,
			'Conditional' => 83,
			'ArrayDereferenced' => 85,
			'SubExpression' => 110,
			'WordScoped' => 112,
			'Operator' => 111,
			'ArrayReference' => 87,
			'LoopLabel' => 109,
			'HashDereferenced' => 77,
			'OPTIONAL-39' => 81,
			'PAREN-38' => 106,
			'VariableDeclaration' => 79
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
			'OP21_LIST_COMMA' => 404,
			")" => 405
		},
		GOTOS => {
			'PAREN-31' => 403
		}
	},
	{#State 402
		DEFAULT => -75
	},
	{#State 403
		DEFAULT => -77
	},
	{#State 404
		ACTIONS => {
			"my" => 406
		}
	},
	{#State 405
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 406
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 408
		}
	},
	{#State 407
		ACTIONS => {
			"\@_;" => 409
		}
	},
	{#State 408
		ACTIONS => {
			'VARIABLE_SYMBOL' => 410
		}
	},
	{#State 409
		DEFAULT => -79
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
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5732 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5739 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
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
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5775 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5782 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5789 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5796 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5803 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5810 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
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
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
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
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5917 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5931 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
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
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5995 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
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
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
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
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6067 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6074 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
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
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6113 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
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
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6152 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
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
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
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
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6262 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
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
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
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
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
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
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
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
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6821 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
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
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
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
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
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
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
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
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
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
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7336 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
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
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7412 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
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
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
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
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
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

#line 190 "lib/RPerl/Grammar.eyp"


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
