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

#line 1 "lib/RPerl/Grammar.eyp"

    use strict;
    use warnings;
    our $VERSION = 0.000_979;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|\=\ sub\ \{|package|foreach|\$TYPED_|undef|while|elsif|else|use|for|\@_\;|our|\%\{|my|if|\@\{|\}|\;|\)|\])}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
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
      /\G(sin|cos|push|pop|keys|values|ETC)\s/gc and return ('OP01_NAMED', $1);
      /\G([a-zA-Z]\w*[a-z]\w*|[a-z])/gc and return ('WORD', $1);
      /\G([A-Z][A-Z0-9_]*|[A-Z])/gc and return ('WORD_UPPERCASE', $1);
      /\G:/gc and return ('COLON', $1);
      /\G\(\s*my/gc and return ('LPAREN_MY', $1);
      /\G\(/gc and return ('LPAREN', $1);
      /\G\[/gc and return ('LBRACKET', $1);
      /\G\{/gc and return ('LBRACE', $1);


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
  [ '_PLUS_LIST' => 'PLUS-17', [ 'PLUS-17', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'Operation' ], 0 ],
  [ 'Subroutine_46' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-16', 'PLUS-17', '}', ';' ], 0 ],
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
  [ '_PLUS_LIST' => 'PLUS-27', [ 'PLUS-27', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-27', [ 'Operation' ], 0 ],
  [ 'Method_69' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-26', 'PLUS-27', '}', ';' ], 0 ],
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
  [ 'SubExpression_131' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
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
  [ 'ArrayDereferenced_183' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_184' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'HashEntry_187' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-46', 'SubExpression' ], 0 ],
  [ 'HashEntry_188' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_189' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_190' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ 'HashReference_194' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-48', '}' ], 0 ],
  [ 'HashReference_195' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ 'HashDereferenced_196' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_197' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_198' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_199' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_200' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_201' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_202' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_203' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_204' => 'TypeInnerConstant', [ 'my', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_205' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_206' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'Literal_207' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_208' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_PLUS_LIST' => 44,
  '_PLUS_LIST' => 45,
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
  '_PLUS_LIST' => 67,
  '_PLUS_LIST' => 68,
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
  'ArrayDereferenced_183' => 183,
  'ArrayDereferenced_184' => 184,
  '_OPTIONAL' => 185,
  '_OPTIONAL' => 186,
  'HashEntry_187' => 187,
  'HashEntry_188' => 188,
  'HashEntryTyped_189' => 189,
  'HashEntryTyped_190' => 190,
  '_PAREN' => 191,
  '_STAR_LIST' => 192,
  '_STAR_LIST' => 193,
  'HashReference_194' => 194,
  'HashReference_195' => 195,
  'HashDereferenced_196' => 196,
  'HashDereferenced_197' => 197,
  'WordScoped_198' => 198,
  'WordScoped_199' => 199,
  'LoopLabel_200' => 200,
  'Type_201' => 201,
  'Type_202' => 202,
  'TypeInner_203' => 203,
  'TypeInnerConstant_204' => 204,
  'VariableOrLiteral_205' => 205,
  'VariableOrLiteral_206' => 206,
  'Literal_207' => 207,
  'Literal_208' => 208,
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
			"package" => -20,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Program' => 8,
			'Critic' => 9,
			'OPTIONAL-9' => 7,
			'CompileUnit' => 3,
			'PAREN-1' => 4,
			'ModuleHeader' => 5,
			'PLUS-2' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 6,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'PAREN-1' => 10,
			'OPTIONAL-9' => 7,
			'Critic' => 9
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 6,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 11,
			'Critic' => 12
		}
	},
	{#State 3
		ACTIONS => {
			'' => 13
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			"use parent qw(" => 17,
			"## no critic qw(" => -25,
			"use constant" => -25,
			"use" => -25,
			"our" => -25
		},
		GOTOS => {
			'Module' => 16,
			'Class' => 18,
			'STAR-10' => 15,
			'Package' => 14
		}
	},
	{#State 6
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 7
		ACTIONS => {
			"package" => 21
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			"use strict;" => 23
		},
		GOTOS => {
			'Header' => 22
		}
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		ACTIONS => {
			"## no critic qw(" => 6,
			"use" => -27,
			"our" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'STAR-11' => 25,
			'Critic' => 24
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 18
		DEFAULT => -23
	},
	{#State 19
		ACTIONS => {
			'WORD' => 29,
			")" => 30
		}
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 32
		}
	},
	{#State 23
		ACTIONS => {
			"use warnings;" => 33
		}
	},
	{#State 24
		DEFAULT => -24
	},
	{#State 25
		ACTIONS => {
			"our" => -29,
			"use" => 34,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 36,
			'Include' => 35
		}
	},
	{#State 26
		DEFAULT => -199
	},
	{#State 27
		ACTIONS => {
			")" => 37
		}
	},
	{#State 28
		DEFAULT => -198
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
			"use" => -11,
			"my" => -11,
			"\@{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_CLOSE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LBRACE' => -11,
			'OP01_NAMED_VOID' => -11,
			"if" => -11,
			'OP01_NAMED' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"%{" => -11,
			'WORD_SCOPED' => -11,
			'OP01_PRINT' => -11,
			'LITERAL_STRING' => -11,
			"undef" => -11,
			'LBRACKET' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'WORD_UPPERCASE' => -11,
			"## no critic qw(" => 6,
			'VARIABLE_SYMBOL' => -11,
			"foreach" => -11,
			"while" => -11,
			'LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"use constant" => -11,
			"for" => -11,
			"our" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'WORD' => -11,
			'OP01_OPEN' => -11
		},
		GOTOS => {
			'Critic' => 40,
			'STAR-5' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use RPerl;" => 41
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 28
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
			"use constant" => 43,
			"our" => 45
		},
		GOTOS => {
			'PLUS-13' => 47,
			'Constant' => 46,
			'Subroutine' => 44
		}
	},
	{#State 37
		ACTIONS => {
			";" => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 23
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -13,
			"\@{" => -13,
			"use" => 34,
			"my" => -13,
			"undef" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LBRACKET' => -13,
			'WORD_UPPERCASE' => -13,
			'LITERAL_STRING' => -13,
			"if" => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'WORD_SCOPED' => -13,
			"%{" => -13,
			'OP01_PRINT' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACE' => -13,
			"foreach" => -13,
			"while" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'WORD' => -13,
			'OP01_OPEN' => -13,
			"our" => -13,
			'OP10_NAMED_UNARY' => -13,
			"for" => -13,
			'LPAREN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"use constant" => -13
		},
		GOTOS => {
			'Include' => 51,
			'STAR-6' => 50
		}
	},
	{#State 40
		DEFAULT => -8
	},
	{#State 41
		ACTIONS => {
			"our" => 52
		}
	},
	{#State 42
		ACTIONS => {
			";" => 53,
			'OP01_QW' => 54
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 44
		DEFAULT => -31
	},
	{#State 45
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 46
		DEFAULT => -28
	},
	{#State 47
		ACTIONS => {
			'LITERAL_NUMBER' => 59,
			"our" => 45
		},
		GOTOS => {
			'Subroutine' => 60
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
			'VARIABLE_SYMBOL' => -15,
			"while" => -15,
			"foreach" => -15,
			"for" => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LPAREN' => -15,
			"use constant" => 43,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_OPEN' => -15,
			'WORD' => -15,
			"our" => -15,
			'OP10_NAMED_UNARY' => -15,
			"\@{" => -15,
			"my" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED' => -15,
			"if" => -15,
			'OP01_PRINT' => -15,
			"%{" => -15,
			'WORD_SCOPED' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LBRACE' => -15,
			'OP01_CLOSE' => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			'LBRACKET' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LITERAL_STRING' => -15
		},
		GOTOS => {
			'STAR-7' => 62,
			'Constant' => 63
		}
	},
	{#State 51
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 64
		}
	},
	{#State 53
		DEFAULT => -39
	},
	{#State 54
		ACTIONS => {
			'WORD' => 66
		},
		GOTOS => {
			'PLUS-15' => 65
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 57
		DEFAULT => -202
	},
	{#State 58
		DEFAULT => -201
	},
	{#State 59
		ACTIONS => {
			";" => 69
		}
	},
	{#State 60
		DEFAULT => -30
	},
	{#State 61
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 70
		}
	},
	{#State 62
		ACTIONS => {
			'OP01_NAMED_VOID' => 81,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP01_PRINT' => 86,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_NAMED' => 89,
			"if" => 87,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 94,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			"undef" => 96,
			"my" => 71,
			"\@{" => 73,
			'OP19_LOOP_CONTROL' => 76,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			"for" => -139,
			'OP10_NAMED_UNARY' => 114,
			"our" => 45,
			'OP01_OPEN' => 115,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			'VARIABLE_SYMBOL' => 101,
			"while" => -139,
			"foreach" => -139
		},
		GOTOS => {
			'Literal' => 75,
			'PAREN-34' => 103,
			'ArrayReference' => 74,
			'Subroutine' => 102,
			'Statement' => 97,
			'LoopLabel' => 72,
			'VariableDeclaration' => 100,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'PLUS-8' => 91,
			'Conditional' => 113,
			'Operator' => 95,
			'OPTIONAL-35' => 83,
			'ArrayDereferenced' => 108,
			'SubExpression' => 107,
			'Expression' => 82,
			'Operation' => 77,
			'WordScoped' => 105,
			'Variable' => 112,
			'OperatorVoid' => 111,
			'VariableModification' => 110
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
			'WORD' => 117,
			")" => 118
		}
	},
	{#State 66
		DEFAULT => -38
	},
	{#State 67
		ACTIONS => {
			"my" => 120
		},
		GOTOS => {
			'TypeInnerConstant' => 119
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 121
		}
	},
	{#State 69
		DEFAULT => -32
	},
	{#State 70
		ACTIONS => {
			"our hash_ref \$properties" => -54,
			"## no critic qw(" => 6,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'STAR-21' => 123,
			'Critic' => 122
		}
	},
	{#State 71
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 124
		}
	},
	{#State 72
		ACTIONS => {
			'COLON' => 125
		}
	},
	{#State 73
		ACTIONS => {
			'LBRACKET' => 93,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Variable' => 126,
			'ArrayReference' => 127
		}
	},
	{#State 74
		DEFAULT => -130
	},
	{#State 75
		DEFAULT => -128
	},
	{#State 76
		ACTIONS => {
			'WORD_UPPERCASE' => 128
		},
		GOTOS => {
			'LoopLabel' => 129
		}
	},
	{#State 77
		DEFAULT => -17
	},
	{#State 78
		ACTIONS => {
			'FH_REF_SYMBOL' => 130
		}
	},
	{#State 79
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Variable' => 131
		}
	},
	{#State 80
		ACTIONS => {
			"}" => 134,
			"%{" => 85,
			'WORD' => 135
		},
		GOTOS => {
			'HashDereferenced' => 133,
			'HashEntry' => 132
		}
	},
	{#State 81
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP01_QW' => 136,
			"my" => 141,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'ListElements' => 144,
			'Operator' => 95,
			'TypeInner' => 140,
			'ArrayReference' => 74,
			'Literal' => 75,
			'HashReference' => 98,
			'ListElement' => 138,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'WordScoped' => 105,
			'Expression' => 142,
			'SubExpression' => 137,
			'ArrayDereferenced' => 108
		}
	},
	{#State 82
		ACTIONS => {
			'OP17_LIST_RANGE' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP18_TERNARY' => -126,
			'OP04_MATH_POW' => -126,
			'OP08_STRING_CAT' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			";" => 146,
			'OP06_REGEX_MATCH' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP07_STRING_REPEAT' => -126
		}
	},
	{#State 83
		ACTIONS => {
			"for" => 153,
			"while" => 152,
			"foreach" => 151
		},
		GOTOS => {
			'LoopFor' => 148,
			'LoopForEach' => 147,
			'Loop' => 149,
			'LoopWhile' => 150
		}
	},
	{#State 84
		DEFAULT => -208
	},
	{#State 85
		ACTIONS => {
			'LBRACE' => 80,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Variable' => 155,
			'HashReference' => 154
		}
	},
	{#State 86
		ACTIONS => {
			'OP01_QW' => -109,
			"my" => -109,
			'FH_REF_SYMBOL_BRACES' => 157,
			"\@{" => -109,
			'VARIABLE_SYMBOL' => -109,
			'LPAREN' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LITERAL_NUMBER' => -109,
			'OP01_CLOSE' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'LBRACE' => -109,
			'OP01_NAMED' => -109,
			'WORD_SCOPED' => -109,
			"%{" => -109,
			'STDOUT_STDERR' => 158,
			'LITERAL_STRING' => -109,
			'OP10_NAMED_UNARY' => -109,
			"undef" => -109,
			'OP05_LOGICAL_NEG' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'WORD' => -109,
			'LBRACKET' => -109,
			'OP01_OPEN' => -109,
			'WORD_UPPERCASE' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 159,
			'PAREN-30' => 156
		}
	},
	{#State 87
		ACTIONS => {
			'LPAREN' => 160
		}
	},
	{#State 88
		DEFAULT => -115
	},
	{#State 89
		ACTIONS => {
			"my" => 141,
			'OP01_QW' => 136,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'ArrayReference' => 74,
			'Literal' => 75,
			'TypeInner' => 140,
			'Operator' => 95,
			'WordScoped' => 105,
			'SubExpression' => 162,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'HashReference' => 98,
			'ListElement' => 161,
			'HashDereferenced' => 99,
			'Variable' => 139
		}
	},
	{#State 90
		DEFAULT => -207
	},
	{#State 91
		ACTIONS => {
			'OP01_NAMED' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"if" => 87,
			'OP01_PRINT' => 86,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'LITERAL_NUMBER' => 84,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED_VOID' => 81,
			'OP01_CLOSE' => 78,
			"undef" => 96,
			'WORD_UPPERCASE' => 94,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'LITERAL_STRING' => 90,
			"\@{" => 73,
			"my" => 71,
			'OP19_LOOP_CONTROL' => 76,
			"for" => -139,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 115,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 101,
			'' => -18,
			"while" => -139,
			"foreach" => -139
		},
		GOTOS => {
			'Literal' => 75,
			'PAREN-34' => 103,
			'ArrayReference' => 74,
			'VariableDeclaration' => 100,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'Statement' => 97,
			'LoopLabel' => 72,
			'Operator' => 95,
			'Conditional' => 113,
			'Variable' => 112,
			'OperatorVoid' => 111,
			'VariableModification' => 110,
			'ArrayDereferenced' => 108,
			'OPTIONAL-35' => 83,
			'Expression' => 82,
			'SubExpression' => 107,
			'Operation' => 163,
			'WordScoped' => 105
		}
	},
	{#State 92
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 164,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99
		}
	},
	{#State 93
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			"]" => -181,
			'OP01_QW' => 136,
			"my" => 141,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 74,
			'OPTIONAL-45' => 165,
			'Operator' => 95,
			'TypeInner' => 140,
			'ListElements' => 166,
			'ArrayDereferenced' => 108,
			'SubExpression' => 137,
			'Expression' => 142,
			'WordScoped' => 105,
			'Variable' => 139,
			'ListElement' => 138,
			'HashDereferenced' => 99,
			'HashReference' => 98
		}
	},
	{#State 94
		ACTIONS => {
			'LPAREN' => 167,
			'COLON' => -200
		}
	},
	{#State 95
		DEFAULT => -121
	},
	{#State 96
		DEFAULT => -127
	},
	{#State 97
		DEFAULT => -77
	},
	{#State 98
		DEFAULT => -132
	},
	{#State 99
		DEFAULT => -133
	},
	{#State 100
		DEFAULT => -143
	},
	{#State 101
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 168
		}
	},
	{#State 102
		DEFAULT => -14
	},
	{#State 103
		DEFAULT => -138
	},
	{#State 104
		DEFAULT => -112
	},
	{#State 105
		ACTIONS => {
			'LPAREN' => 170,
			'OP02_METHOD_THINARROW_NEW' => 169
		}
	},
	{#State 106
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_NAMED' => 173,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_PRINT' => 172
		},
		GOTOS => {
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 171,
			'Expression' => 142,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99
		}
	},
	{#State 107
		ACTIONS => {
			'OP16_LOGICAL_OR' => 179,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP08_STRING_CAT' => 181,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP06_REGEX_MATCH' => 184,
			'OP17_LIST_RANGE' => 188,
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175
		}
	},
	{#State 108
		DEFAULT => -131
	},
	{#State 109
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'OP01_CLOSE' => 78,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 106,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 191,
			'Expression' => 142,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99
		}
	},
	{#State 110
		DEFAULT => -144
	},
	{#State 111
		DEFAULT => -142
	},
	{#State 112
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 195,
			'OP07_STRING_REPEAT' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP18_TERNARY' => -129,
			'OP04_MATH_POW' => -129,
			'OP08_STRING_CAT' => -129,
			'OP19_VARIABLE_ASSIGN' => 194,
			'OP16_LOGICAL_OR' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP03_MATH_INC_DEC' => 192,
			'OP06_REGEX_MATCH' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP02_METHOD_THINARROW' => 193
		}
	},
	{#State 113
		DEFAULT => -140
	},
	{#State 114
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP21_LIST_COMMA' => -95,
			"]" => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP23_LOGICAL_AND' => -95,
			"}" => -95,
			'OP15_LOGICAL_AND' => -95,
			";" => -95,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'WORD' => 28,
			'OP17_LIST_RANGE' => -95,
			'OP01_OPEN' => 115,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			")" => -95,
			'OP18_TERNARY' => -95,
			"\@{" => 73,
			'OP11_COMPARE_LT_GT' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP13_BITWISE_AND' => -95,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP08_STRING_CAT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP01_NAMED' => 143,
			'OP01_CLOSE' => 78,
			'OP06_REGEX_MATCH' => -95,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP24_LOGICAL_OR_XOR' => -95,
			'LITERAL_NUMBER' => 84,
			'OP14_BITWISE_OR_XOR' => -95,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD_UPPERCASE' => 145,
			"undef" => 96,
			'LITERAL_STRING' => 90,
			'OP04_MATH_POW' => -95,
			'OP08_MATH_ADD_SUB' => -95
		},
		GOTOS => {
			'Expression' => 142,
			'SubExpression' => 196,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95
		}
	},
	{#State 115
		ACTIONS => {
			"my" => 197
		}
	},
	{#State 116
		ACTIONS => {
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'HashReference' => 98,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'WordScoped' => 105,
			'SubExpression' => 198,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75
		}
	},
	{#State 117
		DEFAULT => -37
	},
	{#State 118
		ACTIONS => {
			";" => 199
		}
	},
	{#State 119
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'Literal' => 200
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 201
		}
	},
	{#State 121
		ACTIONS => {
			'LITERAL_STRING' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LBRACKET' => -43,
			'WORD_UPPERCASE' => -43,
			"undef" => -43,
			'OP01_CLOSE' => -43,
			'LBRACE' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'LITERAL_NUMBER' => -43,
			"%{" => -43,
			'WORD_SCOPED' => -43,
			'OP01_PRINT' => -43,
			"if" => -43,
			'OP01_NAMED' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"my" => -43,
			"\@{" => -43,
			'OP10_NAMED_UNARY' => -43,
			'WORD' => -43,
			'OP01_OPEN' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'LPAREN_MY' => 203,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'LPAREN' => -43,
			'OP22_LOGICAL_NEG' => -43,
			"for" => -43,
			"foreach" => -43,
			"while" => -43,
			'VARIABLE_SYMBOL' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 204,
			'SubroutineArguments' => 202
		}
	},
	{#State 122
		DEFAULT => -51
	},
	{#State 123
		ACTIONS => {
			"use constant" => -56,
			"use" => 34,
			"our hash_ref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 205,
			'Include' => 206
		}
	},
	{#State 124
		ACTIONS => {
			'VARIABLE_SYMBOL' => 207
		}
	},
	{#State 125
		DEFAULT => -137
	},
	{#State 126
		ACTIONS => {
			"}" => 208
		}
	},
	{#State 127
		ACTIONS => {
			"}" => 209
		}
	},
	{#State 128
		DEFAULT => -200
	},
	{#State 129
		ACTIONS => {
			";" => 210
		}
	},
	{#State 130
		DEFAULT => -82
	},
	{#State 131
		DEFAULT => -83
	},
	{#State 132
		DEFAULT => -193,
		GOTOS => {
			'STAR-48' => 211
		}
	},
	{#State 133
		DEFAULT => -188
	},
	{#State 134
		DEFAULT => -195
	},
	{#State 135
		ACTIONS => {
			'OP20_HASH_FATARROW' => 212
		}
	},
	{#State 136
		ACTIONS => {
			'WORD' => 214
		},
		GOTOS => {
			'PLUS-44' => 213
		}
	},
	{#State 137
		ACTIONS => {
			'OP16_LOGICAL_OR' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP08_STRING_CAT' => 181,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => 182,
			";" => -177,
			'OP06_REGEX_MATCH' => 184,
			'OP17_LIST_RANGE' => 188,
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			'OP04_MATH_POW' => 178,
			")" => -177,
			"]" => -177,
			'OP21_LIST_COMMA' => -177,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175
		}
	},
	{#State 138
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 215
		}
	},
	{#State 139
		ACTIONS => {
			'OP17_LIST_RANGE' => -129,
			'OP04_MATH_POW' => -129,
			'OP18_TERNARY' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			")" => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP16_LOGICAL_OR' => -129,
			"}" => -129,
			'OP08_STRING_CAT' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP02_METHOD_THINARROW' => 193,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP03_MATH_INC_DEC' => 192,
			";" => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP07_STRING_REPEAT' => -129,
			"]" => -129,
			'OP21_LIST_COMMA' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP11_COMPARE_LT_GT' => -129
		}
	},
	{#State 140
		ACTIONS => {
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 216,
			'WordScoped' => 105
		}
	},
	{#State 141
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 217
		}
	},
	{#State 142
		DEFAULT => -126
	},
	{#State 143
		ACTIONS => {
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 78,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 218,
			'Expression' => 142,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99
		}
	},
	{#State 144
		ACTIONS => {
			";" => 219
		}
	},
	{#State 145
		ACTIONS => {
			'LPAREN' => 167
		}
	},
	{#State 146
		DEFAULT => -76
	},
	{#State 147
		DEFAULT => -153
	},
	{#State 148
		DEFAULT => -152
	},
	{#State 149
		DEFAULT => -141
	},
	{#State 150
		DEFAULT => -154
	},
	{#State 151
		ACTIONS => {
			"my" => 220
		}
	},
	{#State 152
		ACTIONS => {
			'LPAREN' => 221
		}
	},
	{#State 153
		ACTIONS => {
			"my" => 222
		}
	},
	{#State 154
		ACTIONS => {
			"}" => 223
		}
	},
	{#State 155
		ACTIONS => {
			"}" => 224
		}
	},
	{#State 156
		DEFAULT => -108
	},
	{#State 157
		ACTIONS => {
			'LPAREN' => 106,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			"my" => 141,
			'OP01_QW' => 136,
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 137,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'ListElement' => 138,
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95,
			'TypeInner' => 140,
			'ListElements' => 225
		}
	},
	{#State 158
		DEFAULT => -107
	},
	{#State 159
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP01_QW' => 136,
			"my" => 141,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95,
			'TypeInner' => 140,
			'ListElements' => 226,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 137,
			'WordScoped' => 105,
			'Variable' => 139,
			'ListElement' => 138,
			'HashDereferenced' => 99,
			'HashReference' => 98
		}
	},
	{#State 160
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 227,
			'Expression' => 142,
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75
		}
	},
	{#State 161
		ACTIONS => {
			'OP21_LIST_COMMA' => 228
		}
	},
	{#State 162
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP06_REGEX_MATCH' => -79,
			";" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP04_MATH_POW' => -79,
			'OP18_TERNARY' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			")" => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP21_LIST_COMMA' => -177,
			'OP11_COMPARE_LT_GT' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP13_BITWISE_AND' => -79
		}
	},
	{#State 163
		DEFAULT => -16
	},
	{#State 164
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			'OP17_LIST_RANGE' => 188,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			'OP04_MATH_POW' => 178,
			")" => 229,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP08_STRING_CAT' => 181,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP06_REGEX_MATCH' => 184
		}
	},
	{#State 165
		ACTIONS => {
			"]" => 230
		}
	},
	{#State 166
		DEFAULT => -180
	},
	{#State 167
		ACTIONS => {
			")" => 231
		}
	},
	{#State 168
		ACTIONS => {
			"]" => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP02_ARRAY_THINARROW' => 234,
			'OP11_COMPARE_LT_GT' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP23_LOGICAL_AND' => -163,
			'COLON' => -163,
			'OP13_BITWISE_AND' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP08_STRING_CAT' => -163,
			"}" => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			";" => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP02_HASH_THINARROW' => 233,
			'OP18_TERNARY' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP04_MATH_POW' => -163,
			")" => -163
		},
		GOTOS => {
			'VariableRetrieval' => 232
		}
	},
	{#State 169
		ACTIONS => {
			")" => 235
		}
	},
	{#State 170
		ACTIONS => {
			'OP01_QW' => 136,
			"my" => 141,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP10_NAMED_UNARY' => 114,
			")" => -118,
			'LITERAL_STRING' => 90,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143
		},
		GOTOS => {
			'HashReference' => 98,
			'HashDereferenced' => 99,
			'ListElement' => 138,
			'Variable' => 139,
			'WordScoped' => 105,
			'SubExpression' => 137,
			'Expression' => 142,
			'OPTIONAL-32' => 237,
			'ArrayDereferenced' => 108,
			'ListElements' => 236,
			'TypeInner' => 140,
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75
		}
	},
	{#State 171
		ACTIONS => {
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP08_STRING_CAT' => 181,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP06_REGEX_MATCH' => 184,
			'OP17_LIST_RANGE' => 188,
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			")" => 238
		}
	},
	{#State 172
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 239
		}
	},
	{#State 173
		ACTIONS => {
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			"my" => 141,
			'OP01_QW' => 136
		},
		GOTOS => {
			'WordScoped' => 105,
			'Expression' => 142,
			'SubExpression' => 162,
			'ArrayDereferenced' => 108,
			'HashReference' => 98,
			'ListElement' => 240,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95,
			'TypeInner' => 140
		}
	},
	{#State 174
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 241,
			'Expression' => 142
		}
	},
	{#State 175
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92
		},
		GOTOS => {
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 242,
			'WordScoped' => 105,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95
		}
	},
	{#State 176
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'WORD' => 28,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'HashDereferenced' => 99,
			'Variable' => 139,
			'HashReference' => 98,
			'Expression' => 142,
			'SubExpression' => 243,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105,
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74
		}
	},
	{#State 177
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'LPAREN' => 106,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96
		},
		GOTOS => {
			'HashDereferenced' => 99,
			'Variable' => 139,
			'HashReference' => 98,
			'SubExpression' => 244,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105,
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74
		}
	},
	{#State 178
		ACTIONS => {
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 245,
			'Expression' => 142,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95
		}
	},
	{#State 179
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143
		},
		GOTOS => {
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 246,
			'WordScoped' => 105,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95
		}
	},
	{#State 180
		ACTIONS => {
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'ArrayDereferenced' => 108,
			'SubExpression' => 247,
			'Expression' => 142,
			'WordScoped' => 105
		}
	},
	{#State 181
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'OP01_CLOSE' => 78,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Expression' => 142,
			'SubExpression' => 248,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95
		}
	},
	{#State 182
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75,
			'HashReference' => 98,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'WordScoped' => 105,
			'SubExpression' => 249,
			'Expression' => 142,
			'ArrayDereferenced' => 108
		}
	},
	{#State 183
		ACTIONS => {
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'ArrayDereferenced' => 108,
			'SubExpression' => 250,
			'Expression' => 142,
			'WordScoped' => 105,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95
		}
	},
	{#State 184
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 251
		}
	},
	{#State 185
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92
		},
		GOTOS => {
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'ArrayDereferenced' => 108,
			'SubExpression' => 252,
			'Expression' => 142,
			'WordScoped' => 105
		}
	},
	{#State 186
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'ArrayDereferenced' => 108,
			'SubExpression' => 253,
			'Expression' => 142,
			'WordScoped' => 105,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95
		}
	},
	{#State 187
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LPAREN' => 106,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'ArrayDereferenced' => 108,
			'SubExpression' => 254,
			'Expression' => 142,
			'WordScoped' => 105,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95
		}
	},
	{#State 188
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96
		},
		GOTOS => {
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 255,
			'Expression' => 142
		}
	},
	{#State 189
		ACTIONS => {
			'LITERAL_STRING' => 90,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'VariableOrLiteral' => 258,
			'Variable' => 256,
			'Literal' => 257
		}
	},
	{#State 190
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'HashReference' => 98,
			'SubExpression' => 259,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105
		}
	},
	{#State 191
		ACTIONS => {
			'OP17_LIST_RANGE' => 188,
			")" => -104,
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			'OP04_MATH_POW' => 178,
			'OP08_STRING_CAT' => 181,
			"}" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			";" => -104,
			'OP06_REGEX_MATCH' => 184,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP09_BITWISE_SHIFT' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP07_STRING_REPEAT' => 186
		}
	},
	{#State 192
		DEFAULT => -84
	},
	{#State 193
		ACTIONS => {
			'LPAREN' => 260
		}
	},
	{#State 194
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'STDIN' => 263,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'WordScoped' => 105,
			'SubExpression' => 262,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'HashReference' => 98,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95,
			'SubExpressionOrStdin' => 261
		}
	},
	{#State 195
		ACTIONS => {
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'WordScoped' => 105,
			'SubExpression' => 264,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'HashReference' => 98,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95
		}
	},
	{#State 196
		ACTIONS => {
			'OP15_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"}" => -94,
			'OP08_STRING_CAT' => 181,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP06_REGEX_MATCH' => 184,
			";" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => -94,
			'OP08_MATH_ADD_SUB' => 177,
			")" => -94,
			"]" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => -94,
			'OP13_BITWISE_AND' => -94
		}
	},
	{#State 197
		ACTIONS => {
			"filehandle_ref" => 265
		}
	},
	{#State 198
		ACTIONS => {
			'OP06_REGEX_MATCH' => -86,
			";" => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			"}" => -86,
			'OP08_STRING_CAT' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			")" => -86,
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => -86,
			'OP18_TERNARY' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			"]" => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP09_BITWISE_SHIFT' => -86
		}
	},
	{#State 199
		DEFAULT => -40
	},
	{#State 200
		ACTIONS => {
			";" => 266
		}
	},
	{#State 201
		ACTIONS => {
			"\$TYPED_" => 267
		}
	},
	{#State 202
		DEFAULT => -42
	},
	{#State 203
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 204
		ACTIONS => {
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD_UPPERCASE' => 94,
			'OP01_OPEN' => 115,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_PRINT' => 86,
			"for" => -139,
			"if" => 87,
			'OP01_NAMED' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_CLOSE' => 78,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED_VOID' => 81,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'OP19_LOOP_CONTROL' => 76,
			"foreach" => -139,
			"while" => -139,
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			"my" => 71
		},
		GOTOS => {
			'Variable' => 112,
			'OperatorVoid' => 111,
			'VariableModification' => 110,
			'OPTIONAL-35' => 83,
			'ArrayDereferenced' => 108,
			'Expression' => 82,
			'SubExpression' => 107,
			'Operation' => 270,
			'WordScoped' => 105,
			'Operator' => 95,
			'Conditional' => 113,
			'VariableDeclaration' => 100,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'Statement' => 97,
			'LoopLabel' => 72,
			'PLUS-17' => 269,
			'Literal' => 75,
			'PAREN-34' => 103,
			'ArrayReference' => 74
		}
	},
	{#State 205
		ACTIONS => {
			"use constant" => 43,
			"our hash_ref \$properties" => 273
		},
		GOTOS => {
			'Properties' => 271,
			'Constant' => 272
		}
	},
	{#State 206
		DEFAULT => -53
	},
	{#State 207
		ACTIONS => {
			";" => 274,
			'OP19_VARIABLE_ASSIGN' => 275
		}
	},
	{#State 208
		DEFAULT => -183
	},
	{#State 209
		DEFAULT => -184
	},
	{#State 210
		DEFAULT => -116
	},
	{#State 211
		ACTIONS => {
			'OP21_LIST_COMMA' => 278,
			"}" => 277
		},
		GOTOS => {
			'PAREN-47' => 276
		}
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => -186,
			"\@{" => -186,
			"my" => 141,
			'OP05_LOGICAL_NEG' => -186,
			"undef" => -186,
			'WORD_UPPERCASE' => -186,
			'OP01_OPEN' => -186,
			'LBRACKET' => -186,
			'WORD' => -186,
			'OP05_MATH_NEG_LPAREN' => -186,
			'OP10_NAMED_UNARY' => -186,
			'LITERAL_STRING' => -186,
			'OP01_NAMED' => -186,
			"%{" => -186,
			'WORD_SCOPED' => -186,
			'LITERAL_NUMBER' => -186,
			'OP22_LOGICAL_NEG' => -186,
			'LPAREN' => -186,
			'OP03_MATH_INC_DEC' => -186,
			'LBRACE' => -186,
			'OP01_CLOSE' => -186
		},
		GOTOS => {
			'TypeInner' => 279,
			'OPTIONAL-46' => 280
		}
	},
	{#State 213
		ACTIONS => {
			'WORD' => 281,
			")" => 282
		}
	},
	{#State 214
		DEFAULT => -176
	},
	{#State 215
		ACTIONS => {
			")" => -174,
			";" => -174,
			"]" => -174,
			'OP21_LIST_COMMA' => 284
		},
		GOTOS => {
			'PAREN-42' => 283
		}
	},
	{#State 216
		ACTIONS => {
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			")" => -178,
			'OP17_LIST_RANGE' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP06_REGEX_MATCH' => 184,
			";" => -178,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 181,
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175,
			'OP09_BITWISE_SHIFT' => 174,
			'OP07_STRING_REPEAT' => 186,
			"]" => -178,
			'OP21_LIST_COMMA' => -178,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176
		}
	},
	{#State 217
		ACTIONS => {
			"\$TYPED_" => 285
		}
	},
	{#State 218
		ACTIONS => {
			'OP16_LOGICAL_OR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			"}" => -79,
			'OP08_STRING_CAT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP06_REGEX_MATCH' => -79,
			";" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP04_MATH_POW' => -79,
			'OP18_TERNARY' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			")" => -79,
			'OP21_LIST_COMMA' => -79,
			"]" => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP13_BITWISE_AND' => -79
		}
	},
	{#State 219
		DEFAULT => -113
	},
	{#State 220
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 286
		}
	},
	{#State 221
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'ArrayDereferenced' => 108,
			'SubExpression' => 287,
			'Expression' => 142,
			'WordScoped' => 105,
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74
		}
	},
	{#State 222
		ACTIONS => {
			'TYPE_INTEGER' => 288
		}
	},
	{#State 223
		DEFAULT => -197
	},
	{#State 224
		DEFAULT => -196
	},
	{#State 225
		ACTIONS => {
			";" => 289
		}
	},
	{#State 226
		ACTIONS => {
			";" => 290
		}
	},
	{#State 227
		ACTIONS => {
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175,
			'OP09_BITWISE_SHIFT' => 174,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			'OP04_MATH_POW' => 178,
			")" => 291,
			'OP17_LIST_RANGE' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP06_REGEX_MATCH' => 184,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 181
		}
	},
	{#State 228
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP01_QW' => 136,
			"my" => 141,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 137,
			'WordScoped' => 105,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'ListElement' => 138,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'TypeInner' => 140,
			'Operator' => 95,
			'ListElements' => 292
		}
	},
	{#State 229
		DEFAULT => -87
	},
	{#State 230
		DEFAULT => -182
	},
	{#State 231
		DEFAULT => -123
	},
	{#State 232
		DEFAULT => -161
	},
	{#State 233
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'WORD' => 293,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143
		},
		GOTOS => {
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 294,
			'Expression' => 142,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95
		}
	},
	{#State 234
		ACTIONS => {
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'SubExpression' => 295,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95
		}
	},
	{#State 235
		DEFAULT => -125
	},
	{#State 236
		DEFAULT => -117
	},
	{#State 237
		ACTIONS => {
			")" => 296
		}
	},
	{#State 238
		DEFAULT => -134
	},
	{#State 239
		ACTIONS => {
			"my" => 141,
			'OP01_QW' => 136,
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'LPAREN' => 106,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'OP01_CLOSE' => 78,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85
		},
		GOTOS => {
			'SubExpression' => 137,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105,
			'HashDereferenced' => 99,
			'ListElement' => 138,
			'Variable' => 139,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'ListElements' => 297,
			'TypeInner' => 140,
			'Operator' => 95
		}
	},
	{#State 240
		ACTIONS => {
			'OP21_LIST_COMMA' => 298
		}
	},
	{#State 241
		ACTIONS => {
			'OP17_LIST_RANGE' => -93,
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => -93,
			")" => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"}" => -93,
			'OP08_STRING_CAT' => 181,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP06_REGEX_MATCH' => 184,
			";" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP07_STRING_REPEAT' => 186,
			"]" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP12_COMPARE_EQ_NE' => -93
		}
	},
	{#State 242
		ACTIONS => {
			'OP15_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP16_LOGICAL_OR' => -98,
			"}" => -98,
			'OP08_STRING_CAT' => 181,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP06_REGEX_MATCH' => 184,
			";" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => -98,
			")" => -98,
			"]" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => -98,
			'OP13_BITWISE_AND' => -98
		}
	},
	{#State 243
		ACTIONS => {
			"]" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => undef,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"}" => -96,
			'OP08_STRING_CAT' => 181,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			";" => -96,
			'OP06_REGEX_MATCH' => 184,
			'OP17_LIST_RANGE' => -96,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => -96,
			'OP04_MATH_POW' => 178,
			")" => -96
		}
	},
	{#State 244
		ACTIONS => {
			"]" => -91,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"}" => -91,
			'OP08_STRING_CAT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			";" => -91,
			'OP06_REGEX_MATCH' => 184,
			'OP17_LIST_RANGE' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP18_TERNARY' => -91,
			'OP04_MATH_POW' => 178,
			")" => -91
		}
	},
	{#State 245
		ACTIONS => {
			'OP08_STRING_CAT' => -85,
			"}" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			";" => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP17_LIST_RANGE' => -85,
			")" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP18_TERNARY' => -85,
			'OP04_MATH_POW' => 178,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP21_LIST_COMMA' => -85,
			"]" => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP23_LOGICAL_AND' => -85
		}
	},
	{#State 246
		ACTIONS => {
			'OP17_LIST_RANGE' => -101,
			")" => -101,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => 178,
			'OP08_STRING_CAT' => 181,
			"}" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			";" => -101,
			'OP06_REGEX_MATCH' => 184,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP09_BITWISE_SHIFT' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP07_STRING_REPEAT' => 186,
			"]" => -101,
			'OP21_LIST_COMMA' => -101
		}
	},
	{#State 247
		ACTIONS => {
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => -90,
			'OP18_TERNARY' => -90,
			")" => -90,
			'OP17_LIST_RANGE' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP06_REGEX_MATCH' => 184,
			";" => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP08_STRING_CAT' => -90,
			"}" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			"]" => -90,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP12_COMPARE_EQ_NE' => -90
		}
	},
	{#State 248
		ACTIONS => {
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => -92,
			'OP08_MATH_ADD_SUB' => 177,
			")" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP06_REGEX_MATCH' => 184,
			";" => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP08_STRING_CAT' => -92,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP07_STRING_REPEAT' => 186,
			"]" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP12_COMPARE_EQ_NE' => -92
		}
	},
	{#State 249
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			'OP21_LIST_COMMA' => -106,
			"]" => -106,
			'OP07_STRING_REPEAT' => 186,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 174,
			";" => -106,
			'OP06_REGEX_MATCH' => 184,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => 183,
			"}" => -106,
			'OP08_STRING_CAT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			")" => -106,
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			'OP04_MATH_POW' => 178,
			'OP17_LIST_RANGE' => 188
		}
	},
	{#State 250
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => -99,
			'OP13_BITWISE_AND' => 175,
			'OP21_LIST_COMMA' => -99,
			"]" => -99,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP17_LIST_RANGE' => -99,
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => -99,
			")" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			"}" => -99,
			'OP08_STRING_CAT' => 181,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => 184,
			";" => -99
		}
	},
	{#State 251
		DEFAULT => -88
	},
	{#State 252
		ACTIONS => {
			")" => -105,
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			'OP17_LIST_RANGE' => 188,
			'OP06_REGEX_MATCH' => 184,
			";" => -105,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => -105,
			"}" => -105,
			'OP08_STRING_CAT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => -105,
			'OP09_BITWISE_SHIFT' => 174,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP07_STRING_REPEAT' => 186
		}
	},
	{#State 253
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP07_STRING_REPEAT' => -89,
			"]" => -89,
			'OP21_LIST_COMMA' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP08_STRING_CAT' => -89,
			"}" => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP06_REGEX_MATCH' => 184,
			";" => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP17_LIST_RANGE' => -89,
			")" => -89,
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => -89,
			'OP08_MATH_ADD_SUB' => -89
		}
	},
	{#State 254
		ACTIONS => {
			"]" => -97,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP11_COMPARE_LT_GT' => 176,
			'OP23_LOGICAL_AND' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP09_BITWISE_SHIFT' => 174,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP06_REGEX_MATCH' => 184,
			";" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP08_STRING_CAT' => 181,
			"}" => -97,
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => -97,
			'OP08_MATH_ADD_SUB' => 177,
			")" => -97,
			'OP17_LIST_RANGE' => -97
		}
	},
	{#State 255
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => -102,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			"]" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP07_STRING_REPEAT' => 186,
			'OP17_LIST_RANGE' => undef,
			")" => -102,
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 177,
			'OP08_STRING_CAT' => 181,
			"}" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP15_LOGICAL_AND' => 190,
			'OP06_REGEX_MATCH' => 184,
			";" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP14_BITWISE_OR_XOR' => 183
		}
	},
	{#State 256
		DEFAULT => -205
	},
	{#State 257
		DEFAULT => -206
	},
	{#State 258
		ACTIONS => {
			'COLON' => 299
		}
	},
	{#State 259
		ACTIONS => {
			'OP15_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"}" => -100,
			'OP08_STRING_CAT' => 181,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP14_BITWISE_OR_XOR' => 183,
			";" => -100,
			'OP06_REGEX_MATCH' => 184,
			'OP17_LIST_RANGE' => -100,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => -100,
			'OP04_MATH_POW' => 178,
			")" => -100,
			"]" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => 175
		}
	},
	{#State 260
		ACTIONS => {
			'OP01_QW' => 136,
			"my" => 141,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			")" => -120,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92
		},
		GOTOS => {
			'ArrayDereferenced' => 108,
			'SubExpression' => 137,
			'Expression' => 142,
			'OPTIONAL-33' => 301,
			'WordScoped' => 105,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'ListElement' => 138,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95,
			'TypeInner' => 140,
			'ListElements' => 300
		}
	},
	{#State 261
		ACTIONS => {
			";" => 302
		}
	},
	{#State 262
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP09_BITWISE_SHIFT' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => 185,
			'OP08_STRING_CAT' => 181,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP06_REGEX_MATCH' => 184,
			";" => -135,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP17_LIST_RANGE' => 188,
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189
		}
	},
	{#State 263
		DEFAULT => -136
	},
	{#State 264
		ACTIONS => {
			'OP06_REGEX_MATCH' => 184,
			";" => 303,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP08_STRING_CAT' => 181,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			'OP17_LIST_RANGE' => 188,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			'OP07_STRING_REPEAT' => 186,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 174
		}
	},
	{#State 265
		ACTIONS => {
			'FH_REF_SYMBOL' => 304
		}
	},
	{#State 266
		DEFAULT => -41
	},
	{#State 267
		ACTIONS => {
			'WORD_UPPERCASE' => 305
		}
	},
	{#State 268
		ACTIONS => {
			'VARIABLE_SYMBOL' => 306
		}
	},
	{#State 269
		ACTIONS => {
			'OP01_PRINT' => 86,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_NAMED' => 89,
			"if" => 87,
			'OP01_NAMED_VOID' => 81,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'WORD_UPPERCASE' => 94,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			"undef" => 96,
			'LITERAL_STRING' => 90,
			"\@{" => 73,
			"my" => 71,
			'OP19_LOOP_CONTROL' => 76,
			"}" => 308,
			"for" => -139,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP01_OPEN' => 115,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 101,
			"while" => -139,
			"foreach" => -139
		},
		GOTOS => {
			'Variable' => 112,
			'OperatorVoid' => 111,
			'VariableModification' => 110,
			'OPTIONAL-35' => 83,
			'ArrayDereferenced' => 108,
			'Expression' => 82,
			'SubExpression' => 107,
			'WordScoped' => 105,
			'Operation' => 307,
			'Operator' => 95,
			'Conditional' => 113,
			'VariableDeclaration' => 100,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'Statement' => 97,
			'LoopLabel' => 72,
			'Literal' => 75,
			'PAREN-34' => 103,
			'ArrayReference' => 74
		}
	},
	{#State 270
		DEFAULT => -45
	},
	{#State 271
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 309
		}
	},
	{#State 272
		DEFAULT => -55
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 310
		}
	},
	{#State 274
		DEFAULT => -167
	},
	{#State 275
		ACTIONS => {
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'LPAREN' => 106,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'STDIN' => 263,
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'ArrayDereferenced' => 108,
			'SubExpression' => 262,
			'Expression' => 142,
			'WordScoped' => 105,
			'Operator' => 95,
			'SubExpressionOrStdin' => 311,
			'Literal' => 75,
			'ArrayReference' => 74
		}
	},
	{#State 276
		DEFAULT => -192
	},
	{#State 277
		DEFAULT => -194
	},
	{#State 278
		ACTIONS => {
			'WORD' => 135,
			"%{" => 85
		},
		GOTOS => {
			'HashEntry' => 312,
			'HashDereferenced' => 133
		}
	},
	{#State 279
		DEFAULT => -185
	},
	{#State 280
		ACTIONS => {
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'HashReference' => 98,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'WordScoped' => 105,
			'SubExpression' => 313,
			'Expression' => 142,
			'ArrayDereferenced' => 108,
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75
		}
	},
	{#State 281
		DEFAULT => -175
	},
	{#State 282
		DEFAULT => -179
	},
	{#State 283
		DEFAULT => -172
	},
	{#State 284
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'OP01_QW' => 136,
			"my" => 141,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'LPAREN' => 106,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114
		},
		GOTOS => {
			'TypeInner' => 140,
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74,
			'Variable' => 139,
			'ListElement' => 314,
			'HashDereferenced' => 99,
			'HashReference' => 98,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 137,
			'WordScoped' => 105
		}
	},
	{#State 285
		ACTIONS => {
			'WORD' => 315
		}
	},
	{#State 286
		ACTIONS => {
			'VARIABLE_SYMBOL' => 316
		}
	},
	{#State 287
		ACTIONS => {
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			'OP04_MATH_POW' => 178,
			")" => 317,
			'OP17_LIST_RANGE' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP06_REGEX_MATCH' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 181,
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175,
			'OP09_BITWISE_SHIFT' => 174,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187
		}
	},
	{#State 288
		ACTIONS => {
			'VARIABLE_SYMBOL' => 318
		}
	},
	{#State 289
		DEFAULT => -111
	},
	{#State 290
		DEFAULT => -110
	},
	{#State 291
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 319
		}
	},
	{#State 292
		ACTIONS => {
			";" => 321
		}
	},
	{#State 293
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -198,
			"}" => 322,
			'LPAREN' => -198
		}
	},
	{#State 294
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP06_REGEX_MATCH' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 181,
			"}" => 323,
			'OP04_MATH_POW' => 178,
			'OP18_TERNARY' => 189,
			'OP08_MATH_ADD_SUB' => 177,
			'OP17_LIST_RANGE' => 188,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175,
			'OP09_BITWISE_SHIFT' => 174
		}
	},
	{#State 295
		ACTIONS => {
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175,
			'OP09_BITWISE_SHIFT' => 174,
			"]" => 324,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			'OP04_MATH_POW' => 178,
			'OP17_LIST_RANGE' => 188,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP06_REGEX_MATCH' => 184,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 181
		}
	},
	{#State 296
		DEFAULT => -122
	},
	{#State 297
		ACTIONS => {
			")" => 325
		}
	},
	{#State 298
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'OP01_QW' => 136,
			"my" => 141,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'ListElement' => 138,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 137,
			'Operator' => 95,
			'TypeInner' => 140,
			'ListElements' => 326,
			'ArrayReference' => 74,
			'Literal' => 75
		}
	},
	{#State 299
		ACTIONS => {
			'LITERAL_STRING' => 90,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 101
		},
		GOTOS => {
			'Variable' => 256,
			'VariableOrLiteral' => 327,
			'Literal' => 257
		}
	},
	{#State 300
		DEFAULT => -119
	},
	{#State 301
		ACTIONS => {
			")" => 328
		}
	},
	{#State 302
		DEFAULT => -169
	},
	{#State 303
		DEFAULT => -170
	},
	{#State 304
		ACTIONS => {
			'OP21_LIST_COMMA' => 329
		}
	},
	{#State 305
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 330
		}
	},
	{#State 306
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 331
		}
	},
	{#State 307
		DEFAULT => -44
	},
	{#State 308
		ACTIONS => {
			";" => 332
		}
	},
	{#State 309
		ACTIONS => {
			"our" => 335,
			'LITERAL_NUMBER' => 333
		},
		GOTOS => {
			'MethodOrSubroutine' => 334,
			'Method' => 337,
			'Subroutine' => 336
		}
	},
	{#State 310
		ACTIONS => {
			'LBRACE' => 338
		}
	},
	{#State 311
		ACTIONS => {
			";" => 339
		}
	},
	{#State 312
		DEFAULT => -191
	},
	{#State 313
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => 185,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			'OP21_LIST_COMMA' => -187,
			'OP07_STRING_REPEAT' => 186,
			'OP17_LIST_RANGE' => 188,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			'OP04_MATH_POW' => 178,
			'OP08_STRING_CAT' => 181,
			"}" => -187,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP06_REGEX_MATCH' => 184,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP14_BITWISE_OR_XOR' => 183
		}
	},
	{#State 314
		DEFAULT => -171
	},
	{#State 315
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 340
		}
	},
	{#State 316
		ACTIONS => {
			'LPAREN' => 341
		}
	},
	{#State 317
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 342
		}
	},
	{#State 318
		ACTIONS => {
			'LPAREN' => 343
		}
	},
	{#State 319
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 344
		}
	},
	{#State 320
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 76,
			"while" => -139,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			"my" => 71,
			'WORD_UPPERCASE' => 94,
			'OP01_OPEN' => 115,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP01_PRINT' => 86,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"for" => -139,
			"if" => 87,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED_VOID' => 81,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106
		},
		GOTOS => {
			'PAREN-34' => 103,
			'ArrayReference' => 74,
			'Literal' => 75,
			'LoopLabel' => 72,
			'Statement' => 97,
			'HashReference' => 98,
			'VariableDeclaration' => 100,
			'HashDereferenced' => 99,
			'Conditional' => 113,
			'Operator' => 95,
			'WordScoped' => 105,
			'Operation' => 346,
			'PLUS-40' => 345,
			'ArrayDereferenced' => 108,
			'OPTIONAL-35' => 83,
			'SubExpression' => 107,
			'Expression' => 82,
			'VariableModification' => 110,
			'Variable' => 112,
			'OperatorVoid' => 111
		}
	},
	{#State 321
		DEFAULT => -114
	},
	{#State 322
		DEFAULT => -166
	},
	{#State 323
		DEFAULT => -165
	},
	{#State 324
		DEFAULT => -164
	},
	{#State 325
		DEFAULT => -78
	},
	{#State 326
		ACTIONS => {
			")" => 347
		}
	},
	{#State 327
		DEFAULT => -103
	},
	{#State 328
		DEFAULT => -124
	},
	{#State 329
		ACTIONS => {
			'LITERAL_STRING' => 348
		}
	},
	{#State 330
		DEFAULT => -204
	},
	{#State 331
		ACTIONS => {
			'OP21_LIST_COMMA' => 349,
			")" => 350
		},
		GOTOS => {
			'PAREN-18' => 351
		}
	},
	{#State 332
		DEFAULT => -46
	},
	{#State 333
		ACTIONS => {
			";" => 352
		}
	},
	{#State 334
		DEFAULT => -57
	},
	{#State 335
		ACTIONS => {
			'TYPE_METHOD' => 353,
			'TYPE_INTEGER' => 57,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 336
		DEFAULT => -75
	},
	{#State 337
		DEFAULT => -74
	},
	{#State 338
		ACTIONS => {
			"%{" => 85,
			'WORD' => 355,
			"}" => 354
		},
		GOTOS => {
			'HashDereferenced' => 356,
			'HashEntryTyped' => 357
		}
	},
	{#State 339
		DEFAULT => -168
	},
	{#State 340
		DEFAULT => -203
	},
	{#State 341
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 143,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			"my" => 141,
			'OP01_QW' => 136,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'Variable' => 139,
			'HashDereferenced' => 99,
			'ListElement' => 138,
			'HashReference' => 98,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 137,
			'WordScoped' => 105,
			'TypeInner' => 140,
			'Operator' => 95,
			'ListElements' => 358,
			'Literal' => 75,
			'ArrayReference' => 74
		}
	},
	{#State 342
		DEFAULT => -157
	},
	{#State 343
		ACTIONS => {
			'WORD_UPPERCASE' => 145,
			'OP01_OPEN' => 115,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP22_LOGICAL_NEG' => 109,
			'LITERAL_NUMBER' => 84,
			'LPAREN' => 106,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'SubExpression' => 359,
			'Expression' => 142,
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75
		}
	},
	{#State 344
		ACTIONS => {
			"while" => -150,
			"foreach" => -150,
			'' => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP10_NAMED_UNARY' => -150,
			"else" => 363,
			'OP01_OPEN' => -150,
			'WORD' => -150,
			'OP05_LOGICAL_NEG' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'LPAREN' => -150,
			"}" => -150,
			"for" => -150,
			'OP19_LOOP_CONTROL' => -150,
			"my" => -150,
			"\@{" => -150,
			'LITERAL_STRING' => -150,
			'WORD_UPPERCASE' => -150,
			'LBRACKET' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			"elsif" => 360,
			"undef" => -150,
			'LBRACE' => -150,
			'OP03_MATH_INC_DEC' => -150,
			'OP01_NAMED_VOID' => -150,
			'OP01_CLOSE' => -150,
			'LITERAL_NUMBER' => -150,
			'OP01_PRINT' => -150,
			"%{" => -150,
			'WORD_SCOPED' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP01_NAMED' => -150,
			"if" => -150
		},
		GOTOS => {
			'PAREN-38' => 364,
			'PAREN-36' => 362,
			'OPTIONAL-39' => 361
		}
	},
	{#State 345
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'OP01_OPEN' => 115,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			"}" => 365,
			"for" => -139,
			"while" => -139,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 94,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			"undef" => 96,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_NAMED_VOID' => 81,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP01_PRINT' => 86,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_NAMED' => 89,
			"if" => 87,
			'OP19_LOOP_CONTROL' => 76,
			"my" => 71,
			"\@{" => 73
		},
		GOTOS => {
			'PAREN-34' => 103,
			'ArrayReference' => 74,
			'Literal' => 75,
			'LoopLabel' => 72,
			'Statement' => 97,
			'HashReference' => 98,
			'VariableDeclaration' => 100,
			'HashDereferenced' => 99,
			'Conditional' => 113,
			'Operator' => 95,
			'Operation' => 366,
			'WordScoped' => 105,
			'OPTIONAL-35' => 83,
			'ArrayDereferenced' => 108,
			'SubExpression' => 107,
			'Expression' => 82,
			'VariableModification' => 110,
			'Variable' => 112,
			'OperatorVoid' => 111
		}
	},
	{#State 346
		DEFAULT => -159
	},
	{#State 347
		DEFAULT => -80
	},
	{#State 348
		ACTIONS => {
			'OP21_LIST_COMMA' => 367
		}
	},
	{#State 349
		ACTIONS => {
			"my" => 368
		}
	},
	{#State 350
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 369
		}
	},
	{#State 351
		DEFAULT => -48
	},
	{#State 352
		DEFAULT => -59
	},
	{#State 353
		ACTIONS => {
			'VARIABLE_SYMBOL' => 370
		}
	},
	{#State 354
		ACTIONS => {
			";" => 371
		}
	},
	{#State 355
		ACTIONS => {
			'OP20_HASH_FATARROW' => 372
		}
	},
	{#State 356
		DEFAULT => -190
	},
	{#State 357
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 373
		}
	},
	{#State 358
		ACTIONS => {
			")" => 374
		}
	},
	{#State 359
		ACTIONS => {
			'OP08_STRING_CAT' => 181,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP06_REGEX_MATCH' => 184,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP17_LIST_RANGE' => 375,
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP09_BITWISE_SHIFT' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => 185
		}
	},
	{#State 360
		ACTIONS => {
			'LPAREN' => 376
		}
	},
	{#State 361
		DEFAULT => -151
	},
	{#State 362
		DEFAULT => -146
	},
	{#State 363
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 377
		}
	},
	{#State 364
		DEFAULT => -149
	},
	{#State 365
		DEFAULT => -160
	},
	{#State 366
		DEFAULT => -158
	},
	{#State 367
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'LPAREN' => 106,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'OP01_CLOSE' => 78,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 92,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114
		},
		GOTOS => {
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 378,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'ArrayReference' => 74,
			'Literal' => 75,
			'Operator' => 95
		}
	},
	{#State 368
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 379
		}
	},
	{#State 369
		ACTIONS => {
			"\@_;" => 380
		}
	},
	{#State 370
		ACTIONS => {
			"= sub {" => 381
		}
	},
	{#State 371
		DEFAULT => -64
	},
	{#State 372
		ACTIONS => {
			"my" => 141
		},
		GOTOS => {
			'TypeInner' => 382
		}
	},
	{#State 373
		ACTIONS => {
			"}" => 385,
			'OP21_LIST_COMMA' => 384
		},
		GOTOS => {
			'PAREN-24' => 383
		}
	},
	{#State 374
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 386
		}
	},
	{#State 375
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'WORD' => 28,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 143,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73
		},
		GOTOS => {
			'Operator' => 95,
			'ArrayReference' => 74,
			'Literal' => 75,
			'HashReference' => 98,
			'Variable' => 139,
			'HashDereferenced' => 99,
			'WordScoped' => 105,
			'ArrayDereferenced' => 108,
			'Expression' => 142,
			'SubExpression' => 387
		}
	},
	{#State 376
		ACTIONS => {
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 143,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92
		},
		GOTOS => {
			'Literal' => 75,
			'ArrayReference' => 74,
			'Operator' => 95,
			'Expression' => 142,
			'SubExpression' => 388,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105,
			'HashDereferenced' => 99,
			'Variable' => 139,
			'HashReference' => 98
		}
	},
	{#State 377
		DEFAULT => -148
	},
	{#State 378
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 174,
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => -81,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP07_STRING_REPEAT' => 186,
			"]" => -81,
			'OP21_LIST_COMMA' => -81,
			'OP17_LIST_RANGE' => 188,
			")" => -81,
			'OP04_MATH_POW' => 178,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			'OP08_STRING_CAT' => 181,
			"}" => -81,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179,
			'OP06_REGEX_MATCH' => 184,
			";" => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP14_BITWISE_OR_XOR' => 183
		}
	},
	{#State 379
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 380
		DEFAULT => -50
	},
	{#State 381
		ACTIONS => {
			"foreach" => -66,
			"while" => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP10_NAMED_UNARY' => -66,
			'WORD' => -66,
			'OP01_OPEN' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'LPAREN_MY' => 390,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LPAREN' => -66,
			'OP22_LOGICAL_NEG' => -66,
			"for" => -66,
			'OP19_LOOP_CONTROL' => -66,
			"my" => -66,
			"\@{" => -66,
			'LITERAL_STRING' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'LBRACKET' => -66,
			'WORD_UPPERCASE' => -66,
			"undef" => -66,
			'OP01_CLOSE' => -66,
			'OP01_NAMED_VOID' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'LBRACE' => -66,
			'LITERAL_NUMBER' => -66,
			"%{" => -66,
			'WORD_SCOPED' => -66,
			'OP01_PRINT' => -66,
			"if" => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP01_NAMED' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 392,
			'MethodArguments' => 391
		}
	},
	{#State 382
		ACTIONS => {
			"\@{" => 73,
			'VARIABLE_SYMBOL' => 101,
			'LITERAL_STRING' => 90,
			'OP10_NAMED_UNARY' => 114,
			'LBRACKET' => 93,
			'WORD' => 28,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 145,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 96,
			'OP01_CLOSE' => 78,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACE' => 80,
			'LPAREN' => 106,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'WORD_SCOPED' => 26,
			"%{" => 85,
			'OP01_NAMED' => 143
		},
		GOTOS => {
			'HashDereferenced' => 99,
			'Variable' => 139,
			'HashReference' => 98,
			'Expression' => 142,
			'SubExpression' => 393,
			'ArrayDereferenced' => 108,
			'WordScoped' => 105,
			'Operator' => 95,
			'Literal' => 75,
			'ArrayReference' => 74
		}
	},
	{#State 383
		DEFAULT => -61
	},
	{#State 384
		ACTIONS => {
			'WORD' => 355,
			"%{" => 85
		},
		GOTOS => {
			'HashDereferenced' => 356,
			'HashEntryTyped' => 394
		}
	},
	{#State 385
		ACTIONS => {
			";" => 395
		}
	},
	{#State 386
		DEFAULT => -156
	},
	{#State 387
		ACTIONS => {
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP16_LOGICAL_OR' => 179,
			'OP08_STRING_CAT' => 181,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP06_REGEX_MATCH' => 184,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 177,
			'OP04_MATH_POW' => 178,
			")" => 396,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => 175
		}
	},
	{#State 388
		ACTIONS => {
			'OP16_LOGICAL_OR' => 179,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP08_STRING_CAT' => 181,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP06_REGEX_MATCH' => 184,
			'OP17_LIST_RANGE' => 188,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			'OP04_MATH_POW' => 178,
			")" => 397,
			'OP07_STRING_REPEAT' => 186,
			'OP11_COMPARE_LT_GT' => 176,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 174,
			'OP23_LOGICAL_AND' => 185,
			'OP13_BITWISE_AND' => 175
		}
	},
	{#State 389
		DEFAULT => -47
	},
	{#State 390
		ACTIONS => {
			'TYPE_SELF' => 398
		}
	},
	{#State 391
		DEFAULT => -65
	},
	{#State 392
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 76,
			"while" => -139,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 101,
			"\@{" => 73,
			"my" => 71,
			'OP01_OPEN' => 115,
			'WORD_UPPERCASE' => 94,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			'WORD' => 28,
			"undef" => 96,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			'LITERAL_STRING' => 90,
			'OP01_PRINT' => 86,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			"for" => -139,
			"if" => 87,
			'LBRACE' => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED_VOID' => 81,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106
		},
		GOTOS => {
			'ArrayReference' => 74,
			'PAREN-34' => 103,
			'Literal' => 75,
			'HashReference' => 98,
			'HashDereferenced' => 99,
			'VariableDeclaration' => 100,
			'PLUS-27' => 399,
			'LoopLabel' => 72,
			'Statement' => 97,
			'Operator' => 95,
			'Conditional' => 113,
			'VariableModification' => 110,
			'OperatorVoid' => 111,
			'Variable' => 112,
			'Operation' => 400,
			'WordScoped' => 105,
			'Expression' => 82,
			'SubExpression' => 107,
			'OPTIONAL-35' => 83,
			'ArrayDereferenced' => 108
		}
	},
	{#State 393
		ACTIONS => {
			'OP13_BITWISE_AND' => 175,
			'OP23_LOGICAL_AND' => 185,
			'OP09_BITWISE_SHIFT' => 174,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP11_COMPARE_LT_GT' => 176,
			'OP21_LIST_COMMA' => -189,
			'OP07_STRING_REPEAT' => 186,
			'OP08_MATH_ADD_SUB' => 177,
			'OP18_TERNARY' => 189,
			'OP04_MATH_POW' => 178,
			'OP17_LIST_RANGE' => 188,
			'OP06_REGEX_MATCH' => 184,
			'OP24_LOGICAL_OR_XOR' => 182,
			'OP14_BITWISE_OR_XOR' => 183,
			'OP08_STRING_CAT' => 181,
			"}" => -189,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP16_LOGICAL_OR' => 179
		}
	},
	{#State 394
		DEFAULT => -60
	},
	{#State 395
		DEFAULT => -63
	},
	{#State 396
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 401
		}
	},
	{#State 397
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 402
		}
	},
	{#State 398
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 403
		}
	},
	{#State 399
		ACTIONS => {
			'OP01_PRINT' => 86,
			"%{" => 85,
			'WORD_SCOPED' => 26,
			'OP19_LOOP_CONTROL_SCOLON' => 88,
			'OP01_NAMED' => 89,
			"if" => 87,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_NAMED_VOID' => 81,
			'LBRACE' => 80,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 84,
			'WORD_UPPERCASE' => 94,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 93,
			"undef" => 96,
			'LITERAL_STRING' => 90,
			"\@{" => 73,
			"my" => 71,
			'OP19_LOOP_CONTROL' => 76,
			"}" => 405,
			"for" => -139,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP22_LOGICAL_NEG' => 109,
			'LPAREN' => 106,
			'OP01_OPEN' => 115,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 101,
			"while" => -139,
			"foreach" => -139
		},
		GOTOS => {
			'Statement' => 97,
			'LoopLabel' => 72,
			'HashDereferenced' => 99,
			'VariableDeclaration' => 100,
			'HashReference' => 98,
			'Literal' => 75,
			'ArrayReference' => 74,
			'PAREN-34' => 103,
			'SubExpression' => 107,
			'Expression' => 82,
			'ArrayDereferenced' => 108,
			'OPTIONAL-35' => 83,
			'Operation' => 404,
			'WordScoped' => 105,
			'OperatorVoid' => 111,
			'Variable' => 112,
			'VariableModification' => 110,
			'Conditional' => 113,
			'Operator' => 95
		}
	},
	{#State 400
		DEFAULT => -68
	},
	{#State 401
		DEFAULT => -155
	},
	{#State 402
		DEFAULT => -145
	},
	{#State 403
		ACTIONS => {
			'OP21_LIST_COMMA' => 406,
			")" => 407
		},
		GOTOS => {
			'PAREN-28' => 408
		}
	},
	{#State 404
		DEFAULT => -67
	},
	{#State 405
		ACTIONS => {
			";" => 409
		}
	},
	{#State 406
		ACTIONS => {
			"my" => 410
		}
	},
	{#State 407
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 411
		}
	},
	{#State 408
		DEFAULT => -71
	},
	{#State 409
		DEFAULT => -69
	},
	{#State 410
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 412
		}
	},
	{#State 411
		ACTIONS => {
			"\@_;" => 413
		}
	},
	{#State 412
		ACTIONS => {
			'VARIABLE_SYMBOL' => 414
		}
	},
	{#State 413
		DEFAULT => -73
	},
	{#State 414
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5786 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5793 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5800 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5807 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5818 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5829 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5836 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5843 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5850 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5857 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5864 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5871 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5878 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5885 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5892 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5899 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5906 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5913 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5924 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5931 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5949 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5960 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6038 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6049 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6056 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6063 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6074 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6088 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6110 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6121 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6128 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6135 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6142 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6149 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6160 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6167 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6174 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6181 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6192 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6199 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6206 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6213 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6220 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6227 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6234 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6241 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6248 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6259 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6266 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6273 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6280 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6291 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6302 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6309 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6316 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6323 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6330 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6341 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6348 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6362 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6373 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6384 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6395 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6406 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6428 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6439 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6450 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6461 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6472 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6483 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6494 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6505 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6516 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6527 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6538 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6549 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6560 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6571 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6593 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6604 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6615 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6637 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6648 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6659 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6670 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6692 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6703 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6714 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6725 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6736 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6743 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6750 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6757 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6768 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6779 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6790 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6801 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6812 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6823 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6834 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6841 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6855 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6895 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6906 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6917 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6928 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6939 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6950 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6961 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6972 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6983 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6994 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7016 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7027 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7038 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7052 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7059 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7070 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7081 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7092 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7103 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7114 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7128 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7135 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7142 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7149 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7156 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7200 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7211 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7222 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7233 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7247 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7272 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7283 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7349 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7360 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7367 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_174
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7399 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7406 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7417 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7428 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7439 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7446 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7453 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7464 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_183
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_184
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_187
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7511 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_188
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7522 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_189
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7533 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_190
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7544 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7551 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7558 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7565 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_194
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7576 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_195
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7587 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7598 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_197
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7609 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7620 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_199
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7631 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_200
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7642 lib/RPerl/Grammar.pm
	],
	[#Rule Type_201
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7653 lib/RPerl/Grammar.pm
	],
	[#Rule Type_202
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7664 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_203
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7675 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_204
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7686 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_205
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7697 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_206
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7708 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7719 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7730 lib/RPerl/Grammar.pm
	]
],
#line 7733 lib/RPerl/Grammar.pm
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
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
         'ArrayDereferenced_183', 
         'ArrayDereferenced_184', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_187', 
         'HashEntry_188', 
         'HashEntryTyped_189', 
         'HashEntryTyped_190', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_194', 
         'HashReference_195', 
         'HashDereferenced_196', 
         'HashDereferenced_197', 
         'WordScoped_198', 
         'WordScoped_199', 
         'LoopLabel_200', 
         'Type_201', 
         'Type_202', 
         'TypeInner_203', 
         'TypeInnerConstant_204', 
         'VariableOrLiteral_205', 
         'VariableOrLiteral_206', 
         'Literal_207', 
         'Literal_208', );
  $self;
}

#line 204 "lib/RPerl/Grammar.eyp"


{
# Rules from Grammar.output
# NEED FIX: UPDATE!?!
my string__hash_ref $rules = {

CompileUnit_3 => 'RPerl::CompileUnit',
CompileUnit_4 => 'RPerl::CompileUnit',
Program_9 => 'RPerl::CompileUnit::Program',
Module_10 => 'RPerl::CompileUnit::Module',
Module_11 => 'RPerl::CompileUnit::Module',
Package_14 => 'RPerl::CompileUnit::Module::Package',
Subroutine_38 => 'RPerl::CodeBlock::Subroutine',
Class_52 => 'RPerl::CompileUnit::Module::Class',
Properties_55 => 'RPerl::DataStructure::Hash::Properties',
Method_60 => 'RPerl::CodeBlock::Subroutine::Method',
Operation_65 => 'RPerl::Operation',
Operation_66 => 'RPerl::Operation',
Operator_69 => 'RPerl::Operation::Expression::Operator',

}; 
    1;
}

=for None

=cut


#line 7990 lib/RPerl/Grammar.pm



1;
