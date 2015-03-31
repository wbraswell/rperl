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
    our $VERSION = 0.000_981;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|\$TYPED_|foreach|package|\=\ sub\ \{|elsif|undef|while|else|use|our|for|\@_\;|my|if|\@\{|\%\{|\)|\]|\}|\;)}gc and return ($1, $1);

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
      /\G([a-zA-Z]\w*|[a-z])/gc and return ('WORD', $1);
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
  [ 'HashDereference_198' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_199' => 'HashDereference', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_200' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_201' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_202' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_203' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_204' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_205' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_206' => 'TypeInnerConstant', [ 'my', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_207' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_208' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'Literal_209' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_210' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'HashDereference_198' => 198,
  'HashDereference_199' => 199,
  'WordScoped_200' => 200,
  'WordScoped_201' => 201,
  'LoopLabel_202' => 202,
  'Type_203' => 203,
  'Type_204' => 204,
  'TypeInner_205' => 205,
  'TypeInnerConstant_206' => 206,
  'VariableOrLiteral_207' => 207,
  'VariableOrLiteral_208' => 208,
  'Literal_209' => 209,
  'Literal_210' => 210,
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
			"## no critic qw(" => 8,
			'SHEBANG' => 2,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 5,
			'CompileUnit' => 4,
			'Critic' => 1,
			'PLUS-2' => 9,
			'Program' => 3,
			'PAREN-1' => 7,
			'ModuleHeader' => 6
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 11,
			'OPTIONAL-3' => 10
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			'' => 12
		}
	},
	{#State 5
		ACTIONS => {
			"package" => 13
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => -25,
			"use constant" => -25,
			"use parent qw(" => 15,
			"our" => -25,
			"use" => -25
		},
		GOTOS => {
			'STAR-10' => 14,
			'Class' => 17,
			'Package' => 18,
			'Module' => 16
		}
	},
	{#State 7
		DEFAULT => -3
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
			"## no critic qw(" => 8,
			'' => -5,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 21,
			'ModuleHeader' => 6,
			'OPTIONAL-9' => 5,
			'Critic' => 1
		}
	},
	{#State 10
		ACTIONS => {
			"use strict;" => 23
		},
		GOTOS => {
			'Header' => 22
		}
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 14
		ACTIONS => {
			"use constant" => -27,
			"## no critic qw(" => 8,
			"use" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 28,
			'Critic' => 27
		}
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		DEFAULT => -23
	},
	{#State 18
		DEFAULT => -22
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
		DEFAULT => -200
	},
	{#State 25
		DEFAULT => -201
	},
	{#State 26
		ACTIONS => {
			";" => 34
		}
	},
	{#State 27
		DEFAULT => -24
	},
	{#State 28
		ACTIONS => {
			"our" => -29,
			"use" => 37,
			"use constant" => -29
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
			"while" => -11,
			"## no critic qw(" => 8,
			'OP01_CLOSE' => -11,
			"use" => -11,
			"our" => -11,
			"%{" => -11,
			'LBRACE' => -11,
			"\@{" => -11,
			'LPAREN' => -11,
			'LBRACKET' => -11,
			"if" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"undef" => -11,
			'OP01_NAMED_VOID' => -11,
			'WORD' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"foreach" => -11,
			"use constant" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_OPEN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"for" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'WORD_SCOPED' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LITERAL_NUMBER' => -11,
			'VARIABLE_SYMBOL' => -11,
			"my" => -11,
			'WORD_UPPERCASE' => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED' => -11,
			'OP01_PRINT' => -11
		},
		GOTOS => {
			'Critic' => 39,
			'STAR-5' => 40
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
			"use constant" => 45,
			"our" => 43
		},
		GOTOS => {
			'PLUS-13' => 47,
			'Subroutine' => 46,
			'Constant' => 44
		}
	},
	{#State 36
		DEFAULT => -26
	},
	{#State 37
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 25
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
		DEFAULT => -8
	},
	{#State 40
		ACTIONS => {
			'OP01_OPEN' => -13,
			'OP10_NAMED_UNARY' => -13,
			"use constant" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"foreach" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'WORD' => -13,
			'OP01_NAMED_VOID' => -13,
			"my" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED' => -13,
			'OP01_PRINT' => -13,
			'LITERAL_STRING' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"for" => -13,
			'WORD_SCOPED' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"\@{" => -13,
			"our" => -13,
			"use" => 37,
			'OP01_CLOSE' => -13,
			"while" => -13,
			'LBRACE' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			"undef" => -13,
			'LPAREN' => -13,
			"if" => -13,
			'LBRACKET' => -13
		},
		GOTOS => {
			'STAR-6' => 50,
			'Include' => 51
		}
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
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		ACTIONS => {
			'WORD_UPPERCASE' => 56
		}
	},
	{#State 46
		DEFAULT => -31
	},
	{#State 47
		ACTIONS => {
			'LITERAL_NUMBER' => 58,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 48
		ACTIONS => {
			";" => 59,
			'OP01_QW' => 60
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 37
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 50
		ACTIONS => {
			'LBRACE' => -15,
			"%{" => -15,
			"our" => -15,
			'OP01_CLOSE' => -15,
			"while" => -15,
			"\@{" => -15,
			'LBRACKET' => -15,
			"if" => -15,
			'LPAREN' => -15,
			"undef" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"foreach" => -15,
			'OP01_NAMED_VOID' => -15,
			'WORD' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_OPEN' => -15,
			"use constant" => 45,
			'WORD_SCOPED' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"for" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LITERAL_STRING' => -15,
			'OP01_NAMED' => -15,
			'OP01_PRINT' => -15,
			'WORD_UPPERCASE' => -15,
			'VARIABLE_SYMBOL' => -15,
			"my" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LITERAL_NUMBER' => -15
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
		DEFAULT => -203
	},
	{#State 54
		DEFAULT => -204
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 56
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
		}
	},
	{#State 57
		DEFAULT => -30
	},
	{#State 58
		ACTIONS => {
			";" => 67
		}
	},
	{#State 59
		DEFAULT => -39
	},
	{#State 60
		ACTIONS => {
			'WORD' => 69
		},
		GOTOS => {
			'PLUS-15' => 68
		}
	},
	{#State 61
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 70
		}
	},
	{#State 62
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 99,
			"undef" => 102,
			'LPAREN' => 103,
			"if" => 105,
			'LBRACKET' => 104,
			"\@{" => 109,
			"our" => 43,
			'OP01_CLOSE' => 111,
			"while" => -139,
			'LBRACE' => 112,
			"%{" => 116,
			"my" => 72,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'OP01_NAMED' => 78,
			'OP01_PRINT' => 79,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 81,
			'OP01_NAMED_VOID_SCOLON' => 82,
			'OP03_MATH_INC_DEC' => 86,
			"for" => -139,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92,
			"foreach" => -139,
			'OP22_LOGICAL_NEG' => 95,
			'WORD' => 24,
			'OP01_NAMED_VOID' => 98
		},
		GOTOS => {
			'VariableModification' => 115,
			'OperatorVoid' => 114,
			'Expression' => 97,
			'Literal' => 113,
			'LoopLabel' => 96,
			'PAREN-34' => 94,
			'Operator' => 110,
			'SubExpression' => 93,
			'HashReference' => 91,
			'VariableDeclaration' => 108,
			'ArrayDereference' => 107,
			'Conditional' => 106,
			'OPTIONAL-35' => 87,
			'WordScoped' => 85,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'PLUS-8' => 80,
			'Subroutine' => 101,
			'Variable' => 100,
			'Operation' => 76,
			'Statement' => 73
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
			"= sub {" => 117
		}
	},
	{#State 66
		ACTIONS => {
			"my" => 119
		},
		GOTOS => {
			'TypeInnerConstant' => 118
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		ACTIONS => {
			")" => 120,
			'WORD' => 121
		}
	},
	{#State 69
		DEFAULT => -38
	},
	{#State 70
		ACTIONS => {
			"our hash_ref \$properties" => -54,
			"use" => -54,
			"## no critic qw(" => 8,
			"use constant" => -54
		},
		GOTOS => {
			'Critic' => 122,
			'STAR-21' => 123
		}
	},
	{#State 71
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 124
		}
	},
	{#State 72
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 125
		}
	},
	{#State 73
		DEFAULT => -77
	},
	{#State 74
		DEFAULT => -115
	},
	{#State 75
		DEFAULT => -210
	},
	{#State 76
		DEFAULT => -17
	},
	{#State 77
		DEFAULT => -209
	},
	{#State 78
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'WORD' => 24,
			"%{" => 116,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 132,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			"my" => 134,
			'OP01_QW' => 126,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103
		},
		GOTOS => {
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'WordScoped' => 85,
			'ListElement' => 130,
			'SubExpression' => 129,
			'TypeInner' => 131,
			'HashReference' => 91,
			'Variable' => 127
		}
	},
	{#State 79
		ACTIONS => {
			'OP01_CLOSE' => -109,
			'STDOUT_STDERR' => 136,
			'WORD' => -109,
			"%{" => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LBRACE' => -109,
			"\@{" => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP01_OPEN' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'LPAREN' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'OP01_QW' => -109,
			'LBRACKET' => -109,
			'WORD_SCOPED' => -109,
			'LITERAL_NUMBER' => -109,
			'VARIABLE_SYMBOL' => -109,
			"my" => -109,
			'FH_REF_SYMBOL_BRACES' => 135,
			'WORD_UPPERCASE' => -109,
			"undef" => -109,
			'LITERAL_STRING' => -109,
			'OP01_NAMED' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 138,
			'PAREN-30' => 137
		}
	},
	{#State 80
		ACTIONS => {
			'LBRACE' => 112,
			"%{" => 116,
			'OP01_CLOSE' => 111,
			"while" => -139,
			"\@{" => 109,
			"if" => 105,
			'LBRACKET' => 104,
			'LPAREN' => 103,
			"undef" => 102,
			'OP19_LOOP_CONTROL' => 99,
			"foreach" => -139,
			'OP22_LOGICAL_NEG' => 95,
			'' => -18,
			'WORD' => 24,
			'OP01_NAMED_VOID' => 98,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_NAMED_VOID_SCOLON' => 82,
			'OP03_MATH_INC_DEC' => 86,
			"for" => -139,
			'OP01_NAMED' => 78,
			'OP01_PRINT' => 79,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 81,
			"my" => 72,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 74
		},
		GOTOS => {
			'Operator' => 110,
			'PAREN-34' => 94,
			'Literal' => 113,
			'LoopLabel' => 96,
			'Expression' => 97,
			'OperatorVoid' => 114,
			'VariableModification' => 115,
			'VariableDeclaration' => 108,
			'HashReference' => 91,
			'SubExpression' => 93,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'WordScoped' => 85,
			'OPTIONAL-35' => 87,
			'Conditional' => 106,
			'ArrayDereference' => 107,
			'Statement' => 73,
			'Variable' => 100,
			'Operation' => 139
		}
	},
	{#State 81
		ACTIONS => {
			'COLON' => -202,
			'LPAREN' => 140
		}
	},
	{#State 82
		DEFAULT => -112
	},
	{#State 83
		DEFAULT => -133
	},
	{#State 84
		DEFAULT => -130
	},
	{#State 85
		ACTIONS => {
			'LPAREN' => 142,
			'OP02_METHOD_THINARROW_NEW' => 141
		}
	},
	{#State 86
		ACTIONS => {
			'VARIABLE_SYMBOL' => 71
		},
		GOTOS => {
			'Variable' => 143
		}
	},
	{#State 87
		ACTIONS => {
			"while" => 148,
			"for" => 146,
			"foreach" => 144
		},
		GOTOS => {
			'Loop' => 150,
			'LoopFor' => 147,
			'LoopForEach' => 145,
			'LoopWhile' => 149
		}
	},
	{#State 88
		ACTIONS => {
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 132,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 116,
			'WORD' => 24,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 151
		}
	},
	{#State 89
		ACTIONS => {
			"%{" => 116,
			'OP21_LIST_COMMA' => -95,
			'LBRACE' => 112,
			"]" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP01_CLOSE' => 111,
			'OP09_BITWISE_SHIFT' => -95,
			'OP08_STRING_CAT' => -95,
			"\@{" => 109,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'LBRACKET' => 104,
			'OP08_MATH_ADD_SUB' => -95,
			'LPAREN' => 103,
			'OP24_LOGICAL_OR_XOR' => -95,
			"undef" => 102,
			'OP07_STRING_REPEAT' => -95,
			'WORD' => 24,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP22_LOGICAL_NEG' => 95,
			'OP17_LIST_RANGE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP05_LOGICAL_NEG' => 92,
			";" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP04_MATH_POW' => -95,
			'WORD_SCOPED' => 25,
			'OP03_MATH_INC_DEC' => 86,
			")" => -95,
			'WORD_UPPERCASE' => 132,
			"}" => -95,
			'OP01_NAMED' => 133,
			'OP18_TERNARY' => -95,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71
		},
		GOTOS => {
			'HashReference' => 91,
			'Variable' => 127,
			'SubExpression' => 152,
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113
		}
	},
	{#State 90
		ACTIONS => {
			"my" => 153
		}
	},
	{#State 91
		DEFAULT => -132
	},
	{#State 92
		ACTIONS => {
			'WORD_UPPERCASE' => 132,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"%{" => 116,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'HashReference' => 91,
			'Variable' => 127,
			'SubExpression' => 154,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107
		}
	},
	{#State 93
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 156,
			'OP08_STRING_CAT' => 164,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171
		}
	},
	{#State 94
		DEFAULT => -138
	},
	{#State 95
		ACTIONS => {
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			"%{" => 116,
			'WORD' => 24,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104
		},
		GOTOS => {
			'HashReference' => 91,
			'Variable' => 127,
			'SubExpression' => 172,
			'WordScoped' => 85,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113
		}
	},
	{#State 96
		ACTIONS => {
			'COLON' => 173
		}
	},
	{#State 97
		ACTIONS => {
			'OP18_TERNARY' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP04_MATH_POW' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP08_STRING_CAT' => -126,
			";" => 174,
			'OP16_LOGICAL_OR' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP11_COMPARE_LT_GT' => -126
		}
	},
	{#State 98
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_QW' => 126,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_UPPERCASE' => 132,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			"my" => 134,
			'WORD' => 24,
			"%{" => 116,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90
		},
		GOTOS => {
			'TypeInner' => 131,
			'HashReference' => 91,
			'Variable' => 127,
			'ListElements' => 175,
			'ListElement' => 177,
			'SubExpression' => 176,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128
		}
	},
	{#State 99
		ACTIONS => {
			'WORD_UPPERCASE' => 179
		},
		GOTOS => {
			'LoopLabel' => 178
		}
	},
	{#State 100
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP19_VARIABLE_ASSIGN' => 180,
			'OP13_BITWISE_AND' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP02_METHOD_THINARROW' => 181,
			'OP08_MATH_ADD_SUB' => -129,
			'OP04_MATH_POW' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 183,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP03_MATH_INC_DEC' => 182,
			'OP18_TERNARY' => -129,
			'OP07_STRING_REPEAT' => -129
		}
	},
	{#State 101
		DEFAULT => -14
	},
	{#State 102
		DEFAULT => -127
	},
	{#State 103
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 186,
			'OP01_PRINT' => 185,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_CLOSE' => 111,
			'WORD' => 24,
			"%{" => 116,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'SubExpression' => 184,
			'Variable' => 127,
			'HashReference' => 91,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'WordScoped' => 85,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110
		}
	},
	{#State 104
		ACTIONS => {
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92,
			"]" => -181,
			'OP01_CLOSE' => 111,
			'WORD' => 24,
			"%{" => 116,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			'LITERAL_NUMBER' => 75,
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'OP01_QW' => 126,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104
		},
		GOTOS => {
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'WordScoped' => 85,
			'HashDereference' => 83,
			'OPTIONAL-45' => 188,
			'ArrayReference' => 84,
			'Operator' => 110,
			'SubExpression' => 176,
			'ListElement' => 177,
			'HashReference' => 91,
			'Variable' => 127,
			'ListElements' => 187,
			'TypeInner' => 131
		}
	},
	{#State 105
		ACTIONS => {
			'LPAREN' => 189
		}
	},
	{#State 106
		DEFAULT => -140
	},
	{#State 107
		DEFAULT => -131
	},
	{#State 108
		DEFAULT => -143
	},
	{#State 109
		ACTIONS => {
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			'LBRACKET' => -184
		},
		GOTOS => {
			'OPTIONAL-46' => 192,
			'Variable' => 191,
			'TypeInner' => 190
		}
	},
	{#State 110
		DEFAULT => -121
	},
	{#State 111
		ACTIONS => {
			'FH_REF_SYMBOL' => 193
		}
	},
	{#State 112
		ACTIONS => {
			"%{" => 116,
			'WORD' => 196,
			"}" => 195
		},
		GOTOS => {
			'HashDereference' => 194,
			'HashEntry' => 197
		}
	},
	{#State 113
		DEFAULT => -128
	},
	{#State 114
		DEFAULT => -142
	},
	{#State 115
		DEFAULT => -144
	},
	{#State 116
		ACTIONS => {
			'LBRACE' => 112,
			'VARIABLE_SYMBOL' => 71
		},
		GOTOS => {
			'HashReference' => 198,
			'Variable' => 199
		}
	},
	{#State 117
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -43,
			'WORD_SCOPED' => -43,
			"for" => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'WORD_UPPERCASE' => -43,
			'LITERAL_STRING' => -43,
			'OP01_PRINT' => -43,
			'OP01_NAMED' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'LITERAL_NUMBER' => -43,
			'VARIABLE_SYMBOL' => -43,
			"my" => -43,
			'OP01_NAMED_VOID' => -43,
			'WORD' => -43,
			'OP22_LOGICAL_NEG' => -43,
			"foreach" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_OPEN' => -43,
			'LBRACKET' => -43,
			'LPAREN_MY' => 202,
			"if" => -43,
			'LPAREN' => -43,
			"undef" => -43,
			'OP19_LOOP_CONTROL' => -43,
			"%{" => -43,
			'LBRACE' => -43,
			'OP01_CLOSE' => -43,
			"while" => -43,
			"\@{" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 200,
			'OPTIONAL-16' => 201
		}
	},
	{#State 118
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Literal' => 203
		}
	},
	{#State 119
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 120
		ACTIONS => {
			";" => 205
		}
	},
	{#State 121
		DEFAULT => -37
	},
	{#State 122
		DEFAULT => -51
	},
	{#State 123
		ACTIONS => {
			"use" => 37,
			"our hash_ref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 207,
			'STAR-22' => 206
		}
	},
	{#State 124
		ACTIONS => {
			'OP16_LOGICAL_OR' => -163,
			'COLON' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP13_BITWISE_AND' => -163,
			'OP08_STRING_CAT' => -163,
			'OP02_HASH_THINARROW' => 210,
			";" => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP17_LIST_RANGE' => -163,
			"]" => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP02_ARRAY_THINARROW' => 208,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP07_STRING_REPEAT' => -163,
			"}" => -163,
			'OP18_TERNARY' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			")" => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP04_MATH_POW' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP08_MATH_ADD_SUB' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 209
		}
	},
	{#State 125
		ACTIONS => {
			'VARIABLE_SYMBOL' => 211
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 213
		},
		GOTOS => {
			'PLUS-44' => 212
		}
	},
	{#State 127
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -129,
			'OP23_LOGICAL_AND' => -129,
			"]" => -129,
			'OP17_LIST_RANGE' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP08_STRING_CAT' => -129,
			";" => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP13_BITWISE_AND' => -129,
			")" => -129,
			'OP03_MATH_INC_DEC' => 182,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP04_MATH_POW' => -129,
			'OP02_METHOD_THINARROW' => 181,
			'OP08_MATH_ADD_SUB' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP18_TERNARY' => -129,
			"}" => -129
		}
	},
	{#State 128
		DEFAULT => -126
	},
	{#State 129
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_STRING_CAT' => -79,
			";" => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP21_LIST_COMMA' => -177,
			'OP23_LOGICAL_AND' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP18_TERNARY' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP04_MATH_POW' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			")" => -79
		}
	},
	{#State 130
		ACTIONS => {
			'OP21_LIST_COMMA' => 214
		}
	},
	{#State 131
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'WORD' => 24,
			"%{" => 116,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'SubExpression' => 215,
			'Variable' => 127,
			'HashReference' => 91
		}
	},
	{#State 132
		ACTIONS => {
			'LPAREN' => 140
		}
	},
	{#State 133
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"%{" => 116,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113,
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'SubExpression' => 216,
			'HashReference' => 91,
			'Variable' => 127
		}
	},
	{#State 134
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 217
		}
	},
	{#State 135
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"%{" => 116,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 71,
			"my" => 134,
			'LITERAL_NUMBER' => 75,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP01_QW' => 126,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'ListElements' => 218,
			'Variable' => 127,
			'HashReference' => 91,
			'TypeInner' => 131,
			'SubExpression' => 176,
			'ListElement' => 177
		}
	},
	{#State 136
		DEFAULT => -107
	},
	{#State 137
		DEFAULT => -108
	},
	{#State 138
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP01_QW' => 126,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 132,
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			'WORD' => 24,
			"%{" => 116,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113,
			'WordScoped' => 85,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'SubExpression' => 176,
			'ListElement' => 177,
			'ListElements' => 219,
			'Variable' => 127,
			'HashReference' => 91,
			'TypeInner' => 131
		}
	},
	{#State 139
		DEFAULT => -16
	},
	{#State 140
		ACTIONS => {
			")" => 220
		}
	},
	{#State 141
		ACTIONS => {
			")" => 221
		}
	},
	{#State 142
		ACTIONS => {
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 132,
			")" => -118,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_QW' => 126,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 116,
			'WORD' => 24
		},
		GOTOS => {
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'OPTIONAL-32' => 222,
			'WordScoped' => 85,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operator' => 110,
			'SubExpression' => 176,
			'ListElement' => 177,
			'Variable' => 127,
			'HashReference' => 91,
			'ListElements' => 223,
			'TypeInner' => 131
		}
	},
	{#State 143
		DEFAULT => -83
	},
	{#State 144
		ACTIONS => {
			"my" => 224
		}
	},
	{#State 145
		DEFAULT => -153
	},
	{#State 146
		ACTIONS => {
			"my" => 225
		}
	},
	{#State 147
		DEFAULT => -152
	},
	{#State 148
		ACTIONS => {
			'LPAREN' => 226
		}
	},
	{#State 149
		DEFAULT => -154
	},
	{#State 150
		DEFAULT => -141
	},
	{#State 151
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 157,
			'OP17_LIST_RANGE' => 156,
			'OP23_LOGICAL_AND' => 162,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			")" => 227,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => 161
		}
	},
	{#State 152
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			";" => -94,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			"]" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP18_TERNARY' => -94,
			"}" => -94,
			'OP07_STRING_REPEAT' => 171,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			")" => -94,
			'OP24_LOGICAL_OR_XOR' => -94
		}
	},
	{#State 153
		ACTIONS => {
			"filehandle_ref" => 228
		}
	},
	{#State 154
		ACTIONS => {
			'OP07_STRING_REPEAT' => -86,
			'OP18_TERNARY' => -86,
			"}" => -86,
			")" => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP04_MATH_POW' => 160,
			'OP06_REGEX_MATCH' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP15_LOGICAL_AND' => -86,
			";" => -86,
			'OP08_STRING_CAT' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP23_LOGICAL_AND' => -86,
			"]" => -86,
			'OP17_LIST_RANGE' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP21_LIST_COMMA' => -86
		}
	},
	{#State 155
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			"%{" => 116,
			'WORD' => 24,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95
		},
		GOTOS => {
			'SubExpression' => 229,
			'Variable' => 127,
			'HashReference' => 91,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113,
			'WordScoped' => 85,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110
		}
	},
	{#State 156
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'WORD' => 24,
			"%{" => 116,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'WordScoped' => 85,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'HashReference' => 91,
			'Variable' => 127,
			'SubExpression' => 230
		}
	},
	{#State 157
		ACTIONS => {
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 132,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			'WORD' => 24,
			"%{" => 116
		},
		GOTOS => {
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'WordScoped' => 85,
			'SubExpression' => 231,
			'Variable' => 127,
			'HashReference' => 91
		}
	},
	{#State 158
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'WORD' => 24,
			"%{" => 116,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 132,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86
		},
		GOTOS => {
			'SubExpression' => 232,
			'Variable' => 127,
			'HashReference' => 91,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'WordScoped' => 85,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110
		}
	},
	{#State 159
		ACTIONS => {
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 116,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 132,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'HashReference' => 91,
			'Variable' => 127,
			'SubExpression' => 233,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128
		}
	},
	{#State 160
		ACTIONS => {
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 132,
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 116,
			'WORD' => 24,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'HashReference' => 91,
			'Variable' => 127,
			'SubExpression' => 234
		}
	},
	{#State 161
		ACTIONS => {
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Variable' => 235,
			'VariableOrLiteral' => 237,
			'Literal' => 236
		}
	},
	{#State 162
		ACTIONS => {
			'OP01_CLOSE' => 111,
			"%{" => 116,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'OP05_LOGICAL_NEG' => 92,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133
		},
		GOTOS => {
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113,
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 238
		}
	},
	{#State 163
		ACTIONS => {
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"%{" => 116,
			'WORD' => 24,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109
		},
		GOTOS => {
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'SubExpression' => 239,
			'HashReference' => 91,
			'Variable' => 127
		}
	},
	{#State 164
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'WORD' => 24,
			"%{" => 116,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'SubExpression' => 240,
			'Variable' => 127,
			'HashReference' => 91
		}
	},
	{#State 165
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"%{" => 116,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'SubExpression' => 241,
			'Variable' => 127,
			'HashReference' => 91,
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'WordScoped' => 85
		}
	},
	{#State 166
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'WORD' => 24,
			"%{" => 116,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 132,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86
		},
		GOTOS => {
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 242
		}
	},
	{#State 167
		ACTIONS => {
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'WORD' => 24,
			"%{" => 116,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 243,
			'WordScoped' => 85,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113
		}
	},
	{#State 168
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 244
		}
	},
	{#State 169
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 132,
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 116,
			'WORD' => 24,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'SubExpression' => 245,
			'HashReference' => 91,
			'Variable' => 127
		}
	},
	{#State 170
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'WORD' => 24,
			"%{" => 116,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 246
		}
	},
	{#State 171
		ACTIONS => {
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			"%{" => 116,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'SubExpression' => 247,
			'HashReference' => 91,
			'Variable' => 127,
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operator' => 110,
			'WordScoped' => 85
		}
	},
	{#State 172
		ACTIONS => {
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => 161,
			"}" => -104,
			")" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			'OP08_STRING_CAT' => 164,
			";" => -104,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP11_COMPARE_LT_GT' => 157,
			"]" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP17_LIST_RANGE' => 156,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP21_LIST_COMMA' => -104
		}
	},
	{#State 173
		DEFAULT => -137
	},
	{#State 174
		DEFAULT => -76
	},
	{#State 175
		ACTIONS => {
			";" => 248
		}
	},
	{#State 176
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 155,
			'OP21_LIST_COMMA' => -177,
			'OP11_COMPARE_LT_GT' => 157,
			'OP17_LIST_RANGE' => 156,
			"]" => -177,
			'OP23_LOGICAL_AND' => 162,
			'OP08_STRING_CAT' => 164,
			";" => -177,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			")" => -177,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171
		}
	},
	{#State 177
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 249
		}
	},
	{#State 178
		ACTIONS => {
			";" => 250
		}
	},
	{#State 179
		DEFAULT => -202
	},
	{#State 180
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'STDIN' => 253,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			"%{" => 116,
			'WORD' => 24,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95
		},
		GOTOS => {
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'HashReference' => 91,
			'Variable' => 127,
			'SubExpression' => 252,
			'SubExpressionOrStdin' => 251
		}
	},
	{#State 181
		ACTIONS => {
			'LPAREN' => 254
		}
	},
	{#State 182
		DEFAULT => -84
	},
	{#State 183
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'WORD' => 24,
			"%{" => 116,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 132,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86
		},
		GOTOS => {
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 255,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'WordScoped' => 85,
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128
		}
	},
	{#State 184
		ACTIONS => {
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP24_LOGICAL_OR_XOR' => 170,
			")" => 256,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP17_LIST_RANGE' => 156,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166
		}
	},
	{#State 185
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 257
		}
	},
	{#State 186
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'WORD' => 24,
			"%{" => 116,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'OP01_QW' => 126,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'LITERAL_NUMBER' => 75,
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'WordScoped' => 85,
			'ListElement' => 258,
			'SubExpression' => 129,
			'TypeInner' => 131,
			'Variable' => 127,
			'HashReference' => 91
		}
	},
	{#State 187
		DEFAULT => -180
	},
	{#State 188
		ACTIONS => {
			"]" => 259
		}
	},
	{#State 189
		ACTIONS => {
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'WORD' => 24,
			"%{" => 116,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113,
			'WordScoped' => 85,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'SubExpression' => 260,
			'Variable' => 127,
			'HashReference' => 91
		}
	},
	{#State 190
		DEFAULT => -183
	},
	{#State 191
		ACTIONS => {
			"}" => 261
		}
	},
	{#State 192
		ACTIONS => {
			'LBRACKET' => 104
		},
		GOTOS => {
			'ArrayReference' => 262
		}
	},
	{#State 193
		DEFAULT => -82
	},
	{#State 194
		DEFAULT => -190
	},
	{#State 195
		DEFAULT => -197
	},
	{#State 196
		ACTIONS => {
			'OP20_HASH_FATARROW' => 263
		}
	},
	{#State 197
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 264
		}
	},
	{#State 198
		ACTIONS => {
			"}" => 265
		}
	},
	{#State 199
		ACTIONS => {
			"}" => 266
		}
	},
	{#State 200
		DEFAULT => -42
	},
	{#State 201
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 82,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			"for" => -139,
			'WORD_SCOPED' => 25,
			"if" => 105,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			"my" => 72,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'OP19_LOOP_CONTROL' => 99,
			'OP01_NAMED' => 78,
			'OP01_PRINT' => 79,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 81,
			'OP01_CLOSE' => 111,
			"while" => -139,
			"foreach" => -139,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 116,
			'WORD' => 24,
			'OP01_NAMED_VOID' => 98,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'SubExpression' => 93,
			'HashReference' => 91,
			'VariableDeclaration' => 108,
			'PLUS-17' => 267,
			'VariableModification' => 115,
			'OperatorVoid' => 114,
			'Expression' => 97,
			'Literal' => 113,
			'LoopLabel' => 96,
			'PAREN-34' => 94,
			'Operator' => 110,
			'Variable' => 100,
			'Operation' => 268,
			'Statement' => 73,
			'ArrayDereference' => 107,
			'Conditional' => 106,
			'OPTIONAL-35' => 87,
			'WordScoped' => 85,
			'ArrayReference' => 84,
			'HashDereference' => 83
		}
	},
	{#State 202
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 269
		}
	},
	{#State 203
		ACTIONS => {
			";" => 270
		}
	},
	{#State 204
		ACTIONS => {
			"\$TYPED_" => 271
		}
	},
	{#State 205
		DEFAULT => -40
	},
	{#State 206
		ACTIONS => {
			"use constant" => 45,
			"our hash_ref \$properties" => 273
		},
		GOTOS => {
			'Constant' => 272,
			'Properties' => 274
		}
	},
	{#State 207
		DEFAULT => -53
	},
	{#State 208
		ACTIONS => {
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 132,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 116,
			'WORD' => 24
		},
		GOTOS => {
			'HashReference' => 91,
			'Variable' => 127,
			'SubExpression' => 275,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128
		}
	},
	{#State 209
		DEFAULT => -161
	},
	{#State 210
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"%{" => 116,
			'WORD' => 276,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'OP01_CLOSE' => 111,
			'WORD_UPPERCASE' => 132,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86
		},
		GOTOS => {
			'SubExpression' => 277,
			'HashReference' => 91,
			'Variable' => 127,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83
		}
	},
	{#State 211
		ACTIONS => {
			";" => 278,
			'OP19_VARIABLE_ASSIGN' => 279
		}
	},
	{#State 212
		ACTIONS => {
			'WORD' => 280,
			")" => 281
		}
	},
	{#State 213
		DEFAULT => -176
	},
	{#State 214
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_QW' => 126,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 75,
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			"%{" => 116,
			'WORD' => 24,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89
		},
		GOTOS => {
			'TypeInner' => 131,
			'HashReference' => 91,
			'Variable' => 127,
			'ListElements' => 282,
			'ListElement' => 177,
			'SubExpression' => 176,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128
		}
	},
	{#State 215
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			")" => -178,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP21_LIST_COMMA' => -178,
			'OP11_COMPARE_LT_GT' => 157,
			'OP23_LOGICAL_AND' => 162,
			"]" => -178,
			'OP17_LIST_RANGE' => 156,
			";" => -178,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165
		}
	},
	{#State 216
		ACTIONS => {
			'OP15_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			";" => -79,
			'OP08_STRING_CAT' => -79,
			'OP17_LIST_RANGE' => -79,
			"]" => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP07_STRING_REPEAT' => -79,
			"}" => -79,
			'OP18_TERNARY' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			")" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP04_MATH_POW' => -79
		}
	},
	{#State 217
		ACTIONS => {
			"\$TYPED_" => 283
		}
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
		DEFAULT => -123
	},
	{#State 221
		DEFAULT => -125
	},
	{#State 222
		ACTIONS => {
			")" => 286
		}
	},
	{#State 223
		DEFAULT => -117
	},
	{#State 224
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 287
		}
	},
	{#State 225
		ACTIONS => {
			'TYPE_INTEGER' => 288
		}
	},
	{#State 226
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"%{" => 116,
			'WORD' => 24,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'WordScoped' => 85,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 289
		}
	},
	{#State 227
		DEFAULT => -87
	},
	{#State 228
		ACTIONS => {
			'FH_REF_SYMBOL' => 290
		}
	},
	{#State 229
		ACTIONS => {
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP24_LOGICAL_OR_XOR' => -99,
			")" => -99,
			"}" => -99,
			'OP18_TERNARY' => -99,
			'OP07_STRING_REPEAT' => 171,
			'OP21_LIST_COMMA' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			"]" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			";" => -99,
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP12_COMPARE_EQ_NE' => 166
		}
	},
	{#State 230
		ACTIONS => {
			")" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => -102,
			"}" => -102,
			'OP11_COMPARE_LT_GT' => 157,
			'OP23_LOGICAL_AND' => -102,
			"]" => -102,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP21_LIST_COMMA' => -102,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			";" => -102,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163
		}
	},
	{#State 231
		ACTIONS => {
			")" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => -96,
			"}" => -96,
			'OP11_COMPARE_LT_GT' => undef,
			"]" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP08_STRING_CAT' => 164,
			";" => -96,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => -96
		}
	},
	{#State 232
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP11_COMPARE_LT_GT' => 157,
			"]" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 164,
			";" => -98,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP16_LOGICAL_OR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			")" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			"}" => -98,
			'OP07_STRING_REPEAT' => 171
		}
	},
	{#State 233
		ACTIONS => {
			'OP16_LOGICAL_OR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 164,
			";" => -100,
			'OP17_LIST_RANGE' => -100,
			"]" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => 157,
			'OP21_LIST_COMMA' => -100,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP07_STRING_REPEAT' => 171,
			"}" => -100,
			'OP18_TERNARY' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			")" => -100,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169
		}
	},
	{#State 234
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP23_LOGICAL_AND' => -85,
			"]" => -85,
			'OP17_LIST_RANGE' => -85,
			";" => -85,
			'OP08_STRING_CAT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP04_MATH_POW' => 160,
			'OP06_REGEX_MATCH' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			")" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP18_TERNARY' => -85,
			"}" => -85,
			'OP07_STRING_REPEAT' => -85
		}
	},
	{#State 235
		DEFAULT => -207
	},
	{#State 236
		DEFAULT => -208
	},
	{#State 237
		ACTIONS => {
			'COLON' => 291
		}
	},
	{#State 238
		ACTIONS => {
			'OP07_STRING_REPEAT' => 171,
			"}" => -105,
			'OP18_TERNARY' => 161,
			'OP24_LOGICAL_OR_XOR' => -105,
			")" => -105,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			";" => -105,
			'OP08_STRING_CAT' => 164,
			'OP17_LIST_RANGE' => 156,
			"]" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP11_COMPARE_LT_GT' => 157,
			'OP21_LIST_COMMA' => -105,
			'OP14_BITWISE_OR_XOR' => 155
		}
	},
	{#State 239
		ACTIONS => {
			'OP08_STRING_CAT' => 164,
			";" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP23_LOGICAL_AND' => -93,
			"]" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP18_TERNARY' => -93,
			"}" => -93,
			'OP07_STRING_REPEAT' => 171,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			")" => -93,
			'OP24_LOGICAL_OR_XOR' => -93
		}
	},
	{#State 240
		ACTIONS => {
			'OP15_LOGICAL_AND' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_STRING_CAT' => -92,
			";" => -92,
			'OP17_LIST_RANGE' => -92,
			"]" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP07_STRING_REPEAT' => 171,
			"}" => -92,
			'OP18_TERNARY' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			")" => -92,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169
		}
	},
	{#State 241
		ACTIONS => {
			"]" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => 157,
			'OP21_LIST_COMMA' => -101,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP16_LOGICAL_OR' => -101,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 164,
			";" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			")" => -101,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP07_STRING_REPEAT' => 171,
			"}" => -101,
			'OP18_TERNARY' => -101
		}
	},
	{#State 242
		ACTIONS => {
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP24_LOGICAL_OR_XOR' => -97,
			")" => -97,
			"}" => -97,
			'OP18_TERNARY' => -97,
			'OP07_STRING_REPEAT' => 171,
			'OP21_LIST_COMMA' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			"]" => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => -97,
			'OP09_BITWISE_SHIFT' => 163,
			";" => -97,
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => undef
		}
	},
	{#State 243
		ACTIONS => {
			'OP13_BITWISE_AND' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			";" => -90,
			'OP08_STRING_CAT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP17_LIST_RANGE' => -90,
			"]" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			"}" => -90,
			'OP18_TERNARY' => -90,
			'OP07_STRING_REPEAT' => 171,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP04_MATH_POW' => 160,
			'OP24_LOGICAL_OR_XOR' => -90,
			")" => -90
		}
	},
	{#State 244
		DEFAULT => -88
	},
	{#State 245
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP08_STRING_CAT' => -91,
			";" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP23_LOGICAL_AND' => -91,
			"]" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			"}" => -91,
			'OP18_TERNARY' => -91,
			'OP07_STRING_REPEAT' => 171,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			")" => -91
		}
	},
	{#State 246
		ACTIONS => {
			'OP07_STRING_REPEAT' => 171,
			"}" => -106,
			'OP18_TERNARY' => 161,
			'OP24_LOGICAL_OR_XOR' => -106,
			")" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			";" => -106,
			'OP08_STRING_CAT' => 164,
			"]" => -106,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP21_LIST_COMMA' => -106,
			'OP14_BITWISE_OR_XOR' => 155
		}
	},
	{#State 247
		ACTIONS => {
			")" => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => -89,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP18_TERNARY' => -89,
			"}" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			"]" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP08_STRING_CAT' => -89,
			";" => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP13_BITWISE_AND' => -89
		}
	},
	{#State 248
		DEFAULT => -113
	},
	{#State 249
		ACTIONS => {
			")" => -174,
			"]" => -174,
			";" => -174,
			'OP21_LIST_COMMA' => 293
		},
		GOTOS => {
			'PAREN-42' => 292
		}
	},
	{#State 250
		DEFAULT => -116
	},
	{#State 251
		ACTIONS => {
			";" => 294
		}
	},
	{#State 252
		ACTIONS => {
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			";" => -135,
			'OP08_STRING_CAT' => 164,
			'OP17_LIST_RANGE' => 156,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => 161,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160
		}
	},
	{#State 253
		DEFAULT => -136
	},
	{#State 254
		ACTIONS => {
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			'WORD' => 24,
			"%{" => 116,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP01_QW' => 126,
			'OP05_MATH_NEG_LPAREN' => 88,
			")" => -120,
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 132,
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'ListElement' => 177,
			'SubExpression' => 176,
			'OPTIONAL-33' => 295,
			'TypeInner' => 131,
			'HashReference' => 91,
			'Variable' => 127,
			'ListElements' => 296
		}
	},
	{#State 255
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 164,
			";" => 297,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP24_LOGICAL_OR_XOR' => 170
		}
	},
	{#State 256
		DEFAULT => -134
	},
	{#State 257
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'WORD' => 24,
			"%{" => 116,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_QW' => 126,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'LITERAL_NUMBER' => 75,
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'TypeInner' => 131,
			'Variable' => 127,
			'HashReference' => 91,
			'ListElements' => 298,
			'ListElement' => 177,
			'SubExpression' => 176
		}
	},
	{#State 258
		ACTIONS => {
			'OP21_LIST_COMMA' => 299
		}
	},
	{#State 259
		DEFAULT => -182
	},
	{#State 260
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP17_LIST_RANGE' => 156,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 157,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP24_LOGICAL_OR_XOR' => 170,
			")" => 300
		}
	},
	{#State 261
		DEFAULT => -185
	},
	{#State 262
		ACTIONS => {
			"}" => 301
		}
	},
	{#State 263
		ACTIONS => {
			"\@{" => -188,
			'OP10_NAMED_UNARY' => -188,
			'OP01_OPEN' => -188,
			'OP05_LOGICAL_NEG' => -188,
			'OP01_CLOSE' => -188,
			"%{" => -188,
			'WORD' => -188,
			'OP22_LOGICAL_NEG' => -188,
			'LBRACE' => -188,
			'LITERAL_NUMBER' => -188,
			'VARIABLE_SYMBOL' => -188,
			"my" => 134,
			'WORD_UPPERCASE' => -188,
			'LITERAL_STRING' => -188,
			"undef" => -188,
			'OP01_NAMED' => -188,
			'LPAREN' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'LBRACKET' => -188,
			'WORD_SCOPED' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 302,
			'TypeInner' => 303
		}
	},
	{#State 264
		ACTIONS => {
			'OP21_LIST_COMMA' => 305,
			"}" => 304
		},
		GOTOS => {
			'PAREN-48' => 306
		}
	},
	{#State 265
		DEFAULT => -199
	},
	{#State 266
		DEFAULT => -198
	},
	{#State 267
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 78,
			'OP01_PRINT' => 79,
			'WORD_UPPERCASE' => 81,
			"}" => 308,
			'VARIABLE_SYMBOL' => 71,
			"my" => 72,
			'LITERAL_NUMBER' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_NAMED_VOID_SCOLON' => 82,
			"for" => -139,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'OP22_LOGICAL_NEG' => 95,
			"foreach" => -139,
			'OP01_NAMED_VOID' => 98,
			'WORD' => 24,
			"undef" => 102,
			'OP19_LOOP_CONTROL' => 99,
			'LBRACKET' => 104,
			"if" => 105,
			'LPAREN' => 103,
			"\@{" => 109,
			'LBRACE' => 112,
			"%{" => 116,
			"while" => -139,
			'OP01_CLOSE' => 111
		},
		GOTOS => {
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'WordScoped' => 85,
			'OPTIONAL-35' => 87,
			'Conditional' => 106,
			'ArrayDereference' => 107,
			'Statement' => 73,
			'Variable' => 100,
			'Operation' => 307,
			'Operator' => 110,
			'PAREN-34' => 94,
			'Literal' => 113,
			'LoopLabel' => 96,
			'Expression' => 97,
			'OperatorVoid' => 114,
			'VariableModification' => 115,
			'VariableDeclaration' => 108,
			'HashReference' => 91,
			'SubExpression' => 93
		}
	},
	{#State 268
		DEFAULT => -45
	},
	{#State 269
		ACTIONS => {
			'VARIABLE_SYMBOL' => 309
		}
	},
	{#State 270
		DEFAULT => -41
	},
	{#State 271
		ACTIONS => {
			'WORD_UPPERCASE' => 310
		}
	},
	{#State 272
		DEFAULT => -55
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 311
		}
	},
	{#State 274
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 312
		}
	},
	{#State 275
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 155,
			'OP17_LIST_RANGE' => 156,
			'OP23_LOGICAL_AND' => 162,
			"]" => 313,
			'OP11_COMPARE_LT_GT' => 157,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			'OP08_STRING_CAT' => 164,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171
		}
	},
	{#State 276
		ACTIONS => {
			"}" => 314,
			'OP02_METHOD_THINARROW_NEW' => -200,
			'LPAREN' => -200
		}
	},
	{#State 277
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP07_STRING_REPEAT' => 171,
			"}" => 315,
			'OP18_TERNARY' => 161,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 278
		DEFAULT => -167
	},
	{#State 279
		ACTIONS => {
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'STDIN' => 253,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"%{" => 116,
			'WORD' => 24
		},
		GOTOS => {
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpressionOrStdin' => 316,
			'SubExpression' => 252,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'WordScoped' => 85,
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107
		}
	},
	{#State 280
		DEFAULT => -175
	},
	{#State 281
		DEFAULT => -179
	},
	{#State 282
		ACTIONS => {
			";" => 317
		}
	},
	{#State 283
		ACTIONS => {
			'WORD' => 318
		}
	},
	{#State 284
		DEFAULT => -111
	},
	{#State 285
		DEFAULT => -110
	},
	{#State 286
		DEFAULT => -122
	},
	{#State 287
		ACTIONS => {
			'VARIABLE_SYMBOL' => 319
		}
	},
	{#State 288
		ACTIONS => {
			'VARIABLE_SYMBOL' => 320
		}
	},
	{#State 289
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			")" => 321,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP11_COMPARE_LT_GT' => 157,
			'OP17_LIST_RANGE' => 156,
			'OP23_LOGICAL_AND' => 162,
			'OP08_STRING_CAT' => 164,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165
		}
	},
	{#State 290
		ACTIONS => {
			'OP21_LIST_COMMA' => 322
		}
	},
	{#State 291
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71
		},
		GOTOS => {
			'Literal' => 236,
			'Variable' => 235,
			'VariableOrLiteral' => 323
		}
	},
	{#State 292
		DEFAULT => -172
	},
	{#State 293
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_QW' => 126,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			"my" => 134,
			'WORD_UPPERCASE' => 132,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'OP01_CLOSE' => 111,
			"%{" => 116,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'Variable' => 127,
			'HashReference' => 91,
			'TypeInner' => 131,
			'SubExpression' => 176,
			'ListElement' => 324,
			'WordScoped' => 85,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113
		}
	},
	{#State 294
		DEFAULT => -169
	},
	{#State 295
		ACTIONS => {
			")" => 325
		}
	},
	{#State 296
		DEFAULT => -119
	},
	{#State 297
		DEFAULT => -170
	},
	{#State 298
		ACTIONS => {
			")" => 326
		}
	},
	{#State 299
		ACTIONS => {
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			'WORD' => 24,
			"%{" => 116,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP01_QW' => 126,
			'OP05_MATH_NEG_LPAREN' => 88,
			"my" => 134,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 133,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'SubExpression' => 176,
			'ListElement' => 177,
			'Variable' => 127,
			'HashReference' => 91,
			'ListElements' => 327,
			'TypeInner' => 131,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113,
			'WordScoped' => 85,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operator' => 110
		}
	},
	{#State 300
		ACTIONS => {
			'LBRACE' => 328
		},
		GOTOS => {
			'CodeBlock' => 329
		}
	},
	{#State 301
		DEFAULT => -186
	},
	{#State 302
		ACTIONS => {
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			'WORD' => 24,
			"%{" => 116,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109
		},
		GOTOS => {
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 330,
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113
		}
	},
	{#State 303
		DEFAULT => -187
	},
	{#State 304
		DEFAULT => -196
	},
	{#State 305
		ACTIONS => {
			'WORD' => 196,
			"%{" => 116
		},
		GOTOS => {
			'HashDereference' => 194,
			'HashEntry' => 331
		}
	},
	{#State 306
		DEFAULT => -194
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
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 333
		}
	},
	{#State 310
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 334
		}
	},
	{#State 311
		ACTIONS => {
			'LBRACE' => 335
		}
	},
	{#State 312
		ACTIONS => {
			"our" => 336,
			'LITERAL_NUMBER' => 340
		},
		GOTOS => {
			'Subroutine' => 337,
			'Method' => 339,
			'MethodOrSubroutine' => 338
		}
	},
	{#State 313
		DEFAULT => -164
	},
	{#State 314
		DEFAULT => -166
	},
	{#State 315
		DEFAULT => -165
	},
	{#State 316
		ACTIONS => {
			";" => 341
		}
	},
	{#State 317
		DEFAULT => -114
	},
	{#State 318
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 342
		}
	},
	{#State 319
		ACTIONS => {
			'LPAREN' => 343
		}
	},
	{#State 320
		ACTIONS => {
			'LPAREN' => 344
		}
	},
	{#State 321
		ACTIONS => {
			'LBRACE' => 328
		},
		GOTOS => {
			'CodeBlock' => 345
		}
	},
	{#State 322
		ACTIONS => {
			'LITERAL_STRING' => 346
		}
	},
	{#State 323
		DEFAULT => -103
	},
	{#State 324
		DEFAULT => -171
	},
	{#State 325
		DEFAULT => -124
	},
	{#State 326
		DEFAULT => -78
	},
	{#State 327
		ACTIONS => {
			")" => 347
		}
	},
	{#State 328
		ACTIONS => {
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			"if" => 105,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_NAMED_VOID_SCOLON' => 82,
			"for" => -139,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 78,
			'OP01_PRINT' => 79,
			'WORD_UPPERCASE' => 81,
			'VARIABLE_SYMBOL' => 71,
			"my" => 72,
			'OP19_LOOP_CONTROL' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'LITERAL_NUMBER' => 75,
			'OP22_LOGICAL_NEG' => 95,
			"foreach" => -139,
			'LBRACE' => 112,
			'OP01_NAMED_VOID' => 98,
			"%{" => 116,
			'WORD' => 24,
			'OP01_CLOSE' => 111,
			"while" => -139,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109
		},
		GOTOS => {
			'SubExpression' => 93,
			'VariableDeclaration' => 108,
			'HashReference' => 91,
			'LoopLabel' => 96,
			'Literal' => 113,
			'Expression' => 97,
			'OperatorVoid' => 114,
			'PLUS-40' => 349,
			'VariableModification' => 115,
			'Operator' => 110,
			'PAREN-34' => 94,
			'Statement' => 73,
			'Operation' => 348,
			'Variable' => 100,
			'OPTIONAL-35' => 87,
			'Conditional' => 106,
			'ArrayDereference' => 107,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'WordScoped' => 85
		}
	},
	{#State 329
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 350
		}
	},
	{#State 330
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 164,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP21_LIST_COMMA' => -189,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP17_LIST_RANGE' => 156,
			'OP23_LOGICAL_AND' => 162,
			'OP11_COMPARE_LT_GT' => 157,
			"}" => -189,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP24_LOGICAL_OR_XOR' => 170
		}
	},
	{#State 331
		DEFAULT => -193
	},
	{#State 332
		DEFAULT => -46
	},
	{#State 333
		ACTIONS => {
			")" => 351,
			'OP21_LIST_COMMA' => 353
		},
		GOTOS => {
			'PAREN-18' => 352
		}
	},
	{#State 334
		DEFAULT => -206
	},
	{#State 335
		ACTIONS => {
			'WORD' => 357,
			"%{" => 116,
			"}" => 354
		},
		GOTOS => {
			'HashDereference' => 355,
			'HashEntryTyped' => 356
		}
	},
	{#State 336
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54,
			'TYPE_METHOD' => 358
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 337
		DEFAULT => -75
	},
	{#State 338
		DEFAULT => -57
	},
	{#State 339
		DEFAULT => -74
	},
	{#State 340
		ACTIONS => {
			";" => 359
		}
	},
	{#State 341
		DEFAULT => -168
	},
	{#State 342
		DEFAULT => -205
	},
	{#State 343
		ACTIONS => {
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP01_QW' => 126,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			"my" => 134,
			'WORD_UPPERCASE' => 132,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'OP01_CLOSE' => 111,
			"%{" => 116,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'SubExpression' => 176,
			'ListElement' => 177,
			'ListElements' => 360,
			'HashReference' => 91,
			'Variable' => 127,
			'TypeInner' => 131,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113,
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83
		}
	},
	{#State 344
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_NAMED' => 133,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			"%{" => 116,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112
		},
		GOTOS => {
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Literal' => 113,
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'SubExpression' => 361,
			'Variable' => 127,
			'HashReference' => 91
		}
	},
	{#State 345
		DEFAULT => -157
	},
	{#State 346
		ACTIONS => {
			'OP21_LIST_COMMA' => 362
		}
	},
	{#State 347
		DEFAULT => -80
	},
	{#State 348
		DEFAULT => -159
	},
	{#State 349
		ACTIONS => {
			'VARIABLE_SYMBOL' => 71,
			"my" => 72,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 78,
			'OP01_PRINT' => 79,
			'WORD_UPPERCASE' => 81,
			"}" => 363,
			'OP01_NAMED_VOID_SCOLON' => 82,
			"for" => -139,
			'OP03_MATH_INC_DEC' => 86,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'OP05_LOGICAL_NEG' => 92,
			'OP22_LOGICAL_NEG' => 95,
			"foreach" => -139,
			'OP01_NAMED_VOID' => 98,
			'WORD' => 24,
			'OP19_LOOP_CONTROL' => 99,
			"undef" => 102,
			'LPAREN' => 103,
			'LBRACKET' => 104,
			"if" => 105,
			"\@{" => 109,
			"while" => -139,
			'OP01_CLOSE' => 111,
			'LBRACE' => 112,
			"%{" => 116
		},
		GOTOS => {
			'Expression' => 97,
			'OperatorVoid' => 114,
			'VariableModification' => 115,
			'Literal' => 113,
			'LoopLabel' => 96,
			'PAREN-34' => 94,
			'Operator' => 110,
			'SubExpression' => 93,
			'HashReference' => 91,
			'VariableDeclaration' => 108,
			'ArrayDereference' => 107,
			'OPTIONAL-35' => 87,
			'Conditional' => 106,
			'WordScoped' => 85,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operation' => 364,
			'Variable' => 100,
			'Statement' => 73
		}
	},
	{#State 350
		ACTIONS => {
			'OP01_OPEN' => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP05_LOGICAL_NEG' => -150,
			"else" => 369,
			"elsif" => 368,
			"foreach" => -150,
			'OP22_LOGICAL_NEG' => -150,
			'' => -150,
			'WORD' => -150,
			'OP01_NAMED_VOID' => -150,
			"my" => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'LITERAL_NUMBER' => -150,
			'OP01_PRINT' => -150,
			'OP01_NAMED' => -150,
			'LITERAL_STRING' => -150,
			"}" => -150,
			'WORD_UPPERCASE' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP03_MATH_INC_DEC' => -150,
			"for" => -150,
			'WORD_SCOPED' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			"\@{" => -150,
			'OP01_CLOSE' => -150,
			"while" => -150,
			'LBRACE' => -150,
			"%{" => -150,
			'OP19_LOOP_CONTROL' => -150,
			"undef" => -150,
			'LPAREN' => -150,
			"if" => -150,
			'LBRACKET' => -150
		},
		GOTOS => {
			'PAREN-36' => 366,
			'OPTIONAL-39' => 367,
			'PAREN-38' => 365
		}
	},
	{#State 351
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 370
		}
	},
	{#State 352
		DEFAULT => -48
	},
	{#State 353
		ACTIONS => {
			"my" => 371
		}
	},
	{#State 354
		ACTIONS => {
			";" => 372
		}
	},
	{#State 355
		DEFAULT => -192
	},
	{#State 356
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 373
		}
	},
	{#State 357
		ACTIONS => {
			'OP20_HASH_FATARROW' => 374
		}
	},
	{#State 358
		ACTIONS => {
			'VARIABLE_SYMBOL' => 375
		}
	},
	{#State 359
		DEFAULT => -59
	},
	{#State 360
		ACTIONS => {
			")" => 376
		}
	},
	{#State 361
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP08_STRING_CAT' => 164,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP11_COMPARE_LT_GT' => 157,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 377,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => 161,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167
		}
	},
	{#State 362
		ACTIONS => {
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			'WORD' => 24,
			"%{" => 116,
			'OP01_CLOSE' => 111,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 132,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113,
			'WordScoped' => 85,
			'Operator' => 110,
			'HashDereference' => 83,
			'ArrayReference' => 84,
			'SubExpression' => 378,
			'HashReference' => 91,
			'Variable' => 127
		}
	},
	{#State 363
		DEFAULT => -160
	},
	{#State 364
		DEFAULT => -158
	},
	{#State 365
		DEFAULT => -149
	},
	{#State 366
		DEFAULT => -146
	},
	{#State 367
		DEFAULT => -151
	},
	{#State 368
		ACTIONS => {
			'LPAREN' => 379
		}
	},
	{#State 369
		ACTIONS => {
			'LBRACE' => 328
		},
		GOTOS => {
			'CodeBlock' => 380
		}
	},
	{#State 370
		ACTIONS => {
			"\@_;" => 381
		}
	},
	{#State 371
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 382
		}
	},
	{#State 372
		DEFAULT => -64
	},
	{#State 373
		ACTIONS => {
			'OP21_LIST_COMMA' => 384,
			"}" => 385
		},
		GOTOS => {
			'PAREN-24' => 383
		}
	},
	{#State 374
		ACTIONS => {
			"my" => 134
		},
		GOTOS => {
			'TypeInner' => 386
		}
	},
	{#State 375
		ACTIONS => {
			"= sub {" => 387
		}
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 328
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 377
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			"\@{" => 109,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			'WORD' => 24,
			"%{" => 116,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112
		},
		GOTOS => {
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 389,
			'WordScoped' => 85,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Literal' => 113
		}
	},
	{#State 378
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 164,
			";" => -81,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 165,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP21_LIST_COMMA' => -81,
			'OP14_BITWISE_OR_XOR' => 155,
			"]" => -81,
			'OP17_LIST_RANGE' => 156,
			'OP23_LOGICAL_AND' => -81,
			'OP11_COMPARE_LT_GT' => 157,
			"}" => -81,
			'OP18_TERNARY' => 161,
			'OP07_STRING_REPEAT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP24_LOGICAL_OR_XOR' => -81,
			")" => -81
		}
	},
	{#State 379
		ACTIONS => {
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			'LBRACKET' => 104,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			'WORD_UPPERCASE' => 132,
			'OP01_NAMED' => 133,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'OP01_CLOSE' => 111,
			'WORD' => 24,
			"%{" => 116,
			'LBRACE' => 112,
			'OP22_LOGICAL_NEG' => 95,
			"\@{" => 109,
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'Operator' => 110,
			'WordScoped' => 85,
			'Literal' => 113,
			'ArrayDereference' => 107,
			'Expression' => 128,
			'Variable' => 127,
			'HashReference' => 91,
			'SubExpression' => 390
		}
	},
	{#State 380
		DEFAULT => -148
	},
	{#State 381
		DEFAULT => -50
	},
	{#State 382
		ACTIONS => {
			'VARIABLE_SYMBOL' => 391
		}
	},
	{#State 383
		DEFAULT => -61
	},
	{#State 384
		ACTIONS => {
			"%{" => 116,
			'WORD' => 357
		},
		GOTOS => {
			'HashDereference' => 355,
			'HashEntryTyped' => 392
		}
	},
	{#State 385
		ACTIONS => {
			";" => 393
		}
	},
	{#State 386
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 86,
			'LPAREN' => 103,
			'LBRACKET' => 104,
			'WORD_SCOPED' => 25,
			'OP05_MATH_NEG_LPAREN' => 88,
			'VARIABLE_SYMBOL' => 71,
			'LITERAL_NUMBER' => 75,
			"undef" => 102,
			'LITERAL_STRING' => 77,
			'OP01_NAMED' => 133,
			'WORD_UPPERCASE' => 132,
			'OP01_CLOSE' => 111,
			'OP22_LOGICAL_NEG' => 95,
			'LBRACE' => 112,
			"%{" => 116,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'Literal' => 113,
			'Expression' => 128,
			'ArrayDereference' => 107,
			'Operator' => 110,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'WordScoped' => 85,
			'SubExpression' => 394,
			'Variable' => 127,
			'HashReference' => 91
		}
	},
	{#State 387
		ACTIONS => {
			'WORD_SCOPED' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP03_MATH_INC_DEC' => -66,
			"for" => -66,
			'OP01_PRINT' => -66,
			'OP01_NAMED' => -66,
			'LITERAL_STRING' => -66,
			'WORD_UPPERCASE' => -66,
			"my" => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'LITERAL_NUMBER' => -66,
			"foreach" => -66,
			'OP22_LOGICAL_NEG' => -66,
			'WORD' => -66,
			'OP01_NAMED_VOID' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP01_OPEN' => -66,
			'OP10_NAMED_UNARY' => -66,
			"if" => -66,
			'LBRACKET' => -66,
			'LPAREN_MY' => 395,
			'LPAREN' => -66,
			"undef" => -66,
			'OP19_LOOP_CONTROL' => -66,
			'LBRACE' => -66,
			"%{" => -66,
			'OP01_CLOSE' => -66,
			"while" => -66,
			"\@{" => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 396,
			'MethodArguments' => 397
		}
	},
	{#State 388
		DEFAULT => -156
	},
	{#State 389
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -102,
			")" => 398,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP04_MATH_POW' => 160,
			'OP08_MATH_ADD_SUB' => 169,
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => undef,
			'OP11_COMPARE_LT_GT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP09_BITWISE_SHIFT' => 163,
			'OP13_BITWISE_AND' => 158,
			'OP08_STRING_CAT' => 164
		}
	},
	{#State 390
		ACTIONS => {
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			'OP08_STRING_CAT' => 164,
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => 161,
			'OP24_LOGICAL_OR_XOR' => 170,
			")" => 399,
			'OP06_REGEX_MATCH' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160
		}
	},
	{#State 391
		DEFAULT => -47
	},
	{#State 392
		DEFAULT => -60
	},
	{#State 393
		DEFAULT => -63
	},
	{#State 394
		ACTIONS => {
			'OP23_LOGICAL_AND' => 162,
			'OP17_LIST_RANGE' => 156,
			'OP11_COMPARE_LT_GT' => 157,
			'OP21_LIST_COMMA' => -191,
			'OP14_BITWISE_OR_XOR' => 155,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 166,
			'OP13_BITWISE_AND' => 158,
			'OP09_BITWISE_SHIFT' => 163,
			'OP08_STRING_CAT' => 164,
			'OP24_LOGICAL_OR_XOR' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 167,
			'OP06_REGEX_MATCH' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 160,
			'OP07_STRING_REPEAT' => 171,
			"}" => -191,
			'OP18_TERNARY' => 161
		}
	},
	{#State 395
		ACTIONS => {
			'TYPE_SELF' => 400
		}
	},
	{#State 396
		ACTIONS => {
			'OP01_OPEN' => 90,
			'OP10_NAMED_UNARY' => 89,
			"\@{" => 109,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_CLOSE' => 111,
			"while" => -139,
			'LBRACE' => 112,
			"foreach" => -139,
			'OP22_LOGICAL_NEG' => 95,
			'WORD' => 24,
			"%{" => 116,
			'OP01_NAMED_VOID' => 98,
			"my" => 72,
			'VARIABLE_SYMBOL' => 71,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'LITERAL_NUMBER' => 75,
			'OP19_LOOP_CONTROL' => 99,
			'OP01_NAMED' => 78,
			'OP01_PRINT' => 79,
			'LITERAL_STRING' => 77,
			"undef" => 102,
			'WORD_UPPERCASE' => 81,
			'OP01_NAMED_VOID_SCOLON' => 82,
			'LPAREN' => 103,
			'OP03_MATH_INC_DEC' => 86,
			"for" => -139,
			'WORD_SCOPED' => 25,
			"if" => 105,
			'LBRACKET' => 104,
			'OP05_MATH_NEG_LPAREN' => 88
		},
		GOTOS => {
			'PAREN-34' => 94,
			'Operator' => 110,
			'VariableModification' => 115,
			'Expression' => 97,
			'OperatorVoid' => 114,
			'Literal' => 113,
			'LoopLabel' => 96,
			'HashReference' => 91,
			'VariableDeclaration' => 108,
			'PLUS-27' => 402,
			'SubExpression' => 93,
			'WordScoped' => 85,
			'ArrayReference' => 84,
			'HashDereference' => 83,
			'ArrayDereference' => 107,
			'Conditional' => 106,
			'OPTIONAL-35' => 87,
			'Variable' => 100,
			'Operation' => 401,
			'Statement' => 73
		}
	},
	{#State 397
		DEFAULT => -65
	},
	{#State 398
		ACTIONS => {
			'LBRACE' => 328
		},
		GOTOS => {
			'CodeBlock' => 403
		}
	},
	{#State 399
		ACTIONS => {
			'LBRACE' => 328
		},
		GOTOS => {
			'CodeBlock' => 404
		}
	},
	{#State 400
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 405
		}
	},
	{#State 401
		DEFAULT => -68
	},
	{#State 402
		ACTIONS => {
			'LBRACKET' => 104,
			"if" => 105,
			'LPAREN' => 103,
			"undef" => 102,
			'OP19_LOOP_CONTROL' => 99,
			"%{" => 116,
			'LBRACE' => 112,
			'OP01_CLOSE' => 111,
			"while" => -139,
			"\@{" => 109,
			'OP05_MATH_NEG_LPAREN' => 88,
			'WORD_SCOPED' => 25,
			"for" => -139,
			'OP03_MATH_INC_DEC' => 86,
			'OP01_NAMED_VOID_SCOLON' => 82,
			'WORD_UPPERCASE' => 81,
			"}" => 406,
			'LITERAL_STRING' => 77,
			'OP01_PRINT' => 79,
			'OP01_NAMED' => 78,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 71,
			"my" => 72,
			'OP01_NAMED_VOID' => 98,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 95,
			"foreach" => -139,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_NAMED_UNARY' => 89,
			'OP01_OPEN' => 90
		},
		GOTOS => {
			'SubExpression' => 93,
			'HashReference' => 91,
			'VariableDeclaration' => 108,
			'VariableModification' => 115,
			'Expression' => 97,
			'OperatorVoid' => 114,
			'Literal' => 113,
			'LoopLabel' => 96,
			'PAREN-34' => 94,
			'Operator' => 110,
			'Operation' => 407,
			'Variable' => 100,
			'Statement' => 73,
			'ArrayDereference' => 107,
			'Conditional' => 106,
			'OPTIONAL-35' => 87,
			'WordScoped' => 85,
			'ArrayReference' => 84,
			'HashDereference' => 83
		}
	},
	{#State 403
		DEFAULT => -155
	},
	{#State 404
		DEFAULT => -145
	},
	{#State 405
		ACTIONS => {
			'OP21_LIST_COMMA' => 409,
			")" => 410
		},
		GOTOS => {
			'PAREN-28' => 408
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
		DEFAULT => -71
	},
	{#State 409
		ACTIONS => {
			"my" => 412
		}
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
			'TYPE_INTEGER' => 54
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
#line 5803 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5810 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5824 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5835 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5846 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5853 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5860 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5867 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5874 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5881 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5941 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5948 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5955 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5977 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5988 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5995 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6002 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6009 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6016 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6044 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6055 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6066 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6073 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6080 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6091 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6098 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6105 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6116 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6127 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6138 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6152 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6198 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6209 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6216 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6223 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6230 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6237 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6244 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6251 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6265 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6276 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6283 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6290 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6297 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6308 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6319 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6326 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6358 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6372 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6379 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6390 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6401 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6412 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6423 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6434 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6445 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6456 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6467 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6478 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6489 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6500 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6511 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6522 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6533 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6544 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6555 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6566 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6577 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6588 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6599 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6610 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6621 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6632 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6643 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6654 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6665 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6676 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6687 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6698 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6720 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6731 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6742 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6753 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6760 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 169 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6785 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6796 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6807 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6890 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6912 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6923 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6934 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6945 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6956 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6967 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6978 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6989 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7011 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7022 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7033 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7044 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7055 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7062 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7069 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7087 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7098 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7109 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7120 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7131 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7138 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7145 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7152 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7159 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7173 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7184 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7206 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7217 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7228 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7239 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7250 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7282 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7289 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7300 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7311 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7333 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7344 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7355 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7366 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7377 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7384 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7391 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7398 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_174
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7409 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7423 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_177
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7434 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7445 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7456 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7463 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7470 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7481 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_185
		 'ArrayDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_186
		 'ArrayDereference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7553 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7575 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-48', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7582 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_196
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_197
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_198
		 'HashDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_199
		 'HashDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_200
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7651 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_201
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7662 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_202
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7673 lib/RPerl/Grammar.pm
	],
	[#Rule Type_203
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7684 lib/RPerl/Grammar.pm
	],
	[#Rule Type_204
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7695 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_205
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_206
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7717 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_207
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7728 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_208
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7739 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_209
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7750 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_210
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7761 lib/RPerl/Grammar.pm
	]
],
#line 7764 lib/RPerl/Grammar.pm
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
         'HashDereference_198', 
         'HashDereference_199', 
         'WordScoped_200', 
         'WordScoped_201', 
         'LoopLabel_202', 
         'Type_203', 
         'Type_204', 
         'TypeInner_205', 
         'TypeInnerConstant_206', 
         'VariableOrLiteral_207', 
         'VariableOrLiteral_208', 
         'Literal_209', 
         'Literal_210', );
  $self;
}

#line 205 "lib/RPerl/Grammar.eyp"


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


#line 8023 lib/RPerl/Grammar.pm



1;
