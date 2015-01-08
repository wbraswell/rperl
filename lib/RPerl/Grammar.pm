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
    our $VERSION = 0.000_920;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$class_properties|our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|for\ my\ integer|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|while\ \(|package|\$TYPED_|elsif\ \(|\=\ sub\ \{|undef|if\ \(|\(\ my|else|our|qw\(|\@_\;|use|\%\{|my|\@\{|\}|\]|\)|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$[a-zA-Z]\w*[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
      /\G([a-zA-Z]\w*__method)/gc and return ('TYPE_METHOD', $1);
      /\G([a-zA-Z]\w*(::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
      /\G(keys|values)\s/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
      /\G(\{\*STDOUT\}|\{\*STDERR\})/gc and return ('STDOUT_STDERR', $1);
      /\G(<STDIN>)/gc and return ('STDIN', $1);
      /\G(or|xor)\s/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)\s/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not)\s/gc and return ('OP22_LOGICAL_NEG', $1);
      /\G(,)/gc and return ('OP21_LIST_COMMA', $1);
      /\G(=>)/gc and return ('OP20_HASH_FATARROW', $1);
      /\G(next;|last;)/gc and return ('OP19_LOOP_CONTROL_SCOLON', $1);
      /\G(next|last)\s/gc and return ('OP19_LOOP_CONTROL', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|eq|ne)\s/gc and return ('OP12_COMPARE_EQ_NE', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(chdir|rand|scalar[^t])\s/gc and return ('OP10_NAMED_UNARY', $1);
      /\G((?:main)?::[a-zA-Z]\w*__stringify\()/gc and return ('OP10_STRINGIFY_UNARY', $1);
      /\G(\+=|-=|\*=|\/=|\.=)/gc and return ('OP19_VARIABLE_ASSIGN_BY', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(x)\s/gc and return ('OP07_STRING_REPEAT', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->[a-zA-Z]\w*)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LPAREN', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<=|>=|<|>|lt|gt|le|ge)\s/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print)\s/gc and return ('OP01_PRINT', $1);
      /\G(croak;|return;|exit;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak|return|exit)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\()/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|ETC)\s/gc and return ('OP01_NAMED', $1);
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


#line 127 lib/RPerl/Grammar.pm

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
  [ 'Properties_65' => 'Properties', [ 'our hash_ref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryTyped', 'STAR-26', '}', ';' ], 0 ],
  [ 'Properties_66' => 'Properties', [ 'our hash_ref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-27', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'PAREN-27' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ 'PropertiesClass_70' => 'PropertiesClass', [ 'our hash_ref $class_properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryTyped', 'STAR-28', '}', ';' ], 0 ],
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
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'OP10_STRINGIFY_UNARY', 'SubExpression', ')' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_111' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_112' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_113' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-33', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'PAREN-33' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-34', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_123' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-36', ')' ], 0 ],
  [ 'Expression_133' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-37', ')' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_142' => 'SubExpression', [ 'LBRACE', '}' ], 0 ],
  [ 'SubExpression_143' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_144' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_145' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'OPTIONAL-39', 'Loop' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'PAREN-40' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [ 'PAREN-42' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-43', [  ], 0 ],
  [ 'Conditional_160' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-41', 'OPTIONAL-43' ], 0 ],
  [ 'Loop_161' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_163' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_164' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_165' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_166' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'Operation' ], 0 ],
  [ 'CodeBlock_169' => 'CodeBlock', [ 'LBRACE', 'PLUS-44', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'Variable_172' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-45' ], 0 ],
  [ 'VariableRetrieval_173' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_174' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_175' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_176' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_177' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_178' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_179' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-46', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [ 'STAR-47', 'PAREN-46' ], 0 ],
  [ '_STAR_LIST' => 'STAR-47', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'PLUS-48', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-48', [ 'WORD' ], 0 ],
  [ 'ListElements_185' => 'ListElements', [ 'ListElement', 'STAR-47' ], 0 ],
  [ 'ListElements_186' => 'ListElements', [ 'OP01_QW', 'PLUS-48', ')' ], 0 ],
  [ 'ListElement_187' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_189' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'ArrayReference_192' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-49', ']' ], 0 ],
  [ 'ArrayDereferenced_193' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_194' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashEntry_197' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-50', 'SubExpression' ], 0 ],
  [ 'HashEntry_198' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_199' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_200' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'HashReference_204' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-52', '}' ], 0 ],
  [ 'HashDereferenced_205' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_206' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_207' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_208' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_209' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_210' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_211' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_212' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_213' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
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
  'Operator_113' => 113,
  '_PAREN' => 114,
  '_OPTIONAL' => 115,
  '_OPTIONAL' => 116,
  'OperatorVoid_117' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  'OperatorVoid_123' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  '_OPTIONAL' => 128,
  '_OPTIONAL' => 129,
  'Expression_130' => 130,
  'Expression_131' => 131,
  'Expression_132' => 132,
  'Expression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpression_141' => 141,
  'SubExpression_142' => 142,
  'SubExpression_143' => 143,
  'SubExpressionOrStdin_144' => 144,
  'SubExpressionOrStdin_145' => 145,
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
  'LoopLabel_209' => 209,
  'Type_210' => 210,
  'TypeInner_211' => 211,
  'VariableOrLiteral_212' => 212,
  'VariableOrLiteral_213' => 213,
  'Literal_214' => 214,
  'Literal_215' => 215,
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
	'our hash_ref $class_properties' => { ISSEMANTIC => 0 },
	'our hash_ref $properties' => { ISSEMANTIC => 0 },
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
	OP01_NAMED_VOID_SCOLON => { ISSEMANTIC => 1 },
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
	OP07_STRING_REPEAT => { ISSEMANTIC => 1 },
	OP08_MATH_ADD_SUB => { ISSEMANTIC => 1 },
	OP08_STRING_CAT => { ISSEMANTIC => 1 },
	OP09_BITWISE_SHIFT => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY => { ISSEMANTIC => 1 },
	OP10_STRINGIFY_UNARY => { ISSEMANTIC => 1 },
	OP11_COMPARE_LT_GT => { ISSEMANTIC => 1 },
	OP12_COMPARE_EQ_NE => { ISSEMANTIC => 1 },
	OP13_BITWISE_AND => { ISSEMANTIC => 1 },
	OP14_BITWISE_OR_XOR => { ISSEMANTIC => 1 },
	OP15_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP16_LOGICAL_OR => { ISSEMANTIC => 1 },
	OP17_LIST_RANGE => { ISSEMANTIC => 1 },
	OP18_TERNARY => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL_SCOLON => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN_BY => { ISSEMANTIC => 1 },
	OP20_HASH_FATARROW => { ISSEMANTIC => 1 },
	OP21_LIST_COMMA => { ISSEMANTIC => 1 },
	OP22_LOGICAL_NEG => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 5,
			"package" => -20,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'ModuleHeader' => 2,
			'Program' => 6,
			'Critic' => 1,
			'PAREN-1' => 3,
			'CompileUnit' => 4,
			'PLUS-2' => 9,
			'OPTIONAL-9' => 8
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"use constant" => -25,
			"## no critic qw(" => -25,
			"use" => -25,
			"use parent qw(" => 12,
			"our" => -25
		},
		GOTOS => {
			'Package' => 13,
			'STAR-10' => 14,
			'Module' => 10,
			'Class' => 11
		}
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			'' => 15
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 7,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 17,
			'OPTIONAL-3' => 16
		}
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 8
		ACTIONS => {
			"package" => 20
		}
	},
	{#State 9
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 7,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 2,
			'Critic' => 1,
			'PAREN-1' => 21,
			'OPTIONAL-9' => 8
		}
	},
	{#State 10
		DEFAULT => -1
	},
	{#State 11
		DEFAULT => -23
	},
	{#State 12
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		ACTIONS => {
			"our" => -27,
			"use" => -27,
			"## no critic qw(" => 7,
			"use constant" => -27
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-11' => 25
		}
	},
	{#State 15
		DEFAULT => 0
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
		DEFAULT => -35
	},
	{#State 19
		ACTIONS => {
			")" => 29,
			'WORD' => 30
		}
	},
	{#State 20
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 21
		DEFAULT => -2
	},
	{#State 22
		ACTIONS => {
			")" => 32
		}
	},
	{#State 23
		DEFAULT => -207
	},
	{#State 24
		DEFAULT => -208
	},
	{#State 25
		ACTIONS => {
			"use" => 33,
			"our" => -29,
			"use constant" => -29
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 35
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
		DEFAULT => -36
	},
	{#State 30
		DEFAULT => -34
	},
	{#State 31
		ACTIONS => {
			";" => 38
		}
	},
	{#State 32
		ACTIONS => {
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			"use constant" => 42,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 41,
			'PLUS-13' => 44,
			'Constant' => 45
		}
	},
	{#State 36
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -11,
			'WORD' => -11,
			"my" => -11,
			"for my integer" => -11,
			"\@{" => -11,
			'VARIABLE_SYMBOL' => -11,
			"undef" => -11,
			"foreach my" => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED' => -11,
			'LBRACE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"%{" => -11,
			"our" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID' => -11,
			"if (" => -11,
			'LPAREN' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_OPEN' => -11,
			"use constant" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_PRINT' => -11,
			'OP01_CLOSE' => -11,
			"while (" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"## no critic qw(" => 7,
			'LBRACKET' => -11,
			'OP10_NAMED_UNARY' => -11,
			'WORD_SCOPED' => -11,
			"use" => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			'LITERAL_STRING' => -11,
			'OP22_LOGICAL_NEG' => -11
		},
		GOTOS => {
			'Critic' => 46,
			'STAR-5' => 47
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
			"use" => 33
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 40
		ACTIONS => {
			";" => 52,
			"qw(" => 51
		}
	},
	{#State 41
		DEFAULT => -31
	},
	{#State 42
		ACTIONS => {
			'WORD' => 53
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 44
		ACTIONS => {
			"our" => 43,
			'LITERAL_NUMBER' => 57
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		DEFAULT => -8
	},
	{#State 47
		ACTIONS => {
			'LBRACE' => -13,
			'OP01_NAMED' => -13,
			'LITERAL_NUMBER' => -13,
			"undef" => -13,
			"foreach my" => -13,
			'VARIABLE_SYMBOL' => -13,
			"\@{" => -13,
			"for my integer" => -13,
			"my" => -13,
			'WORD' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_PRINT' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_OPEN' => -13,
			"use constant" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LPAREN' => -13,
			"if (" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"our" => -13,
			"%{" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LBRACKET' => -13,
			"while (" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'LITERAL_STRING' => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			"use" => 33,
			'WORD_SCOPED' => -13
		},
		GOTOS => {
			'Include' => 58,
			'STAR-6' => 59
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
		ACTIONS => {
			'WORD' => 63
		},
		GOTOS => {
			'PLUS-15' => 62
		}
	},
	{#State 52
		DEFAULT => -39
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 55
		DEFAULT => -210
	},
	{#State 56
		DEFAULT => -30
	},
	{#State 57
		ACTIONS => {
			";" => 66
		}
	},
	{#State 58
		DEFAULT => -10
	},
	{#State 59
		ACTIONS => {
			'OP10_NAMED_UNARY' => -15,
			'LBRACKET' => -15,
			"while (" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			'LITERAL_STRING' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			'WORD_SCOPED' => -15,
			'LBRACE' => -15,
			"undef" => -15,
			"foreach my" => -15,
			"\@{" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_NAMED' => -15,
			'LITERAL_NUMBER' => -15,
			'WORD' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"for my integer" => -15,
			"my" => -15,
			"use constant" => 42,
			'OP01_OPEN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_PRINT' => -15,
			"if (" => -15,
			'LPAREN' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"%{" => -15,
			"our" => -15
		},
		GOTOS => {
			'STAR-7' => 68,
			'Constant' => 67
		}
	},
	{#State 60
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 69
		}
	},
	{#State 61
		ACTIONS => {
			"use constant" => -54,
			"## no critic qw(" => 7,
			"use" => -54,
			"our hash_ref \$properties" => -54
		},
		GOTOS => {
			'Critic' => 70,
			'STAR-21' => 71
		}
	},
	{#State 62
		ACTIONS => {
			'WORD' => 73,
			")" => 72
		}
	},
	{#State 63
		DEFAULT => -38
	},
	{#State 64
		ACTIONS => {
			"my" => 75
		},
		GOTOS => {
			'TypeInner' => 74
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 76
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		DEFAULT => -12
	},
	{#State 68
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 112,
			"while (" => -148,
			'OP01_CLOSE' => 109,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 78,
			"my" => 81,
			"for my integer" => -148,
			'LBRACE' => 88,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			"foreach my" => -148,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 87,
			'OP01_NAMED_VOID' => 96,
			'OP03_MATH_INC_DEC' => 90,
			"our" => 43,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP19_LOOP_CONTROL' => 106,
			'OP19_LOOP_CONTROL_SCOLON' => 104,
			'OP01_OPEN' => 105,
			'OP01_PRINT' => 107,
			"if (" => 101,
			'LPAREN' => 100
		},
		GOTOS => {
			'Operation' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 89,
			'PLUS-8' => 110,
			'Conditional' => 79,
			'OPTIONAL-39' => 77,
			'VariableDeclaration' => 82,
			'VariableModification' => 111,
			'Subroutine' => 99,
			'HashDereferenced' => 98,
			'Statement' => 120,
			'HashReference' => 108,
			'LoopLabel' => 123,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'Variable' => 95,
			'Operator' => 91,
			'Expression' => 93,
			'OperatorVoid' => 117,
			'PAREN-38' => 97,
			'Literal' => 119
		}
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		DEFAULT => -51
	},
	{#State 71
		ACTIONS => {
			"use constant" => -56,
			"our hash_ref \$properties" => -56,
			"use" => 33
		},
		GOTOS => {
			'Include' => 125,
			'STAR-22' => 124
		}
	},
	{#State 72
		ACTIONS => {
			";" => 126
		}
	},
	{#State 73
		DEFAULT => -37
	},
	{#State 74
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'Literal' => 127
		}
	},
	{#State 75
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 128
		}
	},
	{#State 76
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -43,
			'LITERAL_STRING' => -43,
			'WORD_SCOPED' => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			'LBRACKET' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_CLOSE' => -43,
			"( my" => 130,
			'OP01_NAMED_VOID_SCOLON' => -43,
			"while (" => -43,
			'LPAREN' => -43,
			"if (" => -43,
			'OP01_PRINT' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP01_OPEN' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			"%{" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED_VOID' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_NAMED' => -43,
			"\@{" => -43,
			'VARIABLE_SYMBOL' => -43,
			"undef" => -43,
			"foreach my" => -43,
			'LBRACE' => -43,
			"my" => -43,
			"for my integer" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'WORD' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 131,
			'OPTIONAL-16' => 129
		}
	},
	{#State 77
		ACTIONS => {
			"foreach my" => 134,
			"for my integer" => 133,
			"while (" => 138
		},
		GOTOS => {
			'LoopWhile' => 136,
			'LoopFor' => 135,
			'LoopForEach' => 137,
			'Loop' => 132
		}
	},
	{#State 78
		ACTIONS => {
			'LPAREN' => -207,
			'COLON' => -209,
			'OP02_METHOD_THINARROW' => -207
		}
	},
	{#State 79
		DEFAULT => -149
	},
	{#State 80
		ACTIONS => {
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'Literal' => 119,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'SubExpression' => 140,
			'HashReference' => 108,
			'HashDereferenced' => 98,
			'ArrayReference' => 113
		}
	},
	{#State 81
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 143
		}
	},
	{#State 82
		DEFAULT => -152
	},
	{#State 83
		DEFAULT => -135
	},
	{#State 84
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85,
			'LBRACKET' => 115
		},
		GOTOS => {
			'ArrayReference' => 145,
			'Variable' => 144
		}
	},
	{#State 85
		DEFAULT => -171,
		GOTOS => {
			'STAR-45' => 146
		}
	},
	{#State 86
		DEFAULT => -215
	},
	{#State 87
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'OP01_OPEN' => 105,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'KEYS_OR_VALUES' => 149,
			"my" => 75,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LBRACE' => 88
		},
		GOTOS => {
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'ListElement' => 148,
			'Literal' => 119,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'TypeInner' => 150,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashReference' => 108,
			'SubExpression' => 147
		}
	},
	{#State 88
		ACTIONS => {
			'WORD' => 153,
			"}" => 154,
			"%{" => 94
		},
		GOTOS => {
			'HashEntry' => 151,
			'HashDereferenced' => 152
		}
	},
	{#State 89
		ACTIONS => {
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 160,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP07_STRING_REPEAT' => 163,
			'OP13_BITWISE_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156
		}
	},
	{#State 90
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'Variable' => 172
		}
	},
	{#State 91
		DEFAULT => -130
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23
		},
		GOTOS => {
			'SubExpression' => 173,
			'HashReference' => 108,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'Literal' => 119,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141
		}
	},
	{#State 93
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP18_TERNARY' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP04_MATH_POW' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP08_STRING_CAT' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP13_BITWISE_AND' => -134,
			";" => 174,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP14_BITWISE_OR_XOR' => -134
		}
	},
	{#State 94
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85,
			'LBRACE' => 177
		},
		GOTOS => {
			'Variable' => 176,
			'HashReference' => 175
		}
	},
	{#State 95
		ACTIONS => {
			'OP13_BITWISE_AND' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 181,
			'OP09_BITWISE_SHIFT' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP03_MATH_INC_DEC' => 178,
			'OP06_REGEX_MATCH' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP08_STRING_CAT' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP04_MATH_POW' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP02_METHOD_THINARROW' => 179,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP19_VARIABLE_ASSIGN' => 180,
			'OP11_COMPARE_LT_GT' => -137,
			'OP18_TERNARY' => -137,
			'OP16_LOGICAL_OR' => -137
		}
	},
	{#State 96
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			'OP01_QW' => 185,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			"my" => 75,
			'KEYS_OR_VALUES' => 149,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP10_STRINGIFY_UNARY' => 118
		},
		GOTOS => {
			'Literal' => 119,
			'ListElement' => 184,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashReference' => 108,
			'SubExpression' => 183,
			'ArrayReference' => 113,
			'TypeInner' => 150,
			'ListElements' => 182,
			'HashDereferenced' => 98
		}
	},
	{#State 97
		DEFAULT => -147
	},
	{#State 98
		DEFAULT => -141
	},
	{#State 99
		DEFAULT => -14
	},
	{#State 100
		ACTIONS => {
			'OP01_PRINT' => 188,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'OP01_NAMED' => 187,
			'LITERAL_NUMBER' => 86,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109
		},
		GOTOS => {
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashReference' => 108,
			'SubExpression' => 186,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'Literal' => 119,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91
		}
	},
	{#State 101
		ACTIONS => {
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23,
			'OP01_OPEN' => 105,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP10_STRINGIFY_UNARY' => 118,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'Literal' => 119,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashReference' => 108,
			'SubExpression' => 189,
			'HashDereferenced' => 98,
			'ArrayReference' => 113
		}
	},
	{#State 102
		DEFAULT => -139
	},
	{#State 103
		ACTIONS => {
			'LPAREN' => 191,
			'OP02_METHOD_THINARROW' => 190
		}
	},
	{#State 104
		DEFAULT => -122
	},
	{#State 105
		ACTIONS => {
			"my" => 192
		}
	},
	{#State 106
		ACTIONS => {
			'WORD' => 193
		},
		GOTOS => {
			'LoopLabel' => 194
		}
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => -116,
			'OP22_LOGICAL_NEG' => -116,
			'LITERAL_STRING' => -116,
			'OP01_OPEN' => -116,
			"%{" => -116,
			'OP05_LOGICAL_NEG' => -116,
			'WORD_SCOPED' => -116,
			'OP03_MATH_INC_DEC' => -116,
			'FH_REF_SYMBOL_BRACES' => 196,
			'OP10_STRINGIFY_UNARY' => -116,
			'OP01_NAMED' => -116,
			'LITERAL_NUMBER' => -116,
			'OP01_QW' => -116,
			'VARIABLE_SYMBOL' => -116,
			"\@{" => -116,
			"undef" => -116,
			'LBRACE' => -116,
			'LBRACKET' => -116,
			'OP10_NAMED_UNARY' => -116,
			"my" => -116,
			'KEYS_OR_VALUES' => -116,
			'OP05_MATH_NEG_LPAREN' => -116,
			'OP01_CLOSE' => -116,
			'WORD' => -116,
			'STDOUT_STDERR' => 198
		},
		GOTOS => {
			'PAREN-33' => 195,
			'OPTIONAL-34' => 197
		}
	},
	{#State 108
		DEFAULT => -140
	},
	{#State 109
		ACTIONS => {
			'FH_REF_SYMBOL' => 199
		}
	},
	{#State 110
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'' => -18,
			'OP01_NAMED_VOID_SCOLON' => 112,
			"while (" => -148,
			'OP01_CLOSE' => 109,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'OP01_NAMED_VOID' => 96,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_PRINT' => 107,
			'OP19_LOOP_CONTROL_SCOLON' => 104,
			'OP01_OPEN' => 105,
			'OP19_LOOP_CONTROL' => 106,
			"if (" => 101,
			'LPAREN' => 100,
			"for my integer" => -148,
			"my" => 81,
			'WORD' => 78,
			'OP05_MATH_NEG_LPAREN' => 80,
			'LBRACE' => 88,
			'OP01_NAMED' => 87,
			'LITERAL_NUMBER' => 86,
			"foreach my" => -148,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84
		},
		GOTOS => {
			'OperatorVoid' => 117,
			'Operator' => 91,
			'Expression' => 93,
			'Variable' => 95,
			'PAREN-38' => 97,
			'Literal' => 119,
			'Statement' => 120,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'LoopLabel' => 123,
			'HashReference' => 108,
			'Conditional' => 79,
			'OPTIONAL-39' => 77,
			'VariableModification' => 111,
			'VariableDeclaration' => 82,
			'ArrayReference' => 113,
			'Operation' => 200,
			'SubExpression' => 89
		}
	},
	{#State 111
		DEFAULT => -153
	},
	{#State 112
		DEFAULT => -119
	},
	{#State 113
		DEFAULT => -138
	},
	{#State 114
		DEFAULT => -17
	},
	{#State 115
		ACTIONS => {
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			"]" => -191,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP01_QW' => 185,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			"my" => 75,
			'KEYS_OR_VALUES' => 149,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23
		},
		GOTOS => {
			'Literal' => 119,
			'ListElement' => 184,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'SubExpression' => 183,
			'HashReference' => 108,
			'HashDereferenced' => 98,
			'ListElements' => 202,
			'ArrayReference' => 113,
			'TypeInner' => 150,
			'OPTIONAL-49' => 201
		}
	},
	{#State 116
		ACTIONS => {
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'OP11_COMPARE_LT_GT' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP01_CLOSE' => 109,
			'OP08_MATH_ADD_SUB' => -101,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP13_BITWISE_AND' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			";" => -101,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP17_LIST_RANGE' => -101,
			'OP09_BITWISE_SHIFT' => -101,
			'WORD_SCOPED' => 24,
			'LBRACE' => 88,
			'OP23_LOGICAL_AND' => -101,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			"undef" => 83,
			'OP18_TERNARY' => -101,
			'OP16_LOGICAL_OR' => -101,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'OP04_MATH_POW' => -101,
			'OP07_MATH_MULT_DIV_MOD' => -101,
			")" => -101,
			'WORD' => 23,
			"}" => -101,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP06_REGEX_MATCH' => -101,
			'OP01_OPEN' => 105,
			'OP08_STRING_CAT' => -101,
			'OP07_STRING_REPEAT' => -101,
			'LPAREN' => 100,
			"]" => -101,
			'OP12_COMPARE_EQ_NE' => -101,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'Literal' => 119,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashReference' => 108,
			'SubExpression' => 203,
			'HashDereferenced' => 98,
			'ArrayReference' => 113
		}
	},
	{#State 117
		DEFAULT => -151
	},
	{#State 118
		ACTIONS => {
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP10_STRINGIFY_UNARY' => 118,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'WORD' => 23,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80
		},
		GOTOS => {
			'HashReference' => 108,
			'SubExpression' => 204,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'Literal' => 119,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141
		}
	},
	{#State 119
		DEFAULT => -136
	},
	{#State 120
		DEFAULT => -83
	},
	{#State 121
		DEFAULT => -214
	},
	{#State 122
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'Literal' => 119,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'HashReference' => 108,
			'SubExpression' => 205,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103
		}
	},
	{#State 123
		ACTIONS => {
			'COLON' => 206
		}
	},
	{#State 124
		ACTIONS => {
			"use constant" => 42,
			"our hash_ref \$properties" => 208
		},
		GOTOS => {
			'Properties' => 207,
			'Constant' => 209
		}
	},
	{#State 125
		DEFAULT => -53
	},
	{#State 126
		DEFAULT => -40
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
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP01_NAMED_VOID' => 96,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			"if (" => 101,
			'OP22_LOGICAL_NEG' => 122,
			'OP19_LOOP_CONTROL' => 106,
			'OP01_OPEN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 104,
			'OP01_PRINT' => 107,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 78,
			"my" => 81,
			"for my integer" => -148,
			'OP01_NAMED_VOID_SCOLON' => 112,
			"while (" => -148,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"foreach my" => -148,
			"undef" => 83,
			'OP01_NAMED' => 87,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88
		},
		GOTOS => {
			'Statement' => 120,
			'HashDereferenced' => 98,
			'HashReference' => 108,
			'ArrayDereferenced' => 102,
			'LoopLabel' => 123,
			'WordScoped' => 103,
			'PLUS-17' => 212,
			'Expression' => 93,
			'Operator' => 91,
			'Variable' => 95,
			'OperatorVoid' => 117,
			'Literal' => 119,
			'PAREN-38' => 97,
			'Operation' => 213,
			'ArrayReference' => 113,
			'SubExpression' => 89,
			'OPTIONAL-39' => 77,
			'Conditional' => 79,
			'VariableModification' => 111,
			'VariableDeclaration' => 82
		}
	},
	{#State 130
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 214
		}
	},
	{#State 131
		DEFAULT => -42
	},
	{#State 132
		DEFAULT => -150
	},
	{#State 133
		ACTIONS => {
			'VARIABLE_SYMBOL' => 215
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 216
		}
	},
	{#State 135
		DEFAULT => -161
	},
	{#State 136
		DEFAULT => -163
	},
	{#State 137
		DEFAULT => -162
	},
	{#State 138
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'WORD' => 23,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'SubExpression' => 217,
			'HashReference' => 108,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'Literal' => 119,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142
		}
	},
	{#State 139
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109
		},
		GOTOS => {
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'SubExpression' => 218,
			'HashReference' => 108,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'Literal' => 119,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91
		}
	},
	{#State 140
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 163,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			")" => 219,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 160,
			'OP18_TERNARY' => 168,
			'OP16_LOGICAL_OR' => 167
		}
	},
	{#State 141
		DEFAULT => -134
	},
	{#State 142
		ACTIONS => {
			'OP08_STRING_CAT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			";" => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			"]" => -137,
			'OP21_LIST_COMMA' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP03_MATH_INC_DEC' => 178,
			'OP09_BITWISE_SHIFT' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP18_TERNARY' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP02_METHOD_THINARROW' => 179,
			'OP04_MATH_POW' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			"}" => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			")" => -137
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 220
		}
	},
	{#State 144
		ACTIONS => {
			"}" => 221
		}
	},
	{#State 145
		ACTIONS => {
			"}" => 222
		}
	},
	{#State 146
		ACTIONS => {
			'OP02_METHOD_THINARROW' => -172,
			'COLON' => -172,
			'OP04_MATH_POW' => -172,
			'OP15_LOGICAL_AND' => -172,
			'OP02_ARRAY_THINARROW' => 225,
			"}" => -172,
			'OP24_LOGICAL_OR_XOR' => -172,
			")" => -172,
			'OP07_MATH_MULT_DIV_MOD' => -172,
			'OP23_LOGICAL_AND' => -172,
			'OP11_COMPARE_LT_GT' => -172,
			'OP19_VARIABLE_ASSIGN' => -172,
			'OP02_HASH_THINARROW' => 224,
			'OP16_LOGICAL_OR' => -172,
			'OP18_TERNARY' => -172,
			"]" => -172,
			'OP21_LIST_COMMA' => -172,
			'OP13_BITWISE_AND' => -172,
			'OP19_VARIABLE_ASSIGN_BY' => -172,
			'OP12_COMPARE_EQ_NE' => -172,
			";" => -172,
			'OP14_BITWISE_OR_XOR' => -172,
			'OP09_BITWISE_SHIFT' => -172,
			'OP17_LIST_RANGE' => -172,
			'OP03_MATH_INC_DEC' => -172,
			'OP06_REGEX_MATCH' => -172,
			'OP08_STRING_CAT' => -172,
			'OP08_MATH_ADD_SUB' => -172,
			'OP07_STRING_REPEAT' => -172
		},
		GOTOS => {
			'VariableRetrieval' => 223
		}
	},
	{#State 147
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP21_LIST_COMMA' => -187,
			'OP13_BITWISE_AND' => -85,
			";" => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_STRING_CAT' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			")" => -85,
			'OP04_MATH_POW' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP18_TERNARY' => -85,
			'OP23_LOGICAL_AND' => -85
		}
	},
	{#State 148
		ACTIONS => {
			'OP21_LIST_COMMA' => 226
		}
	},
	{#State 149
		ACTIONS => {
			"%{" => 94
		},
		GOTOS => {
			'HashDereferenced' => 227
		}
	},
	{#State 150
		ACTIONS => {
			'OP01_OPEN' => 105,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP10_STRINGIFY_UNARY' => 118,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23
		},
		GOTOS => {
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'Literal' => 119,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'SubExpression' => 228,
			'HashReference' => 108,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102
		}
	},
	{#State 151
		DEFAULT => -203,
		GOTOS => {
			'STAR-52' => 229
		}
	},
	{#State 152
		DEFAULT => -198
	},
	{#State 153
		ACTIONS => {
			'OP20_HASH_FATARROW' => 230
		}
	},
	{#State 154
		DEFAULT => -142
	},
	{#State 155
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84
		},
		GOTOS => {
			'Literal' => 119,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'SubExpression' => 231,
			'HashReference' => 108,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'ArrayReference' => 113,
			'HashDereferenced' => 98
		}
	},
	{#State 156
		ACTIONS => {
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'Literal' => 119,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashReference' => 108,
			'SubExpression' => 232,
			'ArrayReference' => 113,
			'HashDereferenced' => 98
		}
	},
	{#State 157
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'SubExpression' => 233,
			'HashReference' => 108,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'Literal' => 119
		}
	},
	{#State 158
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 105,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashReference' => 108,
			'SubExpression' => 234,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'Literal' => 119
		}
	},
	{#State 159
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 118
		},
		GOTOS => {
			'SubExpression' => 235,
			'HashReference' => 108,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'Literal' => 119,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142
		}
	},
	{#State 160
		ACTIONS => {
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23,
			'OP01_OPEN' => 105,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP10_STRINGIFY_UNARY' => 118,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'SubExpression' => 236,
			'HashReference' => 108,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'Literal' => 119
		}
	},
	{#State 161
		ACTIONS => {
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_OPEN' => 105,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 118
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashReference' => 108,
			'SubExpression' => 237,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142,
			'Literal' => 119
		}
	},
	{#State 162
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'OP01_OPEN' => 105,
			'WORD' => 23,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115
		},
		GOTOS => {
			'Literal' => 119,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashReference' => 108,
			'SubExpression' => 238,
			'ArrayReference' => 113,
			'HashDereferenced' => 98
		}
	},
	{#State 163
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'HashReference' => 108,
			'SubExpression' => 239,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'Literal' => 119
		}
	},
	{#State 164
		ACTIONS => {
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23
		},
		GOTOS => {
			'Literal' => 119,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashReference' => 108,
			'SubExpression' => 240,
			'HashDereferenced' => 98,
			'ArrayReference' => 113
		}
	},
	{#State 165
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 241
		}
	},
	{#State 166
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'WORD' => 23,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'Literal' => 119,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'HashReference' => 108,
			'SubExpression' => 242,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'ArrayReference' => 113,
			'HashDereferenced' => 98
		}
	},
	{#State 167
		ACTIONS => {
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23
		},
		GOTOS => {
			'Literal' => 119,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashReference' => 108,
			'SubExpression' => 243,
			'HashDereferenced' => 98,
			'ArrayReference' => 113
		}
	},
	{#State 168
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 121,
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'VariableOrLiteral' => 245,
			'Variable' => 244,
			'Literal' => 246
		}
	},
	{#State 169
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP10_STRINGIFY_UNARY' => 118
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'HashReference' => 108,
			'SubExpression' => 247,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142,
			'Literal' => 119
		}
	},
	{#State 170
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115
		},
		GOTOS => {
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'Literal' => 119,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'SubExpression' => 248,
			'HashReference' => 108,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103
		}
	},
	{#State 171
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'WORD' => 23,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP10_STRINGIFY_UNARY' => 118
		},
		GOTOS => {
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'SubExpression' => 249,
			'HashReference' => 108,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'Literal' => 119,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142
		}
	},
	{#State 172
		DEFAULT => -89
	},
	{#State 173
		ACTIONS => {
			'OP07_STRING_REPEAT' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP08_STRING_CAT' => -92,
			'OP06_REGEX_MATCH' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			";" => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP21_LIST_COMMA' => -92,
			"]" => -92,
			'OP18_TERNARY' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP23_LOGICAL_AND' => -92,
			")" => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			"}" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP04_MATH_POW' => 171
		}
	},
	{#State 174
		DEFAULT => -82
	},
	{#State 175
		ACTIONS => {
			"}" => 250
		}
	},
	{#State 176
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 177
		ACTIONS => {
			'WORD' => 153,
			"%{" => 94
		},
		GOTOS => {
			'HashDereferenced' => 152,
			'HashEntry' => 151
		}
	},
	{#State 178
		DEFAULT => -90
	},
	{#State 179
		ACTIONS => {
			'LPAREN' => 252
		}
	},
	{#State 180
		ACTIONS => {
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'STDIN' => 255,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23,
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'SubExpression' => 253,
			'HashReference' => 108,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'Literal' => 119,
			'SubExpressionOrStdin' => 254,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142
		}
	},
	{#State 181
		ACTIONS => {
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'Literal' => 119,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'SubExpression' => 256,
			'HashReference' => 108,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102
		}
	},
	{#State 182
		ACTIONS => {
			";" => 257
		}
	},
	{#State 183
		ACTIONS => {
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP24_LOGICAL_OR_XOR' => 161,
			")" => -187,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP11_COMPARE_LT_GT' => 160,
			'OP12_COMPARE_EQ_NE' => 166,
			";" => -187,
			'OP14_BITWISE_OR_XOR' => 158,
			"]" => -187,
			'OP21_LIST_COMMA' => -187,
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163
		}
	},
	{#State 184
		DEFAULT => -182,
		GOTOS => {
			'STAR-47' => 258
		}
	},
	{#State 185
		ACTIONS => {
			'WORD' => 260
		},
		GOTOS => {
			'PLUS-48' => 259
		}
	},
	{#State 186
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => 261,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP11_COMPARE_LT_GT' => 160,
			'OP18_TERNARY' => 168,
			'OP16_LOGICAL_OR' => 167,
			'OP23_LOGICAL_AND' => 169,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP07_STRING_REPEAT' => 163,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 187
		ACTIONS => {
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			"my" => 75,
			'KEYS_OR_VALUES' => 149,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23,
			'OP01_OPEN' => 105,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP10_STRINGIFY_UNARY' => 118,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142,
			'Literal' => 119,
			'ListElement' => 262,
			'TypeInner' => 150,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'SubExpression' => 147,
			'HashReference' => 108
		}
	},
	{#State 188
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 263
		}
	},
	{#State 189
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP13_BITWISE_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP07_STRING_REPEAT' => 163,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => 264,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 160,
			'OP18_TERNARY' => 168,
			'OP16_LOGICAL_OR' => 167,
			'OP23_LOGICAL_AND' => 169
		}
	},
	{#State 190
		ACTIONS => {
			'LPAREN' => 265
		}
	},
	{#State 191
		ACTIONS => {
			'KEYS_OR_VALUES' => 149,
			"my" => 75,
			'WORD' => 23,
			")" => -125,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'OP01_QW' => 185,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'TypeInner' => 150,
			'ListElements' => 267,
			'WordScoped' => 103,
			'OPTIONAL-35' => 266,
			'ArrayDereferenced' => 102,
			'SubExpression' => 183,
			'HashReference' => 108,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'Literal' => 119,
			'ListElement' => 184
		}
	},
	{#State 192
		ACTIONS => {
			"filehandle_ref" => 268
		}
	},
	{#State 193
		DEFAULT => -209
	},
	{#State 194
		ACTIONS => {
			";" => 269
		}
	},
	{#State 195
		DEFAULT => -115
	},
	{#State 196
		ACTIONS => {
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP10_STRINGIFY_UNARY' => 118,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			"my" => 75,
			'KEYS_OR_VALUES' => 149,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP01_QW' => 185,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115
		},
		GOTOS => {
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'Literal' => 119,
			'ListElement' => 184,
			'ListElements' => 270,
			'TypeInner' => 150,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'SubExpression' => 183,
			'HashReference' => 108
		}
	},
	{#State 197
		ACTIONS => {
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 23,
			"my" => 75,
			'KEYS_OR_VALUES' => 149,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			'OP01_QW' => 185,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_OPEN' => 105
		},
		GOTOS => {
			'ListElement' => 184,
			'Literal' => 119,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'SubExpression' => 183,
			'HashReference' => 108,
			'TypeInner' => 150,
			'ArrayReference' => 113,
			'ListElements' => 271,
			'HashDereferenced' => 98
		}
	},
	{#State 198
		DEFAULT => -114
	},
	{#State 199
		DEFAULT => -88
	},
	{#State 200
		DEFAULT => -16
	},
	{#State 201
		ACTIONS => {
			"]" => 272
		}
	},
	{#State 202
		DEFAULT => -190
	},
	{#State 203
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163,
			";" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			"]" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP18_TERNARY' => -100,
			'OP11_COMPARE_LT_GT' => -100,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -100,
			"}" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => -100
		}
	},
	{#State 204
		ACTIONS => {
			'OP07_STRING_REPEAT' => 163,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP11_COMPARE_LT_GT' => 160,
			'OP23_LOGICAL_AND' => 169,
			'OP24_LOGICAL_OR_XOR' => 161,
			")" => 273,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162
		}
	},
	{#State 205
		ACTIONS => {
			'OP07_STRING_REPEAT' => 163,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP21_LIST_COMMA' => -111,
			"]" => -111,
			'OP13_BITWISE_AND' => 159,
			";" => -111,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP11_COMPARE_LT_GT' => 160,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP23_LOGICAL_AND' => -111,
			'OP24_LOGICAL_OR_XOR' => -111,
			"}" => -111,
			")" => -111,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171
		}
	},
	{#State 206
		DEFAULT => -146
	},
	{#State 207
		ACTIONS => {
			"our hash_ref \$class_properties" => 274,
			'LITERAL_NUMBER' => -58,
			"our" => -58
		},
		GOTOS => {
			'PropertiesClass' => 275,
			'OPTIONAL-23' => 276
		}
	},
	{#State 208
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 277
		}
	},
	{#State 209
		DEFAULT => -55
	},
	{#State 210
		DEFAULT => -41
	},
	{#State 211
		ACTIONS => {
			'WORD' => 278
		}
	},
	{#State 212
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 112,
			"while (" => -148,
			'OP01_CLOSE' => 109,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			"my" => 81,
			"for my integer" => -148,
			"}" => 280,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 78,
			'LBRACE' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 87,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"foreach my" => -148,
			"undef" => 83,
			'OP01_NAMED_VOID' => 96,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_PRINT' => 107,
			'OP19_LOOP_CONTROL' => 106,
			'OP19_LOOP_CONTROL_SCOLON' => 104,
			'OP01_OPEN' => 105,
			'LPAREN' => 100,
			"if (" => 101
		},
		GOTOS => {
			'Literal' => 119,
			'PAREN-38' => 97,
			'OperatorVoid' => 117,
			'Variable' => 95,
			'Operator' => 91,
			'Expression' => 93,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'LoopLabel' => 123,
			'HashReference' => 108,
			'HashDereferenced' => 98,
			'Statement' => 120,
			'VariableDeclaration' => 82,
			'VariableModification' => 111,
			'OPTIONAL-39' => 77,
			'Conditional' => 79,
			'SubExpression' => 89,
			'ArrayReference' => 113,
			'Operation' => 279
		}
	},
	{#State 213
		DEFAULT => -45
	},
	{#State 214
		ACTIONS => {
			'VARIABLE_SYMBOL' => 281
		}
	},
	{#State 215
		ACTIONS => {
			'LPAREN' => 282
		}
	},
	{#State 216
		ACTIONS => {
			'VARIABLE_SYMBOL' => 283
		}
	},
	{#State 217
		ACTIONS => {
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP24_LOGICAL_OR_XOR' => 161,
			")" => 284,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 160,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP13_BITWISE_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP07_STRING_REPEAT' => 163
		}
	},
	{#State 218
		ACTIONS => {
			'OP18_TERNARY' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP23_LOGICAL_AND' => -85,
			")" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			"}" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP04_MATH_POW' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			";" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP13_BITWISE_AND' => -85,
			"]" => -85,
			'OP21_LIST_COMMA' => -85
		}
	},
	{#State 219
		DEFAULT => -93
	},
	{#State 220
		ACTIONS => {
			";" => 285,
			'OP19_VARIABLE_ASSIGN' => 286
		}
	},
	{#State 221
		DEFAULT => -193
	},
	{#State 222
		DEFAULT => -194
	},
	{#State 223
		DEFAULT => -170
	},
	{#State 224
		ACTIONS => {
			'WORD' => 287,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'OP01_OPEN' => 105
		},
		GOTOS => {
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'Literal' => 119,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'SubExpression' => 288,
			'HashReference' => 108,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102
		}
	},
	{#State 225
		ACTIONS => {
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'Literal' => 119,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'HashReference' => 108,
			'SubExpression' => 289,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103
		}
	},
	{#State 226
		ACTIONS => {
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP01_QW' => 185,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'KEYS_OR_VALUES' => 149,
			"my" => 75,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP10_STRINGIFY_UNARY' => 118
		},
		GOTOS => {
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'Literal' => 119,
			'ListElement' => 184,
			'TypeInner' => 150,
			'ArrayReference' => 113,
			'ListElements' => 290,
			'HashDereferenced' => 98,
			'HashReference' => 108,
			'SubExpression' => 183,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102
		}
	},
	{#State 227
		DEFAULT => -189
	},
	{#State 228
		ACTIONS => {
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP11_COMPARE_LT_GT' => 160,
			'OP23_LOGICAL_AND' => 169,
			'OP24_LOGICAL_OR_XOR' => 161,
			")" => -188,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			'OP07_STRING_REPEAT' => 163,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP12_COMPARE_EQ_NE' => 166,
			";" => -188,
			'OP14_BITWISE_OR_XOR' => 158,
			"]" => -188,
			'OP21_LIST_COMMA' => -188,
			'OP13_BITWISE_AND' => 159
		}
	},
	{#State 229
		ACTIONS => {
			'OP21_LIST_COMMA' => 293,
			"}" => 291
		},
		GOTOS => {
			'PAREN-51' => 292
		}
	},
	{#State 230
		ACTIONS => {
			'LPAREN' => -196,
			'OP22_LOGICAL_NEG' => -196,
			'LITERAL_STRING' => -196,
			'OP01_OPEN' => -196,
			"%{" => -196,
			'OP05_LOGICAL_NEG' => -196,
			'WORD_SCOPED' => -196,
			'OP03_MATH_INC_DEC' => -196,
			'OP10_STRINGIFY_UNARY' => -196,
			'OP01_NAMED' => -196,
			'LITERAL_NUMBER' => -196,
			'VARIABLE_SYMBOL' => -196,
			"\@{" => -196,
			"undef" => -196,
			'LBRACE' => -196,
			'LBRACKET' => -196,
			'OP10_NAMED_UNARY' => -196,
			"my" => 75,
			'OP01_CLOSE' => -196,
			'OP05_MATH_NEG_LPAREN' => -196,
			'WORD' => -196
		},
		GOTOS => {
			'TypeInner' => 294,
			'OPTIONAL-50' => 295
		}
	},
	{#State 231
		ACTIONS => {
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => -97,
			'OP08_MATH_ADD_SUB' => -97,
			'OP07_STRING_REPEAT' => 163,
			'OP21_LIST_COMMA' => -97,
			"]" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			";" => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP18_TERNARY' => -97,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			"}" => -97,
			")" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 170
		}
	},
	{#State 232
		ACTIONS => {
			'OP23_LOGICAL_AND' => -99,
			'OP18_TERNARY' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => -99,
			"}" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163,
			'OP12_COMPARE_EQ_NE' => -99,
			";" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP21_LIST_COMMA' => -99,
			"]" => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP17_LIST_RANGE' => -99
		}
	},
	{#State 233
		ACTIONS => {
			'OP07_STRING_REPEAT' => 163,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 156,
			";" => -109,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			"]" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP13_BITWISE_AND' => 159,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => -109,
			'OP11_COMPARE_LT_GT' => 160,
			'OP23_LOGICAL_AND' => -109,
			"}" => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			")" => -109,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171
		}
	},
	{#State 234
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 160,
			'OP18_TERNARY' => -106,
			'OP16_LOGICAL_OR' => -106,
			'OP23_LOGICAL_AND' => -106,
			")" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP24_LOGICAL_OR_XOR' => -106,
			"}" => -106,
			'OP15_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 171,
			'OP07_STRING_REPEAT' => 163,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP17_LIST_RANGE' => -106,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 159,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			";" => -106,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => -106
		}
	},
	{#State 235
		ACTIONS => {
			'OP18_TERNARY' => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP11_COMPARE_LT_GT' => 160,
			'OP23_LOGICAL_AND' => -105,
			")" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			"}" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -105,
			'OP07_STRING_REPEAT' => 163,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP06_REGEX_MATCH' => 165,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => -105,
			'OP14_BITWISE_OR_XOR' => -105,
			";" => -105,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP13_BITWISE_AND' => -105,
			'OP21_LIST_COMMA' => -105,
			"]" => -105
		}
	},
	{#State 236
		ACTIONS => {
			'OP23_LOGICAL_AND' => -103,
			'OP18_TERNARY' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP11_COMPARE_LT_GT' => undef,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => -103,
			"}" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163,
			";" => -103,
			'OP12_COMPARE_EQ_NE' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP13_BITWISE_AND' => -103,
			'OP21_LIST_COMMA' => -103,
			"]" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP09_BITWISE_SHIFT' => 156
		}
	},
	{#State 237
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 166,
			";" => -113,
			'OP14_BITWISE_OR_XOR' => 158,
			"]" => -113,
			'OP21_LIST_COMMA' => -113,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			"}" => -113,
			'OP24_LOGICAL_OR_XOR' => -113,
			")" => -113,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP11_COMPARE_LT_GT' => 160
		}
	},
	{#State 238
		ACTIONS => {
			'OP23_LOGICAL_AND' => -107,
			'OP16_LOGICAL_OR' => -107,
			'OP18_TERNARY' => -107,
			'OP11_COMPARE_LT_GT' => 160,
			'OP15_LOGICAL_AND' => -107,
			'OP04_MATH_POW' => 171,
			"}" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => -107,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163,
			'OP12_COMPARE_EQ_NE' => 166,
			";" => -107,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP21_LIST_COMMA' => -107,
			"]" => -107,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => -107
		}
	},
	{#State 239
		ACTIONS => {
			'OP07_STRING_REPEAT' => -95,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => -95,
			'OP08_STRING_CAT' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP13_BITWISE_AND' => -95,
			"]" => -95,
			'OP21_LIST_COMMA' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			";" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP18_TERNARY' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP23_LOGICAL_AND' => -95,
			")" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			"}" => -95,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -95
		}
	},
	{#State 240
		ACTIONS => {
			'OP23_LOGICAL_AND' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP18_TERNARY' => -98,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			"}" => -98,
			")" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => -98,
			'OP08_MATH_ADD_SUB' => 155,
			'OP07_STRING_REPEAT' => 163,
			"]" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			";" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP09_BITWISE_SHIFT' => -98,
			'OP17_LIST_RANGE' => -98
		}
	},
	{#State 241
		DEFAULT => -94
	},
	{#State 242
		ACTIONS => {
			'OP13_BITWISE_AND' => -104,
			'OP21_LIST_COMMA' => -104,
			"]" => -104,
			";" => -104,
			'OP14_BITWISE_OR_XOR' => -104,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => -104,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 163,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			"}" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 160,
			'OP18_TERNARY' => -104,
			'OP16_LOGICAL_OR' => -104
		}
	},
	{#State 243
		ACTIONS => {
			'OP17_LIST_RANGE' => -108,
			'OP09_BITWISE_SHIFT' => 156,
			";" => -108,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP13_BITWISE_AND' => 159,
			'OP21_LIST_COMMA' => -108,
			"]" => -108,
			'OP07_STRING_REPEAT' => 163,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP06_REGEX_MATCH' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => -108,
			"}" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			'OP18_TERNARY' => -108,
			'OP16_LOGICAL_OR' => -108,
			'OP11_COMPARE_LT_GT' => 160,
			'OP23_LOGICAL_AND' => -108
		}
	},
	{#State 244
		DEFAULT => -212
	},
	{#State 245
		ACTIONS => {
			'COLON' => 296
		}
	},
	{#State 246
		DEFAULT => -213
	},
	{#State 247
		ACTIONS => {
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			"}" => -112,
			'OP24_LOGICAL_OR_XOR' => -112,
			")" => -112,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP23_LOGICAL_AND' => -112,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP11_COMPARE_LT_GT' => 160,
			";" => -112,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP21_LIST_COMMA' => -112,
			"]" => -112,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163
		}
	},
	{#State 248
		ACTIONS => {
			'OP18_TERNARY' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP23_LOGICAL_AND' => -96,
			")" => -96,
			'OP07_MATH_MULT_DIV_MOD' => -96,
			"}" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP04_MATH_POW' => 171,
			'OP07_STRING_REPEAT' => 163,
			'OP08_MATH_ADD_SUB' => -96,
			'OP08_STRING_CAT' => -96,
			'OP06_REGEX_MATCH' => 165,
			'OP09_BITWISE_SHIFT' => -96,
			'OP17_LIST_RANGE' => -96,
			";" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP13_BITWISE_AND' => -96,
			"]" => -96,
			'OP21_LIST_COMMA' => -96
		}
	},
	{#State 249
		ACTIONS => {
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => -91,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			")" => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP18_TERNARY' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			";" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			"]" => -91,
			'OP21_LIST_COMMA' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP08_STRING_CAT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP06_REGEX_MATCH' => -91,
			'OP07_STRING_REPEAT' => -91
		}
	},
	{#State 250
		DEFAULT => -206
	},
	{#State 251
		DEFAULT => -205
	},
	{#State 252
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			")" => -127,
			'WORD' => 23,
			"my" => 75,
			'KEYS_OR_VALUES' => 149,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP01_QW' => 185,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122
		},
		GOTOS => {
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142,
			'Literal' => 119,
			'ListElement' => 184,
			'ListElements' => 298,
			'TypeInner' => 150,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashReference' => 108,
			'SubExpression' => 183,
			'OPTIONAL-36' => 297
		}
	},
	{#State 253
		ACTIONS => {
			";" => -144,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP23_LOGICAL_AND' => 169,
			'OP18_TERNARY' => 168,
			'OP16_LOGICAL_OR' => 167,
			'OP11_COMPARE_LT_GT' => 160
		}
	},
	{#State 254
		ACTIONS => {
			";" => 299
		}
	},
	{#State 255
		DEFAULT => -145
	},
	{#State 256
		ACTIONS => {
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP23_LOGICAL_AND' => 169,
			'OP18_TERNARY' => 168,
			'OP16_LOGICAL_OR' => 167,
			'OP11_COMPARE_LT_GT' => 160,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			";" => 300,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP06_REGEX_MATCH' => 165,
			'OP07_STRING_REPEAT' => 163
		}
	},
	{#State 257
		DEFAULT => -120
	},
	{#State 258
		ACTIONS => {
			";" => -185,
			"]" => -185,
			'OP21_LIST_COMMA' => 301,
			")" => -185
		},
		GOTOS => {
			'PAREN-46' => 302
		}
	},
	{#State 259
		ACTIONS => {
			")" => 303,
			'WORD' => 304
		}
	},
	{#State 260
		DEFAULT => -184
	},
	{#State 261
		DEFAULT => -143
	},
	{#State 262
		ACTIONS => {
			'OP21_LIST_COMMA' => 305
		}
	},
	{#State 263
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'OP01_OPEN' => 105,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'KEYS_OR_VALUES' => 149,
			"my" => 75,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'OP01_QW' => 185,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88
		},
		GOTOS => {
			'HashReference' => 108,
			'SubExpression' => 183,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'TypeInner' => 150,
			'ListElements' => 306,
			'Literal' => 119,
			'ListElement' => 184,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141
		}
	},
	{#State 264
		ACTIONS => {
			'LBRACE' => 307
		},
		GOTOS => {
			'CodeBlock' => 308
		}
	},
	{#State 265
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			")" => -129,
			'WORD' => 23,
			"my" => 75,
			'KEYS_OR_VALUES' => 149,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			'OP01_QW' => 185
		},
		GOTOS => {
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashReference' => 108,
			'SubExpression' => 183,
			'TypeInner' => 150,
			'ListElements' => 309,
			'OPTIONAL-37' => 310,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'ListElement' => 184,
			'Literal' => 119,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142
		}
	},
	{#State 266
		ACTIONS => {
			")" => 311
		}
	},
	{#State 267
		DEFAULT => -124
	},
	{#State 268
		ACTIONS => {
			'FH_REF_SYMBOL' => 312
		}
	},
	{#State 269
		DEFAULT => -123
	},
	{#State 270
		ACTIONS => {
			";" => 313
		}
	},
	{#State 271
		ACTIONS => {
			";" => 314
		}
	},
	{#State 272
		DEFAULT => -192
	},
	{#State 273
		DEFAULT => -102
	},
	{#State 274
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 315
		}
	},
	{#State 275
		DEFAULT => -57
	},
	{#State 276
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 316
		}
	},
	{#State 277
		ACTIONS => {
			'LBRACE' => 317
		}
	},
	{#State 278
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 318
		}
	},
	{#State 279
		DEFAULT => -44
	},
	{#State 280
		ACTIONS => {
			";" => 319
		}
	},
	{#State 281
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 320
		}
	},
	{#State 282
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122
		},
		GOTOS => {
			'Literal' => 119,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'HashReference' => 108,
			'SubExpression' => 321,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'ArrayReference' => 113,
			'HashDereferenced' => 98
		}
	},
	{#State 283
		ACTIONS => {
			'LPAREN' => 322
		}
	},
	{#State 284
		ACTIONS => {
			'LBRACE' => 307
		},
		GOTOS => {
			'CodeBlock' => 323
		}
	},
	{#State 285
		DEFAULT => -176
	},
	{#State 286
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'STDIN' => 255,
			"undef" => 83,
			'OP10_STRINGIFY_UNARY' => 118,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 105,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121
		},
		GOTOS => {
			'Literal' => 119,
			'SubExpressionOrStdin' => 324,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'HashReference' => 108,
			'SubExpression' => 253,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashDereferenced' => 98,
			'ArrayReference' => 113
		}
	},
	{#State 287
		ACTIONS => {
			'OP02_METHOD_THINARROW' => -207,
			'LPAREN' => -207,
			"}" => 325
		}
	},
	{#State 288
		ACTIONS => {
			"}" => 326,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP11_COMPARE_LT_GT' => 160,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP23_LOGICAL_AND' => 169,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP07_STRING_REPEAT' => 163,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155
		}
	},
	{#State 289
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 160,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP23_LOGICAL_AND' => 169,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			'OP07_STRING_REPEAT' => 163,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			"]" => 327,
			'OP13_BITWISE_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 166
		}
	},
	{#State 290
		ACTIONS => {
			";" => 328
		}
	},
	{#State 291
		DEFAULT => -204
	},
	{#State 292
		DEFAULT => -202
	},
	{#State 293
		ACTIONS => {
			'WORD' => 153,
			"%{" => 94
		},
		GOTOS => {
			'HashDereferenced' => 152,
			'HashEntry' => 329
		}
	},
	{#State 294
		DEFAULT => -195
	},
	{#State 295
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP10_STRINGIFY_UNARY' => 118,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'OP01_OPEN' => 105,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LBRACE' => 88
		},
		GOTOS => {
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'SubExpression' => 330,
			'HashReference' => 108,
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'Literal' => 119,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142
		}
	},
	{#State 296
		ACTIONS => {
			'LITERAL_STRING' => 121,
			'VARIABLE_SYMBOL' => 85,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 246,
			'VariableOrLiteral' => 331,
			'Variable' => 244
		}
	},
	{#State 297
		ACTIONS => {
			")" => 332
		}
	},
	{#State 298
		DEFAULT => -126
	},
	{#State 299
		DEFAULT => -178
	},
	{#State 300
		DEFAULT => -179
	},
	{#State 301
		ACTIONS => {
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'OP01_OPEN' => 105,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP10_STRINGIFY_UNARY' => 118,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LBRACE' => 88,
			'WORD' => 23,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'KEYS_OR_VALUES' => 149,
			"my" => 75
		},
		GOTOS => {
			'ArrayReference' => 113,
			'TypeInner' => 150,
			'HashDereferenced' => 98,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'SubExpression' => 183,
			'HashReference' => 108,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'ListElement' => 333,
			'Literal' => 119
		}
	},
	{#State 302
		DEFAULT => -181
	},
	{#State 303
		DEFAULT => -186
	},
	{#State 304
		DEFAULT => -183
	},
	{#State 305
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'KEYS_OR_VALUES' => 149,
			"my" => 75,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP01_QW' => 185,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84
		},
		GOTOS => {
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'SubExpression' => 183,
			'HashReference' => 108,
			'ListElements' => 334,
			'ArrayReference' => 113,
			'TypeInner' => 150,
			'HashDereferenced' => 98,
			'ListElement' => 184,
			'Literal' => 119,
			'Operator' => 91,
			'Expression' => 141,
			'Variable' => 142
		}
	},
	{#State 306
		ACTIONS => {
			")" => 335
		}
	},
	{#State 307
		ACTIONS => {
			'OP01_PRINT' => 107,
			'OP19_LOOP_CONTROL' => 106,
			'OP01_OPEN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 104,
			'LPAREN' => 100,
			"if (" => 101,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP01_NAMED_VOID' => 96,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 87,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"foreach my" => -148,
			"undef" => 83,
			'OP01_NAMED_VOID_SCOLON' => 112,
			"while (" => -148,
			"my" => 81,
			"for my integer" => -148,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 78
		},
		GOTOS => {
			'ArrayReference' => 113,
			'Operation' => 337,
			'SubExpression' => 89,
			'OPTIONAL-39' => 77,
			'Conditional' => 79,
			'PLUS-44' => 336,
			'VariableDeclaration' => 82,
			'VariableModification' => 111,
			'HashDereferenced' => 98,
			'Statement' => 120,
			'ArrayDereferenced' => 102,
			'LoopLabel' => 123,
			'WordScoped' => 103,
			'HashReference' => 108,
			'OperatorVoid' => 117,
			'Variable' => 95,
			'Expression' => 93,
			'Operator' => 91,
			'Literal' => 119,
			'PAREN-38' => 97
		}
	},
	{#State 308
		DEFAULT => -156,
		GOTOS => {
			'STAR-41' => 338
		}
	},
	{#State 309
		DEFAULT => -128
	},
	{#State 310
		ACTIONS => {
			")" => 339
		}
	},
	{#State 311
		DEFAULT => -131
	},
	{#State 312
		ACTIONS => {
			'OP21_LIST_COMMA' => 340
		}
	},
	{#State 313
		DEFAULT => -118
	},
	{#State 314
		DEFAULT => -117
	},
	{#State 315
		ACTIONS => {
			'LBRACE' => 341
		}
	},
	{#State 316
		ACTIONS => {
			'LITERAL_NUMBER' => 344,
			"our" => 345
		},
		GOTOS => {
			'MethodOrSubroutine' => 342,
			'Method' => 343,
			'Subroutine' => 346
		}
	},
	{#State 317
		ACTIONS => {
			'WORD' => 348,
			"}" => 349,
			"%{" => 94
		},
		GOTOS => {
			'HashEntryTyped' => 347,
			'HashDereferenced' => 350
		}
	},
	{#State 318
		DEFAULT => -211
	},
	{#State 319
		DEFAULT => -46
	},
	{#State 320
		ACTIONS => {
			")" => 352,
			'OP21_LIST_COMMA' => 353
		},
		GOTOS => {
			'PAREN-18' => 351
		}
	},
	{#State 321
		ACTIONS => {
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 160,
			'OP18_TERNARY' => 168,
			'OP16_LOGICAL_OR' => 167,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 163,
			'OP13_BITWISE_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 354
		}
	},
	{#State 322
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'OP01_OPEN' => 105,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'KEYS_OR_VALUES' => 149,
			"my" => 75,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'OP01_QW' => 185,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'TypeInner' => 150,
			'ListElements' => 355,
			'ArrayReference' => 113,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashReference' => 108,
			'SubExpression' => 183,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'ListElement' => 184,
			'Literal' => 119
		}
	},
	{#State 323
		DEFAULT => -166
	},
	{#State 324
		ACTIONS => {
			";" => 356
		}
	},
	{#State 325
		DEFAULT => -175
	},
	{#State 326
		DEFAULT => -174
	},
	{#State 327
		DEFAULT => -173
	},
	{#State 328
		DEFAULT => -121
	},
	{#State 329
		DEFAULT => -201
	},
	{#State 330
		ACTIONS => {
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 160,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			'OP24_LOGICAL_OR_XOR' => 161,
			"}" => -197,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP07_STRING_REPEAT' => 163,
			'OP21_LIST_COMMA' => -197,
			'OP13_BITWISE_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 157
		}
	},
	{#State 331
		DEFAULT => -110
	},
	{#State 332
		DEFAULT => -132
	},
	{#State 333
		DEFAULT => -180
	},
	{#State 334
		ACTIONS => {
			")" => 357
		}
	},
	{#State 335
		DEFAULT => -84
	},
	{#State 336
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 106,
			'OP19_LOOP_CONTROL_SCOLON' => 104,
			'OP01_OPEN' => 105,
			'OP01_PRINT' => 107,
			'LPAREN' => 100,
			"if (" => 101,
			'OP01_NAMED_VOID' => 96,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'LBRACE' => 88,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			"foreach my" => -148,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 87,
			'OP05_MATH_NEG_LPAREN' => 80,
			"}" => 359,
			'WORD' => 78,
			"my" => 81,
			"for my integer" => -148,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'OP01_NAMED_VOID_SCOLON' => 112,
			"while (" => -148,
			'OP01_CLOSE' => 109
		},
		GOTOS => {
			'Operation' => 358,
			'ArrayReference' => 113,
			'SubExpression' => 89,
			'OPTIONAL-39' => 77,
			'Conditional' => 79,
			'VariableDeclaration' => 82,
			'VariableModification' => 111,
			'HashDereferenced' => 98,
			'Statement' => 120,
			'HashReference' => 108,
			'ArrayDereferenced' => 102,
			'LoopLabel' => 123,
			'WordScoped' => 103,
			'Variable' => 95,
			'Operator' => 91,
			'Expression' => 93,
			'OperatorVoid' => 117,
			'Literal' => 119,
			'PAREN-38' => 97
		}
	},
	{#State 337
		DEFAULT => -168
	},
	{#State 338
		ACTIONS => {
			"\@{" => -159,
			'VARIABLE_SYMBOL' => -159,
			"foreach my" => -159,
			"undef" => -159,
			'OP01_NAMED' => -159,
			'LITERAL_NUMBER' => -159,
			'LBRACE' => -159,
			'OP05_MATH_NEG_LPAREN' => -159,
			"}" => -159,
			'WORD' => -159,
			"my" => -159,
			"for my integer" => -159,
			"if (" => -159,
			'LPAREN' => -159,
			'OP19_LOOP_CONTROL' => -159,
			'OP01_OPEN' => -159,
			'OP19_LOOP_CONTROL_SCOLON' => -159,
			'OP01_PRINT' => -159,
			'OP03_MATH_INC_DEC' => -159,
			"%{" => -159,
			'OP05_LOGICAL_NEG' => -159,
			'OP01_NAMED_VOID' => -159,
			"elsif (" => 363,
			'OP10_NAMED_UNARY' => -159,
			'LBRACKET' => -159,
			"else" => 362,
			'OP01_CLOSE' => -159,
			"while (" => -159,
			'OP01_NAMED_VOID_SCOLON' => -159,
			'LITERAL_STRING' => -159,
			'' => -159,
			'OP22_LOGICAL_NEG' => -159,
			'WORD_SCOPED' => -159,
			'OP10_STRINGIFY_UNARY' => -159
		},
		GOTOS => {
			'OPTIONAL-43' => 361,
			'PAREN-40' => 364,
			'PAREN-42' => 360
		}
	},
	{#State 339
		DEFAULT => -133
	},
	{#State 340
		ACTIONS => {
			'LITERAL_STRING' => 365
		}
	},
	{#State 341
		ACTIONS => {
			'WORD' => 348,
			"%{" => 94
		},
		GOTOS => {
			'HashDereferenced' => 350,
			'HashEntryTyped' => 366
		}
	},
	{#State 342
		DEFAULT => -59
	},
	{#State 343
		DEFAULT => -80
	},
	{#State 344
		ACTIONS => {
			";" => 367
		}
	},
	{#State 345
		ACTIONS => {
			'TYPE_METHOD' => 368,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 346
		DEFAULT => -81
	},
	{#State 347
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 369
		}
	},
	{#State 348
		ACTIONS => {
			'OP20_HASH_FATARROW' => 370
		}
	},
	{#State 349
		ACTIONS => {
			";" => 371
		}
	},
	{#State 350
		DEFAULT => -200
	},
	{#State 351
		DEFAULT => -48
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 372
		}
	},
	{#State 353
		ACTIONS => {
			"my" => 373
		}
	},
	{#State 354
		ACTIONS => {
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			"undef" => 83,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 86,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_OPEN' => 105,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 118
		},
		GOTOS => {
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'SubExpression' => 374,
			'HashReference' => 108,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'Variable' => 142,
			'Expression' => 141,
			'Operator' => 91,
			'Literal' => 119
		}
	},
	{#State 355
		ACTIONS => {
			")" => 375
		}
	},
	{#State 356
		DEFAULT => -177
	},
	{#State 357
		DEFAULT => -86
	},
	{#State 358
		DEFAULT => -167
	},
	{#State 359
		DEFAULT => -169
	},
	{#State 360
		DEFAULT => -158
	},
	{#State 361
		DEFAULT => -160
	},
	{#State 362
		ACTIONS => {
			'LBRACE' => 307
		},
		GOTOS => {
			'CodeBlock' => 376
		}
	},
	{#State 363
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			'VARIABLE_SYMBOL' => 85,
			"\@{" => 84,
			'OP10_NAMED_UNARY' => 116,
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'OP01_OPEN' => 105,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP10_STRINGIFY_UNARY' => 118
		},
		GOTOS => {
			'Literal' => 119,
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'SubExpression' => 377,
			'HashReference' => 108,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashDereferenced' => 98,
			'ArrayReference' => 113
		}
	},
	{#State 364
		DEFAULT => -155
	},
	{#State 365
		ACTIONS => {
			'OP21_LIST_COMMA' => 378
		}
	},
	{#State 366
		DEFAULT => -69,
		GOTOS => {
			'STAR-28' => 379
		}
	},
	{#State 367
		DEFAULT => -61
	},
	{#State 368
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 369
		ACTIONS => {
			'OP21_LIST_COMMA' => 383,
			"}" => 382
		},
		GOTOS => {
			'PAREN-25' => 381
		}
	},
	{#State 370
		ACTIONS => {
			"my" => 75
		},
		GOTOS => {
			'TypeInner' => 384
		}
	},
	{#State 371
		DEFAULT => -66
	},
	{#State 372
		ACTIONS => {
			"\@_;" => 385
		}
	},
	{#State 373
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 386
		}
	},
	{#State 374
		ACTIONS => {
			")" => 387,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP11_COMPARE_LT_GT' => 160,
			'OP18_TERNARY' => -109,
			'OP16_LOGICAL_OR' => 167,
			'OP23_LOGICAL_AND' => -109,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP07_STRING_REPEAT' => 163,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 375
		ACTIONS => {
			'LBRACE' => 307
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 376
		DEFAULT => -157
	},
	{#State 377
		ACTIONS => {
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP07_STRING_REPEAT' => 163,
			'OP06_REGEX_MATCH' => 165,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP24_LOGICAL_OR_XOR' => 161,
			")" => 389,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP11_COMPARE_LT_GT' => 160,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP23_LOGICAL_AND' => 169
		}
	},
	{#State 378
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 92,
			"%{" => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 100,
			'LITERAL_STRING' => 121,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"undef" => 83,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereferenced' => 98,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashReference' => 108,
			'SubExpression' => 390,
			'Expression' => 141,
			'Operator' => 91,
			'Variable' => 142,
			'Literal' => 119
		}
	},
	{#State 379
		ACTIONS => {
			'OP21_LIST_COMMA' => 391,
			"}" => 392
		},
		GOTOS => {
			'PAREN-27' => 393
		}
	},
	{#State 380
		ACTIONS => {
			"= sub {" => 394
		}
	},
	{#State 381
		DEFAULT => -63
	},
	{#State 382
		ACTIONS => {
			";" => 395
		}
	},
	{#State 383
		ACTIONS => {
			"%{" => 94,
			'WORD' => 348
		},
		GOTOS => {
			'HashEntryTyped' => 396,
			'HashDereferenced' => 350
		}
	},
	{#State 384
		ACTIONS => {
			'LBRACE' => 88,
			'LBRACKET' => 115,
			'OP10_NAMED_UNARY' => 116,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 139,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 80,
			'OP01_CLOSE' => 109,
			'WORD' => 23,
			'OP01_OPEN' => 105,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 122,
			'LITERAL_STRING' => 121,
			'OP10_STRINGIFY_UNARY' => 118,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 90
		},
		GOTOS => {
			'Variable' => 142,
			'Operator' => 91,
			'Expression' => 141,
			'Literal' => 119,
			'HashDereferenced' => 98,
			'ArrayReference' => 113,
			'WordScoped' => 103,
			'ArrayDereferenced' => 102,
			'HashReference' => 108,
			'SubExpression' => 397
		}
	},
	{#State 385
		DEFAULT => -50
	},
	{#State 386
		ACTIONS => {
			'VARIABLE_SYMBOL' => 398
		}
	},
	{#State 387
		ACTIONS => {
			'LBRACE' => 307
		},
		GOTOS => {
			'CodeBlock' => 399
		}
	},
	{#State 388
		DEFAULT => -165
	},
	{#State 389
		ACTIONS => {
			'LBRACE' => 307
		},
		GOTOS => {
			'CodeBlock' => 400
		}
	},
	{#State 390
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			"]" => -87,
			'OP21_LIST_COMMA' => -87,
			'OP14_BITWISE_OR_XOR' => 158,
			";" => -87,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP09_BITWISE_SHIFT' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP06_REGEX_MATCH' => 165,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 164,
			'OP07_STRING_REPEAT' => 163,
			'OP15_LOGICAL_AND' => 162,
			'OP04_MATH_POW' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			")" => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			"}" => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP11_COMPARE_LT_GT' => 160,
			'OP18_TERNARY' => 168,
			'OP16_LOGICAL_OR' => 167
		}
	},
	{#State 391
		ACTIONS => {
			'WORD' => 348,
			"%{" => 94
		},
		GOTOS => {
			'HashDereferenced' => 350,
			'HashEntryTyped' => 401
		}
	},
	{#State 392
		ACTIONS => {
			";" => 402
		}
	},
	{#State 393
		DEFAULT => -68
	},
	{#State 394
		ACTIONS => {
			"( my" => 405,
			'OP01_CLOSE' => -72,
			'OP01_NAMED_VOID_SCOLON' => -72,
			"while (" => -72,
			'LBRACKET' => -72,
			'OP10_NAMED_UNARY' => -72,
			'WORD_SCOPED' => -72,
			'OP10_STRINGIFY_UNARY' => -72,
			'OP22_LOGICAL_NEG' => -72,
			'LITERAL_STRING' => -72,
			"for my integer" => -72,
			"my" => -72,
			'WORD' => -72,
			'OP05_MATH_NEG_LPAREN' => -72,
			'LITERAL_NUMBER' => -72,
			'OP01_NAMED' => -72,
			"undef" => -72,
			"foreach my" => -72,
			"\@{" => -72,
			'VARIABLE_SYMBOL' => -72,
			'LBRACE' => -72,
			'OP05_LOGICAL_NEG' => -72,
			"%{" => -72,
			'OP03_MATH_INC_DEC' => -72,
			'OP01_NAMED_VOID' => -72,
			'LPAREN' => -72,
			"if (" => -72,
			'OP01_PRINT' => -72,
			'OP01_OPEN' => -72,
			'OP19_LOOP_CONTROL_SCOLON' => -72,
			'OP19_LOOP_CONTROL' => -72
		},
		GOTOS => {
			'MethodArguments' => 403,
			'OPTIONAL-29' => 404
		}
	},
	{#State 395
		DEFAULT => -65
	},
	{#State 396
		DEFAULT => -62
	},
	{#State 397
		ACTIONS => {
			'OP17_LIST_RANGE' => 157,
			'OP09_BITWISE_SHIFT' => 156,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 158,
			'OP21_LIST_COMMA' => -199,
			'OP13_BITWISE_AND' => 159,
			'OP07_STRING_REPEAT' => 163,
			'OP08_STRING_CAT' => 164,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 165,
			"}" => -199,
			'OP24_LOGICAL_OR_XOR' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 170,
			'OP04_MATH_POW' => 171,
			'OP15_LOGICAL_AND' => 162,
			'OP16_LOGICAL_OR' => 167,
			'OP18_TERNARY' => 168,
			'OP11_COMPARE_LT_GT' => 160,
			'OP23_LOGICAL_AND' => 169
		}
	},
	{#State 398
		DEFAULT => -47
	},
	{#State 399
		DEFAULT => -164
	},
	{#State 400
		DEFAULT => -154
	},
	{#State 401
		DEFAULT => -67
	},
	{#State 402
		DEFAULT => -70
	},
	{#State 403
		DEFAULT => -71
	},
	{#State 404
		ACTIONS => {
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"foreach my" => -148,
			"undef" => 83,
			'OP01_NAMED' => 87,
			'LITERAL_NUMBER' => 86,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'OP01_CLOSE' => 109,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 78,
			"my" => 81,
			"for my integer" => -148,
			'OP01_NAMED_VOID_SCOLON' => 112,
			"while (" => -148,
			'LITERAL_STRING' => 121,
			'LPAREN' => 100,
			"if (" => 101,
			'OP22_LOGICAL_NEG' => 122,
			'OP19_LOOP_CONTROL' => 106,
			'OP19_LOOP_CONTROL_SCOLON' => 104,
			'OP01_OPEN' => 105,
			'OP01_PRINT' => 107,
			'OP03_MATH_INC_DEC' => 90,
			'WORD_SCOPED' => 24,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 118,
			'OP01_NAMED_VOID' => 96
		},
		GOTOS => {
			'HashReference' => 108,
			'ArrayDereferenced' => 102,
			'LoopLabel' => 123,
			'WordScoped' => 103,
			'Statement' => 120,
			'HashDereferenced' => 98,
			'PAREN-38' => 97,
			'Literal' => 119,
			'Operator' => 91,
			'Expression' => 93,
			'Variable' => 95,
			'OperatorVoid' => 117,
			'SubExpression' => 89,
			'PLUS-30' => 407,
			'Operation' => 406,
			'ArrayReference' => 113,
			'VariableModification' => 111,
			'VariableDeclaration' => 82,
			'OPTIONAL-39' => 77,
			'Conditional' => 79
		}
	},
	{#State 405
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 408
		}
	},
	{#State 406
		DEFAULT => -74
	},
	{#State 407
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 106,
			'OP01_OPEN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 104,
			'OP01_PRINT' => 107,
			'LPAREN' => 100,
			"if (" => 101,
			'OP01_NAMED_VOID' => 96,
			'OP03_MATH_INC_DEC' => 90,
			"%{" => 94,
			'OP05_LOGICAL_NEG' => 92,
			'LBRACE' => 88,
			"\@{" => 84,
			'VARIABLE_SYMBOL' => 85,
			"foreach my" => -148,
			"undef" => 83,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 87,
			"}" => 410,
			'OP05_MATH_NEG_LPAREN' => 80,
			'WORD' => 78,
			"my" => 81,
			"for my integer" => -148,
			'LITERAL_STRING' => 121,
			'OP22_LOGICAL_NEG' => 122,
			'OP10_STRINGIFY_UNARY' => 118,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 116,
			'LBRACKET' => 115,
			'OP01_NAMED_VOID_SCOLON' => 112,
			"while (" => -148,
			'OP01_CLOSE' => 109
		},
		GOTOS => {
			'VariableDeclaration' => 82,
			'VariableModification' => 111,
			'Conditional' => 79,
			'OPTIONAL-39' => 77,
			'SubExpression' => 89,
			'ArrayReference' => 113,
			'Operation' => 409,
			'PAREN-38' => 97,
			'Literal' => 119,
			'OperatorVoid' => 117,
			'Variable' => 95,
			'Operator' => 91,
			'Expression' => 93,
			'ArrayDereferenced' => 102,
			'WordScoped' => 103,
			'LoopLabel' => 123,
			'HashReference' => 108,
			'HashDereferenced' => 98,
			'Statement' => 120
		}
	},
	{#State 408
		DEFAULT => -78,
		GOTOS => {
			'STAR-32' => 411
		}
	},
	{#State 409
		DEFAULT => -73
	},
	{#State 410
		ACTIONS => {
			";" => 412
		}
	},
	{#State 411
		ACTIONS => {
			")" => 415,
			'OP21_LIST_COMMA' => 413
		},
		GOTOS => {
			'PAREN-31' => 414
		}
	},
	{#State 412
		DEFAULT => -75
	},
	{#State 413
		ACTIONS => {
			"my" => 416
		}
	},
	{#State 414
		DEFAULT => -77
	},
	{#State 415
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 417
		}
	},
	{#State 416
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 418
		}
	},
	{#State 417
		ACTIONS => {
			"\@_;" => 419
		}
	},
	{#State 418
		ACTIONS => {
			'VARIABLE_SYMBOL' => 420
		}
	},
	{#State 419
		DEFAULT => -79
	},
	{#State 420
		DEFAULT => -76
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 131 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5980 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5994 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6022 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6029 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6036 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6050 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6057 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 132 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6064 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6075 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6082 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6089 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6100 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6143 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6150 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6171 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6178 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6250 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6272 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6279 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6286 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6311 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6318 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6343 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6350 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6357 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6364 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6371 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6406 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 13,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6431 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6438 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6445 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6456 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6467 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-27', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule PropertiesClass_70
		 'PropertiesClass', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-29', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-30', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6527 lib/RPerl/Grammar.pm
	],
	[#Rule Method_75
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6538 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 4,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6552 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-32', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6559 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_79
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6570 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_80
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6581 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_81
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6592 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_82
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6603 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_83
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6614 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6625 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6636 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6658 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6691 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6713 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6735 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6746 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6757 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6768 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6779 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6790 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6801 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6812 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6823 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6834 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6845 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6856 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6867 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6878 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6889 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6911 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_111
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_112
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_113
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-33', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6951 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6965 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6976 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6998 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7009 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7020 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7031 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7042 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7049 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7063 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7070 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7077 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7084 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7095 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7106 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7117 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7128 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7150 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_143
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_144
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_145
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7314 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7325 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7336 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 4,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7357 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7364 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7371 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-43', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7378 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_160
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7400 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7411 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_164
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_165
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_166
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_169
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7480 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7487 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7494 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_172
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_173
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7527 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7538 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_176
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_177
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_178
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_179
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7582 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-46', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-47', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7603 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7610 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-48', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_185
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_186
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7650 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7661 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7672 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7679 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7686 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_192
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7697 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_193
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7708 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_194
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7719 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7726 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7733 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_197
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7744 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_198
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7755 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_199
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_200
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7784 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7791 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_204
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7809 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_205
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7820 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_206
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7831 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7842 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_208
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_209
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule Type_210
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7875 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_211
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_212
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_213
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_214
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_215
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7930 lib/RPerl/Grammar.pm
	]
],
#line 7933 lib/RPerl/Grammar.pm
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
         'Operator_113', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_117', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         'OperatorVoid_123', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_130', 
         'Expression_131', 
         'Expression_132', 
         'Expression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpression_141', 
         'SubExpression_142', 
         'SubExpression_143', 
         'SubExpressionOrStdin_144', 
         'SubExpressionOrStdin_145', 
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
         'LoopLabel_209', 
         'Type_210', 
         'TypeInner_211', 
         'VariableOrLiteral_212', 
         'VariableOrLiteral_213', 
         'Literal_214', 
         'Literal_215', );
  $self;
}

#line 210 "lib/RPerl/Grammar.eyp"


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


#line 8197 lib/RPerl/Grammar.pm



1;
