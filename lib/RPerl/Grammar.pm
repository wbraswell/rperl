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
    our $VERSION = 0.000_973;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\$TYPED_|\=\ sub\ \{|while\ \(|elsif\ \(|package|undef|if\ \(|else|use|qw\(|\@_\;|our|\%\{|my|\@\{|\}|\]|\;|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
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


#line 128 lib/RPerl/Grammar.pm

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
  [ 'Include_40' => 'Include', [ 'use', 'WordScoped', 'qw(', 'PLUS-15', ')', ';' ], 0 ],
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
  [ 'Operator_80' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')', 'OP01_OPEN', 'my', 'filehandle_ref', 'FH_REF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_81' => 'Operator', [ 'OP01_CLOSE', 'FH_REF_SYMBOL' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_83' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [ 'PAREN-30' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [  ], 0 ],
  [ 'OperatorVoid_109' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-31', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_110' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_111' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_112' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_113' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'Expression_120' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_121' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-32', ')' ], 0 ],
  [ 'Expression_122' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_123' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-33', ')' ], 0 ],
  [ 'Expression_124' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_125' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_126' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_127' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_128' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_134' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_135' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-34', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'PAREN-34' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Statement_139' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_140' => 'Statement', [ 'OPTIONAL-35', 'Loop' ], 0 ],
  [ 'Statement_141' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_142' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Conditional_150' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-37', 'OPTIONAL-39' ], 0 ],
  [ 'Loop_151' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_152' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_153' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_154' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_155' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_156' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'PLUS-40', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'Operation' ], 0 ],
  [ 'CodeBlock_159' => 'CodeBlock', [ 'LBRACE', 'PLUS-40', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ 'Variable_162' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-41' ], 0 ],
  [ 'VariableRetrieval_163' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_164' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_165' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_166' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_167' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_168' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_169' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'PAREN-42' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'WORD' ], 0 ],
  [ 'ListElements_175' => 'ListElements', [ 'ListElement', 'STAR-43' ], 0 ],
  [ 'ListElements_176' => 'ListElements', [ 'OP01_QW', 'PLUS-44', ')' ], 0 ],
  [ 'ListElement_177' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_178' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'ArrayReference_181' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-45', ']' ], 0 ],
  [ 'ArrayDereferenced_182' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_183' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'HashEntry_186' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-46', 'SubExpression' ], 0 ],
  [ 'HashEntry_187' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_188' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_189' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ 'HashReference_193' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-48', '}' ], 0 ],
  [ 'HashReference_194' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ 'HashDereferenced_195' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_196' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_197' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_198' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_199' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_200' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_201' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_202' => 'TypeInnerConstant', [ 'my', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_203' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_204' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'Literal_205' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_206' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_PAREN' => 106,
  '_OPTIONAL' => 107,
  '_OPTIONAL' => 108,
  'OperatorVoid_109' => 109,
  'OperatorVoid_110' => 110,
  'OperatorVoid_111' => 111,
  'OperatorVoid_112' => 112,
  'OperatorVoid_113' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  '_OPTIONAL' => 116,
  '_OPTIONAL' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  'Expression_120' => 120,
  'Expression_121' => 121,
  'Expression_122' => 122,
  'Expression_123' => 123,
  'Expression_124' => 124,
  'SubExpression_125' => 125,
  'SubExpression_126' => 126,
  'SubExpression_127' => 127,
  'SubExpression_128' => 128,
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpressionOrStdin_134' => 134,
  'SubExpressionOrStdin_135' => 135,
  '_PAREN' => 136,
  '_OPTIONAL' => 137,
  '_OPTIONAL' => 138,
  'Statement_139' => 139,
  'Statement_140' => 140,
  'Statement_141' => 141,
  'Statement_142' => 142,
  'Statement_143' => 143,
  '_PAREN' => 144,
  '_STAR_LIST' => 145,
  '_STAR_LIST' => 146,
  '_PAREN' => 147,
  '_OPTIONAL' => 148,
  '_OPTIONAL' => 149,
  'Conditional_150' => 150,
  'Loop_151' => 151,
  'Loop_152' => 152,
  'Loop_153' => 153,
  'LoopFor_154' => 154,
  'LoopForEach_155' => 155,
  'LoopWhile_156' => 156,
  '_PLUS_LIST' => 157,
  '_PLUS_LIST' => 158,
  'CodeBlock_159' => 159,
  '_STAR_LIST' => 160,
  '_STAR_LIST' => 161,
  'Variable_162' => 162,
  'VariableRetrieval_163' => 163,
  'VariableRetrieval_164' => 164,
  'VariableRetrieval_165' => 165,
  'VariableDeclaration_166' => 166,
  'VariableDeclaration_167' => 167,
  'VariableModification_168' => 168,
  'VariableModification_169' => 169,
  '_PAREN' => 170,
  '_STAR_LIST' => 171,
  '_STAR_LIST' => 172,
  '_PLUS_LIST' => 173,
  '_PLUS_LIST' => 174,
  'ListElements_175' => 175,
  'ListElements_176' => 176,
  'ListElement_177' => 177,
  'ListElement_178' => 178,
  '_OPTIONAL' => 179,
  '_OPTIONAL' => 180,
  'ArrayReference_181' => 181,
  'ArrayDereferenced_182' => 182,
  'ArrayDereferenced_183' => 183,
  '_OPTIONAL' => 184,
  '_OPTIONAL' => 185,
  'HashEntry_186' => 186,
  'HashEntry_187' => 187,
  'HashEntryTyped_188' => 188,
  'HashEntryTyped_189' => 189,
  '_PAREN' => 190,
  '_STAR_LIST' => 191,
  '_STAR_LIST' => 192,
  'HashReference_193' => 193,
  'HashReference_194' => 194,
  'HashDereferenced_195' => 195,
  'HashDereferenced_196' => 196,
  'WordScoped_197' => 197,
  'WordScoped_198' => 198,
  'LoopLabel_199' => 199,
  'Type_200' => 200,
  'TypeInner_201' => 201,
  'TypeInnerConstant_202' => 202,
  'VariableOrLiteral_203' => 203,
  'VariableOrLiteral_204' => 204,
  'Literal_205' => 205,
  'Literal_206' => 206,
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
	'elsif (' => { ISSEMANTIC => 0 },
	'filehandle_ref' => { ISSEMANTIC => 0 },
	'for my integer' => { ISSEMANTIC => 0 },
	'foreach my' => { ISSEMANTIC => 0 },
	'if (' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our hash_ref $properties' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'qw(' => { ISSEMANTIC => 0 },
	'undef' => { ISSEMANTIC => 0 },
	'use RPerl;' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent qw(' => { ISSEMANTIC => 0 },
	'use strict;' => { ISSEMANTIC => 0 },
	'use warnings;' => { ISSEMANTIC => 0 },
	'use' => { ISSEMANTIC => 0 },
	'while (' => { ISSEMANTIC => 0 },
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
			'SHEBANG' => 9,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Program' => 1,
			'CompileUnit' => 6,
			'PLUS-2' => 2,
			'OPTIONAL-9' => 3,
			'PAREN-1' => 7,
			'ModuleHeader' => 4,
			'Critic' => 5
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 8,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 10,
			'Critic' => 5,
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 3
		}
	},
	{#State 3
		ACTIONS => {
			"package" => 11
		}
	},
	{#State 4
		ACTIONS => {
			"our" => -25,
			"## no critic qw(" => -25,
			"use parent qw(" => 16,
			"use" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'Module' => 14,
			'Class' => 12,
			'Package' => 15,
			'STAR-10' => 13
		}
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		ACTIONS => {
			'' => 17
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 9
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 21,
			'OPTIONAL-3' => 20
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 12
		DEFAULT => -23
	},
	{#State 13
		ACTIONS => {
			"## no critic qw(" => 8,
			"our" => -27,
			"use constant" => -27,
			"use" => -27
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-11' => 25
		}
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		DEFAULT => -22
	},
	{#State 16
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 17
		DEFAULT => 0
	},
	{#State 18
		DEFAULT => -35
	},
	{#State 19
		ACTIONS => {
			'WORD' => 28,
			")" => 29
		}
	},
	{#State 20
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 21
		DEFAULT => -6
	},
	{#State 22
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -197
	},
	{#State 24
		DEFAULT => -198
	},
	{#State 25
		ACTIONS => {
			"use" => 33,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 34
		}
	},
	{#State 26
		DEFAULT => -24
	},
	{#State 27
		ACTIONS => {
			")" => 36
		}
	},
	{#State 28
		DEFAULT => -34
	},
	{#State 29
		DEFAULT => -36
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
			'WORD_SCOPED' => 24,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			"our" => 45,
			"use constant" => 44
		},
		GOTOS => {
			'Constant' => 42,
			'Subroutine' => 43,
			'PLUS-13' => 41
		}
	},
	{#State 36
		ACTIONS => {
			";" => 46
		}
	},
	{#State 37
		ACTIONS => {
			'LITERAL_STRING' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"if (" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'VARIABLE_SYMBOL' => -11,
			'WORD_SCOPED' => -11,
			"our" => -11,
			"use constant" => -11,
			'OP01_CLOSE' => -11,
			"## no critic qw(" => 8,
			'OP19_LOOP_CONTROL' => -11,
			"%{" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP10_NAMED_UNARY' => -11,
			'LITERAL_NUMBER' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'WORD_UPPERCASE' => -11,
			"use" => -11,
			'LPAREN' => -11,
			'WORD' => -11,
			"undef" => -11,
			"while (" => -11,
			'LBRACE' => -11,
			"foreach my" => -11,
			"\@{" => -11,
			'OP01_NAMED' => -11,
			"my" => -11,
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_PRINT' => -11,
			"for my integer" => -11,
			'OP05_MATH_NEG_LPAREN' => -11
		},
		GOTOS => {
			'STAR-5' => 47,
			'Critic' => 48
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
			"qw(" => 51,
			";" => 50
		}
	},
	{#State 41
		ACTIONS => {
			'LITERAL_NUMBER' => 52,
			"our" => 45
		},
		GOTOS => {
			'Subroutine' => 53
		}
	},
	{#State 42
		DEFAULT => -28
	},
	{#State 43
		DEFAULT => -31
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 54
		}
	},
	{#State 45
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 46
		ACTIONS => {
			"use" => 33
		},
		GOTOS => {
			'Include' => 57
		}
	},
	{#State 47
		ACTIONS => {
			"use constant" => -13,
			'OP01_CLOSE' => -13,
			'VARIABLE_SYMBOL' => -13,
			'WORD_SCOPED' => -13,
			"our" => -13,
			'LITERAL_STRING' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"if (" => -13,
			'OP22_LOGICAL_NEG' => -13,
			"\@{" => -13,
			'OP01_NAMED' => -13,
			"my" => -13,
			"foreach my" => -13,
			"for my integer" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_PRINT' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LBRACKET' => -13,
			'WORD_UPPERCASE' => -13,
			'LPAREN' => -13,
			"use" => 33,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LITERAL_NUMBER' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'WORD' => -13,
			"undef" => -13,
			"while (" => -13,
			'LBRACE' => -13
		},
		GOTOS => {
			'Include' => 58,
			'STAR-6' => 59
		}
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		ACTIONS => {
			"our" => 60
		}
	},
	{#State 50
		DEFAULT => -39
	},
	{#State 51
		ACTIONS => {
			'WORD' => 62
		},
		GOTOS => {
			'PLUS-15' => 61
		}
	},
	{#State 52
		ACTIONS => {
			";" => 63
		}
	},
	{#State 53
		DEFAULT => -30
	},
	{#State 54
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 56
		DEFAULT => -200
	},
	{#State 57
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 66
		}
	},
	{#State 58
		DEFAULT => -10
	},
	{#State 59
		ACTIONS => {
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED_VOID' => -15,
			"for my integer" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"foreach my" => -15,
			"\@{" => -15,
			'OP01_NAMED' => -15,
			"my" => -15,
			'WORD' => -15,
			"undef" => -15,
			"while (" => -15,
			'LBRACE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"%{" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LITERAL_NUMBER' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'WORD_UPPERCASE' => -15,
			'LPAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			'WORD_SCOPED' => -15,
			"our" => -15,
			"use constant" => 44,
			'OP01_CLOSE' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_STRING' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"if (" => -15
		},
		GOTOS => {
			'Constant' => 67,
			'STAR-7' => 68
		}
	},
	{#State 60
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 69
		}
	},
	{#State 61
		ACTIONS => {
			'WORD' => 70,
			")" => 71
		}
	},
	{#State 62
		DEFAULT => -38
	},
	{#State 63
		DEFAULT => -32
	},
	{#State 64
		ACTIONS => {
			"my" => 72
		},
		GOTOS => {
			'TypeInnerConstant' => 73
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 66
		ACTIONS => {
			"## no critic qw(" => 8,
			"our hash_ref \$properties" => -54,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'STAR-21' => 76,
			'Critic' => 75
		}
	},
	{#State 67
		DEFAULT => -12
	},
	{#State 68
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP19_LOOP_CONTROL' => 100,
			'OP01_NAMED_VOID_SCOLON' => 102,
			"%{" => 101,
			'OP03_MATH_INC_DEC' => 105,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LPAREN' => 108,
			"if (" => 121,
			'WORD_UPPERCASE' => 107,
			"undef" => 98,
			"while (" => -138,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"foreach my" => -138,
			'VARIABLE_SYMBOL' => 113,
			"our" => 45,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			"my" => 94,
			'OP01_NAMED' => 92,
			'OP01_CLOSE' => 115,
			'LBRACKET' => 83,
			"for my integer" => -138,
			'OP01_NAMED_VOID' => 86,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_PRINT' => 84,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'Statement' => 106,
			'PAREN-34' => 118,
			'LoopLabel' => 96,
			'Subroutine' => 95,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'OPTIONAL-35' => 90,
			'Operation' => 116,
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'ArrayReference' => 110,
			'SubExpression' => 82,
			'HashReference' => 81,
			'Variable' => 80,
			'PLUS-8' => 79,
			'Expression' => 78,
			'VariableModification' => 109,
			'Conditional' => 77,
			'Operator' => 111,
			'OperatorVoid' => 112,
			'VariableDeclaration' => 85
		}
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		DEFAULT => -37
	},
	{#State 71
		ACTIONS => {
			";" => 122
		}
	},
	{#State 72
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 123
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_STRING' => 119,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Literal' => 124
		}
	},
	{#State 74
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_NAMED_VOID' => -43,
			"for my integer" => -43,
			'OP01_PRINT' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'LBRACKET' => -43,
			'OP01_NAMED' => -43,
			'OP01_CLOSE' => -43,
			"my" => -43,
			"\@{" => -43,
			'LPAREN_MY' => 125,
			'WORD_SCOPED' => -43,
			"foreach my" => -43,
			'VARIABLE_SYMBOL' => -43,
			'LBRACE' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'WORD' => -43,
			"while (" => -43,
			"undef" => -43,
			"if (" => -43,
			'WORD_UPPERCASE' => -43,
			'LPAREN' => -43,
			'LITERAL_STRING' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"%{" => -43,
			'LITERAL_NUMBER' => -43,
			'OP10_NAMED_UNARY' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 126,
			'OPTIONAL-16' => 127
		}
	},
	{#State 75
		DEFAULT => -51
	},
	{#State 76
		ACTIONS => {
			"use" => 33,
			"use constant" => -56,
			"our hash_ref \$properties" => -56
		},
		GOTOS => {
			'Include' => 129,
			'STAR-22' => 128
		}
	},
	{#State 77
		DEFAULT => -139
	},
	{#State 78
		ACTIONS => {
			'OP17_LIST_RANGE' => -125,
			'OP08_MATH_ADD_SUB' => -125,
			'OP13_BITWISE_AND' => -125,
			'OP09_BITWISE_SHIFT' => -125,
			'OP07_STRING_REPEAT' => -125,
			'OP04_MATH_POW' => -125,
			'OP11_COMPARE_LT_GT' => -125,
			'OP23_LOGICAL_AND' => -125,
			'OP18_TERNARY' => -125,
			'OP14_BITWISE_OR_XOR' => -125,
			'OP24_LOGICAL_OR_XOR' => -125,
			";" => 130,
			'OP12_COMPARE_EQ_NE' => -125,
			'OP15_LOGICAL_AND' => -125,
			'OP06_REGEX_MATCH' => -125,
			'OP08_STRING_CAT' => -125,
			'OP16_LOGICAL_OR' => -125,
			'OP07_MATH_MULT_DIV_MOD' => -125
		}
	},
	{#State 79
		ACTIONS => {
			'WORD_SCOPED' => 24,
			"foreach my" => -138,
			'VARIABLE_SYMBOL' => 113,
			"my" => 94,
			'OP01_NAMED' => 92,
			'OP01_CLOSE' => 115,
			"\@{" => 91,
			'LBRACKET' => 83,
			'' => -18,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_NAMED_VOID' => 86,
			"for my integer" => -138,
			'OP01_PRINT' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP03_MATH_INC_DEC' => 105,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP19_LOOP_CONTROL' => 100,
			'OP01_NAMED_VOID_SCOLON' => 102,
			"%{" => 101,
			'LPAREN' => 108,
			"if (" => 121,
			'WORD_UPPERCASE' => 107,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			"while (" => -138,
			'WORD' => 23
		},
		GOTOS => {
			'SubExpression' => 82,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'VariableModification' => 109,
			'Expression' => 78,
			'Conditional' => 77,
			'Variable' => 80,
			'VariableDeclaration' => 85,
			'Operator' => 111,
			'OperatorVoid' => 112,
			'HashDereferenced' => 89,
			'OPTIONAL-35' => 90,
			'ArrayDereferenced' => 93,
			'Operation' => 131,
			'Literal' => 114,
			'LoopLabel' => 96,
			'WordScoped' => 97,
			'PAREN-34' => 118,
			'Statement' => 106
		}
	},
	{#State 80
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -128,
			'OP19_VARIABLE_ASSIGN' => 132,
			'OP18_TERNARY' => -128,
			'OP04_MATH_POW' => -128,
			'OP23_LOGICAL_AND' => -128,
			'OP11_COMPARE_LT_GT' => -128,
			'OP19_VARIABLE_ASSIGN_BY' => 134,
			'OP07_STRING_REPEAT' => -128,
			'OP09_BITWISE_SHIFT' => -128,
			'OP13_BITWISE_AND' => -128,
			'OP08_MATH_ADD_SUB' => -128,
			'OP17_LIST_RANGE' => -128,
			'OP02_METHOD_THINARROW' => 135,
			'OP07_MATH_MULT_DIV_MOD' => -128,
			'OP16_LOGICAL_OR' => -128,
			'OP15_LOGICAL_AND' => -128,
			'OP03_MATH_INC_DEC' => 133,
			'OP06_REGEX_MATCH' => -128,
			'OP08_STRING_CAT' => -128,
			'OP12_COMPARE_EQ_NE' => -128,
			'OP24_LOGICAL_OR_XOR' => -128
		}
	},
	{#State 81
		DEFAULT => -131
	},
	{#State 82
		ACTIONS => {
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP18_TERNARY' => 150,
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP23_LOGICAL_AND' => 151,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138
		}
	},
	{#State 83
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			"]" => -180,
			'LBRACKET' => 83,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"my" => 158,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 105
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'TypeInner' => 154,
			'ListElements' => 155,
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'Expression' => 159,
			'Variable' => 160,
			'HashReference' => 81,
			'SubExpression' => 161,
			'ArrayReference' => 110,
			'WordScoped' => 97,
			'Operator' => 111,
			'OPTIONAL-45' => 153,
			'ListElement' => 162
		}
	},
	{#State 84
		ACTIONS => {
			'OP01_NAMED' => -108,
			'OP01_CLOSE' => -108,
			"my" => -108,
			"\@{" => -108,
			'STDOUT_STDERR' => 164,
			'WORD_SCOPED' => -108,
			'OP01_QW' => -108,
			'VARIABLE_SYMBOL' => -108,
			'OP05_MATH_NEG_LPAREN' => -108,
			'LBRACKET' => -108,
			'FH_REF_SYMBOL_BRACES' => 166,
			'WORD_UPPERCASE' => -108,
			'LPAREN' => -108,
			'LITERAL_STRING' => -108,
			'OP05_LOGICAL_NEG' => -108,
			'OP03_MATH_INC_DEC' => -108,
			"%{" => -108,
			'LITERAL_NUMBER' => -108,
			'OP10_NAMED_UNARY' => -108,
			'LBRACE' => -108,
			'OP22_LOGICAL_NEG' => -108,
			'WORD' => -108,
			"undef" => -108
		},
		GOTOS => {
			'OPTIONAL-31' => 167,
			'PAREN-30' => 165
		}
	},
	{#State 85
		DEFAULT => -142
	},
	{#State 86
		ACTIONS => {
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"my" => 158,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'TypeInner' => 154,
			'ListElements' => 168,
			'Literal' => 114,
			'SubExpression' => 161,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'Expression' => 159,
			'Variable' => 160,
			'ListElement' => 162,
			'WordScoped' => 97,
			'Operator' => 111
		}
	},
	{#State 87
		DEFAULT => -114
	},
	{#State 88
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 105,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'WordScoped' => 97,
			'Operator' => 111,
			'ArrayReference' => 110,
			'SubExpression' => 169,
			'HashReference' => 81,
			'Expression' => 159,
			'Variable' => 160,
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'HashDereferenced' => 89
		}
	},
	{#State 89
		DEFAULT => -132
	},
	{#State 90
		ACTIONS => {
			"while (" => 176,
			"for my integer" => 173,
			"foreach my" => 172
		},
		GOTOS => {
			'LoopForEach' => 171,
			'Loop' => 175,
			'LoopFor' => 174,
			'LoopWhile' => 170
		}
	},
	{#State 91
		ACTIONS => {
			'LBRACKET' => 83,
			'VARIABLE_SYMBOL' => 113
		},
		GOTOS => {
			'Variable' => 177,
			'ArrayReference' => 178
		}
	},
	{#State 92
		ACTIONS => {
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP03_MATH_INC_DEC' => 105,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"my" => 158,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83
		},
		GOTOS => {
			'Operator' => 111,
			'WordScoped' => 97,
			'ListElement' => 179,
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'SubExpression' => 180,
			'HashReference' => 81,
			'Literal' => 114,
			'TypeInner' => 154,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89
		}
	},
	{#State 93
		DEFAULT => -130
	},
	{#State 94
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 181
		}
	},
	{#State 95
		DEFAULT => -14
	},
	{#State 96
		ACTIONS => {
			'COLON' => 182
		}
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 184,
			'OP02_METHOD_THINARROW_NEW' => 183
		}
	},
	{#State 98
		DEFAULT => -126
	},
	{#State 99
		ACTIONS => {
			'WORD' => 185,
			"}" => 188,
			"%{" => 101
		},
		GOTOS => {
			'HashEntry' => 186,
			'HashDereferenced' => 187
		}
	},
	{#State 100
		ACTIONS => {
			'WORD_UPPERCASE' => 189
		},
		GOTOS => {
			'LoopLabel' => 190
		}
	},
	{#State 101
		ACTIONS => {
			'VARIABLE_SYMBOL' => 113,
			'LBRACE' => 99
		},
		GOTOS => {
			'Variable' => 191,
			'HashReference' => 192
		}
	},
	{#State 102
		DEFAULT => -111
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 113,
			'OP07_STRING_REPEAT' => -94,
			'WORD_SCOPED' => 24,
			'OP01_CLOSE' => 115,
			'OP08_MATH_ADD_SUB' => -94,
			"]" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP18_TERNARY' => -94,
			"}" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP08_STRING_CAT' => -94,
			'OP21_LIST_COMMA' => -94,
			'LITERAL_STRING' => 119,
			")" => -94,
			'OP05_LOGICAL_NEG' => 120,
			'OP16_LOGICAL_OR' => -94,
			'OP22_LOGICAL_NEG' => 117,
			'OP09_BITWISE_SHIFT' => -94,
			'OP17_LIST_RANGE' => -94,
			"\@{" => 91,
			'OP01_NAMED' => 157,
			'OP13_BITWISE_AND' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'LBRACKET' => 83,
			'OP04_MATH_POW' => -94,
			'OP05_MATH_NEG_LPAREN' => 88,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 105,
			'OP06_REGEX_MATCH' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			";" => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99
		},
		GOTOS => {
			'Expression' => 159,
			'Variable' => 160,
			'ArrayReference' => 110,
			'SubExpression' => 193,
			'HashReference' => 81,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93
		}
	},
	{#State 104
		DEFAULT => -206
	},
	{#State 105
		ACTIONS => {
			'VARIABLE_SYMBOL' => 113
		},
		GOTOS => {
			'Variable' => 194
		}
	},
	{#State 106
		DEFAULT => -77
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => 195,
			'COLON' => -199
		}
	},
	{#State 108
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_PRINT' => 197,
			'LBRACKET' => 83,
			'OP01_NAMED' => 198,
			'OP01_CLOSE' => 115,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'SubExpression' => 196,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'Expression' => 159,
			'Variable' => 160,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114
		}
	},
	{#State 109
		DEFAULT => -143
	},
	{#State 110
		DEFAULT => -129
	},
	{#State 111
		DEFAULT => -120
	},
	{#State 112
		DEFAULT => -141
	},
	{#State 113
		DEFAULT => -161,
		GOTOS => {
			'STAR-41' => 199
		}
	},
	{#State 114
		DEFAULT => -127
	},
	{#State 115
		ACTIONS => {
			'FH_REF_SYMBOL' => 200
		}
	},
	{#State 116
		DEFAULT => -17
	},
	{#State 117
		ACTIONS => {
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101,
			'OP03_MATH_INC_DEC' => 105,
			"undef" => 98,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'Variable' => 160,
			'Expression' => 159,
			'HashReference' => 81,
			'SubExpression' => 201,
			'ArrayReference' => 110,
			'Operator' => 111,
			'WordScoped' => 97
		}
	},
	{#State 118
		DEFAULT => -137
	},
	{#State 119
		DEFAULT => -205
	},
	{#State 120
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'Operator' => 111,
			'WordScoped' => 97,
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'SubExpression' => 202,
			'HashReference' => 81
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'Operator' => 111,
			'WordScoped' => 97,
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 203
		}
	},
	{#State 122
		DEFAULT => -40
	},
	{#State 123
		ACTIONS => {
			"\$TYPED_" => 204
		}
	},
	{#State 124
		ACTIONS => {
			";" => 205
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 206
		}
	},
	{#State 126
		DEFAULT => -42
	},
	{#State 127
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"while (" => -138,
			"undef" => 98,
			'WORD' => 23,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 107,
			"if (" => 121,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP03_MATH_INC_DEC' => 105,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP01_NAMED_VOID_SCOLON' => 102,
			"%{" => 101,
			'OP19_LOOP_CONTROL' => 100,
			'OP05_MATH_NEG_LPAREN' => 88,
			"for my integer" => -138,
			'OP01_NAMED_VOID' => 86,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_PRINT' => 84,
			'LBRACKET' => 83,
			"my" => 94,
			'OP01_NAMED' => 92,
			'OP01_CLOSE' => 115,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			"foreach my" => -138
		},
		GOTOS => {
			'VariableDeclaration' => 85,
			'OperatorVoid' => 112,
			'Operator' => 111,
			'SubExpression' => 82,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'VariableModification' => 109,
			'Expression' => 78,
			'Conditional' => 77,
			'Variable' => 80,
			'ArrayDereferenced' => 93,
			'Operation' => 208,
			'Literal' => 114,
			'PLUS-17' => 207,
			'HashDereferenced' => 89,
			'OPTIONAL-35' => 90,
			'WordScoped' => 97,
			'LoopLabel' => 96,
			'PAREN-34' => 118,
			'Statement' => 106
		}
	},
	{#State 128
		ACTIONS => {
			"use constant" => 44,
			"our hash_ref \$properties" => 209
		},
		GOTOS => {
			'Constant' => 211,
			'Properties' => 210
		}
	},
	{#State 129
		DEFAULT => -53
	},
	{#State 130
		DEFAULT => -76
	},
	{#State 131
		DEFAULT => -16
	},
	{#State 132
		ACTIONS => {
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'STDIN' => 213,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'Operator' => 111,
			'WordScoped' => 97,
			'Variable' => 160,
			'Expression' => 159,
			'SubExpression' => 214,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'SubExpressionOrStdin' => 212
		}
	},
	{#State 133
		DEFAULT => -83
	},
	{#State 134
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"\@{" => 91
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'HashDereferenced' => 89,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 215,
			'Expression' => 159,
			'Variable' => 160
		}
	},
	{#State 135
		ACTIONS => {
			'LPAREN' => 216
		}
	},
	{#State 136
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 217
		}
	},
	{#State 137
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP03_MATH_INC_DEC' => 105,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101
		},
		GOTOS => {
			'Operator' => 111,
			'WordScoped' => 97,
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 218,
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89
		}
	},
	{#State 138
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101,
			'OP03_MATH_INC_DEC' => 105,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			"undef" => 98,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'SubExpression' => 219,
			'HashReference' => 81,
			'Operator' => 111,
			'WordScoped' => 97
		}
	},
	{#State 139
		ACTIONS => {
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'SubExpression' => 220,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'Variable' => 160,
			'Expression' => 159,
			'Operator' => 111,
			'WordScoped' => 97
		}
	},
	{#State 140
		ACTIONS => {
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'HashDereferenced' => 89,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashReference' => 81,
			'SubExpression' => 221,
			'ArrayReference' => 110,
			'Expression' => 159,
			'Variable' => 160
		}
	},
	{#State 141
		ACTIONS => {
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98
		},
		GOTOS => {
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'SubExpression' => 222,
			'HashReference' => 81,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93
		}
	},
	{#State 142
		ACTIONS => {
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83
		},
		GOTOS => {
			'WordScoped' => 97,
			'Operator' => 111,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 223,
			'Expression' => 159,
			'Variable' => 160,
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'HashDereferenced' => 89
		}
	},
	{#State 143
		ACTIONS => {
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83
		},
		GOTOS => {
			'ArrayReference' => 110,
			'SubExpression' => 224,
			'HashReference' => 81,
			'Variable' => 160,
			'Expression' => 159,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114
		}
	},
	{#State 144
		ACTIONS => {
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"\@{" => 91
		},
		GOTOS => {
			'SubExpression' => 225,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'Variable' => 160,
			'Expression' => 159,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114
		}
	},
	{#State 145
		ACTIONS => {
			"undef" => 98,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'OP03_MATH_INC_DEC' => 105,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 226,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93
		}
	},
	{#State 146
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"\@{" => 91
		},
		GOTOS => {
			'Variable' => 160,
			'Expression' => 159,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 227,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93
		}
	},
	{#State 147
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			"\@{" => 91,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP03_MATH_INC_DEC' => 105
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'Operator' => 111,
			'WordScoped' => 97,
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 228
		}
	},
	{#State 148
		ACTIONS => {
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'Operator' => 111,
			'WordScoped' => 97,
			'Variable' => 160,
			'Expression' => 159,
			'SubExpression' => 229,
			'HashReference' => 81,
			'ArrayReference' => 110
		}
	},
	{#State 149
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 105,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'WordScoped' => 97,
			'Operator' => 111,
			'Expression' => 159,
			'Variable' => 160,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 230
		}
	},
	{#State 150
		ACTIONS => {
			'LITERAL_STRING' => 119,
			'LITERAL_NUMBER' => 104,
			'VARIABLE_SYMBOL' => 113
		},
		GOTOS => {
			'Literal' => 233,
			'Variable' => 231,
			'VariableOrLiteral' => 232
		}
	},
	{#State 151
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 105,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'SubExpression' => 234,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'Expression' => 159,
			'Variable' => 160,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114
		}
	},
	{#State 152
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 235,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93
		}
	},
	{#State 153
		ACTIONS => {
			"]" => 236
		}
	},
	{#State 154
		ACTIONS => {
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 105,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119
		},
		GOTOS => {
			'ArrayReference' => 110,
			'SubExpression' => 237,
			'HashReference' => 81,
			'Expression' => 159,
			'Variable' => 160,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114
		}
	},
	{#State 155
		DEFAULT => -179
	},
	{#State 156
		ACTIONS => {
			'WORD' => 239
		},
		GOTOS => {
			'PLUS-44' => 238
		}
	},
	{#State 157
		ACTIONS => {
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98
		},
		GOTOS => {
			'HashReference' => 81,
			'SubExpression' => 240,
			'ArrayReference' => 110,
			'Expression' => 159,
			'Variable' => 160,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114
		}
	},
	{#State 158
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 241
		}
	},
	{#State 159
		DEFAULT => -125
	},
	{#State 160
		ACTIONS => {
			")" => -128,
			'OP24_LOGICAL_OR_XOR' => -128,
			";" => -128,
			'OP12_COMPARE_EQ_NE' => -128,
			'OP06_REGEX_MATCH' => -128,
			'OP15_LOGICAL_AND' => -128,
			'OP08_STRING_CAT' => -128,
			'OP03_MATH_INC_DEC' => 133,
			'OP21_LIST_COMMA' => -128,
			'OP16_LOGICAL_OR' => -128,
			'OP07_MATH_MULT_DIV_MOD' => -128,
			'OP02_METHOD_THINARROW' => 135,
			'OP17_LIST_RANGE' => -128,
			'OP13_BITWISE_AND' => -128,
			'OP08_MATH_ADD_SUB' => -128,
			'OP09_BITWISE_SHIFT' => -128,
			'OP07_STRING_REPEAT' => -128,
			'OP04_MATH_POW' => -128,
			'OP11_COMPARE_LT_GT' => -128,
			'OP23_LOGICAL_AND' => -128,
			'OP18_TERNARY' => -128,
			"}" => -128,
			"]" => -128,
			'OP14_BITWISE_OR_XOR' => -128
		}
	},
	{#State 161
		ACTIONS => {
			")" => -177,
			'OP24_LOGICAL_OR_XOR' => 137,
			";" => -177,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP21_LIST_COMMA' => -177,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP17_LIST_RANGE' => 141,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP23_LOGICAL_AND' => 151,
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP18_TERNARY' => 150,
			"]" => -177,
			'OP14_BITWISE_OR_XOR' => 142
		}
	},
	{#State 162
		DEFAULT => -172,
		GOTOS => {
			'STAR-43' => 242
		}
	},
	{#State 163
		ACTIONS => {
			'LPAREN' => 195
		}
	},
	{#State 164
		DEFAULT => -106
	},
	{#State 165
		DEFAULT => -107
	},
	{#State 166
		ACTIONS => {
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 113,
			'OP01_QW' => 156,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			"my" => 158,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"undef" => 98,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101,
			'OP03_MATH_INC_DEC' => 105,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163
		},
		GOTOS => {
			'ListElement' => 162,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 161,
			'Variable' => 160,
			'Expression' => 159,
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'TypeInner' => 154,
			'ListElements' => 243,
			'HashDereferenced' => 89
		}
	},
	{#State 167
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"my" => 158,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 113,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'ListElements' => 244,
			'TypeInner' => 154,
			'HashDereferenced' => 89,
			'ListElement' => 162,
			'Operator' => 111,
			'WordScoped' => 97,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 161,
			'Variable' => 160,
			'Expression' => 159
		}
	},
	{#State 168
		ACTIONS => {
			";" => 245
		}
	},
	{#State 169
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 142,
			'OP23_LOGICAL_AND' => 151,
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP18_TERNARY' => 150,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 137,
			")" => 246
		}
	},
	{#State 170
		DEFAULT => -153
	},
	{#State 171
		DEFAULT => -152
	},
	{#State 172
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 247
		}
	},
	{#State 173
		ACTIONS => {
			'VARIABLE_SYMBOL' => 248
		}
	},
	{#State 174
		DEFAULT => -151
	},
	{#State 175
		DEFAULT => -140
	},
	{#State 176
		ACTIONS => {
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83
		},
		GOTOS => {
			'Expression' => 159,
			'Variable' => 160,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 249,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93
		}
	},
	{#State 177
		ACTIONS => {
			"}" => 250
		}
	},
	{#State 178
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 179
		ACTIONS => {
			'OP21_LIST_COMMA' => 252
		}
	},
	{#State 180
		ACTIONS => {
			'OP07_STRING_REPEAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP04_MATH_POW' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP21_LIST_COMMA' => -177,
			'OP12_COMPARE_EQ_NE' => -79,
			";" => -79,
			")" => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP16_LOGICAL_OR' => -79
		}
	},
	{#State 181
		ACTIONS => {
			'VARIABLE_SYMBOL' => 253
		}
	},
	{#State 182
		DEFAULT => -136
	},
	{#State 183
		ACTIONS => {
			")" => 254
		}
	},
	{#State 184
		ACTIONS => {
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_QW' => 156,
			"my" => 158,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			")" => -117,
			'LITERAL_STRING' => 119
		},
		GOTOS => {
			'Variable' => 160,
			'Expression' => 159,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 161,
			'Operator' => 111,
			'WordScoped' => 97,
			'ListElement' => 162,
			'HashDereferenced' => 89,
			'OPTIONAL-32' => 255,
			'Literal' => 114,
			'TypeInner' => 154,
			'ListElements' => 256,
			'ArrayDereferenced' => 93
		}
	},
	{#State 185
		ACTIONS => {
			'OP20_HASH_FATARROW' => 257
		}
	},
	{#State 186
		DEFAULT => -192,
		GOTOS => {
			'STAR-48' => 258
		}
	},
	{#State 187
		DEFAULT => -187
	},
	{#State 188
		DEFAULT => -194
	},
	{#State 189
		DEFAULT => -199
	},
	{#State 190
		ACTIONS => {
			";" => 259
		}
	},
	{#State 191
		ACTIONS => {
			"}" => 260
		}
	},
	{#State 192
		ACTIONS => {
			"}" => 261
		}
	},
	{#State 193
		ACTIONS => {
			'OP16_LOGICAL_OR' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			";" => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			")" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP18_TERNARY' => -93,
			"}" => -93,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			"]" => -93,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139
		}
	},
	{#State 194
		DEFAULT => -82
	},
	{#State 195
		ACTIONS => {
			")" => 262
		}
	},
	{#State 196
		ACTIONS => {
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			")" => 263,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP15_LOGICAL_AND' => 144,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP23_LOGICAL_AND' => 151,
			'OP18_TERNARY' => 150,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP17_LIST_RANGE' => 141,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148
		}
	},
	{#State 197
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 264
		}
	},
	{#State 198
		ACTIONS => {
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 105,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"my" => 158,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'TypeInner' => 154,
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'Expression' => 159,
			'Variable' => 160,
			'HashReference' => 81,
			'SubExpression' => 180,
			'ArrayReference' => 110,
			'WordScoped' => 97,
			'Operator' => 111,
			'ListElement' => 265
		}
	},
	{#State 199
		ACTIONS => {
			'OP21_LIST_COMMA' => -162,
			'OP15_LOGICAL_AND' => -162,
			'OP03_MATH_INC_DEC' => -162,
			'OP08_STRING_CAT' => -162,
			'OP06_REGEX_MATCH' => -162,
			'OP02_ARRAY_THINARROW' => 268,
			'OP12_COMPARE_EQ_NE' => -162,
			";" => -162,
			'OP24_LOGICAL_OR_XOR' => -162,
			")" => -162,
			'OP02_METHOD_THINARROW' => -162,
			'OP07_MATH_MULT_DIV_MOD' => -162,
			'OP16_LOGICAL_OR' => -162,
			'OP19_VARIABLE_ASSIGN_BY' => -162,
			'OP07_STRING_REPEAT' => -162,
			'OP09_BITWISE_SHIFT' => -162,
			'OP02_HASH_THINARROW' => 266,
			'OP08_MATH_ADD_SUB' => -162,
			'OP13_BITWISE_AND' => -162,
			'OP17_LIST_RANGE' => -162,
			'COLON' => -162,
			'OP14_BITWISE_OR_XOR' => -162,
			"]" => -162,
			'OP19_VARIABLE_ASSIGN' => -162,
			"}" => -162,
			'OP18_TERNARY' => -162,
			'OP23_LOGICAL_AND' => -162,
			'OP04_MATH_POW' => -162,
			'OP11_COMPARE_LT_GT' => -162
		},
		GOTOS => {
			'VariableRetrieval' => 267
		}
	},
	{#State 200
		DEFAULT => -81
	},
	{#State 201
		ACTIONS => {
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			";" => -103,
			")" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP21_LIST_COMMA' => -103,
			'OP12_COMPARE_EQ_NE' => 146,
			"}" => -103,
			'OP18_TERNARY' => 150,
			'OP11_COMPARE_LT_GT' => 152,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -103,
			"]" => -103,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139
		}
	},
	{#State 202
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -85,
			")" => -85,
			";" => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP18_TERNARY' => -85,
			"}" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			"]" => -85
		}
	},
	{#State 203
		ACTIONS => {
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP18_TERNARY' => 150,
			'OP11_COMPARE_LT_GT' => 152,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => 151,
			'OP14_BITWISE_OR_XOR' => 142,
			")" => 269,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138
		}
	},
	{#State 204
		ACTIONS => {
			'WORD_UPPERCASE' => 270
		}
	},
	{#State 205
		DEFAULT => -41
	},
	{#State 206
		ACTIONS => {
			'VARIABLE_SYMBOL' => 271
		}
	},
	{#State 207
		ACTIONS => {
			"\@{" => 91,
			'OP01_NAMED' => 92,
			'OP01_CLOSE' => 115,
			"my" => 94,
			"foreach my" => -138,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"for my integer" => -138,
			'OP01_NAMED_VOID' => 86,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_PRINT' => 84,
			"}" => 273,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			"if (" => 121,
			'WORD_UPPERCASE' => 107,
			'LPAREN' => 108,
			'OP01_NAMED_VOID_SCOLON' => 102,
			'OP19_LOOP_CONTROL' => 100,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP03_MATH_INC_DEC' => 105,
			'WORD' => 23,
			"undef" => 98,
			"while (" => -138,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'OperatorVoid' => 112,
			'Operator' => 111,
			'VariableDeclaration' => 85,
			'HashReference' => 81,
			'SubExpression' => 82,
			'ArrayReference' => 110,
			'Variable' => 80,
			'Expression' => 78,
			'Conditional' => 77,
			'VariableModification' => 109,
			'Operation' => 272,
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'OPTIONAL-35' => 90,
			'HashDereferenced' => 89,
			'WordScoped' => 97,
			'LoopLabel' => 96,
			'Statement' => 106,
			'PAREN-34' => 118
		}
	},
	{#State 208
		DEFAULT => -45
	},
	{#State 209
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 274
		}
	},
	{#State 210
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 275
		}
	},
	{#State 211
		DEFAULT => -55
	},
	{#State 212
		ACTIONS => {
			";" => 276
		}
	},
	{#State 213
		DEFAULT => -135
	},
	{#State 214
		ACTIONS => {
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP23_LOGICAL_AND' => 151,
			'OP18_TERNARY' => 150,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP17_LIST_RANGE' => 141,
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			";" => -134,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145
		}
	},
	{#State 215
		ACTIONS => {
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NE' => 146,
			";" => 277,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 150,
			'OP11_COMPARE_LT_GT' => 152,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => 151
		}
	},
	{#State 216
		ACTIONS => {
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'LITERAL_STRING' => 119,
			")" => -119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP03_MATH_INC_DEC' => 105,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"my" => 158,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'OPTIONAL-33' => 278,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'TypeInner' => 154,
			'ListElements' => 279,
			'Literal' => 114,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 161,
			'Expression' => 159,
			'Variable' => 160,
			'ListElement' => 162,
			'WordScoped' => 97,
			'Operator' => 111
		}
	},
	{#State 217
		DEFAULT => -87
	},
	{#State 218
		ACTIONS => {
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			")" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			";" => -105,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			"}" => -105,
			'OP18_TERNARY' => 150,
			"]" => -105,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP17_LIST_RANGE' => 141,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148
		}
	},
	{#State 219
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			")" => -89,
			";" => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			"]" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP04_MATH_POW' => 143,
			"}" => -89,
			'OP18_TERNARY' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP07_STRING_REPEAT' => 148,
			'OP17_LIST_RANGE' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89
		}
	},
	{#State 220
		ACTIONS => {
			'OP16_LOGICAL_OR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			";" => -92,
			")" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => -92,
			'OP06_REGEX_MATCH' => 136,
			'OP21_LIST_COMMA' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			"}" => -92,
			'OP18_TERNARY' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP04_MATH_POW' => 143,
			"]" => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => -92,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => -92
		}
	},
	{#State 221
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP18_TERNARY' => -97,
			"}" => -97,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -97,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => -97,
			"]" => -97,
			";" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			")" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP16_LOGICAL_OR' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 138
		}
	},
	{#State 222
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP21_LIST_COMMA' => -101,
			'OP15_LOGICAL_AND' => 144,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP24_LOGICAL_OR_XOR' => -101,
			")" => -101,
			";" => -101,
			'OP14_BITWISE_OR_XOR' => 142,
			"]" => -101,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => 152,
			"}" => -101,
			'OP18_TERNARY' => -101,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP17_LIST_RANGE' => undef,
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149
		}
	},
	{#State 223
		ACTIONS => {
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => -98,
			"]" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			"}" => -98,
			'OP11_COMPARE_LT_GT' => 152,
			'OP23_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 143,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP12_COMPARE_EQ_NE' => 146,
			";" => -98,
			")" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => -98
		}
	},
	{#State 224
		ACTIONS => {
			'OP16_LOGICAL_OR' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			";" => -84,
			'OP24_LOGICAL_OR_XOR' => -84,
			")" => -84,
			'OP21_LIST_COMMA' => -84,
			'OP08_STRING_CAT' => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP15_LOGICAL_AND' => -84,
			'OP12_COMPARE_EQ_NE' => -84,
			"}" => -84,
			'OP18_TERNARY' => -84,
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			"]" => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP13_BITWISE_AND' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP07_STRING_REPEAT' => -84,
			'OP09_BITWISE_SHIFT' => -84
		}
	},
	{#State 225
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP17_LIST_RANGE' => -99,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP18_TERNARY' => -99,
			"}" => -99,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => 152,
			"]" => -99,
			'OP14_BITWISE_OR_XOR' => 142,
			";" => -99,
			")" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP21_LIST_COMMA' => -99,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP16_LOGICAL_OR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 138
		}
	},
	{#State 226
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => -91,
			'OP08_STRING_CAT' => -91,
			'OP21_LIST_COMMA' => -91,
			")" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			";" => -91,
			"]" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP18_TERNARY' => -91,
			"}" => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP07_STRING_REPEAT' => 148,
			'OP17_LIST_RANGE' => -91,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => -91
		}
	},
	{#State 227
		ACTIONS => {
			'OP16_LOGICAL_OR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP24_LOGICAL_OR_XOR' => -96,
			")" => -96,
			";" => -96,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP21_LIST_COMMA' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -96,
			'OP11_COMPARE_LT_GT' => 152,
			"}" => -96,
			'OP18_TERNARY' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			"]" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => -96,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148
		}
	},
	{#State 228
		ACTIONS => {
			"}" => -100,
			'OP18_TERNARY' => -100,
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP23_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => 142,
			"]" => -100,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP17_LIST_RANGE' => -100,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP16_LOGICAL_OR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			";" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			")" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP12_COMPARE_EQ_NE' => 146
		}
	},
	{#State 229
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -88,
			'OP16_LOGICAL_OR' => -88,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => -88,
			'OP08_STRING_CAT' => -88,
			'OP21_LIST_COMMA' => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			";" => -88,
			")" => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			"]" => -88,
			'OP14_BITWISE_OR_XOR' => -88,
			'OP18_TERNARY' => -88,
			"}" => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -88,
			'OP07_STRING_REPEAT' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			'OP13_BITWISE_AND' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP17_LIST_RANGE' => -88
		}
	},
	{#State 230
		ACTIONS => {
			";" => -90,
			")" => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_STRING_CAT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP06_REGEX_MATCH' => 136,
			'OP21_LIST_COMMA' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP08_MATH_ADD_SUB' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => -90,
			"}" => -90,
			'OP18_TERNARY' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP04_MATH_POW' => 143,
			"]" => -90,
			'OP14_BITWISE_OR_XOR' => -90
		}
	},
	{#State 231
		DEFAULT => -203
	},
	{#State 232
		ACTIONS => {
			'COLON' => 280
		}
	},
	{#State 233
		DEFAULT => -204
	},
	{#State 234
		ACTIONS => {
			"]" => -104,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 152,
			"}" => -104,
			'OP18_TERNARY' => 150,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP21_LIST_COMMA' => -104,
			")" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			";" => -104
		}
	},
	{#State 235
		ACTIONS => {
			'OP17_LIST_RANGE' => -95,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => -95,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -95,
			'OP11_COMPARE_LT_GT' => undef,
			'OP18_TERNARY' => -95,
			"}" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			"]" => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			")" => -95,
			";" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 138
		}
	},
	{#State 236
		DEFAULT => -181
	},
	{#State 237
		ACTIONS => {
			'OP18_TERNARY' => 150,
			'OP11_COMPARE_LT_GT' => 152,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => 151,
			"]" => -178,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			";" => -178,
			")" => -178,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP21_LIST_COMMA' => -178,
			'OP12_COMPARE_EQ_NE' => 146
		}
	},
	{#State 238
		ACTIONS => {
			'WORD' => 282,
			")" => 281
		}
	},
	{#State 239
		DEFAULT => -174
	},
	{#State 240
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP08_STRING_CAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			";" => -79,
			")" => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			"]" => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			"}" => -79,
			'OP04_MATH_POW' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP17_LIST_RANGE' => -79
		}
	},
	{#State 241
		ACTIONS => {
			"\$TYPED_" => 283
		}
	},
	{#State 242
		ACTIONS => {
			")" => -175,
			";" => -175,
			"]" => -175,
			'OP21_LIST_COMMA' => 284
		},
		GOTOS => {
			'PAREN-42' => 285
		}
	},
	{#State 243
		ACTIONS => {
			";" => 286
		}
	},
	{#State 244
		ACTIONS => {
			";" => 287
		}
	},
	{#State 245
		DEFAULT => -112
	},
	{#State 246
		DEFAULT => -86
	},
	{#State 247
		ACTIONS => {
			'VARIABLE_SYMBOL' => 288
		}
	},
	{#State 248
		ACTIONS => {
			'LPAREN' => 289
		}
	},
	{#State 249
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 142,
			'OP23_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP04_MATH_POW' => 143,
			'OP18_TERNARY' => 150,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			")" => 290,
			'OP24_LOGICAL_OR_XOR' => 137
		}
	},
	{#State 250
		DEFAULT => -182
	},
	{#State 251
		DEFAULT => -183
	},
	{#State 252
		ACTIONS => {
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"my" => 158,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 105,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'SubExpression' => 161,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'Expression' => 159,
			'Variable' => 160,
			'ListElement' => 162,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'ListElements' => 291,
			'TypeInner' => 154,
			'Literal' => 114
		}
	},
	{#State 253
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 292,
			";" => 293
		}
	},
	{#State 254
		DEFAULT => -124
	},
	{#State 255
		ACTIONS => {
			")" => 294
		}
	},
	{#State 256
		DEFAULT => -116
	},
	{#State 257
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -185,
			'LBRACKET' => -185,
			'OP01_NAMED' => -185,
			'OP01_CLOSE' => -185,
			"my" => 158,
			"\@{" => -185,
			'WORD_SCOPED' => -185,
			'VARIABLE_SYMBOL' => -185,
			'LBRACE' => -185,
			'OP22_LOGICAL_NEG' => -185,
			'WORD' => -185,
			"undef" => -185,
			'WORD_UPPERCASE' => -185,
			'LPAREN' => -185,
			'LITERAL_STRING' => -185,
			'OP05_LOGICAL_NEG' => -185,
			'OP03_MATH_INC_DEC' => -185,
			"%{" => -185,
			'LITERAL_NUMBER' => -185,
			'OP10_NAMED_UNARY' => -185
		},
		GOTOS => {
			'TypeInner' => 296,
			'OPTIONAL-46' => 295
		}
	},
	{#State 258
		ACTIONS => {
			"}" => 297,
			'OP21_LIST_COMMA' => 298
		},
		GOTOS => {
			'PAREN-47' => 299
		}
	},
	{#State 259
		DEFAULT => -115
	},
	{#State 260
		DEFAULT => -195
	},
	{#State 261
		DEFAULT => -196
	},
	{#State 262
		DEFAULT => -122
	},
	{#State 263
		DEFAULT => -133
	},
	{#State 264
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"my" => 158,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 113,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'Expression' => 159,
			'Variable' => 160,
			'SubExpression' => 161,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'WordScoped' => 97,
			'Operator' => 111,
			'ListElement' => 162,
			'HashDereferenced' => 89,
			'ListElements' => 300,
			'TypeInner' => 154,
			'Literal' => 114,
			'ArrayDereferenced' => 93
		}
	},
	{#State 265
		ACTIONS => {
			'OP21_LIST_COMMA' => 301
		}
	},
	{#State 266
		ACTIONS => {
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 303,
			"undef" => 98,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'WordScoped' => 97,
			'Operator' => 111,
			'Expression' => 159,
			'Variable' => 160,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 302
		}
	},
	{#State 267
		DEFAULT => -160
	},
	{#State 268
		ACTIONS => {
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'OP03_MATH_INC_DEC' => 105,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			"undef" => 98,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99
		},
		GOTOS => {
			'ArrayReference' => 110,
			'SubExpression' => 304,
			'HashReference' => 81,
			'Variable' => 160,
			'Expression' => 159,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114
		}
	},
	{#State 269
		ACTIONS => {
			'LBRACE' => 306
		},
		GOTOS => {
			'CodeBlock' => 305
		}
	},
	{#State 270
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 307
		}
	},
	{#State 271
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 308
		}
	},
	{#State 272
		DEFAULT => -44
	},
	{#State 273
		ACTIONS => {
			";" => 309
		}
	},
	{#State 274
		ACTIONS => {
			'LBRACE' => 310
		}
	},
	{#State 275
		ACTIONS => {
			"our" => 311,
			'LITERAL_NUMBER' => 313
		},
		GOTOS => {
			'MethodOrSubroutine' => 315,
			'Method' => 314,
			'Subroutine' => 312
		}
	},
	{#State 276
		DEFAULT => -168
	},
	{#State 277
		DEFAULT => -169
	},
	{#State 278
		ACTIONS => {
			")" => 316
		}
	},
	{#State 279
		DEFAULT => -118
	},
	{#State 280
		ACTIONS => {
			'LITERAL_NUMBER' => 104,
			'VARIABLE_SYMBOL' => 113,
			'LITERAL_STRING' => 119
		},
		GOTOS => {
			'Literal' => 233,
			'VariableOrLiteral' => 317,
			'Variable' => 231
		}
	},
	{#State 281
		DEFAULT => -176
	},
	{#State 282
		DEFAULT => -173
	},
	{#State 283
		ACTIONS => {
			'WORD' => 318
		}
	},
	{#State 284
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			"my" => 158,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91
		},
		GOTOS => {
			'SubExpression' => 161,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'Expression' => 159,
			'Variable' => 160,
			'ListElement' => 319,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'TypeInner' => 154,
			'Literal' => 114
		}
	},
	{#State 285
		DEFAULT => -171
	},
	{#State 286
		DEFAULT => -110
	},
	{#State 287
		DEFAULT => -109
	},
	{#State 288
		ACTIONS => {
			'LPAREN' => 320
		}
	},
	{#State 289
		ACTIONS => {
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98
		},
		GOTOS => {
			'ArrayReference' => 110,
			'SubExpression' => 321,
			'HashReference' => 81,
			'Variable' => 160,
			'Expression' => 159,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114
		}
	},
	{#State 290
		ACTIONS => {
			'LBRACE' => 306
		},
		GOTOS => {
			'CodeBlock' => 322
		}
	},
	{#State 291
		ACTIONS => {
			";" => 323
		}
	},
	{#State 292
		ACTIONS => {
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98,
			'STDIN' => 213,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91
		},
		GOTOS => {
			'HashDereferenced' => 89,
			'SubExpressionOrStdin' => 324,
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'Variable' => 160,
			'Expression' => 159,
			'ArrayReference' => 110,
			'SubExpression' => 214,
			'HashReference' => 81,
			'Operator' => 111,
			'WordScoped' => 97
		}
	},
	{#State 293
		DEFAULT => -166
	},
	{#State 294
		DEFAULT => -121
	},
	{#State 295
		ACTIONS => {
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP03_MATH_INC_DEC' => 105,
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'Operator' => 111,
			'WordScoped' => 97,
			'Variable' => 160,
			'Expression' => 159,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 325
		}
	},
	{#State 296
		DEFAULT => -184
	},
	{#State 297
		DEFAULT => -193
	},
	{#State 298
		ACTIONS => {
			"%{" => 101,
			'WORD' => 185
		},
		GOTOS => {
			'HashDereferenced' => 187,
			'HashEntry' => 326
		}
	},
	{#State 299
		DEFAULT => -191
	},
	{#State 300
		ACTIONS => {
			")" => 327
		}
	},
	{#State 301
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP03_MATH_INC_DEC' => 105,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			"%{" => 101,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			"my" => 158,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_QW' => 156
		},
		GOTOS => {
			'SubExpression' => 161,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'Variable' => 160,
			'Expression' => 159,
			'ListElement' => 162,
			'Operator' => 111,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'ListElements' => 328,
			'TypeInner' => 154
		}
	},
	{#State 302
		ACTIONS => {
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP18_TERNARY' => 150,
			"}" => 329,
			'OP11_COMPARE_LT_GT' => 152,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => 151,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138
		}
	},
	{#State 303
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -197,
			"}" => 330,
			'LPAREN' => -197
		}
	},
	{#State 304
		ACTIONS => {
			'OP15_LOGICAL_AND' => 144,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			"]" => 331,
			'OP18_TERNARY' => 150,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 152
		}
	},
	{#State 305
		DEFAULT => -146,
		GOTOS => {
			'STAR-37' => 332
		}
	},
	{#State 306
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'OP19_LOOP_CONTROL' => 100,
			"%{" => 101,
			'OP01_NAMED_VOID_SCOLON' => 102,
			'OP03_MATH_INC_DEC' => 105,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 107,
			"if (" => 121,
			"undef" => 98,
			"while (" => -138,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"foreach my" => -138,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			"my" => 94,
			'OP01_NAMED' => 92,
			'OP01_CLOSE' => 115,
			'LBRACKET' => 83,
			"for my integer" => -138,
			'OP01_NAMED_VOID' => 86,
			'OP01_PRINT' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Operation' => 333,
			'Literal' => 114,
			'HashDereferenced' => 89,
			'OPTIONAL-35' => 90,
			'PLUS-40' => 334,
			'VariableDeclaration' => 85,
			'OperatorVoid' => 112,
			'Operator' => 111,
			'ArrayReference' => 110,
			'SubExpression' => 82,
			'HashReference' => 81,
			'VariableModification' => 109,
			'Conditional' => 77,
			'Expression' => 78,
			'Variable' => 80,
			'PAREN-34' => 118,
			'Statement' => 106,
			'WordScoped' => 97,
			'LoopLabel' => 96
		}
	},
	{#State 307
		DEFAULT => -202
	},
	{#State 308
		ACTIONS => {
			'OP21_LIST_COMMA' => 336,
			")" => 337
		},
		GOTOS => {
			'PAREN-18' => 335
		}
	},
	{#State 309
		DEFAULT => -46
	},
	{#State 310
		ACTIONS => {
			"}" => 341,
			'WORD' => 338,
			"%{" => 101
		},
		GOTOS => {
			'HashDereferenced' => 339,
			'HashEntryTyped' => 340
		}
	},
	{#State 311
		ACTIONS => {
			'WORD' => 56,
			'TYPE_METHOD' => 342
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 312
		DEFAULT => -75
	},
	{#State 313
		ACTIONS => {
			";" => 343
		}
	},
	{#State 314
		DEFAULT => -74
	},
	{#State 315
		DEFAULT => -57
	},
	{#State 316
		DEFAULT => -123
	},
	{#State 317
		DEFAULT => -102
	},
	{#State 318
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 344
		}
	},
	{#State 319
		DEFAULT => -170
	},
	{#State 320
		ACTIONS => {
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"my" => 158,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 113,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98
		},
		GOTOS => {
			'ListElements' => 345,
			'TypeInner' => 154,
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'WordScoped' => 97,
			'Operator' => 111,
			'ListElement' => 162,
			'Expression' => 159,
			'Variable' => 160,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 161
		}
	},
	{#State 321
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 150,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => 346,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP15_LOGICAL_AND' => 144,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP24_LOGICAL_OR_XOR' => 137
		}
	},
	{#State 322
		DEFAULT => -156
	},
	{#State 323
		DEFAULT => -113
	},
	{#State 324
		ACTIONS => {
			";" => 347
		}
	},
	{#State 325
		ACTIONS => {
			'OP18_TERNARY' => 150,
			"}" => -186,
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP23_LOGICAL_AND' => 151,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => 144,
			'OP08_STRING_CAT' => 145,
			'OP21_LIST_COMMA' => -186,
			'OP12_COMPARE_EQ_NE' => 146
		}
	},
	{#State 326
		DEFAULT => -190
	},
	{#State 327
		DEFAULT => -78
	},
	{#State 328
		ACTIONS => {
			")" => 348
		}
	},
	{#State 329
		DEFAULT => -164
	},
	{#State 330
		DEFAULT => -165
	},
	{#State 331
		DEFAULT => -163
	},
	{#State 332
		ACTIONS => {
			'LBRACE' => -149,
			"while (" => -149,
			"undef" => -149,
			'WORD' => -149,
			'LPAREN' => -149,
			'WORD_UPPERCASE' => -149,
			"elsif (" => 353,
			'OP03_MATH_INC_DEC' => -149,
			'LITERAL_NUMBER' => -149,
			'OP10_NAMED_UNARY' => -149,
			"%{" => -149,
			'OP19_LOOP_CONTROL' => -149,
			'OP01_NAMED_VOID_SCOLON' => -149,
			'OP05_MATH_NEG_LPAREN' => -149,
			"for my integer" => -149,
			'OP19_LOOP_CONTROL_SCOLON' => -149,
			'OP01_PRINT' => -149,
			'OP01_NAMED_VOID' => -149,
			'LBRACKET' => -149,
			"my" => -149,
			'OP01_NAMED' => -149,
			"\@{" => -149,
			"foreach my" => -149,
			'OP22_LOGICAL_NEG' => -149,
			"if (" => -149,
			'OP05_LOGICAL_NEG' => -149,
			'LITERAL_STRING' => -149,
			"}" => -149,
			"else" => 350,
			'' => -149,
			'OP01_CLOSE' => -149,
			'WORD_SCOPED' => -149,
			'VARIABLE_SYMBOL' => -149
		},
		GOTOS => {
			'OPTIONAL-39' => 351,
			'PAREN-38' => 352,
			'PAREN-36' => 349
		}
	},
	{#State 333
		DEFAULT => -158
	},
	{#State 334
		ACTIONS => {
			'WORD' => 23,
			"undef" => 98,
			"while (" => -138,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'OP19_LOOP_CONTROL' => 100,
			'OP01_NAMED_VOID_SCOLON' => 102,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			"if (" => 121,
			'WORD_UPPERCASE' => 107,
			'LPAREN' => 108,
			'LBRACKET' => 83,
			'OP01_NAMED_VOID' => 86,
			"for my integer" => -138,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_PRINT' => 84,
			"}" => 354,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 113,
			"foreach my" => -138,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 92,
			"my" => 94
		},
		GOTOS => {
			'Statement' => 106,
			'PAREN-34' => 118,
			'WordScoped' => 97,
			'LoopLabel' => 96,
			'Operation' => 355,
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'OPTIONAL-35' => 90,
			'HashDereferenced' => 89,
			'Operator' => 111,
			'OperatorVoid' => 112,
			'VariableDeclaration' => 85,
			'SubExpression' => 82,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'Variable' => 80,
			'Expression' => 78,
			'VariableModification' => 109,
			'Conditional' => 77
		}
	},
	{#State 335
		DEFAULT => -48
	},
	{#State 336
		ACTIONS => {
			"my" => 356
		}
	},
	{#State 337
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 357
		}
	},
	{#State 338
		ACTIONS => {
			'OP20_HASH_FATARROW' => 358
		}
	},
	{#State 339
		DEFAULT => -189
	},
	{#State 340
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 359
		}
	},
	{#State 341
		ACTIONS => {
			";" => 360
		}
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 361
		}
	},
	{#State 343
		DEFAULT => -59
	},
	{#State 344
		DEFAULT => -201
	},
	{#State 345
		ACTIONS => {
			")" => 362
		}
	},
	{#State 346
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_NUMBER' => 104,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'Operator' => 111,
			'WordScoped' => 97,
			'Variable' => 160,
			'Expression' => 159,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 363
		}
	},
	{#State 347
		DEFAULT => -167
	},
	{#State 348
		ACTIONS => {
			'OP01_OPEN' => 364
		}
	},
	{#State 349
		DEFAULT => -145
	},
	{#State 350
		ACTIONS => {
			'LBRACE' => 306
		},
		GOTOS => {
			'CodeBlock' => 365
		}
	},
	{#State 351
		DEFAULT => -150
	},
	{#State 352
		DEFAULT => -148
	},
	{#State 353
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 101,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 163,
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"undef" => 98,
			'WORD' => 23
		},
		GOTOS => {
			'ArrayDereferenced' => 93,
			'Literal' => 114,
			'HashDereferenced' => 89,
			'WordScoped' => 97,
			'Operator' => 111,
			'SubExpression' => 366,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'Expression' => 159,
			'Variable' => 160
		}
	},
	{#State 354
		DEFAULT => -159
	},
	{#State 355
		DEFAULT => -157
	},
	{#State 356
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 367
		}
	},
	{#State 357
		ACTIONS => {
			"\@_;" => 368
		}
	},
	{#State 358
		ACTIONS => {
			"my" => 158
		},
		GOTOS => {
			'TypeInner' => 369
		}
	},
	{#State 359
		ACTIONS => {
			'OP21_LIST_COMMA' => 370,
			"}" => 371
		},
		GOTOS => {
			'PAREN-24' => 372
		}
	},
	{#State 360
		DEFAULT => -64
	},
	{#State 361
		ACTIONS => {
			"= sub {" => 373
		}
	},
	{#State 362
		ACTIONS => {
			'LBRACE' => 306
		},
		GOTOS => {
			'CodeBlock' => 374
		}
	},
	{#State 363
		ACTIONS => {
			")" => 375,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP08_STRING_CAT' => 145,
			'OP06_REGEX_MATCH' => 136,
			'OP15_LOGICAL_AND' => 144,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP17_LIST_RANGE' => undef,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP11_COMPARE_LT_GT' => 152,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP14_BITWISE_OR_XOR' => 142
		}
	},
	{#State 364
		ACTIONS => {
			"my" => 376
		}
	},
	{#State 365
		DEFAULT => -147
	},
	{#State 366
		ACTIONS => {
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP24_LOGICAL_OR_XOR' => 137,
			")" => 377,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP13_BITWISE_AND' => 140,
			'OP08_MATH_ADD_SUB' => 149,
			'OP17_LIST_RANGE' => 141,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP18_TERNARY' => 150,
			'OP04_MATH_POW' => 143,
			'OP11_COMPARE_LT_GT' => 152,
			'OP23_LOGICAL_AND' => 151
		}
	},
	{#State 367
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 368
		DEFAULT => -50
	},
	{#State 369
		ACTIONS => {
			'WORD' => 23,
			"undef" => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP03_MATH_INC_DEC' => 105,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_NAMED' => 157,
			'OP01_CLOSE' => 115
		},
		GOTOS => {
			'Expression' => 159,
			'Variable' => 160,
			'SubExpression' => 379,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'WordScoped' => 97,
			'Operator' => 111,
			'HashDereferenced' => 89,
			'Literal' => 114,
			'ArrayDereferenced' => 93
		}
	},
	{#State 370
		ACTIONS => {
			"%{" => 101,
			'WORD' => 338
		},
		GOTOS => {
			'HashDereferenced' => 339,
			'HashEntryTyped' => 380
		}
	},
	{#State 371
		ACTIONS => {
			";" => 381
		}
	},
	{#State 372
		DEFAULT => -61
	},
	{#State 373
		ACTIONS => {
			'OP01_CLOSE' => -66,
			'OP01_NAMED' => -66,
			"my" => -66,
			"\@{" => -66,
			'LPAREN_MY' => 384,
			'WORD_SCOPED' => -66,
			'VARIABLE_SYMBOL' => -66,
			"foreach my" => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"for my integer" => -66,
			'OP01_PRINT' => -66,
			'OP01_NAMED_VOID' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'LBRACKET' => -66,
			"if (" => -66,
			'WORD_UPPERCASE' => -66,
			'LPAREN' => -66,
			'LITERAL_STRING' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP19_LOOP_CONTROL' => -66,
			"%{" => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LITERAL_NUMBER' => -66,
			'OP10_NAMED_UNARY' => -66,
			'LBRACE' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'WORD' => -66,
			"while (" => -66,
			"undef" => -66
		},
		GOTOS => {
			'MethodArguments' => 382,
			'OPTIONAL-26' => 383
		}
	},
	{#State 374
		DEFAULT => -155
	},
	{#State 375
		ACTIONS => {
			'LBRACE' => 306
		},
		GOTOS => {
			'CodeBlock' => 385
		}
	},
	{#State 376
		ACTIONS => {
			"filehandle_ref" => 386
		}
	},
	{#State 377
		ACTIONS => {
			'LBRACE' => 306
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 378
		DEFAULT => -47
	},
	{#State 379
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 146,
			'OP21_LIST_COMMA' => -188,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 138,
			'OP16_LOGICAL_OR' => 147,
			'OP09_BITWISE_SHIFT' => 139,
			'OP07_STRING_REPEAT' => 148,
			'OP17_LIST_RANGE' => 141,
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP14_BITWISE_OR_XOR' => 142,
			'OP11_COMPARE_LT_GT' => 152,
			'OP23_LOGICAL_AND' => 151,
			'OP04_MATH_POW' => 143,
			'OP18_TERNARY' => 150,
			"}" => -188
		}
	},
	{#State 380
		DEFAULT => -60
	},
	{#State 381
		DEFAULT => -63
	},
	{#State 382
		DEFAULT => -65
	},
	{#State 383
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 119,
			'LPAREN' => 108,
			"if (" => 121,
			'WORD_UPPERCASE' => 107,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_NAMED_VOID_SCOLON' => 102,
			'OP19_LOOP_CONTROL' => 100,
			"%{" => 101,
			'OP03_MATH_INC_DEC' => 105,
			"undef" => 98,
			"while (" => -138,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 117,
			'LBRACE' => 99,
			"\@{" => 91,
			"my" => 94,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 92,
			"foreach my" => -138,
			'VARIABLE_SYMBOL' => 113,
			'WORD_SCOPED' => 24,
			"for my integer" => -138,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_PRINT' => 84,
			'OP01_NAMED_VOID' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 83
		},
		GOTOS => {
			'OperatorVoid' => 112,
			'Operator' => 111,
			'VariableDeclaration' => 85,
			'PLUS-27' => 388,
			'Variable' => 80,
			'Expression' => 78,
			'VariableModification' => 109,
			'Conditional' => 77,
			'HashReference' => 81,
			'ArrayReference' => 110,
			'SubExpression' => 82,
			'Literal' => 114,
			'Operation' => 389,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'OPTIONAL-35' => 90,
			'WordScoped' => 97,
			'LoopLabel' => 96,
			'Statement' => 106,
			'PAREN-34' => 118
		}
	},
	{#State 384
		ACTIONS => {
			'TYPE_SELF' => 390
		}
	},
	{#State 385
		DEFAULT => -154
	},
	{#State 386
		ACTIONS => {
			'FH_REF_SYMBOL' => 391
		}
	},
	{#State 387
		DEFAULT => -144
	},
	{#State 388
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 105,
			'OP01_NAMED_VOID_SCOLON' => 102,
			"%{" => 101,
			'OP19_LOOP_CONTROL' => 100,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD_UPPERCASE' => 107,
			"if (" => 121,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"while (" => -138,
			"undef" => 98,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			"foreach my" => -138,
			'OP01_NAMED' => 92,
			'OP01_CLOSE' => 115,
			"my" => 94,
			"\@{" => 91,
			'LBRACKET' => 83,
			"}" => 393,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_PRINT' => 84,
			"for my integer" => -138,
			'OP01_NAMED_VOID' => 86,
			'OP19_LOOP_CONTROL_SCOLON' => 87
		},
		GOTOS => {
			'Statement' => 106,
			'PAREN-34' => 118,
			'LoopLabel' => 96,
			'WordScoped' => 97,
			'HashDereferenced' => 89,
			'OPTIONAL-35' => 90,
			'Literal' => 114,
			'Operation' => 392,
			'ArrayDereferenced' => 93,
			'Variable' => 80,
			'VariableModification' => 109,
			'Expression' => 78,
			'Conditional' => 77,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 82,
			'OperatorVoid' => 112,
			'Operator' => 111,
			'VariableDeclaration' => 85
		}
	},
	{#State 389
		DEFAULT => -68
	},
	{#State 390
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 394
		}
	},
	{#State 391
		ACTIONS => {
			'OP21_LIST_COMMA' => 395
		}
	},
	{#State 392
		DEFAULT => -67
	},
	{#State 393
		ACTIONS => {
			";" => 396
		}
	},
	{#State 394
		ACTIONS => {
			")" => 399,
			'OP21_LIST_COMMA' => 398
		},
		GOTOS => {
			'PAREN-28' => 397
		}
	},
	{#State 395
		ACTIONS => {
			'LITERAL_STRING' => 400
		}
	},
	{#State 396
		DEFAULT => -69
	},
	{#State 397
		DEFAULT => -71
	},
	{#State 398
		ACTIONS => {
			"my" => 401
		}
	},
	{#State 399
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 402
		}
	},
	{#State 400
		ACTIONS => {
			'OP21_LIST_COMMA' => 403
		}
	},
	{#State 401
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 404
		}
	},
	{#State 402
		ACTIONS => {
			"\@_;" => 405
		}
	},
	{#State 403
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 105,
			"%{" => 101,
			'LITERAL_NUMBER' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD_UPPERCASE' => 163,
			'LPAREN' => 108,
			'LITERAL_STRING' => 119,
			'OP05_LOGICAL_NEG' => 120,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 117,
			'WORD' => 23,
			"undef" => 98,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 113,
			'OP01_CLOSE' => 115,
			'OP01_NAMED' => 157,
			"\@{" => 91,
			'LBRACKET' => 83,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayDereferenced' => 93,
			'HashDereferenced' => 89,
			'WordScoped' => 97,
			'Operator' => 111,
			'Expression' => 159,
			'Variable' => 160,
			'ArrayReference' => 110,
			'HashReference' => 81,
			'SubExpression' => 406
		}
	},
	{#State 404
		ACTIONS => {
			'VARIABLE_SYMBOL' => 407
		}
	},
	{#State 405
		DEFAULT => -73
	},
	{#State 406
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 149,
			'OP13_BITWISE_AND' => 140,
			'OP17_LIST_RANGE' => 141,
			'OP07_STRING_REPEAT' => 148,
			'OP09_BITWISE_SHIFT' => 139,
			'OP18_TERNARY' => 150,
			"}" => -80,
			'OP11_COMPARE_LT_GT' => 152,
			'OP04_MATH_POW' => 143,
			'OP23_LOGICAL_AND' => -80,
			"]" => -80,
			'OP14_BITWISE_OR_XOR' => 142,
			";" => -80,
			")" => -80,
			'OP24_LOGICAL_OR_XOR' => -80,
			'OP15_LOGICAL_AND' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP08_STRING_CAT' => 145,
			'OP21_LIST_COMMA' => -80,
			'OP12_COMPARE_EQ_NE' => 146,
			'OP16_LOGICAL_OR' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 138
		}
	},
	{#State 407
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5674 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5681 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5688 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5695 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5706 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5717 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5724 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5731 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5738 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5745 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5752 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5759 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5766 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5773 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5780 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5787 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5794 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5801 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5812 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5819 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5826 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5837 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5859 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5866 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5880 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5887 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5894 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5901 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5926 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5998 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6009 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6016 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6062 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6069 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6080 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6094 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6161 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6168 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6229 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6236 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6243 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6250 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6272 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6283 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6294 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6305 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6316 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6327 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 14,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6338 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6349 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6360 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6371 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6382 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6393 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6404 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6415 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6426 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6437 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6448 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6459 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6470 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6492 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6514 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6525 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6536 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6547 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6558 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6569 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6580 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6591 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6602 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6613 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6620 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6627 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_109
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6645 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6678 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6689 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6711 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6718 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6725 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6732 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6739 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_120
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6750 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6761 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_125
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6849 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6860 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_134
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6929 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_139
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6998 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7033 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_150
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_151
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7077 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_154
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_155
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7099 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_156
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7110 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7117 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7124 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_159
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7135 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7142 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7149 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_162
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7160 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_163
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7182 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7193 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_166
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7204 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_168
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7226 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7237 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7244 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7251 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7265 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7272 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_175
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7283 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_176
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7323 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7330 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_181
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7341 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_182
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_183
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7377 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_186
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7388 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_187
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7399 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_188
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_189
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7428 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7435 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7442 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_193
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7453 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_194
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7464 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_195
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7486 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_197
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_199
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule Type_200
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_201
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_202
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7552 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_203
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_204
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_205
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_206
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	]
],
#line 7599 lib/RPerl/Grammar.pm
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_109', 
         'OperatorVoid_110', 
         'OperatorVoid_111', 
         'OperatorVoid_112', 
         'OperatorVoid_113', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_120', 
         'Expression_121', 
         'Expression_122', 
         'Expression_123', 
         'Expression_124', 
         'SubExpression_125', 
         'SubExpression_126', 
         'SubExpression_127', 
         'SubExpression_128', 
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpressionOrStdin_134', 
         'SubExpressionOrStdin_135', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_139', 
         'Statement_140', 
         'Statement_141', 
         'Statement_142', 
         'Statement_143', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_150', 
         'Loop_151', 
         'Loop_152', 
         'Loop_153', 
         'LoopFor_154', 
         'LoopForEach_155', 
         'LoopWhile_156', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_159', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_162', 
         'VariableRetrieval_163', 
         'VariableRetrieval_164', 
         'VariableRetrieval_165', 
         'VariableDeclaration_166', 
         'VariableDeclaration_167', 
         'VariableModification_168', 
         'VariableModification_169', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_175', 
         'ListElements_176', 
         'ListElement_177', 
         'ListElement_178', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_181', 
         'ArrayDereferenced_182', 
         'ArrayDereferenced_183', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_186', 
         'HashEntry_187', 
         'HashEntryTyped_188', 
         'HashEntryTyped_189', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_193', 
         'HashReference_194', 
         'HashDereferenced_195', 
         'HashDereferenced_196', 
         'WordScoped_197', 
         'WordScoped_198', 
         'LoopLabel_199', 
         'Type_200', 
         'TypeInner_201', 
         'TypeInnerConstant_202', 
         'VariableOrLiteral_203', 
         'VariableOrLiteral_204', 
         'Literal_205', 
         'Literal_206', );
  $self;
}

#line 203 "lib/RPerl/Grammar.eyp"


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


#line 7854 lib/RPerl/Grammar.pm



1;
