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
    our $VERSION = 0.000_974;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\=\ sub\ \{|\$TYPED_|elsif\ \(|package|while\ \(|undef|else|if\ \(|our|qw\(|use|\@_\;|\@\{|my|\%\{|\]|\)|\}|\;)}gc and return ($1, $1);

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
  [ '_PAREN' => 'PAREN-36', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Conditional_151' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-37', 'OPTIONAL-39' ], 0 ],
  [ 'Loop_152' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_153' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_154' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_155' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_156' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_157' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
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
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'WORD' ], 0 ],
  [ 'ListElements_176' => 'ListElements', [ 'ListElement', 'STAR-43' ], 0 ],
  [ 'ListElements_177' => 'ListElements', [ 'OP01_QW', 'PLUS-44', ')' ], 0 ],
  [ 'ListElement_178' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_179' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
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
  [ 'TypeInner_202' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_203' => 'TypeInnerConstant', [ 'my', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_204' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_205' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'Literal_206' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_207' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  '_PLUS_LIST' => 174,
  '_PLUS_LIST' => 175,
  'ListElements_176' => 176,
  'ListElements_177' => 177,
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
  'TypeInner_202' => 202,
  'TypeInnerConstant_203' => 203,
  'VariableOrLiteral_204' => 204,
  'VariableOrLiteral_205' => 205,
  'Literal_206' => 206,
  'Literal_207' => 207,
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
			"## no critic qw(" => 9,
			"package" => -20,
			'SHEBANG' => 3
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'CompileUnit' => 6,
			'PLUS-2' => 8,
			'Critic' => 1,
			'Program' => 2,
			'PAREN-1' => 7,
			'OPTIONAL-9' => 4
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'OPTIONAL-3' => 11,
			'Critic' => 10
		}
	},
	{#State 4
		ACTIONS => {
			"package" => 12
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => -25,
			"our" => -25,
			"use constant" => -25,
			"use" => -25,
			"use parent qw(" => 13
		},
		GOTOS => {
			'Class' => 14,
			'STAR-10' => 17,
			'Module' => 16,
			'Package' => 15
		}
	},
	{#State 6
		ACTIONS => {
			'' => 18
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 9,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'Critic' => 1,
			'OPTIONAL-9' => 4,
			'PAREN-1' => 19
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-14' => 21
		}
	},
	{#State 10
		DEFAULT => -6
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
			'WORD' => 26,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		DEFAULT => -22
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			"use constant" => -27,
			"our" => -27,
			"use" => -27,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'STAR-11' => 28,
			'Critic' => 29
		}
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			")" => 31,
			'WORD' => 30
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
		DEFAULT => -199
	},
	{#State 25
		ACTIONS => {
			";" => 34
		}
	},
	{#State 26
		DEFAULT => -198
	},
	{#State 27
		ACTIONS => {
			")" => 35
		}
	},
	{#State 28
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 37
		},
		GOTOS => {
			'Include' => 36,
			'STAR-12' => 38
		}
	},
	{#State 29
		DEFAULT => -24
	},
	{#State 30
		DEFAULT => -34
	},
	{#State 31
		DEFAULT => -36
	},
	{#State 32
		ACTIONS => {
			'OP01_PRINT' => -11,
			"undef" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"while (" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP10_NAMED_UNARY' => -11,
			'LBRACE' => -11,
			'OP01_NAMED_VOID' => -11,
			'WORD' => -11,
			"## no critic qw(" => 9,
			'WORD_UPPERCASE' => -11,
			"foreach my" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_NAMED' => -11,
			"use constant" => -11,
			'OP01_OPEN' => -11,
			'LITERAL_STRING' => -11,
			'LPAREN' => -11,
			"%{" => -11,
			"use" => -11,
			'LBRACKET' => -11,
			"for my integer" => -11,
			"\@{" => -11,
			'WORD_SCOPED' => -11,
			"my" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"if (" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_CLOSE' => -11,
			"our" => -11
		},
		GOTOS => {
			'STAR-5' => 39,
			'Critic' => 40
		}
	},
	{#State 33
		ACTIONS => {
			"use RPerl;" => 41
		}
	},
	{#State 34
		ACTIONS => {
			"use strict;" => 23
		},
		GOTOS => {
			'Header' => 42
		}
	},
	{#State 35
		ACTIONS => {
			";" => 43
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 44
		}
	},
	{#State 38
		ACTIONS => {
			"use constant" => 48,
			"our" => 45
		},
		GOTOS => {
			'Constant' => 46,
			'Subroutine' => 49,
			'PLUS-13' => 47
		}
	},
	{#State 39
		ACTIONS => {
			'WORD' => -13,
			'WORD_UPPERCASE' => -13,
			"foreach my" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"undef" => -13,
			"while (" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LBRACE' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"if (" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_CLOSE' => -13,
			"our" => -13,
			"use constant" => -13,
			'OP01_NAMED' => -13,
			'OP01_OPEN' => -13,
			'LITERAL_STRING' => -13,
			'LPAREN' => -13,
			"%{" => -13,
			"use" => 37,
			"for my integer" => -13,
			'LBRACKET' => -13,
			"\@{" => -13,
			'WORD_SCOPED' => -13,
			"my" => -13
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
		DEFAULT => -21
	},
	{#State 43
		ACTIONS => {
			"use" => 37
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 44
		ACTIONS => {
			";" => 55,
			"qw(" => 54
		}
	},
	{#State 45
		ACTIONS => {
			'WORD' => 57
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
			'Subroutine' => 58
		}
	},
	{#State 48
		ACTIONS => {
			'WORD_UPPERCASE' => 60
		}
	},
	{#State 49
		DEFAULT => -31
	},
	{#State 50
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LITERAL_NUMBER' => -15,
			"if (" => -15,
			'OP19_LOOP_CONTROL' => -15,
			"our" => -15,
			'OP01_CLOSE' => -15,
			"use constant" => 48,
			'OP01_NAMED' => -15,
			'OP01_OPEN' => -15,
			"%{" => -15,
			'LITERAL_STRING' => -15,
			'LPAREN' => -15,
			'LBRACKET' => -15,
			"for my integer" => -15,
			"my" => -15,
			"\@{" => -15,
			'WORD_SCOPED' => -15,
			'WORD' => -15,
			'WORD_UPPERCASE' => -15,
			"foreach my" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"undef" => -15,
			'OP01_PRINT' => -15,
			"while (" => -15,
			'OP01_NAMED_VOID' => -15,
			'LBRACE' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY' => -15
		},
		GOTOS => {
			'Constant' => 62,
			'STAR-7' => 61
		}
	},
	{#State 51
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 63
		}
	},
	{#State 53
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 64
		}
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
		DEFAULT => -39
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		}
	},
	{#State 57
		DEFAULT => -201
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
		ACTIONS => {
			"for my integer" => -139,
			'LBRACKET' => 93,
			"my" => 89,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP01_NAMED' => 100,
			'OP01_OPEN' => 102,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			'OP01_CLOSE' => 107,
			"our" => 45,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LITERAL_NUMBER' => 108,
			"if (" => 112,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_NAMED_VOID' => 71,
			'LBRACE' => 70,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_PRINT' => 78,
			"while (" => -139,
			"foreach my" => -139,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'WORD_UPPERCASE' => 85
		},
		GOTOS => {
			'OperatorVoid' => 95,
			'Operator' => 94,
			'Statement' => 92,
			'PAREN-34' => 72,
			'ArrayDereferenced' => 90,
			'HashReference' => 101,
			'VariableModification' => 79,
			'WordScoped' => 77,
			'LoopLabel' => 98,
			'Expression' => 84,
			'HashDereferenced' => 106,
			'VariableDeclaration' => 105,
			'OPTIONAL-35' => 81,
			'Variable' => 104,
			'Conditional' => 103,
			'Operation' => 87,
			'Literal' => 88,
			'PLUS-8' => 110,
			'ArrayReference' => 111,
			'Subroutine' => 109,
			'SubExpression' => 86
		}
	},
	{#State 62
		DEFAULT => -12
	},
	{#State 63
		DEFAULT => -33
	},
	{#State 64
		ACTIONS => {
			"use constant" => -54,
			"use" => -54,
			"our hash_ref \$properties" => -54,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 117,
			'STAR-21' => 116
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
			"my" => 121
		},
		GOTOS => {
			'TypeInnerConstant' => 122
		}
	},
	{#State 70
		ACTIONS => {
			"%{" => 96,
			"}" => 123,
			'WORD' => 124
		},
		GOTOS => {
			'HashEntry' => 126,
			'HashDereferenced' => 125
		}
	},
	{#State 71
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP01_QW' => 131,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			'LBRACKET' => 93,
			"my" => 136,
			'LBRACE' => 70,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74
		},
		GOTOS => {
			'HashReference' => 101,
			'TypeInner' => 133,
			'ListElement' => 130,
			'WordScoped' => 77,
			'ListElements' => 129,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 127,
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 90
		}
	},
	{#State 72
		DEFAULT => -138
	},
	{#State 73
		ACTIONS => {
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 80,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107
		},
		GOTOS => {
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 137,
			'HashReference' => 101,
			'WordScoped' => 77,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106
		}
	},
	{#State 74
		ACTIONS => {
			'LITERAL_NUMBER' => 108,
			";" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_CLOSE' => 107,
			'OP24_LOGICAL_OR_XOR' => -95,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"]" => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP06_REGEX_MATCH' => -95,
			"%{" => 96,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'OP13_BITWISE_AND' => -95,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP11_COMPARE_LT_GT' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'LBRACKET' => 93,
			'OP08_STRING_CAT' => -95,
			'WORD_UPPERCASE' => 128,
			'OP04_MATH_POW' => -95,
			'OP07_STRING_REPEAT' => -95,
			'WORD' => 26,
			"}" => -95,
			'OP21_LIST_COMMA' => -95,
			'VARIABLE_SYMBOL' => 80,
			'OP03_MATH_INC_DEC' => 82,
			'OP18_TERNARY' => -95,
			")" => -95,
			'OP15_LOGICAL_AND' => -95,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70,
			'OP17_LIST_RANGE' => -95,
			'OP23_LOGICAL_AND' => -95
		},
		GOTOS => {
			'WordScoped' => 77,
			'HashReference' => 101,
			'ArrayReference' => 111,
			'SubExpression' => 138,
			'Literal' => 88,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132,
			'ArrayDereferenced' => 90,
			'Variable' => 134
		}
	},
	{#State 75
		DEFAULT => -127
	},
	{#State 76
		ACTIONS => {
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Literal' => 88,
			'SubExpression' => 139,
			'ArrayReference' => 111,
			'HashReference' => 101,
			'WordScoped' => 77
		}
	},
	{#State 77
		ACTIONS => {
			'LPAREN' => 141,
			'OP02_METHOD_THINARROW_NEW' => 140
		}
	},
	{#State 78
		ACTIONS => {
			'OP01_CLOSE' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP01_QW' => -109,
			'VARIABLE_SYMBOL' => -109,
			'STDOUT_STDERR' => 142,
			'WORD' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'WORD_UPPERCASE' => -109,
			'LITERAL_NUMBER' => -109,
			'LBRACKET' => -109,
			'FH_REF_SYMBOL_BRACES' => 145,
			'OP10_NAMED_UNARY' => -109,
			'WORD_SCOPED' => -109,
			"\@{" => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LBRACE' => -109,
			"my" => -109,
			'OP01_OPEN' => -109,
			'OP01_NAMED' => -109,
			"undef" => -109,
			'OP05_LOGICAL_NEG' => -109,
			'LPAREN' => -109,
			'LITERAL_STRING' => -109,
			"%{" => -109
		},
		GOTOS => {
			'PAREN-30' => 143,
			'OPTIONAL-31' => 144
		}
	},
	{#State 79
		DEFAULT => -144
	},
	{#State 80
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 146
		}
	},
	{#State 81
		ACTIONS => {
			"while (" => 147,
			"for my integer" => 152,
			"foreach my" => 148
		},
		GOTOS => {
			'LoopForEach' => 149,
			'LoopWhile' => 151,
			'Loop' => 150,
			'LoopFor' => 153
		}
	},
	{#State 82
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Variable' => 154
		}
	},
	{#State 83
		DEFAULT => -115
	},
	{#State 84
		ACTIONS => {
			'OP23_LOGICAL_AND' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP18_TERNARY' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP04_MATH_POW' => -126,
			'OP08_STRING_CAT' => -126,
			";" => 155,
			'OP07_STRING_REPEAT' => -126
		}
	},
	{#State 85
		ACTIONS => {
			'LPAREN' => 156,
			'COLON' => -200
		}
	},
	{#State 86
		ACTIONS => {
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP16_LOGICAL_OR' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP23_LOGICAL_AND' => 159,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 163
		}
	},
	{#State 87
		DEFAULT => -17
	},
	{#State 88
		DEFAULT => -128
	},
	{#State 89
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 174
		}
	},
	{#State 90
		DEFAULT => -131
	},
	{#State 91
		ACTIONS => {
			'LBRACKET' => 93,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'ArrayReference' => 176,
			'Variable' => 175
		}
	},
	{#State 92
		DEFAULT => -77
	},
	{#State 93
		ACTIONS => {
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"]" => -181,
			"%{" => 96,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			"my" => 136,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_QW' => 131
		},
		GOTOS => {
			'ListElements' => 177,
			'WordScoped' => 77,
			'ListElement' => 130,
			'HashReference' => 101,
			'TypeInner' => 133,
			'SubExpression' => 127,
			'ArrayReference' => 111,
			'Literal' => 88,
			'HashDereferenced' => 106,
			'OPTIONAL-45' => 178,
			'Operator' => 94,
			'Expression' => 132,
			'Variable' => 134,
			'ArrayDereferenced' => 90
		}
	},
	{#State 94
		DEFAULT => -121
	},
	{#State 95
		DEFAULT => -142
	},
	{#State 96
		ACTIONS => {
			'LBRACE' => 70,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Variable' => 179,
			'HashReference' => 180
		}
	},
	{#State 97
		DEFAULT => -206
	},
	{#State 98
		ACTIONS => {
			'COLON' => 181
		}
	},
	{#State 99
		ACTIONS => {
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_OPEN' => 102,
			'OP01_PRINT' => 183,
			'OP01_NAMED' => 184,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'LBRACE' => 70,
			'LBRACKET' => 93
		},
		GOTOS => {
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Literal' => 88,
			'SubExpression' => 182,
			'ArrayReference' => 111
		}
	},
	{#State 100
		ACTIONS => {
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'LBRACKET' => 93,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			"my" => 136,
			'LBRACE' => 70
		},
		GOTOS => {
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 185,
			'HashReference' => 101,
			'TypeInner' => 133,
			'ListElement' => 186,
			'WordScoped' => 77
		}
	},
	{#State 101
		DEFAULT => -132
	},
	{#State 102
		ACTIONS => {
			"my" => 187
		}
	},
	{#State 103
		DEFAULT => -140
	},
	{#State 104
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP02_METHOD_THINARROW' => 189,
			'OP16_LOGICAL_OR' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 191,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP19_VARIABLE_ASSIGN' => 188,
			'OP13_BITWISE_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP04_MATH_POW' => -129,
			'OP18_TERNARY' => -129,
			'OP03_MATH_INC_DEC' => 190,
			'OP24_LOGICAL_OR_XOR' => -129
		}
	},
	{#State 105
		DEFAULT => -143
	},
	{#State 106
		DEFAULT => -133
	},
	{#State 107
		ACTIONS => {
			'FH_REF_SYMBOL' => 192
		}
	},
	{#State 108
		DEFAULT => -207
	},
	{#State 109
		DEFAULT => -14
	},
	{#State 110
		ACTIONS => {
			'LBRACKET' => 93,
			"for my integer" => -139,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			"my" => 89,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 100,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP19_LOOP_CONTROL' => 113,
			"if (" => 112,
			'LITERAL_NUMBER' => 108,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'LBRACE' => 70,
			'OP01_NAMED_VOID' => 71,
			'OP01_PRINT' => 78,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			"while (" => -139,
			'OP03_MATH_INC_DEC' => 82,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			"foreach my" => -139,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'' => -18,
			'WORD_UPPERCASE' => 85
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'PAREN-34' => 72,
			'OperatorVoid' => 95,
			'Operator' => 94,
			'Statement' => 92,
			'LoopLabel' => 98,
			'HashReference' => 101,
			'VariableModification' => 79,
			'WordScoped' => 77,
			'OPTIONAL-35' => 81,
			'Conditional' => 103,
			'Variable' => 104,
			'Expression' => 84,
			'HashDereferenced' => 106,
			'VariableDeclaration' => 105,
			'Literal' => 88,
			'Operation' => 193,
			'ArrayReference' => 111,
			'SubExpression' => 86
		}
	},
	{#State 111
		DEFAULT => -130
	},
	{#State 112
		ACTIONS => {
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'LBRACKET' => 93,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70
		},
		GOTOS => {
			'SubExpression' => 194,
			'ArrayReference' => 111,
			'Literal' => 88,
			'WordScoped' => 77,
			'HashReference' => 101,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132
		}
	},
	{#State 113
		ACTIONS => {
			'WORD_UPPERCASE' => 195
		},
		GOTOS => {
			'LoopLabel' => 196
		}
	},
	{#State 114
		DEFAULT => -112
	},
	{#State 115
		ACTIONS => {
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70,
			'LBRACKET' => 93
		},
		GOTOS => {
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 197,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94
		}
	},
	{#State 116
		ACTIONS => {
			"use" => 37,
			"use constant" => -56,
			"our hash_ref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 199,
			'Include' => 198
		}
	},
	{#State 117
		DEFAULT => -51
	},
	{#State 118
		DEFAULT => -37
	},
	{#State 119
		ACTIONS => {
			";" => 200
		}
	},
	{#State 120
		ACTIONS => {
			'OP01_PRINT' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"undef" => -43,
			"while (" => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP10_NAMED_UNARY' => -43,
			'LBRACE' => -43,
			'OP01_NAMED_VOID' => -43,
			'WORD' => -43,
			'WORD_UPPERCASE' => -43,
			"foreach my" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED' => -43,
			'OP01_OPEN' => -43,
			'LITERAL_STRING' => -43,
			'LPAREN' => -43,
			"%{" => -43,
			'LBRACKET' => -43,
			"for my integer" => -43,
			'WORD_SCOPED' => -43,
			"\@{" => -43,
			"my" => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"if (" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_CLOSE' => -43,
			'LPAREN_MY' => 201
		},
		GOTOS => {
			'OPTIONAL-16' => 202,
			'SubroutineArguments' => 203
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 122
		ACTIONS => {
			'LITERAL_NUMBER' => 108,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'Literal' => 205
		}
	},
	{#State 123
		DEFAULT => -195
	},
	{#State 124
		ACTIONS => {
			'OP20_HASH_FATARROW' => 206
		}
	},
	{#State 125
		DEFAULT => -188
	},
	{#State 126
		DEFAULT => -193,
		GOTOS => {
			'STAR-48' => 207
		}
	},
	{#State 127
		ACTIONS => {
			'OP23_LOGICAL_AND' => 159,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP16_LOGICAL_OR' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			")" => -178,
			"]" => -178,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP21_LIST_COMMA' => -178,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP07_STRING_REPEAT' => 162,
			";" => -178,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 128
		ACTIONS => {
			'LPAREN' => 156
		}
	},
	{#State 129
		ACTIONS => {
			";" => 208
		}
	},
	{#State 130
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 209
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 211
		},
		GOTOS => {
			'PLUS-44' => 210
		}
	},
	{#State 132
		DEFAULT => -126
	},
	{#State 133
		ACTIONS => {
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 74,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			'LBRACE' => 70,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 212,
			'ArrayReference' => 111,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94
		}
	},
	{#State 134
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 189,
			'OP23_LOGICAL_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			"]" => -129,
			")" => -129,
			'OP18_TERNARY' => -129,
			'OP03_MATH_INC_DEC' => 190,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP21_LIST_COMMA' => -129,
			"}" => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP04_MATH_POW' => -129,
			";" => -129,
			'OP07_STRING_REPEAT' => -129
		}
	},
	{#State 135
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132,
			'ArrayReference' => 111,
			'SubExpression' => 213,
			'Literal' => 88,
			'WordScoped' => 77,
			'HashReference' => 101
		}
	},
	{#State 136
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 214
		}
	},
	{#State 137
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			")" => -104,
			"]" => -104,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => -104,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP16_LOGICAL_OR' => 170,
			'OP17_LIST_RANGE' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP04_MATH_POW' => 161,
			";" => -104,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP18_TERNARY' => 163,
			"}" => -104,
			'OP21_LIST_COMMA' => -104
		}
	},
	{#State 138
		ACTIONS => {
			'OP17_LIST_RANGE' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			"]" => -94,
			")" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP21_LIST_COMMA' => -94,
			"}" => -94,
			'OP18_TERNARY' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => 162,
			";" => -94,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172
		}
	},
	{#State 139
		ACTIONS => {
			'OP21_LIST_COMMA' => -86,
			"}" => -86,
			'OP18_TERNARY' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			";" => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP06_REGEX_MATCH' => -86,
			"]" => -86,
			")" => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP12_COMPARE_EQ_NE' => -86
		}
	},
	{#State 140
		ACTIONS => {
			")" => 215
		}
	},
	{#State 141
		ACTIONS => {
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'LITERAL_STRING' => 97,
			")" => -118,
			'LPAREN' => 99,
			"%{" => 96,
			'LBRACKET' => 93,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			"my" => 136,
			'LBRACE' => 70,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_QW' => 131,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'HashReference' => 101,
			'TypeInner' => 133,
			'ListElement' => 130,
			'WordScoped' => 77,
			'ListElements' => 217,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 127,
			'OPTIONAL-32' => 216,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'ArrayDereferenced' => 90,
			'Variable' => 134
		}
	},
	{#State 142
		DEFAULT => -107
	},
	{#State 143
		DEFAULT => -108
	},
	{#State 144
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_QW' => 131,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 93,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			"my" => 136,
			'LBRACE' => 70,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96
		},
		GOTOS => {
			'WordScoped' => 77,
			'ListElements' => 218,
			'TypeInner' => 133,
			'HashReference' => 101,
			'ListElement' => 130,
			'ArrayReference' => 111,
			'SubExpression' => 127,
			'Literal' => 88,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'Variable' => 134,
			'ArrayDereferenced' => 90
		}
	},
	{#State 145
		ACTIONS => {
			"my" => 136,
			'LBRACE' => 70,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			'LBRACKET' => 93,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'VARIABLE_SYMBOL' => 80,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_QW' => 131,
			'OP01_CLOSE' => 107,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26
		},
		GOTOS => {
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'SubExpression' => 127,
			'ArrayReference' => 111,
			'Literal' => 88,
			'ListElements' => 219,
			'WordScoped' => 77,
			'ListElement' => 130,
			'TypeInner' => 133,
			'HashReference' => 101
		}
	},
	{#State 146
		ACTIONS => {
			'OP02_HASH_THINARROW' => 222,
			'OP21_LIST_COMMA' => -163,
			"}" => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP18_TERNARY' => -163,
			'OP03_MATH_INC_DEC' => -163,
			";" => -163,
			'OP08_STRING_CAT' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP04_MATH_POW' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP16_LOGICAL_OR' => -163,
			'COLON' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP13_BITWISE_AND' => -163,
			'OP02_ARRAY_THINARROW' => 221,
			'OP02_METHOD_THINARROW' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP06_REGEX_MATCH' => -163,
			"]" => -163,
			")" => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP12_COMPARE_EQ_NE' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 220
		}
	},
	{#State 147
		ACTIONS => {
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'LBRACE' => 70,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 223,
			'ArrayReference' => 111,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106
		}
	},
	{#State 148
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 224
		}
	},
	{#State 149
		DEFAULT => -153
	},
	{#State 150
		DEFAULT => -141
	},
	{#State 151
		DEFAULT => -154
	},
	{#State 152
		ACTIONS => {
			'VARIABLE_SYMBOL' => 225
		}
	},
	{#State 153
		DEFAULT => -152
	},
	{#State 154
		DEFAULT => -83
	},
	{#State 155
		DEFAULT => -76
	},
	{#State 156
		ACTIONS => {
			")" => 226
		}
	},
	{#State 157
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'ArrayReference' => 111,
			'SubExpression' => 227,
			'Literal' => 88,
			'WordScoped' => 77,
			'HashReference' => 101,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132
		}
	},
	{#State 158
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LBRACE' => 70,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			'LBRACKET' => 93,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102
		},
		GOTOS => {
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 228
		}
	},
	{#State 159
		ACTIONS => {
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128
		},
		GOTOS => {
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Literal' => 88,
			'SubExpression' => 229,
			'ArrayReference' => 111
		}
	},
	{#State 160
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'WordScoped' => 77,
			'HashReference' => 101,
			'SubExpression' => 230,
			'ArrayReference' => 111,
			'Literal' => 88
		}
	},
	{#State 161
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 231,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94
		}
	},
	{#State 162
		ACTIONS => {
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Literal' => 88,
			'SubExpression' => 232,
			'ArrayReference' => 111
		}
	},
	{#State 163
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'LITERAL_NUMBER' => 108,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'Literal' => 234,
			'Variable' => 235,
			'VariableOrLiteral' => 233
		}
	},
	{#State 164
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 236
		}
	},
	{#State 165
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115
		},
		GOTOS => {
			'WordScoped' => 77,
			'HashReference' => 101,
			'SubExpression' => 237,
			'ArrayReference' => 111,
			'Literal' => 88,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132,
			'Variable' => 134,
			'ArrayDereferenced' => 90
		}
	},
	{#State 166
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'SubExpression' => 238,
			'ArrayReference' => 111,
			'Literal' => 88,
			'WordScoped' => 77,
			'HashReference' => 101
		}
	},
	{#State 167
		ACTIONS => {
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 80,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'LBRACE' => 70,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			'LBRACKET' => 93
		},
		GOTOS => {
			'SubExpression' => 239,
			'ArrayReference' => 111,
			'Literal' => 88,
			'WordScoped' => 77,
			'HashReference' => 101,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132
		}
	},
	{#State 168
		ACTIONS => {
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'LBRACKET' => 93,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70
		},
		GOTOS => {
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 240
		}
	},
	{#State 169
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 74,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'SubExpression' => 241,
			'ArrayReference' => 111,
			'Literal' => 88,
			'WordScoped' => 77,
			'HashReference' => 101
		}
	},
	{#State 170
		ACTIONS => {
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			'LBRACKET' => 93,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			'VARIABLE_SYMBOL' => 80,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 242,
			'HashReference' => 101,
			'WordScoped' => 77
		}
	},
	{#State 171
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 74,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75
		},
		GOTOS => {
			'SubExpression' => 243,
			'ArrayReference' => 111,
			'Literal' => 88,
			'WordScoped' => 77,
			'HashReference' => 101,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132
		}
	},
	{#State 172
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'OP10_NAMED_UNARY' => 74,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99
		},
		GOTOS => {
			'HashReference' => 101,
			'WordScoped' => 77,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 244,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Variable' => 134,
			'ArrayDereferenced' => 90
		}
	},
	{#State 173
		ACTIONS => {
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 74,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'WordScoped' => 77,
			'HashReference' => 101,
			'SubExpression' => 245,
			'ArrayReference' => 111,
			'Literal' => 88,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'ArrayDereferenced' => 90,
			'Variable' => 134
		}
	},
	{#State 174
		ACTIONS => {
			'VARIABLE_SYMBOL' => 246
		}
	},
	{#State 175
		ACTIONS => {
			"}" => 247
		}
	},
	{#State 176
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 177
		DEFAULT => -180
	},
	{#State 178
		ACTIONS => {
			"]" => 249
		}
	},
	{#State 179
		ACTIONS => {
			"}" => 250
		}
	},
	{#State 180
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 181
		DEFAULT => -137
	},
	{#State 182
		ACTIONS => {
			")" => 252,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP16_LOGICAL_OR' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP23_LOGICAL_AND' => 159,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 183
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 253
		}
	},
	{#State 184
		ACTIONS => {
			'OP10_NAMED_UNARY' => 74,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'LBRACE' => 70,
			"my" => 136,
			'LBRACKET' => 93,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'WordScoped' => 77,
			'TypeInner' => 133,
			'HashReference' => 101,
			'ListElement' => 254,
			'ArrayReference' => 111,
			'SubExpression' => 185,
			'Literal' => 88
		}
	},
	{#State 185
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP07_STRING_REPEAT' => -79,
			";" => -79,
			'OP08_STRING_CAT' => -79,
			'OP04_MATH_POW' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP21_LIST_COMMA' => -178,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			")" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP16_LOGICAL_OR' => -79
		}
	},
	{#State 186
		ACTIONS => {
			'OP21_LIST_COMMA' => 255
		}
	},
	{#State 187
		ACTIONS => {
			"filehandle_ref" => 256
		}
	},
	{#State 188
		ACTIONS => {
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP10_NAMED_UNARY' => 74,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'LBRACE' => 70,
			'STDIN' => 257,
			'LBRACKET' => 93,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 258,
			'HashReference' => 101,
			'WordScoped' => 77,
			'ArrayDereferenced' => 90,
			'SubExpressionOrStdin' => 259,
			'Variable' => 134,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94
		}
	},
	{#State 189
		ACTIONS => {
			'LPAREN' => 260
		}
	},
	{#State 190
		DEFAULT => -84
	},
	{#State 191
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 93,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96
		},
		GOTOS => {
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Literal' => 88,
			'SubExpression' => 261,
			'ArrayReference' => 111,
			'HashReference' => 101,
			'WordScoped' => 77
		}
	},
	{#State 192
		DEFAULT => -82
	},
	{#State 193
		DEFAULT => -16
	},
	{#State 194
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			")" => 262,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP23_LOGICAL_AND' => 159,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP16_LOGICAL_OR' => 170,
			'OP17_LIST_RANGE' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 195
		DEFAULT => -200
	},
	{#State 196
		ACTIONS => {
			";" => 263
		}
	},
	{#State 197
		ACTIONS => {
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			")" => 264,
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP16_LOGICAL_OR' => 170,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP23_LOGICAL_AND' => 159
		}
	},
	{#State 198
		DEFAULT => -53
	},
	{#State 199
		ACTIONS => {
			"use constant" => 48,
			"our hash_ref \$properties" => 265
		},
		GOTOS => {
			'Constant' => 266,
			'Properties' => 267
		}
	},
	{#State 200
		DEFAULT => -40
	},
	{#State 201
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 202
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'OP03_MATH_INC_DEC' => 82,
			"foreach my" => -139,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP19_LOOP_CONTROL' => 113,
			"if (" => 112,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 85,
			'LBRACKET' => 93,
			"for my integer" => -139,
			'OP10_NAMED_UNARY' => 74,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'LBRACE' => 70,
			'OP01_NAMED_VOID' => 71,
			"my" => 89,
			'OP01_OPEN' => 102,
			'OP01_PRINT' => 78,
			'OP01_NAMED' => 100,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			"while (" => -139
		},
		GOTOS => {
			'LoopLabel' => 98,
			'PLUS-17' => 269,
			'HashReference' => 101,
			'VariableModification' => 79,
			'WordScoped' => 77,
			'PAREN-34' => 72,
			'ArrayDereferenced' => 90,
			'OperatorVoid' => 95,
			'Operator' => 94,
			'Statement' => 92,
			'Operation' => 270,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 86,
			'OPTIONAL-35' => 81,
			'Variable' => 104,
			'Conditional' => 103,
			'Expression' => 84,
			'HashDereferenced' => 106,
			'VariableDeclaration' => 105
		}
	},
	{#State 203
		DEFAULT => -42
	},
	{#State 204
		ACTIONS => {
			"\$TYPED_" => 271
		}
	},
	{#State 205
		ACTIONS => {
			";" => 272
		}
	},
	{#State 206
		ACTIONS => {
			'VARIABLE_SYMBOL' => -186,
			'OP03_MATH_INC_DEC' => -186,
			'OP01_CLOSE' => -186,
			'LITERAL_NUMBER' => -186,
			'WORD_UPPERCASE' => -186,
			'OP05_MATH_NEG_LPAREN' => -186,
			'WORD' => -186,
			"my" => 136,
			'LBRACE' => -186,
			"\@{" => -186,
			'OP22_LOGICAL_NEG' => -186,
			'WORD_SCOPED' => -186,
			'OP10_NAMED_UNARY' => -186,
			'LBRACKET' => -186,
			"%{" => -186,
			'LITERAL_STRING' => -186,
			'LPAREN' => -186,
			"undef" => -186,
			'OP05_LOGICAL_NEG' => -186,
			'OP01_NAMED' => -186,
			'OP01_OPEN' => -186
		},
		GOTOS => {
			'TypeInner' => 274,
			'OPTIONAL-46' => 273
		}
	},
	{#State 207
		ACTIONS => {
			'OP21_LIST_COMMA' => 275,
			"}" => 276
		},
		GOTOS => {
			'PAREN-47' => 277
		}
	},
	{#State 208
		DEFAULT => -113
	},
	{#State 209
		ACTIONS => {
			";" => -176,
			")" => -176,
			"]" => -176,
			'OP21_LIST_COMMA' => 279
		},
		GOTOS => {
			'PAREN-42' => 278
		}
	},
	{#State 210
		ACTIONS => {
			'WORD' => 280,
			")" => 281
		}
	},
	{#State 211
		DEFAULT => -175
	},
	{#State 212
		ACTIONS => {
			";" => -179,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP21_LIST_COMMA' => -179,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 163,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			")" => -179,
			"]" => -179,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP16_LOGICAL_OR' => 170,
			'OP17_LIST_RANGE' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP23_LOGICAL_AND' => 159
		}
	},
	{#State 213
		ACTIONS => {
			'OP21_LIST_COMMA' => -79,
			"}" => -79,
			'OP18_TERNARY' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			";" => -79,
			'OP04_MATH_POW' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_STRING_CAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			"]" => -79,
			")" => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79
		}
	},
	{#State 214
		ACTIONS => {
			"\$TYPED_" => 282
		}
	},
	{#State 215
		DEFAULT => -125
	},
	{#State 216
		ACTIONS => {
			")" => 283
		}
	},
	{#State 217
		DEFAULT => -117
	},
	{#State 218
		ACTIONS => {
			";" => 284
		}
	},
	{#State 219
		ACTIONS => {
			";" => 285
		}
	},
	{#State 220
		DEFAULT => -161
	},
	{#State 221
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'LBRACE' => 70,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96
		},
		GOTOS => {
			'ArrayReference' => 111,
			'SubExpression' => 286,
			'Literal' => 88,
			'WordScoped' => 77,
			'HashReference' => 101,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132
		}
	},
	{#State 222
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 287,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'WordScoped' => 77,
			'HashReference' => 101,
			'ArrayReference' => 111,
			'SubExpression' => 288,
			'Literal' => 88
		}
	},
	{#State 223
		ACTIONS => {
			'OP23_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			")" => 289,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 163,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162
		}
	},
	{#State 224
		ACTIONS => {
			'VARIABLE_SYMBOL' => 290
		}
	},
	{#State 225
		ACTIONS => {
			'LPAREN' => 291
		}
	},
	{#State 226
		DEFAULT => -123
	},
	{#State 227
		ACTIONS => {
			'OP18_TERNARY' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			"}" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_STRING_REPEAT' => 162,
			";" => -100,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP23_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => -100,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			")" => -100,
			"]" => -100
		}
	},
	{#State 228
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP16_LOGICAL_OR' => 170,
			'OP23_LOGICAL_AND' => -102,
			"]" => -102,
			")" => -102,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP21_LIST_COMMA' => -102,
			"}" => -102,
			'OP18_TERNARY' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			";" => -102,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171
		}
	},
	{#State 229
		ACTIONS => {
			'OP08_STRING_CAT' => 160,
			";" => -105,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			"}" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			")" => -105,
			"]" => -105,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP16_LOGICAL_OR' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP23_LOGICAL_AND' => -105
		}
	},
	{#State 230
		ACTIONS => {
			'OP21_LIST_COMMA' => -92,
			"}" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			'OP08_STRING_CAT' => -92,
			";" => -92,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP23_LOGICAL_AND' => -92,
			"]" => -92,
			")" => -92,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP15_LOGICAL_AND' => -92,
			'OP12_COMPARE_EQ_NE' => -92
		}
	},
	{#State 231
		ACTIONS => {
			'OP06_REGEX_MATCH' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			")" => -85,
			"]" => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP23_LOGICAL_AND' => -85,
			";" => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			"}" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP18_TERNARY' => -85,
			'OP24_LOGICAL_OR_XOR' => -85
		}
	},
	{#State 232
		ACTIONS => {
			")" => -89,
			"]" => -89,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP07_STRING_REPEAT' => -89,
			";" => -89,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			"}" => -89,
			'OP21_LIST_COMMA' => -89,
			'OP18_TERNARY' => -89,
			'OP24_LOGICAL_OR_XOR' => -89
		}
	},
	{#State 233
		ACTIONS => {
			'COLON' => 292
		}
	},
	{#State 234
		DEFAULT => -205
	},
	{#State 235
		DEFAULT => -204
	},
	{#State 236
		DEFAULT => -88
	},
	{#State 237
		ACTIONS => {
			"]" => -91,
			")" => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP06_REGEX_MATCH' => 164,
			'OP15_LOGICAL_AND' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP23_LOGICAL_AND' => -91,
			";" => -91,
			'OP08_STRING_CAT' => -91,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => -91,
			'OP21_LIST_COMMA' => -91,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP18_TERNARY' => -91
		}
	},
	{#State 238
		ACTIONS => {
			'OP23_LOGICAL_AND' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP11_COMPARE_LT_GT' => 167,
			'OP15_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			"]" => -97,
			")" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP18_TERNARY' => -97,
			'OP21_LIST_COMMA' => -97,
			"}" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_STRING_REPEAT' => 162,
			";" => -97,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 239
		ACTIONS => {
			"]" => -96,
			")" => -96,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP15_LOGICAL_AND' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP13_BITWISE_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP23_LOGICAL_AND' => -96,
			";" => -96,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			'OP21_LIST_COMMA' => -96,
			"}" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP18_TERNARY' => -96
		}
	},
	{#State 240
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			";" => -98,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => 160,
			'OP18_TERNARY' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			"}" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => -98,
			")" => -98,
			"]" => -98,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => -98,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP17_LIST_RANGE' => -98
		}
	},
	{#State 241
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => -99,
			")" => -99,
			"]" => -99,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP16_LOGICAL_OR' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			'OP08_STRING_CAT' => 160,
			";" => -99,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP18_TERNARY' => -99,
			"}" => -99,
			'OP21_LIST_COMMA' => -99
		}
	},
	{#State 242
		ACTIONS => {
			";" => -101,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			"}" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP18_TERNARY' => -101,
			")" => -101,
			"]" => -101,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP16_LOGICAL_OR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 243
		ACTIONS => {
			")" => -93,
			"]" => -93,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP23_LOGICAL_AND' => -93,
			";" => -93,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP09_BITWISE_SHIFT' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			"}" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP18_TERNARY' => -93
		}
	},
	{#State 244
		ACTIONS => {
			'OP15_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			"]" => -90,
			")" => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP08_STRING_CAT' => -90,
			";" => -90,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP21_LIST_COMMA' => -90,
			"}" => -90
		}
	},
	{#State 245
		ACTIONS => {
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166,
			"]" => -106,
			")" => -106,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => 159,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP16_LOGICAL_OR' => 170,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			";" => -106,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106,
			"}" => -106
		}
	},
	{#State 246
		ACTIONS => {
			";" => 294,
			'OP19_VARIABLE_ASSIGN' => 293
		}
	},
	{#State 247
		DEFAULT => -183
	},
	{#State 248
		DEFAULT => -184
	},
	{#State 249
		DEFAULT => -182
	},
	{#State 250
		DEFAULT => -196
	},
	{#State 251
		DEFAULT => -197
	},
	{#State 252
		DEFAULT => -134
	},
	{#State 253
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_QW' => 131,
			'OP01_CLOSE' => 107,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LBRACE' => 70,
			"my" => 136,
			'OP10_NAMED_UNARY' => 74,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			'LBRACKET' => 93,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135
		},
		GOTOS => {
			'WordScoped' => 77,
			'ListElements' => 295,
			'TypeInner' => 133,
			'HashReference' => 101,
			'ListElement' => 130,
			'ArrayReference' => 111,
			'SubExpression' => 127,
			'Literal' => 88,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'Variable' => 134,
			'ArrayDereferenced' => 90
		}
	},
	{#State 254
		ACTIONS => {
			'OP21_LIST_COMMA' => 296
		}
	},
	{#State 255
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'OP01_QW' => 131,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 93,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			"my" => 136,
			'LBRACE' => 70,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96
		},
		GOTOS => {
			'ArrayReference' => 111,
			'SubExpression' => 127,
			'Literal' => 88,
			'WordScoped' => 77,
			'ListElements' => 297,
			'HashReference' => 101,
			'TypeInner' => 133,
			'ListElement' => 130,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132
		}
	},
	{#State 256
		ACTIONS => {
			'FH_REF_SYMBOL' => 298
		}
	},
	{#State 257
		DEFAULT => -136
	},
	{#State 258
		ACTIONS => {
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP16_LOGICAL_OR' => 170,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			";" => -135,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 163
		}
	},
	{#State 259
		ACTIONS => {
			";" => 299
		}
	},
	{#State 260
		ACTIONS => {
			'LBRACKET' => 93,
			"my" => 136,
			'LBRACE' => 70,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP10_NAMED_UNARY' => 74,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"%{" => 96,
			")" => -120,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			'OP01_QW' => 131,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128
		},
		GOTOS => {
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'HashReference' => 101,
			'TypeInner' => 133,
			'ListElement' => 130,
			'OPTIONAL-33' => 300,
			'WordScoped' => 77,
			'ListElements' => 301,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 127
		}
	},
	{#State 261
		ACTIONS => {
			'OP23_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 170,
			'OP17_LIST_RANGE' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			";" => 302,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161
		}
	},
	{#State 262
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 304
		}
	},
	{#State 263
		DEFAULT => -116
	},
	{#State 264
		DEFAULT => -87
	},
	{#State 265
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 305
		}
	},
	{#State 266
		DEFAULT => -55
	},
	{#State 267
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 306
		}
	},
	{#State 268
		ACTIONS => {
			'VARIABLE_SYMBOL' => 307
		}
	},
	{#State 269
		ACTIONS => {
			"while (" => -139,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_PRINT' => 78,
			'OP01_NAMED_VOID' => 71,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 85,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 80,
			"}" => 308,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'OP03_MATH_INC_DEC' => 82,
			"foreach my" => -139,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 100,
			"my" => 89,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			"for my integer" => -139,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 108,
			'OP19_LOOP_CONTROL' => 113,
			"if (" => 112,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP01_CLOSE' => 107
		},
		GOTOS => {
			'Operation' => 309,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 86,
			'OPTIONAL-35' => 81,
			'Conditional' => 103,
			'Variable' => 104,
			'Expression' => 84,
			'HashDereferenced' => 106,
			'VariableDeclaration' => 105,
			'LoopLabel' => 98,
			'HashReference' => 101,
			'VariableModification' => 79,
			'WordScoped' => 77,
			'ArrayDereferenced' => 90,
			'PAREN-34' => 72,
			'OperatorVoid' => 95,
			'Operator' => 94,
			'Statement' => 92
		}
	},
	{#State 270
		DEFAULT => -45
	},
	{#State 271
		ACTIONS => {
			'WORD_UPPERCASE' => 310
		}
	},
	{#State 272
		DEFAULT => -41
	},
	{#State 273
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Literal' => 88,
			'SubExpression' => 311,
			'ArrayReference' => 111,
			'HashReference' => 101,
			'WordScoped' => 77
		}
	},
	{#State 274
		DEFAULT => -185
	},
	{#State 275
		ACTIONS => {
			'WORD' => 124,
			"%{" => 96
		},
		GOTOS => {
			'HashDereferenced' => 125,
			'HashEntry' => 312
		}
	},
	{#State 276
		DEFAULT => -194
	},
	{#State 277
		DEFAULT => -192
	},
	{#State 278
		DEFAULT => -172
	},
	{#State 279
		ACTIONS => {
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'LBRACKET' => 93,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'OP10_NAMED_UNARY' => 74,
			"my" => 136,
			'LBRACE' => 70
		},
		GOTOS => {
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'WordScoped' => 77,
			'ListElement' => 313,
			'HashReference' => 101,
			'TypeInner' => 133,
			'SubExpression' => 127,
			'ArrayReference' => 111,
			'Literal' => 88
		}
	},
	{#State 280
		DEFAULT => -174
	},
	{#State 281
		DEFAULT => -177
	},
	{#State 282
		ACTIONS => {
			'WORD' => 314
		}
	},
	{#State 283
		DEFAULT => -122
	},
	{#State 284
		DEFAULT => -110
	},
	{#State 285
		DEFAULT => -111
	},
	{#State 286
		ACTIONS => {
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP11_COMPARE_LT_GT' => 167,
			'OP13_BITWISE_AND' => 168,
			'OP16_LOGICAL_OR' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP23_LOGICAL_AND' => 159,
			"]" => 315,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157
		}
	},
	{#State 287
		ACTIONS => {
			"}" => 316,
			'LPAREN' => -198,
			'OP02_METHOD_THINARROW_NEW' => -198
		}
	},
	{#State 288
		ACTIONS => {
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP16_LOGICAL_OR' => 170,
			'OP17_LIST_RANGE' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP23_LOGICAL_AND' => 159,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			"}" => 317,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 289
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 318
		}
	},
	{#State 290
		ACTIONS => {
			'LPAREN' => 319
		}
	},
	{#State 291
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP10_NAMED_UNARY' => 74,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99
		},
		GOTOS => {
			'WordScoped' => 77,
			'HashReference' => 101,
			'ArrayReference' => 111,
			'SubExpression' => 320,
			'Literal' => 88,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'ArrayDereferenced' => 90,
			'Variable' => 134
		}
	},
	{#State 292
		ACTIONS => {
			'LITERAL_STRING' => 97,
			'VARIABLE_SYMBOL' => 80,
			'LITERAL_NUMBER' => 108
		},
		GOTOS => {
			'Literal' => 234,
			'Variable' => 235,
			'VariableOrLiteral' => 321
		}
	},
	{#State 293
		ACTIONS => {
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			'LBRACKET' => 93,
			'STDIN' => 257,
			'LBRACE' => 70,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'ArrayDereferenced' => 90,
			'SubExpressionOrStdin' => 322,
			'Variable' => 134,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Literal' => 88,
			'SubExpression' => 258,
			'ArrayReference' => 111
		}
	},
	{#State 294
		DEFAULT => -167
	},
	{#State 295
		ACTIONS => {
			")" => 323
		}
	},
	{#State 296
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_QW' => 131,
			'OP01_CLOSE' => 107,
			'VARIABLE_SYMBOL' => 80,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			'LBRACKET' => 93,
			'LBRACE' => 70,
			"my" => 136,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'ListElements' => 324,
			'WordScoped' => 77,
			'ListElement' => 130,
			'TypeInner' => 133,
			'HashReference' => 101,
			'SubExpression' => 127,
			'ArrayReference' => 111,
			'Literal' => 88
		}
	},
	{#State 297
		ACTIONS => {
			";" => 325
		}
	},
	{#State 298
		ACTIONS => {
			'OP21_LIST_COMMA' => 326
		}
	},
	{#State 299
		DEFAULT => -169
	},
	{#State 300
		ACTIONS => {
			")" => 327
		}
	},
	{#State 301
		DEFAULT => -119
	},
	{#State 302
		DEFAULT => -170
	},
	{#State 303
		ACTIONS => {
			"if (" => 112,
			'OP19_LOOP_CONTROL' => 113,
			'WORD_UPPERCASE' => 85,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP05_MATH_NEG_LPAREN' => 115,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			"foreach my" => -139,
			'OP03_MATH_INC_DEC' => 82,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"while (" => -139,
			"%{" => 96,
			'OP01_NAMED' => 100,
			'OP01_OPEN' => 102,
			'OP01_PRINT' => 78,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			"my" => 89,
			'LBRACE' => 70,
			'OP01_NAMED_VOID' => 71,
			'LBRACKET' => 93,
			"for my integer" => -139
		},
		GOTOS => {
			'OperatorVoid' => 95,
			'Operator' => 94,
			'Statement' => 92,
			'PAREN-34' => 72,
			'ArrayDereferenced' => 90,
			'VariableModification' => 79,
			'HashReference' => 101,
			'WordScoped' => 77,
			'LoopLabel' => 98,
			'PLUS-40' => 328,
			'Expression' => 84,
			'HashDereferenced' => 106,
			'VariableDeclaration' => 105,
			'OPTIONAL-35' => 81,
			'Variable' => 104,
			'Conditional' => 103,
			'Operation' => 329,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 86
		}
	},
	{#State 304
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 330
		}
	},
	{#State 305
		ACTIONS => {
			'LBRACE' => 331
		}
	},
	{#State 306
		ACTIONS => {
			"our" => 334,
			'LITERAL_NUMBER' => 333
		},
		GOTOS => {
			'Subroutine' => 332,
			'MethodOrSubroutine' => 335,
			'Method' => 336
		}
	},
	{#State 307
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 337
		}
	},
	{#State 308
		ACTIONS => {
			";" => 338
		}
	},
	{#State 309
		DEFAULT => -44
	},
	{#State 310
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 339
		}
	},
	{#State 311
		ACTIONS => {
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP17_LIST_RANGE' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP16_LOGICAL_OR' => 170,
			'OP23_LOGICAL_AND' => 159,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP21_LIST_COMMA' => -187,
			"}" => -187,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP04_MATH_POW' => 161,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171
		}
	},
	{#State 312
		DEFAULT => -191
	},
	{#State 313
		DEFAULT => -171
	},
	{#State 314
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 340
		}
	},
	{#State 315
		DEFAULT => -164
	},
	{#State 316
		DEFAULT => -166
	},
	{#State 317
		DEFAULT => -165
	},
	{#State 318
		DEFAULT => -157
	},
	{#State 319
		ACTIONS => {
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'LBRACKET' => 93,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'OP10_NAMED_UNARY' => 74,
			"my" => 136,
			'LBRACE' => 70,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'OP01_CLOSE' => 107,
			'OP01_QW' => 131,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80
		},
		GOTOS => {
			'Expression' => 132,
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'TypeInner' => 133,
			'HashReference' => 101,
			'ListElement' => 130,
			'WordScoped' => 77,
			'ListElements' => 341,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 127
		}
	},
	{#State 320
		ACTIONS => {
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP17_LIST_RANGE' => 342,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP16_LOGICAL_OR' => 170,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP23_LOGICAL_AND' => 159,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 163
		}
	},
	{#State 321
		DEFAULT => -103
	},
	{#State 322
		ACTIONS => {
			";" => 343
		}
	},
	{#State 323
		DEFAULT => -78
	},
	{#State 324
		ACTIONS => {
			")" => 344
		}
	},
	{#State 325
		DEFAULT => -114
	},
	{#State 326
		ACTIONS => {
			'LITERAL_STRING' => 345
		}
	},
	{#State 327
		DEFAULT => -124
	},
	{#State 328
		ACTIONS => {
			"%{" => 96,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 100,
			"my" => 89,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'LBRACKET' => 93,
			"for my integer" => -139,
			'LITERAL_NUMBER' => 108,
			'OP19_LOOP_CONTROL' => 113,
			"if (" => 112,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP01_CLOSE' => 107,
			"while (" => -139,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76,
			'OP01_PRINT' => 78,
			'OP01_NAMED_VOID' => 71,
			'LBRACE' => 70,
			'OP10_NAMED_UNARY' => 74,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 85,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 80,
			"}" => 347,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'OP03_MATH_INC_DEC' => 82,
			"foreach my" => -139
		},
		GOTOS => {
			'LoopLabel' => 98,
			'VariableModification' => 79,
			'HashReference' => 101,
			'WordScoped' => 77,
			'ArrayDereferenced' => 90,
			'PAREN-34' => 72,
			'OperatorVoid' => 95,
			'Statement' => 92,
			'Operator' => 94,
			'Operation' => 346,
			'Literal' => 88,
			'SubExpression' => 86,
			'ArrayReference' => 111,
			'OPTIONAL-35' => 81,
			'Conditional' => 103,
			'Variable' => 104,
			'Expression' => 84,
			'VariableDeclaration' => 105,
			'HashDereferenced' => 106
		}
	},
	{#State 329
		DEFAULT => -159
	},
	{#State 330
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -150,
			"if (" => -150,
			'LITERAL_NUMBER' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP01_CLOSE' => -150,
			'LPAREN' => -150,
			'LITERAL_STRING' => -150,
			"elsif (" => 350,
			"%{" => -150,
			'OP01_OPEN' => -150,
			'OP01_NAMED' => -150,
			'WORD_SCOPED' => -150,
			"\@{" => -150,
			"my" => -150,
			'LBRACKET' => -150,
			"for my integer" => -150,
			'WORD_UPPERCASE' => -150,
			'WORD' => -150,
			'' => -150,
			"}" => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP03_MATH_INC_DEC' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			"foreach my" => -150,
			"while (" => -150,
			'OP01_PRINT' => -150,
			"undef" => -150,
			'OP05_LOGICAL_NEG' => -150,
			'OP10_NAMED_UNARY' => -150,
			"else" => 349,
			'OP22_LOGICAL_NEG' => -150,
			'LBRACE' => -150,
			'OP01_NAMED_VOID' => -150
		},
		GOTOS => {
			'PAREN-38' => 352,
			'OPTIONAL-39' => 348,
			'PAREN-36' => 351
		}
	},
	{#State 331
		ACTIONS => {
			'WORD' => 353,
			"}" => 354,
			"%{" => 96
		},
		GOTOS => {
			'HashEntryTyped' => 355,
			'HashDereferenced' => 356
		}
	},
	{#State 332
		DEFAULT => -75
	},
	{#State 333
		ACTIONS => {
			";" => 357
		}
	},
	{#State 334
		ACTIONS => {
			'WORD' => 57,
			'TYPE_METHOD' => 358
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 335
		DEFAULT => -57
	},
	{#State 336
		DEFAULT => -74
	},
	{#State 337
		ACTIONS => {
			")" => 360,
			'OP21_LIST_COMMA' => 361
		},
		GOTOS => {
			'PAREN-18' => 359
		}
	},
	{#State 338
		DEFAULT => -46
	},
	{#State 339
		DEFAULT => -203
	},
	{#State 340
		DEFAULT => -202
	},
	{#State 341
		ACTIONS => {
			")" => 362
		}
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75
		},
		GOTOS => {
			'HashReference' => 101,
			'WordScoped' => 77,
			'Literal' => 88,
			'ArrayReference' => 111,
			'SubExpression' => 363,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Variable' => 134,
			'ArrayDereferenced' => 90
		}
	},
	{#State 343
		DEFAULT => -168
	},
	{#State 344
		DEFAULT => -80
	},
	{#State 345
		ACTIONS => {
			'OP21_LIST_COMMA' => 364
		}
	},
	{#State 346
		DEFAULT => -158
	},
	{#State 347
		DEFAULT => -160
	},
	{#State 348
		DEFAULT => -151
	},
	{#State 349
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 365
		}
	},
	{#State 350
		ACTIONS => {
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 73,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96,
			'OP01_NAMED' => 135,
			'OP01_OPEN' => 102,
			"undef" => 75,
			'OP05_LOGICAL_NEG' => 76
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 366,
			'ArrayReference' => 111,
			'HashReference' => 101,
			'WordScoped' => 77,
			'Variable' => 134,
			'ArrayDereferenced' => 90,
			'Expression' => 132,
			'HashDereferenced' => 106,
			'Operator' => 94
		}
	},
	{#State 351
		DEFAULT => -146
	},
	{#State 352
		DEFAULT => -149
	},
	{#State 353
		ACTIONS => {
			'OP20_HASH_FATARROW' => 367
		}
	},
	{#State 354
		ACTIONS => {
			";" => 368
		}
	},
	{#State 355
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 369
		}
	},
	{#State 356
		DEFAULT => -190
	},
	{#State 357
		DEFAULT => -59
	},
	{#State 358
		ACTIONS => {
			'VARIABLE_SYMBOL' => 370
		}
	},
	{#State 359
		DEFAULT => -48
	},
	{#State 360
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 361
		ACTIONS => {
			"my" => 372
		}
	},
	{#State 362
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 373
		}
	},
	{#State 363
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 160,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166,
			")" => 374,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			'OP23_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 170
		}
	},
	{#State 364
		ACTIONS => {
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP10_NAMED_UNARY' => 74,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'LBRACE' => 70,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 128,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'VARIABLE_SYMBOL' => 80,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Operator' => 94,
			'HashDereferenced' => 106,
			'Expression' => 132,
			'ArrayDereferenced' => 90,
			'Variable' => 134,
			'WordScoped' => 77,
			'HashReference' => 101,
			'SubExpression' => 375,
			'ArrayReference' => 111,
			'Literal' => 88
		}
	},
	{#State 365
		DEFAULT => -148
	},
	{#State 366
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 173,
			'OP18_TERNARY' => 163,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_STRING_REPEAT' => 162,
			'OP04_MATH_POW' => 161,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 159,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP16_LOGICAL_OR' => 170,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			")" => 376
		}
	},
	{#State 367
		ACTIONS => {
			"my" => 136
		},
		GOTOS => {
			'TypeInner' => 377
		}
	},
	{#State 368
		DEFAULT => -64
	},
	{#State 369
		ACTIONS => {
			'OP21_LIST_COMMA' => 379,
			"}" => 378
		},
		GOTOS => {
			'PAREN-24' => 380
		}
	},
	{#State 370
		ACTIONS => {
			"= sub {" => 381
		}
	},
	{#State 371
		ACTIONS => {
			"\@_;" => 382
		}
	},
	{#State 372
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 383
		}
	},
	{#State 373
		DEFAULT => -156
	},
	{#State 374
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 384
		}
	},
	{#State 375
		ACTIONS => {
			'OP21_LIST_COMMA' => -81,
			"}" => -81,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => -81,
			";" => -81,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 158,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP16_LOGICAL_OR' => 170,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP23_LOGICAL_AND' => -81,
			'OP08_MATH_ADD_SUB' => 165,
			'OP06_REGEX_MATCH' => 164,
			"]" => -81,
			")" => -81,
			'OP15_LOGICAL_AND' => 157,
			'OP12_COMPARE_EQ_NE' => 166
		}
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 303
		},
		GOTOS => {
			'CodeBlock' => 385
		}
	},
	{#State 377
		ACTIONS => {
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 74,
			'WORD_SCOPED' => 24,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'LBRACE' => 70,
			'OP01_OPEN' => 102,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'LPAREN' => 99,
			'LITERAL_STRING' => 97,
			"%{" => 96,
			'OP01_CLOSE' => 107,
			'OP03_MATH_INC_DEC' => 82,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD_UPPERCASE' => 128,
			'LITERAL_NUMBER' => 108
		},
		GOTOS => {
			'WordScoped' => 77,
			'HashReference' => 101,
			'SubExpression' => 386,
			'ArrayReference' => 111,
			'Literal' => 88,
			'HashDereferenced' => 106,
			'Operator' => 94,
			'Expression' => 132,
			'Variable' => 134,
			'ArrayDereferenced' => 90
		}
	},
	{#State 378
		ACTIONS => {
			";" => 387
		}
	},
	{#State 379
		ACTIONS => {
			'WORD' => 353,
			"%{" => 96
		},
		GOTOS => {
			'HashEntryTyped' => 388,
			'HashDereferenced' => 356
		}
	},
	{#State 380
		DEFAULT => -61
	},
	{#State 381
		ACTIONS => {
			"while (" => -66,
			'OP01_PRINT' => -66,
			"undef" => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP01_NAMED_VOID' => -66,
			'LBRACE' => -66,
			'WORD_UPPERCASE' => -66,
			'WORD' => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			"foreach my" => -66,
			'LPAREN' => -66,
			'LITERAL_STRING' => -66,
			"%{" => -66,
			'OP01_OPEN' => -66,
			'OP01_NAMED' => -66,
			'WORD_SCOPED' => -66,
			"\@{" => -66,
			"my" => -66,
			"for my integer" => -66,
			'LBRACKET' => -66,
			'OP19_LOOP_CONTROL' => -66,
			"if (" => -66,
			'LITERAL_NUMBER' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LPAREN_MY' => 389,
			'OP01_CLOSE' => -66
		},
		GOTOS => {
			'MethodArguments' => 391,
			'OPTIONAL-26' => 390
		}
	},
	{#State 382
		DEFAULT => -50
	},
	{#State 383
		ACTIONS => {
			'VARIABLE_SYMBOL' => 392
		}
	},
	{#State 384
		DEFAULT => -155
	},
	{#State 385
		DEFAULT => -145
	},
	{#State 386
		ACTIONS => {
			'OP06_REGEX_MATCH' => 164,
			'OP08_MATH_ADD_SUB' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 157,
			'OP13_BITWISE_AND' => 168,
			'OP11_COMPARE_LT_GT' => 167,
			'OP16_LOGICAL_OR' => 170,
			'OP14_BITWISE_OR_XOR' => 169,
			'OP17_LIST_RANGE' => 158,
			'OP23_LOGICAL_AND' => 159,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 162,
			'OP08_STRING_CAT' => 160,
			'OP09_BITWISE_SHIFT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			"}" => -189,
			'OP21_LIST_COMMA' => -189,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => 173
		}
	},
	{#State 387
		DEFAULT => -63
	},
	{#State 388
		DEFAULT => -60
	},
	{#State 389
		ACTIONS => {
			'TYPE_SELF' => 393
		}
	},
	{#State 390
		ACTIONS => {
			"while (" => -139,
			"%{" => 96,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			'OP01_NAMED' => 100,
			'OP01_PRINT' => 78,
			'OP01_OPEN' => 102,
			"my" => 89,
			'LBRACE' => 70,
			'OP01_NAMED_VOID' => 71,
			"\@{" => 91,
			'OP22_LOGICAL_NEG' => 73,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 74,
			"for my integer" => -139,
			'LBRACKET' => 93,
			'LITERAL_NUMBER' => 108,
			'WORD_UPPERCASE' => 85,
			"if (" => 112,
			'OP19_LOOP_CONTROL' => 113,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP05_MATH_NEG_LPAREN' => 115,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 80,
			"foreach my" => -139,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_CLOSE' => 107
		},
		GOTOS => {
			'PLUS-27' => 394,
			'SubExpression' => 86,
			'ArrayReference' => 111,
			'Literal' => 88,
			'Operation' => 395,
			'VariableDeclaration' => 105,
			'HashDereferenced' => 106,
			'Expression' => 84,
			'Conditional' => 103,
			'Variable' => 104,
			'OPTIONAL-35' => 81,
			'WordScoped' => 77,
			'VariableModification' => 79,
			'HashReference' => 101,
			'LoopLabel' => 98,
			'Statement' => 92,
			'Operator' => 94,
			'OperatorVoid' => 95,
			'ArrayDereferenced' => 90,
			'PAREN-34' => 72
		}
	},
	{#State 391
		DEFAULT => -65
	},
	{#State 392
		DEFAULT => -47
	},
	{#State 393
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 396
		}
	},
	{#State 394
		ACTIONS => {
			"foreach my" => -139,
			'OP03_MATH_INC_DEC' => 82,
			'OP19_LOOP_CONTROL_SCOLON' => 83,
			"}" => 398,
			'VARIABLE_SYMBOL' => 80,
			'WORD' => 26,
			'WORD_UPPERCASE' => 85,
			'OP22_LOGICAL_NEG' => 73,
			'OP10_NAMED_UNARY' => 74,
			'OP01_NAMED_VOID' => 71,
			'LBRACE' => 70,
			'OP01_PRINT' => 78,
			'OP05_LOGICAL_NEG' => 76,
			"undef" => 75,
			"while (" => -139,
			'OP01_CLOSE' => 107,
			'OP01_NAMED_VOID_SCOLON' => 114,
			'OP05_MATH_NEG_LPAREN' => 115,
			"if (" => 112,
			'OP19_LOOP_CONTROL' => 113,
			'LITERAL_NUMBER' => 108,
			"for my integer" => -139,
			'LBRACKET' => 93,
			"\@{" => 91,
			'WORD_SCOPED' => 24,
			"my" => 89,
			'OP01_NAMED' => 100,
			'OP01_OPEN' => 102,
			'LITERAL_STRING' => 97,
			'LPAREN' => 99,
			"%{" => 96
		},
		GOTOS => {
			'Conditional' => 103,
			'Variable' => 104,
			'OPTIONAL-35' => 81,
			'HashDereferenced' => 106,
			'VariableDeclaration' => 105,
			'Expression' => 84,
			'ArrayReference' => 111,
			'SubExpression' => 86,
			'Operation' => 397,
			'Literal' => 88,
			'PAREN-34' => 72,
			'ArrayDereferenced' => 90,
			'Operator' => 94,
			'Statement' => 92,
			'OperatorVoid' => 95,
			'LoopLabel' => 98,
			'WordScoped' => 77,
			'HashReference' => 101,
			'VariableModification' => 79
		}
	},
	{#State 395
		DEFAULT => -68
	},
	{#State 396
		ACTIONS => {
			'OP21_LIST_COMMA' => 401,
			")" => 399
		},
		GOTOS => {
			'PAREN-28' => 400
		}
	},
	{#State 397
		DEFAULT => -67
	},
	{#State 398
		ACTIONS => {
			";" => 402
		}
	},
	{#State 399
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 403
		}
	},
	{#State 400
		DEFAULT => -71
	},
	{#State 401
		ACTIONS => {
			"my" => 404
		}
	},
	{#State 402
		DEFAULT => -69
	},
	{#State 403
		ACTIONS => {
			"\@_;" => 405
		}
	},
	{#State 404
		ACTIONS => {
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 406
		}
	},
	{#State 405
		DEFAULT => -73
	},
	{#State 406
		ACTIONS => {
			'VARIABLE_SYMBOL' => 407
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
#line 5738 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5745 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5752 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5759 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5770 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5781 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5788 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5795 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5802 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5816 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5823 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5830 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5837 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5844 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5851 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5858 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5865 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5876 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5901 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5912 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5965 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5972 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6026 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6033 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6051 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6062 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6073 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6080 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6094 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6112 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6144 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6151 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6186 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6193 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6200 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6243 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6254 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6275 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6336 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6479 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6490 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6501 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6512 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6523 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6600 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6611 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6622 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6644 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6655 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6677 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6688 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6720 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6731 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6742 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6753 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6764 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6775 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6786 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6793 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6800 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6869 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6880 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6891 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6902 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6913 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6924 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6935 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6946 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6957 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6968 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6979 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6990 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7011 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7022 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7033 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7073 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7080 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7087 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7094 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7108 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7119 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7130 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7141 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7152 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7163 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7185 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7192 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7235 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7246 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7268 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7279 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7290 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7301 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7312 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7319 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7333 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7347 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_176
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7358 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_177
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7369 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7380 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7391 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_183
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_184
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7438 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7445 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7452 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_187
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7463 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_188
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7474 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_189
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7485 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_190
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7503 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_194
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7528 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_195
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7539 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7550 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_197
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7561 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7572 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_199
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7583 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_200
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7594 lib/RPerl/Grammar.pm
	],
	[#Rule Type_201
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7605 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_202
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7616 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_203
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7627 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_204
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7638 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_205
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_206
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7660 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7671 lib/RPerl/Grammar.pm
	]
],
#line 7674 lib/RPerl/Grammar.pm
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_176', 
         'ListElements_177', 
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
         'TypeInner_202', 
         'TypeInnerConstant_203', 
         'VariableOrLiteral_204', 
         'VariableOrLiteral_205', 
         'Literal_206', 
         'Literal_207', );
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


#line 7930 lib/RPerl/Grammar.pm



1;
