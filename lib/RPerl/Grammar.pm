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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|package|while\ \(|\=\ sub\ \{|elsif\ \(|\$TYPED_|undef|else|if\ \(|\(\ my|qw\(|use|our|\@_\;|my|\.\.|\%\{|\@\{|\)|\}|\;|\])}gc and return ($1, $1);

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
			"## no critic qw(" => 2,
			"package" => -20,
			'SHEBANG' => 3
		},
		GOTOS => {
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 5,
			'PLUS-2' => 8,
			'CompileUnit' => 9,
			'Program' => 1,
			'PAREN-1' => 6,
			'Critic' => 7
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-14' => 10
		}
	},
	{#State 3
		ACTIONS => {
			"## no critic qw(" => 2,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 12,
			'Critic' => 13
		}
	},
	{#State 4
		ACTIONS => {
			"our" => -25,
			"use constant" => -25,
			"use parent qw(" => 17,
			"## no critic qw(" => -25,
			"use" => -25
		},
		GOTOS => {
			'Class' => 16,
			'STAR-10' => 14,
			'Package' => 18,
			'Module' => 15
		}
	},
	{#State 5
		ACTIONS => {
			"package" => 19
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 7,
			'PAREN-1' => 20,
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 5
		}
	},
	{#State 9
		ACTIONS => {
			'' => 21
		}
	},
	{#State 10
		ACTIONS => {
			")" => 22,
			'WORD' => 23
		}
	},
	{#State 11
		DEFAULT => -35
	},
	{#State 12
		ACTIONS => {
			"use strict;" => 24
		},
		GOTOS => {
			'Header' => 25
		}
	},
	{#State 13
		DEFAULT => -6
	},
	{#State 14
		ACTIONS => {
			"use constant" => -27,
			"## no critic qw(" => 2,
			"use" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 26,
			'Critic' => 27
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		DEFAULT => -23
	},
	{#State 17
		ACTIONS => {
			'WORD' => 30,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 18
		DEFAULT => -22
	},
	{#State 19
		ACTIONS => {
			'WORD' => 30,
			'WORD_SCOPED' => 29
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 20
		DEFAULT => -2
	},
	{#State 21
		DEFAULT => 0
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
			"our" => -29,
			"use" => 35,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 34,
			'Include' => 36
		}
	},
	{#State 27
		DEFAULT => -24
	},
	{#State 28
		ACTIONS => {
			")" => 37
		}
	},
	{#State 29
		DEFAULT => -203
	},
	{#State 30
		DEFAULT => -202
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
			'OP01_OPEN' => -11,
			"use constant" => -11,
			'OP01_PRINT' => -11,
			'LEFT_BRACE' => -11,
			"undef" => -11,
			'OP22_LOGICAL_NOT' => -11,
			'LEFT_BRACKET' => -11,
			"for my integer" => -11,
			"%{" => -11,
			"use" => -11,
			"our" => -11,
			"foreach my" => -11,
			'WORD_SCOPED' => -11,
			'OP01_NAMED' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP05_MATH_NEG' => -11,
			'WORD' => -11,
			"## no critic qw(" => 2,
			'LITERAL_STRING' => -11,
			"\@{" => -11,
			'OP01_NAMED_VOID' => -11,
			"while (" => -11,
			'LEFT_PAREN' => -11,
			'OP01_CLOSE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP10_NAMED_UNARY_STRINGIFY' => -11,
			"if (" => -11,
			'LITERAL_NUMBER' => -11,
			"my" => -11
		},
		GOTOS => {
			'Critic' => 40,
			'STAR-5' => 41
		}
	},
	{#State 34
		ACTIONS => {
			"our" => 44,
			"use constant" => 42
		},
		GOTOS => {
			'PLUS-13' => 45,
			'Constant' => 43,
			'Subroutine' => 46
		}
	},
	{#State 35
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 47
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			";" => 48
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
			'OP01_OPEN' => -13,
			"use constant" => -13,
			'OP01_PRINT' => -13,
			'LEFT_BRACE' => -13,
			"undef" => -13,
			'OP22_LOGICAL_NOT' => -13,
			'LEFT_BRACKET' => -13,
			"for my integer" => -13,
			"%{" => -13,
			"use" => 35,
			"our" => -13,
			"foreach my" => -13,
			'OP01_NAMED' => -13,
			'WORD_SCOPED' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP05_MATH_NEG' => -13,
			'WORD' => -13,
			'LITERAL_STRING' => -13,
			"\@{" => -13,
			'OP01_NAMED_VOID' => -13,
			"while (" => -13,
			'LEFT_PAREN' => -13,
			'OP01_CLOSE' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP10_NAMED_UNARY_STRINGIFY' => -13,
			'LITERAL_NUMBER' => -13,
			"my" => -13,
			"if (" => -13
		},
		GOTOS => {
			'STAR-6' => 52,
			'Include' => 51
		}
	},
	{#State 42
		ACTIONS => {
			'WORD' => 53
		}
	},
	{#State 43
		DEFAULT => -28
	},
	{#State 44
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 56,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 46
		DEFAULT => -31
	},
	{#State 47
		ACTIONS => {
			";" => 59,
			"qw(" => 58
		}
	},
	{#State 48
		ACTIONS => {
			"use" => 35
		},
		GOTOS => {
			'Include' => 60
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
			"foreach my" => -15,
			"our" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LITERAL_NUMBER' => -15,
			'OP10_NAMED_UNARY_STRINGIFY' => -15,
			"my" => -15,
			"if (" => -15,
			'OP01_NAMED' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED_VOID' => -15,
			"while (" => -15,
			'OP01_CLOSE' => -15,
			'LEFT_PAREN' => -15,
			"%{" => -15,
			"\@{" => -15,
			'WORD' => -15,
			'LITERAL_STRING' => -15,
			"for my integer" => -15,
			'LEFT_BRACKET' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP05_MATH_NEG' => -15,
			'OP22_LOGICAL_NOT' => -15,
			"undef" => -15,
			'OP01_PRINT' => -15,
			'LEFT_BRACE' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_OPEN' => -15,
			'VARIABLE_SYMBOL' => -15,
			"use constant" => 42,
			'OP19_LOOP_CONTROL' => -15
		},
		GOTOS => {
			'STAR-7' => 63,
			'Constant' => 62
		}
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 54
		DEFAULT => -205
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
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
			'WORD' => 67
		},
		GOTOS => {
			'PLUS-15' => 68
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
		DEFAULT => -12
	},
	{#State 63
		ACTIONS => {
			"our" => 44,
			'OP03_MATH_INC_DEC' => 91,
			"foreach my" => -143,
			'OP01_NAMED' => 112,
			'WORD_SCOPED' => 29,
			"my" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"if (" => 90,
			'LITERAL_NUMBER' => 87,
			"while (" => -143,
			'OP01_NAMED_VOID' => 96,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"%{" => 109,
			"\@{" => 82,
			'WORD' => 86,
			"for my integer" => -143,
			'LITERAL_STRING' => 85,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP01_PRINT' => 98,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP19_LOOP_CONTROL' => 73
		},
		GOTOS => {
			'Expression' => 108,
			'OPTIONAL-39' => 81,
			'ArrayDereferenced' => 107,
			'WordScoped' => 105,
			'HashReference' => 80,
			'PLUS-8' => 79,
			'VariableDeclaration' => 77,
			'Variable' => 103,
			'VariableModification' => 101,
			'Statement' => 74,
			'LoopLabel' => 71,
			'Operator' => 72,
			'OperatorVoid' => 97,
			'ArrayReference' => 94,
			'Subroutine' => 92,
			'PAREN-38' => 114,
			'Conditional' => 113,
			'SubExpression' => 111,
			'HashDereferenced' => 84,
			'Operation' => 110,
			'Literal' => 83
		}
	},
	{#State 64
		ACTIONS => {
			"my" => 116
		},
		GOTOS => {
			'TypeInner' => 115
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 117
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		DEFAULT => -38
	},
	{#State 68
		ACTIONS => {
			'WORD' => 118,
			")" => 119
		}
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
			'STAR-21' => 120
		}
	},
	{#State 70
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 106,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109
		},
		GOTOS => {
			'SubExpression' => 123,
			'HashDereferenced' => 84,
			'Variable' => 125,
			'Operator' => 72,
			'Literal' => 83,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'HashReference' => 80
		}
	},
	{#State 71
		ACTIONS => {
			'COLON' => 126
		}
	},
	{#State 72
		DEFAULT => -126
	},
	{#State 73
		ACTIONS => {
			'WORD' => 127
		},
		GOTOS => {
			'LoopLabel' => 128
		}
	},
	{#State 74
		DEFAULT => -83
	},
	{#State 75
		DEFAULT => -166,
		GOTOS => {
			'STAR-45' => 129
		}
	},
	{#State 76
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99
		},
		GOTOS => {
			'Literal' => 83,
			'Operator' => 72,
			'Variable' => 125,
			'SubExpression' => 130,
			'HashDereferenced' => 84,
			'HashReference' => 80,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105
		}
	},
	{#State 77
		DEFAULT => -147
	},
	{#State 78
		ACTIONS => {
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			"\@{" => 82,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'HashReference' => 80,
			'Variable' => 125,
			'SubExpression' => 131,
			'HashDereferenced' => 84,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 79
		ACTIONS => {
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'OP22_LOGICAL_NOT' => 106,
			'' => -18,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_PRINT' => 98,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP19_LOOP_CONTROL' => 73,
			'OP03_MATH_INC_DEC' => 91,
			"foreach my" => -143,
			'LITERAL_NUMBER' => 87,
			"if (" => 90,
			'WORD_SCOPED' => 29,
			"my" => 89,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 112,
			'OP01_NAMED_VOID' => 96,
			"while (" => -143,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			"%{" => 109,
			"\@{" => 82,
			'WORD' => 86,
			"for my integer" => -143,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'SubExpression' => 111,
			'HashDereferenced' => 84,
			'Literal' => 83,
			'Operation' => 132,
			'ArrayReference' => 94,
			'PAREN-38' => 114,
			'Conditional' => 113,
			'Variable' => 103,
			'Statement' => 74,
			'VariableModification' => 101,
			'Operator' => 72,
			'LoopLabel' => 71,
			'OperatorVoid' => 97,
			'ArrayDereferenced' => 107,
			'OPTIONAL-39' => 81,
			'Expression' => 108,
			'WordScoped' => 105,
			'HashReference' => 80,
			'VariableDeclaration' => 77
		}
	},
	{#State 80
		DEFAULT => -135
	},
	{#State 81
		ACTIONS => {
			"for my integer" => 139,
			"while (" => 134,
			"foreach my" => 138
		},
		GOTOS => {
			'LoopWhile' => 136,
			'LoopForEach' => 137,
			'Loop' => 133,
			'LoopFor' => 135
		}
	},
	{#State 82
		ACTIONS => {
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 140,
			'ArrayReference' => 141
		}
	},
	{#State 83
		DEFAULT => -131
	},
	{#State 84
		DEFAULT => -136
	},
	{#State 85
		DEFAULT => -207
	},
	{#State 86
		ACTIONS => {
			'COLON' => -204,
			'LEFT_PAREN' => -202
		}
	},
	{#State 87
		DEFAULT => -208
	},
	{#State 88
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'HashReference' => 80,
			'Variable' => 125,
			'SubExpression' => 142,
			'HashDereferenced' => 84,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 89
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 143
		}
	},
	{#State 90
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102
		},
		GOTOS => {
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'HashReference' => 80,
			'HashDereferenced' => 84,
			'SubExpression' => 144,
			'Variable' => 125,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 91
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 145
		}
	},
	{#State 92
		DEFAULT => -14
	},
	{#State 93
		ACTIONS => {
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_NAMED' => 147,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			"\@{" => 82,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_PRINT' => 146,
			'LEFT_BRACE' => 99,
			"undef" => 100
		},
		GOTOS => {
			'HashDereferenced' => 84,
			'SubExpression' => 148,
			'Variable' => 125,
			'Operator' => 72,
			'Literal' => 83,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'HashReference' => 80
		}
	},
	{#State 94
		DEFAULT => -133
	},
	{#State 95
		ACTIONS => {
			'FH_REF_SYMBOL' => 149
		}
	},
	{#State 96
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 91,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"my" => 116,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			"%{" => 109,
			'KEYS_OR_VALUES' => 150,
			"\@{" => 82,
			'WORD' => 30,
			";" => -116,
			'LITERAL_STRING' => 85,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'OP22_LOGICAL_NOT' => 106,
			'OP01_QW' => 151,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'OPTIONAL-35' => 154,
			'TypeInner' => 153,
			'ListElements' => 152,
			'HashReference' => 80,
			'HashDereferenced' => 84,
			'SubExpression' => 155,
			'Variable' => 125,
			'ListElement' => 156,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 97
		DEFAULT => -146
	},
	{#State 98
		ACTIONS => {
			'LEFT_PAREN' => -114,
			'OP01_CLOSE' => -114,
			'WORD_SCOPED' => -114,
			'OP10_NAMED_UNARY_STRINGIFY' => -114,
			'LITERAL_NUMBER' => -114,
			"my" => -114,
			'OP01_NAMED' => -114,
			'OP03_MATH_INC_DEC' => -114,
			'LITERAL_STRING' => -114,
			'WORD' => -114,
			"\@{" => -114,
			'KEYS_OR_VALUES' => -114,
			"%{" => -114,
			'OP01_QW' => -114,
			'OP22_LOGICAL_NOT' => -114,
			'FH_REF_SYMBOL_BRACES' => 160,
			'OP10_NAMED_UNARY' => -114,
			'OP05_MATH_NEG' => -114,
			'LEFT_BRACKET' => -114,
			'STDOUT_STDERR' => 157,
			'OP01_OPEN' => -114,
			'VARIABLE_SYMBOL' => -114,
			"undef" => -114,
			'LEFT_BRACE' => -114,
			'OP05_LOGICAL_NEG' => -114
		},
		GOTOS => {
			'PAREN-33' => 158,
			'OPTIONAL-34' => 159
		}
	},
	{#State 99
		ACTIONS => {
			"%{" => 109,
			'WORD' => 163,
			"}" => 164
		},
		GOTOS => {
			'HashDereferenced' => 162,
			'HashEntry' => 161
		}
	},
	{#State 100
		DEFAULT => -130
	},
	{#State 101
		DEFAULT => -148
	},
	{#State 102
		ACTIONS => {
			"my" => 165
		}
	},
	{#State 103
		ACTIONS => {
			'OP12_COMPARE_EQ_NEQ' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP03_MATH_INC_DEC' => 166,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP08_STRING_CAT' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP18_TERNARY' => -132,
			'OP02_METHOD_THINARROW' => 168,
			'OP04_MATH_POW' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP19_VARIABLE_ASSIGN_BY' => 167,
			'OP06_REGEX_MATCH' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP19_VARIABLE_ASSIGN' => 169,
			'OP23_LOGICAL_AND' => -132
		}
	},
	{#State 104
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			"my" => 116,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'KEYS_OR_VALUES' => 150,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			"]" => -186,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102
		},
		GOTOS => {
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 155,
			'Literal' => 83,
			'Operator' => 72,
			'ListElement' => 156,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80,
			'ListElements' => 171,
			'TypeInner' => 153,
			'OPTIONAL-49' => 170
		}
	},
	{#State 105
		ACTIONS => {
			'LEFT_PAREN' => 172
		}
	},
	{#State 106
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104
		},
		GOTOS => {
			'HashReference' => 80,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'Literal' => 83,
			'Operator' => 72,
			'Variable' => 125,
			'SubExpression' => 173,
			'HashDereferenced' => 84
		}
	},
	{#State 107
		DEFAULT => -134
	},
	{#State 108
		ACTIONS => {
			'OP15_LOGICAL_AND' => -129,
			'OP08_STRING_CAT' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP12_COMPARE_EQ_NEQ' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP18_TERNARY' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			";" => 174,
			'OP09_BITWISE_SHIFT' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP04_MATH_POW' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP13_BITWISE_AND' => -129
		}
	},
	{#State 109
		ACTIONS => {
			'LEFT_BRACE' => 176,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'HashReference' => 177,
			'Variable' => 175
		}
	},
	{#State 110
		DEFAULT => -17
	},
	{#State 111
		ACTIONS => {
			'OP13_BITWISE_AND' => 190,
			'OP23_LOGICAL_AND' => 191,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP04_MATH_POW' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP18_TERNARY' => 186,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => 189
		}
	},
	{#State 112
		ACTIONS => {
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			"my" => 116,
			'WORD_SCOPED' => 29,
			'OP03_MATH_INC_DEC' => 91,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'KEYS_OR_VALUES' => 150,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'TypeInner' => 153,
			'HashReference' => 80,
			'SubExpression' => 195,
			'HashDereferenced' => 84,
			'Variable' => 125,
			'ListElement' => 194,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 113
		DEFAULT => -144
	},
	{#State 114
		DEFAULT => -142
	},
	{#State 115
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'Literal' => 196
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
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -43,
			"( my" => 200,
			'VARIABLE_SYMBOL' => -43,
			'OP01_OPEN' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_PRINT' => -43,
			'LEFT_BRACE' => -43,
			"undef" => -43,
			'OP22_LOGICAL_NOT' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP05_MATH_NEG' => -43,
			'LEFT_BRACKET' => -43,
			"for my integer" => -43,
			'LITERAL_STRING' => -43,
			'WORD' => -43,
			"\@{" => -43,
			"%{" => -43,
			'LEFT_PAREN' => -43,
			'OP01_CLOSE' => -43,
			'OP01_NAMED_VOID' => -43,
			"while (" => -43,
			'OP10_NAMED_UNARY_STRINGIFY' => -43,
			'LITERAL_NUMBER' => -43,
			"if (" => -43,
			"my" => -43,
			'WORD_SCOPED' => -43,
			'OP01_NAMED' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"foreach my" => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 198,
			'SubroutineArguments' => 199
		}
	},
	{#State 118
		DEFAULT => -37
	},
	{#State 119
		ACTIONS => {
			";" => 201
		}
	},
	{#State 120
		ACTIONS => {
			"use" => 35,
			"use constant" => -56,
			"our %properties = (" => -56
		},
		GOTOS => {
			'Include' => 203,
			'STAR-22' => 202
		}
	},
	{#State 121
		DEFAULT => -51
	},
	{#State 122
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 91,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			"\@{" => 82
		},
		GOTOS => {
			'Literal' => 83,
			'Operator' => 72,
			'Variable' => 125,
			'SubExpression' => 204,
			'HashDereferenced' => 84,
			'HashReference' => 80,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105
		}
	},
	{#State 123
		ACTIONS => {
			";" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP18_TERNARY' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP08_STRING_CAT' => -92,
			'OP15_LOGICAL_AND' => -92,
			")" => -92,
			".." => -92,
			'OP12_COMPARE_EQ_NEQ' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP21_LIST_COMMA' => -92,
			"}" => -92,
			"]" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP04_MATH_POW' => 180,
			'OP11_COMPARE_LT_GT' => -92,
			'OP16_LOGICAL_OR' => -92
		}
	},
	{#State 124
		DEFAULT => -129
	},
	{#State 125
		ACTIONS => {
			'OP13_BITWISE_AND' => -132,
			"}" => -132,
			'OP23_LOGICAL_AND' => -132,
			"]" => -132,
			'OP02_METHOD_THINARROW' => 168,
			'OP11_COMPARE_LT_GT' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP04_MATH_POW' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			";" => -132,
			'OP18_TERNARY' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP03_MATH_INC_DEC' => 166,
			'OP12_COMPARE_EQ_NEQ' => -132,
			".." => -132,
			'OP17_LIST_RANGE' => -132,
			'OP21_LIST_COMMA' => -132,
			'OP08_STRING_CAT' => -132,
			'OP15_LOGICAL_AND' => -132,
			")" => -132
		}
	},
	{#State 126
		DEFAULT => -141
	},
	{#State 127
		DEFAULT => -204
	},
	{#State 128
		ACTIONS => {
			";" => 205
		}
	},
	{#State 129
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 206,
			'OP19_VARIABLE_ASSIGN_BY' => -167,
			'OP06_REGEX_MATCH' => -167,
			'OP07_MATH_MULT_DIV_MOD' => -167,
			'OP02_METHOD_THINARROW' => -167,
			'OP16_LOGICAL_OR' => -167,
			'OP11_COMPARE_LT_GT' => -167,
			'OP04_MATH_POW' => -167,
			"}" => -167,
			'OP23_LOGICAL_AND' => -167,
			'OP19_VARIABLE_ASSIGN' => -167,
			"]" => -167,
			'COLON' => -167,
			'OP13_BITWISE_AND' => -167,
			'OP02_HASH_THINARROW' => 208,
			'OP08_STRING_CAT' => -167,
			'OP15_LOGICAL_AND' => -167,
			")" => -167,
			'OP03_MATH_INC_DEC' => -167,
			'OP14_BITWISE_OR_XOR' => -167,
			".." => -167,
			'OP12_COMPARE_EQ_NEQ' => -167,
			'OP17_LIST_RANGE' => -167,
			'OP21_LIST_COMMA' => -167,
			'OP08_MATH_ADD_SUB' => -167,
			'OP24_LOGICAL_OR_XOR' => -167,
			";" => -167,
			'OP18_TERNARY' => -167,
			'OP09_BITWISE_SHIFT' => -167
		},
		GOTOS => {
			'VariableRetrieval' => 207
		}
	},
	{#State 130
		ACTIONS => {
			'OP21_LIST_COMMA' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			".." => -99,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP15_LOGICAL_AND' => -99,
			")" => -99,
			'OP08_STRING_CAT' => 188,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => -99,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => -99,
			";" => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP04_MATH_POW' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP13_BITWISE_AND' => -99,
			'OP23_LOGICAL_AND' => -99,
			"]" => -99,
			"}" => -99
		}
	},
	{#State 131
		ACTIONS => {
			'OP23_LOGICAL_AND' => 191,
			'OP13_BITWISE_AND' => 190,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP04_MATH_POW' => 180,
			'OP18_TERNARY' => 186,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			")" => 209,
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178
		}
	},
	{#State 132
		DEFAULT => -16
	},
	{#State 133
		DEFAULT => -145
	},
	{#State 134
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP03_MATH_INC_DEC' => 91
		},
		GOTOS => {
			'HashDereferenced' => 84,
			'SubExpression' => 210,
			'Variable' => 125,
			'Operator' => 72,
			'Literal' => 83,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'HashReference' => 80
		}
	},
	{#State 135
		DEFAULT => -156
	},
	{#State 136
		DEFAULT => -158
	},
	{#State 137
		DEFAULT => -157
	},
	{#State 138
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 211
		}
	},
	{#State 139
		ACTIONS => {
			'VARIABLE_SYMBOL' => 212
		}
	},
	{#State 140
		ACTIONS => {
			"}" => 213
		}
	},
	{#State 141
		ACTIONS => {
			"}" => 214
		}
	},
	{#State 142
		ACTIONS => {
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP16_LOGICAL_OR' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP04_MATH_POW' => 180,
			'OP23_LOGICAL_AND' => -100,
			"]" => -100,
			"}" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			")" => -100,
			'OP08_STRING_CAT' => 188,
			'OP21_LIST_COMMA' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP17_LIST_RANGE' => -100,
			".." => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => -100,
			";" => -100,
			'OP09_BITWISE_SHIFT' => 183
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 215
		}
	},
	{#State 144
		ACTIONS => {
			'OP18_TERNARY' => 186,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP09_BITWISE_SHIFT' => 183,
			'OP15_LOGICAL_AND' => 189,
			")" => 216,
			'OP08_STRING_CAT' => 188,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP23_LOGICAL_AND' => 191,
			'OP13_BITWISE_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP04_MATH_POW' => 180
		}
	},
	{#State 145
		DEFAULT => -89
	},
	{#State 146
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 217
		}
	},
	{#State 147
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_NUMBER' => 87,
			"my" => 116,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			"\@{" => 82,
			'KEYS_OR_VALUES' => 150,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99
		},
		GOTOS => {
			'HashDereferenced' => 84,
			'SubExpression' => 195,
			'Variable' => 125,
			'Operator' => 72,
			'ListElement' => 218,
			'Literal' => 83,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'TypeInner' => 153,
			'HashReference' => 80
		}
	},
	{#State 148
		ACTIONS => {
			'OP23_LOGICAL_AND' => 191,
			'OP13_BITWISE_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP04_MATH_POW' => 180,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP18_TERNARY' => 186,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP15_LOGICAL_AND' => 189,
			")" => 219,
			'OP08_STRING_CAT' => 188,
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP14_BITWISE_OR_XOR' => 187
		}
	},
	{#State 149
		DEFAULT => -88
	},
	{#State 150
		ACTIONS => {
			"%{" => 109
		},
		GOTOS => {
			'HashDereferenced' => 220
		}
	},
	{#State 151
		ACTIONS => {
			'LEFT_PAREN' => 221
		}
	},
	{#State 152
		DEFAULT => -115
	},
	{#State 153
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109
		},
		GOTOS => {
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'HashReference' => 80,
			'HashDereferenced' => 84,
			'SubExpression' => 222,
			'Variable' => 125,
			'Literal' => 83,
			'Operator' => 72
		}
	},
	{#State 154
		ACTIONS => {
			";" => 223
		}
	},
	{#State 155
		ACTIONS => {
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP21_LIST_COMMA' => -182,
			'OP08_STRING_CAT' => 188,
			")" => -182,
			'OP15_LOGICAL_AND' => 189,
			'OP09_BITWISE_SHIFT' => 183,
			";" => -182,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP18_TERNARY' => 186,
			'OP04_MATH_POW' => 180,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP13_BITWISE_AND' => 190,
			"]" => -182,
			'OP23_LOGICAL_AND' => 191
		}
	},
	{#State 156
		DEFAULT => -177,
		GOTOS => {
			'STAR-47' => 224
		}
	},
	{#State 157
		DEFAULT => -112
	},
	{#State 158
		DEFAULT => -113
	},
	{#State 159
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'KEYS_OR_VALUES' => 150,
			"\@{" => 82,
			"%{" => 109,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			"my" => 116,
			'WORD_SCOPED' => 29,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104
		},
		GOTOS => {
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80,
			'ListElements' => 225,
			'TypeInner' => 153,
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 155,
			'Literal' => 83,
			'Operator' => 72,
			'ListElement' => 156
		}
	},
	{#State 160
		ACTIONS => {
			"%{" => 109,
			"\@{" => 82,
			'KEYS_OR_VALUES' => 150,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			'OP03_MATH_INC_DEC' => 91,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			"my" => 116,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'OP22_LOGICAL_NOT' => 106,
			'OP01_QW' => 151
		},
		GOTOS => {
			'Variable' => 125,
			'SubExpression' => 155,
			'HashDereferenced' => 84,
			'Literal' => 83,
			'Operator' => 72,
			'ListElement' => 156,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'ListElements' => 226,
			'HashReference' => 80,
			'TypeInner' => 153
		}
	},
	{#State 161
		DEFAULT => -198,
		GOTOS => {
			'STAR-52' => 227
		}
	},
	{#State 162
		DEFAULT => -193
	},
	{#State 163
		ACTIONS => {
			'OP20_HASH_FATARROW' => 228
		}
	},
	{#State 164
		DEFAULT => -137
	},
	{#State 165
		ACTIONS => {
			"filehandle_ref" => 229
		}
	},
	{#State 166
		DEFAULT => -90
	},
	{#State 167
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95
		},
		GOTOS => {
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 230,
			'Literal' => 83,
			'Operator' => 72,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80
		}
	},
	{#State 168
		ACTIONS => {
			'WORD' => 231
		}
	},
	{#State 169
		ACTIONS => {
			"%{" => 109,
			"\@{" => 82,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			'OP03_MATH_INC_DEC' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'WORD_SCOPED' => 29,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'STDIN' => 234,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'OP22_LOGICAL_NOT' => 106
		},
		GOTOS => {
			'HashReference' => 80,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'Literal' => 83,
			'SubExpressionOrStdin' => 233,
			'Operator' => 72,
			'HashDereferenced' => 84,
			'SubExpression' => 232,
			'Variable' => 125
		}
	},
	{#State 170
		ACTIONS => {
			"]" => 235
		}
	},
	{#State 171
		DEFAULT => -185
	},
	{#State 172
		ACTIONS => {
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NOT' => 106,
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"my" => 116,
			'OP03_MATH_INC_DEC' => 91,
			")" => -123,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"\@{" => 82,
			'KEYS_OR_VALUES' => 150,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30
		},
		GOTOS => {
			'Variable' => 125,
			'SubExpression' => 155,
			'HashDereferenced' => 84,
			'OPTIONAL-36' => 236,
			'Operator' => 72,
			'ListElement' => 156,
			'Literal' => 83,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'HashReference' => 80,
			'ListElements' => 237,
			'TypeInner' => 153
		}
	},
	{#State 173
		ACTIONS => {
			'OP13_BITWISE_AND' => 190,
			"}" => -109,
			"]" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			";" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP08_MATH_ADD_SUB' => 184,
			'OP18_TERNARY' => 186,
			'OP12_COMPARE_EQ_NEQ' => 178,
			".." => -109,
			'OP17_LIST_RANGE' => 179,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP21_LIST_COMMA' => -109,
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => 189,
			")" => -109
		}
	},
	{#State 174
		DEFAULT => -82
	},
	{#State 175
		ACTIONS => {
			"}" => 238
		}
	},
	{#State 176
		ACTIONS => {
			"%{" => 109,
			'WORD' => 163
		},
		GOTOS => {
			'HashEntry' => 161,
			'HashDereferenced' => 162
		}
	},
	{#State 177
		ACTIONS => {
			"}" => 239
		}
	},
	{#State 178
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109
		},
		GOTOS => {
			'HashReference' => 80,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'Operator' => 72,
			'Literal' => 83,
			'HashDereferenced' => 84,
			'SubExpression' => 240,
			'Variable' => 125
		}
	},
	{#State 179
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'HashReference' => 80,
			'Variable' => 125,
			'SubExpression' => 241,
			'HashDereferenced' => 84,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 180
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91
		},
		GOTOS => {
			'Operator' => 72,
			'Literal' => 83,
			'HashDereferenced' => 84,
			'SubExpression' => 242,
			'Variable' => 125,
			'HashReference' => 80,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124
		}
	},
	{#State 181
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 106,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD_SCOPED' => 29,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109
		},
		GOTOS => {
			'Operator' => 72,
			'Literal' => 83,
			'HashDereferenced' => 84,
			'SubExpression' => 243,
			'Variable' => 125,
			'HashReference' => 80,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124
		}
	},
	{#State 182
		ACTIONS => {
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"%{" => 109,
			"\@{" => 82,
			'WORD' => 30,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'HashReference' => 80,
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 244,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 183
		ACTIONS => {
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106
		},
		GOTOS => {
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 245,
			'Literal' => 83,
			'Operator' => 72,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80
		}
	},
	{#State 184
		ACTIONS => {
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30
		},
		GOTOS => {
			'Variable' => 125,
			'SubExpression' => 246,
			'HashDereferenced' => 84,
			'Literal' => 83,
			'Operator' => 72,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80
		}
	},
	{#State 185
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			"\@{" => 82
		},
		GOTOS => {
			'HashReference' => 80,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'Operator' => 72,
			'Literal' => 83,
			'SubExpression' => 247,
			'HashDereferenced' => 84,
			'Variable' => 125
		}
	},
	{#State 186
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 248
		}
	},
	{#State 187
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100
		},
		GOTOS => {
			'SubExpression' => 249,
			'HashDereferenced' => 84,
			'Variable' => 125,
			'Operator' => 72,
			'Literal' => 83,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'HashReference' => 80
		}
	},
	{#State 188
		ACTIONS => {
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30
		},
		GOTOS => {
			'HashReference' => 80,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'Literal' => 83,
			'Operator' => 72,
			'Variable' => 125,
			'SubExpression' => 250,
			'HashDereferenced' => 84
		}
	},
	{#State 189
		ACTIONS => {
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'OP03_MATH_INC_DEC' => 91,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30
		},
		GOTOS => {
			'Operator' => 72,
			'Literal' => 83,
			'HashDereferenced' => 84,
			'SubExpression' => 251,
			'Variable' => 125,
			'HashReference' => 80,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124
		}
	},
	{#State 190
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP03_MATH_INC_DEC' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			"\@{" => 82
		},
		GOTOS => {
			'Variable' => 125,
			'SubExpression' => 252,
			'HashDereferenced' => 84,
			'Literal' => 83,
			'Operator' => 72,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80
		}
	},
	{#State 191
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 106,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109
		},
		GOTOS => {
			'SubExpression' => 253,
			'HashDereferenced' => 84,
			'Variable' => 125,
			'Operator' => 72,
			'Literal' => 83,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'HashReference' => 80
		}
	},
	{#State 192
		ACTIONS => {
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_NUMBER' => 87,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			"\@{" => 82,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99
		},
		GOTOS => {
			'HashDereferenced' => 84,
			'SubExpression' => 254,
			'Variable' => 125,
			'Operator' => 72,
			'Literal' => 83,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'HashReference' => 80
		}
	},
	{#State 193
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 255
		}
	},
	{#State 194
		ACTIONS => {
			'OP21_LIST_COMMA' => 256
		}
	},
	{#State 195
		ACTIONS => {
			'OP15_LOGICAL_AND' => -85,
			")" => -85,
			'OP08_STRING_CAT' => -85,
			'OP21_LIST_COMMA' => -182,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			'OP18_TERNARY' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			";" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP04_MATH_POW' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP13_BITWISE_AND' => -85
		}
	},
	{#State 196
		ACTIONS => {
			";" => 257
		}
	},
	{#State 197
		ACTIONS => {
			"\$TYPED_" => 258
		}
	},
	{#State 198
		ACTIONS => {
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_PRINT' => 98,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'OP19_LOOP_CONTROL' => 73,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'OP22_LOGICAL_NOT' => 106,
			"%{" => 109,
			"\@{" => 82,
			'WORD' => 86,
			'LITERAL_STRING' => 85,
			"for my integer" => -143,
			"foreach my" => -143,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"if (" => 90,
			'WORD_SCOPED' => 29,
			"my" => 89,
			'OP01_NAMED' => 112,
			'OP01_NAMED_VOID' => 96,
			"while (" => -143,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93
		},
		GOTOS => {
			'Literal' => 83,
			'Operation' => 260,
			'HashDereferenced' => 84,
			'SubExpression' => 111,
			'Conditional' => 113,
			'PAREN-38' => 114,
			'ArrayReference' => 94,
			'OperatorVoid' => 97,
			'LoopLabel' => 71,
			'Operator' => 72,
			'Statement' => 74,
			'VariableModification' => 101,
			'Variable' => 103,
			'VariableDeclaration' => 77,
			'HashReference' => 80,
			'PLUS-17' => 259,
			'WordScoped' => 105,
			'ArrayDereferenced' => 107,
			'Expression' => 108,
			'OPTIONAL-39' => 81
		}
	},
	{#State 199
		DEFAULT => -42
	},
	{#State 200
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 261
		}
	},
	{#State 201
		DEFAULT => -40
	},
	{#State 202
		ACTIONS => {
			"use constant" => 42,
			"our %properties = (" => 262
		},
		GOTOS => {
			'Constant' => 263,
			'Properties' => 264
		}
	},
	{#State 203
		DEFAULT => -53
	},
	{#State 204
		ACTIONS => {
			'OP18_TERNARY' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			";" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP15_LOGICAL_AND' => -85,
			")" => -85,
			'OP08_STRING_CAT' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			".." => -85,
			'OP17_LIST_RANGE' => -85,
			'OP23_LOGICAL_AND' => -85,
			"]" => -85,
			"}" => -85,
			'OP13_BITWISE_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP04_MATH_POW' => -85
		}
	},
	{#State 205
		DEFAULT => -121
	},
	{#State 206
		ACTIONS => {
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'WORD_SCOPED' => 29,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30
		},
		GOTOS => {
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80,
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 265,
			'Literal' => 83,
			'Operator' => 72
		}
	},
	{#State 207
		DEFAULT => -165
	},
	{#State 208
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"%{" => 109,
			"\@{" => 82,
			'WORD' => 267,
			'LITERAL_STRING' => 85,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102
		},
		GOTOS => {
			'HashReference' => 80,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'Literal' => 83,
			'Operator' => 72,
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 266
		}
	},
	{#State 209
		DEFAULT => -93
	},
	{#State 210
		ACTIONS => {
			'OP13_BITWISE_AND' => 190,
			'OP23_LOGICAL_AND' => 191,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 186,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			")" => 268,
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188
		}
	},
	{#State 211
		ACTIONS => {
			'VARIABLE_SYMBOL' => 269
		}
	},
	{#State 212
		ACTIONS => {
			'LEFT_PAREN' => 270
		}
	},
	{#State 213
		DEFAULT => -188
	},
	{#State 214
		DEFAULT => -189
	},
	{#State 215
		ACTIONS => {
			";" => 271,
			'OP19_VARIABLE_ASSIGN' => 272
		}
	},
	{#State 216
		ACTIONS => {
			'LEFT_BRACE' => 273
		},
		GOTOS => {
			'CodeBlock' => 274
		}
	},
	{#State 217
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"my" => 116,
			'OP03_MATH_INC_DEC' => 91,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'KEYS_OR_VALUES' => 150,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ListElements' => 275,
			'HashReference' => 80,
			'TypeInner' => 153,
			'Variable' => 125,
			'SubExpression' => 155,
			'HashDereferenced' => 84,
			'ListElement' => 156,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 218
		ACTIONS => {
			'OP21_LIST_COMMA' => 276
		}
	},
	{#State 219
		DEFAULT => -138
	},
	{#State 220
		DEFAULT => -184
	},
	{#State 221
		ACTIONS => {
			'WORD' => 277
		},
		GOTOS => {
			'PLUS-48' => 278
		}
	},
	{#State 222
		ACTIONS => {
			'OP21_LIST_COMMA' => -183,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP14_BITWISE_OR_XOR' => 187,
			")" => -183,
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188,
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => 186,
			";" => -183,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP13_BITWISE_AND' => 190,
			"]" => -183,
			'OP23_LOGICAL_AND' => 191
		}
	},
	{#State 223
		DEFAULT => -119
	},
	{#State 224
		ACTIONS => {
			'OP21_LIST_COMMA' => 279,
			")" => -180,
			"]" => -180,
			";" => -180
		},
		GOTOS => {
			'PAREN-46' => 280
		}
	},
	{#State 225
		ACTIONS => {
			";" => 281
		}
	},
	{#State 226
		ACTIONS => {
			";" => 282
		}
	},
	{#State 227
		ACTIONS => {
			"}" => 284,
			'OP21_LIST_COMMA' => 283
		},
		GOTOS => {
			'PAREN-51' => 285
		}
	},
	{#State 228
		ACTIONS => {
			'WORD' => -191,
			'LITERAL_STRING' => -191,
			"%{" => -191,
			"\@{" => -191,
			'OP01_CLOSE' => -191,
			'LEFT_PAREN' => -191,
			'OP03_MATH_INC_DEC' => -191,
			"my" => 116,
			'OP01_NAMED' => -191,
			'WORD_SCOPED' => -191,
			'LITERAL_NUMBER' => -191,
			'OP10_NAMED_UNARY_STRINGIFY' => -191,
			'VARIABLE_SYMBOL' => -191,
			'OP01_OPEN' => -191,
			"undef" => -191,
			'OP05_LOGICAL_NEG' => -191,
			'LEFT_BRACE' => -191,
			'OP22_LOGICAL_NOT' => -191,
			'LEFT_BRACKET' => -191,
			'OP10_NAMED_UNARY' => -191,
			'OP05_MATH_NEG' => -191
		},
		GOTOS => {
			'OPTIONAL-50' => 286,
			'TypeInner' => 287
		}
	},
	{#State 229
		ACTIONS => {
			'FH_REF_SYMBOL' => 288
		}
	},
	{#State 230
		ACTIONS => {
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP04_MATH_POW' => 180,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP13_BITWISE_AND' => 190,
			'OP23_LOGICAL_AND' => 191,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => 189,
			'OP09_BITWISE_SHIFT' => 183,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			";" => 289,
			'OP18_TERNARY' => 186
		}
	},
	{#State 231
		ACTIONS => {
			'LEFT_PAREN' => 290
		}
	},
	{#State 232
		ACTIONS => {
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP18_TERNARY' => 186,
			";" => -139,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP23_LOGICAL_AND' => 191,
			'OP13_BITWISE_AND' => 190
		}
	},
	{#State 233
		ACTIONS => {
			";" => 291
		}
	},
	{#State 234
		DEFAULT => -140
	},
	{#State 235
		DEFAULT => -187
	},
	{#State 236
		ACTIONS => {
			")" => 292
		}
	},
	{#State 237
		DEFAULT => -122
	},
	{#State 238
		DEFAULT => -200
	},
	{#State 239
		DEFAULT => -201
	},
	{#State 240
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 183,
			";" => -102,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP18_TERNARY' => -102,
			'OP17_LIST_RANGE' => -102,
			".." => -102,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => -102,
			")" => -102,
			'OP13_BITWISE_AND' => -102,
			"}" => -102,
			"]" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP04_MATH_POW' => 180,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => -102,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182
		}
	},
	{#State 241
		ACTIONS => {
			'OP15_LOGICAL_AND' => 189,
			")" => -107,
			'OP08_STRING_CAT' => 188,
			'OP21_LIST_COMMA' => -107,
			'OP12_COMPARE_EQ_NEQ' => 178,
			".." => -107,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP18_TERNARY' => -107,
			";" => -107,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			"]" => -107,
			'OP23_LOGICAL_AND' => -107,
			"}" => -107,
			'OP13_BITWISE_AND' => 190
		}
	},
	{#State 242
		ACTIONS => {
			'OP18_TERNARY' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			";" => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP15_LOGICAL_AND' => -91,
			")" => -91,
			'OP08_STRING_CAT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91,
			".." => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP23_LOGICAL_AND' => -91,
			"]" => -91,
			"}" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP04_MATH_POW' => 180
		}
	},
	{#State 243
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => -101,
			";" => -101,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP21_LIST_COMMA' => -101,
			".." => -101,
			'OP17_LIST_RANGE' => -101,
			'OP12_COMPARE_EQ_NEQ' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			")" => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP08_STRING_CAT' => 188,
			'OP13_BITWISE_AND' => -101,
			"]" => -101,
			'OP23_LOGICAL_AND' => -101,
			"}" => -101,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => -101,
			'OP11_COMPARE_LT_GT' => undef,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182
		}
	},
	{#State 244
		ACTIONS => {
			'OP13_BITWISE_AND' => -95,
			"]" => -95,
			'OP23_LOGICAL_AND' => -95,
			"}" => -95,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP18_TERNARY' => -95,
			";" => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP21_LIST_COMMA' => -95,
			".." => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			")" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95
		}
	},
	{#State 245
		ACTIONS => {
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP04_MATH_POW' => 180,
			'OP11_COMPARE_LT_GT' => -98,
			'OP16_LOGICAL_OR' => -98,
			"]" => -98,
			'OP23_LOGICAL_AND' => -98,
			"}" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP15_LOGICAL_AND' => -98,
			")" => -98,
			'OP08_STRING_CAT' => 188,
			'OP21_LIST_COMMA' => -98,
			'OP17_LIST_RANGE' => -98,
			".." => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			";" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 184,
			'OP09_BITWISE_SHIFT' => -98
		}
	},
	{#State 246
		ACTIONS => {
			"}" => -96,
			"]" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			";" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP18_TERNARY' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP08_STRING_CAT' => -96,
			")" => -96,
			'OP15_LOGICAL_AND' => -96,
			".." => -96,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96
		}
	},
	{#State 247
		ACTIONS => {
			'OP13_BITWISE_AND' => 190,
			"}" => -111,
			'OP23_LOGICAL_AND' => 191,
			"]" => -111,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP04_MATH_POW' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP09_BITWISE_SHIFT' => 183,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP08_MATH_ADD_SUB' => 184,
			";" => -111,
			'OP18_TERNARY' => 186,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => 179,
			".." => -111,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP21_LIST_COMMA' => -111,
			'OP08_STRING_CAT' => 188,
			")" => -111,
			'OP15_LOGICAL_AND' => 189
		}
	},
	{#State 248
		ACTIONS => {
			'COLON' => 293
		}
	},
	{#State 249
		ACTIONS => {
			"}" => -104,
			'OP23_LOGICAL_AND' => -104,
			"]" => -104,
			'OP13_BITWISE_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP16_LOGICAL_OR' => -104,
			'OP11_COMPARE_LT_GT' => 181,
			'OP04_MATH_POW' => 180,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => -104,
			";" => -104,
			'OP18_TERNARY' => -104,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_STRING_CAT' => 188,
			")" => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			".." => -104,
			'OP17_LIST_RANGE' => -104,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP21_LIST_COMMA' => -104
		}
	},
	{#State 250
		ACTIONS => {
			'OP18_TERNARY' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP08_MATH_ADD_SUB' => 184,
			";" => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP15_LOGICAL_AND' => -97,
			")" => -97,
			'OP08_STRING_CAT' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP17_LIST_RANGE' => -97,
			".." => -97,
			'OP12_COMPARE_EQ_NEQ' => -97,
			'OP23_LOGICAL_AND' => -97,
			"]" => -97,
			"}" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP16_LOGICAL_OR' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP04_MATH_POW' => 180
		}
	},
	{#State 251
		ACTIONS => {
			'OP13_BITWISE_AND' => 190,
			"}" => -105,
			'OP23_LOGICAL_AND' => -105,
			"]" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP11_COMPARE_LT_GT' => 181,
			'OP04_MATH_POW' => 180,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP09_BITWISE_SHIFT' => 183,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => -105,
			";" => -105,
			'OP18_TERNARY' => -105,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => -105,
			".." => -105,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP21_LIST_COMMA' => -105,
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => -105,
			")" => -105
		}
	},
	{#State 252
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 183,
			'OP18_TERNARY' => -103,
			";" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP08_MATH_ADD_SUB' => 184,
			'OP21_LIST_COMMA' => -103,
			".." => -103,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => -103,
			")" => -103,
			'OP08_STRING_CAT' => 188,
			'OP13_BITWISE_AND' => -103,
			"]" => -103,
			'OP23_LOGICAL_AND' => -103,
			"}" => -103,
			'OP04_MATH_POW' => 180,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193
		}
	},
	{#State 253
		ACTIONS => {
			")" => -110,
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188,
			'OP21_LIST_COMMA' => -110,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP12_COMPARE_EQ_NEQ' => 178,
			".." => -110,
			'OP17_LIST_RANGE' => 179,
			'OP18_TERNARY' => 186,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP08_MATH_ADD_SUB' => 184,
			";" => -110,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP04_MATH_POW' => 180,
			'OP23_LOGICAL_AND' => -110,
			"]" => -110,
			"}" => -110,
			'OP13_BITWISE_AND' => 190
		}
	},
	{#State 254
		ACTIONS => {
			'OP18_TERNARY' => -106,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => -106,
			";" => -106,
			'OP09_BITWISE_SHIFT' => 183,
			")" => -106,
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188,
			'OP21_LIST_COMMA' => -106,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP12_COMPARE_EQ_NEQ' => 178,
			".." => -106,
			'OP17_LIST_RANGE' => -106,
			'OP23_LOGICAL_AND' => -106,
			"]" => -106,
			"}" => -106,
			'OP13_BITWISE_AND' => 190,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP16_LOGICAL_OR' => -106,
			'OP11_COMPARE_LT_GT' => 181,
			'OP04_MATH_POW' => 180
		}
	},
	{#State 255
		DEFAULT => -94
	},
	{#State 256
		ACTIONS => {
			"\@{" => 82,
			'KEYS_OR_VALUES' => 150,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'LITERAL_NUMBER' => 87,
			"my" => 116,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NOT' => 106
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'HashReference' => 80,
			'ListElements' => 294,
			'TypeInner' => 153,
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 155,
			'Operator' => 72,
			'ListElement' => 156,
			'Literal' => 83
		}
	},
	{#State 257
		DEFAULT => -41
	},
	{#State 258
		ACTIONS => {
			'WORD' => 295
		}
	},
	{#State 259
		ACTIONS => {
			"for my integer" => -143,
			'LITERAL_STRING' => 85,
			'WORD' => 86,
			"\@{" => 82,
			"%{" => 109,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP01_NAMED_VOID' => 96,
			"while (" => -143,
			"if (" => 90,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			"my" => 89,
			'OP01_NAMED' => 112,
			'WORD_SCOPED' => 29,
			'OP03_MATH_INC_DEC' => 91,
			"foreach my" => -143,
			'OP19_LOOP_CONTROL' => 73,
			'VARIABLE_SYMBOL' => 75,
			"}" => 297,
			'OP01_OPEN' => 102,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_PRINT' => 98,
			"undef" => 100,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104
		},
		GOTOS => {
			'Operation' => 296,
			'Literal' => 83,
			'HashDereferenced' => 84,
			'SubExpression' => 111,
			'Conditional' => 113,
			'PAREN-38' => 114,
			'ArrayReference' => 94,
			'OperatorVoid' => 97,
			'Operator' => 72,
			'LoopLabel' => 71,
			'Statement' => 74,
			'VariableModification' => 101,
			'Variable' => 103,
			'VariableDeclaration' => 77,
			'HashReference' => 80,
			'WordScoped' => 105,
			'ArrayDereferenced' => 107,
			'Expression' => 108,
			'OPTIONAL-39' => 81
		}
	},
	{#State 260
		DEFAULT => -45
	},
	{#State 261
		ACTIONS => {
			'VARIABLE_SYMBOL' => 298
		}
	},
	{#State 262
		ACTIONS => {
			")" => 299,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 300
		}
	},
	{#State 263
		DEFAULT => -55
	},
	{#State 264
		ACTIONS => {
			"our" => -58,
			"our %properties_class = (" => 301,
			'LITERAL_NUMBER' => -58
		},
		GOTOS => {
			'OPTIONAL-23' => 302,
			'PropertiesClass' => 303
		}
	},
	{#State 265
		ACTIONS => {
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP18_TERNARY' => 186,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP04_MATH_POW' => 180,
			'OP23_LOGICAL_AND' => 191,
			"]" => 304,
			'OP13_BITWISE_AND' => 190
		}
	},
	{#State 266
		ACTIONS => {
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP04_MATH_POW' => 180,
			"}" => 305,
			'OP23_LOGICAL_AND' => 191,
			'OP13_BITWISE_AND' => 190,
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => 189,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP18_TERNARY' => 186,
			'OP09_BITWISE_SHIFT' => 183
		}
	},
	{#State 267
		ACTIONS => {
			"}" => 306,
			'LEFT_PAREN' => -202
		}
	},
	{#State 268
		ACTIONS => {
			'LEFT_BRACE' => 273
		},
		GOTOS => {
			'CodeBlock' => 307
		}
	},
	{#State 269
		ACTIONS => {
			'LEFT_PAREN' => 308
		}
	},
	{#State 270
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104
		},
		GOTOS => {
			'HashReference' => 80,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'Operator' => 72,
			'Literal' => 83,
			'HashDereferenced' => 84,
			'SubExpression' => 309,
			'Variable' => 125
		}
	},
	{#State 271
		DEFAULT => -171
	},
	{#State 272
		ACTIONS => {
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'STDIN' => 234,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106
		},
		GOTOS => {
			'Literal' => 83,
			'SubExpressionOrStdin' => 310,
			'Operator' => 72,
			'Variable' => 125,
			'SubExpression' => 232,
			'HashDereferenced' => 84,
			'HashReference' => 80,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105
		}
	},
	{#State 273
		ACTIONS => {
			"\@{" => 82,
			"%{" => 109,
			"for my integer" => -143,
			'LITERAL_STRING' => 85,
			'WORD' => 86,
			'OP01_NAMED' => 112,
			"if (" => 90,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"my" => 89,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			"foreach my" => -143,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			"while (" => -143,
			'OP01_NAMED_VOID' => 96,
			'OP01_PRINT' => 98,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'OP19_LOOP_CONTROL' => 73,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106
		},
		GOTOS => {
			'Literal' => 83,
			'Operation' => 312,
			'SubExpression' => 111,
			'HashDereferenced' => 84,
			'PLUS-44' => 311,
			'PAREN-38' => 114,
			'Conditional' => 113,
			'ArrayReference' => 94,
			'Operator' => 72,
			'LoopLabel' => 71,
			'OperatorVoid' => 97,
			'Variable' => 103,
			'Statement' => 74,
			'VariableModification' => 101,
			'HashReference' => 80,
			'VariableDeclaration' => 77,
			'ArrayDereferenced' => 107,
			'Expression' => 108,
			'OPTIONAL-39' => 81,
			'WordScoped' => 105
		}
	},
	{#State 274
		DEFAULT => -151,
		GOTOS => {
			'STAR-41' => 313
		}
	},
	{#State 275
		ACTIONS => {
			")" => 314
		}
	},
	{#State 276
		ACTIONS => {
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP01_NAMED' => 122,
			"my" => 116,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'KEYS_OR_VALUES' => 150,
			"\@{" => 82,
			"%{" => 109,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100
		},
		GOTOS => {
			'HashDereferenced' => 84,
			'SubExpression' => 155,
			'Variable' => 125,
			'Literal' => 83,
			'Operator' => 72,
			'ListElement' => 156,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'TypeInner' => 153,
			'HashReference' => 80,
			'ListElements' => 315
		}
	},
	{#State 277
		DEFAULT => -179
	},
	{#State 278
		ACTIONS => {
			'WORD' => 316,
			")" => 317
		}
	},
	{#State 279
		ACTIONS => {
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			'KEYS_OR_VALUES' => 150,
			"\@{" => 82,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP03_MATH_INC_DEC' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			'WORD_SCOPED' => 29,
			"my" => 116,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76
		},
		GOTOS => {
			'HashReference' => 80,
			'TypeInner' => 153,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'Literal' => 83,
			'Operator' => 72,
			'ListElement' => 318,
			'Variable' => 125,
			'SubExpression' => 155,
			'HashDereferenced' => 84
		}
	},
	{#State 280
		DEFAULT => -176
	},
	{#State 281
		DEFAULT => -117
	},
	{#State 282
		DEFAULT => -118
	},
	{#State 283
		ACTIONS => {
			"%{" => 109,
			'WORD' => 163
		},
		GOTOS => {
			'HashDereferenced' => 162,
			'HashEntry' => 319
		}
	},
	{#State 284
		DEFAULT => -199
	},
	{#State 285
		DEFAULT => -197
	},
	{#State 286
		ACTIONS => {
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106,
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93
		},
		GOTOS => {
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80,
			'Variable' => 125,
			'SubExpression' => 320,
			'HashDereferenced' => 84,
			'Literal' => 83,
			'Operator' => 72
		}
	},
	{#State 287
		DEFAULT => -190
	},
	{#State 288
		ACTIONS => {
			'OP21_LIST_COMMA' => 321
		}
	},
	{#State 289
		DEFAULT => -174
	},
	{#State 290
		ACTIONS => {
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 122,
			"my" => 116,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP03_MATH_INC_DEC' => 91,
			")" => -125,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"\@{" => 82,
			'KEYS_OR_VALUES' => 150,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NOT' => 106,
			"undef" => 100,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'OPTIONAL-37' => 322,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'ListElements' => 323,
			'HashReference' => 80,
			'TypeInner' => 153,
			'Variable' => 125,
			'SubExpression' => 155,
			'HashDereferenced' => 84,
			'Literal' => 83,
			'ListElement' => 156,
			'Operator' => 72
		}
	},
	{#State 291
		DEFAULT => -173
	},
	{#State 292
		DEFAULT => -127
	},
	{#State 293
		ACTIONS => {
			'VARIABLE_SYMBOL' => 75
		},
		GOTOS => {
			'Variable' => 324
		}
	},
	{#State 294
		ACTIONS => {
			";" => 325
		}
	},
	{#State 295
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 326
		}
	},
	{#State 296
		DEFAULT => -44
	},
	{#State 297
		ACTIONS => {
			";" => 327
		}
	},
	{#State 298
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 328
		}
	},
	{#State 299
		ACTIONS => {
			";" => 329
		}
	},
	{#State 300
		ACTIONS => {
			"%{" => 109,
			'WORD' => 331
		},
		GOTOS => {
			'HashDereferenced' => 330,
			'HashEntryTyped' => 332
		}
	},
	{#State 301
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 333
		}
	},
	{#State 302
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 334
		}
	},
	{#State 303
		DEFAULT => -57
	},
	{#State 304
		DEFAULT => -168
	},
	{#State 305
		DEFAULT => -169
	},
	{#State 306
		DEFAULT => -170
	},
	{#State 307
		DEFAULT => -161
	},
	{#State 308
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 91,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'LITERAL_NUMBER' => 87,
			"my" => 116,
			'WORD_SCOPED' => 29,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			"%{" => 109,
			'KEYS_OR_VALUES' => 150,
			"\@{" => 82,
			'WORD' => 30,
			'LITERAL_STRING' => 85,
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'OP22_LOGICAL_NOT' => 106,
			'OP01_QW' => 151,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102
		},
		GOTOS => {
			'Variable' => 125,
			'SubExpression' => 155,
			'HashDereferenced' => 84,
			'Literal' => 83,
			'Operator' => 72,
			'ListElement' => 156,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80,
			'ListElements' => 335,
			'TypeInner' => 153
		}
	},
	{#State 309
		ACTIONS => {
			'OP23_LOGICAL_AND' => 191,
			'OP13_BITWISE_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP04_MATH_POW' => 180,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP18_TERNARY' => 186,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP09_BITWISE_SHIFT' => 183,
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => 179,
			".." => 336,
			'OP14_BITWISE_OR_XOR' => 187
		}
	},
	{#State 310
		ACTIONS => {
			";" => 337
		}
	},
	{#State 311
		ACTIONS => {
			'OP01_OPEN' => 102,
			"}" => 338,
			'VARIABLE_SYMBOL' => 75,
			'OP19_LOOP_CONTROL' => 73,
			'OP01_PRINT' => 98,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'WORD' => 86,
			"for my integer" => -143,
			'LITERAL_STRING' => 85,
			"%{" => 109,
			"\@{" => 82,
			'OP01_NAMED_VOID' => 96,
			"while (" => -143,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP03_MATH_INC_DEC' => 91,
			"foreach my" => -143,
			'WORD_SCOPED' => 29,
			"if (" => 90,
			'OP01_NAMED' => 112,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"my" => 89
		},
		GOTOS => {
			'HashReference' => 80,
			'VariableDeclaration' => 77,
			'Expression' => 108,
			'OPTIONAL-39' => 81,
			'ArrayDereferenced' => 107,
			'WordScoped' => 105,
			'LoopLabel' => 71,
			'Operator' => 72,
			'OperatorVoid' => 97,
			'Variable' => 103,
			'VariableModification' => 101,
			'Statement' => 74,
			'PAREN-38' => 114,
			'Conditional' => 113,
			'ArrayReference' => 94,
			'Operation' => 339,
			'Literal' => 83,
			'HashDereferenced' => 84,
			'SubExpression' => 111
		}
	},
	{#State 312
		DEFAULT => -163
	},
	{#State 313
		ACTIONS => {
			'OP10_NAMED_UNARY_STRINGIFY' => -154,
			'LITERAL_NUMBER' => -154,
			"if (" => -154,
			"my" => -154,
			'OP03_MATH_INC_DEC' => -154,
			'LEFT_PAREN' => -154,
			'OP01_CLOSE' => -154,
			"while (" => -154,
			'OP01_NAMED_VOID' => -154,
			"\@{" => -154,
			'LITERAL_STRING' => -154,
			'WORD' => -154,
			'OP10_NAMED_UNARY' => -154,
			'OP05_MATH_NEG' => -154,
			"elsif (" => 344,
			'OP05_LOGICAL_NEG' => -154,
			'OP19_LOOP_CONTROL' => -154,
			'VARIABLE_SYMBOL' => -154,
			"}" => -154,
			'OP01_NAMED' => -154,
			'WORD_SCOPED' => -154,
			"foreach my" => -154,
			"else" => 341,
			"%{" => -154,
			"for my integer" => -154,
			'LEFT_BRACKET' => -154,
			'OP22_LOGICAL_NOT' => -154,
			'OP01_PRINT' => -154,
			'LEFT_BRACE' => -154,
			"undef" => -154,
			'' => -154,
			'OP01_OPEN' => -154
		},
		GOTOS => {
			'PAREN-42' => 342,
			'PAREN-40' => 343,
			'OPTIONAL-43' => 340
		}
	},
	{#State 314
		DEFAULT => -84
	},
	{#State 315
		ACTIONS => {
			")" => 345
		}
	},
	{#State 316
		DEFAULT => -178
	},
	{#State 317
		DEFAULT => -181
	},
	{#State 318
		DEFAULT => -175
	},
	{#State 319
		DEFAULT => -196
	},
	{#State 320
		ACTIONS => {
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => 189,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP21_LIST_COMMA' => -192,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP18_TERNARY' => 186,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP04_MATH_POW' => 180,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			"}" => -192,
			'OP23_LOGICAL_AND' => 191,
			'OP13_BITWISE_AND' => 190
		}
	},
	{#State 321
		ACTIONS => {
			'LITERAL_STRING' => 346
		}
	},
	{#State 322
		ACTIONS => {
			")" => 347
		}
	},
	{#State 323
		DEFAULT => -124
	},
	{#State 324
		DEFAULT => -108
	},
	{#State 325
		DEFAULT => -120
	},
	{#State 326
		DEFAULT => -206
	},
	{#State 327
		DEFAULT => -46
	},
	{#State 328
		ACTIONS => {
			")" => 349,
			'OP21_LIST_COMMA' => 348
		},
		GOTOS => {
			'PAREN-18' => 350
		}
	},
	{#State 329
		ACTIONS => {
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 351
		}
	},
	{#State 330
		DEFAULT => -195
	},
	{#State 331
		ACTIONS => {
			'OP20_HASH_FATARROW' => 352
		}
	},
	{#State 332
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 353
		}
	},
	{#State 333
		ACTIONS => {
			"%{" => 109,
			'WORD' => 331
		},
		GOTOS => {
			'HashEntryTyped' => 354,
			'HashDereferenced' => 330
		}
	},
	{#State 334
		ACTIONS => {
			"our" => 355,
			'LITERAL_NUMBER' => 357
		},
		GOTOS => {
			'Subroutine' => 358,
			'MethodOrSubroutine' => 356,
			'Method' => 359
		}
	},
	{#State 335
		ACTIONS => {
			")" => 360
		}
	},
	{#State 336
		ACTIONS => {
			'LEFT_BRACKET' => 104,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70,
			"undef" => 100,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'LITERAL_NUMBER' => 87,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			"%{" => 109,
			"\@{" => 82,
			'WORD' => 30,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Variable' => 125,
			'SubExpression' => 361,
			'HashDereferenced' => 84,
			'Operator' => 72,
			'Literal' => 83,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'HashReference' => 80
		}
	},
	{#State 337
		DEFAULT => -172
	},
	{#State 338
		DEFAULT => -164
	},
	{#State 339
		DEFAULT => -162
	},
	{#State 340
		DEFAULT => -155
	},
	{#State 341
		ACTIONS => {
			'LEFT_BRACE' => 273
		},
		GOTOS => {
			'CodeBlock' => 362
		}
	},
	{#State 342
		DEFAULT => -153
	},
	{#State 343
		DEFAULT => -150
	},
	{#State 344
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP01_NAMED' => 122,
			'OP03_MATH_INC_DEC' => 91,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104
		},
		GOTOS => {
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 363,
			'Literal' => 83,
			'Operator' => 72,
			'Expression' => 124,
			'ArrayDereferenced' => 107,
			'ArrayReference' => 94,
			'WordScoped' => 105,
			'HashReference' => 80
		}
	},
	{#State 345
		DEFAULT => -86
	},
	{#State 346
		ACTIONS => {
			'OP21_LIST_COMMA' => 364
		}
	},
	{#State 347
		DEFAULT => -128
	},
	{#State 348
		ACTIONS => {
			"my" => 365
		}
	},
	{#State 349
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 366
		}
	},
	{#State 350
		DEFAULT => -48
	},
	{#State 351
		DEFAULT => -66
	},
	{#State 352
		ACTIONS => {
			"my" => 116
		},
		GOTOS => {
			'TypeInner' => 367
		}
	},
	{#State 353
		ACTIONS => {
			'OP21_LIST_COMMA' => 368,
			")" => 370
		},
		GOTOS => {
			'PAREN-25' => 369
		}
	},
	{#State 354
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 371
		}
	},
	{#State 355
		ACTIONS => {
			'TYPE_METHOD' => 372,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 356
		DEFAULT => -59
	},
	{#State 357
		ACTIONS => {
			";" => 373
		}
	},
	{#State 358
		DEFAULT => -81
	},
	{#State 359
		DEFAULT => -80
	},
	{#State 360
		ACTIONS => {
			'LEFT_BRACE' => 273
		},
		GOTOS => {
			'CodeBlock' => 374
		}
	},
	{#State 361
		ACTIONS => {
			")" => 375,
			'OP15_LOGICAL_AND' => 189,
			'OP08_STRING_CAT' => 188,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP18_TERNARY' => 186,
			'OP08_MATH_ADD_SUB' => 184,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP09_BITWISE_SHIFT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP04_MATH_POW' => 180,
			'OP23_LOGICAL_AND' => 191,
			'OP13_BITWISE_AND' => 190
		}
	},
	{#State 362
		DEFAULT => -152
	},
	{#State 363
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP04_MATH_POW' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP13_BITWISE_AND' => 190,
			'OP23_LOGICAL_AND' => 191,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => 179,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => 189,
			")" => 376,
			'OP09_BITWISE_SHIFT' => 183,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP18_TERNARY' => 186
		}
	},
	{#State 364
		ACTIONS => {
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			"undef" => 100,
			'OP22_LOGICAL_NOT' => 106,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			"\@{" => 82,
			"%{" => 109,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'WORD_SCOPED' => 29,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'OP03_MATH_INC_DEC' => 91
		},
		GOTOS => {
			'HashReference' => 80,
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'Operator' => 72,
			'Literal' => 83,
			'Variable' => 125,
			'SubExpression' => 377,
			'HashDereferenced' => 84
		}
	},
	{#State 365
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 378
		}
	},
	{#State 366
		ACTIONS => {
			"\@_;" => 379
		}
	},
	{#State 367
		ACTIONS => {
			"\@{" => 82,
			"%{" => 109,
			'LITERAL_STRING' => 85,
			'WORD' => 30,
			'LITERAL_NUMBER' => 87,
			'OP01_NAMED' => 122,
			'WORD_SCOPED' => 29,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 75,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG' => 78,
			'LEFT_BRACKET' => 104,
			'OP22_LOGICAL_NOT' => 106
		},
		GOTOS => {
			'ArrayDereferenced' => 107,
			'Expression' => 124,
			'WordScoped' => 105,
			'ArrayReference' => 94,
			'HashReference' => 80,
			'Variable' => 125,
			'HashDereferenced' => 84,
			'SubExpression' => 380,
			'Operator' => 72,
			'Literal' => 83
		}
	},
	{#State 368
		ACTIONS => {
			'WORD' => 331,
			"%{" => 109
		},
		GOTOS => {
			'HashEntryTyped' => 381,
			'HashDereferenced' => 330
		}
	},
	{#State 369
		DEFAULT => -63
	},
	{#State 370
		ACTIONS => {
			";" => 382
		}
	},
	{#State 371
		ACTIONS => {
			'OP21_LIST_COMMA' => 385,
			")" => 383
		},
		GOTOS => {
			'PAREN-27' => 384
		}
	},
	{#State 372
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 373
		DEFAULT => -61
	},
	{#State 374
		DEFAULT => -160
	},
	{#State 375
		ACTIONS => {
			'LEFT_BRACE' => 273
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 376
		ACTIONS => {
			'LEFT_BRACE' => 273
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 377
		ACTIONS => {
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => 189,
			")" => -87,
			'OP14_BITWISE_OR_XOR' => 187,
			".." => -87,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP21_LIST_COMMA' => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP08_MATH_ADD_SUB' => 184,
			";" => -87,
			'OP18_TERNARY' => 186,
			'OP09_BITWISE_SHIFT' => 183,
			'OP06_REGEX_MATCH' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP11_COMPARE_LT_GT' => 181,
			'OP16_LOGICAL_OR' => 192,
			'OP04_MATH_POW' => 180,
			"}" => -87,
			'OP23_LOGICAL_AND' => -87,
			"]" => -87,
			'OP13_BITWISE_AND' => 190
		}
	},
	{#State 378
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 379
		DEFAULT => -50
	},
	{#State 380
		ACTIONS => {
			'OP13_BITWISE_AND' => 190,
			'OP23_LOGICAL_AND' => 191,
			'OP16_LOGICAL_OR' => 192,
			'OP11_COMPARE_LT_GT' => 181,
			'OP04_MATH_POW' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP06_REGEX_MATCH' => 193,
			'OP09_BITWISE_SHIFT' => 183,
			'OP24_LOGICAL_OR_XOR' => 185,
			'OP08_MATH_ADD_SUB' => 184,
			'OP18_TERNARY' => 186,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP12_COMPARE_EQ_NEQ' => 178,
			'OP17_LIST_RANGE' => 179,
			'OP21_LIST_COMMA' => -194,
			'OP08_STRING_CAT' => 188,
			'OP15_LOGICAL_AND' => 189,
			")" => -194
		}
	},
	{#State 381
		DEFAULT => -62
	},
	{#State 382
		DEFAULT => -65
	},
	{#State 383
		ACTIONS => {
			";" => 390
		}
	},
	{#State 384
		DEFAULT => -68
	},
	{#State 385
		ACTIONS => {
			'WORD' => 331,
			"%{" => 109
		},
		GOTOS => {
			'HashEntryTyped' => 391,
			'HashDereferenced' => 330
		}
	},
	{#State 386
		ACTIONS => {
			"= sub {" => 392
		}
	},
	{#State 387
		DEFAULT => -159
	},
	{#State 388
		DEFAULT => -149
	},
	{#State 389
		DEFAULT => -47
	},
	{#State 390
		DEFAULT => -70
	},
	{#State 391
		DEFAULT => -67
	},
	{#State 392
		ACTIONS => {
			"%{" => -72,
			"\@{" => -72,
			'WORD' => -72,
			"for my integer" => -72,
			'LITERAL_STRING' => -72,
			'OP03_MATH_INC_DEC' => -72,
			"foreach my" => -72,
			"my" => -72,
			'OP10_NAMED_UNARY_STRINGIFY' => -72,
			'LITERAL_NUMBER' => -72,
			"if (" => -72,
			'OP01_NAMED' => -72,
			'WORD_SCOPED' => -72,
			"while (" => -72,
			'OP01_NAMED_VOID' => -72,
			'OP01_CLOSE' => -72,
			'LEFT_PAREN' => -72,
			'OP01_PRINT' => -72,
			'LEFT_BRACE' => -72,
			'OP05_LOGICAL_NEG' => -72,
			"undef" => -72,
			'VARIABLE_SYMBOL' => -72,
			'OP01_OPEN' => -72,
			'OP19_LOOP_CONTROL' => -72,
			"( my" => 393,
			'LEFT_BRACKET' => -72,
			'OP10_NAMED_UNARY' => -72,
			'OP05_MATH_NEG' => -72,
			'OP22_LOGICAL_NOT' => -72
		},
		GOTOS => {
			'MethodArguments' => 395,
			'OPTIONAL-29' => 394
		}
	},
	{#State 393
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 396
		}
	},
	{#State 394
		ACTIONS => {
			'LITERAL_STRING' => 85,
			"for my integer" => -143,
			'WORD' => 86,
			"\@{" => 82,
			"%{" => 109,
			'LEFT_PAREN' => 93,
			'OP01_CLOSE' => 95,
			'OP01_NAMED_VOID' => 96,
			"while (" => -143,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 112,
			"my" => 89,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"if (" => 90,
			"foreach my" => -143,
			'OP03_MATH_INC_DEC' => 91,
			'OP19_LOOP_CONTROL' => 73,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 70,
			'LEFT_BRACE' => 99,
			'OP01_PRINT' => 98,
			'OP22_LOGICAL_NOT' => 106,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'LEFT_BRACKET' => 104
		},
		GOTOS => {
			'WordScoped' => 105,
			'ArrayDereferenced' => 107,
			'Expression' => 108,
			'OPTIONAL-39' => 81,
			'VariableDeclaration' => 77,
			'HashReference' => 80,
			'Statement' => 74,
			'VariableModification' => 101,
			'Variable' => 103,
			'OperatorVoid' => 97,
			'Operator' => 72,
			'LoopLabel' => 71,
			'ArrayReference' => 94,
			'Conditional' => 113,
			'PLUS-30' => 397,
			'PAREN-38' => 114,
			'HashDereferenced' => 84,
			'SubExpression' => 111,
			'Literal' => 83,
			'Operation' => 398
		}
	},
	{#State 395
		DEFAULT => -71
	},
	{#State 396
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 399
		}
	},
	{#State 397
		ACTIONS => {
			"while (" => -143,
			'OP01_NAMED_VOID' => 96,
			'OP01_CLOSE' => 95,
			'LEFT_PAREN' => 93,
			"foreach my" => -143,
			'OP03_MATH_INC_DEC' => 91,
			'WORD_SCOPED' => 29,
			'OP01_NAMED' => 112,
			'OP10_NAMED_UNARY_STRINGIFY' => 88,
			"if (" => 90,
			'LITERAL_NUMBER' => 87,
			"my" => 89,
			'WORD' => 86,
			'LITERAL_STRING' => 85,
			"for my integer" => -143,
			"%{" => 109,
			"\@{" => 82,
			'OP22_LOGICAL_NOT' => 106,
			'LEFT_BRACKET' => 104,
			'OP05_MATH_NEG' => 78,
			'OP10_NAMED_UNARY' => 76,
			'VARIABLE_SYMBOL' => 75,
			'OP01_OPEN' => 102,
			"}" => 400,
			'OP19_LOOP_CONTROL' => 73,
			"undef" => 100,
			'OP01_PRINT' => 98,
			'LEFT_BRACE' => 99,
			'OP05_LOGICAL_NEG' => 70
		},
		GOTOS => {
			'VariableModification' => 101,
			'Statement' => 74,
			'Variable' => 103,
			'OperatorVoid' => 97,
			'LoopLabel' => 71,
			'Operator' => 72,
			'WordScoped' => 105,
			'Expression' => 108,
			'OPTIONAL-39' => 81,
			'ArrayDereferenced' => 107,
			'VariableDeclaration' => 77,
			'HashReference' => 80,
			'HashDereferenced' => 84,
			'SubExpression' => 111,
			'Operation' => 401,
			'Literal' => 83,
			'ArrayReference' => 94,
			'Conditional' => 113,
			'PAREN-38' => 114
		}
	},
	{#State 398
		DEFAULT => -74
	},
	{#State 399
		ACTIONS => {
			'OP21_LIST_COMMA' => 402,
			")" => 403
		},
		GOTOS => {
			'PAREN-31' => 404
		}
	},
	{#State 400
		ACTIONS => {
			";" => 405
		}
	},
	{#State 401
		DEFAULT => -73
	},
	{#State 402
		ACTIONS => {
			"my" => 406
		}
	},
	{#State 403
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 404
		DEFAULT => -77
	},
	{#State 405
		DEFAULT => -75
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
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5732 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5739 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 120 "lib/RPerl/Grammar.eyp"
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
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5775 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5782 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5789 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5796 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5803 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5810 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 121 "lib/RPerl/Grammar.eyp"
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
#line 122 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 122 "lib/RPerl/Grammar.eyp"
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
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5917 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5931 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
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
#line 126 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5995 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 126 "lib/RPerl/Grammar.eyp"
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
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
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
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6067 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6074 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
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
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6113 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
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
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6152 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
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
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
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
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6262 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
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
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6301 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
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
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
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
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6731 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6738 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
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
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6821 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
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
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
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
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
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
#line 166 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 166 "lib/RPerl/Grammar.eyp"
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
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
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
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7336 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 2,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
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
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7412 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
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
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
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
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
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


#line 7901 lib/RPerl/Grammar.pm



1;
