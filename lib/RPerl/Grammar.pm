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

#line 2 "lib/RPerl/Grammar.eyp"

    use strict;
    use warnings;
    our $VERSION = 0.001_200;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|foreach|\$TYPED_|\=\ sub\ \{|undef|elsif|while|else|our|\@_\;|use|for|\@\{|\%\{|if|\]|\}|\)|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G([+-]?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?(e[+-]?\d+)?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q\{[^}]*\}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer)\s+/gc and return ('TYPE_INTEGER', $1);
      /\G(filehandleref\s+)/gc and return ('TYPE_FHREF', $1);
      /\G([a-zA-Z]\w*::method)/gc and return ('TYPE_METHOD', $1);
      /\G((?:[a-zA-Z]\w*)?(?:::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
      /\G(object\s+\$self)/gc and return ('TYPE_SELF', $1);
      /\G(\{\*STDOUT\}|\{\*STDERR\})/gc and return ('STDOUT_STDERR', $1);
      /\G(<STDIN>)/gc and return ('STDIN', $1);
      /\G(or|xor)\s/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)\s/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not)/gc and return ('OP22_LOGICAL_NEG', $1);
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
      /\G(chdir|rand|scalar[^t])/gc and return ('OP10_NAMED_UNARY', $1);
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
      /\G(->new\()/gc and return ('OP02_METHOD_THINARROW_NEW', $1);
      /\G(->[a-zA-Z]\w*)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LPAREN', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<=|>=|<|>|lt|gt|le|ge)\s/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print|printf)\s/gc and return ('OP01_PRINT', $1);
      /\G(croak;|die;|exit;|return;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak\(|exit\(|return\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(croak|die|exit|return)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\()/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|keys|values|sort|length|fakebuiltin)\s/gc and return ('OP01_NAMED', $1);
      /\G([a-z]\w*|[A-Z]\w*[a-z]\w*)/gc and return ('WORD', $1);
      /\G([A-Z][A-Z0-9_]*|[A-Z])/gc and return ('WORD_UPPERCASE', $1);
      /\G(::)/gc and return ('SCOPE', $1);
      /\G(:)/gc and return ('COLON', $1);
      /\G(\(\s*my)/gc and return ('LPAREN_MY', $1);
      /\G(\()/gc and return ('LPAREN', $1);
      /\G(\[)/gc and return ('LBRACKET', $1);
      /\G(\{)/gc and return ('LBRACE', $1);


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


#line 133 lib/RPerl/Grammar.pm

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
  [ 'Include_40' => 'Include', [ 'use', 'WordScoped', 'OP01_QW', 'PLUS-15', ')', ';' ], 0 ],
  [ 'Constant_41' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-17', [ 'STAR-17', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-17', [  ], 0 ],
  [ 'Subroutine_46' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-16', 'STAR-17', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-18', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [ 'STAR-19', 'PAREN-18' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [  ], 0 ],
  [ 'SubroutineArguments_50' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-19', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'MethodOrSubroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ 'Class_59' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-20', 'STAR-21', 'STAR-22', 'Properties', 'STAR-23', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-24', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'PAREN-24' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ 'Properties_63' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryTyped', 'STAR-25', '}', ';' ], 0 ],
  [ 'Properties_64' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'Method_69' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-26', 'STAR-27', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-28', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'PAREN-28' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ 'MethodArguments_73' => 'MethodArguments', [ 'LPAREN_MY', 'TYPE_SELF', 'STAR-29', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ 'MethodOrSubroutine_74' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_75' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
  [ 'Operation_76' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_77' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_78' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_79' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_80' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_81' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_83' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [ 'PAREN-30' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ 'OperatorVoid_112' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-31', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_113' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-32', ')', ';' ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ 'Expression_124' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_125' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-33', ')' ], 0 ],
  [ 'Expression_126' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_127' => 'Expression', [ 'WordScoped', 'SCOPE', 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_139' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_140' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-35', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'PAREN-35' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'OPTIONAL-36', 'Loop' ], 0 ],
  [ 'Statement_146' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_147' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_148' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'PAREN-37' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ 'Conditional_155' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-38', 'OPTIONAL-40' ], 0 ],
  [ 'Loop_156' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_157' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_158' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_159' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_160' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_161' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-41', [ 'PLUS-41', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-41', [ 'Operation' ], 0 ],
  [ 'CodeBlock_164' => 'CodeBlock', [ 'LBRACE', 'PLUS-41', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [ 'STAR-42', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [  ], 0 ],
  [ 'Variable_167' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-42' ], 0 ],
  [ 'VariableRetrieval_168' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_169' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_170' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_171' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_172' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableDeclaration_173' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_174' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_175' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'PAREN-43' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'ListElements_179' => 'ListElements', [ 'ListElement', 'STAR-44' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'PLUS-45', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'WORD' ], 0 ],
  [ 'ListElement_182' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_183' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_184' => 'ListElement', [ 'OP01_QW', 'PLUS-45', ')' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_187' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_190' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_191' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_194' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_195' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryTyped_196' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_197' => 'HashEntryTyped', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_201' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_202' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_205' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_206' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_207' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_208' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_209' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_210' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_211' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_212' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_213' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_214' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_215' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_216' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_217' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_218' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_219' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'Literal_220' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_221' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  '_STAR_LIST' => 44,
  '_STAR_LIST' => 45,
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
  '_STAR_LIST' => 57,
  '_STAR_LIST' => 58,
  'Class_59' => 59,
  '_PAREN' => 60,
  '_STAR_LIST' => 61,
  '_STAR_LIST' => 62,
  'Properties_63' => 63,
  'Properties_64' => 64,
  '_OPTIONAL' => 65,
  '_OPTIONAL' => 66,
  '_STAR_LIST' => 67,
  '_STAR_LIST' => 68,
  'Method_69' => 69,
  '_PAREN' => 70,
  '_STAR_LIST' => 71,
  '_STAR_LIST' => 72,
  'MethodArguments_73' => 73,
  'MethodOrSubroutine_74' => 74,
  'MethodOrSubroutine_75' => 75,
  'Operation_76' => 76,
  'Operation_77' => 77,
  'Operator_78' => 78,
  'Operator_79' => 79,
  'Operator_80' => 80,
  'Operator_81' => 81,
  'Operator_82' => 82,
  'Operator_83' => 83,
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
  '_PAREN' => 107,
  '_OPTIONAL' => 108,
  '_OPTIONAL' => 109,
  '_OPTIONAL' => 110,
  '_OPTIONAL' => 111,
  'OperatorVoid_112' => 112,
  'OperatorVoid_113' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  'OperatorVoid_116' => 116,
  'OperatorVoid_117' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  '_OPTIONAL' => 120,
  '_OPTIONAL' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  'Expression_124' => 124,
  'Expression_125' => 125,
  'Expression_126' => 126,
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
  'VariableDeclaration_173' => 173,
  'VariableModification_174' => 174,
  'VariableModification_175' => 175,
  '_PAREN' => 176,
  '_STAR_LIST' => 177,
  '_STAR_LIST' => 178,
  'ListElements_179' => 179,
  '_PLUS_LIST' => 180,
  '_PLUS_LIST' => 181,
  'ListElement_182' => 182,
  'ListElement_183' => 183,
  'ListElement_184' => 184,
  '_OPTIONAL' => 185,
  '_OPTIONAL' => 186,
  'ArrayReference_187' => 187,
  '_OPTIONAL' => 188,
  '_OPTIONAL' => 189,
  'ArrayDereference_190' => 190,
  'ArrayDereference_191' => 191,
  '_OPTIONAL' => 192,
  '_OPTIONAL' => 193,
  'HashEntry_194' => 194,
  'HashEntry_195' => 195,
  'HashEntryTyped_196' => 196,
  'HashEntryTyped_197' => 197,
  '_PAREN' => 198,
  '_STAR_LIST' => 199,
  '_STAR_LIST' => 200,
  'HashReference_201' => 201,
  'HashReference_202' => 202,
  '_OPTIONAL' => 203,
  '_OPTIONAL' => 204,
  'HashDereference_205' => 205,
  'HashDereference_206' => 206,
  'WordScoped_207' => 207,
  'WordScoped_208' => 208,
  'LoopLabel_209' => 209,
  'Type_210' => 210,
  'Type_211' => 211,
  'Type_212' => 212,
  'TypeInner_213' => 213,
  'TypeInnerConstant_214' => 214,
  'VariableOrLiteral_215' => 215,
  'VariableOrLiteral_216' => 216,
  'VariableOrLiteralOrWord_217' => 217,
  'VariableOrLiteralOrWord_218' => 218,
  'VariableOrLiteralOrWord_219' => 219,
  'Literal_220' => 220,
  'Literal_221' => 221,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'= sub {' => { ISSEMANTIC => 0 },
	'@_;' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif' => { ISSEMANTIC => 0 },
	'for' => { ISSEMANTIC => 0 },
	'foreach' => { ISSEMANTIC => 0 },
	'if' => { ISSEMANTIC => 0 },
	'our hashref $properties' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'undef' => { ISSEMANTIC => 0 },
	'use RPerl;' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent qw(' => { ISSEMANTIC => 0 },
	'use strict;' => { ISSEMANTIC => 0 },
	'use warnings;' => { ISSEMANTIC => 0 },
	'use' => { ISSEMANTIC => 0 },
	'while' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	COLON => { ISSEMANTIC => 1 },
	FHREF_SYMBOL => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	LBRACE => { ISSEMANTIC => 1 },
	LBRACKET => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	LPAREN => { ISSEMANTIC => 1 },
	LPAREN_MY => { ISSEMANTIC => 1 },
	MY => { ISSEMANTIC => 1 },
	OP01_CLOSE => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_LPAREN => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_SCOLON => { ISSEMANTIC => 1 },
	OP01_OPEN => { ISSEMANTIC => 1 },
	OP01_PRINT => { ISSEMANTIC => 1 },
	OP01_QW => { ISSEMANTIC => 1 },
	OP02_ARRAY_THINARROW => { ISSEMANTIC => 1 },
	OP02_HASH_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW_NEW => { ISSEMANTIC => 1 },
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
	SCOPE => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
	TYPE_FHREF => { ISSEMANTIC => 1 },
	TYPE_INTEGER => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
	TYPE_SELF => { ISSEMANTIC => 1 },
	VARIABLE_SYMBOL => { ISSEMANTIC => 1 },
	VERSION_NUMBER_ASSIGN => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	WORD_SCOPED => { ISSEMANTIC => 1 },
	WORD_UPPERCASE => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'SHEBANG' => 6,
			"package" => -20,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-9' => 9,
			'PAREN-1' => 5,
			'Program' => 1,
			'Critic' => 2,
			'PLUS-2' => 7,
			'CompileUnit' => 3,
			'ModuleHeader' => 4
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			'' => 10
		}
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => -25,
			"use" => -25,
			"our" => -25,
			"use constant" => -25,
			"use parent qw(" => 15
		},
		GOTOS => {
			'Module' => 11,
			'Class' => 12,
			'Package' => 13,
			'STAR-10' => 14
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-3' => 16,
			'Critic' => 17
		}
	},
	{#State 7
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 8,
			"package" => -20
		},
		GOTOS => {
			'Critic' => 2,
			'ModuleHeader' => 4,
			'PAREN-1' => 18,
			'OPTIONAL-9' => 9
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 19
		},
		GOTOS => {
			'PLUS-14' => 20
		}
	},
	{#State 9
		ACTIONS => {
			"package" => 21
		}
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -1
	},
	{#State 12
		DEFAULT => -23
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		ACTIONS => {
			"use constant" => -27,
			"use" => -27,
			"## no critic qw(" => 8,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 22,
			'Critic' => 23
		}
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 26
		}
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
		DEFAULT => -2
	},
	{#State 19
		DEFAULT => -35
	},
	{#State 20
		ACTIONS => {
			'WORD' => 29,
			")" => 30
		}
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 32
		},
		GOTOS => {
			'STAR-12' => 34,
			'Include' => 33
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
		DEFAULT => -34
	},
	{#State 30
		DEFAULT => -36
	},
	{#State 31
		ACTIONS => {
			";" => 38
		}
	},
	{#State 32
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 33
		DEFAULT => -26
	},
	{#State 34
		ACTIONS => {
			"our" => 42,
			"use constant" => 44
		},
		GOTOS => {
			'Subroutine' => 41,
			'PLUS-13' => 43,
			'Constant' => 40
		}
	},
	{#State 35
		ACTIONS => {
			";" => 45
		}
	},
	{#State 36
		ACTIONS => {
			'OP01_CLOSE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"foreach" => -11,
			'WORD_SCOPED' => -11,
			'LBRACKET' => -11,
			'MY' => -11,
			'WORD' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_OPEN' => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'LPAREN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"use constant" => -11,
			"undef" => -11,
			'LBRACE' => -11,
			'OP01_PRINT' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"use" => -11,
			"for" => -11,
			"## no critic qw(" => 8,
			'OP22_LOGICAL_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"if" => -11,
			"%{" => -11,
			"our" => -11,
			'VARIABLE_SYMBOL' => -11,
			'LITERAL_STRING' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'WORD_UPPERCASE' => -11,
			"while" => -11,
			"\@{" => -11
		},
		GOTOS => {
			'STAR-5' => 46,
			'Critic' => 47
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
			'OP01_QW' => 51,
			";" => 50
		}
	},
	{#State 40
		DEFAULT => -28
	},
	{#State 41
		DEFAULT => -31
	},
	{#State 42
		ACTIONS => {
			'TYPE_INTEGER' => 53,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 42,
			'LITERAL_NUMBER' => 57
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 58
		}
	},
	{#State 45
		ACTIONS => {
			"use" => 32
		},
		GOTOS => {
			'Include' => 59
		}
	},
	{#State 46
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP10_NAMED_UNARY' => -13,
			"if" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'LITERAL_NUMBER' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"for" => -13,
			"use" => 32,
			'LBRACE' => -13,
			'OP01_PRINT' => -13,
			"\@{" => -13,
			"while" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD_UPPERCASE' => -13,
			"our" => -13,
			"%{" => -13,
			'VARIABLE_SYMBOL' => -13,
			'LITERAL_STRING' => -13,
			'MY' => -13,
			'WORD_SCOPED' => -13,
			'LBRACKET' => -13,
			'OP01_CLOSE' => -13,
			"foreach" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LPAREN' => -13,
			"use constant" => -13,
			"undef" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_OPEN' => -13,
			'OP01_NAMED' => -13,
			'WORD' => -13
		},
		GOTOS => {
			'STAR-6' => 60,
			'Include' => 61
		}
	},
	{#State 47
		DEFAULT => -8
	},
	{#State 48
		ACTIONS => {
			"our" => 62
		}
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		DEFAULT => -39
	},
	{#State 51
		ACTIONS => {
			'WORD' => 64
		},
		GOTOS => {
			'PLUS-15' => 63
		}
	},
	{#State 52
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 53
		DEFAULT => -212
	},
	{#State 54
		DEFAULT => -211
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
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 59
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 68
		}
	},
	{#State 60
		ACTIONS => {
			'MY' => -15,
			'OP01_CLOSE' => -15,
			"foreach" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'WORD_SCOPED' => -15,
			'LBRACKET' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_NAMED' => -15,
			'OP01_OPEN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"use constant" => 44,
			'LPAREN' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"undef" => -15,
			'WORD' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_NUMBER' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP10_NAMED_UNARY' => -15,
			"if" => -15,
			'LBRACE' => -15,
			'OP01_PRINT' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"for" => -15,
			'WORD_UPPERCASE' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"while" => -15,
			"\@{" => -15,
			'LITERAL_STRING' => -15,
			"%{" => -15,
			"our" => -15,
			'VARIABLE_SYMBOL' => -15
		},
		GOTOS => {
			'Constant' => 69,
			'STAR-7' => 70
		}
	},
	{#State 61
		DEFAULT => -10
	},
	{#State 62
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 71
		}
	},
	{#State 63
		ACTIONS => {
			'WORD' => 72,
			")" => 73
		}
	},
	{#State 64
		DEFAULT => -38
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		ACTIONS => {
			'MY' => 76
		},
		GOTOS => {
			'TypeInnerConstant' => 75
		}
	},
	{#State 68
		ACTIONS => {
			"## no critic qw(" => 8,
			"use" => -54,
			"our hashref \$properties" => -54,
			"use constant" => -54
		},
		GOTOS => {
			'Critic' => 78,
			'STAR-21' => 77
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			'MY' => 110,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			"foreach" => -143,
			'OP01_NAMED_VOID_SCOLON' => 105,
			'OP01_CLOSE' => 107,
			"undef" => 121,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'LPAREN' => 122,
			'OP19_LOOP_CONTROL_SCOLON' => 124,
			'OP01_NAMED' => 117,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED_VOID' => 120,
			'WORD' => 25,
			"if" => 90,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			"for" => -143,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_PRINT' => 80,
			'LBRACE' => 84,
			"\@{" => 103,
			'OP19_LOOP_CONTROL' => 101,
			"while" => -143,
			'WORD_UPPERCASE' => 102,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			"our" => 42
		},
		GOTOS => {
			'WordScoped' => 97,
			'SubExpression' => 116,
			'PAREN-35' => 115,
			'VariableModification' => 123,
			'Statement' => 104,
			'ArrayDereference' => 98,
			'Operation' => 99,
			'OperatorVoid' => 100,
			'PLUS-8' => 86,
			'Conditional' => 108,
			'Subroutine' => 82,
			'HashDereference' => 83,
			'Operator' => 81,
			'LoopLabel' => 106,
			'VariableDeclaration' => 79,
			'Expression' => 93,
			'OPTIONAL-36' => 114,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 88,
			'ArrayReference' => 111
		}
	},
	{#State 71
		DEFAULT => -33
	},
	{#State 72
		DEFAULT => -37
	},
	{#State 73
		ACTIONS => {
			";" => 126
		}
	},
	{#State 74
		ACTIONS => {
			"undef" => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'LPAREN' => -43,
			'OP01_NAMED_VOID_LPAREN' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_OPEN' => -43,
			'LPAREN_MY' => 129,
			'OP01_NAMED' => -43,
			'OP01_NAMED_VOID' => -43,
			'WORD' => -43,
			'MY' => -43,
			'LBRACKET' => -43,
			"}" => -43,
			'WORD_SCOPED' => -43,
			"foreach" => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP01_CLOSE' => -43,
			"\@{" => -43,
			"while" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'WORD_UPPERCASE' => -43,
			"%{" => -43,
			'VARIABLE_SYMBOL' => -43,
			'LITERAL_STRING' => -43,
			"if" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP10_NAMED_UNARY' => -43,
			'LITERAL_NUMBER' => -43,
			'OP22_LOGICAL_NEG' => -43,
			"for" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_PRINT' => -43,
			'LBRACE' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 127,
			'OPTIONAL-16' => 128
		}
	},
	{#State 75
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 94
		},
		GOTOS => {
			'Literal' => 130
		}
	},
	{#State 76
		ACTIONS => {
			'TYPE_INTEGER' => 53,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 131
		}
	},
	{#State 77
		ACTIONS => {
			"use constant" => -56,
			"use" => 32,
			"our hashref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 132,
			'Include' => 133
		}
	},
	{#State 78
		DEFAULT => -51
	},
	{#State 79
		DEFAULT => -147
	},
	{#State 80
		ACTIONS => {
			'MY' => -109,
			'LITERAL_NUMBER' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'LBRACE' => -109,
			'OP01_CLOSE' => -109,
			'LBRACKET' => -109,
			'STDOUT_STDERR' => 136,
			'WORD_SCOPED' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP01_NAMED' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'OP01_OPEN' => -109,
			'OP01_QW' => -109,
			'WORD_UPPERCASE' => -109,
			"\@{" => -109,
			"undef" => -109,
			'LPAREN' => -109,
			'LITERAL_STRING' => -109,
			'FHREF_SYMBOL_BRACES' => 134,
			"%{" => -109,
			'VARIABLE_SYMBOL' => -109,
			'WORD' => -109
		},
		GOTOS => {
			'PAREN-30' => 137,
			'OPTIONAL-31' => 135
		}
	},
	{#State 81
		DEFAULT => -124
	},
	{#State 82
		DEFAULT => -14
	},
	{#State 83
		DEFAULT => -137
	},
	{#State 84
		ACTIONS => {
			"}" => 142,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 139,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'HashEntry' => 138,
			'VariableOrLiteralOrWord' => 140,
			'HashDereference' => 144,
			'Variable' => 143,
			'Literal' => 141
		}
	},
	{#State 85
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96
		},
		GOTOS => {
			'Variable' => 145
		}
	},
	{#State 86
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			"if" => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'OP01_PRINT' => 80,
			'LBRACE' => 84,
			"for" => -143,
			'OP03_MATH_INC_DEC' => 85,
			'OP19_LOOP_CONTROL' => 101,
			"while" => -143,
			'WORD_UPPERCASE' => 102,
			"\@{" => 103,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'' => -18,
			'MY' => 110,
			"foreach" => -143,
			'OP01_NAMED_VOID_SCOLON' => 105,
			'OP01_CLOSE' => 107,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 117,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED_VOID' => 120,
			"undef" => 121,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP19_LOOP_CONTROL_SCOLON' => 124,
			'LPAREN' => 122,
			'WORD' => 25
		},
		GOTOS => {
			'VariableModification' => 123,
			'Statement' => 104,
			'OperatorVoid' => 100,
			'Operation' => 146,
			'ArrayDereference' => 98,
			'SubExpression' => 116,
			'WordScoped' => 97,
			'PAREN-35' => 115,
			'OPTIONAL-36' => 114,
			'Expression' => 93,
			'Literal' => 112,
			'Variable' => 88,
			'HashReference' => 113,
			'ArrayReference' => 111,
			'Conditional' => 108,
			'HashDereference' => 83,
			'Operator' => 81,
			'VariableDeclaration' => 79,
			'LoopLabel' => 106
		}
	},
	{#State 87
		DEFAULT => -220
	},
	{#State 88
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -133,
			'OP23_LOGICAL_AND' => -133,
			'OP03_MATH_INC_DEC' => 149,
			'OP17_LIST_RANGE' => -133,
			'OP19_VARIABLE_ASSIGN_BY' => 148,
			'OP02_METHOD_THINARROW' => 150,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP07_STRING_REPEAT' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP19_VARIABLE_ASSIGN' => 147,
			'OP09_BITWISE_SHIFT' => -133,
			'OP18_TERNARY' => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP16_LOGICAL_OR' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP08_STRING_CAT' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP04_MATH_POW' => -133,
			'OP11_COMPARE_LT_GT' => -133
		}
	},
	{#State 89
		ACTIONS => {
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'WordScoped' => 97,
			'SubExpression' => 154,
			'Variable' => 151,
			'Literal' => 112,
			'HashReference' => 113,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152
		}
	},
	{#State 90
		ACTIONS => {
			'LPAREN' => 156
		}
	},
	{#State 91
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP23_LOGICAL_AND' => -95,
			'WORD_SCOPED' => 24,
			'OP17_LIST_RANGE' => -95,
			'LBRACKET' => 109,
			"}" => -95,
			'OP01_CLOSE' => 107,
			'LPAREN' => 122,
			'OP08_STRING_CAT' => -95,
			"undef" => 121,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'WORD' => 25,
			"]" => -95,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			";" => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP22_LOGICAL_NEG' => 89,
			'OP14_BITWISE_OR_XOR' => -95,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP12_COMPARE_EQ_NE' => -95,
			'LBRACE' => 84,
			'OP04_MATH_POW' => -95,
			'OP13_BITWISE_AND' => -95,
			"\@{" => 103,
			'OP11_COMPARE_LT_GT' => -95,
			")" => -95,
			'WORD_UPPERCASE' => 153,
			'OP18_TERNARY' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'OP21_LIST_COMMA' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP08_MATH_ADD_SUB' => -95
		},
		GOTOS => {
			'Literal' => 112,
			'Variable' => 151,
			'HashReference' => 113,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152,
			'HashDereference' => 83,
			'Operator' => 81,
			'WordScoped' => 97,
			'SubExpression' => 157
		}
	},
	{#State 92
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 153,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 158,
			'WordScoped' => 97,
			'Variable' => 151,
			'Literal' => 112,
			'HashReference' => 113,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Expression' => 152
		}
	},
	{#State 93
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP08_STRING_CAT' => -130,
			'OP04_MATH_POW' => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP16_LOGICAL_OR' => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP18_TERNARY' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP07_STRING_REPEAT' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP06_REGEX_MATCH' => -130,
			";" => 159,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP23_LOGICAL_AND' => -130
		}
	},
	{#State 94
		DEFAULT => -221
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			'LBRACE' => -204,
			'MY' => 162
		},
		GOTOS => {
			'Variable' => 161,
			'OPTIONAL-51' => 163,
			'TypeInner' => 160
		}
	},
	{#State 96
		DEFAULT => -166,
		GOTOS => {
			'STAR-42' => 164
		}
	},
	{#State 97
		ACTIONS => {
			'SCOPE' => 166,
			'OP02_METHOD_THINARROW_NEW' => 167,
			'LPAREN' => 165
		}
	},
	{#State 98
		DEFAULT => -135
	},
	{#State 99
		DEFAULT => -17
	},
	{#State 100
		DEFAULT => -146
	},
	{#State 101
		ACTIONS => {
			'WORD_UPPERCASE' => 169
		},
		GOTOS => {
			'LoopLabel' => 168
		}
	},
	{#State 102
		ACTIONS => {
			'LPAREN' => 170,
			'COLON' => -209
		}
	},
	{#State 103
		ACTIONS => {
			'LBRACKET' => -189,
			'VARIABLE_SYMBOL' => 96,
			'MY' => 162
		},
		GOTOS => {
			'Variable' => 171,
			'OPTIONAL-47' => 172,
			'TypeInner' => 173
		}
	},
	{#State 104
		DEFAULT => -77
	},
	{#State 105
		DEFAULT => -114
	},
	{#State 106
		ACTIONS => {
			'COLON' => 174
		}
	},
	{#State 107
		ACTIONS => {
			'FHREF_SYMBOL' => 175
		}
	},
	{#State 108
		DEFAULT => -144
	},
	{#State 109
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD_UPPERCASE' => 153,
			'OP01_QW' => 178,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD' => 25,
			"%{" => 95,
			"]" => -186,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94
		},
		GOTOS => {
			'SubExpression' => 180,
			'ListElement' => 179,
			'OPTIONAL-46' => 181,
			'WordScoped' => 97,
			'Operator' => 81,
			'HashDereference' => 83,
			'ListElements' => 176,
			'TypeInner' => 177,
			'Expression' => 152,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Variable' => 151,
			'Literal' => 112,
			'HashReference' => 113
		}
	},
	{#State 110
		ACTIONS => {
			'TYPE_INTEGER' => 53,
			'TYPE_FHREF' => 182,
			'WORD' => 55,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 183
		}
	},
	{#State 111
		DEFAULT => -134
	},
	{#State 112
		DEFAULT => -132
	},
	{#State 113
		DEFAULT => -136
	},
	{#State 114
		ACTIONS => {
			"while" => 190,
			"foreach" => 184,
			"for" => 187
		},
		GOTOS => {
			'LoopFor' => 186,
			'LoopForEach' => 185,
			'Loop' => 189,
			'LoopWhile' => 188
		}
	},
	{#State 115
		DEFAULT => -142
	},
	{#State 116
		ACTIONS => {
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => 192,
			'OP11_COMPARE_LT_GT' => 193,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP23_LOGICAL_AND' => 206,
			'OP17_LIST_RANGE' => 207,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => 204,
			'OP07_STRING_REPEAT' => 200
		}
	},
	{#State 117
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			'OP01_QW' => 178,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'WORD' => 25
		},
		GOTOS => {
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'HashReference' => 113,
			'Variable' => 151,
			'Literal' => 112,
			'TypeInner' => 177,
			'Expression' => 152,
			'Operator' => 81,
			'HashDereference' => 83,
			'SubExpression' => 208,
			'ListElement' => 209,
			'WordScoped' => 97
		}
	},
	{#State 118
		ACTIONS => {
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD_UPPERCASE' => 153,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107
		},
		GOTOS => {
			'WordScoped' => 97,
			'SubExpression' => 210,
			'HashDereference' => 83,
			'Operator' => 81,
			'Expression' => 152,
			'Variable' => 151,
			'Literal' => 112,
			'HashReference' => 113,
			'ArrayDereference' => 98,
			'ArrayReference' => 111
		}
	},
	{#State 119
		ACTIONS => {
			'MY' => 211
		}
	},
	{#State 120
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 89,
			'MY' => 162,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'OP01_QW' => 178,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95
		},
		GOTOS => {
			'HashReference' => 113,
			'Variable' => 151,
			'Literal' => 112,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152,
			'TypeInner' => 177,
			'ListElements' => 212,
			'HashDereference' => 83,
			'Operator' => 81,
			'ListElement' => 179,
			'WordScoped' => 97,
			'SubExpression' => 180
		}
	},
	{#State 121
		DEFAULT => -131
	},
	{#State 122
		ACTIONS => {
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'OP01_PRINT' => 215,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'WORD' => 25,
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122,
			'OP01_NAMED' => 214,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'WORD_UPPERCASE' => 153
		},
		GOTOS => {
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Expression' => 152,
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 213,
			'WordScoped' => 97
		}
	},
	{#State 123
		DEFAULT => -148
	},
	{#State 124
		DEFAULT => -118
	},
	{#State 125
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD_UPPERCASE' => 153,
			'OP01_QW' => 178,
			")" => -111,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD' => 25,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'ListElement' => 179,
			'WordScoped' => 97,
			'SubExpression' => 180,
			'Literal' => 112,
			'Variable' => 151,
			'HashReference' => 113,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152,
			'OPTIONAL-32' => 217,
			'TypeInner' => 177,
			'ListElements' => 216
		}
	},
	{#State 126
		DEFAULT => -40
	},
	{#State 127
		DEFAULT => -42
	},
	{#State 128
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 218
		}
	},
	{#State 129
		ACTIONS => {
			'WORD_SCOPED' => 54,
			'WORD' => 55,
			'TYPE_INTEGER' => 53
		},
		GOTOS => {
			'Type' => 219
		}
	},
	{#State 130
		ACTIONS => {
			";" => 220
		}
	},
	{#State 131
		ACTIONS => {
			"\$TYPED_" => 221
		}
	},
	{#State 132
		ACTIONS => {
			"our hashref \$properties" => 223,
			"use constant" => 44
		},
		GOTOS => {
			'Constant' => 224,
			'Properties' => 222
		}
	},
	{#State 133
		DEFAULT => -53
	},
	{#State 134
		ACTIONS => {
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD_UPPERCASE' => 153,
			'OP01_QW' => 178,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107
		},
		GOTOS => {
			'HashReference' => 113,
			'Variable' => 151,
			'Literal' => 112,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'TypeInner' => 177,
			'Expression' => 152,
			'ListElements' => 225,
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 180,
			'ListElement' => 179,
			'WordScoped' => 97
		}
	},
	{#State 135
		ACTIONS => {
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'WORD' => 25,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_QW' => 178,
			'WORD_UPPERCASE' => 153,
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'MY' => 162,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'ListElements' => 226,
			'TypeInner' => 177,
			'Expression' => 152,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'SubExpression' => 180,
			'ListElement' => 179,
			'WordScoped' => 97,
			'Operator' => 81,
			'HashDereference' => 83
		}
	},
	{#State 136
		DEFAULT => -107
	},
	{#State 137
		DEFAULT => -108
	},
	{#State 138
		DEFAULT => -200,
		GOTOS => {
			'STAR-50' => 227
		}
	},
	{#State 139
		DEFAULT => -219
	},
	{#State 140
		ACTIONS => {
			'OP20_HASH_FATARROW' => 228
		}
	},
	{#State 141
		DEFAULT => -218
	},
	{#State 142
		DEFAULT => -202
	},
	{#State 143
		DEFAULT => -217
	},
	{#State 144
		DEFAULT => -195
	},
	{#State 145
		DEFAULT => -83
	},
	{#State 146
		DEFAULT => -16
	},
	{#State 147
		ACTIONS => {
			'STDIN' => 230,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 25,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'WORD_UPPERCASE' => 153,
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92
		},
		GOTOS => {
			'WordScoped' => 97,
			'SubExpression' => 231,
			'Operator' => 81,
			'HashDereference' => 83,
			'Expression' => 152,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'SubExpressionOrStdin' => 229,
			'Literal' => 112,
			'Variable' => 151,
			'HashReference' => 113
		}
	},
	{#State 148
		ACTIONS => {
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'WordScoped' => 97,
			'SubExpression' => 232,
			'HashDereference' => 83,
			'Operator' => 81,
			'Expression' => 152,
			'Literal' => 112,
			'Variable' => 151,
			'HashReference' => 113,
			'ArrayDereference' => 98,
			'ArrayReference' => 111
		}
	},
	{#State 149
		DEFAULT => -84
	},
	{#State 150
		ACTIONS => {
			'LPAREN' => 233
		}
	},
	{#State 151
		ACTIONS => {
			'OP07_STRING_REPEAT' => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			";" => -133,
			'OP02_METHOD_THINARROW' => 150,
			'OP17_LIST_RANGE' => -133,
			'OP23_LOGICAL_AND' => -133,
			'OP03_MATH_INC_DEC' => 149,
			'OP12_COMPARE_EQ_NE' => -133,
			"}" => -133,
			")" => -133,
			'OP11_COMPARE_LT_GT' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP04_MATH_POW' => -133,
			'OP08_STRING_CAT' => -133,
			'OP21_LIST_COMMA' => -133,
			'OP16_LOGICAL_OR' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP18_TERNARY' => -133,
			'OP09_BITWISE_SHIFT' => -133,
			"]" => -133
		}
	},
	{#State 152
		DEFAULT => -130
	},
	{#State 153
		ACTIONS => {
			'LPAREN' => 170
		}
	},
	{#State 154
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP16_LOGICAL_OR' => 196,
			'OP21_LIST_COMMA' => -104,
			"]" => -104,
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			")" => -104,
			'OP11_COMPARE_LT_GT' => 193,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -104,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => -104,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => 204,
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			";" => -104
		}
	},
	{#State 155
		ACTIONS => {
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'WORD' => 25,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'WORD_UPPERCASE' => 153,
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'Expression' => 152,
			'Operator' => 81,
			'HashDereference' => 83,
			'SubExpression' => 234,
			'WordScoped' => 97
		}
	},
	{#State 156
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'WORD_UPPERCASE' => 153,
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 97,
			'SubExpression' => 235,
			'HashDereference' => 83,
			'Operator' => 81,
			'Expression' => 152,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151,
			'ArrayDereference' => 98,
			'ArrayReference' => 111
		}
	},
	{#State 157
		ACTIONS => {
			"]" => -94,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => -94,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 203,
			'OP11_COMPARE_LT_GT' => -94,
			")" => -94,
			"}" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP17_LIST_RANGE' => -94,
			";" => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200
		}
	},
	{#State 158
		ACTIONS => {
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => 204,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => 206,
			'OP12_COMPARE_EQ_NE' => 202,
			")" => 236,
			'OP11_COMPARE_LT_GT' => 193,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198
		}
	},
	{#State 159
		DEFAULT => -76
	},
	{#State 160
		DEFAULT => -203
	},
	{#State 161
		ACTIONS => {
			"}" => 237
		}
	},
	{#State 162
		ACTIONS => {
			'WORD' => 55,
			'WORD_SCOPED' => 54,
			'TYPE_INTEGER' => 53
		},
		GOTOS => {
			'Type' => 238
		}
	},
	{#State 163
		ACTIONS => {
			'LBRACE' => 84
		},
		GOTOS => {
			'HashReference' => 239
		}
	},
	{#State 164
		ACTIONS => {
			"]" => -167,
			'OP09_BITWISE_SHIFT' => -167,
			'OP18_TERNARY' => -167,
			'OP02_ARRAY_THINARROW' => 242,
			'OP16_LOGICAL_OR' => -167,
			'OP24_LOGICAL_OR_XOR' => -167,
			'OP08_MATH_ADD_SUB' => -167,
			'OP21_LIST_COMMA' => -167,
			'OP11_COMPARE_LT_GT' => -167,
			'OP08_STRING_CAT' => -167,
			'OP13_BITWISE_AND' => -167,
			'OP04_MATH_POW' => -167,
			'OP02_HASH_THINARROW' => 241,
			'COLON' => -167,
			")" => -167,
			'OP12_COMPARE_EQ_NE' => -167,
			"}" => -167,
			'OP17_LIST_RANGE' => -167,
			'OP03_MATH_INC_DEC' => -167,
			'OP23_LOGICAL_AND' => -167,
			'OP20_HASH_FATARROW' => -167,
			'OP19_VARIABLE_ASSIGN_BY' => -167,
			'OP02_METHOD_THINARROW' => -167,
			";" => -167,
			'OP14_BITWISE_OR_XOR' => -167,
			'OP19_VARIABLE_ASSIGN' => -167,
			'OP07_STRING_REPEAT' => -167,
			'OP07_MATH_MULT_DIV_MOD' => -167,
			'OP06_REGEX_MATCH' => -167,
			'OP15_LOGICAL_AND' => -167
		},
		GOTOS => {
			'VariableRetrieval' => 240
		}
	},
	{#State 165
		ACTIONS => {
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD_UPPERCASE' => 153,
			")" => -121,
			'OP01_QW' => 178,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD' => 25,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'WordScoped' => 97,
			'ListElement' => 179,
			'OPTIONAL-33' => 244,
			'SubExpression' => 180,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152,
			'TypeInner' => 177,
			'ListElements' => 243
		}
	},
	{#State 166
		ACTIONS => {
			'WORD_UPPERCASE' => 245
		}
	},
	{#State 167
		ACTIONS => {
			")" => 246
		}
	},
	{#State 168
		ACTIONS => {
			";" => 247
		}
	},
	{#State 169
		DEFAULT => -209
	},
	{#State 170
		ACTIONS => {
			")" => 248
		}
	},
	{#State 171
		ACTIONS => {
			"}" => 249
		}
	},
	{#State 172
		ACTIONS => {
			'LBRACKET' => 109
		},
		GOTOS => {
			'ArrayReference' => 250
		}
	},
	{#State 173
		DEFAULT => -188
	},
	{#State 174
		DEFAULT => -141
	},
	{#State 175
		DEFAULT => -82
	},
	{#State 176
		DEFAULT => -185
	},
	{#State 177
		ACTIONS => {
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'WORD' => 25,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'WORD_UPPERCASE' => 153,
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122
		},
		GOTOS => {
			'Operator' => 81,
			'HashDereference' => 83,
			'WordScoped' => 97,
			'SubExpression' => 251,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112,
			'Expression' => 152
		}
	},
	{#State 178
		ACTIONS => {
			'WORD' => 253
		},
		GOTOS => {
			'PLUS-45' => 252
		}
	},
	{#State 179
		DEFAULT => -178,
		GOTOS => {
			'STAR-44' => 254
		}
	},
	{#State 180
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 193,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			")" => -182,
			"]" => -182,
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP21_LIST_COMMA' => -182,
			";" => -182,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP15_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => 206
		}
	},
	{#State 181
		ACTIONS => {
			"]" => 255
		}
	},
	{#State 182
		ACTIONS => {
			'FHREF_SYMBOL' => 256
		}
	},
	{#State 183
		ACTIONS => {
			'VARIABLE_SYMBOL' => 257
		}
	},
	{#State 184
		ACTIONS => {
			'MY' => 258
		}
	},
	{#State 185
		DEFAULT => -157
	},
	{#State 186
		DEFAULT => -156
	},
	{#State 187
		ACTIONS => {
			'MY' => 259
		}
	},
	{#State 188
		DEFAULT => -158
	},
	{#State 189
		DEFAULT => -145
	},
	{#State 190
		ACTIONS => {
			'LPAREN' => 260
		}
	},
	{#State 191
		ACTIONS => {
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 261,
			'WordScoped' => 97,
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Expression' => 152
		}
	},
	{#State 192
		ACTIONS => {
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'SubExpression' => 262,
			'WordScoped' => 97,
			'Operator' => 81,
			'HashDereference' => 83,
			'Expression' => 152,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151
		}
	},
	{#State 193
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'WORD' => 25
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'Expression' => 152,
			'Operator' => 81,
			'HashDereference' => 83,
			'WordScoped' => 97,
			'SubExpression' => 263
		}
	},
	{#State 194
		ACTIONS => {
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'Expression' => 152,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151,
			'SubExpression' => 264,
			'WordScoped' => 97,
			'Operator' => 81,
			'HashDereference' => 83
		}
	},
	{#State 195
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118
		},
		GOTOS => {
			'SubExpression' => 265,
			'WordScoped' => 97,
			'Operator' => 81,
			'HashDereference' => 83,
			'Expression' => 152,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151
		}
	},
	{#State 196
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD_UPPERCASE' => 153,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94
		},
		GOTOS => {
			'Expression' => 152,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112,
			'SubExpression' => 266,
			'WordScoped' => 97,
			'Operator' => 81,
			'HashDereference' => 83
		}
	},
	{#State 197
		ACTIONS => {
			'WORD_UPPERCASE' => 153,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109
		},
		GOTOS => {
			'WordScoped' => 97,
			'SubExpression' => 267,
			'HashDereference' => 83,
			'Operator' => 81,
			'Expression' => 152,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151,
			'ArrayDereference' => 98,
			'ArrayReference' => 111
		}
	},
	{#State 198
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'Literal' => 270,
			'VariableOrLiteral' => 268,
			'Variable' => 269
		}
	},
	{#State 199
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Expression' => 152,
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 271,
			'WordScoped' => 97
		}
	},
	{#State 200
		ACTIONS => {
			'WORD_UPPERCASE' => 153,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD' => 25,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 272,
			'WordScoped' => 97,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Expression' => 152
		}
	},
	{#State 201
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 273
		}
	},
	{#State 202
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122
		},
		GOTOS => {
			'Expression' => 152,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'WordScoped' => 97,
			'SubExpression' => 274,
			'HashDereference' => 83,
			'Operator' => 81
		}
	},
	{#State 203
		ACTIONS => {
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'Operator' => 81,
			'HashDereference' => 83,
			'SubExpression' => 275,
			'WordScoped' => 97,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'Expression' => 152
		}
	},
	{#State 204
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118
		},
		GOTOS => {
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152,
			'HashDereference' => 83,
			'Operator' => 81,
			'WordScoped' => 97,
			'SubExpression' => 276
		}
	},
	{#State 205
		ACTIONS => {
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD_UPPERCASE' => 153,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD' => 25,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'WordScoped' => 97,
			'SubExpression' => 277,
			'HashReference' => 113,
			'Literal' => 112,
			'Variable' => 151,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152
		}
	},
	{#State 206
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 97,
			'SubExpression' => 278,
			'HashDereference' => 83,
			'Operator' => 81,
			'Expression' => 152,
			'HashReference' => 113,
			'Variable' => 151,
			'Literal' => 112,
			'ArrayDereference' => 98,
			'ArrayReference' => 111
		}
	},
	{#State 207
		ACTIONS => {
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153
		},
		GOTOS => {
			'Expression' => 152,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'HashReference' => 113,
			'Variable' => 151,
			'Literal' => 112,
			'WordScoped' => 97,
			'SubExpression' => 279,
			'Operator' => 81,
			'HashDereference' => 83
		}
	},
	{#State 208
		ACTIONS => {
			'OP06_REGEX_MATCH' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			";" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			")" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP04_MATH_POW' => -79,
			'OP21_LIST_COMMA' => -182,
			'OP08_MATH_ADD_SUB' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP18_TERNARY' => -79,
			'OP09_BITWISE_SHIFT' => -79
		}
	},
	{#State 209
		ACTIONS => {
			'OP21_LIST_COMMA' => 280
		}
	},
	{#State 210
		ACTIONS => {
			")" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP08_STRING_CAT' => -86,
			'OP04_MATH_POW' => 191,
			'OP21_LIST_COMMA' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP18_TERNARY' => -86,
			"]" => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			";" => -86,
			'OP17_LIST_RANGE' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			"}" => -86
		}
	},
	{#State 211
		ACTIONS => {
			'TYPE_FHREF' => 281
		}
	},
	{#State 212
		ACTIONS => {
			";" => 282
		}
	},
	{#State 213
		ACTIONS => {
			'OP16_LOGICAL_OR' => 196,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_MATH_ADD_SUB' => 195,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198,
			")" => 283,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203,
			'OP11_COMPARE_LT_GT' => 193,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP23_LOGICAL_AND' => 206,
			'OP17_LIST_RANGE' => 207,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP15_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 205
		}
	},
	{#State 214
		ACTIONS => {
			'WORD_UPPERCASE' => 153,
			'OP01_QW' => 178,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'LPAREN' => 122,
			"undef" => 121,
			"\@{" => 103,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109
		},
		GOTOS => {
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'TypeInner' => 177,
			'Expression' => 152,
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 208,
			'WordScoped' => 97,
			'ListElement' => 284
		}
	},
	{#State 215
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 285
		}
	},
	{#State 216
		DEFAULT => -110
	},
	{#State 217
		ACTIONS => {
			")" => 286
		}
	},
	{#State 218
		ACTIONS => {
			'OP01_PRINT' => 80,
			'LBRACE' => 84,
			"for" => -143,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			"if" => 90,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'WORD_UPPERCASE' => 102,
			"while" => -143,
			'OP19_LOOP_CONTROL' => 101,
			"\@{" => 103,
			"foreach" => -143,
			'OP01_NAMED_VOID_SCOLON' => 105,
			'OP01_CLOSE' => 107,
			'LBRACKET' => 109,
			"}" => 287,
			'WORD_SCOPED' => 24,
			'MY' => 110,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 117,
			'OP01_NAMED_VOID' => 120,
			"undef" => 121,
			'LPAREN' => 122,
			'OP19_LOOP_CONTROL_SCOLON' => 124,
			'OP01_NAMED_VOID_LPAREN' => 125
		},
		GOTOS => {
			'PAREN-35' => 115,
			'SubExpression' => 116,
			'WordScoped' => 97,
			'OperatorVoid' => 100,
			'Operation' => 288,
			'ArrayDereference' => 98,
			'Statement' => 104,
			'VariableModification' => 123,
			'VariableDeclaration' => 79,
			'Operator' => 81,
			'LoopLabel' => 106,
			'HashDereference' => 83,
			'Conditional' => 108,
			'ArrayReference' => 111,
			'Literal' => 112,
			'Variable' => 88,
			'HashReference' => 113,
			'OPTIONAL-36' => 114,
			'Expression' => 93
		}
	},
	{#State 219
		ACTIONS => {
			'VARIABLE_SYMBOL' => 289
		}
	},
	{#State 220
		DEFAULT => -41
	},
	{#State 221
		ACTIONS => {
			'WORD_UPPERCASE' => 290
		}
	},
	{#State 222
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 291
		}
	},
	{#State 223
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 292
		}
	},
	{#State 224
		DEFAULT => -55
	},
	{#State 225
		ACTIONS => {
			";" => 293
		}
	},
	{#State 226
		ACTIONS => {
			";" => 294
		}
	},
	{#State 227
		ACTIONS => {
			'OP21_LIST_COMMA' => 295,
			"}" => 297
		},
		GOTOS => {
			'PAREN-49' => 296
		}
	},
	{#State 228
		ACTIONS => {
			'LBRACKET' => -193,
			'WORD_SCOPED' => -193,
			'OP03_MATH_INC_DEC' => -193,
			'OP01_CLOSE' => -193,
			'LBRACE' => -193,
			'OP05_MATH_NEG_LPAREN' => -193,
			'OP10_NAMED_UNARY' => -193,
			'LITERAL_NUMBER' => -193,
			'MY' => 162,
			'OP22_LOGICAL_NEG' => -193,
			'VARIABLE_SYMBOL' => -193,
			"%{" => -193,
			'LITERAL_STRING' => -193,
			'WORD' => -193,
			"undef" => -193,
			"\@{" => -193,
			'LPAREN' => -193,
			'OP05_LOGICAL_NEG' => -193,
			'OP01_OPEN' => -193,
			'OP01_NAMED' => -193,
			'WORD_UPPERCASE' => -193
		},
		GOTOS => {
			'OPTIONAL-48' => 299,
			'TypeInner' => 298
		}
	},
	{#State 229
		ACTIONS => {
			";" => 300
		}
	},
	{#State 230
		DEFAULT => -140
	},
	{#State 231
		ACTIONS => {
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => 192,
			'OP04_MATH_POW' => 191,
			'OP11_COMPARE_LT_GT' => 193,
			'OP23_LOGICAL_AND' => 206,
			'OP17_LIST_RANGE' => 207,
			'OP12_COMPARE_EQ_NE' => 202,
			";" => -139,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => 204,
			'OP07_STRING_REPEAT' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP14_BITWISE_OR_XOR' => 199
		}
	},
	{#State 232
		ACTIONS => {
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => 206,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP15_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			'OP14_BITWISE_OR_XOR' => 199,
			";" => 301,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			'OP11_COMPARE_LT_GT' => 193,
			'OP13_BITWISE_AND' => 192,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 203
		}
	},
	{#State 233
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			")" => -123,
			'OP01_QW' => 178,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25
		},
		GOTOS => {
			'Variable' => 151,
			'Literal' => 112,
			'HashReference' => 113,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'TypeInner' => 177,
			'Expression' => 152,
			'ListElements' => 303,
			'HashDereference' => 83,
			'OPTIONAL-34' => 302,
			'Operator' => 81,
			'SubExpression' => 180,
			'ListElement' => 179,
			'WordScoped' => 97
		}
	},
	{#State 234
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -79,
			"}" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			";" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP21_LIST_COMMA' => -79,
			"]" => -79,
			'OP18_TERNARY' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			")" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP04_MATH_POW' => -79
		}
	},
	{#State 235
		ACTIONS => {
			")" => 304,
			'OP11_COMPARE_LT_GT' => 193,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP06_REGEX_MATCH' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP07_STRING_REPEAT' => 200,
			'OP15_LOGICAL_AND' => 204,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => 206
		}
	},
	{#State 236
		DEFAULT => -87
	},
	{#State 237
		DEFAULT => -205
	},
	{#State 238
		ACTIONS => {
			"\$TYPED_" => 305
		}
	},
	{#State 239
		ACTIONS => {
			"}" => 306
		}
	},
	{#State 240
		DEFAULT => -165
	},
	{#State 241
		ACTIONS => {
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'WORD_UPPERCASE' => 153,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 307,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'WordScoped' => 97,
			'SubExpression' => 308,
			'HashReference' => 113,
			'Variable' => 151,
			'Literal' => 112,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152
		}
	},
	{#State 242
		ACTIONS => {
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Expression' => 152,
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 309,
			'WordScoped' => 97
		}
	},
	{#State 243
		DEFAULT => -120
	},
	{#State 244
		ACTIONS => {
			")" => 310
		}
	},
	{#State 245
		ACTIONS => {
			'LPAREN' => 311
		}
	},
	{#State 246
		DEFAULT => -129
	},
	{#State 247
		DEFAULT => -119
	},
	{#State 248
		DEFAULT => -126
	},
	{#State 249
		DEFAULT => -190
	},
	{#State 250
		ACTIONS => {
			"}" => 312
		}
	},
	{#State 251
		ACTIONS => {
			";" => -183,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP15_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP23_LOGICAL_AND' => 206,
			'OP17_LIST_RANGE' => 207,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP11_COMPARE_LT_GT' => 193,
			")" => -183,
			"]" => -183,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP21_LIST_COMMA' => -183
		}
	},
	{#State 252
		ACTIONS => {
			'WORD' => 314,
			")" => 313
		}
	},
	{#State 253
		DEFAULT => -181
	},
	{#State 254
		ACTIONS => {
			")" => -179,
			'OP21_LIST_COMMA' => 316,
			";" => -179,
			"]" => -179
		},
		GOTOS => {
			'PAREN-43' => 315
		}
	},
	{#State 255
		DEFAULT => -187
	},
	{#State 256
		ACTIONS => {
			";" => 317
		}
	},
	{#State 257
		ACTIONS => {
			";" => 319,
			'OP19_VARIABLE_ASSIGN' => 318
		}
	},
	{#State 258
		ACTIONS => {
			'WORD_SCOPED' => 54,
			'WORD' => 55,
			'TYPE_INTEGER' => 53
		},
		GOTOS => {
			'Type' => 320
		}
	},
	{#State 259
		ACTIONS => {
			'TYPE_INTEGER' => 321
		}
	},
	{#State 260
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'WORD' => 25
		},
		GOTOS => {
			'Operator' => 81,
			'HashDereference' => 83,
			'WordScoped' => 97,
			'SubExpression' => 322,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151,
			'Expression' => 152
		}
	},
	{#State 261
		ACTIONS => {
			'OP17_LIST_RANGE' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			"}" => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			";" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP18_TERNARY' => -85,
			"]" => -85,
			")" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP08_STRING_CAT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 262
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP21_LIST_COMMA' => -98,
			"]" => -98,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => -98,
			")" => -98,
			'OP11_COMPARE_LT_GT' => 193,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP07_STRING_REPEAT' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP06_REGEX_MATCH' => 201,
			";" => -98
		}
	},
	{#State 263
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -96,
			"}" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP07_STRING_REPEAT' => 200,
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 201,
			";" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			"]" => -96,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => -96,
			")" => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP13_BITWISE_AND' => -96,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 264
		ACTIONS => {
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203,
			'OP11_COMPARE_LT_GT' => 193,
			")" => -106,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP16_LOGICAL_OR' => 196,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => 195,
			";" => -106,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP07_STRING_REPEAT' => 200,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP23_LOGICAL_AND' => 206,
			'OP17_LIST_RANGE' => 207,
			"}" => -106,
			'OP12_COMPARE_EQ_NE' => 202
		}
	},
	{#State 265
		ACTIONS => {
			'OP13_BITWISE_AND' => -91,
			'OP08_STRING_CAT' => -91,
			'OP04_MATH_POW' => 191,
			'OP11_COMPARE_LT_GT' => -91,
			")" => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP18_TERNARY' => -91,
			"]" => -91,
			'OP21_LIST_COMMA' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			";" => -91,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => -91,
			'OP07_STRING_REPEAT' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			"}" => -91,
			'OP12_COMPARE_EQ_NE' => -91
		}
	},
	{#State 266
		ACTIONS => {
			"]" => -101,
			'OP18_TERNARY' => -101,
			'OP09_BITWISE_SHIFT' => 197,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP08_MATH_ADD_SUB' => 195,
			'OP21_LIST_COMMA' => -101,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203,
			'OP11_COMPARE_LT_GT' => 193,
			")" => -101,
			"}" => -101,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP23_LOGICAL_AND' => -101,
			'OP17_LIST_RANGE' => -101,
			";" => -101,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => 204
		}
	},
	{#State 267
		ACTIONS => {
			'OP18_TERNARY' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			"]" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			")" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			"}" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			";" => -93,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP14_BITWISE_OR_XOR' => -93
		}
	},
	{#State 268
		ACTIONS => {
			'COLON' => 323
		}
	},
	{#State 269
		DEFAULT => -215
	},
	{#State 270
		DEFAULT => -216
	},
	{#State 271
		ACTIONS => {
			")" => -99,
			'OP11_COMPARE_LT_GT' => 193,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => 192,
			'OP04_MATH_POW' => 191,
			'OP16_LOGICAL_OR' => -99,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			"]" => -99,
			'OP18_TERNARY' => -99,
			'OP09_BITWISE_SHIFT' => 197,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP23_LOGICAL_AND' => -99
		}
	},
	{#State 272
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -89,
			'OP06_REGEX_MATCH' => 201,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP15_LOGICAL_AND' => -89,
			";" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			"}" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP23_LOGICAL_AND' => -89,
			")" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_STRING_CAT' => -89,
			'OP04_MATH_POW' => 191,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP21_LIST_COMMA' => -89,
			"]" => -89,
			'OP18_TERNARY' => -89,
			'OP09_BITWISE_SHIFT' => -89
		}
	},
	{#State 273
		DEFAULT => -88
	},
	{#State 274
		ACTIONS => {
			'OP15_LOGICAL_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP14_BITWISE_OR_XOR' => -97,
			";" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -97,
			")" => -97,
			'OP11_COMPARE_LT_GT' => 193,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => -97,
			'OP08_STRING_CAT' => 203,
			'OP21_LIST_COMMA' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => -97,
			'OP18_TERNARY' => -97,
			'OP09_BITWISE_SHIFT' => 197,
			"]" => -97
		}
	},
	{#State 275
		ACTIONS => {
			'OP07_STRING_REPEAT' => 200,
			'OP15_LOGICAL_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP06_REGEX_MATCH' => 201,
			'OP14_BITWISE_OR_XOR' => -92,
			";" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			"}" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			")" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP04_MATH_POW' => 191,
			'OP11_COMPARE_LT_GT' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			"]" => -92
		}
	},
	{#State 276
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 193,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			")" => -100,
			'OP18_TERNARY' => -100,
			'OP09_BITWISE_SHIFT' => 197,
			"]" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP08_MATH_ADD_SUB' => 195,
			";" => -100,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => -100,
			'OP07_STRING_REPEAT' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -100
		}
	},
	{#State 277
		ACTIONS => {
			";" => -90,
			'OP07_STRING_REPEAT' => 200,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP06_REGEX_MATCH' => 201,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			"}" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP08_STRING_CAT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP04_MATH_POW' => 191,
			'OP11_COMPARE_LT_GT' => -90,
			")" => -90,
			'OP18_TERNARY' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			"]" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP16_LOGICAL_OR' => -90
		}
	},
	{#State 278
		ACTIONS => {
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => 204,
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			'OP14_BITWISE_OR_XOR' => 199,
			";" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198,
			"]" => -105,
			")" => -105,
			'OP11_COMPARE_LT_GT' => 193,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => 192,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 279
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_MATH_ADD_SUB' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => -102,
			"]" => -102,
			")" => -102,
			'OP11_COMPARE_LT_GT' => 193,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -102,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -102,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP15_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP14_BITWISE_OR_XOR' => 199,
			";" => -102
		}
	},
	{#State 280
		ACTIONS => {
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'OP22_LOGICAL_NEG' => 89,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			'OP01_QW' => 178,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122
		},
		GOTOS => {
			'TypeInner' => 177,
			'Expression' => 152,
			'ListElements' => 324,
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'SubExpression' => 180,
			'WordScoped' => 97,
			'ListElement' => 179,
			'HashDereference' => 83,
			'Operator' => 81
		}
	},
	{#State 281
		ACTIONS => {
			'FHREF_SYMBOL' => 325
		}
	},
	{#State 282
		DEFAULT => -116
	},
	{#State 283
		DEFAULT => -138
	},
	{#State 284
		ACTIONS => {
			'OP21_LIST_COMMA' => 326
		}
	},
	{#State 285
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			'OP01_QW' => 178,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25
		},
		GOTOS => {
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Literal' => 112,
			'Variable' => 151,
			'HashReference' => 113,
			'ListElements' => 327,
			'TypeInner' => 177,
			'Expression' => 152,
			'Operator' => 81,
			'HashDereference' => 83,
			'SubExpression' => 180,
			'ListElement' => 179,
			'WordScoped' => 97
		}
	},
	{#State 286
		ACTIONS => {
			";" => 328
		}
	},
	{#State 287
		ACTIONS => {
			";" => 329
		}
	},
	{#State 288
		DEFAULT => -44
	},
	{#State 289
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 330
		}
	},
	{#State 290
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 331
		}
	},
	{#State 291
		ACTIONS => {
			'LITERAL_NUMBER' => 335,
			"our" => 334
		},
		GOTOS => {
			'Method' => 332,
			'Subroutine' => 336,
			'MethodOrSubroutine' => 333
		}
	},
	{#State 292
		ACTIONS => {
			'LBRACE' => 337
		}
	},
	{#State 293
		DEFAULT => -113
	},
	{#State 294
		DEFAULT => -112
	},
	{#State 295
		ACTIONS => {
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 139,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'HashEntry' => 338,
			'VariableOrLiteralOrWord' => 140,
			'Literal' => 141,
			'HashDereference' => 144,
			'Variable' => 143
		}
	},
	{#State 296
		DEFAULT => -199
	},
	{#State 297
		DEFAULT => -201
	},
	{#State 298
		DEFAULT => -192
	},
	{#State 299
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92
		},
		GOTOS => {
			'SubExpression' => 339,
			'WordScoped' => 97,
			'Operator' => 81,
			'HashDereference' => 83,
			'Expression' => 152,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112
		}
	},
	{#State 300
		DEFAULT => -174
	},
	{#State 301
		DEFAULT => -175
	},
	{#State 302
		ACTIONS => {
			")" => 340
		}
	},
	{#State 303
		DEFAULT => -122
	},
	{#State 304
		ACTIONS => {
			'LBRACE' => 342
		},
		GOTOS => {
			'CodeBlock' => 341
		}
	},
	{#State 305
		ACTIONS => {
			'WORD' => 343
		}
	},
	{#State 306
		DEFAULT => -206
	},
	{#State 307
		ACTIONS => {
			"}" => 344,
			'LPAREN' => -207,
			'OP02_METHOD_THINARROW_NEW' => -207,
			'SCOPE' => -207
		}
	},
	{#State 308
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 199,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => 204,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => 345,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => 206,
			'OP11_COMPARE_LT_GT' => 193,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => 192,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 194
		}
	},
	{#State 309
		ACTIONS => {
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => 206,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP11_COMPARE_LT_GT' => 193,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => 192,
			'OP04_MATH_POW' => 191,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			"]" => 346
		}
	},
	{#State 310
		DEFAULT => -125
	},
	{#State 311
		ACTIONS => {
			")" => 347
		}
	},
	{#State 312
		DEFAULT => -191
	},
	{#State 313
		DEFAULT => -184
	},
	{#State 314
		DEFAULT => -180
	},
	{#State 315
		DEFAULT => -177
	},
	{#State 316
		ACTIONS => {
			'MY' => 162,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_QW' => 178,
			'WORD_UPPERCASE' => 153,
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'WORD' => 25
		},
		GOTOS => {
			'Operator' => 81,
			'HashDereference' => 83,
			'WordScoped' => 97,
			'ListElement' => 348,
			'SubExpression' => 180,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112,
			'Expression' => 152,
			'TypeInner' => 177
		}
	},
	{#State 317
		DEFAULT => -173
	},
	{#State 318
		ACTIONS => {
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'STDIN' => 230,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84
		},
		GOTOS => {
			'Expression' => 152,
			'SubExpressionOrStdin' => 349,
			'HashReference' => 113,
			'Variable' => 151,
			'Literal' => 112,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'WordScoped' => 97,
			'SubExpression' => 231,
			'HashDereference' => 83,
			'Operator' => 81
		}
	},
	{#State 319
		DEFAULT => -171
	},
	{#State 320
		ACTIONS => {
			'VARIABLE_SYMBOL' => 350
		}
	},
	{#State 321
		ACTIONS => {
			'VARIABLE_SYMBOL' => 351
		}
	},
	{#State 322
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			")" => 352,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP11_COMPARE_LT_GT' => 193,
			'OP23_LOGICAL_AND' => 206,
			'OP17_LIST_RANGE' => 207,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP15_LOGICAL_AND' => 204,
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP14_BITWISE_OR_XOR' => 199
		}
	},
	{#State 323
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94
		},
		GOTOS => {
			'Literal' => 270,
			'VariableOrLiteral' => 353,
			'Variable' => 269
		}
	},
	{#State 324
		ACTIONS => {
			";" => 354
		}
	},
	{#State 325
		ACTIONS => {
			'OP21_LIST_COMMA' => 355
		}
	},
	{#State 326
		ACTIONS => {
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'OP01_QW' => 178,
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 89,
			'MY' => 162,
			'LITERAL_NUMBER' => 87,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107
		},
		GOTOS => {
			'SubExpression' => 180,
			'WordScoped' => 97,
			'ListElement' => 179,
			'HashDereference' => 83,
			'Operator' => 81,
			'TypeInner' => 177,
			'Expression' => 152,
			'ListElements' => 356,
			'Variable' => 151,
			'HashReference' => 113,
			'Literal' => 112,
			'ArrayReference' => 111,
			'ArrayDereference' => 98
		}
	},
	{#State 327
		ACTIONS => {
			")" => 357
		}
	},
	{#State 328
		DEFAULT => -115
	},
	{#State 329
		DEFAULT => -46
	},
	{#State 330
		ACTIONS => {
			")" => 359,
			'OP21_LIST_COMMA' => 360
		},
		GOTOS => {
			'PAREN-18' => 358
		}
	},
	{#State 331
		DEFAULT => -214
	},
	{#State 332
		DEFAULT => -74
	},
	{#State 333
		DEFAULT => -57
	},
	{#State 334
		ACTIONS => {
			'TYPE_INTEGER' => 53,
			'TYPE_METHOD' => 361,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 335
		ACTIONS => {
			";" => 362
		}
	},
	{#State 336
		DEFAULT => -75
	},
	{#State 337
		ACTIONS => {
			"}" => 363,
			"%{" => 95,
			'WORD' => 365
		},
		GOTOS => {
			'HashDereference' => 366,
			'HashEntryTyped' => 364
		}
	},
	{#State 338
		DEFAULT => -198
	},
	{#State 339
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -194,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => 206,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => 204,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP21_LIST_COMMA' => -194,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198,
			'OP11_COMPARE_LT_GT' => 193,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203
		}
	},
	{#State 340
		DEFAULT => -128
	},
	{#State 341
		DEFAULT => -151,
		GOTOS => {
			'STAR-38' => 367
		}
	},
	{#State 342
		ACTIONS => {
			'MY' => 110,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP01_NAMED_VOID_SCOLON' => 105,
			"foreach" => -143,
			'OP01_CLOSE' => 107,
			"undef" => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 124,
			'LPAREN' => 122,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_NAMED' => 117,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED_VOID' => 120,
			'WORD' => 25,
			"if" => 90,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			"for" => -143,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_PRINT' => 80,
			'LBRACE' => 84,
			"\@{" => 103,
			'WORD_UPPERCASE' => 102,
			"while" => -143,
			'OP19_LOOP_CONTROL' => 101,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96
		},
		GOTOS => {
			'SubExpression' => 116,
			'WordScoped' => 97,
			'PAREN-35' => 115,
			'VariableModification' => 123,
			'Statement' => 104,
			'OperatorVoid' => 100,
			'Operation' => 369,
			'ArrayDereference' => 98,
			'Conditional' => 108,
			'HashDereference' => 83,
			'Operator' => 81,
			'LoopLabel' => 106,
			'VariableDeclaration' => 79,
			'OPTIONAL-36' => 114,
			'Expression' => 93,
			'PLUS-41' => 368,
			'Variable' => 88,
			'Literal' => 112,
			'HashReference' => 113,
			'ArrayReference' => 111
		}
	},
	{#State 343
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 370
		}
	},
	{#State 344
		DEFAULT => -170
	},
	{#State 345
		DEFAULT => -169
	},
	{#State 346
		DEFAULT => -168
	},
	{#State 347
		DEFAULT => -127
	},
	{#State 348
		DEFAULT => -176
	},
	{#State 349
		ACTIONS => {
			";" => 371
		}
	},
	{#State 350
		ACTIONS => {
			'LPAREN' => 372
		}
	},
	{#State 351
		ACTIONS => {
			'LPAREN' => 373
		}
	},
	{#State 352
		ACTIONS => {
			'LBRACE' => 342
		},
		GOTOS => {
			'CodeBlock' => 374
		}
	},
	{#State 353
		DEFAULT => -103
	},
	{#State 354
		DEFAULT => -117
	},
	{#State 355
		ACTIONS => {
			'LITERAL_STRING' => 375
		}
	},
	{#State 356
		ACTIONS => {
			")" => 376
		}
	},
	{#State 357
		DEFAULT => -78
	},
	{#State 358
		DEFAULT => -48
	},
	{#State 359
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 360
		ACTIONS => {
			'MY' => 378
		}
	},
	{#State 361
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 362
		DEFAULT => -59
	},
	{#State 363
		ACTIONS => {
			";" => 380
		}
	},
	{#State 364
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 381
		}
	},
	{#State 365
		ACTIONS => {
			'OP20_HASH_FATARROW' => 382
		}
	},
	{#State 366
		DEFAULT => -197
	},
	{#State 367
		ACTIONS => {
			'OP01_PRINT' => -154,
			'LBRACE' => -154,
			"for" => -154,
			'OP03_MATH_INC_DEC' => -154,
			'LITERAL_NUMBER' => -154,
			'OP22_LOGICAL_NEG' => -154,
			"if" => -154,
			'OP05_MATH_NEG_LPAREN' => -154,
			'OP10_NAMED_UNARY' => -154,
			'LITERAL_STRING' => -154,
			'VARIABLE_SYMBOL' => -154,
			"%{" => -154,
			'' => -154,
			"else" => 383,
			'OP19_LOOP_CONTROL' => -154,
			'WORD_UPPERCASE' => -154,
			"while" => -154,
			"\@{" => -154,
			'OP01_NAMED_VOID_SCOLON' => -154,
			"elsif" => 387,
			"foreach" => -154,
			'OP01_CLOSE' => -154,
			"}" => -154,
			'LBRACKET' => -154,
			'WORD_SCOPED' => -154,
			'MY' => -154,
			'WORD' => -154,
			'OP01_NAMED' => -154,
			'OP05_LOGICAL_NEG' => -154,
			'OP01_OPEN' => -154,
			'OP01_NAMED_VOID' => -154,
			"undef" => -154,
			'OP19_LOOP_CONTROL_SCOLON' => -154,
			'LPAREN' => -154,
			'OP01_NAMED_VOID_LPAREN' => -154
		},
		GOTOS => {
			'OPTIONAL-40' => 385,
			'PAREN-37' => 384,
			'PAREN-39' => 386
		}
	},
	{#State 368
		ACTIONS => {
			'MY' => 110,
			"foreach" => -143,
			'OP01_NAMED_VOID_SCOLON' => 105,
			'OP01_CLOSE' => 107,
			"}" => 389,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 117,
			'OP01_NAMED_VOID' => 120,
			"undef" => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 124,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'LPAREN' => 122,
			'WORD' => 25,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			"if" => 90,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP01_PRINT' => 80,
			'LBRACE' => 84,
			"for" => -143,
			'OP03_MATH_INC_DEC' => 85,
			"while" => -143,
			'WORD_UPPERCASE' => 102,
			'OP19_LOOP_CONTROL' => 101,
			"\@{" => 103,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94
		},
		GOTOS => {
			'Operator' => 81,
			'LoopLabel' => 106,
			'VariableDeclaration' => 79,
			'HashDereference' => 83,
			'Conditional' => 108,
			'ArrayReference' => 111,
			'Variable' => 88,
			'Literal' => 112,
			'HashReference' => 113,
			'Expression' => 93,
			'OPTIONAL-36' => 114,
			'PAREN-35' => 115,
			'WordScoped' => 97,
			'SubExpression' => 116,
			'ArrayDereference' => 98,
			'Operation' => 388,
			'OperatorVoid' => 100,
			'Statement' => 104,
			'VariableModification' => 123
		}
	},
	{#State 369
		DEFAULT => -163
	},
	{#State 370
		DEFAULT => -213
	},
	{#State 371
		DEFAULT => -172
	},
	{#State 372
		ACTIONS => {
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_NUMBER' => 87,
			'MY' => 162,
			'OP22_LOGICAL_NEG' => 89,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			'OP01_QW' => 178
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'SubExpression' => 180,
			'ListElement' => 179,
			'WordScoped' => 97,
			'Literal' => 112,
			'Variable' => 151,
			'HashReference' => 113,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'TypeInner' => 177,
			'Expression' => 152,
			'ListElements' => 390
		}
	},
	{#State 373
		ACTIONS => {
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153,
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'HashDereference' => 83,
			'Operator' => 81,
			'WordScoped' => 97,
			'SubExpression' => 391,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'Expression' => 152
		}
	},
	{#State 374
		DEFAULT => -161
	},
	{#State 375
		ACTIONS => {
			'OP21_LIST_COMMA' => 392
		}
	},
	{#State 376
		DEFAULT => -80
	},
	{#State 377
		ACTIONS => {
			"\@_;" => 393
		}
	},
	{#State 378
		ACTIONS => {
			'WORD_SCOPED' => 54,
			'WORD' => 55,
			'TYPE_INTEGER' => 53
		},
		GOTOS => {
			'Type' => 394
		}
	},
	{#State 379
		ACTIONS => {
			"= sub {" => 395
		}
	},
	{#State 380
		DEFAULT => -64
	},
	{#State 381
		ACTIONS => {
			'OP21_LIST_COMMA' => 398,
			"}" => 396
		},
		GOTOS => {
			'PAREN-24' => 397
		}
	},
	{#State 382
		ACTIONS => {
			'MY' => 162
		},
		GOTOS => {
			'TypeInner' => 399
		}
	},
	{#State 383
		ACTIONS => {
			'LBRACE' => 342
		},
		GOTOS => {
			'CodeBlock' => 400
		}
	},
	{#State 384
		DEFAULT => -150
	},
	{#State 385
		DEFAULT => -155
	},
	{#State 386
		DEFAULT => -153
	},
	{#State 387
		ACTIONS => {
			'LPAREN' => 401
		}
	},
	{#State 388
		DEFAULT => -162
	},
	{#State 389
		DEFAULT => -164
	},
	{#State 390
		ACTIONS => {
			")" => 402
		}
	},
	{#State 391
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => 204,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP23_LOGICAL_AND' => 206,
			'OP17_LIST_RANGE' => 403,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203,
			'OP04_MATH_POW' => 191,
			'OP11_COMPARE_LT_GT' => 193,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198
		}
	},
	{#State 392
		ACTIONS => {
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153
		},
		GOTOS => {
			'Expression' => 152,
			'Variable' => 151,
			'Literal' => 112,
			'HashReference' => 113,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'WordScoped' => 97,
			'SubExpression' => 404,
			'HashDereference' => 83,
			'Operator' => 81
		}
	},
	{#State 393
		DEFAULT => -50
	},
	{#State 394
		ACTIONS => {
			'VARIABLE_SYMBOL' => 405
		}
	},
	{#State 395
		ACTIONS => {
			'WORD_SCOPED' => -66,
			"}" => -66,
			'LBRACKET' => -66,
			'OP01_CLOSE' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			"foreach" => -66,
			'MY' => -66,
			'WORD' => -66,
			'LPAREN' => -66,
			'OP01_NAMED_VOID_LPAREN' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			"undef" => -66,
			'OP01_NAMED_VOID' => -66,
			'LPAREN_MY' => 408,
			'OP01_NAMED' => -66,
			'OP01_OPEN' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP03_MATH_INC_DEC' => -66,
			"for" => -66,
			'LBRACE' => -66,
			'OP01_PRINT' => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"if" => -66,
			'OP22_LOGICAL_NEG' => -66,
			'LITERAL_NUMBER' => -66,
			'LITERAL_STRING' => -66,
			'VARIABLE_SYMBOL' => -66,
			"%{" => -66,
			"\@{" => -66,
			'OP19_LOOP_CONTROL' => -66,
			"while" => -66,
			'WORD_UPPERCASE' => -66
		},
		GOTOS => {
			'MethodArguments' => 406,
			'OPTIONAL-26' => 407
		}
	},
	{#State 396
		ACTIONS => {
			";" => 409
		}
	},
	{#State 397
		DEFAULT => -61
	},
	{#State 398
		ACTIONS => {
			'WORD' => 365,
			"%{" => 95
		},
		GOTOS => {
			'HashDereference' => 366,
			'HashEntryTyped' => 410
		}
	},
	{#State 399
		ACTIONS => {
			'WORD_UPPERCASE' => 153,
			'OP01_NAMED' => 155,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'LPAREN' => 122,
			"\@{" => 103,
			"undef" => 121,
			'WORD' => 25,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'OP22_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACKET' => 109
		},
		GOTOS => {
			'Expression' => 152,
			'Variable' => 151,
			'Literal' => 112,
			'HashReference' => 113,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'SubExpression' => 411,
			'WordScoped' => 97,
			'HashDereference' => 83,
			'Operator' => 81
		}
	},
	{#State 400
		DEFAULT => -152
	},
	{#State 401
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'LBRACKET' => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD_SCOPED' => 24,
			'OP01_CLOSE' => 107,
			'LBRACE' => 84,
			"\@{" => 103,
			"undef" => 121,
			'LPAREN' => 122,
			'OP01_NAMED' => 155,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'WORD_UPPERCASE' => 153,
			'LITERAL_STRING' => 94,
			"%{" => 95,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 97,
			'SubExpression' => 412,
			'Operator' => 81,
			'HashDereference' => 83,
			'Expression' => 152,
			'ArrayDereference' => 98,
			'ArrayReference' => 111,
			'HashReference' => 113,
			'Variable' => 151,
			'Literal' => 112
		}
	},
	{#State 402
		ACTIONS => {
			'LBRACE' => 342
		},
		GOTOS => {
			'CodeBlock' => 413
		}
	},
	{#State 403
		ACTIONS => {
			'LBRACKET' => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACE' => 84,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			'WORD' => 25,
			"undef" => 121,
			"\@{" => 103,
			'LPAREN' => 122,
			'OP01_OPEN' => 119,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 155,
			'WORD_UPPERCASE' => 153
		},
		GOTOS => {
			'SubExpression' => 414,
			'WordScoped' => 97,
			'Operator' => 81,
			'HashDereference' => 83,
			'Expression' => 152,
			'ArrayReference' => 111,
			'ArrayDereference' => 98,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 151
		}
	},
	{#State 404
		ACTIONS => {
			")" => -81,
			'OP11_COMPARE_LT_GT' => 193,
			'OP04_MATH_POW' => 191,
			'OP13_BITWISE_AND' => 192,
			'OP08_STRING_CAT' => 203,
			'OP21_LIST_COMMA' => -81,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198,
			"]" => -81,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => 204,
			'OP07_STRING_REPEAT' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP14_BITWISE_OR_XOR' => 199,
			";" => -81,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => -81,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -81
		}
	},
	{#State 405
		DEFAULT => -47
	},
	{#State 406
		DEFAULT => -65
	},
	{#State 407
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 415
		}
	},
	{#State 408
		ACTIONS => {
			'TYPE_SELF' => 416
		}
	},
	{#State 409
		DEFAULT => -63
	},
	{#State 410
		DEFAULT => -60
	},
	{#State 411
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP15_LOGICAL_AND' => 204,
			'OP12_COMPARE_EQ_NE' => 202,
			"}" => -196,
			'OP17_LIST_RANGE' => 207,
			'OP23_LOGICAL_AND' => 206,
			'OP11_COMPARE_LT_GT' => 193,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => 192,
			'OP09_BITWISE_SHIFT' => 197,
			'OP18_TERNARY' => 198,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP21_LIST_COMMA' => -196
		}
	},
	{#State 412
		ACTIONS => {
			'OP16_LOGICAL_OR' => 196,
			'OP08_MATH_ADD_SUB' => 195,
			'OP24_LOGICAL_OR_XOR' => 194,
			'OP18_TERNARY' => 198,
			'OP09_BITWISE_SHIFT' => 197,
			")" => 417,
			'OP13_BITWISE_AND' => 192,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 203,
			'OP11_COMPARE_LT_GT' => 193,
			'OP23_LOGICAL_AND' => 206,
			'OP17_LIST_RANGE' => 207,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP15_LOGICAL_AND' => 204,
			'OP06_REGEX_MATCH' => 201,
			'OP07_STRING_REPEAT' => 200,
			'OP14_BITWISE_OR_XOR' => 199
		}
	},
	{#State 413
		DEFAULT => -160
	},
	{#State 414
		ACTIONS => {
			'OP07_STRING_REPEAT' => 200,
			'OP06_REGEX_MATCH' => 201,
			'OP15_LOGICAL_AND' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 205,
			'OP14_BITWISE_OR_XOR' => 199,
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -102,
			'OP12_COMPARE_EQ_NE' => 202,
			'OP11_COMPARE_LT_GT' => 193,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 203,
			'OP13_BITWISE_AND' => 192,
			")" => 418,
			'OP18_TERNARY' => -102,
			'OP09_BITWISE_SHIFT' => 197,
			'OP16_LOGICAL_OR' => 196,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_MATH_ADD_SUB' => 195
		}
	},
	{#State 415
		ACTIONS => {
			'OP01_PRINT' => 80,
			'LBRACE' => 84,
			"for" => -143,
			'OP03_MATH_INC_DEC' => 85,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 89,
			"if" => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 91,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 95,
			'LITERAL_STRING' => 94,
			"while" => -143,
			'OP19_LOOP_CONTROL' => 101,
			'WORD_UPPERCASE' => 102,
			"\@{" => 103,
			"foreach" => -143,
			'OP01_NAMED_VOID_SCOLON' => 105,
			'OP01_CLOSE' => 107,
			'LBRACKET' => 109,
			"}" => 420,
			'WORD_SCOPED' => 24,
			'MY' => 110,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_OPEN' => 119,
			'OP01_NAMED' => 117,
			'OP01_NAMED_VOID' => 120,
			"undef" => 121,
			'LPAREN' => 122,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP19_LOOP_CONTROL_SCOLON' => 124
		},
		GOTOS => {
			'SubExpression' => 116,
			'WordScoped' => 97,
			'PAREN-35' => 115,
			'VariableModification' => 123,
			'Statement' => 104,
			'OperatorVoid' => 100,
			'Operation' => 419,
			'ArrayDereference' => 98,
			'Conditional' => 108,
			'HashDereference' => 83,
			'LoopLabel' => 106,
			'VariableDeclaration' => 79,
			'Operator' => 81,
			'OPTIONAL-36' => 114,
			'Expression' => 93,
			'Literal' => 112,
			'HashReference' => 113,
			'Variable' => 88,
			'ArrayReference' => 111
		}
	},
	{#State 416
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 421
		}
	},
	{#State 417
		ACTIONS => {
			'LBRACE' => 342
		},
		GOTOS => {
			'CodeBlock' => 422
		}
	},
	{#State 418
		ACTIONS => {
			'LBRACE' => 342
		},
		GOTOS => {
			'CodeBlock' => 423
		}
	},
	{#State 419
		DEFAULT => -67
	},
	{#State 420
		ACTIONS => {
			";" => 424
		}
	},
	{#State 421
		ACTIONS => {
			'OP21_LIST_COMMA' => 426,
			")" => 425
		},
		GOTOS => {
			'PAREN-28' => 427
		}
	},
	{#State 422
		DEFAULT => -149
	},
	{#State 423
		DEFAULT => -159
	},
	{#State 424
		DEFAULT => -69
	},
	{#State 425
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 428
		}
	},
	{#State 426
		ACTIONS => {
			'MY' => 429
		}
	},
	{#State 427
		DEFAULT => -71
	},
	{#State 428
		ACTIONS => {
			"\@_;" => 430
		}
	},
	{#State 429
		ACTIONS => {
			'WORD_SCOPED' => 54,
			'WORD' => 55,
			'TYPE_INTEGER' => 53
		},
		GOTOS => {
			'Type' => 431
		}
	},
	{#State 430
		DEFAULT => -73
	},
	{#State 431
		ACTIONS => {
			'VARIABLE_SYMBOL' => 432
		}
	},
	{#State 432
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5886 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5893 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5900 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5911 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6017 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6024 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6031 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6042 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6113 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6120 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6131 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6149 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6156 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6167 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6174 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6181 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6192 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6203 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6253 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6306 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6313 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6320 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6327 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6341 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6352 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6359 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6366 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6373 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6384 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6395 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6409 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6416 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6423 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6434 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6448 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6455 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6477 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6521 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6532 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6543 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6554 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6565 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6576 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6587 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6598 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6609 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6620 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6653 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6664 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6697 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6719 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6752 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6785 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6796 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6843 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6857 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6864 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6897 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6919 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6930 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6941 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7112 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7134 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7145 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_139
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7156 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_140
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7181 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7221 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7232 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7243 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 5,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7250 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7278 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_155
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7318 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_158
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_159
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_160
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_161
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7369 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7376 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_164
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7387 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_167
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7412 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7423 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7434 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_170
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7445 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_171
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7456 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_172
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_173
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7478 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_174
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7489 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_175
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7514 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_179
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7557 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7568 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_184
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7579 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7586 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7593 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_187
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7604 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_190
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_191
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7654 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_194
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7665 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_195
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7676 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_196
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7687 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_197
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7698 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7712 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7719 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_201
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7730 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_202
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7748 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7755 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_205
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_206
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7788 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_208
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7799 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_209
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7810 lib/RPerl/Grammar.pm
	],
	[#Rule Type_210
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7821 lib/RPerl/Grammar.pm
	],
	[#Rule Type_211
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7832 lib/RPerl/Grammar.pm
	],
	[#Rule Type_212
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7843 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_213
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7854 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_214
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7865 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_215
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7876 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_216
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7887 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_217
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7898 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_218
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7909 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_219
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7920 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_220
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7931 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_221
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7942 lib/RPerl/Grammar.pm
	]
],
#line 7945 lib/RPerl/Grammar.pm
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
         '_STAR_LIST', 
         '_STAR_LIST', 
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
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_59', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_63', 
         'Properties_64', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_69', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_73', 
         'MethodOrSubroutine_74', 
         'MethodOrSubroutine_75', 
         'Operation_76', 
         'Operation_77', 
         'Operator_78', 
         'Operator_79', 
         'Operator_80', 
         'Operator_81', 
         'Operator_82', 
         'Operator_83', 
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_112', 
         'OperatorVoid_113', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         'OperatorVoid_116', 
         'OperatorVoid_117', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_124', 
         'Expression_125', 
         'Expression_126', 
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
         'VariableDeclaration_173', 
         'VariableModification_174', 
         'VariableModification_175', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_179', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElement_182', 
         'ListElement_183', 
         'ListElement_184', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_187', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_190', 
         'ArrayDereference_191', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_194', 
         'HashEntry_195', 
         'HashEntryTyped_196', 
         'HashEntryTyped_197', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_201', 
         'HashReference_202', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_205', 
         'HashDereference_206', 
         'WordScoped_207', 
         'WordScoped_208', 
         'LoopLabel_209', 
         'Type_210', 
         'Type_211', 
         'Type_212', 
         'TypeInner_213', 
         'TypeInnerConstant_214', 
         'VariableOrLiteral_215', 
         'VariableOrLiteral_216', 
         'VariableOrLiteralOrWord_217', 
         'VariableOrLiteralOrWord_218', 
         'VariableOrLiteralOrWord_219', 
         'Literal_220', 
         'Literal_221', );
  $self;
}

