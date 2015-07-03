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
    our $VERSION = 0.001_003;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|\$TYPED_|\=\ sub\ \{|foreach|elsif|while|undef|else|use|\@_\;|our|for|if|\%\{|\@\{|\]|\;|\}|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q\{[^}]*\}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer)\s+/gc and return ('TYPE_INTEGER', $1);
      /\G(filehandleref\s+)/gc and return ('TYPE_FHREF', $1);
      /\G([a-zA-Z]\w*_method)/gc and return ('TYPE_METHOD', $1);
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


#line 132 lib/RPerl/Grammar.pm

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
  [ 'Expression_127' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_138' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_139' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-35', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'PAREN-35' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'OPTIONAL-36', 'Loop' ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_146' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_147' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'PAREN-37' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ 'Conditional_154' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-38', 'OPTIONAL-40' ], 0 ],
  [ 'Loop_155' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_156' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_157' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_158' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_159' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_160' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-41', [ 'PLUS-41', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-41', [ 'Operation' ], 0 ],
  [ 'CodeBlock_163' => 'CodeBlock', [ 'LBRACE', 'PLUS-41', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [ 'STAR-42', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [  ], 0 ],
  [ 'Variable_166' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-42' ], 0 ],
  [ 'VariableRetrieval_167' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_168' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_169' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_170' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_171' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableDeclaration_172' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_173' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_174' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'PAREN-43' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'ListElements_178' => 'ListElements', [ 'ListElement', 'STAR-44' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'PLUS-45', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'WORD' ], 0 ],
  [ 'ListElement_181' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_182' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_183' => 'ListElement', [ 'OP01_QW', 'PLUS-45', ')' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_186' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_189' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_190' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_193' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_194' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryTyped_195' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_196' => 'HashEntryTyped', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_200' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_201' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_204' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_205' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_206' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_207' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_208' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_209' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_210' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_211' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_212' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_213' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_214' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_215' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_216' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_217' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'Literal_218' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_219' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpressionOrStdin_138' => 138,
  'SubExpressionOrStdin_139' => 139,
  '_PAREN' => 140,
  '_OPTIONAL' => 141,
  '_OPTIONAL' => 142,
  'Statement_143' => 143,
  'Statement_144' => 144,
  'Statement_145' => 145,
  'Statement_146' => 146,
  'Statement_147' => 147,
  '_PAREN' => 148,
  '_STAR_LIST' => 149,
  '_STAR_LIST' => 150,
  '_PAREN' => 151,
  '_OPTIONAL' => 152,
  '_OPTIONAL' => 153,
  'Conditional_154' => 154,
  'Loop_155' => 155,
  'Loop_156' => 156,
  'Loop_157' => 157,
  'LoopFor_158' => 158,
  'LoopForEach_159' => 159,
  'LoopWhile_160' => 160,
  '_PLUS_LIST' => 161,
  '_PLUS_LIST' => 162,
  'CodeBlock_163' => 163,
  '_STAR_LIST' => 164,
  '_STAR_LIST' => 165,
  'Variable_166' => 166,
  'VariableRetrieval_167' => 167,
  'VariableRetrieval_168' => 168,
  'VariableRetrieval_169' => 169,
  'VariableDeclaration_170' => 170,
  'VariableDeclaration_171' => 171,
  'VariableDeclaration_172' => 172,
  'VariableModification_173' => 173,
  'VariableModification_174' => 174,
  '_PAREN' => 175,
  '_STAR_LIST' => 176,
  '_STAR_LIST' => 177,
  'ListElements_178' => 178,
  '_PLUS_LIST' => 179,
  '_PLUS_LIST' => 180,
  'ListElement_181' => 181,
  'ListElement_182' => 182,
  'ListElement_183' => 183,
  '_OPTIONAL' => 184,
  '_OPTIONAL' => 185,
  'ArrayReference_186' => 186,
  '_OPTIONAL' => 187,
  '_OPTIONAL' => 188,
  'ArrayDereference_189' => 189,
  'ArrayDereference_190' => 190,
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
  'HashReference_201' => 201,
  '_OPTIONAL' => 202,
  '_OPTIONAL' => 203,
  'HashDereference_204' => 204,
  'HashDereference_205' => 205,
  'WordScoped_206' => 206,
  'WordScoped_207' => 207,
  'LoopLabel_208' => 208,
  'Type_209' => 209,
  'Type_210' => 210,
  'TypeInner_211' => 211,
  'TypeInnerConstant_212' => 212,
  'VariableOrLiteral_213' => 213,
  'VariableOrLiteral_214' => 214,
  'VariableOrLiteralOrWord_215' => 215,
  'VariableOrLiteralOrWord_216' => 216,
  'VariableOrLiteralOrWord_217' => 217,
  'Literal_218' => 218,
  'Literal_219' => 219,
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
			'SHEBANG' => 3,
			"package" => -20,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Program' => 4,
			'PAREN-1' => 5,
			'PLUS-2' => 7,
			'ModuleHeader' => 6,
			'CompileUnit' => 9,
			'Critic' => 1,
			'OPTIONAL-9' => 2
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 3
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-3' => 11,
			'Critic' => 12
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			"our" => -25,
			"use constant" => -25,
			"use parent qw(" => 15,
			"use" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'STAR-10' => 14,
			'Package' => 13,
			'Class' => 16,
			'Module' => 17
		}
	},
	{#State 7
		ACTIONS => {
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-9' => 2,
			'Critic' => 1,
			'ModuleHeader' => 6,
			'PAREN-1' => 18
		}
	},
	{#State 8
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 9
		ACTIONS => {
			'' => 21
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 11
		ACTIONS => {
			"use strict;" => 25
		},
		GOTOS => {
			'Header' => 26
		}
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		ACTIONS => {
			"use constant" => -27,
			"our" => -27,
			"## no critic qw(" => 8,
			"use" => -27
		},
		GOTOS => {
			'Critic' => 28,
			'STAR-11' => 27
		}
	},
	{#State 15
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 16
		DEFAULT => -23
	},
	{#State 17
		DEFAULT => -1
	},
	{#State 18
		DEFAULT => -2
	},
	{#State 19
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		DEFAULT => 0
	},
	{#State 22
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -206
	},
	{#State 24
		DEFAULT => -207
	},
	{#State 25
		ACTIONS => {
			"use warnings;" => 33
		}
	},
	{#State 26
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 34
		}
	},
	{#State 27
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 37
		},
		GOTOS => {
			'Include' => 36,
			'STAR-12' => 35
		}
	},
	{#State 28
		DEFAULT => -24
	},
	{#State 29
		ACTIONS => {
			")" => 38
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
			"use strict;" => 25
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use RPerl;" => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => -11,
			"use constant" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACKET' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'LITERAL_STRING' => -11,
			"if" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"for" => -11,
			"%{" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED' => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_CLOSE' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"use" => -11,
			'OP01_PRINT' => -11,
			'LITERAL_NUMBER' => -11,
			"\@{" => -11,
			'WORD_SCOPED' => -11,
			'LBRACE' => -11,
			'OP01_OPEN' => -11,
			'MY' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LPAREN' => -11,
			"foreach" => -11,
			"while" => -11,
			"our" => -11,
			"undef" => -11,
			"## no critic qw(" => 8,
			'OP10_NAMED_UNARY' => -11
		},
		GOTOS => {
			'Critic' => 41,
			'STAR-5' => 42
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 45,
			"our" => 43
		},
		GOTOS => {
			'Constant' => 46,
			'Subroutine' => 47,
			'PLUS-13' => 44
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 48
		}
	},
	{#State 38
		ACTIONS => {
			";" => 49
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 41
		DEFAULT => -8
	},
	{#State 42
		ACTIONS => {
			'OP01_OPEN' => -13,
			'LBRACE' => -13,
			'WORD_SCOPED' => -13,
			"\@{" => -13,
			"undef" => -13,
			'OP10_NAMED_UNARY' => -13,
			'LPAREN' => -13,
			"foreach" => -13,
			'MY' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"our" => -13,
			"while" => -13,
			'OP19_LOOP_CONTROL' => -13,
			"use" => 37,
			'OP03_MATH_INC_DEC' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_CLOSE' => -13,
			'OP01_PRINT' => -13,
			'LITERAL_NUMBER' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"%{" => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED' => -13,
			"for" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'LBRACKET' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD' => -13,
			"use constant" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"if" => -13,
			'LITERAL_STRING' => -13
		},
		GOTOS => {
			'Include' => 52,
			'STAR-6' => 51
		}
	},
	{#State 43
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 44
		ACTIONS => {
			'LITERAL_NUMBER' => 57,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'WORD_UPPERCASE' => 58
		}
	},
	{#State 46
		DEFAULT => -28
	},
	{#State 47
		DEFAULT => -31
	},
	{#State 48
		ACTIONS => {
			'OP01_QW' => 59,
			";" => 60
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 37
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 62
		}
	},
	{#State 51
		ACTIONS => {
			'OP01_PRINT' => -15,
			'LITERAL_NUMBER' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_CLOSE' => -15,
			"undef" => -15,
			'OP10_NAMED_UNARY' => -15,
			'LPAREN' => -15,
			"foreach" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'MY' => -15,
			"our" => -15,
			"while" => -15,
			'OP01_OPEN' => -15,
			'LBRACE' => -15,
			'WORD_SCOPED' => -15,
			"\@{" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"if" => -15,
			'LITERAL_STRING' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'LBRACKET' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'WORD' => -15,
			"use constant" => 45,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"%{" => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED' => -15,
			"for" => -15
		},
		GOTOS => {
			'Constant' => 64,
			'STAR-7' => 63
		}
	},
	{#State 52
		DEFAULT => -10
	},
	{#State 53
		DEFAULT => -209
	},
	{#State 54
		DEFAULT => -210
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
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
		ACTIONS => {
			'WORD' => 68
		},
		GOTOS => {
			'PLUS-15' => 69
		}
	},
	{#State 60
		DEFAULT => -39
	},
	{#State 61
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 70
		}
	},
	{#State 62
		DEFAULT => -33
	},
	{#State 63
		ACTIONS => {
			'MY' => 109,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			"foreach" => -142,
			"while" => -142,
			"our" => 43,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 117,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'OP01_PRINT' => 97,
			'LITERAL_NUMBER' => 99,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			'OP19_LOOP_CONTROL' => 94,
			'OP03_MATH_INC_DEC' => 96,
			"for" => -142,
			"%{" => 87,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_NAMED' => 89,
			'WORD_UPPERCASE' => 90,
			'LITERAL_STRING' => 77,
			'OP01_NAMED_VOID_SCOLON' => 79,
			"if" => 78,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 72,
			'OP01_NAMED_VOID' => 74,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'OP01_NAMED_VOID_LPAREN' => 76
		},
		GOTOS => {
			'LoopLabel' => 81,
			'Operator' => 80,
			'Subroutine' => 101,
			'HashReference' => 82,
			'HashDereference' => 105,
			'SubExpression' => 106,
			'Literal' => 104,
			'Statement' => 103,
			'Variable' => 85,
			'Conditional' => 84,
			'Operation' => 112,
			'VariableModification' => 83,
			'WordScoped' => 110,
			'PAREN-35' => 115,
			'VariableDeclaration' => 86,
			'OperatorVoid' => 114,
			'Expression' => 93,
			'PLUS-8' => 95,
			'OPTIONAL-36' => 71,
			'ArrayDereference' => 98,
			'ArrayReference' => 100
		}
	},
	{#State 64
		DEFAULT => -12
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 118
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		ACTIONS => {
			'MY' => 120
		},
		GOTOS => {
			'TypeInnerConstant' => 119
		}
	},
	{#State 68
		DEFAULT => -38
	},
	{#State 69
		ACTIONS => {
			'WORD' => 121,
			")" => 122
		}
	},
	{#State 70
		ACTIONS => {
			"use" => -54,
			"our hashref \$properties" => -54,
			"## no critic qw(" => 8,
			"use constant" => -54
		},
		GOTOS => {
			'STAR-21' => 124,
			'Critic' => 123
		}
	},
	{#State 71
		ACTIONS => {
			"foreach" => 127,
			"for" => 131,
			"while" => 125
		},
		GOTOS => {
			'LoopFor' => 130,
			'Loop' => 126,
			'LoopForEach' => 128,
			'LoopWhile' => 129
		}
	},
	{#State 72
		DEFAULT => -165,
		GOTOS => {
			'STAR-42' => 132
		}
	},
	{#State 73
		ACTIONS => {
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			"%{" => 87,
			"undef" => 116
		},
		GOTOS => {
			'HashDereference' => 105,
			'SubExpression' => 134,
			'Literal' => 104,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133,
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98
		}
	},
	{#State 74
		ACTIONS => {
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 139,
			'OP01_QW' => 138,
			"undef" => 116,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96
		},
		GOTOS => {
			'Expression' => 133,
			'ListElement' => 143,
			'Operator' => 80,
			'HashReference' => 82,
			'SubExpression' => 140,
			'Literal' => 104,
			'HashDereference' => 105,
			'TypeInner' => 141,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'ListElements' => 142
		}
	},
	{#State 75
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 92,
			"]" => -185,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LPAREN' => 113,
			'MY' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_QW' => 138,
			"undef" => 116,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'ListElements' => 144,
			'ArrayReference' => 100,
			'Operator' => 80,
			'Expression' => 133,
			'ListElement' => 143,
			'OPTIONAL-46' => 145,
			'TypeInner' => 141,
			'SubExpression' => 140,
			'HashDereference' => 105,
			'Literal' => 104,
			'HashReference' => 82
		}
	},
	{#State 76
		ACTIONS => {
			")" => -111,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			"%{" => 87,
			'OP01_QW' => 138,
			"undef" => 116,
			'OP01_NAMED' => 135,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'MY' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'VARIABLE_SYMBOL' => 72,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACKET' => 75,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99
		},
		GOTOS => {
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'ListElements' => 146,
			'ArrayReference' => 100,
			'Operator' => 80,
			'ListElement' => 143,
			'Expression' => 133,
			'OPTIONAL-32' => 147,
			'TypeInner' => 141,
			'Literal' => 104,
			'SubExpression' => 140,
			'HashDereference' => 105,
			'HashReference' => 82
		}
	},
	{#State 77
		DEFAULT => -219
	},
	{#State 78
		ACTIONS => {
			'LPAREN' => 148
		}
	},
	{#State 79
		DEFAULT => -114
	},
	{#State 80
		DEFAULT => -124
	},
	{#State 81
		ACTIONS => {
			'COLON' => 149
		}
	},
	{#State 82
		DEFAULT => -135
	},
	{#State 83
		DEFAULT => -147
	},
	{#State 84
		DEFAULT => -143
	},
	{#State 85
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 152,
			'OP02_METHOD_THINARROW' => 153,
			'OP09_BITWISE_SHIFT' => -132,
			'OP04_MATH_POW' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP03_MATH_INC_DEC' => 150,
			'OP08_STRING_CAT' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP19_VARIABLE_ASSIGN_BY' => 151,
			'OP15_LOGICAL_AND' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP18_TERNARY' => -132,
			'OP23_LOGICAL_AND' => -132
		}
	},
	{#State 86
		DEFAULT => -146
	},
	{#State 87
		ACTIONS => {
			'LBRACE' => -203,
			'VARIABLE_SYMBOL' => 72,
			'MY' => 139
		},
		GOTOS => {
			'TypeInner' => 154,
			'OPTIONAL-51' => 155,
			'Variable' => 156
		}
	},
	{#State 88
		DEFAULT => -118
	},
	{#State 89
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'VARIABLE_SYMBOL' => 72,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 139,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			"undef" => 116,
			'OP01_QW' => 138,
			"%{" => 87,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'SubExpression' => 158,
			'Literal' => 104,
			'HashDereference' => 105,
			'TypeInner' => 141,
			'HashReference' => 82,
			'Operator' => 80,
			'ListElement' => 157,
			'Expression' => 133
		}
	},
	{#State 90
		ACTIONS => {
			'LPAREN' => 159,
			'COLON' => -208
		}
	},
	{#State 91
		ACTIONS => {
			'FHREF_SYMBOL' => 160
		}
	},
	{#State 92
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'VARIABLE_SYMBOL' => 72,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 108,
			'LBRACE' => 107
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'Variable' => 137,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'SubExpression' => 161,
			'Literal' => 104,
			'HashDereference' => 105
		}
	},
	{#State 93
		ACTIONS => {
			'OP13_BITWISE_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP18_TERNARY' => -129,
			'OP08_STRING_CAT' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			";" => 162,
			'OP04_MATH_POW' => -129
		}
	},
	{#State 94
		ACTIONS => {
			'WORD_UPPERCASE' => 164
		},
		GOTOS => {
			'LoopLabel' => 163
		}
	},
	{#State 95
		ACTIONS => {
			'OP01_NAMED' => 89,
			'WORD_UPPERCASE' => 90,
			"%{" => 87,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'' => -18,
			"for" => -142,
			"if" => 78,
			'OP01_NAMED_VOID_SCOLON' => 79,
			'LITERAL_STRING' => 77,
			'OP01_NAMED_VOID' => 74,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'OP01_NAMED_VOID_LPAREN' => 76,
			'VARIABLE_SYMBOL' => 72,
			'WORD' => 23,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 116,
			"while" => -142,
			'MY' => 109,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			"foreach" => -142,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 99,
			'OP01_PRINT' => 97,
			'OP03_MATH_INC_DEC' => 96,
			'OP19_LOOP_CONTROL' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'Expression' => 93,
			'OPTIONAL-36' => 71,
			'ArrayDereference' => 98,
			'ArrayReference' => 100,
			'Operator' => 80,
			'LoopLabel' => 81,
			'Statement' => 103,
			'SubExpression' => 106,
			'HashDereference' => 105,
			'Literal' => 104,
			'HashReference' => 82,
			'WordScoped' => 110,
			'Operation' => 165,
			'VariableModification' => 83,
			'Conditional' => 84,
			'Variable' => 85,
			'OperatorVoid' => 114,
			'VariableDeclaration' => 86,
			'PAREN-35' => 115
		}
	},
	{#State 96
		ACTIONS => {
			'VARIABLE_SYMBOL' => 72
		},
		GOTOS => {
			'Variable' => 166
		}
	},
	{#State 97
		ACTIONS => {
			'LITERAL_NUMBER' => -109,
			'LITERAL_STRING' => -109,
			'LBRACKET' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'WORD' => -109,
			'OP01_CLOSE' => -109,
			'WORD_UPPERCASE' => -109,
			'OP10_NAMED_UNARY' => -109,
			'STDOUT_STDERR' => 168,
			'OP01_NAMED' => -109,
			'OP01_QW' => -109,
			"undef" => -109,
			"%{" => -109,
			'LPAREN' => -109,
			'FHREF_SYMBOL_BRACES' => 170,
			'OP05_LOGICAL_NEG' => -109,
			'MY' => -109,
			'OP01_OPEN' => -109,
			'LBRACE' => -109,
			'WORD_SCOPED' => -109,
			"\@{" => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 169,
			'PAREN-30' => 167
		}
	},
	{#State 98
		DEFAULT => -134
	},
	{#State 99
		DEFAULT => -218
	},
	{#State 100
		DEFAULT => -133
	},
	{#State 101
		DEFAULT => -14
	},
	{#State 102
		ACTIONS => {
			'LBRACKET' => -188,
			'VARIABLE_SYMBOL' => 72,
			'MY' => 139
		},
		GOTOS => {
			'Variable' => 173,
			'OPTIONAL-47' => 171,
			'TypeInner' => 172
		}
	},
	{#State 103
		DEFAULT => -77
	},
	{#State 104
		DEFAULT => -131
	},
	{#State 105
		DEFAULT => -136
	},
	{#State 106
		ACTIONS => {
			'OP18_TERNARY' => 187,
			'OP23_LOGICAL_AND' => 186,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP06_REGEX_MATCH' => 189,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 180,
			'OP08_STRING_CAT' => 182,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175,
			'OP09_BITWISE_SHIFT' => 177,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 176
		}
	},
	{#State 107
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'WORD' => 194,
			'LITERAL_STRING' => 77,
			"}" => 197,
			"%{" => 87,
			'VARIABLE_SYMBOL' => 72
		},
		GOTOS => {
			'Literal' => 192,
			'HashDereference' => 193,
			'HashEntry' => 195,
			'VariableOrLiteralOrWord' => 191,
			'Variable' => 196
		}
	},
	{#State 108
		ACTIONS => {
			'MY' => 198
		}
	},
	{#State 109
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 53,
			'TYPE_FHREF' => 200
		},
		GOTOS => {
			'Type' => 199
		}
	},
	{#State 110
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 202,
			'LPAREN' => 201
		}
	},
	{#State 111
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'VARIABLE_SYMBOL' => 72,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87
		},
		GOTOS => {
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'SubExpression' => 203,
			'HashDereference' => 105,
			'Literal' => 104,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100
		}
	},
	{#State 112
		DEFAULT => -17
	},
	{#State 113
		ACTIONS => {
			"%{" => 87,
			"undef" => 116,
			'OP01_NAMED' => 204,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_PRINT' => 205,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'VARIABLE_SYMBOL' => 72,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACKET' => 75,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'Variable' => 137,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'Literal' => 104,
			'SubExpression' => 206,
			'HashDereference' => 105
		}
	},
	{#State 114
		DEFAULT => -145
	},
	{#State 115
		DEFAULT => -141
	},
	{#State 116
		DEFAULT => -130
	},
	{#State 117
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -95,
			'OP03_MATH_INC_DEC' => 96,
			'OP16_LOGICAL_OR' => -95,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			")" => -95,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP07_STRING_REPEAT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 116,
			'OP24_LOGICAL_OR_XOR' => -95,
			'LPAREN' => 113,
			'OP08_STRING_CAT' => -95,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP12_COMPARE_EQ_NE' => -95,
			'VARIABLE_SYMBOL' => 72,
			'OP17_LIST_RANGE' => -95,
			'WORD' => 23,
			"]" => -95,
			'OP04_MATH_POW' => -95,
			";" => -95,
			'LITERAL_STRING' => 77,
			'OP18_TERNARY' => -95,
			'OP23_LOGICAL_AND' => -95,
			"}" => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			"%{" => 87
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'HashDereference' => 105,
			'SubExpression' => 207,
			'Literal' => 104,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133
		}
	},
	{#State 118
		ACTIONS => {
			'OP01_CLOSE' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_PRINT' => -43,
			'LITERAL_NUMBER' => -43,
			"\@{" => -43,
			'WORD_SCOPED' => -43,
			'LBRACE' => -43,
			'OP01_OPEN' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'MY' => -43,
			"foreach" => -43,
			'LPAREN' => -43,
			"while" => -43,
			"undef" => -43,
			'OP10_NAMED_UNARY' => -43,
			'WORD' => -43,
			'LPAREN_MY' => 209,
			'VARIABLE_SYMBOL' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_NAMED_VOID_LPAREN' => -43,
			'LBRACKET' => -43,
			'LITERAL_STRING' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			"if" => -43,
			"}" => -43,
			"for" => -43,
			"%{" => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_NAMED' => -43,
			'WORD_UPPERCASE' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 210,
			'SubroutineArguments' => 208
		}
	},
	{#State 119
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Literal' => 211
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 121
		DEFAULT => -37
	},
	{#State 122
		ACTIONS => {
			";" => 213
		}
	},
	{#State 123
		DEFAULT => -51
	},
	{#State 124
		ACTIONS => {
			"use" => 37,
			"our hashref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 214,
			'STAR-22' => 215
		}
	},
	{#State 125
		ACTIONS => {
			'LPAREN' => 216
		}
	},
	{#State 126
		DEFAULT => -144
	},
	{#State 127
		ACTIONS => {
			'MY' => 217
		}
	},
	{#State 128
		DEFAULT => -156
	},
	{#State 129
		DEFAULT => -157
	},
	{#State 130
		DEFAULT => -155
	},
	{#State 131
		ACTIONS => {
			'MY' => 218
		}
	},
	{#State 132
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => -166,
			'OP21_LIST_COMMA' => -166,
			'OP15_LOGICAL_AND' => -166,
			'OP24_LOGICAL_OR_XOR' => -166,
			'OP08_STRING_CAT' => -166,
			"}" => -166,
			'OP23_LOGICAL_AND' => -166,
			'OP18_TERNARY' => -166,
			'OP20_HASH_FATARROW' => -166,
			")" => -166,
			'OP07_MATH_MULT_DIV_MOD' => -166,
			'OP07_STRING_REPEAT' => -166,
			'OP06_REGEX_MATCH' => -166,
			'OP11_COMPARE_LT_GT' => -166,
			'OP13_BITWISE_AND' => -166,
			";" => -166,
			'OP14_BITWISE_OR_XOR' => -166,
			'OP04_MATH_POW' => -166,
			'OP09_BITWISE_SHIFT' => -166,
			'OP02_METHOD_THINARROW' => -166,
			'COLON' => -166,
			'OP19_VARIABLE_ASSIGN' => -166,
			'OP03_MATH_INC_DEC' => -166,
			'OP08_MATH_ADD_SUB' => -166,
			'OP12_COMPARE_EQ_NE' => -166,
			'OP02_ARRAY_THINARROW' => 221,
			'OP16_LOGICAL_OR' => -166,
			'OP02_HASH_THINARROW' => 219,
			"]" => -166,
			'OP17_LIST_RANGE' => -166
		},
		GOTOS => {
			'VariableRetrieval' => 220
		}
	},
	{#State 133
		DEFAULT => -129
	},
	{#State 134
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 180,
			'OP08_STRING_CAT' => 182,
			")" => 222,
			'OP23_LOGICAL_AND' => 186,
			'OP18_TERNARY' => 187,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP09_BITWISE_SHIFT' => 177,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175
		}
	},
	{#State 135
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			"undef" => 116,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'Literal' => 104,
			'SubExpression' => 223,
			'HashDereference' => 105
		}
	},
	{#State 136
		ACTIONS => {
			'LPAREN' => 159
		}
	},
	{#State 137
		ACTIONS => {
			'OP08_STRING_CAT' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP21_LIST_COMMA' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP18_TERNARY' => -132,
			"}" => -132,
			'OP23_LOGICAL_AND' => -132,
			")" => -132,
			'OP04_MATH_POW' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			";" => -132,
			'OP02_METHOD_THINARROW' => 153,
			'OP09_BITWISE_SHIFT' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP17_LIST_RANGE' => -132,
			"]" => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP03_MATH_INC_DEC' => 150,
			'OP12_COMPARE_EQ_NE' => -132
		}
	},
	{#State 138
		ACTIONS => {
			'WORD' => 224
		},
		GOTOS => {
			'PLUS-45' => 225
		}
	},
	{#State 139
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 226
		}
	},
	{#State 140
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			"]" => -181,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175,
			'OP09_BITWISE_SHIFT' => 177,
			'OP14_BITWISE_OR_XOR' => 176,
			";" => -181,
			'OP04_MATH_POW' => 185,
			")" => -181,
			'OP23_LOGICAL_AND' => 186,
			'OP18_TERNARY' => 187,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 189,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP21_LIST_COMMA' => -181,
			'OP15_LOGICAL_AND' => 180,
			'OP08_STRING_CAT' => 182
		}
	},
	{#State 141
		ACTIONS => {
			"undef" => 116,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91
		},
		GOTOS => {
			'Operator' => 80,
			'Expression' => 133,
			'SubExpression' => 227,
			'Literal' => 104,
			'HashDereference' => 105,
			'HashReference' => 82,
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'ArrayReference' => 100
		}
	},
	{#State 142
		ACTIONS => {
			";" => 228
		}
	},
	{#State 143
		DEFAULT => -177,
		GOTOS => {
			'STAR-44' => 229
		}
	},
	{#State 144
		DEFAULT => -184
	},
	{#State 145
		ACTIONS => {
			"]" => 230
		}
	},
	{#State 146
		DEFAULT => -110
	},
	{#State 147
		ACTIONS => {
			")" => 231
		}
	},
	{#State 148
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			"%{" => 87,
			"undef" => 116,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LBRACE' => 107,
			'OP01_OPEN' => 108
		},
		GOTOS => {
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'ArrayReference' => 100,
			'Operator' => 80,
			'Expression' => 133,
			'Literal' => 104,
			'HashDereference' => 105,
			'SubExpression' => 232,
			'HashReference' => 82
		}
	},
	{#State 149
		DEFAULT => -140
	},
	{#State 150
		DEFAULT => -84
	},
	{#State 151
		ACTIONS => {
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'VARIABLE_SYMBOL' => 72,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACKET' => 75,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			"%{" => 87,
			"undef" => 116,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'SubExpression' => 233,
			'HashDereference' => 105,
			'Literal' => 104,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133
		}
	},
	{#State 152
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'VARIABLE_SYMBOL' => 72,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'STDIN' => 234
		},
		GOTOS => {
			'Expression' => 133,
			'Operator' => 80,
			'SubExpressionOrStdin' => 235,
			'HashReference' => 82,
			'Literal' => 104,
			'SubExpression' => 236,
			'HashDereference' => 105,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100
		}
	},
	{#State 153
		ACTIONS => {
			'LPAREN' => 237
		}
	},
	{#State 154
		DEFAULT => -202
	},
	{#State 155
		ACTIONS => {
			'LBRACE' => 107
		},
		GOTOS => {
			'HashReference' => 238
		}
	},
	{#State 156
		ACTIONS => {
			"}" => 239
		}
	},
	{#State 157
		ACTIONS => {
			'OP21_LIST_COMMA' => 240
		}
	},
	{#State 158
		ACTIONS => {
			'OP17_LIST_RANGE' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP04_MATH_POW' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			";" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP07_STRING_REPEAT' => -79,
			")" => -79,
			'OP18_TERNARY' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP21_LIST_COMMA' => -181,
			'OP15_LOGICAL_AND' => -79
		}
	},
	{#State 159
		ACTIONS => {
			")" => 241
		}
	},
	{#State 160
		DEFAULT => -82
	},
	{#State 161
		ACTIONS => {
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 189,
			")" => -104,
			'OP23_LOGICAL_AND' => -104,
			"}" => -104,
			'OP18_TERNARY' => 187,
			'OP08_STRING_CAT' => 182,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP15_LOGICAL_AND' => 180,
			"]" => -104,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP09_BITWISE_SHIFT' => 177,
			";" => -104,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185
		}
	},
	{#State 162
		DEFAULT => -76
	},
	{#State 163
		ACTIONS => {
			";" => 242
		}
	},
	{#State 164
		DEFAULT => -208
	},
	{#State 165
		DEFAULT => -16
	},
	{#State 166
		DEFAULT => -83
	},
	{#State 167
		DEFAULT => -108
	},
	{#State 168
		DEFAULT => -107
	},
	{#State 169
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LPAREN' => 113,
			'MY' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_QW' => 138,
			"undef" => 116,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'ListElements' => 243,
			'ArrayReference' => 100,
			'Operator' => 80,
			'ListElement' => 143,
			'Expression' => 133,
			'TypeInner' => 141,
			'Literal' => 104,
			'SubExpression' => 140,
			'HashDereference' => 105,
			'HashReference' => 82
		}
	},
	{#State 170
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 139,
			'LPAREN' => 113,
			"%{" => 87,
			"undef" => 116,
			'OP01_QW' => 138,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			'VARIABLE_SYMBOL' => 72,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACKET' => 75
		},
		GOTOS => {
			'HashReference' => 82,
			'Literal' => 104,
			'SubExpression' => 140,
			'HashDereference' => 105,
			'TypeInner' => 141,
			'Expression' => 133,
			'ListElement' => 143,
			'Operator' => 80,
			'ArrayReference' => 100,
			'ListElements' => 244,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110
		}
	},
	{#State 171
		ACTIONS => {
			'LBRACKET' => 75
		},
		GOTOS => {
			'ArrayReference' => 245
		}
	},
	{#State 172
		DEFAULT => -187
	},
	{#State 173
		ACTIONS => {
			"}" => 246
		}
	},
	{#State 174
		ACTIONS => {
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'VARIABLE_SYMBOL' => 72
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'SubExpression' => 247,
			'HashDereference' => 105,
			'Literal' => 104,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133
		}
	},
	{#State 175
		ACTIONS => {
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'VARIABLE_SYMBOL' => 72,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23
		},
		GOTOS => {
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 248,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133
		}
	},
	{#State 176
		ACTIONS => {
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			"undef" => 116,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99
		},
		GOTOS => {
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 249
		}
	},
	{#State 177
		ACTIONS => {
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			"%{" => 87,
			"undef" => 116,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'VARIABLE_SYMBOL' => 72,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99
		},
		GOTOS => {
			'SubExpression' => 250,
			'Literal' => 104,
			'HashDereference' => 105,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133,
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137
		}
	},
	{#State 178
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			"%{" => 87,
			"undef" => 116,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			'VARIABLE_SYMBOL' => 72,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75
		},
		GOTOS => {
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'Literal' => 104,
			'SubExpression' => 251,
			'HashDereference' => 105,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100
		}
	},
	{#State 179
		ACTIONS => {
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			"%{" => 87,
			"undef" => 116,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'HashReference' => 82,
			'Literal' => 104,
			'SubExpression' => 252,
			'HashDereference' => 105,
			'Expression' => 133,
			'Operator' => 80,
			'ArrayReference' => 100,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110
		}
	},
	{#State 180
		ACTIONS => {
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'VARIABLE_SYMBOL' => 72,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'HashDereference' => 105,
			'SubExpression' => 253,
			'Literal' => 104,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133,
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98
		}
	},
	{#State 181
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'VARIABLE_SYMBOL' => 72,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'WORD_SCOPED' => 24,
			"\@{" => 102
		},
		GOTOS => {
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'ArrayReference' => 100,
			'Operator' => 80,
			'Expression' => 133,
			'Literal' => 104,
			'SubExpression' => 254,
			'HashDereference' => 105,
			'HashReference' => 82
		}
	},
	{#State 182
		ACTIONS => {
			"undef" => 116,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91
		},
		GOTOS => {
			'HashReference' => 82,
			'SubExpression' => 255,
			'HashDereference' => 105,
			'Literal' => 104,
			'Expression' => 133,
			'Operator' => 80,
			'ArrayReference' => 100,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'WordScoped' => 110
		}
	},
	{#State 183
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'VARIABLE_SYMBOL' => 72,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'WORD_SCOPED' => 24,
			"\@{" => 102
		},
		GOTOS => {
			'Operator' => 80,
			'Expression' => 133,
			'Literal' => 104,
			'SubExpression' => 256,
			'HashDereference' => 105,
			'HashReference' => 82,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'ArrayReference' => 100
		}
	},
	{#State 184
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'VARIABLE_SYMBOL' => 72,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			"%{" => 87,
			"undef" => 116,
			'OP01_NAMED' => 135,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			"\@{" => 102,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'ArrayReference' => 100,
			'Operator' => 80,
			'Expression' => 133,
			'Literal' => 104,
			'HashDereference' => 105,
			'SubExpression' => 257,
			'HashReference' => 82
		}
	},
	{#State 185
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'VARIABLE_SYMBOL' => 72,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107
		},
		GOTOS => {
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'HashDereference' => 105,
			'SubExpression' => 258,
			'Literal' => 104,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100
		}
	},
	{#State 186
		ACTIONS => {
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			"%{" => 87,
			"undef" => 116
		},
		GOTOS => {
			'Literal' => 104,
			'SubExpression' => 259,
			'HashDereference' => 105,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133,
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137
		}
	},
	{#State 187
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 72
		},
		GOTOS => {
			'VariableOrLiteral' => 262,
			'Variable' => 261,
			'Literal' => 260
		}
	},
	{#State 188
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'VARIABLE_SYMBOL' => 72,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACKET' => 75,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			"%{" => 87,
			"undef" => 116,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'LBRACE' => 107,
			'OP01_OPEN' => 108
		},
		GOTOS => {
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 263
		}
	},
	{#State 189
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 264
		}
	},
	{#State 190
		ACTIONS => {
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			"undef" => 116,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'HashReference' => 82,
			'Literal' => 104,
			'HashDereference' => 105,
			'SubExpression' => 265,
			'Expression' => 133,
			'Operator' => 80
		}
	},
	{#State 191
		ACTIONS => {
			'OP20_HASH_FATARROW' => 266
		}
	},
	{#State 192
		DEFAULT => -216
	},
	{#State 193
		DEFAULT => -194
	},
	{#State 194
		DEFAULT => -217
	},
	{#State 195
		DEFAULT => -199,
		GOTOS => {
			'STAR-50' => 267
		}
	},
	{#State 196
		DEFAULT => -215
	},
	{#State 197
		DEFAULT => -201
	},
	{#State 198
		ACTIONS => {
			'TYPE_FHREF' => 268
		}
	},
	{#State 199
		ACTIONS => {
			'VARIABLE_SYMBOL' => 269
		}
	},
	{#State 200
		ACTIONS => {
			'FHREF_SYMBOL' => 270
		}
	},
	{#State 201
		ACTIONS => {
			'LPAREN' => 113,
			'MY' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			'OP01_QW' => 138,
			"undef" => 116,
			"%{" => 87,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			")" => -121,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'VARIABLE_SYMBOL' => 72
		},
		GOTOS => {
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'ListElements' => 271,
			'ArrayReference' => 100,
			'Operator' => 80,
			'ListElement' => 143,
			'Expression' => 133,
			'TypeInner' => 141,
			'Literal' => 104,
			'HashDereference' => 105,
			'SubExpression' => 140,
			'OPTIONAL-33' => 272,
			'HashReference' => 82
		}
	},
	{#State 202
		ACTIONS => {
			")" => 273
		}
	},
	{#State 203
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP17_LIST_RANGE' => -86,
			"]" => -86,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => -86,
			";" => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP18_TERNARY' => -86,
			'OP23_LOGICAL_AND' => -86,
			"}" => -86,
			")" => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP08_STRING_CAT' => -86
		}
	},
	{#State 204
		ACTIONS => {
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 139,
			'LPAREN' => 113,
			'OP01_NAMED' => 135,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			"%{" => 87,
			'OP01_QW' => 138,
			"undef" => 116,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'TypeInner' => 141,
			'Literal' => 104,
			'SubExpression' => 158,
			'HashDereference' => 105,
			'HashReference' => 82,
			'Operator' => 80,
			'ListElement' => 274,
			'Expression' => 133,
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137
		}
	},
	{#State 205
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 275
		}
	},
	{#State 206
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 180,
			'OP08_STRING_CAT' => 182,
			")" => 276,
			'OP18_TERNARY' => 187,
			'OP23_LOGICAL_AND' => 186,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP06_REGEX_MATCH' => 189,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP09_BITWISE_SHIFT' => 177,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175
		}
	},
	{#State 207
		ACTIONS => {
			";" => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP16_LOGICAL_OR' => -94,
			"]" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP08_STRING_CAT' => 182,
			"}" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP18_TERNARY' => -94,
			")" => -94,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP11_COMPARE_LT_GT' => -94,
			'OP13_BITWISE_AND' => -94
		}
	},
	{#State 208
		DEFAULT => -42
	},
	{#State 209
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 277
		}
	},
	{#State 210
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 278
		}
	},
	{#State 211
		ACTIONS => {
			";" => 279
		}
	},
	{#State 212
		ACTIONS => {
			"\$TYPED_" => 280
		}
	},
	{#State 213
		DEFAULT => -40
	},
	{#State 214
		DEFAULT => -53
	},
	{#State 215
		ACTIONS => {
			"our hashref \$properties" => 282,
			"use constant" => 45
		},
		GOTOS => {
			'Properties' => 283,
			'Constant' => 281
		}
	},
	{#State 216
		ACTIONS => {
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			"undef" => 116,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'HashReference' => 82,
			'SubExpression' => 284,
			'Literal' => 104,
			'HashDereference' => 105,
			'Expression' => 133,
			'Operator' => 80
		}
	},
	{#State 217
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 285
		}
	},
	{#State 218
		ACTIONS => {
			'TYPE_INTEGER' => 286
		}
	},
	{#State 219
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'OP01_CLOSE' => 91,
			'WORD' => 288,
			'OP22_LOGICAL_NEG' => 92,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 135,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			"%{" => 87,
			"undef" => 116,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113
		},
		GOTOS => {
			'HashReference' => 82,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 287,
			'Expression' => 133,
			'Operator' => 80,
			'ArrayReference' => 100,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'WordScoped' => 110
		}
	},
	{#State 220
		DEFAULT => -164
	},
	{#State 221
		ACTIONS => {
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			"undef" => 116,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'HashDereference' => 105,
			'SubExpression' => 289,
			'Literal' => 104
		}
	},
	{#State 222
		DEFAULT => -87
	},
	{#State 223
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			")" => -79,
			'OP23_LOGICAL_AND' => -79,
			"}" => -79,
			'OP18_TERNARY' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			";" => -79,
			'OP04_MATH_POW' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			"]" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP16_LOGICAL_OR' => -79
		}
	},
	{#State 224
		DEFAULT => -180
	},
	{#State 225
		ACTIONS => {
			")" => 290,
			'WORD' => 291
		}
	},
	{#State 226
		ACTIONS => {
			"\$TYPED_" => 292
		}
	},
	{#State 227
		ACTIONS => {
			'OP18_TERNARY' => 187,
			'OP23_LOGICAL_AND' => 186,
			")" => -182,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP15_LOGICAL_AND' => 180,
			'OP21_LIST_COMMA' => -182,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP08_STRING_CAT' => 182,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP16_LOGICAL_OR' => 175,
			'OP17_LIST_RANGE' => 184,
			"]" => -182,
			'OP04_MATH_POW' => 185,
			";" => -182,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 228
		DEFAULT => -116
	},
	{#State 229
		ACTIONS => {
			"]" => -178,
			'OP21_LIST_COMMA' => 293,
			";" => -178,
			")" => -178
		},
		GOTOS => {
			'PAREN-43' => 294
		}
	},
	{#State 230
		DEFAULT => -186
	},
	{#State 231
		ACTIONS => {
			";" => 295
		}
	},
	{#State 232
		ACTIONS => {
			'OP08_STRING_CAT' => 182,
			'OP15_LOGICAL_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 189,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP23_LOGICAL_AND' => 186,
			'OP18_TERNARY' => 187,
			")" => 296,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 175,
			'OP17_LIST_RANGE' => 184,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183
		}
	},
	{#State 233
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 189,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP23_LOGICAL_AND' => 186,
			'OP18_TERNARY' => 187,
			'OP08_STRING_CAT' => 182,
			'OP15_LOGICAL_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP16_LOGICAL_OR' => 175,
			'OP17_LIST_RANGE' => 184,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			";" => 297,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 234
		DEFAULT => -139
	},
	{#State 235
		ACTIONS => {
			";" => 298
		}
	},
	{#State 236
		ACTIONS => {
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP09_BITWISE_SHIFT' => 177,
			'OP04_MATH_POW' => 185,
			";" => -138,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP18_TERNARY' => 187,
			'OP23_LOGICAL_AND' => 186,
			'OP08_STRING_CAT' => 182,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 180
		}
	},
	{#State 237
		ACTIONS => {
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			")" => -123,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LPAREN' => 113,
			'MY' => 139,
			'OP05_LOGICAL_NEG' => 111,
			"undef" => 116,
			'OP01_QW' => 138,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99
		},
		GOTOS => {
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'OPTIONAL-34' => 299,
			'ListElements' => 300,
			'ListElement' => 143,
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 140,
			'TypeInner' => 141
		}
	},
	{#State 238
		ACTIONS => {
			"}" => 301
		}
	},
	{#State 239
		DEFAULT => -204
	},
	{#State 240
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_NAMED' => 135,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			"%{" => 87,
			'OP01_QW' => 138,
			"undef" => 116,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 139,
			'LPAREN' => 113
		},
		GOTOS => {
			'ArrayReference' => 100,
			'ListElements' => 302,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'HashReference' => 82,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 140,
			'TypeInner' => 141,
			'Expression' => 133,
			'ListElement' => 143,
			'Operator' => 80
		}
	},
	{#State 241
		DEFAULT => -126
	},
	{#State 242
		DEFAULT => -119
	},
	{#State 243
		ACTIONS => {
			";" => 303
		}
	},
	{#State 244
		ACTIONS => {
			";" => 304
		}
	},
	{#State 245
		ACTIONS => {
			"}" => 305
		}
	},
	{#State 246
		DEFAULT => -189
	},
	{#State 247
		ACTIONS => {
			")" => -91,
			'OP18_TERNARY' => -91,
			'OP23_LOGICAL_AND' => -91,
			"}" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP06_REGEX_MATCH' => 189,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP08_STRING_CAT' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP17_LIST_RANGE' => -91,
			"]" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP04_MATH_POW' => 185,
			";" => -91,
			'OP14_BITWISE_OR_XOR' => -91
		}
	},
	{#State 248
		ACTIONS => {
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			"}" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP18_TERNARY' => -101,
			")" => -101,
			'OP08_STRING_CAT' => 182,
			'OP15_LOGICAL_AND' => 180,
			'OP21_LIST_COMMA' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			"]" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP14_BITWISE_OR_XOR' => 176,
			";" => -101,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 249
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP16_LOGICAL_OR' => -99,
			'OP17_LIST_RANGE' => -99,
			"]" => -99,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => -99,
			";" => -99,
			'OP09_BITWISE_SHIFT' => 177,
			'OP18_TERNARY' => -99,
			'OP23_LOGICAL_AND' => -99,
			"}" => -99,
			")" => -99,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP15_LOGICAL_AND' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_STRING_CAT' => 182
		}
	},
	{#State 250
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -93,
			'OP08_MATH_ADD_SUB' => 174,
			"]" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			";" => -93,
			'OP04_MATH_POW' => 185,
			")" => -93,
			"}" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP18_TERNARY' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP08_STRING_CAT' => 182
		}
	},
	{#State 251
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			";" => -89,
			'OP04_MATH_POW' => 185,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			"]" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP08_STRING_CAT' => -89,
			")" => -89,
			"}" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP18_TERNARY' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP06_REGEX_MATCH' => 189
		}
	},
	{#State 252
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 182,
			")" => -98,
			'OP18_TERNARY' => -98,
			"}" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP11_COMPARE_LT_GT' => 190,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177,
			'OP04_MATH_POW' => 185,
			";" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP17_LIST_RANGE' => -98,
			"]" => -98,
			'OP16_LOGICAL_OR' => -98
		}
	},
	{#State 253
		ACTIONS => {
			'OP15_LOGICAL_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_STRING_CAT' => 182,
			'OP18_TERNARY' => -100,
			'OP23_LOGICAL_AND' => -100,
			"}" => -100,
			")" => -100,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP04_MATH_POW' => 185,
			";" => -100,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP09_BITWISE_SHIFT' => 177,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP16_LOGICAL_OR' => -100,
			'OP17_LIST_RANGE' => -100,
			"]" => -100
		}
	},
	{#State 254
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP16_LOGICAL_OR' => 175,
			'OP17_LIST_RANGE' => 184,
			"]" => -106,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 176,
			";" => -106,
			'OP09_BITWISE_SHIFT' => 177,
			'OP18_TERNARY' => 187,
			'OP23_LOGICAL_AND' => 186,
			"}" => -106,
			")" => -106,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP15_LOGICAL_AND' => 180,
			'OP21_LIST_COMMA' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_STRING_CAT' => 182
		}
	},
	{#State 255
		ACTIONS => {
			'OP08_STRING_CAT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			")" => -92,
			'OP18_TERNARY' => -92,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP04_MATH_POW' => 185,
			";" => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP17_LIST_RANGE' => -92,
			"]" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP08_MATH_ADD_SUB' => 174
		}
	},
	{#State 256
		ACTIONS => {
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => -97,
			"}" => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			")" => -97,
			'OP08_STRING_CAT' => 182,
			'OP15_LOGICAL_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP16_LOGICAL_OR' => -97,
			"]" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP14_BITWISE_OR_XOR' => -97,
			";" => -97,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 257
		ACTIONS => {
			'OP08_STRING_CAT' => 182,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP15_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			")" => -102,
			"}" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP09_BITWISE_SHIFT' => 177,
			";" => -102,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			"]" => -102,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 175,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174
		}
	},
	{#State 258
		ACTIONS => {
			'OP16_LOGICAL_OR' => -85,
			'OP17_LIST_RANGE' => -85,
			"]" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP04_MATH_POW' => 185,
			";" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP18_TERNARY' => -85,
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			")" => -85,
			'OP08_STRING_CAT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP24_LOGICAL_OR_XOR' => -85
		}
	},
	{#State 259
		ACTIONS => {
			'OP15_LOGICAL_AND' => 180,
			'OP21_LIST_COMMA' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP08_STRING_CAT' => 182,
			'OP23_LOGICAL_AND' => -105,
			"}" => -105,
			'OP18_TERNARY' => 187,
			")" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			";" => -105,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP16_LOGICAL_OR' => 175,
			"]" => -105,
			'OP17_LIST_RANGE' => 184
		}
	},
	{#State 260
		DEFAULT => -214
	},
	{#State 261
		DEFAULT => -213
	},
	{#State 262
		ACTIONS => {
			'COLON' => 306
		}
	},
	{#State 263
		ACTIONS => {
			'OP04_MATH_POW' => 185,
			";" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP17_LIST_RANGE' => -90,
			"]" => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP08_STRING_CAT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP06_REGEX_MATCH' => 189,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP18_TERNARY' => -90,
			'OP23_LOGICAL_AND' => -90,
			"}" => -90,
			")" => -90
		}
	},
	{#State 264
		DEFAULT => -88
	},
	{#State 265
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP17_LIST_RANGE' => -96,
			"]" => -96,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => -96,
			";" => -96,
			'OP09_BITWISE_SHIFT' => 177,
			'OP18_TERNARY' => -96,
			'OP23_LOGICAL_AND' => -96,
			"}" => -96,
			")" => -96,
			'OP06_REGEX_MATCH' => 189,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP13_BITWISE_AND' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP15_LOGICAL_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_STRING_CAT' => 182
		}
	},
	{#State 266
		ACTIONS => {
			"%{" => -192,
			"undef" => -192,
			'OP01_NAMED' => -192,
			'WORD_UPPERCASE' => -192,
			'OP10_NAMED_UNARY' => -192,
			'OP05_LOGICAL_NEG' => -192,
			'MY' => 139,
			'LPAREN' => -192,
			'LBRACE' => -192,
			'OP01_OPEN' => -192,
			"\@{" => -192,
			'WORD_SCOPED' => -192,
			'LITERAL_STRING' => -192,
			'LITERAL_NUMBER' => -192,
			'VARIABLE_SYMBOL' => -192,
			'OP03_MATH_INC_DEC' => -192,
			'OP05_MATH_NEG_LPAREN' => -192,
			'LBRACKET' => -192,
			'OP01_CLOSE' => -192,
			'WORD' => -192,
			'OP22_LOGICAL_NEG' => -192
		},
		GOTOS => {
			'OPTIONAL-48' => 308,
			'TypeInner' => 307
		}
	},
	{#State 267
		ACTIONS => {
			"}" => 310,
			'OP21_LIST_COMMA' => 309
		},
		GOTOS => {
			'PAREN-49' => 311
		}
	},
	{#State 268
		ACTIONS => {
			'FHREF_SYMBOL' => 312
		}
	},
	{#State 269
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 314,
			";" => 313
		}
	},
	{#State 270
		ACTIONS => {
			";" => 315
		}
	},
	{#State 271
		DEFAULT => -120
	},
	{#State 272
		ACTIONS => {
			")" => 316
		}
	},
	{#State 273
		DEFAULT => -128
	},
	{#State 274
		ACTIONS => {
			'OP21_LIST_COMMA' => 317
		}
	},
	{#State 275
		ACTIONS => {
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			"undef" => 116,
			'OP01_QW' => 138,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 139
		},
		GOTOS => {
			'ArrayReference' => 100,
			'ListElements' => 318,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'WordScoped' => 110,
			'HashReference' => 82,
			'TypeInner' => 141,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 140,
			'Expression' => 133,
			'ListElement' => 143,
			'Operator' => 80
		}
	},
	{#State 276
		DEFAULT => -137
	},
	{#State 277
		ACTIONS => {
			'VARIABLE_SYMBOL' => 319
		}
	},
	{#State 278
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 79,
			"if" => 78,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP01_NAMED_VOID_LPAREN' => 76,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP01_NAMED_VOID' => 74,
			'WORD' => 23,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"%{" => 87,
			'WORD_UPPERCASE' => 90,
			'OP01_NAMED' => 89,
			"for" => -142,
			"}" => 321,
			'OP01_PRINT' => 97,
			'LITERAL_NUMBER' => 99,
			'OP19_LOOP_CONTROL' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 117,
			"foreach" => -142,
			'LPAREN' => 113,
			'MY' => 109,
			'OP05_LOGICAL_NEG' => 111,
			"while" => -142,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'WORD_SCOPED' => 24,
			"\@{" => 102
		},
		GOTOS => {
			'Statement' => 103,
			'Literal' => 104,
			'HashDereference' => 105,
			'SubExpression' => 106,
			'HashReference' => 82,
			'Operator' => 80,
			'LoopLabel' => 81,
			'OperatorVoid' => 114,
			'VariableDeclaration' => 86,
			'PAREN-35' => 115,
			'WordScoped' => 110,
			'Operation' => 320,
			'VariableModification' => 83,
			'Conditional' => 84,
			'Variable' => 85,
			'OPTIONAL-36' => 71,
			'Expression' => 93,
			'ArrayReference' => 100,
			'ArrayDereference' => 98
		}
	},
	{#State 279
		DEFAULT => -41
	},
	{#State 280
		ACTIONS => {
			'WORD_UPPERCASE' => 322
		}
	},
	{#State 281
		DEFAULT => -55
	},
	{#State 282
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 323
		}
	},
	{#State 283
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 324
		}
	},
	{#State 284
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 175,
			'OP17_LIST_RANGE' => 184,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_STRING_CAT' => 182,
			'OP15_LOGICAL_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP23_LOGICAL_AND' => 186,
			'OP18_TERNARY' => 187,
			")" => 325
		}
	},
	{#State 285
		ACTIONS => {
			'VARIABLE_SYMBOL' => 326
		}
	},
	{#State 286
		ACTIONS => {
			'VARIABLE_SYMBOL' => 327
		}
	},
	{#State 287
		ACTIONS => {
			'OP08_STRING_CAT' => 182,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 180,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP18_TERNARY' => 187,
			'OP23_LOGICAL_AND' => 186,
			"}" => 328,
			'OP09_BITWISE_SHIFT' => 177,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174
		}
	},
	{#State 288
		ACTIONS => {
			'LPAREN' => -206,
			'OP02_METHOD_THINARROW_NEW' => -206,
			"}" => 329
		}
	},
	{#State 289
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 177,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			"]" => 330,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP08_STRING_CAT' => 182,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP23_LOGICAL_AND' => 186,
			'OP18_TERNARY' => 187
		}
	},
	{#State 290
		DEFAULT => -183
	},
	{#State 291
		DEFAULT => -179
	},
	{#State 292
		ACTIONS => {
			'WORD' => 331
		}
	},
	{#State 293
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'VARIABLE_SYMBOL' => 72,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 139,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			"undef" => 116,
			'OP01_QW' => 138,
			"%{" => 87,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107
		},
		GOTOS => {
			'TypeInner' => 141,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 140,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133,
			'ListElement' => 332,
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137
		}
	},
	{#State 294
		DEFAULT => -176
	},
	{#State 295
		DEFAULT => -115
	},
	{#State 296
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 333
		}
	},
	{#State 297
		DEFAULT => -174
	},
	{#State 298
		DEFAULT => -173
	},
	{#State 299
		ACTIONS => {
			")" => 335
		}
	},
	{#State 300
		DEFAULT => -122
	},
	{#State 301
		DEFAULT => -205
	},
	{#State 302
		ACTIONS => {
			";" => 336
		}
	},
	{#State 303
		DEFAULT => -112
	},
	{#State 304
		DEFAULT => -113
	},
	{#State 305
		DEFAULT => -190
	},
	{#State 306
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 72
		},
		GOTOS => {
			'VariableOrLiteral' => 337,
			'Variable' => 261,
			'Literal' => 260
		}
	},
	{#State 307
		DEFAULT => -191
	},
	{#State 308
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_NAMED' => 135,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			"%{" => 87,
			"undef" => 116,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 24,
			"\@{" => 102
		},
		GOTOS => {
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'SubExpression' => 338,
			'HashDereference' => 105,
			'Literal' => 104,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100
		}
	},
	{#State 309
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77,
			'WORD' => 194,
			'VARIABLE_SYMBOL' => 72,
			"%{" => 87
		},
		GOTOS => {
			'Variable' => 196,
			'VariableOrLiteralOrWord' => 191,
			'HashEntry' => 339,
			'Literal' => 192,
			'HashDereference' => 193
		}
	},
	{#State 310
		DEFAULT => -200
	},
	{#State 311
		DEFAULT => -198
	},
	{#State 312
		ACTIONS => {
			'OP21_LIST_COMMA' => 340
		}
	},
	{#State 313
		DEFAULT => -170
	},
	{#State 314
		ACTIONS => {
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'STDIN' => 234,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			"undef" => 116,
			"%{" => 87,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'VARIABLE_SYMBOL' => 72,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'ArrayReference' => 100,
			'Operator' => 80,
			'SubExpressionOrStdin' => 341,
			'Expression' => 133,
			'SubExpression' => 236,
			'Literal' => 104,
			'HashDereference' => 105,
			'HashReference' => 82
		}
	},
	{#State 315
		DEFAULT => -172
	},
	{#State 316
		DEFAULT => -125
	},
	{#State 317
		ACTIONS => {
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			"undef" => 116,
			'OP01_QW' => 138,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 139
		},
		GOTOS => {
			'ListElements' => 342,
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'TypeInner' => 141,
			'Literal' => 104,
			'SubExpression' => 140,
			'HashDereference' => 105,
			'HashReference' => 82,
			'Operator' => 80,
			'ListElement' => 143,
			'Expression' => 133
		}
	},
	{#State 318
		ACTIONS => {
			")" => 343
		}
	},
	{#State 319
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 344
		}
	},
	{#State 320
		DEFAULT => -44
	},
	{#State 321
		ACTIONS => {
			";" => 345
		}
	},
	{#State 322
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 346
		}
	},
	{#State 323
		ACTIONS => {
			'LBRACE' => 347
		}
	},
	{#State 324
		ACTIONS => {
			'LITERAL_NUMBER' => 348,
			"our" => 351
		},
		GOTOS => {
			'MethodOrSubroutine' => 349,
			'Subroutine' => 352,
			'Method' => 350
		}
	},
	{#State 325
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 353
		}
	},
	{#State 326
		ACTIONS => {
			'LPAREN' => 354
		}
	},
	{#State 327
		ACTIONS => {
			'LPAREN' => 355
		}
	},
	{#State 328
		DEFAULT => -168
	},
	{#State 329
		DEFAULT => -169
	},
	{#State 330
		DEFAULT => -167
	},
	{#State 331
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 356
		}
	},
	{#State 332
		DEFAULT => -175
	},
	{#State 333
		DEFAULT => -150,
		GOTOS => {
			'STAR-38' => 357
		}
	},
	{#State 334
		ACTIONS => {
			'OP01_PRINT' => 97,
			'LITERAL_NUMBER' => 99,
			'OP19_LOOP_CONTROL' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 117,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 109,
			"foreach" => -142,
			'LPAREN' => 113,
			"while" => -142,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_NAMED_VOID_SCOLON' => 79,
			"if" => 78,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 72,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP01_NAMED_VOID' => 74,
			'LBRACKET' => 75,
			'OP01_NAMED_VOID_LPAREN' => 76,
			'WORD' => 23,
			"%{" => 87,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_NAMED' => 89,
			'WORD_UPPERCASE' => 90,
			"for" => -142
		},
		GOTOS => {
			'OPTIONAL-36' => 71,
			'Expression' => 93,
			'PLUS-41' => 359,
			'ArrayReference' => 100,
			'ArrayDereference' => 98,
			'Statement' => 103,
			'SubExpression' => 106,
			'Literal' => 104,
			'HashDereference' => 105,
			'HashReference' => 82,
			'Operator' => 80,
			'LoopLabel' => 81,
			'VariableDeclaration' => 86,
			'OperatorVoid' => 114,
			'PAREN-35' => 115,
			'Operation' => 358,
			'VariableModification' => 83,
			'WordScoped' => 110,
			'Conditional' => 84,
			'Variable' => 85
		}
	},
	{#State 335
		DEFAULT => -127
	},
	{#State 336
		DEFAULT => -117
	},
	{#State 337
		DEFAULT => -103
	},
	{#State 338
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 175,
			'OP17_LIST_RANGE' => 184,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_STRING_CAT' => 182,
			'OP15_LOGICAL_AND' => 180,
			'OP21_LIST_COMMA' => -193,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP23_LOGICAL_AND' => 186,
			"}" => -193,
			'OP18_TERNARY' => 187
		}
	},
	{#State 339
		DEFAULT => -197
	},
	{#State 340
		ACTIONS => {
			'LITERAL_STRING' => 360
		}
	},
	{#State 341
		ACTIONS => {
			";" => 361
		}
	},
	{#State 342
		ACTIONS => {
			")" => 362
		}
	},
	{#State 343
		DEFAULT => -78
	},
	{#State 344
		ACTIONS => {
			'OP21_LIST_COMMA' => 364,
			")" => 365
		},
		GOTOS => {
			'PAREN-18' => 363
		}
	},
	{#State 345
		DEFAULT => -46
	},
	{#State 346
		DEFAULT => -212
	},
	{#State 347
		ACTIONS => {
			'WORD' => 367,
			"%{" => 87,
			"}" => 366
		},
		GOTOS => {
			'HashDereference' => 369,
			'HashEntryTyped' => 368
		}
	},
	{#State 348
		ACTIONS => {
			";" => 370
		}
	},
	{#State 349
		DEFAULT => -57
	},
	{#State 350
		DEFAULT => -74
	},
	{#State 351
		ACTIONS => {
			'TYPE_METHOD' => 371,
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 352
		DEFAULT => -75
	},
	{#State 353
		DEFAULT => -160
	},
	{#State 354
		ACTIONS => {
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'MY' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'OP01_NAMED' => 135,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			"%{" => 87,
			'OP01_QW' => 138,
			"undef" => 116,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'ListElement' => 143,
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'TypeInner' => 141,
			'HashDereference' => 105,
			'SubExpression' => 140,
			'Literal' => 104,
			'ArrayDereference' => 98,
			'Variable' => 137,
			'WordScoped' => 110,
			'ArrayReference' => 100,
			'ListElements' => 372
		}
	},
	{#State 355
		ACTIONS => {
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			"undef" => 116,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'OP22_LOGICAL_NEG' => 92,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99
		},
		GOTOS => {
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'SubExpression' => 373,
			'Literal' => 104,
			'HashDereference' => 105,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100
		}
	},
	{#State 356
		DEFAULT => -211
	},
	{#State 357
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -153,
			'OP19_LOOP_CONTROL' => -153,
			'OP01_CLOSE' => -153,
			'OP22_LOGICAL_NEG' => -153,
			'LITERAL_NUMBER' => -153,
			'OP01_PRINT' => -153,
			'LBRACE' => -153,
			'OP01_OPEN' => -153,
			"\@{" => -153,
			'WORD_SCOPED' => -153,
			'OP10_NAMED_UNARY' => -153,
			"undef" => -153,
			"while" => -153,
			'OP05_LOGICAL_NEG' => -153,
			'MY' => -153,
			"else" => 374,
			"foreach" => -153,
			'LPAREN' => -153,
			'OP01_NAMED_VOID' => -153,
			'OP05_MATH_NEG_LPAREN' => -153,
			'OP01_NAMED_VOID_LPAREN' => -153,
			'LBRACKET' => -153,
			'VARIABLE_SYMBOL' => -153,
			'WORD' => -153,
			"if" => -153,
			'OP01_NAMED_VOID_SCOLON' => -153,
			'LITERAL_STRING' => -153,
			"}" => -153,
			'OP01_NAMED' => -153,
			'WORD_UPPERCASE' => -153,
			"%{" => -153,
			'OP19_LOOP_CONTROL_SCOLON' => -153,
			'' => -153,
			"elsif" => 377,
			"for" => -153
		},
		GOTOS => {
			'PAREN-37' => 376,
			'PAREN-39' => 378,
			'OPTIONAL-40' => 375
		}
	},
	{#State 358
		DEFAULT => -162
	},
	{#State 359
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'OP01_PRINT' => 97,
			'OP03_MATH_INC_DEC' => 96,
			'OP19_LOOP_CONTROL' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 117,
			"undef" => 116,
			"while" => -142,
			'OP05_LOGICAL_NEG' => 111,
			'MY' => 109,
			'LPAREN' => 113,
			"foreach" => -142,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			"if" => 78,
			'OP01_NAMED_VOID_SCOLON' => 79,
			'LITERAL_STRING' => 77,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP01_NAMED_VOID' => 74,
			'OP01_NAMED_VOID_LPAREN' => 76,
			'LBRACKET' => 75,
			'VARIABLE_SYMBOL' => 72,
			'WORD' => 23,
			'OP01_NAMED' => 89,
			'WORD_UPPERCASE' => 90,
			"%{" => 87,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"for" => -142,
			"}" => 380
		},
		GOTOS => {
			'Conditional' => 84,
			'Operation' => 379,
			'WordScoped' => 110,
			'VariableModification' => 83,
			'Variable' => 85,
			'PAREN-35' => 115,
			'VariableDeclaration' => 86,
			'OperatorVoid' => 114,
			'Operator' => 80,
			'LoopLabel' => 81,
			'SubExpression' => 106,
			'HashDereference' => 105,
			'Literal' => 104,
			'Statement' => 103,
			'HashReference' => 82,
			'ArrayDereference' => 98,
			'ArrayReference' => 100,
			'Expression' => 93,
			'OPTIONAL-36' => 71
		}
	},
	{#State 360
		ACTIONS => {
			'OP21_LIST_COMMA' => 381
		}
	},
	{#State 361
		DEFAULT => -171
	},
	{#State 362
		DEFAULT => -80
	},
	{#State 363
		DEFAULT => -48
	},
	{#State 364
		ACTIONS => {
			'MY' => 382
		}
	},
	{#State 365
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 383
		}
	},
	{#State 366
		ACTIONS => {
			";" => 384
		}
	},
	{#State 367
		ACTIONS => {
			'OP20_HASH_FATARROW' => 385
		}
	},
	{#State 368
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 386
		}
	},
	{#State 369
		DEFAULT => -196
	},
	{#State 370
		DEFAULT => -59
	},
	{#State 371
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 372
		ACTIONS => {
			")" => 388
		}
	},
	{#State 373
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 176,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP16_LOGICAL_OR' => 175,
			'OP17_LIST_RANGE' => 389,
			'OP15_LOGICAL_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP08_STRING_CAT' => 182,
			'OP23_LOGICAL_AND' => 186,
			'OP18_TERNARY' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190
		}
	},
	{#State 374
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 390
		}
	},
	{#State 375
		DEFAULT => -154
	},
	{#State 376
		DEFAULT => -149
	},
	{#State 377
		ACTIONS => {
			'LPAREN' => 391
		}
	},
	{#State 378
		DEFAULT => -152
	},
	{#State 379
		DEFAULT => -161
	},
	{#State 380
		DEFAULT => -163
	},
	{#State 381
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			"%{" => 87,
			"undef" => 116,
			'OP01_NAMED' => 135,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 92,
			'VARIABLE_SYMBOL' => 72,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACKET' => 75
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'HashReference' => 82,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 392,
			'Expression' => 133,
			'Operator' => 80
		}
	},
	{#State 382
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 393
		}
	},
	{#State 383
		ACTIONS => {
			"\@_;" => 394
		}
	},
	{#State 384
		DEFAULT => -64
	},
	{#State 385
		ACTIONS => {
			'MY' => 139
		},
		GOTOS => {
			'TypeInner' => 395
		}
	},
	{#State 386
		ACTIONS => {
			"}" => 397,
			'OP21_LIST_COMMA' => 398
		},
		GOTOS => {
			'PAREN-24' => 396
		}
	},
	{#State 387
		ACTIONS => {
			"= sub {" => 399
		}
	},
	{#State 388
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 400
		}
	},
	{#State 389
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_MATH_NEG_LPAREN' => 73,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			"undef" => 116,
			"%{" => 87,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 117,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'Expression' => 133,
			'Operator' => 80,
			'HashReference' => 82,
			'Literal' => 104,
			'SubExpression' => 401,
			'HashDereference' => 105,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'WordScoped' => 110,
			'ArrayReference' => 100
		}
	},
	{#State 390
		DEFAULT => -151
	},
	{#State 391
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LPAREN' => 113,
			'OP05_LOGICAL_NEG' => 111,
			"undef" => 116,
			"%{" => 87,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP01_NAMED' => 135,
			'WORD_SCOPED' => 24,
			"\@{" => 102,
			'OP01_OPEN' => 108,
			'LBRACE' => 107
		},
		GOTOS => {
			'Operator' => 80,
			'Expression' => 133,
			'Literal' => 104,
			'SubExpression' => 402,
			'HashDereference' => 105,
			'HashReference' => 82,
			'WordScoped' => 110,
			'Variable' => 137,
			'ArrayDereference' => 98,
			'ArrayReference' => 100
		}
	},
	{#State 392
		ACTIONS => {
			'OP08_STRING_CAT' => 182,
			'OP15_LOGICAL_AND' => 180,
			'OP21_LIST_COMMA' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP06_REGEX_MATCH' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			"}" => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP18_TERNARY' => 187,
			")" => -81,
			'OP14_BITWISE_OR_XOR' => 176,
			";" => -81,
			'OP04_MATH_POW' => 185,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 175,
			"]" => -81,
			'OP17_LIST_RANGE' => 184,
			'OP08_MATH_ADD_SUB' => 174,
			'OP12_COMPARE_EQ_NE' => 183
		}
	},
	{#State 393
		ACTIONS => {
			'VARIABLE_SYMBOL' => 403
		}
	},
	{#State 394
		DEFAULT => -50
	},
	{#State 395
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 99,
			'VARIABLE_SYMBOL' => 72,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACKET' => 75,
			'WORD' => 23,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 92,
			"%{" => 87,
			"undef" => 116,
			'OP01_NAMED' => 135,
			'OP10_NAMED_UNARY' => 117,
			'WORD_UPPERCASE' => 136,
			'OP05_LOGICAL_NEG' => 111,
			'LPAREN' => 113,
			'LBRACE' => 107,
			'OP01_OPEN' => 108,
			"\@{" => 102,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 404,
			'HashReference' => 82,
			'Operator' => 80,
			'Expression' => 133,
			'ArrayReference' => 100,
			'WordScoped' => 110,
			'ArrayDereference' => 98,
			'Variable' => 137
		}
	},
	{#State 396
		DEFAULT => -61
	},
	{#State 397
		ACTIONS => {
			";" => 405
		}
	},
	{#State 398
		ACTIONS => {
			"%{" => 87,
			'WORD' => 367
		},
		GOTOS => {
			'HashEntryTyped' => 406,
			'HashDereference' => 369
		}
	},
	{#State 399
		ACTIONS => {
			'OP01_CLOSE' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP01_PRINT' => -66,
			'LITERAL_NUMBER' => -66,
			"\@{" => -66,
			'WORD_SCOPED' => -66,
			'LBRACE' => -66,
			'OP01_OPEN' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'MY' => -66,
			'LPAREN' => -66,
			"foreach" => -66,
			"while" => -66,
			"undef" => -66,
			'OP10_NAMED_UNARY' => -66,
			'WORD' => -66,
			'LPAREN_MY' => 407,
			'VARIABLE_SYMBOL' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP01_NAMED_VOID' => -66,
			'LBRACKET' => -66,
			'OP01_NAMED_VOID_LPAREN' => -66,
			'LITERAL_STRING' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			"if" => -66,
			"}" => -66,
			"for" => -66,
			"%{" => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP01_NAMED' => -66,
			'WORD_UPPERCASE' => -66
		},
		GOTOS => {
			'MethodArguments' => 408,
			'OPTIONAL-26' => 409
		}
	},
	{#State 400
		DEFAULT => -159
	},
	{#State 401
		ACTIONS => {
			'OP08_STRING_CAT' => 182,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP15_LOGICAL_AND' => 180,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP06_REGEX_MATCH' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP07_STRING_REPEAT' => 178,
			")" => 410,
			'OP18_TERNARY' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP09_BITWISE_SHIFT' => 177,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 175,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174
		}
	},
	{#State 402
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 177,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 176,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 180,
			'OP08_STRING_CAT' => 182,
			")" => 411,
			'OP18_TERNARY' => 187,
			'OP23_LOGICAL_AND' => 186,
			'OP13_BITWISE_AND' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP06_REGEX_MATCH' => 189,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188
		}
	},
	{#State 403
		DEFAULT => -47
	},
	{#State 404
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP06_REGEX_MATCH' => 189,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 188,
			'OP18_TERNARY' => 187,
			"}" => -195,
			'OP23_LOGICAL_AND' => 186,
			'OP08_STRING_CAT' => 182,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP21_LIST_COMMA' => -195,
			'OP15_LOGICAL_AND' => 180,
			'OP17_LIST_RANGE' => 184,
			'OP16_LOGICAL_OR' => 175,
			'OP12_COMPARE_EQ_NE' => 183,
			'OP08_MATH_ADD_SUB' => 174,
			'OP09_BITWISE_SHIFT' => 177,
			'OP04_MATH_POW' => 185,
			'OP14_BITWISE_OR_XOR' => 176
		}
	},
	{#State 405
		DEFAULT => -63
	},
	{#State 406
		DEFAULT => -60
	},
	{#State 407
		ACTIONS => {
			'TYPE_SELF' => 412
		}
	},
	{#State 408
		DEFAULT => -65
	},
	{#State 409
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 413
		}
	},
	{#State 410
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 414
		}
	},
	{#State 411
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 415
		}
	},
	{#State 412
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 416
		}
	},
	{#State 413
		ACTIONS => {
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 72,
			'LBRACKET' => 75,
			'OP01_NAMED_VOID_LPAREN' => 76,
			'OP05_MATH_NEG_LPAREN' => 73,
			'OP01_NAMED_VOID' => 74,
			'LITERAL_STRING' => 77,
			'OP01_NAMED_VOID_SCOLON' => 79,
			"if" => 78,
			"}" => 418,
			"for" => -142,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"%{" => 87,
			'WORD_UPPERCASE' => 90,
			'OP01_NAMED' => 89,
			'OP22_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 91,
			'OP19_LOOP_CONTROL' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_PRINT' => 97,
			'LITERAL_NUMBER' => 99,
			"\@{" => 102,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 108,
			'LBRACE' => 107,
			'LPAREN' => 113,
			"foreach" => -142,
			'MY' => 109,
			'OP05_LOGICAL_NEG' => 111,
			"while" => -142,
			"undef" => 116,
			'OP10_NAMED_UNARY' => 117
		},
		GOTOS => {
			'OPTIONAL-36' => 71,
			'Expression' => 93,
			'ArrayReference' => 100,
			'ArrayDereference' => 98,
			'Statement' => 103,
			'HashDereference' => 105,
			'Literal' => 104,
			'SubExpression' => 106,
			'HashReference' => 82,
			'Operator' => 80,
			'LoopLabel' => 81,
			'VariableDeclaration' => 86,
			'OperatorVoid' => 114,
			'PAREN-35' => 115,
			'Operation' => 417,
			'WordScoped' => 110,
			'VariableModification' => 83,
			'Conditional' => 84,
			'Variable' => 85
		}
	},
	{#State 414
		DEFAULT => -158
	},
	{#State 415
		DEFAULT => -148
	},
	{#State 416
		ACTIONS => {
			")" => 419,
			'OP21_LIST_COMMA' => 420
		},
		GOTOS => {
			'PAREN-28' => 421
		}
	},
	{#State 417
		DEFAULT => -67
	},
	{#State 418
		ACTIONS => {
			";" => 422
		}
	},
	{#State 419
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 423
		}
	},
	{#State 420
		ACTIONS => {
			'MY' => 424
		}
	},
	{#State 421
		DEFAULT => -71
	},
	{#State 422
		DEFAULT => -69
	},
	{#State 423
		ACTIONS => {
			"\@_;" => 425
		}
	},
	{#State 424
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 426
		}
	},
	{#State 425
		DEFAULT => -73
	},
	{#State 426
		ACTIONS => {
			'VARIABLE_SYMBOL' => 427
		}
	},
	{#State 427
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5898 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5905 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5912 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5919 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5926 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5933 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5947 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5954 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5961 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5968 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5986 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6026 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6033 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6068 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6075 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6082 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6118 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6143 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6222 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6229 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6236 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6247 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6254 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6275 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6289 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6296 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6328 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6335 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6357 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6364 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6371 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6396 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6403 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6410 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6428 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6439 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6450 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6461 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6472 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6483 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6494 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6505 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6516 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6527 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6538 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6549 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6560 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6571 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6593 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6604 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6615 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6637 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6648 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6659 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6670 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6692 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6703 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6714 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6725 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6736 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6747 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6780 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6798 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6812 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6819 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6826 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6837 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6859 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6870 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6881 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6892 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6903 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6921 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6928 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6935 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6942 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6953 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6975 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7008 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7030 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7041 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7052 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7063 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7074 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7096 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_138
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_139
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7150 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 5,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7222 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7236 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_154
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7247 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_155
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_158
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_159
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7302 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_160
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7313 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7320 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_163
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_166
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_167
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_170
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_171
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7418 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_172
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_173
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_174
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_178
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7490 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_181
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7544 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_186
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7555 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7569 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_189
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7580 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_190
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7591 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7598 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7605 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_193
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7616 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_194
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7627 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_195
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7638 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_196
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7656 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7663 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7670 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_200
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7681 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_201
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7692 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7699 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_204
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7717 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_205
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7728 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_206
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7739 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7750 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_208
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7761 lib/RPerl/Grammar.pm
	],
	[#Rule Type_209
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7772 lib/RPerl/Grammar.pm
	],
	[#Rule Type_210
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7783 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_211
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7794 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_212
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7805 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_213
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7816 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_214
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7827 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_215
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7838 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_216
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7849 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_217
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7860 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_218
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7871 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_219
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7882 lib/RPerl/Grammar.pm
	]
],
#line 7885 lib/RPerl/Grammar.pm
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
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpressionOrStdin_138', 
         'SubExpressionOrStdin_139', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_143', 
         'Statement_144', 
         'Statement_145', 
         'Statement_146', 
         'Statement_147', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_154', 
         'Loop_155', 
         'Loop_156', 
         'Loop_157', 
         'LoopFor_158', 
         'LoopForEach_159', 
         'LoopWhile_160', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_163', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_166', 
         'VariableRetrieval_167', 
         'VariableRetrieval_168', 
         'VariableRetrieval_169', 
         'VariableDeclaration_170', 
         'VariableDeclaration_171', 
         'VariableDeclaration_172', 
         'VariableModification_173', 
         'VariableModification_174', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_178', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElement_181', 
         'ListElement_182', 
         'ListElement_183', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_186', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_189', 
         'ArrayDereference_190', 
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
         'HashReference_201', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_204', 
         'HashDereference_205', 
         'WordScoped_206', 
         'WordScoped_207', 
         'LoopLabel_208', 
         'Type_209', 
         'Type_210', 
         'TypeInner_211', 
         'TypeInnerConstant_212', 
         'VariableOrLiteral_213', 
         'VariableOrLiteral_214', 
         'VariableOrLiteralOrWord_215', 
         'VariableOrLiteralOrWord_216', 
         'VariableOrLiteralOrWord_217', 
         'Literal_218', 
         'Literal_219', );
  $self;
}

