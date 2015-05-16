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

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandleref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|\$TYPED_|\=\ sub\ \{|package|foreach|undef|elsif|while|else|for|\@_\;|use|our|my|if|\%\{|\@\{|\)|\]|\;|\})}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
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


#line 129 lib/RPerl/Grammar.pm

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
  [ '_PAREN' => 'PAREN-18', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
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
  [ '_PAREN' => 'PAREN-28', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
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
  [ 'Operator_81' => 'Operator', [ 'OP01_OPEN', 'my', 'filehandleref', 'FH_REF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
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
  [ 'LoopFor_155' => 'LoopFor', [ 'for', 'my', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_156' => 'LoopForEach', [ 'foreach', 'my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
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
  [ 'VariableDeclaration_167' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_168' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
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
  [ 'TypeInner_207' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_208' => 'TypeInnerConstant', [ 'my', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
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
	'my' => { ISSEMANTIC => 0 },
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
			"package" => -20,
			'SHEBANG' => 7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Program' => 6,
			'Critic' => 2,
			'OPTIONAL-9' => 1,
			'CompileUnit' => 3,
			'ModuleHeader' => 4,
			'PLUS-2' => 8,
			'PAREN-1' => 5
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			'' => 11
		}
	},
	{#State 4
		ACTIONS => {
			"use parent qw(" => 15,
			"## no critic qw(" => -25,
			"use constant" => -25,
			"use" => -25,
			"our" => -25
		},
		GOTOS => {
			'Package' => 14,
			'STAR-10' => 16,
			'Class' => 13,
			'Module' => 12
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 17,
			'OPTIONAL-3' => 18
		}
	},
	{#State 8
		ACTIONS => {
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'OPTIONAL-9' => 1,
			'Critic' => 2,
			'ModuleHeader' => 4,
			'PAREN-1' => 19
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
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 23
		}
	},
	{#State 11
		DEFAULT => 0
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		DEFAULT => -23
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 16
		ACTIONS => {
			"our" => -27,
			"use constant" => -27,
			"use" => -27,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'STAR-11' => 27,
			'Critic' => 26
		}
	},
	{#State 17
		DEFAULT => -6
	},
	{#State 18
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 28
		}
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 21
		DEFAULT => -35
	},
	{#State 22
		DEFAULT => -203
	},
	{#State 23
		ACTIONS => {
			";" => 32
		}
	},
	{#State 24
		DEFAULT => -202
	},
	{#State 25
		ACTIONS => {
			")" => 33
		}
	},
	{#State 26
		DEFAULT => -24
	},
	{#State 27
		ACTIONS => {
			"use constant" => -29,
			"use" => 36,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 34,
			'Include' => 35
		}
	},
	{#State 28
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 29
		ACTIONS => {
			"use warnings;" => 38
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
			"use strict;" => 29
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
			"use constant" => 43,
			"our" => 42
		},
		GOTOS => {
			'PLUS-13' => 45,
			'Constant' => 44,
			'Subroutine' => 41
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 46
		}
	},
	{#State 37
		ACTIONS => {
			'OP10_NAMED_UNARY' => -11,
			"my" => -11,
			'LITERAL_STRING' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'WORD' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_PRINT' => -11,
			'OP01_OPEN' => -11,
			'WORD_UPPERCASE' => -11,
			"undef" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"## no critic qw(" => 9,
			'OP01_NAMED_VOID' => -11,
			'LPAREN' => -11,
			'LBRACKET' => -11,
			"while" => -11,
			'WORD_SCOPED' => -11,
			"if" => -11,
			"use constant" => -11,
			"\@{" => -11,
			"our" => -11,
			"foreach" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LBRACE' => -11,
			'VARIABLE_SYMBOL' => -11,
			'LITERAL_NUMBER' => -11,
			"for" => -11,
			'OP01_CLOSE' => -11,
			"%{" => -11,
			"use" => -11
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
			"use" => 36
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 41
		DEFAULT => -31
	},
	{#State 42
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 54
		}
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 56,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 46
		ACTIONS => {
			";" => 58,
			'OP01_QW' => 57
		}
	},
	{#State 47
		DEFAULT => -8
	},
	{#State 48
		ACTIONS => {
			"if" => -13,
			'WORD_SCOPED' => -13,
			'LBRACKET' => -13,
			"while" => -13,
			'LPAREN' => -13,
			'LBRACE' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'VARIABLE_SYMBOL' => -13,
			"our" => -13,
			"foreach" => -13,
			"use constant" => -13,
			"\@{" => -13,
			"for" => -13,
			'LITERAL_NUMBER' => -13,
			"use" => 36,
			'OP01_CLOSE' => -13,
			"%{" => -13,
			'WORD' => -13,
			'LITERAL_STRING' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"my" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_OPEN' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_PRINT' => -13,
			"undef" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED' => -13,
			'OP05_MATH_NEG_LPAREN' => -13
		},
		GOTOS => {
			'Include' => 60,
			'STAR-6' => 59
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
		DEFAULT => -206
	},
	{#State 52
		ACTIONS => {
			'VARIABLE_SYMBOL' => 63
		}
	},
	{#State 53
		DEFAULT => -205
	},
	{#State 54
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 55
		DEFAULT => -30
	},
	{#State 56
		ACTIONS => {
			";" => 65
		}
	},
	{#State 57
		ACTIONS => {
			'WORD' => 67
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 58
		DEFAULT => -39
	},
	{#State 59
		ACTIONS => {
			'LITERAL_NUMBER' => -15,
			"for" => -15,
			"%{" => -15,
			'OP01_CLOSE' => -15,
			"if" => -15,
			'LPAREN' => -15,
			'LBRACKET' => -15,
			"while" => -15,
			'WORD_SCOPED' => -15,
			"foreach" => -15,
			"our" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LBRACE' => -15,
			'VARIABLE_SYMBOL' => -15,
			"\@{" => -15,
			"use constant" => 43,
			'OP01_NAMED_VOID' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_STRING' => -15,
			'WORD' => -15,
			'OP10_NAMED_UNARY' => -15,
			"my" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"undef" => -15,
			'OP01_OPEN' => -15,
			'OP01_PRINT' => -15,
			'WORD_UPPERCASE' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP19_LOOP_CONTROL' => -15
		},
		GOTOS => {
			'Constant' => 68,
			'STAR-7' => 69
		}
	},
	{#State 60
		DEFAULT => -10
	},
	{#State 61
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 70
		}
	},
	{#State 62
		ACTIONS => {
			"our hashref \$properties" => -54,
			"## no critic qw(" => 9,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'Critic' => 71,
			'STAR-21' => 72
		}
	},
	{#State 63
		ACTIONS => {
			"= sub {" => 73
		}
	},
	{#State 64
		ACTIONS => {
			"my" => 75
		},
		GOTOS => {
			'TypeInnerConstant' => 74
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			")" => 77,
			'WORD' => 76
		}
	},
	{#State 67
		DEFAULT => -38
	},
	{#State 68
		DEFAULT => -12
	},
	{#State 69
		ACTIONS => {
			"undef" => 109,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 107,
			'OP01_PRINT' => 108,
			'OP01_NAMED_VOID_SCOLON' => 110,
			'OP19_LOOP_CONTROL' => 111,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			"my" => 103,
			'OP10_NAMED_UNARY' => 104,
			'OP01_NAMED_VOID' => 118,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 122,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"foreach" => -139,
			"our" => 42,
			"\@{" => 90,
			"if" => 79,
			"while" => -139,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'LPAREN' => 84,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			"for" => -139,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'SubExpression' => 102,
			'PLUS-8' => 83,
			'WordScoped' => 85,
			'OperatorVoid' => 78,
			'Operation' => 80,
			'Variable' => 100,
			'Expression' => 81,
			'OPTIONAL-35' => 112,
			'VariableModification' => 91,
			'Statement' => 92,
			'HashReference' => 113,
			'Subroutine' => 105,
			'Operator' => 89,
			'ArrayDereference' => 93,
			'LoopLabel' => 94,
			'Conditional' => 115,
			'PAREN-34' => 95,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'VariableDeclaration' => 120,
			'Literal' => 119
		}
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
			"use" => 36,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 125,
			'Include' => 124
		}
	},
	{#State 73
		ACTIONS => {
			'OP01_CLOSE' => -43,
			"%{" => -43,
			'LITERAL_NUMBER' => -43,
			"for" => -43,
			"\@{" => -43,
			"foreach" => -43,
			"}" => -43,
			'LBRACE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'LPAREN' => -43,
			"while" => -43,
			'LBRACKET' => -43,
			'WORD_SCOPED' => -43,
			"if" => -43,
			'LPAREN_MY' => 126,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_NAMED' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'WORD_UPPERCASE' => -43,
			'OP01_OPEN' => -43,
			'OP01_PRINT' => -43,
			"undef" => -43,
			'OP10_NAMED_UNARY' => -43,
			"my" => -43,
			'OP22_LOGICAL_NEG' => -43,
			'LITERAL_STRING' => -43,
			'WORD' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 128,
			'SubroutineArguments' => 127
		}
	},
	{#State 74
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'LITERAL_STRING' => 99
		},
		GOTOS => {
			'Literal' => 129
		}
	},
	{#State 75
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 130
		}
	},
	{#State 76
		DEFAULT => -37
	},
	{#State 77
		ACTIONS => {
			";" => 131
		}
	},
	{#State 78
		DEFAULT => -142
	},
	{#State 79
		ACTIONS => {
			'LPAREN' => 132
		}
	},
	{#State 80
		DEFAULT => -17
	},
	{#State 81
		ACTIONS => {
			'OP08_STRING_CAT' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP18_TERNARY' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP06_REGEX_MATCH' => -126,
			";" => 133,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP04_MATH_POW' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP24_LOGICAL_OR_XOR' => -126
		}
	},
	{#State 82
		ACTIONS => {
			"\@{" => 90,
			"]" => -181,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"undef" => 109,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			"my" => 144,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'LITERAL_NUMBER' => 96,
			'OP01_QW' => 140
		},
		GOTOS => {
			'Variable' => 142,
			'ListElements' => 139,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'ListElement' => 136,
			'SubExpression' => 143,
			'Literal' => 119,
			'OPTIONAL-45' => 134,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'HashReference' => 113
		}
	},
	{#State 83
		ACTIONS => {
			"\@{" => 90,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 84,
			'LBRACKET' => 82,
			"while" => -139,
			'WORD_SCOPED' => 22,
			"if" => 79,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'LITERAL_NUMBER' => 96,
			"for" => -139,
			'OP05_LOGICAL_NEG' => 114,
			'OP19_LOOP_CONTROL' => 111,
			'OP01_NAMED_VOID_SCOLON' => 110,
			'OP01_OPEN' => 106,
			'OP01_PRINT' => 108,
			'WORD_UPPERCASE' => 107,
			"undef" => 109,
			'OP10_NAMED_UNARY' => 104,
			"my" => 103,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'' => -18,
			'WORD' => 24,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP01_NAMED' => 122,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED_VOID' => 118
		},
		GOTOS => {
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Literal' => 119,
			'VariableDeclaration' => 120,
			'ArrayDereference' => 93,
			'PAREN-34' => 95,
			'Conditional' => 115,
			'LoopLabel' => 94,
			'OPTIONAL-35' => 112,
			'Statement' => 92,
			'HashReference' => 113,
			'VariableModification' => 91,
			'Operator' => 89,
			'SubExpression' => 102,
			'WordScoped' => 85,
			'OperatorVoid' => 78,
			'Expression' => 81,
			'Variable' => 100,
			'Operation' => 145
		}
	},
	{#State 84
		ACTIONS => {
			'OP01_NAMED' => 146,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'LITERAL_NUMBER' => 96,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP01_PRINT' => 147,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99
		},
		GOTOS => {
			'Expression' => 135,
			'Variable' => 142,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 148,
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'HashReference' => 113
		}
	},
	{#State 85
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 150,
			'LPAREN' => 149
		}
	},
	{#State 86
		ACTIONS => {
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'Variable' => 151
		}
	},
	{#State 87
		ACTIONS => {
			'LITERAL_STRING' => 99,
			"}" => 158,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 157,
			"%{" => 98,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'HashEntry' => 154,
			'Variable' => 156,
			'VariableOrLiteralOrWord' => 155,
			'Literal' => 152,
			'HashDereference' => 153
		}
	},
	{#State 88
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 159
		}
	},
	{#State 89
		DEFAULT => -121
	},
	{#State 90
		ACTIONS => {
			"my" => 144,
			'LBRACKET' => -184,
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'TypeInner' => 162,
			'OPTIONAL-46' => 161,
			'Variable' => 160
		}
	},
	{#State 91
		DEFAULT => -144
	},
	{#State 92
		DEFAULT => -77
	},
	{#State 93
		DEFAULT => -131
	},
	{#State 94
		ACTIONS => {
			'COLON' => 163
		}
	},
	{#State 95
		DEFAULT => -138
	},
	{#State 96
		DEFAULT => -214
	},
	{#State 97
		ACTIONS => {
			'FH_REF_SYMBOL' => 164
		}
	},
	{#State 98
		ACTIONS => {
			'LBRACE' => -199,
			'VARIABLE_SYMBOL' => 88,
			"my" => 144
		},
		GOTOS => {
			'Variable' => 167,
			'OPTIONAL-50' => 166,
			'TypeInner' => 165
		}
	},
	{#State 99
		DEFAULT => -215
	},
	{#State 100
		ACTIONS => {
			'OP13_BITWISE_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP04_MATH_POW' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP19_VARIABLE_ASSIGN' => 171,
			'OP03_MATH_INC_DEC' => 169,
			'OP16_LOGICAL_OR' => -129,
			'OP18_TERNARY' => -129,
			'OP08_STRING_CAT' => -129,
			'OP02_METHOD_THINARROW' => 168,
			'OP23_LOGICAL_AND' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 170,
			'OP06_REGEX_MATCH' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129
		}
	},
	{#State 101
		ACTIONS => {
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'LITERAL_NUMBER' => 96,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82
		},
		GOTOS => {
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'HashReference' => 113,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'SubExpression' => 172,
			'WordScoped' => 85
		}
	},
	{#State 102
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 187,
			'OP23_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => 188,
			'OP06_REGEX_MATCH' => 182,
			'OP09_BITWISE_SHIFT' => 184,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 103
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 190
		}
	},
	{#State 104
		ACTIONS => {
			'OP23_LOGICAL_AND' => -95,
			'OP05_LOGICAL_NEG' => 114,
			"]" => -95,
			'OP21_LIST_COMMA' => -95,
			'OP16_LOGICAL_OR' => -95,
			"undef" => 109,
			'OP18_TERNARY' => -95,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP08_STRING_CAT' => -95,
			'OP10_NAMED_UNARY' => 104,
			'OP12_COMPARE_EQ_NE' => -95,
			";" => -95,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'OP06_REGEX_MATCH' => -95,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP04_MATH_POW' => -95,
			")" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			"\@{" => 90,
			'OP14_BITWISE_OR_XOR' => -95,
			"}" => -95,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'OP08_MATH_ADD_SUB' => -95,
			'OP15_LOGICAL_AND' => -95,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'LPAREN' => 84,
			'OP07_STRING_REPEAT' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP11_COMPARE_LT_GT' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'SubExpression' => 191,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142,
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89
		}
	},
	{#State 105
		DEFAULT => -14
	},
	{#State 106
		ACTIONS => {
			"my" => 192
		}
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => 193,
			'COLON' => -204
		}
	},
	{#State 108
		ACTIONS => {
			'OP01_OPEN' => -109,
			'WORD_UPPERCASE' => -109,
			'VARIABLE_SYMBOL' => -109,
			'LBRACE' => -109,
			'OP03_MATH_INC_DEC' => -109,
			"undef" => -109,
			"\@{" => -109,
			'STDOUT_STDERR' => 196,
			'OP05_LOGICAL_NEG' => -109,
			'WORD' => -109,
			'LITERAL_STRING' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'WORD_SCOPED' => -109,
			'LBRACKET' => -109,
			"my" => -109,
			'LPAREN' => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'OP01_NAMED' => -109,
			'OP01_CLOSE' => -109,
			"%{" => -109,
			'FH_REF_SYMBOL_BRACES' => 197,
			'OP01_QW' => -109,
			'LITERAL_NUMBER' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 195,
			'PAREN-30' => 194
		}
	},
	{#State 109
		DEFAULT => -127
	},
	{#State 110
		DEFAULT => -112
	},
	{#State 111
		ACTIONS => {
			'WORD_UPPERCASE' => 199
		},
		GOTOS => {
			'LoopLabel' => 198
		}
	},
	{#State 112
		ACTIONS => {
			"for" => 200,
			"while" => 202,
			"foreach" => 204
		},
		GOTOS => {
			'Loop' => 205,
			'LoopForEach' => 203,
			'LoopWhile' => 206,
			'LoopFor' => 201
		}
	},
	{#State 113
		DEFAULT => -132
	},
	{#State 114
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'LITERAL_NUMBER' => 96,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"undef" => 109,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'SubExpression' => 207,
			'WordScoped' => 85,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'HashReference' => 113
		}
	},
	{#State 115
		DEFAULT => -140
	},
	{#State 116
		DEFAULT => -133
	},
	{#State 117
		DEFAULT => -130
	},
	{#State 118
		ACTIONS => {
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			"my" => 144,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP01_QW' => 140,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'HashReference' => 113,
			'ListElements' => 208,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'ListElement' => 136,
			'SubExpression' => 143
		}
	},
	{#State 119
		DEFAULT => -128
	},
	{#State 120
		DEFAULT => -143
	},
	{#State 121
		DEFAULT => -115
	},
	{#State 122
		ACTIONS => {
			'OP01_QW' => 140,
			'LITERAL_NUMBER' => 96,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			"my" => 144,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"undef" => 109,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142,
			'ListElement' => 210,
			'SubExpression' => 209,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'HashReference' => 113
		}
	},
	{#State 123
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'LITERAL_NUMBER' => 96,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104
		},
		GOTOS => {
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'HashReference' => 113,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 211
		}
	},
	{#State 124
		DEFAULT => -53
	},
	{#State 125
		ACTIONS => {
			"use constant" => 43,
			"our hashref \$properties" => 213
		},
		GOTOS => {
			'Constant' => 212,
			'Properties' => 214
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 215
		}
	},
	{#State 127
		DEFAULT => -42
	},
	{#State 128
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 216
		}
	},
	{#State 129
		ACTIONS => {
			";" => 217
		}
	},
	{#State 130
		ACTIONS => {
			"\$TYPED_" => 218
		}
	},
	{#State 131
		DEFAULT => -40
	},
	{#State 132
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106
		},
		GOTOS => {
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'SubExpression' => 219,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135
		}
	},
	{#State 133
		DEFAULT => -76
	},
	{#State 134
		ACTIONS => {
			"]" => 220
		}
	},
	{#State 135
		DEFAULT => -126
	},
	{#State 136
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 221
		}
	},
	{#State 137
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'SubExpression' => 222,
			'WordScoped' => 85,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'HashReference' => 113
		}
	},
	{#State 138
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			'LBRACE' => 87,
			'LITERAL_NUMBER' => 96,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'OP01_CLOSE' => 97,
			"%{" => 98
		},
		GOTOS => {
			'SubExpression' => 223,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142,
			'HashReference' => 113,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119
		}
	},
	{#State 139
		DEFAULT => -180
	},
	{#State 140
		ACTIONS => {
			'WORD' => 225
		},
		GOTOS => {
			'PLUS-44' => 224
		}
	},
	{#State 141
		ACTIONS => {
			'LPAREN' => 193
		}
	},
	{#State 142
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			")" => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP04_MATH_POW' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP06_REGEX_MATCH' => -129,
			";" => -129,
			"]" => -129,
			'OP21_LIST_COMMA' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP02_METHOD_THINARROW' => 168,
			'OP08_STRING_CAT' => -129,
			"}" => -129,
			'OP03_MATH_INC_DEC' => 169,
			'OP16_LOGICAL_OR' => -129,
			'OP18_TERNARY' => -129
		}
	},
	{#State 143
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP09_BITWISE_SHIFT' => 184,
			")" => -177,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP06_REGEX_MATCH' => 182,
			";" => -177,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP21_LIST_COMMA' => -177,
			"]" => -177,
			'OP23_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179
		}
	},
	{#State 144
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 226
		}
	},
	{#State 145
		DEFAULT => -16
	},
	{#State 146
		ACTIONS => {
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			"my" => 144,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'OP01_QW' => 140,
			'LITERAL_NUMBER' => 96,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123
		},
		GOTOS => {
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'HashReference' => 113,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'ListElement' => 227,
			'SubExpression' => 209
		}
	},
	{#State 147
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 228
		}
	},
	{#State 148
		ACTIONS => {
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP23_LOGICAL_AND' => 177,
			'OP06_REGEX_MATCH' => 182,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => 188,
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185,
			'OP13_BITWISE_AND' => 174,
			")" => 229,
			'OP09_BITWISE_SHIFT' => 184,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => 186
		}
	},
	{#State 149
		ACTIONS => {
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			"my" => 144,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_NUMBER' => 96,
			'OP01_QW' => 140,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			")" => -118,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123
		},
		GOTOS => {
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'ListElement' => 136,
			'SubExpression' => 143,
			'TypeInner' => 137,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'ListElements' => 230,
			'Variable' => 142,
			'OPTIONAL-32' => 231,
			'Expression' => 135
		}
	},
	{#State 150
		ACTIONS => {
			")" => 232
		}
	},
	{#State 151
		DEFAULT => -83
	},
	{#State 152
		DEFAULT => -212
	},
	{#State 153
		DEFAULT => -190
	},
	{#State 154
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 233
		}
	},
	{#State 155
		ACTIONS => {
			'OP20_HASH_FATARROW' => 234
		}
	},
	{#State 156
		DEFAULT => -211
	},
	{#State 157
		DEFAULT => -213
	},
	{#State 158
		DEFAULT => -197
	},
	{#State 159
		ACTIONS => {
			'OP20_HASH_FATARROW' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP13_BITWISE_AND' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			")" => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP04_MATH_POW' => -163,
			'OP02_ARRAY_THINARROW' => 236,
			'OP06_REGEX_MATCH' => -163,
			'OP02_HASH_THINARROW' => 235,
			";" => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP08_STRING_CAT' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'COLON' => -163,
			"}" => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP18_TERNARY' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			"]" => -163,
			'OP23_LOGICAL_AND' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 237
		}
	},
	{#State 160
		ACTIONS => {
			"}" => 238
		}
	},
	{#State 161
		ACTIONS => {
			'LBRACKET' => 82
		},
		GOTOS => {
			'ArrayReference' => 239
		}
	},
	{#State 162
		DEFAULT => -183
	},
	{#State 163
		DEFAULT => -137
	},
	{#State 164
		DEFAULT => -82
	},
	{#State 165
		DEFAULT => -198
	},
	{#State 166
		ACTIONS => {
			'LBRACE' => 87
		},
		GOTOS => {
			'HashReference' => 240
		}
	},
	{#State 167
		ACTIONS => {
			"}" => 241
		}
	},
	{#State 168
		ACTIONS => {
			'LPAREN' => 242
		}
	},
	{#State 169
		DEFAULT => -84
	},
	{#State 170
		ACTIONS => {
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'SubExpression' => 243,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89
		}
	},
	{#State 171
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'STDIN' => 246,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'LBRACE' => 87,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'HashReference' => 113,
			'Expression' => 135,
			'Variable' => 142,
			'SubExpressionOrStdin' => 244,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 245
		}
	},
	{#State 172
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185,
			'OP13_BITWISE_AND' => 174,
			")" => -104,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP06_REGEX_MATCH' => 182,
			";" => -104,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => 178,
			"}" => -104,
			'OP16_LOGICAL_OR' => 179,
			'OP21_LIST_COMMA' => -104,
			'OP14_BITWISE_OR_XOR' => 187,
			"]" => -104,
			'OP23_LOGICAL_AND' => -104
		}
	},
	{#State 173
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'LITERAL_NUMBER' => 96,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'SubExpression' => 247,
			'WordScoped' => 85,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'HashReference' => 113
		}
	},
	{#State 174
		ACTIONS => {
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'LITERAL_NUMBER' => 96,
			"undef" => 109,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'SubExpression' => 248,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142
		}
	},
	{#State 175
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'WordScoped' => 85,
			'SubExpression' => 249,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'HashReference' => 113,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117
		}
	},
	{#State 176
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			"undef" => 109,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'SubExpression' => 250,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142
		}
	},
	{#State 177
		ACTIONS => {
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'LBRACE' => 87,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'HashReference' => 113,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'WordScoped' => 85,
			'SubExpression' => 251,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93
		}
	},
	{#State 178
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'VARIABLE_SYMBOL' => 88,
			'LITERAL_STRING' => 99
		},
		GOTOS => {
			'Literal' => 253,
			'VariableOrLiteral' => 252,
			'Variable' => 254
		}
	},
	{#State 179
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'LITERAL_NUMBER' => 96,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'LBRACE' => 87,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'WordScoped' => 85,
			'SubExpression' => 255,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'HashReference' => 113,
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116
		}
	},
	{#State 180
		ACTIONS => {
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'HashReference' => 113,
			'Expression' => 135,
			'Variable' => 142,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 256
		}
	},
	{#State 181
		ACTIONS => {
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'LITERAL_NUMBER' => 96,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"undef" => 109,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24
		},
		GOTOS => {
			'SubExpression' => 257,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'HashReference' => 113,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119
		}
	},
	{#State 182
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 258
		}
	},
	{#State 183
		ACTIONS => {
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'LITERAL_NUMBER' => 96,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'SubExpression' => 259,
			'WordScoped' => 85,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'HashReference' => 113
		}
	},
	{#State 184
		ACTIONS => {
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'LBRACE' => 87,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'HashReference' => 113,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'SubExpression' => 260,
			'WordScoped' => 85
		}
	},
	{#State 185
		ACTIONS => {
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			"undef" => 109,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'HashReference' => 113,
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142,
			'SubExpression' => 261,
			'WordScoped' => 85
		}
	},
	{#State 186
		ACTIONS => {
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'LITERAL_NUMBER' => 96,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 85,
			'SubExpression' => 262,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'HashReference' => 113,
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116
		}
	},
	{#State 187
		ACTIONS => {
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LITERAL_NUMBER' => 96,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'SubExpression' => 263,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135
		}
	},
	{#State 188
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142,
			'SubExpression' => 264,
			'WordScoped' => 85,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'HashReference' => 113
		}
	},
	{#State 189
		ACTIONS => {
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LITERAL_NUMBER' => 96,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123
		},
		GOTOS => {
			'WordScoped' => 85,
			'SubExpression' => 265,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'HashReference' => 113,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117
		}
	},
	{#State 190
		ACTIONS => {
			'VARIABLE_SYMBOL' => 266
		}
	},
	{#State 191
		ACTIONS => {
			'OP23_LOGICAL_AND' => -94,
			"]" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			"}" => -94,
			'OP18_TERNARY' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP08_STRING_CAT' => 180,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			";" => -94,
			'OP06_REGEX_MATCH' => 182,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			")" => -94,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 192
		ACTIONS => {
			"filehandleref" => 267
		}
	},
	{#State 193
		ACTIONS => {
			")" => 268
		}
	},
	{#State 194
		DEFAULT => -108
	},
	{#State 195
		ACTIONS => {
			"my" => 144,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LITERAL_NUMBER' => 96,
			'OP01_QW' => 140,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			"%{" => 98,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'HashReference' => 113,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'ListElement' => 136,
			'SubExpression' => 143,
			'Expression' => 135,
			'Variable' => 142,
			'ListElements' => 269,
			'ArrayDereference' => 93
		}
	},
	{#State 196
		DEFAULT => -107
	},
	{#State 197
		ACTIONS => {
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			"my" => 144,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'LBRACE' => 87,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LITERAL_NUMBER' => 96,
			'OP01_QW' => 140,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Variable' => 142,
			'ListElements' => 270,
			'Expression' => 135,
			'ListElement' => 136,
			'SubExpression' => 143,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89,
			'HashReference' => 113
		}
	},
	{#State 198
		ACTIONS => {
			";" => 271
		}
	},
	{#State 199
		DEFAULT => -204
	},
	{#State 200
		ACTIONS => {
			"my" => 272
		}
	},
	{#State 201
		DEFAULT => -152
	},
	{#State 202
		ACTIONS => {
			'LPAREN' => 273
		}
	},
	{#State 203
		DEFAULT => -153
	},
	{#State 204
		ACTIONS => {
			"my" => 274
		}
	},
	{#State 205
		DEFAULT => -141
	},
	{#State 206
		DEFAULT => -154
	},
	{#State 207
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -86,
			'OP21_LIST_COMMA' => -86,
			"]" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP08_STRING_CAT' => -86,
			'OP18_TERNARY' => -86,
			"}" => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP06_REGEX_MATCH' => -86,
			";" => -86,
			")" => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP04_MATH_POW' => 173,
			'OP11_COMPARE_LT_GT' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86
		}
	},
	{#State 208
		ACTIONS => {
			";" => 275
		}
	},
	{#State 209
		ACTIONS => {
			")" => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP04_MATH_POW' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP21_LIST_COMMA' => -177,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP18_TERNARY' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP06_REGEX_MATCH' => -79,
			";" => -79
		}
	},
	{#State 210
		ACTIONS => {
			'OP21_LIST_COMMA' => 276
		}
	},
	{#State 211
		ACTIONS => {
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185,
			'OP13_BITWISE_AND' => 174,
			")" => 277,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP23_LOGICAL_AND' => 177,
			'OP06_REGEX_MATCH' => 182,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189
		}
	},
	{#State 212
		DEFAULT => -55
	},
	{#State 213
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 278
		}
	},
	{#State 214
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 279
		}
	},
	{#State 215
		ACTIONS => {
			'VARIABLE_SYMBOL' => 280
		}
	},
	{#State 216
		ACTIONS => {
			'OP10_NAMED_UNARY' => 104,
			"my" => 103,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 114,
			'OP19_LOOP_CONTROL' => 111,
			'OP01_NAMED_VOID_SCOLON' => 110,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 107,
			'OP01_PRINT' => 108,
			"undef" => 109,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP01_NAMED' => 122,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED_VOID' => 118,
			'LPAREN' => 84,
			"while" => -139,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			"if" => 79,
			"\@{" => 90,
			"foreach" => -139,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"}" => 281,
			'LITERAL_NUMBER' => 96,
			"for" => -139,
			'OP01_CLOSE' => 97,
			"%{" => 98
		},
		GOTOS => {
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Literal' => 119,
			'VariableDeclaration' => 120,
			'ArrayDereference' => 93,
			'Conditional' => 115,
			'PAREN-34' => 95,
			'LoopLabel' => 94,
			'OPTIONAL-35' => 112,
			'HashReference' => 113,
			'Statement' => 92,
			'VariableModification' => 91,
			'Operator' => 89,
			'SubExpression' => 102,
			'WordScoped' => 85,
			'OperatorVoid' => 78,
			'Variable' => 100,
			'Expression' => 81,
			'Operation' => 282
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
		ACTIONS => {
			'OP23_LOGICAL_AND' => 177,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 180,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => 188,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			")" => 284,
			'OP13_BITWISE_AND' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 220
		DEFAULT => -182
	},
	{#State 221
		ACTIONS => {
			";" => -174,
			'OP21_LIST_COMMA' => 286,
			"]" => -174,
			")" => -174
		},
		GOTOS => {
			'PAREN-42' => 285
		}
	},
	{#State 222
		ACTIONS => {
			'OP06_REGEX_MATCH' => 182,
			";" => -178,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => 178,
			"]" => -178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP21_LIST_COMMA' => -178,
			'OP23_LOGICAL_AND' => 177,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 184,
			")" => -178,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173
		}
	},
	{#State 223
		ACTIONS => {
			'OP04_MATH_POW' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			")" => -79,
			'OP13_BITWISE_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP23_LOGICAL_AND' => -79,
			"]" => -79,
			'OP21_LIST_COMMA' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			"}" => -79,
			'OP18_TERNARY' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP08_STRING_CAT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			";" => -79,
			'OP06_REGEX_MATCH' => -79
		}
	},
	{#State 224
		ACTIONS => {
			")" => 288,
			'WORD' => 287
		}
	},
	{#State 225
		DEFAULT => -176
	},
	{#State 226
		ACTIONS => {
			"\$TYPED_" => 289
		}
	},
	{#State 227
		ACTIONS => {
			'OP21_LIST_COMMA' => 290
		}
	},
	{#State 228
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP01_QW' => 140,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			"my" => 144,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'LBRACE' => 87,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106
		},
		GOTOS => {
			'HashReference' => 113,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'TypeInner' => 137,
			'WordScoped' => 85,
			'ListElement' => 136,
			'SubExpression' => 143,
			'ListElements' => 291,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93
		}
	},
	{#State 229
		DEFAULT => -134
	},
	{#State 230
		DEFAULT => -117
	},
	{#State 231
		ACTIONS => {
			")" => 292
		}
	},
	{#State 232
		DEFAULT => -125
	},
	{#State 233
		ACTIONS => {
			'OP21_LIST_COMMA' => 295,
			"}" => 294
		},
		GOTOS => {
			'PAREN-48' => 293
		}
	},
	{#State 234
		ACTIONS => {
			"%{" => -188,
			'OP01_CLOSE' => -188,
			'OP01_NAMED' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'LITERAL_NUMBER' => -188,
			'LBRACE' => -188,
			'OP03_MATH_INC_DEC' => -188,
			"undef" => -188,
			'VARIABLE_SYMBOL' => -188,
			'OP01_OPEN' => -188,
			'WORD_UPPERCASE' => -188,
			'OP05_LOGICAL_NEG' => -188,
			"\@{" => -188,
			'OP22_LOGICAL_NEG' => -188,
			'LITERAL_STRING' => -188,
			'WORD' => -188,
			'OP10_NAMED_UNARY' => -188,
			'LPAREN' => -188,
			"my" => 144,
			'WORD_SCOPED' => -188,
			'LBRACKET' => -188
		},
		GOTOS => {
			'TypeInner' => 297,
			'OPTIONAL-47' => 296
		}
	},
	{#State 235
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 298,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87
		},
		GOTOS => {
			'HashReference' => 113,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'SubExpression' => 299,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142
		}
	},
	{#State 236
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			'LBRACE' => 87,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LITERAL_NUMBER' => 96,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			"%{" => 98,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'HashReference' => 113,
			'Expression' => 135,
			'Variable' => 142,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 300
		}
	},
	{#State 237
		DEFAULT => -161
	},
	{#State 238
		DEFAULT => -185
	},
	{#State 239
		ACTIONS => {
			"}" => 301
		}
	},
	{#State 240
		ACTIONS => {
			"}" => 302
		}
	},
	{#State 241
		DEFAULT => -200
	},
	{#State 242
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP01_QW' => 140,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			")" => -120,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			"my" => 144,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141
		},
		GOTOS => {
			'ListElements' => 303,
			'Expression' => 135,
			'Variable' => 142,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'SubExpression' => 143,
			'ListElement' => 136,
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'OPTIONAL-33' => 304,
			'HashReference' => 113
		}
	},
	{#State 243
		ACTIONS => {
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP12_COMPARE_EQ_NE' => 181,
			";" => 305,
			'OP06_REGEX_MATCH' => 182,
			'OP23_LOGICAL_AND' => 177,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => 178,
			'OP08_STRING_CAT' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175
		}
	},
	{#State 244
		ACTIONS => {
			";" => 306
		}
	},
	{#State 245
		ACTIONS => {
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => 178,
			'OP08_STRING_CAT' => 180,
			'OP23_LOGICAL_AND' => 177,
			'OP14_BITWISE_OR_XOR' => 187,
			";" => -135,
			'OP06_REGEX_MATCH' => 182,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP13_BITWISE_AND' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => 186
		}
	},
	{#State 246
		DEFAULT => -136
	},
	{#State 247
		ACTIONS => {
			"]" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP08_STRING_CAT' => -85,
			'OP18_TERNARY' => -85,
			"}" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			";" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			")" => -85,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85
		}
	},
	{#State 248
		ACTIONS => {
			"]" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => -98,
			"}" => -98,
			'OP18_TERNARY' => -98,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => -98,
			'OP06_REGEX_MATCH' => 182,
			";" => -98,
			'OP09_BITWISE_SHIFT' => 184,
			")" => -98,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -98,
			'OP11_COMPARE_LT_GT' => 185,
			'OP13_BITWISE_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 249
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP17_LIST_RANGE' => undef,
			'OP11_COMPARE_LT_GT' => 185,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 184,
			")" => -102,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP06_REGEX_MATCH' => 182,
			";" => -102,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 179,
			"}" => -102,
			'OP18_TERNARY' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP14_BITWISE_OR_XOR' => 187,
			"]" => -102,
			'OP23_LOGICAL_AND' => -102
		}
	},
	{#State 250
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => -90,
			")" => -90,
			'OP13_BITWISE_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			";" => -90,
			'OP06_REGEX_MATCH' => 182,
			'OP23_LOGICAL_AND' => -90,
			"]" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP21_LIST_COMMA' => -90,
			"}" => -90,
			'OP18_TERNARY' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP08_STRING_CAT' => -90
		}
	},
	{#State 251
		ACTIONS => {
			'OP23_LOGICAL_AND' => -105,
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP14_BITWISE_OR_XOR' => 187,
			"}" => -105,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 180,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => 188,
			'OP12_COMPARE_EQ_NE' => 181,
			";" => -105,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			")" => -105,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 252
		ACTIONS => {
			'COLON' => 307
		}
	},
	{#State 253
		DEFAULT => -210
	},
	{#State 254
		DEFAULT => -209
	},
	{#State 255
		ACTIONS => {
			"}" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP18_TERNARY' => -101,
			'OP08_STRING_CAT' => 180,
			'OP23_LOGICAL_AND' => -101,
			"]" => -101,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP21_LIST_COMMA' => -101,
			";" => -101,
			'OP06_REGEX_MATCH' => 182,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => -101,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			")" => -101,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => -101
		}
	},
	{#State 256
		ACTIONS => {
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP09_BITWISE_SHIFT' => -92,
			")" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP23_LOGICAL_AND' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			"]" => -92,
			"}" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP18_TERNARY' => -92,
			'OP08_STRING_CAT' => -92,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			";" => -92,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 257
		ACTIONS => {
			";" => -97,
			'OP06_REGEX_MATCH' => 182,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP18_TERNARY' => -97,
			'OP08_STRING_CAT' => 180,
			'OP23_LOGICAL_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			"]" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP11_COMPARE_LT_GT' => 185,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => 184,
			")" => -97
		}
	},
	{#State 258
		DEFAULT => -88
	},
	{#State 259
		ACTIONS => {
			'OP08_STRING_CAT' => -89,
			'OP18_TERNARY' => -89,
			"}" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP21_LIST_COMMA' => -89,
			"]" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP06_REGEX_MATCH' => 182,
			";" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP13_BITWISE_AND' => -89,
			")" => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP04_MATH_POW' => 173,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP24_LOGICAL_OR_XOR' => -89
		}
	},
	{#State 260
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -93,
			'OP21_LIST_COMMA' => -93,
			"]" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => -93,
			"}" => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 182,
			";" => -93,
			")" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 261
		ACTIONS => {
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => -96,
			"}" => -96,
			'OP18_TERNARY' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			"]" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 182,
			";" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP08_MATH_ADD_SUB' => 189,
			'OP17_LIST_RANGE' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP13_BITWISE_AND' => -96,
			")" => -96,
			'OP09_BITWISE_SHIFT' => 184,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => -96
		}
	},
	{#State 262
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP06_REGEX_MATCH' => 182,
			";" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP14_BITWISE_OR_XOR' => 187,
			"]" => -106,
			'OP23_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 179,
			"}" => -106,
			'OP18_TERNARY' => 178,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			")" => -106,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175,
			'OP13_BITWISE_AND' => 174
		}
	},
	{#State 263
		ACTIONS => {
			'OP13_BITWISE_AND' => 174,
			'OP17_LIST_RANGE' => -99,
			'OP11_COMPARE_LT_GT' => 185,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			")" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => -99,
			"}" => -99,
			'OP18_TERNARY' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP08_STRING_CAT' => 180,
			'OP23_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			"]" => -99,
			";" => -99,
			'OP06_REGEX_MATCH' => 182,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => -99,
			'OP12_COMPARE_EQ_NE' => 181
		}
	},
	{#State 264
		ACTIONS => {
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => -100,
			"}" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP21_LIST_COMMA' => -100,
			"]" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 182,
			";" => -100,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 189,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => -100,
			'OP13_BITWISE_AND' => 174,
			")" => -100,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => -100
		}
	},
	{#State 265
		ACTIONS => {
			'OP23_LOGICAL_AND' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			"]" => -91,
			"}" => -91,
			'OP18_TERNARY' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP08_STRING_CAT' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			";" => -91,
			'OP06_REGEX_MATCH' => 182,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => -91,
			")" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 266
		ACTIONS => {
			";" => 308,
			'OP19_VARIABLE_ASSIGN' => 309
		}
	},
	{#State 267
		ACTIONS => {
			'FH_REF_SYMBOL' => 310
		}
	},
	{#State 268
		DEFAULT => -123
	},
	{#State 269
		ACTIONS => {
			";" => 311
		}
	},
	{#State 270
		ACTIONS => {
			";" => 312
		}
	},
	{#State 271
		DEFAULT => -116
	},
	{#State 272
		ACTIONS => {
			'TYPE_INTEGER' => 313
		}
	},
	{#State 273
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			'LBRACE' => 87,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114
		},
		GOTOS => {
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 314,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'HashReference' => 113
		}
	},
	{#State 274
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 315
		}
	},
	{#State 275
		DEFAULT => -113
	},
	{#State 276
		ACTIONS => {
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			"my" => 144,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_QW' => 140,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'Variable' => 142,
			'ListElements' => 316,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'SubExpression' => 143,
			'ListElement' => 136,
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'HashReference' => 113
		}
	},
	{#State 277
		DEFAULT => -87
	},
	{#State 278
		ACTIONS => {
			'LBRACE' => 317
		}
	},
	{#State 279
		ACTIONS => {
			'LITERAL_NUMBER' => 319,
			"our" => 318
		},
		GOTOS => {
			'MethodOrSubroutine' => 320,
			'Subroutine' => 321,
			'Method' => 322
		}
	},
	{#State 280
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 323
		}
	},
	{#State 281
		ACTIONS => {
			";" => 324
		}
	},
	{#State 282
		DEFAULT => -44
	},
	{#State 283
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 325
		}
	},
	{#State 284
		ACTIONS => {
			'LBRACE' => 326
		},
		GOTOS => {
			'CodeBlock' => 327
		}
	},
	{#State 285
		DEFAULT => -172
	},
	{#State 286
		ACTIONS => {
			'OP01_QW' => 140,
			'LITERAL_NUMBER' => 96,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			"my" => 144,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114
		},
		GOTOS => {
			'ListElement' => 328,
			'SubExpression' => 143,
			'WordScoped' => 85,
			'TypeInner' => 137,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89
		}
	},
	{#State 287
		DEFAULT => -175
	},
	{#State 288
		DEFAULT => -179
	},
	{#State 289
		ACTIONS => {
			'WORD' => 329
		}
	},
	{#State 290
		ACTIONS => {
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP01_QW' => 140,
			'LITERAL_NUMBER' => 96,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			"my" => 144,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84
		},
		GOTOS => {
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142,
			'ListElements' => 330,
			'SubExpression' => 143,
			'ListElement' => 136,
			'TypeInner' => 137,
			'WordScoped' => 85,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'HashReference' => 113
		}
	},
	{#State 291
		ACTIONS => {
			")" => 331
		}
	},
	{#State 292
		DEFAULT => -122
	},
	{#State 293
		DEFAULT => -194
	},
	{#State 294
		DEFAULT => -196
	},
	{#State 295
		ACTIONS => {
			"%{" => 98,
			'LITERAL_NUMBER' => 96,
			'VARIABLE_SYMBOL' => 88,
			'WORD' => 157,
			'LITERAL_STRING' => 99
		},
		GOTOS => {
			'HashEntry' => 332,
			'HashDereference' => 153,
			'Literal' => 152,
			'Variable' => 156,
			'VariableOrLiteralOrWord' => 155
		}
	},
	{#State 296
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90
		},
		GOTOS => {
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'Operator' => 89,
			'Literal' => 119,
			'HashReference' => 113,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'SubExpression' => 333,
			'WordScoped' => 85
		}
	},
	{#State 297
		DEFAULT => -187
	},
	{#State 298
		ACTIONS => {
			"}" => 334,
			'OP02_METHOD_THINARROW_NEW' => -202,
			'LPAREN' => -202
		}
	},
	{#State 299
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP23_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179,
			"}" => 335,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 300
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 184,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185,
			'OP13_BITWISE_AND' => 174,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP14_BITWISE_OR_XOR' => 187,
			"]" => 336,
			'OP23_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => 178,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => 188,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 301
		DEFAULT => -186
	},
	{#State 302
		DEFAULT => -201
	},
	{#State 303
		DEFAULT => -119
	},
	{#State 304
		ACTIONS => {
			")" => 337
		}
	},
	{#State 305
		DEFAULT => -170
	},
	{#State 306
		DEFAULT => -169
	},
	{#State 307
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'VARIABLE_SYMBOL' => 88,
			'LITERAL_STRING' => 99
		},
		GOTOS => {
			'Literal' => 253,
			'Variable' => 254,
			'VariableOrLiteral' => 338
		}
	},
	{#State 308
		DEFAULT => -167
	},
	{#State 309
		ACTIONS => {
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'VARIABLE_SYMBOL' => 88,
			'LBRACE' => 87,
			"undef" => 109,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'STDIN' => 246,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'WordScoped' => 85,
			'SubExpression' => 245,
			'SubExpressionOrStdin' => 339,
			'Expression' => 135,
			'Variable' => 142,
			'ArrayDereference' => 93,
			'HashReference' => 113,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117
		}
	},
	{#State 310
		ACTIONS => {
			'OP21_LIST_COMMA' => 340
		}
	},
	{#State 311
		DEFAULT => -110
	},
	{#State 312
		DEFAULT => -111
	},
	{#State 313
		ACTIONS => {
			'VARIABLE_SYMBOL' => 341
		}
	},
	{#State 314
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => 188,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP23_LOGICAL_AND' => 177,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => 178,
			'OP08_STRING_CAT' => 180,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			")" => 342,
			'OP13_BITWISE_AND' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185
		}
	},
	{#State 315
		ACTIONS => {
			'VARIABLE_SYMBOL' => 343
		}
	},
	{#State 316
		ACTIONS => {
			";" => 344
		}
	},
	{#State 317
		ACTIONS => {
			"%{" => 98,
			'WORD' => 345,
			"}" => 347
		},
		GOTOS => {
			'HashDereference' => 346,
			'HashEntryTyped' => 348
		}
	},
	{#State 318
		ACTIONS => {
			'WORD' => 53,
			'TYPE_METHOD' => 349,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 319
		ACTIONS => {
			";" => 350
		}
	},
	{#State 320
		DEFAULT => -57
	},
	{#State 321
		DEFAULT => -75
	},
	{#State 322
		DEFAULT => -74
	},
	{#State 323
		ACTIONS => {
			'OP21_LIST_COMMA' => 352,
			")" => 351
		},
		GOTOS => {
			'PAREN-18' => 353
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
			'OP01_NAMED_VOID' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 122,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			"for" => -139,
			'LITERAL_NUMBER' => 96,
			'OP01_PRINT' => 108,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 107,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'OP01_NAMED_VOID_SCOLON' => 110,
			"foreach" => -139,
			'OP19_LOOP_CONTROL' => 111,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'WORD' => 24,
			"if" => 79,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'LBRACKET' => 82,
			"while" => -139,
			'WORD_SCOPED' => 22,
			"my" => 103,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104
		},
		GOTOS => {
			'OPTIONAL-35' => 112,
			'VariableModification' => 91,
			'Statement' => 92,
			'HashReference' => 113,
			'Operator' => 89,
			'SubExpression' => 102,
			'WordScoped' => 85,
			'PLUS-40' => 354,
			'OperatorVoid' => 78,
			'Operation' => 355,
			'Expression' => 81,
			'Variable' => 100,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'VariableDeclaration' => 120,
			'ArrayDereference' => 93,
			'LoopLabel' => 94,
			'Conditional' => 115,
			'PAREN-34' => 95
		}
	},
	{#State 327
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 356
		}
	},
	{#State 328
		DEFAULT => -171
	},
	{#State 329
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 357
		}
	},
	{#State 330
		ACTIONS => {
			")" => 358
		}
	},
	{#State 331
		DEFAULT => -78
	},
	{#State 332
		DEFAULT => -193
	},
	{#State 333
		ACTIONS => {
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP23_LOGICAL_AND' => 177,
			'OP21_LIST_COMMA' => -189,
			'OP14_BITWISE_OR_XOR' => 187,
			"}" => -189,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 180,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 334
		DEFAULT => -166
	},
	{#State 335
		DEFAULT => -165
	},
	{#State 336
		DEFAULT => -164
	},
	{#State 337
		DEFAULT => -124
	},
	{#State 338
		DEFAULT => -103
	},
	{#State 339
		ACTIONS => {
			";" => 359
		}
	},
	{#State 340
		ACTIONS => {
			'LITERAL_STRING' => 360
		}
	},
	{#State 341
		ACTIONS => {
			'LPAREN' => 361
		}
	},
	{#State 342
		ACTIONS => {
			'LBRACE' => 326
		},
		GOTOS => {
			'CodeBlock' => 362
		}
	},
	{#State 343
		ACTIONS => {
			'LPAREN' => 363
		}
	},
	{#State 344
		DEFAULT => -114
	},
	{#State 345
		ACTIONS => {
			'OP20_HASH_FATARROW' => 364
		}
	},
	{#State 346
		DEFAULT => -192
	},
	{#State 347
		ACTIONS => {
			";" => 365
		}
	},
	{#State 348
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 366
		}
	},
	{#State 349
		ACTIONS => {
			'VARIABLE_SYMBOL' => 367
		}
	},
	{#State 350
		DEFAULT => -59
	},
	{#State 351
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 368
		}
	},
	{#State 352
		ACTIONS => {
			"my" => 369
		}
	},
	{#State 353
		DEFAULT => -48
	},
	{#State 354
		ACTIONS => {
			"if" => 79,
			"while" => -139,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LPAREN' => 84,
			"}" => 371,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			"foreach" => -139,
			"\@{" => 90,
			"for" => -139,
			'LITERAL_NUMBER' => 96,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			"my" => 103,
			'OP10_NAMED_UNARY' => 104,
			'OP01_OPEN' => 106,
			'OP01_PRINT' => 108,
			'WORD_UPPERCASE' => 107,
			"undef" => 109,
			'OP01_NAMED_VOID_SCOLON' => 110,
			'OP19_LOOP_CONTROL' => 111,
			'OP05_LOGICAL_NEG' => 114,
			'OP01_NAMED_VOID' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 122
		},
		GOTOS => {
			'LoopLabel' => 94,
			'PAREN-34' => 95,
			'Conditional' => 115,
			'ArrayDereference' => 93,
			'Literal' => 119,
			'VariableDeclaration' => 120,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'WordScoped' => 85,
			'SubExpression' => 102,
			'Operation' => 370,
			'Expression' => 81,
			'Variable' => 100,
			'OperatorVoid' => 78,
			'VariableModification' => 91,
			'Statement' => 92,
			'HashReference' => 113,
			'OPTIONAL-35' => 112,
			'Operator' => 89
		}
	},
	{#State 355
		DEFAULT => -159
	},
	{#State 356
		ACTIONS => {
			'WORD_UPPERCASE' => -150,
			'OP01_PRINT' => -150,
			'OP01_OPEN' => -150,
			"undef" => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP19_LOOP_CONTROL' => -150,
			'OP05_LOGICAL_NEG' => -150,
			'' => -150,
			'WORD' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'LITERAL_STRING' => -150,
			"my" => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP01_NAMED_VOID' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'OP01_NAMED' => -150,
			"else" => 376,
			'LBRACE' => -150,
			"}" => -150,
			'OP03_MATH_INC_DEC' => -150,
			'VARIABLE_SYMBOL' => -150,
			"foreach" => -150,
			"\@{" => -150,
			"if" => -150,
			'LBRACKET' => -150,
			"while" => -150,
			'WORD_SCOPED' => -150,
			'LPAREN' => -150,
			"elsif" => 373,
			'OP01_CLOSE' => -150,
			"%{" => -150,
			"for" => -150,
			'LITERAL_NUMBER' => -150
		},
		GOTOS => {
			'OPTIONAL-39' => 375,
			'PAREN-38' => 372,
			'PAREN-36' => 374
		}
	},
	{#State 357
		DEFAULT => -207
	},
	{#State 358
		DEFAULT => -80
	},
	{#State 359
		DEFAULT => -168
	},
	{#State 360
		ACTIONS => {
			'OP21_LIST_COMMA' => 377
		}
	},
	{#State 361
		ACTIONS => {
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'LITERAL_NUMBER' => 96,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'SubExpression' => 378,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Variable' => 142,
			'Expression' => 135,
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89
		}
	},
	{#State 362
		DEFAULT => -157
	},
	{#State 363
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			"my" => 144,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			'LITERAL_NUMBER' => 96,
			'OP01_QW' => 140
		},
		GOTOS => {
			'ListElements' => 379,
			'Expression' => 135,
			'Variable' => 142,
			'ArrayDereference' => 93,
			'TypeInner' => 137,
			'WordScoped' => 85,
			'ListElement' => 136,
			'SubExpression' => 143,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'HashReference' => 113
		}
	},
	{#State 364
		ACTIONS => {
			"my" => 144
		},
		GOTOS => {
			'TypeInner' => 380
		}
	},
	{#State 365
		DEFAULT => -64
	},
	{#State 366
		ACTIONS => {
			'OP21_LIST_COMMA' => 383,
			"}" => 381
		},
		GOTOS => {
			'PAREN-24' => 382
		}
	},
	{#State 367
		ACTIONS => {
			"= sub {" => 384
		}
	},
	{#State 368
		ACTIONS => {
			"\@_;" => 385
		}
	},
	{#State 369
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 386
		}
	},
	{#State 370
		DEFAULT => -158
	},
	{#State 371
		DEFAULT => -160
	},
	{#State 372
		DEFAULT => -149
	},
	{#State 373
		ACTIONS => {
			'LPAREN' => 387
		}
	},
	{#State 374
		DEFAULT => -146
	},
	{#State 375
		DEFAULT => -151
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 326
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 377
		ACTIONS => {
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 88,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LITERAL_NUMBER' => 96,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138
		},
		GOTOS => {
			'SubExpression' => 389,
			'WordScoped' => 85,
			'ArrayDereference' => 93,
			'Expression' => 135,
			'Variable' => 142,
			'HashReference' => 113,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'Literal' => 119,
			'Operator' => 89
		}
	},
	{#State 378
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP13_BITWISE_AND' => 174,
			'OP17_LIST_RANGE' => 390,
			'OP11_COMPARE_LT_GT' => 185,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => 188,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => 178,
			'OP08_STRING_CAT' => 180,
			'OP23_LOGICAL_AND' => 177,
			'OP14_BITWISE_OR_XOR' => 187
		}
	},
	{#State 379
		ACTIONS => {
			")" => 391
		}
	},
	{#State 380
		ACTIONS => {
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'WORD_UPPERCASE' => 141,
			'OP01_OPEN' => 106,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			'VARIABLE_SYMBOL' => 88,
			"undef" => 109,
			'LITERAL_NUMBER' => 96,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123
		},
		GOTOS => {
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 392,
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'HashReference' => 113
		}
	},
	{#State 381
		ACTIONS => {
			";" => 393
		}
	},
	{#State 382
		DEFAULT => -61
	},
	{#State 383
		ACTIONS => {
			"%{" => 98,
			'WORD' => 345
		},
		GOTOS => {
			'HashDereference' => 346,
			'HashEntryTyped' => 394
		}
	},
	{#State 384
		ACTIONS => {
			'OP01_NAMED_VOID' => -66,
			'OP01_NAMED' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			"undef" => -66,
			'OP01_OPEN' => -66,
			'OP01_PRINT' => -66,
			'WORD_UPPERCASE' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'LITERAL_STRING' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'WORD' => -66,
			'OP10_NAMED_UNARY' => -66,
			"my" => -66,
			"%{" => -66,
			'OP01_CLOSE' => -66,
			'LITERAL_NUMBER' => -66,
			"for" => -66,
			"foreach" => -66,
			'LBRACE' => -66,
			"}" => -66,
			'OP03_MATH_INC_DEC' => -66,
			'VARIABLE_SYMBOL' => -66,
			"\@{" => -66,
			"if" => -66,
			'LPAREN_MY' => 397,
			'LPAREN' => -66,
			'LBRACKET' => -66,
			"while" => -66,
			'WORD_SCOPED' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 396,
			'MethodArguments' => 395
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
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 138,
			"%{" => 98,
			'OP01_CLOSE' => 97,
			'LITERAL_NUMBER' => 96,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 114,
			'VARIABLE_SYMBOL' => 88,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 109,
			'LBRACE' => 87,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP10_NAMED_UNARY' => 104,
			'LPAREN' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 119,
			'ArrayReference' => 117,
			'HashDereference' => 116,
			'HashReference' => 113,
			'Expression' => 135,
			'Variable' => 142,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 399
		}
	},
	{#State 388
		DEFAULT => -148
	},
	{#State 389
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => 184,
			")" => -81,
			";" => -81,
			'OP06_REGEX_MATCH' => 182,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP12_COMPARE_EQ_NE' => 181,
			"}" => -81,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 180,
			'OP23_LOGICAL_AND' => -81,
			"]" => -81,
			'OP21_LIST_COMMA' => -81,
			'OP14_BITWISE_OR_XOR' => 187
		}
	},
	{#State 390
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 101,
			'LITERAL_STRING' => 99,
			'WORD' => 24,
			'LPAREN' => 84,
			'OP10_NAMED_UNARY' => 104,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 82,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACE' => 87,
			"undef" => 109,
			'VARIABLE_SYMBOL' => 88,
			'OP05_LOGICAL_NEG' => 114,
			"\@{" => 90,
			'LITERAL_NUMBER' => 96,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'OP01_NAMED' => 138,
			'OP05_MATH_NEG_LPAREN' => 123
		},
		GOTOS => {
			'Literal' => 119,
			'Operator' => 89,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'HashReference' => 113,
			'Variable' => 142,
			'Expression' => 135,
			'ArrayDereference' => 93,
			'WordScoped' => 85,
			'SubExpression' => 400
		}
	},
	{#State 391
		ACTIONS => {
			'LBRACE' => 326
		},
		GOTOS => {
			'CodeBlock' => 401
		}
	},
	{#State 392
		ACTIONS => {
			'OP23_LOGICAL_AND' => 177,
			'OP21_LIST_COMMA' => -191,
			'OP14_BITWISE_OR_XOR' => 187,
			"}" => -191,
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => 178,
			'OP08_STRING_CAT' => 180,
			'OP08_MATH_ADD_SUB' => 189,
			'OP15_LOGICAL_AND' => 188,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP11_COMPARE_LT_GT' => 185,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 393
		DEFAULT => -63
	},
	{#State 394
		DEFAULT => -60
	},
	{#State 395
		DEFAULT => -65
	},
	{#State 396
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 402
		}
	},
	{#State 397
		ACTIONS => {
			'TYPE_SELF' => 403
		}
	},
	{#State 398
		DEFAULT => -47
	},
	{#State 399
		ACTIONS => {
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 185,
			'OP17_LIST_RANGE' => 175,
			'OP04_MATH_POW' => 173,
			'OP07_STRING_REPEAT' => 183,
			")" => 404,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 176,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 180,
			'OP23_LOGICAL_AND' => 177,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP06_REGEX_MATCH' => 182,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP12_COMPARE_EQ_NE' => 181
		}
	},
	{#State 400
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP16_LOGICAL_OR' => 179,
			'OP18_TERNARY' => -102,
			'OP08_STRING_CAT' => 180,
			'OP15_LOGICAL_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP07_STRING_REPEAT' => 183,
			'OP04_MATH_POW' => 173,
			")" => 405,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 174,
			'OP17_LIST_RANGE' => undef,
			'OP11_COMPARE_LT_GT' => 185,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 176
		}
	},
	{#State 401
		DEFAULT => -156
	},
	{#State 402
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 121,
			'OP05_MATH_NEG_LPAREN' => 123,
			'OP01_NAMED' => 122,
			'OP01_NAMED_VOID' => 118,
			'OP10_NAMED_UNARY' => 104,
			"my" => 103,
			'LITERAL_STRING' => 99,
			'OP22_LOGICAL_NEG' => 101,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 114,
			'OP19_LOOP_CONTROL' => 111,
			'OP01_NAMED_VOID_SCOLON' => 110,
			'OP01_OPEN' => 106,
			'WORD_UPPERCASE' => 107,
			'OP01_PRINT' => 108,
			"undef" => 109,
			'LITERAL_NUMBER' => 96,
			"for" => -139,
			'OP01_CLOSE' => 97,
			"%{" => 98,
			'LPAREN' => 84,
			"while" => -139,
			'LBRACKET' => 82,
			'WORD_SCOPED' => 22,
			"if" => 79,
			"\@{" => 90,
			"foreach" => -139,
			'LBRACE' => 87,
			'OP03_MATH_INC_DEC' => 86,
			"}" => 406,
			'VARIABLE_SYMBOL' => 88
		},
		GOTOS => {
			'VariableDeclaration' => 120,
			'Literal' => 119,
			'HashDereference' => 116,
			'ArrayReference' => 117,
			'LoopLabel' => 94,
			'PAREN-34' => 95,
			'Conditional' => 115,
			'ArrayDereference' => 93,
			'VariableModification' => 91,
			'HashReference' => 113,
			'Statement' => 92,
			'OPTIONAL-35' => 112,
			'Operator' => 89,
			'WordScoped' => 85,
			'SubExpression' => 102,
			'Operation' => 407,
			'Expression' => 81,
			'Variable' => 100,
			'OperatorVoid' => 78
		}
	},
	{#State 403
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 408
		}
	},
	{#State 404
		ACTIONS => {
			'LBRACE' => 326
		},
		GOTOS => {
			'CodeBlock' => 409
		}
	},
	{#State 405
		ACTIONS => {
			'LBRACE' => 326
		},
		GOTOS => {
			'CodeBlock' => 410
		}
	},
	{#State 406
		ACTIONS => {
			";" => 411
		}
	},
	{#State 407
		DEFAULT => -67
	},
	{#State 408
		ACTIONS => {
			")" => 412,
			'OP21_LIST_COMMA' => 413
		},
		GOTOS => {
			'PAREN-28' => 414
		}
	},
	{#State 409
		DEFAULT => -145
	},
	{#State 410
		DEFAULT => -155
	},
	{#State 411
		DEFAULT => -69
	},
	{#State 412
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 415
		}
	},
	{#State 413
		ACTIONS => {
			"my" => 416
		}
	},
	{#State 414
		DEFAULT => -71
	},
	{#State 415
		ACTIONS => {
			"\@_;" => 417
		}
	},
	{#State 416
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 51
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
#line 5744 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5751 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5758 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5765 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5776 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5787 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5794 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5801 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5808 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5815 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5822 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5829 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5836 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5843 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5850 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5857 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5864 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5871 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5882 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5889 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5896 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5907 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5918 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5996 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6007 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6014 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6021 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6032 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6039 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6057 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6068 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6100 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6107 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6118 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6125 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6132 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6139 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6150 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6171 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6178 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6185 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6192 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6199 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6206 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6217 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6224 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6231 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6238 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6267 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6274 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6306 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6313 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6320 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6331 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6342 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6353 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6364 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6375 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6386 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6397 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6408 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6419 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6430 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6452 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6463 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6485 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6507 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6518 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6529 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6540 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6551 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6562 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6573 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6584 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6606 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6628 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6639 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6650 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6672 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6694 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6701 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6715 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6726 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6748 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6759 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6770 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6781 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6792 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6799 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6820 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6831 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6842 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6853 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6864 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6897 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6919 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6930 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6941 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6963 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6974 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6985 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6996 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7003 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7010 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7114 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7158 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7169 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7180 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7191 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7223 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7230 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7318 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7325 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7332 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_174
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7357 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7364 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7375 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7386 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7397 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7404 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7411 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7422 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_185
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_186
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7494 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7523 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_196
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_197
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7559 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7566 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_200
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_201
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_202
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_204
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule Type_205
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule Type_206
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7650 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_207
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7661 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_208
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7672 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_209
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7683 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_210
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7694 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_211
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_212
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7716 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_213
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7727 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_214
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7738 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_215
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7749 lib/RPerl/Grammar.pm
	]
],
#line 7752 lib/RPerl/Grammar.pm
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

#line 206 "lib/RPerl/Grammar.eyp"


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
TypeInner_207 => 'RPerl::NonGenerator',             # TypeInner -> 'my' Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_208 => 'RPerl::NonGenerator',     # TypeInnerConstant -> 'my' Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
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


#line 8132 lib/RPerl/Grammar.pm



1;
