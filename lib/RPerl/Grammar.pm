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
    our $VERSION = 0.000_994;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach|\=\ sub\ \{|\$TYPED_|package|undef|while|elsif|else|our|use|for|\@_\;|my|if|\%\{|\@\{|\)|\]|\}|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\$VERSION\ =)/gc and return ('VERSION_ASSIGN', $1);
      /\G(\d\d?\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
      /\G(integer\s+)/gc and return ('TYPE_INTEGER', $1);
      /\G([a-zA-Z]\w*__method)/gc and return ('TYPE_METHOD', $1);
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
      /\G(sin|cos|push|pop|keys|values|sort|ETC)\s/gc and return ('OP01_NAMED', $1);
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
  [ 'Header_33' => 'Header', [ 'use strict;', 'use warnings;', 'use RPerl;', 'our', 'VERSION_ASSIGN', 'VERSION_NUMBER', ';' ], 0 ],
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
  [ 'Properties_63' => 'Properties', [ 'our hash_ref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryTyped', 'STAR-25', '}', ';' ], 0 ],
  [ 'Properties_64' => 'Properties', [ 'our hash_ref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
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
  [ 'Operator_81' => 'Operator', [ 'OP01_OPEN', 'my', 'filehandle_ref', 'FH_REF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
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
  [ 'HashEntry_189' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-47', 'SubExpression' ], 0 ],
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
  [ 'Literal_211' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_212' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'Literal_211' => 211,
  'Literal_212' => 212,
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
	'filehandle_ref' => { ISSEMANTIC => 0 },
	'for' => { ISSEMANTIC => 0 },
	'foreach' => { ISSEMANTIC => 0 },
	'if' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our hash_ref $properties' => { ISSEMANTIC => 0 },
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
	VERSION_ASSIGN => { ISSEMANTIC => 1 },
	VERSION_NUMBER => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 7,
			"## no critic qw(" => 5,
			"package" => -20
		},
		GOTOS => {
			'CompileUnit' => 4,
			'Critic' => 2,
			'PAREN-1' => 3,
			'ModuleHeader' => 1,
			'OPTIONAL-9' => 6,
			'PLUS-2' => 9,
			'Program' => 8
		}
	},
	{#State 1
		ACTIONS => {
			"our" => -25,
			"use" => -25,
			"use constant" => -25,
			"use parent qw(" => 14,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'STAR-10' => 11,
			'Module' => 10,
			'Class' => 12,
			'Package' => 13
		}
	},
	{#State 2
		DEFAULT => -19
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
			'WORD' => 16
		},
		GOTOS => {
			'PLUS-14' => 17
		}
	},
	{#State 6
		ACTIONS => {
			"package" => 18
		}
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 5,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 20,
			'OPTIONAL-3' => 19
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => 5,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'Critic' => 2,
			'PAREN-1' => 21,
			'ModuleHeader' => 1,
			'OPTIONAL-9' => 6
		}
	},
	{#State 10
		DEFAULT => -1
	},
	{#State 11
		ACTIONS => {
			"use constant" => -27,
			"## no critic qw(" => 5,
			"our" => -27,
			"use" => -27
		},
		GOTOS => {
			'Critic' => 22,
			'STAR-11' => 23
		}
	},
	{#State 12
		DEFAULT => -23
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 15
		DEFAULT => 0
	},
	{#State 16
		DEFAULT => -35
	},
	{#State 17
		ACTIONS => {
			'WORD' => 27,
			")" => 28
		}
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 19
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 31
		}
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		DEFAULT => -2
	},
	{#State 22
		DEFAULT => -24
	},
	{#State 23
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 32
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 33
		}
	},
	{#State 24
		ACTIONS => {
			")" => 35
		}
	},
	{#State 25
		DEFAULT => -203
	},
	{#State 26
		DEFAULT => -202
	},
	{#State 27
		DEFAULT => -34
	},
	{#State 28
		DEFAULT => -36
	},
	{#State 29
		ACTIONS => {
			";" => 36
		}
	},
	{#State 30
		ACTIONS => {
			"use warnings;" => 37
		}
	},
	{#State 31
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 38
		}
	},
	{#State 32
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"our" => 44,
			"use constant" => 41
		},
		GOTOS => {
			'Subroutine' => 42,
			'PLUS-13' => 43,
			'Constant' => 40
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			";" => 45
		}
	},
	{#State 36
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 46
		}
	},
	{#State 37
		ACTIONS => {
			"use RPerl;" => 47
		}
	},
	{#State 38
		ACTIONS => {
			'WORD' => -11,
			'LPAREN' => -11,
			"use" => -11,
			'OP01_PRINT' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"my" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED_VOID' => -11,
			'LBRACE' => -11,
			"use constant" => -11,
			'OP01_NAMED' => -11,
			"for" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"undef" => -11,
			"foreach" => -11,
			"our" => -11,
			"\@{" => -11,
			'OP01_OPEN' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"%{" => -11,
			"while" => -11,
			"if" => -11,
			'WORD_SCOPED' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_CLOSE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LBRACKET' => -11,
			"## no critic qw(" => 5,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'LITERAL_NUMBER' => -11
		},
		GOTOS => {
			'Critic' => 48,
			'STAR-5' => 49
		}
	},
	{#State 39
		ACTIONS => {
			";" => 51,
			'OP01_QW' => 50
		}
	},
	{#State 40
		DEFAULT => -28
	},
	{#State 41
		ACTIONS => {
			'WORD_UPPERCASE' => 52
		}
	},
	{#State 42
		DEFAULT => -31
	},
	{#State 43
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 53
		},
		GOTOS => {
			'Subroutine' => 54
		}
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
		ACTIONS => {
			"use" => 32
		},
		GOTOS => {
			'Include' => 58
		}
	},
	{#State 46
		DEFAULT => -21
	},
	{#State 47
		ACTIONS => {
			"our" => 59
		}
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		ACTIONS => {
			'VARIABLE_SYMBOL' => -13,
			'OP01_CLOSE' => -13,
			"while" => -13,
			"\@{" => -13,
			'OP01_OPEN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"%{" => -13,
			"if" => -13,
			'WORD_SCOPED' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LITERAL_NUMBER' => -13,
			'WORD_UPPERCASE' => -13,
			'LBRACKET' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'LPAREN' => -13,
			'WORD' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"my" => -13,
			"use" => 32,
			'OP01_PRINT' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"our" => -13,
			"undef" => -13,
			"foreach" => -13,
			"use constant" => -13,
			'LBRACE' => -13,
			'OP01_NAMED_VOID' => -13,
			'LITERAL_STRING' => -13,
			"for" => -13,
			'OP01_NAMED' => -13
		},
		GOTOS => {
			'STAR-6' => 61,
			'Include' => 60
		}
	},
	{#State 50
		ACTIONS => {
			'WORD' => 63
		},
		GOTOS => {
			'PLUS-15' => 62
		}
	},
	{#State 51
		DEFAULT => -39
	},
	{#State 52
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 53
		ACTIONS => {
			";" => 65
		}
	},
	{#State 54
		DEFAULT => -30
	},
	{#State 55
		DEFAULT => -206
	},
	{#State 56
		DEFAULT => -205
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 58
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 67
		}
	},
	{#State 59
		ACTIONS => {
			'VERSION_ASSIGN' => 68
		}
	},
	{#State 60
		DEFAULT => -10
	},
	{#State 61
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -15,
			'LPAREN' => -15,
			'WORD' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"my" => -15,
			'OP01_PRINT' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"our" => -15,
			"undef" => -15,
			"foreach" => -15,
			'LBRACE' => -15,
			"use constant" => 41,
			'LITERAL_STRING' => -15,
			'OP01_NAMED_VOID' => -15,
			"for" => -15,
			'OP01_NAMED' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_CLOSE' => -15,
			"while" => -15,
			"\@{" => -15,
			"%{" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_OPEN' => -15,
			"if" => -15,
			'WORD_SCOPED' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'LITERAL_NUMBER' => -15,
			'WORD_UPPERCASE' => -15,
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15
		},
		GOTOS => {
			'STAR-7' => 69,
			'Constant' => 70
		}
	},
	{#State 62
		ACTIONS => {
			'WORD' => 71,
			")" => 72
		}
	},
	{#State 63
		DEFAULT => -38
	},
	{#State 64
		ACTIONS => {
			"my" => 73
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
			"= sub {" => 75
		}
	},
	{#State 67
		ACTIONS => {
			"## no critic qw(" => 5,
			"our hash_ref \$properties" => -54,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'STAR-21' => 76,
			'Critic' => 77
		}
	},
	{#State 68
		ACTIONS => {
			'VERSION_NUMBER' => 78
		}
	},
	{#State 69
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			"while" => -139,
			"%{" => 100,
			'OP19_LOOP_CONTROL' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'WORD_SCOPED' => 25,
			"if" => 105,
			'OP01_NAMED_VOID_SCOLON' => 119,
			'OP10_NAMED_UNARY' => 118,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 124,
			'LBRACKET' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 79,
			'WORD' => 26,
			"my" => 83,
			'OP05_LOGICAL_NEG' => 84,
			'OP01_PRINT' => 85,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			"our" => 44,
			"foreach" => -139,
			"undef" => 99,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'OP01_NAMED_VOID' => 91,
			"for" => -139,
			'OP01_NAMED' => 95
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 110,
			'Operation' => 113,
			'SubExpression' => 88,
			'WordScoped' => 86,
			'LoopLabel' => 82,
			'Conditional' => 102,
			'OPTIONAL-35' => 81,
			'ArrayDereference' => 80,
			'VariableModification' => 107,
			'Variable' => 108,
			'OperatorVoid' => 106,
			'VariableDeclaration' => 97,
			'PLUS-8' => 120,
			'Operator' => 122,
			'Statement' => 123,
			'HashReference' => 94,
			'PAREN-34' => 93,
			'Subroutine' => 89,
			'HashDereference' => 114,
			'ArrayReference' => 117
		}
	},
	{#State 70
		DEFAULT => -12
	},
	{#State 71
		DEFAULT => -37
	},
	{#State 72
		ACTIONS => {
			";" => 125
		}
	},
	{#State 73
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 126
		}
	},
	{#State 74
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121
		},
		GOTOS => {
			'Literal' => 127
		}
	},
	{#State 75
		ACTIONS => {
			'OP01_CLOSE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'WORD_SCOPED' => -43,
			"if" => -43,
			'OP19_LOOP_CONTROL' => -43,
			"%{" => -43,
			'OP01_OPEN' => -43,
			"\@{" => -43,
			"while" => -43,
			'WORD_UPPERCASE' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'LPAREN_MY' => 128,
			'LBRACKET' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_PRINT' => -43,
			"my" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'WORD' => -43,
			'LPAREN' => -43,
			"foreach" => -43,
			"undef" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_NAMED' => -43,
			"for" => -43,
			"}" => -43,
			'LITERAL_STRING' => -43,
			'OP01_NAMED_VOID' => -43,
			'LBRACE' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 129,
			'SubroutineArguments' => 130
		}
	},
	{#State 76
		ACTIONS => {
			"our hash_ref \$properties" => -56,
			"use constant" => -56,
			"use" => 32
		},
		GOTOS => {
			'STAR-22' => 131,
			'Include' => 132
		}
	},
	{#State 77
		DEFAULT => -51
	},
	{#State 78
		ACTIONS => {
			";" => 133
		}
	},
	{#State 79
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 139,
			'LBRACKET' => 115,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"%{" => 100,
			'LPAREN' => 79,
			'OP01_PRINT' => 137,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'ArrayReference' => 117,
			'Variable' => 134,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'SubExpression' => 138,
			'WordScoped' => 86,
			'Operator' => 122,
			'Literal' => 111,
			'Expression' => 135
		}
	},
	{#State 80
		DEFAULT => -131
	},
	{#State 81
		ACTIONS => {
			"foreach" => 143,
			"for" => 145,
			"while" => 141
		},
		GOTOS => {
			'Loop' => 142,
			'LoopFor' => 146,
			'LoopWhile' => 140,
			'LoopForEach' => 144
		}
	},
	{#State 82
		ACTIONS => {
			'COLON' => 147
		}
	},
	{#State 83
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 148
		}
	},
	{#State 84
		ACTIONS => {
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"%{" => 100,
			"\@{" => 104,
			'LPAREN' => 79,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121
		},
		GOTOS => {
			'ArrayReference' => 117,
			'Variable' => 134,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'SubExpression' => 149,
			'Operator' => 122,
			'WordScoped' => 86,
			'Literal' => 111,
			'Expression' => 135
		}
	},
	{#State 85
		ACTIONS => {
			'LPAREN' => -109,
			'STDOUT_STDERR' => 151,
			"\@{" => -109,
			'OP01_OPEN' => -109,
			'WORD' => -109,
			"%{" => -109,
			'OP05_LOGICAL_NEG' => -109,
			'WORD_SCOPED' => -109,
			"my" => -109,
			'OP01_QW' => -109,
			'VARIABLE_SYMBOL' => -109,
			'FH_REF_SYMBOL_BRACES' => 154,
			'OP01_CLOSE' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LBRACE' => -109,
			'LITERAL_STRING' => -109,
			'LBRACKET' => -109,
			'OP01_NAMED' => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'LITERAL_NUMBER' => -109,
			'WORD_UPPERCASE' => -109,
			"undef" => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 152,
			'PAREN-30' => 153
		}
	},
	{#State 86
		ACTIONS => {
			'LPAREN' => 156,
			'OP02_METHOD_THINARROW_NEW' => 155
		}
	},
	{#State 87
		ACTIONS => {
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'LPAREN' => 79,
			"\@{" => 104,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 157,
			'Expression' => 135,
			'Literal' => 111,
			'Variable' => 134,
			'ArrayReference' => 117,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'HashReference' => 94
		}
	},
	{#State 88
		ACTIONS => {
			'OP13_BITWISE_AND' => 165,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP04_MATH_POW' => 174,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP09_BITWISE_SHIFT' => 170,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => 163,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159
		}
	},
	{#State 89
		DEFAULT => -14
	},
	{#State 90
		ACTIONS => {
			"}" => 177,
			'WORD' => 178,
			"%{" => 100
		},
		GOTOS => {
			'HashEntry' => 176,
			'HashDereference' => 175
		}
	},
	{#State 91
		ACTIONS => {
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109,
			'OP01_QW' => 182,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			"my" => 180,
			'LPAREN' => 79,
			"\@{" => 104,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'WORD' => 26
		},
		GOTOS => {
			'HashReference' => 94,
			'ListElement' => 184,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'Variable' => 134,
			'ArrayReference' => 117,
			'TypeInner' => 181,
			'ListElements' => 179,
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 183,
			'WordScoped' => 86,
			'Operator' => 122
		}
	},
	{#State 92
		DEFAULT => -211
	},
	{#State 93
		DEFAULT => -138
	},
	{#State 94
		DEFAULT => -132
	},
	{#State 95
		ACTIONS => {
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109,
			'OP01_QW' => 182,
			"my" => 180,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'LPAREN' => 79,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"\@{" => 104
		},
		GOTOS => {
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpression' => 185,
			'Expression' => 135,
			'Literal' => 111,
			'Variable' => 134,
			'ArrayReference' => 117,
			'TypeInner' => 181,
			'HashDereference' => 114,
			'ListElement' => 186,
			'ArrayDereference' => 80,
			'HashReference' => 94
		}
	},
	{#State 96
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'WORD' => 26,
			"\@{" => 104,
			'LPAREN' => 79,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115
		},
		GOTOS => {
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'HashReference' => 94,
			'Variable' => 134,
			'ArrayReference' => 117,
			'Expression' => 135,
			'Literal' => 111,
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 187
		}
	},
	{#State 97
		DEFAULT => -143
	},
	{#State 98
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Variable' => 188
		}
	},
	{#State 99
		DEFAULT => -127
	},
	{#State 100
		ACTIONS => {
			"my" => 180,
			'LBRACE' => -199,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Variable' => 190,
			'TypeInner' => 191,
			'OPTIONAL-50' => 189
		}
	},
	{#State 101
		ACTIONS => {
			'WORD_UPPERCASE' => 192
		},
		GOTOS => {
			'LoopLabel' => 193
		}
	},
	{#State 102
		DEFAULT => -140
	},
	{#State 103
		ACTIONS => {
			"my" => 194
		}
	},
	{#State 104
		ACTIONS => {
			'LBRACKET' => -184,
			"my" => 180,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'OPTIONAL-46' => 196,
			'Variable' => 197,
			'TypeInner' => 195
		}
	},
	{#State 105
		ACTIONS => {
			'LPAREN' => 198
		}
	},
	{#State 106
		DEFAULT => -142
	},
	{#State 107
		DEFAULT => -144
	},
	{#State 108
		ACTIONS => {
			'OP16_LOGICAL_OR' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP03_MATH_INC_DEC' => 202,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP18_TERNARY' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP04_MATH_POW' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP08_STRING_CAT' => -129,
			'OP02_METHOD_THINARROW' => 200,
			'OP07_STRING_REPEAT' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 201,
			'OP08_MATH_ADD_SUB' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP19_VARIABLE_ASSIGN' => 199
		}
	},
	{#State 109
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 203
		}
	},
	{#State 110
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP08_STRING_CAT' => -126,
			";" => 204,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP04_MATH_POW' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP18_TERNARY' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP09_BITWISE_SHIFT' => -126
		}
	},
	{#State 111
		DEFAULT => -128
	},
	{#State 112
		ACTIONS => {
			'FH_REF_SYMBOL' => 205
		}
	},
	{#State 113
		DEFAULT => -17
	},
	{#State 114
		DEFAULT => -133
	},
	{#State 115
		ACTIONS => {
			'LPAREN' => 79,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"%{" => 100,
			"\@{" => 104,
			'WORD_SCOPED' => 25,
			"my" => 180,
			'OP05_LOGICAL_NEG' => 84,
			"]" => -181,
			'VARIABLE_SYMBOL' => 109,
			'OP01_QW' => 182,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 136,
			"undef" => 99
		},
		GOTOS => {
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpression' => 183,
			'Expression' => 135,
			'Literal' => 111,
			'ListElements' => 206,
			'TypeInner' => 181,
			'ArrayReference' => 117,
			'Variable' => 134,
			'OPTIONAL-45' => 207,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'ListElement' => 184,
			'HashReference' => 94
		}
	},
	{#State 116
		DEFAULT => -115
	},
	{#State 117
		DEFAULT => -130
	},
	{#State 118
		ACTIONS => {
			'OP13_BITWISE_AND' => -95,
			'LBRACKET' => 115,
			'OP18_TERNARY' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			")" => -95,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			'OP23_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => -95,
			'LITERAL_NUMBER' => 121,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'OP15_LOGICAL_AND' => -95,
			"]" => -95,
			'WORD_SCOPED' => 25,
			";" => -95,
			'VARIABLE_SYMBOL' => 109,
			'OP07_STRING_REPEAT' => -95,
			'OP08_STRING_CAT' => -95,
			'OP01_CLOSE' => 112,
			'OP21_LIST_COMMA' => -95,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP01_NAMED' => 150,
			'OP04_MATH_POW' => -95,
			"}" => -95,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP09_BITWISE_SHIFT' => -95,
			'OP17_LIST_RANGE' => -95,
			"undef" => 99,
			'OP16_LOGICAL_OR' => -95,
			'WORD' => 26,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'OP08_MATH_ADD_SUB' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 208,
			'WordScoped' => 86,
			'Operator' => 122,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'ArrayReference' => 117,
			'Variable' => 134
		}
	},
	{#State 119
		DEFAULT => -112
	},
	{#State 120
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 87,
			'OP05_LOGICAL_NEG' => 84,
			"my" => 83,
			'OP01_PRINT' => 85,
			'LPAREN' => 79,
			'WORD' => 26,
			"undef" => 99,
			"foreach" => -139,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			"for" => -139,
			'OP01_NAMED' => 95,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'OP01_NAMED_VOID' => 91,
			'OP01_CLOSE' => 112,
			'VARIABLE_SYMBOL' => 109,
			"if" => 105,
			'WORD_SCOPED' => 25,
			"while" => -139,
			"\@{" => 104,
			"%{" => 100,
			'OP19_LOOP_CONTROL' => 101,
			'OP01_OPEN' => 103,
			'' => -18,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 124,
			'OP01_NAMED_VOID_SCOLON' => 119,
			'OP10_NAMED_UNARY' => 118,
			'LBRACKET' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 116
		},
		GOTOS => {
			'PAREN-34' => 93,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayReference' => 117,
			'VariableDeclaration' => 97,
			'Statement' => 123,
			'Operator' => 122,
			'LoopLabel' => 82,
			'OPTIONAL-35' => 81,
			'Conditional' => 102,
			'ArrayDereference' => 80,
			'VariableModification' => 107,
			'Variable' => 108,
			'OperatorVoid' => 106,
			'Literal' => 111,
			'Expression' => 110,
			'SubExpression' => 88,
			'Operation' => 209,
			'WordScoped' => 86
		}
	},
	{#State 121
		DEFAULT => -212
	},
	{#State 122
		DEFAULT => -121
	},
	{#State 123
		DEFAULT => -77
	},
	{#State 124
		ACTIONS => {
			'COLON' => -204,
			'LPAREN' => 210
		}
	},
	{#State 125
		DEFAULT => -40
	},
	{#State 126
		ACTIONS => {
			"\$TYPED_" => 211
		}
	},
	{#State 127
		ACTIONS => {
			";" => 212
		}
	},
	{#State 128
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 213
		}
	},
	{#State 129
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 214
		}
	},
	{#State 130
		DEFAULT => -42
	},
	{#State 131
		ACTIONS => {
			"our hash_ref \$properties" => 217,
			"use constant" => 41
		},
		GOTOS => {
			'Properties' => 216,
			'Constant' => 215
		}
	},
	{#State 132
		DEFAULT => -53
	},
	{#State 133
		DEFAULT => -33
	},
	{#State 134
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			"}" => -129,
			'OP04_MATH_POW' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP03_MATH_INC_DEC' => 202,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			")" => -129,
			'OP09_BITWISE_SHIFT' => -129,
			"]" => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP08_STRING_CAT' => -129,
			'OP02_METHOD_THINARROW' => 200,
			'OP07_STRING_REPEAT' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			";" => -129
		}
	},
	{#State 135
		DEFAULT => -126
	},
	{#State 136
		ACTIONS => {
			'LPAREN' => 210
		}
	},
	{#State 137
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 218
		}
	},
	{#State 138
		ACTIONS => {
			'OP04_MATH_POW' => 174,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP23_LOGICAL_AND' => 163,
			'OP17_LIST_RANGE' => 171,
			'OP09_BITWISE_SHIFT' => 170,
			")" => 219,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => 160,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP14_BITWISE_OR_XOR' => 168
		}
	},
	{#State 139
		ACTIONS => {
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LITERAL_NUMBER' => 121,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'OP01_QW' => 182,
			'VARIABLE_SYMBOL' => 109,
			"my" => 180,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'LPAREN' => 79
		},
		GOTOS => {
			'SubExpression' => 185,
			'Operator' => 122,
			'WordScoped' => 86,
			'Literal' => 111,
			'Expression' => 135,
			'Variable' => 134,
			'ArrayReference' => 117,
			'TypeInner' => 181,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'ListElement' => 220,
			'HashDereference' => 114
		}
	},
	{#State 140
		DEFAULT => -154
	},
	{#State 141
		ACTIONS => {
			'LPAREN' => 221
		}
	},
	{#State 142
		DEFAULT => -141
	},
	{#State 143
		ACTIONS => {
			"my" => 222
		}
	},
	{#State 144
		DEFAULT => -153
	},
	{#State 145
		ACTIONS => {
			"my" => 223
		}
	},
	{#State 146
		DEFAULT => -152
	},
	{#State 147
		DEFAULT => -137
	},
	{#State 148
		ACTIONS => {
			'VARIABLE_SYMBOL' => 224
		}
	},
	{#State 149
		ACTIONS => {
			'OP15_LOGICAL_AND' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			"]" => -86,
			";" => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP08_STRING_CAT' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP13_BITWISE_AND' => -86,
			"}" => -86,
			'OP04_MATH_POW' => 174,
			'OP18_TERNARY' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			")" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP23_LOGICAL_AND' => -86
		}
	},
	{#State 150
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"%{" => 100,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'Variable' => 134,
			'ArrayReference' => 117,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'HashReference' => 94,
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpression' => 225,
			'Expression' => 135,
			'Literal' => 111
		}
	},
	{#State 151
		DEFAULT => -107
	},
	{#State 152
		ACTIONS => {
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'OP01_QW' => 182,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 79,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			"my" => 180,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84
		},
		GOTOS => {
			'SubExpression' => 183,
			'Operator' => 122,
			'WordScoped' => 86,
			'ListElements' => 226,
			'Literal' => 111,
			'Expression' => 135,
			'TypeInner' => 181,
			'Variable' => 134,
			'ArrayReference' => 117,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ListElement' => 184,
			'ArrayDereference' => 80
		}
	},
	{#State 153
		DEFAULT => -108
	},
	{#State 154
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP01_QW' => 182,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'LPAREN' => 79,
			"my" => 180,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84
		},
		GOTOS => {
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 183,
			'Expression' => 135,
			'Literal' => 111,
			'ListElements' => 227,
			'TypeInner' => 181,
			'ArrayReference' => 117,
			'Variable' => 134,
			'ListElement' => 184,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'HashReference' => 94
		}
	},
	{#State 155
		ACTIONS => {
			")" => 228
		}
	},
	{#State 156
		ACTIONS => {
			'WORD_SCOPED' => 25,
			"my" => 180,
			'OP05_LOGICAL_NEG' => 84,
			'LPAREN' => 79,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'WORD' => 26,
			"\@{" => 104,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109,
			'OP01_QW' => 182,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'OP10_NAMED_UNARY' => 118,
			")" => -118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98
		},
		GOTOS => {
			'TypeInner' => 181,
			'Variable' => 134,
			'ArrayReference' => 117,
			'ListElement' => 184,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'HashReference' => 94,
			'OPTIONAL-32' => 230,
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 183,
			'Expression' => 135,
			'Literal' => 111,
			'ListElements' => 229
		}
	},
	{#State 157
		ACTIONS => {
			'OP15_LOGICAL_AND' => 160,
			"]" => -104,
			'OP08_MATH_ADD_SUB' => 169,
			'OP14_BITWISE_OR_XOR' => 168,
			";" => -104,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP13_BITWISE_AND' => 165,
			'OP21_LIST_COMMA' => -104,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP18_TERNARY' => 167,
			"}" => -104,
			'OP04_MATH_POW' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			")" => -104,
			'OP09_BITWISE_SHIFT' => 170,
			'OP23_LOGICAL_AND' => -104,
			'OP17_LIST_RANGE' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164
		}
	},
	{#State 158
		ACTIONS => {
			"\@{" => 104,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121
		},
		GOTOS => {
			'SubExpression' => 231,
			'WordScoped' => 86,
			'Operator' => 122,
			'Literal' => 111,
			'Expression' => 135,
			'ArrayReference' => 117,
			'Variable' => 134,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114
		}
	},
	{#State 159
		ACTIONS => {
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 79,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"%{" => 100,
			"\@{" => 104,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84
		},
		GOTOS => {
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'HashReference' => 94,
			'Variable' => 134,
			'ArrayReference' => 117,
			'Expression' => 135,
			'Literal' => 111,
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 232
		}
	},
	{#State 160
		ACTIONS => {
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'LPAREN' => 79,
			"\@{" => 104,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Variable' => 134,
			'ArrayReference' => 117,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'HashReference' => 94,
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpression' => 233,
			'Expression' => 135,
			'Literal' => 111
		}
	},
	{#State 161
		ACTIONS => {
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LPAREN' => 79,
			"\@{" => 104,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 234,
			'Expression' => 135,
			'Literal' => 111,
			'Variable' => 134,
			'ArrayReference' => 117,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'HashReference' => 94
		}
	},
	{#State 162
		ACTIONS => {
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'WORD' => 26,
			"\@{" => 104,
			'LPAREN' => 79,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 235,
			'Operator' => 122,
			'WordScoped' => 86,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'Variable' => 134,
			'ArrayReference' => 117
		}
	},
	{#State 163
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"\@{" => 104,
			'LPAREN' => 79,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115
		},
		GOTOS => {
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 236,
			'Expression' => 135,
			'Literal' => 111,
			'Variable' => 134,
			'ArrayReference' => 117,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'HashReference' => 94
		}
	},
	{#State 164
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 237
		}
	},
	{#State 165
		ACTIONS => {
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'VARIABLE_SYMBOL' => 109,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"\@{" => 104,
			'LPAREN' => 79
		},
		GOTOS => {
			'Expression' => 135,
			'Literal' => 111,
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpression' => 238,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'HashReference' => 94,
			'ArrayReference' => 117,
			'Variable' => 134
		}
	},
	{#State 166
		ACTIONS => {
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'LPAREN' => 79,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Expression' => 135,
			'Literal' => 111,
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 239,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'HashReference' => 94,
			'Variable' => 134,
			'ArrayReference' => 117
		}
	},
	{#State 167
		ACTIONS => {
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Variable' => 241,
			'Literal' => 240,
			'VariableOrLiteral' => 242
		}
	},
	{#State 168
		ACTIONS => {
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'LPAREN' => 79,
			"\@{" => 104,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'SubExpression' => 243,
			'Operator' => 122,
			'WordScoped' => 86,
			'Literal' => 111,
			'Expression' => 135,
			'Variable' => 134,
			'ArrayReference' => 117,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80
		}
	},
	{#State 169
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			"\@{" => 104,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			'LPAREN' => 79,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'VARIABLE_SYMBOL' => 109,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LITERAL_NUMBER' => 121,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 244,
			'WordScoped' => 86,
			'Operator' => 122,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'Variable' => 134,
			'ArrayReference' => 117
		}
	},
	{#State 170
		ACTIONS => {
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'LPAREN' => 79,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"%{" => 100,
			"\@{" => 104,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84
		},
		GOTOS => {
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpression' => 245,
			'Expression' => 135,
			'Literal' => 111,
			'Variable' => 134,
			'ArrayReference' => 117,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'HashReference' => 94
		}
	},
	{#State 171
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			"\@{" => 104,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			'LPAREN' => 79,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'VARIABLE_SYMBOL' => 109,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118
		},
		GOTOS => {
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'Variable' => 134,
			'ArrayReference' => 117,
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 246,
			'Operator' => 122,
			'WordScoped' => 86
		}
	},
	{#State 172
		ACTIONS => {
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'LPAREN' => 79,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'SubExpression' => 247,
			'WordScoped' => 86,
			'Operator' => 122,
			'Literal' => 111,
			'Expression' => 135,
			'ArrayReference' => 117,
			'Variable' => 134,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80
		}
	},
	{#State 173
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'LPAREN' => 79,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 248,
			'WordScoped' => 86,
			'Operator' => 122,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'ArrayReference' => 117,
			'Variable' => 134
		}
	},
	{#State 174
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"%{" => 100,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 249,
			'WordScoped' => 86,
			'Operator' => 122,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'ArrayReference' => 117,
			'Variable' => 134
		}
	},
	{#State 175
		DEFAULT => -190
	},
	{#State 176
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 250
		}
	},
	{#State 177
		DEFAULT => -197
	},
	{#State 178
		ACTIONS => {
			'OP20_HASH_FATARROW' => 251
		}
	},
	{#State 179
		ACTIONS => {
			";" => 252
		}
	},
	{#State 180
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 253
		}
	},
	{#State 181
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'WORD' => 26,
			"\@{" => 104,
			'LPAREN' => 79,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 254,
			'Operator' => 122,
			'WordScoped' => 86,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'Variable' => 134,
			'ArrayReference' => 117
		}
	},
	{#State 182
		ACTIONS => {
			'WORD' => 255
		},
		GOTOS => {
			'PLUS-44' => 256
		}
	},
	{#State 183
		ACTIONS => {
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			";" => -177,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -177,
			'OP15_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 170,
			")" => -177,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP04_MATH_POW' => 174,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP21_LIST_COMMA' => -177,
			'OP13_BITWISE_AND' => 165
		}
	},
	{#State 184
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 257
		}
	},
	{#State 185
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP04_MATH_POW' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP21_LIST_COMMA' => -177,
			'OP16_LOGICAL_OR' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			")" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			";" => -79
		}
	},
	{#State 186
		ACTIONS => {
			'OP21_LIST_COMMA' => 258
		}
	},
	{#State 187
		ACTIONS => {
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => 160,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => 163,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			")" => 259,
			'OP09_BITWISE_SHIFT' => 170,
			'OP04_MATH_POW' => 174,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP13_BITWISE_AND' => 165,
			'OP12_COMPARE_EQ_NE' => 173
		}
	},
	{#State 188
		DEFAULT => -83
	},
	{#State 189
		ACTIONS => {
			'LBRACE' => 90
		},
		GOTOS => {
			'HashReference' => 260
		}
	},
	{#State 190
		ACTIONS => {
			"}" => 261
		}
	},
	{#State 191
		DEFAULT => -198
	},
	{#State 192
		DEFAULT => -204
	},
	{#State 193
		ACTIONS => {
			";" => 262
		}
	},
	{#State 194
		ACTIONS => {
			"filehandle_ref" => 263
		}
	},
	{#State 195
		DEFAULT => -183
	},
	{#State 196
		ACTIONS => {
			'LBRACKET' => 115
		},
		GOTOS => {
			'ArrayReference' => 264
		}
	},
	{#State 197
		ACTIONS => {
			"}" => 265
		}
	},
	{#State 198
		ACTIONS => {
			"\@{" => 104,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121
		},
		GOTOS => {
			'ArrayReference' => 117,
			'Variable' => 134,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'HashReference' => 94,
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 266,
			'Expression' => 135,
			'Literal' => 111
		}
	},
	{#State 199
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'STDIN' => 268,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'LPAREN' => 79,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 267,
			'SubExpressionOrStdin' => 269,
			'Operator' => 122,
			'WordScoped' => 86,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'Variable' => 134,
			'ArrayReference' => 117
		}
	},
	{#State 200
		ACTIONS => {
			'LPAREN' => 270
		}
	},
	{#State 201
		ACTIONS => {
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'LPAREN' => 79,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'Variable' => 134,
			'ArrayReference' => 117,
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 271,
			'Operator' => 122,
			'WordScoped' => 86
		}
	},
	{#State 202
		DEFAULT => -84
	},
	{#State 203
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			";" => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP08_STRING_CAT' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'COLON' => -163,
			"]" => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP02_HASH_THINARROW' => 274,
			'OP03_MATH_INC_DEC' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			")" => -163,
			'OP17_LIST_RANGE' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP02_ARRAY_THINARROW' => 273,
			'OP06_REGEX_MATCH' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP13_BITWISE_AND' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP04_MATH_POW' => -163,
			"}" => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP18_TERNARY' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 272
		}
	},
	{#State 204
		DEFAULT => -76
	},
	{#State 205
		DEFAULT => -82
	},
	{#State 206
		DEFAULT => -180
	},
	{#State 207
		ACTIONS => {
			"]" => 275
		}
	},
	{#State 208
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => -94,
			")" => -94,
			'OP09_BITWISE_SHIFT' => 170,
			'OP17_LIST_RANGE' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP06_REGEX_MATCH' => 164,
			'OP13_BITWISE_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			'OP04_MATH_POW' => 174,
			"}" => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			";" => -94,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP15_LOGICAL_AND' => -94,
			"]" => -94,
			'OP08_MATH_ADD_SUB' => 169
		}
	},
	{#State 209
		DEFAULT => -16
	},
	{#State 210
		ACTIONS => {
			")" => 276
		}
	},
	{#State 211
		ACTIONS => {
			'WORD_UPPERCASE' => 277
		}
	},
	{#State 212
		DEFAULT => -41
	},
	{#State 213
		ACTIONS => {
			'VARIABLE_SYMBOL' => 278
		}
	},
	{#State 214
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'LBRACKET' => 115,
			'OP01_NAMED_VOID_SCOLON' => 119,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 124,
			'LITERAL_NUMBER' => 121,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			'OP19_LOOP_CONTROL' => 101,
			"%{" => 100,
			"while" => -139,
			"if" => 105,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			'OP01_NAMED_VOID' => 91,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 95,
			"}" => 280,
			"for" => -139,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			"undef" => 99,
			"foreach" => -139,
			'WORD' => 26,
			'LPAREN' => 79,
			'OP01_PRINT' => 85,
			'OP05_LOGICAL_NEG' => 84,
			"my" => 83,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'Expression' => 110,
			'Literal' => 111,
			'WordScoped' => 86,
			'SubExpression' => 88,
			'Operation' => 279,
			'ArrayDereference' => 80,
			'OPTIONAL-35' => 81,
			'Conditional' => 102,
			'LoopLabel' => 82,
			'Variable' => 108,
			'OperatorVoid' => 106,
			'VariableModification' => 107,
			'VariableDeclaration' => 97,
			'Statement' => 123,
			'Operator' => 122,
			'HashDereference' => 114,
			'PAREN-34' => 93,
			'HashReference' => 94,
			'ArrayReference' => 117
		}
	},
	{#State 215
		DEFAULT => -55
	},
	{#State 216
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 281
		}
	},
	{#State 217
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 282
		}
	},
	{#State 218
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP01_QW' => 182,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'LPAREN' => 79,
			'WORD_SCOPED' => 25,
			"my" => 180,
			'OP05_LOGICAL_NEG' => 84
		},
		GOTOS => {
			'Variable' => 134,
			'ArrayReference' => 117,
			'TypeInner' => 181,
			'ArrayDereference' => 80,
			'ListElement' => 184,
			'HashDereference' => 114,
			'HashReference' => 94,
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpression' => 183,
			'Expression' => 135,
			'Literal' => 111,
			'ListElements' => 283
		}
	},
	{#State 219
		DEFAULT => -134
	},
	{#State 220
		ACTIONS => {
			'OP21_LIST_COMMA' => 284
		}
	},
	{#State 221
		ACTIONS => {
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'LPAREN' => 79,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'WORD' => 26,
			"\@{" => 104
		},
		GOTOS => {
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpression' => 285,
			'Expression' => 135,
			'Literal' => 111,
			'Variable' => 134,
			'ArrayReference' => 117,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'HashReference' => 94
		}
	},
	{#State 222
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 286
		}
	},
	{#State 223
		ACTIONS => {
			'TYPE_INTEGER' => 287
		}
	},
	{#State 224
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 289,
			";" => 288
		}
	},
	{#State 225
		ACTIONS => {
			'OP15_LOGICAL_AND' => -79,
			"]" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			";" => -79,
			'OP08_STRING_CAT' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP04_MATH_POW' => -79,
			"}" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			")" => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP06_REGEX_MATCH' => -79
		}
	},
	{#State 226
		ACTIONS => {
			";" => 290
		}
	},
	{#State 227
		ACTIONS => {
			";" => 291
		}
	},
	{#State 228
		DEFAULT => -125
	},
	{#State 229
		DEFAULT => -117
	},
	{#State 230
		ACTIONS => {
			")" => 292
		}
	},
	{#State 231
		ACTIONS => {
			";" => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP08_STRING_CAT' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			"]" => -89,
			'OP09_BITWISE_SHIFT' => -89,
			")" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP13_BITWISE_AND' => -89,
			"}" => -89,
			'OP04_MATH_POW' => 174,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP18_TERNARY' => -89
		}
	},
	{#State 232
		ACTIONS => {
			";" => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			")" => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP04_MATH_POW' => 174,
			"}" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP18_TERNARY' => -92
		}
	},
	{#State 233
		ACTIONS => {
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => 168,
			";" => -100,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP09_BITWISE_SHIFT' => 170,
			")" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP18_TERNARY' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			"}" => -100,
			'OP04_MATH_POW' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP21_LIST_COMMA' => -100
		}
	},
	{#State 234
		ACTIONS => {
			'OP23_LOGICAL_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			")" => -96,
			'OP09_BITWISE_SHIFT' => 170,
			'OP04_MATH_POW' => 174,
			"}" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP18_TERNARY' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			";" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			"]" => -96,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => -96
		}
	},
	{#State 235
		ACTIONS => {
			"}" => -90,
			'OP04_MATH_POW' => 174,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP18_TERNARY' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			")" => -90,
			'OP09_BITWISE_SHIFT' => -90,
			"]" => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => -90,
			";" => -90,
			'OP14_BITWISE_OR_XOR' => -90
		}
	},
	{#State 236
		ACTIONS => {
			"]" => -105,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => 160,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			";" => -105,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP04_MATH_POW' => 174,
			"}" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP18_TERNARY' => 167,
			'OP21_LIST_COMMA' => -105,
			'OP13_BITWISE_AND' => 165,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => -105,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			")" => -105,
			'OP09_BITWISE_SHIFT' => 170
		}
	},
	{#State 237
		DEFAULT => -88
	},
	{#State 238
		ACTIONS => {
			'OP15_LOGICAL_AND' => -98,
			"]" => -98,
			'OP08_MATH_ADD_SUB' => 169,
			";" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP21_LIST_COMMA' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP04_MATH_POW' => 174,
			"}" => -98,
			'OP18_TERNARY' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			")" => -98,
			'OP09_BITWISE_SHIFT' => 170,
			'OP23_LOGICAL_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => -98
		}
	},
	{#State 239
		ACTIONS => {
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -106,
			";" => -106,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP21_LIST_COMMA' => -106,
			'OP13_BITWISE_AND' => 165,
			'OP04_MATH_POW' => 174,
			"}" => -106,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 170,
			")" => -106,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => 163
		}
	},
	{#State 240
		DEFAULT => -210
	},
	{#State 241
		DEFAULT => -209
	},
	{#State 242
		ACTIONS => {
			'COLON' => 293
		}
	},
	{#State 243
		ACTIONS => {
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => -99,
			";" => -99,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP09_BITWISE_SHIFT' => 170,
			")" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP18_TERNARY' => -99,
			"}" => -99,
			'OP04_MATH_POW' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP21_LIST_COMMA' => -99
		}
	},
	{#State 244
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP13_BITWISE_AND' => -91,
			"}" => -91,
			'OP04_MATH_POW' => 174,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP18_TERNARY' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			")" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			"]" => -91,
			";" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => -91
		}
	},
	{#State 245
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -93,
			")" => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP04_MATH_POW' => 174,
			"}" => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP18_TERNARY' => -93,
			";" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP15_LOGICAL_AND' => -93,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -93
		}
	},
	{#State 246
		ACTIONS => {
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			";" => -102,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -102,
			'OP15_LOGICAL_AND' => 160,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP23_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 170,
			")" => -102,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP04_MATH_POW' => 174,
			"}" => -102,
			'OP18_TERNARY' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP21_LIST_COMMA' => -102,
			'OP13_BITWISE_AND' => 165
		}
	},
	{#State 247
		ACTIONS => {
			'OP16_LOGICAL_OR' => -101,
			'OP06_REGEX_MATCH' => 164,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP09_BITWISE_SHIFT' => 170,
			")" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => 174,
			"}" => -101,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP21_LIST_COMMA' => -101,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => 168,
			";" => -101,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -101,
			'OP15_LOGICAL_AND' => 160
		}
	},
	{#State 248
		ACTIONS => {
			'OP23_LOGICAL_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP06_REGEX_MATCH' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			")" => -97,
			'OP09_BITWISE_SHIFT' => 170,
			'OP18_TERNARY' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP04_MATH_POW' => 174,
			"}" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => -97,
			";" => -97,
			"]" => -97,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => -97
		}
	},
	{#State 249
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -85,
			")" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP18_TERNARY' => -85,
			'OP04_MATH_POW' => 174,
			"}" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			";" => -85,
			'OP08_STRING_CAT' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			"]" => -85
		}
	},
	{#State 250
		ACTIONS => {
			'OP21_LIST_COMMA' => 294,
			"}" => 295
		},
		GOTOS => {
			'PAREN-48' => 296
		}
	},
	{#State 251
		ACTIONS => {
			'WORD_SCOPED' => -188,
			"my" => 180,
			'OP05_LOGICAL_NEG' => -188,
			"%{" => -188,
			'WORD' => -188,
			'OP01_OPEN' => -188,
			"\@{" => -188,
			'LPAREN' => -188,
			'OP22_LOGICAL_NEG' => -188,
			'OP01_CLOSE' => -188,
			'VARIABLE_SYMBOL' => -188,
			'OP01_NAMED' => -188,
			'LBRACKET' => -188,
			'LITERAL_STRING' => -188,
			'LBRACE' => -188,
			"undef" => -188,
			'WORD_UPPERCASE' => -188,
			'LITERAL_NUMBER' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'OP10_NAMED_UNARY' => -188
		},
		GOTOS => {
			'TypeInner' => 298,
			'OPTIONAL-47' => 297
		}
	},
	{#State 252
		DEFAULT => -113
	},
	{#State 253
		ACTIONS => {
			"\$TYPED_" => 299
		}
	},
	{#State 254
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 170,
			")" => -178,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP17_LIST_RANGE' => 171,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP21_LIST_COMMA' => -178,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP04_MATH_POW' => 174,
			'OP14_BITWISE_OR_XOR' => 168,
			";" => -178,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -178
		}
	},
	{#State 255
		DEFAULT => -176
	},
	{#State 256
		ACTIONS => {
			'WORD' => 301,
			")" => 300
		}
	},
	{#State 257
		ACTIONS => {
			"]" => -174,
			'OP21_LIST_COMMA' => 303,
			")" => -174,
			";" => -174
		},
		GOTOS => {
			'PAREN-42' => 302
		}
	},
	{#State 258
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP01_QW' => 182,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"%{" => 100,
			"\@{" => 104,
			'LPAREN' => 79,
			"my" => 180,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115
		},
		GOTOS => {
			'Literal' => 111,
			'ListElements' => 304,
			'Expression' => 135,
			'SubExpression' => 183,
			'Operator' => 122,
			'WordScoped' => 86,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'ListElement' => 184,
			'TypeInner' => 181,
			'Variable' => 134,
			'ArrayReference' => 117
		}
	},
	{#State 259
		DEFAULT => -87
	},
	{#State 260
		ACTIONS => {
			"}" => 305
		}
	},
	{#State 261
		DEFAULT => -200
	},
	{#State 262
		DEFAULT => -116
	},
	{#State 263
		ACTIONS => {
			'FH_REF_SYMBOL' => 306
		}
	},
	{#State 264
		ACTIONS => {
			"}" => 307
		}
	},
	{#State 265
		DEFAULT => -185
	},
	{#State 266
		ACTIONS => {
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => 163,
			")" => 308,
			'OP09_BITWISE_SHIFT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP18_TERNARY' => 167,
			'OP04_MATH_POW' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => 160
		}
	},
	{#State 267
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP04_MATH_POW' => 174,
			'OP09_BITWISE_SHIFT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP17_LIST_RANGE' => 171,
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP14_BITWISE_OR_XOR' => 168,
			";" => -135,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158
		}
	},
	{#State 268
		DEFAULT => -136
	},
	{#State 269
		ACTIONS => {
			";" => 309
		}
	},
	{#State 270
		ACTIONS => {
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			")" => -120,
			'OP10_NAMED_UNARY' => 118,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'OP01_QW' => 182,
			'VARIABLE_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 84,
			"my" => 180,
			'WORD_SCOPED' => 25,
			"\@{" => 104,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			'LPAREN' => 79
		},
		GOTOS => {
			'TypeInner' => 181,
			'ArrayReference' => 117,
			'Variable' => 134,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ListElement' => 184,
			'ArrayDereference' => 80,
			'SubExpression' => 183,
			'OPTIONAL-33' => 311,
			'WordScoped' => 86,
			'Operator' => 122,
			'Literal' => 111,
			'ListElements' => 310,
			'Expression' => 135
		}
	},
	{#State 271
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP18_TERNARY' => 167,
			'OP04_MATH_POW' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => 160,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => 168,
			";" => 312
		}
	},
	{#State 272
		DEFAULT => -161
	},
	{#State 273
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'WORD' => 26,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112
		},
		GOTOS => {
			'SubExpression' => 313,
			'Operator' => 122,
			'WordScoped' => 86,
			'Literal' => 111,
			'Expression' => 135,
			'Variable' => 134,
			'ArrayReference' => 117,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80
		}
	},
	{#State 274
		ACTIONS => {
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			"\@{" => 104,
			'WORD' => 315,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'LPAREN' => 79,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 314,
			'WordScoped' => 86,
			'Operator' => 122,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'ArrayReference' => 117,
			'Variable' => 134
		}
	},
	{#State 275
		DEFAULT => -182
	},
	{#State 276
		DEFAULT => -123
	},
	{#State 277
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 316
		}
	},
	{#State 278
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 317
		}
	},
	{#State 279
		DEFAULT => -44
	},
	{#State 280
		ACTIONS => {
			";" => 318
		}
	},
	{#State 281
		ACTIONS => {
			"our" => 323,
			'LITERAL_NUMBER' => 319
		},
		GOTOS => {
			'MethodOrSubroutine' => 322,
			'Method' => 320,
			'Subroutine' => 321
		}
	},
	{#State 282
		ACTIONS => {
			'LBRACE' => 324
		}
	},
	{#State 283
		ACTIONS => {
			")" => 325
		}
	},
	{#State 284
		ACTIONS => {
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_QW' => 182,
			'VARIABLE_SYMBOL' => 109,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			"my" => 180,
			'LPAREN' => 79,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"%{" => 100,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92
		},
		GOTOS => {
			'Literal' => 111,
			'ListElements' => 326,
			'Expression' => 135,
			'SubExpression' => 183,
			'Operator' => 122,
			'WordScoped' => 86,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'ListElement' => 184,
			'TypeInner' => 181,
			'ArrayReference' => 117,
			'Variable' => 134
		}
	},
	{#State 285
		ACTIONS => {
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP13_BITWISE_AND' => 165,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP04_MATH_POW' => 174,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP09_BITWISE_SHIFT' => 170,
			")" => 327,
			'OP23_LOGICAL_AND' => 163,
			'OP17_LIST_RANGE' => 171,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172
		}
	},
	{#State 286
		ACTIONS => {
			'VARIABLE_SYMBOL' => 328
		}
	},
	{#State 287
		ACTIONS => {
			'VARIABLE_SYMBOL' => 329
		}
	},
	{#State 288
		DEFAULT => -167
	},
	{#State 289
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'STDIN' => 268,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			"\@{" => 104,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112
		},
		GOTOS => {
			'ArrayReference' => 117,
			'Variable' => 134,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'HashReference' => 94,
			'WordScoped' => 86,
			'Operator' => 122,
			'SubExpressionOrStdin' => 330,
			'SubExpression' => 267,
			'Expression' => 135,
			'Literal' => 111
		}
	},
	{#State 290
		DEFAULT => -110
	},
	{#State 291
		DEFAULT => -111
	},
	{#State 292
		DEFAULT => -122
	},
	{#State 293
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'VARIABLE_SYMBOL' => 109,
			'LITERAL_NUMBER' => 121
		},
		GOTOS => {
			'VariableOrLiteral' => 331,
			'Literal' => 240,
			'Variable' => 241
		}
	},
	{#State 294
		ACTIONS => {
			'WORD' => 178,
			"%{" => 100
		},
		GOTOS => {
			'HashDereference' => 175,
			'HashEntry' => 332
		}
	},
	{#State 295
		DEFAULT => -196
	},
	{#State 296
		DEFAULT => -194
	},
	{#State 297
		ACTIONS => {
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'LITERAL_NUMBER' => 121,
			"\@{" => 104,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112
		},
		GOTOS => {
			'SubExpression' => 333,
			'WordScoped' => 86,
			'Operator' => 122,
			'Literal' => 111,
			'Expression' => 135,
			'ArrayReference' => 117,
			'Variable' => 134,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114
		}
	},
	{#State 298
		DEFAULT => -187
	},
	{#State 299
		ACTIONS => {
			'WORD' => 334
		}
	},
	{#State 300
		DEFAULT => -179
	},
	{#State 301
		DEFAULT => -175
	},
	{#State 302
		DEFAULT => -172
	},
	{#State 303
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP10_NAMED_UNARY' => 118,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LITERAL_NUMBER' => 121,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'VARIABLE_SYMBOL' => 109,
			'OP01_QW' => 182,
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			"\@{" => 104,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			'LPAREN' => 79,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			"my" => 180
		},
		GOTOS => {
			'Variable' => 134,
			'ArrayReference' => 117,
			'TypeInner' => 181,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114,
			'ListElement' => 335,
			'SubExpression' => 183,
			'WordScoped' => 86,
			'Operator' => 122,
			'Literal' => 111,
			'Expression' => 135
		}
	},
	{#State 304
		ACTIONS => {
			";" => 336
		}
	},
	{#State 305
		DEFAULT => -201
	},
	{#State 306
		ACTIONS => {
			'OP21_LIST_COMMA' => 337
		}
	},
	{#State 307
		DEFAULT => -186
	},
	{#State 308
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 339
		}
	},
	{#State 309
		DEFAULT => -169
	},
	{#State 310
		DEFAULT => -119
	},
	{#State 311
		ACTIONS => {
			")" => 340
		}
	},
	{#State 312
		DEFAULT => -170
	},
	{#State 313
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 168,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP15_LOGICAL_AND' => 160,
			"]" => 341,
			'OP08_MATH_ADD_SUB' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP09_BITWISE_SHIFT' => 170,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => 163,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP13_BITWISE_AND' => 165,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP18_TERNARY' => 167,
			'OP04_MATH_POW' => 174
		}
	},
	{#State 314
		ACTIONS => {
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => 163,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP09_BITWISE_SHIFT' => 170,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP04_MATH_POW' => 174,
			"}" => 342,
			'OP13_BITWISE_AND' => 165,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => 160
		}
	},
	{#State 315
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -202,
			'LPAREN' => -202,
			"}" => 343
		}
	},
	{#State 316
		DEFAULT => -208
	},
	{#State 317
		ACTIONS => {
			'OP21_LIST_COMMA' => 345,
			")" => 344
		},
		GOTOS => {
			'PAREN-18' => 346
		}
	},
	{#State 318
		DEFAULT => -46
	},
	{#State 319
		ACTIONS => {
			";" => 347
		}
	},
	{#State 320
		DEFAULT => -74
	},
	{#State 321
		DEFAULT => -75
	},
	{#State 322
		DEFAULT => -57
	},
	{#State 323
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'TYPE_METHOD' => 348,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 324
		ACTIONS => {
			"}" => 351,
			"%{" => 100,
			'WORD' => 349
		},
		GOTOS => {
			'HashDereference' => 352,
			'HashEntryTyped' => 350
		}
	},
	{#State 325
		DEFAULT => -78
	},
	{#State 326
		ACTIONS => {
			")" => 353
		}
	},
	{#State 327
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 354
		}
	},
	{#State 328
		ACTIONS => {
			'LPAREN' => 355
		}
	},
	{#State 329
		ACTIONS => {
			'LPAREN' => 356
		}
	},
	{#State 330
		ACTIONS => {
			";" => 357
		}
	},
	{#State 331
		DEFAULT => -103
	},
	{#State 332
		DEFAULT => -193
	},
	{#State 333
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => 163,
			'OP17_LIST_RANGE' => 171,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP21_LIST_COMMA' => -189,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP18_TERNARY' => 167,
			'OP04_MATH_POW' => 174,
			"}" => -189,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169
		}
	},
	{#State 334
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358
		}
	},
	{#State 335
		DEFAULT => -171
	},
	{#State 336
		DEFAULT => -114
	},
	{#State 337
		ACTIONS => {
			'LITERAL_STRING' => 359
		}
	},
	{#State 338
		ACTIONS => {
			'LITERAL_NUMBER' => 121,
			"foreach" => -139,
			'WORD_UPPERCASE' => 124,
			"undef" => 99,
			'OP10_NAMED_UNARY' => 118,
			'OP01_NAMED_VOID_SCOLON' => 119,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'LBRACKET' => 115,
			"for" => -139,
			'OP01_NAMED' => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'LBRACE' => 90,
			'OP01_NAMED_VOID' => 91,
			'LITERAL_STRING' => 92,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109,
			"my" => 83,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			"if" => 105,
			'OP01_PRINT' => 85,
			"while" => -139,
			'LPAREN' => 79,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'OP19_LOOP_CONTROL' => 101,
			'WORD' => 26,
			"\@{" => 104
		},
		GOTOS => {
			'Operator' => 122,
			'Statement' => 123,
			'VariableDeclaration' => 97,
			'ArrayReference' => 117,
			'PAREN-34' => 93,
			'HashReference' => 94,
			'HashDereference' => 114,
			'SubExpression' => 88,
			'Operation' => 361,
			'WordScoped' => 86,
			'Literal' => 111,
			'Expression' => 110,
			'OperatorVoid' => 106,
			'VariableModification' => 107,
			'Variable' => 108,
			'LoopLabel' => 82,
			'Conditional' => 102,
			'OPTIONAL-35' => 81,
			'ArrayDereference' => 80,
			'PLUS-40' => 360
		}
	},
	{#State 339
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 362
		}
	},
	{#State 340
		DEFAULT => -124
	},
	{#State 341
		DEFAULT => -164
	},
	{#State 342
		DEFAULT => -165
	},
	{#State 343
		DEFAULT => -166
	},
	{#State 344
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 363
		}
	},
	{#State 345
		ACTIONS => {
			"my" => 364
		}
	},
	{#State 346
		DEFAULT => -48
	},
	{#State 347
		DEFAULT => -59
	},
	{#State 348
		ACTIONS => {
			'VARIABLE_SYMBOL' => 365
		}
	},
	{#State 349
		ACTIONS => {
			'OP20_HASH_FATARROW' => 366
		}
	},
	{#State 350
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 367
		}
	},
	{#State 351
		ACTIONS => {
			";" => 368
		}
	},
	{#State 352
		DEFAULT => -192
	},
	{#State 353
		DEFAULT => -80
	},
	{#State 354
		DEFAULT => -157
	},
	{#State 355
		ACTIONS => {
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 118,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LPAREN' => 79,
			'WORD' => 26,
			"%{" => 100,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			"my" => 180,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'OP01_QW' => 182,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'TypeInner' => 181,
			'Variable' => 134,
			'ArrayReference' => 117,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'ListElement' => 184,
			'SubExpression' => 183,
			'Operator' => 122,
			'WordScoped' => 86,
			'Literal' => 111,
			'ListElements' => 369,
			'Expression' => 135
		}
	},
	{#State 356
		ACTIONS => {
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'LPAREN' => 79,
			"\@{" => 104,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'SubExpression' => 370,
			'Operator' => 122,
			'WordScoped' => 86,
			'Literal' => 111,
			'Expression' => 135,
			'ArrayReference' => 117,
			'Variable' => 134,
			'HashReference' => 94,
			'ArrayDereference' => 80,
			'HashDereference' => 114
		}
	},
	{#State 357
		DEFAULT => -168
	},
	{#State 358
		DEFAULT => -207
	},
	{#State 359
		ACTIONS => {
			'OP21_LIST_COMMA' => 371
		}
	},
	{#State 360
		ACTIONS => {
			"undef" => 99,
			"foreach" => -139,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			"}" => 372,
			"for" => -139,
			'OP01_NAMED' => 95,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'OP01_NAMED_VOID' => 91,
			'OP22_LOGICAL_NEG' => 87,
			'OP05_LOGICAL_NEG' => 84,
			"my" => 83,
			'OP01_PRINT' => 85,
			'LPAREN' => 79,
			'WORD' => 26,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 124,
			'OP10_NAMED_UNARY' => 118,
			'OP01_NAMED_VOID_SCOLON' => 119,
			'LBRACKET' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'OP01_CLOSE' => 112,
			'VARIABLE_SYMBOL' => 109,
			"if" => 105,
			'WORD_SCOPED' => 25,
			"while" => -139,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			"%{" => 100,
			'OP19_LOOP_CONTROL' => 101
		},
		GOTOS => {
			'VariableDeclaration' => 97,
			'Statement' => 123,
			'Operator' => 122,
			'HashDereference' => 114,
			'HashReference' => 94,
			'PAREN-34' => 93,
			'ArrayReference' => 117,
			'Expression' => 110,
			'Literal' => 111,
			'WordScoped' => 86,
			'Operation' => 373,
			'SubExpression' => 88,
			'ArrayDereference' => 80,
			'LoopLabel' => 82,
			'Conditional' => 102,
			'OPTIONAL-35' => 81,
			'Variable' => 108,
			'OperatorVoid' => 106,
			'VariableModification' => 107
		}
	},
	{#State 361
		DEFAULT => -159
	},
	{#State 362
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP10_NAMED_UNARY' => -150,
			'LITERAL_NUMBER' => -150,
			'' => -150,
			'WORD_UPPERCASE' => -150,
			"else" => 376,
			'LBRACKET' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP01_CLOSE' => -150,
			"while" => -150,
			"\@{" => -150,
			'OP19_LOOP_CONTROL' => -150,
			"%{" => -150,
			'OP01_OPEN' => -150,
			"if" => -150,
			'WORD_SCOPED' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'OP03_MATH_INC_DEC' => -150,
			"undef" => -150,
			"foreach" => -150,
			'LBRACE' => -150,
			'OP01_NAMED_VOID' => -150,
			'LITERAL_STRING' => -150,
			"}" => -150,
			"for" => -150,
			'OP01_NAMED' => -150,
			"elsif" => 377,
			'OP22_LOGICAL_NEG' => -150,
			'LPAREN' => -150,
			'WORD' => -150,
			'OP05_LOGICAL_NEG' => -150,
			"my" => -150,
			'OP01_PRINT' => -150
		},
		GOTOS => {
			'PAREN-38' => 378,
			'PAREN-36' => 374,
			'OPTIONAL-39' => 375
		}
	},
	{#State 363
		ACTIONS => {
			"\@_;" => 379
		}
	},
	{#State 364
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 380
		}
	},
	{#State 365
		ACTIONS => {
			"= sub {" => 381
		}
	},
	{#State 366
		ACTIONS => {
			"my" => 180
		},
		GOTOS => {
			'TypeInner' => 382
		}
	},
	{#State 367
		ACTIONS => {
			"}" => 384,
			'OP21_LIST_COMMA' => 383
		},
		GOTOS => {
			'PAREN-24' => 385
		}
	},
	{#State 368
		DEFAULT => -64
	},
	{#State 369
		ACTIONS => {
			")" => 386
		}
	},
	{#State 370
		ACTIONS => {
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => 160,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP17_LIST_RANGE' => 387,
			'OP23_LOGICAL_AND' => 163,
			'OP09_BITWISE_SHIFT' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP04_MATH_POW' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165
		}
	},
	{#State 371
		ACTIONS => {
			'LPAREN' => 79,
			"\@{" => 104,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			"%{" => 100,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 136,
			"undef" => 99
		},
		GOTOS => {
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'Variable' => 134,
			'ArrayReference' => 117,
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 388,
			'Operator' => 122,
			'WordScoped' => 86
		}
	},
	{#State 372
		DEFAULT => -160
	},
	{#State 373
		DEFAULT => -158
	},
	{#State 374
		DEFAULT => -146
	},
	{#State 375
		DEFAULT => -151
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 377
		ACTIONS => {
			'LPAREN' => 390
		}
	},
	{#State 378
		DEFAULT => -149
	},
	{#State 379
		DEFAULT => -50
	},
	{#State 380
		ACTIONS => {
			'VARIABLE_SYMBOL' => 391
		}
	},
	{#State 381
		ACTIONS => {
			"if" => -66,
			'WORD_SCOPED' => -66,
			"while" => -66,
			"\@{" => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP01_OPEN' => -66,
			"%{" => -66,
			'OP01_CLOSE' => -66,
			'VARIABLE_SYMBOL' => -66,
			'LBRACKET' => -66,
			'LPAREN_MY' => 393,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'LITERAL_NUMBER' => -66,
			'WORD_UPPERCASE' => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP05_LOGICAL_NEG' => -66,
			"my" => -66,
			'OP01_PRINT' => -66,
			'LPAREN' => -66,
			'WORD' => -66,
			'OP22_LOGICAL_NEG' => -66,
			"}" => -66,
			"for" => -66,
			'OP01_NAMED' => -66,
			'LBRACE' => -66,
			'OP01_NAMED_VOID' => -66,
			'LITERAL_STRING' => -66,
			"undef" => -66,
			"foreach" => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP03_MATH_INC_DEC' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 394,
			'MethodArguments' => 392
		}
	},
	{#State 382
		ACTIONS => {
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			'WORD_UPPERCASE' => 136,
			"undef" => 99,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP05_LOGICAL_NEG' => 84,
			'WORD_SCOPED' => 25,
			'LPAREN' => 79,
			"\@{" => 104,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Expression' => 135,
			'Literal' => 111,
			'Operator' => 122,
			'WordScoped' => 86,
			'SubExpression' => 395,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'HashReference' => 94,
			'Variable' => 134,
			'ArrayReference' => 117
		}
	},
	{#State 383
		ACTIONS => {
			'WORD' => 349,
			"%{" => 100
		},
		GOTOS => {
			'HashEntryTyped' => 396,
			'HashDereference' => 352
		}
	},
	{#State 384
		ACTIONS => {
			";" => 397
		}
	},
	{#State 385
		DEFAULT => -61
	},
	{#State 386
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 398
		}
	},
	{#State 387
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 87,
			'OP01_CLOSE' => 112,
			'VARIABLE_SYMBOL' => 109,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'LPAREN' => 79,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'LITERAL_NUMBER' => 121,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			'OP10_NAMED_UNARY' => 118,
			'OP01_NAMED' => 150,
			'LBRACKET' => 115,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90
		},
		GOTOS => {
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 399,
			'WordScoped' => 86,
			'Operator' => 122,
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'ArrayReference' => 117,
			'Variable' => 134
		}
	},
	{#State 388
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 170,
			")" => -81,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP17_LIST_RANGE' => 171,
			'OP23_LOGICAL_AND' => -81,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP21_LIST_COMMA' => -81,
			'OP13_BITWISE_AND' => 165,
			'OP04_MATH_POW' => 174,
			"}" => -81,
			'OP18_TERNARY' => 167,
			'OP24_LOGICAL_OR_XOR' => -81,
			";" => -81,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -81
		}
	},
	{#State 389
		DEFAULT => -148
	},
	{#State 390
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 84,
			'LPAREN' => 79,
			"%{" => 100,
			'WORD' => 26,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			'OP01_CLOSE' => 112,
			'OP22_LOGICAL_NEG' => 87,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 115,
			'OP01_NAMED' => 150,
			'LBRACE' => 90,
			'LITERAL_STRING' => 92,
			'LITERAL_NUMBER' => 121,
			"undef" => 99,
			'WORD_UPPERCASE' => 136,
			'OP10_NAMED_UNARY' => 118,
			'OP03_MATH_INC_DEC' => 98,
			'OP05_MATH_NEG_LPAREN' => 96
		},
		GOTOS => {
			'HashReference' => 94,
			'HashDereference' => 114,
			'ArrayDereference' => 80,
			'Variable' => 134,
			'ArrayReference' => 117,
			'Literal' => 111,
			'Expression' => 135,
			'SubExpression' => 400,
			'Operator' => 122,
			'WordScoped' => 86
		}
	},
	{#State 391
		DEFAULT => -47
	},
	{#State 392
		DEFAULT => -65
	},
	{#State 393
		ACTIONS => {
			'TYPE_SELF' => 401
		}
	},
	{#State 394
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 402
		}
	},
	{#State 395
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP09_BITWISE_SHIFT' => 170,
			'OP23_LOGICAL_AND' => 163,
			'OP17_LIST_RANGE' => 171,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP21_LIST_COMMA' => -191,
			'OP13_BITWISE_AND' => 165,
			'OP12_COMPARE_EQ_NE' => 173,
			"}" => -191,
			'OP04_MATH_POW' => 174,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP18_TERNARY' => 167
		}
	},
	{#State 396
		DEFAULT => -60
	},
	{#State 397
		DEFAULT => -63
	},
	{#State 398
		DEFAULT => -156
	},
	{#State 399
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 169,
			'OP15_LOGICAL_AND' => 160,
			'OP08_STRING_CAT' => 159,
			'OP07_STRING_REPEAT' => 158,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP18_TERNARY' => -102,
			'OP04_MATH_POW' => 174,
			'OP13_BITWISE_AND' => 165,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP23_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 172,
			'OP06_REGEX_MATCH' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP11_COMPARE_LT_GT' => 161,
			")" => 403,
			'OP09_BITWISE_SHIFT' => 170
		}
	},
	{#State 400
		ACTIONS => {
			'OP15_LOGICAL_AND' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP14_BITWISE_OR_XOR' => 168,
			'OP07_STRING_REPEAT' => 158,
			'OP08_STRING_CAT' => 159,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP13_BITWISE_AND' => 165,
			'OP04_MATH_POW' => 174,
			'OP24_LOGICAL_OR_XOR' => 166,
			'OP18_TERNARY' => 167,
			'OP09_BITWISE_SHIFT' => 170,
			")" => 404,
			'OP11_COMPARE_LT_GT' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 162,
			'OP06_REGEX_MATCH' => 164,
			'OP16_LOGICAL_OR' => 172,
			'OP23_LOGICAL_AND' => 163,
			'OP17_LIST_RANGE' => 171
		}
	},
	{#State 401
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 405
		}
	},
	{#State 402
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 112,
			"%{" => 100,
			'OP19_LOOP_CONTROL' => 101,
			'OP01_OPEN' => 103,
			"\@{" => 104,
			"while" => -139,
			'WORD_SCOPED' => 25,
			"if" => 105,
			'OP10_NAMED_UNARY' => 118,
			'OP01_NAMED_VOID_SCOLON' => 119,
			'WORD_UPPERCASE' => 124,
			'LITERAL_NUMBER' => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'LBRACKET' => 115,
			'OP22_LOGICAL_NEG' => 87,
			'WORD' => 26,
			'LPAREN' => 79,
			'OP01_PRINT' => 85,
			"my" => 83,
			'OP05_LOGICAL_NEG' => 84,
			'OP05_MATH_NEG_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 98,
			"foreach" => -139,
			"undef" => 99,
			'OP01_NAMED_VOID' => 91,
			'LITERAL_STRING' => 92,
			'LBRACE' => 90,
			'OP01_NAMED' => 95,
			"for" => -139,
			"}" => 407
		},
		GOTOS => {
			'Statement' => 123,
			'Operator' => 122,
			'VariableDeclaration' => 97,
			'ArrayReference' => 117,
			'HashDereference' => 114,
			'PAREN-34' => 93,
			'HashReference' => 94,
			'WordScoped' => 86,
			'Operation' => 406,
			'SubExpression' => 88,
			'Expression' => 110,
			'Literal' => 111,
			'VariableModification' => 107,
			'OperatorVoid' => 106,
			'Variable' => 108,
			'ArrayDereference' => 80,
			'Conditional' => 102,
			'OPTIONAL-35' => 81,
			'LoopLabel' => 82
		}
	},
	{#State 403
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 408
		}
	},
	{#State 404
		ACTIONS => {
			'LBRACE' => 338
		},
		GOTOS => {
			'CodeBlock' => 409
		}
	},
	{#State 405
		ACTIONS => {
			")" => 411,
			'OP21_LIST_COMMA' => 410
		},
		GOTOS => {
			'PAREN-28' => 412
		}
	},
	{#State 406
		DEFAULT => -67
	},
	{#State 407
		ACTIONS => {
			";" => 413
		}
	},
	{#State 408
		DEFAULT => -155
	},
	{#State 409
		DEFAULT => -145
	},
	{#State 410
		ACTIONS => {
			"my" => 414
		}
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
		DEFAULT => -69
	},
	{#State 414
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 416
		}
	},
	{#State 415
		ACTIONS => {
			"\@_;" => 417
		}
	},
	{#State 416
		ACTIONS => {
			'VARIABLE_SYMBOL' => 418
		}
	},
	{#State 417
		DEFAULT => -73
	},
	{#State 418
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5728 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5735 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5742 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5749 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5760 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5771 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5778 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5785 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5792 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5799 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5806 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5813 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5866 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5880 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5913 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5920 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5927 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5934 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5941 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5948 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5955 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5980 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5991 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5998 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6005 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6016 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6052 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6063 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6070 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6077 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6084 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6091 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6102 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6109 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6116 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6123 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6134 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6141 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6155 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6162 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6169 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6201 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6222 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6244 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6251 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6272 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6283 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6290 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6297 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6304 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6326 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6337 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6348 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6359 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6370 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6381 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6403 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6414 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6645 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6678 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6685 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6692 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6699 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6710 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6721 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6732 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6743 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6754 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6790 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6815 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6826 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6837 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6859 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6870 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6881 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6892 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6903 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6994 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7001 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7023 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7034 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7063 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7070 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7077 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7084 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7091 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7098 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7109 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7120 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7142 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7164 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7175 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7182 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7200 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7214 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7225 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7236 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7247 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7302 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7309 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7323 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_174
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7334 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7341 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7348 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7388 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7395 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7406 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7413 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7420 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_185
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7431 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_186
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7442 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7449 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7456 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7478 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7489 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7507 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7514 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_196
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_197
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7543 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7550 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7557 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_200
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7568 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_201
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7579 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_202
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7590 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7601 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_204
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7612 lib/RPerl/Grammar.pm
	],
	[#Rule Type_205
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7623 lib/RPerl/Grammar.pm
	],
	[#Rule Type_206
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7634 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_207
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7645 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_208
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7656 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_209
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7667 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_210
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7678 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_211
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_212
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7700 lib/RPerl/Grammar.pm
	]
],
#line 7703 lib/RPerl/Grammar.pm
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
         'Literal_211', 
         'Literal_212', );
  $self;
}

