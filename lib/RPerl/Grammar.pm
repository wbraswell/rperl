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
    our $VERSION = 0.001_110;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|\=\ sub\ \{|\$TYPED_|foreach|undef|while|elsif|else|use|for|our|\@_\;|\@\{|if|\%\{|\;|\}|\]|\))}gc and return ($1, $1);

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
  [ 'Type_211' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_212' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_213' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_214' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_215' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_216' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_217' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_218' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'Literal_219' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_220' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'TypeInner_212' => 212,
  'TypeInnerConstant_213' => 213,
  'VariableOrLiteral_214' => 214,
  'VariableOrLiteral_215' => 215,
  'VariableOrLiteralOrWord_216' => 216,
  'VariableOrLiteralOrWord_217' => 217,
  'VariableOrLiteralOrWord_218' => 218,
  'Literal_219' => 219,
  'Literal_220' => 220,
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
			"package" => -20,
			'SHEBANG' => 2,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'Critic' => 1,
			'Program' => 7,
			'CompileUnit' => 6,
			'OPTIONAL-9' => 3,
			'PAREN-1' => 9,
			'PLUS-2' => 8,
			'ModuleHeader' => 5
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 4,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 10,
			'OPTIONAL-3' => 11
		}
	},
	{#State 3
		ACTIONS => {
			"package" => 12
		}
	},
	{#State 4
		ACTIONS => {
			'WORD' => 14
		},
		GOTOS => {
			'PLUS-14' => 13
		}
	},
	{#State 5
		ACTIONS => {
			"our" => -25,
			"use constant" => -25,
			"use parent qw(" => 18,
			"## no critic qw(" => -25,
			"use" => -25
		},
		GOTOS => {
			'Package' => 16,
			'Module' => 19,
			'STAR-10' => 15,
			'Class' => 17
		}
	},
	{#State 6
		ACTIONS => {
			'' => 20
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'OPTIONAL-9' => 3,
			'PAREN-1' => 21,
			'Critic' => 1
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		DEFAULT => -6
	},
	{#State 11
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 12
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 13
		ACTIONS => {
			'WORD' => 28,
			")" => 27
		}
	},
	{#State 14
		DEFAULT => -35
	},
	{#State 15
		ACTIONS => {
			"use" => -27,
			"## no critic qw(" => 4,
			"use constant" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 30,
			'Critic' => 29
		}
	},
	{#State 16
		DEFAULT => -22
	},
	{#State 17
		DEFAULT => -23
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 19
		DEFAULT => -1
	},
	{#State 20
		DEFAULT => 0
	},
	{#State 21
		DEFAULT => -2
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
		DEFAULT => -208
	},
	{#State 25
		ACTIONS => {
			";" => 34
		}
	},
	{#State 26
		DEFAULT => -207
	},
	{#State 27
		DEFAULT => -36
	},
	{#State 28
		DEFAULT => -34
	},
	{#State 29
		DEFAULT => -24
	},
	{#State 30
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 35
		},
		GOTOS => {
			'Include' => 37,
			'STAR-12' => 36
		}
	},
	{#State 31
		ACTIONS => {
			")" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -11,
			"%{" => -11,
			'LPAREN' => -11,
			'OP01_NAMED' => -11,
			'LITERAL_NUMBER' => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			'MY' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'WORD_SCOPED' => -11,
			"foreach" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LBRACE' => -11,
			'OP01_PRINT' => -11,
			'OP01_OPEN' => -11,
			'LBRACKET' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"use" => -11,
			'OP01_CLOSE' => -11,
			"if" => -11,
			"while" => -11,
			'OP01_NAMED_VOID' => -11,
			'WORD' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"use constant" => -11,
			'LITERAL_STRING' => -11,
			"undef" => -11,
			'OP10_NAMED_UNARY' => -11,
			"\@{" => -11,
			"## no critic qw(" => 4,
			"our" => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP19_LOOP_CONTROL' => -11
		},
		GOTOS => {
			'STAR-5' => 40,
			'Critic' => 41
		}
	},
	{#State 34
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 42
		}
	},
	{#State 35
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 36
		ACTIONS => {
			"use constant" => 46,
			"our" => 48
		},
		GOTOS => {
			'Subroutine' => 47,
			'PLUS-13' => 44,
			'Constant' => 45
		}
	},
	{#State 37
		DEFAULT => -26
	},
	{#State 38
		ACTIONS => {
			";" => 49
		}
	},
	{#State 39
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 40
		ACTIONS => {
			'MY' => -13,
			'WORD_SCOPED' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'WORD_UPPERCASE' => -13,
			"for" => -13,
			'VARIABLE_SYMBOL' => -13,
			"foreach" => -13,
			'LPAREN' => -13,
			"%{" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_CLOSE' => -13,
			"use" => 35,
			'LBRACE' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'LBRACKET' => -13,
			'OP01_PRINT' => -13,
			'OP01_OPEN' => -13,
			"use constant" => -13,
			'LITERAL_STRING' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"\@{" => -13,
			'OP10_NAMED_UNARY' => -13,
			"undef" => -13,
			'OP01_NAMED_VOID' => -13,
			"if" => -13,
			"while" => -13,
			'WORD' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"our" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13
		},
		GOTOS => {
			'STAR-6' => 52,
			'Include' => 51
		}
	},
	{#State 41
		DEFAULT => -8
	},
	{#State 42
		DEFAULT => -21
	},
	{#State 43
		ACTIONS => {
			'OP01_QW' => 53,
			";" => 54
		}
	},
	{#State 44
		ACTIONS => {
			"our" => 48,
			'LITERAL_NUMBER' => 56
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		ACTIONS => {
			'WORD_UPPERCASE' => 57
		}
	},
	{#State 47
		DEFAULT => -31
	},
	{#State 48
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 35
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
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			"\@{" => -15,
			"undef" => -15,
			'OP10_NAMED_UNARY' => -15,
			"use constant" => 46,
			'LITERAL_STRING' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'WORD' => -15,
			'OP01_NAMED_VOID' => -15,
			"while" => -15,
			"if" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"our" => -15,
			'VARIABLE_SYMBOL' => -15,
			"foreach" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'MY' => -15,
			'WORD_SCOPED' => -15,
			'WORD_UPPERCASE' => -15,
			"for" => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED' => -15,
			'LPAREN' => -15,
			"%{" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LBRACKET' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_OPEN' => -15,
			'OP01_PRINT' => -15,
			'LBRACE' => -15,
			'OP22_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'STAR-7' => 63,
			'Constant' => 64
		}
	},
	{#State 53
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 54
		DEFAULT => -39
	},
	{#State 55
		DEFAULT => -30
	},
	{#State 56
		ACTIONS => {
			";" => 67
		}
	},
	{#State 57
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
	},
	{#State 58
		DEFAULT => -210
	},
	{#State 59
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		}
	},
	{#State 60
		DEFAULT => -211
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
			"our" => 48,
			'OP01_NAMED_VOID_LPAREN' => 75,
			'OP19_LOOP_CONTROL' => 73,
			'OP01_NAMED_VOID' => 89,
			"while" => -143,
			"if" => 88,
			'WORD' => 26,
			'LITERAL_STRING' => 85,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'OP01_PRINT' => 95,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 111,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 109,
			'WORD_UPPERCASE' => 108,
			"for" => -143,
			'VARIABLE_SYMBOL' => 107,
			"foreach" => -143
		},
		GOTOS => {
			'LoopLabel' => 84,
			'HashDereference' => 86,
			'Operation' => 76,
			'PLUS-8' => 106,
			'Literal' => 81,
			'Expression' => 80,
			'Variable' => 82,
			'Subroutine' => 114,
			'OPTIONAL-36' => 115,
			'OperatorVoid' => 87,
			'WordScoped' => 92,
			'VariableModification' => 93,
			'HashReference' => 72,
			'ArrayReference' => 90,
			'Operator' => 71,
			'Statement' => 100,
			'SubExpression' => 101,
			'Conditional' => 103,
			'PAREN-35' => 104,
			'VariableDeclaration' => 96,
			'ArrayDereference' => 74
		}
	},
	{#State 64
		DEFAULT => -12
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			'WORD' => 118,
			")" => 119
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		ACTIONS => {
			'MY' => 121
		},
		GOTOS => {
			'TypeInnerConstant' => 120
		}
	},
	{#State 69
		ACTIONS => {
			"= sub {" => 122
		}
	},
	{#State 70
		ACTIONS => {
			"use" => -54,
			"## no critic qw(" => 4,
			"our hashref \$properties" => -54,
			"use constant" => -54
		},
		GOTOS => {
			'STAR-21' => 123,
			'Critic' => 124
		}
	},
	{#State 71
		DEFAULT => -124
	},
	{#State 72
		DEFAULT => -136
	},
	{#State 73
		ACTIONS => {
			'WORD_UPPERCASE' => 126
		},
		GOTOS => {
			'LoopLabel' => 125
		}
	},
	{#State 74
		DEFAULT => -135
	},
	{#State 75
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 135,
			'WORD_UPPERCASE' => 133,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_CLOSE' => 91,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 94,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			")" => -111
		},
		GOTOS => {
			'OPTIONAL-32' => 129,
			'Operator' => 71,
			'Variable' => 128,
			'Expression' => 127,
			'Literal' => 81,
			'ArrayReference' => 90,
			'HashReference' => 72,
			'HashDereference' => 86,
			'TypeInner' => 134,
			'ListElement' => 132,
			'WordScoped' => 92,
			'ListElements' => 137,
			'ArrayDereference' => 74,
			'SubExpression' => 131
		}
	},
	{#State 76
		DEFAULT => -17
	},
	{#State 77
		ACTIONS => {
			"\@{" => 79,
			'OP11_COMPARE_LT_GT' => -95,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'LITERAL_STRING' => 85,
			'OP16_LOGICAL_OR' => -95,
			'WORD' => 26,
			'OP21_LIST_COMMA' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP08_STRING_CAT' => -95,
			'OP04_MATH_POW' => -95,
			";" => -95,
			'OP18_TERNARY' => -95,
			'OP06_REGEX_MATCH' => -95,
			")" => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'VARIABLE_SYMBOL' => 107,
			'OP23_LOGICAL_AND' => -95,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 133,
			'OP09_BITWISE_SHIFT' => -95,
			'OP07_STRING_REPEAT' => -95,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116,
			"]" => -95,
			'OP01_CLOSE' => 91,
			"}" => -95,
			'OP03_MATH_INC_DEC' => 94,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP15_LOGICAL_AND' => -95,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP22_LOGICAL_NEG' => 102,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP13_BITWISE_AND' => -95
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 138,
			'Variable' => 128,
			'Operator' => 71,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81,
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92
		}
	},
	{#State 78
		DEFAULT => -131
	},
	{#State 79
		ACTIONS => {
			'LBRACKET' => -189,
			'VARIABLE_SYMBOL' => 107,
			'MY' => 135
		},
		GOTOS => {
			'Variable' => 139,
			'TypeInner' => 141,
			'OPTIONAL-47' => 140
		}
	},
	{#State 80
		ACTIONS => {
			'OP23_LOGICAL_AND' => -130,
			'OP11_COMPARE_LT_GT' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP16_LOGICAL_OR' => -130,
			'OP07_STRING_REPEAT' => -130,
			'OP18_TERNARY' => -130,
			";" => 142,
			'OP06_REGEX_MATCH' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP08_STRING_CAT' => -130,
			'OP04_MATH_POW' => -130
		}
	},
	{#State 81
		DEFAULT => -132
	},
	{#State 82
		ACTIONS => {
			'OP16_LOGICAL_OR' => -133,
			'OP07_STRING_REPEAT' => -133,
			'OP09_BITWISE_SHIFT' => -133,
			'OP11_COMPARE_LT_GT' => -133,
			'OP02_METHOD_THINARROW' => 146,
			'OP23_LOGICAL_AND' => -133,
			'OP04_MATH_POW' => -133,
			'OP03_MATH_INC_DEC' => 144,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP08_STRING_CAT' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP17_LIST_RANGE' => -133,
			'OP19_VARIABLE_ASSIGN_BY' => 143,
			'OP13_BITWISE_AND' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP12_COMPARE_EQ_NE' => -133,
			'OP19_VARIABLE_ASSIGN' => 145,
			'OP15_LOGICAL_AND' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP18_TERNARY' => -133
		}
	},
	{#State 83
		DEFAULT => -118
	},
	{#State 84
		ACTIONS => {
			'COLON' => 147
		}
	},
	{#State 85
		DEFAULT => -220
	},
	{#State 86
		DEFAULT => -137
	},
	{#State 87
		DEFAULT => -146
	},
	{#State 88
		ACTIONS => {
			'LPAREN' => 148
		}
	},
	{#State 89
		ACTIONS => {
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 135,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_CLOSE' => 91,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105
		},
		GOTOS => {
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Variable' => 128,
			'Operator' => 71,
			'ListElement' => 132,
			'WordScoped' => 92,
			'TypeInner' => 134,
			'HashDereference' => 86,
			'HashReference' => 72,
			'ArrayDereference' => 74,
			'ListElements' => 149,
			'SubExpression' => 131
		}
	},
	{#State 90
		DEFAULT => -134
	},
	{#State 91
		ACTIONS => {
			'FHREF_SYMBOL' => 150
		}
	},
	{#State 92
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 152,
			'SCOPE' => 153,
			'LPAREN' => 151
		}
	},
	{#State 93
		DEFAULT => -148
	},
	{#State 94
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'Variable' => 154
		}
	},
	{#State 95
		ACTIONS => {
			'OP01_QW' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP01_CLOSE' => -109,
			'LBRACE' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'OP01_OPEN' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'LBRACKET' => -109,
			'WORD_UPPERCASE' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'MY' => -109,
			'WORD_SCOPED' => -109,
			'LITERAL_STRING' => -109,
			"\@{" => -109,
			"undef" => -109,
			'OP10_NAMED_UNARY' => -109,
			'VARIABLE_SYMBOL' => -109,
			'STDOUT_STDERR' => 157,
			'LPAREN' => -109,
			'FHREF_SYMBOL_BRACES' => 156,
			"%{" => -109,
			'OP01_NAMED' => -109,
			'WORD' => -109,
			'LITERAL_NUMBER' => -109
		},
		GOTOS => {
			'PAREN-30' => 155,
			'OPTIONAL-31' => 158
		}
	},
	{#State 96
		DEFAULT => -147
	},
	{#State 97
		ACTIONS => {
			'MY' => 159
		}
	},
	{#State 98
		ACTIONS => {
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 160,
			'Variable' => 128,
			'Operator' => 71,
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92
		}
	},
	{#State 99
		ACTIONS => {
			"]" => -186,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'MY' => 135,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_QW' => 130,
			'OP01_CLOSE' => 91
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'OPTIONAL-46' => 161,
			'Operator' => 71,
			'Variable' => 128,
			'WordScoped' => 92,
			'ListElement' => 132,
			'HashDereference' => 86,
			'HashReference' => 72,
			'TypeInner' => 134,
			'ListElements' => 162,
			'ArrayDereference' => 74,
			'SubExpression' => 131
		}
	},
	{#State 100
		DEFAULT => -77
	},
	{#State 101
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => 179,
			'OP08_MATH_ADD_SUB' => 168,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP18_TERNARY' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 165,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166
		}
	},
	{#State 102
		ACTIONS => {
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			"%{" => 116,
			'LPAREN' => 117,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'SubExpression' => 180,
			'ArrayDereference' => 74,
			'HashDereference' => 86,
			'HashReference' => 72,
			'WordScoped' => 92,
			'Variable' => 128,
			'Operator' => 71,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81
		}
	},
	{#State 103
		DEFAULT => -144
	},
	{#State 104
		DEFAULT => -142
	},
	{#State 105
		ACTIONS => {
			'LITERAL_NUMBER' => 112,
			'WORD' => 181,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_STRING' => 85,
			"%{" => 116,
			"}" => 186
		},
		GOTOS => {
			'HashDereference' => 182,
			'HashEntry' => 185,
			'VariableOrLiteralOrWord' => 187,
			'Variable' => 184,
			'Literal' => 183
		}
	},
	{#State 106
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			'OP01_NAMED_VOID' => 89,
			"if" => 88,
			"while" => -143,
			'WORD' => 26,
			'OP19_LOOP_CONTROL' => 73,
			'OP01_NAMED_VOID_LPAREN' => 75,
			'MY' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			"for" => -143,
			'WORD_UPPERCASE' => 108,
			'VARIABLE_SYMBOL' => 107,
			"foreach" => -143,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'LITERAL_NUMBER' => 112,
			'' => -18,
			'OP01_NAMED' => 111,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'OP01_PRINT' => 95
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Operator' => 71,
			'WordScoped' => 92,
			'VariableModification' => 93,
			'HashReference' => 72,
			'VariableDeclaration' => 96,
			'ArrayDereference' => 74,
			'SubExpression' => 101,
			'Statement' => 100,
			'Conditional' => 103,
			'PAREN-35' => 104,
			'Expression' => 80,
			'Literal' => 81,
			'Operation' => 188,
			'Variable' => 82,
			'LoopLabel' => 84,
			'HashDereference' => 86,
			'OperatorVoid' => 87,
			'OPTIONAL-36' => 115
		}
	},
	{#State 107
		DEFAULT => -166,
		GOTOS => {
			'STAR-42' => 189
		}
	},
	{#State 108
		ACTIONS => {
			'LPAREN' => 190,
			'COLON' => -209
		}
	},
	{#State 109
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'TYPE_FHREF' => 191,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 192
		}
	},
	{#State 110
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'Literal' => 81,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Variable' => 128,
			'Operator' => 71,
			'SubExpression' => 193,
			'ArrayDereference' => 74
		}
	},
	{#State 111
		ACTIONS => {
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'WORD_UPPERCASE' => 133,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 135,
			'LITERAL_STRING' => 85,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'ListElement' => 194,
			'WordScoped' => 92,
			'TypeInner' => 134,
			'HashDereference' => 86,
			'HashReference' => 72,
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Operator' => 71,
			'Variable' => 128,
			'SubExpression' => 195,
			'ArrayDereference' => 74
		}
	},
	{#State 112
		DEFAULT => -219
	},
	{#State 113
		DEFAULT => -114
	},
	{#State 114
		DEFAULT => -14
	},
	{#State 115
		ACTIONS => {
			"while" => 198,
			"for" => 200,
			"foreach" => 199
		},
		GOTOS => {
			'LoopFor' => 201,
			'LoopForEach' => 196,
			'Loop' => 197,
			'LoopWhile' => 202
		}
	},
	{#State 116
		ACTIONS => {
			'MY' => 135,
			'LBRACE' => -204,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'TypeInner' => 205,
			'Variable' => 204,
			'OPTIONAL-51' => 203
		}
	},
	{#State 117
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_PRINT' => 207,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 206,
			'LPAREN' => 117,
			"%{" => 116,
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 208,
			'Operator' => 71,
			'Variable' => 128,
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'HashDereference' => 86,
			'HashReference' => 72,
			'WordScoped' => 92
		}
	},
	{#State 118
		DEFAULT => -37
	},
	{#State 119
		ACTIONS => {
			";" => 209
		}
	},
	{#State 120
		ACTIONS => {
			'LITERAL_NUMBER' => 112,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Literal' => 210
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 211
		}
	},
	{#State 122
		ACTIONS => {
			'LPAREN' => -43,
			"%{" => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_NAMED' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'MY' => -43,
			'WORD_SCOPED' => -43,
			'WORD_UPPERCASE' => -43,
			"for" => -43,
			'LPAREN_MY' => 214,
			'VARIABLE_SYMBOL' => -43,
			"foreach" => -43,
			'LBRACE' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'LBRACKET' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_PRINT' => -43,
			'OP01_OPEN' => -43,
			"}" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_CLOSE' => -43,
			'OP01_NAMED_VOID' => -43,
			"while" => -43,
			"if" => -43,
			'WORD' => -43,
			'LITERAL_STRING' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			"\@{" => -43,
			'OP10_NAMED_UNARY' => -43,
			"undef" => -43,
			'OP01_NAMED_VOID_LPAREN' => -43,
			'OP19_LOOP_CONTROL' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 213,
			'OPTIONAL-16' => 212
		}
	},
	{#State 123
		ACTIONS => {
			"use constant" => -56,
			"our hashref \$properties" => -56,
			"use" => 35
		},
		GOTOS => {
			'Include' => 215,
			'STAR-22' => 216
		}
	},
	{#State 124
		DEFAULT => -51
	},
	{#State 125
		ACTIONS => {
			";" => 217
		}
	},
	{#State 126
		DEFAULT => -209
	},
	{#State 127
		DEFAULT => -130
	},
	{#State 128
		ACTIONS => {
			'OP17_LIST_RANGE' => -133,
			'OP24_LOGICAL_OR_XOR' => -133,
			'OP03_MATH_INC_DEC' => 144,
			'OP04_MATH_POW' => -133,
			"}" => -133,
			'OP08_STRING_CAT' => -133,
			'OP07_MATH_MULT_DIV_MOD' => -133,
			'OP18_TERNARY' => -133,
			";" => -133,
			'OP15_LOGICAL_AND' => -133,
			'OP06_REGEX_MATCH' => -133,
			'OP12_COMPARE_EQ_NE' => -133,
			'OP13_BITWISE_AND' => -133,
			'OP14_BITWISE_OR_XOR' => -133,
			")" => -133,
			'OP08_MATH_ADD_SUB' => -133,
			'OP23_LOGICAL_AND' => -133,
			'OP02_METHOD_THINARROW' => 146,
			'OP11_COMPARE_LT_GT' => -133,
			'OP16_LOGICAL_OR' => -133,
			'OP07_STRING_REPEAT' => -133,
			'OP09_BITWISE_SHIFT' => -133,
			"]" => -133,
			'OP21_LIST_COMMA' => -133
		}
	},
	{#State 129
		ACTIONS => {
			")" => 218
		}
	},
	{#State 130
		ACTIONS => {
			'WORD' => 220
		},
		GOTOS => {
			'PLUS-45' => 219
		}
	},
	{#State 131
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -182,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP18_TERNARY' => 169,
			";" => -182,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 165,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP21_LIST_COMMA' => -182,
			"]" => -182,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172
		}
	},
	{#State 132
		DEFAULT => -178,
		GOTOS => {
			'STAR-44' => 221
		}
	},
	{#State 133
		ACTIONS => {
			'LPAREN' => 190
		}
	},
	{#State 134
		ACTIONS => {
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'LPAREN' => 117,
			"%{" => 116,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 85,
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Expression' => 127,
			'Variable' => 128,
			'Operator' => 71,
			'SubExpression' => 222,
			'ArrayDereference' => 74
		}
	},
	{#State 135
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 223
		}
	},
	{#State 136
		ACTIONS => {
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Literal' => 81,
			'Expression' => 127,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86,
			'ArrayDereference' => 74,
			'SubExpression' => 224
		}
	},
	{#State 137
		DEFAULT => -110
	},
	{#State 138
		ACTIONS => {
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 170,
			'OP18_TERNARY' => -94,
			";" => -94,
			'OP13_BITWISE_AND' => -94,
			")" => -94,
			'OP08_MATH_ADD_SUB' => 168,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP04_MATH_POW' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -94,
			'OP08_STRING_CAT' => 164,
			"]" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => -94,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 139
		ACTIONS => {
			"}" => 225
		}
	},
	{#State 140
		ACTIONS => {
			'LBRACKET' => 99
		},
		GOTOS => {
			'ArrayReference' => 226
		}
	},
	{#State 141
		DEFAULT => -188
	},
	{#State 142
		DEFAULT => -76
	},
	{#State 143
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'Variable' => 128,
			'Operator' => 71,
			'SubExpression' => 227,
			'ArrayDereference' => 74
		}
	},
	{#State 144
		DEFAULT => -84
	},
	{#State 145
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 133,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'STDIN' => 230,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105
		},
		GOTOS => {
			'Literal' => 81,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Variable' => 128,
			'Operator' => 71,
			'SubExpressionOrStdin' => 229,
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86,
			'ArrayDereference' => 74,
			'SubExpression' => 228
		}
	},
	{#State 146
		ACTIONS => {
			'LPAREN' => 231
		}
	},
	{#State 147
		DEFAULT => -141
	},
	{#State 148
		ACTIONS => {
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'WORD_UPPERCASE' => 133,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 85,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'Operator' => 71,
			'Variable' => 128,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'HashDereference' => 86,
			'HashReference' => 72,
			'WordScoped' => 92,
			'ArrayDereference' => 74,
			'SubExpression' => 232
		}
	},
	{#State 149
		ACTIONS => {
			";" => 233
		}
	},
	{#State 150
		DEFAULT => -82
	},
	{#State 151
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			'OP01_QW' => 130,
			'OP01_CLOSE' => 91,
			")" => -121,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 135,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26
		},
		GOTOS => {
			'ArrayReference' => 90,
			'OPTIONAL-33' => 235,
			'Expression' => 127,
			'Literal' => 81,
			'Operator' => 71,
			'Variable' => 128,
			'ListElement' => 132,
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'TypeInner' => 134,
			'ListElements' => 234,
			'ArrayDereference' => 74,
			'SubExpression' => 131
		}
	},
	{#State 152
		ACTIONS => {
			")" => 236
		}
	},
	{#State 153
		ACTIONS => {
			'WORD_UPPERCASE' => 237
		}
	},
	{#State 154
		DEFAULT => -83
	},
	{#State 155
		DEFAULT => -108
	},
	{#State 156
		ACTIONS => {
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_QW' => 130,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'LPAREN' => 117,
			"%{" => 116,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'MY' => 135,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'ListElements' => 238,
			'SubExpression' => 131,
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Operator' => 71,
			'Variable' => 128,
			'ListElement' => 132,
			'WordScoped' => 92,
			'TypeInner' => 134,
			'HashDereference' => 86,
			'HashReference' => 72
		}
	},
	{#State 157
		DEFAULT => -107
	},
	{#State 158
		ACTIONS => {
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'MY' => 135,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_QW' => 130,
			'OP01_CLOSE' => 91
		},
		GOTOS => {
			'Variable' => 128,
			'Operator' => 71,
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'TypeInner' => 134,
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92,
			'ListElement' => 132,
			'ArrayDereference' => 74,
			'ListElements' => 239,
			'SubExpression' => 131
		}
	},
	{#State 159
		ACTIONS => {
			'TYPE_FHREF' => 240
		}
	},
	{#State 160
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP07_STRING_REPEAT' => -86,
			"]" => -86,
			'OP21_LIST_COMMA' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			"}" => -86,
			'OP08_STRING_CAT' => -86,
			'OP04_MATH_POW' => 165,
			'OP15_LOGICAL_AND' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP18_TERNARY' => -86,
			";" => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			")" => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP12_COMPARE_EQ_NE' => -86
		}
	},
	{#State 161
		ACTIONS => {
			"]" => 241
		}
	},
	{#State 162
		DEFAULT => -185
	},
	{#State 163
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 242,
			'Literal' => 81,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86
		}
	},
	{#State 164
		ACTIONS => {
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			"%{" => 116,
			'LPAREN' => 117
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Literal' => 81,
			'Expression' => 127,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86,
			'ArrayDereference' => 74,
			'SubExpression' => 243
		}
	},
	{#State 165
		ACTIONS => {
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116,
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 244,
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 245,
			'Operator' => 71,
			'Variable' => 128,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92
		}
	},
	{#State 167
		ACTIONS => {
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			"%{" => 116,
			'LPAREN' => 117,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110
		},
		GOTOS => {
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92,
			'Operator' => 71,
			'Variable' => 128,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'SubExpression' => 246,
			'ArrayDereference' => 74
		}
	},
	{#State 168
		ACTIONS => {
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 133,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			"%{" => 116,
			'LPAREN' => 117
		},
		GOTOS => {
			'SubExpression' => 247,
			'ArrayDereference' => 74,
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92,
			'Variable' => 128,
			'Operator' => 71,
			'Literal' => 81,
			'ArrayReference' => 90,
			'Expression' => 127
		}
	},
	{#State 169
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 112,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Literal' => 248,
			'Variable' => 249,
			'VariableOrLiteral' => 250
		}
	},
	{#State 170
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 251
		}
	},
	{#State 171
		ACTIONS => {
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'LPAREN' => 117,
			"%{" => 116,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Operator' => 71,
			'Variable' => 128,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81,
			'HashDereference' => 86,
			'HashReference' => 72,
			'WordScoped' => 92,
			'ArrayDereference' => 74,
			'SubExpression' => 252
		}
	},
	{#State 172
		ACTIONS => {
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'LPAREN' => 117,
			"%{" => 116,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'SubExpression' => 253,
			'ArrayDereference' => 74,
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92,
			'Operator' => 71,
			'Variable' => 128,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81
		}
	},
	{#State 173
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'Operator' => 71,
			'Variable' => 128,
			'SubExpression' => 254,
			'ArrayDereference' => 74
		}
	},
	{#State 174
		ACTIONS => {
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			"%{" => 116,
			'LPAREN' => 117,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Expression' => 127,
			'Variable' => 128,
			'Operator' => 71,
			'SubExpression' => 255,
			'ArrayDereference' => 74
		}
	},
	{#State 175
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'ArrayDereference' => 74,
			'SubExpression' => 256
		}
	},
	{#State 176
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'WORD_UPPERCASE' => 133,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 85,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 257,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72
		}
	},
	{#State 177
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136
		},
		GOTOS => {
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92,
			'Operator' => 71,
			'Variable' => 128,
			'Expression' => 127,
			'Literal' => 81,
			'ArrayReference' => 90,
			'SubExpression' => 258,
			'ArrayDereference' => 74
		}
	},
	{#State 178
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Operator' => 71,
			'Variable' => 128,
			'SubExpression' => 259,
			'ArrayDereference' => 74
		}
	},
	{#State 179
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'SubExpression' => 260,
			'ArrayDereference' => 74,
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'Operator' => 71,
			'Variable' => 128
		}
	},
	{#State 180
		ACTIONS => {
			'OP23_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 172,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177,
			'OP21_LIST_COMMA' => -104,
			"]" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP17_LIST_RANGE' => 167,
			'OP04_MATH_POW' => 165,
			"}" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP18_TERNARY' => 169,
			";" => -104,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 174,
			")" => -104,
			'OP08_MATH_ADD_SUB' => 168
		}
	},
	{#State 181
		DEFAULT => -218
	},
	{#State 182
		DEFAULT => -195
	},
	{#State 183
		DEFAULT => -217
	},
	{#State 184
		DEFAULT => -216
	},
	{#State 185
		DEFAULT => -200,
		GOTOS => {
			'STAR-50' => 261
		}
	},
	{#State 186
		DEFAULT => -202
	},
	{#State 187
		ACTIONS => {
			'OP20_HASH_FATARROW' => 262
		}
	},
	{#State 188
		DEFAULT => -16
	},
	{#State 189
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -167,
			'OP16_LOGICAL_OR' => -167,
			'OP07_STRING_REPEAT' => -167,
			'OP02_METHOD_THINARROW' => -167,
			'OP23_LOGICAL_AND' => -167,
			'OP11_COMPARE_LT_GT' => -167,
			'OP21_LIST_COMMA' => -167,
			"]" => -167,
			'OP02_ARRAY_THINARROW' => 264,
			'OP20_HASH_FATARROW' => -167,
			'OP07_MATH_MULT_DIV_MOD' => -167,
			"}" => -167,
			'OP08_STRING_CAT' => -167,
			'OP04_MATH_POW' => -167,
			'OP03_MATH_INC_DEC' => -167,
			'OP24_LOGICAL_OR_XOR' => -167,
			'COLON' => -167,
			'OP19_VARIABLE_ASSIGN_BY' => -167,
			'OP17_LIST_RANGE' => -167,
			'OP12_COMPARE_EQ_NE' => -167,
			")" => -167,
			'OP14_BITWISE_OR_XOR' => -167,
			'OP08_MATH_ADD_SUB' => -167,
			'OP13_BITWISE_AND' => -167,
			";" => -167,
			'OP18_TERNARY' => -167,
			'OP02_HASH_THINARROW' => 265,
			'OP15_LOGICAL_AND' => -167,
			'OP06_REGEX_MATCH' => -167,
			'OP19_VARIABLE_ASSIGN' => -167
		},
		GOTOS => {
			'VariableRetrieval' => 263
		}
	},
	{#State 190
		ACTIONS => {
			")" => 266
		}
	},
	{#State 191
		ACTIONS => {
			'FHREF_SYMBOL' => 267
		}
	},
	{#State 192
		ACTIONS => {
			'VARIABLE_SYMBOL' => 268
		}
	},
	{#State 193
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			")" => 269,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 175,
			'OP18_TERNARY' => 169,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 165,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172
		}
	},
	{#State 194
		ACTIONS => {
			'OP21_LIST_COMMA' => 270
		}
	},
	{#State 195
		ACTIONS => {
			'OP18_TERNARY' => -79,
			";" => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP13_BITWISE_AND' => -79,
			")" => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP04_MATH_POW' => -79,
			'OP08_STRING_CAT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP21_LIST_COMMA' => -182,
			'OP23_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP09_BITWISE_SHIFT' => -79
		}
	},
	{#State 196
		DEFAULT => -157
	},
	{#State 197
		DEFAULT => -145
	},
	{#State 198
		ACTIONS => {
			'LPAREN' => 271
		}
	},
	{#State 199
		ACTIONS => {
			'MY' => 272
		}
	},
	{#State 200
		ACTIONS => {
			'MY' => 273
		}
	},
	{#State 201
		DEFAULT => -156
	},
	{#State 202
		DEFAULT => -158
	},
	{#State 203
		ACTIONS => {
			'LBRACE' => 105
		},
		GOTOS => {
			'HashReference' => 274
		}
	},
	{#State 204
		ACTIONS => {
			"}" => 275
		}
	},
	{#State 205
		DEFAULT => -203
	},
	{#State 206
		ACTIONS => {
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 135,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99
		},
		GOTOS => {
			'WordScoped' => 92,
			'ListElement' => 276,
			'HashDereference' => 86,
			'HashReference' => 72,
			'TypeInner' => 134,
			'Literal' => 81,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Variable' => 128,
			'Operator' => 71,
			'SubExpression' => 195,
			'ArrayDereference' => 74
		}
	},
	{#State 207
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 277
		}
	},
	{#State 208
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP17_LIST_RANGE' => 167,
			'OP04_MATH_POW' => 165,
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP18_TERNARY' => 169,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 175,
			'OP08_MATH_ADD_SUB' => 168,
			")" => 278,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 209
		DEFAULT => -40
	},
	{#State 210
		ACTIONS => {
			";" => 279
		}
	},
	{#State 211
		ACTIONS => {
			"\$TYPED_" => 280
		}
	},
	{#State 212
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 281
		}
	},
	{#State 213
		DEFAULT => -42
	},
	{#State 214
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 282
		}
	},
	{#State 215
		DEFAULT => -53
	},
	{#State 216
		ACTIONS => {
			"our hashref \$properties" => 283,
			"use constant" => 46
		},
		GOTOS => {
			'Properties' => 285,
			'Constant' => 284
		}
	},
	{#State 217
		DEFAULT => -119
	},
	{#State 218
		ACTIONS => {
			";" => 286
		}
	},
	{#State 219
		ACTIONS => {
			'WORD' => 288,
			")" => 287
		}
	},
	{#State 220
		DEFAULT => -181
	},
	{#State 221
		ACTIONS => {
			"]" => -179,
			")" => -179,
			'OP21_LIST_COMMA' => 289,
			";" => -179
		},
		GOTOS => {
			'PAREN-43' => 290
		}
	},
	{#State 222
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 165,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -183,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			";" => -183,
			'OP18_TERNARY' => 169,
			'OP09_BITWISE_SHIFT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => 171,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => 179,
			"]" => -183,
			'OP21_LIST_COMMA' => -183
		}
	},
	{#State 223
		ACTIONS => {
			"\$TYPED_" => 291
		}
	},
	{#State 224
		ACTIONS => {
			'OP17_LIST_RANGE' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			"}" => -79,
			'OP08_STRING_CAT' => -79,
			'OP04_MATH_POW' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			";" => -79,
			'OP18_TERNARY' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			")" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP07_STRING_REPEAT' => -79,
			"]" => -79,
			'OP21_LIST_COMMA' => -79
		}
	},
	{#State 225
		DEFAULT => -190
	},
	{#State 226
		ACTIONS => {
			"}" => 292
		}
	},
	{#State 227
		ACTIONS => {
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP18_TERNARY' => 169,
			";" => 293,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP04_MATH_POW' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP17_LIST_RANGE' => 167
		}
	},
	{#State 228
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => 179,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => 171,
			'OP09_BITWISE_SHIFT' => 177,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			'OP18_TERNARY' => 169,
			";" => -139,
			'OP13_BITWISE_AND' => 175,
			'OP08_MATH_ADD_SUB' => 168,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP17_LIST_RANGE' => 167,
			'OP04_MATH_POW' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 229
		ACTIONS => {
			";" => 294
		}
	},
	{#State 230
		DEFAULT => -140
	},
	{#State 231
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 135,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_CLOSE' => 91,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 94,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			")" => -123
		},
		GOTOS => {
			'SubExpression' => 131,
			'OPTIONAL-34' => 295,
			'ArrayDereference' => 74,
			'ListElements' => 296,
			'ListElement' => 132,
			'WordScoped' => 92,
			'TypeInner' => 134,
			'HashDereference' => 86,
			'HashReference' => 72,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Variable' => 128,
			'Operator' => 71
		}
	},
	{#State 232
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP14_BITWISE_OR_XOR' => 174,
			")" => 297,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 175,
			'OP18_TERNARY' => 169,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 165,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166
		}
	},
	{#State 233
		DEFAULT => -116
	},
	{#State 234
		DEFAULT => -120
	},
	{#State 235
		ACTIONS => {
			")" => 298
		}
	},
	{#State 236
		DEFAULT => -129
	},
	{#State 237
		ACTIONS => {
			'LPAREN' => 299
		}
	},
	{#State 238
		ACTIONS => {
			";" => 300
		}
	},
	{#State 239
		ACTIONS => {
			";" => 301
		}
	},
	{#State 240
		ACTIONS => {
			'FHREF_SYMBOL' => 302
		}
	},
	{#State 241
		DEFAULT => -187
	},
	{#State 242
		ACTIONS => {
			'OP17_LIST_RANGE' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP04_MATH_POW' => 165,
			"}" => -90,
			'OP08_STRING_CAT' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP18_TERNARY' => -90,
			";" => -90,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			")" => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => -90,
			'OP21_LIST_COMMA' => -90,
			"]" => -90
		}
	},
	{#State 243
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP17_LIST_RANGE' => -92,
			"}" => -92,
			'OP08_STRING_CAT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 165,
			'OP18_TERNARY' => -92,
			";" => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP06_REGEX_MATCH' => 170,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			")" => -92,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => -92,
			'OP21_LIST_COMMA' => -92,
			"]" => -92
		}
	},
	{#State 244
		ACTIONS => {
			"]" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP15_LOGICAL_AND' => -85,
			";" => -85,
			'OP18_TERNARY' => -85,
			'OP13_BITWISE_AND' => -85,
			")" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP04_MATH_POW' => 165,
			"}" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP08_STRING_CAT' => -85
		}
	},
	{#State 245
		ACTIONS => {
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP18_TERNARY' => 169,
			";" => -106,
			'OP13_BITWISE_AND' => 175,
			")" => -106,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP04_MATH_POW' => 165,
			"}" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => 179,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 246
		ACTIONS => {
			"]" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP18_TERNARY' => -102,
			";" => -102,
			'OP13_BITWISE_AND' => 175,
			")" => -102,
			'OP08_MATH_ADD_SUB' => 168,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP04_MATH_POW' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -102,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 247
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -91,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP21_LIST_COMMA' => -91,
			"]" => -91,
			'OP08_STRING_CAT' => -91,
			"}" => -91,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 165,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			")" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP18_TERNARY' => -91,
			";" => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP06_REGEX_MATCH' => 170
		}
	},
	{#State 248
		DEFAULT => -215
	},
	{#State 249
		DEFAULT => -214
	},
	{#State 250
		ACTIONS => {
			'COLON' => 303
		}
	},
	{#State 251
		DEFAULT => -88
	},
	{#State 252
		ACTIONS => {
			"]" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => -101,
			'OP13_BITWISE_AND' => 175,
			")" => -101,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			'OP18_TERNARY' => -101,
			";" => -101,
			'OP04_MATH_POW' => 165,
			'OP08_STRING_CAT' => 164,
			"}" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP17_LIST_RANGE' => -101,
			'OP24_LOGICAL_OR_XOR' => -101
		}
	},
	{#State 253
		ACTIONS => {
			"]" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => -96,
			'OP09_BITWISE_SHIFT' => 177,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			")" => -96,
			'OP08_MATH_ADD_SUB' => 168,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 170,
			'OP18_TERNARY' => -96,
			";" => -96,
			'OP04_MATH_POW' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -96,
			'OP08_STRING_CAT' => 164,
			'OP17_LIST_RANGE' => -96,
			'OP24_LOGICAL_OR_XOR' => -96
		}
	},
	{#State 254
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => undef,
			'OP13_BITWISE_AND' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			")" => -97,
			'OP08_MATH_ADD_SUB' => 168,
			";" => -97,
			'OP18_TERNARY' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP06_REGEX_MATCH' => 170,
			'OP04_MATH_POW' => 165,
			"}" => -97,
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP17_LIST_RANGE' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			"]" => -97,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => -97,
			'OP09_BITWISE_SHIFT' => 177,
			'OP23_LOGICAL_AND' => -97,
			'OP11_COMPARE_LT_GT' => 172
		}
	},
	{#State 255
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 175,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			";" => -99,
			'OP18_TERNARY' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP06_REGEX_MATCH' => 170,
			'OP04_MATH_POW' => 165,
			'OP08_STRING_CAT' => 164,
			"}" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP17_LIST_RANGE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			"]" => -99,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => -99,
			'OP09_BITWISE_SHIFT' => 177,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => 172
		}
	},
	{#State 256
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP13_BITWISE_AND' => -98,
			";" => -98,
			'OP18_TERNARY' => -98,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 164,
			"}" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 165,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP21_LIST_COMMA' => -98,
			"]" => -98,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => -98,
			'OP07_STRING_REPEAT' => 178,
			'OP23_LOGICAL_AND' => -98,
			'OP11_COMPARE_LT_GT' => 172
		}
	},
	{#State 257
		ACTIONS => {
			"]" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => -100,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => -100,
			")" => -100,
			'OP08_MATH_ADD_SUB' => 168,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => -100,
			";" => -100,
			'OP18_TERNARY' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -100,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 165,
			'OP17_LIST_RANGE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100
		}
	},
	{#State 258
		ACTIONS => {
			'OP15_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 170,
			";" => -93,
			'OP18_TERNARY' => -93,
			")" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP08_STRING_CAT' => 164,
			"}" => -93,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 165,
			"]" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => -93
		}
	},
	{#State 259
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			")" => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP13_BITWISE_AND' => -89,
			";" => -89,
			'OP18_TERNARY' => -89,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => -89,
			'OP08_STRING_CAT' => -89,
			"}" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP04_MATH_POW' => 165,
			'OP17_LIST_RANGE' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP21_LIST_COMMA' => -89,
			"]" => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89
		}
	},
	{#State 260
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP17_LIST_RANGE' => 167,
			'OP04_MATH_POW' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			"}" => -105,
			'OP08_STRING_CAT' => 164,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			";" => -105,
			'OP18_TERNARY' => 169,
			'OP13_BITWISE_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 174,
			")" => -105,
			'OP08_MATH_ADD_SUB' => 168,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => -105,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => 171,
			'OP09_BITWISE_SHIFT' => 177,
			"]" => -105,
			'OP21_LIST_COMMA' => -105
		}
	},
	{#State 261
		ACTIONS => {
			"}" => 305,
			'OP21_LIST_COMMA' => 306
		},
		GOTOS => {
			'PAREN-49' => 304
		}
	},
	{#State 262
		ACTIONS => {
			'LPAREN' => -193,
			"%{" => -193,
			'WORD' => -193,
			'LITERAL_NUMBER' => -193,
			'OP01_NAMED' => -193,
			'WORD_SCOPED' => -193,
			'MY' => 135,
			'OP05_MATH_NEG_LPAREN' => -193,
			'LITERAL_STRING' => -193,
			'WORD_UPPERCASE' => -193,
			'VARIABLE_SYMBOL' => -193,
			"\@{" => -193,
			'OP10_NAMED_UNARY' => -193,
			"undef" => -193,
			'LBRACE' => -193,
			'OP22_LOGICAL_NEG' => -193,
			'OP05_LOGICAL_NEG' => -193,
			'LBRACKET' => -193,
			'OP01_OPEN' => -193,
			'OP03_MATH_INC_DEC' => -193,
			'OP01_CLOSE' => -193
		},
		GOTOS => {
			'OPTIONAL-48' => 307,
			'TypeInner' => 308
		}
	},
	{#State 263
		DEFAULT => -165
	},
	{#State 264
		ACTIONS => {
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105
		},
		GOTOS => {
			'Variable' => 128,
			'Operator' => 71,
			'Literal' => 81,
			'ArrayReference' => 90,
			'Expression' => 127,
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92,
			'ArrayDereference' => 74,
			'SubExpression' => 309
		}
	},
	{#State 265
		ACTIONS => {
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 311,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91
		},
		GOTOS => {
			'SubExpression' => 310,
			'ArrayDereference' => 74,
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'Operator' => 71,
			'Variable' => 128
		}
	},
	{#State 266
		DEFAULT => -126
	},
	{#State 267
		ACTIONS => {
			";" => 312
		}
	},
	{#State 268
		ACTIONS => {
			";" => 314,
			'OP19_VARIABLE_ASSIGN' => 313
		}
	},
	{#State 269
		DEFAULT => -87
	},
	{#State 270
		ACTIONS => {
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116,
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'MY' => 135,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_QW' => 130
		},
		GOTOS => {
			'WordScoped' => 92,
			'ListElement' => 132,
			'TypeInner' => 134,
			'HashReference' => 72,
			'HashDereference' => 86,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Expression' => 127,
			'Operator' => 71,
			'Variable' => 128,
			'SubExpression' => 131,
			'ArrayDereference' => 74,
			'ListElements' => 315
		}
	},
	{#State 271
		ACTIONS => {
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'WORD_UPPERCASE' => 133,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Variable' => 128,
			'Operator' => 71,
			'SubExpression' => 316,
			'ArrayDereference' => 74
		}
	},
	{#State 272
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 317
		}
	},
	{#State 273
		ACTIONS => {
			'TYPE_INTEGER' => 318
		}
	},
	{#State 274
		ACTIONS => {
			"}" => 319
		}
	},
	{#State 275
		DEFAULT => -205
	},
	{#State 276
		ACTIONS => {
			'OP21_LIST_COMMA' => 320
		}
	},
	{#State 277
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'MY' => 135,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'ListElements' => 321,
			'SubExpression' => 131,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'Operator' => 71,
			'Variable' => 128,
			'ListElement' => 132,
			'WordScoped' => 92,
			'TypeInner' => 134,
			'HashDereference' => 86,
			'HashReference' => 72
		}
	},
	{#State 278
		DEFAULT => -138
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
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			"foreach" => -143,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 109,
			"for" => -143,
			'WORD_UPPERCASE' => 108,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 111,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			"}" => 323,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_PRINT' => 95,
			'OP01_OPEN' => 97,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'LITERAL_STRING' => 85,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'WORD' => 26,
			'OP01_NAMED_VOID' => 89,
			"while" => -143,
			"if" => 88,
			'OP19_LOOP_CONTROL' => 73,
			'OP01_NAMED_VOID_LPAREN' => 75
		},
		GOTOS => {
			'OPTIONAL-36' => 115,
			'OperatorVoid' => 87,
			'HashDereference' => 86,
			'LoopLabel' => 84,
			'Variable' => 82,
			'Expression' => 80,
			'Literal' => 81,
			'Operation' => 324,
			'Conditional' => 103,
			'PAREN-35' => 104,
			'SubExpression' => 101,
			'Statement' => 100,
			'ArrayDereference' => 74,
			'VariableDeclaration' => 96,
			'HashReference' => 72,
			'VariableModification' => 93,
			'WordScoped' => 92,
			'Operator' => 71,
			'ArrayReference' => 90
		}
	},
	{#State 282
		ACTIONS => {
			'VARIABLE_SYMBOL' => 325
		}
	},
	{#State 283
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 326
		}
	},
	{#State 284
		DEFAULT => -55
	},
	{#State 285
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 327
		}
	},
	{#State 286
		DEFAULT => -115
	},
	{#State 287
		DEFAULT => -184
	},
	{#State 288
		DEFAULT => -180
	},
	{#State 289
		ACTIONS => {
			'WORD_UPPERCASE' => 133,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 135,
			'LITERAL_STRING' => 85,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 97,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'Operator' => 71,
			'Variable' => 128,
			'WordScoped' => 92,
			'ListElement' => 328,
			'HashDereference' => 86,
			'HashReference' => 72,
			'TypeInner' => 134,
			'ArrayDereference' => 74,
			'SubExpression' => 131
		}
	},
	{#State 290
		DEFAULT => -177
	},
	{#State 291
		ACTIONS => {
			'WORD' => 329
		}
	},
	{#State 292
		DEFAULT => -191
	},
	{#State 293
		DEFAULT => -175
	},
	{#State 294
		DEFAULT => -174
	},
	{#State 295
		ACTIONS => {
			")" => 330
		}
	},
	{#State 296
		DEFAULT => -122
	},
	{#State 297
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 331
		}
	},
	{#State 298
		DEFAULT => -125
	},
	{#State 299
		ACTIONS => {
			")" => 333
		}
	},
	{#State 300
		DEFAULT => -113
	},
	{#State 301
		DEFAULT => -112
	},
	{#State 302
		ACTIONS => {
			'OP21_LIST_COMMA' => 334
		}
	},
	{#State 303
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 112
		},
		GOTOS => {
			'VariableOrLiteral' => 335,
			'Variable' => 249,
			'Literal' => 248
		}
	},
	{#State 304
		DEFAULT => -199
	},
	{#State 305
		DEFAULT => -201
	},
	{#State 306
		ACTIONS => {
			'WORD' => 181,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 112,
			'LITERAL_STRING' => 85,
			"%{" => 116
		},
		GOTOS => {
			'Variable' => 184,
			'VariableOrLiteralOrWord' => 187,
			'Literal' => 183,
			'HashDereference' => 182,
			'HashEntry' => 336
		}
	},
	{#State 307
		ACTIONS => {
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116,
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133
		},
		GOTOS => {
			'SubExpression' => 337,
			'ArrayDereference' => 74,
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Variable' => 128,
			'Operator' => 71
		}
	},
	{#State 308
		DEFAULT => -192
	},
	{#State 309
		ACTIONS => {
			"]" => 338,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP18_TERNARY' => 169,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 175,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 165
		}
	},
	{#State 310
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP18_TERNARY' => 169,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			'OP04_MATH_POW' => 165,
			"}" => 339,
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => 171,
			'OP09_BITWISE_SHIFT' => 177,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172
		}
	},
	{#State 311
		ACTIONS => {
			'LPAREN' => -207,
			"}" => 340,
			'SCOPE' => -207,
			'OP02_METHOD_THINARROW_NEW' => -207
		}
	},
	{#State 312
		DEFAULT => -173
	},
	{#State 313
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'STDIN' => 230,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79
		},
		GOTOS => {
			'SubExpression' => 228,
			'ArrayDereference' => 74,
			'HashDereference' => 86,
			'HashReference' => 72,
			'SubExpressionOrStdin' => 341,
			'WordScoped' => 92,
			'Variable' => 128,
			'Operator' => 71,
			'Literal' => 81,
			'ArrayReference' => 90,
			'Expression' => 127
		}
	},
	{#State 314
		DEFAULT => -171
	},
	{#State 315
		ACTIONS => {
			";" => 342
		}
	},
	{#State 316
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP17_LIST_RANGE' => 167,
			'OP04_MATH_POW' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP18_TERNARY' => 169,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 175,
			")" => 343,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 317
		ACTIONS => {
			'VARIABLE_SYMBOL' => 344
		}
	},
	{#State 318
		ACTIONS => {
			'VARIABLE_SYMBOL' => 345
		}
	},
	{#State 319
		DEFAULT => -206
	},
	{#State 320
		ACTIONS => {
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			"%{" => 116,
			'LPAREN' => 117,
			'VARIABLE_SYMBOL' => 107,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'LITERAL_STRING' => 85,
			'MY' => 135,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 133,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_CLOSE' => 91,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 94
		},
		GOTOS => {
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'ListElement' => 132,
			'HashReference' => 72,
			'HashDereference' => 86,
			'TypeInner' => 134,
			'ListElements' => 346,
			'ArrayDereference' => 74,
			'SubExpression' => 131
		}
	},
	{#State 321
		ACTIONS => {
			")" => 347
		}
	},
	{#State 322
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 348
		}
	},
	{#State 323
		ACTIONS => {
			";" => 349
		}
	},
	{#State 324
		DEFAULT => -44
	},
	{#State 325
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 350
		}
	},
	{#State 326
		ACTIONS => {
			'LBRACE' => 351
		}
	},
	{#State 327
		ACTIONS => {
			'LITERAL_NUMBER' => 353,
			"our" => 356
		},
		GOTOS => {
			'Method' => 355,
			'Subroutine' => 354,
			'MethodOrSubroutine' => 352
		}
	},
	{#State 328
		DEFAULT => -176
	},
	{#State 329
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 357
		}
	},
	{#State 330
		DEFAULT => -128
	},
	{#State 331
		DEFAULT => -151,
		GOTOS => {
			'STAR-38' => 358
		}
	},
	{#State 332
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => 75,
			'OP19_LOOP_CONTROL' => 73,
			'WORD' => 26,
			"if" => 88,
			"while" => -143,
			'OP01_NAMED_VOID' => 89,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'LITERAL_STRING' => 85,
			'OP01_PRINT' => 95,
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 111,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'LPAREN' => 117,
			"%{" => 116,
			"foreach" => -143,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 108,
			"for" => -143,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'MY' => 109
		},
		GOTOS => {
			'ArrayReference' => 90,
			'Operator' => 71,
			'WordScoped' => 92,
			'VariableModification' => 93,
			'HashReference' => 72,
			'VariableDeclaration' => 96,
			'ArrayDereference' => 74,
			'Statement' => 100,
			'SubExpression' => 101,
			'PAREN-35' => 104,
			'Conditional' => 103,
			'Operation' => 360,
			'Literal' => 81,
			'Expression' => 80,
			'PLUS-41' => 359,
			'Variable' => 82,
			'LoopLabel' => 84,
			'HashDereference' => 86,
			'OperatorVoid' => 87,
			'OPTIONAL-36' => 115
		}
	},
	{#State 333
		DEFAULT => -127
	},
	{#State 334
		ACTIONS => {
			'LITERAL_STRING' => 361
		}
	},
	{#State 335
		DEFAULT => -103
	},
	{#State 336
		DEFAULT => -198
	},
	{#State 337
		ACTIONS => {
			'OP18_TERNARY' => 169,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 175,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP08_STRING_CAT' => 164,
			"}" => -194,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP04_MATH_POW' => 165,
			'OP21_LIST_COMMA' => -194,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172,
			'OP09_BITWISE_SHIFT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => 171
		}
	},
	{#State 338
		DEFAULT => -168
	},
	{#State 339
		DEFAULT => -169
	},
	{#State 340
		DEFAULT => -170
	},
	{#State 341
		ACTIONS => {
			";" => 362
		}
	},
	{#State 342
		DEFAULT => -117
	},
	{#State 343
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 363
		}
	},
	{#State 344
		ACTIONS => {
			'LPAREN' => 364
		}
	},
	{#State 345
		ACTIONS => {
			'LPAREN' => 365
		}
	},
	{#State 346
		ACTIONS => {
			")" => 366
		}
	},
	{#State 347
		DEFAULT => -78
	},
	{#State 348
		DEFAULT => -213
	},
	{#State 349
		DEFAULT => -46
	},
	{#State 350
		ACTIONS => {
			")" => 368,
			'OP21_LIST_COMMA' => 369
		},
		GOTOS => {
			'PAREN-18' => 367
		}
	},
	{#State 351
		ACTIONS => {
			"%{" => 116,
			"}" => 370,
			'WORD' => 373
		},
		GOTOS => {
			'HashDereference' => 372,
			'HashEntryTyped' => 371
		}
	},
	{#State 352
		DEFAULT => -57
	},
	{#State 353
		ACTIONS => {
			";" => 374
		}
	},
	{#State 354
		DEFAULT => -75
	},
	{#State 355
		DEFAULT => -74
	},
	{#State 356
		ACTIONS => {
			'WORD' => 58,
			'TYPE_METHOD' => 375,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 59
		}
	},
	{#State 357
		DEFAULT => -212
	},
	{#State 358
		ACTIONS => {
			'LBRACKET' => -154,
			'OP05_LOGICAL_NEG' => -154,
			'OP01_OPEN' => -154,
			'OP01_PRINT' => -154,
			'OP22_LOGICAL_NEG' => -154,
			'LBRACE' => -154,
			'OP01_CLOSE' => -154,
			'OP03_MATH_INC_DEC' => -154,
			"}" => -154,
			'LITERAL_NUMBER' => -154,
			'' => -154,
			'OP01_NAMED' => -154,
			"%{" => -154,
			'LPAREN' => -154,
			'OP01_NAMED_VOID_SCOLON' => -154,
			'VARIABLE_SYMBOL' => -154,
			"foreach" => -154,
			'MY' => -154,
			'OP05_MATH_NEG_LPAREN' => -154,
			'WORD_SCOPED' => -154,
			"for" => -154,
			'WORD_UPPERCASE' => -154,
			'OP01_NAMED_VOID_LPAREN' => -154,
			"elsif" => 380,
			"else" => 378,
			'OP19_LOOP_CONTROL' => -154,
			'WORD' => -154,
			'OP01_NAMED_VOID' => -154,
			"if" => -154,
			"while" => -154,
			'OP10_NAMED_UNARY' => -154,
			"undef" => -154,
			"\@{" => -154,
			'LITERAL_STRING' => -154,
			'OP19_LOOP_CONTROL_SCOLON' => -154
		},
		GOTOS => {
			'PAREN-37' => 377,
			'OPTIONAL-40' => 379,
			'PAREN-39' => 376
		}
	},
	{#State 359
		ACTIONS => {
			"}" => 381,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_PRINT' => 95,
			'OP01_OPEN' => 97,
			'MY' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 108,
			"for" => -143,
			'VARIABLE_SYMBOL' => 107,
			"foreach" => -143,
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_NAMED_VOID_SCOLON' => 113,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 111,
			'OP19_LOOP_CONTROL' => 73,
			'OP01_NAMED_VOID_LPAREN' => 75,
			'LITERAL_STRING' => 85,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'OP01_NAMED_VOID' => 89,
			"while" => -143,
			"if" => 88,
			'WORD' => 26
		},
		GOTOS => {
			'OperatorVoid' => 87,
			'OPTIONAL-36' => 115,
			'Operation' => 382,
			'Literal' => 81,
			'Expression' => 80,
			'Variable' => 82,
			'LoopLabel' => 84,
			'HashDereference' => 86,
			'VariableDeclaration' => 96,
			'ArrayDereference' => 74,
			'Statement' => 100,
			'SubExpression' => 101,
			'PAREN-35' => 104,
			'Conditional' => 103,
			'ArrayReference' => 90,
			'Operator' => 71,
			'VariableModification' => 93,
			'WordScoped' => 92,
			'HashReference' => 72
		}
	},
	{#State 360
		DEFAULT => -163
	},
	{#State 361
		ACTIONS => {
			'OP21_LIST_COMMA' => 383
		}
	},
	{#State 362
		DEFAULT => -172
	},
	{#State 363
		DEFAULT => -161
	},
	{#State 364
		ACTIONS => {
			'LPAREN' => 117,
			"%{" => 116,
			'OP01_NAMED' => 136,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'WORD_UPPERCASE' => 133,
			'MY' => 135,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'VARIABLE_SYMBOL' => 107,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_QW' => 130,
			'OP01_CLOSE' => 91
		},
		GOTOS => {
			'HashReference' => 72,
			'HashDereference' => 86,
			'TypeInner' => 134,
			'WordScoped' => 92,
			'ListElement' => 132,
			'Variable' => 128,
			'Operator' => 71,
			'Expression' => 127,
			'Literal' => 81,
			'ArrayReference' => 90,
			'SubExpression' => 131,
			'ListElements' => 384,
			'ArrayDereference' => 74
		}
	},
	{#State 365
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			"%{" => 116,
			'LPAREN' => 117,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP01_NAMED' => 136,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79
		},
		GOTOS => {
			'HashReference' => 72,
			'HashDereference' => 86,
			'WordScoped' => 92,
			'Variable' => 128,
			'Operator' => 71,
			'ArrayReference' => 90,
			'Expression' => 127,
			'Literal' => 81,
			'SubExpression' => 385,
			'ArrayDereference' => 74
		}
	},
	{#State 366
		DEFAULT => -80
	},
	{#State 367
		DEFAULT => -48
	},
	{#State 368
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 386
		}
	},
	{#State 369
		ACTIONS => {
			'MY' => 387
		}
	},
	{#State 370
		ACTIONS => {
			";" => 388
		}
	},
	{#State 371
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 389
		}
	},
	{#State 372
		DEFAULT => -197
	},
	{#State 373
		ACTIONS => {
			'OP20_HASH_FATARROW' => 390
		}
	},
	{#State 374
		DEFAULT => -59
	},
	{#State 375
		ACTIONS => {
			'VARIABLE_SYMBOL' => 391
		}
	},
	{#State 376
		DEFAULT => -153
	},
	{#State 377
		DEFAULT => -150
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 392
		}
	},
	{#State 379
		DEFAULT => -155
	},
	{#State 380
		ACTIONS => {
			'LPAREN' => 393
		}
	},
	{#State 381
		DEFAULT => -164
	},
	{#State 382
		DEFAULT => -162
	},
	{#State 383
		ACTIONS => {
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP01_OPEN' => 97,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136,
			'LPAREN' => 117,
			"%{" => 116
		},
		GOTOS => {
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Operator' => 71,
			'Variable' => 128,
			'SubExpression' => 394,
			'ArrayDereference' => 74
		}
	},
	{#State 384
		ACTIONS => {
			")" => 395
		}
	},
	{#State 385
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 165,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP17_LIST_RANGE' => 396,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			'OP13_BITWISE_AND' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP18_TERNARY' => 169,
			'OP09_BITWISE_SHIFT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => 171,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => 179
		}
	},
	{#State 386
		ACTIONS => {
			"\@_;" => 397
		}
	},
	{#State 387
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 60
		},
		GOTOS => {
			'Type' => 398
		}
	},
	{#State 388
		DEFAULT => -64
	},
	{#State 389
		ACTIONS => {
			"}" => 399,
			'OP21_LIST_COMMA' => 401
		},
		GOTOS => {
			'PAREN-24' => 400
		}
	},
	{#State 390
		ACTIONS => {
			'MY' => 135
		},
		GOTOS => {
			'TypeInner' => 402
		}
	},
	{#State 391
		ACTIONS => {
			"= sub {" => 403
		}
	},
	{#State 392
		DEFAULT => -152
	},
	{#State 393
		ACTIONS => {
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 77,
			"undef" => 78,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			"%{" => 116,
			'LPAREN' => 117,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 404,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'HashReference' => 72,
			'HashDereference' => 86
		}
	},
	{#State 394
		ACTIONS => {
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => -81,
			"}" => -81,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP04_MATH_POW' => 165,
			";" => -81,
			'OP18_TERNARY' => 169,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP08_MATH_ADD_SUB' => 168,
			")" => -81,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => -81,
			'OP11_COMPARE_LT_GT' => 172,
			'OP09_BITWISE_SHIFT' => 177,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP21_LIST_COMMA' => -81,
			"]" => -81
		}
	},
	{#State 395
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 405
		}
	},
	{#State 396
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 94,
			'OP01_CLOSE' => 91,
			'LBRACE' => 105,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP01_OPEN' => 97,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_STRING' => 85,
			'WORD_UPPERCASE' => 133,
			'VARIABLE_SYMBOL' => 107,
			"\@{" => 79,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			'LPAREN' => 117,
			"%{" => 116,
			'WORD' => 26,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 136
		},
		GOTOS => {
			'Literal' => 81,
			'Expression' => 127,
			'ArrayReference' => 90,
			'Variable' => 128,
			'Operator' => 71,
			'WordScoped' => 92,
			'HashDereference' => 86,
			'HashReference' => 72,
			'ArrayDereference' => 74,
			'SubExpression' => 406
		}
	},
	{#State 397
		DEFAULT => -50
	},
	{#State 398
		ACTIONS => {
			'VARIABLE_SYMBOL' => 407
		}
	},
	{#State 399
		ACTIONS => {
			";" => 408
		}
	},
	{#State 400
		DEFAULT => -61
	},
	{#State 401
		ACTIONS => {
			'WORD' => 373,
			"%{" => 116
		},
		GOTOS => {
			'HashDereference' => 372,
			'HashEntryTyped' => 409
		}
	},
	{#State 402
		ACTIONS => {
			'OP01_OPEN' => 97,
			'LBRACKET' => 99,
			'OP05_LOGICAL_NEG' => 98,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			'OP01_NAMED' => 136,
			'LITERAL_NUMBER' => 112,
			'WORD' => 26,
			"%{" => 116,
			'LPAREN' => 117,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			'VARIABLE_SYMBOL' => 107,
			'WORD_UPPERCASE' => 133,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayDereference' => 74,
			'SubExpression' => 410,
			'Variable' => 128,
			'Operator' => 71,
			'ArrayReference' => 90,
			'Literal' => 81,
			'Expression' => 127,
			'HashDereference' => 86,
			'HashReference' => 72,
			'WordScoped' => 92
		}
	},
	{#State 403
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -66,
			'OP01_NAMED_VOID_LPAREN' => -66,
			'OP10_NAMED_UNARY' => -66,
			"undef" => -66,
			"\@{" => -66,
			'LITERAL_STRING' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'WORD' => -66,
			'OP01_NAMED_VOID' => -66,
			"while" => -66,
			"if" => -66,
			'OP01_CLOSE' => -66,
			'OP03_MATH_INC_DEC' => -66,
			"}" => -66,
			'OP05_LOGICAL_NEG' => -66,
			'LBRACKET' => -66,
			'OP01_OPEN' => -66,
			'OP01_PRINT' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'LBRACE' => -66,
			'LPAREN_MY' => 411,
			'VARIABLE_SYMBOL' => -66,
			"foreach" => -66,
			'WORD_SCOPED' => -66,
			'MY' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"for" => -66,
			'WORD_UPPERCASE' => -66,
			'LITERAL_NUMBER' => -66,
			'OP01_NAMED' => -66,
			"%{" => -66,
			'LPAREN' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66
		},
		GOTOS => {
			'MethodArguments' => 412,
			'OPTIONAL-26' => 413
		}
	},
	{#State 404
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP17_LIST_RANGE' => 167,
			'OP04_MATH_POW' => 165,
			'OP08_STRING_CAT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP18_TERNARY' => 169,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP08_MATH_ADD_SUB' => 168,
			")" => 414,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177
		}
	},
	{#State 405
		DEFAULT => -160
	},
	{#State 406
		ACTIONS => {
			'OP13_BITWISE_AND' => 175,
			'OP08_MATH_ADD_SUB' => 168,
			'OP14_BITWISE_OR_XOR' => 174,
			")" => 415,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 170,
			'OP15_LOGICAL_AND' => 176,
			'OP18_TERNARY' => -102,
			'OP04_MATH_POW' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 163,
			'OP08_STRING_CAT' => 164,
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177,
			'OP11_COMPARE_LT_GT' => 172,
			'OP23_LOGICAL_AND' => -102
		}
	},
	{#State 407
		DEFAULT => -47
	},
	{#State 408
		DEFAULT => -63
	},
	{#State 409
		DEFAULT => -60
	},
	{#State 410
		ACTIONS => {
			'OP21_LIST_COMMA' => -196,
			'OP23_LOGICAL_AND' => 179,
			'OP11_COMPARE_LT_GT' => 172,
			'OP16_LOGICAL_OR' => 171,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 177,
			'OP18_TERNARY' => 169,
			'OP15_LOGICAL_AND' => 176,
			'OP06_REGEX_MATCH' => 170,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 175,
			'OP08_MATH_ADD_SUB' => 168,
			'OP14_BITWISE_OR_XOR' => 174,
			'OP17_LIST_RANGE' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP04_MATH_POW' => 165,
			'OP08_STRING_CAT' => 164,
			"}" => -196,
			'OP07_MATH_MULT_DIV_MOD' => 163
		}
	},
	{#State 411
		ACTIONS => {
			'TYPE_SELF' => 416
		}
	},
	{#State 412
		DEFAULT => -65
	},
	{#State 413
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 417
		}
	},
	{#State 414
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 418
		}
	},
	{#State 415
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 419
		}
	},
	{#State 416
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 420
		}
	},
	{#State 417
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 73,
			'OP01_NAMED_VOID_LPAREN' => 75,
			"undef" => 78,
			'OP10_NAMED_UNARY' => 77,
			"\@{" => 79,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			"if" => 88,
			"while" => -143,
			'OP01_NAMED_VOID' => 89,
			'OP01_CLOSE' => 91,
			'OP03_MATH_INC_DEC' => 94,
			"}" => 422,
			'OP01_OPEN' => 97,
			'OP01_PRINT' => 95,
			'OP05_LOGICAL_NEG' => 98,
			'LBRACKET' => 99,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACE' => 105,
			"foreach" => -143,
			'VARIABLE_SYMBOL' => 107,
			"for" => -143,
			'WORD_UPPERCASE' => 108,
			'MY' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 111,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED_VOID_SCOLON' => 113,
			"%{" => 116,
			'LPAREN' => 117
		},
		GOTOS => {
			'OperatorVoid' => 87,
			'OPTIONAL-36' => 115,
			'Expression' => 80,
			'Literal' => 81,
			'Operation' => 421,
			'Variable' => 82,
			'LoopLabel' => 84,
			'HashDereference' => 86,
			'VariableDeclaration' => 96,
			'ArrayDereference' => 74,
			'SubExpression' => 101,
			'Statement' => 100,
			'Conditional' => 103,
			'PAREN-35' => 104,
			'ArrayReference' => 90,
			'Operator' => 71,
			'WordScoped' => 92,
			'VariableModification' => 93,
			'HashReference' => 72
		}
	},
	{#State 418
		DEFAULT => -149
	},
	{#State 419
		DEFAULT => -159
	},
	{#State 420
		ACTIONS => {
			")" => 423,
			'OP21_LIST_COMMA' => 424
		},
		GOTOS => {
			'PAREN-28' => 425
		}
	},
	{#State 421
		DEFAULT => -67
	},
	{#State 422
		ACTIONS => {
			";" => 426
		}
	},
	{#State 423
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 427
		}
	},
	{#State 424
		ACTIONS => {
			'MY' => 428
		}
	},
	{#State 425
		DEFAULT => -71
	},
	{#State 426
		DEFAULT => -69
	},
	{#State 427
		ACTIONS => {
			"\@_;" => 429
		}
	},
	{#State 428
		ACTIONS => {
			'TYPE_INTEGER' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 430
		}
	},
	{#State 429
		DEFAULT => -73
	},
	{#State 430
		ACTIONS => {
			'VARIABLE_SYMBOL' => 431
		}
	},
	{#State 431
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5865 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5872 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5886 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6003 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6010 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6017 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6028 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6050 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6057 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6071 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6117 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6128 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6135 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6153 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6160 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6167 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6178 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6246 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6253 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6306 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6313 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6320 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6327 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6338 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6345 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6352 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6359 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6370 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6381 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6388 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6395 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6409 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6420 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6427 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6434 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6452 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6463 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6485 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6507 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6518 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6529 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6540 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6551 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6562 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6573 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6584 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6606 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6628 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6639 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6650 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6672 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6694 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6705 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6727 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6738 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6749 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6760 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6771 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6782 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6793 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6815 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6822 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6843 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6916 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6927 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6938 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6945 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6977 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6988 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6999 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7010 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7021 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7032 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7043 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7065 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7087 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7098 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7109 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7120 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_139
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7142 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_140
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7185 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7196 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7218 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 5,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7236 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7243 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7250 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_155
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7282 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7304 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_158
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_159
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_160
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7337 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_161
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7348 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7355 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_164
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7373 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7380 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7387 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_167
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7420 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_170
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7431 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_171
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7442 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_172
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7453 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_173
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7464 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_174
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_175
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_179
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7518 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7525 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7543 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7554 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_184
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7565 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7572 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7579 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_187
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7590 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7597 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7604 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_190
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7615 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_191
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7626 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7633 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_194
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7651 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_195
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7662 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_196
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7673 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_197
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7684 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7691 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7698 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_201
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7716 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_202
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7727 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7734 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7741 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_205
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7752 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_206
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7763 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7774 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_208
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7785 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_209
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7796 lib/RPerl/Grammar.pm
	],
	[#Rule Type_210
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7807 lib/RPerl/Grammar.pm
	],
	[#Rule Type_211
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7818 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_212
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7829 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_213
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7840 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_214
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7851 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_215
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7862 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_216
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7873 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_217
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7884 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_218
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7895 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_219
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7906 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_220
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7917 lib/RPerl/Grammar.pm
	]
],
#line 7920 lib/RPerl/Grammar.pm
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
         'TypeInner_212', 
         'TypeInnerConstant_213', 
         'VariableOrLiteral_214', 
         'VariableOrLiteral_215', 
         'VariableOrLiteralOrWord_216', 
         'VariableOrLiteralOrWord_217', 
         'VariableOrLiteralOrWord_218', 
         'Literal_219', 
         'Literal_220', );
  $self;
}

#line 213 "lib/RPerl/Grammar.eyp"


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
Type_211 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_212 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_213 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_214 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_215 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_216 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_217 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_218 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
Literal_219 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_220 => 'RPerl::Operation::Expression::SubExpression::Literal::String'                   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8308 lib/RPerl/Grammar.pm



1;