#line 214 "lib/RPerl/Grammar.eyp"


{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run scripts/grammar_recompile.sh
# 3. Run new & existing grammar tests
# 4. Copy updates from Grammar.output file into this file, below this line only
# 5. Run scripts/grammar_recompile.sh again
our string_hashref $RULES = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',                             # CompileUnit -> Program
CompileUnit_5 => 'RPerl::CompileUnit::Module',                              # CompileUnit -> PLUS-2
Program_18 => 'RPerl::CompileUnit::Program',                                # Program -> SHEBANG OPTIONAL-3 Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
ModuleHeader_21 => 'RPerl::CompileUnit::Module::Header',                    # ModuleHeader -> OPTIONAL-9 'package' WordScoped ';' Header
Module_22 => 'RPerl::CompileUnit::Module::Package',                         # Module -> Package
Module_23 => 'RPerl::CompileUnit::Module::Class::Generator',                # Module -> Class
Package_32 => 'RPerl::CompileUnit::Module::Package',                        # Package -> STAR-10 STAR-11 STAR-12 PLUS-13 LITERAL_NUMBER ';'
Header_33 => 'RPerl::NonGenerator',                                         # Header -> 'use strict;' 'use warnings;' 'use RPerl;' 'our' VERSION_NUMBER_ASSIGN
Critic_36 => 'RPerl::CompileUnit::Critic',                                  # Critic -> '## no critic qw(' PLUS-14 ')'
Include_39 => 'RPerl::CompileUnit::Include',                                # Include -> 'use' WordScoped ';'
Include_40 => 'RPerl::CompileUnit::Include',                                # Include -> 'use' WordScoped OP01_QW PLUS-15 ')' ';'
Constant_41 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_46 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_50 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@_;'
Class_59 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_63 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryTyped STAR-25 '}' ';'
Properties_64 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_69 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_73 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_74 => 'RPerl::CodeBlock::Subroutine::Method',            # MethodOrSubroutine -> Method
MethodOrSubroutine_75 => 'RPerl::CodeBlock::Subroutine',                    # MethodOrSubroutine -> Subroutine
Operation_76 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_77 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_78 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_79 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_80 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_81 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_82 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_83 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> OP03_MATH_INC_DEC Variable
Operator_84 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> Variable OP03_MATH_INC_DEC
Operator_85 => 'RPerl::Operation::Expression::Operator::Math::Power',                   # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_86 => 'RPerl::Operation::Expression::Operator::Logical::Negation',             # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_87 => 'RPerl::Operation::Expression::Operator::Math::Negative',                # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_88 => 'RPerl::Operation::Expression::Operator::RegularExpression',             # Operator -> SubExpression OP06_REGEX_MATCH OP06_REGEX_PATTERN
Operator_89 => 'RPerl::Operation::Expression::Operator::String::Repeat',                # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_90 => 'RPerl::Operation::Expression::Operator::Math::MultiplyDivideModulo',    # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_91 => 'RPerl::Operation::Expression::Operator::Math::AddSubtract',             # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_92 => 'RPerl::Operation::Expression::Operator::String::Concatenate',           # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_93 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_94 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY SubExpression
Operator_95 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY
Operator_96 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',  # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_97 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',        # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_98 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                  # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_99 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',                # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_100 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_102 => 'RPerl::Operation::Expression::Operator::List::Range',                  # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Ternary',                      # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_104 => 'RPerl::Operation::Expression::Operator::Logical::Negation',            # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_105 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_106 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_112 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_113 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_114 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_115 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_116 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_117 => 'RPerl::Operation::Expression::Operator::Named',                    # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_118 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_119 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_124 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_125 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_126 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_127 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WordScoped SCOPE WORD_UPPERCASE LPAREN ')'
Expression_128 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_129 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_130 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_131 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_132 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_133 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_134 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_135 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_136 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_138 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrStdin_139 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrStdin -> SubExpression
SubExpressionOrStdin_140 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrStdin -> STDIN
Statement_144 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_145 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_146 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_147 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_148 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification
Conditional_155 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_156 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_157 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_158 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_159 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopForEach_160 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_161 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
CodeBlock_164 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_167 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VARIABLE_SYMBOL STAR-42
VariableRetrieval_168 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_169 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_170 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_171 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_172 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableDeclaration_173 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_174 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableModification_175 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression ';'
ListElements_179 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_182 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_183 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_184 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW PLUS-44 ')'
ArrayReference_187 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_190 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_191 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_194 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_195 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntryTyped_196 => 'RPerl::DataStructure::Hash::EntryTyped',                                 # HashEntryTyped -> WORD OP20_HASH_FATARROW TypeInner SubExpression
HashEntryTyped_197 => 'RPerl::Operation::Expression::SubExpression::HashDereference',           # HashEntryTyped -> HashDereference
HashReference_201 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_202 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_205 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_206 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_207 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_208 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_209 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_210 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_211 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_212 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_213 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_214 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_215 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_216 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_217 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_218 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_219 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
Literal_220 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_221 => 'RPerl::Operation::Expression::SubExpression::Literal::String'                   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8335 lib/RPerl/Grammar.pm



1;
