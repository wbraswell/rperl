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
    our $VERSION = 0.000_996;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandleref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|foreach|\$TYPED_|\=\ sub\ \{|elsif|undef|while|else|for|our|use|\@_\;|\@\{|\%\{|if|\)|\]|\}|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
      /\G(integer\s+)/gc and return ('TYPE_INTEGER', $1);
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
      /\G(croak;|return;|exit;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak|return|exit)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\()/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|keys|values|sort|length|ETC)\s/gc and return ('OP01_NAMED', $1);
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


#line 130 lib/RPerl/Grammar.pm

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
  [ 'Operator_78' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_79' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_80' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_81' => 'Operator', [ 'OP01_OPEN', 'MY', 'filehandleref', 'FH_REF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'OP01_CLOSE', 'FH_REF_SYMBOL' ], 0 ],
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
  [ 'OperatorVoid_110' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-31', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_111' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_112' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_113' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'Expression_121' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_122' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-32', ')' ], 0 ],
  [ 'Expression_123' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_124' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-33', ')' ], 0 ],
  [ 'Expression_125' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_126' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_127' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_128' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_135' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_136' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-34', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'PAREN-34' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Statement_140' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_141' => 'Statement', [ 'OPTIONAL-35', 'Loop' ], 0 ],
  [ 'Statement_142' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Conditional_151' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-37', 'OPTIONAL-39' ], 0 ],
  [ 'Loop_152' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_153' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_154' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_155' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_156' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_157' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'PLUS-40', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'Operation' ], 0 ],
  [ 'CodeBlock_160' => 'CodeBlock', [ 'LBRACE', 'PLUS-40', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ 'Variable_163' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-41' ], 0 ],
  [ 'VariableRetrieval_164' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_165' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_166' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_167' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_168' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_169' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_170' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'PAREN-42' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'ListElements_174' => 'ListElements', [ 'ListElement', 'STAR-43' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'WORD' ], 0 ],
  [ 'ListElement_177' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_178' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_179' => 'ListElement', [ 'OP01_QW', 'PLUS-44', ')' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'ArrayReference_182' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-45', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayDereference_185' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_186' => 'ArrayDereference', [ '@{', 'OPTIONAL-46', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'HashEntry_189' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-47', 'SubExpression' ], 0 ],
  [ 'HashEntry_190' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryTyped_191' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_192' => 'HashEntryTyped', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-48', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [ 'STAR-49', 'PAREN-48' ], 0 ],
  [ '_STAR_LIST' => 'STAR-49', [  ], 0 ],
  [ 'HashReference_196' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-49', '}' ], 0 ],
  [ 'HashReference_197' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashDereference_200' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_201' => 'HashDereference', [ '%{', 'OPTIONAL-50', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_202' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_203' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_204' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_205' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_206' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_207' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_208' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_209' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_210' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_211' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_212' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_213' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'Literal_214' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_215' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'OperatorVoid_110' => 110,
  'OperatorVoid_111' => 111,
  'OperatorVoid_112' => 112,
  'OperatorVoid_113' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  'OperatorVoid_116' => 116,
  '_OPTIONAL' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  'Expression_121' => 121,
  'Expression_122' => 122,
  'Expression_123' => 123,
  'Expression_124' => 124,
  'Expression_125' => 125,
  'SubExpression_126' => 126,
  'SubExpression_127' => 127,
  'SubExpression_128' => 128,
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpressionOrStdin_135' => 135,
  'SubExpressionOrStdin_136' => 136,
  '_PAREN' => 137,
  '_OPTIONAL' => 138,
  '_OPTIONAL' => 139,
  'Statement_140' => 140,
  'Statement_141' => 141,
  'Statement_142' => 142,
  'Statement_143' => 143,
  'Statement_144' => 144,
  '_PAREN' => 145,
  '_STAR_LIST' => 146,
  '_STAR_LIST' => 147,
  '_PAREN' => 148,
  '_OPTIONAL' => 149,
  '_OPTIONAL' => 150,
  'Conditional_151' => 151,
  'Loop_152' => 152,
  'Loop_153' => 153,
  'Loop_154' => 154,
  'LoopFor_155' => 155,
  'LoopForEach_156' => 156,
  'LoopWhile_157' => 157,
  '_PLUS_LIST' => 158,
  '_PLUS_LIST' => 159,
  'CodeBlock_160' => 160,
  '_STAR_LIST' => 161,
  '_STAR_LIST' => 162,
  'Variable_163' => 163,
  'VariableRetrieval_164' => 164,
  'VariableRetrieval_165' => 165,
  'VariableRetrieval_166' => 166,
  'VariableDeclaration_167' => 167,
  'VariableDeclaration_168' => 168,
  'VariableModification_169' => 169,
  'VariableModification_170' => 170,
  '_PAREN' => 171,
  '_STAR_LIST' => 172,
  '_STAR_LIST' => 173,
  'ListElements_174' => 174,
  '_PLUS_LIST' => 175,
  '_PLUS_LIST' => 176,
  'ListElement_177' => 177,
  'ListElement_178' => 178,
  'ListElement_179' => 179,
  '_OPTIONAL' => 180,
  '_OPTIONAL' => 181,
  'ArrayReference_182' => 182,
  '_OPTIONAL' => 183,
  '_OPTIONAL' => 184,
  'ArrayDereference_185' => 185,
  'ArrayDereference_186' => 186,
  '_OPTIONAL' => 187,
  '_OPTIONAL' => 188,
  'HashEntry_189' => 189,
  'HashEntry_190' => 190,
  'HashEntryTyped_191' => 191,
  'HashEntryTyped_192' => 192,
  '_PAREN' => 193,
  '_STAR_LIST' => 194,
  '_STAR_LIST' => 195,
  'HashReference_196' => 196,
  'HashReference_197' => 197,
  '_OPTIONAL' => 198,
  '_OPTIONAL' => 199,
  'HashDereference_200' => 200,
  'HashDereference_201' => 201,
  'WordScoped_202' => 202,
  'WordScoped_203' => 203,
  'LoopLabel_204' => 204,
  'Type_205' => 205,
  'Type_206' => 206,
  'TypeInner_207' => 207,
  'TypeInnerConstant_208' => 208,
  'VariableOrLiteral_209' => 209,
  'VariableOrLiteral_210' => 210,
  'VariableOrLiteralOrWord_211' => 211,
  'VariableOrLiteralOrWord_212' => 212,
  'VariableOrLiteralOrWord_213' => 213,
  'Literal_214' => 214,
  'Literal_215' => 215,
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
	'filehandleref' => { ISSEMANTIC => 0 },
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
	FH_REF_SYMBOL => { ISSEMANTIC => 1 },
	FH_REF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 4
		},
		GOTOS => {
			'CompileUnit' => 1,
			'Critic' => 2,
			'PLUS-2' => 3,
			'Program' => 7,
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 9,
			'PAREN-1' => 5
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 4,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 11,
			'ModuleHeader' => 9,
			'OPTIONAL-9' => 8,
			'Critic' => 2
		}
	},
	{#State 4
		ACTIONS => {
			'WORD' => 13
		},
		GOTOS => {
			'PLUS-14' => 12
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 4,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 14,
			'Critic' => 15
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"package" => 16
		}
	},
	{#State 9
		ACTIONS => {
			"use constant" => -25,
			"use parent qw(" => 20,
			"## no critic qw(" => -25,
			"use" => -25,
			"our" => -25
		},
		GOTOS => {
			'Class' => 21,
			'Package' => 17,
			'Module' => 18,
			'STAR-10' => 19
		}
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -2
	},
	{#State 12
		ACTIONS => {
			'WORD' => 22,
			")" => 23
		}
	},
	{#State 13
		DEFAULT => -35
	},
	{#State 14
		ACTIONS => {
			"use strict;" => 24
		},
		GOTOS => {
			'Header' => 25
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 17
		DEFAULT => -22
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		ACTIONS => {
			"our" => -27,
			"use" => -27,
			"## no critic qw(" => 4,
			"use constant" => -27
		},
		GOTOS => {
			'Critic' => 30,
			'STAR-11' => 29
		}
	},
	{#State 20
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 21
		DEFAULT => -23
	},
	{#State 22
		DEFAULT => -34
	},
	{#State 23
		DEFAULT => -36
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
			";" => 34
		}
	},
	{#State 27
		DEFAULT => -203
	},
	{#State 28
		DEFAULT => -202
	},
	{#State 29
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 37
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 36
		}
	},
	{#State 30
		DEFAULT => -24
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
			'OP22_LOGICAL_NEG' => -11,
			'LITERAL_STRING' => -11,
			'LBRACE' => -11,
			"foreach" => -11,
			"use" => -11,
			'OP01_NAMED_VOID' => -11,
			"use constant" => -11,
			'OP01_NAMED' => -11,
			'WORD_UPPERCASE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_OPEN' => -11,
			'OP01_CLOSE' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_PRINT' => -11,
			"## no critic qw(" => 4,
			'LITERAL_NUMBER' => -11,
			'MY' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"%{" => -11,
			"\@{" => -11,
			'LBRACKET' => -11,
			"undef" => -11,
			'OP03_MATH_INC_DEC' => -11,
			"if" => -11,
			"for" => -11,
			'LPAREN' => -11,
			"while" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'WORD' => -11,
			'WORD_SCOPED' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"our" => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP10_NAMED_UNARY' => -11
		},
		GOTOS => {
			'STAR-5' => 40,
			'Critic' => 41
		}
	},
	{#State 34
		ACTIONS => {
			"use strict;" => 24
		},
		GOTOS => {
			'Header' => 42
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 44,
			"our" => 43
		},
		GOTOS => {
			'Constant' => 46,
			'PLUS-13' => 45,
			'Subroutine' => 47
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
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
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_PRINT' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'OP01_OPEN' => -13,
			'WORD_UPPERCASE' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED' => -13,
			"use constant" => -13,
			'OP01_NAMED_VOID' => -13,
			"use" => 37,
			"foreach" => -13,
			'LBRACE' => -13,
			'LITERAL_STRING' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			"our" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD' => -13,
			'WORD_SCOPED' => -13,
			'LPAREN' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"while" => -13,
			"if" => -13,
			"for" => -13,
			'OP03_MATH_INC_DEC' => -13,
			"undef" => -13,
			'LBRACKET' => -13,
			"%{" => -13,
			"\@{" => -13,
			'MY' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LITERAL_NUMBER' => -13
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
		DEFAULT => -21
	},
	{#State 43
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 54
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
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 58
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
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			'OP01_NAMED_VOID' => -15,
			"use constant" => 44,
			'OP01_NAMED' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_STRING' => -15,
			"foreach" => -15,
			'LBRACE' => -15,
			'OP01_OPEN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_CLOSE' => -15,
			'OP01_PRINT' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'WORD_UPPERCASE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LITERAL_NUMBER' => -15,
			"\@{" => -15,
			"%{" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'MY' => -15,
			'LBRACKET' => -15,
			"undef" => -15,
			'OP19_LOOP_CONTROL' => -15,
			"our" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP10_NAMED_UNARY' => -15,
			"if" => -15,
			"for" => -15,
			"while" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'LPAREN' => -15,
			'WORD_SCOPED' => -15,
			'WORD' => -15
		},
		GOTOS => {
			'STAR-7' => 64,
			'Constant' => 63
		}
	},
	{#State 53
		DEFAULT => -205
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 55
		DEFAULT => -206
	},
	{#State 56
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
		}
	},
	{#State 57
		ACTIONS => {
			";" => 67
		}
	},
	{#State 58
		DEFAULT => -30
	},
	{#State 59
		ACTIONS => {
			'WORD' => 69
		},
		GOTOS => {
			'PLUS-15' => 68
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
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'LBRACKET' => 100,
			"undef" => 98,
			'LITERAL_NUMBER' => 106,
			'MY' => 104,
			'OP01_NAMED_VOID_SCOLON' => 103,
			"\@{" => 102,
			"%{" => 101,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP19_LOOP_CONTROL' => 110,
			"our" => 43,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			"for" => -139,
			"if" => 116,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			"while" => -139,
			'OP01_NAMED' => 71,
			'OP01_NAMED_VOID' => 73,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"foreach" => -139,
			'OP22_LOGICAL_NEG' => 81,
			'OP01_PRINT' => 84,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'WORD_UPPERCASE' => 91
		},
		GOTOS => {
			'Operator' => 85,
			'Expression' => 89,
			'PAREN-34' => 107,
			'ArrayDereference' => 92,
			'PLUS-8' => 93,
			'Variable' => 115,
			'OPTIONAL-35' => 94,
			'Subroutine' => 111,
			'VariableModification' => 112,
			'HashReference' => 74,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'Literal' => 95,
			'SubExpression' => 72,
			'OperatorVoid' => 80,
			'VariableDeclaration' => 82,
			'HashDereference' => 105,
			'Operation' => 83,
			'LoopLabel' => 76,
			'Statement' => 99,
			'Conditional' => 78
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 117
		}
	},
	{#State 66
		ACTIONS => {
			'MY' => 119
		},
		GOTOS => {
			'TypeInnerConstant' => 118
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		ACTIONS => {
			'WORD' => 120,
			")" => 121
		}
	},
	{#State 69
		DEFAULT => -38
	},
	{#State 70
		ACTIONS => {
			"use constant" => -54,
			"our hashref \$properties" => -54,
			"## no critic qw(" => 4,
			"use" => -54
		},
		GOTOS => {
			'STAR-21' => 123,
			'Critic' => 122
		}
	},
	{#State 71
		ACTIONS => {
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'MY' => 131,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 130,
			'OP01_NAMED' => 125
		},
		GOTOS => {
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92,
			'SubExpression' => 124,
			'Literal' => 95,
			'TypeInner' => 128,
			'ListElement' => 129,
			'HashReference' => 74,
			'WordScoped' => 96,
			'Expression' => 126,
			'ArrayReference' => 75,
			'Operator' => 85
		}
	},
	{#State 72
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 140,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP17_LIST_RANGE' => 136,
			'OP06_REGEX_MATCH' => 137,
			'OP08_STRING_CAT' => 143,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP04_MATH_POW' => 148,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138,
			'OP23_LOGICAL_AND' => 147,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			'MY' => 131,
			"%{" => 101,
			"\@{" => 102,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'LBRACE' => 77,
			"undef" => 98,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 130,
			'OP01_NAMED' => 125,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132,
			'TypeInner' => 128,
			'ListElements' => 151,
			'SubExpression' => 152,
			'Literal' => 95,
			'Operator' => 85,
			'HashReference' => 74,
			'ListElement' => 150,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96
		}
	},
	{#State 74
		DEFAULT => -132
	},
	{#State 75
		DEFAULT => -130
	},
	{#State 76
		ACTIONS => {
			'COLON' => 153
		}
	},
	{#State 77
		ACTIONS => {
			'LITERAL_STRING' => 79,
			'VARIABLE_SYMBOL' => 109,
			'WORD' => 158,
			'LITERAL_NUMBER' => 106,
			"}" => 157,
			"%{" => 101
		},
		GOTOS => {
			'Literal' => 155,
			'HashEntry' => 154,
			'VariableOrLiteralOrWord' => 159,
			'HashDereference' => 156,
			'Variable' => 160
		}
	},
	{#State 78
		DEFAULT => -140
	},
	{#State 79
		DEFAULT => -215
	},
	{#State 80
		DEFAULT => -142
	},
	{#State 81
		ACTIONS => {
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'LBRACE' => 77,
			"undef" => 98
		},
		GOTOS => {
			'Literal' => 95,
			'SubExpression' => 161,
			'Operator' => 85,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132
		}
	},
	{#State 82
		DEFAULT => -143
	},
	{#State 83
		DEFAULT => -17
	},
	{#State 84
		ACTIONS => {
			'OP01_CLOSE' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'OP01_OPEN' => -109,
			'OP10_NAMED_UNARY' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'LPAREN' => -109,
			'STDOUT_STDERR' => 165,
			'WORD' => -109,
			'WORD_SCOPED' => -109,
			'WORD_UPPERCASE' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP01_QW' => -109,
			'FH_REF_SYMBOL_BRACES' => 163,
			'OP01_NAMED' => -109,
			'MY' => -109,
			"%{" => -109,
			"\@{" => -109,
			'LITERAL_NUMBER' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LBRACE' => -109,
			"undef" => -109,
			'LBRACKET' => -109,
			'LITERAL_STRING' => -109
		},
		GOTOS => {
			'PAREN-30' => 164,
			'OPTIONAL-31' => 162
		}
	},
	{#State 85
		DEFAULT => -121
	},
	{#State 86
		ACTIONS => {
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"undef" => 98,
			'LBRACE' => 77,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'WORD_UPPERCASE' => 127,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87
		},
		GOTOS => {
			'Expression' => 126,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'HashReference' => 74,
			'Operator' => 85,
			'SubExpression' => 166,
			'Literal' => 95,
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92
		}
	},
	{#State 87
		ACTIONS => {
			'FH_REF_SYMBOL' => 167
		}
	},
	{#State 88
		ACTIONS => {
			'MY' => 168
		}
	},
	{#State 89
		ACTIONS => {
			'OP08_STRING_CAT' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			";" => 169,
			'OP17_LIST_RANGE' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP18_TERNARY' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP04_MATH_POW' => -126
		}
	},
	{#State 90
		DEFAULT => -115
	},
	{#State 91
		ACTIONS => {
			'LPAREN' => 170,
			'COLON' => -204
		}
	},
	{#State 92
		DEFAULT => -131
	},
	{#State 93
		ACTIONS => {
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_PRINT' => 84,
			'WORD_UPPERCASE' => 91,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'OP01_NAMED_VOID' => 73,
			'OP01_NAMED' => 71,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"foreach" => -139,
			'OP19_LOOP_CONTROL' => 110,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			"if" => 116,
			"for" => -139,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			"while" => -139,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 97,
			'' => -18,
			'LITERAL_NUMBER' => 106,
			'MY' => 104,
			'OP01_NAMED_VOID_SCOLON' => 103,
			"%{" => 101,
			"\@{" => 102,
			'LBRACKET' => 100,
			"undef" => 98
		},
		GOTOS => {
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Literal' => 95,
			'SubExpression' => 72,
			'OperatorVoid' => 80,
			'HashDereference' => 105,
			'VariableDeclaration' => 82,
			'Operation' => 171,
			'Statement' => 99,
			'LoopLabel' => 76,
			'Conditional' => 78,
			'Operator' => 85,
			'Expression' => 89,
			'PAREN-34' => 107,
			'ArrayDereference' => 92,
			'Variable' => 115,
			'OPTIONAL-35' => 94,
			'VariableModification' => 112
		}
	},
	{#State 94
		ACTIONS => {
			"for" => 173,
			"while" => 174,
			"foreach" => 176
		},
		GOTOS => {
			'Loop' => 177,
			'LoopFor' => 172,
			'LoopForEach' => 175,
			'LoopWhile' => 178
		}
	},
	{#State 95
		DEFAULT => -128
	},
	{#State 96
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 180,
			'LPAREN' => 179
		}
	},
	{#State 97
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Variable' => 181
		}
	},
	{#State 98
		DEFAULT => -127
	},
	{#State 99
		DEFAULT => -77
	},
	{#State 100
		ACTIONS => {
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 97,
			"]" => -181,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'MY' => 131,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"undef" => 98,
			'LBRACE' => 77,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_UPPERCASE' => 127,
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Operator' => 85,
			'ListElement' => 150,
			'HashReference' => 74,
			'Expression' => 126,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'TypeInner' => 128,
			'ListElements' => 183,
			'SubExpression' => 152,
			'Literal' => 95,
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132,
			'OPTIONAL-45' => 182
		}
	},
	{#State 101
		ACTIONS => {
			'LBRACE' => -199,
			'VARIABLE_SYMBOL' => 109,
			'MY' => 131
		},
		GOTOS => {
			'TypeInner' => 185,
			'Variable' => 184,
			'OPTIONAL-50' => 186
		}
	},
	{#State 102
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => -184,
			'MY' => 131
		},
		GOTOS => {
			'TypeInner' => 189,
			'OPTIONAL-46' => 187,
			'Variable' => 188
		}
	},
	{#State 103
		DEFAULT => -112
	},
	{#State 104
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 190
		}
	},
	{#State 105
		DEFAULT => -133
	},
	{#State 106
		DEFAULT => -214
	},
	{#State 107
		DEFAULT => -138
	},
	{#State 108
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -95,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NEG' => 81,
			'OP16_LOGICAL_OR' => -95,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			'OP01_OPEN' => 88,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP05_MATH_NEG_LPAREN' => 86,
			";" => -95,
			'OP01_CLOSE' => 87,
			'OP17_LIST_RANGE' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP06_REGEX_MATCH' => -95,
			")" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'WORD_UPPERCASE' => 127,
			'OP03_MATH_INC_DEC' => 97,
			"]" => -95,
			'OP07_STRING_REPEAT' => -95,
			'LITERAL_NUMBER' => 106,
			'OP15_LOGICAL_AND' => -95,
			"\@{" => 102,
			"%{" => 101,
			'OP23_LOGICAL_AND' => -95,
			'LBRACKET' => 100,
			'OP04_MATH_POW' => -95,
			"undef" => 98,
			"}" => -95,
			'OP08_STRING_CAT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'VARIABLE_SYMBOL' => 109,
			'OP09_BITWISE_SHIFT' => -95,
			'OP10_NAMED_UNARY' => 108,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP11_COMPARE_LT_GT' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP18_TERNARY' => -95
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105,
			'Operator' => 85,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'HashReference' => 74,
			'SubExpression' => 191,
			'Literal' => 95
		}
	},
	{#State 109
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 192
		}
	},
	{#State 110
		ACTIONS => {
			'WORD_UPPERCASE' => 193
		},
		GOTOS => {
			'LoopLabel' => 194
		}
	},
	{#State 111
		DEFAULT => -14
	},
	{#State 112
		DEFAULT => -144
	},
	{#State 113
		ACTIONS => {
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"%{" => 101,
			"\@{" => 102,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'LBRACE' => 77,
			"undef" => 98,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125
		},
		GOTOS => {
			'SubExpression' => 195,
			'Literal' => 95,
			'Operator' => 85,
			'WordScoped' => 96,
			'Expression' => 126,
			'ArrayReference' => 75,
			'HashReference' => 74,
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105
		}
	},
	{#State 114
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 196,
			"%{" => 101,
			"\@{" => 102,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'OP10_NAMED_UNARY' => 108,
			'OP01_PRINT' => 198,
			'VARIABLE_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127
		},
		GOTOS => {
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'Operator' => 85,
			'Literal' => 95,
			'SubExpression' => 197
		}
	},
	{#State 115
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 201,
			'OP03_MATH_INC_DEC' => 202,
			'OP07_STRING_REPEAT' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP19_VARIABLE_ASSIGN' => 200,
			'OP23_LOGICAL_AND' => -129,
			'OP04_MATH_POW' => -129,
			'OP08_STRING_CAT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP02_METHOD_THINARROW' => 199,
			'OP11_COMPARE_LT_GT' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129
		}
	},
	{#State 116
		ACTIONS => {
			'LPAREN' => 203
		}
	},
	{#State 117
		ACTIONS => {
			'OP01_NAMED' => -43,
			'OP01_NAMED_VOID' => -43,
			"foreach" => -43,
			'LBRACE' => -43,
			'LITERAL_STRING' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_PRINT' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LPAREN_MY' => 206,
			'OP01_CLOSE' => -43,
			'OP01_OPEN' => -43,
			'WORD_UPPERCASE' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"undef" => -43,
			'LBRACKET' => -43,
			"\@{" => -43,
			"%{" => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'MY' => -43,
			'LITERAL_NUMBER' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"}" => -43,
			'WORD_SCOPED' => -43,
			'WORD' => -43,
			"while" => -43,
			'LPAREN' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"for" => -43,
			"if" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 205,
			'OPTIONAL-16' => 204
		}
	},
	{#State 118
		ACTIONS => {
			'LITERAL_STRING' => 79,
			'LITERAL_NUMBER' => 106
		},
		GOTOS => {
			'Literal' => 207
		}
	},
	{#State 119
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 208
		}
	},
	{#State 120
		DEFAULT => -37
	},
	{#State 121
		ACTIONS => {
			";" => 209
		}
	},
	{#State 122
		DEFAULT => -51
	},
	{#State 123
		ACTIONS => {
			"our hashref \$properties" => -56,
			"use constant" => -56,
			"use" => 37
		},
		GOTOS => {
			'Include' => 210,
			'STAR-22' => 211
		}
	},
	{#State 124
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP04_MATH_POW' => -79,
			";" => -79,
			'OP21_LIST_COMMA' => -177,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP18_TERNARY' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			")" => -79,
			'OP11_COMPARE_LT_GT' => -79
		}
	},
	{#State 125
		ACTIONS => {
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"undef" => 98,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105,
			'Operator' => 85,
			'WordScoped' => 96,
			'Expression' => 126,
			'ArrayReference' => 75,
			'HashReference' => 74,
			'Literal' => 95,
			'SubExpression' => 212
		}
	},
	{#State 126
		DEFAULT => -126
	},
	{#State 127
		ACTIONS => {
			'LPAREN' => 170
		}
	},
	{#State 128
		ACTIONS => {
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 77,
			"undef" => 98,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"\@{" => 102,
			"%{" => 101,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'HashReference' => 74,
			'Operator' => 85,
			'Literal' => 95,
			'SubExpression' => 213,
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92
		}
	},
	{#State 129
		ACTIONS => {
			'OP21_LIST_COMMA' => 214
		}
	},
	{#State 130
		ACTIONS => {
			'WORD' => 215
		},
		GOTOS => {
			'PLUS-44' => 216
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 217
		}
	},
	{#State 132
		ACTIONS => {
			'OP23_LOGICAL_AND' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP04_MATH_POW' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP03_MATH_INC_DEC' => 202,
			"]" => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP02_METHOD_THINARROW' => 199,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP18_TERNARY' => -129,
			")" => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			";" => -129,
			'OP21_LIST_COMMA' => -129,
			"}" => -129,
			'OP08_STRING_CAT' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP24_LOGICAL_OR_XOR' => -129
		}
	},
	{#State 133
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"%{" => 101,
			"\@{" => 102,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'LBRACE' => 77,
			"undef" => 98,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127
		},
		GOTOS => {
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92,
			'Literal' => 95,
			'SubExpression' => 218,
			'HashReference' => 74,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'Expression' => 126,
			'Operator' => 85
		}
	},
	{#State 134
		ACTIONS => {
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"undef" => 98
		},
		GOTOS => {
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'Expression' => 126,
			'HashReference' => 74,
			'Operator' => 85,
			'Literal' => 95,
			'SubExpression' => 219
		}
	},
	{#State 135
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"undef" => 98,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132,
			'Operator' => 85,
			'HashReference' => 74,
			'Expression' => 126,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'Literal' => 95,
			'SubExpression' => 220
		}
	},
	{#State 136
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			"%{" => 101,
			"\@{" => 102,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105,
			'Literal' => 95,
			'SubExpression' => 221,
			'Operator' => 85,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'HashReference' => 74
		}
	},
	{#State 137
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 222
		}
	},
	{#State 138
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"%{" => 101,
			"\@{" => 102,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132,
			'Literal' => 95,
			'SubExpression' => 223,
			'Operator' => 85,
			'HashReference' => 74,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'Expression' => 126
		}
	},
	{#State 139
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			"\@{" => 102,
			"%{" => 101,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"undef" => 98,
			'LBRACE' => 77,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_OPEN' => 88,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28
		},
		GOTOS => {
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92,
			'Expression' => 126,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'HashReference' => 74,
			'Operator' => 85,
			'Literal' => 95,
			'SubExpression' => 224
		}
	},
	{#State 140
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"undef" => 98,
			'LBRACE' => 77,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Literal' => 95,
			'SubExpression' => 225,
			'Operator' => 85,
			'HashReference' => 74,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'Expression' => 126,
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132
		}
	},
	{#State 141
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'VARIABLE_SYMBOL' => 109,
			'LITERAL_STRING' => 79
		},
		GOTOS => {
			'VariableOrLiteral' => 227,
			'Literal' => 226,
			'Variable' => 228
		}
	},
	{#State 142
		ACTIONS => {
			"%{" => 101,
			"\@{" => 102,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Literal' => 95,
			'SubExpression' => 229,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'HashReference' => 74,
			'Operator' => 85,
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92
		}
	},
	{#State 143
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"%{" => 101,
			"\@{" => 102,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'LBRACE' => 77,
			"undef" => 98,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108
		},
		GOTOS => {
			'Literal' => 95,
			'SubExpression' => 230,
			'Operator' => 85,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132
		}
	},
	{#State 144
		ACTIONS => {
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'LBRACE' => 77,
			"undef" => 98,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"%{" => 101,
			"\@{" => 102,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105,
			'Operator' => 85,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'HashReference' => 74,
			'Literal' => 95,
			'SubExpression' => 231
		}
	},
	{#State 145
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"undef" => 98,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"%{" => 101,
			"\@{" => 102
		},
		GOTOS => {
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92,
			'SubExpression' => 232,
			'Literal' => 95,
			'Expression' => 126,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'HashReference' => 74,
			'Operator' => 85
		}
	},
	{#State 146
		ACTIONS => {
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"undef" => 98,
			'LBRACE' => 77,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"%{" => 101,
			"\@{" => 102,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97
		},
		GOTOS => {
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92,
			'SubExpression' => 233,
			'Literal' => 95,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'Operator' => 85
		}
	},
	{#State 147
		ACTIONS => {
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_OPEN' => 88,
			"undef" => 98,
			'LBRACE' => 77,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			"\@{" => 102,
			"%{" => 101,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97
		},
		GOTOS => {
			'Literal' => 95,
			'SubExpression' => 234,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'Operator' => 85,
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92
		}
	},
	{#State 148
		ACTIONS => {
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_OPEN' => 88,
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			"undef" => 98,
			'LBRACE' => 77,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			"%{" => 101,
			"\@{" => 102,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106
		},
		GOTOS => {
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92,
			'SubExpression' => 235,
			'Literal' => 95,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'Operator' => 85
		}
	},
	{#State 149
		ACTIONS => {
			"undef" => 98,
			'LBRACE' => 77,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'WORD_UPPERCASE' => 127,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_OPEN' => 88
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105,
			'Operator' => 85,
			'Expression' => 126,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'HashReference' => 74,
			'Literal' => 95,
			'SubExpression' => 236
		}
	},
	{#State 150
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 237
		}
	},
	{#State 151
		ACTIONS => {
			";" => 238
		}
	},
	{#State 152
		ACTIONS => {
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => 136,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP09_BITWISE_SHIFT' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP21_LIST_COMMA' => -177,
			";" => -177,
			'OP08_STRING_CAT' => 143,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 141,
			")" => -177,
			'OP11_COMPARE_LT_GT' => 140,
			"]" => -177,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138
		}
	},
	{#State 153
		DEFAULT => -137
	},
	{#State 154
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 239
		}
	},
	{#State 155
		DEFAULT => -212
	},
	{#State 156
		DEFAULT => -190
	},
	{#State 157
		DEFAULT => -197
	},
	{#State 158
		DEFAULT => -213
	},
	{#State 159
		ACTIONS => {
			'OP20_HASH_FATARROW' => 240
		}
	},
	{#State 160
		DEFAULT => -211
	},
	{#State 161
		ACTIONS => {
			'OP23_LOGICAL_AND' => -104,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			"]" => -104,
			'OP18_TERNARY' => 141,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			")" => -104,
			'OP11_COMPARE_LT_GT' => 140,
			";" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP08_STRING_CAT' => 143,
			"}" => -104,
			'OP06_REGEX_MATCH' => 137,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP17_LIST_RANGE' => 136
		}
	},
	{#State 162
		ACTIONS => {
			'LBRACE' => 77,
			"undef" => 98,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'MY' => 131,
			"\@{" => 102,
			"%{" => 101,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 130,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132,
			'Operator' => 85,
			'HashReference' => 74,
			'ListElement' => 150,
			'WordScoped' => 96,
			'Expression' => 126,
			'ArrayReference' => 75,
			'TypeInner' => 128,
			'ListElements' => 241,
			'SubExpression' => 152,
			'Literal' => 95
		}
	},
	{#State 163
		ACTIONS => {
			'MY' => 131,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 130,
			'OP01_NAMED' => 125,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105,
			'Operator' => 85,
			'Expression' => 126,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'HashReference' => 74,
			'ListElement' => 150,
			'TypeInner' => 128,
			'SubExpression' => 152,
			'Literal' => 95,
			'ListElements' => 242
		}
	},
	{#State 164
		DEFAULT => -108
	},
	{#State 165
		DEFAULT => -107
	},
	{#State 166
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 140,
			")" => 243,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP17_LIST_RANGE' => 136,
			'OP06_REGEX_MATCH' => 137,
			'OP08_STRING_CAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP04_MATH_POW' => 148,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138,
			'OP23_LOGICAL_AND' => 147,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139
		}
	},
	{#State 167
		DEFAULT => -82
	},
	{#State 168
		ACTIONS => {
			"filehandleref" => 244
		}
	},
	{#State 169
		DEFAULT => -76
	},
	{#State 170
		ACTIONS => {
			")" => 245
		}
	},
	{#State 171
		DEFAULT => -16
	},
	{#State 172
		DEFAULT => -152
	},
	{#State 173
		ACTIONS => {
			'MY' => 246
		}
	},
	{#State 174
		ACTIONS => {
			'LPAREN' => 247
		}
	},
	{#State 175
		DEFAULT => -153
	},
	{#State 176
		ACTIONS => {
			'MY' => 248
		}
	},
	{#State 177
		DEFAULT => -141
	},
	{#State 178
		DEFAULT => -154
	},
	{#State 179
		ACTIONS => {
			'MY' => 131,
			"\@{" => 102,
			"%{" => 101,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 130,
			'OP01_NAMED' => 125,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			")" => -118,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'HashReference' => 74,
			'ListElement' => 150,
			'Operator' => 85,
			'Literal' => 95,
			'OPTIONAL-32' => 249,
			'SubExpression' => 152,
			'ListElements' => 250,
			'TypeInner' => 128,
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92
		}
	},
	{#State 180
		ACTIONS => {
			")" => 251
		}
	},
	{#State 181
		DEFAULT => -83
	},
	{#State 182
		ACTIONS => {
			"]" => 252
		}
	},
	{#State 183
		DEFAULT => -180
	},
	{#State 184
		ACTIONS => {
			"}" => 253
		}
	},
	{#State 185
		DEFAULT => -198
	},
	{#State 186
		ACTIONS => {
			'LBRACE' => 77
		},
		GOTOS => {
			'HashReference' => 254
		}
	},
	{#State 187
		ACTIONS => {
			'LBRACKET' => 100
		},
		GOTOS => {
			'ArrayReference' => 255
		}
	},
	{#State 188
		ACTIONS => {
			"}" => 256
		}
	},
	{#State 189
		DEFAULT => -183
	},
	{#State 190
		ACTIONS => {
			'VARIABLE_SYMBOL' => 257
		}
	},
	{#State 191
		ACTIONS => {
			'OP06_REGEX_MATCH' => 137,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP21_LIST_COMMA' => -94,
			";" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => -94,
			"}" => -94,
			'OP08_STRING_CAT' => 143,
			'OP18_TERNARY' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			")" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP07_STRING_REPEAT' => 149,
			"]" => -94,
			'OP08_MATH_ADD_SUB' => 139,
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94
		}
	},
	{#State 192
		ACTIONS => {
			'OP07_STRING_REPEAT' => -163,
			"]" => -163,
			'OP20_HASH_FATARROW' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP04_MATH_POW' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP02_HASH_THINARROW' => 259,
			'OP15_LOGICAL_AND' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP02_ARRAY_THINARROW' => 260,
			'OP17_LIST_RANGE' => -163,
			";" => -163,
			'OP21_LIST_COMMA' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP13_BITWISE_AND' => -163,
			"}" => -163,
			'OP08_STRING_CAT' => -163,
			'OP18_TERNARY' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			")" => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'COLON' => -163,
			'OP02_METHOD_THINARROW' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 258
		}
	},
	{#State 193
		DEFAULT => -204
	},
	{#State 194
		ACTIONS => {
			";" => 261
		}
	},
	{#State 195
		ACTIONS => {
			";" => -86,
			'OP21_LIST_COMMA' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP08_STRING_CAT' => -86,
			"}" => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP18_TERNARY' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			")" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP07_STRING_REPEAT' => -86,
			"]" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 196
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 130,
			'OP01_NAMED' => 125,
			'MY' => 131,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'LBRACE' => 77,
			"undef" => 98,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127
		},
		GOTOS => {
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'ListElement' => 262,
			'HashReference' => 74,
			'Operator' => 85,
			'SubExpression' => 124,
			'Literal' => 95,
			'TypeInner' => 128
		}
	},
	{#State 197
		ACTIONS => {
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => 136,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP09_BITWISE_SHIFT' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP08_STRING_CAT' => 143,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 140,
			")" => 263,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138
		}
	},
	{#State 198
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 264
		}
	},
	{#State 199
		ACTIONS => {
			'LPAREN' => 265
		}
	},
	{#State 200
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'STDIN' => 268,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'LBRACE' => 77,
			"undef" => 98,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97
		},
		GOTOS => {
			'Variable' => 132,
			'HashDereference' => 105,
			'SubExpressionOrStdin' => 266,
			'ArrayDereference' => 92,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'Expression' => 126,
			'HashReference' => 74,
			'Operator' => 85,
			'Literal' => 95,
			'SubExpression' => 267
		}
	},
	{#State 201
		ACTIONS => {
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114
		},
		GOTOS => {
			'Literal' => 95,
			'SubExpression' => 269,
			'Expression' => 126,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'HashReference' => 74,
			'Operator' => 85,
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92
		}
	},
	{#State 202
		DEFAULT => -84
	},
	{#State 203
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"\@{" => 102,
			"%{" => 101,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"undef" => 98,
			'LBRACE' => 77,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_UPPERCASE' => 127,
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92,
			'Expression' => 126,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'HashReference' => 74,
			'Operator' => 85,
			'SubExpression' => 270,
			'Literal' => 95
		}
	},
	{#State 204
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 271
		}
	},
	{#State 205
		DEFAULT => -42
	},
	{#State 206
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 272
		}
	},
	{#State 207
		ACTIONS => {
			";" => 273
		}
	},
	{#State 208
		ACTIONS => {
			"\$TYPED_" => 274
		}
	},
	{#State 209
		DEFAULT => -40
	},
	{#State 210
		DEFAULT => -53
	},
	{#State 211
		ACTIONS => {
			"use constant" => 44,
			"our hashref \$properties" => 276
		},
		GOTOS => {
			'Properties' => 275,
			'Constant' => 277
		}
	},
	{#State 212
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP21_LIST_COMMA' => -79,
			";" => -79,
			'OP08_STRING_CAT' => -79,
			"}" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP18_TERNARY' => -79,
			")" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			"]" => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP04_MATH_POW' => -79
		}
	},
	{#State 213
		ACTIONS => {
			";" => -178,
			'OP21_LIST_COMMA' => -178,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP08_STRING_CAT' => 143,
			'OP06_REGEX_MATCH' => 137,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP17_LIST_RANGE' => 136,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			")" => -178,
			'OP11_COMPARE_LT_GT' => 140,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			"]" => -178,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 214
		ACTIONS => {
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 130,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'MY' => 131,
			"\@{" => 102,
			"%{" => 101,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114
		},
		GOTOS => {
			'TypeInner' => 128,
			'Literal' => 95,
			'SubExpression' => 152,
			'ListElements' => 278,
			'Operator' => 85,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'ListElement' => 150,
			'HashReference' => 74,
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105
		}
	},
	{#State 215
		DEFAULT => -176
	},
	{#State 216
		ACTIONS => {
			")" => 280,
			'WORD' => 279
		}
	},
	{#State 217
		ACTIONS => {
			"\$TYPED_" => 281
		}
	},
	{#State 218
		ACTIONS => {
			'OP23_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			"]" => -97,
			'OP18_TERNARY' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			")" => -97,
			'OP11_COMPARE_LT_GT' => 140,
			";" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => -97,
			"}" => -97,
			'OP08_STRING_CAT' => 143,
			'OP06_REGEX_MATCH' => 137,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP17_LIST_RANGE' => -97
		}
	},
	{#State 219
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -90,
			")" => -90,
			'OP18_TERNARY' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			"}" => -90,
			'OP08_STRING_CAT' => -90,
			";" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP06_REGEX_MATCH' => 137,
			'OP16_LOGICAL_OR' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => -90,
			'OP07_STRING_REPEAT' => 149,
			"]" => -90
		}
	},
	{#State 220
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP18_TERNARY' => 141,
			")" => -106,
			'OP11_COMPARE_LT_GT' => 140,
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => 136,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 145,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			";" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP08_STRING_CAT' => 143,
			"}" => -106,
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => 147,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			"]" => -106,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139
		}
	},
	{#State 221
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			"]" => -102,
			'OP07_STRING_REPEAT' => 149,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP18_TERNARY' => -102,
			")" => -102,
			'OP11_COMPARE_LT_GT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP21_LIST_COMMA' => -102,
			";" => -102,
			'OP08_STRING_CAT' => 143,
			"}" => -102,
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => -102
		}
	},
	{#State 222
		DEFAULT => -88
	},
	{#State 223
		ACTIONS => {
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			"]" => -101,
			'OP11_COMPARE_LT_GT' => 140,
			")" => -101,
			'OP18_TERNARY' => -101,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP08_STRING_CAT' => 143,
			"}" => -101,
			'OP21_LIST_COMMA' => -101,
			";" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP06_REGEX_MATCH' => 137
		}
	},
	{#State 224
		ACTIONS => {
			'OP23_LOGICAL_AND' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => -91,
			'OP07_STRING_REPEAT' => 149,
			"]" => -91,
			'OP18_TERNARY' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			")" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			";" => -91,
			'OP21_LIST_COMMA' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			"}" => -91,
			'OP08_STRING_CAT' => -91,
			'OP06_REGEX_MATCH' => 137,
			'OP09_BITWISE_SHIFT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91
		}
	},
	{#State 225
		ACTIONS => {
			'OP07_STRING_REPEAT' => 149,
			"]" => -96,
			'OP08_MATH_ADD_SUB' => 139,
			'OP04_MATH_POW' => 148,
			'OP15_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP09_BITWISE_SHIFT' => 145,
			'OP17_LIST_RANGE' => -96,
			'OP06_REGEX_MATCH' => 137,
			"}" => -96,
			'OP08_STRING_CAT' => 143,
			";" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -96,
			'OP18_TERNARY' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP14_BITWISE_OR_XOR' => -96
		}
	},
	{#State 226
		DEFAULT => -210
	},
	{#State 227
		ACTIONS => {
			'COLON' => 282
		}
	},
	{#State 228
		DEFAULT => -209
	},
	{#State 229
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP15_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP07_STRING_REPEAT' => 149,
			"]" => -99,
			'OP08_MATH_ADD_SUB' => 139,
			'OP11_COMPARE_LT_GT' => 140,
			")" => -99,
			'OP18_TERNARY' => -99,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP06_REGEX_MATCH' => 137,
			'OP08_STRING_CAT' => 143,
			"}" => -99,
			";" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144
		}
	},
	{#State 230
		ACTIONS => {
			'OP08_STRING_CAT' => -92,
			"}" => -92,
			";" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP06_REGEX_MATCH' => 137,
			'OP11_COMPARE_LT_GT' => -92,
			")" => -92,
			'OP18_TERNARY' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			"]" => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 231
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP16_LOGICAL_OR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP23_LOGICAL_AND' => -98,
			"]" => -98,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP11_COMPARE_LT_GT' => 140,
			")" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP18_TERNARY' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP09_BITWISE_SHIFT' => 145,
			'OP06_REGEX_MATCH' => 137,
			'OP08_STRING_CAT' => 143,
			"}" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			";" => -98,
			'OP21_LIST_COMMA' => -98
		}
	},
	{#State 232
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -93,
			")" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP18_TERNARY' => -93,
			"}" => -93,
			'OP08_STRING_CAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => -93,
			'OP21_LIST_COMMA' => -93,
			";" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP06_REGEX_MATCH' => 137,
			'OP15_LOGICAL_AND' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			"]" => -93,
			'OP07_STRING_REPEAT' => 149
		}
	},
	{#State 233
		ACTIONS => {
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP09_BITWISE_SHIFT' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP21_LIST_COMMA' => -100,
			";" => -100,
			'OP08_STRING_CAT' => 143,
			"}" => -100,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP18_TERNARY' => -100,
			")" => -100,
			'OP11_COMPARE_LT_GT' => 140,
			"]" => -100,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100
		}
	},
	{#State 234
		ACTIONS => {
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => 136,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP21_LIST_COMMA' => -105,
			";" => -105,
			'OP08_STRING_CAT' => 143,
			"}" => -105,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 141,
			")" => -105,
			'OP11_COMPARE_LT_GT' => 140,
			"]" => -105,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => -105,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138
		}
	},
	{#State 235
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -85,
			")" => -85,
			'OP18_TERNARY' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP06_REGEX_MATCH' => -85,
			"}" => -85,
			'OP08_STRING_CAT' => -85,
			";" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP04_MATH_POW' => 148,
			'OP16_LOGICAL_OR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP07_STRING_REPEAT' => -85,
			"]" => -85,
			'OP08_MATH_ADD_SUB' => -85
		}
	},
	{#State 236
		ACTIONS => {
			'OP07_STRING_REPEAT' => -89,
			"]" => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP06_REGEX_MATCH' => 137,
			'OP09_BITWISE_SHIFT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP17_LIST_RANGE' => -89,
			";" => -89,
			'OP21_LIST_COMMA' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			"}" => -89,
			'OP08_STRING_CAT' => -89,
			'OP18_TERNARY' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			")" => -89,
			'OP11_COMPARE_LT_GT' => -89
		}
	},
	{#State 237
		ACTIONS => {
			'OP21_LIST_COMMA' => 283,
			";" => -174,
			")" => -174,
			"]" => -174
		},
		GOTOS => {
			'PAREN-42' => 284
		}
	},
	{#State 238
		DEFAULT => -113
	},
	{#State 239
		ACTIONS => {
			'OP21_LIST_COMMA' => 287,
			"}" => 286
		},
		GOTOS => {
			'PAREN-48' => 285
		}
	},
	{#State 240
		ACTIONS => {
			'OP01_NAMED' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'LBRACKET' => -188,
			'LITERAL_STRING' => -188,
			"undef" => -188,
			'LBRACE' => -188,
			'OP22_LOGICAL_NEG' => -188,
			'LITERAL_NUMBER' => -188,
			"%{" => -188,
			"\@{" => -188,
			'MY' => 131,
			'OP10_NAMED_UNARY' => -188,
			'VARIABLE_SYMBOL' => -188,
			'OP01_OPEN' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'OP01_CLOSE' => -188,
			'WORD_UPPERCASE' => -188,
			'WORD' => -188,
			'WORD_SCOPED' => -188,
			'LPAREN' => -188,
			'OP05_LOGICAL_NEG' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 289,
			'TypeInner' => 288
		}
	},
	{#State 241
		ACTIONS => {
			";" => 290
		}
	},
	{#State 242
		ACTIONS => {
			";" => 291
		}
	},
	{#State 243
		DEFAULT => -87
	},
	{#State 244
		ACTIONS => {
			'FH_REF_SYMBOL' => 292
		}
	},
	{#State 245
		DEFAULT => -123
	},
	{#State 246
		ACTIONS => {
			'TYPE_INTEGER' => 293
		}
	},
	{#State 247
		ACTIONS => {
			"undef" => 98,
			'LBRACE' => 77,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_OPEN' => 88
		},
		GOTOS => {
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92,
			'HashReference' => 74,
			'Expression' => 126,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Operator' => 85,
			'Literal' => 95,
			'SubExpression' => 294
		}
	},
	{#State 248
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 295
		}
	},
	{#State 249
		ACTIONS => {
			")" => 296
		}
	},
	{#State 250
		DEFAULT => -117
	},
	{#State 251
		DEFAULT => -125
	},
	{#State 252
		DEFAULT => -182
	},
	{#State 253
		DEFAULT => -200
	},
	{#State 254
		ACTIONS => {
			"}" => 297
		}
	},
	{#State 255
		ACTIONS => {
			"}" => 298
		}
	},
	{#State 256
		DEFAULT => -185
	},
	{#State 257
		ACTIONS => {
			";" => 300,
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 258
		DEFAULT => -161
	},
	{#State 259
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			"%{" => 101,
			"\@{" => 102,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			'LBRACE' => 77,
			"undef" => 98,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_SCOPED' => 27,
			'WORD' => 301,
			'WORD_UPPERCASE' => 127
		},
		GOTOS => {
			'SubExpression' => 302,
			'Literal' => 95,
			'Operator' => 85,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'HashReference' => 74,
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105
		}
	},
	{#State 260
		ACTIONS => {
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"\@{" => 102,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'SubExpression' => 303,
			'Literal' => 95,
			'HashReference' => 74,
			'Expression' => 126,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Operator' => 85,
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92
		}
	},
	{#State 261
		DEFAULT => -116
	},
	{#State 262
		ACTIONS => {
			'OP21_LIST_COMMA' => 304
		}
	},
	{#State 263
		DEFAULT => -134
	},
	{#State 264
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP01_NAMED' => 125,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 97,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			"undef" => 98,
			'LBRACE' => 77,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"%{" => 101,
			"\@{" => 102,
			'MY' => 131
		},
		GOTOS => {
			'Operator' => 85,
			'HashReference' => 74,
			'ListElement' => 150,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'TypeInner' => 128,
			'ListElements' => 305,
			'Literal' => 95,
			'SubExpression' => 152,
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132
		}
	},
	{#State 265
		ACTIONS => {
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'MY' => 131,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_QW' => 130,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			")" => -120,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88
		},
		GOTOS => {
			'OPTIONAL-33' => 307,
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132,
			'TypeInner' => 128,
			'ListElements' => 306,
			'SubExpression' => 152,
			'Literal' => 95,
			'Operator' => 85,
			'ListElement' => 150,
			'HashReference' => 74,
			'WordScoped' => 96,
			'Expression' => 126,
			'ArrayReference' => 75
		}
	},
	{#State 266
		ACTIONS => {
			";" => 308
		}
	},
	{#State 267
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => 147,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 140,
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => 136,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			";" => -135,
			'OP08_STRING_CAT' => 143
		}
	},
	{#State 268
		DEFAULT => -136
	},
	{#State 269
		ACTIONS => {
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP04_MATH_POW' => 148,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138,
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => 136,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP09_BITWISE_SHIFT' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			";" => 309,
			'OP08_STRING_CAT' => 143,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 140
		}
	},
	{#State 270
		ACTIONS => {
			'OP08_STRING_CAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP09_BITWISE_SHIFT' => 145,
			'OP17_LIST_RANGE' => 136,
			'OP06_REGEX_MATCH' => 137,
			'OP11_COMPARE_LT_GT' => 140,
			")" => 310,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138,
			'OP23_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 148
		}
	},
	{#State 271
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'MY' => 104,
			'OP01_NAMED_VOID_SCOLON' => 103,
			"\@{" => 102,
			"%{" => 101,
			'LITERAL_NUMBER' => 106,
			"undef" => 98,
			'LBRACKET' => 100,
			'OP19_LOOP_CONTROL' => 110,
			"}" => 312,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP05_LOGICAL_NEG' => 113,
			"while" => -139,
			'LPAREN' => 114,
			"for" => -139,
			"if" => 116,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'OP01_NAMED_VOID' => 73,
			'OP01_NAMED' => 71,
			'OP22_LOGICAL_NEG' => 81,
			'LBRACE' => 77,
			"foreach" => -139,
			'LITERAL_STRING' => 79,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'OP01_PRINT' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'WORD_UPPERCASE' => 91
		},
		GOTOS => {
			'Operator' => 85,
			'Expression' => 89,
			'PAREN-34' => 107,
			'ArrayDereference' => 92,
			'Variable' => 115,
			'OPTIONAL-35' => 94,
			'VariableModification' => 112,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'SubExpression' => 72,
			'Literal' => 95,
			'OperatorVoid' => 80,
			'HashDereference' => 105,
			'VariableDeclaration' => 82,
			'Operation' => 311,
			'Statement' => 99,
			'LoopLabel' => 76,
			'Conditional' => 78
		}
	},
	{#State 272
		ACTIONS => {
			'VARIABLE_SYMBOL' => 313
		}
	},
	{#State 273
		DEFAULT => -41
	},
	{#State 274
		ACTIONS => {
			'WORD_UPPERCASE' => 314
		}
	},
	{#State 275
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 315
		}
	},
	{#State 276
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 316
		}
	},
	{#State 277
		DEFAULT => -55
	},
	{#State 278
		ACTIONS => {
			";" => 317
		}
	},
	{#State 279
		DEFAULT => -175
	},
	{#State 280
		DEFAULT => -179
	},
	{#State 281
		ACTIONS => {
			'WORD' => 318
		}
	},
	{#State 282
		ACTIONS => {
			'LITERAL_NUMBER' => 106,
			'LITERAL_STRING' => 79,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'VariableOrLiteral' => 319,
			'Literal' => 226,
			'Variable' => 228
		}
	},
	{#State 283
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'MY' => 131,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"undef" => 98,
			'LBRACE' => 77,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105,
			'TypeInner' => 128,
			'Literal' => 95,
			'SubExpression' => 152,
			'Operator' => 85,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'HashReference' => 74,
			'ListElement' => 320
		}
	},
	{#State 284
		DEFAULT => -172
	},
	{#State 285
		DEFAULT => -194
	},
	{#State 286
		DEFAULT => -196
	},
	{#State 287
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'LITERAL_STRING' => 79,
			'WORD' => 158,
			'LITERAL_NUMBER' => 106,
			"%{" => 101
		},
		GOTOS => {
			'Literal' => 155,
			'HashEntry' => 321,
			'VariableOrLiteralOrWord' => 159,
			'HashDereference' => 156,
			'Variable' => 160
		}
	},
	{#State 288
		DEFAULT => -187
	},
	{#State 289
		ACTIONS => {
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125
		},
		GOTOS => {
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92,
			'SubExpression' => 322,
			'Literal' => 95,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'Operator' => 85
		}
	},
	{#State 290
		DEFAULT => -110
	},
	{#State 291
		DEFAULT => -111
	},
	{#State 292
		ACTIONS => {
			'OP21_LIST_COMMA' => 323
		}
	},
	{#State 293
		ACTIONS => {
			'VARIABLE_SYMBOL' => 324
		}
	},
	{#State 294
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 148,
			'OP08_STRING_CAT' => 143,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP17_LIST_RANGE' => 136,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP09_BITWISE_SHIFT' => 145,
			'OP06_REGEX_MATCH' => 137,
			")" => 325,
			'OP11_COMPARE_LT_GT' => 140,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 141
		}
	},
	{#State 295
		ACTIONS => {
			'VARIABLE_SYMBOL' => 326
		}
	},
	{#State 296
		DEFAULT => -122
	},
	{#State 297
		DEFAULT => -201
	},
	{#State 298
		DEFAULT => -186
	},
	{#State 299
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"undef" => 98,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 127,
			'STDIN' => 268
		},
		GOTOS => {
			'HashDereference' => 105,
			'SubExpressionOrStdin' => 327,
			'Variable' => 132,
			'ArrayDereference' => 92,
			'HashReference' => 74,
			'WordScoped' => 96,
			'Expression' => 126,
			'ArrayReference' => 75,
			'Operator' => 85,
			'Literal' => 95,
			'SubExpression' => 267
		}
	},
	{#State 300
		DEFAULT => -167
	},
	{#State 301
		ACTIONS => {
			'LPAREN' => -202,
			"}" => 328,
			'OP02_METHOD_THINARROW_NEW' => -202
		}
	},
	{#State 302
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 140,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP08_STRING_CAT' => 143,
			"}" => 329,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP17_LIST_RANGE' => 136,
			'OP06_REGEX_MATCH' => 137,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149
		}
	},
	{#State 303
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			"]" => 330,
			'OP07_STRING_REPEAT' => 149,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138,
			'OP04_MATH_POW' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP08_STRING_CAT' => 143,
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => 136,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 140
		}
	},
	{#State 304
		ACTIONS => {
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_OPEN' => 88,
			'WORD_UPPERCASE' => 127,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP01_NAMED' => 125,
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 97,
			"undef" => 98,
			'LBRACE' => 77,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"%{" => 101,
			"\@{" => 102,
			'MY' => 131,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105,
			'Operator' => 85,
			'Expression' => 126,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'HashReference' => 74,
			'ListElement' => 150,
			'TypeInner' => 128,
			'Literal' => 95,
			'SubExpression' => 152,
			'ListElements' => 331
		}
	},
	{#State 305
		ACTIONS => {
			")" => 332
		}
	},
	{#State 306
		DEFAULT => -119
	},
	{#State 307
		ACTIONS => {
			")" => 333
		}
	},
	{#State 308
		DEFAULT => -169
	},
	{#State 309
		DEFAULT => -170
	},
	{#State 310
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 335
		}
	},
	{#State 311
		DEFAULT => -44
	},
	{#State 312
		ACTIONS => {
			";" => 336
		}
	},
	{#State 313
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 337
		}
	},
	{#State 314
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 338
		}
	},
	{#State 315
		ACTIONS => {
			'LITERAL_NUMBER' => 339,
			"our" => 341
		},
		GOTOS => {
			'Method' => 343,
			'MethodOrSubroutine' => 342,
			'Subroutine' => 340
		}
	},
	{#State 316
		ACTIONS => {
			'LBRACE' => 344
		}
	},
	{#State 317
		DEFAULT => -114
	},
	{#State 318
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 345
		}
	},
	{#State 319
		DEFAULT => -103
	},
	{#State 320
		DEFAULT => -171
	},
	{#State 321
		DEFAULT => -193
	},
	{#State 322
		ACTIONS => {
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP04_MATH_POW' => 148,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP17_LIST_RANGE' => 136,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP09_BITWISE_SHIFT' => 145,
			'OP06_REGEX_MATCH' => 137,
			"}" => -189,
			'OP08_STRING_CAT' => 143,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP21_LIST_COMMA' => -189,
			'OP11_COMPARE_LT_GT' => 140,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 141
		}
	},
	{#State 323
		ACTIONS => {
			'LITERAL_STRING' => 346
		}
	},
	{#State 324
		ACTIONS => {
			'LPAREN' => 347
		}
	},
	{#State 325
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 348
		}
	},
	{#State 326
		ACTIONS => {
			'LPAREN' => 349
		}
	},
	{#State 327
		ACTIONS => {
			";" => 350
		}
	},
	{#State 328
		DEFAULT => -166
	},
	{#State 329
		DEFAULT => -165
	},
	{#State 330
		DEFAULT => -164
	},
	{#State 331
		ACTIONS => {
			")" => 351
		}
	},
	{#State 332
		DEFAULT => -78
	},
	{#State 333
		DEFAULT => -124
	},
	{#State 334
		ACTIONS => {
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"foreach" => -139,
			"undef" => 98,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'MY' => 104,
			'OP01_NAMED_VOID_SCOLON' => 103,
			"%{" => 101,
			"\@{" => 102,
			'OP01_NAMED' => 71,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED_VOID' => 73,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'WORD_UPPERCASE' => 91,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			"if" => 116,
			"for" => -139,
			'OP05_LOGICAL_NEG' => 113,
			"while" => -139,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 108,
			'OP01_PRINT' => 84,
			'VARIABLE_SYMBOL' => 109,
			'OP01_OPEN' => 88,
			'OP19_LOOP_CONTROL' => 110,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'LoopLabel' => 76,
			'Statement' => 99,
			'Conditional' => 78,
			'OperatorVoid' => 80,
			'Operation' => 353,
			'VariableDeclaration' => 82,
			'HashDereference' => 105,
			'PLUS-40' => 352,
			'Literal' => 95,
			'SubExpression' => 72,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'HashReference' => 74,
			'VariableModification' => 112,
			'ArrayDereference' => 92,
			'OPTIONAL-35' => 94,
			'Variable' => 115,
			'PAREN-34' => 107,
			'Operator' => 85,
			'Expression' => 89
		}
	},
	{#State 335
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 354
		}
	},
	{#State 336
		DEFAULT => -46
	},
	{#State 337
		ACTIONS => {
			")" => 357,
			'OP21_LIST_COMMA' => 355
		},
		GOTOS => {
			'PAREN-18' => 356
		}
	},
	{#State 338
		DEFAULT => -208
	},
	{#State 339
		ACTIONS => {
			";" => 358
		}
	},
	{#State 340
		DEFAULT => -75
	},
	{#State 341
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 53,
			'TYPE_METHOD' => 359
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 342
		DEFAULT => -57
	},
	{#State 343
		DEFAULT => -74
	},
	{#State 344
		ACTIONS => {
			'WORD' => 361,
			"%{" => 101,
			"}" => 362
		},
		GOTOS => {
			'HashDereference' => 360,
			'HashEntryTyped' => 363
		}
	},
	{#State 345
		DEFAULT => -207
	},
	{#State 346
		ACTIONS => {
			'OP21_LIST_COMMA' => 364
		}
	},
	{#State 347
		ACTIONS => {
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"%{" => 101,
			"\@{" => 102,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"undef" => 98
		},
		GOTOS => {
			'Operator' => 85,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'HashReference' => 74,
			'SubExpression' => 365,
			'Literal' => 95,
			'ArrayDereference' => 92,
			'Variable' => 132,
			'HashDereference' => 105
		}
	},
	{#State 348
		DEFAULT => -157
	},
	{#State 349
		ACTIONS => {
			'OP01_QW' => 130,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'LITERAL_NUMBER' => 106,
			'OP22_LOGICAL_NEG' => 81,
			"\@{" => 102,
			"%{" => 101,
			'MY' => 131,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			"undef" => 98,
			'LBRACE' => 77,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28
		},
		GOTOS => {
			'TypeInner' => 128,
			'ListElements' => 366,
			'SubExpression' => 152,
			'Literal' => 95,
			'Operator' => 85,
			'ListElement' => 150,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126,
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132
		}
	},
	{#State 350
		DEFAULT => -168
	},
	{#State 351
		DEFAULT => -80
	},
	{#State 352
		ACTIONS => {
			"}" => 367,
			'OP19_LOOP_CONTROL' => 110,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			"for" => -139,
			"if" => 116,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			"while" => -139,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 97,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED_VOID_SCOLON' => 103,
			'MY' => 104,
			"%{" => 101,
			"\@{" => 102,
			'LBRACKET' => 100,
			"undef" => 98,
			'OP01_OPEN' => 88,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_PRINT' => 84,
			'WORD_UPPERCASE' => 91,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'OP01_NAMED_VOID' => 73,
			'OP01_NAMED' => 71,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 79,
			'LBRACE' => 77,
			"foreach" => -139
		},
		GOTOS => {
			'OperatorVoid' => 80,
			'VariableDeclaration' => 82,
			'HashDereference' => 105,
			'Operation' => 368,
			'Statement' => 99,
			'LoopLabel' => 76,
			'Conditional' => 78,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'SubExpression' => 72,
			'Literal' => 95,
			'ArrayDereference' => 92,
			'Variable' => 115,
			'OPTIONAL-35' => 94,
			'VariableModification' => 112,
			'Operator' => 85,
			'Expression' => 89,
			'PAREN-34' => 107
		}
	},
	{#State 353
		DEFAULT => -159
	},
	{#State 354
		ACTIONS => {
			'LBRACE' => -150,
			"foreach" => -150,
			'LITERAL_STRING' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'OP01_NAMED' => -150,
			'OP01_NAMED_VOID' => -150,
			'WORD_UPPERCASE' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP01_PRINT' => -150,
			'OP01_CLOSE' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'OP01_OPEN' => -150,
			"undef" => -150,
			"elsif" => 373,
			'LBRACKET' => -150,
			'MY' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			"\@{" => -150,
			"%{" => -150,
			"else" => 371,
			'LITERAL_NUMBER' => -150,
			'' => -150,
			'OP03_MATH_INC_DEC' => -150,
			'WORD' => -150,
			'WORD_SCOPED' => -150,
			'LPAREN' => -150,
			"while" => -150,
			'OP05_LOGICAL_NEG' => -150,
			"if" => -150,
			"for" => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP19_LOOP_CONTROL' => -150,
			"}" => -150
		},
		GOTOS => {
			'PAREN-36' => 369,
			'OPTIONAL-39' => 370,
			'PAREN-38' => 372
		}
	},
	{#State 355
		ACTIONS => {
			'MY' => 374
		}
	},
	{#State 356
		DEFAULT => -48
	},
	{#State 357
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 375
		}
	},
	{#State 358
		DEFAULT => -59
	},
	{#State 359
		ACTIONS => {
			'VARIABLE_SYMBOL' => 376
		}
	},
	{#State 360
		DEFAULT => -192
	},
	{#State 361
		ACTIONS => {
			'OP20_HASH_FATARROW' => 377
		}
	},
	{#State 362
		ACTIONS => {
			";" => 378
		}
	},
	{#State 363
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 379
		}
	},
	{#State 364
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"undef" => 98,
			'LBRACE' => 77,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_OPEN' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_UPPERCASE' => 127,
			'WORD_SCOPED' => 27,
			'WORD' => 28
		},
		GOTOS => {
			'HashReference' => 74,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'Operator' => 85,
			'SubExpression' => 380,
			'Literal' => 95,
			'HashDereference' => 105,
			'Variable' => 132,
			'ArrayDereference' => 92
		}
	},
	{#State 365
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			'OP23_LOGICAL_AND' => 147,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP08_STRING_CAT' => 143,
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => 381,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 140
		}
	},
	{#State 366
		ACTIONS => {
			")" => 382
		}
	},
	{#State 367
		DEFAULT => -160
	},
	{#State 368
		DEFAULT => -158
	},
	{#State 369
		DEFAULT => -146
	},
	{#State 370
		DEFAULT => -151
	},
	{#State 371
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 383
		}
	},
	{#State 372
		DEFAULT => -149
	},
	{#State 373
		ACTIONS => {
			'LPAREN' => 384
		}
	},
	{#State 374
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 385
		}
	},
	{#State 375
		ACTIONS => {
			"\@_;" => 386
		}
	},
	{#State 376
		ACTIONS => {
			"= sub {" => 387
		}
	},
	{#State 377
		ACTIONS => {
			'MY' => 131
		},
		GOTOS => {
			'TypeInner' => 388
		}
	},
	{#State 378
		DEFAULT => -64
	},
	{#State 379
		ACTIONS => {
			"}" => 389,
			'OP21_LIST_COMMA' => 390
		},
		GOTOS => {
			'PAREN-24' => 391
		}
	},
	{#State 380
		ACTIONS => {
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => -81,
			'OP04_MATH_POW' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			"]" => -81,
			'OP07_STRING_REPEAT' => 149,
			'OP11_COMPARE_LT_GT' => 140,
			")" => -81,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP18_TERNARY' => 141,
			"}" => -81,
			'OP08_STRING_CAT' => 143,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			";" => -81,
			'OP21_LIST_COMMA' => -81,
			'OP17_LIST_RANGE' => 136,
			'OP09_BITWISE_SHIFT' => 145,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => 137
		}
	},
	{#State 381
		ACTIONS => {
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'WORD_UPPERCASE' => 127,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'LBRACKET' => 100,
			'LITERAL_STRING' => 79,
			"undef" => 98,
			'LBRACE' => 77
		},
		GOTOS => {
			'Literal' => 95,
			'SubExpression' => 392,
			'Operator' => 85,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'Expression' => 126,
			'WordScoped' => 96,
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132
		}
	},
	{#State 382
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 393
		}
	},
	{#State 383
		DEFAULT => -148
	},
	{#State 384
		ACTIONS => {
			'LBRACE' => 77,
			"undef" => 98,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			'OP01_NAMED' => 125,
			'OP03_MATH_INC_DEC' => 97,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 113,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 108,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 87,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 88
		},
		GOTOS => {
			'ArrayDereference' => 92,
			'HashDereference' => 105,
			'Variable' => 132,
			'Literal' => 95,
			'SubExpression' => 394,
			'Operator' => 85,
			'HashReference' => 74,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'Expression' => 126
		}
	},
	{#State 385
		ACTIONS => {
			'VARIABLE_SYMBOL' => 395
		}
	},
	{#State 386
		DEFAULT => -50
	},
	{#State 387
		ACTIONS => {
			'OP01_NAMED_VOID' => -66,
			'OP01_NAMED' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'LITERAL_STRING' => -66,
			'LBRACE' => -66,
			"foreach" => -66,
			'OP01_OPEN' => -66,
			'OP01_CLOSE' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'LPAREN_MY' => 397,
			'OP01_PRINT' => -66,
			'WORD_UPPERCASE' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'LITERAL_NUMBER' => -66,
			'MY' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			"%{" => -66,
			"\@{" => -66,
			'LBRACKET' => -66,
			"undef" => -66,
			"}" => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP10_NAMED_UNARY' => -66,
			'VARIABLE_SYMBOL' => -66,
			"if" => -66,
			"for" => -66,
			'OP05_LOGICAL_NEG' => -66,
			'LPAREN' => -66,
			"while" => -66,
			'WORD_SCOPED' => -66,
			'WORD' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 398,
			'MethodArguments' => 396
		}
	},
	{#State 388
		ACTIONS => {
			"\@{" => 102,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_NUMBER' => 106,
			"undef" => 98,
			'LBRACE' => 77,
			'LITERAL_STRING' => 79,
			'LBRACKET' => 100,
			'OP03_MATH_INC_DEC' => 97,
			'OP01_NAMED' => 125,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_UPPERCASE' => 127,
			'WORD' => 28,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_OPEN' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108
		},
		GOTOS => {
			'Variable' => 132,
			'HashDereference' => 105,
			'ArrayDereference' => 92,
			'WordScoped' => 96,
			'ArrayReference' => 75,
			'Expression' => 126,
			'HashReference' => 74,
			'Operator' => 85,
			'SubExpression' => 399,
			'Literal' => 95
		}
	},
	{#State 389
		ACTIONS => {
			";" => 400
		}
	},
	{#State 390
		ACTIONS => {
			'WORD' => 361,
			"%{" => 101
		},
		GOTOS => {
			'HashEntryTyped' => 401,
			'HashDereference' => 360
		}
	},
	{#State 391
		DEFAULT => -61
	},
	{#State 392
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			'OP23_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP13_BITWISE_AND' => 144,
			'OP08_STRING_CAT' => 143,
			'OP06_REGEX_MATCH' => 137,
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP09_BITWISE_SHIFT' => 145,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => -102,
			")" => 402,
			'OP11_COMPARE_LT_GT' => 140
		}
	},
	{#State 393
		DEFAULT => -156
	},
	{#State 394
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP07_STRING_REPEAT' => 149,
			'OP23_LOGICAL_AND' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP16_LOGICAL_OR' => 138,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 134,
			'OP08_STRING_CAT' => 143,
			'OP06_REGEX_MATCH' => 137,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP09_BITWISE_SHIFT' => 145,
			'OP17_LIST_RANGE' => 136,
			'OP18_TERNARY' => 141,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP11_COMPARE_LT_GT' => 140,
			")" => 403
		}
	},
	{#State 395
		DEFAULT => -47
	},
	{#State 396
		DEFAULT => -65
	},
	{#State 397
		ACTIONS => {
			'TYPE_SELF' => 404
		}
	},
	{#State 398
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 405
		}
	},
	{#State 399
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP16_LOGICAL_OR' => 138,
			'OP15_LOGICAL_AND' => 146,
			'OP23_LOGICAL_AND' => 147,
			'OP07_STRING_REPEAT' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP11_COMPARE_LT_GT' => 140,
			'OP18_TERNARY' => 141,
			'OP12_COMPARE_EQ_NE' => 133,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 135,
			'OP09_BITWISE_SHIFT' => 145,
			'OP17_LIST_RANGE' => 136,
			'OP06_REGEX_MATCH' => 137,
			"}" => -191,
			'OP08_STRING_CAT' => 143,
			'OP21_LIST_COMMA' => -191,
			'OP13_BITWISE_AND' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 134
		}
	},
	{#State 400
		DEFAULT => -63
	},
	{#State 401
		DEFAULT => -60
	},
	{#State 402
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 406
		}
	},
	{#State 403
		ACTIONS => {
			'LBRACE' => 334
		},
		GOTOS => {
			'CodeBlock' => 407
		}
	},
	{#State 404
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 408
		}
	},
	{#State 405
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 110,
			"}" => 410,
			'VARIABLE_SYMBOL' => 109,
			'OP10_NAMED_UNARY' => 108,
			"if" => 116,
			"for" => -139,
			"while" => -139,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD_SCOPED' => 27,
			'WORD' => 28,
			'OP03_MATH_INC_DEC' => 97,
			'LITERAL_NUMBER' => 106,
			"\@{" => 102,
			"%{" => 101,
			'MY' => 104,
			'OP01_NAMED_VOID_SCOLON' => 103,
			'LBRACKET' => 100,
			"undef" => 98,
			'OP01_OPEN' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_CLOSE' => 87,
			'OP01_PRINT' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'WORD_UPPERCASE' => 91,
			'OP01_NAMED_VOID' => 73,
			'OP01_NAMED' => 71,
			'OP22_LOGICAL_NEG' => 81,
			'LITERAL_STRING' => 79,
			"foreach" => -139,
			'LBRACE' => 77
		},
		GOTOS => {
			'Variable' => 115,
			'OPTIONAL-35' => 94,
			'ArrayDereference' => 92,
			'VariableModification' => 112,
			'Expression' => 89,
			'Operator' => 85,
			'PAREN-34' => 107,
			'Operation' => 409,
			'VariableDeclaration' => 82,
			'HashDereference' => 105,
			'OperatorVoid' => 80,
			'Conditional' => 78,
			'LoopLabel' => 76,
			'Statement' => 99,
			'ArrayReference' => 75,
			'WordScoped' => 96,
			'HashReference' => 74,
			'SubExpression' => 72,
			'Literal' => 95
		}
	},
	{#State 406
		DEFAULT => -155
	},
	{#State 407
		DEFAULT => -145
	},
	{#State 408
		ACTIONS => {
			")" => 413,
			'OP21_LIST_COMMA' => 411
		},
		GOTOS => {
			'PAREN-28' => 412
		}
	},
	{#State 409
		DEFAULT => -67
	},
	{#State 410
		ACTIONS => {
			";" => 414
		}
	},
	{#State 411
		ACTIONS => {
			'MY' => 415
		}
	},
	{#State 412
		DEFAULT => -71
	},
	{#State 413
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 416
		}
	},
	{#State 414
		DEFAULT => -69
	},
	{#State 415
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 417
		}
	},
	{#State 416
		ACTIONS => {
			"\@_;" => 418
		}
	},
	{#State 417
		ACTIONS => {
			'VARIABLE_SYMBOL' => 419
		}
	},
	{#State 418
		DEFAULT => -73
	},
	{#State 419
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5745 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5752 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5759 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5766 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5795 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5802 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5816 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5823 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5830 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5837 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5844 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5851 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5858 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5865 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5872 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5919 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5972 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5986 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6022 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6033 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6058 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6069 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6080 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6094 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6151 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6250 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6275 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6289 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6343 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6354 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6376 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6387 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6398 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6409 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6420 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6431 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6442 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6453 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6464 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6475 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6486 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6497 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6508 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6519 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6530 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6541 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6552 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6563 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6574 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6585 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6607 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6618 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6629 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6640 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6651 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6662 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6684 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6727 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6738 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6749 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6760 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6771 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6782 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6793 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6800 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6821 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6832 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6843 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6854 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6876 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6887 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6898 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6909 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6920 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6931 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6942 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6953 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6975 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7011 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7018 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7029 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7040 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7051 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7062 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7073 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7080 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7087 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7094 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7108 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7126 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7137 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7148 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7159 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7170 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7181 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7192 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7206 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7297 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7308 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7319 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7333 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_174
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7358 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7365 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7376 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7387 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7412 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7423 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_185
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7448 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_186
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7473 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7484 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7538 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_196
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_197
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7567 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_200
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_201
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_202
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_204
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule Type_205
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule Type_206
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7651 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_207
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7662 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_208
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7673 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_209
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7684 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_210
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7695 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_211
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_212
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7717 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_213
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7728 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_214
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7739 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_215
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7750 lib/RPerl/Grammar.pm
	]
],
#line 7753 lib/RPerl/Grammar.pm
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
         'OperatorVoid_110', 
         'OperatorVoid_111', 
         'OperatorVoid_112', 
         'OperatorVoid_113', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         'OperatorVoid_116', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_121', 
         'Expression_122', 
         'Expression_123', 
         'Expression_124', 
         'Expression_125', 
         'SubExpression_126', 
         'SubExpression_127', 
         'SubExpression_128', 
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpressionOrStdin_135', 
         'SubExpressionOrStdin_136', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_140', 
         'Statement_141', 
         'Statement_142', 
         'Statement_143', 
         'Statement_144', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_151', 
         'Loop_152', 
         'Loop_153', 
         'Loop_154', 
         'LoopFor_155', 
         'LoopForEach_156', 
         'LoopWhile_157', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_160', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_163', 
         'VariableRetrieval_164', 
         'VariableRetrieval_165', 
         'VariableRetrieval_166', 
         'VariableDeclaration_167', 
         'VariableDeclaration_168', 
         'VariableModification_169', 
         'VariableModification_170', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_174', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElement_177', 
         'ListElement_178', 
         'ListElement_179', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_182', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_185', 
         'ArrayDereference_186', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_189', 
         'HashEntry_190', 
         'HashEntryTyped_191', 
         'HashEntryTyped_192', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_196', 
         'HashReference_197', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_200', 
         'HashDereference_201', 
         'WordScoped_202', 
         'WordScoped_203', 
         'LoopLabel_204', 
         'Type_205', 
         'Type_206', 
         'TypeInner_207', 
         'TypeInnerConstant_208', 
         'VariableOrLiteral_209', 
         'VariableOrLiteral_210', 
         'VariableOrLiteralOrWord_211', 
         'VariableOrLiteralOrWord_212', 
         'VariableOrLiteralOrWord_213', 
         'Literal_214', 
         'Literal_215', );
  $self;
}

