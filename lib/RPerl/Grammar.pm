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

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach|\=\ sub\ \{|\$TYPED_|package|elsif|while|undef|else|\@_\;|our|use|for|\@\{|if|\%\{|\]|\;|\}|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
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
			"## no critic qw(" => 6,
			"package" => -20,
			'SHEBANG' => 3
		},
		GOTOS => {
			'OPTIONAL-9' => 7,
			'PLUS-2' => 1,
			'PAREN-1' => 4,
			'Critic' => 2,
			'CompileUnit' => 8,
			'Program' => 9,
			'ModuleHeader' => 5
		}
	},
	{#State 1
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'PAREN-1' => 10,
			'Critic' => 2,
			'OPTIONAL-9' => 7
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			"## no critic qw(" => 6,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 11,
			'OPTIONAL-3' => 12
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			"use constant" => -25,
			"use" => -25,
			"use parent qw(" => 13,
			"## no critic qw(" => -25,
			"our" => -25
		},
		GOTOS => {
			'Module' => 16,
			'Class' => 15,
			'STAR-10' => 17,
			'Package' => 14
		}
	},
	{#State 6
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 7
		ACTIONS => {
			"package" => 20
		}
	},
	{#State 8
		ACTIONS => {
			'' => 21
		}
	},
	{#State 9
		DEFAULT => -4
	},
	{#State 10
		DEFAULT => -2
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
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		DEFAULT => -23
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			"## no critic qw(" => 6,
			"use" => -27,
			"use constant" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 27,
			'Critic' => 28
		}
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
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 21
		DEFAULT => 0
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
		DEFAULT => -206
	},
	{#State 25
		ACTIONS => {
			")" => 34
		}
	},
	{#State 26
		DEFAULT => -207
	},
	{#State 27
		ACTIONS => {
			"use" => 36,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 37
		}
	},
	{#State 28
		DEFAULT => -24
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
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_CLOSE' => -11,
			'LBRACE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'VARIABLE_SYMBOL' => -11,
			"for" => -11,
			'LPAREN' => -11,
			"use constant" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"## no critic qw(" => 6,
			'LBRACKET' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_PRINT' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_NAMED' => -11,
			"our" => -11,
			"while" => -11,
			"%{" => -11,
			'LITERAL_STRING' => -11,
			'WORD' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'WORD_SCOPED' => -11,
			'WORD_UPPERCASE' => -11,
			"undef" => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"\@{" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'MY' => -11,
			"foreach" => -11,
			'OP01_OPEN' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"if" => -11
		},
		GOTOS => {
			'STAR-5' => 41,
			'Critic' => 40
		}
	},
	{#State 34
		ACTIONS => {
			";" => 42
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 37
		ACTIONS => {
			"use constant" => 44,
			"our" => 46
		},
		GOTOS => {
			'Subroutine' => 47,
			'Constant' => 48,
			'PLUS-13' => 45
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
		DEFAULT => -8
	},
	{#State 41
		ACTIONS => {
			"undef" => -13,
			'MY' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"\@{" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'WORD' => -13,
			'LITERAL_STRING' => -13,
			'WORD_UPPERCASE' => -13,
			'WORD_SCOPED' => -13,
			"if" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_OPEN' => -13,
			"foreach" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"use constant" => -13,
			"for" => -13,
			'LPAREN' => -13,
			'LBRACE' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"use" => 36,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			"while" => -13,
			"our" => -13,
			"%{" => -13,
			'OP01_NAMED' => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACKET' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_LOGICAL_NEG' => -13
		},
		GOTOS => {
			'Include' => 51,
			'STAR-6' => 52
		}
	},
	{#State 42
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 43
		ACTIONS => {
			";" => 54,
			'OP01_QW' => 55
		}
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 57,
			"our" => 46
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 46
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 47
		DEFAULT => -31
	},
	{#State 48
		DEFAULT => -28
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 62
		}
	},
	{#State 51
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			'OP10_NAMED_UNARY' => -15,
			'LBRACKET' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_PRINT' => -15,
			"our" => -15,
			"while" => -15,
			"%{" => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LBRACE' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"use constant" => 44,
			"for" => -15,
			'LPAREN' => -15,
			"foreach" => -15,
			"if" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_OPEN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'WORD' => -15,
			'LITERAL_STRING' => -15,
			'WORD_SCOPED' => -15,
			'WORD_UPPERCASE' => -15,
			"undef" => -15,
			'MY' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"\@{" => -15,
			'OP01_NAMED_VOID_LPAREN' => -15
		},
		GOTOS => {
			'STAR-7' => 63,
			'Constant' => 64
		}
	},
	{#State 53
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 65
		}
	},
	{#State 54
		DEFAULT => -39
	},
	{#State 55
		ACTIONS => {
			'WORD' => 67
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 56
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
	},
	{#State 57
		ACTIONS => {
			";" => 69
		}
	},
	{#State 58
		DEFAULT => -30
	},
	{#State 59
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70
		}
	},
	{#State 60
		DEFAULT => -210
	},
	{#State 61
		DEFAULT => -209
	},
	{#State 62
		DEFAULT => -33
	},
	{#State 63
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 106,
			"for" => -142,
			'LPAREN' => 105,
			'VARIABLE_SYMBOL' => 96,
			'LBRACE' => 101,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'OP01_NAMED_VOID_SCOLON' => 99,
			'OP01_CLOSE' => 100,
			"while" => -142,
			"our" => 46,
			"%{" => 116,
			'OP01_NAMED_VOID' => 112,
			'OP01_NAMED' => 113,
			'OP01_PRINT' => 117,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 81,
			'OP01_NAMED_VOID_LPAREN' => 80,
			"\@{" => 79,
			"undef" => 83,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 71,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LITERAL_STRING' => 73,
			"if" => 95,
			'OP01_OPEN' => 93,
			'OP19_LOOP_CONTROL' => 92,
			"foreach" => -142
		},
		GOTOS => {
			'HashDereference' => 78,
			'WordScoped' => 76,
			'SubExpression' => 75,
			'ArrayDereference' => 98,
			'Statement' => 74,
			'OPTIONAL-36' => 72,
			'VariableModification' => 97,
			'OperatorVoid' => 104,
			'Expression' => 103,
			'HashReference' => 111,
			'PLUS-8' => 88,
			'PAREN-35' => 87,
			'VariableDeclaration' => 86,
			'Operation' => 85,
			'Literal' => 84,
			'Operator' => 94,
			'LoopLabel' => 91,
			'Subroutine' => 115,
			'ArrayReference' => 90,
			'Variable' => 114,
			'Conditional' => 89
		}
	},
	{#State 64
		DEFAULT => -12
	},
	{#State 65
		ACTIONS => {
			"## no critic qw(" => 6,
			"use" => -54,
			"use constant" => -54,
			"our hashref \$properties" => -54
		},
		GOTOS => {
			'STAR-21' => 119,
			'Critic' => 118
		}
	},
	{#State 66
		ACTIONS => {
			'WORD' => 120,
			")" => 121
		}
	},
	{#State 67
		DEFAULT => -38
	},
	{#State 68
		ACTIONS => {
			'MY' => 123
		},
		GOTOS => {
			'TypeInnerConstant' => 122
		}
	},
	{#State 69
		DEFAULT => -32
	},
	{#State 70
		ACTIONS => {
			"= sub {" => 124
		}
	},
	{#State 71
		ACTIONS => {
			'COLON' => -208,
			'LPAREN' => 125
		}
	},
	{#State 72
		ACTIONS => {
			"foreach" => 129,
			"for" => 130,
			"while" => 131
		},
		GOTOS => {
			'LoopWhile' => 126,
			'LoopForEach' => 128,
			'Loop' => 127,
			'LoopFor' => 132
		}
	},
	{#State 73
		DEFAULT => -219
	},
	{#State 74
		DEFAULT => -77
	},
	{#State 75
		ACTIONS => {
			'OP18_TERNARY' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 141,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => 136,
			'OP13_BITWISE_AND' => 145
		}
	},
	{#State 76
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 151,
			'LPAREN' => 150
		}
	},
	{#State 77
		ACTIONS => {
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155
		},
		GOTOS => {
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Operator' => 94,
			'Literal' => 84,
			'SubExpression' => 156,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'HashReference' => 111,
			'ArrayDereference' => 98
		}
	},
	{#State 78
		DEFAULT => -136
	},
	{#State 79
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			'MY' => 157,
			'LBRACKET' => -188
		},
		GOTOS => {
			'Variable' => 159,
			'OPTIONAL-47' => 160,
			'TypeInner' => 158
		}
	},
	{#State 80
		ACTIONS => {
			'OP01_QW' => 164,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			"%{" => 116,
			")" => -111,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 24,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83
		},
		GOTOS => {
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'SubExpression' => 162,
			'ArrayDereference' => 98,
			'ListElements' => 161,
			'Literal' => 84,
			'Operator' => 94,
			'ListElement' => 163,
			'TypeInner' => 166,
			'Expression' => 152,
			'ArrayReference' => 90,
			'OPTIONAL-32' => 165,
			'Variable' => 154
		}
	},
	{#State 81
		ACTIONS => {
			'WORD' => 61,
			'TYPE_FHREF' => 167,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 168
		}
	},
	{#State 82
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96
		},
		GOTOS => {
			'Variable' => 169
		}
	},
	{#State 83
		DEFAULT => -130
	},
	{#State 84
		DEFAULT => -131
	},
	{#State 85
		DEFAULT => -17
	},
	{#State 86
		DEFAULT => -146
	},
	{#State 87
		DEFAULT => -141
	},
	{#State 88
		ACTIONS => {
			"for" => -142,
			'LPAREN' => 105,
			'' => -18,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_NAMED_VOID_SCOLON' => 99,
			'OP01_CLOSE' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'OP01_PRINT' => 117,
			'OP01_NAMED' => 113,
			'OP01_NAMED_VOID' => 112,
			"while" => -142,
			"%{" => 116,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			"undef" => 83,
			'OP01_NAMED_VOID_LPAREN' => 80,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 81,
			'LITERAL_STRING' => 73,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'WORD_UPPERCASE' => 71,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 93,
			'OP19_LOOP_CONTROL' => 92,
			"if" => 95,
			"foreach" => -142
		},
		GOTOS => {
			'Conditional' => 89,
			'Variable' => 114,
			'ArrayReference' => 90,
			'LoopLabel' => 91,
			'Operator' => 94,
			'Literal' => 84,
			'Operation' => 170,
			'VariableDeclaration' => 86,
			'PAREN-35' => 87,
			'HashReference' => 111,
			'Expression' => 103,
			'OperatorVoid' => 104,
			'VariableModification' => 97,
			'OPTIONAL-36' => 72,
			'ArrayDereference' => 98,
			'Statement' => 74,
			'SubExpression' => 75,
			'WordScoped' => 76,
			'HashDereference' => 78
		}
	},
	{#State 89
		DEFAULT => -143
	},
	{#State 90
		DEFAULT => -133
	},
	{#State 91
		ACTIONS => {
			'COLON' => 171
		}
	},
	{#State 92
		ACTIONS => {
			'WORD_UPPERCASE' => 172
		},
		GOTOS => {
			'LoopLabel' => 173
		}
	},
	{#State 93
		ACTIONS => {
			'MY' => 174
		}
	},
	{#State 94
		DEFAULT => -124
	},
	{#State 95
		ACTIONS => {
			'LPAREN' => 175
		}
	},
	{#State 96
		DEFAULT => -165,
		GOTOS => {
			'STAR-42' => 176
		}
	},
	{#State 97
		DEFAULT => -147
	},
	{#State 98
		DEFAULT => -134
	},
	{#State 99
		DEFAULT => -114
	},
	{#State 100
		ACTIONS => {
			'FHREF_SYMBOL' => 177
		}
	},
	{#State 101
		ACTIONS => {
			"%{" => 116,
			'LITERAL_NUMBER' => 107,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 182,
			"}" => 183,
			'LITERAL_STRING' => 73
		},
		GOTOS => {
			'Variable' => 179,
			'Literal' => 184,
			'VariableOrLiteralOrWord' => 180,
			'HashEntry' => 178,
			'HashDereference' => 181
		}
	},
	{#State 102
		DEFAULT => -118
	},
	{#State 103
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP08_STRING_CAT' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP04_MATH_POW' => -129,
			";" => 185,
			'OP09_BITWISE_SHIFT' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP18_TERNARY' => -129,
			'OP24_LOGICAL_OR_XOR' => -129
		}
	},
	{#State 104
		DEFAULT => -145
	},
	{#State 105
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_PRINT' => 187,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 186
		},
		GOTOS => {
			'Operator' => 94,
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152,
			'SubExpression' => 188,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'ArrayDereference' => 98,
			'Literal' => 84
		}
	},
	{#State 106
		ACTIONS => {
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24
		},
		GOTOS => {
			'Operator' => 94,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'ArrayDereference' => 98,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'HashReference' => 111,
			'SubExpression' => 189,
			'Literal' => 84
		}
	},
	{#State 107
		DEFAULT => -218
	},
	{#State 108
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'Literal' => 84,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'HashReference' => 111,
			'SubExpression' => 190,
			'ArrayDereference' => 98,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'Operator' => 94
		}
	},
	{#State 109
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP13_BITWISE_AND' => -95,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP11_COMPARE_LT_GT' => -95,
			'OP06_REGEX_MATCH' => -95,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP15_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95,
			";" => -95,
			'VARIABLE_SYMBOL' => 96,
			'LBRACE' => 101,
			'OP09_BITWISE_SHIFT' => -95,
			'OP01_CLOSE' => 100,
			'OP16_LOGICAL_OR' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP18_TERNARY' => -95,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			"]" => -95,
			'OP21_LIST_COMMA' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"}" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			")" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP01_OPEN' => 93,
			'OP04_MATH_POW' => -95,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 73,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP24_LOGICAL_OR_XOR' => -95,
			"undef" => 83
		},
		GOTOS => {
			'Literal' => 84,
			'ArrayDereference' => 98,
			'HashReference' => 111,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'SubExpression' => 191,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'Operator' => 94
		}
	},
	{#State 110
		ACTIONS => {
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'OP01_QW' => 164,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			"]" => -185,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			"\@{" => 79,
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24
		},
		GOTOS => {
			'TypeInner' => 166,
			'Operator' => 94,
			'ListElement' => 163,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'SubExpression' => 162,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'HashReference' => 111,
			'ArrayDereference' => 98,
			'ListElements' => 193,
			'OPTIONAL-46' => 192,
			'Literal' => 84
		}
	},
	{#State 111
		DEFAULT => -135
	},
	{#State 112
		ACTIONS => {
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 157,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_QW' => 164
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'ListElements' => 194,
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'SubExpression' => 162,
			'Literal' => 84,
			'ListElement' => 163,
			'Operator' => 94,
			'TypeInner' => 166,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154
		}
	},
	{#State 113
		ACTIONS => {
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_QW' => 164,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 157,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24
		},
		GOTOS => {
			'Literal' => 84,
			'HashReference' => 111,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'SubExpression' => 196,
			'ArrayDereference' => 98,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'ListElement' => 195,
			'Operator' => 94,
			'TypeInner' => 166
		}
	},
	{#State 114
		ACTIONS => {
			'OP04_MATH_POW' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP19_VARIABLE_ASSIGN_BY' => 199,
			'OP16_LOGICAL_OR' => -132,
			'OP03_MATH_INC_DEC' => 197,
			'OP07_STRING_REPEAT' => -132,
			'OP18_TERNARY' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP02_METHOD_THINARROW' => 198,
			'OP13_BITWISE_AND' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP19_VARIABLE_ASSIGN' => 200,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP08_STRING_CAT' => -132,
			'OP15_LOGICAL_AND' => -132
		}
	},
	{#State 115
		DEFAULT => -14
	},
	{#State 116
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			'MY' => 157,
			'LBRACE' => -203
		},
		GOTOS => {
			'TypeInner' => 203,
			'OPTIONAL-51' => 201,
			'Variable' => 202
		}
	},
	{#State 117
		ACTIONS => {
			'LBRACKET' => -109,
			'OP10_NAMED_UNARY' => -109,
			'LITERAL_NUMBER' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'OP01_QW' => -109,
			'OP01_OPEN' => -109,
			"%{" => -109,
			'OP01_NAMED' => -109,
			'FHREF_SYMBOL_BRACES' => 205,
			'LBRACE' => -109,
			'WORD' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LITERAL_STRING' => -109,
			'OP01_CLOSE' => -109,
			'WORD_SCOPED' => -109,
			'STDOUT_STDERR' => 206,
			'WORD_UPPERCASE' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			"undef" => -109,
			'LPAREN' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'MY' => -109,
			"\@{" => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 207,
			'PAREN-30' => 204
		}
	},
	{#State 118
		DEFAULT => -51
	},
	{#State 119
		ACTIONS => {
			"our hashref \$properties" => -56,
			"use" => 36,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 209,
			'STAR-22' => 208
		}
	},
	{#State 120
		DEFAULT => -37
	},
	{#State 121
		ACTIONS => {
			";" => 210
		}
	},
	{#State 122
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 73
		},
		GOTOS => {
			'Literal' => 211
		}
	},
	{#State 123
		ACTIONS => {
			'WORD' => 61,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 124
		ACTIONS => {
			'OP10_NAMED_UNARY' => -43,
			'LBRACKET' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_PRINT' => -43,
			"while" => -43,
			"%{" => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_NAMED' => -43,
			'LBRACE' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP01_CLOSE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"for" => -43,
			'LPAREN' => -43,
			"foreach" => -43,
			"}" => -43,
			"if" => -43,
			'OP01_OPEN' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'WORD' => -43,
			'LITERAL_STRING' => -43,
			'WORD_UPPERCASE' => -43,
			'WORD_SCOPED' => -43,
			'LPAREN_MY' => 215,
			"undef" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'MY' => -43,
			'OP01_NAMED_VOID_LPAREN' => -43,
			"\@{" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 213,
			'OPTIONAL-16' => 214
		}
	},
	{#State 125
		ACTIONS => {
			")" => 216
		}
	},
	{#State 126
		DEFAULT => -157
	},
	{#State 127
		DEFAULT => -144
	},
	{#State 128
		DEFAULT => -156
	},
	{#State 129
		ACTIONS => {
			'MY' => 217
		}
	},
	{#State 130
		ACTIONS => {
			'MY' => 218
		}
	},
	{#State 131
		ACTIONS => {
			'LPAREN' => 219
		}
	},
	{#State 132
		DEFAULT => -155
	},
	{#State 133
		ACTIONS => {
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Operator' => 94,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'SubExpression' => 220,
			'ArrayDereference' => 98,
			'Literal' => 84
		}
	},
	{#State 134
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110
		},
		GOTOS => {
			'Literal' => 84,
			'ArrayDereference' => 98,
			'SubExpression' => 221,
			'HashReference' => 111,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Operator' => 94
		}
	},
	{#State 135
		ACTIONS => {
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73
		},
		GOTOS => {
			'Operator' => 94,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'SubExpression' => 222,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'ArrayDereference' => 98,
			'Literal' => 84
		}
	},
	{#State 136
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 24,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105
		},
		GOTOS => {
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'SubExpression' => 223,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'Operator' => 94,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154
		}
	},
	{#State 137
		ACTIONS => {
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'Literal' => 84,
			'ArrayDereference' => 98,
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'SubExpression' => 224,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'Operator' => 94
		}
	},
	{#State 138
		ACTIONS => {
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79
		},
		GOTOS => {
			'Operator' => 94,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'HashReference' => 111,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'SubExpression' => 225,
			'ArrayDereference' => 98,
			'Literal' => 84
		}
	},
	{#State 139
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109
		},
		GOTOS => {
			'Operator' => 94,
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152,
			'ArrayDereference' => 98,
			'SubExpression' => 226,
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'Literal' => 84
		}
	},
	{#State 140
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108
		},
		GOTOS => {
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Operator' => 94,
			'Literal' => 84,
			'SubExpression' => 227,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'ArrayDereference' => 98
		}
	},
	{#State 141
		ACTIONS => {
			'LBRACE' => 101,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153
		},
		GOTOS => {
			'HashReference' => 111,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'SubExpression' => 228,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'Operator' => 94,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154
		}
	},
	{#State 142
		ACTIONS => {
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'SubExpression' => 229,
			'HashReference' => 111,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'Operator' => 94,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'SubExpression' => 230,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'Operator' => 94,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154
		}
	},
	{#State 144
		ACTIONS => {
			'LITERAL_STRING' => 73,
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'VariableOrLiteral' => 232,
			'Variable' => 231,
			'Literal' => 233
		}
	},
	{#State 145
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108
		},
		GOTOS => {
			'Operator' => 94,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'SubExpression' => 234,
			'ArrayDereference' => 98,
			'Literal' => 84
		}
	},
	{#State 146
		ACTIONS => {
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100
		},
		GOTOS => {
			'Operator' => 94,
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152,
			'ArrayDereference' => 98,
			'SubExpression' => 235,
			'HashReference' => 111,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'Literal' => 84
		}
	},
	{#State 147
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105
		},
		GOTOS => {
			'SubExpression' => 236,
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'Operator' => 94,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90
		}
	},
	{#State 148
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'Operator' => 94,
			'Literal' => 84,
			'ArrayDereference' => 98,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'SubExpression' => 237
		}
	},
	{#State 149
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 238
		}
	},
	{#State 150
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP01_QW' => 164,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_OPEN' => 93,
			"%{" => 116,
			")" => -121,
			'OP01_NAMED' => 153
		},
		GOTOS => {
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'TypeInner' => 166,
			'ListElement' => 163,
			'Operator' => 94,
			'Literal' => 84,
			'SubExpression' => 162,
			'HashReference' => 111,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'OPTIONAL-33' => 239,
			'ListElements' => 240,
			'ArrayDereference' => 98
		}
	},
	{#State 151
		ACTIONS => {
			")" => 241
		}
	},
	{#State 152
		DEFAULT => -129
	},
	{#State 153
		ACTIONS => {
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116
		},
		GOTOS => {
			'Operator' => 94,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'SubExpression' => 242,
			'HashReference' => 111,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'ArrayDereference' => 98,
			'Literal' => 84
		}
	},
	{#State 154
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 197,
			'OP07_STRING_REPEAT' => -132,
			'OP18_TERNARY' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP04_MATH_POW' => -132,
			";" => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP06_REGEX_MATCH' => -132,
			")" => -132,
			'OP17_LIST_RANGE' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP08_STRING_CAT' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			"]" => -132,
			'OP13_BITWISE_AND' => -132,
			'OP02_METHOD_THINARROW' => 198,
			'OP21_LIST_COMMA' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP23_LOGICAL_AND' => -132,
			"}" => -132
		}
	},
	{#State 155
		ACTIONS => {
			'LPAREN' => 125
		}
	},
	{#State 156
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP18_TERNARY' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 141,
			";" => -104,
			'OP04_MATH_POW' => 133,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			")" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP12_COMPARE_EQ_NE' => 135,
			"}" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 146,
			'OP13_BITWISE_AND' => 145,
			"]" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 137
		}
	},
	{#State 157
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'WORD' => 61
		},
		GOTOS => {
			'Type' => 243
		}
	},
	{#State 158
		DEFAULT => -187
	},
	{#State 159
		ACTIONS => {
			"}" => 244
		}
	},
	{#State 160
		ACTIONS => {
			'LBRACKET' => 110
		},
		GOTOS => {
			'ArrayReference' => 245
		}
	},
	{#State 161
		DEFAULT => -110
	},
	{#State 162
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			")" => -181,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP21_LIST_COMMA' => -181,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => 136,
			"]" => -181,
			'OP13_BITWISE_AND' => 145,
			'OP18_TERNARY' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => 134,
			";" => -181,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 141
		}
	},
	{#State 163
		DEFAULT => -177,
		GOTOS => {
			'STAR-44' => 246
		}
	},
	{#State 164
		ACTIONS => {
			'WORD' => 247
		},
		GOTOS => {
			'PLUS-45' => 248
		}
	},
	{#State 165
		ACTIONS => {
			")" => 249
		}
	},
	{#State 166
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'Operator' => 94,
			'Literal' => 84,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'SubExpression' => 250,
			'ArrayDereference' => 98
		}
	},
	{#State 167
		ACTIONS => {
			'FHREF_SYMBOL' => 251
		}
	},
	{#State 168
		ACTIONS => {
			'VARIABLE_SYMBOL' => 252
		}
	},
	{#State 169
		DEFAULT => -83
	},
	{#State 170
		DEFAULT => -16
	},
	{#State 171
		DEFAULT => -140
	},
	{#State 172
		DEFAULT => -208
	},
	{#State 173
		ACTIONS => {
			";" => 253
		}
	},
	{#State 174
		ACTIONS => {
			'TYPE_FHREF' => 254
		}
	},
	{#State 175
		ACTIONS => {
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'Operator' => 94,
			'Literal' => 84,
			'ArrayDereference' => 98,
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'SubExpression' => 255
		}
	},
	{#State 176
		ACTIONS => {
			'OP08_STRING_CAT' => -166,
			'OP15_LOGICAL_AND' => -166,
			'OP17_LIST_RANGE' => -166,
			'OP08_MATH_ADD_SUB' => -166,
			'OP14_BITWISE_OR_XOR' => -166,
			'OP06_REGEX_MATCH' => -166,
			")" => -166,
			'OP21_LIST_COMMA' => -166,
			'OP12_COMPARE_EQ_NE' => -166,
			'OP11_COMPARE_LT_GT' => -166,
			'OP23_LOGICAL_AND' => -166,
			"}" => -166,
			'OP19_VARIABLE_ASSIGN' => -166,
			'OP02_ARRAY_THINARROW' => 256,
			'OP13_BITWISE_AND' => -166,
			"]" => -166,
			'OP02_METHOD_THINARROW' => -166,
			'OP20_HASH_FATARROW' => -166,
			'OP07_MATH_MULT_DIV_MOD' => -166,
			'OP24_LOGICAL_OR_XOR' => -166,
			'OP18_TERNARY' => -166,
			'OP02_HASH_THINARROW' => 258,
			'OP03_MATH_INC_DEC' => -166,
			'OP07_STRING_REPEAT' => -166,
			'OP16_LOGICAL_OR' => -166,
			'COLON' => -166,
			'OP19_VARIABLE_ASSIGN_BY' => -166,
			'OP09_BITWISE_SHIFT' => -166,
			";" => -166,
			'OP04_MATH_POW' => -166
		},
		GOTOS => {
			'VariableRetrieval' => 257
		}
	},
	{#State 177
		DEFAULT => -82
	},
	{#State 178
		DEFAULT => -199,
		GOTOS => {
			'STAR-50' => 259
		}
	},
	{#State 179
		DEFAULT => -215
	},
	{#State 180
		ACTIONS => {
			'OP20_HASH_FATARROW' => 260
		}
	},
	{#State 181
		DEFAULT => -194
	},
	{#State 182
		DEFAULT => -217
	},
	{#State 183
		DEFAULT => -201
	},
	{#State 184
		DEFAULT => -216
	},
	{#State 185
		DEFAULT => -76
	},
	{#State 186
		ACTIONS => {
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP01_QW' => 164,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'SubExpression' => 196,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'Literal' => 84,
			'TypeInner' => 166,
			'ListElement' => 261,
			'Operator' => 94,
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152
		}
	},
	{#State 187
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 262
		}
	},
	{#State 188
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP04_MATH_POW' => 133,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP13_BITWISE_AND' => 145,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => 136,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => 138,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			")" => 263,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140
		}
	},
	{#State 189
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			")" => 264,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP13_BITWISE_AND' => 145,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => 136,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP04_MATH_POW' => 133,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142
		}
	},
	{#State 190
		ACTIONS => {
			")" => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP08_STRING_CAT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			"}" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			"]" => -86,
			'OP13_BITWISE_AND' => -86,
			'OP18_TERNARY' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			";" => -86,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => -86,
			'OP09_BITWISE_SHIFT' => -86
		}
	},
	{#State 191
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => -94,
			'OP04_MATH_POW' => 133,
			";" => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -94,
			"]" => -94,
			'OP13_BITWISE_AND' => -94,
			"}" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => -94,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => -94,
			")" => -94,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => -94
		}
	},
	{#State 192
		ACTIONS => {
			"]" => 265
		}
	},
	{#State 193
		DEFAULT => -184
	},
	{#State 194
		ACTIONS => {
			";" => 266
		}
	},
	{#State 195
		ACTIONS => {
			'OP21_LIST_COMMA' => 267
		}
	},
	{#State 196
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP21_LIST_COMMA' => -181,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP13_BITWISE_AND' => -79,
			")" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP08_STRING_CAT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP17_LIST_RANGE' => -79,
			";" => -79,
			'OP04_MATH_POW' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP18_TERNARY' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79
		}
	},
	{#State 197
		DEFAULT => -84
	},
	{#State 198
		ACTIONS => {
			'LPAREN' => 268
		}
	},
	{#State 199
		ACTIONS => {
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Operator' => 94,
			'Literal' => 84,
			'ArrayDereference' => 98,
			'SubExpression' => 269,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78
		}
	},
	{#State 200
		ACTIONS => {
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'STDIN' => 270,
			'LBRACE' => 101,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79
		},
		GOTOS => {
			'HashDereference' => 78,
			'WordScoped' => 76,
			'HashReference' => 111,
			'SubExpression' => 271,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'SubExpressionOrStdin' => 272,
			'Operator' => 94,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154
		}
	},
	{#State 201
		ACTIONS => {
			'LBRACE' => 101
		},
		GOTOS => {
			'HashReference' => 273
		}
	},
	{#State 202
		ACTIONS => {
			"}" => 274
		}
	},
	{#State 203
		DEFAULT => -202
	},
	{#State 204
		DEFAULT => -108
	},
	{#State 205
		ACTIONS => {
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 157,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_QW' => 164,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110
		},
		GOTOS => {
			'SubExpression' => 162,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'HashReference' => 111,
			'ListElements' => 275,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'TypeInner' => 166,
			'Operator' => 94,
			'ListElement' => 163,
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152
		}
	},
	{#State 206
		DEFAULT => -107
	},
	{#State 207
		ACTIONS => {
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 157,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_QW' => 164,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153
		},
		GOTOS => {
			'Literal' => 84,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'HashReference' => 111,
			'SubExpression' => 162,
			'ArrayDereference' => 98,
			'ListElements' => 276,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'Operator' => 94,
			'ListElement' => 163,
			'TypeInner' => 166
		}
	},
	{#State 208
		ACTIONS => {
			"our hashref \$properties" => 277,
			"use constant" => 44
		},
		GOTOS => {
			'Properties' => 278,
			'Constant' => 279
		}
	},
	{#State 209
		DEFAULT => -53
	},
	{#State 210
		DEFAULT => -40
	},
	{#State 211
		ACTIONS => {
			";" => 280
		}
	},
	{#State 212
		ACTIONS => {
			"\$TYPED_" => 281
		}
	},
	{#State 213
		DEFAULT => -42
	},
	{#State 214
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 282
		}
	},
	{#State 215
		ACTIONS => {
			'WORD' => 61,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 283
		}
	},
	{#State 216
		DEFAULT => -126
	},
	{#State 217
		ACTIONS => {
			'WORD' => 61,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 284
		}
	},
	{#State 218
		ACTIONS => {
			'TYPE_INTEGER' => 285
		}
	},
	{#State 219
		ACTIONS => {
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116
		},
		GOTOS => {
			'Literal' => 84,
			'ArrayDereference' => 98,
			'SubExpression' => 286,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'HashReference' => 111,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Operator' => 94
		}
	},
	{#State 220
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -85,
			'OP06_REGEX_MATCH' => -85,
			")" => -85,
			'OP08_STRING_CAT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP23_LOGICAL_AND' => -85,
			"}" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP13_BITWISE_AND' => -85,
			"]" => -85,
			'OP18_TERNARY' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			";" => -85,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => -85,
			'OP09_BITWISE_SHIFT' => -85
		}
	},
	{#State 221
		ACTIONS => {
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP04_MATH_POW' => 133,
			";" => -106,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140,
			")" => -106,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP13_BITWISE_AND' => 145,
			"]" => -106,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP21_LIST_COMMA' => -106,
			'OP23_LOGICAL_AND' => 136,
			"}" => -106,
			'OP11_COMPARE_LT_GT' => 146
		}
	},
	{#State 222
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 137,
			"]" => -97,
			'OP13_BITWISE_AND' => -97,
			"}" => -97,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP21_LIST_COMMA' => -97,
			")" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => -97,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => -97,
			'OP04_MATH_POW' => 133,
			";" => -97,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => -97,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -97,
			'OP24_LOGICAL_OR_XOR' => -97
		}
	},
	{#State 223
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP04_MATH_POW' => 133,
			";" => -105,
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => 138,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			")" => -105,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			"]" => -105,
			'OP13_BITWISE_AND' => 145,
			'OP11_COMPARE_LT_GT' => 146,
			"}" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP21_LIST_COMMA' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 137
		}
	},
	{#State 224
		ACTIONS => {
			'OP15_LOGICAL_AND' => -90,
			'OP08_STRING_CAT' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP17_LIST_RANGE' => -90,
			")" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP06_REGEX_MATCH' => 149,
			"}" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			"]" => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP18_TERNARY' => -90,
			'OP07_STRING_REPEAT' => 143,
			'OP16_LOGICAL_OR' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			";" => -90,
			'OP04_MATH_POW' => 133
		}
	},
	{#State 225
		ACTIONS => {
			'OP18_TERNARY' => -102,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => -102,
			";" => -102,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 141,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140,
			")" => -102,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP21_LIST_COMMA' => -102,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP23_LOGICAL_AND' => -102,
			"}" => -102,
			'OP11_COMPARE_LT_GT' => 146,
			"]" => -102,
			'OP13_BITWISE_AND' => 145
		}
	},
	{#State 226
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 137,
			"}" => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP13_BITWISE_AND' => -91,
			"]" => -91,
			")" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP06_REGEX_MATCH' => 149,
			'OP08_STRING_CAT' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP17_LIST_RANGE' => -91,
			";" => -91,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP18_TERNARY' => -91,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => -91
		}
	},
	{#State 227
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP08_STRING_CAT' => 147,
			")" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => 145,
			"]" => -99,
			'OP11_COMPARE_LT_GT' => 146,
			"}" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP21_LIST_COMMA' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -99,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => -99,
			'OP04_MATH_POW' => 133,
			";" => -99
		}
	},
	{#State 228
		ACTIONS => {
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => -93,
			")" => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP08_STRING_CAT' => 147,
			'OP17_LIST_RANGE' => -93,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP21_LIST_COMMA' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP23_LOGICAL_AND' => -93,
			"}" => -93,
			'OP11_COMPARE_LT_GT' => -93,
			"]" => -93,
			'OP13_BITWISE_AND' => -93,
			'OP18_TERNARY' => -93,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => -93,
			";" => -93,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => -93,
			'OP09_BITWISE_SHIFT' => -93
		}
	},
	{#State 229
		ACTIONS => {
			'OP18_TERNARY' => -101,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => -101,
			";" => -101,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => -101,
			'OP09_BITWISE_SHIFT' => 141,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			")" => -101,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP17_LIST_RANGE' => -101,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP21_LIST_COMMA' => -101,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP11_COMPARE_LT_GT' => 146,
			"}" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP13_BITWISE_AND' => 145,
			"]" => -101
		}
	},
	{#State 230
		ACTIONS => {
			";" => -89,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP18_TERNARY' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			"}" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP13_BITWISE_AND' => -89,
			"]" => -89,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => -89,
			")" => -89,
			'OP08_STRING_CAT' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP08_MATH_ADD_SUB' => -89
		}
	},
	{#State 231
		DEFAULT => -213
	},
	{#State 232
		ACTIONS => {
			'COLON' => 287
		}
	},
	{#State 233
		DEFAULT => -214
	},
	{#State 234
		ACTIONS => {
			'OP17_LIST_RANGE' => -98,
			'OP08_MATH_ADD_SUB' => 139,
			'OP15_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 147,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP06_REGEX_MATCH' => 149,
			")" => -98,
			"]" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP21_LIST_COMMA' => -98,
			'OP11_COMPARE_LT_GT' => 146,
			"}" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -98,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => -98,
			'OP04_MATH_POW' => 133,
			";" => -98
		}
	},
	{#State 235
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP08_STRING_CAT' => 147,
			")" => -96,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => -96,
			"]" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP23_LOGICAL_AND' => -96,
			"}" => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -96,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => -96,
			'OP04_MATH_POW' => 133,
			";" => -96
		}
	},
	{#State 236
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -92,
			'OP06_REGEX_MATCH' => 149,
			")" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP08_MATH_ADD_SUB' => 139,
			'OP08_STRING_CAT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP13_BITWISE_AND' => -92,
			"]" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP04_MATH_POW' => 133,
			";" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP16_LOGICAL_OR' => -92
		}
	},
	{#State 237
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			")" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP08_MATH_ADD_SUB' => 139,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			"]" => -100,
			'OP13_BITWISE_AND' => 145,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP21_LIST_COMMA' => -100,
			'OP11_COMPARE_LT_GT' => 146,
			"}" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP04_MATH_POW' => 133,
			";" => -100,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => -100
		}
	},
	{#State 238
		DEFAULT => -88
	},
	{#State 239
		ACTIONS => {
			")" => 288
		}
	},
	{#State 240
		DEFAULT => -120
	},
	{#State 241
		DEFAULT => -128
	},
	{#State 242
		ACTIONS => {
			'OP13_BITWISE_AND' => -79,
			"]" => -79,
			"}" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			")" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP04_MATH_POW' => -79,
			";" => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP18_TERNARY' => -79
		}
	},
	{#State 243
		ACTIONS => {
			"\$TYPED_" => 289
		}
	},
	{#State 244
		DEFAULT => -189
	},
	{#State 245
		ACTIONS => {
			"}" => 290
		}
	},
	{#State 246
		ACTIONS => {
			")" => -178,
			";" => -178,
			"]" => -178,
			'OP21_LIST_COMMA' => 292
		},
		GOTOS => {
			'PAREN-43' => 291
		}
	},
	{#State 247
		DEFAULT => -180
	},
	{#State 248
		ACTIONS => {
			'WORD' => 294,
			")" => 293
		}
	},
	{#State 249
		ACTIONS => {
			";" => 295
		}
	},
	{#State 250
		ACTIONS => {
			";" => -182,
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 141,
			'OP18_TERNARY' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP21_LIST_COMMA' => -182,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP23_LOGICAL_AND' => 136,
			'OP11_COMPARE_LT_GT' => 146,
			"]" => -182,
			'OP13_BITWISE_AND' => 145,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140,
			")" => -182,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139
		}
	},
	{#State 251
		ACTIONS => {
			";" => 296
		}
	},
	{#State 252
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 298,
			";" => 297
		}
	},
	{#State 253
		DEFAULT => -119
	},
	{#State 254
		ACTIONS => {
			'FHREF_SYMBOL' => 299
		}
	},
	{#State 255
		ACTIONS => {
			")" => 300,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => 138,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP13_BITWISE_AND' => 145,
			'OP23_LOGICAL_AND' => 136,
			'OP11_COMPARE_LT_GT' => 146,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP04_MATH_POW' => 133,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142
		}
	},
	{#State 256
		ACTIONS => {
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101
		},
		GOTOS => {
			'Literal' => 84,
			'ArrayDereference' => 98,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'SubExpression' => 301,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154,
			'Operator' => 94
		}
	},
	{#State 257
		DEFAULT => -164
	},
	{#State 258
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'WORD' => 302,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Operator' => 94,
			'Literal' => 84,
			'SubExpression' => 303,
			'HashReference' => 111,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'ArrayDereference' => 98
		}
	},
	{#State 259
		ACTIONS => {
			'OP21_LIST_COMMA' => 305,
			"}" => 306
		},
		GOTOS => {
			'PAREN-49' => 304
		}
	},
	{#State 260
		ACTIONS => {
			'OP10_NAMED_UNARY' => -192,
			'LBRACKET' => -192,
			'LITERAL_NUMBER' => -192,
			'OP05_LOGICAL_NEG' => -192,
			'OP01_OPEN' => -192,
			'OP01_NAMED' => -192,
			"%{" => -192,
			'OP01_CLOSE' => -192,
			'LITERAL_STRING' => -192,
			'WORD' => -192,
			'OP22_LOGICAL_NEG' => -192,
			'LBRACE' => -192,
			'VARIABLE_SYMBOL' => -192,
			'WORD_UPPERCASE' => -192,
			'WORD_SCOPED' => -192,
			"undef" => -192,
			'LPAREN' => -192,
			'OP05_MATH_NEG_LPAREN' => -192,
			"\@{" => -192,
			'OP03_MATH_INC_DEC' => -192,
			'MY' => 157
		},
		GOTOS => {
			'TypeInner' => 308,
			'OPTIONAL-48' => 307
		}
	},
	{#State 261
		ACTIONS => {
			'OP21_LIST_COMMA' => 309
		}
	},
	{#State 262
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 157,
			"\@{" => 79,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_QW' => 164
		},
		GOTOS => {
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'ListElement' => 163,
			'Operator' => 94,
			'TypeInner' => 166,
			'Literal' => 84,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'HashReference' => 111,
			'SubExpression' => 162,
			'ListElements' => 310,
			'ArrayDereference' => 98
		}
	},
	{#State 263
		DEFAULT => -137
	},
	{#State 264
		DEFAULT => -87
	},
	{#State 265
		DEFAULT => -186
	},
	{#State 266
		DEFAULT => -116
	},
	{#State 267
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 157,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_QW' => 164,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'ListElement' => 163,
			'Operator' => 94,
			'TypeInner' => 166,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'ListElements' => 311,
			'ArrayDereference' => 98,
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'SubExpression' => 162,
			'Literal' => 84
		}
	},
	{#State 268
		ACTIONS => {
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 157,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_QW' => 164,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			")" => -123,
			"%{" => 116
		},
		GOTOS => {
			'HashReference' => 111,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'SubExpression' => 162,
			'ListElements' => 313,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'OPTIONAL-34' => 312,
			'ListElement' => 163,
			'Operator' => 94,
			'TypeInner' => 166,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154
		}
	},
	{#State 269
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP13_BITWISE_AND' => 145,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => 136,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => 138,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP04_MATH_POW' => 133,
			";" => 314,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP24_LOGICAL_OR_XOR' => 134
		}
	},
	{#State 270
		DEFAULT => -139
	},
	{#State 271
		ACTIONS => {
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 141,
			";" => -138,
			'OP04_MATH_POW' => 133,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP18_TERNARY' => 144,
			'OP07_STRING_REPEAT' => 143,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => 136,
			'OP13_BITWISE_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140
		}
	},
	{#State 272
		ACTIONS => {
			";" => 315
		}
	},
	{#State 273
		ACTIONS => {
			"}" => 316
		}
	},
	{#State 274
		DEFAULT => -204
	},
	{#State 275
		ACTIONS => {
			";" => 317
		}
	},
	{#State 276
		ACTIONS => {
			";" => 318
		}
	},
	{#State 277
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 319
		}
	},
	{#State 278
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 320
		}
	},
	{#State 279
		DEFAULT => -55
	},
	{#State 280
		DEFAULT => -41
	},
	{#State 281
		ACTIONS => {
			'WORD_UPPERCASE' => 321
		}
	},
	{#State 282
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'LBRACE' => 101,
			'OP01_CLOSE' => 100,
			'OP01_NAMED_VOID_SCOLON' => 99,
			'OP05_MATH_NEG_LPAREN' => 106,
			"for" => -142,
			'LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			"while" => -142,
			"%{" => 116,
			'OP01_NAMED' => 113,
			'OP01_NAMED_VOID' => 112,
			'OP01_PRINT' => 117,
			'WORD_UPPERCASE' => 71,
			'WORD_SCOPED' => 26,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 73,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 81,
			'OP01_NAMED_VOID_LPAREN' => 80,
			"\@{" => 79,
			"undef" => 83,
			"foreach" => -142,
			"}" => 323,
			"if" => 95,
			'OP01_OPEN' => 93,
			'OP19_LOOP_CONTROL' => 92
		},
		GOTOS => {
			'OperatorVoid' => 104,
			'Expression' => 103,
			'Statement' => 74,
			'ArrayDereference' => 98,
			'SubExpression' => 75,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'VariableModification' => 97,
			'OPTIONAL-36' => 72,
			'Operator' => 94,
			'Variable' => 114,
			'Conditional' => 89,
			'ArrayReference' => 90,
			'LoopLabel' => 91,
			'PAREN-35' => 87,
			'HashReference' => 111,
			'Literal' => 84,
			'Operation' => 322,
			'VariableDeclaration' => 86
		}
	},
	{#State 283
		ACTIONS => {
			'VARIABLE_SYMBOL' => 324
		}
	},
	{#State 284
		ACTIONS => {
			'VARIABLE_SYMBOL' => 325
		}
	},
	{#State 285
		ACTIONS => {
			'VARIABLE_SYMBOL' => 326
		}
	},
	{#State 286
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP04_MATH_POW' => 133,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			")" => 327,
			'OP13_BITWISE_AND' => 145,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP23_LOGICAL_AND' => 136,
			'OP11_COMPARE_LT_GT' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 137
		}
	},
	{#State 287
		ACTIONS => {
			'VARIABLE_SYMBOL' => 96,
			'LITERAL_NUMBER' => 107,
			'LITERAL_STRING' => 73
		},
		GOTOS => {
			'Literal' => 233,
			'Variable' => 231,
			'VariableOrLiteral' => 328
		}
	},
	{#State 288
		DEFAULT => -125
	},
	{#State 289
		ACTIONS => {
			'WORD' => 329
		}
	},
	{#State 290
		DEFAULT => -190
	},
	{#State 291
		DEFAULT => -176
	},
	{#State 292
		ACTIONS => {
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'OP01_QW' => 164,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73
		},
		GOTOS => {
			'Literal' => 84,
			'ArrayDereference' => 98,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'HashReference' => 111,
			'SubExpression' => 162,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'Operator' => 94,
			'ListElement' => 330,
			'TypeInner' => 166
		}
	},
	{#State 293
		DEFAULT => -183
	},
	{#State 294
		DEFAULT => -179
	},
	{#State 295
		DEFAULT => -115
	},
	{#State 296
		DEFAULT => -172
	},
	{#State 297
		DEFAULT => -170
	},
	{#State 298
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'STDIN' => 270,
			'WORD' => 24,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'OP01_OPEN' => 93,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'SubExpression' => 271,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'SubExpressionOrStdin' => 331,
			'Literal' => 84,
			'Operator' => 94,
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152
		}
	},
	{#State 299
		ACTIONS => {
			'OP21_LIST_COMMA' => 332
		}
	},
	{#State 300
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 333
		}
	},
	{#State 301
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP04_MATH_POW' => 133,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP13_BITWISE_AND' => 145,
			"]" => 335,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 302
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -206,
			"}" => 336,
			'LPAREN' => -206
		}
	},
	{#State 303
		ACTIONS => {
			'OP04_MATH_POW' => 133,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP13_BITWISE_AND' => 145,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP23_LOGICAL_AND' => 136,
			"}" => 337,
			'OP11_COMPARE_LT_GT' => 146,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147
		}
	},
	{#State 304
		DEFAULT => -198
	},
	{#State 305
		ACTIONS => {
			'LITERAL_STRING' => 73,
			'WORD' => 182,
			'VARIABLE_SYMBOL' => 96,
			"%{" => 116,
			'LITERAL_NUMBER' => 107
		},
		GOTOS => {
			'HashDereference' => 181,
			'HashEntry' => 338,
			'VariableOrLiteralOrWord' => 180,
			'Literal' => 184,
			'Variable' => 179
		}
	},
	{#State 306
		DEFAULT => -200
	},
	{#State 307
		ACTIONS => {
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Operator' => 94,
			'Literal' => 84,
			'SubExpression' => 339,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'ArrayDereference' => 98
		}
	},
	{#State 308
		DEFAULT => -191
	},
	{#State 309
		ACTIONS => {
			'MY' => 157,
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'OP01_QW' => 164,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109
		},
		GOTOS => {
			'Literal' => 84,
			'ListElements' => 340,
			'ArrayDereference' => 98,
			'SubExpression' => 162,
			'HashReference' => 111,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'TypeInner' => 166,
			'ListElement' => 163,
			'Operator' => 94
		}
	},
	{#State 310
		ACTIONS => {
			")" => 341
		}
	},
	{#State 311
		ACTIONS => {
			";" => 342
		}
	},
	{#State 312
		ACTIONS => {
			")" => 343
		}
	},
	{#State 313
		DEFAULT => -122
	},
	{#State 314
		DEFAULT => -174
	},
	{#State 315
		DEFAULT => -173
	},
	{#State 316
		DEFAULT => -205
	},
	{#State 317
		DEFAULT => -113
	},
	{#State 318
		DEFAULT => -112
	},
	{#State 319
		ACTIONS => {
			'LBRACE' => 344
		}
	},
	{#State 320
		ACTIONS => {
			"our" => 348,
			'LITERAL_NUMBER' => 347
		},
		GOTOS => {
			'MethodOrSubroutine' => 346,
			'Method' => 345,
			'Subroutine' => 349
		}
	},
	{#State 321
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 350
		}
	},
	{#State 322
		DEFAULT => -44
	},
	{#State 323
		ACTIONS => {
			";" => 351
		}
	},
	{#State 324
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 352
		}
	},
	{#State 325
		ACTIONS => {
			'LPAREN' => 353
		}
	},
	{#State 326
		ACTIONS => {
			'LPAREN' => 354
		}
	},
	{#State 327
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 355
		}
	},
	{#State 328
		DEFAULT => -103
	},
	{#State 329
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 356
		}
	},
	{#State 330
		DEFAULT => -175
	},
	{#State 331
		ACTIONS => {
			";" => 357
		}
	},
	{#State 332
		ACTIONS => {
			'LITERAL_STRING' => 358
		}
	},
	{#State 333
		DEFAULT => -150,
		GOTOS => {
			'STAR-38' => 359
		}
	},
	{#State 334
		ACTIONS => {
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_PRINT' => 117,
			'OP01_NAMED' => 113,
			'OP01_NAMED_VOID' => 112,
			"%{" => 116,
			"while" => -142,
			'OP01_CLOSE' => 100,
			'OP01_NAMED_VOID_SCOLON' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			"for" => -142,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			"foreach" => -142,
			'OP01_OPEN' => 93,
			'OP19_LOOP_CONTROL' => 92,
			"if" => 95,
			'LITERAL_STRING' => 73,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'WORD_UPPERCASE' => 71,
			'WORD_SCOPED' => 26,
			"undef" => 83,
			'OP01_NAMED_VOID_LPAREN' => 80,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 81
		},
		GOTOS => {
			'Literal' => 84,
			'Operation' => 361,
			'VariableDeclaration' => 86,
			'PAREN-35' => 87,
			'HashReference' => 111,
			'Variable' => 114,
			'Conditional' => 89,
			'ArrayReference' => 90,
			'LoopLabel' => 91,
			'Operator' => 94,
			'OPTIONAL-36' => 72,
			'VariableModification' => 97,
			'ArrayDereference' => 98,
			'Statement' => 74,
			'SubExpression' => 75,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'Expression' => 103,
			'OperatorVoid' => 104,
			'PLUS-41' => 360
		}
	},
	{#State 335
		DEFAULT => -167
	},
	{#State 336
		DEFAULT => -169
	},
	{#State 337
		DEFAULT => -168
	},
	{#State 338
		DEFAULT => -197
	},
	{#State 339
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP04_MATH_POW' => 133,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP13_BITWISE_AND' => 145,
			"}" => -193,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => 136,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP21_LIST_COMMA' => -193,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => 138,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140
		}
	},
	{#State 340
		ACTIONS => {
			")" => 362
		}
	},
	{#State 341
		DEFAULT => -78
	},
	{#State 342
		DEFAULT => -117
	},
	{#State 343
		DEFAULT => -127
	},
	{#State 344
		ACTIONS => {
			"%{" => 116,
			"}" => 363,
			'WORD' => 365
		},
		GOTOS => {
			'HashDereference' => 366,
			'HashEntryTyped' => 364
		}
	},
	{#State 345
		DEFAULT => -74
	},
	{#State 346
		DEFAULT => -57
	},
	{#State 347
		ACTIONS => {
			";" => 367
		}
	},
	{#State 348
		ACTIONS => {
			'WORD' => 61,
			'TYPE_METHOD' => 368,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 349
		DEFAULT => -75
	},
	{#State 350
		DEFAULT => -212
	},
	{#State 351
		DEFAULT => -46
	},
	{#State 352
		ACTIONS => {
			")" => 371,
			'OP21_LIST_COMMA' => 370
		},
		GOTOS => {
			'PAREN-18' => 369
		}
	},
	{#State 353
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'VARIABLE_SYMBOL' => 96,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'LBRACE' => 101,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'OP03_MATH_INC_DEC' => 82,
			'MY' => 157,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			"undef" => 83,
			'LPAREN' => 105,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_QW' => 164,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'ListElement' => 163,
			'Operator' => 94,
			'TypeInner' => 166,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'WordScoped' => 76,
			'HashReference' => 111,
			'HashDereference' => 78,
			'SubExpression' => 162,
			'ArrayDereference' => 98,
			'ListElements' => 372,
			'Literal' => 84
		}
	},
	{#State 354
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			"\@{" => 79,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LPAREN' => 105,
			"undef" => 83,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 96,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			"%{" => 116,
			'OP01_NAMED' => 153,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110
		},
		GOTOS => {
			'Literal' => 84,
			'SubExpression' => 373,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'HashReference' => 111,
			'ArrayDereference' => 98,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Operator' => 94
		}
	},
	{#State 355
		DEFAULT => -160
	},
	{#State 356
		DEFAULT => -211
	},
	{#State 357
		DEFAULT => -171
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 374
		}
	},
	{#State 359
		ACTIONS => {
			'OP01_PRINT' => -153,
			"%{" => -153,
			"while" => -153,
			'OP01_NAMED' => -153,
			'OP01_NAMED_VOID' => -153,
			'OP10_NAMED_UNARY' => -153,
			'LBRACKET' => -153,
			'OP05_LOGICAL_NEG' => -153,
			'LITERAL_NUMBER' => -153,
			'OP05_MATH_NEG_LPAREN' => -153,
			'' => -153,
			'LPAREN' => -153,
			"for" => -153,
			'OP19_LOOP_CONTROL_SCOLON' => -153,
			'LBRACE' => -153,
			'OP01_CLOSE' => -153,
			'OP01_NAMED_VOID_SCOLON' => -153,
			'VARIABLE_SYMBOL' => -153,
			"if" => -153,
			'OP01_OPEN' => -153,
			'OP19_LOOP_CONTROL' => -153,
			"foreach" => -153,
			"}" => -153,
			"undef" => -153,
			'OP03_MATH_INC_DEC' => -153,
			'MY' => -153,
			'OP01_NAMED_VOID_LPAREN' => -153,
			"elsif" => 377,
			"else" => 378,
			"\@{" => -153,
			'OP22_LOGICAL_NEG' => -153,
			'WORD' => -153,
			'LITERAL_STRING' => -153,
			'WORD_SCOPED' => -153,
			'WORD_UPPERCASE' => -153
		},
		GOTOS => {
			'PAREN-39' => 379,
			'OPTIONAL-40' => 376,
			'PAREN-37' => 375
		}
	},
	{#State 360
		ACTIONS => {
			"for" => -142,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_CLOSE' => 100,
			'OP01_NAMED_VOID_SCOLON' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'OP01_PRINT' => 117,
			'OP01_NAMED_VOID' => 112,
			'OP01_NAMED' => 113,
			"while" => -142,
			"%{" => 116,
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			"undef" => 83,
			"\@{" => 79,
			'OP01_NAMED_VOID_LPAREN' => 80,
			'MY' => 81,
			'OP03_MATH_INC_DEC' => 82,
			'LITERAL_STRING' => 73,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 71,
			'OP19_LOOP_CONTROL' => 92,
			'OP01_OPEN' => 93,
			"if" => 95,
			"}" => 381,
			"foreach" => -142
		},
		GOTOS => {
			'VariableModification' => 97,
			'OPTIONAL-36' => 72,
			'SubExpression' => 75,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'ArrayDereference' => 98,
			'Statement' => 74,
			'Expression' => 103,
			'OperatorVoid' => 104,
			'Operation' => 380,
			'VariableDeclaration' => 86,
			'Literal' => 84,
			'HashReference' => 111,
			'PAREN-35' => 87,
			'LoopLabel' => 91,
			'Conditional' => 89,
			'Variable' => 114,
			'ArrayReference' => 90,
			'Operator' => 94
		}
	},
	{#State 361
		DEFAULT => -162
	},
	{#State 362
		DEFAULT => -80
	},
	{#State 363
		ACTIONS => {
			";" => 382
		}
	},
	{#State 364
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 383
		}
	},
	{#State 365
		ACTIONS => {
			'OP20_HASH_FATARROW' => 384
		}
	},
	{#State 366
		DEFAULT => -196
	},
	{#State 367
		DEFAULT => -59
	},
	{#State 368
		ACTIONS => {
			'VARIABLE_SYMBOL' => 385
		}
	},
	{#State 369
		DEFAULT => -48
	},
	{#State 370
		ACTIONS => {
			'MY' => 386
		}
	},
	{#State 371
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 387
		}
	},
	{#State 372
		ACTIONS => {
			")" => 388
		}
	},
	{#State 373
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 135,
			'OP23_LOGICAL_AND' => 136,
			'OP11_COMPARE_LT_GT' => 146,
			'OP13_BITWISE_AND' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP17_LIST_RANGE' => 389,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 141,
			'OP04_MATH_POW' => 133,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP18_TERNARY' => 144,
			'OP07_STRING_REPEAT' => 143
		}
	},
	{#State 374
		ACTIONS => {
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'VARIABLE_SYMBOL' => 96,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 155,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'SubExpression' => 390,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'HashReference' => 111,
			'Literal' => 84,
			'Operator' => 94,
			'Variable' => 154,
			'Expression' => 152,
			'ArrayReference' => 90
		}
	},
	{#State 375
		DEFAULT => -149
	},
	{#State 376
		DEFAULT => -154
	},
	{#State 377
		ACTIONS => {
			'LPAREN' => 391
		}
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 379
		DEFAULT => -152
	},
	{#State 380
		DEFAULT => -161
	},
	{#State 381
		DEFAULT => -163
	},
	{#State 382
		DEFAULT => -64
	},
	{#State 383
		ACTIONS => {
			'OP21_LIST_COMMA' => 394,
			"}" => 395
		},
		GOTOS => {
			'PAREN-24' => 393
		}
	},
	{#State 384
		ACTIONS => {
			'MY' => 157
		},
		GOTOS => {
			'TypeInner' => 396
		}
	},
	{#State 385
		ACTIONS => {
			"= sub {" => 397
		}
	},
	{#State 386
		ACTIONS => {
			'WORD' => 61,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 398
		}
	},
	{#State 387
		ACTIONS => {
			"\@_;" => 399
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
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'LBRACE' => 101,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			"undef" => 83,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Literal' => 84,
			'ArrayDereference' => 98,
			'HashReference' => 111,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'SubExpression' => 401,
			'Expression' => 152,
			'ArrayReference' => 90,
			'Variable' => 154,
			'Operator' => 94
		}
	},
	{#State 390
		ACTIONS => {
			'OP04_MATH_POW' => 133,
			";" => -81,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			"]" => -81,
			'OP13_BITWISE_AND' => 145,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP21_LIST_COMMA' => -81,
			"}" => -81,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => -81,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			")" => -81,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147
		}
	},
	{#State 391
		ACTIONS => {
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'OP01_OPEN' => 93,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'OP01_CLOSE' => 100,
			'LITERAL_STRING' => 73,
			'LBRACE' => 101,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106
		},
		GOTOS => {
			'SubExpression' => 402,
			'HashDereference' => 78,
			'HashReference' => 111,
			'WordScoped' => 76,
			'ArrayDereference' => 98,
			'Literal' => 84,
			'Operator' => 94,
			'Variable' => 154,
			'ArrayReference' => 90,
			'Expression' => 152
		}
	},
	{#State 392
		DEFAULT => -151
	},
	{#State 393
		DEFAULT => -61
	},
	{#State 394
		ACTIONS => {
			"%{" => 116,
			'WORD' => 365
		},
		GOTOS => {
			'HashEntryTyped' => 403,
			'HashDereference' => 366
		}
	},
	{#State 395
		ACTIONS => {
			";" => 404
		}
	},
	{#State 396
		ACTIONS => {
			'LBRACKET' => 110,
			'OP10_NAMED_UNARY' => 109,
			'OP05_LOGICAL_NEG' => 108,
			'LITERAL_NUMBER' => 107,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 153,
			"%{" => 116,
			'LITERAL_STRING' => 73,
			'OP01_CLOSE' => 100,
			'OP22_LOGICAL_NEG' => 77,
			'WORD' => 24,
			'LBRACE' => 101,
			'VARIABLE_SYMBOL' => 96,
			'WORD_UPPERCASE' => 155,
			'WORD_SCOPED' => 26,
			'LPAREN' => 105,
			"undef" => 83,
			'OP05_MATH_NEG_LPAREN' => 106,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'HashDereference' => 78,
			'WordScoped' => 76,
			'HashReference' => 111,
			'SubExpression' => 405,
			'Literal' => 84,
			'Operator' => 94,
			'ArrayReference' => 90,
			'Expression' => 152,
			'Variable' => 154
		}
	},
	{#State 397
		ACTIONS => {
			"if" => -66,
			'OP01_OPEN' => -66,
			'OP19_LOOP_CONTROL' => -66,
			"foreach" => -66,
			"}" => -66,
			'LPAREN_MY' => 408,
			"undef" => -66,
			'OP03_MATH_INC_DEC' => -66,
			'MY' => -66,
			'OP01_NAMED_VOID_LPAREN' => -66,
			"\@{" => -66,
			'OP22_LOGICAL_NEG' => -66,
			'WORD' => -66,
			'LITERAL_STRING' => -66,
			'WORD_UPPERCASE' => -66,
			'WORD_SCOPED' => -66,
			'OP01_PRINT' => -66,
			"while" => -66,
			"%{" => -66,
			'OP01_NAMED' => -66,
			'OP01_NAMED_VOID' => -66,
			'LBRACKET' => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'LITERAL_NUMBER' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'LPAREN' => -66,
			"for" => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'LBRACE' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP01_CLOSE' => -66,
			'VARIABLE_SYMBOL' => -66
		},
		GOTOS => {
			'MethodArguments' => 406,
			'OPTIONAL-26' => 407
		}
	},
	{#State 398
		ACTIONS => {
			'VARIABLE_SYMBOL' => 409
		}
	},
	{#State 399
		DEFAULT => -50
	},
	{#State 400
		DEFAULT => -159
	},
	{#State 401
		ACTIONS => {
			'OP04_MATH_POW' => 133,
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 141,
			'OP18_TERNARY' => -102,
			'OP07_STRING_REPEAT' => 143,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP11_COMPARE_LT_GT' => 146,
			'OP23_LOGICAL_AND' => -102,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP13_BITWISE_AND' => 145,
			")" => 410,
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP08_MATH_ADD_SUB' => 139,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 402
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP13_BITWISE_AND' => 145,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP23_LOGICAL_AND' => 136,
			'OP11_COMPARE_LT_GT' => 146,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			")" => 411,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 133,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP24_LOGICAL_OR_XOR' => 134
		}
	},
	{#State 403
		DEFAULT => -60
	},
	{#State 404
		DEFAULT => -63
	},
	{#State 405
		ACTIONS => {
			'OP06_REGEX_MATCH' => 149,
			'OP14_BITWISE_OR_XOR' => 140,
			'OP17_LIST_RANGE' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 137,
			'OP13_BITWISE_AND' => 145,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP21_LIST_COMMA' => -195,
			'OP23_LOGICAL_AND' => 136,
			"}" => -195,
			'OP11_COMPARE_LT_GT' => 146,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 144,
			'OP24_LOGICAL_OR_XOR' => 134,
			'OP04_MATH_POW' => 133,
			'OP09_BITWISE_SHIFT' => 141,
			'OP16_LOGICAL_OR' => 142
		}
	},
	{#State 406
		DEFAULT => -65
	},
	{#State 407
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 412
		}
	},
	{#State 408
		ACTIONS => {
			'TYPE_SELF' => 413
		}
	},
	{#State 409
		DEFAULT => -47
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
		ACTIONS => {
			'OP01_CLOSE' => 100,
			'OP01_NAMED_VOID_SCOLON' => 99,
			'LBRACE' => 101,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'VARIABLE_SYMBOL' => 96,
			"for" => -142,
			'LPAREN' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 109,
			'LBRACKET' => 110,
			'LITERAL_NUMBER' => 107,
			'OP05_LOGICAL_NEG' => 108,
			'OP01_PRINT' => 117,
			'OP01_NAMED_VOID' => 112,
			'OP01_NAMED' => 113,
			"%{" => 116,
			"while" => -142,
			'LITERAL_STRING' => 73,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 77,
			'WORD_UPPERCASE' => 71,
			'WORD_SCOPED' => 26,
			"undef" => 83,
			"\@{" => 79,
			'OP01_NAMED_VOID_LPAREN' => 80,
			'MY' => 81,
			'OP03_MATH_INC_DEC' => 82,
			"}" => 416,
			"foreach" => -142,
			'OP19_LOOP_CONTROL' => 92,
			'OP01_OPEN' => 93,
			"if" => 95
		},
		GOTOS => {
			'OPTIONAL-36' => 72,
			'VariableModification' => 97,
			'ArrayDereference' => 98,
			'Statement' => 74,
			'SubExpression' => 75,
			'WordScoped' => 76,
			'HashDereference' => 78,
			'Expression' => 103,
			'OperatorVoid' => 104,
			'Literal' => 84,
			'Operation' => 417,
			'VariableDeclaration' => 86,
			'PAREN-35' => 87,
			'HashReference' => 111,
			'Conditional' => 89,
			'Variable' => 114,
			'ArrayReference' => 90,
			'LoopLabel' => 91,
			'Operator' => 94
		}
	},
	{#State 413
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 418
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
			";" => 419
		}
	},
	{#State 417
		DEFAULT => -67
	},
	{#State 418
		ACTIONS => {
			")" => 422,
			'OP21_LIST_COMMA' => 421
		},
		GOTOS => {
			'PAREN-28' => 420
		}
	},
	{#State 419
		DEFAULT => -69
	},
	{#State 420
		DEFAULT => -71
	},
	{#State 421
		ACTIONS => {
			'MY' => 423
		}
	},
	{#State 422
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 424
		}
	},
	{#State 423
		ACTIONS => {
			'WORD' => 61,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 425
		}
	},
	{#State 424
		ACTIONS => {
			"\@_;" => 426
		}
	},
	{#State 425
		ACTIONS => {
			'VARIABLE_SYMBOL' => 427
		}
	},
	{#State 426
		DEFAULT => -73
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
