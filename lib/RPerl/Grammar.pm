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
    our $VERSION = 0.001_004;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|\$TYPED_|foreach|\=\ sub\ \{|elsif|while|undef|else|\@_\;|for|use|our|if|\%\{|\@\{|\}|\;|\)|\])}gc and return ($1, $1);

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
			'SHEBANG' => 4,
			"## no critic qw(" => 1,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 9,
			'CompileUnit' => 3,
			'Critic' => 7,
			'PLUS-2' => 8,
			'OPTIONAL-9' => 2,
			'PAREN-1' => 5,
			'Program' => 6
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'PLUS-14' => 11
		}
	},
	{#State 2
		ACTIONS => {
			"package" => 12
		}
	},
	{#State 3
		ACTIONS => {
			'' => 13
		}
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => 1,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 14,
			'Critic' => 15
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'ModuleHeader' => 9,
			'PAREN-1' => 16,
			'OPTIONAL-9' => 2,
			'Critic' => 7
		}
	},
	{#State 9
		ACTIONS => {
			"our" => -25,
			"## no critic qw(" => -25,
			"use parent qw(" => 17,
			"use constant" => -25,
			"use" => -25
		},
		GOTOS => {
			'STAR-10' => 18,
			'Class' => 21,
			'Module' => 20,
			'Package' => 19
		}
	},
	{#State 10
		DEFAULT => -35
	},
	{#State 11
		ACTIONS => {
			'WORD' => 23,
			")" => 22
		}
	},
	{#State 12
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		ACTIONS => {
			"use strict;" => 28
		},
		GOTOS => {
			'Header' => 27
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		DEFAULT => -2
	},
	{#State 17
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 18
		ACTIONS => {
			"use" => -27,
			"use constant" => -27,
			"our" => -27,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'STAR-11' => 31,
			'Critic' => 30
		}
	},
	{#State 19
		DEFAULT => -22
	},
	{#State 20
		DEFAULT => -1
	},
	{#State 21
		DEFAULT => -23
	},
	{#State 22
		DEFAULT => -36
	},
	{#State 23
		DEFAULT => -34
	},
	{#State 24
		DEFAULT => -207
	},
	{#State 25
		ACTIONS => {
			";" => 32
		}
	},
	{#State 26
		DEFAULT => -206
	},
	{#State 27
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 33
		}
	},
	{#State 28
		ACTIONS => {
			"use warnings;" => 34
		}
	},
	{#State 29
		ACTIONS => {
			")" => 35
		}
	},
	{#State 30
		DEFAULT => -24
	},
	{#State 31
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 36
		},
		GOTOS => {
			'Include' => 38,
			'STAR-12' => 37
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 28
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			'WORD_UPPERCASE' => -11,
			'OP01_OPEN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"## no critic qw(" => 1,
			'OP01_NAMED_VOID' => -11,
			'OP01_PRINT' => -11,
			'LPAREN' => -11,
			"use" => -11,
			"%{" => -11,
			'OP10_NAMED_UNARY' => -11,
			'WORD_SCOPED' => -11,
			"for" => -11,
			"\@{" => -11,
			'LITERAL_NUMBER' => -11,
			'WORD' => -11,
			"use constant" => -11,
			'OP01_NAMED' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LITERAL_STRING' => -11,
			'VARIABLE_SYMBOL' => -11,
			"undef" => -11,
			'MY' => -11,
			"foreach" => -11,
			"while" => -11,
			"if" => -11,
			'LBRACKET' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"our" => -11,
			'LBRACE' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_CLOSE' => -11
		},
		GOTOS => {
			'STAR-5' => 41,
			'Critic' => 40
		}
	},
	{#State 34
		ACTIONS => {
			"use RPerl;" => 42
		}
	},
	{#State 35
		ACTIONS => {
			";" => 43
		}
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 44
		}
	},
	{#State 37
		ACTIONS => {
			"use constant" => 48,
			"our" => 49
		},
		GOTOS => {
			'Subroutine' => 47,
			'PLUS-13' => 45,
			'Constant' => 46
		}
	},
	{#State 38
		DEFAULT => -26
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		DEFAULT => -8
	},
	{#State 41
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LBRACKET' => -13,
			"if" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_CLOSE' => -13,
			'LBRACE' => -13,
			"our" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'LITERAL_STRING' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_NAMED' => -13,
			"foreach" => -13,
			"while" => -13,
			'MY' => -13,
			"undef" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'WORD_SCOPED' => -13,
			"%{" => -13,
			"use" => 36,
			"use constant" => -13,
			'WORD' => -13,
			'LITERAL_NUMBER' => -13,
			"\@{" => -13,
			"for" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_OPEN' => -13,
			'WORD_UPPERCASE' => -13,
			'LPAREN' => -13,
			'OP01_PRINT' => -13,
			'OP01_NAMED_VOID' => -13
		},
		GOTOS => {
			'Include' => 50,
			'STAR-6' => 51
		}
	},
	{#State 42
		ACTIONS => {
			"our" => 52
		}
	},
	{#State 43
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 44
		ACTIONS => {
			'OP01_QW' => 54,
			";" => 55
		}
	},
	{#State 45
		ACTIONS => {
			"our" => 49,
			'LITERAL_NUMBER' => 57
		},
		GOTOS => {
			'Subroutine' => 56
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
			'WORD_UPPERCASE' => 58
		}
	},
	{#State 49
		ACTIONS => {
			'WORD' => 60,
			'TYPE_INTEGER' => 61
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 50
		DEFAULT => -10
	},
	{#State 51
		ACTIONS => {
			'OP01_OPEN' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LPAREN' => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP10_NAMED_UNARY' => -15,
			'WORD_SCOPED' => -15,
			"%{" => -15,
			'LITERAL_NUMBER' => -15,
			"\@{" => -15,
			"for" => -15,
			"use constant" => 48,
			'WORD' => -15,
			'LITERAL_STRING' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_NAMED' => -15,
			'MY' => -15,
			"undef" => -15,
			'VARIABLE_SYMBOL' => -15,
			"while" => -15,
			"foreach" => -15,
			'LBRACKET' => -15,
			"if" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"our" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_CLOSE' => -15,
			'LBRACE' => -15,
			'OP19_LOOP_CONTROL' => -15
		},
		GOTOS => {
			'Constant' => 63,
			'STAR-7' => 62
		}
	},
	{#State 52
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 64
		}
	},
	{#State 53
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 65
		}
	},
	{#State 54
		ACTIONS => {
			'WORD' => 67
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 55
		DEFAULT => -39
	},
	{#State 56
		DEFAULT => -30
	},
	{#State 57
		ACTIONS => {
			";" => 68
		}
	},
	{#State 58
		ACTIONS => {
			'OP20_HASH_FATARROW' => 69
		}
	},
	{#State 59
		ACTIONS => {
			'VARIABLE_SYMBOL' => 70
		}
	},
	{#State 60
		DEFAULT => -209
	},
	{#State 61
		DEFAULT => -210
	},
	{#State 62
		ACTIONS => {
			'LPAREN' => 83,
			'OP01_NAMED_VOID' => 81,
			'OP01_PRINT' => 80,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 84,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"for" => -142,
			"\@{" => 71,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			"%{" => 74,
			"foreach" => -142,
			"while" => -142,
			"undef" => 105,
			'MY' => 108,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED' => 115,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'OP19_LOOP_CONTROL' => 93,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			"our" => 49,
			'OP05_LOGICAL_NEG' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP01_NAMED_VOID_SCOLON' => 102,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99,
			"if" => 97
		},
		GOTOS => {
			'Operator' => 90,
			'ArrayReference' => 72,
			'OPTIONAL-36' => 91,
			'VariableDeclaration' => 95,
			'Subroutine' => 96,
			'ArrayDereference' => 98,
			'PLUS-8' => 75,
			'PAREN-35' => 106,
			'Conditional' => 107,
			'HashReference' => 109,
			'SubExpression' => 79,
			'Expression' => 103,
			'LoopLabel' => 78,
			'Variable' => 77,
			'OperatorVoid' => 111,
			'Operation' => 82,
			'VariableModification' => 110,
			'Literal' => 114,
			'WordScoped' => 113,
			'Statement' => 112,
			'HashDereference' => 87
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		DEFAULT => -33
	},
	{#State 65
		ACTIONS => {
			"use" => -54,
			"use constant" => -54,
			"our hashref \$properties" => -54,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'Critic' => 118,
			'STAR-21' => 119
		}
	},
	{#State 66
		ACTIONS => {
			'WORD' => 121,
			")" => 120
		}
	},
	{#State 67
		DEFAULT => -38
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			'MY' => 123
		},
		GOTOS => {
			'TypeInnerConstant' => 122
		}
	},
	{#State 70
		ACTIONS => {
			"= sub {" => 124
		}
	},
	{#State 71
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'MY' => 127,
			'LBRACKET' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 125,
			'Variable' => 126,
			'TypeInner' => 128
		}
	},
	{#State 72
		DEFAULT => -133
	},
	{#State 73
		DEFAULT => -218
	},
	{#State 74
		ACTIONS => {
			'MY' => 127,
			'VARIABLE_SYMBOL' => 104,
			'LBRACE' => -203
		},
		GOTOS => {
			'Variable' => 130,
			'TypeInner' => 131,
			'OPTIONAL-51' => 129
		}
	},
	{#State 75
		ACTIONS => {
			'LPAREN' => 83,
			'OP01_NAMED_VOID' => 81,
			'OP01_PRINT' => 80,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 84,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_NUMBER' => 73,
			"for" => -142,
			"\@{" => 71,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			"%{" => 74,
			"undef" => 105,
			'MY' => 108,
			'VARIABLE_SYMBOL' => 104,
			"while" => -142,
			"foreach" => -142,
			'OP01_NAMED' => 115,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'OP05_LOGICAL_NEG' => 89,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'OP19_LOOP_CONTROL' => 93,
			'' => -18,
			'LBRACKET' => 99,
			"if" => 97,
			'OP01_NAMED_VOID_SCOLON' => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP05_MATH_NEG_LPAREN' => 100
		},
		GOTOS => {
			'Conditional' => 107,
			'SubExpression' => 79,
			'HashReference' => 109,
			'PAREN-35' => 106,
			'Variable' => 77,
			'LoopLabel' => 78,
			'Expression' => 103,
			'OperatorVoid' => 111,
			'VariableModification' => 110,
			'Operation' => 132,
			'Literal' => 114,
			'Statement' => 112,
			'WordScoped' => 113,
			'HashDereference' => 87,
			'Operator' => 90,
			'ArrayReference' => 72,
			'VariableDeclaration' => 95,
			'OPTIONAL-36' => 91,
			'ArrayDereference' => 98
		}
	},
	{#State 76
		ACTIONS => {
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'OP15_LOGICAL_AND' => -95,
			'OP05_LOGICAL_NEG' => 89,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99,
			'OP09_BITWISE_SHIFT' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'OP17_LIST_RANGE' => -95,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			"}" => -95,
			'OP04_MATH_POW' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			'OP13_BITWISE_AND' => -95,
			"\@{" => 71,
			'OP08_STRING_CAT' => -95,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			"%{" => 74,
			";" => -95,
			'OP23_LOGICAL_AND' => -95,
			'LPAREN' => 83,
			'OP18_TERNARY' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			")" => -95,
			'OP03_MATH_INC_DEC' => 86,
			"]" => -95,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133
		},
		GOTOS => {
			'SubExpression' => 134,
			'Operator' => 90,
			'HashReference' => 109,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Expression' => 137,
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98
		}
	},
	{#State 77
		ACTIONS => {
			'OP23_LOGICAL_AND' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP19_VARIABLE_ASSIGN' => 141,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP08_STRING_CAT' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP03_MATH_INC_DEC' => 138,
			'OP19_VARIABLE_ASSIGN_BY' => 140,
			'OP02_METHOD_THINARROW' => 139,
			'OP04_MATH_POW' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP18_TERNARY' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP17_LIST_RANGE' => -132
		}
	},
	{#State 78
		ACTIONS => {
			'COLON' => 142
		}
	},
	{#State 79
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 152,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144,
			'OP23_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 150,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP15_LOGICAL_AND' => 149,
			'OP13_BITWISE_AND' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157
		}
	},
	{#State 80
		ACTIONS => {
			'LBRACKET' => -109,
			'WORD_SCOPED' => -109,
			'OP10_NAMED_UNARY' => -109,
			"%{" => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'LITERAL_NUMBER' => -109,
			"\@{" => -109,
			'OP05_LOGICAL_NEG' => -109,
			'STDOUT_STDERR' => 162,
			'OP01_CLOSE' => -109,
			'LBRACE' => -109,
			'WORD' => -109,
			'OP01_OPEN' => -109,
			'FHREF_SYMBOL_BRACES' => 163,
			'WORD_UPPERCASE' => -109,
			'LITERAL_STRING' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP01_NAMED' => -109,
			'MY' => -109,
			"undef" => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP01_QW' => -109,
			'LPAREN' => -109
		},
		GOTOS => {
			'PAREN-30' => 161,
			'OPTIONAL-31' => 160
		}
	},
	{#State 81
		ACTIONS => {
			'LITERAL_STRING' => 117,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 166,
			'MY' => 127,
			"undef" => 105,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 99,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'TypeInner' => 164,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'SubExpression' => 168,
			'HashReference' => 109,
			'ListElement' => 167,
			'Operator' => 90,
			'ListElements' => 165,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72
		}
	},
	{#State 82
		DEFAULT => -17
	},
	{#State 83
		ACTIONS => {
			'LPAREN' => 83,
			'OP01_PRINT' => 170,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 171,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99
		},
		GOTOS => {
			'Operator' => 90,
			'HashReference' => 109,
			'SubExpression' => 169,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'HashDereference' => 87
		}
	},
	{#State 84
		ACTIONS => {
			'LPAREN' => 172,
			'COLON' => -208
		}
	},
	{#State 85
		ACTIONS => {
			'MY' => 173
		}
	},
	{#State 86
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 174
		}
	},
	{#State 87
		DEFAULT => -136
	},
	{#State 88
		ACTIONS => {
			'LPAREN' => 83,
			"undef" => 105,
			'MY' => 127,
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 166,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			")" => -111,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LBRACKET' => 99
		},
		GOTOS => {
			'HashDereference' => 87,
			'TypeInner' => 164,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114,
			'OPTIONAL-32' => 175,
			'ListElements' => 176,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135,
			'ListElement' => 167,
			'HashReference' => 109,
			'SubExpression' => 168,
			'Operator' => 90
		}
	},
	{#State 89
		ACTIONS => {
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99
		},
		GOTOS => {
			'HashDereference' => 87,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'Literal' => 114,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135,
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 177
		}
	},
	{#State 90
		DEFAULT => -124
	},
	{#State 91
		ACTIONS => {
			"for" => 184,
			"foreach" => 178,
			"while" => 179
		},
		GOTOS => {
			'Loop' => 183,
			'LoopWhile' => 181,
			'LoopFor' => 180,
			'LoopForEach' => 182
		}
	},
	{#State 92
		ACTIONS => {
			"}" => 186,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 188,
			"%{" => 74,
			'LITERAL_STRING' => 117
		},
		GOTOS => {
			'HashEntry' => 187,
			'VariableOrLiteralOrWord' => 190,
			'HashDereference' => 189,
			'Literal' => 185,
			'Variable' => 191
		}
	},
	{#State 93
		ACTIONS => {
			'WORD_UPPERCASE' => 193
		},
		GOTOS => {
			'LoopLabel' => 192
		}
	},
	{#State 94
		ACTIONS => {
			'FHREF_SYMBOL' => 194
		}
	},
	{#State 95
		DEFAULT => -146
	},
	{#State 96
		DEFAULT => -14
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 195
		}
	},
	{#State 98
		DEFAULT => -134
	},
	{#State 99
		ACTIONS => {
			'OP01_OPEN' => 85,
			"]" => -185,
			'WORD_UPPERCASE' => 133,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			"undef" => 105,
			'MY' => 127,
			'OP01_QW' => 166,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 83,
			'LBRACKET' => 99,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'WORD' => 26
		},
		GOTOS => {
			'Expression' => 137,
			'ListElements' => 197,
			'ArrayReference' => 72,
			'Variable' => 135,
			'ListElement' => 167,
			'SubExpression' => 168,
			'HashReference' => 109,
			'Operator' => 90,
			'OPTIONAL-46' => 196,
			'HashDereference' => 87,
			'TypeInner' => 164,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'Literal' => 114
		}
	},
	{#State 100
		ACTIONS => {
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 99
		},
		GOTOS => {
			'SubExpression' => 198,
			'Operator' => 90,
			'HashReference' => 109,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'HashDereference' => 87
		}
	},
	{#State 101
		DEFAULT => -118
	},
	{#State 102
		DEFAULT => -114
	},
	{#State 103
		ACTIONS => {
			'OP06_REGEX_MATCH' => -129,
			'OP04_MATH_POW' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP18_TERNARY' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP23_LOGICAL_AND' => -129,
			";" => 199,
			'OP08_STRING_CAT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP14_BITWISE_OR_XOR' => -129
		}
	},
	{#State 104
		DEFAULT => -165,
		GOTOS => {
			'STAR-42' => 200
		}
	},
	{#State 105
		DEFAULT => -130
	},
	{#State 106
		DEFAULT => -141
	},
	{#State 107
		DEFAULT => -143
	},
	{#State 108
		ACTIONS => {
			'TYPE_INTEGER' => 61,
			'WORD' => 60,
			'TYPE_FHREF' => 201
		},
		GOTOS => {
			'Type' => 202
		}
	},
	{#State 109
		DEFAULT => -135
	},
	{#State 110
		DEFAULT => -147
	},
	{#State 111
		DEFAULT => -145
	},
	{#State 112
		DEFAULT => -77
	},
	{#State 113
		ACTIONS => {
			'LPAREN' => 203,
			'OP02_METHOD_THINARROW_NEW' => 204
		}
	},
	{#State 114
		DEFAULT => -131
	},
	{#State 115
		ACTIONS => {
			'LPAREN' => 83,
			'OP01_QW' => 166,
			'VARIABLE_SYMBOL' => 104,
			'MY' => 127,
			"undef" => 105,
			'LITERAL_STRING' => 117,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 99
		},
		GOTOS => {
			'Literal' => 114,
			'TypeInner' => 164,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'HashDereference' => 87,
			'ListElement' => 206,
			'Operator' => 90,
			'SubExpression' => 205,
			'HashReference' => 109,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135
		}
	},
	{#State 116
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'LBRACKET' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117
		},
		GOTOS => {
			'Operator' => 90,
			'HashReference' => 109,
			'SubExpression' => 207,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Expression' => 137,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'HashDereference' => 87
		}
	},
	{#State 117
		DEFAULT => -219
	},
	{#State 118
		DEFAULT => -51
	},
	{#State 119
		ACTIONS => {
			"our hashref \$properties" => -56,
			"use constant" => -56,
			"use" => 36
		},
		GOTOS => {
			'STAR-22' => 209,
			'Include' => 208
		}
	},
	{#State 120
		ACTIONS => {
			";" => 210
		}
	},
	{#State 121
		DEFAULT => -37
	},
	{#State 122
		ACTIONS => {
			'LITERAL_NUMBER' => 73,
			'LITERAL_STRING' => 117
		},
		GOTOS => {
			'Literal' => 211
		}
	},
	{#State 123
		ACTIONS => {
			'TYPE_INTEGER' => 61,
			'WORD' => 60
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 124
		ACTIONS => {
			'WORD_UPPERCASE' => -43,
			'OP01_OPEN' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED_VOID_LPAREN' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_PRINT' => -43,
			'LPAREN' => -43,
			"%{" => -43,
			'WORD_SCOPED' => -43,
			'OP10_NAMED_UNARY' => -43,
			"\@{" => -43,
			"for" => -43,
			'LITERAL_NUMBER' => -43,
			'WORD' => -43,
			"}" => -43,
			'LITERAL_STRING' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_NAMED' => -43,
			'VARIABLE_SYMBOL' => -43,
			'MY' => -43,
			"undef" => -43,
			"foreach" => -43,
			"while" => -43,
			"if" => -43,
			'LPAREN_MY' => 213,
			'LBRACKET' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_CLOSE' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LBRACE' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 214,
			'OPTIONAL-16' => 215
		}
	},
	{#State 125
		ACTIONS => {
			'LBRACKET' => 99
		},
		GOTOS => {
			'ArrayReference' => 216
		}
	},
	{#State 126
		ACTIONS => {
			"}" => 217
		}
	},
	{#State 127
		ACTIONS => {
			'TYPE_INTEGER' => 61,
			'WORD' => 60
		},
		GOTOS => {
			'Type' => 218
		}
	},
	{#State 128
		DEFAULT => -187
	},
	{#State 129
		ACTIONS => {
			'LBRACE' => 92
		},
		GOTOS => {
			'HashReference' => 219
		}
	},
	{#State 130
		ACTIONS => {
			"}" => 220
		}
	},
	{#State 131
		DEFAULT => -202
	},
	{#State 132
		DEFAULT => -16
	},
	{#State 133
		ACTIONS => {
			'LPAREN' => 172
		}
	},
	{#State 134
		ACTIONS => {
			'OP21_LIST_COMMA' => -94,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			"]" => -94,
			"}" => -94,
			")" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -94,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => -94,
			";" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 156
		}
	},
	{#State 135
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 138,
			")" => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP21_LIST_COMMA' => -132,
			'OP04_MATH_POW' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP02_METHOD_THINARROW' => 139,
			"]" => -132,
			"}" => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP18_TERNARY' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP23_LOGICAL_AND' => -132,
			";" => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP08_STRING_CAT' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP15_LOGICAL_AND' => -132
		}
	},
	{#State 136
		ACTIONS => {
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'WORD' => 26,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 117,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 83
		},
		GOTOS => {
			'HashDereference' => 87,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135,
			'SubExpression' => 221,
			'Operator' => 90,
			'HashReference' => 109
		}
	},
	{#State 137
		DEFAULT => -129
	},
	{#State 138
		DEFAULT => -84
	},
	{#State 139
		ACTIONS => {
			'LPAREN' => 222
		}
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LITERAL_STRING' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'LBRACKET' => 99,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'SubExpression' => 223,
			'HashReference' => 109,
			'Operator' => 90,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Expression' => 137
		}
	},
	{#State 141
		ACTIONS => {
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'LPAREN' => 83,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'STDIN' => 226,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 224,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Expression' => 137,
			'SubExpressionOrStdin' => 225,
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98
		}
	},
	{#State 142
		DEFAULT => -140
	},
	{#State 143
		ACTIONS => {
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'LBRACKET' => 99,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'SubExpression' => 227,
			'HashReference' => 109,
			'Operator' => 90,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135
		}
	},
	{#State 144
		ACTIONS => {
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 117,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 83
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'SubExpression' => 228,
			'HashReference' => 109,
			'Operator' => 90,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135
		}
	},
	{#State 145
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'LBRACKET' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'HashReference' => 109,
			'SubExpression' => 229,
			'Operator' => 90,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72
		}
	},
	{#State 146
		ACTIONS => {
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 83,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'LBRACKET' => 99,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100
		},
		GOTOS => {
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 230,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Expression' => 137,
			'HashDereference' => 87,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113
		}
	},
	{#State 147
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 231
		}
	},
	{#State 148
		ACTIONS => {
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 99,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73
		},
		GOTOS => {
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114,
			'HashDereference' => 87,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'SubExpression' => 232,
			'HashReference' => 109,
			'Operator' => 90
		}
	},
	{#State 149
		ACTIONS => {
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85
		},
		GOTOS => {
			'SubExpression' => 233,
			'HashReference' => 109,
			'Operator' => 90,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Expression' => 137,
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98
		}
	},
	{#State 150
		ACTIONS => {
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LITERAL_STRING' => 117,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85
		},
		GOTOS => {
			'Operator' => 90,
			'SubExpression' => 234,
			'HashReference' => 109,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'HashDereference' => 87
		}
	},
	{#State 151
		ACTIONS => {
			'LITERAL_STRING' => 117,
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'VariableOrLiteral' => 236,
			'Variable' => 237,
			'Literal' => 235
		}
	},
	{#State 152
		ACTIONS => {
			'LITERAL_STRING' => 117,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'LPAREN' => 83,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'HashDereference' => 87,
			'SubExpression' => 238,
			'HashReference' => 109,
			'Operator' => 90,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72
		}
	},
	{#State 153
		ACTIONS => {
			'LBRACKET' => 99,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LITERAL_STRING' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Operator' => 90,
			'SubExpression' => 239,
			'HashReference' => 109,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Expression' => 137
		}
	},
	{#State 154
		ACTIONS => {
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 117,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'LBRACKET' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94
		},
		GOTOS => {
			'ArrayReference' => 72,
			'Variable' => 135,
			'Expression' => 137,
			'Operator' => 90,
			'HashReference' => 109,
			'SubExpression' => 240,
			'HashDereference' => 87,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114
		}
	},
	{#State 155
		ACTIONS => {
			'LPAREN' => 83,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99
		},
		GOTOS => {
			'HashReference' => 109,
			'SubExpression' => 241,
			'Operator' => 90,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'HashDereference' => 87
		}
	},
	{#State 156
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 99,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105
		},
		GOTOS => {
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'SubExpression' => 242,
			'Operator' => 90,
			'HashReference' => 109,
			'HashDereference' => 87,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114
		}
	},
	{#State 157
		ACTIONS => {
			'LPAREN' => 83,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 117,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99
		},
		GOTOS => {
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'Literal' => 114,
			'HashDereference' => 87,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Expression' => 137,
			'SubExpression' => 243,
			'Operator' => 90,
			'HashReference' => 109
		}
	},
	{#State 158
		ACTIONS => {
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LITERAL_STRING' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85
		},
		GOTOS => {
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'Literal' => 114,
			'HashDereference' => 87,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Operator' => 90,
			'SubExpression' => 244,
			'HashReference' => 109
		}
	},
	{#State 159
		ACTIONS => {
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'HashDereference' => 87,
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 245,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135
		}
	},
	{#State 160
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 166,
			"undef" => 105,
			'MY' => 127,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'LBRACKET' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'TypeInner' => 164,
			'HashReference' => 109,
			'Operator' => 90,
			'ListElement' => 167,
			'SubExpression' => 168,
			'ArrayReference' => 72,
			'Variable' => 135,
			'ListElements' => 246,
			'Expression' => 137
		}
	},
	{#State 161
		DEFAULT => -108
	},
	{#State 162
		DEFAULT => -107
	},
	{#State 163
		ACTIONS => {
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 166,
			'MY' => 127,
			"undef" => 105
		},
		GOTOS => {
			'ListElement' => 167,
			'Operator' => 90,
			'HashReference' => 109,
			'SubExpression' => 168,
			'Variable' => 135,
			'ArrayReference' => 72,
			'ListElements' => 247,
			'Expression' => 137,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'TypeInner' => 164,
			'HashDereference' => 87
		}
	},
	{#State 164
		ACTIONS => {
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 83,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'LBRACKET' => 99,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74
		},
		GOTOS => {
			'Operator' => 90,
			'SubExpression' => 248,
			'HashReference' => 109,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'HashDereference' => 87,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113
		}
	},
	{#State 165
		ACTIONS => {
			";" => 249
		}
	},
	{#State 166
		ACTIONS => {
			'WORD' => 251
		},
		GOTOS => {
			'PLUS-45' => 250
		}
	},
	{#State 167
		DEFAULT => -177,
		GOTOS => {
			'STAR-44' => 252
		}
	},
	{#State 168
		ACTIONS => {
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 149,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => 159,
			";" => -181,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP21_LIST_COMMA' => -181,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			"]" => -181,
			")" => -181,
			'OP12_COMPARE_EQ_NE' => 152
		}
	},
	{#State 169
		ACTIONS => {
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 149,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => 159,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			")" => 253,
			'OP12_COMPARE_EQ_NE' => 152
		}
	},
	{#State 170
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 254
		}
	},
	{#State 171
		ACTIONS => {
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 166,
			'MY' => 127,
			"undef" => 105
		},
		GOTOS => {
			'SubExpression' => 205,
			'HashReference' => 109,
			'Operator' => 90,
			'ListElement' => 255,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'HashDereference' => 87,
			'Literal' => 114,
			'TypeInner' => 164,
			'ArrayDereference' => 98,
			'WordScoped' => 113
		}
	},
	{#State 172
		ACTIONS => {
			")" => 256
		}
	},
	{#State 173
		ACTIONS => {
			'TYPE_FHREF' => 257
		}
	},
	{#State 174
		DEFAULT => -83
	},
	{#State 175
		ACTIONS => {
			")" => 258
		}
	},
	{#State 176
		DEFAULT => -110
	},
	{#State 177
		ACTIONS => {
			"}" => -86,
			"]" => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			")" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP18_TERNARY' => -86,
			'OP07_STRING_REPEAT' => -86,
			";" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP08_STRING_CAT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP16_LOGICAL_OR' => -86
		}
	},
	{#State 178
		ACTIONS => {
			'MY' => 259
		}
	},
	{#State 179
		ACTIONS => {
			'LPAREN' => 260
		}
	},
	{#State 180
		DEFAULT => -155
	},
	{#State 181
		DEFAULT => -157
	},
	{#State 182
		DEFAULT => -156
	},
	{#State 183
		DEFAULT => -144
	},
	{#State 184
		ACTIONS => {
			'MY' => 261
		}
	},
	{#State 185
		DEFAULT => -216
	},
	{#State 186
		DEFAULT => -201
	},
	{#State 187
		DEFAULT => -199,
		GOTOS => {
			'STAR-50' => 262
		}
	},
	{#State 188
		DEFAULT => -217
	},
	{#State 189
		DEFAULT => -194
	},
	{#State 190
		ACTIONS => {
			'OP20_HASH_FATARROW' => 263
		}
	},
	{#State 191
		DEFAULT => -215
	},
	{#State 192
		ACTIONS => {
			";" => 264
		}
	},
	{#State 193
		DEFAULT => -208
	},
	{#State 194
		DEFAULT => -82
	},
	{#State 195
		ACTIONS => {
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_STRING' => 117,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LPAREN' => 83,
			'LBRACKET' => 99,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 265,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135
		}
	},
	{#State 196
		ACTIONS => {
			"]" => 266
		}
	},
	{#State 197
		DEFAULT => -184
	},
	{#State 198
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => 159,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145,
			")" => 267,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 199
		DEFAULT => -76
	},
	{#State 200
		ACTIONS => {
			")" => -166,
			'OP03_MATH_INC_DEC' => -166,
			'OP19_VARIABLE_ASSIGN_BY' => -166,
			'COLON' => -166,
			'OP12_COMPARE_EQ_NE' => -166,
			'OP02_METHOD_THINARROW' => -166,
			'OP06_REGEX_MATCH' => -166,
			'OP04_MATH_POW' => -166,
			'OP21_LIST_COMMA' => -166,
			"}" => -166,
			"]" => -166,
			'OP07_STRING_REPEAT' => -166,
			'OP18_TERNARY' => -166,
			'OP17_LIST_RANGE' => -166,
			'OP11_COMPARE_LT_GT' => -166,
			'OP20_HASH_FATARROW' => -166,
			'OP09_BITWISE_SHIFT' => -166,
			";" => -166,
			'OP23_LOGICAL_AND' => -166,
			'OP02_HASH_THINARROW' => 268,
			'OP02_ARRAY_THINARROW' => 269,
			'OP08_MATH_ADD_SUB' => -166,
			'OP14_BITWISE_OR_XOR' => -166,
			'OP19_VARIABLE_ASSIGN' => -166,
			'OP24_LOGICAL_OR_XOR' => -166,
			'OP16_LOGICAL_OR' => -166,
			'OP13_BITWISE_AND' => -166,
			'OP08_STRING_CAT' => -166,
			'OP07_MATH_MULT_DIV_MOD' => -166,
			'OP15_LOGICAL_AND' => -166
		},
		GOTOS => {
			'VariableRetrieval' => 270
		}
	},
	{#State 201
		ACTIONS => {
			'FHREF_SYMBOL' => 271
		}
	},
	{#State 202
		ACTIONS => {
			'VARIABLE_SYMBOL' => 272
		}
	},
	{#State 203
		ACTIONS => {
			'LPAREN' => 83,
			'MY' => 127,
			"undef" => 105,
			'OP01_QW' => 166,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 117,
			")" => -121,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99
		},
		GOTOS => {
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'TypeInner' => 164,
			'Literal' => 114,
			'OPTIONAL-33' => 274,
			'HashDereference' => 87,
			'Variable' => 135,
			'ArrayReference' => 72,
			'ListElements' => 273,
			'Expression' => 137,
			'Operator' => 90,
			'SubExpression' => 168,
			'ListElement' => 167,
			'HashReference' => 109
		}
	},
	{#State 204
		ACTIONS => {
			")" => 275
		}
	},
	{#State 205
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -79,
			'OP23_LOGICAL_AND' => -79,
			";" => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP08_STRING_CAT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP15_LOGICAL_AND' => -79,
			")" => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP21_LIST_COMMA' => -181,
			'OP04_MATH_POW' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP18_TERNARY' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP11_COMPARE_LT_GT' => -79
		}
	},
	{#State 206
		ACTIONS => {
			'OP21_LIST_COMMA' => 276
		}
	},
	{#State 207
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP15_LOGICAL_AND' => 149,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			";" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144,
			'OP12_COMPARE_EQ_NE' => 152,
			")" => -104,
			"}" => -104,
			"]" => -104,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP21_LIST_COMMA' => -104
		}
	},
	{#State 208
		DEFAULT => -53
	},
	{#State 209
		ACTIONS => {
			"use constant" => 48,
			"our hashref \$properties" => 279
		},
		GOTOS => {
			'Constant' => 278,
			'Properties' => 277
		}
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
		ACTIONS => {
			'WORD' => 60,
			'TYPE_INTEGER' => 61
		},
		GOTOS => {
			'Type' => 282
		}
	},
	{#State 214
		DEFAULT => -42
	},
	{#State 215
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 283
		}
	},
	{#State 216
		ACTIONS => {
			"}" => 284
		}
	},
	{#State 217
		DEFAULT => -189
	},
	{#State 218
		ACTIONS => {
			"\$TYPED_" => 285
		}
	},
	{#State 219
		ACTIONS => {
			"}" => 286
		}
	},
	{#State 220
		DEFAULT => -204
	},
	{#State 221
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -79,
			")" => -79,
			"}" => -79,
			"]" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP04_MATH_POW' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP18_TERNARY' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP17_LIST_RANGE' => -79,
			";" => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79
		}
	},
	{#State 222
		ACTIONS => {
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99,
			'LPAREN' => 83,
			'OP01_QW' => 166,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'MY' => 127,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			")" => -123,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85
		},
		GOTOS => {
			'HashDereference' => 87,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'TypeInner' => 164,
			'Literal' => 114,
			'OPTIONAL-34' => 288,
			'Variable' => 135,
			'ArrayReference' => 72,
			'ListElements' => 287,
			'Expression' => 137,
			'Operator' => 90,
			'ListElement' => 167,
			'HashReference' => 109,
			'SubExpression' => 168
		}
	},
	{#State 223
		ACTIONS => {
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 149,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => 159,
			";" => 289
		}
	},
	{#State 224
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 150,
			";" => -138,
			'OP23_LOGICAL_AND' => 159,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154,
			'OP13_BITWISE_AND' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP15_LOGICAL_AND' => 149,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145
		}
	},
	{#State 225
		ACTIONS => {
			";" => 290
		}
	},
	{#State 226
		DEFAULT => -139
	},
	{#State 227
		ACTIONS => {
			"}" => -89,
			"]" => -89,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP21_LIST_COMMA' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			")" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP18_TERNARY' => -89,
			'OP07_STRING_REPEAT' => -89,
			";" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_STRING_CAT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP16_LOGICAL_OR' => -89
		}
	},
	{#State 228
		ACTIONS => {
			'OP18_TERNARY' => -102,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 152,
			")" => -102,
			"}" => -102,
			"]" => -102,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -102,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP16_LOGICAL_OR' => 154,
			'OP15_LOGICAL_AND' => 149,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			";" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP09_BITWISE_SHIFT' => 150
		}
	},
	{#State 229
		ACTIONS => {
			'OP18_TERNARY' => -96,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => undef,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			")" => -96,
			"}" => -96,
			"]" => -96,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP08_MATH_ADD_SUB' => 156,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			";" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP09_BITWISE_SHIFT' => 150
		}
	},
	{#State 230
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -85,
			")" => -85,
			"]" => -85,
			"}" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => -85,
			'OP18_TERNARY' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP23_LOGICAL_AND' => -85,
			";" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP08_STRING_CAT' => -85,
			'OP13_BITWISE_AND' => -85
		}
	},
	{#State 231
		DEFAULT => -88
	},
	{#State 232
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -90,
			";" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP08_STRING_CAT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP21_LIST_COMMA' => -90,
			"}" => -90,
			"]" => -90,
			")" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -90
		}
	},
	{#State 233
		ACTIONS => {
			";" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => 150,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP12_COMPARE_EQ_NE' => 152,
			")" => -100,
			"}" => -100,
			"]" => -100,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -100,
			'OP18_TERNARY' => -100,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => -100
		}
	},
	{#State 234
		ACTIONS => {
			'OP21_LIST_COMMA' => -93,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			"]" => -93,
			"}" => -93,
			")" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP23_LOGICAL_AND' => -93,
			";" => -93,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => 156
		}
	},
	{#State 235
		DEFAULT => -214
	},
	{#State 236
		ACTIONS => {
			'COLON' => 291
		}
	},
	{#State 237
		DEFAULT => -213
	},
	{#State 238
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			";" => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => -97,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			")" => -97,
			"}" => -97,
			"]" => -97,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -97
		}
	},
	{#State 239
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP16_LOGICAL_OR' => 154,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => 159,
			";" => -106,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145,
			")" => -106,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP21_LIST_COMMA' => -106,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			"]" => -106,
			"}" => -106
		}
	},
	{#State 240
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 152,
			")" => -101,
			"]" => -101,
			"}" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP18_TERNARY' => -101,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101,
			";" => -101,
			'OP09_BITWISE_SHIFT' => 150,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP15_LOGICAL_AND' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => 158
		}
	},
	{#State 241
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP23_LOGICAL_AND' => -99,
			";" => -99,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => -99,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => -99,
			'OP12_COMPARE_EQ_NE' => 152,
			")" => -99,
			"]" => -99,
			"}" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 242
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			";" => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			")" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP21_LIST_COMMA' => -91,
			"}" => -91,
			"]" => -91
		}
	},
	{#State 243
		ACTIONS => {
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			")" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -92,
			"}" => -92,
			"]" => -92,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP15_LOGICAL_AND' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			";" => -92,
			'OP23_LOGICAL_AND' => -92
		}
	},
	{#State 244
		ACTIONS => {
			'OP15_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 156,
			'OP23_LOGICAL_AND' => -98,
			";" => -98,
			'OP09_BITWISE_SHIFT' => 150,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => -98,
			'OP18_TERNARY' => -98,
			'OP07_STRING_REPEAT' => 143,
			"]" => -98,
			"}" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP12_COMPARE_EQ_NE' => 152,
			")" => -98
		}
	},
	{#State 245
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP13_BITWISE_AND' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP15_LOGICAL_AND' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			";" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145,
			")" => -105,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP21_LIST_COMMA' => -105,
			"}" => -105,
			"]" => -105
		}
	},
	{#State 246
		ACTIONS => {
			";" => 292
		}
	},
	{#State 247
		ACTIONS => {
			";" => 293
		}
	},
	{#State 248
		ACTIONS => {
			"]" => -182,
			'OP21_LIST_COMMA' => -182,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NE' => 152,
			")" => -182,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP23_LOGICAL_AND' => 159,
			";" => -182,
			'OP09_BITWISE_SHIFT' => 150,
			'OP15_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156
		}
	},
	{#State 249
		DEFAULT => -116
	},
	{#State 250
		ACTIONS => {
			'WORD' => 294,
			")" => 295
		}
	},
	{#State 251
		DEFAULT => -180
	},
	{#State 252
		ACTIONS => {
			"]" => -178,
			";" => -178,
			'OP21_LIST_COMMA' => 297,
			")" => -178
		},
		GOTOS => {
			'PAREN-43' => 296
		}
	},
	{#State 253
		DEFAULT => -137
	},
	{#State 254
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99,
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 166,
			"undef" => 105,
			'MY' => 127
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'TypeInner' => 164,
			'ListElement' => 167,
			'SubExpression' => 168,
			'Operator' => 90,
			'HashReference' => 109,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Expression' => 137,
			'ListElements' => 298
		}
	},
	{#State 255
		ACTIONS => {
			'OP21_LIST_COMMA' => 299
		}
	},
	{#State 256
		DEFAULT => -126
	},
	{#State 257
		ACTIONS => {
			'FHREF_SYMBOL' => 300
		}
	},
	{#State 258
		ACTIONS => {
			";" => 301
		}
	},
	{#State 259
		ACTIONS => {
			'TYPE_INTEGER' => 61,
			'WORD' => 60
		},
		GOTOS => {
			'Type' => 302
		}
	},
	{#State 260
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'LBRACKET' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'SubExpression' => 303,
			'Operator' => 90,
			'HashReference' => 109,
			'Variable' => 135,
			'ArrayReference' => 72,
			'Expression' => 137,
			'HashDereference' => 87,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113
		}
	},
	{#State 261
		ACTIONS => {
			'TYPE_INTEGER' => 304
		}
	},
	{#State 262
		ACTIONS => {
			"}" => 306,
			'OP21_LIST_COMMA' => 307
		},
		GOTOS => {
			'PAREN-49' => 305
		}
	},
	{#State 263
		ACTIONS => {
			'MY' => 127,
			"undef" => -192,
			'VARIABLE_SYMBOL' => -192,
			'LPAREN' => -192,
			'OP01_OPEN' => -192,
			'WORD_UPPERCASE' => -192,
			'LITERAL_STRING' => -192,
			'OP03_MATH_INC_DEC' => -192,
			'OP22_LOGICAL_NEG' => -192,
			'OP01_NAMED' => -192,
			'LITERAL_NUMBER' => -192,
			"\@{" => -192,
			'OP05_LOGICAL_NEG' => -192,
			'OP01_CLOSE' => -192,
			'LBRACE' => -192,
			'WORD' => -192,
			'LBRACKET' => -192,
			'OP10_NAMED_UNARY' => -192,
			'WORD_SCOPED' => -192,
			"%{" => -192,
			'OP05_MATH_NEG_LPAREN' => -192
		},
		GOTOS => {
			'OPTIONAL-48' => 309,
			'TypeInner' => 308
		}
	},
	{#State 264
		DEFAULT => -119
	},
	{#State 265
		ACTIONS => {
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			")" => 310,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => 159,
			'OP13_BITWISE_AND' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP15_LOGICAL_AND' => 149,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154
		}
	},
	{#State 266
		DEFAULT => -186
	},
	{#State 267
		DEFAULT => -87
	},
	{#State 268
		ACTIONS => {
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LITERAL_STRING' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'WORD' => 312,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 99
		},
		GOTOS => {
			'HashDereference' => 87,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'Literal' => 114,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135,
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 311
		}
	},
	{#State 269
		ACTIONS => {
			'LPAREN' => 83,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 117,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LBRACKET' => 99
		},
		GOTOS => {
			'HashDereference' => 87,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114,
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'HashReference' => 109,
			'SubExpression' => 313,
			'Operator' => 90
		}
	},
	{#State 270
		DEFAULT => -164
	},
	{#State 271
		ACTIONS => {
			";" => 314
		}
	},
	{#State 272
		ACTIONS => {
			";" => 316,
			'OP19_VARIABLE_ASSIGN' => 315
		}
	},
	{#State 273
		DEFAULT => -120
	},
	{#State 274
		ACTIONS => {
			")" => 317
		}
	},
	{#State 275
		DEFAULT => -128
	},
	{#State 276
		ACTIONS => {
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117,
			"undef" => 105,
			'MY' => 127,
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 166,
			'LPAREN' => 83,
			'LBRACKET' => 99,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26
		},
		GOTOS => {
			'TypeInner' => 164,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'Literal' => 114,
			'HashDereference' => 87,
			'Expression' => 137,
			'ListElements' => 318,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Operator' => 90,
			'HashReference' => 109,
			'SubExpression' => 168,
			'ListElement' => 167
		}
	},
	{#State 277
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 319
		}
	},
	{#State 278
		DEFAULT => -55
	},
	{#State 279
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 320
		}
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
			'VARIABLE_SYMBOL' => 322
		}
	},
	{#State 283
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP01_NAMED_VOID_SCOLON' => 102,
			"if" => 97,
			'LBRACKET' => 99,
			'OP19_LOOP_CONTROL' => 93,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 115,
			'OP22_LOGICAL_NEG' => 116,
			"}" => 323,
			"while" => -142,
			"foreach" => -142,
			'VARIABLE_SYMBOL' => 104,
			'MY' => 108,
			"undef" => 105,
			"%{" => 74,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'WORD' => 26,
			"\@{" => 71,
			"for" => -142,
			'LITERAL_NUMBER' => 73,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'WORD_UPPERCASE' => 84,
			'OP01_OPEN' => 85,
			'OP01_NAMED_VOID' => 81,
			'OP01_PRINT' => 80,
			'LPAREN' => 83
		},
		GOTOS => {
			'HashDereference' => 87,
			'Statement' => 112,
			'WordScoped' => 113,
			'Literal' => 114,
			'VariableModification' => 110,
			'Operation' => 324,
			'OperatorVoid' => 111,
			'LoopLabel' => 78,
			'Variable' => 77,
			'Expression' => 103,
			'SubExpression' => 79,
			'Conditional' => 107,
			'HashReference' => 109,
			'PAREN-35' => 106,
			'ArrayDereference' => 98,
			'VariableDeclaration' => 95,
			'OPTIONAL-36' => 91,
			'ArrayReference' => 72,
			'Operator' => 90
		}
	},
	{#State 284
		DEFAULT => -190
	},
	{#State 285
		ACTIONS => {
			'WORD' => 325
		}
	},
	{#State 286
		DEFAULT => -205
	},
	{#State 287
		DEFAULT => -122
	},
	{#State 288
		ACTIONS => {
			")" => 326
		}
	},
	{#State 289
		DEFAULT => -174
	},
	{#State 290
		DEFAULT => -173
	},
	{#State 291
		ACTIONS => {
			'LITERAL_NUMBER' => 73,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 117
		},
		GOTOS => {
			'VariableOrLiteral' => 327,
			'Literal' => 235,
			'Variable' => 237
		}
	},
	{#State 292
		DEFAULT => -112
	},
	{#State 293
		DEFAULT => -113
	},
	{#State 294
		DEFAULT => -179
	},
	{#State 295
		DEFAULT => -183
	},
	{#State 296
		DEFAULT => -176
	},
	{#State 297
		ACTIONS => {
			'WORD' => 26,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 99,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			'OP01_QW' => 166,
			"undef" => 105,
			'MY' => 127,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85
		},
		GOTOS => {
			'HashDereference' => 87,
			'TypeInner' => 164,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135,
			'ListElement' => 328,
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 168
		}
	},
	{#State 298
		ACTIONS => {
			")" => 329
		}
	},
	{#State 299
		ACTIONS => {
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LBRACKET' => 99,
			'LPAREN' => 83,
			"undef" => 105,
			'MY' => 127,
			'OP01_QW' => 166,
			'VARIABLE_SYMBOL' => 104,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 117,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133
		},
		GOTOS => {
			'Operator' => 90,
			'SubExpression' => 168,
			'ListElement' => 167,
			'HashReference' => 109,
			'Expression' => 137,
			'ListElements' => 330,
			'ArrayReference' => 72,
			'Variable' => 135,
			'HashDereference' => 87,
			'Literal' => 114,
			'TypeInner' => 164,
			'ArrayDereference' => 98,
			'WordScoped' => 113
		}
	},
	{#State 300
		ACTIONS => {
			'OP21_LIST_COMMA' => 331
		}
	},
	{#State 301
		DEFAULT => -115
	},
	{#State 302
		ACTIONS => {
			'VARIABLE_SYMBOL' => 332
		}
	},
	{#State 303
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 152,
			")" => 333,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144,
			'OP23_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 150,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP15_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158
		}
	},
	{#State 304
		ACTIONS => {
			'VARIABLE_SYMBOL' => 334
		}
	},
	{#State 305
		DEFAULT => -198
	},
	{#State 306
		DEFAULT => -200
	},
	{#State 307
		ACTIONS => {
			'LITERAL_STRING' => 117,
			"%{" => 74,
			'WORD' => 188,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 73
		},
		GOTOS => {
			'HashDereference' => 189,
			'HashEntry' => 335,
			'VariableOrLiteralOrWord' => 190,
			'Literal' => 185,
			'Variable' => 191
		}
	},
	{#State 308
		DEFAULT => -191
	},
	{#State 309
		ACTIONS => {
			'LPAREN' => 83,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 117,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LBRACKET' => 99
		},
		GOTOS => {
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 336,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Expression' => 137,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'HashDereference' => 87
		}
	},
	{#State 310
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 337
		}
	},
	{#State 311
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			"}" => 339,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP15_LOGICAL_AND' => 149,
			'OP13_BITWISE_AND' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154,
			'OP23_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 150
		}
	},
	{#State 312
		ACTIONS => {
			"}" => 340,
			'OP02_METHOD_THINARROW_NEW' => -206,
			'LPAREN' => -206
		}
	},
	{#State 313
		ACTIONS => {
			"]" => 341,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP23_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 150,
			'OP15_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155
		}
	},
	{#State 314
		DEFAULT => -172
	},
	{#State 315
		ACTIONS => {
			'LPAREN' => 83,
			"undef" => 105,
			'STDIN' => 226,
			'VARIABLE_SYMBOL' => 104,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_STRING' => 117,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'LBRACKET' => 99
		},
		GOTOS => {
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 224,
			'HashDereference' => 87,
			'SubExpressionOrStdin' => 342,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'Literal' => 114
		}
	},
	{#State 316
		DEFAULT => -170
	},
	{#State 317
		DEFAULT => -125
	},
	{#State 318
		ACTIONS => {
			";" => 343
		}
	},
	{#State 319
		ACTIONS => {
			'LITERAL_NUMBER' => 344,
			"our" => 346
		},
		GOTOS => {
			'MethodOrSubroutine' => 345,
			'Subroutine' => 348,
			'Method' => 347
		}
	},
	{#State 320
		ACTIONS => {
			'LBRACE' => 349
		}
	},
	{#State 321
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 350
		}
	},
	{#State 322
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 351
		}
	},
	{#State 323
		ACTIONS => {
			";" => 352
		}
	},
	{#State 324
		DEFAULT => -44
	},
	{#State 325
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 353
		}
	},
	{#State 326
		DEFAULT => -127
	},
	{#State 327
		DEFAULT => -103
	},
	{#State 328
		DEFAULT => -175
	},
	{#State 329
		DEFAULT => -78
	},
	{#State 330
		ACTIONS => {
			")" => 354
		}
	},
	{#State 331
		ACTIONS => {
			'LITERAL_STRING' => 355
		}
	},
	{#State 332
		ACTIONS => {
			'LPAREN' => 356
		}
	},
	{#State 333
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 357
		}
	},
	{#State 334
		ACTIONS => {
			'LPAREN' => 358
		}
	},
	{#State 335
		DEFAULT => -197
	},
	{#State 336
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP23_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144,
			'OP12_COMPARE_EQ_NE' => 152,
			"}" => -193,
			'OP21_LIST_COMMA' => -193,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 337
		DEFAULT => -150,
		GOTOS => {
			'STAR-38' => 359
		}
	},
	{#State 338
		ACTIONS => {
			'WORD' => 26,
			"\@{" => 71,
			"for" => -142,
			'LITERAL_NUMBER' => 73,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP01_NAMED_VOID' => 81,
			'OP01_PRINT' => 80,
			'LPAREN' => 83,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'WORD_UPPERCASE' => 84,
			'OP01_OPEN' => 85,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP19_LOOP_CONTROL' => 93,
			'OP05_LOGICAL_NEG' => 89,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_NAMED_VOID_SCOLON' => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			"if" => 97,
			'LBRACKET' => 99,
			"foreach" => -142,
			"while" => -142,
			'VARIABLE_SYMBOL' => 104,
			'MY' => 108,
			"undef" => 105,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 115,
			'OP22_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'ArrayReference' => 72,
			'Operator' => 90,
			'VariableDeclaration' => 95,
			'OPTIONAL-36' => 91,
			'ArrayDereference' => 98,
			'Variable' => 77,
			'LoopLabel' => 78,
			'Expression' => 103,
			'Conditional' => 107,
			'SubExpression' => 79,
			'HashReference' => 109,
			'PAREN-35' => 106,
			'VariableModification' => 110,
			'Operation' => 361,
			'OperatorVoid' => 111,
			'WordScoped' => 113,
			'Statement' => 112,
			'Literal' => 114,
			'HashDereference' => 87,
			'PLUS-41' => 360
		}
	},
	{#State 339
		DEFAULT => -168
	},
	{#State 340
		DEFAULT => -169
	},
	{#State 341
		DEFAULT => -167
	},
	{#State 342
		ACTIONS => {
			";" => 362
		}
	},
	{#State 343
		DEFAULT => -117
	},
	{#State 344
		ACTIONS => {
			";" => 363
		}
	},
	{#State 345
		DEFAULT => -57
	},
	{#State 346
		ACTIONS => {
			'WORD' => 60,
			'TYPE_METHOD' => 364,
			'TYPE_INTEGER' => 61
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 347
		DEFAULT => -74
	},
	{#State 348
		DEFAULT => -75
	},
	{#State 349
		ACTIONS => {
			"}" => 365,
			"%{" => 74,
			'WORD' => 368
		},
		GOTOS => {
			'HashDereference' => 367,
			'HashEntryTyped' => 366
		}
	},
	{#State 350
		DEFAULT => -212
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 369,
			")" => 371
		},
		GOTOS => {
			'PAREN-18' => 370
		}
	},
	{#State 352
		DEFAULT => -46
	},
	{#State 353
		DEFAULT => -211
	},
	{#State 354
		DEFAULT => -80
	},
	{#State 355
		ACTIONS => {
			'OP21_LIST_COMMA' => 372
		}
	},
	{#State 356
		ACTIONS => {
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 73,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'LBRACKET' => 99,
			'LPAREN' => 83,
			'OP01_QW' => 166,
			'VARIABLE_SYMBOL' => 104,
			'MY' => 127,
			"undef" => 105,
			'LITERAL_STRING' => 117,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85
		},
		GOTOS => {
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 168,
			'ListElement' => 167,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Expression' => 137,
			'ListElements' => 373,
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'TypeInner' => 164
		}
	},
	{#State 357
		DEFAULT => -160
	},
	{#State 358
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'LBRACKET' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117
		},
		GOTOS => {
			'Expression' => 137,
			'Variable' => 135,
			'ArrayReference' => 72,
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 374,
			'HashDereference' => 87,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114
		}
	},
	{#State 359
		ACTIONS => {
			'LPAREN' => -153,
			'OP01_PRINT' => -153,
			'OP01_NAMED_VOID' => -153,
			'OP01_NAMED_VOID_LPAREN' => -153,
			'OP03_MATH_INC_DEC' => -153,
			'OP01_OPEN' => -153,
			'WORD_UPPERCASE' => -153,
			'WORD' => -153,
			'LITERAL_NUMBER' => -153,
			"\@{" => -153,
			"for" => -153,
			'WORD_SCOPED' => -153,
			'OP10_NAMED_UNARY' => -153,
			"%{" => -153,
			"while" => -153,
			"foreach" => -153,
			'MY' => -153,
			"undef" => -153,
			'VARIABLE_SYMBOL' => -153,
			'LITERAL_STRING' => -153,
			'OP22_LOGICAL_NEG' => -153,
			'OP01_NAMED' => -153,
			"}" => -153,
			"else" => 379,
			'OP19_LOOP_CONTROL' => -153,
			'OP01_CLOSE' => -153,
			'LBRACE' => -153,
			"elsif" => 377,
			'OP05_LOGICAL_NEG' => -153,
			'OP01_NAMED_VOID_SCOLON' => -153,
			'OP19_LOOP_CONTROL_SCOLON' => -153,
			'OP05_MATH_NEG_LPAREN' => -153,
			'' => -153,
			'LBRACKET' => -153,
			"if" => -153
		},
		GOTOS => {
			'PAREN-39' => 376,
			'PAREN-37' => 378,
			'OPTIONAL-40' => 375
		}
	},
	{#State 360
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 93,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_NAMED_VOID_SCOLON' => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			"if" => 97,
			'LBRACKET' => 99,
			"foreach" => -142,
			"while" => -142,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'MY' => 108,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 115,
			'LITERAL_STRING' => 117,
			"}" => 381,
			'WORD' => 26,
			"for" => -142,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'OP01_NAMED_VOID' => 81,
			'OP01_PRINT' => 80,
			'LPAREN' => 83,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'WORD_UPPERCASE' => 84,
			'OP01_OPEN' => 85
		},
		GOTOS => {
			'OperatorVoid' => 111,
			'Operation' => 380,
			'VariableModification' => 110,
			'PAREN-35' => 106,
			'Conditional' => 107,
			'HashReference' => 109,
			'SubExpression' => 79,
			'Expression' => 103,
			'Variable' => 77,
			'LoopLabel' => 78,
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'Statement' => 112,
			'OPTIONAL-36' => 91,
			'VariableDeclaration' => 95,
			'Operator' => 90,
			'ArrayReference' => 72,
			'ArrayDereference' => 98
		}
	},
	{#State 361
		DEFAULT => -162
	},
	{#State 362
		DEFAULT => -171
	},
	{#State 363
		DEFAULT => -59
	},
	{#State 364
		ACTIONS => {
			'VARIABLE_SYMBOL' => 382
		}
	},
	{#State 365
		ACTIONS => {
			";" => 383
		}
	},
	{#State 366
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 384
		}
	},
	{#State 367
		DEFAULT => -196
	},
	{#State 368
		ACTIONS => {
			'OP20_HASH_FATARROW' => 385
		}
	},
	{#State 369
		ACTIONS => {
			'MY' => 386
		}
	},
	{#State 370
		DEFAULT => -48
	},
	{#State 371
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 387
		}
	},
	{#State 372
		ACTIONS => {
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			'OP05_LOGICAL_NEG' => 89,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			"%{" => 74,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99,
			'LPAREN' => 83,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 133
		},
		GOTOS => {
			'HashDereference' => 87,
			'Literal' => 114,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'HashReference' => 109,
			'Operator' => 90,
			'SubExpression' => 388,
			'Expression' => 137,
			'ArrayReference' => 72,
			'Variable' => 135
		}
	},
	{#State 373
		ACTIONS => {
			")" => 389
		}
	},
	{#State 374
		ACTIONS => {
			'OP17_LIST_RANGE' => 390,
			'OP11_COMPARE_LT_GT' => 145,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP04_MATH_POW' => 146,
			'OP06_REGEX_MATCH' => 147,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 149,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => 159
		}
	},
	{#State 375
		DEFAULT => -154
	},
	{#State 376
		DEFAULT => -152
	},
	{#State 377
		ACTIONS => {
			'LPAREN' => 391
		}
	},
	{#State 378
		DEFAULT => -149
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 380
		DEFAULT => -161
	},
	{#State 381
		DEFAULT => -163
	},
	{#State 382
		ACTIONS => {
			"= sub {" => 393
		}
	},
	{#State 383
		DEFAULT => -64
	},
	{#State 384
		ACTIONS => {
			'OP21_LIST_COMMA' => 395,
			"}" => 394
		},
		GOTOS => {
			'PAREN-24' => 396
		}
	},
	{#State 385
		ACTIONS => {
			'MY' => 127
		},
		GOTOS => {
			'TypeInner' => 397
		}
	},
	{#State 386
		ACTIONS => {
			'TYPE_INTEGER' => 61,
			'WORD' => 60
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
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => -81,
			";" => -81,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP15_LOGICAL_AND' => 149,
			")" => -81,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP21_LIST_COMMA' => -81,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			"]" => -81,
			"}" => -81,
			'OP07_STRING_REPEAT' => 143,
			'OP18_TERNARY' => 151,
			'OP17_LIST_RANGE' => 144,
			'OP11_COMPARE_LT_GT' => 145
		}
	},
	{#State 389
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 400
		}
	},
	{#State 390
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'LBRACKET' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 76,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_STRING' => 117
		},
		GOTOS => {
			'HashDereference' => 87,
			'WordScoped' => 113,
			'ArrayDereference' => 98,
			'Literal' => 114,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Expression' => 137,
			'SubExpression' => 401,
			'Operator' => 90,
			'HashReference' => 109
		}
	},
	{#State 391
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'LBRACKET' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105,
			'LPAREN' => 83,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 86,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 117
		},
		GOTOS => {
			'Variable' => 135,
			'ArrayReference' => 72,
			'Expression' => 137,
			'SubExpression' => 402,
			'Operator' => 90,
			'HashReference' => 109,
			'HashDereference' => 87,
			'ArrayDereference' => 98,
			'WordScoped' => 113,
			'Literal' => 114
		}
	},
	{#State 392
		DEFAULT => -151
	},
	{#State 393
		ACTIONS => {
			'VARIABLE_SYMBOL' => -66,
			"undef" => -66,
			'MY' => -66,
			"while" => -66,
			"foreach" => -66,
			"}" => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP01_NAMED' => -66,
			'LITERAL_STRING' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP01_CLOSE' => -66,
			'LBRACE' => -66,
			'LPAREN_MY' => 405,
			"if" => -66,
			'LBRACKET' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP01_NAMED_VOID' => -66,
			'OP01_PRINT' => -66,
			'LPAREN' => -66,
			'WORD_UPPERCASE' => -66,
			'OP01_OPEN' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP01_NAMED_VOID_LPAREN' => -66,
			"for" => -66,
			"\@{" => -66,
			'LITERAL_NUMBER' => -66,
			'WORD' => -66,
			"%{" => -66,
			'WORD_SCOPED' => -66,
			'OP10_NAMED_UNARY' => -66
		},
		GOTOS => {
			'MethodArguments' => 404,
			'OPTIONAL-26' => 403
		}
	},
	{#State 394
		ACTIONS => {
			";" => 406
		}
	},
	{#State 395
		ACTIONS => {
			"%{" => 74,
			'WORD' => 368
		},
		GOTOS => {
			'HashDereference' => 367,
			'HashEntryTyped' => 407
		}
	},
	{#State 396
		DEFAULT => -61
	},
	{#State 397
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 74,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 99,
			'WORD' => 26,
			'LBRACE' => 92,
			'OP01_CLOSE' => 94,
			'OP05_LOGICAL_NEG' => 89,
			"\@{" => 71,
			'LITERAL_NUMBER' => 73,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 117,
			'WORD_UPPERCASE' => 133,
			'OP01_OPEN' => 85,
			'LPAREN' => 83,
			'VARIABLE_SYMBOL' => 104,
			"undef" => 105
		},
		GOTOS => {
			'SubExpression' => 408,
			'HashReference' => 109,
			'Operator' => 90,
			'ArrayReference' => 72,
			'Variable' => 135,
			'Expression' => 137,
			'HashDereference' => 87,
			'Literal' => 114,
			'WordScoped' => 113,
			'ArrayDereference' => 98
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
			'OP15_LOGICAL_AND' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP16_LOGICAL_OR' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP23_LOGICAL_AND' => -102,
			'OP09_BITWISE_SHIFT' => 150,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -102,
			'OP07_STRING_REPEAT' => 143,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NE' => 152,
			")" => 410
		}
	},
	{#State 402
		ACTIONS => {
			'OP23_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 150,
			'OP16_LOGICAL_OR' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 149,
			'OP08_STRING_CAT' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NE' => 152,
			")" => 411,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144
		}
	},
	{#State 403
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 412
		}
	},
	{#State 404
		DEFAULT => -65
	},
	{#State 405
		ACTIONS => {
			'TYPE_SELF' => 413
		}
	},
	{#State 406
		DEFAULT => -63
	},
	{#State 407
		DEFAULT => -60
	},
	{#State 408
		ACTIONS => {
			'OP15_LOGICAL_AND' => 149,
			'OP13_BITWISE_AND' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP16_LOGICAL_OR' => 154,
			'OP23_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 150,
			'OP11_COMPARE_LT_GT' => 145,
			'OP17_LIST_RANGE' => 144,
			'OP18_TERNARY' => 151,
			'OP07_STRING_REPEAT' => 143,
			"}" => -195,
			'OP06_REGEX_MATCH' => 147,
			'OP04_MATH_POW' => 146,
			'OP21_LIST_COMMA' => -195,
			'OP12_COMPARE_EQ_NE' => 152
		}
	},
	{#State 409
		DEFAULT => -47
	},
	{#State 410
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 414
		}
	},
	{#State 411
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 415
		}
	},
	{#State 412
		ACTIONS => {
			'LPAREN' => 83,
			'OP01_NAMED_VOID' => 81,
			'OP01_PRINT' => 80,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 85,
			'WORD_UPPERCASE' => 84,
			'WORD' => 26,
			'LITERAL_NUMBER' => 73,
			"\@{" => 71,
			"for" => -142,
			'OP10_NAMED_UNARY' => 76,
			'WORD_SCOPED' => 24,
			"%{" => 74,
			"foreach" => -142,
			"while" => -142,
			'MY' => 108,
			"undef" => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_STRING' => 117,
			'OP01_NAMED' => 115,
			'OP22_LOGICAL_NEG' => 116,
			"}" => 416,
			'OP19_LOOP_CONTROL' => 93,
			'OP01_CLOSE' => 94,
			'LBRACE' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP01_NAMED_VOID_SCOLON' => 102,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LBRACKET' => 99,
			"if" => 97
		},
		GOTOS => {
			'ArrayReference' => 72,
			'Operator' => 90,
			'OPTIONAL-36' => 91,
			'VariableDeclaration' => 95,
			'ArrayDereference' => 98,
			'Expression' => 103,
			'LoopLabel' => 78,
			'Variable' => 77,
			'PAREN-35' => 106,
			'SubExpression' => 79,
			'Conditional' => 107,
			'HashReference' => 109,
			'Operation' => 417,
			'VariableModification' => 110,
			'OperatorVoid' => 111,
			'Statement' => 112,
			'WordScoped' => 113,
			'Literal' => 114,
			'HashDereference' => 87
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
			'OP21_LIST_COMMA' => 422,
			")" => 420
		},
		GOTOS => {
			'PAREN-28' => 421
		}
	},
	{#State 419
		DEFAULT => -69
	},
	{#State 420
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 423
		}
	},
	{#State 421
		DEFAULT => -71
	},
	{#State 422
		ACTIONS => {
			'MY' => 424
		}
	},
	{#State 423
		ACTIONS => {
			"\@_;" => 425
		}
	},
	{#State 424
		ACTIONS => {
			'WORD' => 60,
			'TYPE_INTEGER' => 61
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