#line 207 "lib/RPerl/Grammar.eyp"


{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run scripts/grammar_recompile.sh
# 3. Run new & existing grammar tests
# 4. Copy updates from Grammar.output file into this file, below this line only
# 5. Run scripts/grammar_recompile.sh again
our string_hashref $rules = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',  # CompileUnit -> Program
CompileUnit_5 => 'RPerl::CompileUnit::Module',  # CompileUnit -> PLUS-2
Program_18 => 'RPerl::CompileUnit::Program',  # Program -> SHEBANG OPTIONAL-3 Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
ModuleHeader_21 => 'RPerl::CompileUnit::Module::Header',  # ModuleHeader -> OPTIONAL-9 'package' WordScoped ';' Header
Module_22 => 'RPerl::CompileUnit::Module::Package',  # Module -> Package
Module_23 => 'RPerl::CompileUnit::Module::Class::Generator',  # Module -> Class
Package_32 => 'RPerl::CompileUnit::Module::Package',  # Package -> STAR-10 STAR-11 STAR-12 PLUS-13 LITERAL_NUMBER ';'
Header_33 => 'RPerl::NonGenerator',  # Header -> 'use strict;' 'use warnings;' 'use RPerl;' 'our' VERSION_NUMBER_ASSIGN
Critic_36 => 'RPerl::CompileUnit::Critic',  # Critic -> '## no critic qw(' PLUS-14 ')'
Include_39 => 'RPerl::CompileUnit::Include',  # Include -> 'use' WordScoped ';'
Include_40 => 'RPerl::CompileUnit::Include',  # Include -> 'use' WordScoped OP01_QW PLUS-15 ')' ';'
Constant_41 => 'RPerl::CompileUnit::Constant',  # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_46 => 'RPerl::CodeBlock::Subroutine',  # Subroutine -> 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_50 => 'RPerl::CodeBlock::Subroutine::Arguments',  # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@_;'
Class_59 => 'RPerl::NonGenerator',  # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_63 => 'RPerl::DataStructure::Hash::Properties',  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryTyped STAR-25 '}' ';'
Properties_64 => 'RPerl::DataStructure::Hash::Properties',  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_69 => 'RPerl::CodeBlock::Subroutine::Method',  # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_73 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',  # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_74 => 'RPerl::CodeBlock::Subroutine::Method',  # MethodOrSubroutine -> Method
MethodOrSubroutine_75 => 'RPerl::CodeBlock::Subroutine',  # MethodOrSubroutine -> Subroutine
Operation_76 => 'RPerl::Operation::Expression',
Operation_77 => 'RPerl::Operation::Statement',
Operator_78 => 'RPerl::Operation::Expression::Operator::Print',
Operator_79 => 'RPerl::Operation::Expression::Operator::Named',
Operator_80 => 'RPerl::Operation::Expression::Operator::Named',
Operator_81 => 'RPerl::Operation::Expression::Operator::Open',
Operator_82 => 'RPerl::Operation::Expression::Operator::Close',
Operator_83 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',
Operator_84 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',
Operator_85 => 'RPerl::Operation::Expression::Operator::Math::Power',
Operator_86 => 'RPerl::Operation::Expression::Operator::Logical::Negation',
Operator_87 => 'RPerl::Operation::Expression::Operator::Math::Negative',
Operator_88 => 'RPerl::Operation::Expression::Operator::RegularExpression',
Operator_89 => 'RPerl::Operation::Expression::Operator::String::Repeat',
Operator_90 => 'RPerl::Operation::Expression::Operator::Math::MultiplyDivideModulo',
Operator_91 => 'RPerl::Operation::Expression::Operator::Math::AddSubtract',
Operator_92 => 'RPerl::Operation::Expression::Operator::String::Concatenate',
Operator_93 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',
Operator_94 => 'RPerl::Operation::Expression::Operator::NamedUnary',
Operator_95 => 'RPerl::Operation::Expression::Operator::NamedUnary',
Operator_96 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',
Operator_97 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',
Operator_98 => 'RPerl::Operation::Expression::Operator::Bitwise::And',
Operator_99 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',
Operator_100 => 'RPerl::Operation::Expression::Operator::Logical::And',
Operator_101 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',
Operator_102 => 'RPerl::Operation::Expression::Operator::List::Range',
Operator_103 => 'RPerl::Operation::Expression::Operator::Ternary',
Operator_104 => 'RPerl::Operation::Expression::Operator::Logical::Negation',
Operator_015 => 'RPerl::Operation::Expression::Operator::Logical::And',
Operator_106 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',
OperatorVoid_110 => 'RPerl::Operation::Statement::OperatorVoid::Print',
OperatorVoid_111 => 'RPerl::Operation::Statement::OperatorVoid::Print',
OperatorVoid_112 => 'RPerl::Operation::Statement::OperatorVoid::Named',
OperatorVoid_113 => 'RPerl::Operation::Statement::OperatorVoid::Named',
OperatorVoid_114 => 'RPerl::Operation::Expression::Operator::Named',
OperatorVoid_115 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',
OperatorVoid_116 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',
Expression_121 => 'RPerl::Operation::Expression::Operator',
Expression_122 => 'RPerl::Operation::Expression::SubroutineCall',
Expression_123 => 'RPerl::Operation::Expression::ConstantCall',
Expression_124 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',
Expression_125 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',
SubExpression_126 => 'RPerl::Operation::Expression',
SubExpression_127 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',
SubExpression_128 => 'RPerl::Operation::Expression::SubExpression::Literal',    # SubExpression -> Literal
SubExpression_129 => 'RPerl::Operation::Expression::SubExpression::Variable',
SubExpression_130 => 'RPerl::DataStructure::Array::Reference',                  # SubExpression -> ArrayReference
SubExpression_131 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
SubExpression_132 => 'RPerl::DataStructure::Hash::Reference',                   # SubExpression -> HashReference
SubExpression_133 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
SubExpression_134 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',
SubExpressionOrStdin_135 => 'RPerl::Operation::Expression::SubExpression',      # SubExpressionOrStdin -> SubExpression
SubExpressionOrStdin_136 => 'RPerl::InputOutput::Stdin',
Statement_140 => 'RPerl::Operation::Statement::Conditional',
Statement_141 => 'RPerl::Operation::Statement::Loop',
Statement_142 => 'RPerl::Operation::Statement::OperatorVoid',
Statement_143 => 'RPerl::Operation::Statement::VariableDeclaration',
Statement_144 => 'RPerl::Operation::Statement::VariableModification',
Conditional_151 => 'RPerl::Operation::Statement::Conditional',
Loop_152 => 'RPerl::Operation::Statement::Loop::For',
Loop_153 => 'RPerl::Operation::Statement::Loop::ForEach',
Loop_154 => 'RPerl::Operation::Statement::Loop::While',
LoopFor_155 => 'RPerl::Operation::Statement::Loop::For',
LoopForEach_156 => 'RPerl::Operation::Statement::Loop::ForEach',
LoopWhile_157 => 'RPerl::Operation::Statement::Loop::While',
CodeBlock_160 => 'RPerl::CodeBlock',
Variable_163 => 'RPerl::Operation::Expression::SubExpression::Variable',
VariableRetrieval_164 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',
VariableRetrieval_165 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',
VariableRetrieval_166 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',
VariableDeclaration_167 => 'RPerl::Operation::Statement::VariableDeclaration',
VariableDeclaration_168 => 'RPerl::Operation::Statement::VariableDeclaration',
VariableModification_169 => 'RPerl::Operation::Statement::VariableModification',
VariableModification_170 => 'RPerl::Operation::Statement::VariableModification',
ListElements_174 => 'RPerl::DataStructure::Array::ListElements',    # ListElements -> ListElement STAR-43
ListElement_177 => 'RPerl::Operation::Expression::SubExpression',   # ListElement -> SubExpression
ListElement_178 => 'RPerl::Operation::Expression::SubExpression',   # ListElement -> TypeInner SubExpression
ListElement_179 => 'RPerl::DataStructure::Array::ListElement',      # ListElement -> OP01_QW PLUS-44 ')'
ArrayReference_182 => 'RPerl::DataStructure::Array::Reference',     # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_185 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
ArrayDereference_186 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
HashEntry_189 => 'RPerl::DataStructure::Hash::Entry',                                   # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_190 => 'RPerl::Operation::Expression::SubExpression::HashDereference',        # HashEntry -> HashDereference
HashEntryTyped_191 => 'RPerl::DataStructure::Hash::EntryTyped',                         # HashEntryTyped -> WORD OP20_HASH_FATARROW TypeInner SubExpression
HashEntryTyped_192 => 'RPerl::Operation::Expression::SubExpression::HashDereference',   # HashEntryTyped -> HashDereference
HashReference_196 => 'RPerl::DataStructure::Hash::Reference',
HashReference_197 => 'RPerl::DataStructure::Hash::Reference',
HashDereference_200 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
HashDereference_201 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
WordScoped_202 => 'RPerl::NonGenerator',
WordScoped_203 => 'RPerl::NonGenerator',
LoopLabel_204 => 'RPerl::NonGenerator',
Type_205 => 'RPerl::NonGenerator',                  # Type -> WORD
Type_206 => 'RPerl::NonGenerator',                  # Type -> TYPE_INTEGER
TypeInner_207 => 'RPerl::NonGenerator',             # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_208 => 'RPerl::NonGenerator',     # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_209 => 'RPerl::Operation::Expression::SubExpression::Variable',
VariableOrLiteral_210 => 'RPerl::Operation::Expression::SubExpression::Literal',
VariableOrLiteralOrWord_211 => 'RPerl::Operation::Expression::SubExpression::Variable',  # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_212 => 'RPerl::Operation::Expression::SubExpression::Literal',   # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_213 => 'RPerl::NonGenerator',                                    # VariableOrLiteralOrWord -> WORD
Literal_214 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',  # Literal -> LITERAL_NUMBER
Literal_215 => 'RPerl::Operation::Expression::SubExpression::Literal::String'   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8133 lib/RPerl/Grammar.pm



1;
