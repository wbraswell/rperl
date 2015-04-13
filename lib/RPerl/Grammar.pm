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
    our $VERSION = 0.000_992;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach|\=\ sub\ \{|\$TYPED_|package|while|elsif|undef|else|our|for|use|\@_\;|my|if|\%\{|\@\{|\;|\]|\}|\))}gc and return ($1, $1);

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
      /\G(sin|cos|push|pop|keys|values|sort|ETC)\s/gc and return ('OP01_NAMED', $1);
      /\G([a-z]\w*|[A-Z]\w*[a-z]\w*)/gc and return ('WORD', $1);
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
			'SHEBANG' => 4,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 1,
			'ModuleHeader' => 6,
			'Program' => 7,
			'OPTIONAL-9' => 8,
			'PAREN-1' => 3,
			'CompileUnit' => 9,
			'PLUS-2' => 5
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-14' => 10
		}
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => 2,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 12,
			'OPTIONAL-3' => 13
		}
	},
	{#State 5
		ACTIONS => {
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 1,
			'ModuleHeader' => 6,
			'OPTIONAL-9' => 8,
			'PAREN-1' => 14
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => -25,
			"our" => -25,
			"use constant" => -25,
			"use parent qw(" => 18,
			"use" => -25
		},
		GOTOS => {
			'Module' => 19,
			'STAR-10' => 16,
			'Class' => 17,
			'Package' => 15
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"package" => 20
		}
	},
	{#State 9
		ACTIONS => {
			'' => 21
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
		DEFAULT => -6
	},
	{#State 13
		ACTIONS => {
			"use strict;" => 24
		},
		GOTOS => {
			'Header' => 25
		}
	},
	{#State 14
		DEFAULT => -2
	},
	{#State 15
		DEFAULT => -22
	},
	{#State 16
		ACTIONS => {
			"use constant" => -27,
			"our" => -27,
			"## no critic qw(" => 2,
			"use" => -27
		},
		GOTOS => {
			'STAR-11' => 26,
			'Critic' => 27
		}
	},
	{#State 17
		DEFAULT => -23
	},
	{#State 18
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 19
		DEFAULT => -1
	},
	{#State 20
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 21
		DEFAULT => 0
	},
	{#State 22
		DEFAULT => -36
	},
	{#State 23
		DEFAULT => -34
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
			"use constant" => -29,
			"our" => -29,
			"use" => 35
		},
		GOTOS => {
			'STAR-12' => 34,
			'Include' => 36
		}
	},
	{#State 27
		DEFAULT => -24
	},
	{#State 28
		DEFAULT => -203
	},
	{#State 29
		ACTIONS => {
			")" => 37
		}
	},
	{#State 30
		DEFAULT => -202
	},
	{#State 31
		ACTIONS => {
			";" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			'LPAREN' => -11,
			"## no critic qw(" => 2,
			"%{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"use" => -11,
			'OP01_NAMED' => -11,
			"\@{" => -11,
			"foreach" => -11,
			'WORD' => -11,
			"my" => -11,
			'LBRACKET' => -11,
			"for" => -11,
			'LITERAL_NUMBER' => -11,
			'WORD_SCOPED' => -11,
			"if" => -11,
			'OP01_NAMED_VOID' => -11,
			'VARIABLE_SYMBOL' => -11,
			'WORD_UPPERCASE' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LITERAL_STRING' => -11,
			"our" => -11,
			"use constant" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"while" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_OPEN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_CLOSE' => -11,
			"undef" => -11,
			'OP01_PRINT' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LBRACE' => -11
		},
		GOTOS => {
			'Critic' => 40,
			'STAR-5' => 41
		}
	},
	{#State 34
		ACTIONS => {
			"our" => 42,
			"use constant" => 44
		},
		GOTOS => {
			'PLUS-13' => 46,
			'Constant' => 43,
			'Subroutine' => 45
		}
	},
	{#State 35
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 30
		},
		GOTOS => {
			'WordScoped' => 47
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			";" => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 24
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 40
		DEFAULT => -8
	},
	{#State 41
		ACTIONS => {
			'LBRACE' => -13,
			"undef" => -13,
			'OP01_PRINT' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_CLOSE' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"use constant" => -13,
			"our" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_OPEN' => -13,
			"while" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'WORD_UPPERCASE' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			'WORD_SCOPED' => -13,
			"if" => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD' => -13,
			"my" => -13,
			"for" => -13,
			'LITERAL_NUMBER' => -13,
			'LBRACKET' => -13,
			'LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"use" => 35,
			"foreach" => -13,
			'OP01_NAMED' => -13,
			"\@{" => -13
		},
		GOTOS => {
			'STAR-6' => 51,
			'Include' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 43
		DEFAULT => -28
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 56
		}
	},
	{#State 45
		DEFAULT => -31
	},
	{#State 46
		ACTIONS => {
			'LITERAL_NUMBER' => 57,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 47
		ACTIONS => {
			";" => 60,
			'OP01_QW' => 59
		}
	},
	{#State 48
		ACTIONS => {
			"use" => 35
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
			'VERSION_NUMBER_ASSIGN' => 62
		}
	},
	{#State 51
		ACTIONS => {
			'WORD' => -15,
			'LBRACKET' => -15,
			'LITERAL_NUMBER' => -15,
			"for" => -15,
			"my" => -15,
			"%{" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LPAREN' => -15,
			'OP01_NAMED' => -15,
			"\@{" => -15,
			"foreach" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'WORD_UPPERCASE' => -15,
			'LITERAL_STRING' => -15,
			'WORD_SCOPED' => -15,
			"if" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_CLOSE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"our" => -15,
			"use constant" => 44,
			"while" => -15,
			'OP01_OPEN' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LBRACE' => -15,
			'OP01_PRINT' => -15,
			"undef" => -15,
			'OP22_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'STAR-7' => 63,
			'Constant' => 64
		}
	},
	{#State 52
		DEFAULT => -10
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
			'WORD' => 68
		},
		GOTOS => {
			'PLUS-15' => 69
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
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'OP01_PRINT' => 101,
			'LBRACE' => 98,
			"while" => -139,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"our" => 42,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'OP01_NAMED_VOID' => 83,
			"if" => 81,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 72,
			'OP05_LOGICAL_NEG' => 73,
			'OP01_NAMED_VOID_SCOLON' => 71,
			'OP19_LOOP_CONTROL_SCOLON' => 96,
			"\@{" => 94,
			'OP01_NAMED' => 95,
			"foreach" => -139,
			'LPAREN' => 93,
			"%{" => 92,
			'OP19_LOOP_CONTROL' => 90,
			"my" => 89,
			'LBRACKET' => 88,
			"for" => -139,
			'LITERAL_NUMBER' => 86,
			'WORD' => 30
		},
		GOTOS => {
			'PLUS-8' => 85,
			'Statement' => 84,
			'Variable' => 109,
			'Conditional' => 107,
			'Operation' => 87,
			'VariableDeclaration' => 108,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'HashDereference' => 116,
			'WordScoped' => 97,
			'HashReference' => 75,
			'OPTIONAL-35' => 100,
			'OperatorVoid' => 99,
			'PAREN-34' => 76,
			'Subroutine' => 80,
			'SubExpression' => 82,
			'VariableModification' => 78,
			'LoopLabel' => 79,
			'Expression' => 104
		}
	},
	{#State 64
		DEFAULT => -12
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 117
		}
	},
	{#State 66
		ACTIONS => {
			"my" => 118
		},
		GOTOS => {
			'TypeInnerConstant' => 119
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		DEFAULT => -38
	},
	{#State 69
		ACTIONS => {
			")" => 121,
			'WORD' => 120
		}
	},
	{#State 70
		ACTIONS => {
			"our hash_ref \$properties" => -54,
			"use" => -54,
			"## no critic qw(" => 2,
			"use constant" => -54
		},
		GOTOS => {
			'Critic' => 123,
			'STAR-21' => 122
		}
	},
	{#State 71
		DEFAULT => -112
	},
	{#State 72
		ACTIONS => {
			'COLON' => -204,
			'LPAREN' => 124
		}
	},
	{#State 73
		ACTIONS => {
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93
		},
		GOTOS => {
			'HashDereference' => 116,
			'Expression' => 129,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayReference' => 91,
			'ArrayDereference' => 110,
			'SubExpression' => 126,
			'Variable' => 128,
			'HashReference' => 75,
			'WordScoped' => 97
		}
	},
	{#State 74
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 130
		}
	},
	{#State 75
		DEFAULT => -132
	},
	{#State 76
		DEFAULT => -138
	},
	{#State 77
		DEFAULT => -211
	},
	{#State 78
		DEFAULT => -144
	},
	{#State 79
		ACTIONS => {
			'COLON' => 131
		}
	},
	{#State 80
		DEFAULT => -14
	},
	{#State 81
		ACTIONS => {
			'LPAREN' => 132
		}
	},
	{#State 82
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => 138,
			'OP07_STRING_REPEAT' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP11_COMPARE_LT_GT' => 143,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136
		}
	},
	{#State 83
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			"my" => 151,
			'OP01_QW' => 154,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92
		},
		GOTOS => {
			'ListElement' => 152,
			'Variable' => 128,
			'TypeInner' => 150,
			'WordScoped' => 97,
			'HashReference' => 75,
			'ListElements' => 155,
			'Expression' => 129,
			'HashDereference' => 116,
			'SubExpression' => 153,
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112
		}
	},
	{#State 84
		DEFAULT => -77
	},
	{#State 85
		ACTIONS => {
			"foreach" => -139,
			'OP01_NAMED' => 95,
			"\@{" => 94,
			'OP19_LOOP_CONTROL_SCOLON' => 96,
			'OP19_LOOP_CONTROL' => 90,
			"%{" => 92,
			'LPAREN' => 93,
			'' => -18,
			"for" => -139,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			"my" => 89,
			'WORD' => 30,
			'OP01_NAMED_VOID' => 83,
			'WORD_SCOPED' => 28,
			"if" => 81,
			'LITERAL_STRING' => 77,
			'OP01_NAMED_VOID_SCOLON' => 71,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 72,
			'VARIABLE_SYMBOL' => 74,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'OP22_LOGICAL_NEG' => 103,
			'OP01_PRINT' => 101,
			"undef" => 102,
			'LBRACE' => 98
		},
		GOTOS => {
			'VariableModification' => 78,
			'LoopLabel' => 79,
			'SubExpression' => 82,
			'Expression' => 104,
			'WordScoped' => 97,
			'HashReference' => 75,
			'OperatorVoid' => 99,
			'PAREN-34' => 76,
			'OPTIONAL-35' => 100,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayReference' => 91,
			'HashDereference' => 116,
			'Statement' => 84,
			'Conditional' => 107,
			'Operation' => 156,
			'VariableDeclaration' => 108,
			'Variable' => 109
		}
	},
	{#State 86
		DEFAULT => -212
	},
	{#State 87
		DEFAULT => -17
	},
	{#State 88
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			"my" => 151,
			'OP01_QW' => 154,
			"]" => -181,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113
		},
		GOTOS => {
			'ListElements' => 158,
			'OPTIONAL-45' => 157,
			'TypeInner' => 150,
			'WordScoped' => 97,
			'HashReference' => 75,
			'ListElement' => 152,
			'Variable' => 128,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'SubExpression' => 153,
			'Expression' => 129,
			'HashDereference' => 116
		}
	},
	{#State 89
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 159
		}
	},
	{#State 90
		ACTIONS => {
			'WORD_UPPERCASE' => 160
		},
		GOTOS => {
			'LoopLabel' => 161
		}
	},
	{#State 91
		DEFAULT => -130
	},
	{#State 92
		ACTIONS => {
			'VARIABLE_SYMBOL' => 74,
			"my" => 151,
			'LBRACE' => -199
		},
		GOTOS => {
			'TypeInner' => 162,
			'OPTIONAL-50' => 164,
			'Variable' => 163
		}
	},
	{#State 93
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP01_PRINT' => 167,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			"\@{" => 94,
			'OP01_NAMED' => 165,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayReference' => 91,
			'SubExpression' => 166,
			'Expression' => 129,
			'HashDereference' => 116,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128
		}
	},
	{#State 94
		ACTIONS => {
			"my" => 151,
			'LBRACKET' => -184,
			'VARIABLE_SYMBOL' => 74
		},
		GOTOS => {
			'OPTIONAL-46' => 170,
			'Variable' => 169,
			'TypeInner' => 168
		}
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			'OP01_QW' => 154,
			"my" => 151,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114
		},
		GOTOS => {
			'Variable' => 128,
			'ListElement' => 171,
			'HashReference' => 75,
			'TypeInner' => 150,
			'WordScoped' => 97,
			'HashDereference' => 116,
			'Expression' => 129,
			'SubExpression' => 172,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayReference' => 91,
			'ArrayDereference' => 110
		}
	},
	{#State 96
		DEFAULT => -115
	},
	{#State 97
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 174,
			'LPAREN' => 173
		}
	},
	{#State 98
		ACTIONS => {
			"%{" => 92,
			'WORD' => 175,
			"}" => 176
		},
		GOTOS => {
			'HashEntry' => 177,
			'HashDereference' => 178
		}
	},
	{#State 99
		DEFAULT => -142
	},
	{#State 100
		ACTIONS => {
			"while" => 182,
			"foreach" => 179,
			"for" => 181
		},
		GOTOS => {
			'LoopFor' => 185,
			'LoopForEach' => 184,
			'LoopWhile' => 183,
			'Loop' => 180
		}
	},
	{#State 101
		ACTIONS => {
			'WORD_SCOPED' => -109,
			"undef" => -109,
			'STDOUT_STDERR' => 187,
			'OP22_LOGICAL_NEG' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'WORD_UPPERCASE' => -109,
			'VARIABLE_SYMBOL' => -109,
			'LITERAL_STRING' => -109,
			'LBRACE' => -109,
			'LPAREN' => -109,
			"%{" => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'FH_REF_SYMBOL_BRACES' => 186,
			'OP01_OPEN' => -109,
			'OP10_NAMED_UNARY' => -109,
			"\@{" => -109,
			'OP01_NAMED' => -109,
			'OP01_CLOSE' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'WORD' => -109,
			"my" => -109,
			'OP01_QW' => -109,
			'LITERAL_NUMBER' => -109,
			'LBRACKET' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 188,
			'PAREN-30' => 189
		}
	},
	{#State 102
		DEFAULT => -127
	},
	{#State 103
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'OP01_NAMED' => 125,
			"\@{" => 94
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'SubExpression' => 190,
			'HashDereference' => 116,
			'Expression' => 129,
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128
		}
	},
	{#State 104
		ACTIONS => {
			'OP15_LOGICAL_AND' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP04_MATH_POW' => -126,
			'OP08_STRING_CAT' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP18_TERNARY' => -126,
			'OP17_LIST_RANGE' => -126,
			";" => 191
		}
	},
	{#State 105
		ACTIONS => {
			'FH_REF_SYMBOL' => 192
		}
	},
	{#State 106
		ACTIONS => {
			'VARIABLE_SYMBOL' => 74
		},
		GOTOS => {
			'Variable' => 193
		}
	},
	{#State 107
		DEFAULT => -140
	},
	{#State 108
		DEFAULT => -143
	},
	{#State 109
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP04_MATH_POW' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP19_VARIABLE_ASSIGN' => 195,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP03_MATH_INC_DEC' => 194,
			'OP11_COMPARE_LT_GT' => -129,
			'OP02_METHOD_THINARROW' => 196,
			'OP19_VARIABLE_ASSIGN_BY' => 197,
			'OP13_BITWISE_AND' => -129,
			'OP06_REGEX_MATCH' => -129
		}
	},
	{#State 110
		DEFAULT => -131
	},
	{#State 111
		DEFAULT => -128
	},
	{#State 112
		DEFAULT => -121
	},
	{#State 113
		ACTIONS => {
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'Variable' => 128,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Expression' => 129,
			'HashDereference' => 116,
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112,
			'SubExpression' => 198
		}
	},
	{#State 114
		ACTIONS => {
			"my" => 199
		}
	},
	{#State 115
		ACTIONS => {
			'WORD' => 30,
			"]" => -95,
			'LBRACKET' => 88,
			"}" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP06_REGEX_MATCH' => -95,
			'LITERAL_NUMBER' => 86,
			'LPAREN' => 93,
			"%{" => 92,
			")" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP17_LIST_RANGE' => -95,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'OP09_BITWISE_SHIFT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 28,
			'OP23_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'OP11_COMPARE_LT_GT' => -95,
			";" => -95,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP21_LIST_COMMA' => -95,
			'OP18_TERNARY' => -95,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'OP08_STRING_CAT' => -95,
			'OP04_MATH_POW' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'LBRACE' => 98,
			'OP08_MATH_ADD_SUB' => -95,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'SubExpression' => 200,
			'HashDereference' => 116,
			'Expression' => 129
		}
	},
	{#State 116
		DEFAULT => -133
	},
	{#State 117
		ACTIONS => {
			'LBRACE' => -43,
			'LPAREN_MY' => 202,
			'OP22_LOGICAL_NEG' => -43,
			"undef" => -43,
			'OP01_PRINT' => -43,
			'OP01_CLOSE' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_OPEN' => -43,
			"while" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LITERAL_STRING' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'WORD_UPPERCASE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP01_NAMED_VOID' => -43,
			'WORD_SCOPED' => -43,
			"if" => -43,
			"my" => -43,
			"for" => -43,
			'LITERAL_NUMBER' => -43,
			'LBRACKET' => -43,
			"}" => -43,
			'WORD' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			"foreach" => -43,
			"\@{" => -43,
			'OP01_NAMED' => -43,
			'LPAREN' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"%{" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 203,
			'OPTIONAL-16' => 201
		}
	},
	{#State 118
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 119
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Literal' => 205
		}
	},
	{#State 120
		DEFAULT => -37
	},
	{#State 121
		ACTIONS => {
			";" => 206
		}
	},
	{#State 122
		ACTIONS => {
			"use constant" => -56,
			"use" => 35,
			"our hash_ref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 207,
			'Include' => 208
		}
	},
	{#State 123
		DEFAULT => -51
	},
	{#State 124
		ACTIONS => {
			")" => 209
		}
	},
	{#State 125
		ACTIONS => {
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74
		},
		GOTOS => {
			'Variable' => 128,
			'HashReference' => 75,
			'WordScoped' => 97,
			'HashDereference' => 116,
			'Expression' => 129,
			'SubExpression' => 210,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayDereference' => 110
		}
	},
	{#State 126
		ACTIONS => {
			'OP15_LOGICAL_AND' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP16_LOGICAL_OR' => -86,
			"]" => -86,
			"}" => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP18_TERNARY' => -86,
			";" => -86,
			'OP21_LIST_COMMA' => -86,
			")" => -86
		}
	},
	{#State 127
		ACTIONS => {
			'LPAREN' => 124
		}
	},
	{#State 128
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP08_STRING_CAT' => -129,
			'OP04_MATH_POW' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			";" => -129,
			")" => -129,
			'OP21_LIST_COMMA' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP03_MATH_INC_DEC' => 194,
			'OP11_COMPARE_LT_GT' => -129,
			'OP02_METHOD_THINARROW' => 196,
			"]" => -129,
			'OP13_BITWISE_AND' => -129,
			'OP06_REGEX_MATCH' => -129,
			"}" => -129
		}
	},
	{#State 129
		DEFAULT => -126
	},
	{#State 130
		ACTIONS => {
			";" => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			")" => -163,
			'OP21_LIST_COMMA' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP18_TERNARY' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP02_HASH_THINARROW' => 212,
			'OP11_COMPARE_LT_GT' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			"]" => -163,
			'OP13_BITWISE_AND' => -163,
			'OP06_REGEX_MATCH' => -163,
			"}" => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'COLON' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP08_STRING_CAT' => -163,
			'OP04_MATH_POW' => -163,
			'OP02_ARRAY_THINARROW' => 213,
			'OP15_LOGICAL_AND' => -163,
			'OP24_LOGICAL_OR_XOR' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 211
		}
	},
	{#State 131
		DEFAULT => -137
	},
	{#State 132
		ACTIONS => {
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LPAREN' => 93,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Variable' => 128,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Expression' => 129,
			'HashDereference' => 116,
			'SubExpression' => 214,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayReference' => 91
		}
	},
	{#State 133
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128,
			'ArrayDereference' => 110,
			'Literal' => 111,
			'ArrayReference' => 91,
			'Operator' => 112,
			'SubExpression' => 215,
			'Expression' => 129,
			'HashDereference' => 116
		}
	},
	{#State 134
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'Operator' => 112,
			'Literal' => 111,
			'ArrayReference' => 91,
			'ArrayDereference' => 110,
			'SubExpression' => 216,
			'HashDereference' => 116,
			'Expression' => 129,
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128
		}
	},
	{#State 135
		ACTIONS => {
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LPAREN' => 93,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128,
			'SubExpression' => 217,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'HashDereference' => 116,
			'Expression' => 129
		}
	},
	{#State 136
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 218
		}
	},
	{#State 137
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'SubExpression' => 219,
			'HashDereference' => 116,
			'Expression' => 129,
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128
		}
	},
	{#State 138
		ACTIONS => {
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'SubExpression' => 220,
			'Expression' => 129,
			'HashDereference' => 116,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128
		}
	},
	{#State 139
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105
		},
		GOTOS => {
			'Expression' => 129,
			'HashDereference' => 116,
			'ArrayDereference' => 110,
			'Literal' => 111,
			'ArrayReference' => 91,
			'Operator' => 112,
			'SubExpression' => 221,
			'Variable' => 128,
			'WordScoped' => 97,
			'HashReference' => 75
		}
	},
	{#State 140
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125
		},
		GOTOS => {
			'Variable' => 128,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Expression' => 129,
			'HashDereference' => 116,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'SubExpression' => 222
		}
	},
	{#State 141
		ACTIONS => {
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LPAREN' => 93,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'Variable' => 128,
			'HashReference' => 75,
			'WordScoped' => 97,
			'HashDereference' => 116,
			'Expression' => 129,
			'SubExpression' => 223,
			'Literal' => 111,
			'ArrayReference' => 91,
			'Operator' => 112,
			'ArrayDereference' => 110
		}
	},
	{#State 142
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 74
		},
		GOTOS => {
			'VariableOrLiteral' => 226,
			'Variable' => 224,
			'Literal' => 225
		}
	},
	{#State 143
		ACTIONS => {
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'Variable' => 128,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Expression' => 129,
			'HashDereference' => 116,
			'SubExpression' => 227,
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112
		}
	},
	{#State 144
		ACTIONS => {
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'OP01_NAMED' => 125,
			"\@{" => 94
		},
		GOTOS => {
			'HashDereference' => 116,
			'Expression' => 129,
			'SubExpression' => 228,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'Variable' => 128,
			'HashReference' => 75,
			'WordScoped' => 97
		}
	},
	{#State 145
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LPAREN' => 93,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105
		},
		GOTOS => {
			'Variable' => 128,
			'HashReference' => 75,
			'WordScoped' => 97,
			'HashDereference' => 116,
			'Expression' => 129,
			'SubExpression' => 229,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayReference' => 91,
			'ArrayDereference' => 110
		}
	},
	{#State 146
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30
		},
		GOTOS => {
			'Variable' => 128,
			'HashReference' => 75,
			'WordScoped' => 97,
			'HashDereference' => 116,
			'Expression' => 129,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'SubExpression' => 230
		}
	},
	{#State 147
		ACTIONS => {
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128,
			'SubExpression' => 231,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayReference' => 91,
			'Expression' => 129,
			'HashDereference' => 116
		}
	},
	{#State 148
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128,
			'ArrayDereference' => 110,
			'Literal' => 111,
			'ArrayReference' => 91,
			'Operator' => 112,
			'SubExpression' => 232,
			'Expression' => 129,
			'HashDereference' => 116
		}
	},
	{#State 149
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30
		},
		GOTOS => {
			'Variable' => 128,
			'HashReference' => 75,
			'WordScoped' => 97,
			'HashDereference' => 116,
			'Expression' => 129,
			'Literal' => 111,
			'ArrayReference' => 91,
			'Operator' => 112,
			'ArrayDereference' => 110,
			'SubExpression' => 233
		}
	},
	{#State 150
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'SubExpression' => 234,
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'Expression' => 129,
			'HashDereference' => 116,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128
		}
	},
	{#State 151
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 235
		}
	},
	{#State 152
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 236
		}
	},
	{#State 153
		ACTIONS => {
			";" => -177,
			")" => -177,
			'OP21_LIST_COMMA' => -177,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP11_COMPARE_LT_GT' => 143,
			"]" => -177,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => 138,
			'OP07_STRING_REPEAT' => 139,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149
		}
	},
	{#State 154
		ACTIONS => {
			'WORD' => 238
		},
		GOTOS => {
			'PLUS-44' => 237
		}
	},
	{#State 155
		ACTIONS => {
			";" => 239
		}
	},
	{#State 156
		DEFAULT => -16
	},
	{#State 157
		ACTIONS => {
			"]" => 240
		}
	},
	{#State 158
		DEFAULT => -180
	},
	{#State 159
		ACTIONS => {
			'VARIABLE_SYMBOL' => 241
		}
	},
	{#State 160
		DEFAULT => -204
	},
	{#State 161
		ACTIONS => {
			";" => 242
		}
	},
	{#State 162
		DEFAULT => -198
	},
	{#State 163
		ACTIONS => {
			"}" => 243
		}
	},
	{#State 164
		ACTIONS => {
			'LBRACE' => 98
		},
		GOTOS => {
			'HashReference' => 244
		}
	},
	{#State 165
		ACTIONS => {
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			"my" => 151,
			'OP01_QW' => 154,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98
		},
		GOTOS => {
			'Variable' => 128,
			'ListElement' => 245,
			'HashReference' => 75,
			'TypeInner' => 150,
			'WordScoped' => 97,
			'HashDereference' => 116,
			'Expression' => 129,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayDereference' => 110,
			'SubExpression' => 172
		}
	},
	{#State 166
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 143,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			")" => 246,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP15_LOGICAL_AND' => 148,
			'OP23_LOGICAL_AND' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP08_MATH_ADD_SUB' => 144,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 167
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 247
		}
	},
	{#State 168
		DEFAULT => -183
	},
	{#State 169
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 170
		ACTIONS => {
			'LBRACKET' => 88
		},
		GOTOS => {
			'ArrayReference' => 249
		}
	},
	{#State 171
		ACTIONS => {
			'OP21_LIST_COMMA' => 250
		}
	},
	{#State 172
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP04_MATH_POW' => -79,
			'OP08_STRING_CAT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP13_BITWISE_AND' => -79,
			";" => -79,
			")" => -79,
			'OP21_LIST_COMMA' => -177,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP17_LIST_RANGE' => -79
		}
	},
	{#State 173
		ACTIONS => {
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'LPAREN' => 93,
			")" => -118,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			"my" => 151,
			'OP01_QW' => 154,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88
		},
		GOTOS => {
			'Variable' => 128,
			'ListElement' => 152,
			'ListElements' => 251,
			'HashReference' => 75,
			'TypeInner' => 150,
			'WordScoped' => 97,
			'OPTIONAL-32' => 252,
			'HashDereference' => 116,
			'Expression' => 129,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'SubExpression' => 153
		}
	},
	{#State 174
		ACTIONS => {
			")" => 253
		}
	},
	{#State 175
		ACTIONS => {
			'OP20_HASH_FATARROW' => 254
		}
	},
	{#State 176
		DEFAULT => -197
	},
	{#State 177
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 255
		}
	},
	{#State 178
		DEFAULT => -190
	},
	{#State 179
		ACTIONS => {
			"my" => 256
		}
	},
	{#State 180
		DEFAULT => -141
	},
	{#State 181
		ACTIONS => {
			"my" => 257
		}
	},
	{#State 182
		ACTIONS => {
			'LPAREN' => 258
		}
	},
	{#State 183
		DEFAULT => -154
	},
	{#State 184
		DEFAULT => -153
	},
	{#State 185
		DEFAULT => -152
	},
	{#State 186
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			'OP01_QW' => 154,
			"my" => 151,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'ListElement' => 152,
			'Variable' => 128,
			'WordScoped' => 97,
			'TypeInner' => 150,
			'HashReference' => 75,
			'ListElements' => 259,
			'Expression' => 129,
			'HashDereference' => 116,
			'SubExpression' => 153,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayReference' => 91
		}
	},
	{#State 187
		DEFAULT => -107
	},
	{#State 188
		ACTIONS => {
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_QW' => 154,
			"my" => 151,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102
		},
		GOTOS => {
			'ListElements' => 260,
			'HashReference' => 75,
			'WordScoped' => 97,
			'TypeInner' => 150,
			'Variable' => 128,
			'ListElement' => 152,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayReference' => 91,
			'ArrayDereference' => 110,
			'SubExpression' => 153,
			'HashDereference' => 116,
			'Expression' => 129
		}
	},
	{#State 189
		DEFAULT => -108
	},
	{#State 190
		ACTIONS => {
			'OP07_STRING_REPEAT' => 139,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => -104,
			'OP08_MATH_ADD_SUB' => 144,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP15_LOGICAL_AND' => 148,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP14_BITWISE_OR_XOR' => 133,
			")" => -104,
			'OP21_LIST_COMMA' => -104,
			";" => -104,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			"}" => -104,
			"]" => -104,
			'OP11_COMPARE_LT_GT' => 143
		}
	},
	{#State 191
		DEFAULT => -76
	},
	{#State 192
		DEFAULT => -82
	},
	{#State 193
		DEFAULT => -83
	},
	{#State 194
		DEFAULT => -84
	},
	{#State 195
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LITERAL_STRING' => 77,
			'STDIN' => 261,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'HashReference' => 75,
			'WordScoped' => 97,
			'SubExpressionOrStdin' => 263,
			'Variable' => 128,
			'SubExpression' => 262,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayDereference' => 110,
			'HashDereference' => 116,
			'Expression' => 129
		}
	},
	{#State 196
		ACTIONS => {
			'LPAREN' => 264
		}
	},
	{#State 197
		ACTIONS => {
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88
		},
		GOTOS => {
			'SubExpression' => 265,
			'Literal' => 111,
			'ArrayReference' => 91,
			'Operator' => 112,
			'ArrayDereference' => 110,
			'HashDereference' => 116,
			'Expression' => 129,
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128
		}
	},
	{#State 198
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 143,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			")" => 266,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP18_TERNARY' => 142,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => 138,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 199
		ACTIONS => {
			"filehandle_ref" => 267
		}
	},
	{#State 200
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -94,
			"]" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP06_REGEX_MATCH' => 136,
			"}" => -94,
			";" => -94,
			")" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP18_TERNARY' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 201
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 268
		}
	},
	{#State 202
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 269
		}
	},
	{#State 203
		DEFAULT => -42
	},
	{#State 204
		ACTIONS => {
			"\$TYPED_" => 270
		}
	},
	{#State 205
		ACTIONS => {
			";" => 271
		}
	},
	{#State 206
		DEFAULT => -40
	},
	{#State 207
		ACTIONS => {
			"our hash_ref \$properties" => 273,
			"use constant" => 44
		},
		GOTOS => {
			'Constant' => 274,
			'Properties' => 272
		}
	},
	{#State 208
		DEFAULT => -53
	},
	{#State 209
		DEFAULT => -123
	},
	{#State 210
		ACTIONS => {
			'OP15_LOGICAL_AND' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP08_STRING_CAT' => -79,
			'OP04_MATH_POW' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP23_LOGICAL_AND' => -79,
			"]" => -79,
			'OP13_BITWISE_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			"}" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP18_TERNARY' => -79,
			";" => -79,
			")" => -79,
			'OP21_LIST_COMMA' => -79
		}
	},
	{#State 211
		DEFAULT => -161
	},
	{#State 212
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 276,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113
		},
		GOTOS => {
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayDereference' => 110,
			'SubExpression' => 275,
			'HashDereference' => 116,
			'Expression' => 129
		}
	},
	{#State 213
		ACTIONS => {
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'SubExpression' => 277,
			'ArrayDereference' => 110,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Expression' => 129,
			'HashDereference' => 116,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128
		}
	},
	{#State 214
		ACTIONS => {
			'OP07_STRING_REPEAT' => 139,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => 138,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP18_TERNARY' => 142,
			")" => 278,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP11_COMPARE_LT_GT' => 143
		}
	},
	{#State 215
		ACTIONS => {
			")" => -99,
			'OP21_LIST_COMMA' => -99,
			";" => -99,
			'OP18_TERNARY' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP11_COMPARE_LT_GT' => 143,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			"}" => -99,
			"]" => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP08_MATH_ADD_SUB' => 144,
			'OP07_STRING_REPEAT' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99
		}
	},
	{#State 216
		ACTIONS => {
			'OP07_STRING_REPEAT' => 139,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 144,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP15_LOGICAL_AND' => 148,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => 133,
			")" => -102,
			'OP21_LIST_COMMA' => -102,
			";" => -102,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			"}" => -102,
			"]" => -102,
			'OP11_COMPARE_LT_GT' => 143
		}
	},
	{#State 217
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 143,
			"]" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP06_REGEX_MATCH' => 136,
			"}" => -98,
			";" => -98,
			")" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP15_LOGICAL_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 218
		DEFAULT => -88
	},
	{#State 219
		ACTIONS => {
			'OP07_STRING_REPEAT' => 139,
			'OP23_LOGICAL_AND' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP08_MATH_ADD_SUB' => 144,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP15_LOGICAL_AND' => 148,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP18_TERNARY' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP21_LIST_COMMA' => -101,
			")" => -101,
			";" => -101,
			"}" => -101,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			"]" => -101,
			'OP11_COMPARE_LT_GT' => 143
		}
	},
	{#State 220
		ACTIONS => {
			'OP23_LOGICAL_AND' => -105,
			'OP16_LOGICAL_OR' => 137,
			'OP08_MATH_ADD_SUB' => 144,
			'OP07_STRING_REPEAT' => 139,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP15_LOGICAL_AND' => 148,
			'OP21_LIST_COMMA' => -105,
			")" => -105,
			";" => -105,
			'OP17_LIST_RANGE' => 134,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP11_COMPARE_LT_GT' => 143,
			"}" => -105,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			"]" => -105
		}
	},
	{#State 221
		ACTIONS => {
			'OP16_LOGICAL_OR' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP15_LOGICAL_AND' => -89,
			")" => -89,
			'OP21_LIST_COMMA' => -89,
			";" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP18_TERNARY' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => -89,
			"}" => -89,
			"]" => -89
		}
	},
	{#State 222
		ACTIONS => {
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP08_MATH_ADD_SUB' => 144,
			'OP07_STRING_REPEAT' => 139,
			'OP11_COMPARE_LT_GT' => -93,
			"}" => -93,
			'OP13_BITWISE_AND' => -93,
			'OP06_REGEX_MATCH' => 136,
			"]" => -93,
			'OP21_LIST_COMMA' => -93,
			")" => -93,
			";" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP18_TERNARY' => -93,
			'OP14_BITWISE_OR_XOR' => -93
		}
	},
	{#State 223
		ACTIONS => {
			'OP08_STRING_CAT' => -90,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP07_STRING_REPEAT' => 139,
			'OP11_COMPARE_LT_GT' => -90,
			"}" => -90,
			'OP13_BITWISE_AND' => -90,
			'OP06_REGEX_MATCH' => 136,
			"]" => -90,
			'OP21_LIST_COMMA' => -90,
			")" => -90,
			";" => -90,
			'OP17_LIST_RANGE' => -90,
			'OP18_TERNARY' => -90,
			'OP14_BITWISE_OR_XOR' => -90
		}
	},
	{#State 224
		DEFAULT => -209
	},
	{#State 225
		DEFAULT => -210
	},
	{#State 226
		ACTIONS => {
			'COLON' => 279
		}
	},
	{#State 227
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 140,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP07_STRING_REPEAT' => 139,
			'OP11_COMPARE_LT_GT' => undef,
			"]" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP06_REGEX_MATCH' => 136,
			"}" => -96,
			";" => -96,
			")" => -96,
			'OP21_LIST_COMMA' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP18_TERNARY' => -96
		}
	},
	{#State 228
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP09_BITWISE_SHIFT' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP07_STRING_REPEAT' => 139,
			'OP11_COMPARE_LT_GT' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP06_REGEX_MATCH' => 136,
			"}" => -91,
			"]" => -91,
			")" => -91,
			'OP21_LIST_COMMA' => -91,
			";" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP18_TERNARY' => -91,
			'OP14_BITWISE_OR_XOR' => -91
		}
	},
	{#State 229
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => undef,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP08_MATH_ADD_SUB' => 144,
			'OP07_STRING_REPEAT' => 139,
			'OP11_COMPARE_LT_GT' => 143,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => -97,
			"}" => -97,
			"]" => -97,
			")" => -97,
			'OP21_LIST_COMMA' => -97,
			";" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP18_TERNARY' => -97,
			'OP14_BITWISE_OR_XOR' => -97
		}
	},
	{#State 230
		ACTIONS => {
			'OP15_LOGICAL_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP16_LOGICAL_OR' => -85,
			"]" => -85,
			"}" => -85,
			'OP13_BITWISE_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP18_TERNARY' => -85,
			'OP17_LIST_RANGE' => -85,
			";" => -85,
			'OP21_LIST_COMMA' => -85,
			")" => -85
		}
	},
	{#State 231
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP07_STRING_REPEAT' => 139,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP09_BITWISE_SHIFT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			";" => -92,
			")" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			"]" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP06_REGEX_MATCH' => 136,
			"}" => -92
		}
	},
	{#State 232
		ACTIONS => {
			'OP17_LIST_RANGE' => -100,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => 133,
			")" => -100,
			'OP21_LIST_COMMA' => -100,
			";" => -100,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			"}" => -100,
			"]" => -100,
			'OP11_COMPARE_LT_GT' => 143,
			'OP07_STRING_REPEAT' => 139,
			'OP16_LOGICAL_OR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 144,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146
		}
	},
	{#State 233
		ACTIONS => {
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => 144,
			'OP23_LOGICAL_AND' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP07_STRING_REPEAT' => 139,
			'OP11_COMPARE_LT_GT' => 143,
			"]" => -106,
			"}" => -106,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			";" => -106,
			'OP21_LIST_COMMA' => -106,
			")" => -106,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP18_TERNARY' => 142
		}
	},
	{#State 234
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 143,
			"]" => -178,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			";" => -178,
			'OP21_LIST_COMMA' => -178,
			")" => -178,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP08_MATH_ADD_SUB' => 144,
			'OP23_LOGICAL_AND' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 235
		ACTIONS => {
			"\$TYPED_" => 280
		}
	},
	{#State 236
		ACTIONS => {
			")" => -174,
			'OP21_LIST_COMMA' => 281,
			";" => -174,
			"]" => -174
		},
		GOTOS => {
			'PAREN-42' => 282
		}
	},
	{#State 237
		ACTIONS => {
			'WORD' => 283,
			")" => 284
		}
	},
	{#State 238
		DEFAULT => -176
	},
	{#State 239
		DEFAULT => -113
	},
	{#State 240
		DEFAULT => -182
	},
	{#State 241
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 285,
			";" => 286
		}
	},
	{#State 242
		DEFAULT => -116
	},
	{#State 243
		DEFAULT => -200
	},
	{#State 244
		ACTIONS => {
			"}" => 287
		}
	},
	{#State 245
		ACTIONS => {
			'OP21_LIST_COMMA' => 288
		}
	},
	{#State 246
		DEFAULT => -134
	},
	{#State 247
		ACTIONS => {
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_QW' => 154,
			"my" => 151,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93
		},
		GOTOS => {
			'SubExpression' => 153,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'HashDereference' => 116,
			'Expression' => 129,
			'HashReference' => 75,
			'TypeInner' => 150,
			'WordScoped' => 97,
			'ListElements' => 289,
			'Variable' => 128,
			'ListElement' => 152
		}
	},
	{#State 248
		DEFAULT => -185
	},
	{#State 249
		ACTIONS => {
			"}" => 290
		}
	},
	{#State 250
		ACTIONS => {
			'OP01_QW' => 154,
			"my" => 151,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'Expression' => 129,
			'HashDereference' => 116,
			'SubExpression' => 153,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'ListElement' => 152,
			'Variable' => 128,
			'TypeInner' => 150,
			'WordScoped' => 97,
			'HashReference' => 75,
			'ListElements' => 291
		}
	},
	{#State 251
		DEFAULT => -117
	},
	{#State 252
		ACTIONS => {
			")" => 292
		}
	},
	{#State 253
		DEFAULT => -125
	},
	{#State 254
		ACTIONS => {
			'WORD' => -188,
			'OP01_CLOSE' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'LITERAL_NUMBER' => -188,
			'LBRACKET' => -188,
			"my" => 151,
			"%{" => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'LPAREN' => -188,
			'OP10_NAMED_UNARY' => -188,
			'OP01_OPEN' => -188,
			'OP01_NAMED' => -188,
			"\@{" => -188,
			'OP05_LOGICAL_NEG' => -188,
			'WORD_UPPERCASE' => -188,
			'VARIABLE_SYMBOL' => -188,
			'LBRACE' => -188,
			'LITERAL_STRING' => -188,
			'WORD_SCOPED' => -188,
			"undef" => -188,
			'OP22_LOGICAL_NEG' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 293,
			'TypeInner' => 294
		}
	},
	{#State 255
		ACTIONS => {
			"}" => 296,
			'OP21_LIST_COMMA' => 295
		},
		GOTOS => {
			'PAREN-48' => 297
		}
	},
	{#State 256
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 298
		}
	},
	{#State 257
		ACTIONS => {
			'TYPE_INTEGER' => 299
		}
	},
	{#State 258
		ACTIONS => {
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LPAREN' => 93,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128,
			'SubExpression' => 300,
			'ArrayDereference' => 110,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Expression' => 129,
			'HashDereference' => 116
		}
	},
	{#State 259
		ACTIONS => {
			";" => 301
		}
	},
	{#State 260
		ACTIONS => {
			";" => 302
		}
	},
	{#State 261
		DEFAULT => -136
	},
	{#State 262
		ACTIONS => {
			'OP07_STRING_REPEAT' => 139,
			'OP08_MATH_ADD_SUB' => 144,
			'OP23_LOGICAL_AND' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			";" => -135,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP11_COMPARE_LT_GT' => 143
		}
	},
	{#State 263
		ACTIONS => {
			";" => 303
		}
	},
	{#State 264
		ACTIONS => {
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			")" => -120,
			'LPAREN' => 93,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_QW' => 154,
			"my" => 151,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'HashReference' => 75,
			'WordScoped' => 97,
			'TypeInner' => 150,
			'ListElements' => 305,
			'Variable' => 128,
			'ListElement' => 152,
			'SubExpression' => 153,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'ArrayDereference' => 110,
			'HashDereference' => 116,
			'OPTIONAL-33' => 304,
			'Expression' => 129
		}
	},
	{#State 265
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP15_LOGICAL_AND' => 148,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => 138,
			'OP08_MATH_ADD_SUB' => 144,
			'OP07_STRING_REPEAT' => 139,
			'OP11_COMPARE_LT_GT' => 143,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			";" => 306,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP14_BITWISE_OR_XOR' => 133
		}
	},
	{#State 266
		DEFAULT => -87
	},
	{#State 267
		ACTIONS => {
			'FH_REF_SYMBOL' => 307
		}
	},
	{#State 268
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'OP01_PRINT' => 101,
			'LBRACE' => 98,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_NAMED_VOID' => 83,
			"if" => 81,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 72,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP01_NAMED_VOID_SCOLON' => 71,
			'OP19_LOOP_CONTROL_SCOLON' => 96,
			"foreach" => -139,
			"\@{" => 94,
			'OP01_NAMED' => 95,
			'LPAREN' => 93,
			'OP19_LOOP_CONTROL' => 90,
			"%{" => 92,
			"my" => 89,
			"for" => -139,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			"}" => 309,
			'WORD' => 30
		},
		GOTOS => {
			'Conditional' => 107,
			'Operation' => 308,
			'VariableDeclaration' => 108,
			'Variable' => 109,
			'Statement' => 84,
			'HashDereference' => 116,
			'ArrayDereference' => 110,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Literal' => 111,
			'OperatorVoid' => 99,
			'PAREN-34' => 76,
			'OPTIONAL-35' => 100,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Expression' => 104,
			'VariableModification' => 78,
			'LoopLabel' => 79,
			'SubExpression' => 82
		}
	},
	{#State 269
		ACTIONS => {
			'VARIABLE_SYMBOL' => 310
		}
	},
	{#State 270
		ACTIONS => {
			'WORD_UPPERCASE' => 311
		}
	},
	{#State 271
		DEFAULT => -41
	},
	{#State 272
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 312
		}
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 313
		}
	},
	{#State 274
		DEFAULT => -55
	},
	{#State 275
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 143,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			"}" => 314,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP15_LOGICAL_AND' => 148,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => 138,
			'OP08_MATH_ADD_SUB' => 144,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 276
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -202,
			'LPAREN' => -202,
			"}" => 315
		}
	},
	{#State 277
		ACTIONS => {
			"]" => 316,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			'OP11_COMPARE_LT_GT' => 143,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_STRING_REPEAT' => 139,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => 138
		}
	},
	{#State 278
		ACTIONS => {
			'LBRACE' => 317
		},
		GOTOS => {
			'CodeBlock' => 318
		}
	},
	{#State 279
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 74
		},
		GOTOS => {
			'Literal' => 225,
			'Variable' => 224,
			'VariableOrLiteral' => 319
		}
	},
	{#State 280
		ACTIONS => {
			'WORD' => 320
		}
	},
	{#State 281
		ACTIONS => {
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LPAREN' => 93,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP01_QW' => 154,
			"my" => 151,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127
		},
		GOTOS => {
			'TypeInner' => 150,
			'WordScoped' => 97,
			'HashReference' => 75,
			'ListElement' => 321,
			'Variable' => 128,
			'SubExpression' => 153,
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112,
			'Expression' => 129,
			'HashDereference' => 116
		}
	},
	{#State 282
		DEFAULT => -172
	},
	{#State 283
		DEFAULT => -175
	},
	{#State 284
		DEFAULT => -179
	},
	{#State 285
		ACTIONS => {
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'STDIN' => 261,
			'LBRACE' => 98,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112,
			'SubExpression' => 262,
			'Expression' => 129,
			'HashDereference' => 116,
			'SubExpressionOrStdin' => 322,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128
		}
	},
	{#State 286
		DEFAULT => -167
	},
	{#State 287
		DEFAULT => -201
	},
	{#State 288
		ACTIONS => {
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'WORD' => 30,
			'OP01_QW' => 154,
			"my" => 151,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98
		},
		GOTOS => {
			'Variable' => 128,
			'ListElement' => 152,
			'ListElements' => 323,
			'HashReference' => 75,
			'TypeInner' => 150,
			'WordScoped' => 97,
			'HashDereference' => 116,
			'Expression' => 129,
			'ArrayReference' => 91,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayDereference' => 110,
			'SubExpression' => 153
		}
	},
	{#State 289
		ACTIONS => {
			")" => 324
		}
	},
	{#State 290
		DEFAULT => -186
	},
	{#State 291
		ACTIONS => {
			";" => 325
		}
	},
	{#State 292
		DEFAULT => -122
	},
	{#State 293
		ACTIONS => {
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LPAREN' => 93,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'VARIABLE_SYMBOL' => 74,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'Literal' => 111,
			'ArrayReference' => 91,
			'Operator' => 112,
			'SubExpression' => 326,
			'Expression' => 129,
			'HashDereference' => 116,
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128
		}
	},
	{#State 294
		DEFAULT => -187
	},
	{#State 295
		ACTIONS => {
			'WORD' => 175,
			"%{" => 92
		},
		GOTOS => {
			'HashEntry' => 327,
			'HashDereference' => 178
		}
	},
	{#State 296
		DEFAULT => -196
	},
	{#State 297
		DEFAULT => -194
	},
	{#State 298
		ACTIONS => {
			'VARIABLE_SYMBOL' => 328
		}
	},
	{#State 299
		ACTIONS => {
			'VARIABLE_SYMBOL' => 329
		}
	},
	{#State 300
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			")" => 330,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			'OP11_COMPARE_LT_GT' => 143,
			'OP07_STRING_REPEAT' => 139,
			'OP08_MATH_ADD_SUB' => 144,
			'OP23_LOGICAL_AND' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP09_BITWISE_SHIFT' => 140,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 141
		}
	},
	{#State 301
		DEFAULT => -111
	},
	{#State 302
		DEFAULT => -110
	},
	{#State 303
		DEFAULT => -169
	},
	{#State 304
		ACTIONS => {
			")" => 331
		}
	},
	{#State 305
		DEFAULT => -119
	},
	{#State 306
		DEFAULT => -170
	},
	{#State 307
		ACTIONS => {
			'OP21_LIST_COMMA' => 332
		}
	},
	{#State 308
		DEFAULT => -44
	},
	{#State 309
		ACTIONS => {
			";" => 333
		}
	},
	{#State 310
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 334
		}
	},
	{#State 311
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 335
		}
	},
	{#State 312
		ACTIONS => {
			"our" => 336,
			'LITERAL_NUMBER' => 340
		},
		GOTOS => {
			'MethodOrSubroutine' => 338,
			'Subroutine' => 339,
			'Method' => 337
		}
	},
	{#State 313
		ACTIONS => {
			'LBRACE' => 341
		}
	},
	{#State 314
		DEFAULT => -165
	},
	{#State 315
		DEFAULT => -166
	},
	{#State 316
		DEFAULT => -164
	},
	{#State 317
		ACTIONS => {
			'OP01_NAMED_VOID' => 83,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			"if" => 81,
			'WORD_SCOPED' => 28,
			'OP01_PRINT' => 101,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_UPPERCASE' => 72,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP01_NAMED_VOID_SCOLON' => 71,
			'OP19_LOOP_CONTROL_SCOLON' => 96,
			"foreach" => -139,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"while" => -139,
			"\@{" => 94,
			'OP01_NAMED' => 95,
			'LPAREN' => 93,
			'OP19_LOOP_CONTROL' => 90,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			"my" => 89,
			'LITERAL_NUMBER' => 86,
			"for" => -139,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30
		},
		GOTOS => {
			'HashReference' => 75,
			'WordScoped' => 97,
			'OPTIONAL-35' => 100,
			'PAREN-34' => 76,
			'OperatorVoid' => 99,
			'PLUS-40' => 343,
			'SubExpression' => 82,
			'LoopLabel' => 79,
			'VariableModification' => 78,
			'Expression' => 104,
			'Statement' => 84,
			'Variable' => 109,
			'VariableDeclaration' => 108,
			'Operation' => 342,
			'Conditional' => 107,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayReference' => 91,
			'ArrayDereference' => 110,
			'HashDereference' => 116
		}
	},
	{#State 318
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 344
		}
	},
	{#State 319
		DEFAULT => -103
	},
	{#State 320
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 345
		}
	},
	{#State 321
		DEFAULT => -171
	},
	{#State 322
		ACTIONS => {
			";" => 346
		}
	},
	{#State 323
		ACTIONS => {
			")" => 347
		}
	},
	{#State 324
		DEFAULT => -78
	},
	{#State 325
		DEFAULT => -114
	},
	{#State 326
		ACTIONS => {
			'OP07_STRING_REPEAT' => 139,
			'OP08_MATH_ADD_SUB' => 144,
			'OP23_LOGICAL_AND' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP18_TERNARY' => 142,
			'OP21_LIST_COMMA' => -189,
			"}" => -189,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP11_COMPARE_LT_GT' => 143
		}
	},
	{#State 327
		DEFAULT => -193
	},
	{#State 328
		ACTIONS => {
			'LPAREN' => 348
		}
	},
	{#State 329
		ACTIONS => {
			'LPAREN' => 349
		}
	},
	{#State 330
		ACTIONS => {
			'LBRACE' => 317
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 331
		DEFAULT => -124
	},
	{#State 332
		ACTIONS => {
			'LITERAL_STRING' => 351
		}
	},
	{#State 333
		DEFAULT => -46
	},
	{#State 334
		ACTIONS => {
			'OP21_LIST_COMMA' => 352,
			")" => 353
		},
		GOTOS => {
			'PAREN-18' => 354
		}
	},
	{#State 335
		DEFAULT => -208
	},
	{#State 336
		ACTIONS => {
			'WORD' => 53,
			'TYPE_METHOD' => 355,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 337
		DEFAULT => -74
	},
	{#State 338
		DEFAULT => -57
	},
	{#State 339
		DEFAULT => -75
	},
	{#State 340
		ACTIONS => {
			";" => 356
		}
	},
	{#State 341
		ACTIONS => {
			"%{" => 92,
			'WORD' => 360,
			"}" => 359
		},
		GOTOS => {
			'HashDereference' => 358,
			'HashEntryTyped' => 357
		}
	},
	{#State 342
		DEFAULT => -159
	},
	{#State 343
		ACTIONS => {
			'OP01_PRINT' => 101,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACE' => 98,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"while" => -139,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD_SCOPED' => 28,
			"if" => 81,
			'OP01_NAMED_VOID' => 83,
			'OP01_NAMED_VOID_SCOLON' => 71,
			'WORD_UPPERCASE' => 72,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'LITERAL_STRING' => 77,
			'OP19_LOOP_CONTROL' => 90,
			"%{" => 92,
			'LPAREN' => 93,
			"foreach" => -139,
			'OP01_NAMED' => 95,
			"\@{" => 94,
			'OP19_LOOP_CONTROL_SCOLON' => 96,
			'WORD' => 30,
			"for" => -139,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			"}" => 361,
			"my" => 89
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 75,
			'OPTIONAL-35' => 100,
			'OperatorVoid' => 99,
			'PAREN-34' => 76,
			'SubExpression' => 82,
			'VariableModification' => 78,
			'LoopLabel' => 79,
			'Expression' => 104,
			'Statement' => 84,
			'Variable' => 109,
			'Operation' => 362,
			'Conditional' => 107,
			'VariableDeclaration' => 108,
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'HashDereference' => 116
		}
	},
	{#State 344
		ACTIONS => {
			"else" => 363,
			'OP03_MATH_INC_DEC' => -150,
			'OP01_CLOSE' => -150,
			"while" => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP01_OPEN' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'LBRACE' => -150,
			"elsif" => 365,
			'OP22_LOGICAL_NEG' => -150,
			"undef" => -150,
			'OP01_PRINT' => -150,
			"my" => -150,
			"}" => -150,
			'LBRACKET' => -150,
			"for" => -150,
			'LITERAL_NUMBER' => -150,
			'' => -150,
			'WORD' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			"\@{" => -150,
			'OP01_NAMED' => -150,
			"foreach" => -150,
			'LPAREN' => -150,
			"%{" => -150,
			'OP19_LOOP_CONTROL' => -150,
			'LITERAL_STRING' => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP05_LOGICAL_NEG' => -150,
			'WORD_UPPERCASE' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP01_NAMED_VOID' => -150,
			'WORD_SCOPED' => -150,
			"if" => -150
		},
		GOTOS => {
			'OPTIONAL-39' => 364,
			'PAREN-36' => 367,
			'PAREN-38' => 366
		}
	},
	{#State 345
		DEFAULT => -207
	},
	{#State 346
		DEFAULT => -168
	},
	{#State 347
		DEFAULT => -80
	},
	{#State 348
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'LPAREN' => 93,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			"my" => 151,
			'OP01_QW' => 154,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30
		},
		GOTOS => {
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'SubExpression' => 153,
			'Expression' => 129,
			'HashDereference' => 116,
			'ListElements' => 368,
			'WordScoped' => 97,
			'TypeInner' => 150,
			'HashReference' => 75,
			'ListElement' => 152,
			'Variable' => 128
		}
	},
	{#State 349
		ACTIONS => {
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'OP22_LOGICAL_NEG' => 103,
			'VARIABLE_SYMBOL' => 74,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			"%{" => 92,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LPAREN' => 93,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'WORD' => 30,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_CLOSE' => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Expression' => 129,
			'HashDereference' => 116,
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'SubExpression' => 369,
			'Variable' => 128,
			'WordScoped' => 97,
			'HashReference' => 75
		}
	},
	{#State 350
		DEFAULT => -157
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 370
		}
	},
	{#State 352
		ACTIONS => {
			"my" => 371
		}
	},
	{#State 353
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 372
		}
	},
	{#State 354
		DEFAULT => -48
	},
	{#State 355
		ACTIONS => {
			'VARIABLE_SYMBOL' => 373
		}
	},
	{#State 356
		DEFAULT => -59
	},
	{#State 357
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 374
		}
	},
	{#State 358
		DEFAULT => -192
	},
	{#State 359
		ACTIONS => {
			";" => 375
		}
	},
	{#State 360
		ACTIONS => {
			'OP20_HASH_FATARROW' => 376
		}
	},
	{#State 361
		DEFAULT => -160
	},
	{#State 362
		DEFAULT => -158
	},
	{#State 363
		ACTIONS => {
			'LBRACE' => 317
		},
		GOTOS => {
			'CodeBlock' => 377
		}
	},
	{#State 364
		DEFAULT => -151
	},
	{#State 365
		ACTIONS => {
			'LPAREN' => 378
		}
	},
	{#State 366
		DEFAULT => -149
	},
	{#State 367
		DEFAULT => -146
	},
	{#State 368
		ACTIONS => {
			")" => 379
		}
	},
	{#State 369
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP15_LOGICAL_AND' => 148,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP07_STRING_REPEAT' => 139,
			'OP23_LOGICAL_AND' => 138,
			'OP16_LOGICAL_OR' => 137,
			'OP08_MATH_ADD_SUB' => 144,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			'OP11_COMPARE_LT_GT' => 143,
			'OP17_LIST_RANGE' => 380,
			'OP18_TERNARY' => 142,
			'OP14_BITWISE_OR_XOR' => 133
		}
	},
	{#State 370
		ACTIONS => {
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 28,
			"undef" => 102,
			'OP22_LOGICAL_NEG' => 103,
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125
		},
		GOTOS => {
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128,
			'Operator' => 112,
			'Literal' => 111,
			'ArrayReference' => 91,
			'ArrayDereference' => 110,
			'SubExpression' => 381,
			'HashDereference' => 116,
			'Expression' => 129
		}
	},
	{#State 371
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 382
		}
	},
	{#State 372
		ACTIONS => {
			"\@_;" => 383
		}
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 384
		}
	},
	{#State 374
		ACTIONS => {
			'OP21_LIST_COMMA' => 387,
			"}" => 386
		},
		GOTOS => {
			'PAREN-24' => 385
		}
	},
	{#State 375
		DEFAULT => -64
	},
	{#State 376
		ACTIONS => {
			"my" => 151
		},
		GOTOS => {
			'TypeInner' => 388
		}
	},
	{#State 377
		DEFAULT => -148
	},
	{#State 378
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 77,
			'LBRACE' => 98,
			'WORD_UPPERCASE' => 127,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'LPAREN' => 93,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'WORD' => 30
		},
		GOTOS => {
			'HashDereference' => 116,
			'Expression' => 129,
			'SubExpression' => 389,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayReference' => 91,
			'ArrayDereference' => 110,
			'Variable' => 128,
			'HashReference' => 75,
			'WordScoped' => 97
		}
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 317
		},
		GOTOS => {
			'CodeBlock' => 390
		}
	},
	{#State 380
		ACTIONS => {
			'OP01_OPEN' => 114,
			'OP10_NAMED_UNARY' => 115,
			"\@{" => 94,
			'OP01_NAMED' => 125,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74
		},
		GOTOS => {
			'WordScoped' => 97,
			'HashReference' => 75,
			'Variable' => 128,
			'SubExpression' => 391,
			'ArrayDereference' => 110,
			'Literal' => 111,
			'Operator' => 112,
			'ArrayReference' => 91,
			'Expression' => 129,
			'HashDereference' => 116
		}
	},
	{#State 381
		ACTIONS => {
			";" => -81,
			")" => -81,
			'OP21_LIST_COMMA' => -81,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP11_COMPARE_LT_GT' => 143,
			"]" => -81,
			'OP06_REGEX_MATCH' => 136,
			'OP13_BITWISE_AND' => 135,
			"}" => -81,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => -81,
			'OP07_STRING_REPEAT' => 139,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => -81
		}
	},
	{#State 382
		ACTIONS => {
			'VARIABLE_SYMBOL' => 392
		}
	},
	{#State 383
		DEFAULT => -50
	},
	{#State 384
		ACTIONS => {
			'LBRACE' => -66,
			"undef" => -66,
			'OP01_PRINT' => -66,
			'LPAREN_MY' => 393,
			'OP22_LOGICAL_NEG' => -66,
			'OP01_CLOSE' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP01_OPEN' => -66,
			"while" => -66,
			'OP05_LOGICAL_NEG' => -66,
			'WORD_UPPERCASE' => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LITERAL_STRING' => -66,
			'WORD_SCOPED' => -66,
			"if" => -66,
			'OP01_NAMED_VOID' => -66,
			'WORD' => -66,
			"my" => -66,
			"for" => -66,
			'LITERAL_NUMBER' => -66,
			'LBRACKET' => -66,
			"}" => -66,
			'LPAREN' => -66,
			'OP19_LOOP_CONTROL' => -66,
			"%{" => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			"foreach" => -66,
			'OP01_NAMED' => -66,
			"\@{" => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 394,
			'MethodArguments' => 395
		}
	},
	{#State 385
		DEFAULT => -61
	},
	{#State 386
		ACTIONS => {
			";" => 396
		}
	},
	{#State 387
		ACTIONS => {
			'WORD' => 360,
			"%{" => 92
		},
		GOTOS => {
			'HashEntryTyped' => 397,
			'HashDereference' => 358
		}
	},
	{#State 388
		ACTIONS => {
			'LBRACE' => 98,
			'LITERAL_STRING' => 77,
			'OP05_LOGICAL_NEG' => 73,
			'WORD_UPPERCASE' => 127,
			'VARIABLE_SYMBOL' => 74,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 102,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 86,
			'LBRACKET' => 88,
			'WORD' => 30,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			'OP01_NAMED' => 125,
			"\@{" => 94,
			'OP05_MATH_NEG_LPAREN' => 113,
			"%{" => 92,
			'LPAREN' => 93
		},
		GOTOS => {
			'Literal' => 111,
			'ArrayReference' => 91,
			'Operator' => 112,
			'ArrayDereference' => 110,
			'SubExpression' => 398,
			'HashDereference' => 116,
			'Expression' => 129,
			'HashReference' => 75,
			'WordScoped' => 97,
			'Variable' => 128
		}
	},
	{#State 389
		ACTIONS => {
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP07_STRING_REPEAT' => 139,
			'OP08_MATH_ADD_SUB' => 144,
			'OP16_LOGICAL_OR' => 137,
			'OP23_LOGICAL_AND' => 138,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP11_COMPARE_LT_GT' => 143,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP18_TERNARY' => 142,
			")" => 399
		}
	},
	{#State 390
		DEFAULT => -156
	},
	{#State 391
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 143,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			")" => 400,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP04_MATH_POW' => 146,
			'OP08_STRING_CAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP09_BITWISE_SHIFT' => 140,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP15_LOGICAL_AND' => 148,
			'OP23_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => 137,
			'OP08_MATH_ADD_SUB' => 144,
			'OP07_STRING_REPEAT' => 139
		}
	},
	{#State 392
		DEFAULT => -47
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
		DEFAULT => -65
	},
	{#State 396
		DEFAULT => -63
	},
	{#State 397
		DEFAULT => -60
	},
	{#State 398
		ACTIONS => {
			"}" => -191,
			'OP13_BITWISE_AND' => 135,
			'OP06_REGEX_MATCH' => 136,
			'OP11_COMPARE_LT_GT' => 143,
			'OP14_BITWISE_OR_XOR' => 133,
			'OP18_TERNARY' => 142,
			'OP17_LIST_RANGE' => 134,
			'OP21_LIST_COMMA' => -191,
			'OP15_LOGICAL_AND' => 148,
			'OP24_LOGICAL_OR_XOR' => 149,
			'OP08_STRING_CAT' => 147,
			'OP04_MATH_POW' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 141,
			'OP09_BITWISE_SHIFT' => 140,
			'OP12_COMPARE_EQ_NE' => 145,
			'OP07_STRING_REPEAT' => 139,
			'OP08_MATH_ADD_SUB' => 144,
			'OP23_LOGICAL_AND' => 138,
			'OP16_LOGICAL_OR' => 137
		}
	},
	{#State 399
		ACTIONS => {
			'LBRACE' => 317
		},
		GOTOS => {
			'CodeBlock' => 403
		}
	},
	{#State 400
		ACTIONS => {
			'LBRACE' => 317
		},
		GOTOS => {
			'CodeBlock' => 404
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
			'OP22_LOGICAL_NEG' => 103,
			'OP01_PRINT' => 101,
			"undef" => 102,
			'LBRACE' => 98,
			'OP10_NAMED_UNARY' => 115,
			'OP01_OPEN' => 114,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_CLOSE' => 105,
			'OP03_MATH_INC_DEC' => 106,
			'OP01_NAMED_VOID' => 83,
			"if" => 81,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 77,
			'OP01_NAMED_VOID_SCOLON' => 71,
			'WORD_UPPERCASE' => 72,
			'OP05_LOGICAL_NEG' => 73,
			'VARIABLE_SYMBOL' => 74,
			"foreach" => -139,
			"\@{" => 94,
			'OP01_NAMED' => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 96,
			'OP19_LOOP_CONTROL' => 90,
			"%{" => 92,
			'LPAREN' => 93,
			"for" => -139,
			'LITERAL_NUMBER' => 86,
			"}" => 406,
			'LBRACKET' => 88,
			"my" => 89,
			'WORD' => 30
		},
		GOTOS => {
			'VariableModification' => 78,
			'LoopLabel' => 79,
			'SubExpression' => 82,
			'Expression' => 104,
			'WordScoped' => 97,
			'HashReference' => 75,
			'OperatorVoid' => 99,
			'PAREN-34' => 76,
			'OPTIONAL-35' => 100,
			'ArrayDereference' => 110,
			'ArrayReference' => 91,
			'Operator' => 112,
			'Literal' => 111,
			'HashDereference' => 116,
			'Statement' => 84,
			'Conditional' => 107,
			'Operation' => 407,
			'VariableDeclaration' => 108,
			'Variable' => 109
		}
	},
	{#State 403
		DEFAULT => -145
	},
	{#State 404
		DEFAULT => -155
	},
	{#State 405
		ACTIONS => {
			'OP21_LIST_COMMA' => 408,
			")" => 410
		},
		GOTOS => {
			'PAREN-28' => 409
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
			"my" => 412
		}
	},
	{#State 409
		DEFAULT => -71
	},
	{#State 410
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 411
		DEFAULT => -69
	},
	{#State 412
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 414
		}
	},
	{#State 413
		ACTIONS => {
			"\@_;" => 415
		}
	},
	{#State 414
		ACTIONS => {
			'VARIABLE_SYMBOL' => 416
		}
	},
	{#State 415
		DEFAULT => -73
	},
	{#State 416
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5716 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5723 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5730 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5737 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5748 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5759 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5766 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5773 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5780 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5787 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5794 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5801 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5808 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5815 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5822 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5829 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5836 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5843 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5854 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5879 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5901 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5908 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5936 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5943 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5968 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5986 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6018 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6029 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6051 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6058 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6090 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6097 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6143 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6150 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6171 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6178 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6196 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6203 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6210 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6246 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6253 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6260 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6285 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6292 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6336 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6391 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6402 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6413 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6435 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6457 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6479 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6490 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6501 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6512 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6523 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6534 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6556 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6567 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6600 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6611 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6622 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6633 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6644 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6655 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6687 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6698 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6720 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6731 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6742 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6753 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6764 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6771 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6778 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6785 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6792 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6803 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6869 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6880 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6891 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6902 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6913 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6924 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6935 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6946 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6957 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6968 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6975 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6982 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6989 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7011 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7022 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7033 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7051 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7058 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7065 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7108 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7119 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7130 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7141 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7152 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7163 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7170 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7202 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7235 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7246 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7268 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7279 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7290 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7297 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7304 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7311 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_174
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7336 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7347 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7358 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7369 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7376 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_185
		 'ArrayDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_186
		 'ArrayDereference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_196
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7520 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_197
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7538 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7545 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_200
		 'HashDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7556 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_201
		 'HashDereference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7567 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_202
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_204
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule Type_205
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule Type_206
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7622 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_207
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7633 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_208
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7644 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_209
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7655 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_210
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7666 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_211
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7677 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_212
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7688 lib/RPerl/Grammar.pm
	]
],
#line 7691 lib/RPerl/Grammar.pm
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

