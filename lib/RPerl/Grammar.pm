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

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|filehandleref|use\ constant|use\ strict\;|use\ RPerl\;|package|\$TYPED_|foreach|\=\ sub\ \{|elsif|undef|while|else|our|for|\@_\;|use|if|\%\{|\@\{|\]|\;|\}|\))}gc and return ($1, $1);

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
			"## no critic qw(" => 4,
			'SHEBANG' => 8,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 6,
			'Critic' => 9,
			'PAREN-1' => 2,
			'Program' => 3,
			'OPTIONAL-9' => 1,
			'PLUS-2' => 5,
			'CompileUnit' => 7
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-14' => 12
		}
	},
	{#State 5
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 4
		},
		GOTOS => {
			'OPTIONAL-9' => 1,
			'PAREN-1' => 13,
			'Critic' => 9,
			'ModuleHeader' => 6
		}
	},
	{#State 6
		ACTIONS => {
			"use parent qw(" => 14,
			"our" => -25,
			"use" => -25,
			"use constant" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Package' => 18,
			'Class' => 17,
			'STAR-10' => 16,
			'Module' => 15
		}
	},
	{#State 7
		ACTIONS => {
			'' => 19
		}
	},
	{#State 8
		ACTIONS => {
			"## no critic qw(" => 4,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 20,
			'OPTIONAL-3' => 21
		}
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		ACTIONS => {
			'WORD' => 22,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 23
		}
	},
	{#State 11
		DEFAULT => -35
	},
	{#State 12
		ACTIONS => {
			")" => 25,
			'WORD' => 26
		}
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			"use" => -27,
			"## no critic qw(" => 4,
			"use constant" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 28,
			'Critic' => 29
		}
	},
	{#State 17
		DEFAULT => -23
	},
	{#State 18
		DEFAULT => -22
	},
	{#State 19
		DEFAULT => 0
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 22
		DEFAULT => -202
	},
	{#State 23
		ACTIONS => {
			";" => 32
		}
	},
	{#State 24
		DEFAULT => -203
	},
	{#State 25
		DEFAULT => -36
	},
	{#State 26
		DEFAULT => -34
	},
	{#State 27
		ACTIONS => {
			")" => 33
		}
	},
	{#State 28
		ACTIONS => {
			"our" => -29,
			"use" => 34,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 36
		}
	},
	{#State 29
		DEFAULT => -24
	},
	{#State 30
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 31
		ACTIONS => {
			"use warnings;" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			";" => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 41
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 46,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 43,
			'Constant' => 44,
			'PLUS-13' => 45
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'LPAREN' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_CLOSE' => -11,
			'OP01_OPEN' => -11,
			'OP01_NAMED_VOID' => -11,
			"if" => -11,
			'LBRACKET' => -11,
			'WORD' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP10_NAMED_UNARY' => -11,
			"our" => -11,
			'LITERAL_STRING' => -11,
			'LITERAL_NUMBER' => -11,
			"%{" => -11,
			'VARIABLE_SYMBOL' => -11,
			"foreach" => -11,
			"for" => -11,
			'OP01_PRINT' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"undef" => -11,
			'LBRACE' => -11,
			"use" => -11,
			"while" => -11,
			"## no critic qw(" => 4,
			'OP03_MATH_INC_DEC' => -11,
			"use constant" => -11,
			"\@{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED' => -11,
			'WORD_SCOPED' => -11,
			'MY' => -11,
			'WORD_UPPERCASE' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11
		},
		GOTOS => {
			'STAR-5' => 48,
			'Critic' => 47
		}
	},
	{#State 38
		ACTIONS => {
			"use RPerl;" => 49
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 41
		ACTIONS => {
			";" => 52,
			'OP01_QW' => 51
		}
	},
	{#State 42
		ACTIONS => {
			'WORD' => 55,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 53
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
			'LITERAL_NUMBER' => 57,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 46
		ACTIONS => {
			'WORD_UPPERCASE' => 58
		}
	},
	{#State 47
		DEFAULT => -8
	},
	{#State 48
		ACTIONS => {
			"\@{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			"use constant" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACE' => -13,
			"use" => 34,
			"undef" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"while" => -13,
			'OP01_PRINT' => -13,
			'VARIABLE_SYMBOL' => -13,
			"%{" => -13,
			"for" => -13,
			"foreach" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'WORD_UPPERCASE' => -13,
			'WORD_SCOPED' => -13,
			'MY' => -13,
			'OP01_NAMED' => -13,
			'WORD' => -13,
			'LBRACKET' => -13,
			"if" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_OPEN' => -13,
			'OP01_CLOSE' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LPAREN' => -13,
			'LITERAL_NUMBER' => -13,
			'LITERAL_STRING' => -13,
			"our" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP10_NAMED_UNARY' => -13
		},
		GOTOS => {
			'Include' => 59,
			'STAR-6' => 60
		}
	},
	{#State 49
		ACTIONS => {
			"our" => 61
		}
	},
	{#State 50
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 62
		}
	},
	{#State 51
		ACTIONS => {
			'WORD' => 63
		},
		GOTOS => {
			'PLUS-15' => 64
		}
	},
	{#State 52
		DEFAULT => -39
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 54
		DEFAULT => -206
	},
	{#State 55
		DEFAULT => -205
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
		DEFAULT => -10
	},
	{#State 60
		ACTIONS => {
			'MY' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_PRINT' => -15,
			"foreach" => -15,
			"for" => -15,
			"%{" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"\@{" => -15,
			'LBRACE' => -15,
			"while" => -15,
			"undef" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"use constant" => 46,
			"our" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LITERAL_NUMBER' => -15,
			'LITERAL_STRING' => -15,
			'OP01_OPEN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LPAREN' => -15,
			'OP01_CLOSE' => -15,
			'LBRACKET' => -15,
			"if" => -15,
			'WORD' => -15,
			'OP01_NAMED_VOID' => -15
		},
		GOTOS => {
			'STAR-7' => 68,
			'Constant' => 69
		}
	},
	{#State 61
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 70
		}
	},
	{#State 62
		ACTIONS => {
			"use" => -54,
			"use constant" => -54,
			"## no critic qw(" => 4,
			"our hashref \$properties" => -54
		},
		GOTOS => {
			'Critic' => 71,
			'STAR-21' => 72
		}
	},
	{#State 63
		DEFAULT => -38
	},
	{#State 64
		ACTIONS => {
			'WORD' => 73,
			")" => 74
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 75
		}
	},
	{#State 66
		DEFAULT => -32
	},
	{#State 67
		ACTIONS => {
			'MY' => 77
		},
		GOTOS => {
			'TypeInnerConstant' => 76
		}
	},
	{#State 68
		ACTIONS => {
			'OP01_NAMED' => 108,
			'WORD_SCOPED' => 24,
			'MY' => 109,
			'WORD_UPPERCASE' => 104,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED_VOID_SCOLON' => 106,
			"foreach" => -139,
			"for" => -139,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_PRINT' => 122,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			"while" => -139,
			'OP03_MATH_INC_DEC' => 111,
			'OP19_LOOP_CONTROL' => 117,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"our" => 42,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'OP01_OPEN' => 101,
			'OP01_NAMED_VOID' => 91,
			'LBRACKET' => 92,
			'WORD' => 22,
			"if" => 93
		},
		GOTOS => {
			'HashDereference' => 82,
			'WordScoped' => 83,
			'OPTIONAL-35' => 85,
			'Operator' => 86,
			'Subroutine' => 87,
			'OperatorVoid' => 110,
			'Conditional' => 89,
			'Expression' => 79,
			'VariableDeclaration' => 105,
			'Statement' => 80,
			'PLUS-8' => 98,
			'PAREN-34' => 119,
			'ArrayReference' => 102,
			'Variable' => 123,
			'SubExpression' => 103,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116,
			'Operation' => 94,
			'VariableModification' => 95,
			'LoopLabel' => 96
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		DEFAULT => -33
	},
	{#State 71
		DEFAULT => -51
	},
	{#State 72
		ACTIONS => {
			"our hashref \$properties" => -56,
			"use constant" => -56,
			"use" => 34
		},
		GOTOS => {
			'STAR-22' => 124,
			'Include' => 125
		}
	},
	{#State 73
		DEFAULT => -37
	},
	{#State 74
		ACTIONS => {
			";" => 126
		}
	},
	{#State 75
		ACTIONS => {
			'MY' => -43,
			'WORD_SCOPED' => -43,
			"}" => -43,
			'OP01_NAMED' => -43,
			'LPAREN_MY' => 127,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'WORD_UPPERCASE' => -43,
			'OP01_PRINT' => -43,
			'VARIABLE_SYMBOL' => -43,
			"%{" => -43,
			"for" => -43,
			"foreach" => -43,
			"\@{" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"undef" => -43,
			'LBRACE' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"while" => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP10_NAMED_UNARY' => -43,
			'LITERAL_NUMBER' => -43,
			'LITERAL_STRING' => -43,
			'OP01_OPEN' => -43,
			'OP01_CLOSE' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LPAREN' => -43,
			"if" => -43,
			'LBRACKET' => -43,
			'WORD' => -43,
			'OP01_NAMED_VOID' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 128,
			'SubroutineArguments' => 129
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 130
		}
	},
	{#State 77
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 131
		}
	},
	{#State 78
		DEFAULT => -215
	},
	{#State 79
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP04_MATH_POW' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP13_BITWISE_AND' => -126,
			";" => 132,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP08_STRING_CAT' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP18_TERNARY' => -126,
			'OP14_BITWISE_OR_XOR' => -126
		}
	},
	{#State 80
		DEFAULT => -77
	},
	{#State 81
		DEFAULT => -214
	},
	{#State 82
		DEFAULT => -133
	},
	{#State 83
		ACTIONS => {
			'LPAREN' => 133,
			'OP02_METHOD_THINARROW_NEW' => 134
		}
	},
	{#State 84
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -95,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP01_NAMED' => 138,
			"}" => -95,
			'WORD_SCOPED' => 24,
			'OP17_LIST_RANGE' => -95,
			'OP23_LOGICAL_AND' => -95,
			'LBRACE' => 112,
			'OP12_COMPARE_EQ_NE' => -95,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP15_LOGICAL_AND' => -95,
			'OP03_MATH_INC_DEC' => 111,
			'OP11_COMPARE_LT_GT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			")" => -95,
			"\@{" => 118,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			";" => -95,
			'OP04_MATH_POW' => -95,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 84,
			'OP08_MATH_ADD_SUB' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP08_STRING_CAT' => -95,
			'LBRACKET' => 92,
			'OP18_TERNARY' => -95,
			'WORD' => 22,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'OP13_BITWISE_AND' => -95,
			'OP01_OPEN' => 101,
			'OP21_LIST_COMMA' => -95,
			"]" => -95
		},
		GOTOS => {
			'Operator' => 86,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'SubExpression' => 136,
			'ArrayReference' => 102,
			'Variable' => 139,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'HashReference' => 90,
			'Literal' => 116
		}
	},
	{#State 85
		ACTIONS => {
			"for" => 144,
			"while" => 146,
			"foreach" => 145
		},
		GOTOS => {
			'Loop' => 140,
			'LoopFor' => 143,
			'LoopForEach' => 142,
			'LoopWhile' => 141
		}
	},
	{#State 86
		DEFAULT => -121
	},
	{#State 87
		DEFAULT => -14
	},
	{#State 88
		DEFAULT => -115
	},
	{#State 89
		DEFAULT => -140
	},
	{#State 90
		DEFAULT => -132
	},
	{#State 91
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 118,
			'WORD' => 22,
			'LBRACKET' => 92,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_OPEN' => 101,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'OP01_QW' => 152,
			'WORD_SCOPED' => 24,
			'MY' => 151
		},
		GOTOS => {
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 147,
			'WordScoped' => 83,
			'TypeInner' => 149,
			'HashDereference' => 82,
			'Operator' => 86,
			'ListElement' => 150,
			'Literal' => 116,
			'ListElements' => 148,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Expression' => 135
		}
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			"]" => -181,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP01_QW' => 152,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'MY' => 151,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'ListElement' => 150,
			'Literal' => 116,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'OPTIONAL-45' => 153,
			'ListElements' => 154,
			'SubExpression' => 147,
			'Variable' => 139,
			'ArrayReference' => 102,
			'Operator' => 86,
			'HashDereference' => 82,
			'TypeInner' => 149,
			'WordScoped' => 83
		}
	},
	{#State 93
		ACTIONS => {
			'LPAREN' => 155
		}
	},
	{#State 94
		DEFAULT => -17
	},
	{#State 95
		DEFAULT => -144
	},
	{#State 96
		ACTIONS => {
			'COLON' => 156
		}
	},
	{#State 97
		ACTIONS => {
			'FH_REF_SYMBOL' => 157
		}
	},
	{#State 98
		ACTIONS => {
			'LBRACKET' => 92,
			'' => -18,
			'WORD' => 22,
			"if" => 93,
			'OP01_NAMED_VOID' => 91,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'OP10_NAMED_UNARY' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP19_LOOP_CONTROL' => 117,
			"\@{" => 118,
			'LBRACE' => 112,
			"while" => -139,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			'OP01_PRINT' => 122,
			"foreach" => -139,
			"for" => -139,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_NAMED_VOID_SCOLON' => 106,
			'OP22_LOGICAL_NEG' => 107,
			'WORD_UPPERCASE' => 104,
			'MY' => 109,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 108
		},
		GOTOS => {
			'Statement' => 80,
			'VariableDeclaration' => 105,
			'Expression' => 79,
			'Conditional' => 89,
			'OperatorVoid' => 110,
			'Operator' => 86,
			'OPTIONAL-35' => 85,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'LoopLabel' => 96,
			'Operation' => 158,
			'VariableModification' => 95,
			'Literal' => 116,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'SubExpression' => 103,
			'Variable' => 123,
			'ArrayReference' => 102,
			'PAREN-34' => 119
		}
	},
	{#State 99
		ACTIONS => {
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'OP03_MATH_INC_DEC' => 111,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'OP01_PRINT' => 160,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 159
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'Expression' => 135,
			'HashReference' => 90,
			'Literal' => 116,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 161
		}
	},
	{#State 100
		ACTIONS => {
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'OP01_OPEN' => 101,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 162,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Expression' => 135,
			'Literal' => 116
		}
	},
	{#State 101
		ACTIONS => {
			'MY' => 163
		}
	},
	{#State 102
		DEFAULT => -130
	},
	{#State 103
		ACTIONS => {
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			'OP13_BITWISE_AND' => 176,
			'OP18_TERNARY' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171
		}
	},
	{#State 104
		ACTIONS => {
			'LPAREN' => 181,
			'COLON' => -204
		}
	},
	{#State 105
		DEFAULT => -143
	},
	{#State 106
		DEFAULT => -112
	},
	{#State 107
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 182,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116
		}
	},
	{#State 108
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP01_QW' => 152,
			'OP10_NAMED_UNARY' => 84,
			'WORD_SCOPED' => 24,
			'MY' => 151,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'OP01_OPEN' => 101,
			'LBRACE' => 112,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Expression' => 135,
			'ListElement' => 183,
			'Literal' => 116,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'TypeInner' => 149,
			'Operator' => 86,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 184
		}
	},
	{#State 109
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 185
		}
	},
	{#State 110
		DEFAULT => -142
	},
	{#State 111
		ACTIONS => {
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Variable' => 186
		}
	},
	{#State 112
		ACTIONS => {
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'LITERAL_NUMBER' => 81,
			'WORD' => 193,
			"}" => 187
		},
		GOTOS => {
			'HashDereference' => 192,
			'HashEntry' => 188,
			'Variable' => 189,
			'Literal' => 191,
			'VariableOrLiteralOrWord' => 190
		}
	},
	{#State 113
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'OP03_MATH_INC_DEC' => 111,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'OP01_OPEN' => 101
		},
		GOTOS => {
			'Operator' => 86,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'SubExpression' => 194,
			'Variable' => 139,
			'ArrayReference' => 102,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'Literal' => 116
		}
	},
	{#State 114
		DEFAULT => -127
	},
	{#State 115
		DEFAULT => -131
	},
	{#State 116
		DEFAULT => -128
	},
	{#State 117
		ACTIONS => {
			'WORD_UPPERCASE' => 195
		},
		GOTOS => {
			'LoopLabel' => 196
		}
	},
	{#State 118
		ACTIONS => {
			'MY' => 151,
			'LBRACKET' => -184,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Variable' => 198,
			'OPTIONAL-46' => 199,
			'TypeInner' => 197
		}
	},
	{#State 119
		DEFAULT => -138
	},
	{#State 120
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 200
		}
	},
	{#State 121
		ACTIONS => {
			'MY' => 151,
			'LBRACE' => -199,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Variable' => 201,
			'OPTIONAL-50' => 202,
			'TypeInner' => 203
		}
	},
	{#State 122
		ACTIONS => {
			'OP01_OPEN' => -109,
			"%{" => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'LPAREN' => -109,
			'OP01_CLOSE' => -109,
			"\@{" => -109,
			'WORD' => -109,
			'LBRACKET' => -109,
			"undef" => -109,
			'OP05_LOGICAL_NEG' => -109,
			'LBRACE' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'MY' => -109,
			'FH_REF_SYMBOL_BRACES' => 204,
			'WORD_SCOPED' => -109,
			'STDOUT_STDERR' => 207,
			'OP01_NAMED' => -109,
			'OP01_QW' => -109,
			'OP10_NAMED_UNARY' => -109,
			'LITERAL_NUMBER' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'WORD_UPPERCASE' => -109,
			'LITERAL_STRING' => -109
		},
		GOTOS => {
			'PAREN-30' => 205,
			'OPTIONAL-31' => 206
		}
	},
	{#State 123
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -129,
			'OP04_MATH_POW' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP02_METHOD_THINARROW' => 210,
			'OP07_STRING_REPEAT' => -129,
			'OP03_MATH_INC_DEC' => 209,
			'OP06_REGEX_MATCH' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP08_STRING_CAT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 208,
			'OP11_COMPARE_LT_GT' => -129,
			'OP19_VARIABLE_ASSIGN' => 211,
			'OP13_BITWISE_AND' => -129
		}
	},
	{#State 124
		ACTIONS => {
			"our hashref \$properties" => 214,
			"use constant" => 46
		},
		GOTOS => {
			'Properties' => 212,
			'Constant' => 213
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
			'TYPE_INTEGER' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 215
		}
	},
	{#State 128
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 216
		}
	},
	{#State 129
		DEFAULT => -42
	},
	{#State 130
		ACTIONS => {
			";" => 217
		}
	},
	{#State 131
		ACTIONS => {
			"\$TYPED_" => 218
		}
	},
	{#State 132
		DEFAULT => -76
	},
	{#State 133
		ACTIONS => {
			'OP01_QW' => 152,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'MY' => 151,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 22,
			'LBRACKET' => 92,
			")" => -118,
			"\@{" => 118
		},
		GOTOS => {
			'ListElement' => 150,
			'Literal' => 116,
			'ListElements' => 219,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 147,
			'OPTIONAL-32' => 220,
			'WordScoped' => 83,
			'TypeInner' => 149,
			'HashDereference' => 82,
			'Operator' => 86
		}
	},
	{#State 134
		ACTIONS => {
			")" => 221
		}
	},
	{#State 135
		DEFAULT => -126
	},
	{#State 136
		ACTIONS => {
			")" => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => -94,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			"]" => -94,
			'OP21_LIST_COMMA' => -94,
			";" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167,
			'OP23_LOGICAL_AND' => -94,
			'OP17_LIST_RANGE' => -94,
			"}" => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 174
		}
	},
	{#State 137
		ACTIONS => {
			'LPAREN' => 181
		}
	},
	{#State 138
		ACTIONS => {
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP03_MATH_INC_DEC' => 111,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118
		},
		GOTOS => {
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 222,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116
		}
	},
	{#State 139
		ACTIONS => {
			'OP15_LOGICAL_AND' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP03_MATH_INC_DEC' => 209,
			'OP11_COMPARE_LT_GT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP18_TERNARY' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP02_METHOD_THINARROW' => 210,
			")" => -129,
			'OP13_BITWISE_AND' => -129,
			";" => -129,
			'OP21_LIST_COMMA' => -129,
			"]" => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP04_MATH_POW' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			"}" => -129,
			'OP17_LIST_RANGE' => -129,
			'OP23_LOGICAL_AND' => -129
		}
	},
	{#State 140
		DEFAULT => -141
	},
	{#State 141
		DEFAULT => -154
	},
	{#State 142
		DEFAULT => -153
	},
	{#State 143
		DEFAULT => -152
	},
	{#State 144
		ACTIONS => {
			'MY' => 223
		}
	},
	{#State 145
		ACTIONS => {
			'MY' => 224
		}
	},
	{#State 146
		ACTIONS => {
			'LPAREN' => 225
		}
	},
	{#State 147
		ACTIONS => {
			'OP18_TERNARY' => 180,
			'OP16_LOGICAL_OR' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			")" => -177,
			'OP07_STRING_REPEAT' => 178,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -177,
			"]" => -177,
			'OP21_LIST_COMMA' => -177,
			'OP13_BITWISE_AND' => 176,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 174
		}
	},
	{#State 148
		ACTIONS => {
			";" => 226
		}
	},
	{#State 149
		ACTIONS => {
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'Literal' => 116,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'HashReference' => 90,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 227,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86
		}
	},
	{#State 150
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 228
		}
	},
	{#State 151
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 229
		}
	},
	{#State 152
		ACTIONS => {
			'WORD' => 230
		},
		GOTOS => {
			'PLUS-44' => 231
		}
	},
	{#State 153
		ACTIONS => {
			"]" => 232
		}
	},
	{#State 154
		DEFAULT => -180
	},
	{#State 155
		ACTIONS => {
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 233,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'Literal' => 116,
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115
		}
	},
	{#State 156
		DEFAULT => -137
	},
	{#State 157
		DEFAULT => -82
	},
	{#State 158
		DEFAULT => -16
	},
	{#State 159
		ACTIONS => {
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN' => 101,
			'OP03_MATH_INC_DEC' => 111,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 84,
			'OP01_QW' => 152,
			'OP01_NAMED' => 138,
			'MY' => 151,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Literal' => 116,
			'ListElement' => 234,
			'Operator' => 86,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'TypeInner' => 149,
			'SubExpression' => 184,
			'Variable' => 139,
			'ArrayReference' => 102
		}
	},
	{#State 160
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 235
		}
	},
	{#State 161
		ACTIONS => {
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167,
			'OP13_BITWISE_AND' => 176,
			")" => 236,
			'OP18_TERNARY' => 180,
			'OP16_LOGICAL_OR' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178
		}
	},
	{#State 162
		ACTIONS => {
			'OP13_BITWISE_AND' => 176,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_STRING_REPEAT' => 178,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 177,
			")" => 237,
			'OP18_TERNARY' => 180,
			'OP16_LOGICAL_OR' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167
		}
	},
	{#State 163
		ACTIONS => {
			"filehandleref" => 238
		}
	},
	{#State 164
		ACTIONS => {
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118
		},
		GOTOS => {
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 239,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116
		}
	},
	{#State 165
		ACTIONS => {
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 240,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'Literal' => 116,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Expression' => 135
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 241,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'Literal' => 116,
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115
		}
	},
	{#State 167
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'WORD_SCOPED' => 24,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'OP01_OPEN' => 101
		},
		GOTOS => {
			'Literal' => 116,
			'HashReference' => 90,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'SubExpression' => 242,
			'ArrayReference' => 102,
			'Variable' => 139,
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82
		}
	},
	{#State 168
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP01_OPEN' => 101,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"\@{" => 118,
			'WORD' => 22,
			'LBRACKET' => 92,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113
		},
		GOTOS => {
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'SubExpression' => 243,
			'Variable' => 139,
			'ArrayReference' => 102,
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Literal' => 116
		}
	},
	{#State 169
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_OPEN' => 101,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 244,
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Literal' => 116
		}
	},
	{#State 170
		ACTIONS => {
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137
		},
		GOTOS => {
			'SubExpression' => 245,
			'ArrayReference' => 102,
			'Variable' => 139,
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Literal' => 116,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90
		}
	},
	{#State 171
		ACTIONS => {
			'OP01_OPEN' => 101,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			"\@{" => 118,
			'WORD' => 22,
			'LBRACKET' => 92,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 246,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'Literal' => 116,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90
		}
	},
	{#State 172
		ACTIONS => {
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP03_MATH_INC_DEC' => 111,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'Literal' => 116,
			'Operator' => 86,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'SubExpression' => 247,
			'Variable' => 139,
			'ArrayReference' => 102
		}
	},
	{#State 173
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'LBRACE' => 112,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Literal' => 116,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'SubExpression' => 248,
			'ArrayReference' => 102,
			'Variable' => 139,
			'Operator' => 86,
			'HashDereference' => 82,
			'WordScoped' => 83
		}
	},
	{#State 174
		ACTIONS => {
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACE' => 112,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN' => 101
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 249,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'Literal' => 116,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Expression' => 135
		}
	},
	{#State 175
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Expression' => 135,
			'Literal' => 116,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 250
		}
	},
	{#State 176
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN' => 101
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'Expression' => 135,
			'HashReference' => 90,
			'Literal' => 116,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 251
		}
	},
	{#State 177
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 252
		}
	},
	{#State 178
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN' => 101,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'SubExpression' => 253,
			'Variable' => 139,
			'ArrayReference' => 102,
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Literal' => 116,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90
		}
	},
	{#State 179
		ACTIONS => {
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 254
		}
	},
	{#State 180
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 78
		},
		GOTOS => {
			'Literal' => 255,
			'Variable' => 256,
			'VariableOrLiteral' => 257
		}
	},
	{#State 181
		ACTIONS => {
			")" => 258
		}
	},
	{#State 182
		ACTIONS => {
			'OP13_BITWISE_AND' => 176,
			";" => -104,
			'OP21_LIST_COMMA' => -104,
			"]" => -104,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP18_TERNARY' => 180,
			'OP16_LOGICAL_OR' => 173,
			")" => -104,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => -104,
			"}" => -104,
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175
		}
	},
	{#State 183
		ACTIONS => {
			'OP21_LIST_COMMA' => 259
		}
	},
	{#State 184
		ACTIONS => {
			'OP07_STRING_REPEAT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP08_STRING_CAT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP18_TERNARY' => -79,
			")" => -79,
			'OP13_BITWISE_AND' => -79,
			";" => -79,
			'OP21_LIST_COMMA' => -177,
			'OP09_BITWISE_SHIFT' => -79,
			'OP04_MATH_POW' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP17_LIST_RANGE' => -79
		}
	},
	{#State 185
		ACTIONS => {
			'VARIABLE_SYMBOL' => 260
		}
	},
	{#State 186
		DEFAULT => -83
	},
	{#State 187
		DEFAULT => -197
	},
	{#State 188
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 261
		}
	},
	{#State 189
		DEFAULT => -211
	},
	{#State 190
		ACTIONS => {
			'OP20_HASH_FATARROW' => 262
		}
	},
	{#State 191
		DEFAULT => -212
	},
	{#State 192
		DEFAULT => -190
	},
	{#State 193
		DEFAULT => -213
	},
	{#State 194
		ACTIONS => {
			"}" => -86,
			'OP17_LIST_RANGE' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP04_MATH_POW' => 175,
			";" => -86,
			'OP21_LIST_COMMA' => -86,
			"]" => -86,
			'OP13_BITWISE_AND' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP18_TERNARY' => -86,
			'OP16_LOGICAL_OR' => -86,
			")" => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP08_STRING_CAT' => -86
		}
	},
	{#State 195
		DEFAULT => -204
	},
	{#State 196
		ACTIONS => {
			";" => 263
		}
	},
	{#State 197
		DEFAULT => -183
	},
	{#State 198
		ACTIONS => {
			"}" => 264
		}
	},
	{#State 199
		ACTIONS => {
			'LBRACKET' => 92
		},
		GOTOS => {
			'ArrayReference' => 265
		}
	},
	{#State 200
		ACTIONS => {
			'OP02_HASH_THINARROW' => 267,
			'OP09_BITWISE_SHIFT' => -163,
			'OP04_MATH_POW' => -163,
			"}" => -163,
			'OP17_LIST_RANGE' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP02_ARRAY_THINARROW' => 268,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP18_TERNARY' => -163,
			")" => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP20_HASH_FATARROW' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'COLON' => -163,
			'OP08_STRING_CAT' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			";" => -163,
			'OP21_LIST_COMMA' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			"]" => -163,
			'OP13_BITWISE_AND' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 266
		}
	},
	{#State 201
		ACTIONS => {
			"}" => 269
		}
	},
	{#State 202
		ACTIONS => {
			'LBRACE' => 112
		},
		GOTOS => {
			'HashReference' => 270
		}
	},
	{#State 203
		DEFAULT => -198
	},
	{#State 204
		ACTIONS => {
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP01_OPEN' => 101,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'MY' => 151,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 138,
			'OP01_QW' => 152,
			'OP10_NAMED_UNARY' => 84
		},
		GOTOS => {
			'Literal' => 116,
			'ListElement' => 150,
			'ListElements' => 271,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 147,
			'HashDereference' => 82,
			'TypeInner' => 149,
			'WordScoped' => 83,
			'Operator' => 86
		}
	},
	{#State 205
		DEFAULT => -108
	},
	{#State 206
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 138,
			'OP01_QW' => 152,
			'OP10_NAMED_UNARY' => 84,
			'MY' => 151,
			'WORD_SCOPED' => 24,
			'LBRACE' => 112,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			"\@{" => 118,
			'WORD' => 22,
			'LBRACKET' => 92,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'OP01_OPEN' => 101
		},
		GOTOS => {
			'ListElements' => 272,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116,
			'ListElement' => 150,
			'TypeInner' => 149,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 147
		}
	},
	{#State 207
		DEFAULT => -107
	},
	{#State 208
		ACTIONS => {
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'LBRACE' => 112,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 273,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'HashReference' => 90,
			'Literal' => 116
		}
	},
	{#State 209
		DEFAULT => -84
	},
	{#State 210
		ACTIONS => {
			'LPAREN' => 274
		}
	},
	{#State 211
		ACTIONS => {
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			'STDIN' => 276,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN' => 101,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Literal' => 116,
			'SubExpressionOrStdin' => 275,
			'HashReference' => 90,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'SubExpression' => 277,
			'Variable' => 139,
			'ArrayReference' => 102,
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82
		}
	},
	{#State 212
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 278
		}
	},
	{#State 213
		DEFAULT => -55
	},
	{#State 214
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 279
		}
	},
	{#State 215
		ACTIONS => {
			'VARIABLE_SYMBOL' => 280
		}
	},
	{#State 216
		ACTIONS => {
			'WORD_UPPERCASE' => 104,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED_VOID_SCOLON' => 106,
			'OP01_NAMED' => 108,
			'MY' => 109,
			'WORD_SCOPED' => 24,
			"}" => 282,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACE' => 112,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			"while" => -139,
			"\@{" => 118,
			'OP19_LOOP_CONTROL' => 117,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			"for" => -139,
			"foreach" => -139,
			'OP01_PRINT' => 122,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED_VOID' => 91,
			'LBRACKET' => 92,
			"if" => 93,
			'WORD' => 22,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_OPEN' => 101
		},
		GOTOS => {
			'Expression' => 79,
			'Statement' => 80,
			'VariableDeclaration' => 105,
			'Operator' => 86,
			'OPTIONAL-35' => 85,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Conditional' => 89,
			'OperatorVoid' => 110,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'LoopLabel' => 96,
			'Operation' => 281,
			'VariableModification' => 95,
			'Literal' => 116,
			'PAREN-34' => 119,
			'SubExpression' => 103,
			'Variable' => 123,
			'ArrayReference' => 102
		}
	},
	{#State 217
		DEFAULT => -41
	},
	{#State 218
		ACTIONS => {
			'WORD_UPPERCASE' => 283
		}
	},
	{#State 219
		DEFAULT => -117
	},
	{#State 220
		ACTIONS => {
			")" => 284
		}
	},
	{#State 221
		DEFAULT => -125
	},
	{#State 222
		ACTIONS => {
			"}" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP04_MATH_POW' => -79,
			";" => -79,
			'OP21_LIST_COMMA' => -79,
			"]" => -79,
			'OP13_BITWISE_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			")" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP08_STRING_CAT' => -79
		}
	},
	{#State 223
		ACTIONS => {
			'TYPE_INTEGER' => 285
		}
	},
	{#State 224
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 286
		}
	},
	{#State 225
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP01_OPEN' => 101,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'Literal' => 116,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 287
		}
	},
	{#State 226
		DEFAULT => -113
	},
	{#State 227
		ACTIONS => {
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178,
			")" => -178,
			'OP16_LOGICAL_OR' => 173,
			'OP18_TERNARY' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 176,
			'OP21_LIST_COMMA' => -178,
			"]" => -178,
			";" => -178
		}
	},
	{#State 228
		ACTIONS => {
			";" => -174,
			"]" => -174,
			")" => -174,
			'OP21_LIST_COMMA' => 289
		},
		GOTOS => {
			'PAREN-42' => 288
		}
	},
	{#State 229
		ACTIONS => {
			"\$TYPED_" => 290
		}
	},
	{#State 230
		DEFAULT => -176
	},
	{#State 231
		ACTIONS => {
			'WORD' => 291,
			")" => 292
		}
	},
	{#State 232
		DEFAULT => -182
	},
	{#State 233
		ACTIONS => {
			'OP13_BITWISE_AND' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_STRING_REPEAT' => 178,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => 169,
			")" => 293,
			'OP18_TERNARY' => 180,
			'OP16_LOGICAL_OR' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167
		}
	},
	{#State 234
		ACTIONS => {
			'OP21_LIST_COMMA' => 294
		}
	},
	{#State 235
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'MY' => 151,
			'OP01_NAMED' => 138,
			'OP01_QW' => 152,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP01_OPEN' => 101,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'OP03_MATH_INC_DEC' => 111
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 147,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'TypeInner' => 149,
			'Operator' => 86,
			'Literal' => 116,
			'ListElement' => 150,
			'ListElements' => 295,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'HashReference' => 90
		}
	},
	{#State 236
		DEFAULT => -134
	},
	{#State 237
		DEFAULT => -87
	},
	{#State 238
		ACTIONS => {
			'FH_REF_SYMBOL' => 296
		}
	},
	{#State 239
		ACTIONS => {
			'OP13_BITWISE_AND' => 176,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			";" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_STRING_REPEAT' => 178,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 177,
			'OP12_COMPARE_EQ_NE' => 168,
			")" => -106,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP18_TERNARY' => 180,
			'OP16_LOGICAL_OR' => 173,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			"}" => -106,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167
		}
	},
	{#State 240
		ACTIONS => {
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP16_LOGICAL_OR' => 173,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => 172,
			")" => -102,
			'OP13_BITWISE_AND' => 176,
			";" => -102,
			'OP21_LIST_COMMA' => -102,
			"]" => -102,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => -102,
			"}" => -102,
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -102
		}
	},
	{#State 241
		ACTIONS => {
			'OP13_BITWISE_AND' => 176,
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			";" => -105,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_STRING_REPEAT' => 178,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 177,
			")" => -105,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => -105,
			'OP17_LIST_RANGE' => 165,
			"}" => -105,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167
		}
	},
	{#State 242
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -93,
			'OP04_MATH_POW' => 175,
			"}" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => 174,
			'OP16_LOGICAL_OR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP18_TERNARY' => -93,
			")" => -93,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 177,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => -93,
			";" => -93,
			"]" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP13_BITWISE_AND' => -93
		}
	},
	{#State 243
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			"}" => -97,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167,
			'OP13_BITWISE_AND' => -97,
			"]" => -97,
			'OP21_LIST_COMMA' => -97,
			";" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 177,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP15_LOGICAL_AND' => -97,
			")" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP18_TERNARY' => -97,
			'OP14_BITWISE_OR_XOR' => -97
		}
	},
	{#State 244
		ACTIONS => {
			'OP07_STRING_REPEAT' => 178,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 177,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP16_LOGICAL_OR' => -100,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => 172,
			")" => -100,
			'OP13_BITWISE_AND' => 176,
			";" => -100,
			"]" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_MATH_ADD_SUB' => 174,
			"}" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100
		}
	},
	{#State 245
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			"}" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_MATH_ADD_SUB' => 174,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP18_TERNARY' => -96,
			'OP16_LOGICAL_OR' => -96,
			")" => -96,
			'OP07_STRING_REPEAT' => 178,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => -96,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => undef,
			";" => -96,
			"]" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP13_BITWISE_AND' => -96
		}
	},
	{#State 246
		ACTIONS => {
			";" => -90,
			"]" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP18_TERNARY' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP16_LOGICAL_OR' => -90,
			")" => -90,
			'OP07_STRING_REPEAT' => 178,
			'OP15_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP06_REGEX_MATCH' => 177,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP08_STRING_CAT' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			"}" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP04_MATH_POW' => 175
		}
	},
	{#State 247
		ACTIONS => {
			";" => -99,
			"]" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP13_BITWISE_AND' => 176,
			'OP16_LOGICAL_OR' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP18_TERNARY' => -99,
			")" => -99,
			'OP07_STRING_REPEAT' => 178,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP15_LOGICAL_AND' => -99,
			'OP06_REGEX_MATCH' => 177,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			"}" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 174,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175
		}
	},
	{#State 248
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => -101,
			"}" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			'OP13_BITWISE_AND' => 176,
			";" => -101,
			'OP21_LIST_COMMA' => -101,
			"]" => -101,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 177,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP18_TERNARY' => -101,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP16_LOGICAL_OR' => -101,
			")" => -101
		}
	},
	{#State 249
		ACTIONS => {
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP23_LOGICAL_AND' => -91,
			"}" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP06_REGEX_MATCH' => 177,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP07_STRING_REPEAT' => 178,
			")" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP18_TERNARY' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP21_LIST_COMMA' => -91,
			"]" => -91,
			";" => -91
		}
	},
	{#State 250
		ACTIONS => {
			'OP18_TERNARY' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			")" => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP08_STRING_CAT' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			";" => -85,
			"]" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP04_MATH_POW' => 175,
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP08_MATH_ADD_SUB' => -85
		}
	},
	{#State 251
		ACTIONS => {
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP23_LOGICAL_AND' => -98,
			"}" => -98,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP15_LOGICAL_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178,
			")" => -98,
			'OP18_TERNARY' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP21_LIST_COMMA' => -98,
			"]" => -98,
			";" => -98
		}
	},
	{#State 252
		DEFAULT => -88
	},
	{#State 253
		ACTIONS => {
			'OP08_STRING_CAT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => -89,
			")" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP18_TERNARY' => -89,
			'OP13_BITWISE_AND' => -89,
			"]" => -89,
			'OP21_LIST_COMMA' => -89,
			";" => -89,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP17_LIST_RANGE' => -89,
			"}" => -89
		}
	},
	{#State 254
		ACTIONS => {
			'OP18_TERNARY' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP16_LOGICAL_OR' => -92,
			")" => -92,
			'OP07_STRING_REPEAT' => 178,
			'OP15_LOGICAL_AND' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP06_REGEX_MATCH' => 177,
			'OP08_STRING_CAT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => -92,
			";" => -92,
			"]" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP04_MATH_POW' => 175,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP08_MATH_ADD_SUB' => 174
		}
	},
	{#State 255
		DEFAULT => -210
	},
	{#State 256
		DEFAULT => -209
	},
	{#State 257
		ACTIONS => {
			'COLON' => 297
		}
	},
	{#State 258
		DEFAULT => -123
	},
	{#State 259
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			"\@{" => 118,
			'WORD' => 22,
			'LBRACKET' => 92,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_OPEN' => 101,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'OP01_QW' => 152,
			'WORD_SCOPED' => 24,
			'MY' => 151
		},
		GOTOS => {
			'Literal' => 116,
			'ListElement' => 150,
			'ListElements' => 298,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Expression' => 135,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 147,
			'WordScoped' => 83,
			'TypeInner' => 149,
			'HashDereference' => 82,
			'Operator' => 86
		}
	},
	{#State 260
		ACTIONS => {
			";" => 300,
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 261
		ACTIONS => {
			"}" => 301,
			'OP21_LIST_COMMA' => 303
		},
		GOTOS => {
			'PAREN-48' => 302
		}
	},
	{#State 262
		ACTIONS => {
			'WORD_SCOPED' => -188,
			'MY' => 151,
			'OP10_NAMED_UNARY' => -188,
			'OP01_NAMED' => -188,
			'OP22_LOGICAL_NEG' => -188,
			'LITERAL_NUMBER' => -188,
			'WORD_UPPERCASE' => -188,
			'LITERAL_STRING' => -188,
			'OP01_OPEN' => -188,
			'LPAREN' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'OP01_CLOSE' => -188,
			"%{" => -188,
			'VARIABLE_SYMBOL' => -188,
			'LBRACKET' => -188,
			'WORD' => -188,
			"\@{" => -188,
			'OP05_LOGICAL_NEG' => -188,
			'LBRACE' => -188,
			"undef" => -188,
			'OP03_MATH_INC_DEC' => -188
		},
		GOTOS => {
			'TypeInner' => 305,
			'OPTIONAL-47' => 304
		}
	},
	{#State 263
		DEFAULT => -116
	},
	{#State 264
		DEFAULT => -185
	},
	{#State 265
		ACTIONS => {
			"}" => 306
		}
	},
	{#State 266
		DEFAULT => -161
	},
	{#State 267
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP01_OPEN' => 101,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 308,
			'LBRACE' => 112,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111
		},
		GOTOS => {
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Expression' => 135,
			'Literal' => 116,
			'Operator' => 86,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'SubExpression' => 307,
			'Variable' => 139,
			'ArrayReference' => 102
		}
	},
	{#State 268
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			"\@{" => 118,
			'WORD' => 22,
			'LBRACKET' => 92,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'OP03_MATH_INC_DEC' => 111,
			'OP01_OPEN' => 101,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'SubExpression' => 309,
			'ArrayReference' => 102,
			'Variable' => 139,
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Literal' => 116
		}
	},
	{#State 269
		DEFAULT => -200
	},
	{#State 270
		ACTIONS => {
			"}" => 310
		}
	},
	{#State 271
		ACTIONS => {
			";" => 311
		}
	},
	{#State 272
		ACTIONS => {
			";" => 312
		}
	},
	{#State 273
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			'OP13_BITWISE_AND' => 176,
			";" => 313,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP18_TERNARY' => 180,
			'OP16_LOGICAL_OR' => 173
		}
	},
	{#State 274
		ACTIONS => {
			'MY' => 151,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 138,
			'OP01_QW' => 152,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'OP01_OPEN' => 101,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			")" => -120,
			"\@{" => 118,
			'LBRACKET' => 92,
			'WORD' => 22,
			'LBRACE' => 112,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111
		},
		GOTOS => {
			'ListElements' => 314,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'ListElement' => 150,
			'Literal' => 116,
			'WordScoped' => 83,
			'TypeInner' => 149,
			'HashDereference' => 82,
			'Operator' => 86,
			'Variable' => 139,
			'ArrayReference' => 102,
			'OPTIONAL-33' => 315,
			'SubExpression' => 147
		}
	},
	{#State 275
		ACTIONS => {
			";" => 316
		}
	},
	{#State 276
		DEFAULT => -136
	},
	{#State 277
		ACTIONS => {
			'OP13_BITWISE_AND' => 176,
			";" => -135,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP16_LOGICAL_OR' => 173,
			'OP18_TERNARY' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167
		}
	},
	{#State 278
		ACTIONS => {
			'LITERAL_NUMBER' => 320,
			"our" => 318
		},
		GOTOS => {
			'Method' => 321,
			'MethodOrSubroutine' => 317,
			'Subroutine' => 319
		}
	},
	{#State 279
		ACTIONS => {
			'LBRACE' => 322
		}
	},
	{#State 280
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 323
		}
	},
	{#State 281
		DEFAULT => -44
	},
	{#State 282
		ACTIONS => {
			";" => 324
		}
	},
	{#State 283
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 325
		}
	},
	{#State 284
		DEFAULT => -122
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
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 174,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167,
			'OP13_BITWISE_AND' => 176,
			")" => 328,
			'OP16_LOGICAL_OR' => 173,
			'OP18_TERNARY' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168
		}
	},
	{#State 288
		DEFAULT => -172
	},
	{#State 289
		ACTIONS => {
			'OP10_NAMED_UNARY' => 84,
			'OP01_QW' => 152,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'MY' => 151,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP03_MATH_INC_DEC' => 111,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'LBRACE' => 112,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118
		},
		GOTOS => {
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Literal' => 116,
			'ListElement' => 329,
			'Operator' => 86,
			'WordScoped' => 83,
			'TypeInner' => 149,
			'HashDereference' => 82,
			'SubExpression' => 147,
			'ArrayReference' => 102,
			'Variable' => 139
		}
	},
	{#State 290
		ACTIONS => {
			'WORD' => 330
		}
	},
	{#State 291
		DEFAULT => -175
	},
	{#State 292
		DEFAULT => -179
	},
	{#State 293
		ACTIONS => {
			'LBRACE' => 331
		},
		GOTOS => {
			'CodeBlock' => 332
		}
	},
	{#State 294
		ACTIONS => {
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 84,
			'OP01_QW' => 152,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'MY' => 151,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 147,
			'TypeInner' => 149,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'Literal' => 116,
			'ListElement' => 150,
			'ListElements' => 333,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90
		}
	},
	{#State 295
		ACTIONS => {
			")" => 334
		}
	},
	{#State 296
		ACTIONS => {
			'OP21_LIST_COMMA' => 335
		}
	},
	{#State 297
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'VARIABLE_SYMBOL' => 120,
			'LITERAL_STRING' => 78
		},
		GOTOS => {
			'VariableOrLiteral' => 336,
			'Variable' => 256,
			'Literal' => 255
		}
	},
	{#State 298
		ACTIONS => {
			";" => 337
		}
	},
	{#State 299
		ACTIONS => {
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			'STDIN' => 276,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'SubExpressionOrStdin' => 338,
			'Literal' => 116,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Expression' => 135,
			'ArrayReference' => 102,
			'Variable' => 139,
			'SubExpression' => 277,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86
		}
	},
	{#State 300
		DEFAULT => -167
	},
	{#State 301
		DEFAULT => -196
	},
	{#State 302
		DEFAULT => -194
	},
	{#State 303
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'WORD' => 193,
			'LITERAL_STRING' => 78,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121
		},
		GOTOS => {
			'HashEntry' => 339,
			'Variable' => 189,
			'Literal' => 191,
			'VariableOrLiteralOrWord' => 190,
			'HashDereference' => 192
		}
	},
	{#State 304
		ACTIONS => {
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP01_OPEN' => 101,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118
		},
		GOTOS => {
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'SubExpression' => 340,
			'Variable' => 139,
			'ArrayReference' => 102,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116
		}
	},
	{#State 305
		DEFAULT => -187
	},
	{#State 306
		DEFAULT => -186
	},
	{#State 307
		ACTIONS => {
			'OP13_BITWISE_AND' => 176,
			'OP16_LOGICAL_OR' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP18_TERNARY' => 180,
			'OP07_STRING_REPEAT' => 178,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			"}" => 341,
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 174,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175
		}
	},
	{#State 308
		ACTIONS => {
			"}" => 342,
			'LPAREN' => -202,
			'OP02_METHOD_THINARROW_NEW' => -202
		}
	},
	{#State 309
		ACTIONS => {
			'OP18_TERNARY' => 180,
			'OP16_LOGICAL_OR' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178,
			"]" => 343,
			'OP13_BITWISE_AND' => 176,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167,
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => 164
		}
	},
	{#State 310
		DEFAULT => -201
	},
	{#State 311
		DEFAULT => -111
	},
	{#State 312
		DEFAULT => -110
	},
	{#State 313
		DEFAULT => -170
	},
	{#State 314
		DEFAULT => -119
	},
	{#State 315
		ACTIONS => {
			")" => 344
		}
	},
	{#State 316
		DEFAULT => -169
	},
	{#State 317
		DEFAULT => -57
	},
	{#State 318
		ACTIONS => {
			'TYPE_METHOD' => 345,
			'TYPE_INTEGER' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 319
		DEFAULT => -75
	},
	{#State 320
		ACTIONS => {
			";" => 346
		}
	},
	{#State 321
		DEFAULT => -74
	},
	{#State 322
		ACTIONS => {
			"}" => 350,
			'WORD' => 348,
			"%{" => 121
		},
		GOTOS => {
			'HashEntryTyped' => 347,
			'HashDereference' => 349
		}
	},
	{#State 323
		ACTIONS => {
			'OP21_LIST_COMMA' => 353,
			")" => 352
		},
		GOTOS => {
			'PAREN-18' => 351
		}
	},
	{#State 324
		DEFAULT => -46
	},
	{#State 325
		DEFAULT => -208
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
		ACTIONS => {
			'LBRACE' => 331
		},
		GOTOS => {
			'CodeBlock' => 356
		}
	},
	{#State 329
		DEFAULT => -171
	},
	{#State 330
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 357
		}
	},
	{#State 331
		ACTIONS => {
			'OP01_CLOSE' => 97,
			"for" => -139,
			"foreach" => -139,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP01_OPEN' => 101,
			'OP01_PRINT' => 122,
			'OP03_MATH_INC_DEC' => 111,
			"while" => -139,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'OP01_NAMED_VOID' => 91,
			'LBRACKET' => 92,
			'WORD' => 22,
			"if" => 93,
			'OP19_LOOP_CONTROL' => 117,
			"\@{" => 118,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'MY' => 109,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 104,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED_VOID_SCOLON' => 106,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Expression' => 79,
			'Statement' => 80,
			'VariableDeclaration' => 105,
			'Operator' => 86,
			'OPTIONAL-35' => 85,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Conditional' => 89,
			'OperatorVoid' => 110,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'LoopLabel' => 96,
			'VariableModification' => 95,
			'Operation' => 358,
			'Literal' => 116,
			'PAREN-34' => 119,
			'PLUS-40' => 359,
			'SubExpression' => 103,
			'Variable' => 123,
			'ArrayReference' => 102
		}
	},
	{#State 332
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 360
		}
	},
	{#State 333
		ACTIONS => {
			")" => 361
		}
	},
	{#State 334
		DEFAULT => -78
	},
	{#State 335
		ACTIONS => {
			'LITERAL_STRING' => 362
		}
	},
	{#State 336
		DEFAULT => -103
	},
	{#State 337
		DEFAULT => -114
	},
	{#State 338
		ACTIONS => {
			";" => 363
		}
	},
	{#State 339
		DEFAULT => -193
	},
	{#State 340
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			"}" => -189,
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 174,
			'OP18_TERNARY' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP21_LIST_COMMA' => -189,
			'OP13_BITWISE_AND' => 176
		}
	},
	{#State 341
		DEFAULT => -165
	},
	{#State 342
		DEFAULT => -166
	},
	{#State 343
		DEFAULT => -164
	},
	{#State 344
		DEFAULT => -124
	},
	{#State 345
		ACTIONS => {
			'VARIABLE_SYMBOL' => 364
		}
	},
	{#State 346
		DEFAULT => -59
	},
	{#State 347
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 365
		}
	},
	{#State 348
		ACTIONS => {
			'OP20_HASH_FATARROW' => 366
		}
	},
	{#State 349
		DEFAULT => -192
	},
	{#State 350
		ACTIONS => {
			";" => 367
		}
	},
	{#State 351
		DEFAULT => -48
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 368
		}
	},
	{#State 353
		ACTIONS => {
			'MY' => 369
		}
	},
	{#State 354
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 113,
			"undef" => 114,
			'LBRACE' => 112,
			'OP03_MATH_INC_DEC' => 111,
			"\@{" => 118,
			'WORD' => 22,
			'LBRACKET' => 92,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'OP01_OPEN' => 101
		},
		GOTOS => {
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Literal' => 116,
			'Operator' => 86,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'SubExpression' => 370,
			'Variable' => 139,
			'ArrayReference' => 102
		}
	},
	{#State 355
		ACTIONS => {
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP03_MATH_INC_DEC' => 111,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'MY' => 151,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_QW' => 152,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'Expression' => 135,
			'HashReference' => 90,
			'ListElements' => 371,
			'Literal' => 116,
			'ListElement' => 150,
			'Operator' => 86,
			'HashDereference' => 82,
			'TypeInner' => 149,
			'WordScoped' => 83,
			'SubExpression' => 147,
			'ArrayReference' => 102,
			'Variable' => 139
		}
	},
	{#State 356
		DEFAULT => -157
	},
	{#State 357
		DEFAULT => -207
	},
	{#State 358
		DEFAULT => -159
	},
	{#State 359
		ACTIONS => {
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED_VOID' => 91,
			'LBRACKET' => 92,
			"if" => 93,
			'WORD' => 22,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'OP01_OPEN' => 101,
			'WORD_UPPERCASE' => 104,
			'OP01_NAMED_VOID_SCOLON' => 106,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED' => 108,
			'WORD_SCOPED' => 24,
			'MY' => 109,
			"}" => 373,
			'OP03_MATH_INC_DEC' => 111,
			"while" => -139,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"\@{" => 118,
			'OP19_LOOP_CONTROL' => 117,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			"for" => -139,
			"foreach" => -139,
			'OP01_PRINT' => 122
		},
		GOTOS => {
			'PAREN-34' => 119,
			'ArrayReference' => 102,
			'Variable' => 123,
			'SubExpression' => 103,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116,
			'VariableModification' => 95,
			'Operation' => 372,
			'LoopLabel' => 96,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'OPTIONAL-35' => 85,
			'Operator' => 86,
			'OperatorVoid' => 110,
			'Conditional' => 89,
			'Expression' => 79,
			'VariableDeclaration' => 105,
			'Statement' => 80
		}
	},
	{#State 360
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP10_NAMED_UNARY' => -150,
			'LITERAL_STRING' => -150,
			'LITERAL_NUMBER' => -150,
			'LPAREN' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'OP01_CLOSE' => -150,
			"elsif" => 375,
			'OP01_OPEN' => -150,
			'OP01_NAMED_VOID' => -150,
			'' => -150,
			'LBRACKET' => -150,
			"if" => -150,
			'WORD' => -150,
			'OP01_NAMED' => -150,
			"}" => -150,
			'MY' => -150,
			'WORD_SCOPED' => -150,
			'WORD_UPPERCASE' => -150,
			"else" => 378,
			'OP22_LOGICAL_NEG' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'VARIABLE_SYMBOL' => -150,
			"%{" => -150,
			"foreach" => -150,
			"for" => -150,
			'OP01_PRINT' => -150,
			"undef" => -150,
			'LBRACE' => -150,
			'OP05_LOGICAL_NEG' => -150,
			"while" => -150,
			'OP03_MATH_INC_DEC' => -150,
			"\@{" => -150,
			'OP19_LOOP_CONTROL' => -150
		},
		GOTOS => {
			'PAREN-38' => 377,
			'OPTIONAL-39' => 374,
			'PAREN-36' => 376
		}
	},
	{#State 361
		DEFAULT => -80
	},
	{#State 362
		ACTIONS => {
			'OP21_LIST_COMMA' => 379
		}
	},
	{#State 363
		DEFAULT => -168
	},
	{#State 364
		ACTIONS => {
			"= sub {" => 380
		}
	},
	{#State 365
		ACTIONS => {
			'OP21_LIST_COMMA' => 382,
			"}" => 383
		},
		GOTOS => {
			'PAREN-24' => 381
		}
	},
	{#State 366
		ACTIONS => {
			'MY' => 151
		},
		GOTOS => {
			'TypeInner' => 384
		}
	},
	{#State 367
		DEFAULT => -64
	},
	{#State 368
		ACTIONS => {
			"\@_;" => 385
		}
	},
	{#State 369
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 386
		}
	},
	{#State 370
		ACTIONS => {
			'OP17_LIST_RANGE' => 387,
			'OP23_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167,
			'OP13_BITWISE_AND' => 176,
			'OP16_LOGICAL_OR' => 173,
			'OP18_TERNARY' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178
		}
	},
	{#State 371
		ACTIONS => {
			")" => 388
		}
	},
	{#State 372
		DEFAULT => -158
	},
	{#State 373
		DEFAULT => -160
	},
	{#State 374
		DEFAULT => -151
	},
	{#State 375
		ACTIONS => {
			'LPAREN' => 389
		}
	},
	{#State 376
		DEFAULT => -146
	},
	{#State 377
		DEFAULT => -149
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 331
		},
		GOTOS => {
			'CodeBlock' => 390
		}
	},
	{#State 379
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP10_NAMED_UNARY' => 84,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 107,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'OP01_OPEN' => 101,
			"undef" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			"\@{" => 118,
			'WORD' => 22,
			'LBRACKET' => 92
		},
		GOTOS => {
			'SubExpression' => 391,
			'Variable' => 139,
			'ArrayReference' => 102,
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Literal' => 116,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90
		}
	},
	{#State 380
		ACTIONS => {
			'LBRACE' => -66,
			"undef" => -66,
			'OP05_LOGICAL_NEG' => -66,
			"while" => -66,
			'OP03_MATH_INC_DEC' => -66,
			"\@{" => -66,
			'OP19_LOOP_CONTROL' => -66,
			"%{" => -66,
			'VARIABLE_SYMBOL' => -66,
			"foreach" => -66,
			"for" => -66,
			'OP01_PRINT' => -66,
			'WORD_UPPERCASE' => -66,
			'LPAREN_MY' => 392,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP01_NAMED' => -66,
			"}" => -66,
			'WORD_SCOPED' => -66,
			'MY' => -66,
			'OP01_NAMED_VOID' => -66,
			'WORD' => -66,
			'LBRACKET' => -66,
			"if" => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'LPAREN' => -66,
			'OP01_CLOSE' => -66,
			'OP01_OPEN' => -66,
			'LITERAL_STRING' => -66,
			'LITERAL_NUMBER' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP10_NAMED_UNARY' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 394,
			'MethodArguments' => 393
		}
	},
	{#State 381
		DEFAULT => -61
	},
	{#State 382
		ACTIONS => {
			'WORD' => 348,
			"%{" => 121
		},
		GOTOS => {
			'HashDereference' => 349,
			'HashEntryTyped' => 395
		}
	},
	{#State 383
		ACTIONS => {
			";" => 396
		}
	},
	{#State 384
		ACTIONS => {
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121,
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'HashDereference' => 82,
			'WordScoped' => 83,
			'Operator' => 86,
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 397,
			'Expression' => 135,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Literal' => 116
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
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'LBRACKET' => 92,
			'WORD' => 22,
			"\@{" => 118,
			'OP03_MATH_INC_DEC' => 111,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 97,
			'LPAREN' => 99,
			'OP05_MATH_NEG_LPAREN' => 100,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120
		},
		GOTOS => {
			'Expression' => 135,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'Literal' => 116,
			'Operator' => 86,
			'HashDereference' => 82,
			'WordScoped' => 83,
			'SubExpression' => 399,
			'ArrayReference' => 102,
			'Variable' => 139
		}
	},
	{#State 388
		ACTIONS => {
			'LBRACE' => 331
		},
		GOTOS => {
			'CodeBlock' => 400
		}
	},
	{#State 389
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 107,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 78,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED' => 138,
			'WORD' => 22,
			'LBRACKET' => 92,
			"\@{" => 118,
			'OP05_LOGICAL_NEG' => 113,
			'LBRACE' => 112,
			"undef" => 114,
			'OP03_MATH_INC_DEC' => 111,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'VARIABLE_SYMBOL' => 120,
			"%{" => 121
		},
		GOTOS => {
			'Variable' => 139,
			'ArrayReference' => 102,
			'SubExpression' => 401,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'Operator' => 86,
			'Literal' => 116,
			'ArrayDereference' => 115,
			'HashReference' => 90,
			'Expression' => 135
		}
	},
	{#State 390
		DEFAULT => -148
	},
	{#State 391
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => -81,
			"}" => -81,
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => -81,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			'OP13_BITWISE_AND' => 176,
			";" => -81,
			'OP21_LIST_COMMA' => -81,
			"]" => -81,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP08_STRING_CAT' => 179,
			'OP16_LOGICAL_OR' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP18_TERNARY' => 180,
			")" => -81
		}
	},
	{#State 392
		ACTIONS => {
			'TYPE_SELF' => 402
		}
	},
	{#State 393
		DEFAULT => -65
	},
	{#State 394
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 403
		}
	},
	{#State 395
		DEFAULT => -60
	},
	{#State 396
		DEFAULT => -63
	},
	{#State 397
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP18_TERNARY' => 180,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP06_REGEX_MATCH' => 177,
			'OP15_LOGICAL_AND' => 169,
			'OP07_STRING_REPEAT' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP21_LIST_COMMA' => -191,
			'OP13_BITWISE_AND' => 176,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			"}" => -191,
			'OP17_LIST_RANGE' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => 164
		}
	},
	{#State 398
		DEFAULT => -47
	},
	{#State 399
		ACTIONS => {
			'OP13_BITWISE_AND' => 176,
			")" => 404,
			'OP16_LOGICAL_OR' => 173,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP11_COMPARE_LT_GT' => 170,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP06_REGEX_MATCH' => 177,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP15_LOGICAL_AND' => 169,
			'OP07_STRING_REPEAT' => 178,
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 174,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 167
		}
	},
	{#State 400
		DEFAULT => -156
	},
	{#State 401
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => 166,
			'OP17_LIST_RANGE' => 165,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 175,
			'OP13_BITWISE_AND' => 176,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 177,
			'OP12_COMPARE_EQ_NE' => 168,
			'OP15_LOGICAL_AND' => 169,
			'OP08_STRING_CAT' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP16_LOGICAL_OR' => 173,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP18_TERNARY' => 180,
			")" => 405
		}
	},
	{#State 402
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 406
		}
	},
	{#State 403
		ACTIONS => {
			"}" => 408,
			'WORD_SCOPED' => 24,
			'MY' => 109,
			'OP01_NAMED' => 108,
			'OP22_LOGICAL_NEG' => 107,
			'OP01_NAMED_VOID_SCOLON' => 106,
			'WORD_UPPERCASE' => 104,
			'OP01_PRINT' => 122,
			"%{" => 121,
			'VARIABLE_SYMBOL' => 120,
			"foreach" => -139,
			"for" => -139,
			"\@{" => 118,
			'OP19_LOOP_CONTROL' => 117,
			"undef" => 114,
			'LBRACE' => 112,
			"while" => -139,
			'OP05_LOGICAL_NEG' => 113,
			'OP03_MATH_INC_DEC' => 111,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 78,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 100,
			'LPAREN' => 99,
			'OP01_CLOSE' => 97,
			'WORD' => 22,
			'LBRACKET' => 92,
			"if" => 93,
			'OP01_NAMED_VOID' => 91
		},
		GOTOS => {
			'Operator' => 86,
			'WordScoped' => 83,
			'HashDereference' => 82,
			'OPTIONAL-35' => 85,
			'Conditional' => 89,
			'OperatorVoid' => 110,
			'Expression' => 79,
			'Statement' => 80,
			'VariableDeclaration' => 105,
			'PAREN-34' => 119,
			'SubExpression' => 103,
			'ArrayReference' => 102,
			'Variable' => 123,
			'HashReference' => 90,
			'ArrayDereference' => 115,
			'VariableModification' => 95,
			'Operation' => 407,
			'LoopLabel' => 96,
			'Literal' => 116
		}
	},
	{#State 404
		ACTIONS => {
			'LBRACE' => 331
		},
		GOTOS => {
			'CodeBlock' => 409
		}
	},
	{#State 405
		ACTIONS => {
			'LBRACE' => 331
		},
		GOTOS => {
			'CodeBlock' => 410
		}
	},
	{#State 406
		ACTIONS => {
			'OP21_LIST_COMMA' => 413,
			")" => 411
		},
		GOTOS => {
			'PAREN-28' => 412
		}
	},
	{#State 407
		DEFAULT => -67
	},
	{#State 408
		ACTIONS => {
			";" => 414
		}
	},
	{#State 409
		DEFAULT => -155
	},
	{#State 410
		DEFAULT => -145
	},
	{#State 411
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 415
		}
	},
	{#State 412
		DEFAULT => -71
	},
	{#State 413
		ACTIONS => {
			'MY' => 416
		}
	},
	{#State 414
		DEFAULT => -69
	},
	{#State 415
		ACTIONS => {
			"\@_;" => 417
		}
	},
	{#State 416
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 418
		}
	},
	{#State 417
		DEFAULT => -73
	},
	{#State 418
		ACTIONS => {
			'VARIABLE_SYMBOL' => 419
		}
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
our string_hashref $RULES = {
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
Operation_77 => 'RPerl::Operation::Statement',  # Operation -> Statement
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
OperatorVoid_110 => 'RPerl::Operation::Statement::OperatorVoid::Print',        # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_111 => 'RPerl::Operation::Statement::OperatorVoid::Print',        # OperatorVoid -> OP01_PRINT FH_REF_SYMBOL_BRACES ListElements ';'
OperatorVoid_112 => 'RPerl::Operation::Statement::OperatorVoid::Named',        # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_113 => 'RPerl::Operation::Statement::OperatorVoid::Named',        # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_114 => 'RPerl::Operation::Expression::Operator::Named',           # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_115 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',  # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_116 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',  # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
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
Statement_142 => 'RPerl::Operation::Statement::OperatorVoid',  # Statement -> OperatorVoid
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
