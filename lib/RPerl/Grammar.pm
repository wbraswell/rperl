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

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|\$TYPED_|package|foreach|\=\ sub\ \{|elsif|while|undef|else|\@_\;|for|use|our|my|if|\@\{|\%\{|\]|\;|\}|\))}gc and return ($1, $1);

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
  [ 'ArrayDereference_183' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_184' => 'ArrayDereference', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'HashEntry_187' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-46', 'SubExpression' ], 0 ],
  [ 'HashEntry_188' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryTyped_189' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_190' => 'HashEntryTyped', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ 'HashReference_194' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-48', '}' ], 0 ],
  [ 'HashReference_195' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ 'HashDereference_196' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_197' => 'HashDereference', [ '%{', 'HashReference', '}' ], 0 ],
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
  'ArrayDereference_183' => 183,
  'ArrayDereference_184' => 184,
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
  'HashDereference_196' => 196,
  'HashDereference_197' => 197,
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
			'SHEBANG' => 6,
			"## no critic qw(" => 7,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 3,
			'PAREN-1' => 4,
			'PLUS-2' => 9,
			'ModuleHeader' => 1,
			'Critic' => 2,
			'CompileUnit' => 5,
			'Program' => 8
		}
	},
	{#State 1
		ACTIONS => {
			"use parent qw(" => 14,
			"our" => -25,
			"use constant" => -25,
			"## no critic qw(" => -25,
			"use" => -25
		},
		GOTOS => {
			'Package' => 12,
			'Module' => 10,
			'Class' => 13,
			'STAR-10' => 11
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			"package" => 15
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'' => 16
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 7,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 17,
			'Critic' => 18
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 19
		},
		GOTOS => {
			'PLUS-14' => 20
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 7,
			'' => -5
		},
		GOTOS => {
			'OPTIONAL-9' => 3,
			'PAREN-1' => 21,
			'Critic' => 2,
			'ModuleHeader' => 1
		}
	},
	{#State 10
		DEFAULT => -1
	},
	{#State 11
		ACTIONS => {
			"use" => -27,
			"use constant" => -27,
			"our" => -27,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'STAR-11' => 22,
			'Critic' => 23
		}
	},
	{#State 12
		DEFAULT => -22
	},
	{#State 13
		DEFAULT => -23
	},
	{#State 14
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 16
		DEFAULT => 0
	},
	{#State 17
		ACTIONS => {
			"use strict;" => 28
		},
		GOTOS => {
			'Header' => 29
		}
	},
	{#State 18
		DEFAULT => -6
	},
	{#State 19
		DEFAULT => -35
	},
	{#State 20
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 21
		DEFAULT => -2
	},
	{#State 22
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 34
		},
		GOTOS => {
			'Include' => 33,
			'STAR-12' => 32
		}
	},
	{#State 23
		DEFAULT => -24
	},
	{#State 24
		DEFAULT => -198
	},
	{#State 25
		ACTIONS => {
			")" => 35
		}
	},
	{#State 26
		DEFAULT => -199
	},
	{#State 27
		ACTIONS => {
			";" => 36
		}
	},
	{#State 28
		ACTIONS => {
			"use warnings;" => 37
		}
	},
	{#State 29
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 38
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
			"our" => 40,
			"use constant" => 43
		},
		GOTOS => {
			'PLUS-13' => 41,
			'Constant' => 39,
			'Subroutine' => 42
		}
	},
	{#State 33
		DEFAULT => -26
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 44
		}
	},
	{#State 35
		ACTIONS => {
			";" => 45
		}
	},
	{#State 36
		ACTIONS => {
			"use strict;" => 28
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
			"while" => -11,
			'OP01_NAMED' => -11,
			"my" => -11,
			'LBRACE' => -11,
			'LITERAL_NUMBER' => -11,
			'VARIABLE_SYMBOL' => -11,
			"foreach" => -11,
			"%{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"for" => -11,
			'WORD' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'WORD_SCOPED' => -11,
			'LPAREN' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"## no critic qw(" => 7,
			'OP10_NAMED_UNARY' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"our" => -11,
			'WORD_UPPERCASE' => -11,
			"\@{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_OPEN' => -11,
			"use" => -11,
			"undef" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_PRINT' => -11,
			'OP01_CLOSE' => -11,
			'LITERAL_STRING' => -11,
			"if" => -11,
			"use constant" => -11,
			'LBRACKET' => -11
		},
		GOTOS => {
			'Critic' => 49,
			'STAR-5' => 48
		}
	},
	{#State 39
		DEFAULT => -28
	},
	{#State 40
		ACTIONS => {
			'WORD' => 50,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 51
		}
	},
	{#State 41
		ACTIONS => {
			'LITERAL_NUMBER' => 54,
			"our" => 40
		},
		GOTOS => {
			'Subroutine' => 53
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
			";" => 57,
			'OP01_QW' => 56
		}
	},
	{#State 45
		ACTIONS => {
			"use" => 34
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
		ACTIONS => {
			'LBRACE' => -13,
			"my" => -13,
			'OP01_NAMED' => -13,
			"while" => -13,
			'LPAREN' => -13,
			'WORD_SCOPED' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'WORD' => -13,
			"for" => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			"foreach" => -13,
			'VARIABLE_SYMBOL' => -13,
			'LITERAL_NUMBER' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_OPEN' => -13,
			"\@{" => -13,
			'WORD_UPPERCASE' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"our" => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACKET' => -13,
			"use constant" => -13,
			"if" => -13,
			'OP01_CLOSE' => -13,
			'LITERAL_STRING' => -13,
			'OP01_PRINT' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"undef" => -13,
			"use" => 34
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
		DEFAULT => -201
	},
	{#State 51
		ACTIONS => {
			'VARIABLE_SYMBOL' => 62
		}
	},
	{#State 52
		DEFAULT => -202
	},
	{#State 53
		DEFAULT => -30
	},
	{#State 54
		ACTIONS => {
			";" => 63
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
	},
	{#State 56
		ACTIONS => {
			'WORD' => 66
		},
		GOTOS => {
			'PLUS-15' => 65
		}
	},
	{#State 57
		DEFAULT => -39
	},
	{#State 58
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 67
		}
	},
	{#State 59
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 68
		}
	},
	{#State 60
		ACTIONS => {
			'OP01_NAMED' => -15,
			"while" => -15,
			'LBRACE' => -15,
			"my" => -15,
			"foreach" => -15,
			'VARIABLE_SYMBOL' => -15,
			'LITERAL_NUMBER' => -15,
			"%{" => -15,
			"for" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD' => -15,
			'LPAREN' => -15,
			'WORD_SCOPED' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"our" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_NAMED_VOID' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_OPEN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"\@{" => -15,
			"undef" => -15,
			'LITERAL_STRING' => -15,
			'OP01_CLOSE' => -15,
			'OP01_PRINT' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"use constant" => 43,
			"if" => -15,
			'LBRACKET' => -15
		},
		GOTOS => {
			'Constant' => 70,
			'STAR-7' => 69
		}
	},
	{#State 61
		DEFAULT => -10
	},
	{#State 62
		ACTIONS => {
			"= sub {" => 71
		}
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
			")" => 74,
			'WORD' => 75
		}
	},
	{#State 66
		DEFAULT => -38
	},
	{#State 67
		ACTIONS => {
			"## no critic qw(" => 7,
			"use constant" => -54,
			"use" => -54,
			"our hash_ref \$properties" => -54
		},
		GOTOS => {
			'STAR-21' => 76,
			'Critic' => 77
		}
	},
	{#State 68
		DEFAULT => -33
	},
	{#State 69
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			"our" => 40,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED_VOID' => 93,
			'WORD_UPPERCASE' => 99,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"\@{" => 103,
			"undef" => 80,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			'OP01_PRINT' => 82,
			'OP05_MATH_NEG_LPAREN' => 83,
			"if" => 86,
			'LBRACKET' => 88,
			'OP01_NAMED' => 119,
			"while" => -139,
			'LBRACE' => 122,
			"my" => 123,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"for" => -139,
			"%{" => 112,
			'OP19_LOOP_CONTROL' => 113,
			'WORD' => 24,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP22_LOGICAL_NEG' => 114
		},
		GOTOS => {
			'VariableDeclaration' => 89,
			'OperatorVoid' => 90,
			'HashReference' => 91,
			'Conditional' => 92,
			'Operation' => 87,
			'OPTIONAL-35' => 111,
			'SubExpression' => 81,
			'Variable' => 110,
			'ArrayDereference' => 109,
			'PLUS-8' => 79,
			'PAREN-34' => 78,
			'Operator' => 106,
			'Literal' => 100,
			'Subroutine' => 101,
			'WordScoped' => 102,
			'VariableModification' => 121,
			'LoopLabel' => 120,
			'ArrayReference' => 118,
			'Statement' => 98,
			'Expression' => 97,
			'HashDereference' => 117
		}
	},
	{#State 70
		DEFAULT => -12
	},
	{#State 71
		ACTIONS => {
			"undef" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_PRINT' => -43,
			'OP01_CLOSE' => -43,
			'LITERAL_STRING' => -43,
			"if" => -43,
			'LBRACKET' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'WORD_UPPERCASE' => -43,
			"\@{" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_OPEN' => -43,
			'LITERAL_NUMBER' => -43,
			'VARIABLE_SYMBOL' => -43,
			"foreach" => -43,
			"%{" => -43,
			'OP19_LOOP_CONTROL' => -43,
			"for" => -43,
			'LPAREN_MY' => 125,
			'WORD' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'WORD_SCOPED' => -43,
			'LPAREN' => -43,
			"while" => -43,
			'OP01_NAMED' => -43,
			"my" => -43,
			'LBRACE' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 126,
			'SubroutineArguments' => 124
		}
	},
	{#State 72
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 50
		},
		GOTOS => {
			'Type' => 127
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 108
		},
		GOTOS => {
			'Literal' => 128
		}
	},
	{#State 74
		ACTIONS => {
			";" => 129
		}
	},
	{#State 75
		DEFAULT => -37
	},
	{#State 76
		ACTIONS => {
			"our hash_ref \$properties" => -56,
			"use" => 34,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 131,
			'Include' => 130
		}
	},
	{#State 77
		DEFAULT => -51
	},
	{#State 78
		DEFAULT => -138
	},
	{#State 79
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"\@{" => 103,
			'WORD_UPPERCASE' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED_VOID' => 93,
			'LBRACKET' => 88,
			"if" => 86,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'' => -18,
			'OP01_PRINT' => 82,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'LBRACE' => 122,
			"my" => 123,
			'OP01_NAMED' => 119,
			"while" => -139,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'WORD' => 24,
			"%{" => 112,
			"for" => -139,
			'OP19_LOOP_CONTROL' => 113,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashDereference' => 117,
			'Expression' => 97,
			'Statement' => 98,
			'ArrayReference' => 118,
			'LoopLabel' => 120,
			'VariableModification' => 121,
			'Operation' => 132,
			'OperatorVoid' => 90,
			'HashReference' => 91,
			'Conditional' => 92,
			'VariableDeclaration' => 89,
			'Operator' => 106,
			'ArrayDereference' => 109,
			'PAREN-34' => 78,
			'Variable' => 110,
			'SubExpression' => 81,
			'OPTIONAL-35' => 111
		}
	},
	{#State 80
		DEFAULT => -127
	},
	{#State 81
		ACTIONS => {
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			'OP23_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP15_LOGICAL_AND' => 135,
			'OP11_COMPARE_LT_GT' => 144,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 82
		ACTIONS => {
			'WORD' => -109,
			'WORD_SCOPED' => -109,
			'LBRACKET' => -109,
			'LPAREN' => -109,
			'FH_REF_SYMBOL_BRACES' => 153,
			'OP22_LOGICAL_NEG' => -109,
			"undef" => -109,
			'STDOUT_STDERR' => 150,
			'LITERAL_NUMBER' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP01_CLOSE' => -109,
			"%{" => -109,
			'LITERAL_STRING' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'OP01_OPEN' => -109,
			"my" => -109,
			'LBRACE' => -109,
			"\@{" => -109,
			'OP01_NAMED' => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP01_QW' => -109,
			'WORD_UPPERCASE' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 151,
			'PAREN-30' => 152
		}
	},
	{#State 83
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'WORD' => 24,
			'WORD_UPPERCASE' => 154,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			"\@{" => 103,
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91,
			'Operator' => 106,
			'HashDereference' => 117,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'SubExpression' => 156,
			'Variable' => 158
		}
	},
	{#State 84
		ACTIONS => {
			'FH_REF_SYMBOL' => 159
		}
	},
	{#State 85
		DEFAULT => -207
	},
	{#State 86
		ACTIONS => {
			'LPAREN' => 160
		}
	},
	{#State 87
		DEFAULT => -17
	},
	{#State 88
		ACTIONS => {
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 83,
			'WORD' => 24,
			"]" => -181,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			'OP01_QW' => 165,
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			"my" => 167,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 103
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'TypeInner' => 163,
			'OPTIONAL-45' => 162,
			'ListElements' => 166,
			'HashReference' => 91,
			'Operator' => 106,
			'HashDereference' => 117,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Expression' => 155,
			'ListElement' => 164,
			'SubExpression' => 161,
			'Variable' => 158
		}
	},
	{#State 89
		DEFAULT => -143
	},
	{#State 90
		DEFAULT => -142
	},
	{#State 91
		DEFAULT => -132
	},
	{#State 92
		DEFAULT => -140
	},
	{#State 93
		ACTIONS => {
			"\@{" => 103,
			"my" => 167,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_QW' => 165,
			'WORD_UPPERCASE' => 154,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'TypeInner' => 163,
			'ListElements' => 168,
			'HashReference' => 91,
			'Literal' => 100,
			'WordScoped' => 102,
			'SubExpression' => 161,
			'Variable' => 158,
			'HashDereference' => 117,
			'Operator' => 106,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'ListElement' => 164,
			'Expression' => 155
		}
	},
	{#State 94
		ACTIONS => {
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			'OP11_COMPARE_LT_GT' => -95,
			'OP16_LOGICAL_OR' => -95,
			"%{" => 112,
			'OP08_STRING_CAT' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			")" => -95,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'OP01_NAMED' => 157,
			'OP06_REGEX_MATCH' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'LBRACE' => 122,
			'OP17_LIST_RANGE' => -95,
			"}" => -95,
			"undef" => 80,
			";" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP04_MATH_POW' => -95,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'OP15_LOGICAL_AND' => -95,
			"]" => -95,
			'LBRACKET' => 88,
			'OP08_MATH_ADD_SUB' => -95,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP18_TERNARY' => -95,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104
		},
		GOTOS => {
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 169,
			'Operator' => 106,
			'HashDereference' => 117,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109
		}
	},
	{#State 95
		DEFAULT => -115
	},
	{#State 96
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'Variable' => 170
		}
	},
	{#State 97
		ACTIONS => {
			'OP08_STRING_CAT' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP04_MATH_POW' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP23_LOGICAL_AND' => -126,
			";" => 171,
			'OP18_TERNARY' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP08_MATH_ADD_SUB' => -126
		}
	},
	{#State 98
		DEFAULT => -77
	},
	{#State 99
		ACTIONS => {
			'COLON' => -200,
			'LPAREN' => 172
		}
	},
	{#State 100
		DEFAULT => -128
	},
	{#State 101
		DEFAULT => -14
	},
	{#State 102
		ACTIONS => {
			'LPAREN' => 174,
			'OP02_METHOD_THINARROW_NEW' => 173
		}
	},
	{#State 103
		ACTIONS => {
			'LBRACKET' => 88,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'ArrayReference' => 175,
			'Variable' => 176
		}
	},
	{#State 104
		ACTIONS => {
			"my" => 177
		}
	},
	{#State 105
		ACTIONS => {
			'WORD_UPPERCASE' => 154,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			"\@{" => 103,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD' => 24
		},
		GOTOS => {
			'SubExpression' => 178,
			'Variable' => 158,
			'HashDereference' => 117,
			'Operator' => 106,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Expression' => 155,
			'HashReference' => 91,
			'Literal' => 100,
			'WordScoped' => 102
		}
	},
	{#State 106
		DEFAULT => -121
	},
	{#State 107
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 179
		}
	},
	{#State 108
		DEFAULT => -208
	},
	{#State 109
		DEFAULT => -131
	},
	{#State 110
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP19_VARIABLE_ASSIGN' => 181,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 180,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP03_MATH_INC_DEC' => 182,
			'OP06_REGEX_MATCH' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP02_METHOD_THINARROW' => 183,
			'OP08_STRING_CAT' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP04_MATH_POW' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP15_LOGICAL_AND' => -129
		}
	},
	{#State 111
		ACTIONS => {
			"for" => 188,
			"while" => 186,
			"foreach" => 189
		},
		GOTOS => {
			'LoopWhile' => 184,
			'LoopFor' => 190,
			'Loop' => 185,
			'LoopForEach' => 187
		}
	},
	{#State 112
		ACTIONS => {
			'LBRACE' => 122,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'HashReference' => 191,
			'Variable' => 192
		}
	},
	{#State 113
		ACTIONS => {
			'WORD_UPPERCASE' => 193
		},
		GOTOS => {
			'LoopLabel' => 194
		}
	},
	{#State 114
		ACTIONS => {
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'WORD_UPPERCASE' => 154,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Variable' => 158,
			'SubExpression' => 195
		}
	},
	{#State 115
		DEFAULT => -112
	},
	{#State 116
		ACTIONS => {
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'OP01_PRINT' => 197,
			'OP05_MATH_NEG_LPAREN' => 83,
			'WORD' => 24,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 198,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"\@{" => 103
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91,
			'Operator' => 106,
			'HashDereference' => 117,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'SubExpression' => 196,
			'Variable' => 158
		}
	},
	{#State 117
		DEFAULT => -133
	},
	{#State 118
		DEFAULT => -130
	},
	{#State 119
		ACTIONS => {
			'WORD_UPPERCASE' => 154,
			'OP01_QW' => 165,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 167,
			'OP01_OPEN' => 104,
			"\@{" => 103,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24
		},
		GOTOS => {
			'Operator' => 106,
			'HashDereference' => 117,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'ListElement' => 199,
			'Expression' => 155,
			'SubExpression' => 200,
			'Variable' => 158,
			'Literal' => 100,
			'WordScoped' => 102,
			'TypeInner' => 163,
			'HashReference' => 91
		}
	},
	{#State 120
		ACTIONS => {
			'COLON' => 201
		}
	},
	{#State 121
		DEFAULT => -144
	},
	{#State 122
		ACTIONS => {
			'WORD' => 204,
			"}" => 205,
			"%{" => 112
		},
		GOTOS => {
			'HashDereference' => 202,
			'HashEntry' => 203
		}
	},
	{#State 123
		ACTIONS => {
			'WORD' => 50,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 206
		}
	},
	{#State 124
		DEFAULT => -42
	},
	{#State 125
		ACTIONS => {
			'WORD' => 50,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 207
		}
	},
	{#State 126
		ACTIONS => {
			"\@{" => 103,
			'LBRACE' => 122,
			"my" => 123,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'WORD_UPPERCASE' => 99,
			"while" => -139,
			'OP01_NAMED_VOID' => 93,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_NAMED' => 119,
			'OP22_LOGICAL_NEG' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			"if" => 86,
			'WORD' => 24,
			'OP01_PRINT' => 82,
			'OP05_MATH_NEG_LPAREN' => 83,
			"for" => -139,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'OP19_LOOP_CONTROL' => 113,
			"%{" => 112,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"foreach" => -139,
			"undef" => 80
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'VariableModification' => 121,
			'LoopLabel' => 120,
			'ArrayReference' => 118,
			'Expression' => 97,
			'Statement' => 98,
			'HashDereference' => 117,
			'VariableDeclaration' => 89,
			'OperatorVoid' => 90,
			'HashReference' => 91,
			'Conditional' => 92,
			'Operation' => 209,
			'OPTIONAL-35' => 111,
			'PLUS-17' => 208,
			'SubExpression' => 81,
			'Variable' => 110,
			'PAREN-34' => 78,
			'ArrayDereference' => 109,
			'Operator' => 106
		}
	},
	{#State 127
		ACTIONS => {
			"\$TYPED_" => 210
		}
	},
	{#State 128
		ACTIONS => {
			";" => 211
		}
	},
	{#State 129
		DEFAULT => -40
	},
	{#State 130
		DEFAULT => -53
	},
	{#State 131
		ACTIONS => {
			"our hash_ref \$properties" => 213,
			"use constant" => 43
		},
		GOTOS => {
			'Constant' => 212,
			'Properties' => 214
		}
	},
	{#State 132
		DEFAULT => -16
	},
	{#State 133
		ACTIONS => {
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			"\@{" => 103,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'WORD_UPPERCASE' => 154
		},
		GOTOS => {
			'Operator' => 106,
			'HashDereference' => 117,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Variable' => 158,
			'SubExpression' => 215,
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91
		}
	},
	{#State 134
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			"\@{" => 103,
			'WORD_UPPERCASE' => 154,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94
		},
		GOTOS => {
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Operator' => 106,
			'HashDereference' => 117,
			'Variable' => 158,
			'SubExpression' => 216,
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91
		}
	},
	{#State 135
		ACTIONS => {
			"\@{" => 103,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'Operator' => 106,
			'HashDereference' => 117,
			'SubExpression' => 217,
			'Variable' => 158
		}
	},
	{#State 136
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			"\@{" => 103,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154,
			'WORD' => 24,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 114,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 83
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Variable' => 158,
			'SubExpression' => 218
		}
	},
	{#State 137
		ACTIONS => {
			"\@{" => 103,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 154,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'WORD' => 24,
			'OP05_MATH_NEG_LPAREN' => 83,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80
		},
		GOTOS => {
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 219,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Operator' => 106,
			'HashDereference' => 117
		}
	},
	{#State 138
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'Literal' => 220,
			'VariableOrLiteral' => 221,
			'Variable' => 222
		}
	},
	{#State 139
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			"\@{" => 103,
			'WORD_UPPERCASE' => 154,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96
		},
		GOTOS => {
			'HashDereference' => 117,
			'Operator' => 106,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'SubExpression' => 223,
			'Variable' => 158,
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91
		}
	},
	{#State 140
		ACTIONS => {
			'WORD_UPPERCASE' => 154,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			"\@{" => 103,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24
		},
		GOTOS => {
			'Variable' => 158,
			'SubExpression' => 224,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'HashDereference' => 117,
			'Operator' => 106,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100
		}
	},
	{#State 141
		ACTIONS => {
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 83,
			'WORD' => 24,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"\@{" => 103
		},
		GOTOS => {
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 225,
			'Expression' => 155,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Operator' => 106,
			'HashDereference' => 117
		}
	},
	{#State 142
		ACTIONS => {
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'WORD_UPPERCASE' => 154,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 103
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Expression' => 155,
			'Operator' => 106,
			'HashDereference' => 117,
			'SubExpression' => 226,
			'Variable' => 158
		}
	},
	{#State 143
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			"\@{" => 103,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116
		},
		GOTOS => {
			'SubExpression' => 227,
			'Variable' => 158,
			'Operator' => 106,
			'HashDereference' => 117,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Expression' => 155,
			'HashReference' => 91,
			'Literal' => 100,
			'WordScoped' => 102
		}
	},
	{#State 144
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			"\@{" => 103,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104
		},
		GOTOS => {
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 228,
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109
		}
	},
	{#State 145
		ACTIONS => {
			'WORD_UPPERCASE' => 154,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			"\@{" => 103,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'HashReference' => 91,
			'Literal' => 100,
			'WordScoped' => 102,
			'SubExpression' => 229,
			'Variable' => 158,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'Operator' => 106,
			'HashDereference' => 117
		}
	},
	{#State 146
		ACTIONS => {
			"\@{" => 103,
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'WORD_UPPERCASE' => 154,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'WORD' => 24,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80
		},
		GOTOS => {
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Variable' => 158,
			'SubExpression' => 230,
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91
		}
	},
	{#State 147
		ACTIONS => {
			"\@{" => 103,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 231,
			'Operator' => 106,
			'HashDereference' => 117,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109
		}
	},
	{#State 148
		ACTIONS => {
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 103,
			'WORD_UPPERCASE' => 154,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108
		},
		GOTOS => {
			'Variable' => 158,
			'SubExpression' => 232,
			'Expression' => 155,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'HashDereference' => 117,
			'Operator' => 106,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100
		}
	},
	{#State 149
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 233
		}
	},
	{#State 150
		DEFAULT => -107
	},
	{#State 151
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 114,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"my" => 167,
			'LBRACE' => 122,
			"\@{" => 103,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'OP01_QW' => 165,
			'WORD_UPPERCASE' => 154
		},
		GOTOS => {
			'Expression' => 155,
			'ListElement' => 164,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'HashDereference' => 117,
			'Operator' => 106,
			'Variable' => 158,
			'SubExpression' => 161,
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'ListElements' => 234,
			'TypeInner' => 163
		}
	},
	{#State 152
		DEFAULT => -108
	},
	{#State 153
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP01_QW' => 165,
			'WORD_UPPERCASE' => 154,
			"\@{" => 103,
			"my" => 167,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116
		},
		GOTOS => {
			'ListElements' => 235,
			'TypeInner' => 163,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 161,
			'HashDereference' => 117,
			'Operator' => 106,
			'ListElement' => 164,
			'Expression' => 155,
			'ArrayDereference' => 109,
			'ArrayReference' => 118
		}
	},
	{#State 154
		ACTIONS => {
			'LPAREN' => 172
		}
	},
	{#State 155
		DEFAULT => -126
	},
	{#State 156
		ACTIONS => {
			")" => 236,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			'OP23_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 157
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"\@{" => 103,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'OP05_MATH_NEG_LPAREN' => 83,
			'WORD' => 24,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91,
			'HashDereference' => 117,
			'Operator' => 106,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'SubExpression' => 237,
			'Variable' => 158
		}
	},
	{#State 158
		ACTIONS => {
			'OP23_LOGICAL_AND' => -129,
			";" => -129,
			'OP17_LIST_RANGE' => -129,
			"}" => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP04_MATH_POW' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP02_METHOD_THINARROW' => 183,
			"]" => -129,
			")" => -129,
			'OP03_MATH_INC_DEC' => 182,
			'OP08_MATH_ADD_SUB' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP18_TERNARY' => -129,
			'OP14_BITWISE_OR_XOR' => -129
		}
	},
	{#State 159
		DEFAULT => -82
	},
	{#State 160
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154,
			"\@{" => 103,
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'HashReference' => 91,
			'Literal' => 100,
			'WordScoped' => 102,
			'SubExpression' => 238,
			'Variable' => 158,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'Operator' => 106,
			'HashDereference' => 117
		}
	},
	{#State 161
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -177,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 139,
			"]" => -177,
			")" => -177,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			'OP16_LOGICAL_OR' => 145,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			'OP15_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 134,
			";" => -177,
			'OP23_LOGICAL_AND' => 133
		}
	},
	{#State 162
		ACTIONS => {
			"]" => 239
		}
	},
	{#State 163
		ACTIONS => {
			'WORD_UPPERCASE' => 154,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			"\@{" => 103,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24
		},
		GOTOS => {
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 240,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Operator' => 106,
			'HashDereference' => 117
		}
	},
	{#State 164
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 241
		}
	},
	{#State 165
		ACTIONS => {
			'WORD' => 242
		},
		GOTOS => {
			'PLUS-44' => 243
		}
	},
	{#State 166
		DEFAULT => -180
	},
	{#State 167
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 50
		},
		GOTOS => {
			'Type' => 244
		}
	},
	{#State 168
		ACTIONS => {
			";" => 245
		}
	},
	{#State 169
		ACTIONS => {
			"}" => -94,
			'OP17_LIST_RANGE' => -94,
			";" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => -94,
			'OP15_LOGICAL_AND' => -94,
			")" => -94,
			"]" => -94,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP18_TERNARY' => -94
		}
	},
	{#State 170
		DEFAULT => -83
	},
	{#State 171
		DEFAULT => -76
	},
	{#State 172
		ACTIONS => {
			")" => 246
		}
	},
	{#State 173
		ACTIONS => {
			")" => 247
		}
	},
	{#State 174
		ACTIONS => {
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			")" => -118,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LBRACE' => 122,
			"my" => 167,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"\@{" => 103,
			'WORD_UPPERCASE' => 154,
			'OP01_QW' => 165,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157
		},
		GOTOS => {
			'TypeInner' => 163,
			'ListElements' => 248,
			'HashReference' => 91,
			'OPTIONAL-32' => 249,
			'Literal' => 100,
			'WordScoped' => 102,
			'SubExpression' => 161,
			'Variable' => 158,
			'HashDereference' => 117,
			'Operator' => 106,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'ListElement' => 164,
			'Expression' => 155
		}
	},
	{#State 175
		ACTIONS => {
			"}" => 250
		}
	},
	{#State 176
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 177
		ACTIONS => {
			"filehandle_ref" => 252
		}
	},
	{#State 178
		ACTIONS => {
			'OP17_LIST_RANGE' => -86,
			"}" => -86,
			";" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP04_MATH_POW' => 136,
			'OP16_LOGICAL_OR' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP08_STRING_CAT' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			")" => -86,
			"]" => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP18_TERNARY' => -86
		}
	},
	{#State 179
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP02_HASH_THINARROW' => 254,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP18_TERNARY' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP13_BITWISE_AND' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP08_STRING_CAT' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			")" => -163,
			"]" => -163,
			'OP23_LOGICAL_AND' => -163,
			";" => -163,
			'OP17_LIST_RANGE' => -163,
			'COLON' => -163,
			"}" => -163,
			'OP02_ARRAY_THINARROW' => 253,
			'OP15_LOGICAL_AND' => -163,
			'OP04_MATH_POW' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP16_LOGICAL_OR' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 255
		}
	},
	{#State 180
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			"\@{" => 103,
			'WORD_UPPERCASE' => 154,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'Operator' => 106,
			'HashDereference' => 117,
			'Expression' => 155,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Variable' => 158,
			'SubExpression' => 256
		}
	},
	{#State 181
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			"\@{" => 103,
			'WORD_UPPERCASE' => 154,
			'STDIN' => 257,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'SubExpressionOrStdin' => 258,
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Variable' => 158,
			'SubExpression' => 259
		}
	},
	{#State 182
		DEFAULT => -84
	},
	{#State 183
		ACTIONS => {
			'LPAREN' => 260
		}
	},
	{#State 184
		DEFAULT => -154
	},
	{#State 185
		DEFAULT => -141
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 261
		}
	},
	{#State 187
		DEFAULT => -153
	},
	{#State 188
		ACTIONS => {
			"my" => 262
		}
	},
	{#State 189
		ACTIONS => {
			"my" => 263
		}
	},
	{#State 190
		DEFAULT => -152
	},
	{#State 191
		ACTIONS => {
			"}" => 264
		}
	},
	{#State 192
		ACTIONS => {
			"}" => 265
		}
	},
	{#State 193
		DEFAULT => -200
	},
	{#State 194
		ACTIONS => {
			";" => 266
		}
	},
	{#State 195
		ACTIONS => {
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP13_BITWISE_AND' => 141,
			"]" => -104,
			")" => -104,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			"}" => -104,
			'OP17_LIST_RANGE' => 134,
			'OP23_LOGICAL_AND' => -104,
			";" => -104,
			'OP11_COMPARE_LT_GT' => 144,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP15_LOGICAL_AND' => 135
		}
	},
	{#State 196
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP17_LIST_RANGE' => 134,
			'OP23_LOGICAL_AND' => 133,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP15_LOGICAL_AND' => 135,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			")" => 267
		}
	},
	{#State 197
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 268
		}
	},
	{#State 198
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD' => 24,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			"\@{" => 103,
			'OP01_OPEN' => 104,
			"my" => 167,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			'OP01_QW' => 165,
			'WORD_UPPERCASE' => 154,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157
		},
		GOTOS => {
			'Variable' => 158,
			'SubExpression' => 200,
			'Operator' => 106,
			'HashDereference' => 117,
			'ListElement' => 269,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'TypeInner' => 163,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100
		}
	},
	{#State 199
		ACTIONS => {
			'OP21_LIST_COMMA' => 270
		}
	},
	{#State 200
		ACTIONS => {
			'OP21_LIST_COMMA' => -177,
			'OP06_REGEX_MATCH' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP04_MATH_POW' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP17_LIST_RANGE' => -79,
			";" => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP08_STRING_CAT' => -79,
			")" => -79
		}
	},
	{#State 201
		DEFAULT => -137
	},
	{#State 202
		DEFAULT => -188
	},
	{#State 203
		DEFAULT => -193,
		GOTOS => {
			'STAR-48' => 271
		}
	},
	{#State 204
		ACTIONS => {
			'OP20_HASH_FATARROW' => 272
		}
	},
	{#State 205
		DEFAULT => -195
	},
	{#State 206
		ACTIONS => {
			'VARIABLE_SYMBOL' => 273
		}
	},
	{#State 207
		ACTIONS => {
			'VARIABLE_SYMBOL' => 274
		}
	},
	{#State 208
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'WORD' => 24,
			"for" => -139,
			'OP19_LOOP_CONTROL' => 113,
			"%{" => 112,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"foreach" => -139,
			'LBRACE' => 122,
			"my" => 123,
			"while" => -139,
			'OP01_NAMED' => 119,
			'LBRACKET' => 88,
			"if" => 86,
			'OP01_PRINT' => 82,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"}" => 275,
			"undef" => 80,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 99,
			'OP01_NAMED_VOID' => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96
		},
		GOTOS => {
			'OPTIONAL-35' => 111,
			'SubExpression' => 81,
			'Variable' => 110,
			'ArrayDereference' => 109,
			'PAREN-34' => 78,
			'Operator' => 106,
			'VariableDeclaration' => 89,
			'HashReference' => 91,
			'OperatorVoid' => 90,
			'Conditional' => 92,
			'Operation' => 276,
			'VariableModification' => 121,
			'LoopLabel' => 120,
			'ArrayReference' => 118,
			'Statement' => 98,
			'Expression' => 97,
			'HashDereference' => 117,
			'Literal' => 100,
			'WordScoped' => 102
		}
	},
	{#State 209
		DEFAULT => -45
	},
	{#State 210
		ACTIONS => {
			'WORD_UPPERCASE' => 277
		}
	},
	{#State 211
		DEFAULT => -41
	},
	{#State 212
		DEFAULT => -55
	},
	{#State 213
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 278
		}
	},
	{#State 214
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 279
		}
	},
	{#State 215
		ACTIONS => {
			"]" => -105,
			")" => -105,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			'OP15_LOGICAL_AND' => 135,
			'OP11_COMPARE_LT_GT' => 144,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			";" => -105,
			'OP23_LOGICAL_AND' => -105,
			"}" => -105,
			'OP17_LIST_RANGE' => 134,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 139
		}
	},
	{#State 216
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -102,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => 148,
			"}" => -102,
			'OP17_LIST_RANGE' => undef,
			";" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => 145,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			'OP15_LOGICAL_AND' => 135,
			")" => -102,
			"]" => -102,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143
		}
	},
	{#State 217
		ACTIONS => {
			'OP17_LIST_RANGE' => -100,
			"}" => -100,
			";" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP15_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			")" => -100,
			"]" => -100,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => 148
		}
	},
	{#State 218
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -85,
			'OP08_STRING_CAT' => -85,
			"]" => -85,
			")" => -85,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			";" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP18_TERNARY' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP08_MATH_ADD_SUB' => -85
		}
	},
	{#State 219
		ACTIONS => {
			'OP15_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			";" => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			"}" => -97,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			")" => -97,
			"]" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP18_TERNARY' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP07_STRING_REPEAT' => 147
		}
	},
	{#State 220
		DEFAULT => -206
	},
	{#State 221
		ACTIONS => {
			'COLON' => 280
		}
	},
	{#State 222
		DEFAULT => -205
	},
	{#State 223
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP06_REGEX_MATCH' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP18_TERNARY' => -91,
			'OP23_LOGICAL_AND' => -91,
			";" => -91,
			"}" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP04_MATH_POW' => 136,
			"]" => -91,
			")" => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP08_STRING_CAT' => -91
		}
	},
	{#State 224
		ACTIONS => {
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			"]" => -106,
			")" => -106,
			'OP17_LIST_RANGE' => 134,
			"}" => -106,
			'OP23_LOGICAL_AND' => 133,
			";" => -106,
			'OP16_LOGICAL_OR' => 145,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			'OP15_LOGICAL_AND' => 135,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -106,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => -106
		}
	},
	{#State 225
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			'OP17_LIST_RANGE' => -98,
			"}" => -98,
			'OP23_LOGICAL_AND' => -98,
			";" => -98,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			'OP16_LOGICAL_OR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			")" => -98,
			"]" => -98
		}
	},
	{#State 226
		ACTIONS => {
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => -93,
			"]" => -93,
			")" => -93,
			'OP17_LIST_RANGE' => -93,
			"}" => -93,
			";" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP04_MATH_POW' => 136,
			'OP16_LOGICAL_OR' => -93,
			'OP15_LOGICAL_AND' => -93
		}
	},
	{#State 227
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP13_BITWISE_AND' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP06_REGEX_MATCH' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			'OP23_LOGICAL_AND' => -92,
			";" => -92,
			"}" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => -92,
			"]" => -92,
			")" => -92,
			'OP08_STRING_CAT' => -92,
			'OP09_BITWISE_SHIFT' => -92
		}
	},
	{#State 228
		ACTIONS => {
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP18_TERNARY' => -96,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			"]" => -96,
			")" => -96,
			'OP17_LIST_RANGE' => -96,
			"}" => -96,
			'OP23_LOGICAL_AND' => -96,
			";" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => undef,
			'OP15_LOGICAL_AND' => -96
		}
	},
	{#State 229
		ACTIONS => {
			'OP16_LOGICAL_OR' => -101,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			'OP15_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => -101,
			"}" => -101,
			";" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			")" => -101,
			"]" => -101,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -101,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => 139,
			'OP18_TERNARY' => -101,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146
		}
	},
	{#State 230
		ACTIONS => {
			'OP15_LOGICAL_AND' => -90,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP23_LOGICAL_AND' => -90,
			";" => -90,
			'OP17_LIST_RANGE' => -90,
			"}" => -90,
			'OP08_STRING_CAT' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			")" => -90,
			"]" => -90,
			'OP13_BITWISE_AND' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => -90,
			'OP18_TERNARY' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => -90
		}
	},
	{#State 231
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -89,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP18_TERNARY' => -89,
			'OP17_LIST_RANGE' => -89,
			"}" => -89,
			'OP23_LOGICAL_AND' => -89,
			";" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP04_MATH_POW' => 136,
			'OP15_LOGICAL_AND' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP08_STRING_CAT' => -89,
			")" => -89,
			"]" => -89
		}
	},
	{#State 232
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			")" => -99,
			"]" => -99,
			'OP23_LOGICAL_AND' => -99,
			";" => -99,
			'OP17_LIST_RANGE' => -99,
			"}" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP18_TERNARY' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 139,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 233
		DEFAULT => -88
	},
	{#State 234
		ACTIONS => {
			";" => 281
		}
	},
	{#State 235
		ACTIONS => {
			";" => 282
		}
	},
	{#State 236
		DEFAULT => -87
	},
	{#State 237
		ACTIONS => {
			'OP17_LIST_RANGE' => -79,
			"}" => -79,
			'OP23_LOGICAL_AND' => -79,
			";" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP04_MATH_POW' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP08_STRING_CAT' => -79,
			")" => -79,
			"]" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79
		}
	},
	{#State 238
		ACTIONS => {
			")" => 283,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			'OP23_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP15_LOGICAL_AND' => 135,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			'OP16_LOGICAL_OR' => 145,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149
		}
	},
	{#State 239
		DEFAULT => -182
	},
	{#State 240
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 141,
			'OP21_LIST_COMMA' => -178,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP23_LOGICAL_AND' => 133,
			";" => -178,
			'OP17_LIST_RANGE' => 134,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			")" => -178,
			"]" => -178
		}
	},
	{#State 241
		ACTIONS => {
			")" => -174,
			"]" => -174,
			";" => -174,
			'OP21_LIST_COMMA' => 285
		},
		GOTOS => {
			'PAREN-42' => 284
		}
	},
	{#State 242
		DEFAULT => -176
	},
	{#State 243
		ACTIONS => {
			'WORD' => 286,
			")" => 287
		}
	},
	{#State 244
		ACTIONS => {
			"\$TYPED_" => 288
		}
	},
	{#State 245
		DEFAULT => -113
	},
	{#State 246
		DEFAULT => -123
	},
	{#State 247
		DEFAULT => -125
	},
	{#State 248
		DEFAULT => -117
	},
	{#State 249
		ACTIONS => {
			")" => 289
		}
	},
	{#State 250
		DEFAULT => -184
	},
	{#State 251
		DEFAULT => -183
	},
	{#State 252
		ACTIONS => {
			'FH_REF_SYMBOL' => 290
		}
	},
	{#State 253
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 157,
			'WORD_UPPERCASE' => 154,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88
		},
		GOTOS => {
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 291,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'HashDereference' => 117,
			'Operator' => 106
		}
	},
	{#State 254
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'WORD' => 293,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			"\@{" => 103,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 154,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94
		},
		GOTOS => {
			'Variable' => 158,
			'SubExpression' => 292,
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100
		}
	},
	{#State 255
		DEFAULT => -161
	},
	{#State 256
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP17_LIST_RANGE' => 134,
			";" => 294,
			'OP23_LOGICAL_AND' => 133,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP16_LOGICAL_OR' => 145,
			'OP15_LOGICAL_AND' => 135,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143
		}
	},
	{#State 257
		DEFAULT => -136
	},
	{#State 258
		ACTIONS => {
			";" => 295
		}
	},
	{#State 259
		ACTIONS => {
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			'OP15_LOGICAL_AND' => 135,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP16_LOGICAL_OR' => 145,
			";" => -135,
			'OP23_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 134
		}
	},
	{#State 260
		ACTIONS => {
			'WORD' => 24,
			")" => -120,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			'OP05_MATH_NEG_LPAREN' => 83,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 167,
			'OP01_OPEN' => 104,
			"\@{" => 103,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			'OP01_QW' => 165
		},
		GOTOS => {
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'OPTIONAL-33' => 296,
			'ListElement' => 164,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'Variable' => 158,
			'SubExpression' => 161,
			'WordScoped' => 102,
			'Literal' => 100,
			'ListElements' => 297,
			'TypeInner' => 163,
			'HashReference' => 91
		}
	},
	{#State 261
		ACTIONS => {
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			"\@{" => 103,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			'WORD' => 24,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'OP22_LOGICAL_NEG' => 114,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'OP05_MATH_NEG_LPAREN' => 83
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Variable' => 158,
			'SubExpression' => 298
		}
	},
	{#State 262
		ACTIONS => {
			'TYPE_INTEGER' => 299
		}
	},
	{#State 263
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 50
		},
		GOTOS => {
			'Type' => 300
		}
	},
	{#State 264
		DEFAULT => -197
	},
	{#State 265
		DEFAULT => -196
	},
	{#State 266
		DEFAULT => -116
	},
	{#State 267
		DEFAULT => -134
	},
	{#State 268
		ACTIONS => {
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'OP01_QW' => 165,
			'WORD_UPPERCASE' => 154,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			"my" => 167,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			"\@{" => 103
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'ListElements' => 301,
			'TypeInner' => 163,
			'ListElement' => 164,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Operator' => 106,
			'HashDereference' => 117,
			'Variable' => 158,
			'SubExpression' => 161
		}
	},
	{#State 269
		ACTIONS => {
			'OP21_LIST_COMMA' => 302
		}
	},
	{#State 270
		ACTIONS => {
			"\@{" => 103,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			"my" => 167,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			'OP01_QW' => 165,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112
		},
		GOTOS => {
			'ListElements' => 303,
			'TypeInner' => 163,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 161,
			'HashDereference' => 117,
			'Operator' => 106,
			'Expression' => 155,
			'ListElement' => 164,
			'ArrayDereference' => 109,
			'ArrayReference' => 118
		}
	},
	{#State 271
		ACTIONS => {
			'OP21_LIST_COMMA' => 306,
			"}" => 305
		},
		GOTOS => {
			'PAREN-47' => 304
		}
	},
	{#State 272
		ACTIONS => {
			'OP10_NAMED_UNARY' => -186,
			'OP03_MATH_INC_DEC' => -186,
			'OP01_NAMED' => -186,
			'WORD_UPPERCASE' => -186,
			"\@{" => -186,
			'OP05_LOGICAL_NEG' => -186,
			'OP01_OPEN' => -186,
			"my" => 167,
			'LBRACE' => -186,
			'LITERAL_NUMBER' => -186,
			'VARIABLE_SYMBOL' => -186,
			"undef" => -186,
			'OP05_MATH_NEG_LPAREN' => -186,
			'OP01_CLOSE' => -186,
			"%{" => -186,
			'LITERAL_STRING' => -186,
			'WORD' => -186,
			'OP22_LOGICAL_NEG' => -186,
			'WORD_SCOPED' => -186,
			'LPAREN' => -186,
			'LBRACKET' => -186
		},
		GOTOS => {
			'TypeInner' => 308,
			'OPTIONAL-46' => 307
		}
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 310,
			";" => 309
		}
	},
	{#State 274
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 311
		}
	},
	{#State 275
		ACTIONS => {
			";" => 312
		}
	},
	{#State 276
		DEFAULT => -44
	},
	{#State 277
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 313
		}
	},
	{#State 278
		ACTIONS => {
			'LBRACE' => 314
		}
	},
	{#State 279
		ACTIONS => {
			"our" => 315,
			'LITERAL_NUMBER' => 319
		},
		GOTOS => {
			'Subroutine' => 316,
			'Method' => 317,
			'MethodOrSubroutine' => 318
		}
	},
	{#State 280
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107
		},
		GOTOS => {
			'Literal' => 220,
			'VariableOrLiteral' => 320,
			'Variable' => 222
		}
	},
	{#State 281
		DEFAULT => -110
	},
	{#State 282
		DEFAULT => -111
	},
	{#State 283
		ACTIONS => {
			'LBRACE' => 321
		},
		GOTOS => {
			'CodeBlock' => 322
		}
	},
	{#State 284
		DEFAULT => -172
	},
	{#State 285
		ACTIONS => {
			'OP01_QW' => 165,
			'WORD_UPPERCASE' => 154,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94,
			"\@{" => 103,
			'OP01_OPEN' => 104,
			"my" => 167,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD' => 24
		},
		GOTOS => {
			'Expression' => 155,
			'ListElement' => 323,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Operator' => 106,
			'HashDereference' => 117,
			'Variable' => 158,
			'SubExpression' => 161,
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'TypeInner' => 163
		}
	},
	{#State 286
		DEFAULT => -175
	},
	{#State 287
		DEFAULT => -179
	},
	{#State 288
		ACTIONS => {
			'WORD' => 324
		}
	},
	{#State 289
		DEFAULT => -122
	},
	{#State 290
		ACTIONS => {
			'OP21_LIST_COMMA' => 325
		}
	},
	{#State 291
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP06_REGEX_MATCH' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP23_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP15_LOGICAL_AND' => 135,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP16_LOGICAL_OR' => 145,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			"]" => 326
		}
	},
	{#State 292
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP06_REGEX_MATCH' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 141,
			'OP08_MATH_ADD_SUB' => 139,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP15_LOGICAL_AND' => 135,
			"}" => 327,
			'OP17_LIST_RANGE' => 134,
			'OP23_LOGICAL_AND' => 133
		}
	},
	{#State 293
		ACTIONS => {
			'LPAREN' => -198,
			'OP02_METHOD_THINARROW_NEW' => -198,
			"}" => 328
		}
	},
	{#State 294
		DEFAULT => -170
	},
	{#State 295
		DEFAULT => -169
	},
	{#State 296
		ACTIONS => {
			")" => 329
		}
	},
	{#State 297
		DEFAULT => -119
	},
	{#State 298
		ACTIONS => {
			'OP23_LOGICAL_AND' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP15_LOGICAL_AND' => 135,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			")" => 330,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			'OP08_MATH_ADD_SUB' => 139,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 141,
			'OP06_REGEX_MATCH' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148
		}
	},
	{#State 299
		ACTIONS => {
			'VARIABLE_SYMBOL' => 331
		}
	},
	{#State 300
		ACTIONS => {
			'VARIABLE_SYMBOL' => 332
		}
	},
	{#State 301
		ACTIONS => {
			")" => 333
		}
	},
	{#State 302
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD' => 24,
			'OP01_QW' => 165,
			'WORD_UPPERCASE' => 154,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			"\@{" => 103,
			'OP01_OPEN' => 104,
			"my" => 167,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashReference' => 91,
			'ListElements' => 334,
			'TypeInner' => 163,
			'ListElement' => 164,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Operator' => 106,
			'HashDereference' => 117,
			'Variable' => 158,
			'SubExpression' => 161
		}
	},
	{#State 303
		ACTIONS => {
			";" => 335
		}
	},
	{#State 304
		DEFAULT => -192
	},
	{#State 305
		DEFAULT => -194
	},
	{#State 306
		ACTIONS => {
			"%{" => 112,
			'WORD' => 204
		},
		GOTOS => {
			'HashDereference' => 202,
			'HashEntry' => 336
		}
	},
	{#State 307
		ACTIONS => {
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154
		},
		GOTOS => {
			'Variable' => 158,
			'SubExpression' => 337,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'HashDereference' => 117,
			'Operator' => 106,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100
		}
	},
	{#State 308
		DEFAULT => -185
	},
	{#State 309
		DEFAULT => -167
	},
	{#State 310
		ACTIONS => {
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"\@{" => 103,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'LBRACE' => 122,
			'STDIN' => 257,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'WORD_UPPERCASE' => 154
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'Operator' => 106,
			'HashDereference' => 117,
			'SubExpressionOrStdin' => 338,
			'SubExpression' => 259,
			'Variable' => 158
		}
	},
	{#State 311
		ACTIONS => {
			'OP21_LIST_COMMA' => 341,
			")" => 340
		},
		GOTOS => {
			'PAREN-18' => 339
		}
	},
	{#State 312
		DEFAULT => -46
	},
	{#State 313
		DEFAULT => -204
	},
	{#State 314
		ACTIONS => {
			'WORD' => 345,
			"}" => 343,
			"%{" => 112
		},
		GOTOS => {
			'HashDereference' => 344,
			'HashEntryTyped' => 342
		}
	},
	{#State 315
		ACTIONS => {
			'WORD' => 50,
			'TYPE_INTEGER' => 52,
			'TYPE_METHOD' => 346
		},
		GOTOS => {
			'Type' => 51
		}
	},
	{#State 316
		DEFAULT => -75
	},
	{#State 317
		DEFAULT => -74
	},
	{#State 318
		DEFAULT => -57
	},
	{#State 319
		ACTIONS => {
			";" => 347
		}
	},
	{#State 320
		DEFAULT => -103
	},
	{#State 321
		ACTIONS => {
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			"if" => 86,
			'OP01_CLOSE' => 84,
			"for" => -139,
			"%{" => 112,
			'OP19_LOOP_CONTROL' => 113,
			'LITERAL_STRING' => 85,
			'OP01_PRINT' => 82,
			'OP05_MATH_NEG_LPAREN' => 83,
			"foreach" => -139,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LBRACE' => 122,
			"my" => 123,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"\@{" => 103,
			'WORD_UPPERCASE' => 99,
			'OP10_NAMED_UNARY' => 94,
			'OP01_NAMED' => 119,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP03_MATH_INC_DEC' => 96,
			"while" => -139,
			'OP01_NAMED_VOID' => 93
		},
		GOTOS => {
			'WordScoped' => 102,
			'Literal' => 100,
			'HashDereference' => 117,
			'Expression' => 97,
			'Statement' => 98,
			'ArrayReference' => 118,
			'LoopLabel' => 120,
			'VariableModification' => 121,
			'Operation' => 348,
			'OperatorVoid' => 90,
			'Conditional' => 92,
			'HashReference' => 91,
			'VariableDeclaration' => 89,
			'Operator' => 106,
			'PLUS-40' => 349,
			'ArrayDereference' => 109,
			'PAREN-34' => 78,
			'Variable' => 110,
			'SubExpression' => 81,
			'OPTIONAL-35' => 111
		}
	},
	{#State 322
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 350
		}
	},
	{#State 323
		DEFAULT => -171
	},
	{#State 324
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 351
		}
	},
	{#State 325
		ACTIONS => {
			'LITERAL_STRING' => 352
		}
	},
	{#State 326
		DEFAULT => -164
	},
	{#State 327
		DEFAULT => -165
	},
	{#State 328
		DEFAULT => -166
	},
	{#State 329
		DEFAULT => -124
	},
	{#State 330
		ACTIONS => {
			'LBRACE' => 321
		},
		GOTOS => {
			'CodeBlock' => 353
		}
	},
	{#State 331
		ACTIONS => {
			'LPAREN' => 354
		}
	},
	{#State 332
		ACTIONS => {
			'LPAREN' => 355
		}
	},
	{#State 333
		DEFAULT => -78
	},
	{#State 334
		ACTIONS => {
			")" => 356
		}
	},
	{#State 335
		DEFAULT => -114
	},
	{#State 336
		DEFAULT => -191
	},
	{#State 337
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP06_REGEX_MATCH' => 149,
			'OP21_LIST_COMMA' => -187,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP08_MATH_ADD_SUB' => 139,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP16_LOGICAL_OR' => 145,
			'OP15_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 134,
			"}" => -187,
			'OP23_LOGICAL_AND' => 133
		}
	},
	{#State 338
		ACTIONS => {
			";" => 357
		}
	},
	{#State 339
		DEFAULT => -48
	},
	{#State 340
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358
		}
	},
	{#State 341
		ACTIONS => {
			"my" => 359
		}
	},
	{#State 342
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 360
		}
	},
	{#State 343
		ACTIONS => {
			";" => 361
		}
	},
	{#State 344
		DEFAULT => -190
	},
	{#State 345
		ACTIONS => {
			'OP20_HASH_FATARROW' => 362
		}
	},
	{#State 346
		ACTIONS => {
			'VARIABLE_SYMBOL' => 363
		}
	},
	{#State 347
		DEFAULT => -59
	},
	{#State 348
		DEFAULT => -159
	},
	{#State 349
		ACTIONS => {
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"foreach" => -139,
			'OP19_LOOP_CONTROL' => 113,
			"for" => -139,
			"%{" => 112,
			'WORD' => 24,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			"while" => -139,
			'OP01_NAMED' => 119,
			"my" => 123,
			'LBRACE' => 122,
			"}" => 365,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_PRINT' => 82,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"if" => 86,
			'LBRACKET' => 88,
			'OP01_NAMED_VOID' => 93,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'WORD_UPPERCASE' => 99,
			"\@{" => 103,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'LoopLabel' => 120,
			'VariableModification' => 121,
			'HashDereference' => 117,
			'Statement' => 98,
			'Expression' => 97,
			'ArrayReference' => 118,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 110,
			'SubExpression' => 81,
			'OPTIONAL-35' => 111,
			'Operator' => 106,
			'ArrayDereference' => 109,
			'PAREN-34' => 78,
			'Conditional' => 92,
			'OperatorVoid' => 90,
			'HashReference' => 91,
			'VariableDeclaration' => 89,
			'Operation' => 364
		}
	},
	{#State 350
		ACTIONS => {
			'LBRACKET' => -150,
			"if" => -150,
			'OP01_PRINT' => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'LITERAL_STRING' => -150,
			'OP01_CLOSE' => -150,
			'' => -150,
			"else" => 367,
			"}" => -150,
			"undef" => -150,
			"\@{" => -150,
			'OP05_LOGICAL_NEG' => -150,
			'OP01_OPEN' => -150,
			'WORD_UPPERCASE' => -150,
			'OP01_NAMED_VOID' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP03_MATH_INC_DEC' => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'LPAREN' => -150,
			'WORD_SCOPED' => -150,
			'WORD' => -150,
			"%{" => -150,
			'OP19_LOOP_CONTROL' => -150,
			"for" => -150,
			'VARIABLE_SYMBOL' => -150,
			"elsif" => 369,
			'LITERAL_NUMBER' => -150,
			"foreach" => -150,
			'LBRACE' => -150,
			"my" => -150,
			"while" => -150,
			'OP01_NAMED' => -150
		},
		GOTOS => {
			'OPTIONAL-39' => 368,
			'PAREN-38' => 366,
			'PAREN-36' => 370
		}
	},
	{#State 351
		DEFAULT => -203
	},
	{#State 352
		ACTIONS => {
			'OP21_LIST_COMMA' => 371
		}
	},
	{#State 353
		DEFAULT => -157
	},
	{#State 354
		ACTIONS => {
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112,
			"\@{" => 103,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'OP03_MATH_INC_DEC' => 96,
			'WORD_UPPERCASE' => 154
		},
		GOTOS => {
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100,
			'Variable' => 158,
			'SubExpression' => 372,
			'Expression' => 155,
			'ArrayDereference' => 109,
			'ArrayReference' => 118,
			'HashDereference' => 117,
			'Operator' => 106
		}
	},
	{#State 355
		ACTIONS => {
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"my" => 167,
			"\@{" => 103,
			'WORD_UPPERCASE' => 154,
			'OP01_QW' => 165,
			'OP01_NAMED' => 157,
			'OP03_MATH_INC_DEC' => 96,
			'OP10_NAMED_UNARY' => 94
		},
		GOTOS => {
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91,
			'TypeInner' => 163,
			'ListElements' => 373,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'ListElement' => 164,
			'Expression' => 155,
			'Operator' => 106,
			'HashDereference' => 117,
			'SubExpression' => 161,
			'Variable' => 158
		}
	},
	{#State 356
		DEFAULT => -80
	},
	{#State 357
		DEFAULT => -168
	},
	{#State 358
		ACTIONS => {
			"\@_;" => 374
		}
	},
	{#State 359
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 50
		},
		GOTOS => {
			'Type' => 375
		}
	},
	{#State 360
		ACTIONS => {
			'OP21_LIST_COMMA' => 376,
			"}" => 377
		},
		GOTOS => {
			'PAREN-24' => 378
		}
	},
	{#State 361
		DEFAULT => -64
	},
	{#State 362
		ACTIONS => {
			"my" => 167
		},
		GOTOS => {
			'TypeInner' => 379
		}
	},
	{#State 363
		ACTIONS => {
			"= sub {" => 380
		}
	},
	{#State 364
		DEFAULT => -158
	},
	{#State 365
		DEFAULT => -160
	},
	{#State 366
		DEFAULT => -149
	},
	{#State 367
		ACTIONS => {
			'LBRACE' => 321
		},
		GOTOS => {
			'CodeBlock' => 381
		}
	},
	{#State 368
		DEFAULT => -151
	},
	{#State 369
		ACTIONS => {
			'LPAREN' => 382
		}
	},
	{#State 370
		DEFAULT => -146
	},
	{#State 371
		ACTIONS => {
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'WORD' => 24,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 83,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			"\@{" => 103,
			'WORD_UPPERCASE' => 154,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94
		},
		GOTOS => {
			'HashReference' => 91,
			'Literal' => 100,
			'WordScoped' => 102,
			'SubExpression' => 383,
			'Variable' => 158,
			'HashDereference' => 117,
			'Operator' => 106,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155
		}
	},
	{#State 372
		ACTIONS => {
			'OP06_REGEX_MATCH' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 141,
			'OP08_MATH_ADD_SUB' => 139,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP11_COMPARE_LT_GT' => 144,
			'OP15_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => 384,
			'OP23_LOGICAL_AND' => 133,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142
		}
	},
	{#State 373
		ACTIONS => {
			")" => 385
		}
	},
	{#State 374
		DEFAULT => -50
	},
	{#State 375
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 376
		ACTIONS => {
			'WORD' => 345,
			"%{" => 112
		},
		GOTOS => {
			'HashDereference' => 344,
			'HashEntryTyped' => 387
		}
	},
	{#State 377
		ACTIONS => {
			";" => 388
		}
	},
	{#State 378
		DEFAULT => -61
	},
	{#State 379
		ACTIONS => {
			"\@{" => 103,
			'LBRACE' => 122,
			'OP05_LOGICAL_NEG' => 105,
			'OP01_OPEN' => 104,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			"%{" => 112
		},
		GOTOS => {
			'Variable' => 158,
			'SubExpression' => 389,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Operator' => 106,
			'HashDereference' => 117,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100
		}
	},
	{#State 380
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -66,
			'OP01_OPEN' => -66,
			"\@{" => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP01_NAMED_VOID' => -66,
			'WORD_UPPERCASE' => -66,
			"if" => -66,
			'LBRACKET' => -66,
			"undef" => -66,
			'LITERAL_STRING' => -66,
			'OP01_CLOSE' => -66,
			'OP01_PRINT' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'LBRACE' => -66,
			"my" => -66,
			'OP01_NAMED' => -66,
			"while" => -66,
			'WORD' => -66,
			'LPAREN_MY' => 392,
			'LPAREN' => -66,
			'WORD_SCOPED' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			"foreach" => -66,
			'VARIABLE_SYMBOL' => -66,
			'LITERAL_NUMBER' => -66,
			"%{" => -66,
			"for" => -66,
			'OP19_LOOP_CONTROL' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 390,
			'MethodArguments' => 391
		}
	},
	{#State 381
		DEFAULT => -148
	},
	{#State 382
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			"\@{" => 103,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			'LBRACE' => 122,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'LBRACKET' => 88
		},
		GOTOS => {
			'HashDereference' => 117,
			'Operator' => 106,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Expression' => 155,
			'SubExpression' => 393,
			'Variable' => 158,
			'Literal' => 100,
			'WordScoped' => 102,
			'HashReference' => 91
		}
	},
	{#State 383
		ACTIONS => {
			'OP15_LOGICAL_AND' => 135,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			'OP16_LOGICAL_OR' => 145,
			";" => -81,
			'OP23_LOGICAL_AND' => -81,
			"}" => -81,
			'OP17_LIST_RANGE' => 134,
			")" => -81,
			"]" => -81,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP13_BITWISE_AND' => 141,
			'OP21_LIST_COMMA' => -81,
			'OP06_REGEX_MATCH' => 149,
			'OP08_MATH_ADD_SUB' => 139,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147
		}
	},
	{#State 384
		ACTIONS => {
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			"undef" => 80,
			'OP05_MATH_NEG_LPAREN' => 83,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 84,
			"%{" => 112,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 114,
			'LBRACKET' => 88,
			'LPAREN' => 116,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 157,
			'OP10_NAMED_UNARY' => 94,
			'WORD_UPPERCASE' => 154,
			"\@{" => 103,
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105
		},
		GOTOS => {
			'Variable' => 158,
			'SubExpression' => 394,
			'Expression' => 155,
			'ArrayReference' => 118,
			'ArrayDereference' => 109,
			'Operator' => 106,
			'HashDereference' => 117,
			'HashReference' => 91,
			'WordScoped' => 102,
			'Literal' => 100
		}
	},
	{#State 385
		ACTIONS => {
			'LBRACE' => 321
		},
		GOTOS => {
			'CodeBlock' => 395
		}
	},
	{#State 386
		DEFAULT => -47
	},
	{#State 387
		DEFAULT => -60
	},
	{#State 388
		DEFAULT => -63
	},
	{#State 389
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 139,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 141,
			'OP21_LIST_COMMA' => -189,
			'OP06_REGEX_MATCH' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP18_TERNARY' => 138,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP23_LOGICAL_AND' => 133,
			"}" => -189,
			'OP17_LIST_RANGE' => 134,
			'OP15_LOGICAL_AND' => 135,
			'OP11_COMPARE_LT_GT' => 144,
			'OP16_LOGICAL_OR' => 145,
			'OP04_MATH_POW' => 136,
			'OP08_STRING_CAT' => 143,
			'OP09_BITWISE_SHIFT' => 142
		}
	},
	{#State 390
		ACTIONS => {
			'LITERAL_STRING' => 85,
			"for" => -139,
			'OP19_LOOP_CONTROL' => 113,
			"%{" => 112,
			'OP01_CLOSE' => 84,
			'OP01_PRINT' => 82,
			'OP05_MATH_NEG_LPAREN' => 83,
			"foreach" => -139,
			"undef" => 80,
			'VARIABLE_SYMBOL' => 107,
			'LITERAL_NUMBER' => 108,
			'LPAREN' => 116,
			'LBRACKET' => 88,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'WORD' => 24,
			"if" => 86,
			'WORD_UPPERCASE' => 99,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED' => 119,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP10_NAMED_UNARY' => 94,
			"while" => -139,
			'OP01_NAMED_VOID' => 93,
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			"my" => 123,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 103
		},
		GOTOS => {
			'Operation' => 396,
			'Conditional' => 92,
			'OperatorVoid' => 90,
			'HashReference' => 91,
			'VariableDeclaration' => 89,
			'ArrayDereference' => 109,
			'PAREN-34' => 78,
			'Operator' => 106,
			'OPTIONAL-35' => 111,
			'Variable' => 110,
			'PLUS-27' => 397,
			'SubExpression' => 81,
			'WordScoped' => 102,
			'Literal' => 100,
			'Statement' => 98,
			'Expression' => 97,
			'ArrayReference' => 118,
			'HashDereference' => 117,
			'VariableModification' => 121,
			'LoopLabel' => 120
		}
	},
	{#State 391
		DEFAULT => -65
	},
	{#State 392
		ACTIONS => {
			'TYPE_SELF' => 398
		}
	},
	{#State 393
		ACTIONS => {
			'OP07_STRING_REPEAT' => 147,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => 138,
			'OP08_MATH_ADD_SUB' => 139,
			'OP06_REGEX_MATCH' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 141,
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			")" => 399,
			'OP17_LIST_RANGE' => 134,
			'OP23_LOGICAL_AND' => 133,
			'OP16_LOGICAL_OR' => 145,
			'OP11_COMPARE_LT_GT' => 144,
			'OP04_MATH_POW' => 136,
			'OP15_LOGICAL_AND' => 135
		}
	},
	{#State 394
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 142,
			'OP08_STRING_CAT' => 143,
			")" => 400,
			'OP04_MATH_POW' => 136,
			'OP16_LOGICAL_OR' => 145,
			'OP11_COMPARE_LT_GT' => 144,
			'OP15_LOGICAL_AND' => 135,
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -102,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP18_TERNARY' => -102,
			'OP12_COMPARE_EQ_NE' => 137,
			'OP07_STRING_REPEAT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 146,
			'OP06_REGEX_MATCH' => 149,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP13_BITWISE_AND' => 141,
			'OP08_MATH_ADD_SUB' => 139
		}
	},
	{#State 395
		DEFAULT => -156
	},
	{#State 396
		DEFAULT => -68
	},
	{#State 397
		ACTIONS => {
			"undef" => 80,
			"}" => 402,
			'OP01_CLOSE' => 84,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 83,
			'OP01_PRINT' => 82,
			"if" => 86,
			'LBRACKET' => 88,
			'OP10_NAMED_UNARY' => 94,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP03_MATH_INC_DEC' => 96,
			'OP01_NAMED_VOID' => 93,
			'WORD_UPPERCASE' => 99,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 105,
			"\@{" => 103,
			"foreach" => -139,
			'LITERAL_NUMBER' => 108,
			'VARIABLE_SYMBOL' => 107,
			"for" => -139,
			"%{" => 112,
			'OP19_LOOP_CONTROL' => 113,
			'WORD' => 24,
			'WORD_SCOPED' => 26,
			'LPAREN' => 116,
			'OP22_LOGICAL_NEG' => 114,
			'OP01_NAMED_VOID_SCOLON' => 115,
			'OP01_NAMED' => 119,
			"while" => -139,
			"my" => 123,
			'LBRACE' => 122
		},
		GOTOS => {
			'OPTIONAL-35' => 111,
			'Variable' => 110,
			'SubExpression' => 81,
			'ArrayDereference' => 109,
			'PAREN-34' => 78,
			'Operator' => 106,
			'OperatorVoid' => 90,
			'Conditional' => 92,
			'HashReference' => 91,
			'VariableDeclaration' => 89,
			'Operation' => 401,
			'VariableModification' => 121,
			'LoopLabel' => 120,
			'Expression' => 97,
			'Statement' => 98,
			'ArrayReference' => 118,
			'HashDereference' => 117,
			'WordScoped' => 102,
			'Literal' => 100
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
			'LBRACE' => 321
		},
		GOTOS => {
			'CodeBlock' => 404
		}
	},
	{#State 400
		ACTIONS => {
			'LBRACE' => 321
		},
		GOTOS => {
			'CodeBlock' => 405
		}
	},
	{#State 401
		DEFAULT => -67
	},
	{#State 402
		ACTIONS => {
			";" => 406
		}
	},
	{#State 403
		ACTIONS => {
			'OP21_LIST_COMMA' => 407,
			")" => 408
		},
		GOTOS => {
			'PAREN-28' => 409
		}
	},
	{#State 404
		DEFAULT => -145
	},
	{#State 405
		DEFAULT => -155
	},
	{#State 406
		DEFAULT => -69
	},
	{#State 407
		ACTIONS => {
			"my" => 410
		}
	},
	{#State 408
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 411
		}
	},
	{#State 409
		DEFAULT => -71
	},
	{#State 410
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 50
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
	[#Rule ArrayDereference_183
		 'ArrayDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_184
		 'ArrayDereference', 3,
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
	[#Rule HashDereference_196
		 'HashDereference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7598 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_197
		 'HashDereference', 3,
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
         'ArrayDereference_183', 
         'ArrayDereference_184', 
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
         'HashDereference_196', 
         'HashDereference_197', 
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
