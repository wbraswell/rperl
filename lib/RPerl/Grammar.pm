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
    our $VERSION = 0.000_977;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|foreach|\$TYPED_|\=\ sub\ \{|undef|while|elsif|else|for|our|\@_\;|use|qw\(|\@\{|\%\{|if|my|\)|\}|\]|\;)}gc and return ($1, $1);

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
	'qw(' => { ISSEMANTIC => 0 },
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
			"## no critic qw(" => 6,
			"package" => -20,
			'SHEBANG' => 9
		},
		GOTOS => {
			'OPTIONAL-9' => 8,
			'PLUS-2' => 2,
			'Critic' => 1,
			'CompileUnit' => 5,
			'Program' => 4,
			'PAREN-1' => 7,
			'ModuleHeader' => 3
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 6,
			'' => -5
		},
		GOTOS => {
			'OPTIONAL-9' => 8,
			'ModuleHeader' => 3,
			'Critic' => 1,
			'PAREN-1' => 10
		}
	},
	{#State 3
		ACTIONS => {
			"## no critic qw(" => -25,
			"use parent qw(" => 11,
			"use constant" => -25,
			"our" => -25,
			"use" => -25
		},
		GOTOS => {
			'Module' => 13,
			'Package' => 12,
			'STAR-10' => 15,
			'Class' => 14
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			'' => 16
		}
	},
	{#State 6
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-14' => 17
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			"package" => 19
		}
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => 6,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 21,
			'Critic' => 20
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 12
		DEFAULT => -22
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		ACTIONS => {
			"use" => -27,
			"our" => -27,
			"use constant" => -27,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'STAR-11' => 26,
			'Critic' => 25
		}
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		ACTIONS => {
			'WORD' => 27,
			")" => 28
		}
	},
	{#State 18
		DEFAULT => -35
	},
	{#State 19
		ACTIONS => {
			'WORD' => 22,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 31
		}
	},
	{#State 22
		DEFAULT => -198
	},
	{#State 23
		DEFAULT => -199
	},
	{#State 24
		ACTIONS => {
			")" => 32
		}
	},
	{#State 25
		DEFAULT => -24
	},
	{#State 26
		ACTIONS => {
			"our" => -29,
			"use" => 33,
			"use constant" => -29
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 35
		}
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
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			'WORD' => 22,
			'WORD_SCOPED' => 23
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
			"use constant" => 43,
			"our" => 44
		},
		GOTOS => {
			'Constant' => 45,
			'PLUS-13' => 41,
			'Subroutine' => 42
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
			'LITERAL_STRING' => -11,
			"%{" => -11,
			"if" => -11,
			'OP01_CLOSE' => -11,
			'LBRACE' => -11,
			'LITERAL_NUMBER' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			"## no critic qw(" => 6,
			"\@{" => -11,
			"use" => -11,
			'OP10_NAMED_UNARY' => -11,
			"our" => -11,
			'OP01_OPEN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'VARIABLE_SYMBOL' => -11,
			"foreach" => -11,
			'LPAREN' => -11,
			'OP01_NAMED' => -11,
			'LBRACKET' => -11,
			'WORD_SCOPED' => -11,
			"undef" => -11,
			'WORD' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"use constant" => -11,
			'OP01_PRINT' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"while" => -11,
			"my" => -11,
			'OP01_NAMED_VOID' => -11
		},
		GOTOS => {
			'Critic' => 49,
			'STAR-5' => 48
		}
	},
	{#State 39
		ACTIONS => {
			"use" => 33
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 40
		ACTIONS => {
			";" => 52,
			"qw(" => 51
		}
	},
	{#State 41
		ACTIONS => {
			'LITERAL_NUMBER' => 53,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 54
		}
	},
	{#State 42
		DEFAULT => -31
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 44
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 58
		}
	},
	{#State 45
		DEFAULT => -28
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
		ACTIONS => {
			'OP01_CLOSE' => -13,
			'LBRACE' => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"for" => -13,
			'WORD_UPPERCASE' => -13,
			"\@{" => -13,
			"use" => 33,
			'OP10_NAMED_UNARY' => -13,
			"our" => -13,
			'LITERAL_STRING' => -13,
			"%{" => -13,
			"if" => -13,
			'WORD' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"use constant" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_PRINT' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"while" => -13,
			"my" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_OPEN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'VARIABLE_SYMBOL' => -13,
			"foreach" => -13,
			'LPAREN' => -13,
			'OP01_NAMED' => -13,
			'LBRACKET' => -13,
			"undef" => -13,
			'WORD_SCOPED' => -13
		},
		GOTOS => {
			'Include' => 61,
			'STAR-6' => 60
		}
	},
	{#State 49
		DEFAULT => -8
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
			";" => 65
		}
	},
	{#State 54
		DEFAULT => -30
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
		}
	},
	{#State 56
		DEFAULT => -201
	},
	{#State 57
		DEFAULT => -202
	},
	{#State 58
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		}
	},
	{#State 59
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 68
		}
	},
	{#State 60
		ACTIONS => {
			'LBRACKET' => -15,
			'OP01_NAMED' => -15,
			'WORD_SCOPED' => -15,
			"undef" => -15,
			'LPAREN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"foreach" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_OPEN' => -15,
			"my" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"while" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"use constant" => 43,
			'OP01_PRINT' => -15,
			'WORD' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"if" => -15,
			"%{" => -15,
			'LITERAL_STRING' => -15,
			'OP10_NAMED_UNARY' => -15,
			"our" => -15,
			'OP05_LOGICAL_NEG' => -15,
			"for" => -15,
			"\@{" => -15,
			'WORD_UPPERCASE' => -15,
			'LBRACE' => -15,
			'OP01_CLOSE' => -15,
			'LITERAL_NUMBER' => -15
		},
		GOTOS => {
			'Constant' => 69,
			'STAR-7' => 70
		}
	},
	{#State 61
		DEFAULT => -10
	},
	{#State 62
		ACTIONS => {
			"use" => -54,
			"our hash_ref \$properties" => -54,
			"use constant" => -54,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 72,
			'STAR-21' => 71
		}
	},
	{#State 63
		DEFAULT => -38
	},
	{#State 64
		ACTIONS => {
			")" => 74,
			'WORD' => 73
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			"my" => 76
		},
		GOTOS => {
			'TypeInnerConstant' => 75
		}
	},
	{#State 67
		ACTIONS => {
			"= sub {" => 77
		}
	},
	{#State 68
		DEFAULT => -33
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			'LPAREN' => 123,
			'LBRACKET' => 121,
			'OP01_NAMED' => 119,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_OPEN' => 117,
			'OP19_LOOP_CONTROL' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 114,
			'OP22_LOGICAL_NEG' => 111,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 107,
			"my" => 106,
			'OP01_NAMED_VOID' => 104,
			'WORD' => 22,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'OP03_MATH_INC_DEC' => 99,
			'OP01_PRINT' => 98,
			"if" => 97,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'OP10_NAMED_UNARY' => 87,
			"our" => 44,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'LITERAL_NUMBER' => 81,
			"for" => -139,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 78
		},
		GOTOS => {
			'ArrayReference' => 91,
			'PAREN-34' => 89,
			'Operator' => 113,
			'ArrayDereferenced' => 95,
			'Variable' => 94,
			'Operation' => 93,
			'Literal' => 92,
			'Statement' => 120,
			'HashReference' => 122,
			'OPTIONAL-35' => 96,
			'PLUS-8' => 83,
			'Subroutine' => 103,
			'HashDereferenced' => 102,
			'VariableDeclaration' => 100,
			'LoopLabel' => 86,
			'Conditional' => 105,
			'SubExpression' => 85,
			'OperatorVoid' => 112,
			'WordScoped' => 109,
			'VariableModification' => 110,
			'Expression' => 108
		}
	},
	{#State 71
		ACTIONS => {
			"our hash_ref \$properties" => -56,
			"use" => 33,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 125,
			'STAR-22' => 124
		}
	},
	{#State 72
		DEFAULT => -51
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
			'LITERAL_STRING' => 88,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 127
		}
	},
	{#State 76
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 128
		}
	},
	{#State 77
		ACTIONS => {
			'WORD_SCOPED' => -43,
			"undef" => -43,
			'OP01_NAMED' => -43,
			'LBRACKET' => -43,
			'LPAREN' => -43,
			'VARIABLE_SYMBOL' => -43,
			"foreach" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_OPEN' => -43,
			'OP01_NAMED_VOID' => -43,
			"my" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"while" => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_PRINT' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'WORD' => -43,
			'LPAREN_MY' => 130,
			"if" => -43,
			'LITERAL_STRING' => -43,
			"%{" => -43,
			'OP10_NAMED_UNARY' => -43,
			'WORD_UPPERCASE' => -43,
			"\@{" => -43,
			"for" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_CLOSE' => -43,
			'LBRACE' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 129,
			'OPTIONAL-16' => 131
		}
	},
	{#State 78
		ACTIONS => {
			'LPAREN' => 132,
			'COLON' => -200
		}
	},
	{#State 79
		ACTIONS => {
			'VARIABLE_SYMBOL' => 114,
			'LBRACKET' => 121
		},
		GOTOS => {
			'Variable' => 133,
			'ArrayReference' => 134
		}
	},
	{#State 80
		ACTIONS => {
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'OP01_OPEN' => 117,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'LPAREN' => 123,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87
		},
		GOTOS => {
			'SubExpression' => 136,
			'HashReference' => 122,
			'WordScoped' => 109,
			'Expression' => 138,
			'ArrayReference' => 91,
			'Operator' => 113,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Literal' => 92
		}
	},
	{#State 81
		DEFAULT => -208
	},
	{#State 82
		ACTIONS => {
			'FH_REF_SYMBOL' => 140
		}
	},
	{#State 83
		ACTIONS => {
			"%{" => 90,
			'LITERAL_STRING' => 88,
			"if" => 97,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			"\@{" => 79,
			'WORD_UPPERCASE' => 78,
			'OP05_LOGICAL_NEG' => 80,
			"for" => -139,
			'OP10_NAMED_UNARY' => 87,
			'OP01_OPEN' => 117,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 114,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'OP19_LOOP_CONTROL' => 115,
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 119,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'WORD' => 22,
			'OP01_PRINT' => 98,
			'OP03_MATH_INC_DEC' => 99,
			'' => -18,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_NAMED_VOID' => 104,
			"my" => 106
		},
		GOTOS => {
			'OPTIONAL-35' => 96,
			'HashReference' => 122,
			'Statement' => 120,
			'Variable' => 94,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'Operation' => 141,
			'ArrayReference' => 91,
			'Operator' => 113,
			'PAREN-34' => 89,
			'OperatorVoid' => 112,
			'Expression' => 108,
			'WordScoped' => 109,
			'VariableModification' => 110,
			'LoopLabel' => 86,
			'Conditional' => 105,
			'SubExpression' => 85,
			'HashDereferenced' => 102,
			'VariableDeclaration' => 100
		}
	},
	{#State 84
		ACTIONS => {
			"%{" => 90,
			"}" => 142,
			'WORD' => 144
		},
		GOTOS => {
			'HashDereferenced' => 145,
			'HashEntry' => 143
		}
	},
	{#State 85
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_STRING_CAT' => 147,
			'OP08_MATH_ADD_SUB' => 157,
			'OP23_LOGICAL_AND' => 148,
			'OP18_TERNARY' => 149,
			'OP17_LIST_RANGE' => 158,
			'OP07_STRING_REPEAT' => 150
		}
	},
	{#State 86
		ACTIONS => {
			'COLON' => 163
		}
	},
	{#State 87
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'WORD' => 22,
			")" => -95,
			'OP03_MATH_INC_DEC' => 99,
			"}" => -95,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP04_MATH_POW' => -95,
			'OP01_OPEN' => 117,
			'OP15_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95,
			'VARIABLE_SYMBOL' => 114,
			'OP23_LOGICAL_AND' => -95,
			";" => -95,
			'OP18_TERNARY' => -95,
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_NAMED' => 139,
			'OP07_STRING_REPEAT' => -95,
			'LBRACKET' => 121,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'OP14_BITWISE_OR_XOR' => -95,
			'WORD_UPPERCASE' => 135,
			'OP09_BITWISE_SHIFT' => -95,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP06_REGEX_MATCH' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP10_NAMED_UNARY' => 87,
			'OP24_LOGICAL_OR_XOR' => -95,
			'LITERAL_STRING' => 88,
			'OP08_MATH_ADD_SUB' => -95,
			"%{" => 90,
			"]" => -95,
			'OP17_LIST_RANGE' => -95
		},
		GOTOS => {
			'SubExpression' => 164,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'ArrayReference' => 91,
			'Operator' => 113,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92
		}
	},
	{#State 88
		DEFAULT => -207
	},
	{#State 89
		DEFAULT => -138
	},
	{#State 90
		ACTIONS => {
			'LBRACE' => 84,
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'Variable' => 165,
			'HashReference' => 166
		}
	},
	{#State 91
		DEFAULT => -130
	},
	{#State 92
		DEFAULT => -128
	},
	{#State 93
		DEFAULT => -17
	},
	{#State 94
		ACTIONS => {
			'OP23_LOGICAL_AND' => -129,
			'OP18_TERNARY' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP08_STRING_CAT' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 167,
			'OP08_MATH_ADD_SUB' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP04_MATH_POW' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP02_METHOD_THINARROW' => 169,
			'OP11_COMPARE_LT_GT' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP19_VARIABLE_ASSIGN' => 170,
			'OP03_MATH_INC_DEC' => 168
		}
	},
	{#State 95
		DEFAULT => -131
	},
	{#State 96
		ACTIONS => {
			"while" => 176,
			"foreach" => 175,
			"for" => 172
		},
		GOTOS => {
			'LoopFor' => 171,
			'Loop' => 173,
			'LoopForEach' => 174,
			'LoopWhile' => 177
		}
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 178
		}
	},
	{#State 98
		ACTIONS => {
			"my" => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'OP10_NAMED_UNARY' => -109,
			'WORD_UPPERCASE' => -109,
			"\@{" => -109,
			'STDOUT_STDERR' => 181,
			'OP05_LOGICAL_NEG' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'LITERAL_NUMBER' => -109,
			'OP01_QW' => -109,
			'OP01_CLOSE' => -109,
			'WORD' => -109,
			'LBRACE' => -109,
			"undef" => -109,
			'WORD_SCOPED' => -109,
			'OP01_NAMED' => -109,
			'LBRACKET' => -109,
			'FH_REF_SYMBOL_BRACES' => 179,
			'LPAREN' => -109,
			'VARIABLE_SYMBOL' => -109,
			'LITERAL_STRING' => -109,
			"%{" => -109,
			'OP01_OPEN' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 182,
			'PAREN-30' => 180
		}
	},
	{#State 99
		ACTIONS => {
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'Variable' => 183
		}
	},
	{#State 100
		DEFAULT => -143
	},
	{#State 101
		DEFAULT => -112
	},
	{#State 102
		DEFAULT => -133
	},
	{#State 103
		DEFAULT => -14
	},
	{#State 104
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP01_QW' => 189,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			"my" => 188,
			'OP01_OPEN' => 117,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'LPAREN' => 123,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ListElements' => 186,
			'ListElement' => 187,
			'SubExpression' => 185,
			'HashReference' => 122,
			'TypeInner' => 184,
			'Expression' => 138,
			'WordScoped' => 109
		}
	},
	{#State 105
		DEFAULT => -140
	},
	{#State 106
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 190
		}
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => 123,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_OPEN' => 117,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79
		},
		GOTOS => {
			'SubExpression' => 191,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92
		}
	},
	{#State 108
		ACTIONS => {
			'OP17_LIST_RANGE' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP23_LOGICAL_AND' => -126,
			";" => 192,
			'OP18_TERNARY' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP08_STRING_CAT' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP04_MATH_POW' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP11_COMPARE_LT_GT' => -126
		}
	},
	{#State 109
		ACTIONS => {
			'LPAREN' => 193,
			'OP02_METHOD_THINARROW_NEW' => 194
		}
	},
	{#State 110
		DEFAULT => -144
	},
	{#State 111
		ACTIONS => {
			'OP01_OPEN' => 117,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'LPAREN' => 123,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'LITERAL_NUMBER' => 81,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87
		},
		GOTOS => {
			'SubExpression' => 195,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92
		}
	},
	{#State 112
		DEFAULT => -142
	},
	{#State 113
		DEFAULT => -121
	},
	{#State 114
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 196
		}
	},
	{#State 115
		ACTIONS => {
			'WORD_UPPERCASE' => 197
		},
		GOTOS => {
			'LoopLabel' => 198
		}
	},
	{#State 116
		DEFAULT => -115
	},
	{#State 117
		ACTIONS => {
			"my" => 199
		}
	},
	{#State 118
		DEFAULT => -127
	},
	{#State 119
		ACTIONS => {
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			"my" => 188,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashReference' => 122,
			'TypeInner' => 184,
			'Expression' => 138,
			'WordScoped' => 109,
			'ListElement' => 200,
			'SubExpression' => 201
		}
	},
	{#State 120
		DEFAULT => -77
	},
	{#State 121
		ACTIONS => {
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP01_QW' => 189,
			'LITERAL_NUMBER' => 81,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			"my" => 188,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 123,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			"]" => -181
		},
		GOTOS => {
			'OPTIONAL-45' => 203,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ListElements' => 202,
			'ListElement' => 187,
			'SubExpression' => 185,
			'HashReference' => 122,
			'Expression' => 138,
			'TypeInner' => 184,
			'WordScoped' => 109
		}
	},
	{#State 122
		DEFAULT => -132
	},
	{#State 123
		ACTIONS => {
			'LPAREN' => 123,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 204,
			'LBRACKET' => 121,
			'OP01_OPEN' => 117,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 135,
			'OP01_PRINT' => 205,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99
		},
		GOTOS => {
			'HashReference' => 122,
			'WordScoped' => 109,
			'Expression' => 138,
			'SubExpression' => 206,
			'ArrayDereferenced' => 95,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113
		}
	},
	{#State 124
		ACTIONS => {
			"our hash_ref \$properties" => 208,
			"use constant" => 43
		},
		GOTOS => {
			'Constant' => 207,
			'Properties' => 209
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
			";" => 210
		}
	},
	{#State 128
		ACTIONS => {
			"\$TYPED_" => 211
		}
	},
	{#State 129
		DEFAULT => -42
	},
	{#State 130
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 131
		ACTIONS => {
			'OP01_OPEN' => 117,
			'OP19_LOOP_CONTROL' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'LPAREN' => 123,
			"if" => 97,
			'OP01_NAMED' => 119,
			'LBRACKET' => 121,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'OP05_LOGICAL_NEG' => 80,
			"for" => -139,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 78,
			'OP01_PRINT' => 98,
			"\@{" => 79,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107,
			"while" => -139,
			"my" => 106,
			'OP01_NAMED_VOID' => 104
		},
		GOTOS => {
			'HashReference' => 122,
			'OPTIONAL-35' => 96,
			'PLUS-17' => 214,
			'Statement' => 120,
			'ArrayDereferenced' => 95,
			'Variable' => 94,
			'Operation' => 213,
			'Literal' => 92,
			'ArrayReference' => 91,
			'PAREN-34' => 89,
			'Operator' => 113,
			'OperatorVoid' => 112,
			'VariableModification' => 110,
			'WordScoped' => 109,
			'Expression' => 108,
			'Conditional' => 105,
			'LoopLabel' => 86,
			'SubExpression' => 85,
			'HashDereferenced' => 102,
			'VariableDeclaration' => 100
		}
	},
	{#State 132
		ACTIONS => {
			")" => 215
		}
	},
	{#State 133
		ACTIONS => {
			"}" => 216
		}
	},
	{#State 134
		ACTIONS => {
			"}" => 217
		}
	},
	{#State 135
		ACTIONS => {
			'LPAREN' => 132
		}
	},
	{#State 136
		ACTIONS => {
			'OP17_LIST_RANGE' => -86,
			"]" => -86,
			'OP07_STRING_REPEAT' => -86,
			";" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP18_TERNARY' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP08_STRING_CAT' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP04_MATH_POW' => 155,
			'OP06_REGEX_MATCH' => -86,
			"}" => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			")" => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP14_BITWISE_OR_XOR' => -86
		}
	},
	{#State 137
		ACTIONS => {
			'OP21_LIST_COMMA' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP04_MATH_POW' => -129,
			'OP13_BITWISE_AND' => -129,
			"}" => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP03_MATH_INC_DEC' => 168,
			")" => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP02_METHOD_THINARROW' => 169,
			"]" => -129,
			'OP17_LIST_RANGE' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP23_LOGICAL_AND' => -129,
			";" => -129,
			'OP18_TERNARY' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP08_STRING_CAT' => -129,
			'OP15_LOGICAL_AND' => -129
		}
	},
	{#State 138
		DEFAULT => -126
	},
	{#State 139
		ACTIONS => {
			'LPAREN' => 123,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LITERAL_NUMBER' => 81,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'SubExpression' => 218,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109
		}
	},
	{#State 140
		DEFAULT => -82
	},
	{#State 141
		DEFAULT => -16
	},
	{#State 142
		DEFAULT => -195
	},
	{#State 143
		DEFAULT => -193,
		GOTOS => {
			'STAR-48' => 219
		}
	},
	{#State 144
		ACTIONS => {
			'OP20_HASH_FATARROW' => 220
		}
	},
	{#State 145
		DEFAULT => -188
	},
	{#State 146
		ACTIONS => {
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LPAREN' => 123,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'OP01_OPEN' => 117,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'SubExpression' => 221,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113
		}
	},
	{#State 147
		ACTIONS => {
			'OP01_OPEN' => 117,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'SubExpression' => 222,
			'Expression' => 138,
			'WordScoped' => 109,
			'HashReference' => 122,
			'Operator' => 113,
			'ArrayReference' => 91,
			'Literal' => 92,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95
		}
	},
	{#State 148
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP01_OPEN' => 117,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'LPAREN' => 123,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121
		},
		GOTOS => {
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Operator' => 113,
			'ArrayReference' => 91,
			'WordScoped' => 109,
			'Expression' => 138,
			'HashReference' => 122,
			'SubExpression' => 223
		}
	},
	{#State 149
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'Literal' => 226,
			'Variable' => 225,
			'VariableOrLiteral' => 224
		}
	},
	{#State 150
		ACTIONS => {
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'OP01_OPEN' => 117,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'SubExpression' => 227,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109
		}
	},
	{#State 151
		ACTIONS => {
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'OP01_OPEN' => 117,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22
		},
		GOTOS => {
			'SubExpression' => 228,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92
		}
	},
	{#State 152
		ACTIONS => {
			'LPAREN' => 123,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_OPEN' => 117,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79
		},
		GOTOS => {
			'HashReference' => 122,
			'WordScoped' => 109,
			'Expression' => 138,
			'SubExpression' => 229,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113
		}
	},
	{#State 153
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP01_OPEN' => 117,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121
		},
		GOTOS => {
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Operator' => 113,
			'ArrayReference' => 91,
			'WordScoped' => 109,
			'Expression' => 138,
			'HashReference' => 122,
			'SubExpression' => 230
		}
	},
	{#State 154
		ACTIONS => {
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LITERAL_NUMBER' => 81,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'LPAREN' => 123,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'SubExpression' => 231,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92
		}
	},
	{#State 155
		ACTIONS => {
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LPAREN' => 123,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107
		},
		GOTOS => {
			'Literal' => 92,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Operator' => 113,
			'ArrayReference' => 91,
			'Expression' => 138,
			'WordScoped' => 109,
			'HashReference' => 122,
			'SubExpression' => 232
		}
	},
	{#State 156
		ACTIONS => {
			'OP01_OPEN' => 117,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'LPAREN' => 123,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107
		},
		GOTOS => {
			'Literal' => 92,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Operator' => 113,
			'ArrayReference' => 91,
			'Expression' => 138,
			'WordScoped' => 109,
			'HashReference' => 122,
			'SubExpression' => 233
		}
	},
	{#State 157
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117
		},
		GOTOS => {
			'WordScoped' => 109,
			'Expression' => 138,
			'HashReference' => 122,
			'SubExpression' => 234,
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Operator' => 113,
			'ArrayReference' => 91
		}
	},
	{#State 158
		ACTIONS => {
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LITERAL_NUMBER' => 81,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LPAREN' => 123,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117
		},
		GOTOS => {
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'SubExpression' => 235
		}
	},
	{#State 159
		ACTIONS => {
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LPAREN' => 123,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Expression' => 138,
			'WordScoped' => 109,
			'HashReference' => 122,
			'SubExpression' => 236,
			'Literal' => 92,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Operator' => 113,
			'ArrayReference' => 91
		}
	},
	{#State 160
		ACTIONS => {
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'LITERAL_NUMBER' => 81,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'OP01_OPEN' => 117,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'LPAREN' => 123
		},
		GOTOS => {
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'SubExpression' => 237
		}
	},
	{#State 161
		ACTIONS => {
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LITERAL_NUMBER' => 81,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'LPAREN' => 123,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'SubExpression' => 238
		}
	},
	{#State 162
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 239
		}
	},
	{#State 163
		DEFAULT => -137
	},
	{#State 164
		ACTIONS => {
			'OP18_TERNARY' => -94,
			";" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP07_STRING_REPEAT' => 150,
			"]" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP08_STRING_CAT' => 147,
			'OP08_MATH_ADD_SUB' => 157,
			"}" => -94,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -94,
			'OP09_BITWISE_SHIFT' => 160
		}
	},
	{#State 165
		ACTIONS => {
			"}" => 240
		}
	},
	{#State 166
		ACTIONS => {
			"}" => 241
		}
	},
	{#State 167
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'OP01_OPEN' => 117,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'SubExpression' => 242,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109
		}
	},
	{#State 168
		DEFAULT => -84
	},
	{#State 169
		ACTIONS => {
			'LPAREN' => 243
		}
	},
	{#State 170
		ACTIONS => {
			'LPAREN' => 123,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'STDIN' => 244,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'ArrayDereferenced' => 95,
			'SubExpressionOrStdin' => 246,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Literal' => 92,
			'SubExpression' => 245,
			'HashReference' => 122,
			'WordScoped' => 109,
			'Expression' => 138
		}
	},
	{#State 171
		DEFAULT => -152
	},
	{#State 172
		ACTIONS => {
			"my" => 247
		}
	},
	{#State 173
		DEFAULT => -141
	},
	{#State 174
		DEFAULT => -153
	},
	{#State 175
		ACTIONS => {
			"my" => 248
		}
	},
	{#State 176
		ACTIONS => {
			'LPAREN' => 249
		}
	},
	{#State 177
		DEFAULT => -154
	},
	{#State 178
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'OP01_OPEN' => 117,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LPAREN' => 123
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'SubExpression' => 250,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109
		}
	},
	{#State 179
		ACTIONS => {
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'OP01_QW' => 189,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"my" => 188,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'OP01_OPEN' => 117,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ListElements' => 251,
			'ListElement' => 187,
			'SubExpression' => 185,
			'HashReference' => 122,
			'TypeInner' => 184,
			'Expression' => 138,
			'WordScoped' => 109
		}
	},
	{#State 180
		DEFAULT => -108
	},
	{#State 181
		DEFAULT => -107
	},
	{#State 182
		ACTIONS => {
			'LPAREN' => 123,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"my" => 188,
			'OP01_QW' => 189,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80
		},
		GOTOS => {
			'Operator' => 113,
			'ArrayReference' => 91,
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'SubExpression' => 185,
			'ListElement' => 187,
			'ListElements' => 252,
			'WordScoped' => 109,
			'TypeInner' => 184,
			'Expression' => 138,
			'HashReference' => 122
		}
	},
	{#State 183
		DEFAULT => -83
	},
	{#State 184
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'SubExpression' => 253,
			'HashReference' => 122,
			'WordScoped' => 109,
			'Expression' => 138,
			'ArrayReference' => 91,
			'Operator' => 113,
			'ArrayDereferenced' => 95,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'Literal' => 92
		}
	},
	{#State 185
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -178,
			'OP09_BITWISE_SHIFT' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP21_LIST_COMMA' => -178,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			";" => -178,
			'OP07_STRING_REPEAT' => 150,
			"]" => -178,
			'OP17_LIST_RANGE' => 158
		}
	},
	{#State 186
		ACTIONS => {
			";" => 254
		}
	},
	{#State 187
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 255
		}
	},
	{#State 188
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 57
		},
		GOTOS => {
			'Type' => 256
		}
	},
	{#State 189
		ACTIONS => {
			'WORD' => 258
		},
		GOTOS => {
			'PLUS-44' => 257
		}
	},
	{#State 190
		ACTIONS => {
			'VARIABLE_SYMBOL' => 259
		}
	},
	{#State 191
		ACTIONS => {
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			")" => 260,
			'OP09_BITWISE_SHIFT' => 160,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP07_STRING_REPEAT' => 150,
			'OP17_LIST_RANGE' => 158,
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP08_MATH_ADD_SUB' => 157,
			'OP15_LOGICAL_AND' => 146,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_STRING_CAT' => 147
		}
	},
	{#State 192
		DEFAULT => -76
	},
	{#State 193
		ACTIONS => {
			"my" => 188,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			")" => -118,
			'OP01_QW' => 189,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'OP01_OPEN' => 117
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Literal' => 92,
			'OPTIONAL-32' => 262,
			'ListElements' => 261,
			'SubExpression' => 185,
			'ListElement' => 187,
			'HashReference' => 122,
			'WordScoped' => 109,
			'Expression' => 138,
			'TypeInner' => 184
		}
	},
	{#State 194
		ACTIONS => {
			")" => 263
		}
	},
	{#State 195
		ACTIONS => {
			'OP18_TERNARY' => 149,
			";" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP07_STRING_REPEAT' => 150,
			"]" => -104,
			'OP17_LIST_RANGE' => 158,
			'OP15_LOGICAL_AND' => 146,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP08_STRING_CAT' => 147,
			'OP08_MATH_ADD_SUB' => 157,
			"}" => -104,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 161,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP21_LIST_COMMA' => -104,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -104,
			'OP09_BITWISE_SHIFT' => 160
		}
	},
	{#State 196
		ACTIONS => {
			'OP07_STRING_REPEAT' => -163,
			"]" => -163,
			'OP17_LIST_RANGE' => -163,
			'OP18_TERNARY' => -163,
			'OP23_LOGICAL_AND' => -163,
			";" => -163,
			'OP02_ARRAY_THINARROW' => 264,
			'OP08_MATH_ADD_SUB' => -163,
			'OP02_HASH_THINARROW' => 265,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP08_STRING_CAT' => -163,
			'COLON' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP04_MATH_POW' => -163,
			'OP13_BITWISE_AND' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			"}" => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			")" => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 266
		}
	},
	{#State 197
		DEFAULT => -200
	},
	{#State 198
		ACTIONS => {
			";" => 267
		}
	},
	{#State 199
		ACTIONS => {
			"filehandle_ref" => 268
		}
	},
	{#State 200
		ACTIONS => {
			'OP21_LIST_COMMA' => 269
		}
	},
	{#State 201
		ACTIONS => {
			")" => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP04_MATH_POW' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP21_LIST_COMMA' => -178,
			'OP16_LOGICAL_OR' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP18_TERNARY' => -79,
			'OP23_LOGICAL_AND' => -79,
			";" => -79
		}
	},
	{#State 202
		DEFAULT => -180
	},
	{#State 203
		ACTIONS => {
			"]" => 270
		}
	},
	{#State 204
		ACTIONS => {
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"my" => 188,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ListElement' => 271,
			'SubExpression' => 201,
			'HashReference' => 122,
			'TypeInner' => 184,
			'Expression' => 138,
			'WordScoped' => 109
		}
	},
	{#State 205
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 272
		}
	},
	{#State 206
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => 273,
			'OP09_BITWISE_SHIFT' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP07_STRING_REPEAT' => 150,
			'OP17_LIST_RANGE' => 158
		}
	},
	{#State 207
		DEFAULT => -55
	},
	{#State 208
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 274
		}
	},
	{#State 209
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 275
		}
	},
	{#State 210
		DEFAULT => -41
	},
	{#State 211
		ACTIONS => {
			'WORD_UPPERCASE' => 276
		}
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => 277
		}
	},
	{#State 213
		DEFAULT => -45
	},
	{#State 214
		ACTIONS => {
			"if" => 97,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'OP10_NAMED_UNARY' => 87,
			'WORD_UPPERCASE' => 78,
			"\@{" => 79,
			"for" => -139,
			'OP05_LOGICAL_NEG' => 80,
			'LITERAL_NUMBER' => 81,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 119,
			'LBRACKET' => 121,
			'LPAREN' => 123,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 114,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'OP19_LOOP_CONTROL' => 115,
			'OP01_OPEN' => 117,
			'OP01_NAMED_VOID' => 104,
			"my" => 106,
			"}" => 278,
			'OP05_MATH_NEG_LPAREN' => 107,
			"while" => -139,
			'OP22_LOGICAL_NEG' => 111,
			'OP01_PRINT' => 98,
			'OP03_MATH_INC_DEC' => 99,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'WORD' => 22
		},
		GOTOS => {
			'VariableModification' => 110,
			'WordScoped' => 109,
			'Expression' => 108,
			'OperatorVoid' => 112,
			'SubExpression' => 85,
			'Conditional' => 105,
			'LoopLabel' => 86,
			'VariableDeclaration' => 100,
			'HashDereferenced' => 102,
			'HashReference' => 122,
			'OPTIONAL-35' => 96,
			'Statement' => 120,
			'Operation' => 279,
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'Variable' => 94,
			'PAREN-34' => 89,
			'Operator' => 113,
			'ArrayReference' => 91
		}
	},
	{#State 215
		DEFAULT => -123
	},
	{#State 216
		DEFAULT => -183
	},
	{#State 217
		DEFAULT => -184
	},
	{#State 218
		ACTIONS => {
			'OP13_BITWISE_AND' => -79,
			'OP04_MATH_POW' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP21_LIST_COMMA' => -79,
			"}" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP16_LOGICAL_OR' => -79,
			")" => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP07_STRING_REPEAT' => -79,
			"]" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP18_TERNARY' => -79,
			'OP23_LOGICAL_AND' => -79,
			";" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP08_STRING_CAT' => -79
		}
	},
	{#State 219
		ACTIONS => {
			"}" => 281,
			'OP21_LIST_COMMA' => 280
		},
		GOTOS => {
			'PAREN-47' => 282
		}
	},
	{#State 220
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -186,
			'OP22_LOGICAL_NEG' => -186,
			'OP10_NAMED_UNARY' => -186,
			"my" => 188,
			'LITERAL_NUMBER' => -186,
			'OP01_CLOSE' => -186,
			'WORD' => -186,
			'LBRACE' => -186,
			'WORD_UPPERCASE' => -186,
			"\@{" => -186,
			'OP05_LOGICAL_NEG' => -186,
			'OP03_MATH_INC_DEC' => -186,
			'LPAREN' => -186,
			"undef" => -186,
			'WORD_SCOPED' => -186,
			'OP01_NAMED' => -186,
			'LBRACKET' => -186,
			'OP01_OPEN' => -186,
			'VARIABLE_SYMBOL' => -186,
			'LITERAL_STRING' => -186,
			"%{" => -186
		},
		GOTOS => {
			'OPTIONAL-46' => 284,
			'TypeInner' => 283
		}
	},
	{#State 221
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 157,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => -100,
			'OP07_STRING_REPEAT' => 150,
			"]" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP18_TERNARY' => -100,
			";" => -100,
			'OP23_LOGICAL_AND' => -100,
			")" => -100,
			'OP09_BITWISE_SHIFT' => 160,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP16_LOGICAL_OR' => -100,
			"}" => -100,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 222
		ACTIONS => {
			'OP15_LOGICAL_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => -92,
			'OP23_LOGICAL_AND' => -92,
			";" => -92,
			'OP07_STRING_REPEAT' => 150,
			"]" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP06_REGEX_MATCH' => 162,
			"}" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP21_LIST_COMMA' => -92
		}
	},
	{#State 223
		ACTIONS => {
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 157,
			'OP23_LOGICAL_AND' => -105,
			";" => -105,
			'OP18_TERNARY' => 149,
			'OP17_LIST_RANGE' => 158,
			"]" => -105,
			'OP07_STRING_REPEAT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 160,
			")" => -105,
			'OP16_LOGICAL_OR' => 161,
			"}" => -105,
			'OP06_REGEX_MATCH' => 162,
			'OP21_LIST_COMMA' => -105,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154
		}
	},
	{#State 224
		ACTIONS => {
			'COLON' => 285
		}
	},
	{#State 225
		DEFAULT => -205
	},
	{#State 226
		DEFAULT => -206
	},
	{#State 227
		ACTIONS => {
			"}" => -89,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -89,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			")" => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP18_TERNARY' => -89,
			";" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP07_STRING_REPEAT' => -89,
			"]" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP08_STRING_CAT' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89
		}
	},
	{#State 228
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_STRING_CAT' => -90,
			'OP07_STRING_REPEAT' => 150,
			"]" => -90,
			'OP17_LIST_RANGE' => -90,
			'OP18_TERNARY' => -90,
			";" => -90,
			'OP23_LOGICAL_AND' => -90,
			")" => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP21_LIST_COMMA' => -90,
			"}" => -90,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -90
		}
	},
	{#State 229
		ACTIONS => {
			'OP15_LOGICAL_AND' => -96,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => -96,
			'OP23_LOGICAL_AND' => -96,
			";" => -96,
			'OP07_STRING_REPEAT' => 150,
			"]" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -96,
			'OP09_BITWISE_SHIFT' => 160,
			'OP06_REGEX_MATCH' => 162,
			"}" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP21_LIST_COMMA' => -96
		}
	},
	{#State 230
		ACTIONS => {
			'OP13_BITWISE_AND' => -97,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP21_LIST_COMMA' => -97,
			"}" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP06_REGEX_MATCH' => 162,
			")" => -97,
			'OP09_BITWISE_SHIFT' => 160,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP07_STRING_REPEAT' => 150,
			"]" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP18_TERNARY' => -97,
			'OP23_LOGICAL_AND' => -97,
			";" => -97,
			'OP08_MATH_ADD_SUB' => 157,
			'OP15_LOGICAL_AND' => -97,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => -97
		}
	},
	{#State 231
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -98,
			'OP09_BITWISE_SHIFT' => 160,
			"}" => -98,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -98,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => -98,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => -98,
			'OP23_LOGICAL_AND' => -98,
			";" => -98,
			'OP07_STRING_REPEAT' => 150,
			"]" => -98,
			'OP17_LIST_RANGE' => -98
		}
	},
	{#State 232
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -85,
			")" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			"}" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP08_STRING_CAT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			"]" => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP23_LOGICAL_AND' => -85,
			";" => -85,
			'OP18_TERNARY' => -85
		}
	},
	{#State 233
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -106,
			'OP09_BITWISE_SHIFT' => 160,
			'OP16_LOGICAL_OR' => 161,
			"}" => -106,
			'OP06_REGEX_MATCH' => 162,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => 146,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_STRING_CAT' => 147,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			";" => -106,
			'OP07_STRING_REPEAT' => 150,
			"]" => -106,
			'OP17_LIST_RANGE' => 158
		}
	},
	{#State 234
		ACTIONS => {
			'OP07_STRING_REPEAT' => 150,
			"]" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP18_TERNARY' => -91,
			'OP23_LOGICAL_AND' => -91,
			";" => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP08_STRING_CAT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP21_LIST_COMMA' => -91,
			"}" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP06_REGEX_MATCH' => 162,
			")" => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 151
		}
	},
	{#State 235
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP21_LIST_COMMA' => -102,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			"}" => -102,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 160,
			")" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP17_LIST_RANGE' => undef,
			"]" => -102,
			'OP07_STRING_REPEAT' => 150,
			";" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 157,
			'OP15_LOGICAL_AND' => 146,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_STRING_CAT' => 147
		}
	},
	{#State 236
		ACTIONS => {
			'OP17_LIST_RANGE' => -99,
			"]" => -99,
			'OP07_STRING_REPEAT' => 150,
			";" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP18_TERNARY' => -99,
			'OP08_MATH_ADD_SUB' => 157,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			"}" => -99,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -99,
			'OP09_BITWISE_SHIFT' => 160,
			")" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP11_COMPARE_LT_GT' => 152
		}
	},
	{#State 237
		ACTIONS => {
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => -93,
			'OP23_LOGICAL_AND' => -93,
			";" => -93,
			'OP07_STRING_REPEAT' => 150,
			"]" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP06_REGEX_MATCH' => 162,
			"}" => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP12_COMPARE_EQ_NE' => -93
		}
	},
	{#State 238
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 160,
			")" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP21_LIST_COMMA' => -101,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			"}" => -101,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => -101,
			'OP08_MATH_ADD_SUB' => 157,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP17_LIST_RANGE' => -101,
			"]" => -101,
			'OP07_STRING_REPEAT' => 150,
			'OP23_LOGICAL_AND' => -101,
			";" => -101,
			'OP18_TERNARY' => -101
		}
	},
	{#State 239
		DEFAULT => -88
	},
	{#State 240
		DEFAULT => -196
	},
	{#State 241
		DEFAULT => -197
	},
	{#State 242
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP09_BITWISE_SHIFT' => 160,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 161,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_STRING_CAT' => 147,
			'OP08_MATH_ADD_SUB' => 157,
			'OP23_LOGICAL_AND' => 148,
			";" => 286,
			'OP18_TERNARY' => 149,
			'OP17_LIST_RANGE' => 158,
			'OP07_STRING_REPEAT' => 150
		}
	},
	{#State 243
		ACTIONS => {
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'OP01_OPEN' => 117,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			"my" => 188,
			'LITERAL_NUMBER' => 81,
			'OP01_QW' => 189,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			")" => -120,
			'OP03_MATH_INC_DEC' => 99
		},
		GOTOS => {
			'HashReference' => 122,
			'Expression' => 138,
			'TypeInner' => 184,
			'OPTIONAL-33' => 288,
			'WordScoped' => 109,
			'ListElements' => 287,
			'ListElement' => 187,
			'SubExpression' => 185,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113
		}
	},
	{#State 244
		DEFAULT => -136
	},
	{#State 245
		ACTIONS => {
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 160,
			'OP23_LOGICAL_AND' => 148,
			";" => -135,
			'OP18_TERNARY' => 149,
			'OP17_LIST_RANGE' => 158,
			'OP07_STRING_REPEAT' => 150,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 157
		}
	},
	{#State 246
		ACTIONS => {
			";" => 289
		}
	},
	{#State 247
		ACTIONS => {
			'TYPE_INTEGER' => 290
		}
	},
	{#State 248
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 291
		}
	},
	{#State 249
		ACTIONS => {
			'OP01_OPEN' => 117,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'Operator' => 113,
			'ArrayReference' => 91,
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'SubExpression' => 292,
			'WordScoped' => 109,
			'Expression' => 138,
			'HashReference' => 122
		}
	},
	{#State 250
		ACTIONS => {
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP07_STRING_REPEAT' => 150,
			'OP17_LIST_RANGE' => 158,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_MATH_ADD_SUB' => 157,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => 293,
			'OP09_BITWISE_SHIFT' => 160
		}
	},
	{#State 251
		ACTIONS => {
			";" => 294
		}
	},
	{#State 252
		ACTIONS => {
			";" => 295
		}
	},
	{#State 253
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -179,
			'OP09_BITWISE_SHIFT' => 160,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP21_LIST_COMMA' => -179,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			";" => -179,
			'OP07_STRING_REPEAT' => 150,
			"]" => -179,
			'OP17_LIST_RANGE' => 158
		}
	},
	{#State 254
		DEFAULT => -113
	},
	{#State 255
		ACTIONS => {
			";" => -176,
			")" => -176,
			"]" => -176,
			'OP21_LIST_COMMA' => 296
		},
		GOTOS => {
			'PAREN-42' => 297
		}
	},
	{#State 256
		ACTIONS => {
			"\$TYPED_" => 298
		}
	},
	{#State 257
		ACTIONS => {
			")" => 300,
			'WORD' => 299
		}
	},
	{#State 258
		DEFAULT => -175
	},
	{#State 259
		ACTIONS => {
			";" => 301,
			'OP19_VARIABLE_ASSIGN' => 302
		}
	},
	{#State 260
		DEFAULT => -87
	},
	{#State 261
		DEFAULT => -117
	},
	{#State 262
		ACTIONS => {
			")" => 303
		}
	},
	{#State 263
		DEFAULT => -125
	},
	{#State 264
		ACTIONS => {
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'LPAREN' => 123,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'OP01_OPEN' => 117,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'LITERAL_NUMBER' => 81,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'SubExpression' => 304
		}
	},
	{#State 265
		ACTIONS => {
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LPAREN' => 123,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'LBRACE' => 84,
			'WORD' => 306,
			'OP01_CLOSE' => 82,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'WordScoped' => 109,
			'Expression' => 138,
			'HashReference' => 122,
			'SubExpression' => 305,
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'Operator' => 113,
			'ArrayReference' => 91
		}
	},
	{#State 266
		DEFAULT => -161
	},
	{#State 267
		DEFAULT => -116
	},
	{#State 268
		ACTIONS => {
			'FH_REF_SYMBOL' => 307
		}
	},
	{#State 269
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			"my" => 188,
			'LITERAL_NUMBER' => 81,
			'OP01_QW' => 189,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'LPAREN' => 123,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'OP01_OPEN' => 117,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90
		},
		GOTOS => {
			'SubExpression' => 185,
			'ListElement' => 187,
			'ListElements' => 308,
			'WordScoped' => 109,
			'TypeInner' => 184,
			'Expression' => 138,
			'HashReference' => 122,
			'Operator' => 113,
			'ArrayReference' => 91,
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137
		}
	},
	{#State 270
		DEFAULT => -182
	},
	{#State 271
		ACTIONS => {
			'OP21_LIST_COMMA' => 309
		}
	},
	{#State 272
		ACTIONS => {
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'OP01_QW' => 189,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"my" => 188,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123
		},
		GOTOS => {
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Operator' => 113,
			'ArrayReference' => 91,
			'WordScoped' => 109,
			'Expression' => 138,
			'TypeInner' => 184,
			'HashReference' => 122,
			'SubExpression' => 185,
			'ListElement' => 187,
			'ListElements' => 310
		}
	},
	{#State 273
		DEFAULT => -134
	},
	{#State 274
		ACTIONS => {
			'LBRACE' => 311
		}
	},
	{#State 275
		ACTIONS => {
			'LITERAL_NUMBER' => 312,
			"our" => 313
		},
		GOTOS => {
			'MethodOrSubroutine' => 314,
			'Subroutine' => 315,
			'Method' => 316
		}
	},
	{#State 276
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 317
		}
	},
	{#State 277
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 318
		}
	},
	{#State 278
		ACTIONS => {
			";" => 319
		}
	},
	{#State 279
		DEFAULT => -44
	},
	{#State 280
		ACTIONS => {
			"%{" => 90,
			'WORD' => 144
		},
		GOTOS => {
			'HashDereferenced' => 145,
			'HashEntry' => 320
		}
	},
	{#State 281
		DEFAULT => -194
	},
	{#State 282
		DEFAULT => -192
	},
	{#State 283
		DEFAULT => -185
	},
	{#State 284
		ACTIONS => {
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'LPAREN' => 123,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'OP01_OPEN' => 117,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'LITERAL_NUMBER' => 81,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84
		},
		GOTOS => {
			'Literal' => 92,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95,
			'Operator' => 113,
			'ArrayReference' => 91,
			'Expression' => 138,
			'WordScoped' => 109,
			'HashReference' => 122,
			'SubExpression' => 321
		}
	},
	{#State 285
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'VariableOrLiteral' => 322,
			'Variable' => 225,
			'Literal' => 226
		}
	},
	{#State 286
		DEFAULT => -170
	},
	{#State 287
		DEFAULT => -119
	},
	{#State 288
		ACTIONS => {
			")" => 323
		}
	},
	{#State 289
		DEFAULT => -169
	},
	{#State 290
		ACTIONS => {
			'VARIABLE_SYMBOL' => 324
		}
	},
	{#State 291
		ACTIONS => {
			'VARIABLE_SYMBOL' => 325
		}
	},
	{#State 292
		ACTIONS => {
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 157,
			'OP23_LOGICAL_AND' => 148,
			'OP18_TERNARY' => 149,
			'OP17_LIST_RANGE' => 158,
			'OP07_STRING_REPEAT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 160,
			")" => 326,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154
		}
	},
	{#State 293
		ACTIONS => {
			'LBRACE' => 327
		},
		GOTOS => {
			'CodeBlock' => 328
		}
	},
	{#State 294
		DEFAULT => -111
	},
	{#State 295
		DEFAULT => -110
	},
	{#State 296
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"my" => 188,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'LPAREN' => 123,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'HashReference' => 122,
			'TypeInner' => 184,
			'Expression' => 138,
			'WordScoped' => 109,
			'ListElement' => 329,
			'SubExpression' => 185,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113
		}
	},
	{#State 297
		DEFAULT => -172
	},
	{#State 298
		ACTIONS => {
			'WORD' => 330
		}
	},
	{#State 299
		DEFAULT => -174
	},
	{#State 300
		DEFAULT => -177
	},
	{#State 301
		DEFAULT => -167
	},
	{#State 302
		ACTIONS => {
			'OP01_OPEN' => 117,
			'STDIN' => 244,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'LPAREN' => 123,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107
		},
		GOTOS => {
			'Expression' => 138,
			'WordScoped' => 109,
			'HashReference' => 122,
			'SubExpression' => 245,
			'Literal' => 92,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'SubExpressionOrStdin' => 331,
			'ArrayDereferenced' => 95,
			'Operator' => 113,
			'ArrayReference' => 91
		}
	},
	{#State 303
		DEFAULT => -122
	},
	{#State 304
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 161,
			'OP09_BITWISE_SHIFT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP17_LIST_RANGE' => 158,
			"]" => 332,
			'OP07_STRING_REPEAT' => 150,
			'OP23_LOGICAL_AND' => 148,
			'OP18_TERNARY' => 149,
			'OP08_MATH_ADD_SUB' => 157,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP15_LOGICAL_AND' => 146
		}
	},
	{#State 305
		ACTIONS => {
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP07_STRING_REPEAT' => 150,
			'OP17_LIST_RANGE' => 158,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 157,
			"}" => 333,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 161,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 160
		}
	},
	{#State 306
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -198,
			'LPAREN' => -198,
			"}" => 334
		}
	},
	{#State 307
		ACTIONS => {
			'OP21_LIST_COMMA' => 335
		}
	},
	{#State 308
		ACTIONS => {
			";" => 336
		}
	},
	{#State 309
		ACTIONS => {
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP01_QW' => 189,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107,
			"my" => 188,
			'OP01_OPEN' => 117,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'LPAREN' => 123,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'WORD_SCOPED' => 23,
			"undef" => 118
		},
		GOTOS => {
			'SubExpression' => 185,
			'ListElement' => 187,
			'ListElements' => 337,
			'WordScoped' => 109,
			'Expression' => 138,
			'TypeInner' => 184,
			'HashReference' => 122,
			'Operator' => 113,
			'ArrayReference' => 91,
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'Variable' => 137,
			'HashDereferenced' => 102
		}
	},
	{#State 310
		ACTIONS => {
			")" => 338
		}
	},
	{#State 311
		ACTIONS => {
			'WORD' => 342,
			"}" => 340,
			"%{" => 90
		},
		GOTOS => {
			'HashEntryTyped' => 339,
			'HashDereferenced' => 341
		}
	},
	{#State 312
		ACTIONS => {
			";" => 343
		}
	},
	{#State 313
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 56,
			'TYPE_METHOD' => 344
		},
		GOTOS => {
			'Type' => 58
		}
	},
	{#State 314
		DEFAULT => -57
	},
	{#State 315
		DEFAULT => -75
	},
	{#State 316
		DEFAULT => -74
	},
	{#State 317
		DEFAULT => -204
	},
	{#State 318
		ACTIONS => {
			")" => 346,
			'OP21_LIST_COMMA' => 345
		},
		GOTOS => {
			'PAREN-18' => 347
		}
	},
	{#State 319
		DEFAULT => -46
	},
	{#State 320
		DEFAULT => -191
	},
	{#State 321
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 160,
			'OP06_REGEX_MATCH' => 162,
			"}" => -187,
			'OP16_LOGICAL_OR' => 161,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP21_LIST_COMMA' => -187,
			'OP15_LOGICAL_AND' => 146,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_STRING_CAT' => 147,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP07_STRING_REPEAT' => 150,
			'OP17_LIST_RANGE' => 158
		}
	},
	{#State 322
		DEFAULT => -103
	},
	{#State 323
		DEFAULT => -124
	},
	{#State 324
		ACTIONS => {
			'LPAREN' => 348
		}
	},
	{#State 325
		ACTIONS => {
			'LPAREN' => 349
		}
	},
	{#State 326
		ACTIONS => {
			'LBRACE' => 327
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 327
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'OP19_LOOP_CONTROL' => 115,
			"foreach" => -139,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'OP01_OPEN' => 117,
			'OP01_NAMED' => 119,
			'LBRACKET' => 121,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			"if" => 97,
			'LPAREN' => 123,
			"for" => -139,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 78,
			'OP01_PRINT' => 98,
			"\@{" => 79,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED_VOID_SCOLON' => 101,
			"my" => 106,
			'OP01_NAMED_VOID' => 104,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107,
			"while" => -139
		},
		GOTOS => {
			'Statement' => 120,
			'OPTIONAL-35' => 96,
			'HashReference' => 122,
			'ArrayReference' => 91,
			'Operator' => 113,
			'PAREN-34' => 89,
			'Variable' => 94,
			'ArrayDereferenced' => 95,
			'Literal' => 92,
			'Operation' => 352,
			'Conditional' => 105,
			'LoopLabel' => 86,
			'PLUS-40' => 351,
			'SubExpression' => 85,
			'OperatorVoid' => 112,
			'Expression' => 108,
			'VariableModification' => 110,
			'WordScoped' => 109,
			'HashDereferenced' => 102,
			'VariableDeclaration' => 100
		}
	},
	{#State 328
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 353
		}
	},
	{#State 329
		DEFAULT => -171
	},
	{#State 330
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 354
		}
	},
	{#State 331
		ACTIONS => {
			";" => 355
		}
	},
	{#State 332
		DEFAULT => -164
	},
	{#State 333
		DEFAULT => -165
	},
	{#State 334
		DEFAULT => -166
	},
	{#State 335
		ACTIONS => {
			'LITERAL_STRING' => 356
		}
	},
	{#State 336
		DEFAULT => -114
	},
	{#State 337
		ACTIONS => {
			")" => 357
		}
	},
	{#State 338
		DEFAULT => -78
	},
	{#State 339
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 358
		}
	},
	{#State 340
		ACTIONS => {
			";" => 359
		}
	},
	{#State 341
		DEFAULT => -190
	},
	{#State 342
		ACTIONS => {
			'OP20_HASH_FATARROW' => 360
		}
	},
	{#State 343
		DEFAULT => -59
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 361
		}
	},
	{#State 345
		ACTIONS => {
			"my" => 362
		}
	},
	{#State 346
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 363
		}
	},
	{#State 347
		DEFAULT => -48
	},
	{#State 348
		ACTIONS => {
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LITERAL_NUMBER' => 81,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LPAREN' => 123,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117
		},
		GOTOS => {
			'Expression' => 138,
			'WordScoped' => 109,
			'HashReference' => 122,
			'SubExpression' => 364,
			'Literal' => 92,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Operator' => 113,
			'ArrayReference' => 91
		}
	},
	{#State 349
		ACTIONS => {
			"my" => 188,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'OP01_QW' => 189,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117
		},
		GOTOS => {
			'ListElement' => 187,
			'SubExpression' => 185,
			'ListElements' => 365,
			'Expression' => 138,
			'TypeInner' => 184,
			'WordScoped' => 109,
			'HashReference' => 122,
			'Operator' => 113,
			'ArrayReference' => 91,
			'Literal' => 92,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'ArrayDereferenced' => 95
		}
	},
	{#State 350
		DEFAULT => -157
	},
	{#State 351
		ACTIONS => {
			'OP10_NAMED_UNARY' => 87,
			'OP05_LOGICAL_NEG' => 80,
			"for" => -139,
			"\@{" => 79,
			'WORD_UPPERCASE' => 78,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'LITERAL_NUMBER' => 81,
			"if" => 97,
			"%{" => 90,
			'LITERAL_STRING' => 88,
			"my" => 106,
			'OP01_NAMED_VOID' => 104,
			'OP22_LOGICAL_NEG' => 111,
			"while" => -139,
			"}" => 366,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP03_MATH_INC_DEC' => 99,
			'OP01_PRINT' => 98,
			'WORD' => 22,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'LBRACKET' => 121,
			'OP01_NAMED' => 119,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LPAREN' => 123,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'OP19_LOOP_CONTROL' => 115,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 117
		},
		GOTOS => {
			'Statement' => 120,
			'HashReference' => 122,
			'OPTIONAL-35' => 96,
			'ArrayReference' => 91,
			'PAREN-34' => 89,
			'Operator' => 113,
			'ArrayDereferenced' => 95,
			'Variable' => 94,
			'Operation' => 367,
			'Literal' => 92,
			'LoopLabel' => 86,
			'Conditional' => 105,
			'SubExpression' => 85,
			'OperatorVoid' => 112,
			'VariableModification' => 110,
			'WordScoped' => 109,
			'Expression' => 108,
			'HashDereferenced' => 102,
			'VariableDeclaration' => 100
		}
	},
	{#State 352
		DEFAULT => -159
	},
	{#State 353
		ACTIONS => {
			"if" => -150,
			"%{" => -150,
			'LITERAL_STRING' => -150,
			'OP10_NAMED_UNARY' => -150,
			"\@{" => -150,
			'WORD_UPPERCASE' => -150,
			"for" => -150,
			'OP05_LOGICAL_NEG' => -150,
			'LITERAL_NUMBER' => -150,
			'LBRACE' => -150,
			'OP01_CLOSE' => -150,
			"undef" => -150,
			'WORD_SCOPED' => -150,
			'LBRACKET' => -150,
			'OP01_NAMED' => -150,
			'LPAREN' => -150,
			'VARIABLE_SYMBOL' => -150,
			"foreach" => -150,
			'OP19_LOOP_CONTROL' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP01_OPEN' => -150,
			'OP01_NAMED_VOID' => -150,
			"elsif" => 371,
			"my" => -150,
			"while" => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			"}" => -150,
			'OP22_LOGICAL_NEG' => -150,
			"else" => 372,
			'OP01_PRINT' => -150,
			'OP03_MATH_INC_DEC' => -150,
			'' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'WORD' => -150
		},
		GOTOS => {
			'PAREN-38' => 370,
			'PAREN-36' => 369,
			'OPTIONAL-39' => 368
		}
	},
	{#State 354
		DEFAULT => -203
	},
	{#State 355
		DEFAULT => -168
	},
	{#State 356
		ACTIONS => {
			'OP21_LIST_COMMA' => 373
		}
	},
	{#State 357
		DEFAULT => -80
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 376,
			"}" => 375
		},
		GOTOS => {
			'PAREN-24' => 374
		}
	},
	{#State 359
		DEFAULT => -64
	},
	{#State 360
		ACTIONS => {
			"my" => 188
		},
		GOTOS => {
			'TypeInner' => 377
		}
	},
	{#State 361
		ACTIONS => {
			"= sub {" => 378
		}
	},
	{#State 362
		ACTIONS => {
			'TYPE_INTEGER' => 57,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 379
		}
	},
	{#State 363
		ACTIONS => {
			"\@_;" => 380
		}
	},
	{#State 364
		ACTIONS => {
			'OP17_LIST_RANGE' => 381,
			'OP07_STRING_REPEAT' => 150,
			'OP23_LOGICAL_AND' => 148,
			'OP18_TERNARY' => 149,
			'OP08_MATH_ADD_SUB' => 157,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152
		}
	},
	{#State 365
		ACTIONS => {
			")" => 382
		}
	},
	{#State 366
		DEFAULT => -160
	},
	{#State 367
		DEFAULT => -158
	},
	{#State 368
		DEFAULT => -151
	},
	{#State 369
		DEFAULT => -146
	},
	{#State 370
		DEFAULT => -149
	},
	{#State 371
		ACTIONS => {
			'LPAREN' => 383
		}
	},
	{#State 372
		ACTIONS => {
			'LBRACE' => 327
		},
		GOTOS => {
			'CodeBlock' => 384
		}
	},
	{#State 373
		ACTIONS => {
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'OP01_OPEN' => 117,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80
		},
		GOTOS => {
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'Operator' => 113,
			'ArrayReference' => 91,
			'WordScoped' => 109,
			'Expression' => 138,
			'HashReference' => 122,
			'SubExpression' => 385
		}
	},
	{#State 374
		DEFAULT => -61
	},
	{#State 375
		ACTIONS => {
			";" => 386
		}
	},
	{#State 376
		ACTIONS => {
			"%{" => 90,
			'WORD' => 342
		},
		GOTOS => {
			'HashEntryTyped' => 387,
			'HashDereferenced' => 341
		}
	},
	{#State 377
		ACTIONS => {
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'OP01_OPEN' => 117,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			'LPAREN' => 123
		},
		GOTOS => {
			'SubExpression' => 388,
			'HashReference' => 122,
			'Expression' => 138,
			'WordScoped' => 109,
			'ArrayReference' => 91,
			'Operator' => 113,
			'Variable' => 137,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 95,
			'Literal' => 92
		}
	},
	{#State 378
		ACTIONS => {
			"if" => -66,
			'LPAREN_MY' => 389,
			"%{" => -66,
			'LITERAL_STRING' => -66,
			'OP10_NAMED_UNARY' => -66,
			'LBRACE' => -66,
			'OP01_CLOSE' => -66,
			'LITERAL_NUMBER' => -66,
			"for" => -66,
			'OP05_LOGICAL_NEG' => -66,
			"\@{" => -66,
			'WORD_UPPERCASE' => -66,
			'LPAREN' => -66,
			'LBRACKET' => -66,
			'OP01_NAMED' => -66,
			"undef" => -66,
			'WORD_SCOPED' => -66,
			'OP01_OPEN' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			"foreach" => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP22_LOGICAL_NEG' => -66,
			"while" => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"my" => -66,
			'OP01_NAMED_VOID' => -66,
			'WORD' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP01_PRINT' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 391,
			'MethodArguments' => 390
		}
	},
	{#State 379
		ACTIONS => {
			'VARIABLE_SYMBOL' => 392
		}
	},
	{#State 380
		DEFAULT => -50
	},
	{#State 381
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 99,
			'OP05_LOGICAL_NEG' => 80,
			"\@{" => 79,
			'WORD_UPPERCASE' => 135,
			'LBRACE' => 84,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 87,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			"%{" => 90,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			'OP01_OPEN' => 117,
			'LBRACKET' => 121,
			'OP01_NAMED' => 139,
			"undef" => 118,
			'WORD_SCOPED' => 23,
			'LPAREN' => 123
		},
		GOTOS => {
			'SubExpression' => 393,
			'WordScoped' => 109,
			'Expression' => 138,
			'HashReference' => 122,
			'Operator' => 113,
			'ArrayReference' => 91,
			'Literal' => 92,
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137
		}
	},
	{#State 382
		ACTIONS => {
			'LBRACE' => 327
		},
		GOTOS => {
			'CodeBlock' => 394
		}
	},
	{#State 383
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP05_MATH_NEG_LPAREN' => 107,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			'WORD_UPPERCASE' => 135,
			"\@{" => 79,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 139,
			'LBRACKET' => 121,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LPAREN' => 123,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 88,
			"%{" => 90,
			'OP01_OPEN' => 117
		},
		GOTOS => {
			'ArrayDereferenced' => 95,
			'HashDereferenced' => 102,
			'Variable' => 137,
			'Literal' => 92,
			'ArrayReference' => 91,
			'Operator' => 113,
			'HashReference' => 122,
			'WordScoped' => 109,
			'Expression' => 138,
			'SubExpression' => 395
		}
	},
	{#State 384
		DEFAULT => -148
	},
	{#State 385
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 157,
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => -81,
			";" => -81,
			'OP07_STRING_REPEAT' => 150,
			"]" => -81,
			'OP17_LIST_RANGE' => 158,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			")" => -81,
			'OP09_BITWISE_SHIFT' => 160,
			'OP06_REGEX_MATCH' => 162,
			"}" => -81,
			'OP16_LOGICAL_OR' => 161,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP21_LIST_COMMA' => -81,
			'OP12_COMPARE_EQ_NE' => 153
		}
	},
	{#State 386
		DEFAULT => -63
	},
	{#State 387
		DEFAULT => -60
	},
	{#State 388
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 157,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP15_LOGICAL_AND' => 146,
			'OP07_STRING_REPEAT' => 150,
			'OP17_LIST_RANGE' => 158,
			'OP18_TERNARY' => 149,
			'OP23_LOGICAL_AND' => 148,
			'OP09_BITWISE_SHIFT' => 160,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP21_LIST_COMMA' => -189,
			'OP12_COMPARE_EQ_NE' => 153,
			"}" => -189,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162
		}
	},
	{#State 389
		ACTIONS => {
			'TYPE_SELF' => 396
		}
	},
	{#State 390
		DEFAULT => -65
	},
	{#State 391
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 107,
			"while" => -139,
			'OP22_LOGICAL_NEG' => 111,
			'OP10_NAMED_UNARY' => 87,
			'OP01_NAMED_VOID' => 104,
			"my" => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'LBRACE' => 84,
			'WORD_UPPERCASE' => 78,
			'OP01_PRINT' => 98,
			"\@{" => 79,
			"for" => -139,
			'OP05_LOGICAL_NEG' => 80,
			'OP03_MATH_INC_DEC' => 99,
			"if" => 97,
			'LPAREN' => 123,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'OP01_NAMED' => 119,
			'LBRACKET' => 121,
			'OP01_OPEN' => 117,
			'LITERAL_STRING' => 88,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 114,
			"%{" => 90,
			'OP19_LOOP_CONTROL' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 116
		},
		GOTOS => {
			'OPTIONAL-35' => 96,
			'HashReference' => 122,
			'Statement' => 120,
			'PLUS-27' => 398,
			'Literal' => 92,
			'Operation' => 397,
			'Variable' => 94,
			'ArrayDereferenced' => 95,
			'Operator' => 113,
			'PAREN-34' => 89,
			'ArrayReference' => 91,
			'Expression' => 108,
			'VariableModification' => 110,
			'WordScoped' => 109,
			'OperatorVoid' => 112,
			'SubExpression' => 85,
			'Conditional' => 105,
			'LoopLabel' => 86,
			'VariableDeclaration' => 100,
			'HashDereferenced' => 102
		}
	},
	{#State 392
		DEFAULT => -47
	},
	{#State 393
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 155,
			'OP16_LOGICAL_OR' => 161,
			'OP06_REGEX_MATCH' => 162,
			'OP09_BITWISE_SHIFT' => 160,
			")" => 399,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP11_COMPARE_LT_GT' => 152,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP17_LIST_RANGE' => undef,
			'OP07_STRING_REPEAT' => 150,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 157,
			'OP15_LOGICAL_AND' => 146,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_STRING_CAT' => 147
		}
	},
	{#State 394
		DEFAULT => -156
	},
	{#State 395
		ACTIONS => {
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 156,
			'OP15_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 157,
			'OP23_LOGICAL_AND' => 148,
			'OP18_TERNARY' => 149,
			'OP17_LIST_RANGE' => 158,
			'OP07_STRING_REPEAT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 159,
			'OP11_COMPARE_LT_GT' => 152,
			'OP09_BITWISE_SHIFT' => 160,
			")" => 400,
			'OP06_REGEX_MATCH' => 162,
			'OP16_LOGICAL_OR' => 161,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP04_MATH_POW' => 155,
			'OP13_BITWISE_AND' => 154
		}
	},
	{#State 396
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 401
		}
	},
	{#State 397
		DEFAULT => -68
	},
	{#State 398
		ACTIONS => {
			'LITERAL_STRING' => 88,
			"%{" => 90,
			"if" => 97,
			"for" => -139,
			'OP05_LOGICAL_NEG' => 80,
			'WORD_UPPERCASE' => 78,
			"\@{" => 79,
			'OP01_CLOSE' => 82,
			'LBRACE' => 84,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 87,
			'OP19_LOOP_CONTROL_SCOLON' => 116,
			'OP19_LOOP_CONTROL' => 115,
			'VARIABLE_SYMBOL' => 114,
			"foreach" => -139,
			'OP01_OPEN' => 117,
			'OP01_NAMED' => 119,
			'LBRACKET' => 121,
			'WORD_SCOPED' => 23,
			"undef" => 118,
			'LPAREN' => 123,
			'OP03_MATH_INC_DEC' => 99,
			'OP01_PRINT' => 98,
			'WORD' => 22,
			'OP01_NAMED_VOID_SCOLON' => 101,
			"my" => 106,
			'OP01_NAMED_VOID' => 104,
			'OP22_LOGICAL_NEG' => 111,
			'OP05_MATH_NEG_LPAREN' => 107,
			"}" => 402,
			"while" => -139
		},
		GOTOS => {
			'Statement' => 120,
			'HashReference' => 122,
			'OPTIONAL-35' => 96,
			'ArrayReference' => 91,
			'PAREN-34' => 89,
			'Operator' => 113,
			'ArrayDereferenced' => 95,
			'Variable' => 94,
			'Operation' => 403,
			'Literal' => 92,
			'Conditional' => 105,
			'LoopLabel' => 86,
			'SubExpression' => 85,
			'OperatorVoid' => 112,
			'WordScoped' => 109,
			'VariableModification' => 110,
			'Expression' => 108,
			'HashDereferenced' => 102,
			'VariableDeclaration' => 100
		}
	},
	{#State 399
		ACTIONS => {
			'LBRACE' => 327
		},
		GOTOS => {
			'CodeBlock' => 404
		}
	},
	{#State 400
		ACTIONS => {
			'LBRACE' => 327
		},
		GOTOS => {
			'CodeBlock' => 405
		}
	},
	{#State 401
		ACTIONS => {
			")" => 407,
			'OP21_LIST_COMMA' => 406
		},
		GOTOS => {
			'PAREN-28' => 408
		}
	},
	{#State 402
		ACTIONS => {
			";" => 409
		}
	},
	{#State 403
		DEFAULT => -67
	},
	{#State 404
		DEFAULT => -155
	},
	{#State 405
		DEFAULT => -145
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
			'WORD' => 56,
			'TYPE_INTEGER' => 57
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
#line 5784 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5791 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5798 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5805 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5816 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5869 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5876 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5911 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5947 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6018 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6025 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6036 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6086 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6097 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6179 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6246 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6278 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6289 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6328 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6353 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6360 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6371 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6382 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6393 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6404 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6415 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6426 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6437 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6448 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6459 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6470 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6492 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6514 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6525 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6536 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6547 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6558 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6569 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6580 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6591 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6602 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6613 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6624 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6635 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6646 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6657 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6668 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6679 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6690 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6701 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6712 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6748 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6755 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6766 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6777 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6788 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6799 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6810 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6821 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6832 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6846 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6853 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6860 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6981 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6992 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7003 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7014 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7025 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7036 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7043 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7112 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7119 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7126 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7165 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7187 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7209 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7256 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7270 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7314 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7325 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7336 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7347 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7358 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7365 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7379 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7386 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7393 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_176
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7404 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_177
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7426 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_183
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7473 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_184
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7484 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_187
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_188
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7520 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_189
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_190
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7556 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_194
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_195
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_197
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_199
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_200
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule Type_201
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7651 lib/RPerl/Grammar.pm
	],
	[#Rule Type_202
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7662 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_203
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7673 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_204
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7684 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_205
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7695 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_206
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7717 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7728 lib/RPerl/Grammar.pm
	]
],
#line 7731 lib/RPerl/Grammar.pm
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


#line 7988 lib/RPerl/Grammar.pm



1;
