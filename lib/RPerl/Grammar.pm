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
    our $VERSION = 0.000_975;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|for\ my\ integer|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|\=\ sub\ \{|package|\$TYPED_|while|elsif|undef|else|our|use|\@_\;|qw\(|\@\{|if|my|\%\{|\]|\)|\}|\;)}gc and return ($1, $1);

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
  [ 'LoopFor_155' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_156' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
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
	'elsif' => { ISSEMANTIC => 0 },
	'filehandle_ref' => { ISSEMANTIC => 0 },
	'for my integer' => { ISSEMANTIC => 0 },
	'foreach my' => { ISSEMANTIC => 0 },
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
			"## no critic qw(" => 3
		},
		GOTOS => {
			'ModuleHeader' => 4,
			'PLUS-2' => 8,
			'CompileUnit' => 5,
			'OPTIONAL-9' => 9,
			'Critic' => 2,
			'PAREN-1' => 7,
			'Program' => 1
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-14' => 10
		}
	},
	{#State 4
		ACTIONS => {
			"our" => -25,
			"## no critic qw(" => -25,
			"use constant" => -25,
			"use parent qw(" => 15,
			"use" => -25
		},
		GOTOS => {
			'Module' => 16,
			'Class' => 12,
			'STAR-10' => 14,
			'Package' => 13
		}
	},
	{#State 5
		ACTIONS => {
			'' => 17
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 3,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 19,
			'OPTIONAL-3' => 18
		}
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			"## no critic qw(" => 3,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'OPTIONAL-9' => 9,
			'ModuleHeader' => 4,
			'PAREN-1' => 20,
			'Critic' => 2
		}
	},
	{#State 9
		ACTIONS => {
			"package" => 21
		}
	},
	{#State 10
		ACTIONS => {
			")" => 22,
			'WORD' => 23
		}
	},
	{#State 11
		DEFAULT => -35
	},
	{#State 12
		DEFAULT => -23
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		ACTIONS => {
			"our" => -27,
			"use" => -27,
			"## no critic qw(" => 3,
			"use constant" => -27
		},
		GOTOS => {
			'Critic' => 24,
			'STAR-11' => 25
		}
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		DEFAULT => 0
	},
	{#State 18
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 29
		}
	},
	{#State 19
		DEFAULT => -6
	},
	{#State 20
		DEFAULT => -2
	},
	{#State 21
		ACTIONS => {
			'WORD' => 28,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		DEFAULT => -36
	},
	{#State 23
		DEFAULT => -34
	},
	{#State 24
		DEFAULT => -24
	},
	{#State 25
		ACTIONS => {
			"use" => 32,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 33
		}
	},
	{#State 26
		ACTIONS => {
			")" => 35
		}
	},
	{#State 27
		DEFAULT => -199
	},
	{#State 28
		DEFAULT => -198
	},
	{#State 29
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 36
		}
	},
	{#State 30
		ACTIONS => {
			"use warnings;" => 37
		}
	},
	{#State 31
		ACTIONS => {
			";" => 38
		}
	},
	{#State 32
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"our" => 42,
			"use constant" => 40
		},
		GOTOS => {
			'Subroutine' => 41,
			'Constant' => 44,
			'PLUS-13' => 43
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
			'WORD_SCOPED' => -11,
			'OP01_CLOSE' => -11,
			"%{" => -11,
			"use" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LBRACE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP10_NAMED_UNARY' => -11,
			"## no critic qw(" => 3,
			'VARIABLE_SYMBOL' => -11,
			'OP01_PRINT' => -11,
			"foreach my" => -11,
			'OP01_OPEN' => -11,
			"undef" => -11,
			'LPAREN' => -11,
			'OP01_NAMED' => -11,
			"our" => -11,
			"while" => -11,
			"\@{" => -11,
			'LITERAL_STRING' => -11,
			"for my integer" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"use constant" => -11,
			"if" => -11,
			'WORD' => -11,
			"my" => -11,
			'LITERAL_NUMBER' => -11
		},
		GOTOS => {
			'STAR-5' => 46,
			'Critic' => 47
		}
	},
	{#State 37
		ACTIONS => {
			"use RPerl;" => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 30
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			"qw(" => 50,
			";" => 51
		}
	},
	{#State 40
		ACTIONS => {
			'WORD_UPPERCASE' => 52
		}
	},
	{#State 41
		DEFAULT => -31
	},
	{#State 42
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 43
		ACTIONS => {
			'LITERAL_NUMBER' => 56,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 55
		}
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		ACTIONS => {
			"use" => 32
		},
		GOTOS => {
			'Include' => 57
		}
	},
	{#State 46
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LBRACE' => -13,
			'LBRACKET' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"use" => 32,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'WORD_SCOPED' => -13,
			"%{" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED' => -13,
			'LPAREN' => -13,
			"foreach my" => -13,
			'OP01_OPEN' => -13,
			"undef" => -13,
			'WORD' => -13,
			"my" => -13,
			'LITERAL_NUMBER' => -13,
			"if" => -13,
			"\@{" => -13,
			'LITERAL_STRING' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"for my integer" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"use constant" => -13,
			"our" => -13,
			"while" => -13
		},
		GOTOS => {
			'Include' => 58,
			'STAR-6' => 59
		}
	},
	{#State 47
		DEFAULT => -8
	},
	{#State 48
		ACTIONS => {
			"our" => 60
		}
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		ACTIONS => {
			'WORD' => 62
		},
		GOTOS => {
			'PLUS-15' => 61
		}
	},
	{#State 51
		DEFAULT => -39
	},
	{#State 52
		ACTIONS => {
			'OP20_HASH_FATARROW' => 63
		}
	},
	{#State 53
		DEFAULT => -201
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 64
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
			'OP19_LOOP_CONTROL' => -15,
			'LBRACKET' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LBRACE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"%{" => -15,
			'WORD_SCOPED' => -15,
			'OP01_CLOSE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP10_NAMED_UNARY' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_PRINT' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED_VOID' => -15,
			'LPAREN' => -15,
			'OP01_NAMED' => -15,
			"undef" => -15,
			'OP01_OPEN' => -15,
			"foreach my" => -15,
			"if" => -15,
			'LITERAL_NUMBER' => -15,
			"my" => -15,
			'WORD' => -15,
			"while" => -15,
			"our" => -15,
			'OP05_LOGICAL_NEG' => -15,
			"for my integer" => -15,
			"use constant" => 40,
			'OP03_MATH_INC_DEC' => -15,
			'LITERAL_STRING' => -15,
			"\@{" => -15
		},
		GOTOS => {
			'Constant' => 68,
			'STAR-7' => 67
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
		ACTIONS => {
			"my" => 72
		},
		GOTOS => {
			'TypeInnerConstant' => 73
		}
	},
	{#State 64
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 65
		DEFAULT => -32
	},
	{#State 66
		ACTIONS => {
			"our hash_ref \$properties" => -54,
			"use" => -54,
			"use constant" => -54,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 76,
			'STAR-21' => 75
		}
	},
	{#State 67
		ACTIONS => {
			"foreach my" => -139,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP01_NAMED' => 96,
			'LPAREN' => 97,
			"our" => 42,
			"while" => -139,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			"for my integer" => -139,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			"if" => 89,
			"my" => 88,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP19_LOOP_CONTROL' => 118,
			'LBRACE' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP01_NAMED_VOID' => 101,
			'WORD_UPPERCASE' => 102,
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'OP01_PRINT' => 103
		},
		GOTOS => {
			'VariableModification' => 117,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'HashDereferenced' => 119,
			'Conditional' => 121,
			'OPTIONAL-35' => 100,
			'Operator' => 99,
			'Variable' => 98,
			'VariableDeclaration' => 109,
			'ArrayDereferenced' => 92,
			'Statement' => 94,
			'SubExpression' => 93,
			'Operation' => 111,
			'PAREN-34' => 87,
			'LoopLabel' => 85,
			'OperatorVoid' => 107,
			'Literal' => 106,
			'PLUS-8' => 81,
			'Subroutine' => 84,
			'WordScoped' => 83,
			'Expression' => 82
		}
	},
	{#State 68
		DEFAULT => -12
	},
	{#State 69
		DEFAULT => -33
	},
	{#State 70
		DEFAULT => -37
	},
	{#State 71
		ACTIONS => {
			";" => 123
		}
	},
	{#State 72
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 124
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_STRING' => 79,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 125
		}
	},
	{#State 74
		ACTIONS => {
			'OP01_NAMED' => -43,
			'LPAREN' => -43,
			'OP01_OPEN' => -43,
			"undef" => -43,
			"foreach my" => -43,
			"if" => -43,
			'LITERAL_NUMBER' => -43,
			'WORD' => -43,
			'LPAREN_MY' => 128,
			"my" => -43,
			"while" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"for my integer" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'LITERAL_STRING' => -43,
			"\@{" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LBRACKET' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'LBRACE' => -43,
			"%{" => -43,
			'WORD_SCOPED' => -43,
			'OP01_CLOSE' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_PRINT' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED_VOID' => -43,
			'WORD_UPPERCASE' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 126,
			'SubroutineArguments' => 127
		}
	},
	{#State 75
		ACTIONS => {
			"use" => 32,
			"use constant" => -56,
			"our hash_ref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 130,
			'Include' => 129
		}
	},
	{#State 76
		DEFAULT => -51
	},
	{#State 77
		ACTIONS => {
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 131,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 135
		}
	},
	{#State 78
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 136
		}
	},
	{#State 79
		DEFAULT => -206
	},
	{#State 80
		ACTIONS => {
			'LBRACKET' => 120,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'Variable' => 137,
			'ArrayReference' => 138
		}
	},
	{#State 81
		ACTIONS => {
			"if" => 89,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			"my" => 88,
			"while" => -139,
			'OP05_LOGICAL_NEG' => 77,
			"for my integer" => -139,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'LPAREN' => 97,
			'OP01_NAMED' => 96,
			'' => -18,
			'OP01_OPEN' => 91,
			"undef" => 90,
			"foreach my" => -139,
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'OP01_PRINT' => 103,
			'WORD_UPPERCASE' => 102,
			'OP01_NAMED_VOID' => 101,
			'OP19_LOOP_CONTROL' => 118,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'LBRACE' => 114,
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 110
		},
		GOTOS => {
			'Literal' => 106,
			'OperatorVoid' => 107,
			'LoopLabel' => 85,
			'PAREN-34' => 87,
			'Expression' => 82,
			'WordScoped' => 83,
			'Variable' => 98,
			'OPTIONAL-35' => 100,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Conditional' => 121,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'VariableModification' => 117,
			'Operation' => 139,
			'SubExpression' => 93,
			'Statement' => 94,
			'ArrayDereferenced' => 92,
			'VariableDeclaration' => 109
		}
	},
	{#State 82
		ACTIONS => {
			'OP17_LIST_RANGE' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			";" => 140,
			'OP11_COMPARE_LT_GT' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP04_MATH_POW' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP18_TERNARY' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP08_STRING_CAT' => -126,
			'OP08_MATH_ADD_SUB' => -126
		}
	},
	{#State 83
		ACTIONS => {
			'LPAREN' => 142,
			'OP02_METHOD_THINARROW_NEW' => 141
		}
	},
	{#State 84
		DEFAULT => -14
	},
	{#State 85
		ACTIONS => {
			'COLON' => 143
		}
	},
	{#State 86
		DEFAULT => -207
	},
	{#State 87
		DEFAULT => -138
	},
	{#State 88
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 144
		}
	},
	{#State 89
		ACTIONS => {
			'LPAREN' => 145
		}
	},
	{#State 90
		DEFAULT => -127
	},
	{#State 91
		ACTIONS => {
			"my" => 146
		}
	},
	{#State 92
		DEFAULT => -131
	},
	{#State 93
		ACTIONS => {
			'OP04_MATH_POW' => 158,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 152,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP17_LIST_RANGE' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP11_COMPARE_LT_GT' => 151,
			'OP23_LOGICAL_AND' => 150
		}
	},
	{#State 94
		DEFAULT => -77
	},
	{#State 95
		DEFAULT => -130
	},
	{#State 96
		ACTIONS => {
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 131,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			"my" => 167,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 83,
			'Expression' => 132,
			'ListElement' => 164,
			'SubExpression' => 165,
			'ArrayDereferenced' => 92,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Literal' => 106,
			'Variable' => 134,
			'TypeInner' => 166,
			'ArrayReference' => 95,
			'HashReference' => 116
		}
	},
	{#State 97
		ACTIONS => {
			'WORD_UPPERCASE' => 131,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 86,
			'OP01_PRINT' => 170,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'LPAREN' => 97,
			'OP01_NAMED' => 168,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LBRACE' => 114
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 92,
			'Expression' => 132,
			'WordScoped' => 83,
			'SubExpression' => 169
		}
	},
	{#State 98
		ACTIONS => {
			'OP16_LOGICAL_OR' => -129,
			'OP03_MATH_INC_DEC' => 172,
			'OP04_MATH_POW' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP19_VARIABLE_ASSIGN' => 173,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP02_METHOD_THINARROW' => 174,
			'OP17_LIST_RANGE' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 171,
			'OP11_COMPARE_LT_GT' => -129
		}
	},
	{#State 99
		DEFAULT => -121
	},
	{#State 100
		ACTIONS => {
			"for my integer" => 179,
			"foreach my" => 176,
			"while" => 178
		},
		GOTOS => {
			'Loop' => 180,
			'LoopWhile' => 175,
			'LoopFor' => 181,
			'LoopForEach' => 177
		}
	},
	{#State 101
		ACTIONS => {
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 131,
			'OP01_QW' => 182,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			"my" => 167,
			'WORD' => 28
		},
		GOTOS => {
			'Operator' => 99,
			'HashDereferenced' => 119,
			'ListElements' => 185,
			'Literal' => 106,
			'Variable' => 134,
			'TypeInner' => 166,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Expression' => 132,
			'WordScoped' => 83,
			'SubExpression' => 184,
			'ListElement' => 183,
			'ArrayDereferenced' => 92
		}
	},
	{#State 102
		ACTIONS => {
			'LPAREN' => 186,
			'COLON' => -200
		}
	},
	{#State 103
		ACTIONS => {
			'OP01_OPEN' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			"undef" => -109,
			'WORD_SCOPED' => -109,
			'OP01_CLOSE' => -109,
			"%{" => -109,
			'LBRACE' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LBRACKET' => -109,
			'LPAREN' => -109,
			'OP01_NAMED' => -109,
			'LITERAL_STRING' => -109,
			"\@{" => -109,
			'OP05_LOGICAL_NEG' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'STDOUT_STDERR' => 189,
			'OP01_QW' => -109,
			'FH_REF_SYMBOL_BRACES' => 190,
			'WORD_UPPERCASE' => -109,
			'WORD' => -109,
			"my" => -109,
			'LITERAL_NUMBER' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP10_NAMED_UNARY' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 188,
			'PAREN-30' => 187
		}
	},
	{#State 104
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 191
		}
	},
	{#State 105
		ACTIONS => {
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP17_LIST_RANGE' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP23_LOGICAL_AND' => -95,
			"]" => -95,
			'LPAREN' => 97,
			'OP11_COMPARE_LT_GT' => -95,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP16_LOGICAL_OR' => -95,
			'OP03_MATH_INC_DEC' => 78,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP08_STRING_CAT' => -95,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'OP14_BITWISE_OR_XOR' => -95,
			";" => -95,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			"}" => -95,
			'LBRACE' => 114,
			")" => -95,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP21_LIST_COMMA' => -95,
			'OP04_MATH_POW' => -95,
			'WORD_UPPERCASE' => 131,
			'OP07_STRING_REPEAT' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'VARIABLE_SYMBOL' => 104,
			'OP18_TERNARY' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Literal' => 106,
			'Variable' => 134,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 192,
			'ArrayDereferenced' => 92
		}
	},
	{#State 106
		DEFAULT => -128
	},
	{#State 107
		DEFAULT => -142
	},
	{#State 108
		ACTIONS => {
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 131,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'SubExpression' => 193,
			'WordScoped' => 83,
			'Expression' => 132,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'Variable' => 134,
			'Literal' => 106,
			'HashDereferenced' => 119,
			'Operator' => 99
		}
	},
	{#State 109
		DEFAULT => -143
	},
	{#State 110
		DEFAULT => -115
	},
	{#State 111
		DEFAULT => -17
	},
	{#State 112
		ACTIONS => {
			'VARIABLE_SYMBOL' => 104,
			'LBRACE' => 114
		},
		GOTOS => {
			'HashReference' => 195,
			'Variable' => 194
		}
	},
	{#State 113
		ACTIONS => {
			'FH_REF_SYMBOL' => 196
		}
	},
	{#State 114
		ACTIONS => {
			'WORD' => 200,
			"}" => 199,
			"%{" => 112
		},
		GOTOS => {
			'HashDereferenced' => 198,
			'HashEntry' => 197
		}
	},
	{#State 115
		DEFAULT => -112
	},
	{#State 116
		DEFAULT => -132
	},
	{#State 117
		DEFAULT => -144
	},
	{#State 118
		ACTIONS => {
			'WORD_UPPERCASE' => 202
		},
		GOTOS => {
			'LoopLabel' => 201
		}
	},
	{#State 119
		DEFAULT => -133
	},
	{#State 120
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			"my" => 167,
			'WORD_UPPERCASE' => 131,
			'OP01_QW' => 182,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			"]" => -181,
			'LBRACKET' => 120,
			'LBRACE' => 114,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90
		},
		GOTOS => {
			'SubExpression' => 184,
			'ListElement' => 183,
			'Expression' => 132,
			'WordScoped' => 83,
			'OPTIONAL-45' => 204,
			'ArrayDereferenced' => 92,
			'ListElements' => 203,
			'Literal' => 106,
			'Variable' => 134,
			'TypeInner' => 166,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'ArrayReference' => 95,
			'HashReference' => 116
		}
	},
	{#State 121
		DEFAULT => -140
	},
	{#State 122
		ACTIONS => {
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 105,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'WORD_UPPERCASE' => 131,
			'LBRACE' => 114,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Literal' => 106,
			'Variable' => 134,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'ArrayDereferenced' => 92,
			'SubExpression' => 205,
			'WordScoped' => 83,
			'Expression' => 132
		}
	},
	{#State 123
		DEFAULT => -40
	},
	{#State 124
		ACTIONS => {
			"\$TYPED_" => 206
		}
	},
	{#State 125
		ACTIONS => {
			";" => 207
		}
	},
	{#State 126
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			"foreach my" => -139,
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP19_LOOP_CONTROL' => 118,
			'LPAREN' => 97,
			'OP01_NAMED' => 96,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP03_MATH_INC_DEC' => 78,
			"for my integer" => -139,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 102,
			'OP01_NAMED_VOID' => 101,
			"while" => -139,
			'LITERAL_NUMBER' => 86,
			'OP01_PRINT' => 103,
			'VARIABLE_SYMBOL' => 104,
			"my" => 88,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105,
			"if" => 89
		},
		GOTOS => {
			'Variable' => 98,
			'OPTIONAL-35' => 100,
			'HashDereferenced' => 119,
			'Conditional' => 121,
			'Operator' => 99,
			'VariableModification' => 117,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'SubExpression' => 93,
			'Operation' => 209,
			'Statement' => 94,
			'PLUS-17' => 208,
			'ArrayDereferenced' => 92,
			'VariableDeclaration' => 109,
			'Literal' => 106,
			'OperatorVoid' => 107,
			'LoopLabel' => 85,
			'PAREN-34' => 87,
			'WordScoped' => 83,
			'Expression' => 82
		}
	},
	{#State 127
		DEFAULT => -42
	},
	{#State 128
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 210
		}
	},
	{#State 129
		DEFAULT => -53
	},
	{#State 130
		ACTIONS => {
			"use constant" => 40,
			"our hash_ref \$properties" => 212
		},
		GOTOS => {
			'Constant' => 211,
			'Properties' => 213
		}
	},
	{#State 131
		ACTIONS => {
			'LPAREN' => 186
		}
	},
	{#State 132
		DEFAULT => -126
	},
	{#State 133
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28,
			'WORD_UPPERCASE' => 131,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACE' => 114,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91
		},
		GOTOS => {
			'SubExpression' => 214,
			'Expression' => 132,
			'WordScoped' => 83,
			'ArrayDereferenced' => 92,
			'Variable' => 134,
			'Literal' => 106,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 134
		ACTIONS => {
			"]" => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP23_LOGICAL_AND' => -129,
			")" => -129,
			'OP17_LIST_RANGE' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			"}" => -129,
			'OP09_BITWISE_SHIFT' => -129,
			";" => -129,
			'OP02_METHOD_THINARROW' => 174,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP18_TERNARY' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP08_STRING_CAT' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP04_MATH_POW' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP03_MATH_INC_DEC' => 172
		}
	},
	{#State 135
		ACTIONS => {
			'OP06_REGEX_MATCH' => -86,
			'OP08_STRING_CAT' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP18_TERNARY' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP04_MATH_POW' => 158,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP23_LOGICAL_AND' => -86,
			")" => -86,
			"]" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			";" => -86,
			'OP17_LIST_RANGE' => -86,
			"}" => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP09_BITWISE_SHIFT' => -86
		}
	},
	{#State 136
		DEFAULT => -83
	},
	{#State 137
		ACTIONS => {
			"}" => 215
		}
	},
	{#State 138
		ACTIONS => {
			"}" => 216
		}
	},
	{#State 139
		DEFAULT => -16
	},
	{#State 140
		DEFAULT => -76
	},
	{#State 141
		ACTIONS => {
			")" => 217
		}
	},
	{#State 142
		ACTIONS => {
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_QW' => 182,
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			"my" => 167,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACE' => 114,
			")" => -118
		},
		GOTOS => {
			'ListElement' => 183,
			'SubExpression' => 184,
			'Expression' => 132,
			'WordScoped' => 83,
			'ArrayDereferenced' => 92,
			'ListElements' => 219,
			'TypeInner' => 166,
			'Variable' => 134,
			'Literal' => 106,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'OPTIONAL-32' => 218,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 143
		DEFAULT => -137
	},
	{#State 144
		ACTIONS => {
			'VARIABLE_SYMBOL' => 220
		}
	},
	{#State 145
		ACTIONS => {
			'LBRACE' => 114,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 131
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Variable' => 134,
			'Literal' => 106,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'ArrayDereferenced' => 92,
			'SubExpression' => 221,
			'Expression' => 132,
			'WordScoped' => 83
		}
	},
	{#State 146
		ACTIONS => {
			"filehandle_ref" => 222
		}
	},
	{#State 147
		ACTIONS => {
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114
		},
		GOTOS => {
			'SubExpression' => 223,
			'WordScoped' => 83,
			'Expression' => 132,
			'ArrayDereferenced' => 92,
			'Variable' => 134,
			'Literal' => 106,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 148
		ACTIONS => {
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 131,
			'LBRACE' => 114,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'Expression' => 132,
			'WordScoped' => 83,
			'SubExpression' => 224,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Variable' => 134,
			'Literal' => 106
		}
	},
	{#State 149
		ACTIONS => {
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 131,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Variable' => 134,
			'Literal' => 106,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'ArrayDereferenced' => 92,
			'SubExpression' => 225,
			'Expression' => 132,
			'WordScoped' => 83
		}
	},
	{#State 150
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28,
			'WORD_UPPERCASE' => 131,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LBRACE' => 114,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90
		},
		GOTOS => {
			'HashReference' => 116,
			'ArrayReference' => 95,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 226
		}
	},
	{#State 151
		ACTIONS => {
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 131,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'LBRACE' => 114,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LPAREN' => 97,
			'OP01_NAMED' => 133
		},
		GOTOS => {
			'SubExpression' => 227,
			'Expression' => 132,
			'WordScoped' => 83,
			'ArrayDereferenced' => 92,
			'Literal' => 106,
			'Variable' => 134,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'ArrayReference' => 95,
			'HashReference' => 116
		}
	},
	{#State 152
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108
		},
		GOTOS => {
			'Literal' => 106,
			'Variable' => 134,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 228,
			'WordScoped' => 83,
			'Expression' => 132,
			'ArrayDereferenced' => 92
		}
	},
	{#State 153
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'WORD_UPPERCASE' => 131,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120
		},
		GOTOS => {
			'Literal' => 106,
			'Variable' => 134,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'SubExpression' => 229,
			'Expression' => 132,
			'WordScoped' => 83,
			'ArrayDereferenced' => 92
		}
	},
	{#State 154
		ACTIONS => {
			'WORD_UPPERCASE' => 131,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACE' => 114
		},
		GOTOS => {
			'Expression' => 132,
			'WordScoped' => 83,
			'SubExpression' => 230,
			'ArrayDereferenced' => 92,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 155
		ACTIONS => {
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 131,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'LBRACE' => 114,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 97,
			'OP01_NAMED' => 133
		},
		GOTOS => {
			'SubExpression' => 231,
			'WordScoped' => 83,
			'Expression' => 132,
			'ArrayDereferenced' => 92,
			'Variable' => 134,
			'Literal' => 106,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 156
		ACTIONS => {
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 131,
			'LBRACE' => 114,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112
		},
		GOTOS => {
			'SubExpression' => 232,
			'WordScoped' => 83,
			'Expression' => 132,
			'ArrayDereferenced' => 92,
			'Variable' => 134,
			'Literal' => 106,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 157
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 92,
			'Expression' => 132,
			'WordScoped' => 83,
			'SubExpression' => 233
		}
	},
	{#State 158
		ACTIONS => {
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 234,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Variable' => 134,
			'Literal' => 106
		}
	},
	{#State 159
		ACTIONS => {
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 131,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 235,
			'ArrayDereferenced' => 92
		}
	},
	{#State 160
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 236
		}
	},
	{#State 161
		ACTIONS => {
			'LBRACE' => 114,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 105,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'WORD_UPPERCASE' => 131
		},
		GOTOS => {
			'SubExpression' => 237,
			'WordScoped' => 83,
			'Expression' => 132,
			'ArrayDereferenced' => 92,
			'Variable' => 134,
			'Literal' => 106,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'ArrayReference' => 95,
			'HashReference' => 116
		}
	},
	{#State 162
		ACTIONS => {
			'LITERAL_STRING' => 79,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'VariableOrLiteral' => 238,
			'Literal' => 239,
			'Variable' => 240
		}
	},
	{#State 163
		ACTIONS => {
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD_UPPERCASE' => 131,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Literal' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 241
		}
	},
	{#State 164
		ACTIONS => {
			'OP21_LIST_COMMA' => 242
		}
	},
	{#State 165
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -79,
			'OP23_LOGICAL_AND' => -79,
			")" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			";" => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_STRING_CAT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP04_MATH_POW' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP21_LIST_COMMA' => -178,
			'OP16_LOGICAL_OR' => -79
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 131,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'Variable' => 134,
			'Literal' => 106,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'SubExpression' => 243,
			'Expression' => 132,
			'WordScoped' => 83,
			'ArrayDereferenced' => 92
		}
	},
	{#State 167
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 244
		}
	},
	{#State 168
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28,
			"my" => 167,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 131,
			'LBRACE' => 114,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Operator' => 99,
			'HashDereferenced' => 119,
			'TypeInner' => 166,
			'Literal' => 106,
			'Variable' => 134,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 165,
			'ListElement' => 245,
			'ArrayDereferenced' => 92
		}
	},
	{#State 169
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 161,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP16_LOGICAL_OR' => 152,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			")" => 246,
			'OP23_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 151,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => 147
		}
	},
	{#State 170
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 247
		}
	},
	{#State 171
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'WORD_UPPERCASE' => 131,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 92,
			'Expression' => 132,
			'WordScoped' => 83,
			'SubExpression' => 248
		}
	},
	{#State 172
		DEFAULT => -84
	},
	{#State 173
		ACTIONS => {
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'STDIN' => 251,
			'LBRACE' => 114,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 131,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'SubExpression' => 250,
			'WordScoped' => 83,
			'SubExpressionOrStdin' => 249,
			'Expression' => 132,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'Variable' => 134,
			'Literal' => 106,
			'Operator' => 99,
			'HashDereferenced' => 119
		}
	},
	{#State 174
		ACTIONS => {
			'LPAREN' => 252
		}
	},
	{#State 175
		DEFAULT => -154
	},
	{#State 176
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 253
		}
	},
	{#State 177
		DEFAULT => -153
	},
	{#State 178
		ACTIONS => {
			'LPAREN' => 254
		}
	},
	{#State 179
		ACTIONS => {
			'VARIABLE_SYMBOL' => 255
		}
	},
	{#State 180
		DEFAULT => -141
	},
	{#State 181
		DEFAULT => -152
	},
	{#State 182
		ACTIONS => {
			'WORD' => 257
		},
		GOTOS => {
			'PLUS-44' => 256
		}
	},
	{#State 183
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 258
		}
	},
	{#State 184
		ACTIONS => {
			"]" => -178,
			'OP11_COMPARE_LT_GT' => 151,
			'OP23_LOGICAL_AND' => 150,
			")" => -178,
			'OP17_LIST_RANGE' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			";" => -178,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP04_MATH_POW' => 158,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 152,
			'OP21_LIST_COMMA' => -178
		}
	},
	{#State 185
		ACTIONS => {
			";" => 259
		}
	},
	{#State 186
		ACTIONS => {
			")" => 260
		}
	},
	{#State 187
		DEFAULT => -108
	},
	{#State 188
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'OP01_QW' => 182,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 131,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			"my" => 167,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			'LBRACE' => 114,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122
		},
		GOTOS => {
			'WordScoped' => 83,
			'Expression' => 132,
			'ListElement' => 183,
			'SubExpression' => 184,
			'ArrayDereferenced' => 92,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'TypeInner' => 166,
			'ListElements' => 261,
			'ArrayReference' => 95,
			'HashReference' => 116
		}
	},
	{#State 189
		DEFAULT => -107
	},
	{#State 190
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			"my" => 167,
			'WORD' => 28,
			'WORD_UPPERCASE' => 131,
			'OP01_QW' => 182,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LBRACE' => 114,
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108
		},
		GOTOS => {
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Literal' => 106,
			'Variable' => 134,
			'TypeInner' => 166,
			'ListElements' => 262,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'WordScoped' => 83,
			'Expression' => 132,
			'ListElement' => 183,
			'SubExpression' => 184,
			'ArrayDereferenced' => 92
		}
	},
	{#State 191
		ACTIONS => {
			'OP04_MATH_POW' => -163,
			'OP02_HASH_THINARROW' => 263,
			'OP13_BITWISE_AND' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP18_TERNARY' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP02_ARRAY_THINARROW' => 264,
			'OP08_STRING_CAT' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			"}" => -163,
			";" => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			"]" => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP23_LOGICAL_AND' => -163,
			'COLON' => -163,
			")" => -163
		},
		GOTOS => {
			'VariableRetrieval' => 265
		}
	},
	{#State 192
		ACTIONS => {
			'OP17_LIST_RANGE' => -94,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			";" => -94,
			"]" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP23_LOGICAL_AND' => -94,
			")" => -94,
			'OP04_MATH_POW' => 158,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161
		}
	},
	{#State 193
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 163,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP16_LOGICAL_OR' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP04_MATH_POW' => 158,
			")" => 266,
			'OP23_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 151,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 147
		}
	},
	{#State 194
		ACTIONS => {
			"}" => 267
		}
	},
	{#State 195
		ACTIONS => {
			"}" => 268
		}
	},
	{#State 196
		DEFAULT => -82
	},
	{#State 197
		DEFAULT => -193,
		GOTOS => {
			'STAR-48' => 269
		}
	},
	{#State 198
		DEFAULT => -188
	},
	{#State 199
		DEFAULT => -195
	},
	{#State 200
		ACTIONS => {
			'OP20_HASH_FATARROW' => 270
		}
	},
	{#State 201
		ACTIONS => {
			";" => 271
		}
	},
	{#State 202
		DEFAULT => -200
	},
	{#State 203
		DEFAULT => -180
	},
	{#State 204
		ACTIONS => {
			"]" => 272
		}
	},
	{#State 205
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 151,
			"]" => -104,
			")" => -104,
			'OP23_LOGICAL_AND' => -104,
			"}" => -104,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 147,
			";" => -104,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 158,
			'OP21_LIST_COMMA' => -104,
			'OP16_LOGICAL_OR' => 152
		}
	},
	{#State 206
		ACTIONS => {
			'WORD_UPPERCASE' => 273
		}
	},
	{#State 207
		DEFAULT => -41
	},
	{#State 208
		ACTIONS => {
			"if" => 89,
			'LITERAL_NUMBER' => 86,
			"my" => 88,
			'WORD' => 28,
			"while" => -139,
			'OP03_MATH_INC_DEC' => 78,
			"for my integer" => -139,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'LPAREN' => 97,
			'OP01_NAMED' => 96,
			'OP01_OPEN' => 91,
			"undef" => 90,
			"foreach my" => -139,
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT' => 103,
			'VARIABLE_SYMBOL' => 104,
			'WORD_UPPERCASE' => 102,
			'OP01_NAMED_VOID' => 101,
			'OP19_LOOP_CONTROL' => 118,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LBRACE' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			"}" => 274,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 110
		},
		GOTOS => {
			'Literal' => 106,
			'OperatorVoid' => 107,
			'LoopLabel' => 85,
			'PAREN-34' => 87,
			'WordScoped' => 83,
			'Expression' => 82,
			'Variable' => 98,
			'OPTIONAL-35' => 100,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Conditional' => 121,
			'VariableModification' => 117,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'SubExpression' => 93,
			'Operation' => 275,
			'Statement' => 94,
			'VariableDeclaration' => 109,
			'ArrayDereferenced' => 92
		}
	},
	{#State 209
		DEFAULT => -45
	},
	{#State 210
		ACTIONS => {
			'VARIABLE_SYMBOL' => 276
		}
	},
	{#State 211
		DEFAULT => -55
	},
	{#State 212
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 277
		}
	},
	{#State 213
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 278
		}
	},
	{#State 214
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_STRING_CAT' => -79,
			'OP18_TERNARY' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP04_MATH_POW' => -79,
			")" => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			"]" => -79,
			";" => -79,
			"}" => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP17_LIST_RANGE' => -79
		}
	},
	{#State 215
		DEFAULT => -183
	},
	{#State 216
		DEFAULT => -184
	},
	{#State 217
		DEFAULT => -125
	},
	{#State 218
		ACTIONS => {
			")" => 279
		}
	},
	{#State 219
		DEFAULT => -117
	},
	{#State 220
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 281,
			";" => 280
		}
	},
	{#State 221
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP04_MATH_POW' => 158,
			'OP16_LOGICAL_OR' => 152,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 147,
			'OP11_COMPARE_LT_GT' => 151,
			")" => 282,
			'OP23_LOGICAL_AND' => 150
		}
	},
	{#State 222
		ACTIONS => {
			'FH_REF_SYMBOL' => 283
		}
	},
	{#State 223
		ACTIONS => {
			";" => -102,
			'OP17_LIST_RANGE' => undef,
			"}" => -102,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP23_LOGICAL_AND' => -102,
			")" => -102,
			"]" => -102,
			'OP11_COMPARE_LT_GT' => 151,
			'OP21_LIST_COMMA' => -102,
			'OP16_LOGICAL_OR' => 152,
			'OP04_MATH_POW' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP13_BITWISE_AND' => 154,
			'OP06_REGEX_MATCH' => 160,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP08_MATH_ADD_SUB' => 161,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => -102,
			'OP15_LOGICAL_AND' => 163
		}
	},
	{#State 224
		ACTIONS => {
			"]" => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP23_LOGICAL_AND' => -93,
			")" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			"}" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			";" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP18_TERNARY' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 160,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP08_MATH_ADD_SUB' => 161,
			'OP04_MATH_POW' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP16_LOGICAL_OR' => -93
		}
	},
	{#State 225
		ACTIONS => {
			'OP15_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP13_BITWISE_AND' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP04_MATH_POW' => 158,
			'OP21_LIST_COMMA' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP11_COMPARE_LT_GT' => 151,
			"]" => -97,
			")" => -97,
			'OP23_LOGICAL_AND' => -97,
			"}" => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => -97,
			";" => -97
		}
	},
	{#State 226
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 163,
			'OP06_REGEX_MATCH' => 160,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP08_MATH_ADD_SUB' => 161,
			'OP04_MATH_POW' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP13_BITWISE_AND' => 154,
			'OP21_LIST_COMMA' => -105,
			'OP16_LOGICAL_OR' => 152,
			"]" => -105,
			'OP11_COMPARE_LT_GT' => 151,
			'OP23_LOGICAL_AND' => -105,
			")" => -105,
			'OP17_LIST_RANGE' => 147,
			"}" => -105,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			";" => -105
		}
	},
	{#State 227
		ACTIONS => {
			'OP17_LIST_RANGE' => -96,
			"}" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP09_BITWISE_SHIFT' => 148,
			";" => -96,
			"]" => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -96,
			")" => -96,
			'OP04_MATH_POW' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP18_TERNARY' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP08_MATH_ADD_SUB' => 161
		}
	},
	{#State 228
		ACTIONS => {
			";" => -101,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -101,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => -101,
			")" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => 151,
			"]" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP18_TERNARY' => -101,
			'OP15_LOGICAL_AND' => 163,
			'OP14_BITWISE_OR_XOR' => 157
		}
	},
	{#State 229
		ACTIONS => {
			"]" => -106,
			'OP11_COMPARE_LT_GT' => 151,
			'OP23_LOGICAL_AND' => 150,
			")" => -106,
			'OP17_LIST_RANGE' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -106,
			";" => -106,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP04_MATH_POW' => 158,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => 152,
			'OP21_LIST_COMMA' => -106
		}
	},
	{#State 230
		ACTIONS => {
			";" => -98,
			"}" => -98,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => -98,
			")" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP11_COMPARE_LT_GT' => 151,
			"]" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP15_LOGICAL_AND' => -98,
			'OP18_TERNARY' => -98,
			'OP14_BITWISE_OR_XOR' => -98
		}
	},
	{#State 231
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -90,
			'OP08_STRING_CAT' => -90,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160,
			'OP15_LOGICAL_AND' => -90,
			'OP18_TERNARY' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP04_MATH_POW' => 158,
			")" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			"]" => -90,
			";" => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			"}" => -90,
			'OP17_LIST_RANGE' => -90
		}
	},
	{#State 232
		ACTIONS => {
			";" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			"}" => -92,
			'OP17_LIST_RANGE' => -92,
			")" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			"]" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 161,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => -92,
			'OP06_REGEX_MATCH' => 160,
			'OP15_LOGICAL_AND' => -92,
			'OP18_TERNARY' => -92,
			'OP14_BITWISE_OR_XOR' => -92
		}
	},
	{#State 233
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP18_TERNARY' => -99,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP04_MATH_POW' => 158,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP16_LOGICAL_OR' => -99,
			'OP21_LIST_COMMA' => -99,
			"]" => -99,
			'OP11_COMPARE_LT_GT' => 151,
			'OP23_LOGICAL_AND' => -99,
			")" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -99,
			'OP12_COMPARE_EQ_NE' => 149,
			";" => -99
		}
	},
	{#State 234
		ACTIONS => {
			'OP16_LOGICAL_OR' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => 158,
			'OP13_BITWISE_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85,
			";" => -85,
			'OP17_LIST_RANGE' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			")" => -85,
			"]" => -85,
			'OP11_COMPARE_LT_GT' => -85
		}
	},
	{#State 235
		ACTIONS => {
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => -89,
			'OP08_STRING_CAT' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP18_TERNARY' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP04_MATH_POW' => 158,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP23_LOGICAL_AND' => -89,
			")" => -89,
			"]" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			";" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			"}" => -89,
			'OP09_BITWISE_SHIFT' => -89
		}
	},
	{#State 236
		DEFAULT => -88
	},
	{#State 237
		ACTIONS => {
			'OP15_LOGICAL_AND' => -91,
			'OP18_TERNARY' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => -91,
			'OP06_REGEX_MATCH' => 160,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			'OP16_LOGICAL_OR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			"]" => -91,
			")" => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			"}" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP17_LIST_RANGE' => -91,
			";" => -91
		}
	},
	{#State 238
		ACTIONS => {
			'COLON' => 284
		}
	},
	{#State 239
		DEFAULT => -205
	},
	{#State 240
		DEFAULT => -204
	},
	{#State 241
		ACTIONS => {
			'OP16_LOGICAL_OR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP13_BITWISE_AND' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 161,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160,
			'OP18_TERNARY' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => 157,
			";" => -100,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => -100,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => -100,
			")" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => 151,
			"]" => -100
		}
	},
	{#State 242
		ACTIONS => {
			'WORD_UPPERCASE' => 131,
			'OP01_QW' => 182,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			"my" => 167,
			'WORD' => 28,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACE' => 114
		},
		GOTOS => {
			'ListElement' => 183,
			'SubExpression' => 184,
			'Expression' => 132,
			'WordScoped' => 83,
			'ArrayDereferenced' => 92,
			'ListElements' => 285,
			'Literal' => 106,
			'TypeInner' => 166,
			'Variable' => 134,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 243
		ACTIONS => {
			'OP21_LIST_COMMA' => -179,
			'OP16_LOGICAL_OR' => 152,
			'OP04_MATH_POW' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP08_MATH_ADD_SUB' => 161,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 163,
			";" => -179,
			'OP17_LIST_RANGE' => 147,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP23_LOGICAL_AND' => 150,
			")" => -179,
			"]" => -179,
			'OP11_COMPARE_LT_GT' => 151
		}
	},
	{#State 244
		ACTIONS => {
			"\$TYPED_" => 286
		}
	},
	{#State 245
		ACTIONS => {
			'OP21_LIST_COMMA' => 287
		}
	},
	{#State 246
		DEFAULT => -134
	},
	{#State 247
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP10_NAMED_UNARY' => 105,
			"my" => 167,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD_UPPERCASE' => 131,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'OP01_QW' => 182,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Literal' => 106,
			'Variable' => 134,
			'TypeInner' => 166,
			'ListElements' => 288,
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 184,
			'ListElement' => 183
		}
	},
	{#State 248
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => 147,
			";" => 289,
			'OP11_COMPARE_LT_GT' => 151,
			'OP23_LOGICAL_AND' => 150,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			'OP16_LOGICAL_OR' => 152,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP08_MATH_ADD_SUB' => 161,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160
		}
	},
	{#State 249
		ACTIONS => {
			";" => 290
		}
	},
	{#State 250
		ACTIONS => {
			'OP16_LOGICAL_OR' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 163,
			'OP14_BITWISE_OR_XOR' => 157,
			";" => -135,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 147,
			'OP23_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 151
		}
	},
	{#State 251
		DEFAULT => -136
	},
	{#State 252
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28,
			"my" => 167,
			'OP10_NAMED_UNARY' => 105,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'OP01_QW' => 182,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 131,
			")" => -120,
			'LBRACE' => 114,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_OPEN' => 91,
			"%{" => 112,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113
		},
		GOTOS => {
			'Expression' => 132,
			'WordScoped' => 83,
			'SubExpression' => 184,
			'ListElement' => 183,
			'ArrayDereferenced' => 92,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'ListElements' => 291,
			'Literal' => 106,
			'Variable' => 134,
			'TypeInner' => 166,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'OPTIONAL-33' => 292
		}
	},
	{#State 253
		ACTIONS => {
			'VARIABLE_SYMBOL' => 293
		}
	},
	{#State 254
		ACTIONS => {
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACE' => 114
		},
		GOTOS => {
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 294,
			'ArrayDereferenced' => 92
		}
	},
	{#State 255
		ACTIONS => {
			'LPAREN' => 295
		}
	},
	{#State 256
		ACTIONS => {
			")" => 296,
			'WORD' => 297
		}
	},
	{#State 257
		DEFAULT => -175
	},
	{#State 258
		ACTIONS => {
			"]" => -176,
			";" => -176,
			")" => -176,
			'OP21_LIST_COMMA' => 298
		},
		GOTOS => {
			'PAREN-42' => 299
		}
	},
	{#State 259
		DEFAULT => -113
	},
	{#State 260
		DEFAULT => -123
	},
	{#State 261
		ACTIONS => {
			";" => 300
		}
	},
	{#State 262
		ACTIONS => {
			";" => 301
		}
	},
	{#State 263
		ACTIONS => {
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			'LBRACE' => 114,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 131,
			'WORD' => 302,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'SubExpression' => 303,
			'Expression' => 132,
			'WordScoped' => 83,
			'ArrayDereferenced' => 92,
			'Literal' => 106,
			'Variable' => 134,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 264
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108
		},
		GOTOS => {
			'SubExpression' => 304,
			'Expression' => 132,
			'WordScoped' => 83,
			'ArrayDereferenced' => 92,
			'Variable' => 134,
			'Literal' => 106,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'HashReference' => 116,
			'ArrayReference' => 95
		}
	},
	{#State 265
		DEFAULT => -161
	},
	{#State 266
		DEFAULT => -87
	},
	{#State 267
		DEFAULT => -196
	},
	{#State 268
		DEFAULT => -197
	},
	{#State 269
		ACTIONS => {
			"}" => 307,
			'OP21_LIST_COMMA' => 306
		},
		GOTOS => {
			'PAREN-47' => 305
		}
	},
	{#State 270
		ACTIONS => {
			"%{" => -186,
			'WORD_SCOPED' => -186,
			'OP01_CLOSE' => -186,
			"undef" => -186,
			'OP01_OPEN' => -186,
			'OP05_MATH_NEG_LPAREN' => -186,
			'OP01_NAMED' => -186,
			'LPAREN' => -186,
			'OP22_LOGICAL_NEG' => -186,
			'LBRACKET' => -186,
			'LBRACE' => -186,
			'WORD_UPPERCASE' => -186,
			'OP03_MATH_INC_DEC' => -186,
			'OP05_LOGICAL_NEG' => -186,
			'LITERAL_STRING' => -186,
			"\@{" => -186,
			'OP10_NAMED_UNARY' => -186,
			'VARIABLE_SYMBOL' => -186,
			'LITERAL_NUMBER' => -186,
			"my" => 167,
			'WORD' => -186
		},
		GOTOS => {
			'OPTIONAL-46' => 309,
			'TypeInner' => 308
		}
	},
	{#State 271
		DEFAULT => -116
	},
	{#State 272
		DEFAULT => -182
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 310
		}
	},
	{#State 274
		ACTIONS => {
			";" => 311
		}
	},
	{#State 275
		DEFAULT => -44
	},
	{#State 276
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 312
		}
	},
	{#State 277
		ACTIONS => {
			'LBRACE' => 313
		}
	},
	{#State 278
		ACTIONS => {
			"our" => 316,
			'LITERAL_NUMBER' => 318
		},
		GOTOS => {
			'MethodOrSubroutine' => 317,
			'Method' => 314,
			'Subroutine' => 315
		}
	},
	{#State 279
		DEFAULT => -122
	},
	{#State 280
		DEFAULT => -167
	},
	{#State 281
		ACTIONS => {
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'STDIN' => 251,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 131,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28
		},
		GOTOS => {
			'HashReference' => 116,
			'ArrayReference' => 95,
			'Variable' => 134,
			'Literal' => 106,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'ArrayDereferenced' => 92,
			'SubExpression' => 250,
			'Expression' => 132,
			'SubExpressionOrStdin' => 319,
			'WordScoped' => 83
		}
	},
	{#State 282
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 321
		}
	},
	{#State 283
		ACTIONS => {
			'OP21_LIST_COMMA' => 322
		}
	},
	{#State 284
		ACTIONS => {
			'LITERAL_STRING' => 79,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104
		},
		GOTOS => {
			'VariableOrLiteral' => 323,
			'Literal' => 239,
			'Variable' => 240
		}
	},
	{#State 285
		ACTIONS => {
			";" => 324
		}
	},
	{#State 286
		ACTIONS => {
			'WORD' => 325
		}
	},
	{#State 287
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			"my" => 167,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP01_QW' => 182,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'OP05_MATH_NEG_LPAREN' => 108
		},
		GOTOS => {
			'HashDereferenced' => 119,
			'Operator' => 99,
			'ListElements' => 326,
			'TypeInner' => 166,
			'Variable' => 134,
			'Literal' => 106,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Expression' => 132,
			'WordScoped' => 83,
			'ListElement' => 183,
			'SubExpression' => 184,
			'ArrayDereferenced' => 92
		}
	},
	{#State 288
		ACTIONS => {
			")" => 327
		}
	},
	{#State 289
		DEFAULT => -170
	},
	{#State 290
		DEFAULT => -169
	},
	{#State 291
		DEFAULT => -119
	},
	{#State 292
		ACTIONS => {
			")" => 328
		}
	},
	{#State 293
		ACTIONS => {
			'LPAREN' => 329
		}
	},
	{#State 294
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 161,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 163,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP16_LOGICAL_OR' => 152,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			")" => 330,
			'OP23_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 151,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => 147
		}
	},
	{#State 295
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 131,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'WORD' => 28,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_OPEN' => 91,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'LBRACE' => 114,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 331,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Variable' => 134,
			'Literal' => 106
		}
	},
	{#State 296
		DEFAULT => -177
	},
	{#State 297
		DEFAULT => -174
	},
	{#State 298
		ACTIONS => {
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 105,
			"my" => 167,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77
		},
		GOTOS => {
			'ListElement' => 332,
			'SubExpression' => 184,
			'WordScoped' => 83,
			'Expression' => 132,
			'ArrayDereferenced' => 92,
			'Literal' => 106,
			'Variable' => 134,
			'TypeInner' => 166,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'ArrayReference' => 95,
			'HashReference' => 116
		}
	},
	{#State 299
		DEFAULT => -172
	},
	{#State 300
		DEFAULT => -110
	},
	{#State 301
		DEFAULT => -111
	},
	{#State 302
		ACTIONS => {
			"}" => 333,
			'LPAREN' => -198,
			'OP02_METHOD_THINARROW_NEW' => -198
		}
	},
	{#State 303
		ACTIONS => {
			'OP23_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 151,
			'OP17_LIST_RANGE' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			"}" => 334,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP16_LOGICAL_OR' => 152,
			'OP04_MATH_POW' => 158,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 155
		}
	},
	{#State 304
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 151,
			"]" => 335,
			'OP23_LOGICAL_AND' => 150,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 147,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP04_MATH_POW' => 158,
			'OP16_LOGICAL_OR' => 152
		}
	},
	{#State 305
		DEFAULT => -192
	},
	{#State 306
		ACTIONS => {
			'WORD' => 200,
			"%{" => 112
		},
		GOTOS => {
			'HashDereferenced' => 198,
			'HashEntry' => 336
		}
	},
	{#State 307
		DEFAULT => -194
	},
	{#State 308
		DEFAULT => -185
	},
	{#State 309
		ACTIONS => {
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LBRACE' => 114,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			'OP10_NAMED_UNARY' => 105,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			'WORD_UPPERCASE' => 131,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			"\@{" => 80,
			'LITERAL_STRING' => 79
		},
		GOTOS => {
			'HashReference' => 116,
			'ArrayReference' => 95,
			'Variable' => 134,
			'Literal' => 106,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'ArrayDereferenced' => 92,
			'SubExpression' => 337,
			'WordScoped' => 83,
			'Expression' => 132
		}
	},
	{#State 310
		DEFAULT => -203
	},
	{#State 311
		DEFAULT => -46
	},
	{#State 312
		ACTIONS => {
			'OP21_LIST_COMMA' => 339,
			")" => 340
		},
		GOTOS => {
			'PAREN-18' => 338
		}
	},
	{#State 313
		ACTIONS => {
			'WORD' => 341,
			"%{" => 112,
			"}" => 344
		},
		GOTOS => {
			'HashDereferenced' => 342,
			'HashEntryTyped' => 343
		}
	},
	{#State 314
		DEFAULT => -74
	},
	{#State 315
		DEFAULT => -75
	},
	{#State 316
		ACTIONS => {
			'WORD' => 53,
			'TYPE_METHOD' => 345
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 317
		DEFAULT => -57
	},
	{#State 318
		ACTIONS => {
			";" => 346
		}
	},
	{#State 319
		ACTIONS => {
			";" => 347
		}
	},
	{#State 320
		ACTIONS => {
			'LBRACE' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LPAREN' => 97,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_NAMED' => 96,
			"foreach my" => -139,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			'WORD' => 28,
			"my" => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_PRINT' => 103,
			'VARIABLE_SYMBOL' => 104,
			"if" => 89,
			'OP10_NAMED_UNARY' => 105,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			"for my integer" => -139,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 102,
			'OP01_NAMED_VOID' => 101,
			"while" => -139
		},
		GOTOS => {
			'Variable' => 98,
			'PLUS-40' => 348,
			'OPTIONAL-35' => 100,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Conditional' => 121,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'VariableModification' => 117,
			'Operation' => 349,
			'SubExpression' => 93,
			'Statement' => 94,
			'ArrayDereferenced' => 92,
			'VariableDeclaration' => 109,
			'Literal' => 106,
			'OperatorVoid' => 107,
			'LoopLabel' => 85,
			'PAREN-34' => 87,
			'Expression' => 82,
			'WordScoped' => 83
		}
	},
	{#State 321
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 350
		}
	},
	{#State 322
		ACTIONS => {
			'LITERAL_STRING' => 351
		}
	},
	{#State 323
		DEFAULT => -103
	},
	{#State 324
		DEFAULT => -114
	},
	{#State 325
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 352
		}
	},
	{#State 326
		ACTIONS => {
			")" => 353
		}
	},
	{#State 327
		DEFAULT => -78
	},
	{#State 328
		DEFAULT => -124
	},
	{#State 329
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			'OP10_NAMED_UNARY' => 105,
			"my" => 167,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP01_QW' => 182,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78
		},
		GOTOS => {
			'TypeInner' => 166,
			'Literal' => 106,
			'Variable' => 134,
			'ListElements' => 354,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'ListElement' => 183,
			'SubExpression' => 184,
			'WordScoped' => 83,
			'Expression' => 132,
			'ArrayDereferenced' => 92
		}
	},
	{#State 330
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 355
		}
	},
	{#State 331
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 151,
			'OP23_LOGICAL_AND' => 150,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => 356,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP08_MATH_ADD_SUB' => 161,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP13_BITWISE_AND' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			'OP16_LOGICAL_OR' => 152
		}
	},
	{#State 332
		DEFAULT => -171
	},
	{#State 333
		DEFAULT => -166
	},
	{#State 334
		DEFAULT => -165
	},
	{#State 335
		DEFAULT => -164
	},
	{#State 336
		DEFAULT => -191
	},
	{#State 337
		ACTIONS => {
			'OP16_LOGICAL_OR' => 152,
			'OP21_LIST_COMMA' => -187,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 161,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP06_REGEX_MATCH' => 160,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 163,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -187,
			'OP17_LIST_RANGE' => 147,
			'OP23_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 151
		}
	},
	{#State 338
		DEFAULT => -48
	},
	{#State 339
		ACTIONS => {
			"my" => 357
		}
	},
	{#State 340
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358
		}
	},
	{#State 341
		ACTIONS => {
			'OP20_HASH_FATARROW' => 359
		}
	},
	{#State 342
		DEFAULT => -190
	},
	{#State 343
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 360
		}
	},
	{#State 344
		ACTIONS => {
			";" => 361
		}
	},
	{#State 345
		ACTIONS => {
			'VARIABLE_SYMBOL' => 362
		}
	},
	{#State 346
		DEFAULT => -59
	},
	{#State 347
		DEFAULT => -168
	},
	{#State 348
		ACTIONS => {
			"foreach my" => -139,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP01_NAMED' => 96,
			'LPAREN' => 97,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			"for my integer" => -139,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			"while" => -139,
			"my" => 88,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			"if" => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"}" => 363,
			"%{" => 112,
			'LBRACE' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_NAMED_VOID' => 101,
			'WORD_UPPERCASE' => 102,
			'OP01_PRINT' => 103,
			'VARIABLE_SYMBOL' => 104,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'WordScoped' => 83,
			'Expression' => 82,
			'LoopLabel' => 85,
			'PAREN-34' => 87,
			'Literal' => 106,
			'OperatorVoid' => 107,
			'VariableDeclaration' => 109,
			'ArrayDereferenced' => 92,
			'SubExpression' => 93,
			'Operation' => 364,
			'Statement' => 94,
			'VariableModification' => 117,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'Variable' => 98,
			'Operator' => 99,
			'OPTIONAL-35' => 100,
			'HashDereferenced' => 119,
			'Conditional' => 121
		}
	},
	{#State 349
		DEFAULT => -159
	},
	{#State 350
		ACTIONS => {
			"while" => -150,
			"elsif" => 369,
			'OP05_LOGICAL_NEG' => -150,
			"for my integer" => -150,
			'OP03_MATH_INC_DEC' => -150,
			"\@{" => -150,
			'LITERAL_STRING' => -150,
			"if" => -150,
			'LITERAL_NUMBER' => -150,
			"my" => -150,
			'WORD' => -150,
			"undef" => -150,
			'OP01_OPEN' => -150,
			"foreach my" => -150,
			'OP01_NAMED' => -150,
			'LPAREN' => -150,
			'' => -150,
			'OP01_NAMED_VOID' => -150,
			'WORD_UPPERCASE' => -150,
			'OP10_NAMED_UNARY' => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP01_PRINT' => -150,
			"}" => -150,
			"%{" => -150,
			'WORD_SCOPED' => -150,
			'OP01_CLOSE' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP19_LOOP_CONTROL' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'LBRACKET' => -150,
			"else" => 365,
			'LBRACE' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150
		},
		GOTOS => {
			'PAREN-36' => 368,
			'OPTIONAL-39' => 367,
			'PAREN-38' => 366
		}
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 370
		}
	},
	{#State 352
		DEFAULT => -202
	},
	{#State 353
		DEFAULT => -80
	},
	{#State 354
		ACTIONS => {
			")" => 371
		}
	},
	{#State 355
		DEFAULT => -157
	},
	{#State 356
		ACTIONS => {
			'LBRACE' => 114,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 131
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 372,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Variable' => 134,
			'Literal' => 106
		}
	},
	{#State 357
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 373
		}
	},
	{#State 358
		ACTIONS => {
			"\@_;" => 374
		}
	},
	{#State 359
		ACTIONS => {
			"my" => 167
		},
		GOTOS => {
			'TypeInner' => 375
		}
	},
	{#State 360
		ACTIONS => {
			"}" => 376,
			'OP21_LIST_COMMA' => 378
		},
		GOTOS => {
			'PAREN-24' => 377
		}
	},
	{#State 361
		DEFAULT => -64
	},
	{#State 362
		ACTIONS => {
			"= sub {" => 379
		}
	},
	{#State 363
		DEFAULT => -160
	},
	{#State 364
		DEFAULT => -158
	},
	{#State 365
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 380
		}
	},
	{#State 366
		DEFAULT => -149
	},
	{#State 367
		DEFAULT => -151
	},
	{#State 368
		DEFAULT => -146
	},
	{#State 369
		ACTIONS => {
			'LPAREN' => 381
		}
	},
	{#State 370
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			"undef" => 90,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'WORD_UPPERCASE' => 131,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'OP10_NAMED_UNARY' => 105,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134,
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 382
		}
	},
	{#State 371
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 383
		}
	},
	{#State 372
		ACTIONS => {
			'OP16_LOGICAL_OR' => 152,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 161,
			'OP08_STRING_CAT' => 156,
			'OP07_STRING_REPEAT' => 159,
			'OP06_REGEX_MATCH' => 160,
			'OP18_TERNARY' => -102,
			'OP15_LOGICAL_AND' => 163,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP17_LIST_RANGE' => undef,
			")" => 384,
			'OP23_LOGICAL_AND' => -102,
			'OP11_COMPARE_LT_GT' => 151
		}
	},
	{#State 373
		ACTIONS => {
			'VARIABLE_SYMBOL' => 385
		}
	},
	{#State 374
		DEFAULT => -50
	},
	{#State 375
		ACTIONS => {
			'LBRACE' => 114,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'OP01_NAMED' => 133,
			'LPAREN' => 97,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 90,
			'OP01_OPEN' => 91,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'WORD' => 28,
			'VARIABLE_SYMBOL' => 104,
			'LITERAL_NUMBER' => 86,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'WORD_UPPERCASE' => 131
		},
		GOTOS => {
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 386,
			'ArrayReference' => 95,
			'HashReference' => 116,
			'HashDereferenced' => 119,
			'Operator' => 99,
			'Literal' => 106,
			'Variable' => 134
		}
	},
	{#State 376
		ACTIONS => {
			";" => 387
		}
	},
	{#State 377
		DEFAULT => -61
	},
	{#State 378
		ACTIONS => {
			"%{" => 112,
			'WORD' => 341
		},
		GOTOS => {
			'HashDereferenced' => 342,
			'HashEntryTyped' => 388
		}
	},
	{#State 379
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -66,
			'LBRACKET' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LBRACE' => -66,
			'OP01_CLOSE' => -66,
			'WORD_SCOPED' => -66,
			"%{" => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP10_NAMED_UNARY' => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP01_PRINT' => -66,
			'OP01_NAMED_VOID' => -66,
			'WORD_UPPERCASE' => -66,
			'OP01_NAMED' => -66,
			'LPAREN' => -66,
			"foreach my" => -66,
			"undef" => -66,
			'OP01_OPEN' => -66,
			"if" => -66,
			'WORD' => -66,
			"my" => -66,
			'LPAREN_MY' => 389,
			'LITERAL_NUMBER' => -66,
			"while" => -66,
			'LITERAL_STRING' => -66,
			"\@{" => -66,
			'OP03_MATH_INC_DEC' => -66,
			"for my integer" => -66,
			'OP05_LOGICAL_NEG' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 390,
			'MethodArguments' => 391
		}
	},
	{#State 380
		DEFAULT => -148
	},
	{#State 381
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 113,
			"%{" => 112,
			'LBRACE' => 114,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'LPAREN' => 97,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'WORD_UPPERCASE' => 131,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 104,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayReference' => 95,
			'HashReference' => 116,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Variable' => 134,
			'Literal' => 106,
			'ArrayDereferenced' => 92,
			'WordScoped' => 83,
			'Expression' => 132,
			'SubExpression' => 392
		}
	},
	{#State 382
		ACTIONS => {
			'OP23_LOGICAL_AND' => -81,
			")" => -81,
			"]" => -81,
			'OP11_COMPARE_LT_GT' => 151,
			";" => -81,
			'OP17_LIST_RANGE' => 147,
			'OP09_BITWISE_SHIFT' => 148,
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -81,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP06_REGEX_MATCH' => 160,
			'OP08_MATH_ADD_SUB' => 161,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 163,
			'OP16_LOGICAL_OR' => 152,
			'OP21_LIST_COMMA' => -81,
			'OP04_MATH_POW' => 158,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP13_BITWISE_AND' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 155
		}
	},
	{#State 383
		DEFAULT => -156
	},
	{#State 384
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 393
		}
	},
	{#State 385
		DEFAULT => -47
	},
	{#State 386
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 149,
			"}" => -189,
			'OP09_BITWISE_SHIFT' => 148,
			'OP17_LIST_RANGE' => 147,
			'OP23_LOGICAL_AND' => 150,
			'OP11_COMPARE_LT_GT' => 151,
			'OP21_LIST_COMMA' => -189,
			'OP16_LOGICAL_OR' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP13_BITWISE_AND' => 154,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP04_MATH_POW' => 158,
			'OP08_MATH_ADD_SUB' => 161,
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP15_LOGICAL_AND' => 163,
			'OP18_TERNARY' => 162,
			'OP14_BITWISE_OR_XOR' => 157
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
			'TYPE_SELF' => 394
		}
	},
	{#State 390
		ACTIONS => {
			'LBRACE' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP22_LOGICAL_NEG' => 122,
			'LBRACKET' => 120,
			'LPAREN' => 97,
			'OP19_LOOP_CONTROL' => 118,
			'OP01_NAMED' => 96,
			"foreach my" => -139,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_OPEN' => 91,
			"undef" => 90,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			"%{" => 112,
			"my" => 88,
			'WORD' => 28,
			'LITERAL_NUMBER' => 86,
			'OP01_PRINT' => 103,
			'VARIABLE_SYMBOL' => 104,
			"if" => 89,
			'OP10_NAMED_UNARY' => 105,
			"\@{" => 80,
			'LITERAL_STRING' => 79,
			"for my integer" => -139,
			'OP03_MATH_INC_DEC' => 78,
			'OP05_LOGICAL_NEG' => 77,
			'WORD_UPPERCASE' => 102,
			'OP01_NAMED_VOID' => 101,
			"while" => -139
		},
		GOTOS => {
			'HashDereferenced' => 119,
			'Conditional' => 121,
			'Operator' => 99,
			'OPTIONAL-35' => 100,
			'Variable' => 98,
			'VariableModification' => 117,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'Statement' => 94,
			'SubExpression' => 93,
			'Operation' => 395,
			'VariableDeclaration' => 109,
			'ArrayDereferenced' => 92,
			'OperatorVoid' => 107,
			'PLUS-27' => 396,
			'Literal' => 106,
			'PAREN-34' => 87,
			'LoopLabel' => 85,
			'WordScoped' => 83,
			'Expression' => 82
		}
	},
	{#State 391
		DEFAULT => -65
	},
	{#State 392
		ACTIONS => {
			'OP23_LOGICAL_AND' => 150,
			")" => 397,
			'OP11_COMPARE_LT_GT' => 151,
			'OP17_LIST_RANGE' => 147,
			'OP12_COMPARE_EQ_NE' => 149,
			'OP09_BITWISE_SHIFT' => 148,
			'OP06_REGEX_MATCH' => 160,
			'OP07_STRING_REPEAT' => 159,
			'OP08_STRING_CAT' => 156,
			'OP08_MATH_ADD_SUB' => 161,
			'OP14_BITWISE_OR_XOR' => 157,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 163,
			'OP16_LOGICAL_OR' => 152,
			'OP04_MATH_POW' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 155,
			'OP24_LOGICAL_OR_XOR' => 153,
			'OP13_BITWISE_AND' => 154
		}
	},
	{#State 393
		DEFAULT => -155
	},
	{#State 394
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 398
		}
	},
	{#State 395
		DEFAULT => -68
	},
	{#State 396
		ACTIONS => {
			"if" => 89,
			'LITERAL_NUMBER' => 86,
			'WORD' => 28,
			"my" => 88,
			"while" => -139,
			"for my integer" => -139,
			'OP05_LOGICAL_NEG' => 77,
			'OP03_MATH_INC_DEC' => 78,
			'LITERAL_STRING' => 79,
			"\@{" => 80,
			'OP01_NAMED' => 96,
			'LPAREN' => 97,
			'OP01_OPEN' => 91,
			"undef" => 90,
			"foreach my" => -139,
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT' => 103,
			'VARIABLE_SYMBOL' => 104,
			'OP01_NAMED_VOID' => 101,
			'WORD_UPPERCASE' => 102,
			'OP19_LOOP_CONTROL' => 118,
			'LBRACKET' => 120,
			'OP22_LOGICAL_NEG' => 122,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'LBRACE' => 114,
			"}" => 400,
			"%{" => 112,
			'OP01_CLOSE' => 113,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 110
		},
		GOTOS => {
			'Expression' => 82,
			'WordScoped' => 83,
			'PAREN-34' => 87,
			'LoopLabel' => 85,
			'OperatorVoid' => 107,
			'Literal' => 106,
			'VariableDeclaration' => 109,
			'ArrayDereferenced' => 92,
			'Statement' => 94,
			'Operation' => 399,
			'SubExpression' => 93,
			'HashReference' => 116,
			'ArrayReference' => 95,
			'VariableModification' => 117,
			'Conditional' => 121,
			'OPTIONAL-35' => 100,
			'Operator' => 99,
			'HashDereferenced' => 119,
			'Variable' => 98
		}
	},
	{#State 397
		ACTIONS => {
			'LBRACE' => 320
		},
		GOTOS => {
			'CodeBlock' => 401
		}
	},
	{#State 398
		ACTIONS => {
			")" => 403,
			'OP21_LIST_COMMA' => 402
		},
		GOTOS => {
			'PAREN-28' => 404
		}
	},
	{#State 399
		DEFAULT => -67
	},
	{#State 400
		ACTIONS => {
			";" => 405
		}
	},
	{#State 401
		DEFAULT => -145
	},
	{#State 402
		ACTIONS => {
			"my" => 406
		}
	},
	{#State 403
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 404
		DEFAULT => -71
	},
	{#State 405
		DEFAULT => -69
	},
	{#State 406
		ACTIONS => {
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 408
		}
	},
	{#State 407
		ACTIONS => {
			"\@_;" => 409
		}
	},
	{#State 408
		ACTIONS => {
			'VARIABLE_SYMBOL' => 410
		}
	},
	{#State 409
		DEFAULT => -73
	},
	{#State 410
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5753 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5760 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5767 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5774 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5785 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5796 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5803 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5810 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5859 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5866 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5880 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5898 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5905 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5927 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5938 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5945 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5952 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5973 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5980 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5994 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6005 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6016 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6041 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6048 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6066 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6077 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6088 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6095 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6102 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6109 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6116 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6127 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6134 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6141 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6240 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6247 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6269 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6276 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6283 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6290 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6297 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6315 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6322 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6329 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6351 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6362 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6373 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6384 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6395 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6406 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6428 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6439 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6450 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6461 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6472 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6483 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6494 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6505 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6516 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6527 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6538 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6549 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6560 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6571 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6593 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6604 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6615 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6637 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6648 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6659 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6670 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6692 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6703 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6710 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6735 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6746 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6757 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6768 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6779 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6790 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6801 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6808 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6815 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6822 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6895 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6906 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6917 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6928 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6939 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6950 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6961 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6972 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6983 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6994 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7037 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7048 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7059 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7070 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7081 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7088 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7095 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7102 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7109 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7116 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7134 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7145 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7156 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7167 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7200 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7214 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7232 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7239 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7250 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7261 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7272 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7283 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7294 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7305 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7316 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7334 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7341 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7348 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7355 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_176
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7373 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_177
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7384 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7395 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7406 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7413 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7420 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7431 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_183
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7442 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_184
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7453 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7460 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7467 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_187
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7478 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_188
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7489 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_189
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7500 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_190
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7511 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7518 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7525 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_194
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7543 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_195
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7554 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7565 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_197
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7576 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7587 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_199
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7598 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_200
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7609 lib/RPerl/Grammar.pm
	],
	[#Rule Type_201
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7620 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_202
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7631 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_203
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7642 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_204
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7653 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_205
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7664 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_206
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7675 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7686 lib/RPerl/Grammar.pm
	]
],
#line 7689 lib/RPerl/Grammar.pm
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


#line 7945 lib/RPerl/Grammar.pm



1;