#line 210 "lib/RPerl/Grammar.eyp"


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
Expression_127 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_128 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_129 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_130 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_131 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_132 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_133 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_134 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_135 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_136 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrStdin_138 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrStdin -> SubExpression
SubExpressionOrStdin_139 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrStdin -> STDIN
Statement_143 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_144 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_145 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_146 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_147 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification
Conditional_154 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_155 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_156 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_157 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_158 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopForEach_159 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_160 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
CodeBlock_163 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_166 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VARIABLE_SYMBOL STAR-42
VariableRetrieval_167 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_168 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_169 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_170 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_171 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableDeclaration_172 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_173 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableModification_174 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression ';'
ListElements_178 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_181 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_182 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_183 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW PLUS-44 ')'
ArrayReference_186 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_189 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_190 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_193 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_194 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntryTyped_195 => 'RPerl::DataStructure::Hash::EntryTyped',                                 # HashEntryTyped -> WORD OP20_HASH_FATARROW TypeInner SubExpression
HashEntryTyped_196 => 'RPerl::Operation::Expression::SubExpression::HashDereference',           # HashEntryTyped -> HashDereference
HashReference_200 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_201 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_204 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_205 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_206 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_207 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_208 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_209 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_210 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_211 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_212 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_213 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_214 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_215 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_216 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_217 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
Literal_218 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_219 => 'RPerl::Operation::Expression::SubExpression::Literal::String'                   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8271 lib/RPerl/Grammar.pm



1;
