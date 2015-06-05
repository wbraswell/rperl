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
    our $VERSION = 0.001_000;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|\=\ sub\ \{|\$TYPED_|foreach|while|elsif|undef|else|use|for|\@_\;|our|\%\{|if|\@\{|\}|\]|\;|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer\s+)/gc and return ('TYPE_INTEGER', $1);
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
      /\G(return;|exit;|die;|croak;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(return\(|croak\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(return|exit|die|croak)\s/gc and return ('OP01_NAMED_VOID', $1);
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
			'SHEBANG' => 2,
			"## no critic qw(" => 7,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 9,
			'ModuleHeader' => 5,
			'CompileUnit' => 1,
			'Program' => 8,
			'Critic' => 4,
			'PLUS-2' => 3,
			'PAREN-1' => 6
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'OPTIONAL-3' => 12,
			'Critic' => 11
		}
	},
	{#State 3
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'OPTIONAL-9' => 9,
			'PAREN-1' => 13,
			'Critic' => 4
		}
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		ACTIONS => {
			"use" => -25,
			"## no critic qw(" => -25,
			"our" => -25,
			"use parent qw(" => 15,
			"use constant" => -25
		},
		GOTOS => {
			'STAR-10' => 14,
			'Module' => 18,
			'Package' => 17,
			'Class' => 16
		}
	},
	{#State 6
		DEFAULT => -3
	},
	{#State 7
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 8
		DEFAULT => -4
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
		ACTIONS => {
			"our" => -27,
			"## no critic qw(" => 7,
			"use" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'Critic' => 25,
			'STAR-11' => 24
		}
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 16
		DEFAULT => -23
	},
	{#State 17
		DEFAULT => -22
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		ACTIONS => {
			")" => 30,
			'WORD' => 29
		}
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 31
		}
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
			"our" => -29,
			"use" => 34
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 36
		}
	},
	{#State 25
		DEFAULT => -24
	},
	{#State 26
		DEFAULT => -206
	},
	{#State 27
		DEFAULT => -207
	},
	{#State 28
		ACTIONS => {
			")" => 37
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
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -11,
			"## no critic qw(" => 7,
			'OP19_LOOP_CONTROL' => -11,
			'OP10_NAMED_UNARY' => -11,
			"foreach" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACKET' => -11,
			'OP01_PRINT' => -11,
			"\@{" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED' => -11,
			"our" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			'LITERAL_STRING' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"while" => -11,
			'LPAREN' => -11,
			'WORD' => -11,
			"if" => -11,
			'OP01_CLOSE' => -11,
			"use constant" => -11,
			'LBRACE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'WORD_SCOPED' => -11,
			'OP01_OPEN' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'LITERAL_NUMBER' => -11,
			"use" => -11,
			'MY' => -11,
			"%{" => -11,
			"undef" => -11,
			'OP01_NAMED_VOID' => -11,
			'VARIABLE_SYMBOL' => -11
		},
		GOTOS => {
			'Critic' => 41,
			'STAR-5' => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 42
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			"use constant" => 47,
			"our" => 44
		},
		GOTOS => {
			'PLUS-13' => 46,
			'Constant' => 43,
			'Subroutine' => 45
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
			'OP22_LOGICAL_NEG' => -13,
			"foreach" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"\@{" => -13,
			'OP01_PRINT' => -13,
			'OP01_NAMED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACKET' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'WORD' => -13,
			"if" => -13,
			'LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'WORD_SCOPED' => -13,
			'LBRACE' => -13,
			'OP01_CLOSE' => -13,
			"use constant" => -13,
			"for" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"our" => -13,
			"while" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'LITERAL_STRING' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID' => -13,
			'VARIABLE_SYMBOL' => -13,
			"undef" => -13,
			'MY' => -13,
			"use" => 34,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_OPEN' => -13,
			"%{" => -13
		},
		GOTOS => {
			'Include' => 52,
			'STAR-6' => 51
		}
	},
	{#State 41
		DEFAULT => -8
	},
	{#State 42
		ACTIONS => {
			";" => 53,
			'OP01_QW' => 54
		}
	},
	{#State 43
		DEFAULT => -28
	},
	{#State 44
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 45
		DEFAULT => -31
	},
	{#State 46
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 59
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 47
		ACTIONS => {
			'WORD_UPPERCASE' => 60
		}
	},
	{#State 48
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 61
		}
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
		ACTIONS => {
			'LBRACKET' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_PRINT' => -15,
			"\@{" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP10_NAMED_UNARY' => -15,
			"foreach" => -15,
			'OP22_LOGICAL_NEG' => -15,
			"%{" => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_OPEN' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'MY' => -15,
			"undef" => -15,
			'OP01_NAMED_VOID' => -15,
			'VARIABLE_SYMBOL' => -15,
			'WORD_UPPERCASE' => -15,
			"while" => -15,
			'LITERAL_STRING' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"for" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"our" => -15,
			"use constant" => 47,
			'OP01_CLOSE' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'WORD_SCOPED' => -15,
			'LBRACE' => -15,
			'LPAREN' => -15,
			'WORD' => -15,
			"if" => -15
		},
		GOTOS => {
			'Constant' => 63,
			'STAR-7' => 64
		}
	},
	{#State 52
		DEFAULT => -10
	},
	{#State 53
		DEFAULT => -39
	},
	{#State 54
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 55
		DEFAULT => -210
	},
	{#State 56
		DEFAULT => -209
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		}
	},
	{#State 58
		DEFAULT => -30
	},
	{#State 59
		ACTIONS => {
			";" => 68
		}
	},
	{#State 60
		ACTIONS => {
			'OP20_HASH_FATARROW' => 69
		}
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
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			'OP01_NAMED_VOID' => 103,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			'MY' => 95,
			'OP01_NAMED_VOID_LPAREN' => 92,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			"%{" => 97,
			"if" => 111,
			'WORD' => 26,
			'LPAREN' => 110,
			'LBRACE' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 114,
			'OP01_NAMED_VOID_SCOLON' => 106,
			"for" => -142,
			"our" => 44,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			"while" => -142,
			'WORD_UPPERCASE' => 107,
			"\@{" => 79,
			'OP01_PRINT' => 78,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 81,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP22_LOGICAL_NEG' => 87,
			'OP10_NAMED_UNARY' => 91,
			"foreach" => -142,
			'OP19_LOOP_CONTROL' => 88
		},
		GOTOS => {
			'Expression' => 99,
			'Variable' => 104,
			'Conditional' => 102,
			'PLUS-8' => 82,
			'ArrayReference' => 71,
			'Operator' => 73,
			'Subroutine' => 74,
			'Operation' => 96,
			'PAREN-35' => 76,
			'HashReference' => 98,
			'OPTIONAL-36' => 77,
			'OperatorVoid' => 89,
			'WordScoped' => 113,
			'VariableModification' => 112,
			'VariableDeclaration' => 116,
			'Statement' => 90,
			'SubExpression' => 83,
			'LoopLabel' => 105,
			'Literal' => 84,
			'HashDereference' => 85,
			'ArrayDereference' => 86
		}
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			")" => 119,
			'WORD' => 118
		}
	},
	{#State 67
		ACTIONS => {
			"= sub {" => 120
		}
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			'MY' => 121
		},
		GOTOS => {
			'TypeInnerConstant' => 122
		}
	},
	{#State 70
		ACTIONS => {
			"## no critic qw(" => 7,
			"use" => -54,
			"use constant" => -54,
			"our hashref \$properties" => -54
		},
		GOTOS => {
			'STAR-21' => 124,
			'Critic' => 123
		}
	},
	{#State 71
		DEFAULT => -133
	},
	{#State 72
		ACTIONS => {
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			"%{" => 97,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79
		},
		GOTOS => {
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Literal' => 84,
			'SubExpression' => 128,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73,
			'WordScoped' => 113,
			'Variable' => 126,
			'Expression' => 127
		}
	},
	{#State 73
		DEFAULT => -124
	},
	{#State 74
		DEFAULT => -14
	},
	{#State 75
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			"]" => -185,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			"\@{" => 79,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'MY' => 133,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			"%{" => 97,
			'OP01_QW' => 131
		},
		GOTOS => {
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 134,
			'Operator' => 73,
			'HashDereference' => 85,
			'ListElement' => 132,
			'ArrayDereference' => 86,
			'TypeInner' => 136,
			'HashReference' => 98,
			'Expression' => 127,
			'ListElements' => 135,
			'WordScoped' => 113,
			'OPTIONAL-46' => 130,
			'Variable' => 126
		}
	},
	{#State 76
		DEFAULT => -141
	},
	{#State 77
		ACTIONS => {
			"foreach" => 142,
			"while" => 140,
			"for" => 139
		},
		GOTOS => {
			'LoopForEach' => 141,
			'Loop' => 138,
			'LoopFor' => 137,
			'LoopWhile' => 143
		}
	},
	{#State 78
		ACTIONS => {
			"%{" => -109,
			'FHREF_SYMBOL_BRACES' => 147,
			'OP01_QW' => -109,
			'OP01_OPEN' => -109,
			'LITERAL_NUMBER' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'MY' => -109,
			'LBRACKET' => -109,
			'OP03_MATH_INC_DEC' => -109,
			"undef" => -109,
			'OP01_NAMED' => -109,
			'VARIABLE_SYMBOL' => -109,
			"\@{" => -109,
			'WORD_UPPERCASE' => -109,
			'LITERAL_STRING' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'STDOUT_STDERR' => 146,
			'OP01_CLOSE' => -109,
			'OP10_NAMED_UNARY' => -109,
			'LBRACE' => -109,
			'WORD_SCOPED' => -109,
			'LPAREN' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'WORD' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 145,
			'PAREN-30' => 144
		}
	},
	{#State 79
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			'MY' => 133,
			'LBRACKET' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 149,
			'Variable' => 150,
			'TypeInner' => 148
		}
	},
	{#State 80
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Variable' => 151
		}
	},
	{#State 81
		ACTIONS => {
			"%{" => 97,
			'OP01_QW' => 131,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'MY' => 133,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26
		},
		GOTOS => {
			'ArrayReference' => 71,
			'SubExpression' => 153,
			'Literal' => 84,
			'Operator' => 73,
			'HashDereference' => 85,
			'ListElement' => 152,
			'ArrayDereference' => 86,
			'TypeInner' => 136,
			'HashReference' => 98,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 82
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			"if" => 111,
			'' => -18,
			'LPAREN' => 110,
			"while" => -142,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 107,
			"for" => -142,
			'OP01_NAMED_VOID_SCOLON' => 106,
			'OP01_NAMED_VOID' => 103,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			"%{" => 97,
			'MY' => 95,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_VOID_LPAREN' => 92,
			'OP01_OPEN' => 93,
			"foreach" => -142,
			'OP10_NAMED_UNARY' => 91,
			'OP19_LOOP_CONTROL' => 88,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_NAMED' => 81,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 79,
			'OP01_PRINT' => 78,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72
		},
		GOTOS => {
			'OperatorVoid' => 89,
			'VariableModification' => 112,
			'WordScoped' => 113,
			'Statement' => 90,
			'VariableDeclaration' => 116,
			'ArrayDereference' => 86,
			'Literal' => 84,
			'LoopLabel' => 105,
			'SubExpression' => 83,
			'HashDereference' => 85,
			'Conditional' => 102,
			'Variable' => 104,
			'Expression' => 99,
			'Operation' => 154,
			'PAREN-35' => 76,
			'HashReference' => 98,
			'OPTIONAL-36' => 77,
			'ArrayReference' => 71,
			'Operator' => 73
		}
	},
	{#State 83
		ACTIONS => {
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP04_MATH_POW' => 163,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 159,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169
		}
	},
	{#State 84
		DEFAULT => -131
	},
	{#State 85
		DEFAULT => -136
	},
	{#State 86
		DEFAULT => -134
	},
	{#State 87
		ACTIONS => {
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			"%{" => 97,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125
		},
		GOTOS => {
			'HashDereference' => 85,
			'Operator' => 73,
			'Literal' => 84,
			'SubExpression' => 172,
			'ArrayReference' => 71,
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113
		}
	},
	{#State 88
		ACTIONS => {
			'WORD_UPPERCASE' => 173
		},
		GOTOS => {
			'LoopLabel' => 174
		}
	},
	{#State 89
		DEFAULT => -145
	},
	{#State 90
		DEFAULT => -77
	},
	{#State 91
		ACTIONS => {
			'OP06_REGEX_MATCH' => -95,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'OP16_LOGICAL_OR' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP11_COMPARE_LT_GT' => -95,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP04_MATH_POW' => -95,
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			'OP08_STRING_CAT' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP21_LIST_COMMA' => -95,
			"]" => -95,
			'OP10_NAMED_UNARY' => 91,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			";" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP22_LOGICAL_NEG' => 87,
			'OP13_BITWISE_AND' => -95,
			"}" => -95,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_NAMED' => 129,
			")" => -95,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 79,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP18_TERNARY' => -95
		},
		GOTOS => {
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'SubExpression' => 175,
			'Literal' => 84,
			'HashReference' => 98,
			'ArrayDereference' => 86
		}
	},
	{#State 92
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			")" => -111,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 79,
			'OP01_QW' => 131,
			"%{" => 97,
			'MY' => 133,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'Literal' => 84,
			'SubExpression' => 134,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73,
			'ArrayDereference' => 86,
			'OPTIONAL-32' => 177,
			'ListElement' => 132,
			'HashReference' => 98,
			'TypeInner' => 136,
			'ListElements' => 176,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 93
		ACTIONS => {
			'MY' => 178
		}
	},
	{#State 94
		DEFAULT => -218
	},
	{#State 95
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55,
			'TYPE_FHREF' => 180
		},
		GOTOS => {
			'Type' => 179
		}
	},
	{#State 96
		DEFAULT => -17
	},
	{#State 97
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			'LBRACE' => -203,
			'MY' => 133
		},
		GOTOS => {
			'OPTIONAL-51' => 183,
			'TypeInner' => 181,
			'Variable' => 182
		}
	},
	{#State 98
		DEFAULT => -135
	},
	{#State 99
		ACTIONS => {
			'OP13_BITWISE_AND' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP04_MATH_POW' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP08_STRING_CAT' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			";" => 184,
			'OP15_LOGICAL_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129
		}
	},
	{#State 100
		DEFAULT => -130
	},
	{#State 101
		DEFAULT => -165,
		GOTOS => {
			'STAR-42' => 185
		}
	},
	{#State 102
		DEFAULT => -143
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP01_NAMED' => 129,
			"\@{" => 79,
			'OP01_QW' => 131,
			"%{" => 97,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'MY' => 133,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 125
		},
		GOTOS => {
			'ArrayDereference' => 86,
			'ListElement' => 132,
			'TypeInner' => 136,
			'HashReference' => 98,
			'Literal' => 84,
			'SubExpression' => 134,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73,
			'WordScoped' => 113,
			'Variable' => 126,
			'ListElements' => 186,
			'Expression' => 127
		}
	},
	{#State 104
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 188,
			'OP19_VARIABLE_ASSIGN_BY' => 189,
			'OP04_MATH_POW' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP18_TERNARY' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP03_MATH_INC_DEC' => 190,
			'OP07_STRING_REPEAT' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP08_STRING_CAT' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP02_METHOD_THINARROW' => 187
		}
	},
	{#State 105
		ACTIONS => {
			'COLON' => 191
		}
	},
	{#State 106
		DEFAULT => -114
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => 192,
			'COLON' => -208
		}
	},
	{#State 108
		DEFAULT => -219
	},
	{#State 109
		ACTIONS => {
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 125,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			"%{" => 97,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			"\@{" => 79
		},
		GOTOS => {
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 193,
			'Literal' => 84,
			'ArrayReference' => 71,
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113
		}
	},
	{#State 110
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 195,
			"\@{" => 79,
			'OP01_PRINT' => 196,
			"%{" => 97,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 125
		},
		GOTOS => {
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'SubExpression' => 194,
			'Literal' => 84,
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113
		}
	},
	{#State 111
		ACTIONS => {
			'LPAREN' => 197
		}
	},
	{#State 112
		DEFAULT => -147
	},
	{#State 113
		ACTIONS => {
			'LPAREN' => 199,
			'OP02_METHOD_THINARROW_NEW' => 198
		}
	},
	{#State 114
		ACTIONS => {
			'FHREF_SYMBOL' => 200
		}
	},
	{#State 115
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'WORD' => 203,
			"%{" => 97,
			"}" => 204,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 201,
			'HashDereference' => 206,
			'Literal' => 207,
			'Variable' => 202,
			'HashEntry' => 205
		}
	},
	{#State 116
		DEFAULT => -146
	},
	{#State 117
		DEFAULT => -118
	},
	{#State 118
		DEFAULT => -37
	},
	{#State 119
		ACTIONS => {
			";" => 208
		}
	},
	{#State 120
		ACTIONS => {
			"while" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'LITERAL_STRING' => -43,
			'WORD_UPPERCASE' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			"for" => -43,
			'WORD_SCOPED' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'LBRACE' => -43,
			'OP01_CLOSE' => -43,
			"if" => -43,
			'WORD' => -43,
			'LPAREN' => -43,
			"%{" => -43,
			'MY' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_NAMED_VOID_LPAREN' => -43,
			'OP01_OPEN' => -43,
			'OP01_NAMED_VOID' => -43,
			'VARIABLE_SYMBOL' => -43,
			"undef" => -43,
			'LPAREN_MY' => 209,
			"foreach" => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP22_LOGICAL_NEG' => -43,
			"}" => -43,
			'LBRACKET' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_NAMED' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"\@{" => -43,
			'OP01_PRINT' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 211,
			'SubroutineArguments' => 210
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 122
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'Literal' => 213
		}
	},
	{#State 123
		DEFAULT => -51
	},
	{#State 124
		ACTIONS => {
			"use" => 34,
			"our hashref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 214,
			'Include' => 215
		}
	},
	{#State 125
		ACTIONS => {
			'LPAREN' => 192
		}
	},
	{#State 126
		ACTIONS => {
			'OP13_BITWISE_AND' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			"}" => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP04_MATH_POW' => -132,
			")" => -132,
			'OP03_MATH_INC_DEC' => 190,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP18_TERNARY' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP08_STRING_CAT' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP21_LIST_COMMA' => -132,
			'OP02_METHOD_THINARROW' => 187,
			"]" => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			";" => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP15_LOGICAL_AND' => -132
		}
	},
	{#State 127
		DEFAULT => -129
	},
	{#State 128
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP17_LIST_RANGE' => 159,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP09_BITWISE_SHIFT' => 166,
			'OP07_STRING_REPEAT' => 158,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			")" => 216,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164
		}
	},
	{#State 129
		ACTIONS => {
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 114,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			"%{" => 97,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79
		},
		GOTOS => {
			'WordScoped' => 113,
			'Variable' => 126,
			'Expression' => 127,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 217,
			'Operator' => 73,
			'HashDereference' => 85
		}
	},
	{#State 130
		ACTIONS => {
			"]" => 218
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 220
		},
		GOTOS => {
			'PLUS-45' => 219
		}
	},
	{#State 132
		DEFAULT => -177,
		GOTOS => {
			'STAR-44' => 221
		}
	},
	{#State 133
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 222
		}
	},
	{#State 134
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP21_LIST_COMMA' => -181,
			'OP09_BITWISE_SHIFT' => 166,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP17_LIST_RANGE' => 159,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170,
			";" => -181,
			"]" => -181,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 163,
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			")" => -181
		}
	},
	{#State 135
		DEFAULT => -184
	},
	{#State 136
		ACTIONS => {
			"\@{" => 79,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			"%{" => 97,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'SubExpression' => 223,
			'Literal' => 84,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
		}
	},
	{#State 137
		DEFAULT => -155
	},
	{#State 138
		DEFAULT => -144
	},
	{#State 139
		ACTIONS => {
			'MY' => 224
		}
	},
	{#State 140
		ACTIONS => {
			'LPAREN' => 225
		}
	},
	{#State 141
		DEFAULT => -156
	},
	{#State 142
		ACTIONS => {
			'MY' => 226
		}
	},
	{#State 143
		DEFAULT => -157
	},
	{#State 144
		DEFAULT => -108
	},
	{#State 145
		ACTIONS => {
			'OP01_QW' => 131,
			"%{" => 97,
			'OP05_MATH_NEG_LPAREN' => 72,
			'MY' => 133,
			'LBRACKET' => 75,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			"\@{" => 79,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 125,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 134,
			'Literal' => 84,
			'ArrayReference' => 71,
			'HashReference' => 98,
			'TypeInner' => 136,
			'ArrayDereference' => 86,
			'ListElement' => 132,
			'ListElements' => 227,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113
		}
	},
	{#State 146
		DEFAULT => -107
	},
	{#State 147
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'LBRACKET' => 75,
			'MY' => 133,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'OP01_QW' => 131,
			"%{" => 97,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80
		},
		GOTOS => {
			'WordScoped' => 113,
			'Variable' => 126,
			'ListElements' => 228,
			'Expression' => 127,
			'ArrayDereference' => 86,
			'ListElement' => 132,
			'TypeInner' => 136,
			'HashReference' => 98,
			'Literal' => 84,
			'SubExpression' => 134,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73
		}
	},
	{#State 148
		DEFAULT => -187
	},
	{#State 149
		ACTIONS => {
			'LBRACKET' => 75
		},
		GOTOS => {
			'ArrayReference' => 229
		}
	},
	{#State 150
		ACTIONS => {
			"}" => 230
		}
	},
	{#State 151
		DEFAULT => -83
	},
	{#State 152
		ACTIONS => {
			'OP21_LIST_COMMA' => 231
		}
	},
	{#State 153
		ACTIONS => {
			'OP08_STRING_CAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP21_LIST_COMMA' => -181,
			'OP07_STRING_REPEAT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			";" => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP04_MATH_POW' => -79,
			")" => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79
		}
	},
	{#State 154
		DEFAULT => -16
	},
	{#State 155
		ACTIONS => {
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'Literal' => 84,
			'SubExpression' => 232,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 156
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'Variable' => 233,
			'VariableOrLiteral' => 234,
			'Literal' => 235
		}
	},
	{#State 157
		ACTIONS => {
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72
		},
		GOTOS => {
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 236,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 158
		ACTIONS => {
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			"%{" => 97,
			"\@{" => 79,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'HashDereference' => 85,
			'Operator' => 73,
			'Literal' => 84,
			'SubExpression' => 237,
			'ArrayReference' => 71,
			'HashReference' => 98,
			'ArrayDereference' => 86
		}
	},
	{#State 159
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 125,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			"\@{" => 79,
			"%{" => 97,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'Literal' => 84,
			'SubExpression' => 238,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 160
		ACTIONS => {
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 239,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 161
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 125,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			"\@{" => 79,
			"%{" => 97,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'SubExpression' => 240,
			'Literal' => 84,
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113
		}
	},
	{#State 162
		ACTIONS => {
			"%{" => 97,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 241,
			'Literal' => 84,
			'ArrayReference' => 71,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
		}
	},
	{#State 163
		ACTIONS => {
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			"%{" => 97,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114
		},
		GOTOS => {
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 242,
			'HashReference' => 98,
			'ArrayDereference' => 86
		}
	},
	{#State 164
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			"%{" => 97,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 243,
			'Literal' => 84,
			'ArrayReference' => 71,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
		}
	},
	{#State 165
		ACTIONS => {
			'OP01_CLOSE' => 114,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			"%{" => 97,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75
		},
		GOTOS => {
			'Literal' => 84,
			'SubExpression' => 244,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 166
		ACTIONS => {
			"%{" => 97,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110
		},
		GOTOS => {
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127,
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'HashDereference' => 85,
			'Operator' => 73,
			'Literal' => 84,
			'SubExpression' => 245,
			'ArrayReference' => 71
		}
	},
	{#State 167
		ACTIONS => {
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 101,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			"%{" => 97,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 114,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125
		},
		GOTOS => {
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'SubExpression' => 246,
			'Literal' => 84,
			'HashReference' => 98,
			'ArrayDereference' => 86
		}
	},
	{#State 168
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			"%{" => 97,
			"\@{" => 79,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'HashDereference' => 85,
			'Operator' => 73,
			'Literal' => 84,
			'SubExpression' => 247,
			'ArrayReference' => 71,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
		}
	},
	{#State 169
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 248
		}
	},
	{#State 170
		ACTIONS => {
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			"%{" => 97,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 249,
			'Literal' => 84,
			'ArrayReference' => 71,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
		}
	},
	{#State 171
		ACTIONS => {
			"%{" => 97,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'HashDereference' => 85,
			'Operator' => 73,
			'Literal' => 84,
			'SubExpression' => 250,
			'ArrayReference' => 71,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
		}
	},
	{#State 172
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			"}" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP08_MATH_ADD_SUB' => 165,
			")" => -104,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			'OP17_LIST_RANGE' => 159,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP09_BITWISE_SHIFT' => 166,
			'OP21_LIST_COMMA' => -104,
			'OP07_STRING_REPEAT' => 158,
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			"]" => -104,
			";" => -104,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170
		}
	},
	{#State 173
		DEFAULT => -208
	},
	{#State 174
		ACTIONS => {
			";" => 251
		}
	},
	{#State 175
		ACTIONS => {
			'OP16_LOGICAL_OR' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP09_BITWISE_SHIFT' => 166,
			'OP07_STRING_REPEAT' => 158,
			'OP21_LIST_COMMA' => -94,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP17_LIST_RANGE' => -94,
			";" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP15_LOGICAL_AND' => -94,
			"]" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP13_BITWISE_AND' => -94,
			"}" => -94,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => -94,
			'OP04_MATH_POW' => 163,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			")" => -94
		}
	},
	{#State 176
		DEFAULT => -110
	},
	{#State 177
		ACTIONS => {
			")" => 252
		}
	},
	{#State 178
		ACTIONS => {
			'TYPE_FHREF' => 253
		}
	},
	{#State 179
		ACTIONS => {
			'VARIABLE_SYMBOL' => 254
		}
	},
	{#State 180
		ACTIONS => {
			'FHREF_SYMBOL' => 255
		}
	},
	{#State 181
		DEFAULT => -202
	},
	{#State 182
		ACTIONS => {
			"}" => 256
		}
	},
	{#State 183
		ACTIONS => {
			'LBRACE' => 115
		},
		GOTOS => {
			'HashReference' => 257
		}
	},
	{#State 184
		DEFAULT => -76
	},
	{#State 185
		ACTIONS => {
			'OP16_LOGICAL_OR' => -166,
			'OP24_LOGICAL_OR_XOR' => -166,
			'OP07_STRING_REPEAT' => -166,
			'OP21_LIST_COMMA' => -166,
			'OP09_BITWISE_SHIFT' => -166,
			'COLON' => -166,
			'OP08_STRING_CAT' => -166,
			'OP02_HASH_THINARROW' => 258,
			'OP06_REGEX_MATCH' => -166,
			'OP17_LIST_RANGE' => -166,
			'OP20_HASH_FATARROW' => -166,
			'OP15_LOGICAL_AND' => -166,
			'OP12_COMPARE_EQ_NE' => -166,
			";" => -166,
			"]" => -166,
			'OP02_METHOD_THINARROW' => -166,
			'OP07_MATH_MULT_DIV_MOD' => -166,
			'OP11_COMPARE_LT_GT' => -166,
			'OP19_VARIABLE_ASSIGN_BY' => -166,
			'OP19_VARIABLE_ASSIGN' => -166,
			'OP23_LOGICAL_AND' => -166,
			"}" => -166,
			'OP08_MATH_ADD_SUB' => -166,
			'OP13_BITWISE_AND' => -166,
			'OP04_MATH_POW' => -166,
			'OP02_ARRAY_THINARROW' => 260,
			'OP18_TERNARY' => -166,
			'OP14_BITWISE_OR_XOR' => -166,
			'OP03_MATH_INC_DEC' => -166,
			")" => -166
		},
		GOTOS => {
			'VariableRetrieval' => 259
		}
	},
	{#State 186
		ACTIONS => {
			";" => 261
		}
	},
	{#State 187
		ACTIONS => {
			'LPAREN' => 262
		}
	},
	{#State 188
		ACTIONS => {
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_UPPERCASE' => 125,
			'STDIN' => 265,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			"\@{" => 79,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			"%{" => 97
		},
		GOTOS => {
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126,
			'SubExpression' => 264,
			'Literal' => 84,
			'ArrayReference' => 71,
			'SubExpressionOrStdin' => 263,
			'HashDereference' => 85,
			'Operator' => 73,
			'ArrayDereference' => 86,
			'HashReference' => 98
		}
	},
	{#State 189
		ACTIONS => {
			"%{" => 97,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 79,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 125,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'SubExpression' => 266,
			'Literal' => 84,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73,
			'WordScoped' => 113,
			'Variable' => 126,
			'Expression' => 127
		}
	},
	{#State 190
		DEFAULT => -84
	},
	{#State 191
		DEFAULT => -140
	},
	{#State 192
		ACTIONS => {
			")" => 267
		}
	},
	{#State 193
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -86,
			'OP15_LOGICAL_AND' => -86,
			";" => -86,
			"]" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP08_STRING_CAT' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP18_TERNARY' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			")" => -86,
			'OP08_MATH_ADD_SUB' => -86,
			"}" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP04_MATH_POW' => 163
		}
	},
	{#State 194
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP17_LIST_RANGE' => 159,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			")" => 268,
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 163
		}
	},
	{#State 195
		ACTIONS => {
			"\@{" => 79,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'MY' => 133,
			'OP05_MATH_NEG_LPAREN' => 72,
			"%{" => 97,
			'OP01_QW' => 131,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'HashDereference' => 85,
			'Operator' => 73,
			'Literal' => 84,
			'SubExpression' => 153,
			'ArrayReference' => 71,
			'HashReference' => 98,
			'TypeInner' => 136,
			'ArrayDereference' => 86,
			'ListElement' => 269,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113
		}
	},
	{#State 196
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 270
		}
	},
	{#State 197
		ACTIONS => {
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			"%{" => 97,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP01_CLOSE' => 114,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'ArrayReference' => 71,
			'SubExpression' => 271,
			'Literal' => 84,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 198
		ACTIONS => {
			")" => 272
		}
	},
	{#State 199
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_QW' => 131,
			"%{" => 97,
			'MY' => 133,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			")" => -121,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 79
		},
		GOTOS => {
			'ListElements' => 274,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 134,
			'Literal' => 84,
			'ArrayReference' => 71,
			'HashReference' => 98,
			'TypeInner' => 136,
			'ArrayDereference' => 86,
			'OPTIONAL-33' => 273,
			'ListElement' => 132
		}
	},
	{#State 200
		DEFAULT => -82
	},
	{#State 201
		ACTIONS => {
			'OP20_HASH_FATARROW' => 275
		}
	},
	{#State 202
		DEFAULT => -215
	},
	{#State 203
		DEFAULT => -217
	},
	{#State 204
		DEFAULT => -201
	},
	{#State 205
		DEFAULT => -199,
		GOTOS => {
			'STAR-50' => 276
		}
	},
	{#State 206
		DEFAULT => -194
	},
	{#State 207
		DEFAULT => -216
	},
	{#State 208
		DEFAULT => -40
	},
	{#State 209
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 277
		}
	},
	{#State 210
		DEFAULT => -42
	},
	{#State 211
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 278
		}
	},
	{#State 212
		ACTIONS => {
			"\$TYPED_" => 279
		}
	},
	{#State 213
		ACTIONS => {
			";" => 280
		}
	},
	{#State 214
		ACTIONS => {
			"our hashref \$properties" => 282,
			"use constant" => 47
		},
		GOTOS => {
			'Properties' => 283,
			'Constant' => 281
		}
	},
	{#State 215
		DEFAULT => -53
	},
	{#State 216
		DEFAULT => -87
	},
	{#State 217
		ACTIONS => {
			'OP18_TERNARY' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			")" => -79,
			'OP04_MATH_POW' => -79,
			'OP23_LOGICAL_AND' => -79,
			"}" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			";" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			"]" => -79,
			'OP21_LIST_COMMA' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP08_STRING_CAT' => -79
		}
	},
	{#State 218
		DEFAULT => -186
	},
	{#State 219
		ACTIONS => {
			'WORD' => 284,
			")" => 285
		}
	},
	{#State 220
		DEFAULT => -180
	},
	{#State 221
		ACTIONS => {
			";" => -178,
			'OP21_LIST_COMMA' => 286,
			"]" => -178,
			")" => -178
		},
		GOTOS => {
			'PAREN-43' => 287
		}
	},
	{#State 222
		ACTIONS => {
			"\$TYPED_" => 288
		}
	},
	{#State 223
		ACTIONS => {
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP04_MATH_POW' => 163,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			")" => -182,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP09_BITWISE_SHIFT' => 166,
			'OP07_STRING_REPEAT' => 158,
			'OP21_LIST_COMMA' => -182,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP17_LIST_RANGE' => 159,
			";" => -182,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170,
			"]" => -182,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171
		}
	},
	{#State 224
		ACTIONS => {
			'TYPE_INTEGER' => 289
		}
	},
	{#State 225
		ACTIONS => {
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109
		},
		GOTOS => {
			'ArrayReference' => 71,
			'SubExpression' => 290,
			'Literal' => 84,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 226
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 291
		}
	},
	{#State 227
		ACTIONS => {
			";" => 292
		}
	},
	{#State 228
		ACTIONS => {
			";" => 293
		}
	},
	{#State 229
		ACTIONS => {
			"}" => 294
		}
	},
	{#State 230
		DEFAULT => -189
	},
	{#State 231
		ACTIONS => {
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'MY' => 133,
			"%{" => 97,
			'OP01_QW' => 131,
			"\@{" => 79,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 134,
			'Literal' => 84,
			'ArrayReference' => 71,
			'TypeInner' => 136,
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'ListElement' => 132,
			'ListElements' => 295,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113
		}
	},
	{#State 232
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP23_LOGICAL_AND' => -98,
			"}" => -98,
			'OP08_MATH_ADD_SUB' => 165,
			'OP13_BITWISE_AND' => -98,
			'OP18_TERNARY' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			")" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP16_LOGICAL_OR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP15_LOGICAL_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 170,
			";" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			"]" => -98
		}
	},
	{#State 233
		DEFAULT => -213
	},
	{#State 234
		ACTIONS => {
			'COLON' => 296
		}
	},
	{#State 235
		DEFAULT => -214
	},
	{#State 236
		ACTIONS => {
			")" => -99,
			'OP18_TERNARY' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 165,
			"}" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 163,
			"]" => -99,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP17_LIST_RANGE' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => 158,
			'OP21_LIST_COMMA' => -99,
			'OP09_BITWISE_SHIFT' => 166
		}
	},
	{#State 237
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -89,
			'OP18_TERNARY' => -89,
			")" => -89,
			'OP13_BITWISE_AND' => -89,
			"}" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP04_MATH_POW' => 163,
			";" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP15_LOGICAL_AND' => -89,
			"]" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP08_STRING_CAT' => -89,
			'OP06_REGEX_MATCH' => 169,
			'OP17_LIST_RANGE' => -89
		}
	},
	{#State 238
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 166,
			'OP21_LIST_COMMA' => -102,
			'OP07_STRING_REPEAT' => 158,
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			"]" => -102,
			";" => -102,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			"}" => -102,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => -102,
			")" => -102,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => -102
		}
	},
	{#State 239
		ACTIONS => {
			'OP13_BITWISE_AND' => -92,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP08_MATH_ADD_SUB' => 165,
			'OP04_MATH_POW' => 163,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			")" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP07_STRING_REPEAT' => 158,
			'OP21_LIST_COMMA' => -92,
			'OP08_STRING_CAT' => -92,
			'OP06_REGEX_MATCH' => 169,
			'OP17_LIST_RANGE' => -92,
			";" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP15_LOGICAL_AND' => -92,
			"]" => -92,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => -92
		}
	},
	{#State 240
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			"}" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 165,
			")" => -100,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 166,
			'OP21_LIST_COMMA' => -100,
			'OP07_STRING_REPEAT' => 158,
			'OP16_LOGICAL_OR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			"]" => -100,
			";" => -100,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => -100
		}
	},
	{#State 241
		ACTIONS => {
			'OP13_BITWISE_AND' => -90,
			"}" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP04_MATH_POW' => 163,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP18_TERNARY' => -90,
			")" => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP07_STRING_REPEAT' => 158,
			'OP21_LIST_COMMA' => -90,
			'OP08_STRING_CAT' => -90,
			'OP06_REGEX_MATCH' => 169,
			'OP17_LIST_RANGE' => -90,
			";" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP15_LOGICAL_AND' => -90,
			"]" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90
		}
	},
	{#State 242
		ACTIONS => {
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			"]" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			";" => -85,
			'OP23_LOGICAL_AND' => -85,
			"}" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP04_MATH_POW' => 163,
			")" => -85,
			'OP18_TERNARY' => -85,
			'OP14_BITWISE_OR_XOR' => -85
		}
	},
	{#State 243
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP08_MATH_ADD_SUB' => 165,
			"}" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP13_BITWISE_AND' => 155,
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			")" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 159,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			";" => -105,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			"]" => -105
		}
	},
	{#State 244
		ACTIONS => {
			"}" => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP04_MATH_POW' => 163,
			'OP18_TERNARY' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			")" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP07_STRING_REPEAT' => 158,
			'OP21_LIST_COMMA' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP08_STRING_CAT' => -91,
			'OP06_REGEX_MATCH' => 169,
			'OP17_LIST_RANGE' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			";" => -91,
			"]" => -91,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => -91
		}
	},
	{#State 245
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => -93,
			'OP08_MATH_ADD_SUB' => 165,
			"}" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP18_TERNARY' => -93,
			")" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP07_STRING_REPEAT' => 158,
			'OP16_LOGICAL_OR' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			";" => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			"]" => -93
		}
	},
	{#State 246
		ACTIONS => {
			";" => -106,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170,
			"]" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 166,
			'OP07_STRING_REPEAT' => 158,
			'OP21_LIST_COMMA' => -106,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			")" => -106,
			'OP13_BITWISE_AND' => 155,
			"}" => -106,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP04_MATH_POW' => 163
		}
	},
	{#State 247
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			"]" => -101,
			";" => -101,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP17_LIST_RANGE' => -101,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP09_BITWISE_SHIFT' => 166,
			'OP21_LIST_COMMA' => -101,
			'OP07_STRING_REPEAT' => 158,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			")" => -101,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 165,
			"}" => -101,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 248
		DEFAULT => -88
	},
	{#State 249
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => undef,
			'OP15_LOGICAL_AND' => -97,
			";" => -97,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			"]" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP18_TERNARY' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			")" => -97,
			'OP04_MATH_POW' => 163,
			'OP23_LOGICAL_AND' => -97,
			"}" => -97,
			'OP08_MATH_ADD_SUB' => 165,
			'OP13_BITWISE_AND' => -97
		}
	},
	{#State 250
		ACTIONS => {
			'OP21_LIST_COMMA' => -96,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP15_LOGICAL_AND' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			";" => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			"]" => -96,
			'OP04_MATH_POW' => 163,
			'OP23_LOGICAL_AND' => -96,
			"}" => -96,
			'OP08_MATH_ADD_SUB' => 165,
			'OP13_BITWISE_AND' => -96,
			'OP18_TERNARY' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			")" => -96
		}
	},
	{#State 251
		DEFAULT => -119
	},
	{#State 252
		ACTIONS => {
			";" => 297
		}
	},
	{#State 253
		ACTIONS => {
			'FHREF_SYMBOL' => 298
		}
	},
	{#State 254
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 300,
			";" => 299
		}
	},
	{#State 255
		ACTIONS => {
			";" => 301
		}
	},
	{#State 256
		DEFAULT => -204
	},
	{#State 257
		ACTIONS => {
			"}" => 302
		}
	},
	{#State 258
		ACTIONS => {
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 114,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 304,
			"%{" => 97,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79
		},
		GOTOS => {
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 303,
			'Literal' => 84,
			'ArrayReference' => 71,
			'HashReference' => 98,
			'ArrayDereference' => 86
		}
	},
	{#State 259
		DEFAULT => -164
	},
	{#State 260
		ACTIONS => {
			"%{" => 97,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 114,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 113,
			'Variable' => 126,
			'Expression' => 127,
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'Literal' => 84,
			'SubExpression' => 305,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73
		}
	},
	{#State 261
		DEFAULT => -116
	},
	{#State 262
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'LBRACKET' => 75,
			'MY' => 133,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'OP01_QW' => 131,
			"%{" => 97,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			")" => -123,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100
		},
		GOTOS => {
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 134,
			'Operator' => 73,
			'HashDereference' => 85,
			'ListElement' => 132,
			'ArrayDereference' => 86,
			'TypeInner' => 136,
			'HashReference' => 98,
			'Expression' => 127,
			'ListElements' => 306,
			'WordScoped' => 113,
			'OPTIONAL-34' => 307,
			'Variable' => 126
		}
	},
	{#State 263
		ACTIONS => {
			";" => 308
		}
	},
	{#State 264
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			'OP17_LIST_RANGE' => 159,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 166,
			'OP07_STRING_REPEAT' => 158,
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			";" => -138,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161
		}
	},
	{#State 265
		DEFAULT => -139
	},
	{#State 266
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP23_LOGICAL_AND' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP13_BITWISE_AND' => 155,
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP17_LIST_RANGE' => 159,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			";" => 309,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171
		}
	},
	{#State 267
		DEFAULT => -126
	},
	{#State 268
		DEFAULT => -137
	},
	{#State 269
		ACTIONS => {
			'OP21_LIST_COMMA' => 310
		}
	},
	{#State 270
		ACTIONS => {
			"%{" => 97,
			'OP01_QW' => 131,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'MY' => 133,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 114,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 27,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26
		},
		GOTOS => {
			'HashReference' => 98,
			'TypeInner' => 136,
			'ArrayDereference' => 86,
			'ListElement' => 132,
			'HashDereference' => 85,
			'Operator' => 73,
			'Literal' => 84,
			'SubExpression' => 134,
			'ArrayReference' => 71,
			'Variable' => 126,
			'WordScoped' => 113,
			'ListElements' => 311,
			'Expression' => 127
		}
	},
	{#State 271
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			")" => 312,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 163
		}
	},
	{#State 272
		DEFAULT => -128
	},
	{#State 273
		ACTIONS => {
			")" => 313
		}
	},
	{#State 274
		DEFAULT => -120
	},
	{#State 275
		ACTIONS => {
			"\@{" => -192,
			'VARIABLE_SYMBOL' => -192,
			'OP01_NAMED' => -192,
			'OP03_MATH_INC_DEC' => -192,
			"undef" => -192,
			'LBRACKET' => -192,
			'MY' => 133,
			'OP05_MATH_NEG_LPAREN' => -192,
			'LITERAL_NUMBER' => -192,
			'OP01_OPEN' => -192,
			"%{" => -192,
			'WORD' => -192,
			'OP22_LOGICAL_NEG' => -192,
			'LPAREN' => -192,
			'WORD_SCOPED' => -192,
			'LBRACE' => -192,
			'OP10_NAMED_UNARY' => -192,
			'OP01_CLOSE' => -192,
			'OP05_LOGICAL_NEG' => -192,
			'LITERAL_STRING' => -192,
			'WORD_UPPERCASE' => -192
		},
		GOTOS => {
			'TypeInner' => 314,
			'OPTIONAL-48' => 315
		}
	},
	{#State 276
		ACTIONS => {
			"}" => 317,
			'OP21_LIST_COMMA' => 316
		},
		GOTOS => {
			'PAREN-49' => 318
		}
	},
	{#State 277
		ACTIONS => {
			'VARIABLE_SYMBOL' => 319
		}
	},
	{#State 278
		ACTIONS => {
			'OP01_NAMED' => 81,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_PRINT' => 78,
			"\@{" => 79,
			"}" => 320,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP19_LOOP_CONTROL' => 88,
			"foreach" => -142,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 87,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED_VOID' => 103,
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'OP01_NAMED_VOID_LPAREN' => 92,
			'MY' => 95,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'LBRACE' => 115,
			'LPAREN' => 110,
			'WORD' => 26,
			"if" => 111,
			'WORD_UPPERCASE' => 107,
			"while" => -142,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			"for" => -142,
			'OP01_NAMED_VOID_SCOLON' => 106
		},
		GOTOS => {
			'Operation' => 321,
			'PAREN-35' => 76,
			'HashReference' => 98,
			'OPTIONAL-36' => 77,
			'ArrayReference' => 71,
			'Operator' => 73,
			'Variable' => 104,
			'Conditional' => 102,
			'Expression' => 99,
			'ArrayDereference' => 86,
			'SubExpression' => 83,
			'Literal' => 84,
			'LoopLabel' => 105,
			'HashDereference' => 85,
			'OperatorVoid' => 89,
			'WordScoped' => 113,
			'VariableModification' => 112,
			'Statement' => 90,
			'VariableDeclaration' => 116
		}
	},
	{#State 279
		ACTIONS => {
			'WORD_UPPERCASE' => 322
		}
	},
	{#State 280
		DEFAULT => -41
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
		DEFAULT => -179
	},
	{#State 285
		DEFAULT => -183
	},
	{#State 286
		ACTIONS => {
			'MY' => 133,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'OP01_QW' => 131,
			"%{" => 97,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 125,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 114
		},
		GOTOS => {
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127,
			'TypeInner' => 136,
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'ListElement' => 325,
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 134,
			'Literal' => 84,
			'ArrayReference' => 71
		}
	},
	{#State 287
		DEFAULT => -176
	},
	{#State 288
		ACTIONS => {
			'WORD' => 326
		}
	},
	{#State 289
		ACTIONS => {
			'VARIABLE_SYMBOL' => 327
		}
	},
	{#State 290
		ACTIONS => {
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			")" => 328,
			'OP04_MATH_POW' => 163,
			'OP23_LOGICAL_AND' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 159,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 291
		ACTIONS => {
			'VARIABLE_SYMBOL' => 329
		}
	},
	{#State 292
		DEFAULT => -112
	},
	{#State 293
		DEFAULT => -113
	},
	{#State 294
		DEFAULT => -190
	},
	{#State 295
		ACTIONS => {
			";" => 330
		}
	},
	{#State 296
		ACTIONS => {
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_NUMBER' => 94
		},
		GOTOS => {
			'Variable' => 233,
			'VariableOrLiteral' => 331,
			'Literal' => 235
		}
	},
	{#State 297
		DEFAULT => -115
	},
	{#State 298
		ACTIONS => {
			'OP21_LIST_COMMA' => 332
		}
	},
	{#State 299
		DEFAULT => -170
	},
	{#State 300
		ACTIONS => {
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			'WORD_UPPERCASE' => 125,
			'STDIN' => 265,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'Operator' => 73,
			'HashDereference' => 85,
			'SubExpressionOrStdin' => 333,
			'ArrayReference' => 71,
			'SubExpression' => 264,
			'Literal' => 84,
			'HashReference' => 98,
			'ArrayDereference' => 86
		}
	},
	{#State 301
		DEFAULT => -172
	},
	{#State 302
		DEFAULT => -205
	},
	{#State 303
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			'OP23_LOGICAL_AND' => 164,
			"}" => 334,
			'OP08_MATH_ADD_SUB' => 165,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			'OP17_LIST_RANGE' => 159,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP09_BITWISE_SHIFT' => 166,
			'OP07_STRING_REPEAT' => 158,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170
		}
	},
	{#State 304
		ACTIONS => {
			"}" => 335,
			'OP02_METHOD_THINARROW_NEW' => -206,
			'LPAREN' => -206
		}
	},
	{#State 305
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 159,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			"]" => 336
		}
	},
	{#State 306
		DEFAULT => -122
	},
	{#State 307
		ACTIONS => {
			")" => 337
		}
	},
	{#State 308
		DEFAULT => -173
	},
	{#State 309
		DEFAULT => -174
	},
	{#State 310
		ACTIONS => {
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'MY' => 133,
			'OP05_MATH_NEG_LPAREN' => 72,
			"%{" => 97,
			'OP01_QW' => 131,
			"\@{" => 79,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115
		},
		GOTOS => {
			'SubExpression' => 134,
			'Literal' => 84,
			'ArrayReference' => 71,
			'HashDereference' => 85,
			'Operator' => 73,
			'ArrayDereference' => 86,
			'ListElement' => 132,
			'HashReference' => 98,
			'TypeInner' => 136,
			'ListElements' => 338,
			'Expression' => 127,
			'WordScoped' => 113,
			'Variable' => 126
		}
	},
	{#State 311
		ACTIONS => {
			")" => 339
		}
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 341
		},
		GOTOS => {
			'CodeBlock' => 340
		}
	},
	{#State 313
		DEFAULT => -125
	},
	{#State 314
		DEFAULT => -191
	},
	{#State 315
		ACTIONS => {
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108
		},
		GOTOS => {
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 342,
			'Operator' => 73,
			'HashDereference' => 85,
			'WordScoped' => 113,
			'Variable' => 126,
			'Expression' => 127
		}
	},
	{#State 316
		ACTIONS => {
			'WORD' => 203,
			'LITERAL_NUMBER' => 94,
			'LITERAL_STRING' => 108,
			'VARIABLE_SYMBOL' => 101,
			"%{" => 97
		},
		GOTOS => {
			'Variable' => 202,
			'HashEntry' => 343,
			'VariableOrLiteralOrWord' => 201,
			'HashDereference' => 206,
			'Literal' => 207
		}
	},
	{#State 317
		DEFAULT => -200
	},
	{#State 318
		DEFAULT => -198
	},
	{#State 319
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 344
		}
	},
	{#State 320
		ACTIONS => {
			";" => 345
		}
	},
	{#State 321
		DEFAULT => -44
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
			'LITERAL_NUMBER' => 349,
			"our" => 348
		},
		GOTOS => {
			'MethodOrSubroutine' => 350,
			'Subroutine' => 352,
			'Method' => 351
		}
	},
	{#State 325
		DEFAULT => -175
	},
	{#State 326
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 353
		}
	},
	{#State 327
		ACTIONS => {
			'LPAREN' => 354
		}
	},
	{#State 328
		ACTIONS => {
			'LBRACE' => 341
		},
		GOTOS => {
			'CodeBlock' => 355
		}
	},
	{#State 329
		ACTIONS => {
			'LPAREN' => 356
		}
	},
	{#State 330
		DEFAULT => -117
	},
	{#State 331
		DEFAULT => -103
	},
	{#State 332
		ACTIONS => {
			'LITERAL_STRING' => 357
		}
	},
	{#State 333
		ACTIONS => {
			";" => 358
		}
	},
	{#State 334
		DEFAULT => -168
	},
	{#State 335
		DEFAULT => -169
	},
	{#State 336
		DEFAULT => -167
	},
	{#State 337
		DEFAULT => -127
	},
	{#State 338
		ACTIONS => {
			")" => 359
		}
	},
	{#State 339
		DEFAULT => -78
	},
	{#State 340
		DEFAULT => -150,
		GOTOS => {
			'STAR-38' => 360
		}
	},
	{#State 341
		ACTIONS => {
			'OP01_NAMED' => 81,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 79,
			'OP01_PRINT' => 78,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP10_NAMED_UNARY' => 91,
			"foreach" => -142,
			'OP19_LOOP_CONTROL' => 88,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED_VOID' => 103,
			"undef" => 100,
			"%{" => 97,
			'MY' => 95,
			'LITERAL_NUMBER' => 94,
			'OP01_NAMED_VOID_LPAREN' => 92,
			'OP01_OPEN' => 93,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			"if" => 111,
			'WORD' => 26,
			'LPAREN' => 110,
			"while" => -142,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'WORD_UPPERCASE' => 107,
			"for" => -142,
			'OP01_NAMED_VOID_SCOLON' => 106
		},
		GOTOS => {
			'Variable' => 104,
			'Conditional' => 102,
			'Expression' => 99,
			'Operation' => 361,
			'PAREN-35' => 76,
			'PLUS-41' => 362,
			'OPTIONAL-36' => 77,
			'HashReference' => 98,
			'ArrayReference' => 71,
			'Operator' => 73,
			'OperatorVoid' => 89,
			'VariableModification' => 112,
			'WordScoped' => 113,
			'Statement' => 90,
			'VariableDeclaration' => 116,
			'ArrayDereference' => 86,
			'Literal' => 84,
			'SubExpression' => 83,
			'LoopLabel' => 105,
			'HashDereference' => 85
		}
	},
	{#State 342
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP17_LIST_RANGE' => 159,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP21_LIST_COMMA' => -193,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP04_MATH_POW' => 163,
			"}" => -193,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP13_BITWISE_AND' => 155
		}
	},
	{#State 343
		DEFAULT => -197
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
			"%{" => 97,
			"}" => 369,
			'WORD' => 366
		},
		GOTOS => {
			'HashEntryTyped' => 367,
			'HashDereference' => 368
		}
	},
	{#State 348
		ACTIONS => {
			'TYPE_METHOD' => 370,
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 349
		ACTIONS => {
			";" => 371
		}
	},
	{#State 350
		DEFAULT => -57
	},
	{#State 351
		DEFAULT => -74
	},
	{#State 352
		DEFAULT => -75
	},
	{#State 353
		DEFAULT => -211
	},
	{#State 354
		ACTIONS => {
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_NAMED' => 129,
			"undef" => 100,
			'OP03_MATH_INC_DEC' => 80,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'ArrayDereference' => 86,
			'HashReference' => 98,
			'ArrayReference' => 71,
			'SubExpression' => 372,
			'Literal' => 84,
			'Operator' => 73,
			'HashDereference' => 85,
			'WordScoped' => 113,
			'Variable' => 126,
			'Expression' => 127
		}
	},
	{#State 355
		DEFAULT => -160
	},
	{#State 356
		ACTIONS => {
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			"\@{" => 79,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'MY' => 133,
			'OP05_MATH_NEG_LPAREN' => 72,
			"%{" => 97,
			'OP01_QW' => 131
		},
		GOTOS => {
			'ListElements' => 373,
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'HashDereference' => 85,
			'Operator' => 73,
			'SubExpression' => 134,
			'Literal' => 84,
			'ArrayReference' => 71,
			'HashReference' => 98,
			'TypeInner' => 136,
			'ArrayDereference' => 86,
			'ListElement' => 132
		}
	},
	{#State 357
		ACTIONS => {
			'OP21_LIST_COMMA' => 374
		}
	},
	{#State 358
		DEFAULT => -171
	},
	{#State 359
		DEFAULT => -80
	},
	{#State 360
		ACTIONS => {
			"}" => -153,
			'LBRACKET' => -153,
			'OP05_MATH_NEG_LPAREN' => -153,
			'OP01_NAMED' => -153,
			'OP03_MATH_INC_DEC' => -153,
			"\@{" => -153,
			'OP01_PRINT' => -153,
			"foreach" => -153,
			'OP10_NAMED_UNARY' => -153,
			"else" => 378,
			'OP19_LOOP_CONTROL' => -153,
			'OP22_LOGICAL_NEG' => -153,
			"%{" => -153,
			'MY' => -153,
			'LITERAL_NUMBER' => -153,
			'OP01_OPEN' => -153,
			'OP01_NAMED_VOID_LPAREN' => -153,
			'VARIABLE_SYMBOL' => -153,
			'OP01_NAMED_VOID' => -153,
			"undef" => -153,
			"while" => -153,
			'OP05_LOGICAL_NEG' => -153,
			'LITERAL_STRING' => -153,
			'WORD_UPPERCASE' => -153,
			"for" => -153,
			'OP01_NAMED_VOID_SCOLON' => -153,
			'OP19_LOOP_CONTROL_SCOLON' => -153,
			'WORD_SCOPED' => -153,
			'LBRACE' => -153,
			'OP01_CLOSE' => -153,
			"elsif" => 376,
			"if" => -153,
			'WORD' => -153,
			'' => -153,
			'LPAREN' => -153
		},
		GOTOS => {
			'PAREN-39' => 379,
			'PAREN-37' => 377,
			'OPTIONAL-40' => 375
		}
	},
	{#State 361
		DEFAULT => -162
	},
	{#State 362
		ACTIONS => {
			"%{" => 97,
			'MY' => 95,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'OP01_NAMED_VOID_LPAREN' => 92,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED_VOID' => 103,
			"undef" => 100,
			"while" => -142,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 107,
			'OP01_NAMED_VOID_SCOLON' => 106,
			"for" => -142,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP01_CLOSE' => 114,
			'WORD' => 26,
			"if" => 111,
			'LPAREN' => 110,
			"}" => 380,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'OP01_NAMED' => 81,
			'OP03_MATH_INC_DEC' => 80,
			"\@{" => 79,
			'OP01_PRINT' => 78,
			'OP10_NAMED_UNARY' => 91,
			"foreach" => -142,
			'OP19_LOOP_CONTROL' => 88,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'HashDereference' => 85,
			'LoopLabel' => 105,
			'SubExpression' => 83,
			'Literal' => 84,
			'ArrayDereference' => 86,
			'VariableDeclaration' => 116,
			'Statement' => 90,
			'WordScoped' => 113,
			'VariableModification' => 112,
			'OperatorVoid' => 89,
			'Operator' => 73,
			'ArrayReference' => 71,
			'OPTIONAL-36' => 77,
			'HashReference' => 98,
			'PAREN-35' => 76,
			'Operation' => 381,
			'Expression' => 99,
			'Variable' => 104,
			'Conditional' => 102
		}
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
			'OP20_HASH_FATARROW' => 384
		}
	},
	{#State 367
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 385
		}
	},
	{#State 368
		DEFAULT => -196
	},
	{#State 369
		ACTIONS => {
			";" => 386
		}
	},
	{#State 370
		ACTIONS => {
			'VARIABLE_SYMBOL' => 387
		}
	},
	{#State 371
		DEFAULT => -59
	},
	{#State 372
		ACTIONS => {
			'OP18_TERNARY' => 156,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP04_MATH_POW' => 163,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 388,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 373
		ACTIONS => {
			")" => 389
		}
	},
	{#State 374
		ACTIONS => {
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_UPPERCASE' => 125,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			"\@{" => 79,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			"%{" => 97
		},
		GOTOS => {
			'Expression' => 127,
			'Variable' => 126,
			'WordScoped' => 113,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'SubExpression' => 390,
			'Literal' => 84,
			'HashReference' => 98,
			'ArrayDereference' => 86
		}
	},
	{#State 375
		DEFAULT => -154
	},
	{#State 376
		ACTIONS => {
			'LPAREN' => 391
		}
	},
	{#State 377
		DEFAULT => -149
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 341
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 379
		DEFAULT => -152
	},
	{#State 380
		DEFAULT => -163
	},
	{#State 381
		DEFAULT => -161
	},
	{#State 382
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
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
		ACTIONS => {
			'MY' => 133
		},
		GOTOS => {
			'TypeInner' => 395
		}
	},
	{#State 385
		ACTIONS => {
			'OP21_LIST_COMMA' => 398,
			"}" => 397
		},
		GOTOS => {
			'PAREN-24' => 396
		}
	},
	{#State 386
		DEFAULT => -64
	},
	{#State 387
		ACTIONS => {
			"= sub {" => 399
		}
	},
	{#State 388
		ACTIONS => {
			'OP01_CLOSE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'OP01_NAMED' => 129,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			"%{" => 97,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 94,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'HashDereference' => 85,
			'Operator' => 73,
			'Literal' => 84,
			'SubExpression' => 400,
			'ArrayReference' => 71,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
		}
	},
	{#State 389
		ACTIONS => {
			'LBRACE' => 341
		},
		GOTOS => {
			'CodeBlock' => 401
		}
	},
	{#State 390
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 166,
			'OP21_LIST_COMMA' => -81,
			'OP07_STRING_REPEAT' => 158,
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP17_LIST_RANGE' => 159,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			";" => -81,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			"]" => -81,
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 165,
			"}" => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			")" => -81
		}
	},
	{#State 391
		ACTIONS => {
			'OP01_CLOSE' => 114,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 110,
			'WORD' => 26,
			'WORD_UPPERCASE' => 125,
			'OP05_LOGICAL_NEG' => 109,
			'LITERAL_STRING' => 108,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 79,
			"%{" => 97,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 402,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
		}
	},
	{#State 392
		DEFAULT => -151
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
			'WORD' => 26,
			'LPAREN' => 110,
			'OP22_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 27,
			'LBRACE' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP01_CLOSE' => 114,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			'WORD_UPPERCASE' => 125,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 129,
			'OP03_MATH_INC_DEC' => 80,
			"undef" => 100,
			'LBRACKET' => 75,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LITERAL_NUMBER' => 94,
			'OP01_OPEN' => 93,
			"%{" => 97
		},
		GOTOS => {
			'HashReference' => 98,
			'ArrayDereference' => 86,
			'Operator' => 73,
			'HashDereference' => 85,
			'ArrayReference' => 71,
			'Literal' => 84,
			'SubExpression' => 404,
			'Variable' => 126,
			'WordScoped' => 113,
			'Expression' => 127
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
			'WORD' => 366,
			"%{" => 97
		},
		GOTOS => {
			'HashEntryTyped' => 406,
			'HashDereference' => 368
		}
	},
	{#State 399
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -66,
			'LITERAL_STRING' => -66,
			"while" => -66,
			'WORD_UPPERCASE' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			"for" => -66,
			'LBRACE' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'WORD_SCOPED' => -66,
			'OP01_CLOSE' => -66,
			'WORD' => -66,
			"if" => -66,
			'LPAREN' => -66,
			"%{" => -66,
			'MY' => -66,
			'OP01_OPEN' => -66,
			'OP01_NAMED_VOID_LPAREN' => -66,
			'LITERAL_NUMBER' => -66,
			'OP01_NAMED_VOID' => -66,
			'VARIABLE_SYMBOL' => -66,
			"undef" => -66,
			'LPAREN_MY' => 407,
			"foreach" => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP22_LOGICAL_NEG' => -66,
			"}" => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'LBRACKET' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP01_NAMED' => -66,
			"\@{" => -66,
			'OP01_PRINT' => -66
		},
		GOTOS => {
			'MethodArguments' => 408,
			'OPTIONAL-26' => 409
		}
	},
	{#State 400
		ACTIONS => {
			")" => 410,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP23_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 165,
			'OP13_BITWISE_AND' => 155,
			'OP04_MATH_POW' => 163,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP15_LOGICAL_AND' => 161,
			'OP08_STRING_CAT' => 160,
			'OP06_REGEX_MATCH' => 169,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_STRING_REPEAT' => 158,
			'OP09_BITWISE_SHIFT' => 166
		}
	},
	{#State 401
		DEFAULT => -159
	},
	{#State 402
		ACTIONS => {
			'OP16_LOGICAL_OR' => 168,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP09_BITWISE_SHIFT' => 166,
			'OP07_STRING_REPEAT' => 158,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP17_LIST_RANGE' => 159,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 171,
			'OP13_BITWISE_AND' => 155,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 164,
			'OP04_MATH_POW' => 163,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			")" => 411
		}
	},
	{#State 403
		DEFAULT => -47
	},
	{#State 404
		ACTIONS => {
			'OP04_MATH_POW' => 163,
			'OP13_BITWISE_AND' => 155,
			"}" => -195,
			'OP23_LOGICAL_AND' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 156,
			'OP09_BITWISE_SHIFT' => 166,
			'OP21_LIST_COMMA' => -195,
			'OP07_STRING_REPEAT' => 158,
			'OP24_LOGICAL_OR_XOR' => 167,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 159,
			'OP06_REGEX_MATCH' => 169,
			'OP08_STRING_CAT' => 160,
			'OP15_LOGICAL_AND' => 161,
			'OP12_COMPARE_EQ_NE' => 170,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 162
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
			'LBRACE' => 341
		},
		GOTOS => {
			'CodeBlock' => 414
		}
	},
	{#State 411
		ACTIONS => {
			'LBRACE' => 341
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
			"undef" => 100,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED_VOID' => 103,
			"%{" => 97,
			'OP01_OPEN' => 93,
			'OP01_NAMED_VOID_LPAREN' => 92,
			'LITERAL_NUMBER' => 94,
			'MY' => 95,
			'OP01_CLOSE' => 114,
			'LBRACE' => 115,
			'WORD_SCOPED' => 27,
			'OP19_LOOP_CONTROL_SCOLON' => 117,
			'LPAREN' => 110,
			'WORD' => 26,
			"if" => 111,
			'WORD_UPPERCASE' => 107,
			'LITERAL_STRING' => 108,
			'OP05_LOGICAL_NEG' => 109,
			"while" => -142,
			"for" => -142,
			'OP01_NAMED_VOID_SCOLON' => 106,
			'OP03_MATH_INC_DEC' => 80,
			'OP01_NAMED' => 81,
			'OP01_PRINT' => 78,
			"\@{" => 79,
			"}" => 418,
			'OP05_MATH_NEG_LPAREN' => 72,
			'LBRACKET' => 75,
			'OP19_LOOP_CONTROL' => 88,
			"foreach" => -142,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'ArrayDereference' => 86,
			'LoopLabel' => 105,
			'Literal' => 84,
			'SubExpression' => 83,
			'HashDereference' => 85,
			'WordScoped' => 113,
			'VariableModification' => 112,
			'OperatorVoid' => 89,
			'Statement' => 90,
			'VariableDeclaration' => 116,
			'PAREN-35' => 76,
			'Operation' => 417,
			'HashReference' => 98,
			'OPTIONAL-36' => 77,
			'ArrayReference' => 71,
			'Operator' => 73,
			'Variable' => 104,
			'Conditional' => 102,
			'Expression' => 99
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
			'OP21_LIST_COMMA' => 421,
			")" => 419
		},
		GOTOS => {
			'PAREN-28' => 420
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
		DEFAULT => -71
	},
	{#State 421
		ACTIONS => {
			'MY' => 424
		}
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
			'WORD' => 56,
			'TYPE_INTEGER' => 55
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
Expression_124 => 'RPerl::Operation::Expression::Operator',                             # Expression -> Operator
Expression_125 => 'RPerl::Operation::Expression::SubroutineCall',                       # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_126 => 'RPerl::Operation::Expression::ConstantCall',                         # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_127 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',           # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_128 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_129 => 'RPerl::Operation::Expression',                                    # SubExpression -> Expression
SubExpression_130 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined', # SubExpression -> 'undef'
SubExpression_131 => 'RPerl::Operation::Expression::SubExpression::Literal',            # SubExpression -> Literal
SubExpression_132 => 'RPerl::Operation::Expression::SubExpression::Variable',           # SubExpression -> Variable
SubExpression_133 => 'RPerl::DataStructure::Array::Reference',                          # SubExpression -> ArrayReference
SubExpression_134 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',   # SubExpression -> ArrayDereference
SubExpression_135 => 'RPerl::DataStructure::Hash::Reference',                           # SubExpression -> HashReference
SubExpression_136 => 'RPerl::Operation::Expression::SubExpression::HashDereference',    # SubExpression -> HashDereference
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',        # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrStdin_138 => 'RPerl::Operation::Expression::SubExpression',              # SubExpressionOrStdin -> SubExpression
SubExpressionOrStdin_139 => 'RPerl::InputOutput::Stdin',                                # SubExpressionOrStdin -> STDIN
Statement_143 => 'RPerl::Operation::Statement::Conditional',                            # Statement -> Conditional
Statement_144 => 'RPerl::Operation::Statement::Loop',                                   # Statement -> OPTIONAL-36 Loop
Statement_145 => 'RPerl::Operation::Statement::OperatorVoid',                           # Statement -> OperatorVoid
Statement_146 => 'RPerl::Operation::Statement::VariableDeclaration',                    # Statement -> VariableDeclaration
Statement_147 => 'RPerl::Operation::Statement::VariableModification',                   # Statement -> VariableModification
Conditional_154 => 'RPerl::Operation::Statement::Conditional',                          # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_155 => 'RPerl::Operation::Statement::Loop::For',                                   # Loop -> LoopFor
Loop_156 => 'RPerl::Operation::Statement::Loop::ForEach',                               # Loop -> LoopForEach
Loop_157 => 'RPerl::Operation::Statement::Loop::While',                                 # Loop -> LoopWhile
LoopFor_158 => 'RPerl::Operation::Statement::Loop::For',                                # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopForEach_159 => 'RPerl::Operation::Statement::Loop::ForEach',                        # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_160 => 'RPerl::Operation::Statement::Loop::While',                            # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
CodeBlock_163 => 'RPerl::CodeBlock',                                                    # CodeBlock -> LBRACE PLUS-41 '}'
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
