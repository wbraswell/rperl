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
    our $VERSION = 0.000_987;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach|\$TYPED_|\=\ sub\ \{|package|while|elsif|undef|else|for|\@_\;|use|our|my|if|\@\{|\%\{|\;|\]|\}|\))}gc and return ($1, $1);

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
			"## no critic qw(" => 8,
			'SHEBANG' => 1
		},
		GOTOS => {
			'Critic' => 7,
			'PLUS-2' => 9,
			'Program' => 3,
			'OPTIONAL-9' => 4,
			'CompileUnit' => 6,
			'ModuleHeader' => 5,
			'PAREN-1' => 2
		}
	},
	{#State 1
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'OPTIONAL-3' => 11,
			'Critic' => 10
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
			"package" => 12
		}
	},
	{#State 5
		ACTIONS => {
			"use parent qw(" => 16,
			"## no critic qw(" => -25,
			"use" => -25,
			"use constant" => -25,
			"our" => -25
		},
		GOTOS => {
			'Class' => 14,
			'Module' => 17,
			'Package' => 13,
			'STAR-10' => 15
		}
	},
	{#State 6
		ACTIONS => {
			'' => 18
		}
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-14' => 19
		}
	},
	{#State 9
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 8,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'PAREN-1' => 21,
			'OPTIONAL-9' => 4,
			'Critic' => 7
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
			'WORD' => 26,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		DEFAULT => -23
	},
	{#State 15
		ACTIONS => {
			"our" => -27,
			"## no critic qw(" => 8,
			"use constant" => -27,
			"use" => -27
		},
		GOTOS => {
			'STAR-11' => 27,
			'Critic' => 28
		}
	},
	{#State 16
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 17
		DEFAULT => -1
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		ACTIONS => {
			'WORD' => 30,
			")" => 31
		}
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		DEFAULT => -2
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
		DEFAULT => -203
	},
	{#State 25
		ACTIONS => {
			";" => 34
		}
	},
	{#State 26
		DEFAULT => -202
	},
	{#State 27
		ACTIONS => {
			"use" => 35,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 36,
			'Include' => 37
		}
	},
	{#State 28
		DEFAULT => -24
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
			'OP19_LOOP_CONTROL' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'WORD' => -11,
			'WORD_SCOPED' => -11,
			"our" => -11,
			"use" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			"my" => -11,
			'OP01_PRINT' => -11,
			'VARIABLE_SYMBOL' => -11,
			'LPAREN' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED' => -11,
			'OP01_OPEN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"%{" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'WORD_UPPERCASE' => -11,
			"foreach" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP10_NAMED_UNARY' => -11,
			"for" => -11,
			"## no critic qw(" => 8,
			'LITERAL_NUMBER' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"\@{" => -11,
			"undef" => -11,
			"if" => -11,
			'LITERAL_STRING' => -11,
			"while" => -11,
			"use constant" => -11,
			'LBRACKET' => -11
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
			'WORD' => 26,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 36
		ACTIONS => {
			"use constant" => 44,
			"our" => 45
		},
		GOTOS => {
			'PLUS-13' => 48,
			'Constant' => 47,
			'Subroutine' => 46
		}
	},
	{#State 37
		DEFAULT => -26
	},
	{#State 38
		ACTIONS => {
			";" => 49
		}
	},
	{#State 39
		ACTIONS => {
			'LITERAL_NUMBER' => -13,
			"for" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"foreach" => -13,
			'LBRACKET' => -13,
			"use constant" => -13,
			'LITERAL_STRING' => -13,
			"while" => -13,
			"if" => -13,
			"undef" => -13,
			"\@{" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'VARIABLE_SYMBOL' => -13,
			"my" => -13,
			'LBRACE' => -13,
			'OP01_PRINT' => -13,
			"use" => 35,
			'OP05_MATH_NEG_LPAREN' => -13,
			"our" => -13,
			'WORD_SCOPED' => -13,
			'WORD' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'WORD_UPPERCASE' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_OPEN' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED' => -13,
			'OP01_CLOSE' => -13,
			'LPAREN' => -13
		},
		GOTOS => {
			'STAR-6' => 50,
			'Include' => 51
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
			";" => 53,
			'OP01_QW' => 54
		}
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 45
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 46
		DEFAULT => -31
	},
	{#State 47
		DEFAULT => -28
	},
	{#State 48
		ACTIONS => {
			'LITERAL_NUMBER' => 59,
			"our" => 45
		},
		GOTOS => {
			'Subroutine' => 60
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 35
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 50
		ACTIONS => {
			"for" => -15,
			'LITERAL_NUMBER' => -15,
			"foreach" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_NAMED_VOID' => -15,
			"while" => -15,
			'LITERAL_STRING' => -15,
			'LBRACKET' => -15,
			"use constant" => 44,
			'OP03_MATH_INC_DEC' => -15,
			"\@{" => -15,
			"undef" => -15,
			"if" => -15,
			"our" => -15,
			'WORD_SCOPED' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LBRACE' => -15,
			'OP01_PRINT' => -15,
			"my" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_OPEN' => -15,
			"%{" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'WORD_UPPERCASE' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LPAREN' => -15,
			'OP01_NAMED' => -15,
			'OP01_CLOSE' => -15
		},
		GOTOS => {
			'STAR-7' => 63,
			'Constant' => 62
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
		DEFAULT => -205
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 58
		DEFAULT => -206
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
		DEFAULT => -12
	},
	{#State 63
		ACTIONS => {
			'OP01_NAMED' => 103,
			'OP01_CLOSE' => 102,
			'LPAREN' => 104,
			'WORD_UPPERCASE' => 95,
			'OP22_LOGICAL_NEG' => 96,
			"%{" => 97,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'OP01_OPEN' => 100,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP19_LOOP_CONTROL' => 116,
			'VARIABLE_SYMBOL' => 111,
			'OP01_PRINT' => 109,
			'LBRACE' => 106,
			"my" => 107,
			'OP05_MATH_NEG_LPAREN' => 110,
			"our" => 45,
			'WORD_SCOPED' => 24,
			"if" => 76,
			"undef" => 77,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LBRACKET' => 71,
			"while" => -139,
			'LITERAL_STRING' => 74,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED_VOID' => 87,
			'OP01_NAMED_VOID_SCOLON' => 88,
			"foreach" => -139,
			'LITERAL_NUMBER' => 85,
			"for" => -139
		},
		GOTOS => {
			'LoopLabel' => 73,
			'VariableModification' => 98,
			'Variable' => 72,
			'Conditional' => 78,
			'Expression' => 105,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'ArrayReference' => 113,
			'HashReference' => 108,
			'Statement' => 82,
			'WordScoped' => 81,
			'VariableDeclaration' => 83,
			'Operation' => 84,
			'HashDereference' => 112,
			'Literal' => 86,
			'PAREN-34' => 94,
			'OPTIONAL-35' => 114,
			'PLUS-8' => 90,
			'Subroutine' => 89,
			'SubExpression' => 92,
			'OperatorVoid' => 93
		}
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
			"my" => 119
		},
		GOTOS => {
			'TypeInnerConstant' => 120
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
			"use constant" => -54,
			"use" => -54,
			"## no critic qw(" => 8,
			"our hash_ref \$properties" => -54
		},
		GOTOS => {
			'Critic' => 123,
			'STAR-21' => 122
		}
	},
	{#State 71
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			"my" => 125,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP10_NAMED_UNARY' => 91,
			"]" => -181,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LBRACKET' => 71,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			'OP01_QW' => 131,
			"undef" => 77
		},
		GOTOS => {
			'OPTIONAL-45' => 124,
			'Expression' => 127,
			'ListElement' => 132,
			'TypeInner' => 130,
			'SubExpression' => 129,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'ListElements' => 134,
			'Literal' => 86,
			'Variable' => 133,
			'HashReference' => 108,
			'WordScoped' => 81
		}
	},
	{#State 72
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP18_TERNARY' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 136,
			'OP23_LOGICAL_AND' => -129,
			'OP08_STRING_CAT' => -129,
			'OP03_MATH_INC_DEC' => 135,
			'OP17_LIST_RANGE' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP02_METHOD_THINARROW' => 137,
			'OP19_VARIABLE_ASSIGN' => 138,
			'OP09_BITWISE_SHIFT' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP04_MATH_POW' => -129,
			'OP24_LOGICAL_OR_XOR' => -129
		}
	},
	{#State 73
		ACTIONS => {
			'COLON' => 139
		}
	},
	{#State 74
		DEFAULT => -211
	},
	{#State 75
		DEFAULT => -131
	},
	{#State 76
		ACTIONS => {
			'LPAREN' => 140
		}
	},
	{#State 77
		DEFAULT => -127
	},
	{#State 78
		DEFAULT => -140
	},
	{#State 79
		ACTIONS => {
			'VARIABLE_SYMBOL' => 111
		},
		GOTOS => {
			'Variable' => 141
		}
	},
	{#State 80
		ACTIONS => {
			"my" => 125,
			'VARIABLE_SYMBOL' => 111,
			'LBRACKET' => -184
		},
		GOTOS => {
			'OPTIONAL-46' => 142,
			'Variable' => 143,
			'TypeInner' => 144
		}
	},
	{#State 81
		ACTIONS => {
			'LPAREN' => 146,
			'OP02_METHOD_THINARROW_NEW' => 145
		}
	},
	{#State 82
		DEFAULT => -77
	},
	{#State 83
		DEFAULT => -143
	},
	{#State 84
		DEFAULT => -17
	},
	{#State 85
		DEFAULT => -212
	},
	{#State 86
		DEFAULT => -128
	},
	{#State 87
		ACTIONS => {
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			'OP01_QW' => 131,
			"undef" => 77,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LBRACE' => 106,
			"my" => 125,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26
		},
		GOTOS => {
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'ListElements' => 147,
			'WordScoped' => 81,
			'HashReference' => 108,
			'ArrayReference' => 113,
			'SubExpression' => 129,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'Expression' => 127,
			'ListElement' => 132,
			'TypeInner' => 130
		}
	},
	{#State 88
		DEFAULT => -112
	},
	{#State 89
		DEFAULT => -14
	},
	{#State 90
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP01_NAMED_VOID' => 87,
			"foreach" => -139,
			'LITERAL_NUMBER' => 85,
			"for" => -139,
			"if" => 76,
			"undef" => 77,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'' => -18,
			'LBRACKET' => 71,
			"while" => -139,
			'LITERAL_STRING' => 74,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP19_LOOP_CONTROL' => 116,
			'VARIABLE_SYMBOL' => 111,
			'LBRACE' => 106,
			"my" => 107,
			'OP01_PRINT' => 109,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP01_NAMED' => 103,
			'OP01_CLOSE' => 102,
			'LPAREN' => 104,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 95,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 99
		},
		GOTOS => {
			'Variable' => 72,
			'VariableModification' => 98,
			'LoopLabel' => 73,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'Expression' => 105,
			'Conditional' => 78,
			'Literal' => 86,
			'HashDereference' => 112,
			'Operation' => 148,
			'VariableDeclaration' => 83,
			'HashReference' => 108,
			'Statement' => 82,
			'WordScoped' => 81,
			'ArrayReference' => 113,
			'OperatorVoid' => 93,
			'SubExpression' => 92,
			'OPTIONAL-35' => 114,
			'PAREN-34' => 94
		}
	},
	{#State 91
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'OP08_STRING_CAT' => -95,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'OP18_TERNARY' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			"}" => -95,
			'OP04_MATH_POW' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP10_NAMED_UNARY' => 91,
			"]" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP13_BITWISE_AND' => -95,
			")" => -95,
			'LITERAL_NUMBER' => 85,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP23_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			";" => -95,
			"undef" => 77,
			'LITERAL_STRING' => 74,
			'OP15_LOGICAL_AND' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'LBRACKET' => 71,
			'OP11_COMPARE_LT_GT' => -95
		},
		GOTOS => {
			'WordScoped' => 81,
			'HashReference' => 108,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 149,
			'Expression' => 127
		}
	},
	{#State 92
		ACTIONS => {
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 154,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158
		}
	},
	{#State 93
		DEFAULT => -142
	},
	{#State 94
		DEFAULT => -138
	},
	{#State 95
		ACTIONS => {
			'LPAREN' => 167,
			'COLON' => -204
		}
	},
	{#State 96
		ACTIONS => {
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashReference' => 108,
			'WordScoped' => 81,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'Expression' => 127,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 168
		}
	},
	{#State 97
		ACTIONS => {
			'LBRACE' => -199,
			"my" => 125,
			'VARIABLE_SYMBOL' => 111
		},
		GOTOS => {
			'TypeInner' => 171,
			'Variable' => 170,
			'OPTIONAL-50' => 169
		}
	},
	{#State 98
		DEFAULT => -144
	},
	{#State 99
		DEFAULT => -115
	},
	{#State 100
		ACTIONS => {
			"my" => 172
		}
	},
	{#State 101
		DEFAULT => -121
	},
	{#State 102
		ACTIONS => {
			'FH_REF_SYMBOL' => 173
		}
	},
	{#State 103
		ACTIONS => {
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			"undef" => 77,
			'OP01_QW' => 131,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			"my" => 125,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'TypeInner' => 130,
			'Expression' => 127,
			'ListElement' => 175,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 174,
			'ArrayReference' => 113,
			'HashReference' => 108,
			'WordScoped' => 81,
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112
		}
	},
	{#State 104
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'OP01_PRINT' => 178,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 177,
			"undef" => 77,
			'OP01_CLOSE' => 102
		},
		GOTOS => {
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 176,
			'Expression' => 127,
			'HashReference' => 108,
			'WordScoped' => 81,
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112,
			'ArrayReference' => 113
		}
	},
	{#State 105
		ACTIONS => {
			";" => 179,
			'OP16_LOGICAL_OR' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP08_STRING_CAT' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP18_TERNARY' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP04_MATH_POW' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP13_BITWISE_AND' => -126
		}
	},
	{#State 106
		ACTIONS => {
			"}" => 180,
			"%{" => 97,
			'WORD' => 183
		},
		GOTOS => {
			'HashDereference' => 182,
			'HashEntry' => 181
		}
	},
	{#State 107
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 184
		}
	},
	{#State 108
		DEFAULT => -132
	},
	{#State 109
		ACTIONS => {
			'WORD_SCOPED' => -109,
			'LITERAL_NUMBER' => -109,
			'VARIABLE_SYMBOL' => -109,
			'LBRACE' => -109,
			"my" => -109,
			'STDOUT_STDERR' => 188,
			'OP05_MATH_NEG_LPAREN' => -109,
			'OP10_NAMED_UNARY' => -109,
			'WORD' => -109,
			'OP05_LOGICAL_NEG' => -109,
			"%{" => -109,
			'OP01_OPEN' => -109,
			'LITERAL_STRING' => -109,
			'LBRACKET' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'WORD_UPPERCASE' => -109,
			'FH_REF_SYMBOL_BRACES' => 185,
			'OP03_MATH_INC_DEC' => -109,
			"\@{" => -109,
			'LPAREN' => -109,
			'OP01_NAMED' => -109,
			'OP01_CLOSE' => -109,
			'OP01_QW' => -109,
			"undef" => -109
		},
		GOTOS => {
			'PAREN-30' => 187,
			'OPTIONAL-31' => 186
		}
	},
	{#State 110
		ACTIONS => {
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'LBRACKET' => 71,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Expression' => 127,
			'SubExpression' => 189,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'ArrayReference' => 113,
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112,
			'HashReference' => 108,
			'WordScoped' => 81
		}
	},
	{#State 111
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 190
		}
	},
	{#State 112
		DEFAULT => -133
	},
	{#State 113
		DEFAULT => -130
	},
	{#State 114
		ACTIONS => {
			"foreach" => 193,
			"for" => 195,
			"while" => 191
		},
		GOTOS => {
			'LoopForEach' => 194,
			'LoopFor' => 197,
			'LoopWhile' => 196,
			'Loop' => 192
		}
	},
	{#State 115
		ACTIONS => {
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP01_NAMED' => 126,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'ArrayReference' => 113,
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Expression' => 127,
			'SubExpression' => 198,
			'Operator' => 101,
			'ArrayDereference' => 75
		}
	},
	{#State 116
		ACTIONS => {
			'WORD_UPPERCASE' => 200
		},
		GOTOS => {
			'LoopLabel' => 199
		}
	},
	{#State 117
		DEFAULT => -37
	},
	{#State 118
		ACTIONS => {
			";" => 201
		}
	},
	{#State 119
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 202
		}
	},
	{#State 120
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'Literal' => 203
		}
	},
	{#State 121
		ACTIONS => {
			'OP01_NAMED' => -43,
			'OP01_CLOSE' => -43,
			'LPAREN' => -43,
			'WORD_UPPERCASE' => -43,
			'OP22_LOGICAL_NEG' => -43,
			"%{" => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_OPEN' => -43,
			'WORD' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"my" => -43,
			'OP01_PRINT' => -43,
			'LBRACE' => -43,
			'WORD_SCOPED' => -43,
			"undef" => -43,
			"if" => -43,
			'OP03_MATH_INC_DEC' => -43,
			"\@{" => -43,
			'LPAREN_MY' => 206,
			'LBRACKET' => -43,
			'LITERAL_STRING' => -43,
			"while" => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP01_NAMED_VOID' => -43,
			"foreach" => -43,
			'LITERAL_NUMBER' => -43,
			"for" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 204,
			'OPTIONAL-16' => 205
		}
	},
	{#State 122
		ACTIONS => {
			"use" => 35,
			"use constant" => -56,
			"our hash_ref \$properties" => -56
		},
		GOTOS => {
			'Include' => 208,
			'STAR-22' => 207
		}
	},
	{#State 123
		DEFAULT => -51
	},
	{#State 124
		ACTIONS => {
			"]" => 209
		}
	},
	{#State 125
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 58
		},
		GOTOS => {
			'Type' => 210
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 24,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 71,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'Expression' => 127,
			'SubExpression' => 211,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'Literal' => 86,
			'Variable' => 133,
			'HashReference' => 108,
			'WordScoped' => 81
		}
	},
	{#State 127
		DEFAULT => -126
	},
	{#State 128
		ACTIONS => {
			'LPAREN' => 167
		}
	},
	{#State 129
		ACTIONS => {
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 154,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP23_LOGICAL_AND' => 151,
			'OP08_STRING_CAT' => 160,
			";" => -177,
			'OP16_LOGICAL_OR' => 150,
			")" => -177,
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 164,
			"]" => -177,
			'OP21_LIST_COMMA' => -177,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156
		}
	},
	{#State 130
		ACTIONS => {
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP01_NAMED' => 126,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Expression' => 127,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 212,
			'ArrayReference' => 113,
			'HashReference' => 108,
			'WordScoped' => 81,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86
		}
	},
	{#State 131
		ACTIONS => {
			'WORD' => 214
		},
		GOTOS => {
			'PLUS-44' => 213
		}
	},
	{#State 132
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 215
		}
	},
	{#State 133
		ACTIONS => {
			'OP07_STRING_REPEAT' => -129,
			'OP18_TERNARY' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP08_STRING_CAT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP03_MATH_INC_DEC' => 135,
			";" => -129,
			'OP16_LOGICAL_OR' => -129,
			")" => -129,
			'OP13_BITWISE_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP04_MATH_POW' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			"}" => -129,
			"]" => -129,
			'OP02_METHOD_THINARROW' => 137,
			'OP21_LIST_COMMA' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP14_BITWISE_OR_XOR' => -129
		}
	},
	{#State 134
		DEFAULT => -180
	},
	{#State 135
		DEFAULT => -84
	},
	{#State 136
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Expression' => 127,
			'SubExpression' => 216,
			'Operator' => 101,
			'ArrayDereference' => 75
		}
	},
	{#State 137
		ACTIONS => {
			'LPAREN' => 217
		}
	},
	{#State 138
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'LBRACKET' => 71,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			'STDIN' => 218,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 81,
			'HashReference' => 108,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'Expression' => 127,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 220,
			'SubExpressionOrStdin' => 219
		}
	},
	{#State 139
		DEFAULT => -137
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104
		},
		GOTOS => {
			'Expression' => 127,
			'SubExpression' => 221,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'ArrayReference' => 113,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'HashReference' => 108,
			'WordScoped' => 81
		}
	},
	{#State 141
		DEFAULT => -83
	},
	{#State 142
		ACTIONS => {
			'LBRACKET' => 71
		},
		GOTOS => {
			'ArrayReference' => 222
		}
	},
	{#State 143
		ACTIONS => {
			"}" => 223
		}
	},
	{#State 144
		DEFAULT => -183
	},
	{#State 145
		ACTIONS => {
			")" => 224
		}
	},
	{#State 146
		ACTIONS => {
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_QW' => 131,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'OP05_MATH_NEG_LPAREN' => 110,
			"my" => 125,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 85,
			")" => -118,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'Operator' => 101,
			'ArrayDereference' => 75,
			'OPTIONAL-32' => 225,
			'SubExpression' => 129,
			'TypeInner' => 130,
			'ListElement' => 132,
			'Expression' => 127,
			'WordScoped' => 81,
			'HashReference' => 108,
			'HashDereference' => 112,
			'Variable' => 133,
			'ListElements' => 226,
			'Literal' => 86,
			'ArrayReference' => 113
		}
	},
	{#State 147
		ACTIONS => {
			";" => 227
		}
	},
	{#State 148
		DEFAULT => -16
	},
	{#State 149
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP09_BITWISE_SHIFT' => 155,
			"]" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => -94,
			"}" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			")" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP13_BITWISE_AND' => -94,
			";" => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => -94
		}
	},
	{#State 150
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77
		},
		GOTOS => {
			'WordScoped' => 81,
			'HashReference' => 108,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 228,
			'Expression' => 127
		}
	},
	{#State 151
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'Expression' => 127,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 229
		}
	},
	{#State 152
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashReference' => 108,
			'WordScoped' => 81,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'Expression' => 127,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 230
		}
	},
	{#State 153
		ACTIONS => {
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'Expression' => 127,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 231,
			'ArrayReference' => 113,
			'HashReference' => 108,
			'WordScoped' => 81,
			'HashDereference' => 112,
			'Literal' => 86,
			'Variable' => 133
		}
	},
	{#State 154
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 81,
			'HashReference' => 108,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'Expression' => 127,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 232
		}
	},
	{#State 155
		ACTIONS => {
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 81,
			'HashReference' => 108,
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 233,
			'Expression' => 127
		}
	},
	{#State 156
		ACTIONS => {
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 71
		},
		GOTOS => {
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'HashReference' => 108,
			'WordScoped' => 81,
			'ArrayReference' => 113,
			'SubExpression' => 234,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'Expression' => 127
		}
	},
	{#State 157
		ACTIONS => {
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 71,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'ArrayReference' => 113,
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112,
			'HashReference' => 108,
			'WordScoped' => 81,
			'Expression' => 127,
			'SubExpression' => 235,
			'ArrayDereference' => 75,
			'Operator' => 101
		}
	},
	{#State 158
		ACTIONS => {
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP01_NAMED' => 126,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashReference' => 108,
			'WordScoped' => 81,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'ArrayReference' => 113,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 236,
			'Expression' => 127
		}
	},
	{#State 159
		ACTIONS => {
			'OP01_NAMED' => 126,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Expression' => 127,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 237,
			'ArrayReference' => 113,
			'HashReference' => 108,
			'WordScoped' => 81,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112
		}
	},
	{#State 160
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104
		},
		GOTOS => {
			'WordScoped' => 81,
			'HashReference' => 108,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 238,
			'Expression' => 127
		}
	},
	{#State 161
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96
		},
		GOTOS => {
			'WordScoped' => 81,
			'HashReference' => 108,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 239,
			'Expression' => 127
		}
	},
	{#State 162
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'VariableOrLiteral' => 240,
			'Variable' => 242,
			'Literal' => 241
		}
	},
	{#State 163
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96
		},
		GOTOS => {
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 243,
			'Expression' => 127,
			'WordScoped' => 81,
			'HashReference' => 108,
			'HashDereference' => 112,
			'Literal' => 86,
			'Variable' => 133,
			'ArrayReference' => 113
		}
	},
	{#State 164
		ACTIONS => {
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP01_NAMED' => 126,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97
		},
		GOTOS => {
			'WordScoped' => 81,
			'HashReference' => 108,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 244,
			'Expression' => 127
		}
	},
	{#State 165
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77
		},
		GOTOS => {
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112,
			'HashReference' => 108,
			'WordScoped' => 81,
			'ArrayReference' => 113,
			'SubExpression' => 245,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'Expression' => 127
		}
	},
	{#State 166
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 246
		}
	},
	{#State 167
		ACTIONS => {
			")" => 247
		}
	},
	{#State 168
		ACTIONS => {
			";" => -104,
			'OP16_LOGICAL_OR' => 150,
			'OP23_LOGICAL_AND' => -104,
			'OP08_STRING_CAT' => 160,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP15_LOGICAL_AND' => 154,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => -104,
			"}" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			")" => -104,
			'OP17_LIST_RANGE' => 158,
			'OP13_BITWISE_AND' => 159
		}
	},
	{#State 169
		ACTIONS => {
			'LBRACE' => 106
		},
		GOTOS => {
			'HashReference' => 248
		}
	},
	{#State 170
		ACTIONS => {
			"}" => 249
		}
	},
	{#State 171
		DEFAULT => -198
	},
	{#State 172
		ACTIONS => {
			"filehandle_ref" => 250
		}
	},
	{#State 173
		DEFAULT => -82
	},
	{#State 174
		ACTIONS => {
			'OP23_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			";" => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP18_TERNARY' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP04_MATH_POW' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP21_LIST_COMMA' => -177,
			")" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP13_BITWISE_AND' => -79
		}
	},
	{#State 175
		ACTIONS => {
			'OP21_LIST_COMMA' => 251
		}
	},
	{#State 176
		ACTIONS => {
			'OP23_LOGICAL_AND' => 151,
			'OP08_STRING_CAT' => 160,
			'OP16_LOGICAL_OR' => 150,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 154,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP08_MATH_ADD_SUB' => 156,
			")" => 252,
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158
		}
	},
	{#State 177
		ACTIONS => {
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			"my" => 125,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'OP01_QW' => 131,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 71
		},
		GOTOS => {
			'HashDereference' => 112,
			'Literal' => 86,
			'Variable' => 133,
			'WordScoped' => 81,
			'HashReference' => 108,
			'ArrayReference' => 113,
			'SubExpression' => 174,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'Expression' => 127,
			'ListElement' => 253,
			'TypeInner' => 130
		}
	},
	{#State 178
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 254
		}
	},
	{#State 179
		DEFAULT => -76
	},
	{#State 180
		DEFAULT => -197
	},
	{#State 181
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 255
		}
	},
	{#State 182
		DEFAULT => -190
	},
	{#State 183
		ACTIONS => {
			'OP20_HASH_FATARROW' => 256
		}
	},
	{#State 184
		ACTIONS => {
			'VARIABLE_SYMBOL' => 257
		}
	},
	{#State 185
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_QW' => 131,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			"my" => 125
		},
		GOTOS => {
			'SubExpression' => 129,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'Expression' => 127,
			'ListElement' => 132,
			'TypeInner' => 130,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'ListElements' => 258,
			'WordScoped' => 81,
			'HashReference' => 108,
			'ArrayReference' => 113
		}
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_QW' => 131,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			"my" => 125,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111
		},
		GOTOS => {
			'TypeInner' => 130,
			'ListElement' => 132,
			'Expression' => 127,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 129,
			'ArrayReference' => 113,
			'WordScoped' => 81,
			'HashReference' => 108,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'ListElements' => 259
		}
	},
	{#State 187
		DEFAULT => -108
	},
	{#State 188
		DEFAULT => -107
	},
	{#State 189
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158,
			")" => 260,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP04_MATH_POW' => 157,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP15_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 161,
			'OP16_LOGICAL_OR' => 150,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151
		}
	},
	{#State 190
		ACTIONS => {
			'OP15_LOGICAL_AND' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP18_TERNARY' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP08_STRING_CAT' => -163,
			'OP02_ARRAY_THINARROW' => 262,
			'OP03_MATH_INC_DEC' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			";" => -163,
			'OP16_LOGICAL_OR' => -163,
			")" => -163,
			'OP13_BITWISE_AND' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP02_HASH_THINARROW' => 263,
			'OP04_MATH_POW' => -163,
			"}" => -163,
			'COLON' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			"]" => -163,
			'OP21_LIST_COMMA' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP19_VARIABLE_ASSIGN' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 261
		}
	},
	{#State 191
		ACTIONS => {
			'LPAREN' => 264
		}
	},
	{#State 192
		DEFAULT => -141
	},
	{#State 193
		ACTIONS => {
			"my" => 265
		}
	},
	{#State 194
		DEFAULT => -153
	},
	{#State 195
		ACTIONS => {
			"my" => 266
		}
	},
	{#State 196
		DEFAULT => -154
	},
	{#State 197
		DEFAULT => -152
	},
	{#State 198
		ACTIONS => {
			'OP08_STRING_CAT' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP16_LOGICAL_OR' => -86,
			";" => -86,
			'OP18_TERNARY' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			"}" => -86,
			'OP04_MATH_POW' => 157,
			'OP21_LIST_COMMA' => -86,
			"]" => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP17_LIST_RANGE' => -86,
			")" => -86
		}
	},
	{#State 199
		ACTIONS => {
			";" => 267
		}
	},
	{#State 200
		DEFAULT => -204
	},
	{#State 201
		DEFAULT => -40
	},
	{#State 202
		ACTIONS => {
			"\$TYPED_" => 268
		}
	},
	{#State 203
		ACTIONS => {
			";" => 269
		}
	},
	{#State 204
		DEFAULT => -42
	},
	{#State 205
		ACTIONS => {
			"foreach" => -139,
			'OP19_LOOP_CONTROL' => 116,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP01_NAMED_VOID' => 87,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			"for" => -139,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP01_PRINT' => 109,
			"my" => 107,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 103,
			'OP01_CLOSE' => 102,
			"if" => 76,
			"undef" => 77,
			'LITERAL_STRING' => 74,
			"while" => -139,
			'OP01_OPEN' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			"%{" => 97,
			'LBRACKET' => 71,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 95
		},
		GOTOS => {
			'Literal' => 86,
			'HashDereference' => 112,
			'Operation' => 270,
			'VariableDeclaration' => 83,
			'WordScoped' => 81,
			'Statement' => 82,
			'HashReference' => 108,
			'ArrayReference' => 113,
			'OperatorVoid' => 93,
			'SubExpression' => 92,
			'OPTIONAL-35' => 114,
			'PAREN-34' => 94,
			'Variable' => 72,
			'VariableModification' => 98,
			'LoopLabel' => 73,
			'PLUS-17' => 271,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'Expression' => 105,
			'Conditional' => 78
		}
	},
	{#State 206
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 272
		}
	},
	{#State 207
		ACTIONS => {
			"our hash_ref \$properties" => 275,
			"use constant" => 44
		},
		GOTOS => {
			'Properties' => 273,
			'Constant' => 274
		}
	},
	{#State 208
		DEFAULT => -53
	},
	{#State 209
		DEFAULT => -182
	},
	{#State 210
		ACTIONS => {
			"\$TYPED_" => 276
		}
	},
	{#State 211
		ACTIONS => {
			'OP17_LIST_RANGE' => -79,
			'OP13_BITWISE_AND' => -79,
			")" => -79,
			'OP21_LIST_COMMA' => -79,
			"]" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			"}" => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP04_MATH_POW' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP18_TERNARY' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			";" => -79,
			'OP08_STRING_CAT' => -79,
			'OP23_LOGICAL_AND' => -79
		}
	},
	{#State 212
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158,
			")" => -178,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP04_MATH_POW' => 157,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP21_LIST_COMMA' => -178,
			"]" => -178,
			'OP15_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 161,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151,
			'OP16_LOGICAL_OR' => 150,
			";" => -178
		}
	},
	{#State 213
		ACTIONS => {
			")" => 278,
			'WORD' => 277
		}
	},
	{#State 214
		DEFAULT => -176
	},
	{#State 215
		ACTIONS => {
			";" => -174,
			")" => -174,
			"]" => -174,
			'OP21_LIST_COMMA' => 279
		},
		GOTOS => {
			'PAREN-42' => 280
		}
	},
	{#State 216
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP08_MATH_ADD_SUB' => 156,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 154,
			";" => 281,
			'OP16_LOGICAL_OR' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 217
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'LBRACE' => 106,
			"my" => 125,
			'OP05_MATH_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 111,
			")" => -120,
			'LITERAL_NUMBER' => 85,
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 102,
			'OP01_QW' => 131,
			"undef" => 77,
			'OP01_NAMED' => 126,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71
		},
		GOTOS => {
			'TypeInner' => 130,
			'Expression' => 127,
			'ListElement' => 132,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 129,
			'OPTIONAL-33' => 283,
			'ArrayReference' => 113,
			'HashReference' => 108,
			'WordScoped' => 81,
			'HashDereference' => 112,
			'Literal' => 86,
			'Variable' => 133,
			'ListElements' => 282
		}
	},
	{#State 218
		DEFAULT => -136
	},
	{#State 219
		ACTIONS => {
			";" => 284
		}
	},
	{#State 220
		ACTIONS => {
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151,
			";" => -135,
			'OP16_LOGICAL_OR' => 150,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 154,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP17_LIST_RANGE' => 158,
			'OP13_BITWISE_AND' => 159
		}
	},
	{#State 221
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158,
			")" => 285,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP09_BITWISE_SHIFT' => 155,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP04_MATH_POW' => 157,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 161,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 222
		ACTIONS => {
			"}" => 286
		}
	},
	{#State 223
		DEFAULT => -185
	},
	{#State 224
		DEFAULT => -125
	},
	{#State 225
		ACTIONS => {
			")" => 287
		}
	},
	{#State 226
		DEFAULT => -117
	},
	{#State 227
		DEFAULT => -113
	},
	{#State 228
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => -101,
			")" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			"}" => -101,
			'OP04_MATH_POW' => 157,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP08_MATH_ADD_SUB' => 156,
			'OP21_LIST_COMMA' => -101,
			"]" => -101,
			'OP15_LOGICAL_AND' => 154,
			'OP18_TERNARY' => -101,
			'OP07_STRING_REPEAT' => 161,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP23_LOGICAL_AND' => -101,
			'OP08_STRING_CAT' => 160,
			'OP16_LOGICAL_OR' => -101,
			";" => -101
		}
	},
	{#State 229
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 163,
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => -105,
			"}" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			")" => -105,
			'OP17_LIST_RANGE' => 158,
			'OP13_BITWISE_AND' => 159,
			";" => -105,
			'OP16_LOGICAL_OR' => 150,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP15_LOGICAL_AND' => 154,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162
		}
	},
	{#State 230
		ACTIONS => {
			'OP17_LIST_RANGE' => -97,
			'OP13_BITWISE_AND' => -97,
			")" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP21_LIST_COMMA' => -97,
			"]" => -97,
			"}" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP04_MATH_POW' => 157,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP11_COMPARE_LT_GT' => 153,
			'OP15_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			'OP07_STRING_REPEAT' => 161,
			'OP16_LOGICAL_OR' => -97,
			";" => -97,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -97
		}
	},
	{#State 231
		ACTIONS => {
			'OP15_LOGICAL_AND' => -96,
			'OP18_TERNARY' => -96,
			'OP07_STRING_REPEAT' => 161,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			";" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			")" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			"}" => -96,
			'OP04_MATH_POW' => 157,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			"]" => -96
		}
	},
	{#State 232
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP18_TERNARY' => -100,
			'OP07_STRING_REPEAT' => 161,
			'OP15_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			";" => -100,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP13_BITWISE_AND' => 159,
			")" => -100,
			'OP21_LIST_COMMA' => -100,
			"]" => -100,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"}" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP04_MATH_POW' => 157
		}
	},
	{#State 233
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP18_TERNARY' => -93,
			'OP07_STRING_REPEAT' => 161,
			'OP15_LOGICAL_AND' => -93,
			'OP16_LOGICAL_OR' => -93,
			";" => -93,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP13_BITWISE_AND' => -93,
			")" => -93,
			'OP21_LIST_COMMA' => -93,
			"]" => -93,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"}" => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP04_MATH_POW' => 157
		}
	},
	{#State 234
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => -91,
			'OP15_LOGICAL_AND' => -91,
			";" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP08_STRING_CAT' => -91,
			")" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			"]" => -91,
			'OP21_LIST_COMMA' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91
		}
	},
	{#State 235
		ACTIONS => {
			'OP23_LOGICAL_AND' => -85,
			'OP08_STRING_CAT' => -85,
			";" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP18_TERNARY' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP04_MATH_POW' => 157,
			"}" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			"]" => -85,
			'OP21_LIST_COMMA' => -85,
			")" => -85,
			'OP17_LIST_RANGE' => -85,
			'OP13_BITWISE_AND' => -85
		}
	},
	{#State 236
		ACTIONS => {
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => -102,
			'OP15_LOGICAL_AND' => 154,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP23_LOGICAL_AND' => -102,
			'OP08_STRING_CAT' => 160,
			";" => -102,
			'OP16_LOGICAL_OR' => 150,
			")" => -102,
			'OP17_LIST_RANGE' => undef,
			'OP13_BITWISE_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			"}" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			"]" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163
		}
	},
	{#State 237
		ACTIONS => {
			"}" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP04_MATH_POW' => 157,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			"]" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			")" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 160,
			'OP16_LOGICAL_OR' => -98,
			";" => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP18_TERNARY' => -98,
			'OP07_STRING_REPEAT' => 161,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153
		}
	},
	{#State 238
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => -92,
			";" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP08_STRING_CAT' => -92,
			'OP23_LOGICAL_AND' => -92,
			")" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => -92,
			"]" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP04_MATH_POW' => 157,
			"}" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166
		}
	},
	{#State 239
		ACTIONS => {
			'OP23_LOGICAL_AND' => -89,
			'OP08_STRING_CAT' => -89,
			";" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP18_TERNARY' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => -89,
			"}" => -89,
			"]" => -89,
			'OP21_LIST_COMMA' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			")" => -89,
			'OP13_BITWISE_AND' => -89,
			'OP17_LIST_RANGE' => -89
		}
	},
	{#State 240
		ACTIONS => {
			'COLON' => 288
		}
	},
	{#State 241
		DEFAULT => -210
	},
	{#State 242
		DEFAULT => -209
	},
	{#State 243
		ACTIONS => {
			'OP18_TERNARY' => -99,
			'OP07_STRING_REPEAT' => 161,
			'OP15_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			";" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP13_BITWISE_AND' => 159,
			")" => -99,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"}" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP04_MATH_POW' => 157,
			'OP21_LIST_COMMA' => -99,
			"]" => -99,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 156
		}
	},
	{#State 244
		ACTIONS => {
			'OP04_MATH_POW' => 157,
			"}" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP08_MATH_ADD_SUB' => 156,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			")" => -106,
			'OP17_LIST_RANGE' => 158,
			'OP13_BITWISE_AND' => 159,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151,
			";" => -106,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 154,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153
		}
	},
	{#State 245
		ACTIONS => {
			'OP17_LIST_RANGE' => -90,
			'OP13_BITWISE_AND' => -90,
			")" => -90,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			"}" => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP04_MATH_POW' => 157,
			'OP21_LIST_COMMA' => -90,
			"]" => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP18_TERNARY' => -90,
			'OP07_STRING_REPEAT' => 161,
			'OP15_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP08_STRING_CAT' => -90,
			'OP16_LOGICAL_OR' => -90,
			";" => -90
		}
	},
	{#State 246
		DEFAULT => -88
	},
	{#State 247
		DEFAULT => -123
	},
	{#State 248
		ACTIONS => {
			"}" => 289
		}
	},
	{#State 249
		DEFAULT => -200
	},
	{#State 250
		ACTIONS => {
			'FH_REF_SYMBOL' => 290
		}
	},
	{#State 251
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			"my" => 125,
			'LBRACE' => 106,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LBRACKET' => 71,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			'OP01_QW' => 131,
			"undef" => 77,
			'OP01_CLOSE' => 102
		},
		GOTOS => {
			'ListElement' => 132,
			'Expression' => 127,
			'TypeInner' => 130,
			'SubExpression' => 129,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'ArrayReference' => 113,
			'Variable' => 133,
			'Literal' => 86,
			'ListElements' => 291,
			'HashDereference' => 112,
			'WordScoped' => 81,
			'HashReference' => 108
		}
	},
	{#State 252
		DEFAULT => -134
	},
	{#State 253
		ACTIONS => {
			'OP21_LIST_COMMA' => 292
		}
	},
	{#State 254
		ACTIONS => {
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			"my" => 125,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			"undef" => 77,
			'OP01_QW' => 131,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'ListElements' => 293,
			'Variable' => 133,
			'Literal' => 86,
			'WordScoped' => 81,
			'HashReference' => 108,
			'ListElement' => 132,
			'Expression' => 127,
			'TypeInner' => 130,
			'SubExpression' => 129,
			'ArrayDereference' => 75,
			'Operator' => 101
		}
	},
	{#State 255
		ACTIONS => {
			"}" => 294,
			'OP21_LIST_COMMA' => 296
		},
		GOTOS => {
			'PAREN-48' => 295
		}
	},
	{#State 256
		ACTIONS => {
			'OP10_NAMED_UNARY' => -188,
			'WORD' => -188,
			'OP05_LOGICAL_NEG' => -188,
			'WORD_SCOPED' => -188,
			'VARIABLE_SYMBOL' => -188,
			'LITERAL_NUMBER' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			"my" => 125,
			'LBRACE' => -188,
			'OP03_MATH_INC_DEC' => -188,
			"\@{" => -188,
			'LPAREN' => -188,
			'OP01_NAMED' => -188,
			"undef" => -188,
			'OP01_CLOSE' => -188,
			'LITERAL_STRING' => -188,
			"%{" => -188,
			'OP01_OPEN' => -188,
			'LBRACKET' => -188,
			'WORD_UPPERCASE' => -188,
			'OP22_LOGICAL_NEG' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 297,
			'TypeInner' => 298
		}
	},
	{#State 257
		ACTIONS => {
			";" => 299,
			'OP19_VARIABLE_ASSIGN' => 300
		}
	},
	{#State 258
		ACTIONS => {
			";" => 301
		}
	},
	{#State 259
		ACTIONS => {
			";" => 302
		}
	},
	{#State 260
		DEFAULT => -87
	},
	{#State 261
		DEFAULT => -161
	},
	{#State 262
		ACTIONS => {
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP01_NAMED' => 126,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Expression' => 127,
			'SubExpression' => 303,
			'Operator' => 101,
			'ArrayDereference' => 75
		}
	},
	{#State 263
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 24,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'WORD' => 305,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'SubExpression' => 304,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'Expression' => 127,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'WordScoped' => 81,
			'HashReference' => 108,
			'ArrayReference' => 113
		}
	},
	{#State 264
		ACTIONS => {
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 71,
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 24,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 306,
			'Expression' => 127,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112,
			'ArrayReference' => 113
		}
	},
	{#State 265
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 307
		}
	},
	{#State 266
		ACTIONS => {
			'TYPE_INTEGER' => 308
		}
	},
	{#State 267
		DEFAULT => -116
	},
	{#State 268
		ACTIONS => {
			'WORD_UPPERCASE' => 309
		}
	},
	{#State 269
		DEFAULT => -41
	},
	{#State 270
		DEFAULT => -45
	},
	{#State 271
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP01_NAMED_VOID' => 87,
			'OP10_NAMED_UNARY' => 91,
			"foreach" => -139,
			"}" => 310,
			'LITERAL_NUMBER' => 85,
			"for" => -139,
			"if" => 76,
			"undef" => 77,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LBRACKET' => 71,
			"while" => -139,
			'LITERAL_STRING' => 74,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP19_LOOP_CONTROL' => 116,
			'LBRACE' => 106,
			'OP01_PRINT' => 109,
			"my" => 107,
			'OP05_MATH_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 103,
			'LPAREN' => 104,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 95,
			"%{" => 97,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'Variable' => 72,
			'LoopLabel' => 73,
			'VariableModification' => 98,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'Conditional' => 78,
			'Expression' => 105,
			'Statement' => 82,
			'HashReference' => 108,
			'WordScoped' => 81,
			'VariableDeclaration' => 83,
			'Operation' => 311,
			'HashDereference' => 112,
			'Literal' => 86,
			'ArrayReference' => 113,
			'OPTIONAL-35' => 114,
			'SubExpression' => 92,
			'OperatorVoid' => 93,
			'PAREN-34' => 94
		}
	},
	{#State 272
		ACTIONS => {
			'VARIABLE_SYMBOL' => 312
		}
	},
	{#State 273
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 313
		}
	},
	{#State 274
		DEFAULT => -55
	},
	{#State 275
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 314
		}
	},
	{#State 276
		ACTIONS => {
			'WORD' => 315
		}
	},
	{#State 277
		DEFAULT => -175
	},
	{#State 278
		DEFAULT => -179
	},
	{#State 279
		ACTIONS => {
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'LBRACE' => 106,
			"my" => 125,
			'OP05_MATH_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP01_QW' => 131,
			'OP01_NAMED' => 126,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71
		},
		GOTOS => {
			'Expression' => 127,
			'ListElement' => 316,
			'TypeInner' => 130,
			'SubExpression' => 129,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'Literal' => 86,
			'Variable' => 133,
			'WordScoped' => 81,
			'HashReference' => 108
		}
	},
	{#State 280
		DEFAULT => -172
	},
	{#State 281
		DEFAULT => -170
	},
	{#State 282
		DEFAULT => -119
	},
	{#State 283
		ACTIONS => {
			")" => 317
		}
	},
	{#State 284
		DEFAULT => -169
	},
	{#State 285
		ACTIONS => {
			'LBRACE' => 319
		},
		GOTOS => {
			'CodeBlock' => 318
		}
	},
	{#State 286
		DEFAULT => -186
	},
	{#State 287
		DEFAULT => -122
	},
	{#State 288
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'VariableOrLiteral' => 320,
			'Variable' => 242,
			'Literal' => 241
		}
	},
	{#State 289
		DEFAULT => -201
	},
	{#State 290
		ACTIONS => {
			'OP21_LIST_COMMA' => 321
		}
	},
	{#State 291
		ACTIONS => {
			";" => 322
		}
	},
	{#State 292
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			"my" => 125,
			'LBRACE' => 106,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			"undef" => 77,
			'OP01_QW' => 131,
			'OP01_CLOSE' => 102,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'LBRACKET' => 71,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128
		},
		GOTOS => {
			'ListElement' => 132,
			'Expression' => 127,
			'TypeInner' => 130,
			'SubExpression' => 129,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'ArrayReference' => 113,
			'ListElements' => 323,
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'HashReference' => 108,
			'WordScoped' => 81
		}
	},
	{#State 293
		ACTIONS => {
			")" => 324
		}
	},
	{#State 294
		DEFAULT => -196
	},
	{#State 295
		DEFAULT => -194
	},
	{#State 296
		ACTIONS => {
			"%{" => 97,
			'WORD' => 183
		},
		GOTOS => {
			'HashEntry' => 325,
			'HashDereference' => 182
		}
	},
	{#State 297
		ACTIONS => {
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			'LBRACKET' => 71,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'Literal' => 86,
			'Variable' => 133,
			'HashDereference' => 112,
			'WordScoped' => 81,
			'HashReference' => 108,
			'ArrayReference' => 113,
			'SubExpression' => 326,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'Expression' => 127
		}
	},
	{#State 298
		DEFAULT => -187
	},
	{#State 299
		DEFAULT => -167
	},
	{#State 300
		ACTIONS => {
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'STDIN' => 218,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Expression' => 127,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 220,
			'SubExpressionOrStdin' => 327,
			'ArrayReference' => 113,
			'WordScoped' => 81,
			'HashReference' => 108,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86
		}
	},
	{#State 301
		DEFAULT => -111
	},
	{#State 302
		DEFAULT => -110
	},
	{#State 303
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP04_MATH_POW' => 157,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163,
			"]" => 328,
			'OP17_LIST_RANGE' => 158,
			'OP13_BITWISE_AND' => 159,
			'OP23_LOGICAL_AND' => 151,
			'OP08_STRING_CAT' => 160,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 161,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153
		}
	},
	{#State 304
		ACTIONS => {
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 164,
			"}" => 329,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP17_LIST_RANGE' => 158,
			'OP13_BITWISE_AND' => 159,
			'OP23_LOGICAL_AND' => 151,
			'OP08_STRING_CAT' => 160,
			'OP16_LOGICAL_OR' => 150,
			'OP15_LOGICAL_AND' => 154,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153
		}
	},
	{#State 305
		ACTIONS => {
			'LPAREN' => -202,
			"}" => 330,
			'OP02_METHOD_THINARROW_NEW' => -202
		}
	},
	{#State 306
		ACTIONS => {
			'OP16_LOGICAL_OR' => 150,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 161,
			'OP15_LOGICAL_AND' => 154,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP09_BITWISE_SHIFT' => 155,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP04_MATH_POW' => 157,
			'OP17_LIST_RANGE' => 158,
			'OP13_BITWISE_AND' => 159,
			")" => 331
		}
	},
	{#State 307
		ACTIONS => {
			'VARIABLE_SYMBOL' => 332
		}
	},
	{#State 308
		ACTIONS => {
			'VARIABLE_SYMBOL' => 333
		}
	},
	{#State 309
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 334
		}
	},
	{#State 310
		ACTIONS => {
			";" => 335
		}
	},
	{#State 311
		DEFAULT => -44
	},
	{#State 312
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 336
		}
	},
	{#State 313
		ACTIONS => {
			"our" => 337,
			'LITERAL_NUMBER' => 339
		},
		GOTOS => {
			'Subroutine' => 341,
			'MethodOrSubroutine' => 340,
			'Method' => 338
		}
	},
	{#State 314
		ACTIONS => {
			'LBRACE' => 342
		}
	},
	{#State 315
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 343
		}
	},
	{#State 316
		DEFAULT => -171
	},
	{#State 317
		DEFAULT => -124
	},
	{#State 318
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 344
		}
	},
	{#State 319
		ACTIONS => {
			'OP01_NAMED' => 103,
			'OP01_CLOSE' => 102,
			"if" => 76,
			"undef" => 77,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 95,
			'OP22_LOGICAL_NEG' => 96,
			"while" => -139,
			"%{" => 97,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED_VOID' => 87,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			"foreach" => -139,
			'OP19_LOOP_CONTROL' => 116,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'OP01_PRINT' => 109,
			"my" => 107,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			"for" => -139
		},
		GOTOS => {
			'Conditional' => 78,
			'Expression' => 105,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'VariableModification' => 98,
			'LoopLabel' => 73,
			'Variable' => 72,
			'PAREN-34' => 94,
			'SubExpression' => 92,
			'OperatorVoid' => 93,
			'OPTIONAL-35' => 114,
			'PLUS-40' => 346,
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'Operation' => 345,
			'Literal' => 86,
			'HashReference' => 108,
			'Statement' => 82,
			'WordScoped' => 81,
			'VariableDeclaration' => 83
		}
	},
	{#State 320
		DEFAULT => -103
	},
	{#State 321
		ACTIONS => {
			'LITERAL_STRING' => 347
		}
	},
	{#State 322
		DEFAULT => -114
	},
	{#State 323
		ACTIONS => {
			")" => 348
		}
	},
	{#State 324
		DEFAULT => -78
	},
	{#State 325
		DEFAULT => -193
	},
	{#State 326
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158,
			'OP21_LIST_COMMA' => -189,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"}" => -189,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP04_MATH_POW' => 157,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 161,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 150,
			'OP23_LOGICAL_AND' => 151,
			'OP08_STRING_CAT' => 160
		}
	},
	{#State 327
		ACTIONS => {
			";" => 349
		}
	},
	{#State 328
		DEFAULT => -164
	},
	{#State 329
		DEFAULT => -165
	},
	{#State 330
		DEFAULT => -166
	},
	{#State 331
		ACTIONS => {
			'LBRACE' => 319
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 332
		ACTIONS => {
			'LPAREN' => 351
		}
	},
	{#State 333
		ACTIONS => {
			'LPAREN' => 352
		}
	},
	{#State 334
		DEFAULT => -208
	},
	{#State 335
		DEFAULT => -46
	},
	{#State 336
		ACTIONS => {
			'OP21_LIST_COMMA' => 355,
			")" => 354
		},
		GOTOS => {
			'PAREN-18' => 353
		}
	},
	{#State 337
		ACTIONS => {
			'TYPE_METHOD' => 356,
			'TYPE_INTEGER' => 58,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 338
		DEFAULT => -74
	},
	{#State 339
		ACTIONS => {
			";" => 357
		}
	},
	{#State 340
		DEFAULT => -57
	},
	{#State 341
		DEFAULT => -75
	},
	{#State 342
		ACTIONS => {
			"%{" => 97,
			"}" => 358,
			'WORD' => 360
		},
		GOTOS => {
			'HashEntryTyped' => 359,
			'HashDereference' => 361
		}
	},
	{#State 343
		DEFAULT => -207
	},
	{#State 344
		ACTIONS => {
			'LITERAL_STRING' => -150,
			"while" => -150,
			'LBRACKET' => -150,
			'' => -150,
			'OP03_MATH_INC_DEC' => -150,
			"\@{" => -150,
			"if" => -150,
			"undef" => -150,
			"for" => -150,
			"else" => 363,
			'LITERAL_NUMBER' => -150,
			"foreach" => -150,
			"}" => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP01_NAMED_VOID' => -150,
			"elsif" => 362,
			'OP10_NAMED_UNARY' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP01_OPEN' => -150,
			"%{" => -150,
			'WORD_UPPERCASE' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'LPAREN' => -150,
			'OP01_CLOSE' => -150,
			'OP01_NAMED' => -150,
			'WORD_SCOPED' => -150,
			'LBRACE' => -150,
			"my" => -150,
			'OP01_PRINT' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP19_LOOP_CONTROL' => -150,
			'OP05_LOGICAL_NEG' => -150,
			'WORD' => -150
		},
		GOTOS => {
			'PAREN-38' => 365,
			'PAREN-36' => 366,
			'OPTIONAL-39' => 364
		}
	},
	{#State 345
		DEFAULT => -159
	},
	{#State 346
		ACTIONS => {
			"while" => -139,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 71,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			"if" => 76,
			"undef" => 77,
			"for" => -139,
			'LITERAL_NUMBER' => 85,
			"foreach" => -139,
			"}" => 368,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP01_NAMED_VOID' => 87,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 95,
			'LPAREN' => 104,
			'OP01_NAMED' => 103,
			'OP01_CLOSE' => 102,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'OP01_PRINT' => 109,
			"my" => 107,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP19_LOOP_CONTROL' => 116,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'VariableDeclaration' => 83,
			'Statement' => 82,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Literal' => 86,
			'Operation' => 367,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'OPTIONAL-35' => 114,
			'OperatorVoid' => 93,
			'SubExpression' => 92,
			'PAREN-34' => 94,
			'Variable' => 72,
			'LoopLabel' => 73,
			'VariableModification' => 98,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'Expression' => 105,
			'Conditional' => 78
		}
	},
	{#State 347
		ACTIONS => {
			'OP21_LIST_COMMA' => 369
		}
	},
	{#State 348
		DEFAULT => -80
	},
	{#State 349
		DEFAULT => -168
	},
	{#State 350
		DEFAULT => -157
	},
	{#State 351
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			"my" => 125,
			'OP10_NAMED_UNARY' => 91,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			"undef" => 77,
			'OP01_QW' => 131,
			'OP01_CLOSE' => 102
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'Literal' => 86,
			'ListElements' => 370,
			'Variable' => 133,
			'HashReference' => 108,
			'WordScoped' => 81,
			'ListElement' => 132,
			'Expression' => 127,
			'TypeInner' => 130,
			'SubExpression' => 129,
			'Operator' => 101,
			'ArrayDereference' => 75
		}
	},
	{#State 352
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'LBRACE' => 106,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'OP01_NAMED' => 126,
			'OP01_CLOSE' => 102,
			"undef" => 77,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104
		},
		GOTOS => {
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Expression' => 127,
			'SubExpression' => 371,
			'ArrayDereference' => 75,
			'Operator' => 101
		}
	},
	{#State 353
		DEFAULT => -48
	},
	{#State 354
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 372
		}
	},
	{#State 355
		ACTIONS => {
			"my" => 373
		}
	},
	{#State 356
		ACTIONS => {
			'VARIABLE_SYMBOL' => 374
		}
	},
	{#State 357
		DEFAULT => -59
	},
	{#State 358
		ACTIONS => {
			";" => 375
		}
	},
	{#State 359
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 376
		}
	},
	{#State 360
		ACTIONS => {
			'OP20_HASH_FATARROW' => 377
		}
	},
	{#State 361
		DEFAULT => -192
	},
	{#State 362
		ACTIONS => {
			'LPAREN' => 378
		}
	},
	{#State 363
		ACTIONS => {
			'LBRACE' => 319
		},
		GOTOS => {
			'CodeBlock' => 379
		}
	},
	{#State 364
		DEFAULT => -151
	},
	{#State 365
		DEFAULT => -149
	},
	{#State 366
		DEFAULT => -146
	},
	{#State 367
		DEFAULT => -158
	},
	{#State 368
		DEFAULT => -160
	},
	{#State 369
		ACTIONS => {
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115,
			'OP10_NAMED_UNARY' => 91,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 85,
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			"%{" => 97,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71
		},
		GOTOS => {
			'SubExpression' => 380,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'Expression' => 127,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'WordScoped' => 81,
			'HashReference' => 108,
			'ArrayReference' => 113
		}
	},
	{#State 370
		ACTIONS => {
			")" => 381
		}
	},
	{#State 371
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP15_LOGICAL_AND' => 154,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP16_LOGICAL_OR' => 150,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151,
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 382,
			'OP08_MATH_ADD_SUB' => 156,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP09_BITWISE_SHIFT' => 155,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166
		}
	},
	{#State 372
		ACTIONS => {
			"\@_;" => 383
		}
	},
	{#State 373
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 384
		}
	},
	{#State 374
		ACTIONS => {
			"= sub {" => 385
		}
	},
	{#State 375
		DEFAULT => -64
	},
	{#State 376
		ACTIONS => {
			"}" => 388,
			'OP21_LIST_COMMA' => 386
		},
		GOTOS => {
			'PAREN-24' => 387
		}
	},
	{#State 377
		ACTIONS => {
			"my" => 125
		},
		GOTOS => {
			'TypeInner' => 389
		}
	},
	{#State 378
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80,
			'LPAREN' => 104,
			'OP01_NAMED' => 126,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'OP10_NAMED_UNARY' => 91,
			'WORD' => 26,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'Expression' => 127,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 390,
			'ArrayReference' => 113,
			'WordScoped' => 81,
			'HashReference' => 108,
			'HashDereference' => 112,
			'Literal' => 86,
			'Variable' => 133
		}
	},
	{#State 379
		DEFAULT => -148
	},
	{#State 380
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158,
			")" => -81,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP21_LIST_COMMA' => -81,
			"]" => -81,
			"}" => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP04_MATH_POW' => 157,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP15_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 162,
			'OP07_STRING_REPEAT' => 161,
			'OP16_LOGICAL_OR' => 150,
			";" => -81,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => -81
		}
	},
	{#State 381
		ACTIONS => {
			'LBRACE' => 319
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 382
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 128,
			'LBRACKET' => 71,
			'LITERAL_STRING' => 74,
			"%{" => 97,
			'OP01_OPEN' => 100,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'LPAREN' => 104,
			'OP03_MATH_INC_DEC' => 79,
			"\@{" => 80
		},
		GOTOS => {
			'WordScoped' => 81,
			'HashReference' => 108,
			'HashDereference' => 112,
			'Variable' => 133,
			'Literal' => 86,
			'ArrayReference' => 113,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'SubExpression' => 392,
			'Expression' => 127
		}
	},
	{#State 383
		DEFAULT => -50
	},
	{#State 384
		ACTIONS => {
			'VARIABLE_SYMBOL' => 393
		}
	},
	{#State 385
		ACTIONS => {
			"undef" => -66,
			"if" => -66,
			"\@{" => -66,
			'LPAREN_MY' => 396,
			'OP03_MATH_INC_DEC' => -66,
			'LBRACKET' => -66,
			'LITERAL_STRING' => -66,
			"while" => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP01_NAMED_VOID' => -66,
			"foreach" => -66,
			'LITERAL_NUMBER' => -66,
			"for" => -66,
			'OP01_NAMED' => -66,
			'OP01_CLOSE' => -66,
			'LPAREN' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'WORD_UPPERCASE' => -66,
			'OP01_OPEN' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			"%{" => -66,
			'WORD' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"my" => -66,
			'LBRACE' => -66,
			'OP01_PRINT' => -66,
			'WORD_SCOPED' => -66
		},
		GOTOS => {
			'MethodArguments' => 395,
			'OPTIONAL-26' => 394
		}
	},
	{#State 386
		ACTIONS => {
			'WORD' => 360,
			"%{" => 97
		},
		GOTOS => {
			'HashEntryTyped' => 397,
			'HashDereference' => 361
		}
	},
	{#State 387
		DEFAULT => -61
	},
	{#State 388
		ACTIONS => {
			";" => 398
		}
	},
	{#State 389
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			"undef" => 77,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 126,
			'LPAREN' => 104,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'WORD_UPPERCASE' => 128,
			'OP22_LOGICAL_NEG' => 96,
			'LBRACKET' => 71,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			"%{" => 97
		},
		GOTOS => {
			'Operator' => 101,
			'ArrayDereference' => 75,
			'SubExpression' => 399,
			'Expression' => 127,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Variable' => 133,
			'Literal' => 86,
			'HashDereference' => 112,
			'ArrayReference' => 113
		}
	},
	{#State 390
		ACTIONS => {
			'OP16_LOGICAL_OR' => 150,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP11_COMPARE_LT_GT' => 153,
			'OP15_LOGICAL_AND' => 154,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			")" => 400,
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158
		}
	},
	{#State 391
		DEFAULT => -156
	},
	{#State 392
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP08_STRING_CAT' => 160,
			'OP16_LOGICAL_OR' => 150,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => -102,
			'OP15_LOGICAL_AND' => 154,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP09_BITWISE_SHIFT' => 155,
			'OP08_MATH_ADD_SUB' => 156,
			")" => 401,
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 393
		DEFAULT => -47
	},
	{#State 394
		ACTIONS => {
			"while" => -139,
			'LITERAL_STRING' => 74,
			'OP01_OPEN' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			"%{" => 97,
			'LBRACKET' => 71,
			'WORD_UPPERCASE' => 95,
			'OP22_LOGICAL_NEG' => 96,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			'LPAREN' => 104,
			'OP01_NAMED' => 103,
			"undef" => 77,
			"if" => 76,
			'OP01_CLOSE' => 102,
			"for" => -139,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 106,
			'OP01_PRINT' => 109,
			"my" => 107,
			"foreach" => -139,
			'OP19_LOOP_CONTROL' => 116,
			'OP10_NAMED_UNARY' => 91,
			'OP01_NAMED_VOID' => 87,
			'WORD' => 26,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'OPTIONAL-35' => 114,
			'SubExpression' => 92,
			'OperatorVoid' => 93,
			'PAREN-34' => 94,
			'WordScoped' => 81,
			'HashReference' => 108,
			'Statement' => 82,
			'VariableDeclaration' => 83,
			'Operation' => 403,
			'HashDereference' => 112,
			'Literal' => 86,
			'ArrayReference' => 113,
			'ArrayDereference' => 75,
			'Operator' => 101,
			'Conditional' => 78,
			'Expression' => 105,
			'PLUS-27' => 402,
			'Variable' => 72,
			'LoopLabel' => 73,
			'VariableModification' => 98
		}
	},
	{#State 395
		DEFAULT => -65
	},
	{#State 396
		ACTIONS => {
			'TYPE_SELF' => 404
		}
	},
	{#State 397
		DEFAULT => -60
	},
	{#State 398
		DEFAULT => -63
	},
	{#State 399
		ACTIONS => {
			'OP13_BITWISE_AND' => 159,
			'OP17_LIST_RANGE' => 158,
			'OP21_LIST_COMMA' => -191,
			'OP14_BITWISE_OR_XOR' => 163,
			'OP08_MATH_ADD_SUB' => 156,
			'OP09_BITWISE_SHIFT' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP04_MATH_POW' => 157,
			"}" => -191,
			'OP24_LOGICAL_OR_XOR' => 164,
			'OP11_COMPARE_LT_GT' => 153,
			'OP12_COMPARE_EQ_NE' => 152,
			'OP07_STRING_REPEAT' => 161,
			'OP18_TERNARY' => 162,
			'OP15_LOGICAL_AND' => 154,
			'OP16_LOGICAL_OR' => 150,
			'OP08_STRING_CAT' => 160,
			'OP23_LOGICAL_AND' => 151
		}
	},
	{#State 400
		ACTIONS => {
			'LBRACE' => 319
		},
		GOTOS => {
			'CodeBlock' => 405
		}
	},
	{#State 401
		ACTIONS => {
			'LBRACE' => 319
		},
		GOTOS => {
			'CodeBlock' => 406
		}
	},
	{#State 402
		ACTIONS => {
			"}" => 408,
			"foreach" => -139,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP01_NAMED_VOID' => 87,
			'OP10_NAMED_UNARY' => 91,
			"for" => -139,
			'LITERAL_NUMBER' => 85,
			"\@{" => 80,
			'OP03_MATH_INC_DEC' => 79,
			"undef" => 77,
			"if" => 76,
			'LITERAL_STRING' => 74,
			"while" => -139,
			'LBRACKET' => 71,
			'OP19_LOOP_CONTROL' => 116,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 26,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_PRINT' => 109,
			'LBRACE' => 106,
			"my" => 107,
			'VARIABLE_SYMBOL' => 111,
			'LPAREN' => 104,
			'OP01_CLOSE' => 102,
			'OP01_NAMED' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			"%{" => 97,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 96,
			'WORD_UPPERCASE' => 95
		},
		GOTOS => {
			'VariableModification' => 98,
			'LoopLabel' => 73,
			'Variable' => 72,
			'Expression' => 105,
			'Conditional' => 78,
			'Operator' => 101,
			'ArrayDereference' => 75,
			'ArrayReference' => 113,
			'Literal' => 86,
			'HashDereference' => 112,
			'Operation' => 407,
			'VariableDeclaration' => 83,
			'HashReference' => 108,
			'Statement' => 82,
			'WordScoped' => 81,
			'PAREN-34' => 94,
			'OperatorVoid' => 93,
			'SubExpression' => 92,
			'OPTIONAL-35' => 114
		}
	},
	{#State 403
		DEFAULT => -68
	},
	{#State 404
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 409
		}
	},
	{#State 405
		DEFAULT => -145
	},
	{#State 406
		DEFAULT => -155
	},
	{#State 407
		DEFAULT => -67
	},
	{#State 408
		ACTIONS => {
			";" => 410
		}
	},
	{#State 409
		ACTIONS => {
			'OP21_LIST_COMMA' => 411,
			")" => 412
		},
		GOTOS => {
			'PAREN-28' => 413
		}
	},
	{#State 410
		DEFAULT => -69
	},
	{#State 411
		ACTIONS => {
			"my" => 414
		}
	},
	{#State 412
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 415
		}
	},
	{#State 413
		DEFAULT => -71
	},
	{#State 414
		ACTIONS => {
			'TYPE_INTEGER' => 58,
			'WORD' => 56
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
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5852 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5863 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5870 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5877 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5898 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5905 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5912 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5919 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5926 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5933 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5947 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5958 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5965 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5972 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5994 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6005 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6012 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6019 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6026 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6033 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6083 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6090 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6097 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6108 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6144 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6155 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6162 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6169 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6194 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6226 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6233 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6240 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6247 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6254 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6275 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6336 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6343 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6350 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6357 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6364 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6375 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6382 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6389 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6396 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6407 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6418 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6429 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6440 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6451 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6462 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6473 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6484 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6495 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6517 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6528 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6539 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6550 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6561 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6572 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6583 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6594 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6605 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6616 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6627 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6638 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6660 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6671 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6682 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6693 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6704 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6715 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6726 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6748 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6759 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6770 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6777 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6784 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6802 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6824 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6835 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6846 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6857 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6868 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6889 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6896 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6907 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6918 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6929 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6940 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6951 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6962 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7028 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7126 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7137 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7148 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7162 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7169 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7190 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7212 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7223 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7234 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7256 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7281 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7299 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7306 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_174
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7426 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7433 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7473 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7480 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7487 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7512 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_185
		 'ArrayDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7523 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_186
		 'ArrayDereference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7534 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7559 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7592 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7599 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7613 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_196
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7624 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_197
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7635 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7642 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_200
		 'HashDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7660 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_201
		 'HashDereference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_202
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_203
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7693 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_204
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7704 lib/RPerl/Grammar.pm
	],
	[#Rule Type_205
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7715 lib/RPerl/Grammar.pm
	],
	[#Rule Type_206
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7726 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_207
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7737 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_208
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7748 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_209
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_210
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_211
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7781 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_212
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7792 lib/RPerl/Grammar.pm
	]
],
#line 7795 lib/RPerl/Grammar.pm
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


#line 8056 lib/RPerl/Grammar.pm



1;