#line 208 "lib/RPerl/Grammar.eyp"


{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run scripts/grammar_recompile.sh
# 3. Run new & existing grammar tests
# 4. Copy updates from Grammar.output file into this file, below this line only
# 5. Run scripts/grammar_recompile.sh again
our string__hash_ref $rules = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',  # Program
CompileUnit_5 => 'RPerl::CompileUnit::Module',  # PLUS-2
Program_18 => 'RPerl::CompileUnit::Program',  # SHEBANG OPTIONAL-3 Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
ModuleHeader_21 => 'RPerl::CompileUnit::Module::Header',  # OPTIONAL-9 'package' WordScoped ';' Header
Module_22 => 'RPerl::CompileUnit::Module::Package',  # Package
Module_23 => 'RPerl::CompileUnit::Module::Class::Generator',  # Class
Package_32 => 'RPerl::CompileUnit::Module::Package',  # STAR-10 STAR-11 STAR-12 PLUS-13 LITERAL_NUMBER ';'
Header_33 => 'RPerl::NonGenerator',  # 'use strict;' 'use warnings;' 'use RPerl;' 'our' VERSION_NUMBER_ASSIGN
Critic_36 => 'RPerl::CompileUnit::Critic',  # '## no critic qw(' PLUS-14 ')'
Include_39 => 'RPerl::NonGenerator',  # 'use' WordScoped ';'
Include_40 => 'RPerl::NonGenerator',  # 'use' WordScoped OP01_QW PLUS-15 ')' ';'
Constant_41 => 'RPerl::CompileUnit::Constant',  # 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_46 => 'RPerl::CodeBlock::Subroutine',  # 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_50 => 'RPerl::CodeBlock::Subroutine::Arguments',  # LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@_;'
Class_59 => 'RPerl::NonGenerator',  # 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_63 => 'RPerl::DataStructure::Hash::Properties',  # 'our hash_ref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryTyped STAR-25 '}' ';'
Properties_64 => 'RPerl::DataStructure::Hash::Properties',  # 'our hash_ref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_69 => 'RPerl::CodeBlock::Subroutine::Method',  # 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_73 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',  # LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_74 => 'RPerl::CodeBlock::Subroutine::Method',  # Method
MethodOrSubroutine_75 => 'RPerl::CodeBlock::Subroutine',  # Subroutine
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
SubExpression_128 => 'RPerl::Operation::Expression::SubExpression::Literal',
SubExpression_129 => 'RPerl::Operation::Expression::SubExpression::Variable',
SubExpression_130 => 'RPerl::DataStructure::Array::Reference',
SubExpression_131 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
SubExpression_132 => 'RPerl::DataStructure::Hash::Reference',
SubExpression_133 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
SubExpression_134 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',
SubExpressionOrStdin_135 => 'RPerl::Operation::Expression::SubExpression',
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
ListElements_174 => 'RPerl::DataStructure::Array::ListElements',
ListElement_177 => 'RPerl::Operation::Expression::SubExpression',
ListElement_178 => 'RPerl::Operation::Expression::SubExpression',
ListElement_179 => 'RPerl::Operation::Expression::Operator::List::QuotedWords',
ArrayReference_182 => 'RPerl::DataStructure::Array::Reference',
ArrayDereference_185 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
ArrayDereference_186 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
HashEntry_189 => 'RPerl::DataStructure::Hash::Entry',
HashEntry_190 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
HashEntryTyped_191 => 'RPerl::DataStructure::Hash::Entry',
HashEntryTyped_192 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
HashReference_196 => 'RPerl::DataStructure::Hash::Reference',
HashReference_197 => 'RPerl::DataStructure::Hash::Reference',
HashDereference_200 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
HashDereference_201 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
WordScoped_202 => 'RPerl::CompileUnit::Word',
WordScoped_203 => 'RPerl::CompileUnit::Word',
LoopLabel_204 => 'RPerl::CompileUnit::Word',
Type_205 => 'RPerl::DataType',
Type_206 => 'RPerl::DataType',
TypeInner_207 => 'RPerl::DataType',
TypeInnerConstant_208 => 'RPerl::DataType',
VariableOrLiteral_209 => 'RPerl::Operation::Expression::SubExpression::Variable',
VariableOrLiteral_210 => 'RPerl::Operation::Expression::SubExpression::Literal',
Literal_211 => 'RPerl::Operation::Expression::SubExpression::Literal',
Literal_212 => 'RPerl::Operation::Expression::SubExpression::Literal'
};

    1;
}

=for None

=cut


#line 8077 lib/RPerl/Grammar.pm



1;