#line 204 "lib/RPerl/Grammar.eyp"


{
# Rules from Grammar.output
my string__hash_ref $rules = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',
CompileUnit_5 => 'RPerl::CompileUnit::Module',
Program_18 => 'RPerl::CompileUnit::Program',
ModuleHeader_21 => 'RPerl::CompileUnit::Module::Header',
Module_22 => 'RPerl::CompileUnit::Module::Package',
Module_23 => 'RPerl::CompileUnit::Module::Class',
Package_32 => 'RPerl::CompileUnit::Module::Package',
Header_33 => 'RPerl::CompileUnit::Module::Header',
Critic_36 => 'RPerl::CompileUnit::Critic',
Include_39 => 'RPerl::CompileUnit::Include',
Include_40 => 'RPerl::CompileUnit::Include',
Constant_41 => 'RPerl::CompileUnit::Constant',
Subroutine_46 => 'RPerl::CodeBlock::Subroutine',
SubroutineArguments_50 => 'RPerl::CodeBlock::Subroutine::Arguments',
Class_59 => 'RPerl::CompileUnit::Module::Class',
Properties_63 => 'RPerl::DataStructure::Hash::Properties',
Properties_64 => 'RPerl::DataStructure::Hash::Properties',
Method_69 => 'RPerl::CodeBlock::Subroutine::Method',
MethodArguments_73 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',
MethodOrSubroutine_74 => 'RPerl::CodeBlock::Subroutine::Method',
MethodOrSubroutine_75 => 'RPerl::CodeBlock::Subroutine',
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


#line 8059 lib/RPerl/Grammar.pm



1;
