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
    our $VERSION = 0.000_967;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\$TYPED_|\=\ sub\ \{|while\ \(|package|elsif\ \(|undef|else|if\ \(|our|use|qw\(|\@_\;|my|\@\{|\%\{|\}|\]|\)|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
      /\G([a-zA-Z]\w*__method)/gc and return ('TYPE_METHOD', $1);
      /\G((?:[a-zA-Z]\w*)?(?:::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
      /\G(keys|values)\s/gc and return ('KEYS_OR_VALUES', $1);
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
      /\G(sin|cos|push|pop|ETC)\s/gc and return ('OP01_NAMED', $1);
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
  [ 'SubExpression_134' => 'SubExpression', [ 'LBRACE', '}' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_136' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_137' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-34', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'PAREN-34' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Statement_141' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_142' => 'Statement', [ 'OPTIONAL-35', 'Loop' ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Conditional_152' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-37', 'OPTIONAL-39' ], 0 ],
  [ 'Loop_153' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_154' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_155' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_156' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_157' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_158' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'PLUS-40', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'Operation' ], 0 ],
  [ 'CodeBlock_161' => 'CodeBlock', [ 'LBRACE', 'PLUS-40', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ 'Variable_164' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-41' ], 0 ],
  [ 'VariableRetrieval_165' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_166' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_167' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_168' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_169' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_170' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_171' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'PAREN-42' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'WORD' ], 0 ],
  [ 'ListElements_177' => 'ListElements', [ 'ListElement', 'STAR-43' ], 0 ],
  [ 'ListElements_178' => 'ListElements', [ 'OP01_QW', 'PLUS-44', ')' ], 0 ],
  [ 'ListElement_179' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_180' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_181' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'ArrayReference_184' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-45', ']' ], 0 ],
  [ 'ArrayDereferenced_185' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_186' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'HashEntry_189' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-46', 'SubExpression' ], 0 ],
  [ 'HashEntry_190' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_191' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_192' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ 'HashReference_196' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-48', '}' ], 0 ],
  [ 'HashDereferenced_197' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_198' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_199' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_200' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_201' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_202' => 'Type', [ 'WORD' ], 0 ],
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
  'SubExpression_135' => 135,
  'SubExpressionOrStdin_136' => 136,
  'SubExpressionOrStdin_137' => 137,
  '_PAREN' => 138,
  '_OPTIONAL' => 139,
  '_OPTIONAL' => 140,
  'Statement_141' => 141,
  'Statement_142' => 142,
  'Statement_143' => 143,
  'Statement_144' => 144,
  'Statement_145' => 145,
  '_PAREN' => 146,
  '_STAR_LIST' => 147,
  '_STAR_LIST' => 148,
  '_PAREN' => 149,
  '_OPTIONAL' => 150,
  '_OPTIONAL' => 151,
  'Conditional_152' => 152,
  'Loop_153' => 153,
  'Loop_154' => 154,
  'Loop_155' => 155,
  'LoopFor_156' => 156,
  'LoopForEach_157' => 157,
  'LoopWhile_158' => 158,
  '_PLUS_LIST' => 159,
  '_PLUS_LIST' => 160,
  'CodeBlock_161' => 161,
  '_STAR_LIST' => 162,
  '_STAR_LIST' => 163,
  'Variable_164' => 164,
  'VariableRetrieval_165' => 165,
  'VariableRetrieval_166' => 166,
  'VariableRetrieval_167' => 167,
  'VariableDeclaration_168' => 168,
  'VariableDeclaration_169' => 169,
  'VariableModification_170' => 170,
  'VariableModification_171' => 171,
  '_PAREN' => 172,
  '_STAR_LIST' => 173,
  '_STAR_LIST' => 174,
  '_PLUS_LIST' => 175,
  '_PLUS_LIST' => 176,
  'ListElements_177' => 177,
  'ListElements_178' => 178,
  'ListElement_179' => 179,
  'ListElement_180' => 180,
  'ListElement_181' => 181,
  '_OPTIONAL' => 182,
  '_OPTIONAL' => 183,
  'ArrayReference_184' => 184,
  'ArrayDereferenced_185' => 185,
  'ArrayDereferenced_186' => 186,
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
  'HashDereferenced_197' => 197,
  'HashDereferenced_198' => 198,
  'WordScoped_199' => 199,
  'WordScoped_200' => 200,
  'LoopLabel_201' => 201,
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
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 2
		},
		GOTOS => {
			'Critic' => 4,
			'OPTIONAL-9' => 1,
			'PAREN-1' => 5,
			'CompileUnit' => 6,
			'Program' => 7,
			'PLUS-2' => 3,
			'ModuleHeader' => 8
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 11,
			'OPTIONAL-3' => 12
		}
	},
	{#State 3
		ACTIONS => {
			"## no critic qw(" => 9,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'ModuleHeader' => 8,
			'Critic' => 4,
			'OPTIONAL-9' => 1,
			'PAREN-1' => 13
		}
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			'' => 14
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"use" => -25,
			"use parent qw(" => 19,
			"use constant" => -25,
			"## no critic qw(" => -25,
			"our" => -25
		},
		GOTOS => {
			'STAR-10' => 18,
			'Class' => 15,
			'Package' => 17,
			'Module' => 16
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
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		ACTIONS => {
			"use strict;" => 25
		},
		GOTOS => {
			'Header' => 26
		}
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		DEFAULT => -23
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		DEFAULT => -22
	},
	{#State 18
		ACTIONS => {
			"our" => -27,
			"## no critic qw(" => 9,
			"use constant" => -27,
			"use" => -27
		},
		GOTOS => {
			'STAR-11' => 28,
			'Critic' => 27
		}
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 29
		}
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
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -199
	},
	{#State 24
		DEFAULT => -200
	},
	{#State 25
		ACTIONS => {
			"use warnings;" => 33
		}
	},
	{#State 26
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 34
		}
	},
	{#State 27
		DEFAULT => -24
	},
	{#State 28
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 37
		},
		GOTOS => {
			'Include' => 36,
			'STAR-12' => 35
		}
	},
	{#State 29
		ACTIONS => {
			")" => 38
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
			"use strict;" => 25
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use RPerl;" => 40
		}
	},
	{#State 34
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -11,
			'LBRACE' => -11,
			"my" => -11,
			"\@{" => -11,
			'WORD' => -11,
			"## no critic qw(" => 9,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_CLOSE' => -11,
			"%{" => -11,
			'LPAREN' => -11,
			'OP01_NAMED' => -11,
			'OP01_PRINT' => -11,
			'OP10_NAMED_UNARY' => -11,
			"our" => -11,
			"foreach my" => -11,
			"for my integer" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"while (" => -11,
			'LITERAL_NUMBER' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"if (" => -11,
			"undef" => -11,
			'LBRACKET' => -11,
			"use constant" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'VARIABLE_SYMBOL' => -11,
			"use" => -11,
			'WORD_SCOPED' => -11,
			'LITERAL_STRING' => -11,
			'OP01_OPEN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11
		},
		GOTOS => {
			'Critic' => 42,
			'STAR-5' => 41
		}
	},
	{#State 35
		ACTIONS => {
			"our" => 47,
			"use constant" => 44
		},
		GOTOS => {
			'PLUS-13' => 46,
			'Constant' => 43,
			'Subroutine' => 45
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 23
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
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 41
		ACTIONS => {
			"\@{" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"my" => -13,
			'LBRACE' => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"%{" => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED' => -13,
			'LPAREN' => -13,
			"for my integer" => -13,
			"foreach my" => -13,
			"our" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_PRINT' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED_VOID' => -13,
			'LITERAL_NUMBER' => -13,
			"while (" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACKET' => -13,
			"if (" => -13,
			"undef" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD_UPPERCASE' => -13,
			"use constant" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'WORD_SCOPED' => -13,
			"use" => 37,
			'VARIABLE_SYMBOL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_OPEN' => -13,
			'LITERAL_STRING' => -13
		},
		GOTOS => {
			'STAR-6' => 52,
			'Include' => 51
		}
	},
	{#State 42
		DEFAULT => -8
	},
	{#State 43
		DEFAULT => -28
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 53
		}
	},
	{#State 45
		DEFAULT => -31
	},
	{#State 46
		ACTIONS => {
			"our" => 47,
			'LITERAL_NUMBER' => 55
		},
		GOTOS => {
			'Subroutine' => 54
		}
	},
	{#State 47
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 48
		ACTIONS => {
			";" => 58,
			"qw(" => 59
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 37
		},
		GOTOS => {
			'Include' => 60
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 61
		}
	},
	{#State 51
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			'OP01_PRINT' => -15,
			'OP10_NAMED_UNARY' => -15,
			"our" => -15,
			"foreach my" => -15,
			"for my integer" => -15,
			'LPAREN' => -15,
			'OP01_NAMED' => -15,
			'OP01_CLOSE' => -15,
			"%{" => -15,
			'OP22_LOGICAL_NEG' => -15,
			'WORD' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'LBRACE' => -15,
			"my" => -15,
			"\@{" => -15,
			'LITERAL_STRING' => -15,
			'OP01_OPEN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'VARIABLE_SYMBOL' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"use constant" => 44,
			'WORD_UPPERCASE' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"undef" => -15,
			"if (" => -15,
			'LBRACKET' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"while (" => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP05_MATH_NEG_LPAREN' => -15
		},
		GOTOS => {
			'STAR-7' => 63,
			'Constant' => 62
		}
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 54
		DEFAULT => -30
	},
	{#State 55
		ACTIONS => {
			";" => 65
		}
	},
	{#State 56
		DEFAULT => -202
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 58
		DEFAULT => -39
	},
	{#State 59
		ACTIONS => {
			'WORD' => 68
		},
		GOTOS => {
			'PLUS-15' => 67
		}
	},
	{#State 60
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 69
		}
	},
	{#State 61
		DEFAULT => -33
	},
	{#State 62
		DEFAULT => -12
	},
	{#State 63
		ACTIONS => {
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"my" => 106,
			"for my integer" => -140,
			"foreach my" => -140,
			"our" => 47,
			'OP10_NAMED_UNARY' => 103,
			'OP01_PRINT' => 102,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'OP01_NAMED' => 100,
			'LPAREN' => 97,
			'LITERAL_NUMBER' => 89,
			"while (" => -140,
			'OP03_MATH_INC_DEC' => 91,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_NAMED_VOID' => 88,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP19_LOOP_CONTROL_SCOLON' => 80,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'LBRACKET' => 70,
			"undef" => 72,
			"if (" => 73,
			'OP19_LOOP_CONTROL' => 71,
			'WORD_UPPERCASE' => 74,
			'OP01_NAMED_VOID_SCOLON' => 75
		},
		GOTOS => {
			'Statement' => 82,
			'PAREN-34' => 84,
			'ArrayReference' => 101,
			'VariableDeclaration' => 78,
			'OperatorVoid' => 96,
			'OPTIONAL-35' => 98,
			'HashReference' => 76,
			'PLUS-8' => 99,
			'SubExpression' => 77,
			'Variable' => 95,
			'Subroutine' => 92,
			'Literal' => 114,
			'Expression' => 113,
			'HashDereferenced' => 112,
			'Operation' => 90,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Conditional' => 108,
			'LoopLabel' => 104,
			'VariableModification' => 85
		}
	},
	{#State 64
		ACTIONS => {
			"my" => 116
		},
		GOTOS => {
			'TypeInnerConstant' => 117
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 118
		}
	},
	{#State 67
		ACTIONS => {
			")" => 120,
			'WORD' => 119
		}
	},
	{#State 68
		DEFAULT => -38
	},
	{#State 69
		ACTIONS => {
			"## no critic qw(" => 9,
			"use constant" => -54,
			"use" => -54,
			"our hash_ref \$properties" => -54
		},
		GOTOS => {
			'Critic' => 122,
			'STAR-21' => 121
		}
	},
	{#State 70
		ACTIONS => {
			'OP01_QW' => 125,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'KEYS_OR_VALUES' => 132,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 123,
			"\@{" => 109,
			"]" => -183,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'LBRACKET' => 70
		},
		GOTOS => {
			'Variable' => 130,
			'ListElements' => 129,
			'TypeInner' => 124,
			'SubExpression' => 133,
			'HashReference' => 76,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'WordScoped' => 110,
			'ArrayReference' => 101,
			'OPTIONAL-45' => 126,
			'Literal' => 114,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'ListElement' => 131
		}
	},
	{#State 71
		ACTIONS => {
			'WORD_UPPERCASE' => 135
		},
		GOTOS => {
			'LoopLabel' => 136
		}
	},
	{#State 72
		DEFAULT => -127
	},
	{#State 73
		ACTIONS => {
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LBRACKET' => 70,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'Variable' => 130,
			'WordScoped' => 110,
			'SubExpression' => 137,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111,
			'ArrayReference' => 101,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114
		}
	},
	{#State 74
		ACTIONS => {
			'LPAREN' => 138,
			'COLON' => -201
		}
	},
	{#State 75
		DEFAULT => -112
	},
	{#State 76
		DEFAULT => -132
	},
	{#State 77
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 78
		DEFAULT => -144
	},
	{#State 79
		DEFAULT => -163,
		GOTOS => {
			'STAR-41' => 156
		}
	},
	{#State 80
		DEFAULT => -115
	},
	{#State 81
		DEFAULT => -207
	},
	{#State 82
		DEFAULT => -77
	},
	{#State 83
		ACTIONS => {
			"my" => 157
		}
	},
	{#State 84
		DEFAULT => -139
	},
	{#State 85
		DEFAULT => -145
	},
	{#State 86
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LBRACKET' => 70,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Literal' => 114,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'ArrayReference' => 101,
			'SubExpression' => 158,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'HashReference' => 76,
			'WordScoped' => 110,
			'Variable' => 130
		}
	},
	{#State 87
		DEFAULT => -131
	},
	{#State 88
		ACTIONS => {
			'KEYS_OR_VALUES' => 132,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			'OP01_QW' => 125,
			'OP03_MATH_INC_DEC' => 91,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 123,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'LBRACKET' => 70,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134
		},
		GOTOS => {
			'Variable' => 130,
			'ListElements' => 159,
			'TypeInner' => 124,
			'SubExpression' => 133,
			'HashReference' => 76,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'ListElement' => 131
		}
	},
	{#State 89
		DEFAULT => -208
	},
	{#State 90
		DEFAULT => -17
	},
	{#State 91
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 160
		}
	},
	{#State 92
		DEFAULT => -14
	},
	{#State 93
		ACTIONS => {
			'FH_REF_SYMBOL' => 161
		}
	},
	{#State 94
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'LBRACE' => 163
		},
		GOTOS => {
			'Variable' => 164,
			'HashReference' => 162
		}
	},
	{#State 95
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 165,
			'OP09_BITWISE_SHIFT' => -129,
			'OP18_TERNARY' => -129,
			'OP04_MATH_POW' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 166,
			'OP15_LOGICAL_AND' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP19_VARIABLE_ASSIGN' => 168,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP02_METHOD_THINARROW' => 167,
			'OP16_LOGICAL_OR' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP08_STRING_CAT' => -129,
			'OP23_LOGICAL_AND' => -129
		}
	},
	{#State 96
		DEFAULT => -143
	},
	{#State 97
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 81,
			'OP01_PRINT' => 170,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'LBRACKET' => 70,
			'LPAREN' => 97,
			'OP01_NAMED' => 171,
			'WORD_UPPERCASE' => 134,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'HashReference' => 76,
			'SubExpression' => 169,
			'Variable' => 130
		}
	},
	{#State 98
		ACTIONS => {
			"for my integer" => 174,
			"foreach my" => 173,
			"while (" => 175
		},
		GOTOS => {
			'LoopWhile' => 178,
			'Loop' => 172,
			'LoopFor' => 176,
			'LoopForEach' => 177
		}
	},
	{#State 99
		ACTIONS => {
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'OP19_LOOP_CONTROL_SCOLON' => 80,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP01_NAMED_VOID_SCOLON' => 75,
			'WORD_UPPERCASE' => 74,
			'' => -18,
			"undef" => 72,
			"if (" => 73,
			'OP19_LOOP_CONTROL' => 71,
			'LBRACKET' => 70,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_NUMBER' => 89,
			"while (" => -140,
			'OP01_NAMED_VOID' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP10_NAMED_UNARY' => 103,
			'OP01_PRINT' => 102,
			"foreach my" => -140,
			"for my integer" => -140,
			'OP01_NAMED' => 100,
			'LPAREN' => 97,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'OP22_LOGICAL_NEG' => 115,
			'WORD' => 23,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 106,
			'LBRACE' => 107
		},
		GOTOS => {
			'VariableDeclaration' => 78,
			'ArrayReference' => 101,
			'PAREN-34' => 84,
			'Statement' => 82,
			'Variable' => 95,
			'SubExpression' => 77,
			'HashReference' => 76,
			'OPTIONAL-35' => 98,
			'OperatorVoid' => 96,
			'Operation' => 179,
			'HashDereferenced' => 112,
			'Expression' => 113,
			'Literal' => 114,
			'VariableModification' => 85,
			'LoopLabel' => 104,
			'Conditional' => 108,
			'WordScoped' => 110,
			'Operator' => 111,
			'ArrayDereferenced' => 87
		}
	},
	{#State 100
		ACTIONS => {
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'LBRACKET' => 70,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			"my" => 123,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'KEYS_OR_VALUES' => 132,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91
		},
		GOTOS => {
			'TypeInner' => 124,
			'Variable' => 130,
			'WordScoped' => 110,
			'SubExpression' => 181,
			'Operator' => 111,
			'HashReference' => 76,
			'ArrayDereferenced' => 87,
			'ArrayReference' => 101,
			'ListElement' => 180,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114
		}
	},
	{#State 101
		DEFAULT => -130
	},
	{#State 102
		ACTIONS => {
			'WORD_UPPERCASE' => -109,
			'LPAREN' => -109,
			'OP01_NAMED' => -109,
			'STDOUT_STDERR' => 184,
			'LBRACKET' => -109,
			'OP01_CLOSE' => -109,
			"%{" => -109,
			"undef" => -109,
			'LITERAL_STRING' => -109,
			'OP01_OPEN' => -109,
			'OP10_NAMED_UNARY' => -109,
			'WORD_SCOPED' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			"my" => -109,
			'FH_REF_SYMBOL_BRACES' => 182,
			'LBRACE' => -109,
			'OP05_LOGICAL_NEG' => -109,
			"\@{" => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'OP01_QW' => -109,
			'LITERAL_NUMBER' => -109,
			'WORD' => -109,
			'KEYS_OR_VALUES' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 183,
			'PAREN-30' => 185
		}
	},
	{#State 103
		ACTIONS => {
			'OP04_MATH_POW' => -95,
			'WORD' => 23,
			'OP08_MATH_ADD_SUB' => -95,
			";" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP18_TERNARY' => -95,
			'OP22_LOGICAL_NEG' => 115,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			")" => -95,
			"\@{" => 109,
			'OP21_LIST_COMMA' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 94,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP01_CLOSE' => 93,
			'OP23_LOGICAL_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			"}" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'LITERAL_NUMBER' => 89,
			'OP15_LOGICAL_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP03_MATH_INC_DEC' => 91,
			"]" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD_SCOPED' => 24,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'VARIABLE_SYMBOL' => 79,
			'LITERAL_STRING' => 81,
			'OP06_REGEX_MATCH' => -95,
			'OP01_OPEN' => 83,
			'LBRACKET' => 70,
			'OP07_STRING_REPEAT' => -95,
			'OP08_STRING_CAT' => -95,
			"undef" => 72,
			'WORD_UPPERCASE' => 134
		},
		GOTOS => {
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'SubExpression' => 186,
			'HashReference' => 76,
			'Variable' => 130
		}
	},
	{#State 104
		ACTIONS => {
			'COLON' => 187
		}
	},
	{#State 105
		ACTIONS => {
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LBRACKET' => 70,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89
		},
		GOTOS => {
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'HashReference' => 76,
			'SubExpression' => 188,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'Variable' => 130
		}
	},
	{#State 106
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 189
		}
	},
	{#State 107
		ACTIONS => {
			'WORD' => 192,
			"%{" => 94,
			"}" => 190
		},
		GOTOS => {
			'HashEntry' => 191,
			'HashDereferenced' => 193
		}
	},
	{#State 108
		DEFAULT => -141
	},
	{#State 109
		ACTIONS => {
			'LBRACKET' => 70,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 195,
			'ArrayReference' => 194
		}
	},
	{#State 110
		ACTIONS => {
			'LPAREN' => 196,
			'OP02_METHOD_THINARROW_NEW' => 197
		}
	},
	{#State 111
		DEFAULT => -121
	},
	{#State 112
		DEFAULT => -133
	},
	{#State 113
		ACTIONS => {
			'OP16_LOGICAL_OR' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP08_STRING_CAT' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP13_BITWISE_AND' => -126,
			";" => 198,
			'OP04_MATH_POW' => -126,
			'OP18_TERNARY' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP11_COMPARE_LT_GT' => -126
		}
	},
	{#State 114
		DEFAULT => -128
	},
	{#State 115
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'LBRACKET' => 70,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Variable' => 130,
			'SubExpression' => 199,
			'HashReference' => 76,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110
		}
	},
	{#State 116
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 200
		}
	},
	{#State 117
		ACTIONS => {
			'LITERAL_NUMBER' => 89,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Literal' => 201
		}
	},
	{#State 118
		ACTIONS => {
			'LBRACE' => -43,
			"my" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"\@{" => -43,
			'LPAREN_MY' => 204,
			'WORD' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_CLOSE' => -43,
			"%{" => -43,
			'LPAREN' => -43,
			'OP01_NAMED' => -43,
			'OP01_PRINT' => -43,
			'OP10_NAMED_UNARY' => -43,
			"for my integer" => -43,
			"foreach my" => -43,
			'OP01_NAMED_VOID' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"while (" => -43,
			'LITERAL_NUMBER' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"if (" => -43,
			"undef" => -43,
			'LBRACKET' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'WORD_UPPERCASE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'WORD_SCOPED' => -43,
			'LITERAL_STRING' => -43,
			'OP01_OPEN' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 203,
			'SubroutineArguments' => 202
		}
	},
	{#State 119
		DEFAULT => -37
	},
	{#State 120
		ACTIONS => {
			";" => 205
		}
	},
	{#State 121
		ACTIONS => {
			"our hash_ref \$properties" => -56,
			"use" => 37,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 207,
			'STAR-22' => 206
		}
	},
	{#State 122
		DEFAULT => -51
	},
	{#State 123
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 208
		}
	},
	{#State 124
		ACTIONS => {
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'LBRACKET' => 70,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23
		},
		GOTOS => {
			'Variable' => 130,
			'SubExpression' => 209,
			'HashReference' => 76,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 211
		},
		GOTOS => {
			'PLUS-44' => 210
		}
	},
	{#State 126
		ACTIONS => {
			"]" => 212
		}
	},
	{#State 127
		DEFAULT => -126
	},
	{#State 128
		ACTIONS => {
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'LBRACKET' => 70,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107
		},
		GOTOS => {
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'ArrayReference' => 101,
			'SubExpression' => 213,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111,
			'WordScoped' => 110,
			'Variable' => 130
		}
	},
	{#State 129
		DEFAULT => -182
	},
	{#State 130
		ACTIONS => {
			'OP18_TERNARY' => -129,
			'OP03_MATH_INC_DEC' => 165,
			'OP09_BITWISE_SHIFT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP13_BITWISE_AND' => -129,
			";" => -129,
			'OP04_MATH_POW' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			")" => -129,
			"]" => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP02_METHOD_THINARROW' => 167,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			"}" => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP08_STRING_CAT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP07_STRING_REPEAT' => -129
		}
	},
	{#State 131
		DEFAULT => -174,
		GOTOS => {
			'STAR-43' => 214
		}
	},
	{#State 132
		ACTIONS => {
			"%{" => 94
		},
		GOTOS => {
			'HashDereferenced' => 215
		}
	},
	{#State 133
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140,
			'OP06_REGEX_MATCH' => 142,
			'OP21_LIST_COMMA' => -179,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			"]" => -179,
			")" => -179,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP13_BITWISE_AND' => 154,
			";" => -179
		}
	},
	{#State 134
		ACTIONS => {
			'LPAREN' => 138
		}
	},
	{#State 135
		DEFAULT => -201
	},
	{#State 136
		ACTIONS => {
			";" => 216
		}
	},
	{#State 137
		ACTIONS => {
			")" => 217,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP04_MATH_POW' => 152,
			'OP13_BITWISE_AND' => 154,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP07_STRING_REPEAT' => 139,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => 148,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP06_REGEX_MATCH' => 142
		}
	},
	{#State 138
		ACTIONS => {
			")" => 218
		}
	},
	{#State 139
		ACTIONS => {
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'LBRACKET' => 70,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89
		},
		GOTOS => {
			'Literal' => 114,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'ArrayReference' => 101,
			'Operator' => 111,
			'HashReference' => 76,
			'SubExpression' => 219,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Variable' => 130
		}
	},
	{#State 140
		ACTIONS => {
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LBRACKET' => 70,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89
		},
		GOTOS => {
			'ArrayReference' => 101,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'Variable' => 130,
			'WordScoped' => 110,
			'SubExpression' => 220,
			'HashReference' => 76,
			'ArrayDereferenced' => 87,
			'Operator' => 111
		}
	},
	{#State 141
		ACTIONS => {
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'LBRACKET' => 70,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97
		},
		GOTOS => {
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111,
			'SubExpression' => 221,
			'Variable' => 130,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'ArrayReference' => 101
		}
	},
	{#State 142
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 222
		}
	},
	{#State 143
		ACTIONS => {
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'LBRACKET' => 70,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91
		},
		GOTOS => {
			'Variable' => 130,
			'WordScoped' => 110,
			'SubExpression' => 223,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111,
			'ArrayReference' => 101,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114
		}
	},
	{#State 144
		ACTIONS => {
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'LBRACKET' => 70,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111,
			'SubExpression' => 224,
			'WordScoped' => 110,
			'Variable' => 130,
			'Literal' => 114,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'ArrayReference' => 101
		}
	},
	{#State 145
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'LBRACKET' => 70,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72
		},
		GOTOS => {
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'SubExpression' => 225,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111,
			'Variable' => 130
		}
	},
	{#State 146
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'LBRACKET' => 70,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Operator' => 111,
			'SubExpression' => 226,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'WordScoped' => 110,
			'Variable' => 130,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'ArrayReference' => 101
		}
	},
	{#State 147
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LBRACKET' => 70,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109
		},
		GOTOS => {
			'WordScoped' => 110,
			'SubExpression' => 227,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111,
			'Variable' => 130,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'ArrayReference' => 101
		}
	},
	{#State 148
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'LBRACKET' => 70,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'Variable' => 130,
			'WordScoped' => 110,
			'HashReference' => 76,
			'SubExpression' => 228,
			'ArrayDereferenced' => 87,
			'Operator' => 111
		}
	},
	{#State 149
		ACTIONS => {
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'LBRACKET' => 70,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83
		},
		GOTOS => {
			'Variable' => 130,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'HashReference' => 76,
			'SubExpression' => 229,
			'ArrayReference' => 101,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114
		}
	},
	{#State 150
		ACTIONS => {
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'LBRACKET' => 70,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'WordScoped' => 110,
			'SubExpression' => 230,
			'HashReference' => 76,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'Variable' => 130,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'ArrayReference' => 101
		}
	},
	{#State 151
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'LBRACKET' => 70,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Variable' => 130,
			'WordScoped' => 110,
			'Operator' => 111,
			'SubExpression' => 231,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'ArrayReference' => 101,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114
		}
	},
	{#State 152
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LBRACKET' => 70,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Variable' => 130,
			'SubExpression' => 232,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'WordScoped' => 110
		}
	},
	{#State 153
		ACTIONS => {
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'LBRACKET' => 70,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23
		},
		GOTOS => {
			'Variable' => 130,
			'Operator' => 111,
			'HashReference' => 76,
			'SubExpression' => 233,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127
		}
	},
	{#State 154
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'LBRACKET' => 70,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'Variable' => 130,
			'WordScoped' => 110,
			'Operator' => 111,
			'HashReference' => 76,
			'SubExpression' => 234,
			'ArrayDereferenced' => 87
		}
	},
	{#State 155
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'LITERAL_NUMBER' => 89,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'Literal' => 235,
			'Variable' => 237,
			'VariableOrLiteral' => 236
		}
	},
	{#State 156
		ACTIONS => {
			")" => -164,
			"]" => -164,
			'OP02_ARRAY_THINARROW' => 238,
			'OP17_LIST_RANGE' => -164,
			'OP11_COMPARE_LT_GT' => -164,
			'OP08_MATH_ADD_SUB' => -164,
			'OP19_VARIABLE_ASSIGN_BY' => -164,
			'OP15_LOGICAL_AND' => -164,
			'OP13_BITWISE_AND' => -164,
			";" => -164,
			'COLON' => -164,
			'OP04_MATH_POW' => -164,
			'OP18_TERNARY' => -164,
			'OP03_MATH_INC_DEC' => -164,
			'OP09_BITWISE_SHIFT' => -164,
			'OP12_COMPARE_EQ_NE' => -164,
			'OP08_STRING_CAT' => -164,
			'OP23_LOGICAL_AND' => -164,
			'OP07_STRING_REPEAT' => -164,
			'OP24_LOGICAL_OR_XOR' => -164,
			"}" => -164,
			'OP02_HASH_THINARROW' => 239,
			'OP14_BITWISE_OR_XOR' => -164,
			'OP16_LOGICAL_OR' => -164,
			'OP21_LIST_COMMA' => -164,
			'OP07_MATH_MULT_DIV_MOD' => -164,
			'OP02_METHOD_THINARROW' => -164,
			'OP19_VARIABLE_ASSIGN' => -164,
			'OP06_REGEX_MATCH' => -164
		},
		GOTOS => {
			'VariableRetrieval' => 240
		}
	},
	{#State 157
		ACTIONS => {
			"filehandle_ref" => 241
		}
	},
	{#State 158
		ACTIONS => {
			'OP18_TERNARY' => 155,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 154,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143,
			")" => 242,
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => 148,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 159
		ACTIONS => {
			";" => 243
		}
	},
	{#State 160
		DEFAULT => -83
	},
	{#State 161
		DEFAULT => -82
	},
	{#State 162
		ACTIONS => {
			"}" => 244
		}
	},
	{#State 163
		ACTIONS => {
			"%{" => 94,
			'WORD' => 192
		},
		GOTOS => {
			'HashDereferenced' => 193,
			'HashEntry' => 191
		}
	},
	{#State 164
		ACTIONS => {
			"}" => 245
		}
	},
	{#State 165
		DEFAULT => -84
	},
	{#State 166
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'LBRACKET' => 70
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Variable' => 130,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'SubExpression' => 246,
			'HashReference' => 76,
			'WordScoped' => 110
		}
	},
	{#State 167
		ACTIONS => {
			'LPAREN' => 247
		}
	},
	{#State 168
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'LBRACKET' => 70,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'STDIN' => 249,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'ArrayReference' => 101,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'Variable' => 130,
			'WordScoped' => 110,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'SubExpression' => 248,
			'SubExpressionOrStdin' => 250
		}
	},
	{#State 169
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139,
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143,
			")" => 251,
			'OP18_TERNARY' => 155,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 154,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP04_MATH_POW' => 152
		}
	},
	{#State 170
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 252
		}
	},
	{#State 171
		ACTIONS => {
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 123,
			'OP05_MATH_NEG_LPAREN' => 86,
			'KEYS_OR_VALUES' => 132,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'LBRACKET' => 70,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Literal' => 114,
			'ListElement' => 253,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Variable' => 130,
			'TypeInner' => 124,
			'HashReference' => 76,
			'Operator' => 111,
			'SubExpression' => 181,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110
		}
	},
	{#State 172
		DEFAULT => -142
	},
	{#State 173
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 254
		}
	},
	{#State 174
		ACTIONS => {
			'VARIABLE_SYMBOL' => 255
		}
	},
	{#State 175
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'LBRACKET' => 70,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Variable' => 130,
			'WordScoped' => 110,
			'HashReference' => 76,
			'ArrayDereferenced' => 87,
			'SubExpression' => 256,
			'Operator' => 111,
			'ArrayReference' => 101,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114
		}
	},
	{#State 176
		DEFAULT => -153
	},
	{#State 177
		DEFAULT => -154
	},
	{#State 178
		DEFAULT => -155
	},
	{#State 179
		DEFAULT => -16
	},
	{#State 180
		ACTIONS => {
			'OP21_LIST_COMMA' => 257
		}
	},
	{#State 181
		ACTIONS => {
			'OP04_MATH_POW' => -79,
			";" => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP18_TERNARY' => -79,
			")" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP21_LIST_COMMA' => -179,
			'OP16_LOGICAL_OR' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP24_LOGICAL_OR_XOR' => -79
		}
	},
	{#State 182
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			"my" => 123,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			'OP01_QW' => 125,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'KEYS_OR_VALUES' => 132,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'LBRACKET' => 70,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ListElement' => 131,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'SubExpression' => 133,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111,
			'TypeInner' => 124,
			'ListElements' => 258,
			'Variable' => 130
		}
	},
	{#State 183
		ACTIONS => {
			'KEYS_OR_VALUES' => 132,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			'OP01_QW' => 125,
			'OP03_MATH_INC_DEC' => 91,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"my" => 123,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'LBRACKET' => 70,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Literal' => 114,
			'ListElement' => 131,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'ListElements' => 259,
			'Variable' => 130,
			'TypeInner' => 124,
			'SubExpression' => 133,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'WordScoped' => 110
		}
	},
	{#State 184
		DEFAULT => -107
	},
	{#State 185
		DEFAULT => -108
	},
	{#State 186
		ACTIONS => {
			'OP18_TERNARY' => -94,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => -94,
			";" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP08_MATH_ADD_SUB' => 153,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => -94,
			'OP17_LIST_RANGE' => -94,
			")" => -94,
			"]" => -94,
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			"}" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 187
		DEFAULT => -138
	},
	{#State 188
		ACTIONS => {
			'OP04_MATH_POW' => 152,
			";" => -86,
			'OP13_BITWISE_AND' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP18_TERNARY' => -86,
			"]" => -86,
			")" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP08_STRING_CAT' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			"}" => -86,
			'OP24_LOGICAL_OR_XOR' => -86
		}
	},
	{#State 189
		ACTIONS => {
			'VARIABLE_SYMBOL' => 260
		}
	},
	{#State 190
		DEFAULT => -134
	},
	{#State 191
		DEFAULT => -195,
		GOTOS => {
			'STAR-48' => 261
		}
	},
	{#State 192
		ACTIONS => {
			'OP20_HASH_FATARROW' => 262
		}
	},
	{#State 193
		DEFAULT => -190
	},
	{#State 194
		ACTIONS => {
			"}" => 263
		}
	},
	{#State 195
		ACTIONS => {
			"}" => 264
		}
	},
	{#State 196
		ACTIONS => {
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LBRACKET' => 70,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_QW' => 125,
			'OP22_LOGICAL_NEG' => 115,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'KEYS_OR_VALUES' => 132,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			")" => -118,
			'LBRACE' => 107,
			"my" => 123,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'Operator' => 111,
			'HashReference' => 76,
			'SubExpression' => 133,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'OPTIONAL-32' => 265,
			'Variable' => 130,
			'ListElements' => 266,
			'TypeInner' => 124,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'ListElement' => 131,
			'ArrayReference' => 101
		}
	},
	{#State 197
		ACTIONS => {
			")" => 267
		}
	},
	{#State 198
		DEFAULT => -76
	},
	{#State 199
		ACTIONS => {
			'OP16_LOGICAL_OR' => 151,
			'OP21_LIST_COMMA' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP06_REGEX_MATCH' => 142,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP23_LOGICAL_AND' => -104,
			'OP08_STRING_CAT' => 140,
			'OP07_STRING_REPEAT' => 139,
			'OP24_LOGICAL_OR_XOR' => -104,
			"}" => -104,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP13_BITWISE_AND' => 154,
			";" => -104,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => 155,
			'OP09_BITWISE_SHIFT' => 146,
			")" => -104,
			"]" => -104,
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144
		}
	},
	{#State 200
		ACTIONS => {
			"\$TYPED_" => 268
		}
	},
	{#State 201
		ACTIONS => {
			";" => 269
		}
	},
	{#State 202
		DEFAULT => -42
	},
	{#State 203
		ACTIONS => {
			'WORD_UPPERCASE' => 74,
			'LPAREN' => 97,
			'OP01_NAMED_VOID_SCOLON' => 75,
			'OP01_NAMED' => 100,
			'LBRACKET' => 70,
			'OP19_LOOP_CONTROL' => 71,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			"if (" => 73,
			"for my integer" => -140,
			'OP19_LOOP_CONTROL_SCOLON' => 80,
			"foreach my" => -140,
			'LITERAL_STRING' => 81,
			'OP01_PRINT' => 102,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_NAMED_VOID' => 88,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 106,
			"\@{" => 109,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			"while (" => -140,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89
		},
		GOTOS => {
			'Operation' => 271,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 113,
			'Conditional' => 108,
			'LoopLabel' => 104,
			'VariableModification' => 85,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'WordScoped' => 110,
			'PLUS-17' => 270,
			'VariableDeclaration' => 78,
			'ArrayReference' => 101,
			'PAREN-34' => 84,
			'Statement' => 82,
			'Variable' => 95,
			'SubExpression' => 77,
			'HashReference' => 76,
			'OperatorVoid' => 96,
			'OPTIONAL-35' => 98
		}
	},
	{#State 204
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 272
		}
	},
	{#State 205
		DEFAULT => -40
	},
	{#State 206
		ACTIONS => {
			"use constant" => 44,
			"our hash_ref \$properties" => 273
		},
		GOTOS => {
			'Properties' => 275,
			'Constant' => 274
		}
	},
	{#State 207
		DEFAULT => -53
	},
	{#State 208
		ACTIONS => {
			"\$TYPED_" => 276
		}
	},
	{#State 209
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143,
			")" => -180,
			"]" => -180,
			'OP18_TERNARY' => 155,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 154,
			";" => -180,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 152,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139,
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -180
		}
	},
	{#State 210
		ACTIONS => {
			'WORD' => 278,
			")" => 277
		}
	},
	{#State 211
		DEFAULT => -176
	},
	{#State 212
		DEFAULT => -184
	},
	{#State 213
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -79,
			'OP17_LIST_RANGE' => -79,
			"]" => -79,
			")" => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP18_TERNARY' => -79,
			'OP04_MATH_POW' => -79,
			";" => -79,
			'OP13_BITWISE_AND' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			"}" => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_STRING_CAT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP16_LOGICAL_OR' => -79
		}
	},
	{#State 214
		ACTIONS => {
			'OP21_LIST_COMMA' => 280,
			"]" => -177,
			")" => -177,
			";" => -177
		},
		GOTOS => {
			'PAREN-42' => 279
		}
	},
	{#State 215
		DEFAULT => -181
	},
	{#State 216
		DEFAULT => -116
	},
	{#State 217
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 282
		}
	},
	{#State 218
		DEFAULT => -123
	},
	{#State 219
		ACTIONS => {
			"}" => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP08_STRING_CAT' => -89,
			'OP06_REGEX_MATCH' => 142,
			'OP21_LIST_COMMA' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			"]" => -89,
			")" => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP18_TERNARY' => -89,
			'OP04_MATH_POW' => 152,
			'OP15_LOGICAL_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP13_BITWISE_AND' => -89,
			";" => -89
		}
	},
	{#State 220
		ACTIONS => {
			'OP23_LOGICAL_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP07_STRING_REPEAT' => 139,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			"}" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -92,
			'OP06_REGEX_MATCH' => 142,
			")" => -92,
			"]" => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP17_LIST_RANGE' => -92,
			";" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => -92,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => -92,
			'OP09_BITWISE_SHIFT' => -92
		}
	},
	{#State 221
		ACTIONS => {
			'OP18_TERNARY' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP13_BITWISE_AND' => -90,
			";" => -90,
			'OP04_MATH_POW' => 152,
			'OP17_LIST_RANGE' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			")" => -90,
			"]" => -90,
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			"}" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP08_STRING_CAT' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 222
		DEFAULT => -88
	},
	{#State 223
		ACTIONS => {
			'OP13_BITWISE_AND' => 154,
			";" => -102,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => -102,
			'OP09_BITWISE_SHIFT' => 146,
			")" => -102,
			"]" => -102,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -102,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => -102,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => -102,
			"}" => -102
		}
	},
	{#State 224
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => undef,
			'OP17_LIST_RANGE' => -96,
			"]" => -96,
			")" => -96,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => -96,
			'OP04_MATH_POW' => 152,
			";" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP08_MATH_ADD_SUB' => 153,
			'OP14_BITWISE_OR_XOR' => -96,
			"}" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_STRING_REPEAT' => 139,
			'OP23_LOGICAL_AND' => -96,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -96,
			'OP16_LOGICAL_OR' => -96
		}
	},
	{#State 225
		ACTIONS => {
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -100,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => -100,
			"}" => -100,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139,
			'OP18_TERNARY' => -100,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 154,
			";" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 153,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => -100,
			")" => -100,
			"]" => -100
		}
	},
	{#State 226
		ACTIONS => {
			'OP18_TERNARY' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP13_BITWISE_AND' => -93,
			";" => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP08_MATH_ADD_SUB' => 153,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => -93,
			'OP17_LIST_RANGE' => -93,
			")" => -93,
			"]" => -93,
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			"}" => -93,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 227
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => undef,
			'OP23_LOGICAL_AND' => -97,
			'OP08_STRING_CAT' => 140,
			'OP07_STRING_REPEAT' => 139,
			'OP24_LOGICAL_OR_XOR' => -97,
			"}" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP06_REGEX_MATCH' => 142,
			")" => -97,
			"]" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP11_COMPARE_LT_GT' => 144,
			'OP15_LOGICAL_AND' => -97,
			'OP08_MATH_ADD_SUB' => 153,
			";" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => -97,
			'OP09_BITWISE_SHIFT' => 146
		}
	},
	{#State 228
		ACTIONS => {
			'OP18_TERNARY' => 155,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 154,
			";" => -105,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143,
			")" => -105,
			"]" => -105,
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -105,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => -105,
			"}" => -105,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 229
		ACTIONS => {
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -106,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => -106,
			"}" => -106,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139,
			'OP18_TERNARY' => 155,
			'OP09_BITWISE_SHIFT' => 146,
			'OP13_BITWISE_AND' => 154,
			";" => -106,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP04_MATH_POW' => 152,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143,
			")" => -106,
			"]" => -106
		}
	},
	{#State 230
		ACTIONS => {
			'OP17_LIST_RANGE' => -99,
			'OP11_COMPARE_LT_GT' => 144,
			")" => -99,
			"]" => -99,
			'OP18_TERNARY' => -99,
			'OP09_BITWISE_SHIFT' => 146,
			'OP15_LOGICAL_AND' => -99,
			'OP08_MATH_ADD_SUB' => 153,
			'OP13_BITWISE_AND' => 154,
			";" => -99,
			'OP04_MATH_POW' => 152,
			'OP24_LOGICAL_OR_XOR' => -99,
			"}" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => -99,
			'OP07_STRING_REPEAT' => 139,
			'OP06_REGEX_MATCH' => 142,
			'OP16_LOGICAL_OR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 141
		}
	},
	{#State 231
		ACTIONS => {
			'OP04_MATH_POW' => 152,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP13_BITWISE_AND' => 154,
			";" => -101,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => -101,
			"]" => -101,
			")" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP11_COMPARE_LT_GT' => 144,
			'OP21_LIST_COMMA' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => -101,
			'OP06_REGEX_MATCH' => 142,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => -101,
			"}" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP14_BITWISE_OR_XOR' => 150
		}
	},
	{#State 232
		ACTIONS => {
			")" => -85,
			"]" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP17_LIST_RANGE' => -85,
			";" => -85,
			'OP13_BITWISE_AND' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP08_STRING_CAT' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			"}" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP06_REGEX_MATCH' => -85
		}
	},
	{#State 233
		ACTIONS => {
			'OP04_MATH_POW' => 152,
			";" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP18_TERNARY' => -91,
			"]" => -91,
			")" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP06_REGEX_MATCH' => 142,
			'OP07_STRING_REPEAT' => 139,
			'OP08_STRING_CAT' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91
		}
	},
	{#State 234
		ACTIONS => {
			'OP16_LOGICAL_OR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -98,
			'OP06_REGEX_MATCH' => 142,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			"}" => -98,
			";" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => -98,
			'OP09_BITWISE_SHIFT' => 146,
			")" => -98,
			"]" => -98,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => -98
		}
	},
	{#State 235
		DEFAULT => -206
	},
	{#State 236
		ACTIONS => {
			'COLON' => 283
		}
	},
	{#State 237
		DEFAULT => -205
	},
	{#State 238
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LBRACKET' => 70,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109
		},
		GOTOS => {
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'SubExpression' => 284,
			'Operator' => 111,
			'HashReference' => 76,
			'ArrayDereferenced' => 87,
			'Variable' => 130
		}
	},
	{#State 239
		ACTIONS => {
			'WORD' => 286,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LBRACKET' => 70,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'Variable' => 130,
			'WordScoped' => 110,
			'SubExpression' => 285,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'Operator' => 111
		}
	},
	{#State 240
		DEFAULT => -162
	},
	{#State 241
		ACTIONS => {
			'FH_REF_SYMBOL' => 287
		}
	},
	{#State 242
		DEFAULT => -87
	},
	{#State 243
		DEFAULT => -113
	},
	{#State 244
		DEFAULT => -198
	},
	{#State 245
		DEFAULT => -197
	},
	{#State 246
		ACTIONS => {
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP13_BITWISE_AND' => 154,
			";" => 288,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => 148,
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151
		}
	},
	{#State 247
		ACTIONS => {
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LBRACKET' => 70,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 123,
			")" => -120,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP01_QW' => 125,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'KEYS_OR_VALUES' => 132,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89
		},
		GOTOS => {
			'TypeInner' => 124,
			'Variable' => 130,
			'ListElements' => 289,
			'WordScoped' => 110,
			'SubExpression' => 133,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'HashReference' => 76,
			'ArrayReference' => 101,
			'OPTIONAL-33' => 290,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'ListElement' => 131,
			'Literal' => 114
		}
	},
	{#State 248
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => 148,
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			";" => -136,
			'OP13_BITWISE_AND' => 154
		}
	},
	{#State 249
		DEFAULT => -137
	},
	{#State 250
		ACTIONS => {
			";" => 291
		}
	},
	{#State 251
		DEFAULT => -135
	},
	{#State 252
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 123,
			'LBRACE' => 107,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'OP01_QW' => 125,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 132,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LBRACKET' => 70,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'TypeInner' => 124,
			'ListElements' => 292,
			'Variable' => 130,
			'WordScoped' => 110,
			'HashReference' => 76,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'SubExpression' => 133,
			'ArrayReference' => 101,
			'ListElement' => 131,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114
		}
	},
	{#State 253
		ACTIONS => {
			'OP21_LIST_COMMA' => 293
		}
	},
	{#State 254
		ACTIONS => {
			'VARIABLE_SYMBOL' => 294
		}
	},
	{#State 255
		ACTIONS => {
			'LPAREN' => 295
		}
	},
	{#State 256
		ACTIONS => {
			'OP07_STRING_REPEAT' => 139,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => 148,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP06_REGEX_MATCH' => 142,
			")" => 296,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143,
			'OP04_MATH_POW' => 152,
			'OP13_BITWISE_AND' => 154,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155
		}
	},
	{#State 257
		ACTIONS => {
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LBRACKET' => 70,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 123,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'OP01_QW' => 125,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'KEYS_OR_VALUES' => 132
		},
		GOTOS => {
			'Literal' => 114,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'ListElement' => 131,
			'ArrayReference' => 101,
			'HashReference' => 76,
			'SubExpression' => 133,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'Variable' => 130,
			'ListElements' => 297,
			'TypeInner' => 124
		}
	},
	{#State 258
		ACTIONS => {
			";" => 298
		}
	},
	{#State 259
		ACTIONS => {
			";" => 299
		}
	},
	{#State 260
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 300,
			";" => 301
		}
	},
	{#State 261
		ACTIONS => {
			'OP21_LIST_COMMA' => 303,
			"}" => 304
		},
		GOTOS => {
			'PAREN-47' => 302
		}
	},
	{#State 262
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -188,
			"my" => 123,
			'LBRACE' => -188,
			'OP05_LOGICAL_NEG' => -188,
			"\@{" => -188,
			'OP22_LOGICAL_NEG' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'WORD' => -188,
			'LITERAL_NUMBER' => -188,
			'LPAREN' => -188,
			'OP01_NAMED' => -188,
			'WORD_UPPERCASE' => -188,
			"%{" => -188,
			'OP01_CLOSE' => -188,
			"undef" => -188,
			'LBRACKET' => -188,
			'LITERAL_STRING' => -188,
			'OP10_NAMED_UNARY' => -188,
			'OP01_OPEN' => -188,
			'VARIABLE_SYMBOL' => -188,
			'WORD_SCOPED' => -188
		},
		GOTOS => {
			'TypeInner' => 306,
			'OPTIONAL-46' => 305
		}
	},
	{#State 263
		DEFAULT => -186
	},
	{#State 264
		DEFAULT => -185
	},
	{#State 265
		ACTIONS => {
			")" => 307
		}
	},
	{#State 266
		DEFAULT => -117
	},
	{#State 267
		DEFAULT => -125
	},
	{#State 268
		ACTIONS => {
			'WORD_UPPERCASE' => 308
		}
	},
	{#State 269
		DEFAULT => -41
	},
	{#State 270
		ACTIONS => {
			"if (" => 73,
			"undef" => 72,
			'OP19_LOOP_CONTROL' => 71,
			'LBRACKET' => 70,
			'OP01_NAMED_VOID_SCOLON' => 75,
			'WORD_UPPERCASE' => 74,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'OP19_LOOP_CONTROL_SCOLON' => 80,
			'OP01_NAMED_VOID' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_NUMBER' => 89,
			"while (" => -140,
			'OP03_MATH_INC_DEC' => 91,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'OP01_NAMED' => 100,
			'LPAREN' => 97,
			"}" => 310,
			'OP10_NAMED_UNARY' => 103,
			'OP01_PRINT' => 102,
			"for my integer" => -140,
			"foreach my" => -140,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"my" => 106,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'Variable' => 95,
			'SubExpression' => 77,
			'HashReference' => 76,
			'OperatorVoid' => 96,
			'OPTIONAL-35' => 98,
			'ArrayReference' => 101,
			'VariableDeclaration' => 78,
			'PAREN-34' => 84,
			'Statement' => 82,
			'LoopLabel' => 104,
			'VariableModification' => 85,
			'Conditional' => 108,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'Operation' => 309,
			'Expression' => 113,
			'HashDereferenced' => 112,
			'Literal' => 114
		}
	},
	{#State 271
		DEFAULT => -45
	},
	{#State 272
		ACTIONS => {
			'VARIABLE_SYMBOL' => 311
		}
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 274
		DEFAULT => -55
	},
	{#State 275
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 313
		}
	},
	{#State 276
		ACTIONS => {
			'WORD' => 314
		}
	},
	{#State 277
		DEFAULT => -178
	},
	{#State 278
		DEFAULT => -175
	},
	{#State 279
		DEFAULT => -173
	},
	{#State 280
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'LBRACE' => 107,
			"my" => 123,
			'OP05_LOGICAL_NEG' => 105,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'KEYS_OR_VALUES' => 132,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'LBRACKET' => 70,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Literal' => 114,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'ListElement' => 315,
			'Variable' => 130,
			'TypeInner' => 124,
			'ArrayDereferenced' => 87,
			'SubExpression' => 133,
			'HashReference' => 76,
			'Operator' => 111,
			'WordScoped' => 110
		}
	},
	{#State 281
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			"for my integer" => -140,
			'OP19_LOOP_CONTROL_SCOLON' => 80,
			"foreach my" => -140,
			'LITERAL_STRING' => 81,
			'OP01_PRINT' => 102,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LBRACKET' => 70,
			'OP19_LOOP_CONTROL' => 71,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"if (" => 73,
			"undef" => 72,
			'WORD_UPPERCASE' => 74,
			'LPAREN' => 97,
			'OP01_NAMED_VOID_SCOLON' => 75,
			'OP01_NAMED' => 100,
			"while (" => -140,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"my" => 106,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_NAMED_VOID' => 88
		},
		GOTOS => {
			'OPTIONAL-35' => 98,
			'OperatorVoid' => 96,
			'SubExpression' => 77,
			'HashReference' => 76,
			'Variable' => 95,
			'Statement' => 82,
			'PAREN-34' => 84,
			'VariableDeclaration' => 78,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'LoopLabel' => 104,
			'VariableModification' => 85,
			'Conditional' => 108,
			'Expression' => 113,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'PLUS-40' => 316,
			'Operation' => 317
		}
	},
	{#State 282
		DEFAULT => -148,
		GOTOS => {
			'STAR-37' => 318
		}
	},
	{#State 283
		ACTIONS => {
			'LITERAL_STRING' => 81,
			'LITERAL_NUMBER' => 89,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'Literal' => 235,
			'Variable' => 237,
			'VariableOrLiteral' => 319
		}
	},
	{#State 284
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP13_BITWISE_AND' => 154,
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			"]" => 320,
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140
		}
	},
	{#State 285
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP13_BITWISE_AND' => 154,
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			"}" => 321,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => 148
		}
	},
	{#State 286
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -199,
			"}" => 322,
			'LPAREN' => -199
		}
	},
	{#State 287
		ACTIONS => {
			'OP21_LIST_COMMA' => 323
		}
	},
	{#State 288
		DEFAULT => -171
	},
	{#State 289
		DEFAULT => -119
	},
	{#State 290
		ACTIONS => {
			")" => 324
		}
	},
	{#State 291
		DEFAULT => -170
	},
	{#State 292
		ACTIONS => {
			")" => 325
		}
	},
	{#State 293
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'LBRACKET' => 70,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			'KEYS_OR_VALUES' => 132,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			'OP01_QW' => 125,
			'OP03_MATH_INC_DEC' => 91,
			"\@{" => 109,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 123,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'WordScoped' => 110,
			'Operator' => 111,
			'HashReference' => 76,
			'SubExpression' => 133,
			'ArrayDereferenced' => 87,
			'TypeInner' => 124,
			'ListElements' => 326,
			'Variable' => 130,
			'ListElement' => 131,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'ArrayReference' => 101
		}
	},
	{#State 294
		ACTIONS => {
			'LPAREN' => 327
		}
	},
	{#State 295
		ACTIONS => {
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LBRACKET' => 70,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128
		},
		GOTOS => {
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'SubExpression' => 328,
			'HashReference' => 76,
			'Variable' => 130
		}
	},
	{#State 296
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 329
		}
	},
	{#State 297
		ACTIONS => {
			";" => 330
		}
	},
	{#State 298
		DEFAULT => -111
	},
	{#State 299
		DEFAULT => -110
	},
	{#State 300
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'STDIN' => 249,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'LBRACKET' => 70,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Variable' => 130,
			'SubExpressionOrStdin' => 331,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'SubExpression' => 248,
			'Operator' => 111,
			'WordScoped' => 110
		}
	},
	{#State 301
		DEFAULT => -168
	},
	{#State 302
		DEFAULT => -194
	},
	{#State 303
		ACTIONS => {
			'WORD' => 192,
			"%{" => 94
		},
		GOTOS => {
			'HashDereferenced' => 193,
			'HashEntry' => 332
		}
	},
	{#State 304
		DEFAULT => -196
	},
	{#State 305
		ACTIONS => {
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 86,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			"undef" => 72,
			'LBRACKET' => 70,
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134
		},
		GOTOS => {
			'Variable' => 130,
			'SubExpression' => 333,
			'Operator' => 111,
			'HashReference' => 76,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127
		}
	},
	{#State 306
		DEFAULT => -187
	},
	{#State 307
		DEFAULT => -122
	},
	{#State 308
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 334
		}
	},
	{#State 309
		DEFAULT => -44
	},
	{#State 310
		ACTIONS => {
			";" => 335
		}
	},
	{#State 311
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 336
		}
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 337
		}
	},
	{#State 313
		ACTIONS => {
			'LITERAL_NUMBER' => 342,
			"our" => 339
		},
		GOTOS => {
			'MethodOrSubroutine' => 338,
			'Subroutine' => 341,
			'Method' => 340
		}
	},
	{#State 314
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 343
		}
	},
	{#State 315
		DEFAULT => -172
	},
	{#State 316
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP19_LOOP_CONTROL_SCOLON' => 80,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'LBRACKET' => 70,
			'OP19_LOOP_CONTROL' => 71,
			"if (" => 73,
			"undef" => 72,
			'WORD_UPPERCASE' => 74,
			'OP01_NAMED_VOID_SCOLON' => 75,
			"while (" => -140,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 91,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_NAMED_VOID' => 88,
			"for my integer" => -140,
			"foreach my" => -140,
			'OP01_PRINT' => 102,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"}" => 344,
			'LPAREN' => 97,
			'OP01_NAMED' => 100,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 106,
			"\@{" => 109
		},
		GOTOS => {
			'OPTIONAL-35' => 98,
			'OperatorVoid' => 96,
			'SubExpression' => 77,
			'HashReference' => 76,
			'Variable' => 95,
			'Statement' => 82,
			'PAREN-34' => 84,
			'VariableDeclaration' => 78,
			'ArrayReference' => 101,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'WordScoped' => 110,
			'Conditional' => 108,
			'VariableModification' => 85,
			'LoopLabel' => 104,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 113,
			'Operation' => 345
		}
	},
	{#State 317
		DEFAULT => -160
	},
	{#State 318
		ACTIONS => {
			'LITERAL_STRING' => -151,
			'OP01_OPEN' => -151,
			'OP19_LOOP_CONTROL_SCOLON' => -151,
			'VARIABLE_SYMBOL' => -151,
			'WORD_SCOPED' => -151,
			'OP01_NAMED_VOID_SCOLON' => -151,
			'WORD_UPPERCASE' => -151,
			'OP19_LOOP_CONTROL' => -151,
			'' => -151,
			"if (" => -151,
			"undef" => -151,
			'LBRACKET' => -151,
			'OP03_MATH_INC_DEC' => -151,
			"while (" => -151,
			'LITERAL_NUMBER' => -151,
			'OP01_NAMED_VOID' => -151,
			'OP05_MATH_NEG_LPAREN' => -151,
			'OP01_PRINT' => -151,
			'OP10_NAMED_UNARY' => -151,
			"for my integer" => -151,
			"foreach my" => -151,
			'LPAREN' => -151,
			'OP01_NAMED' => -151,
			"}" => -151,
			"elsif (" => 350,
			'OP01_CLOSE' => -151,
			"%{" => -151,
			'OP22_LOGICAL_NEG' => -151,
			"else" => 349,
			'WORD' => -151,
			'OP05_LOGICAL_NEG' => -151,
			'LBRACE' => -151,
			"my" => -151,
			"\@{" => -151
		},
		GOTOS => {
			'PAREN-38' => 347,
			'PAREN-36' => 346,
			'OPTIONAL-39' => 348
		}
	},
	{#State 319
		DEFAULT => -103
	},
	{#State 320
		DEFAULT => -165
	},
	{#State 321
		DEFAULT => -166
	},
	{#State 322
		DEFAULT => -167
	},
	{#State 323
		ACTIONS => {
			'LITERAL_STRING' => 351
		}
	},
	{#State 324
		DEFAULT => -124
	},
	{#State 325
		DEFAULT => -78
	},
	{#State 326
		ACTIONS => {
			")" => 352
		}
	},
	{#State 327
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LBRACKET' => 70,
			"undef" => 72,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			'OP03_MATH_INC_DEC' => 91,
			'OP01_QW' => 125,
			'OP22_LOGICAL_NEG' => 115,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'KEYS_OR_VALUES' => 132,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			"my" => 123,
			'LBRACE' => 107,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'ListElement' => 131,
			'HashDereferenced' => 112,
			'Expression' => 127,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'SubExpression' => 133,
			'HashReference' => 76,
			'Operator' => 111,
			'TypeInner' => 124,
			'ListElements' => 353,
			'Variable' => 130
		}
	},
	{#State 328
		ACTIONS => {
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP17_LIST_RANGE' => 354,
			'OP11_COMPARE_LT_GT' => 144
		}
	},
	{#State 329
		DEFAULT => -158
	},
	{#State 330
		DEFAULT => -114
	},
	{#State 331
		ACTIONS => {
			";" => 355
		}
	},
	{#State 332
		DEFAULT => -193
	},
	{#State 333
		ACTIONS => {
			'OP16_LOGICAL_OR' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP21_LIST_COMMA' => -189,
			'OP06_REGEX_MATCH' => 142,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP07_STRING_REPEAT' => 139,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => 149,
			"}" => -189,
			'OP13_BITWISE_AND' => 154,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP04_MATH_POW' => 152,
			'OP18_TERNARY' => 155,
			'OP09_BITWISE_SHIFT' => 146,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143
		}
	},
	{#State 334
		DEFAULT => -204
	},
	{#State 335
		DEFAULT => -46
	},
	{#State 336
		ACTIONS => {
			")" => 358,
			'OP21_LIST_COMMA' => 356
		},
		GOTOS => {
			'PAREN-18' => 357
		}
	},
	{#State 337
		ACTIONS => {
			"}" => 359,
			'WORD' => 360,
			"%{" => 94
		},
		GOTOS => {
			'HashDereferenced' => 361,
			'HashEntryTyped' => 362
		}
	},
	{#State 338
		DEFAULT => -57
	},
	{#State 339
		ACTIONS => {
			'TYPE_METHOD' => 363,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 340
		DEFAULT => -74
	},
	{#State 341
		DEFAULT => -75
	},
	{#State 342
		ACTIONS => {
			";" => 364
		}
	},
	{#State 343
		DEFAULT => -203
	},
	{#State 344
		DEFAULT => -161
	},
	{#State 345
		DEFAULT => -159
	},
	{#State 346
		DEFAULT => -147
	},
	{#State 347
		DEFAULT => -150
	},
	{#State 348
		DEFAULT => -152
	},
	{#State 349
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 365
		}
	},
	{#State 350
		ACTIONS => {
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LBRACKET' => 70,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'LITERAL_STRING' => 81,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89
		},
		GOTOS => {
			'ArrayReference' => 101,
			'Literal' => 114,
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Variable' => 130,
			'ArrayDereferenced' => 87,
			'HashReference' => 76,
			'SubExpression' => 366,
			'Operator' => 111,
			'WordScoped' => 110
		}
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 367
		}
	},
	{#State 352
		DEFAULT => -80
	},
	{#State 353
		ACTIONS => {
			")" => 368
		}
	},
	{#State 354
		ACTIONS => {
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'LBRACKET' => 70,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'WORD_UPPERCASE' => 134,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Variable' => 130,
			'HashReference' => 76,
			'SubExpression' => 369,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'WordScoped' => 110,
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127
		}
	},
	{#State 355
		DEFAULT => -169
	},
	{#State 356
		ACTIONS => {
			"my" => 370
		}
	},
	{#State 357
		DEFAULT => -48
	},
	{#State 358
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 359
		ACTIONS => {
			";" => 372
		}
	},
	{#State 360
		ACTIONS => {
			'OP20_HASH_FATARROW' => 373
		}
	},
	{#State 361
		DEFAULT => -192
	},
	{#State 362
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 374
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 375
		}
	},
	{#State 364
		DEFAULT => -59
	},
	{#State 365
		DEFAULT => -149
	},
	{#State 366
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP07_STRING_REPEAT' => 139,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => 143,
			")" => 376,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP13_BITWISE_AND' => 154,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153
		}
	},
	{#State 367
		ACTIONS => {
			'LPAREN' => 97,
			'OP01_NAMED' => 128,
			'WORD_UPPERCASE' => 134,
			'OP01_CLOSE' => 93,
			"%{" => 94,
			"undef" => 72,
			'LBRACKET' => 70,
			'LITERAL_STRING' => 81,
			'OP10_NAMED_UNARY' => 103,
			'OP01_OPEN' => 83,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			"\@{" => 109,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			'WORD' => 23,
			'LITERAL_NUMBER' => 89
		},
		GOTOS => {
			'Variable' => 130,
			'SubExpression' => 377,
			'HashReference' => 76,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'WordScoped' => 110,
			'ArrayReference' => 101,
			'Literal' => 114,
			'HashDereferenced' => 112,
			'Expression' => 127
		}
	},
	{#State 368
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 369
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 144,
			'OP17_LIST_RANGE' => undef,
			")" => 379,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => -102,
			'OP04_MATH_POW' => 152,
			'OP13_BITWISE_AND' => 154,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_STRING_REPEAT' => 139,
			'OP23_LOGICAL_AND' => -102,
			'OP08_STRING_CAT' => 140,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP06_REGEX_MATCH' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151
		}
	},
	{#State 370
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 380
		}
	},
	{#State 371
		ACTIONS => {
			"\@_;" => 381
		}
	},
	{#State 372
		DEFAULT => -64
	},
	{#State 373
		ACTIONS => {
			"my" => 123
		},
		GOTOS => {
			'TypeInner' => 382
		}
	},
	{#State 374
		ACTIONS => {
			'OP21_LIST_COMMA' => 384,
			"}" => 383
		},
		GOTOS => {
			'PAREN-24' => 385
		}
	},
	{#State 375
		ACTIONS => {
			"= sub {" => 386
		}
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 377
		ACTIONS => {
			"}" => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP08_STRING_CAT' => 140,
			'OP23_LOGICAL_AND' => -81,
			'OP06_REGEX_MATCH' => 142,
			'OP21_LIST_COMMA' => -81,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151,
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			"]" => -81,
			")" => -81,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP15_LOGICAL_AND' => 145,
			'OP08_MATH_ADD_SUB' => 153,
			'OP13_BITWISE_AND' => 154,
			";" => -81
		}
	},
	{#State 378
		DEFAULT => -157
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 281
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 380
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 381
		DEFAULT => -50
	},
	{#State 382
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 79,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			'LITERAL_STRING' => 81,
			'LBRACKET' => 70,
			"undef" => 72,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'WORD_UPPERCASE' => 134,
			'OP01_NAMED' => 128,
			'LPAREN' => 97,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 91,
			'OP22_LOGICAL_NEG' => 115,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 107,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Expression' => 127,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'ArrayReference' => 101,
			'WordScoped' => 110,
			'ArrayDereferenced' => 87,
			'SubExpression' => 390,
			'HashReference' => 76,
			'Operator' => 111,
			'Variable' => 130
		}
	},
	{#State 383
		ACTIONS => {
			";" => 391
		}
	},
	{#State 384
		ACTIONS => {
			'WORD' => 360,
			"%{" => 94
		},
		GOTOS => {
			'HashEntryTyped' => 392,
			'HashDereferenced' => 361
		}
	},
	{#State 385
		DEFAULT => -61
	},
	{#State 386
		ACTIONS => {
			"my" => -66,
			'OP05_LOGICAL_NEG' => -66,
			'LBRACE' => -66,
			"\@{" => -66,
			'LPAREN_MY' => 393,
			'WORD' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP01_CLOSE' => -66,
			"%{" => -66,
			'LPAREN' => -66,
			'OP01_NAMED' => -66,
			'OP01_PRINT' => -66,
			'OP10_NAMED_UNARY' => -66,
			"for my integer" => -66,
			"foreach my" => -66,
			'OP01_NAMED_VOID' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"while (" => -66,
			'LITERAL_NUMBER' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP19_LOOP_CONTROL' => -66,
			"undef" => -66,
			"if (" => -66,
			'LBRACKET' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'WORD_UPPERCASE' => -66,
			'VARIABLE_SYMBOL' => -66,
			'WORD_SCOPED' => -66,
			'LITERAL_STRING' => -66,
			'OP01_OPEN' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66
		},
		GOTOS => {
			'MethodArguments' => 394,
			'OPTIONAL-26' => 395
		}
	},
	{#State 387
		DEFAULT => -146
	},
	{#State 388
		DEFAULT => -156
	},
	{#State 389
		DEFAULT => -47
	},
	{#State 390
		ACTIONS => {
			'OP17_LIST_RANGE' => 143,
			'OP11_COMPARE_LT_GT' => 144,
			'OP09_BITWISE_SHIFT' => 146,
			'OP18_TERNARY' => 155,
			'OP04_MATH_POW' => 152,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 145,
			'OP13_BITWISE_AND' => 154,
			"}" => -191,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 150,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 147,
			'OP23_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 140,
			'OP06_REGEX_MATCH' => 142,
			'OP21_LIST_COMMA' => -191,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP16_LOGICAL_OR' => 151
		}
	},
	{#State 391
		DEFAULT => -63
	},
	{#State 392
		DEFAULT => -60
	},
	{#State 393
		ACTIONS => {
			'TYPE_SELF' => 396
		}
	},
	{#State 394
		DEFAULT => -65
	},
	{#State 395
		ACTIONS => {
			'OP01_PRINT' => 102,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP10_NAMED_UNARY' => 103,
			"foreach my" => -140,
			"for my integer" => -140,
			'OP19_LOOP_CONTROL_SCOLON' => 80,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP01_NAMED' => 100,
			'OP01_NAMED_VOID_SCOLON' => 75,
			'WORD_UPPERCASE' => 74,
			'OP01_CLOSE' => 93,
			'OP19_LOOP_CONTROL' => 71,
			"%{" => 94,
			"undef" => 72,
			"if (" => 73,
			'LBRACKET' => 70,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 91,
			"while (" => -140,
			'LITERAL_NUMBER' => 89,
			'WORD' => 23,
			'OP01_NAMED_VOID' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACE' => 107,
			"my" => 106,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 109
		},
		GOTOS => {
			'Statement' => 82,
			'PAREN-34' => 84,
			'ArrayReference' => 101,
			'VariableDeclaration' => 78,
			'OPTIONAL-35' => 98,
			'OperatorVoid' => 96,
			'HashReference' => 76,
			'SubExpression' => 77,
			'Variable' => 95,
			'Literal' => 114,
			'PLUS-27' => 397,
			'HashDereferenced' => 112,
			'Expression' => 113,
			'Operation' => 398,
			'ArrayDereferenced' => 87,
			'Operator' => 111,
			'WordScoped' => 110,
			'Conditional' => 108,
			'VariableModification' => 85,
			'LoopLabel' => 104
		}
	},
	{#State 396
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 399
		}
	},
	{#State 397
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			"my" => 106,
			'LBRACE' => 107,
			"\@{" => 109,
			'WORD' => 23,
			'OP22_LOGICAL_NEG' => 115,
			"%{" => 94,
			'OP01_CLOSE' => 93,
			'LPAREN' => 97,
			'OP01_NAMED' => 100,
			"}" => 400,
			'OP01_PRINT' => 102,
			'OP10_NAMED_UNARY' => 103,
			"foreach my" => -140,
			"for my integer" => -140,
			'OP01_NAMED_VOID' => 88,
			'OP05_MATH_NEG_LPAREN' => 86,
			"while (" => -140,
			'LITERAL_NUMBER' => 89,
			'OP03_MATH_INC_DEC' => 91,
			'OP19_LOOP_CONTROL' => 71,
			"if (" => 73,
			"undef" => 72,
			'LBRACKET' => 70,
			'OP01_NAMED_VOID_SCOLON' => 75,
			'WORD_UPPERCASE' => 74,
			'VARIABLE_SYMBOL' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 81,
			'OP01_OPEN' => 83,
			'OP19_LOOP_CONTROL_SCOLON' => 80
		},
		GOTOS => {
			'VariableModification' => 85,
			'LoopLabel' => 104,
			'Conditional' => 108,
			'WordScoped' => 110,
			'Operator' => 111,
			'ArrayDereferenced' => 87,
			'Operation' => 401,
			'Expression' => 113,
			'HashDereferenced' => 112,
			'Literal' => 114,
			'Variable' => 95,
			'OPTIONAL-35' => 98,
			'OperatorVoid' => 96,
			'SubExpression' => 77,
			'HashReference' => 76,
			'VariableDeclaration' => 78,
			'ArrayReference' => 101,
			'Statement' => 82,
			'PAREN-34' => 84
		}
	},
	{#State 398
		DEFAULT => -68
	},
	{#State 399
		ACTIONS => {
			'OP21_LIST_COMMA' => 404,
			")" => 403
		},
		GOTOS => {
			'PAREN-28' => 402
		}
	},
	{#State 400
		ACTIONS => {
			";" => 405
		}
	},
	{#State 401
		DEFAULT => -67
	},
	{#State 402
		DEFAULT => -71
	},
	{#State 403
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 406
		}
	},
	{#State 404
		ACTIONS => {
			"my" => 407
		}
	},
	{#State 405
		DEFAULT => -69
	},
	{#State 406
		ACTIONS => {
			"\@_;" => 408
		}
	},
	{#State 407
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 409
		}
	},
	{#State 408
		DEFAULT => -73
	},
	{#State 409
		ACTIONS => {
			'VARIABLE_SYMBOL' => 410
		}
	},
	{#State 410
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5784 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5791 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5798 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5869 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5876 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6018 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6029 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6090 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6112 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6151 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6250 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6353 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6364 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6375 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6386 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6397 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6408 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6419 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6430 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6452 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6463 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6485 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6507 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6518 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6529 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6540 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6551 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6562 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6573 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6584 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6606 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6628 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6639 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6650 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6672 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6694 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6705 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6727 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6748 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6759 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6770 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6781 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6792 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6803 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6832 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6846 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6853 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6864 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6897 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6919 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6930 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6941 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6963 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6974 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6985 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6996 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7018 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7029 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_137
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7040 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7047 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7094 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7105 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7116 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7130 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7137 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7158 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_152
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7169 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7180 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7191 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_155
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7202 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_156
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_157
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_158
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7235 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_161
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_164
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_167
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7318 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_169
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_171
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7369 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7376 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7390 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7397 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_177
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_178
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_180
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7441 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_181
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7452 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_184
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_185
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_186
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7513 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7535 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7557 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_196
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_197
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_198
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_199
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7622 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_200
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7633 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_201
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7644 lib/RPerl/Grammar.pm
	],
	[#Rule Type_202
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7655 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_203
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7666 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_204
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7677 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_205
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7688 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_206
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7699 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7710 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7721 lib/RPerl/Grammar.pm
	]
],
#line 7724 lib/RPerl/Grammar.pm
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
         'SubExpression_135', 
         'SubExpressionOrStdin_136', 
         'SubExpressionOrStdin_137', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_141', 
         'Statement_142', 
         'Statement_143', 
         'Statement_144', 
         'Statement_145', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_152', 
         'Loop_153', 
         'Loop_154', 
         'Loop_155', 
         'LoopFor_156', 
         'LoopForEach_157', 
         'LoopWhile_158', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_161', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_164', 
         'VariableRetrieval_165', 
         'VariableRetrieval_166', 
         'VariableRetrieval_167', 
         'VariableDeclaration_168', 
         'VariableDeclaration_169', 
         'VariableModification_170', 
         'VariableModification_171', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_177', 
         'ListElements_178', 
         'ListElement_179', 
         'ListElement_180', 
         'ListElement_181', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_184', 
         'ArrayDereferenced_185', 
         'ArrayDereferenced_186', 
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
         'HashDereferenced_197', 
         'HashDereferenced_198', 
         'WordScoped_199', 
         'WordScoped_200', 
         'LoopLabel_201', 
         'Type_202', 
         'TypeInner_203', 
         'TypeInnerConstant_204', 
         'VariableOrLiteral_205', 
         'VariableOrLiteral_206', 
         'Literal_207', 
         'Literal_208', );
  $self;
}

#line 214 "lib/RPerl/Grammar.eyp"


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


#line 7981 lib/RPerl/Grammar.pm



1;
