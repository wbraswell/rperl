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

      m{\G(our\ \%properties_class\ \=\ \(|our\ \%properties\ \=\ \(|\#\#\ no\ critic\ qw\(|filehandle_ref|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|\=\ sub\ \{|while\ \(|elsif\ \(|\$TYPED_|package|undef|if\ \(|\(\ my|else|our|use|qw\(|\@_\;|my|\@\{|\%\{|\}|\]|\;|\))}gc and return ($1, $1);

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
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|eq|ne)/gc and return ('OP12_COMPARE_EQ_NEQ', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(chdir|rand|scalar[^t])/gc and return ('OP10_NAMED_UNARY', $1);
      /\G((?:main)?::[a-zA-Z]\w*__stringify\()/gc and return ('OP10_STRINGIFY_UNARY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(\+=|-=|\*=|\/=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LPAREN', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<=|>=|<|>|lt|gt|le|ge)/gc and return ('OP11_COMPARE_LT_GT', $1);
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
      /\G\(/gc and return ('LPAREN', $1);
      /\G\[/gc and return ('LBRACKET', $1);
      /\G\{/gc and return ('LBRACE', $1);


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
  [ 'Operator_84' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP01_OPEN', 'my', 'filehandle_ref', 'FH_REF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'OP01_CLOSE', 'FH_REF_SYMBOL' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP10_STRINGIFY_UNARY', 'SubExpression', ')' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NEQ', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'Variable', 'COLON', 'Variable' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'OP22_LOGICAL_NOT', 'SubExpression' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'PAREN-33' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-34', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'OPTIONAL-35', ';' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Expression_127' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-36', ')' ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', 'LPAREN', 'OPTIONAL-37', ')' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'LBRACE', '}' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_140' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_141' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_146' => 'Statement', [ 'OPTIONAL-39', 'Loop' ], 0 ],
  [ 'Statement_147' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_148' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'PAREN-40' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'PAREN-42' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'Conditional_156' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-41', 'OPTIONAL-43' ], 0 ],
  [ 'Loop_157' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_158' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_159' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_160' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_161' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_162' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'Operation' ], 0 ],
  [ 'CodeBlock_165' => 'CodeBlock', [ 'LBRACE', 'PLUS-44', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'Variable_168' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-45' ], 0 ],
  [ 'VariableRetrieval_169' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_170' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_171' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_172' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_173' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_174' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_175' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [ 'STAR-47', 'PAREN-46' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'PLUS-48', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'WORD' ], 0 ],
  [ 'ListElements_181' => 'ListElements', [ 'ListElement', 'STAR-47' ], 0 ],
  [ 'ListElements_182' => 'ListElements', [ 'OP01_QW', 'LPAREN', 'PLUS-48', ')' ], 0 ],
  [ 'ListElement_183' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_184' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_185' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'ArrayReference_188' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-49', ']' ], 0 ],
  [ 'ArrayDereferenced_189' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_190' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashEntry_193' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-50', 'SubExpression' ], 0 ],
  [ 'HashEntry_194' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_195' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_196' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'HashReference_200' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-52', '}' ], 0 ],
  [ 'HashDereferenced_201' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_202' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_203' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_204' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_205' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_206' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_207' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'Literal_208' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_209' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'Operator_112' => 112,
  '_PAREN' => 113,
  '_OPTIONAL' => 114,
  '_OPTIONAL' => 115,
  '_OPTIONAL' => 116,
  '_OPTIONAL' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  'Expression_127' => 127,
  'Expression_128' => 128,
  'Expression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpressionOrStdin_140' => 140,
  'SubExpressionOrStdin_141' => 141,
  '_PAREN' => 142,
  '_OPTIONAL' => 143,
  '_OPTIONAL' => 144,
  'Statement_145' => 145,
  'Statement_146' => 146,
  'Statement_147' => 147,
  'Statement_148' => 148,
  'Statement_149' => 149,
  '_PAREN' => 150,
  '_STAR_LIST' => 151,
  '_STAR_LIST' => 152,
  '_PAREN' => 153,
  '_OPTIONAL' => 154,
  '_OPTIONAL' => 155,
  'Conditional_156' => 156,
  'Loop_157' => 157,
  'Loop_158' => 158,
  'Loop_159' => 159,
  'LoopFor_160' => 160,
  'LoopForEach_161' => 161,
  'LoopWhile_162' => 162,
  '_PLUS_LIST' => 163,
  '_PLUS_LIST' => 164,
  'CodeBlock_165' => 165,
  '_STAR_LIST' => 166,
  '_STAR_LIST' => 167,
  'Variable_168' => 168,
  'VariableRetrieval_169' => 169,
  'VariableRetrieval_170' => 170,
  'VariableRetrieval_171' => 171,
  'VariableDeclaration_172' => 172,
  'VariableDeclaration_173' => 173,
  'VariableModification_174' => 174,
  'VariableModification_175' => 175,
  '_PAREN' => 176,
  '_STAR_LIST' => 177,
  '_STAR_LIST' => 178,
  '_PLUS_LIST' => 179,
  '_PLUS_LIST' => 180,
  'ListElements_181' => 181,
  'ListElements_182' => 182,
  'ListElement_183' => 183,
  'ListElement_184' => 184,
  'ListElement_185' => 185,
  '_OPTIONAL' => 186,
  '_OPTIONAL' => 187,
  'ArrayReference_188' => 188,
  'ArrayDereferenced_189' => 189,
  'ArrayDereferenced_190' => 190,
  '_OPTIONAL' => 191,
  '_OPTIONAL' => 192,
  'HashEntry_193' => 193,
  'HashEntry_194' => 194,
  'HashEntryTyped_195' => 195,
  'HashEntryTyped_196' => 196,
  '_PAREN' => 197,
  '_STAR_LIST' => 198,
  '_STAR_LIST' => 199,
  'HashReference_200' => 200,
  'HashDereferenced_201' => 201,
  'HashDereferenced_202' => 202,
  'WordScoped_203' => 203,
  'WordScoped_204' => 204,
  'LoopLabel_205' => 205,
  'Type_206' => 206,
  'TypeInner_207' => 207,
  'Literal_208' => 208,
  'Literal_209' => 209,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'( my' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
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
	LBRACE => { ISSEMANTIC => 1 },
	LBRACKET => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	LPAREN => { ISSEMANTIC => 1 },
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
	OP05_MATH_NEG_LPAREN => { ISSEMANTIC => 1 },
	OP06_REGEX_MATCH => { ISSEMANTIC => 1 },
	OP06_REGEX_PATTERN => { ISSEMANTIC => 1 },
	OP07_MATH_MULT_DIV_MOD => { ISSEMANTIC => 1 },
	OP08_MATH_ADD_SUB => { ISSEMANTIC => 1 },
	OP08_STRING_CAT => { ISSEMANTIC => 1 },
	OP09_BITWISE_SHIFT => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY => { ISSEMANTIC => 1 },
	OP10_STRINGIFY_UNARY => { ISSEMANTIC => 1 },
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
			"package" => -20,
			"## no critic qw(" => 9,
			'SHEBANG' => 5
		},
		GOTOS => {
			'PLUS-2' => 6,
			'ModuleHeader' => 7,
			'PAREN-1' => 2,
			'Program' => 1,
			'OPTIONAL-9' => 8,
			'Critic' => 3,
			'CompileUnit' => 4
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		ACTIONS => {
			'' => 10
		}
	},
	{#State 5
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'OPTIONAL-3' => 12,
			'Critic' => 11
		}
	},
	{#State 6
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 9,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 8,
			'Critic' => 3,
			'PAREN-1' => 13,
			'ModuleHeader' => 7
		}
	},
	{#State 7
		ACTIONS => {
			"use parent qw(" => 17,
			"our" => -25,
			"use" => -25,
			"## no critic qw(" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'Package' => 14,
			'STAR-10' => 15,
			'Class' => 16,
			'Module' => 18
		}
	},
	{#State 8
		ACTIONS => {
			"package" => 19
		}
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
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		ACTIONS => {
			"use constant" => -27,
			"## no critic qw(" => 9,
			"use" => -27,
			"our" => -27
		},
		GOTOS => {
			'Critic' => 25,
			'STAR-11' => 24
		}
	},
	{#State 16
		DEFAULT => -23
	},
	{#State 17
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		ACTIONS => {
			")" => 30,
			'WORD' => 31
		}
	},
	{#State 21
		DEFAULT => -35
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
		ACTIONS => {
			"use constant" => -29,
			"use" => 36,
			"our" => -29
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 34
		}
	},
	{#State 25
		DEFAULT => -24
	},
	{#State 26
		ACTIONS => {
			")" => 37
		}
	},
	{#State 27
		DEFAULT => -204
	},
	{#State 28
		DEFAULT => -203
	},
	{#State 29
		ACTIONS => {
			";" => 38
		}
	},
	{#State 30
		DEFAULT => -36
	},
	{#State 31
		DEFAULT => -34
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"undef" => -11,
			'VARIABLE_SYMBOL' => -11,
			'WORD_SCOPED' => -11,
			'OP01_PRINT' => -11,
			'LBRACKET' => -11,
			"while (" => -11,
			"%{" => -11,
			"\@{" => -11,
			"my" => -11,
			"our" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			"use" => -11,
			'OP03_MATH_INC_DEC' => -11,
			"foreach my" => -11,
			'OP22_LOGICAL_NOT' => -11,
			'OP01_NAMED' => -11,
			"## no critic qw(" => 9,
			'OP01_CLOSE' => -11,
			'LITERAL_STRING' => -11,
			'OP10_NAMED_UNARY' => -11,
			'WORD' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			"if (" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"for my integer" => -11,
			'OP01_OPEN' => -11,
			'LITERAL_NUMBER' => -11,
			'LPAREN' => -11,
			"use constant" => -11,
			'OP19_LOOP_CONTROL' => -11
		},
		GOTOS => {
			'STAR-5' => 40,
			'Critic' => 41
		}
	},
	{#State 34
		ACTIONS => {
			"our" => 46,
			"use constant" => 45
		},
		GOTOS => {
			'Constant' => 44,
			'Subroutine' => 43,
			'PLUS-13' => 42
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 47
		}
	},
	{#State 37
		ACTIONS => {
			";" => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 22
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
		ACTIONS => {
			"if (" => -13,
			'WORD' => -13,
			'LBRACE' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'LITERAL_STRING' => -13,
			'OP10_NAMED_UNARY' => -13,
			"use constant" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LPAREN' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_OPEN' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"for my integer" => -13,
			"my" => -13,
			"our" => -13,
			"while (" => -13,
			"\@{" => -13,
			"%{" => -13,
			'OP01_PRINT' => -13,
			'LBRACKET' => -13,
			'VARIABLE_SYMBOL' => -13,
			"undef" => -13,
			'WORD_SCOPED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"foreach my" => -13,
			'OP22_LOGICAL_NOT' => -13,
			'OP01_NAMED' => -13,
			"use" => 36,
			'OP01_NAMED_VOID' => -13,
			'OP10_STRINGIFY_UNARY' => -13
		},
		GOTOS => {
			'Include' => 51,
			'STAR-6' => 52
		}
	},
	{#State 41
		DEFAULT => -8
	},
	{#State 42
		ACTIONS => {
			'LITERAL_NUMBER' => 54,
			"our" => 46
		},
		GOTOS => {
			'Subroutine' => 53
		}
	},
	{#State 43
		DEFAULT => -31
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		ACTIONS => {
			'WORD' => 55
		}
	},
	{#State 46
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 47
		ACTIONS => {
			";" => 59,
			"qw(" => 58
		}
	},
	{#State 48
		ACTIONS => {
			"use" => 36
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
			'OP01_CLOSE' => -15,
			"undef" => -15,
			'VARIABLE_SYMBOL' => -15,
			'LITERAL_STRING' => -15,
			'OP10_NAMED_UNARY' => -15,
			'WORD_SCOPED' => -15,
			'WORD' => -15,
			'OP01_PRINT' => -15,
			'LBRACKET' => -15,
			'LBRACE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"while (" => -15,
			"if (" => -15,
			"\@{" => -15,
			"%{" => -15,
			"my" => -15,
			"our" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID' => -15,
			"for my integer" => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			'OP01_OPEN' => -15,
			'LITERAL_NUMBER' => -15,
			"foreach my" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LPAREN' => -15,
			'OP22_LOGICAL_NOT' => -15,
			'OP01_NAMED' => -15,
			"use constant" => 45,
			'OP19_LOOP_CONTROL' => -15
		},
		GOTOS => {
			'Constant' => 63,
			'STAR-7' => 62
		}
	},
	{#State 53
		DEFAULT => -30
	},
	{#State 54
		ACTIONS => {
			";" => 64
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 65
		}
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 57
		DEFAULT => -206
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
		ACTIONS => {
			"our" => 46,
			"my" => 89,
			"if (" => 114,
			"\@{" => 91,
			"%{" => 90,
			"while (" => -144,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'WORD' => 102,
			'OP01_PRINT' => 80,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'OP19_LOOP_CONTROL' => 96,
			'OP01_NAMED' => 79,
			'OP22_LOGICAL_NOT' => 78,
			"foreach my" => -144,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP10_STRINGIFY_UNARY' => 74,
			"for my integer" => -144,
			'OP01_NAMED_VOID' => 73,
			'OP05_LOGICAL_NEG' => 95
		},
		GOTOS => {
			'Conditional' => 112,
			'Subroutine' => 88,
			'LoopLabel' => 113,
			'HashReference' => 84,
			'PAREN-38' => 82,
			'Expression' => 81,
			'ArrayReference' => 110,
			'OPTIONAL-39' => 106,
			'HashDereferenced' => 109,
			'Variable' => 107,
			'VariableModification' => 87,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 75,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Statement' => 99,
			'Operation' => 70,
			'PLUS-8' => 71,
			'VariableDeclaration' => 72,
			'OperatorVoid' => 94
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		DEFAULT => -32
	},
	{#State 65
		ACTIONS => {
			"my" => 115
		},
		GOTOS => {
			'TypeInner' => 116
		}
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 117
		}
	},
	{#State 67
		DEFAULT => -38
	},
	{#State 68
		ACTIONS => {
			")" => 118,
			'WORD' => 119
		}
	},
	{#State 69
		ACTIONS => {
			"use constant" => -54,
			"## no critic qw(" => 9,
			"use" => -54,
			"our %properties = (" => -54
		},
		GOTOS => {
			'STAR-21' => 121,
			'Critic' => 120
		}
	},
	{#State 70
		DEFAULT => -17
	},
	{#State 71
		ACTIONS => {
			"my" => 89,
			"while (" => -144,
			"\@{" => 91,
			"%{" => 90,
			"if (" => 114,
			'OP01_PRINT' => 80,
			'WORD' => 102,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'VARIABLE_SYMBOL' => 85,
			'' => -18,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL' => 96,
			'LPAREN' => 98,
			"foreach my" => -144,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 79,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP01_NAMED_VOID' => 73,
			'OP05_LOGICAL_NEG' => 95,
			"for my integer" => -144,
			'OP10_STRINGIFY_UNARY' => 74
		},
		GOTOS => {
			'Statement' => 99,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'SubExpression' => 75,
			'Operator' => 76,
			'WordScoped' => 97,
			'Operation' => 122,
			'VariableDeclaration' => 72,
			'OperatorVoid' => 94,
			'LoopLabel' => 113,
			'Conditional' => 112,
			'OPTIONAL-39' => 106,
			'Variable' => 107,
			'HashDereferenced' => 109,
			'VariableModification' => 87,
			'ArrayReference' => 110,
			'Expression' => 81,
			'PAREN-38' => 82,
			'HashReference' => 84
		}
	},
	{#State 72
		DEFAULT => -148
	},
	{#State 73
		ACTIONS => {
			"\@{" => 91,
			"%{" => 90,
			"my" => 115,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			";" => -117,
			'KEYS_OR_VALUES' => 131,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_QW' => 124,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'ListElement' => 125,
			'SubExpression' => 126,
			'WordScoped' => 97,
			'Operator' => 76,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Expression' => 128,
			'HashReference' => 84,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'TypeInner' => 130,
			'ListElements' => 123,
			'ArrayReference' => 110,
			'OPTIONAL-35' => 129
		}
	},
	{#State 74
		ACTIONS => {
			"\@{" => 91,
			"%{" => 90,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 127,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74
		},
		GOTOS => {
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'HashReference' => 84,
			'Expression' => 128,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 133
		}
	},
	{#State 75
		ACTIONS => {
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP09_BITWISE_SHIFT' => 148,
			'OP04_MATH_POW' => 149,
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP23_LOGICAL_AND' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP06_REGEX_MATCH' => 138,
			'OP08_STRING_CAT' => 134,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP24_LOGICAL_OR_XOR' => 140
		}
	},
	{#State 76
		DEFAULT => -127
	},
	{#State 77
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'Variable' => 150
		}
	},
	{#State 78
		ACTIONS => {
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			"%{" => 90,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'SubExpression' => 151,
			'Operator' => 76,
			'WordScoped' => 97,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Expression' => 128,
			'HashReference' => 84,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'ArrayReference' => 110
		}
	},
	{#State 79
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'KEYS_OR_VALUES' => 131,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			"\@{" => 91,
			"%{" => 90,
			"my" => 115
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'TypeInner' => 130,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 153,
			'ListElement' => 152,
			'ArrayDereferenced' => 100,
			'Literal' => 101
		}
	},
	{#State 80
		ACTIONS => {
			"my" => -115,
			"%{" => -115,
			"\@{" => -115,
			'WORD' => -115,
			'OP05_MATH_NEG_LPAREN' => -115,
			'LBRACE' => -115,
			'FH_REF_SYMBOL_BRACES' => 157,
			'LBRACKET' => -115,
			'LITERAL_STRING' => -115,
			'VARIABLE_SYMBOL' => -115,
			"undef" => -115,
			'OP01_CLOSE' => -115,
			'WORD_SCOPED' => -115,
			'OP10_NAMED_UNARY' => -115,
			'KEYS_OR_VALUES' => -115,
			'OP22_LOGICAL_NOT' => -115,
			'OP03_MATH_INC_DEC' => -115,
			'LPAREN' => -115,
			'OP01_NAMED' => -115,
			'OP01_OPEN' => -115,
			'LITERAL_NUMBER' => -115,
			'STDOUT_STDERR' => 156,
			'OP05_LOGICAL_NEG' => -115,
			'OP01_QW' => -115,
			'OP10_STRINGIFY_UNARY' => -115
		},
		GOTOS => {
			'OPTIONAL-34' => 154,
			'PAREN-33' => 155
		}
	},
	{#State 81
		ACTIONS => {
			'OP23_LOGICAL_AND' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP12_COMPARE_EQ_NEQ' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP18_TERNARY' => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP08_STRING_CAT' => -130,
			";" => 158,
			'OP04_MATH_POW' => -130,
			'OP16_LOGICAL_OR' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP11_COMPARE_LT_GT' => -130,
			'OP15_LOGICAL_AND' => -130
		}
	},
	{#State 82
		DEFAULT => -143
	},
	{#State 83
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_QW' => 124,
			'OP10_STRINGIFY_UNARY' => 74,
			'KEYS_OR_VALUES' => 131,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'WORD' => 28,
			"]" => -187,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"my" => 115,
			"%{" => 90,
			"\@{" => 91
		},
		GOTOS => {
			'HashReference' => 84,
			'OPTIONAL-49' => 160,
			'Expression' => 128,
			'ArrayReference' => 110,
			'ListElements' => 159,
			'TypeInner' => 130,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 126,
			'ListElement' => 125,
			'Literal' => 101,
			'ArrayDereferenced' => 100
		}
	},
	{#State 84
		DEFAULT => -136
	},
	{#State 85
		DEFAULT => -167,
		GOTOS => {
			'STAR-45' => 161
		}
	},
	{#State 86
		DEFAULT => -131
	},
	{#State 87
		DEFAULT => -149
	},
	{#State 88
		DEFAULT => -14
	},
	{#State 89
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 162
		}
	},
	{#State 90
		ACTIONS => {
			'LBRACE' => 165,
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'Variable' => 164,
			'HashReference' => 163
		}
	},
	{#State 91
		ACTIONS => {
			'LBRACKET' => 83,
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'Variable' => 166,
			'ArrayReference' => 167
		}
	},
	{#State 92
		DEFAULT => -209
	},
	{#State 93
		ACTIONS => {
			"my" => 168
		}
	},
	{#State 94
		DEFAULT => -147
	},
	{#State 95
		ACTIONS => {
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			"%{" => 90,
			"\@{" => 91,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 127
		},
		GOTOS => {
			'Expression' => 128,
			'HashReference' => 84,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'ArrayReference' => 110,
			'SubExpression' => 169,
			'WordScoped' => 97,
			'Operator' => 76,
			'Literal' => 101,
			'ArrayDereferenced' => 100
		}
	},
	{#State 96
		ACTIONS => {
			'WORD' => 170
		},
		GOTOS => {
			'LoopLabel' => 171
		}
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 172
		}
	},
	{#State 98
		ACTIONS => {
			'OP01_PRINT' => 175,
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"\@{" => 91,
			"%{" => 90,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 173
		},
		GOTOS => {
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 174
		}
	},
	{#State 99
		DEFAULT => -83
	},
	{#State 100
		DEFAULT => -135
	},
	{#State 101
		DEFAULT => -132
	},
	{#State 102
		ACTIONS => {
			'LPAREN' => -203,
			'COLON' => -205
		}
	},
	{#State 103
		ACTIONS => {
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			"%{" => 90,
			"\@{" => 91,
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 176,
			'Literal' => 101,
			'ArrayDereferenced' => 100
		}
	},
	{#State 104
		ACTIONS => {
			'WORD' => 177,
			"%{" => 90,
			"}" => 180
		},
		GOTOS => {
			'HashDereferenced' => 178,
			'HashEntry' => 179
		}
	},
	{#State 105
		ACTIONS => {
			'FH_REF_SYMBOL' => 181
		}
	},
	{#State 106
		ACTIONS => {
			"for my integer" => 182,
			"foreach my" => 185,
			"while (" => 188
		},
		GOTOS => {
			'Loop' => 184,
			'LoopForEach' => 186,
			'LoopWhile' => 187,
			'LoopFor' => 183
		}
	},
	{#State 107
		ACTIONS => {
			'OP08_STRING_CAT' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP18_TERNARY' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP23_LOGICAL_AND' => -133,
			'OP19_VARIABLE_ASSIGN' => 189,
			'OP06_REGEX_MATCH' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP12_COMPARE_EQ_NEQ' => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP11_COMPARE_LT_GT' => -133,
			'OP17_LIST_RANGE' => -133,
			'OP16_LOGICAL_OR' => -133,
			'OP19_VARIABLE_ASSIGN_BY' => 191,
			'OP03_MATH_INC_DEC' => 190,
			'OP09_BITWISE_SHIFT' => -133,
			'OP02_METHOD_THINARROW' => 192,
			'OP04_MATH_POW' => -133
		}
	},
	{#State 108
		DEFAULT => -208
	},
	{#State 109
		DEFAULT => -137
	},
	{#State 110
		DEFAULT => -134
	},
	{#State 111
		ACTIONS => {
			'LPAREN' => 98,
			")" => -100,
			'OP05_LOGICAL_NEG' => 95,
			'OP11_COMPARE_LT_GT' => -100,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP13_BITWISE_AND' => -100,
			'OP06_REGEX_MATCH' => -100,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			'OP08_STRING_CAT' => -100,
			'OP01_CLOSE' => 105,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			"]" => -100,
			'WORD' => 28,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			"}" => -100,
			'OP03_MATH_INC_DEC' => 77,
			'OP09_BITWISE_SHIFT' => -100,
			'OP04_MATH_POW' => -100,
			";" => -100,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP15_LOGICAL_AND' => -100,
			"\@{" => 91,
			"%{" => 90,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => -100,
			'OP12_COMPARE_EQ_NEQ' => -100,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'LBRACKET' => 83,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100
		},
		GOTOS => {
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 193
		}
	},
	{#State 112
		DEFAULT => -145
	},
	{#State 113
		ACTIONS => {
			'COLON' => 194
		}
	},
	{#State 114
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 127,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'LITERAL_STRING' => 108,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			"%{" => 90,
			"\@{" => 91
		},
		GOTOS => {
			'Expression' => 128,
			'HashReference' => 84,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'ArrayReference' => 110,
			'SubExpression' => 195,
			'WordScoped' => 97,
			'Operator' => 76,
			'Literal' => 101,
			'ArrayDereferenced' => 100
		}
	},
	{#State 115
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 196
		}
	},
	{#State 116
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'Literal' => 197
		}
	},
	{#State 117
		ACTIONS => {
			'LBRACE' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LBRACKET' => -43,
			'OP01_PRINT' => -43,
			'WORD' => -43,
			"( my" => 200,
			'WORD_SCOPED' => -43,
			'OP10_NAMED_UNARY' => -43,
			'LITERAL_STRING' => -43,
			"undef" => -43,
			'OP01_CLOSE' => -43,
			'VARIABLE_SYMBOL' => -43,
			"my" => -43,
			"%{" => -43,
			"if (" => -43,
			"\@{" => -43,
			"while (" => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_OPEN' => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			"for my integer" => -43,
			'OP01_NAMED_VOID' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP01_NAMED' => -43,
			'OP22_LOGICAL_NOT' => -43,
			'LPAREN' => -43,
			"foreach my" => -43,
			'OP03_MATH_INC_DEC' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 199,
			'OPTIONAL-16' => 198
		}
	},
	{#State 118
		ACTIONS => {
			";" => 201
		}
	},
	{#State 119
		DEFAULT => -37
	},
	{#State 120
		DEFAULT => -51
	},
	{#State 121
		ACTIONS => {
			"our %properties = (" => -56,
			"use" => 36,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 203,
			'STAR-22' => 202
		}
	},
	{#State 122
		DEFAULT => -16
	},
	{#State 123
		DEFAULT => -116
	},
	{#State 124
		ACTIONS => {
			'LPAREN' => 204
		}
	},
	{#State 125
		DEFAULT => -178,
		GOTOS => {
			'STAR-47' => 205
		}
	},
	{#State 126
		ACTIONS => {
			'OP08_STRING_CAT' => 134,
			"]" => -183,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP21_LIST_COMMA' => -183,
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP23_LOGICAL_AND' => 142,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			")" => -183,
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP04_MATH_POW' => 149,
			";" => -183
		}
	},
	{#State 127
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 127,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			"\@{" => 91,
			"%{" => 90,
			'LITERAL_STRING' => 108,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'WORD' => 28,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83
		},
		GOTOS => {
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 206
		}
	},
	{#State 128
		DEFAULT => -130
	},
	{#State 129
		ACTIONS => {
			";" => 207
		}
	},
	{#State 130
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			"%{" => 90,
			"\@{" => 91,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127
		},
		GOTOS => {
			'SubExpression' => 208,
			'WordScoped' => 97,
			'Operator' => 76,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Expression' => 128,
			'HashReference' => 84,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'ArrayReference' => 110
		}
	},
	{#State 131
		ACTIONS => {
			"%{" => 90
		},
		GOTOS => {
			'HashDereferenced' => 209
		}
	},
	{#State 132
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -133,
			"}" => -133,
			'OP03_MATH_INC_DEC' => 190,
			'OP16_LOGICAL_OR' => -133,
			'OP17_LIST_RANGE' => -133,
			'OP04_MATH_POW' => -133,
			";" => -133,
			'OP02_METHOD_THINARROW' => 192,
			")" => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP11_COMPARE_LT_GT' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP12_COMPARE_EQ_NEQ' => -133,
			'OP23_LOGICAL_AND' => -133,
			'OP08_STRING_CAT' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP21_LIST_COMMA' => -133,
			'OP18_TERNARY' => -133,
			'OP08_MATH_ADD_SUB' => -133,
			"]" => -133
		}
	},
	{#State 133
		ACTIONS => {
			'OP04_MATH_POW' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145,
			")" => 210,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138,
			'OP23_LOGICAL_AND' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_STRING_CAT' => 134
		}
	},
	{#State 134
		ACTIONS => {
			"%{" => 90,
			"\@{" => 91,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83,
			'WORD' => 28,
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'SubExpression' => 211,
			'WordScoped' => 97,
			'Operator' => 76,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'ArrayReference' => 110,
			'Expression' => 128,
			'HashReference' => 84
		}
	},
	{#State 135
		ACTIONS => {
			"%{" => 90,
			"\@{" => 91,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 212,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'HashReference' => 84,
			'Expression' => 128
		}
	},
	{#State 136
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'Variable' => 213
		}
	},
	{#State 137
		ACTIONS => {
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'LITERAL_STRING' => 108,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			"%{" => 90,
			"\@{" => 91,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 127
		},
		GOTOS => {
			'SubExpression' => 214,
			'WordScoped' => 97,
			'Operator' => 76,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Expression' => 128,
			'HashReference' => 84,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'ArrayReference' => 110
		}
	},
	{#State 138
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 215
		}
	},
	{#State 139
		ACTIONS => {
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			"%{" => 90,
			"\@{" => 91,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127
		},
		GOTOS => {
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 216
		}
	},
	{#State 140
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'WORD' => 28,
			"\@{" => 91,
			"%{" => 90
		},
		GOTOS => {
			'ArrayReference' => 110,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'HashReference' => 84,
			'Expression' => 128,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 217
		}
	},
	{#State 141
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			"%{" => 90,
			"\@{" => 91,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127
		},
		GOTOS => {
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 218,
			'ArrayReference' => 110,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'HashReference' => 84,
			'Expression' => 128
		}
	},
	{#State 142
		ACTIONS => {
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			"\@{" => 91,
			"%{" => 90,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 219,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'Variable' => 132,
			'HashDereferenced' => 109
		}
	},
	{#State 143
		ACTIONS => {
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD' => 28,
			"%{" => 90,
			"\@{" => 91,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 220,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'Variable' => 132,
			'HashDereferenced' => 109
		}
	},
	{#State 144
		ACTIONS => {
			"\@{" => 91,
			"%{" => 90,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'WORD' => 28,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 127,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 221,
			'ArrayReference' => 110,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'HashReference' => 84,
			'Expression' => 128
		}
	},
	{#State 145
		ACTIONS => {
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED' => 127,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP22_LOGICAL_NOT' => 78,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			"\@{" => 91,
			"%{" => 90
		},
		GOTOS => {
			'HashDereferenced' => 109,
			'Variable' => 132,
			'ArrayReference' => 110,
			'Expression' => 128,
			'HashReference' => 84,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'SubExpression' => 222,
			'Operator' => 76,
			'WordScoped' => 97
		}
	},
	{#State 146
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'WORD' => 28,
			"\@{" => 91,
			"%{" => 90
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 223,
			'Literal' => 101,
			'ArrayDereferenced' => 100
		}
	},
	{#State 147
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"%{" => 90,
			"\@{" => 91
		},
		GOTOS => {
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 224
		}
	},
	{#State 148
		ACTIONS => {
			"\@{" => 91,
			"%{" => 90,
			'WORD' => 28,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 225,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132
		}
	},
	{#State 149
		ACTIONS => {
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			"%{" => 90,
			"\@{" => 91,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83,
			'WORD' => 28
		},
		GOTOS => {
			'ArrayReference' => 110,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 226
		}
	},
	{#State 150
		DEFAULT => -89
	},
	{#State 151
		ACTIONS => {
			")" => -110,
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -110,
			'OP04_MATH_POW' => 149,
			";" => -110,
			'OP08_STRING_CAT' => 134,
			"]" => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP21_LIST_COMMA' => -110,
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP23_LOGICAL_AND' => -110,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143
		}
	},
	{#State 152
		ACTIONS => {
			'OP21_LIST_COMMA' => 227
		}
	},
	{#State 153
		ACTIONS => {
			'OP16_LOGICAL_OR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP04_MATH_POW' => -85,
			";" => -85,
			")" => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP08_STRING_CAT' => -85,
			'OP21_LIST_COMMA' => -183,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP18_TERNARY' => -85
		}
	},
	{#State 154
		ACTIONS => {
			"%{" => 90,
			"\@{" => 91,
			"my" => 115,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'LITERAL_STRING' => 108,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD' => 28,
			'OP01_NAMED' => 127,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP22_LOGICAL_NOT' => 78,
			'KEYS_OR_VALUES' => 131,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_QW' => 124,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'ListElement' => 125,
			'SubExpression' => 126,
			'WordScoped' => 97,
			'Operator' => 76,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Expression' => 128,
			'HashReference' => 84,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'TypeInner' => 130,
			'ListElements' => 228,
			'ArrayReference' => 110
		}
	},
	{#State 155
		DEFAULT => -114
	},
	{#State 156
		DEFAULT => -113
	},
	{#State 157
		ACTIONS => {
			'KEYS_OR_VALUES' => 131,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_QW' => 124,
			'OP05_LOGICAL_NEG' => 95,
			"my" => 115,
			"\@{" => 91,
			"%{" => 90,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'TypeInner' => 130,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'ListElements' => 229,
			'WordScoped' => 97,
			'Operator' => 76,
			'ListElement' => 125,
			'SubExpression' => 126,
			'Literal' => 101,
			'ArrayDereferenced' => 100
		}
	},
	{#State 158
		DEFAULT => -82
	},
	{#State 159
		DEFAULT => -186
	},
	{#State 160
		ACTIONS => {
			"]" => 230
		}
	},
	{#State 161
		ACTIONS => {
			"]" => -168,
			'COLON' => -168,
			'OP18_TERNARY' => -168,
			'OP08_MATH_ADD_SUB' => -168,
			'OP24_LOGICAL_OR_XOR' => -168,
			'OP21_LIST_COMMA' => -168,
			'OP02_HASH_THINARROW' => 231,
			'OP08_STRING_CAT' => -168,
			'OP19_VARIABLE_ASSIGN' => -168,
			'OP23_LOGICAL_AND' => -168,
			'OP02_ARRAY_THINARROW' => 233,
			'OP07_MATH_MULT_DIV_MOD' => -168,
			'OP12_COMPARE_EQ_NEQ' => -168,
			'OP06_REGEX_MATCH' => -168,
			'OP14_BITWISE_OR_XOR' => -168,
			'OP13_BITWISE_AND' => -168,
			'OP11_COMPARE_LT_GT' => -168,
			'OP15_LOGICAL_AND' => -168,
			")" => -168,
			'OP02_METHOD_THINARROW' => -168,
			";" => -168,
			'OP04_MATH_POW' => -168,
			'OP19_VARIABLE_ASSIGN_BY' => -168,
			'OP17_LIST_RANGE' => -168,
			'OP16_LOGICAL_OR' => -168,
			'OP09_BITWISE_SHIFT' => -168,
			"}" => -168,
			'OP03_MATH_INC_DEC' => -168
		},
		GOTOS => {
			'VariableRetrieval' => 232
		}
	},
	{#State 162
		ACTIONS => {
			'VARIABLE_SYMBOL' => 234
		}
	},
	{#State 163
		ACTIONS => {
			"}" => 235
		}
	},
	{#State 164
		ACTIONS => {
			"}" => 236
		}
	},
	{#State 165
		ACTIONS => {
			'WORD' => 177,
			"%{" => 90
		},
		GOTOS => {
			'HashEntry' => 179,
			'HashDereferenced' => 178
		}
	},
	{#State 166
		ACTIONS => {
			"}" => 237
		}
	},
	{#State 167
		ACTIONS => {
			"}" => 238
		}
	},
	{#State 168
		ACTIONS => {
			"filehandle_ref" => 239
		}
	},
	{#State 169
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP12_COMPARE_EQ_NEQ' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			"]" => -92,
			'OP08_STRING_CAT' => -92,
			";" => -92,
			'OP04_MATH_POW' => 149,
			'OP09_BITWISE_SHIFT' => -92,
			"}" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP15_LOGICAL_AND' => -92,
			")" => -92
		}
	},
	{#State 170
		DEFAULT => -205
	},
	{#State 171
		ACTIONS => {
			";" => 240
		}
	},
	{#State 172
		ACTIONS => {
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'KEYS_OR_VALUES' => 131,
			'OP05_LOGICAL_NEG' => 95,
			")" => -124,
			'OP01_QW' => 124,
			'OP10_STRINGIFY_UNARY' => 74,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			"\@{" => 91,
			"%{" => 90,
			"my" => 115,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'OPTIONAL-36' => 241,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'TypeInner' => 130,
			'ListElements' => 242,
			'WordScoped' => 97,
			'Operator' => 76,
			'ListElement' => 125,
			'SubExpression' => 126,
			'ArrayDereferenced' => 100,
			'Literal' => 101
		}
	},
	{#State 173
		ACTIONS => {
			'KEYS_OR_VALUES' => 131,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 127,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			"my" => 115,
			"\@{" => 91,
			"%{" => 90,
			'WORD' => 28,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111
		},
		GOTOS => {
			'SubExpression' => 153,
			'ListElement' => 243,
			'Operator' => 76,
			'WordScoped' => 97,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Expression' => 128,
			'HashReference' => 84,
			'TypeInner' => 130,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'ArrayReference' => 110
		}
	},
	{#State 174
		ACTIONS => {
			'OP04_MATH_POW' => 149,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 139,
			")" => 244,
			'OP15_LOGICAL_AND' => 145,
			'OP23_LOGICAL_AND' => 142,
			'OP06_REGEX_MATCH' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP08_STRING_CAT' => 134
		}
	},
	{#State 175
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 245
		}
	},
	{#State 176
		ACTIONS => {
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_STRING_CAT' => 134,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138,
			'OP23_LOGICAL_AND' => 142,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145,
			")" => 246,
			'OP04_MATH_POW' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147
		}
	},
	{#State 177
		ACTIONS => {
			'OP20_HASH_FATARROW' => 247
		}
	},
	{#State 178
		DEFAULT => -194
	},
	{#State 179
		DEFAULT => -199,
		GOTOS => {
			'STAR-52' => 248
		}
	},
	{#State 180
		DEFAULT => -138
	},
	{#State 181
		DEFAULT => -88
	},
	{#State 182
		ACTIONS => {
			'VARIABLE_SYMBOL' => 249
		}
	},
	{#State 183
		DEFAULT => -157
	},
	{#State 184
		DEFAULT => -146
	},
	{#State 185
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 250
		}
	},
	{#State 186
		DEFAULT => -158
	},
	{#State 187
		DEFAULT => -159
	},
	{#State 188
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 127,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			"%{" => 90,
			"\@{" => 91,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111
		},
		GOTOS => {
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 251,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132
		}
	},
	{#State 189
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 108,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD' => 28,
			"\@{" => 91,
			"%{" => 90,
			'STDIN' => 253
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 252,
			'SubExpressionOrStdin' => 254,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132
		}
	},
	{#State 190
		DEFAULT => -90
	},
	{#State 191
		ACTIONS => {
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'LITERAL_STRING' => 108,
			"%{" => 90,
			"\@{" => 91
		},
		GOTOS => {
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 255,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132
		}
	},
	{#State 192
		ACTIONS => {
			'WORD' => 256
		}
	},
	{#State 193
		ACTIONS => {
			'OP04_MATH_POW' => 149,
			";" => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP17_LIST_RANGE' => -99,
			"}" => -99,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => -99,
			")" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			"]" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP18_TERNARY' => -99,
			'OP08_MATH_ADD_SUB' => 135,
			'OP08_STRING_CAT' => 134
		}
	},
	{#State 194
		DEFAULT => -142
	},
	{#State 195
		ACTIONS => {
			")" => 257,
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139,
			'OP09_BITWISE_SHIFT' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP04_MATH_POW' => 149,
			'OP08_STRING_CAT' => 134,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 142
		}
	},
	{#State 196
		ACTIONS => {
			"\$TYPED_" => 258
		}
	},
	{#State 197
		ACTIONS => {
			";" => 259
		}
	},
	{#State 198
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'WORD' => 102,
			'OP01_PRINT' => 80,
			"if (" => 114,
			"%{" => 90,
			"\@{" => 91,
			"while (" => -144,
			"my" => 89,
			'OP10_STRINGIFY_UNARY' => 74,
			"for my integer" => -144,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED_VOID' => 73,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP01_NAMED' => 79,
			'OP22_LOGICAL_NOT' => 78,
			'OP03_MATH_INC_DEC' => 77,
			"foreach my" => -144,
			'LPAREN' => 98,
			'OP19_LOOP_CONTROL' => 96
		},
		GOTOS => {
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 107,
			'VariableModification' => 87,
			'OPTIONAL-39' => 106,
			'HashReference' => 84,
			'PAREN-38' => 82,
			'Expression' => 81,
			'LoopLabel' => 113,
			'Conditional' => 112,
			'VariableDeclaration' => 72,
			'OperatorVoid' => 94,
			'Operation' => 261,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Statement' => 99,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 75,
			'PLUS-17' => 260
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
			'Type' => 262
		}
	},
	{#State 201
		DEFAULT => -40
	},
	{#State 202
		ACTIONS => {
			"our %properties = (" => 265,
			"use constant" => 45
		},
		GOTOS => {
			'Properties' => 263,
			'Constant' => 264
		}
	},
	{#State 203
		DEFAULT => -53
	},
	{#State 204
		ACTIONS => {
			'WORD' => 267
		},
		GOTOS => {
			'PLUS-48' => 266
		}
	},
	{#State 205
		ACTIONS => {
			'OP21_LIST_COMMA' => 268,
			";" => -181,
			"]" => -181,
			")" => -181
		},
		GOTOS => {
			'PAREN-46' => 269
		}
	},
	{#State 206
		ACTIONS => {
			")" => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			"}" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP04_MATH_POW' => -85,
			";" => -85,
			'OP08_STRING_CAT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP18_TERNARY' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			"]" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP12_COMPARE_EQ_NEQ' => -85,
			'OP23_LOGICAL_AND' => -85
		}
	},
	{#State 207
		DEFAULT => -120
	},
	{#State 208
		ACTIONS => {
			'OP23_LOGICAL_AND' => 142,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			"]" => -184,
			'OP21_LIST_COMMA' => -184,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP08_STRING_CAT' => 134,
			'OP04_MATH_POW' => 149,
			";" => -184,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 139,
			")" => -184,
			'OP15_LOGICAL_AND' => 145
		}
	},
	{#State 209
		DEFAULT => -185
	},
	{#State 210
		DEFAULT => -101
	},
	{#State 211
		ACTIONS => {
			'OP04_MATH_POW' => 149,
			";" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP17_LIST_RANGE' => -97,
			"}" => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			")" => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			"]" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP18_TERNARY' => -97,
			'OP08_MATH_ADD_SUB' => 135,
			'OP08_STRING_CAT' => -97
		}
	},
	{#State 212
		ACTIONS => {
			'OP13_BITWISE_AND' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP12_COMPARE_EQ_NEQ' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138,
			'OP23_LOGICAL_AND' => -96,
			'OP08_STRING_CAT' => -96,
			'OP18_TERNARY' => -96,
			'OP08_MATH_ADD_SUB' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			"]" => -96,
			"}" => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP17_LIST_RANGE' => -96,
			";" => -96,
			'OP04_MATH_POW' => 149,
			'OP15_LOGICAL_AND' => -96,
			")" => -96,
			'OP11_COMPARE_LT_GT' => -96
		}
	},
	{#State 213
		ACTIONS => {
			'COLON' => 270
		}
	},
	{#State 214
		ACTIONS => {
			'OP15_LOGICAL_AND' => -104,
			")" => -104,
			'OP11_COMPARE_LT_GT' => 139,
			'OP16_LOGICAL_OR' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -104,
			";" => -104,
			'OP04_MATH_POW' => 149,
			'OP08_STRING_CAT' => 134,
			"]" => -104,
			'OP18_TERNARY' => -104,
			'OP08_MATH_ADD_SUB' => 135,
			'OP21_LIST_COMMA' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP13_BITWISE_AND' => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138
		}
	},
	{#State 215
		DEFAULT => -94
	},
	{#State 216
		ACTIONS => {
			'OP13_BITWISE_AND' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => -102,
			'OP08_STRING_CAT' => 134,
			"]" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 135,
			'OP16_LOGICAL_OR' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -102,
			'OP04_MATH_POW' => 149,
			";" => -102,
			")" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP11_COMPARE_LT_GT' => undef
		}
	},
	{#State 217
		ACTIONS => {
			"}" => -112,
			'OP09_BITWISE_SHIFT' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP04_MATH_POW' => 149,
			";" => -112,
			")" => -112,
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP08_STRING_CAT' => 134,
			'OP21_LIST_COMMA' => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			"]" => -112
		}
	},
	{#State 218
		ACTIONS => {
			'OP08_STRING_CAT' => 134,
			"]" => -105,
			'OP18_TERNARY' => -105,
			'OP08_MATH_ADD_SUB' => 135,
			'OP21_LIST_COMMA' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			'OP13_BITWISE_AND' => 137,
			'OP23_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138,
			'OP15_LOGICAL_AND' => -105,
			")" => -105,
			'OP11_COMPARE_LT_GT' => 139,
			'OP17_LIST_RANGE' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -105,
			";" => -105,
			'OP04_MATH_POW' => 149
		}
	},
	{#State 219
		ACTIONS => {
			'OP15_LOGICAL_AND' => 145,
			")" => -111,
			'OP11_COMPARE_LT_GT' => 139,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -111,
			";" => -111,
			'OP04_MATH_POW' => 149,
			'OP08_STRING_CAT' => 134,
			"]" => -111,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP24_LOGICAL_OR_XOR' => -111,
			'OP21_LIST_COMMA' => -111,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP23_LOGICAL_AND' => -111,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138
		}
	},
	{#State 220
		ACTIONS => {
			";" => -103,
			'OP04_MATH_POW' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => -103,
			")" => -103,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138,
			'OP23_LOGICAL_AND' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP18_TERNARY' => -103,
			'OP08_MATH_ADD_SUB' => 135,
			'OP21_LIST_COMMA' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			"]" => -103,
			'OP08_STRING_CAT' => 134
		}
	},
	{#State 221
		ACTIONS => {
			"}" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP17_LIST_RANGE' => -95,
			";" => -95,
			'OP04_MATH_POW' => 149,
			'OP15_LOGICAL_AND' => -95,
			")" => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP12_COMPARE_EQ_NEQ' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP06_REGEX_MATCH' => 138,
			'OP23_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95,
			'OP18_TERNARY' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP21_LIST_COMMA' => -95,
			"]" => -95
		}
	},
	{#State 222
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 139,
			")" => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 149,
			";" => -106,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -106,
			'OP17_LIST_RANGE' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => -106,
			"]" => -106,
			'OP08_STRING_CAT' => 134,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => -106,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141
		}
	},
	{#State 223
		ACTIONS => {
			"]" => -108,
			'OP18_TERNARY' => -108,
			'OP08_MATH_ADD_SUB' => 135,
			'OP21_LIST_COMMA' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP08_STRING_CAT' => 134,
			'OP23_LOGICAL_AND' => -108,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145,
			")" => -108,
			";" => -108,
			'OP04_MATH_POW' => 149,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 147,
			"}" => -108,
			'OP09_BITWISE_SHIFT' => 148
		}
	},
	{#State 224
		ACTIONS => {
			'OP17_LIST_RANGE' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -107,
			'OP04_MATH_POW' => 149,
			";" => -107,
			")" => -107,
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP23_LOGICAL_AND' => -107,
			'OP06_REGEX_MATCH' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP08_STRING_CAT' => 134,
			"]" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP21_LIST_COMMA' => -107,
			'OP18_TERNARY' => -107,
			'OP08_MATH_ADD_SUB' => 135
		}
	},
	{#State 225
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -98,
			'OP15_LOGICAL_AND' => -98,
			")" => -98,
			";" => -98,
			'OP04_MATH_POW' => 149,
			'OP16_LOGICAL_OR' => -98,
			'OP17_LIST_RANGE' => -98,
			"}" => -98,
			'OP09_BITWISE_SHIFT' => -98,
			"]" => -98,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_STRING_CAT' => 134,
			'OP23_LOGICAL_AND' => -98,
			'OP12_COMPARE_EQ_NEQ' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP06_REGEX_MATCH' => 138,
			'OP13_BITWISE_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98
		}
	},
	{#State 226
		ACTIONS => {
			'OP04_MATH_POW' => 149,
			";" => -91,
			'OP09_BITWISE_SHIFT' => -91,
			"}" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			")" => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP12_COMPARE_EQ_NEQ' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP18_TERNARY' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			"]" => -91,
			'OP08_STRING_CAT' => -91
		}
	},
	{#State 227
		ACTIONS => {
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'WORD' => 28,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83,
			"%{" => 90,
			"\@{" => 91,
			"my" => 115,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_QW' => 124,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP22_LOGICAL_NOT' => 78,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP01_NAMED' => 127,
			'KEYS_OR_VALUES' => 131
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'TypeInner' => 130,
			'ListElements' => 271,
			'WordScoped' => 97,
			'Operator' => 76,
			'ListElement' => 125,
			'SubExpression' => 126,
			'ArrayDereferenced' => 100,
			'Literal' => 101
		}
	},
	{#State 228
		ACTIONS => {
			";" => 272
		}
	},
	{#State 229
		ACTIONS => {
			";" => 273
		}
	},
	{#State 230
		DEFAULT => -188
	},
	{#State 231
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'WORD' => 275,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 108,
			"\@{" => 91,
			"%{" => 90
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 274,
			'ArrayDereferenced' => 100,
			'Literal' => 101
		}
	},
	{#State 232
		DEFAULT => -166
	},
	{#State 233
		ACTIONS => {
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'LITERAL_STRING' => 108,
			"%{" => 90,
			"\@{" => 91
		},
		GOTOS => {
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 276,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132
		}
	},
	{#State 234
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 277,
			";" => 278
		}
	},
	{#State 235
		DEFAULT => -202
	},
	{#State 236
		DEFAULT => -201
	},
	{#State 237
		DEFAULT => -189
	},
	{#State 238
		DEFAULT => -190
	},
	{#State 239
		ACTIONS => {
			'FH_REF_SYMBOL' => 279
		}
	},
	{#State 240
		DEFAULT => -122
	},
	{#State 241
		ACTIONS => {
			")" => 280
		}
	},
	{#State 242
		DEFAULT => -123
	},
	{#State 243
		ACTIONS => {
			'OP21_LIST_COMMA' => 281
		}
	},
	{#State 244
		DEFAULT => -139
	},
	{#State 245
		ACTIONS => {
			'OP01_QW' => 124,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'KEYS_OR_VALUES' => 131,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD' => 28,
			"%{" => 90,
			"\@{" => 91,
			"my" => 115
		},
		GOTOS => {
			'ListElement' => 125,
			'SubExpression' => 126,
			'WordScoped' => 97,
			'Operator' => 76,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Expression' => 128,
			'HashReference' => 84,
			'TypeInner' => 130,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'ListElements' => 282,
			'ArrayReference' => 110
		}
	},
	{#State 246
		DEFAULT => -93
	},
	{#State 247
		ACTIONS => {
			'OP01_CLOSE' => -192,
			"undef" => -192,
			'VARIABLE_SYMBOL' => -192,
			'LITERAL_STRING' => -192,
			'OP10_NAMED_UNARY' => -192,
			'WORD_SCOPED' => -192,
			'WORD' => -192,
			'LBRACKET' => -192,
			'LBRACE' => -192,
			'OP05_MATH_NEG_LPAREN' => -192,
			"%{" => -192,
			"\@{" => -192,
			"my" => 115,
			'OP05_LOGICAL_NEG' => -192,
			'OP10_STRINGIFY_UNARY' => -192,
			'OP01_OPEN' => -192,
			'LITERAL_NUMBER' => -192,
			'OP03_MATH_INC_DEC' => -192,
			'LPAREN' => -192,
			'OP22_LOGICAL_NOT' => -192,
			'OP01_NAMED' => -192
		},
		GOTOS => {
			'TypeInner' => 284,
			'OPTIONAL-50' => 283
		}
	},
	{#State 248
		ACTIONS => {
			"}" => 286,
			'OP21_LIST_COMMA' => 287
		},
		GOTOS => {
			'PAREN-51' => 285
		}
	},
	{#State 249
		ACTIONS => {
			'LPAREN' => 288
		}
	},
	{#State 250
		ACTIONS => {
			'VARIABLE_SYMBOL' => 289
		}
	},
	{#State 251
		ACTIONS => {
			'OP04_MATH_POW' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP11_COMPARE_LT_GT' => 139,
			")" => 290,
			'OP15_LOGICAL_AND' => 145,
			'OP06_REGEX_MATCH' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 142,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP08_STRING_CAT' => 134
		}
	},
	{#State 252
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP08_STRING_CAT' => 134,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => 142,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 149,
			";" => -140,
			'OP09_BITWISE_SHIFT' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146
		}
	},
	{#State 253
		DEFAULT => -141
	},
	{#State 254
		ACTIONS => {
			";" => 291
		}
	},
	{#State 255
		ACTIONS => {
			'OP04_MATH_POW' => 149,
			";" => 292,
			'OP09_BITWISE_SHIFT' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145,
			'OP06_REGEX_MATCH' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 142,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP08_STRING_CAT' => 134
		}
	},
	{#State 256
		ACTIONS => {
			'LPAREN' => 293
		}
	},
	{#State 257
		ACTIONS => {
			'LBRACE' => 294
		},
		GOTOS => {
			'CodeBlock' => 295
		}
	},
	{#State 258
		ACTIONS => {
			'WORD' => 296
		}
	},
	{#State 259
		DEFAULT => -41
	},
	{#State 260
		ACTIONS => {
			"while (" => -144,
			"%{" => 90,
			"if (" => 114,
			"\@{" => 91,
			"my" => 89,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'OP01_PRINT' => 80,
			'WORD' => 102,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			"foreach my" => -144,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			"}" => 298,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 79,
			'OP19_LOOP_CONTROL' => 96,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED_VOID' => 73,
			"for my integer" => -144,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92
		},
		GOTOS => {
			'Statement' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'SubExpression' => 75,
			'Operator' => 76,
			'WordScoped' => 97,
			'Operation' => 297,
			'OperatorVoid' => 94,
			'VariableDeclaration' => 72,
			'LoopLabel' => 113,
			'Conditional' => 112,
			'OPTIONAL-39' => 106,
			'VariableModification' => 87,
			'HashDereferenced' => 109,
			'Variable' => 107,
			'ArrayReference' => 110,
			'Expression' => 81,
			'PAREN-38' => 82,
			'HashReference' => 84
		}
	},
	{#State 261
		DEFAULT => -45
	},
	{#State 262
		ACTIONS => {
			'VARIABLE_SYMBOL' => 299
		}
	},
	{#State 263
		ACTIONS => {
			"our" => -58,
			'LITERAL_NUMBER' => -58,
			"our %properties_class = (" => 300
		},
		GOTOS => {
			'OPTIONAL-23' => 302,
			'PropertiesClass' => 301
		}
	},
	{#State 264
		DEFAULT => -55
	},
	{#State 265
		ACTIONS => {
			")" => 303,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 304
		}
	},
	{#State 266
		ACTIONS => {
			'WORD' => 305,
			")" => 306
		}
	},
	{#State 267
		DEFAULT => -180
	},
	{#State 268
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'KEYS_OR_VALUES' => 131,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'WORD' => 28,
			"\@{" => 91,
			"%{" => 90,
			"my" => 115
		},
		GOTOS => {
			'Expression' => 128,
			'HashReference' => 84,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'TypeInner' => 130,
			'ArrayReference' => 110,
			'ListElement' => 307,
			'SubExpression' => 126,
			'WordScoped' => 97,
			'Operator' => 76,
			'ArrayDereferenced' => 100,
			'Literal' => 101
		}
	},
	{#State 269
		DEFAULT => -177
	},
	{#State 270
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'Variable' => 308
		}
	},
	{#State 271
		ACTIONS => {
			";" => 309
		}
	},
	{#State 272
		DEFAULT => -118
	},
	{#State 273
		DEFAULT => -119
	},
	{#State 274
		ACTIONS => {
			'OP23_LOGICAL_AND' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP06_REGEX_MATCH' => 138,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_STRING_CAT' => 134,
			'OP04_MATH_POW' => 149,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => 310,
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145
		}
	},
	{#State 275
		ACTIONS => {
			"}" => 311,
			'LPAREN' => -203
		}
	},
	{#State 276
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => 146,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			"]" => 312,
			'OP08_STRING_CAT' => 134,
			'OP06_REGEX_MATCH' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 142,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141
		}
	},
	{#State 277
		ACTIONS => {
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			"%{" => 90,
			"\@{" => 91,
			'STDIN' => 253,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LBRACKET' => 83,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103
		},
		GOTOS => {
			'Expression' => 128,
			'HashReference' => 84,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'ArrayReference' => 110,
			'SubExpressionOrStdin' => 313,
			'SubExpression' => 252,
			'WordScoped' => 97,
			'Operator' => 76,
			'Literal' => 101,
			'ArrayDereferenced' => 100
		}
	},
	{#State 278
		DEFAULT => -172
	},
	{#State 279
		ACTIONS => {
			'OP21_LIST_COMMA' => 314
		}
	},
	{#State 280
		DEFAULT => -128
	},
	{#State 281
		ACTIONS => {
			'OP01_QW' => 124,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'KEYS_OR_VALUES' => 131,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'WORD' => 28,
			"%{" => 90,
			"\@{" => 91,
			"my" => 115
		},
		GOTOS => {
			'Variable' => 132,
			'TypeInner' => 130,
			'HashDereferenced' => 109,
			'ListElements' => 315,
			'ArrayReference' => 110,
			'Expression' => 128,
			'HashReference' => 84,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'ListElement' => 125,
			'SubExpression' => 126,
			'WordScoped' => 97,
			'Operator' => 76
		}
	},
	{#State 282
		ACTIONS => {
			")" => 316
		}
	},
	{#State 283
		ACTIONS => {
			'OP01_NAMED' => 127,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			"\@{" => 91,
			"%{" => 90,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 317,
			'ArrayDereferenced' => 100,
			'Literal' => 101
		}
	},
	{#State 284
		DEFAULT => -191
	},
	{#State 285
		DEFAULT => -198
	},
	{#State 286
		DEFAULT => -200
	},
	{#State 287
		ACTIONS => {
			'WORD' => 177,
			"%{" => 90
		},
		GOTOS => {
			'HashEntry' => 318,
			'HashDereferenced' => 178
		}
	},
	{#State 288
		ACTIONS => {
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"\@{" => 91,
			"%{" => 90,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127
		},
		GOTOS => {
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 319,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132
		}
	},
	{#State 289
		ACTIONS => {
			'LPAREN' => 320
		}
	},
	{#State 290
		ACTIONS => {
			'LBRACE' => 294
		},
		GOTOS => {
			'CodeBlock' => 321
		}
	},
	{#State 291
		DEFAULT => -174
	},
	{#State 292
		DEFAULT => -175
	},
	{#State 293
		ACTIONS => {
			"my" => 115,
			"\@{" => 91,
			"%{" => 90,
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'KEYS_OR_VALUES' => 131,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP05_LOGICAL_NEG' => 95,
			")" => -126,
			'OP01_QW' => 124,
			'OP10_STRINGIFY_UNARY' => 74
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'TypeInner' => 130,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'ListElements' => 322,
			'WordScoped' => 97,
			'Operator' => 76,
			'ListElement' => 125,
			'SubExpression' => 126,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'OPTIONAL-37' => 323
		}
	},
	{#State 294
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED_VOID' => 73,
			"for my integer" => -144,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			"foreach my" => -144,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 79,
			'OP19_LOOP_CONTROL' => 96,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			'OP01_PRINT' => 80,
			'WORD' => 102,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			"while (" => -144,
			"\@{" => 91,
			"if (" => 114,
			"%{" => 90,
			"my" => 89
		},
		GOTOS => {
			'PAREN-38' => 82,
			'Expression' => 81,
			'HashReference' => 84,
			'OPTIONAL-39' => 106,
			'VariableModification' => 87,
			'Variable' => 107,
			'HashDereferenced' => 109,
			'ArrayReference' => 110,
			'Conditional' => 112,
			'LoopLabel' => 113,
			'Operation' => 325,
			'OperatorVoid' => 94,
			'VariableDeclaration' => 72,
			'SubExpression' => 75,
			'Operator' => 76,
			'WordScoped' => 97,
			'Statement' => 99,
			'PLUS-44' => 324,
			'ArrayDereferenced' => 100,
			'Literal' => 101
		}
	},
	{#State 295
		DEFAULT => -152,
		GOTOS => {
			'STAR-41' => 326
		}
	},
	{#State 296
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 327
		}
	},
	{#State 297
		DEFAULT => -44
	},
	{#State 298
		ACTIONS => {
			";" => 328
		}
	},
	{#State 299
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 329
		}
	},
	{#State 300
		ACTIONS => {
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 330
		}
	},
	{#State 301
		DEFAULT => -57
	},
	{#State 302
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 331
		}
	},
	{#State 303
		ACTIONS => {
			";" => 332
		}
	},
	{#State 304
		ACTIONS => {
			'WORD' => 334,
			"%{" => 90
		},
		GOTOS => {
			'HashDereferenced' => 333,
			'HashEntryTyped' => 335
		}
	},
	{#State 305
		DEFAULT => -179
	},
	{#State 306
		DEFAULT => -182
	},
	{#State 307
		DEFAULT => -176
	},
	{#State 308
		DEFAULT => -109
	},
	{#State 309
		DEFAULT => -121
	},
	{#State 310
		DEFAULT => -170
	},
	{#State 311
		DEFAULT => -171
	},
	{#State 312
		DEFAULT => -169
	},
	{#State 313
		ACTIONS => {
			";" => 336
		}
	},
	{#State 314
		ACTIONS => {
			'LITERAL_STRING' => 337
		}
	},
	{#State 315
		ACTIONS => {
			")" => 338
		}
	},
	{#State 316
		DEFAULT => -84
	},
	{#State 317
		ACTIONS => {
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139,
			"}" => -193,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP04_MATH_POW' => 149,
			'OP08_STRING_CAT' => 134,
			'OP21_LIST_COMMA' => -193,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP23_LOGICAL_AND' => 142
		}
	},
	{#State 318
		DEFAULT => -197
	},
	{#State 319
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP23_LOGICAL_AND' => 142,
			'OP06_REGEX_MATCH' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP08_STRING_CAT' => 134,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP17_LIST_RANGE' => 339,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP04_MATH_POW' => 149,
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139
		}
	},
	{#State 320
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP01_QW' => 124,
			'OP05_LOGICAL_NEG' => 95,
			'KEYS_OR_VALUES' => 131,
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			"undef" => 86,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			"my" => 115,
			"%{" => 90,
			"\@{" => 91
		},
		GOTOS => {
			'TypeInner' => 130,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'ListElements' => 340,
			'ArrayReference' => 110,
			'Expression' => 128,
			'HashReference' => 84,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'ListElement' => 125,
			'SubExpression' => 126,
			'WordScoped' => 97,
			'Operator' => 76
		}
	},
	{#State 321
		DEFAULT => -162
	},
	{#State 322
		DEFAULT => -125
	},
	{#State 323
		ACTIONS => {
			")" => 341
		}
	},
	{#State 324
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED_VOID' => 73,
			'OP10_STRINGIFY_UNARY' => 74,
			"for my integer" => -144,
			'OP19_LOOP_CONTROL' => 96,
			'OP22_LOGICAL_NOT' => 78,
			"}" => 342,
			"foreach my" => -144,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP01_NAMED' => 79,
			'OP01_PRINT' => 80,
			'WORD' => 102,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			"my" => 89,
			"%{" => 90,
			"\@{" => 91,
			"if (" => 114,
			"while (" => -144
		},
		GOTOS => {
			'Operation' => 343,
			'OperatorVoid' => 94,
			'VariableDeclaration' => 72,
			'Statement' => 99,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'SubExpression' => 75,
			'Operator' => 76,
			'WordScoped' => 97,
			'OPTIONAL-39' => 106,
			'Variable' => 107,
			'HashDereferenced' => 109,
			'VariableModification' => 87,
			'ArrayReference' => 110,
			'PAREN-38' => 82,
			'Expression' => 81,
			'HashReference' => 84,
			'LoopLabel' => 113,
			'Conditional' => 112
		}
	},
	{#State 325
		DEFAULT => -164
	},
	{#State 326
		ACTIONS => {
			"if (" => -155,
			'WORD' => -155,
			"else" => 345,
			'LBRACE' => -155,
			'OP05_MATH_NEG_LPAREN' => -155,
			'LITERAL_STRING' => -155,
			'OP01_CLOSE' => -155,
			'OP10_NAMED_UNARY' => -155,
			'OP19_LOOP_CONTROL' => -155,
			'LPAREN' => -155,
			'OP01_OPEN' => -155,
			'LITERAL_NUMBER' => -155,
			'OP05_LOGICAL_NEG' => -155,
			"for my integer" => -155,
			"my" => -155,
			"%{" => -155,
			"\@{" => -155,
			"while (" => -155,
			'OP01_PRINT' => -155,
			'LBRACKET' => -155,
			'' => -155,
			'VARIABLE_SYMBOL' => -155,
			"undef" => -155,
			'WORD_SCOPED' => -155,
			'OP22_LOGICAL_NOT' => -155,
			"}" => -155,
			'OP03_MATH_INC_DEC' => -155,
			"foreach my" => -155,
			'OP01_NAMED' => -155,
			"elsif (" => 346,
			'OP01_NAMED_VOID' => -155,
			'OP10_STRINGIFY_UNARY' => -155
		},
		GOTOS => {
			'PAREN-40' => 348,
			'PAREN-42' => 347,
			'OPTIONAL-43' => 344
		}
	},
	{#State 327
		DEFAULT => -207
	},
	{#State 328
		DEFAULT => -46
	},
	{#State 329
		ACTIONS => {
			")" => 350,
			'OP21_LIST_COMMA' => 349
		},
		GOTOS => {
			'PAREN-18' => 351
		}
	},
	{#State 330
		ACTIONS => {
			"%{" => 90,
			'WORD' => 334
		},
		GOTOS => {
			'HashDereferenced' => 333,
			'HashEntryTyped' => 352
		}
	},
	{#State 331
		ACTIONS => {
			"our" => 354,
			'LITERAL_NUMBER' => 357
		},
		GOTOS => {
			'Method' => 353,
			'MethodOrSubroutine' => 356,
			'Subroutine' => 355
		}
	},
	{#State 332
		ACTIONS => {
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 358
		}
	},
	{#State 333
		DEFAULT => -196
	},
	{#State 334
		ACTIONS => {
			'OP20_HASH_FATARROW' => 359
		}
	},
	{#State 335
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 360
		}
	},
	{#State 336
		DEFAULT => -173
	},
	{#State 337
		ACTIONS => {
			'OP21_LIST_COMMA' => 361
		}
	},
	{#State 338
		DEFAULT => -86
	},
	{#State 339
		ACTIONS => {
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			"%{" => 90,
			"\@{" => 91,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86
		},
		GOTOS => {
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 362,
			'ArrayReference' => 110,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'HashReference' => 84,
			'Expression' => 128
		}
	},
	{#State 340
		ACTIONS => {
			")" => 363
		}
	},
	{#State 341
		DEFAULT => -129
	},
	{#State 342
		DEFAULT => -165
	},
	{#State 343
		DEFAULT => -163
	},
	{#State 344
		DEFAULT => -156
	},
	{#State 345
		ACTIONS => {
			'LBRACE' => 294
		},
		GOTOS => {
			'CodeBlock' => 364
		}
	},
	{#State 346
		ACTIONS => {
			"%{" => 90,
			"\@{" => 91,
			'LITERAL_STRING' => 108,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'WORD' => 28,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACKET' => 83,
			'OP22_LOGICAL_NOT' => 78,
			'OP03_MATH_INC_DEC' => 77,
			'LPAREN' => 98,
			'OP01_NAMED' => 127,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'HashReference' => 84,
			'Expression' => 128,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'Operator' => 76,
			'WordScoped' => 97,
			'SubExpression' => 365,
			'ArrayDereferenced' => 100,
			'Literal' => 101
		}
	},
	{#State 347
		DEFAULT => -154
	},
	{#State 348
		DEFAULT => -151
	},
	{#State 349
		ACTIONS => {
			"my" => 366
		}
	},
	{#State 350
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 367
		}
	},
	{#State 351
		DEFAULT => -48
	},
	{#State 352
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 368
		}
	},
	{#State 353
		DEFAULT => -80
	},
	{#State 354
		ACTIONS => {
			'WORD' => 57,
			'TYPE_METHOD' => 369
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 355
		DEFAULT => -81
	},
	{#State 356
		DEFAULT => -59
	},
	{#State 357
		ACTIONS => {
			";" => 370
		}
	},
	{#State 358
		DEFAULT => -66
	},
	{#State 359
		ACTIONS => {
			"my" => 115
		},
		GOTOS => {
			'TypeInner' => 371
		}
	},
	{#State 360
		ACTIONS => {
			")" => 374,
			'OP21_LIST_COMMA' => 373
		},
		GOTOS => {
			'PAREN-25' => 372
		}
	},
	{#State 361
		ACTIONS => {
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 92,
			'OP10_STRINGIFY_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED' => 127,
			'OP22_LOGICAL_NOT' => 78,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 91,
			"%{" => 90
		},
		GOTOS => {
			'SubExpression' => 375,
			'Operator' => 76,
			'WordScoped' => 97,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Expression' => 128,
			'HashReference' => 84,
			'Variable' => 132,
			'HashDereferenced' => 109,
			'ArrayReference' => 110
		}
	},
	{#State 362
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145,
			")" => 376,
			'OP04_MATH_POW' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP08_STRING_CAT' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP06_REGEX_MATCH' => 138,
			'OP23_LOGICAL_AND' => -108,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141
		}
	},
	{#State 363
		ACTIONS => {
			'LBRACE' => 294
		},
		GOTOS => {
			'CodeBlock' => 377
		}
	},
	{#State 364
		DEFAULT => -153
	},
	{#State 365
		ACTIONS => {
			'OP08_STRING_CAT' => 134,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 135,
			'OP18_TERNARY' => 136,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			'OP06_REGEX_MATCH' => 138,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP23_LOGICAL_AND' => 142,
			")" => 378,
			'OP15_LOGICAL_AND' => 145,
			'OP11_COMPARE_LT_GT' => 139,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP04_MATH_POW' => 149
		}
	},
	{#State 366
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 379
		}
	},
	{#State 367
		ACTIONS => {
			"\@_;" => 380
		}
	},
	{#State 368
		ACTIONS => {
			'OP21_LIST_COMMA' => 381,
			")" => 383
		},
		GOTOS => {
			'PAREN-27' => 382
		}
	},
	{#State 369
		ACTIONS => {
			'VARIABLE_SYMBOL' => 384
		}
	},
	{#State 370
		DEFAULT => -61
	},
	{#State 371
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 95,
			'OP10_STRINGIFY_UNARY' => 74,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP22_LOGICAL_NOT' => 78,
			'OP01_NAMED' => 127,
			'WORD' => 28,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"undef" => 86,
			'LITERAL_STRING' => 108,
			'OP10_NAMED_UNARY' => 111,
			'WORD_SCOPED' => 27,
			"%{" => 90,
			"\@{" => 91
		},
		GOTOS => {
			'SubExpression' => 385,
			'WordScoped' => 97,
			'Operator' => 76,
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Expression' => 128,
			'HashReference' => 84,
			'HashDereferenced' => 109,
			'Variable' => 132,
			'ArrayReference' => 110
		}
	},
	{#State 372
		DEFAULT => -63
	},
	{#State 373
		ACTIONS => {
			'WORD' => 334,
			"%{" => 90
		},
		GOTOS => {
			'HashDereferenced' => 333,
			'HashEntryTyped' => 386
		}
	},
	{#State 374
		ACTIONS => {
			";" => 387
		}
	},
	{#State 375
		ACTIONS => {
			'OP23_LOGICAL_AND' => -87,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP06_REGEX_MATCH' => 138,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP13_BITWISE_AND' => 137,
			"]" => -87,
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP21_LIST_COMMA' => -87,
			'OP08_STRING_CAT' => 134,
			";" => -87,
			'OP04_MATH_POW' => 149,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147,
			"}" => -87,
			'OP09_BITWISE_SHIFT' => 148,
			'OP11_COMPARE_LT_GT' => 139,
			'OP15_LOGICAL_AND' => 145,
			")" => -87
		}
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 294
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 377
		DEFAULT => -161
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 294
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 379
		ACTIONS => {
			'VARIABLE_SYMBOL' => 390
		}
	},
	{#State 380
		DEFAULT => -50
	},
	{#State 381
		ACTIONS => {
			'WORD' => 334,
			"%{" => 90
		},
		GOTOS => {
			'HashDereferenced' => 333,
			'HashEntryTyped' => 391
		}
	},
	{#State 382
		DEFAULT => -68
	},
	{#State 383
		ACTIONS => {
			";" => 392
		}
	},
	{#State 384
		ACTIONS => {
			"= sub {" => 393
		}
	},
	{#State 385
		ACTIONS => {
			'OP15_LOGICAL_AND' => 145,
			")" => -195,
			'OP11_COMPARE_LT_GT' => 139,
			'OP17_LIST_RANGE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP04_MATH_POW' => 149,
			'OP08_STRING_CAT' => 134,
			'OP18_TERNARY' => 136,
			'OP08_MATH_ADD_SUB' => 135,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP21_LIST_COMMA' => -195,
			'OP13_BITWISE_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 141,
			'OP23_LOGICAL_AND' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 144,
			'OP12_COMPARE_EQ_NEQ' => 143,
			'OP06_REGEX_MATCH' => 138
		}
	},
	{#State 386
		DEFAULT => -62
	},
	{#State 387
		DEFAULT => -65
	},
	{#State 388
		DEFAULT => -160
	},
	{#State 389
		DEFAULT => -150
	},
	{#State 390
		DEFAULT => -47
	},
	{#State 391
		DEFAULT => -67
	},
	{#State 392
		DEFAULT => -70
	},
	{#State 393
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -72,
			"foreach my" => -72,
			'OP03_MATH_INC_DEC' => -72,
			'LPAREN' => -72,
			'OP22_LOGICAL_NOT' => -72,
			'OP01_NAMED' => -72,
			'OP01_OPEN' => -72,
			'LITERAL_NUMBER' => -72,
			'OP05_LOGICAL_NEG' => -72,
			'OP01_NAMED_VOID' => -72,
			"for my integer" => -72,
			'OP10_STRINGIFY_UNARY' => -72,
			"my" => -72,
			"while (" => -72,
			"\@{" => -72,
			"if (" => -72,
			"%{" => -72,
			"( my" => 394,
			'WORD' => -72,
			'OP01_PRINT' => -72,
			'LBRACKET' => -72,
			'OP05_MATH_NEG_LPAREN' => -72,
			'LBRACE' => -72,
			"undef" => -72,
			'VARIABLE_SYMBOL' => -72,
			'OP01_CLOSE' => -72,
			'LITERAL_STRING' => -72,
			'OP10_NAMED_UNARY' => -72,
			'WORD_SCOPED' => -72
		},
		GOTOS => {
			'MethodArguments' => 395,
			'OPTIONAL-29' => 396
		}
	},
	{#State 394
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 397
		}
	},
	{#State 395
		DEFAULT => -71
	},
	{#State 396
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 95,
			'OP01_NAMED_VOID' => 73,
			'OP10_STRINGIFY_UNARY' => 74,
			"for my integer" => -144,
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP22_LOGICAL_NOT' => 78,
			"foreach my" => -144,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 77,
			'OP01_NAMED' => 79,
			'OP19_LOOP_CONTROL' => 96,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 105,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 86,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'WORD' => 102,
			'OP01_PRINT' => 80,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			"if (" => 114,
			"%{" => 90,
			"\@{" => 91,
			"while (" => -144,
			"my" => 89
		},
		GOTOS => {
			'ArrayDereferenced' => 100,
			'Literal' => 101,
			'Statement' => 99,
			'WordScoped' => 97,
			'Operator' => 76,
			'SubExpression' => 75,
			'OperatorVoid' => 94,
			'VariableDeclaration' => 72,
			'Operation' => 398,
			'LoopLabel' => 113,
			'Conditional' => 112,
			'ArrayReference' => 110,
			'HashDereferenced' => 109,
			'VariableModification' => 87,
			'Variable' => 107,
			'OPTIONAL-39' => 106,
			'HashReference' => 84,
			'PLUS-30' => 399,
			'PAREN-38' => 82,
			'Expression' => 81
		}
	},
	{#State 397
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 400
		}
	},
	{#State 398
		DEFAULT => -74
	},
	{#State 399
		ACTIONS => {
			'LITERAL_NUMBER' => 92,
			'OP01_OPEN' => 93,
			'OP10_STRINGIFY_UNARY' => 74,
			"for my integer" => -144,
			'OP01_NAMED_VOID' => 73,
			'OP05_LOGICAL_NEG' => 95,
			'OP19_LOOP_CONTROL' => 96,
			'OP01_NAMED' => 79,
			'OP22_LOGICAL_NOT' => 78,
			"foreach my" => -144,
			'OP03_MATH_INC_DEC' => 77,
			"}" => 401,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 104,
			'LBRACKET' => 83,
			'OP01_PRINT' => 80,
			'WORD' => 102,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 111,
			'LITERAL_STRING' => 108,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 85,
			'OP01_CLOSE' => 105,
			"my" => 89,
			"\@{" => 91,
			"if (" => 114,
			"%{" => 90,
			"while (" => -144
		},
		GOTOS => {
			'Operation' => 402,
			'VariableDeclaration' => 72,
			'OperatorVoid' => 94,
			'Statement' => 99,
			'Literal' => 101,
			'ArrayDereferenced' => 100,
			'SubExpression' => 75,
			'Operator' => 76,
			'WordScoped' => 97,
			'OPTIONAL-39' => 106,
			'Variable' => 107,
			'HashDereferenced' => 109,
			'VariableModification' => 87,
			'ArrayReference' => 110,
			'Expression' => 81,
			'PAREN-38' => 82,
			'HashReference' => 84,
			'LoopLabel' => 113,
			'Conditional' => 112
		}
	},
	{#State 400
		ACTIONS => {
			'OP21_LIST_COMMA' => 404,
			")" => 403
		},
		GOTOS => {
			'PAREN-31' => 405
		}
	},
	{#State 401
		ACTIONS => {
			";" => 406
		}
	},
	{#State 402
		DEFAULT => -73
	},
	{#State 403
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 404
		ACTIONS => {
			"my" => 408
		}
	},
	{#State 405
		DEFAULT => -77
	},
	{#State 406
		DEFAULT => -75
	},
	{#State 407
		ACTIONS => {
			"\@_;" => 409
		}
	},
	{#State 408
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 410
		}
	},
	{#State 409
		DEFAULT => -79
	},
	{#State 410
		ACTIONS => {
			'VARIABLE_SYMBOL' => 411
		}
	},
	{#State 411
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5723 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5730 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5737 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 123 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5744 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5755 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5766 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5773 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5780 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5787 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5794 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5801 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5808 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5815 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5822 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5829 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5836 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5843 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 124 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5850 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 125 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5875 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5886 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 127 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5975 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5986 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 129 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6000 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6018 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 130 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6025 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6036 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6058 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6097 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6118 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6143 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6150 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6171 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6178 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6185 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6192 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6199 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6210 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6217 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6224 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6231 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6253 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6285 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6306 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6313 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6324 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6331 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6338 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6345 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6356 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6367 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6389 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6400 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6411 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6422 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6433 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6444 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6455 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6477 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6521 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6532 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6543 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6554 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6565 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6576 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6587 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6598 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6609 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6620 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6653 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6664 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6697 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6719 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6726 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6733 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6740 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6747 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6754 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6787 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6798 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6809 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6823 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6830 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6837 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6859 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6870 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6881 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6892 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6903 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_140
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_141
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7009 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7016 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7023 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7034 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 4,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7092 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7106 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7113 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7120 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_156
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7142 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_158
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_159
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7164 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_160
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7175 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_161
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7186 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_162
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7197 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7204 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7211 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_165
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7222 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7236 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_168
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7247 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_170
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_171
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_172
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_173
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7302 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_174
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7313 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_175
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7324 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7331 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_181
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_182
		 'ListElements', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_184
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_185
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7428 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_188
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7439 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_189
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7450 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_190
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7461 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7468 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_193
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_194
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_195
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_196
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7533 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7540 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_200
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7551 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_201
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_202
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_204
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_205
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule Type_206
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_207
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_209
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7650 lib/RPerl/Grammar.pm
	]
],
#line 7653 lib/RPerl/Grammar.pm
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
         'Operator_112', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_127', 
         'Expression_128', 
         'Expression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpressionOrStdin_140', 
         'SubExpressionOrStdin_141', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_145', 
         'Statement_146', 
         'Statement_147', 
         'Statement_148', 
         'Statement_149', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_156', 
         'Loop_157', 
         'Loop_158', 
         'Loop_159', 
         'LoopFor_160', 
         'LoopForEach_161', 
         'LoopWhile_162', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_165', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_168', 
         'VariableRetrieval_169', 
         'VariableRetrieval_170', 
         'VariableRetrieval_171', 
         'VariableDeclaration_172', 
         'VariableDeclaration_173', 
         'VariableModification_174', 
         'VariableModification_175', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_181', 
         'ListElements_182', 
         'ListElement_183', 
         'ListElement_184', 
         'ListElement_185', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_188', 
         'ArrayDereferenced_189', 
         'ArrayDereferenced_190', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_193', 
         'HashEntry_194', 
         'HashEntryTyped_195', 
         'HashEntryTyped_196', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_200', 
         'HashDereferenced_201', 
         'HashDereferenced_202', 
         'WordScoped_203', 
         'WordScoped_204', 
         'LoopLabel_205', 
         'Type_206', 
         'TypeInner_207', 
         'Literal_208', 
         'Literal_209', );
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


#line 7911 lib/RPerl/Grammar.pm



1;
