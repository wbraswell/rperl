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
    our $VERSION = 0.000_976;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|integer|foreach|\=\ sub\ \{|package|\$TYPED_|undef|elsif|while|else|for|our|use|qw\(|\@_\;|my|if|\@\{|\%\{|\}|\;|\]|\))}gc and return ($1, $1);

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
  [ 'LoopFor_155' => 'LoopFor', [ 'for', 'my', 'integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
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
  [ 'Type_202' => 'Type', [ 'integer' ], 0 ],
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
	'integer' => { ISSEMANTIC => 0 },
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
			'SHEBANG' => 5,
			"package" => -20,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'ModuleHeader' => 6,
			'CompileUnit' => 7,
			'Critic' => 9,
			'OPTIONAL-9' => 3,
			'PAREN-1' => 8,
			'Program' => 4,
			'PLUS-2' => 1
		}
	},
	{#State 1
		ACTIONS => {
			"## no critic qw(" => 2,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'Critic' => 9,
			'OPTIONAL-9' => 3,
			'PAREN-1' => 10,
			'ModuleHeader' => 6
		}
	},
	{#State 2
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-14' => 12
		}
	},
	{#State 3
		ACTIONS => {
			"package" => 13
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'OPTIONAL-3' => 14,
			'Critic' => 15
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => -25,
			"use constant" => -25,
			"our" => -25,
			"use parent qw(" => 16,
			"use" => -25
		},
		GOTOS => {
			'Module' => 17,
			'Class' => 18,
			'STAR-10' => 19,
			'Package' => 20
		}
	},
	{#State 7
		ACTIONS => {
			'' => 21
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		DEFAULT => -35
	},
	{#State 12
		ACTIONS => {
			")" => 23,
			'WORD' => 22
		}
	},
	{#State 13
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 14
		ACTIONS => {
			"use strict;" => 27
		},
		GOTOS => {
			'Header' => 28
		}
	},
	{#State 15
		DEFAULT => -6
	},
	{#State 16
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 17
		DEFAULT => -1
	},
	{#State 18
		DEFAULT => -23
	},
	{#State 19
		ACTIONS => {
			"## no critic qw(" => 2,
			"use constant" => -27,
			"use" => -27,
			"our" => -27
		},
		GOTOS => {
			'Critic' => 30,
			'STAR-11' => 31
		}
	},
	{#State 20
		DEFAULT => -22
	},
	{#State 21
		DEFAULT => 0
	},
	{#State 22
		DEFAULT => -34
	},
	{#State 23
		DEFAULT => -36
	},
	{#State 24
		DEFAULT => -198
	},
	{#State 25
		ACTIONS => {
			";" => 32
		}
	},
	{#State 26
		DEFAULT => -199
	},
	{#State 27
		ACTIONS => {
			"use warnings;" => 33
		}
	},
	{#State 28
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 34
		}
	},
	{#State 29
		ACTIONS => {
			")" => 35
		}
	},
	{#State 30
		DEFAULT => -24
	},
	{#State 31
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			"use" => 38
		},
		GOTOS => {
			'STAR-12' => 37,
			'Include' => 36
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 27
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
			'OP10_NAMED_UNARY' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LITERAL_STRING' => -11,
			'WORD_UPPERCASE' => -11,
			"while" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'WORD' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LPAREN' => -11,
			"## no critic qw(" => 2,
			"%{" => -11,
			'OP01_NAMED_VOID' => -11,
			"\@{" => -11,
			"use constant" => -11,
			'OP01_OPEN' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_PRINT' => -11,
			"my" => -11,
			"for" => -11,
			"undef" => -11,
			"our" => -11,
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'WORD_SCOPED' => -11,
			'VARIABLE_SYMBOL' => -11,
			"use" => -11,
			'LBRACE' => -11,
			"if" => -11,
			"foreach" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11
		},
		GOTOS => {
			'Critic' => 42,
			'STAR-5' => 41
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
			"use constant" => 47,
			"our" => 44
		},
		GOTOS => {
			'Constant' => 45,
			'Subroutine' => 46,
			'PLUS-13' => 48
		}
	},
	{#State 38
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 49
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
			'LITERAL_STRING' => -13,
			"while" => -13,
			'WORD_UPPERCASE' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'WORD' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP10_NAMED_UNARY' => -13,
			"use constant" => -13,
			'LPAREN' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"%{" => -13,
			'OP01_NAMED_VOID' => -13,
			"\@{" => -13,
			"my" => -13,
			"for" => -13,
			"our" => -13,
			'LBRACKET' => -13,
			"undef" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_OPEN' => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED' => -13,
			'OP01_PRINT' => -13,
			'LITERAL_NUMBER' => -13,
			'LBRACE' => -13,
			"if" => -13,
			"foreach" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'WORD_SCOPED' => -13,
			'VARIABLE_SYMBOL' => -13,
			"use" => 38
		},
		GOTOS => {
			'Include' => 52,
			'STAR-6' => 51
		}
	},
	{#State 42
		DEFAULT => -8
	},
	{#State 43
		ACTIONS => {
			"use" => 38
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 55,
			"integer" => 56
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		DEFAULT => -31
	},
	{#State 47
		ACTIONS => {
			'WORD_UPPERCASE' => 57
		}
	},
	{#State 48
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 59
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 49
		ACTIONS => {
			"qw(" => 61,
			";" => 60
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 62
		}
	},
	{#State 51
		ACTIONS => {
			'OP01_CLOSE' => -15,
			'OP01_OPEN' => -15,
			'OP01_NAMED' => -15,
			'OP01_PRINT' => -15,
			'LITERAL_NUMBER' => -15,
			"my" => -15,
			"our" => -15,
			"undef" => -15,
			'LBRACKET' => -15,
			"for" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD_SCOPED' => -15,
			'VARIABLE_SYMBOL' => -15,
			'LBRACE' => -15,
			"if" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"foreach" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LITERAL_STRING' => -15,
			'WORD_UPPERCASE' => -15,
			"while" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'WORD' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LPAREN' => -15,
			"%{" => -15,
			'OP01_NAMED_VOID' => -15,
			"\@{" => -15,
			"use constant" => 47
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
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 65
		}
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 55
		DEFAULT => -201
	},
	{#State 56
		DEFAULT => -202
	},
	{#State 57
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
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
		DEFAULT => -39
	},
	{#State 61
		ACTIONS => {
			'WORD' => 70
		},
		GOTOS => {
			'PLUS-15' => 69
		}
	},
	{#State 62
		DEFAULT => -33
	},
	{#State 63
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'WORD_UPPERCASE' => 95,
			"while" => -139,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'OP22_LOGICAL_NEG' => 103,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"\@{" => 115,
			'OP01_NAMED_VOID' => 116,
			'OP01_NAMED' => 76,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'LITERAL_NUMBER' => 81,
			'OP01_PRINT' => 82,
			"my" => 71,
			'OP19_LOOP_CONTROL' => 72,
			"our" => 44,
			'LBRACKET' => 73,
			"undef" => 74,
			"for" => -139,
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 26,
			"if" => 84,
			'LBRACE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 92,
			"foreach" => -139
		},
		GOTOS => {
			'Variable' => 109,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Expression' => 113,
			'PLUS-8' => 83,
			'ArrayDereferenced' => 86,
			'Conditional' => 85,
			'WordScoped' => 87,
			'OPTIONAL-35' => 91,
			'Statement' => 90,
			'OperatorVoid' => 89,
			'Operator' => 93,
			'HashReference' => 77,
			'VariableDeclaration' => 79,
			'PAREN-34' => 107,
			'Literal' => 104,
			'Operation' => 96,
			'Subroutine' => 98,
			'LoopLabel' => 100,
			'SubExpression' => 101,
			'VariableModification' => 75
		}
	},
	{#State 64
		DEFAULT => -12
	},
	{#State 65
		ACTIONS => {
			"our hash_ref \$properties" => -54,
			"use constant" => -54,
			"## no critic qw(" => 2,
			"use" => -54
		},
		GOTOS => {
			'STAR-21' => 117,
			'Critic' => 118
		}
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 119
		}
	},
	{#State 67
		ACTIONS => {
			"my" => 121
		},
		GOTOS => {
			'TypeInnerConstant' => 120
		}
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			")" => 122,
			'WORD' => 123
		}
	},
	{#State 70
		DEFAULT => -38
	},
	{#State 71
		ACTIONS => {
			"integer" => 56,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 124
		}
	},
	{#State 72
		ACTIONS => {
			'WORD_UPPERCASE' => 125
		},
		GOTOS => {
			'LoopLabel' => 126
		}
	},
	{#State 73
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_QW' => 135,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73,
			"my" => 129,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			"\@{" => 115,
			"]" => -181,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'LBRACE' => 88
		},
		GOTOS => {
			'SubExpression' => 136,
			'OPTIONAL-45' => 132,
			'Operator' => 93,
			'WordScoped' => 87,
			'ListElement' => 134,
			'ListElements' => 133,
			'ArrayDereferenced' => 86,
			'Literal' => 104,
			'TypeInner' => 127,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77
		}
	},
	{#State 74
		DEFAULT => -127
	},
	{#State 75
		DEFAULT => -144
	},
	{#State 76
		ACTIONS => {
			"my" => 129,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			"\@{" => 115
		},
		GOTOS => {
			'TypeInner' => 127,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'Literal' => 104,
			'WordScoped' => 87,
			'ListElement' => 139,
			'ArrayDereferenced' => 86,
			'SubExpression' => 138,
			'Operator' => 93
		}
	},
	{#State 77
		DEFAULT => -132
	},
	{#State 78
		ACTIONS => {
			'FH_REF_SYMBOL' => 140
		}
	},
	{#State 79
		DEFAULT => -143
	},
	{#State 80
		ACTIONS => {
			"my" => 141
		}
	},
	{#State 81
		DEFAULT => -208
	},
	{#State 82
		ACTIONS => {
			'LITERAL_STRING' => -109,
			"my" => -109,
			'WORD_UPPERCASE' => -109,
			'LBRACKET' => -109,
			"undef" => -109,
			'OP22_LOGICAL_NEG' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'WORD' => -109,
			'OP01_CLOSE' => -109,
			'OP01_OPEN' => -109,
			'OP01_QW' => -109,
			'OP01_NAMED' => -109,
			'LITERAL_NUMBER' => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'LBRACE' => -109,
			'LPAREN' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'WORD_SCOPED' => -109,
			'VARIABLE_SYMBOL' => -109,
			"%{" => -109,
			'FH_REF_SYMBOL_BRACES' => 145,
			'STDOUT_STDERR' => 143,
			"\@{" => -109
		},
		GOTOS => {
			'PAREN-30' => 144,
			'OPTIONAL-31' => 142
		}
	},
	{#State 83
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 26,
			"if" => 84,
			'LBRACE' => 88,
			"foreach" => -139,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'OP01_NAMED' => 76,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_PRINT' => 82,
			'LITERAL_NUMBER' => 81,
			"my" => 71,
			'OP19_LOOP_CONTROL' => 72,
			"for" => -139,
			'' => -18,
			"undef" => 74,
			'LBRACKET' => 73,
			"%{" => 108,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"\@{" => 115,
			'OP01_NAMED_VOID' => 116,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			"while" => -139,
			'WORD_UPPERCASE' => 95,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 102
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Expression' => 113,
			'HashDereferenced' => 114,
			'Variable' => 109,
			'Operator' => 93,
			'OperatorVoid' => 89,
			'Statement' => 90,
			'OPTIONAL-35' => 91,
			'WordScoped' => 87,
			'Conditional' => 85,
			'ArrayDereferenced' => 86,
			'Literal' => 104,
			'PAREN-34' => 107,
			'VariableDeclaration' => 79,
			'HashReference' => 77,
			'SubExpression' => 101,
			'VariableModification' => 75,
			'LoopLabel' => 100,
			'Operation' => 146
		}
	},
	{#State 84
		ACTIONS => {
			'LPAREN' => 147
		}
	},
	{#State 85
		DEFAULT => -140
	},
	{#State 86
		DEFAULT => -131
	},
	{#State 87
		ACTIONS => {
			'LPAREN' => 149,
			'OP02_METHOD_THINARROW_NEW' => 148
		}
	},
	{#State 88
		ACTIONS => {
			'WORD' => 152,
			"%{" => 108,
			"}" => 150
		},
		GOTOS => {
			'HashEntry' => 151,
			'HashDereferenced' => 153
		}
	},
	{#State 89
		DEFAULT => -142
	},
	{#State 90
		DEFAULT => -77
	},
	{#State 91
		ACTIONS => {
			"while" => 158,
			"foreach" => 155,
			"for" => 154
		},
		GOTOS => {
			'LoopFor' => 160,
			'Loop' => 157,
			'LoopWhile' => 156,
			'LoopForEach' => 159
		}
	},
	{#State 92
		DEFAULT => -112
	},
	{#State 93
		DEFAULT => -121
	},
	{#State 94
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 161
		}
	},
	{#State 95
		ACTIONS => {
			'LPAREN' => 162,
			'COLON' => -200
		}
	},
	{#State 96
		DEFAULT => -17
	},
	{#State 97
		DEFAULT => -207
	},
	{#State 98
		DEFAULT => -14
	},
	{#State 99
		ACTIONS => {
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			"\@{" => 115,
			'LBRACE' => 88,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'Literal' => 104,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'SubExpression' => 163,
			'Operator' => 93,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86
		}
	},
	{#State 100
		ACTIONS => {
			'COLON' => 164
		}
	},
	{#State 101
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP15_LOGICAL_AND' => 172,
			'OP11_COMPARE_LT_GT' => 171,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 102
		DEFAULT => -115
	},
	{#State 103
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'LBRACE' => 88,
			"\@{" => 115,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Operator' => 93,
			'SubExpression' => 182,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Literal' => 104,
			'HashReference' => 77,
			'Variable' => 130,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131
		}
	},
	{#State 104
		DEFAULT => -128
	},
	{#State 105
		ACTIONS => {
			'OP06_REGEX_MATCH' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"}" => -95,
			'OP15_LOGICAL_AND' => -95,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP08_STRING_CAT' => -95,
			'OP18_TERNARY' => -95,
			'LITERAL_NUMBER' => 81,
			'OP07_STRING_REPEAT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 94,
			'OP21_LIST_COMMA' => -95,
			'WORD_SCOPED' => 26,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'OP23_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 103,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP09_BITWISE_SHIFT' => -95,
			";" => -95,
			'OP04_MATH_POW' => -95,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"\@{" => 115,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			")" => -95,
			"]" => -95
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'Literal' => 104,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'SubExpression' => 183,
			'Operator' => 93
		}
	},
	{#State 106
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			"\@{" => 115,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			'LBRACE' => 88
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Operator' => 93,
			'SubExpression' => 184,
			'HashReference' => 77,
			'Variable' => 130,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Literal' => 104
		}
	},
	{#State 107
		DEFAULT => -138
	},
	{#State 108
		ACTIONS => {
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'HashReference' => 185,
			'Variable' => 186
		}
	},
	{#State 109
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP18_TERNARY' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 190,
			'OP02_METHOD_THINARROW' => 189,
			'OP06_REGEX_MATCH' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP03_MATH_INC_DEC' => 188,
			'OP19_VARIABLE_ASSIGN' => 187,
			'OP04_MATH_POW' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP13_BITWISE_AND' => -129
		}
	},
	{#State 110
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'Variable' => 191
		}
	},
	{#State 111
		ACTIONS => {
			'OP01_PRINT' => 193,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_NAMED' => 192,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			"\@{" => 115,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'LBRACE' => 88
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'SubExpression' => 194,
			'Operator' => 93,
			'Variable' => 130,
			'HashReference' => 77,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Literal' => 104
		}
	},
	{#State 112
		DEFAULT => -130
	},
	{#State 113
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP18_TERNARY' => -126,
			'OP08_STRING_CAT' => -126,
			";" => 195,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP04_MATH_POW' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP24_LOGICAL_OR_XOR' => -126
		}
	},
	{#State 114
		DEFAULT => -133
	},
	{#State 115
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'LBRACKET' => 73
		},
		GOTOS => {
			'Variable' => 196,
			'ArrayReference' => 197
		}
	},
	{#State 116
		ACTIONS => {
			'LBRACE' => 88,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"\@{" => 115,
			"my" => 129,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP01_NAMED' => 128,
			'OP01_QW' => 135,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 104,
			'Variable' => 130,
			'HashReference' => 77,
			'TypeInner' => 127,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131,
			'SubExpression' => 136,
			'Operator' => 93,
			'ArrayDereferenced' => 86,
			'ListElements' => 198,
			'WordScoped' => 87,
			'ListElement' => 134
		}
	},
	{#State 117
		ACTIONS => {
			"use" => 38,
			"use constant" => -56,
			"our hash_ref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 199,
			'Include' => 200
		}
	},
	{#State 118
		DEFAULT => -51
	},
	{#State 119
		ACTIONS => {
			'LBRACE' => -43,
			"if" => -43,
			"foreach" => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'WORD_SCOPED' => -43,
			'VARIABLE_SYMBOL' => -43,
			"my" => -43,
			"for" => -43,
			"undef" => -43,
			'LBRACKET' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP01_OPEN' => -43,
			'OP01_CLOSE' => -43,
			'OP01_NAMED' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_PRINT' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'LPAREN' => -43,
			'LPAREN_MY' => 203,
			"%{" => -43,
			'OP01_NAMED_VOID' => -43,
			"\@{" => -43,
			'LITERAL_STRING' => -43,
			'WORD_UPPERCASE' => -43,
			"while" => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'WORD' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP10_NAMED_UNARY' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 202,
			'OPTIONAL-16' => 201
		}
	},
	{#State 120
		ACTIONS => {
			'LITERAL_STRING' => 97,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 204
		}
	},
	{#State 121
		ACTIONS => {
			"integer" => 56,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 205
		}
	},
	{#State 122
		ACTIONS => {
			";" => 206
		}
	},
	{#State 123
		DEFAULT => -37
	},
	{#State 124
		ACTIONS => {
			'VARIABLE_SYMBOL' => 207
		}
	},
	{#State 125
		DEFAULT => -200
	},
	{#State 126
		ACTIONS => {
			";" => 208
		}
	},
	{#State 127
		ACTIONS => {
			"\@{" => 115,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'LBRACE' => 88,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Operator' => 93,
			'SubExpression' => 209,
			'HashReference' => 77,
			'Variable' => 130,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Literal' => 104
		}
	},
	{#State 128
		ACTIONS => {
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_NAMED' => 128,
			'LBRACE' => 88,
			"\@{" => 115,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94
		},
		GOTOS => {
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'Literal' => 104,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'SubExpression' => 210,
			'Operator' => 93
		}
	},
	{#State 129
		ACTIONS => {
			'WORD' => 55,
			"integer" => 56
		},
		GOTOS => {
			'Type' => 211
		}
	},
	{#State 130
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP13_BITWISE_AND' => -129,
			";" => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP04_MATH_POW' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP03_MATH_INC_DEC' => 188,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			")" => -129,
			"]" => -129,
			'OP17_LIST_RANGE' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP02_METHOD_THINARROW' => 189,
			"}" => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP08_STRING_CAT' => -129,
			'OP18_TERNARY' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP07_STRING_REPEAT' => -129
		}
	},
	{#State 131
		DEFAULT => -126
	},
	{#State 132
		ACTIONS => {
			"]" => 212
		}
	},
	{#State 133
		DEFAULT => -180
	},
	{#State 134
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 213
		}
	},
	{#State 135
		ACTIONS => {
			'WORD' => 215
		},
		GOTOS => {
			'PLUS-44' => 214
		}
	},
	{#State 136
		ACTIONS => {
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => 181,
			";" => -178,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP11_COMPARE_LT_GT' => 171,
			"]" => -178,
			")" => -178,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP21_LIST_COMMA' => -178,
			'OP23_LOGICAL_AND' => 166,
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => 165,
			'OP17_LIST_RANGE' => 175,
			'OP06_REGEX_MATCH' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176
		}
	},
	{#State 137
		ACTIONS => {
			'LPAREN' => 162
		}
	},
	{#State 138
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP18_TERNARY' => -79,
			'OP08_STRING_CAT' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP13_BITWISE_AND' => -79,
			";" => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP04_MATH_POW' => -79,
			'OP21_LIST_COMMA' => -178,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			")" => -79,
			'OP11_COMPARE_LT_GT' => -79
		}
	},
	{#State 139
		ACTIONS => {
			'OP21_LIST_COMMA' => 216
		}
	},
	{#State 140
		DEFAULT => -82
	},
	{#State 141
		ACTIONS => {
			"filehandle_ref" => 217
		}
	},
	{#State 142
		ACTIONS => {
			'LBRACE' => 88,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			"\@{" => 115,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			"my" => 129,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_QW' => 135,
			'OP01_NAMED' => 128,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106
		},
		GOTOS => {
			'SubExpression' => 136,
			'Operator' => 93,
			'ArrayDereferenced' => 86,
			'ListElements' => 218,
			'WordScoped' => 87,
			'ListElement' => 134,
			'Literal' => 104,
			'Variable' => 130,
			'HashReference' => 77,
			'TypeInner' => 127,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114
		}
	},
	{#State 143
		DEFAULT => -107
	},
	{#State 144
		DEFAULT => -108
	},
	{#State 145
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			"my" => 129,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128,
			'OP01_QW' => 135,
			'LBRACE' => 88,
			"\@{" => 115,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108
		},
		GOTOS => {
			'Literal' => 104,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'TypeInner' => 127,
			'HashReference' => 77,
			'Variable' => 130,
			'Operator' => 93,
			'SubExpression' => 136,
			'ListElement' => 134,
			'WordScoped' => 87,
			'ListElements' => 219,
			'ArrayDereferenced' => 86
		}
	},
	{#State 146
		DEFAULT => -16
	},
	{#State 147
		ACTIONS => {
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"\@{" => 115,
			'LBRACE' => 88,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'SubExpression' => 220,
			'Operator' => 93,
			'Variable' => 130,
			'HashReference' => 77,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131,
			'Literal' => 104
		}
	},
	{#State 148
		ACTIONS => {
			")" => 221
		}
	},
	{#State 149
		ACTIONS => {
			'LBRACE' => 88,
			")" => -118,
			"\@{" => 115,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			"my" => 129,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_QW' => 135,
			'OP01_NAMED' => 128
		},
		GOTOS => {
			'Literal' => 104,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'TypeInner' => 127,
			'HashReference' => 77,
			'Variable' => 130,
			'Operator' => 93,
			'SubExpression' => 136,
			'OPTIONAL-32' => 223,
			'ListElement' => 134,
			'WordScoped' => 87,
			'ListElements' => 222,
			'ArrayDereferenced' => 86
		}
	},
	{#State 150
		DEFAULT => -195
	},
	{#State 151
		DEFAULT => -193,
		GOTOS => {
			'STAR-48' => 224
		}
	},
	{#State 152
		ACTIONS => {
			'OP20_HASH_FATARROW' => 225
		}
	},
	{#State 153
		DEFAULT => -188
	},
	{#State 154
		ACTIONS => {
			"my" => 226
		}
	},
	{#State 155
		ACTIONS => {
			"my" => 227
		}
	},
	{#State 156
		DEFAULT => -154
	},
	{#State 157
		DEFAULT => -141
	},
	{#State 158
		ACTIONS => {
			'LPAREN' => 228
		}
	},
	{#State 159
		DEFAULT => -153
	},
	{#State 160
		DEFAULT => -152
	},
	{#State 161
		ACTIONS => {
			'OP04_MATH_POW' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			";" => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP13_BITWISE_AND' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			")" => -163,
			"]" => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP02_ARRAY_THINARROW' => 231,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			"}" => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP07_STRING_REPEAT' => -163,
			'COLON' => -163,
			'OP08_STRING_CAT' => -163,
			'OP18_TERNARY' => -163,
			'OP02_HASH_THINARROW' => 229
		},
		GOTOS => {
			'VariableRetrieval' => 230
		}
	},
	{#State 162
		ACTIONS => {
			")" => 232
		}
	},
	{#State 163
		ACTIONS => {
			")" => -86,
			"]" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => -86,
			";" => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP18_TERNARY' => -86,
			'OP08_STRING_CAT' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP15_LOGICAL_AND' => -86,
			"}" => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP17_LIST_RANGE' => -86
		}
	},
	{#State 164
		DEFAULT => -137
	},
	{#State 165
		ACTIONS => {
			"\@{" => 115,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'LBRACE' => 88,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_NAMED' => 128,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137
		},
		GOTOS => {
			'SubExpression' => 233,
			'Operator' => 93,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'Literal' => 104,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Variable' => 130,
			'HashReference' => 77
		}
	},
	{#State 166
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"\@{" => 115,
			'LBRACE' => 88,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'SubExpression' => 234,
			'Operator' => 93,
			'Variable' => 130,
			'HashReference' => 77,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131,
			'Literal' => 104
		}
	},
	{#State 167
		ACTIONS => {
			'LBRACE' => 88,
			"\@{" => 115,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128
		},
		GOTOS => {
			'Operator' => 93,
			'SubExpression' => 235,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Literal' => 104,
			'HashReference' => 77,
			'Variable' => 130,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131
		}
	},
	{#State 168
		ACTIONS => {
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_NAMED' => 128,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			"\@{" => 115,
			'LBRACE' => 88
		},
		GOTOS => {
			'SubExpression' => 236,
			'Operator' => 93,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Literal' => 104,
			'Variable' => 130,
			'HashReference' => 77,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131
		}
	},
	{#State 169
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 115,
			'LBRACE' => 88,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_NAMED' => 128,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24
		},
		GOTOS => {
			'Operator' => 93,
			'SubExpression' => 237,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Literal' => 104,
			'HashReference' => 77,
			'Variable' => 130,
			'HashDereferenced' => 114,
			'Expression' => 131,
			'ArrayReference' => 112
		}
	},
	{#State 170
		ACTIONS => {
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LBRACE' => 88,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 115
		},
		GOTOS => {
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'Operator' => 93,
			'SubExpression' => 238,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'HashReference' => 77,
			'Variable' => 130,
			'Literal' => 104
		}
	},
	{#State 171
		ACTIONS => {
			"\@{" => 115,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'Literal' => 104,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'SubExpression' => 239,
			'Operator' => 93
		}
	},
	{#State 172
		ACTIONS => {
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"\@{" => 115,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 104,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'SubExpression' => 240,
			'Operator' => 93,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86
		}
	},
	{#State 173
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"\@{" => 115
		},
		GOTOS => {
			'Operator' => 93,
			'SubExpression' => 241,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'Literal' => 104,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'HashReference' => 77,
			'Variable' => 130
		}
	},
	{#State 174
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 242
		}
	},
	{#State 175
		ACTIONS => {
			"\@{" => 115,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'Literal' => 104,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'HashReference' => 77,
			'Variable' => 130,
			'Operator' => 93,
			'SubExpression' => 243,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86
		}
	},
	{#State 176
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_STRING' => 97,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'VariableOrLiteral' => 246,
			'Variable' => 245,
			'Literal' => 244
		}
	},
	{#State 177
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"\@{" => 115
		},
		GOTOS => {
			'HashReference' => 77,
			'Variable' => 130,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131,
			'Literal' => 104,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Operator' => 93,
			'SubExpression' => 247
		}
	},
	{#State 178
		ACTIONS => {
			"\@{" => 115,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'LBRACE' => 88,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'Variable' => 130,
			'HashReference' => 77,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Literal' => 104,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'SubExpression' => 248,
			'Operator' => 93
		}
	},
	{#State 179
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 88,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			"\@{" => 115
		},
		GOTOS => {
			'HashReference' => 77,
			'Variable' => 130,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Literal' => 104,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Operator' => 93,
			'SubExpression' => 249
		}
	},
	{#State 180
		ACTIONS => {
			"\@{" => 115,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'LBRACE' => 88,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_NAMED' => 128,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137
		},
		GOTOS => {
			'SubExpression' => 250,
			'Operator' => 93,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Literal' => 104,
			'Variable' => 130,
			'HashReference' => 77,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131
		}
	},
	{#State 181
		ACTIONS => {
			"\@{" => 115,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'HashReference' => 77,
			'Variable' => 130,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131,
			'Literal' => 104,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Operator' => 93,
			'SubExpression' => 251
		}
	},
	{#State 182
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP11_COMPARE_LT_GT' => 171,
			")" => -104,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP04_MATH_POW' => 168,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			";" => -104,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP15_LOGICAL_AND' => 172,
			'OP23_LOGICAL_AND' => -104,
			'OP16_LOGICAL_OR' => 165,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			"}" => -104
		}
	},
	{#State 183
		ACTIONS => {
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => -94,
			'OP08_STRING_CAT' => 177,
			"}" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP06_REGEX_MATCH' => 174,
			'OP16_LOGICAL_OR' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			")" => -94,
			"]" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			";" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 184
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP11_COMPARE_LT_GT' => 171,
			")" => 252,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 185
		ACTIONS => {
			"}" => 253
		}
	},
	{#State 186
		ACTIONS => {
			"}" => 254
		}
	},
	{#State 187
		ACTIONS => {
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD' => 24,
			'STDIN' => 256,
			'OP05_LOGICAL_NEG' => 99,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 115,
			'LBRACE' => 88
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'SubExpression' => 255,
			'Operator' => 93,
			'Variable' => 130,
			'HashReference' => 77,
			'SubExpressionOrStdin' => 257,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Literal' => 104
		}
	},
	{#State 188
		DEFAULT => -84
	},
	{#State 189
		ACTIONS => {
			'LPAREN' => 258
		}
	},
	{#State 190
		ACTIONS => {
			"\@{" => 115,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			'LBRACE' => 88,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'Literal' => 104,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'SubExpression' => 259,
			'Operator' => 93,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86
		}
	},
	{#State 191
		DEFAULT => -83
	},
	{#State 192
		ACTIONS => {
			"\@{" => 115,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'LBRACE' => 88,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'LITERAL_STRING' => 97,
			"my" => 129,
			'WORD_UPPERCASE' => 137
		},
		GOTOS => {
			'Literal' => 104,
			'Variable' => 130,
			'HashReference' => 77,
			'TypeInner' => 127,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'SubExpression' => 138,
			'Operator' => 93,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'ListElement' => 260
		}
	},
	{#State 193
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 261
		}
	},
	{#State 194
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP11_COMPARE_LT_GT' => 171,
			")" => 262,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178
		}
	},
	{#State 195
		DEFAULT => -76
	},
	{#State 196
		ACTIONS => {
			"}" => 263
		}
	},
	{#State 197
		ACTIONS => {
			"}" => 264
		}
	},
	{#State 198
		ACTIONS => {
			";" => 265
		}
	},
	{#State 199
		ACTIONS => {
			"use constant" => 47,
			"our hash_ref \$properties" => 268
		},
		GOTOS => {
			'Constant' => 267,
			'Properties' => 266
		}
	},
	{#State 200
		DEFAULT => -53
	},
	{#State 201
		ACTIONS => {
			"while" => -139,
			"my" => 71,
			'WORD_UPPERCASE' => 95,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'OP19_LOOP_CONTROL' => 72,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			"undef" => 74,
			'LBRACKET' => 73,
			"for" => -139,
			'OP22_LOGICAL_NEG' => 103,
			'OP01_NAMED' => 76,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT' => 82,
			'LITERAL_NUMBER' => 81,
			"if" => 84,
			'LBRACE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 92,
			"foreach" => -139,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"\@{" => 115,
			'OP01_NAMED_VOID' => 116
		},
		GOTOS => {
			'Operator' => 93,
			'OperatorVoid' => 89,
			'OPTIONAL-35' => 91,
			'Statement' => 90,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'Conditional' => 85,
			'PLUS-17' => 270,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Expression' => 113,
			'Variable' => 109,
			'SubExpression' => 101,
			'VariableModification' => 75,
			'LoopLabel' => 100,
			'Operation' => 269,
			'Literal' => 104,
			'PAREN-34' => 107,
			'VariableDeclaration' => 79,
			'HashReference' => 77
		}
	},
	{#State 202
		DEFAULT => -42
	},
	{#State 203
		ACTIONS => {
			"integer" => 56,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 271
		}
	},
	{#State 204
		ACTIONS => {
			";" => 272
		}
	},
	{#State 205
		ACTIONS => {
			"\$TYPED_" => 273
		}
	},
	{#State 206
		DEFAULT => -40
	},
	{#State 207
		ACTIONS => {
			";" => 274,
			'OP19_VARIABLE_ASSIGN' => 275
		}
	},
	{#State 208
		DEFAULT => -116
	},
	{#State 209
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => 175,
			'OP06_REGEX_MATCH' => 174,
			'OP15_LOGICAL_AND' => 172,
			'OP23_LOGICAL_AND' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			";" => -179,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP04_MATH_POW' => 168,
			'OP21_LIST_COMMA' => -179,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			")" => -179,
			"]" => -179,
			'OP11_COMPARE_LT_GT' => 171
		}
	},
	{#State 210
		ACTIONS => {
			")" => -79,
			"]" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP04_MATH_POW' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			";" => -79,
			'OP13_BITWISE_AND' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP18_TERNARY' => -79,
			'OP08_STRING_CAT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			"}" => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP17_LIST_RANGE' => -79
		}
	},
	{#State 211
		ACTIONS => {
			"\$TYPED_" => 276
		}
	},
	{#State 212
		DEFAULT => -182
	},
	{#State 213
		ACTIONS => {
			";" => -176,
			'OP21_LIST_COMMA' => 277,
			"]" => -176,
			")" => -176
		},
		GOTOS => {
			'PAREN-42' => 278
		}
	},
	{#State 214
		ACTIONS => {
			")" => 279,
			'WORD' => 280
		}
	},
	{#State 215
		DEFAULT => -175
	},
	{#State 216
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"\@{" => 115,
			'LBRACE' => 88,
			'OP01_QW' => 135,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			"my" => 129,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'Operator' => 93,
			'SubExpression' => 136,
			'ListElements' => 281,
			'ArrayDereferenced' => 86,
			'ListElement' => 134,
			'WordScoped' => 87,
			'Literal' => 104,
			'HashReference' => 77,
			'Variable' => 130,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'TypeInner' => 127
		}
	},
	{#State 217
		ACTIONS => {
			'FH_REF_SYMBOL' => 282
		}
	},
	{#State 218
		ACTIONS => {
			";" => 283
		}
	},
	{#State 219
		ACTIONS => {
			";" => 284
		}
	},
	{#State 220
		ACTIONS => {
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => 175,
			'OP06_REGEX_MATCH' => 174,
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP04_MATH_POW' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => 169,
			")" => 285,
			'OP11_COMPARE_LT_GT' => 171
		}
	},
	{#State 221
		DEFAULT => -125
	},
	{#State 222
		DEFAULT => -117
	},
	{#State 223
		ACTIONS => {
			")" => 286
		}
	},
	{#State 224
		ACTIONS => {
			'OP21_LIST_COMMA' => 288,
			"}" => 289
		},
		GOTOS => {
			'PAREN-47' => 287
		}
	},
	{#State 225
		ACTIONS => {
			'OP01_NAMED' => -186,
			'OP01_OPEN' => -186,
			'OP01_CLOSE' => -186,
			'OP05_MATH_NEG_LPAREN' => -186,
			'OP10_NAMED_UNARY' => -186,
			'LITERAL_NUMBER' => -186,
			'WORD_UPPERCASE' => -186,
			"my" => 129,
			'LITERAL_STRING' => -186,
			'WORD' => -186,
			'OP05_LOGICAL_NEG' => -186,
			'OP22_LOGICAL_NEG' => -186,
			"undef" => -186,
			'LBRACKET' => -186,
			"%{" => -186,
			'VARIABLE_SYMBOL' => -186,
			'WORD_SCOPED' => -186,
			'LPAREN' => -186,
			'OP03_MATH_INC_DEC' => -186,
			"\@{" => -186,
			'LBRACE' => -186
		},
		GOTOS => {
			'TypeInner' => 291,
			'OPTIONAL-46' => 290
		}
	},
	{#State 226
		ACTIONS => {
			"integer" => 292
		}
	},
	{#State 227
		ACTIONS => {
			'WORD' => 55,
			"integer" => 56
		},
		GOTOS => {
			'Type' => 293
		}
	},
	{#State 228
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 88,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"\@{" => 115
		},
		GOTOS => {
			'Literal' => 104,
			'Variable' => 130,
			'HashReference' => 77,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'SubExpression' => 294,
			'Operator' => 93,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87
		}
	},
	{#State 229
		ACTIONS => {
			'LBRACE' => 88,
			"\@{" => 115,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD' => 296,
			'OP05_LOGICAL_NEG' => 99,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128
		},
		GOTOS => {
			'Variable' => 130,
			'HashReference' => 77,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'Literal' => 104,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'SubExpression' => 295,
			'Operator' => 93
		}
	},
	{#State 230
		DEFAULT => -161
	},
	{#State 231
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"\@{" => 115,
			'LBRACE' => 88,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'SubExpression' => 297,
			'Operator' => 93,
			'Variable' => 130,
			'HashReference' => 77,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Literal' => 104
		}
	},
	{#State 232
		DEFAULT => -123
	},
	{#State 233
		ACTIONS => {
			")" => -101,
			"]" => -101,
			'OP11_COMPARE_LT_GT' => 171,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => 170,
			'OP21_LIST_COMMA' => -101,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => 181,
			";" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => -101,
			'OP08_STRING_CAT' => 177,
			'OP23_LOGICAL_AND' => -101,
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => -101,
			"}" => -101,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => -101
		}
	},
	{#State 234
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP11_COMPARE_LT_GT' => 171,
			")" => -105,
			"]" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 168,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			";" => -105,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP23_LOGICAL_AND' => -105,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 172,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			"}" => -105
		}
	},
	{#State 235
		ACTIONS => {
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => -93,
			'OP18_TERNARY' => -93,
			'OP08_STRING_CAT' => 177,
			"}" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP21_LIST_COMMA' => -93,
			")" => -93,
			"]" => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			";" => -93,
			'OP13_BITWISE_AND' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 236
		ACTIONS => {
			'OP21_LIST_COMMA' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			"]" => -85,
			")" => -85,
			'OP13_BITWISE_AND' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			";" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP04_MATH_POW' => 168,
			'OP08_STRING_CAT' => -85,
			'OP18_TERNARY' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP15_LOGICAL_AND' => -85
		}
	},
	{#State 237
		ACTIONS => {
			'OP23_LOGICAL_AND' => 166,
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => 165,
			"}" => -106,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => 175,
			'OP06_REGEX_MATCH' => 174,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => 181,
			";" => -106,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			"]" => -106,
			")" => -106,
			'OP11_COMPARE_LT_GT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106
		}
	},
	{#State 238
		ACTIONS => {
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => -91,
			'OP18_TERNARY' => -91,
			'OP08_STRING_CAT' => -91,
			"}" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP21_LIST_COMMA' => -91,
			")" => -91,
			"]" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			";" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 239
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => -96,
			"}" => -96,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			")" => -96,
			"]" => -96,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			";" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 240
		ACTIONS => {
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => -100,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NE' => 173,
			"}" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP11_COMPARE_LT_GT' => 171,
			"]" => -100,
			")" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			";" => -100,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 241
		ACTIONS => {
			'OP21_LIST_COMMA' => -97,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP11_COMPARE_LT_GT' => 171,
			"]" => -97,
			")" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			";" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP04_MATH_POW' => 168,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => -97,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP17_LIST_RANGE' => -97,
			'OP06_REGEX_MATCH' => 174,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP15_LOGICAL_AND' => -97
		}
	},
	{#State 242
		DEFAULT => -88
	},
	{#State 243
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 174,
			"}" => -102,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 172,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			";" => -102,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP04_MATH_POW' => 168,
			'OP21_LIST_COMMA' => -102,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -102,
			")" => -102,
			"]" => -102,
			'OP11_COMPARE_LT_GT' => 171
		}
	},
	{#State 244
		DEFAULT => -206
	},
	{#State 245
		DEFAULT => -205
	},
	{#State 246
		ACTIONS => {
			'COLON' => 298
		}
	},
	{#State 247
		ACTIONS => {
			"}" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => -92,
			'OP18_TERNARY' => -92,
			'OP08_STRING_CAT' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			";" => -92,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => -92,
			'OP04_MATH_POW' => 168,
			'OP21_LIST_COMMA' => -92,
			"]" => -92,
			")" => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP08_MATH_ADD_SUB' => 170
		}
	},
	{#State 248
		ACTIONS => {
			"}" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP18_TERNARY' => -89,
			'OP08_STRING_CAT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			";" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP04_MATH_POW' => 168,
			'OP21_LIST_COMMA' => -89,
			"]" => -89,
			")" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP24_LOGICAL_OR_XOR' => -89
		}
	},
	{#State 249
		ACTIONS => {
			'OP16_LOGICAL_OR' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP15_LOGICAL_AND' => -90,
			"}" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP06_REGEX_MATCH' => 174,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => -90,
			'OP18_TERNARY' => -90,
			'OP08_STRING_CAT' => -90,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => -90,
			";" => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			"]" => -90,
			")" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP21_LIST_COMMA' => -90
		}
	},
	{#State 250
		ACTIONS => {
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => -98,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP17_LIST_RANGE' => -98,
			'OP06_REGEX_MATCH' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			"}" => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => 171,
			"]" => -98,
			")" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => -98,
			";" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 251
		ACTIONS => {
			'OP21_LIST_COMMA' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 171,
			"]" => -99,
			")" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			";" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP04_MATH_POW' => 168,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => -99,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => -99,
			'OP12_COMPARE_EQ_NE' => 173,
			"}" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP23_LOGICAL_AND' => -99
		}
	},
	{#State 252
		DEFAULT => -87
	},
	{#State 253
		DEFAULT => -197
	},
	{#State 254
		DEFAULT => -196
	},
	{#State 255
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 171,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => 181,
			";" => -135,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176,
			'OP15_LOGICAL_AND' => 172,
			'OP23_LOGICAL_AND' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP17_LIST_RANGE' => 175,
			'OP06_REGEX_MATCH' => 174,
			'OP12_COMPARE_EQ_NE' => 173
		}
	},
	{#State 256
		DEFAULT => -136
	},
	{#State 257
		ACTIONS => {
			";" => 299
		}
	},
	{#State 258
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			"my" => 129,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128,
			'OP01_QW' => 135,
			'LBRACE' => 88,
			")" => -120,
			"\@{" => 115,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108
		},
		GOTOS => {
			'ListElements' => 301,
			'ArrayDereferenced' => 86,
			'ListElement' => 134,
			'WordScoped' => 87,
			'Operator' => 93,
			'SubExpression' => 136,
			'HashReference' => 77,
			'Variable' => 130,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Expression' => 131,
			'TypeInner' => 127,
			'Literal' => 104,
			'OPTIONAL-33' => 300
		}
	},
	{#State 259
		ACTIONS => {
			'OP04_MATH_POW' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			";" => 302,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 171,
			'OP23_LOGICAL_AND' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 172,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178
		}
	},
	{#State 260
		ACTIONS => {
			'OP21_LIST_COMMA' => 303
		}
	},
	{#State 261
		ACTIONS => {
			'LBRACE' => 88,
			"\@{" => 115,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			"my" => 129,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_QW' => 135,
			'OP01_NAMED' => 128
		},
		GOTOS => {
			'ListElements' => 304,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'ListElement' => 134,
			'SubExpression' => 136,
			'Operator' => 93,
			'Variable' => 130,
			'HashReference' => 77,
			'TypeInner' => 127,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Literal' => 104
		}
	},
	{#State 262
		DEFAULT => -134
	},
	{#State 263
		DEFAULT => -183
	},
	{#State 264
		DEFAULT => -184
	},
	{#State 265
		DEFAULT => -113
	},
	{#State 266
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 305
		}
	},
	{#State 267
		DEFAULT => -55
	},
	{#State 268
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 306
		}
	},
	{#State 269
		DEFAULT => -45
	},
	{#State 270
		ACTIONS => {
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 108,
			'OP01_NAMED_VOID' => 116,
			"\@{" => 115,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 95,
			"while" => -139,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 94,
			'LBRACE' => 88,
			"if" => 84,
			'OP01_NAMED_VOID_SCOLON' => 92,
			"foreach" => -139,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_NAMED' => 76,
			'LITERAL_NUMBER' => 81,
			'OP01_PRINT' => 82,
			"}" => 307,
			"my" => 71,
			"undef" => 74,
			'LBRACKET' => 73,
			"for" => -139,
			'OP19_LOOP_CONTROL' => 72
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'Conditional' => 85,
			'WordScoped' => 87,
			'OPTIONAL-35' => 91,
			'Statement' => 90,
			'OperatorVoid' => 89,
			'Operator' => 93,
			'Variable' => 109,
			'Expression' => 113,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Operation' => 308,
			'LoopLabel' => 100,
			'VariableModification' => 75,
			'SubExpression' => 101,
			'HashReference' => 77,
			'VariableDeclaration' => 79,
			'PAREN-34' => 107,
			'Literal' => 104
		}
	},
	{#State 271
		ACTIONS => {
			'VARIABLE_SYMBOL' => 309
		}
	},
	{#State 272
		DEFAULT => -41
	},
	{#State 273
		ACTIONS => {
			'WORD_UPPERCASE' => 310
		}
	},
	{#State 274
		DEFAULT => -167
	},
	{#State 275
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			"\@{" => 115,
			'LBRACE' => 88,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 103,
			'LBRACKET' => 73,
			"undef" => 74,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'STDIN' => 256
		},
		GOTOS => {
			'SubExpression' => 255,
			'Operator' => 93,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'Literal' => 104,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'SubExpressionOrStdin' => 311,
			'Expression' => 131,
			'Variable' => 130,
			'HashReference' => 77
		}
	},
	{#State 276
		ACTIONS => {
			'WORD' => 312
		}
	},
	{#State 277
		ACTIONS => {
			"\@{" => 115,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			'LBRACE' => 88,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 137,
			"my" => 129,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'Variable' => 130,
			'HashReference' => 77,
			'TypeInner' => 127,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Literal' => 104,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'ListElement' => 313,
			'SubExpression' => 136,
			'Operator' => 93
		}
	},
	{#State 278
		DEFAULT => -172
	},
	{#State 279
		DEFAULT => -177
	},
	{#State 280
		DEFAULT => -174
	},
	{#State 281
		ACTIONS => {
			";" => 314
		}
	},
	{#State 282
		ACTIONS => {
			'OP21_LIST_COMMA' => 315
		}
	},
	{#State 283
		DEFAULT => -110
	},
	{#State 284
		DEFAULT => -111
	},
	{#State 285
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 317
		}
	},
	{#State 286
		DEFAULT => -122
	},
	{#State 287
		DEFAULT => -192
	},
	{#State 288
		ACTIONS => {
			"%{" => 108,
			'WORD' => 152
		},
		GOTOS => {
			'HashEntry' => 318,
			'HashDereferenced' => 153
		}
	},
	{#State 289
		DEFAULT => -194
	},
	{#State 290
		ACTIONS => {
			"\@{" => 115,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'Literal' => 104,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'SubExpression' => 319,
			'Operator' => 93
		}
	},
	{#State 291
		DEFAULT => -185
	},
	{#State 292
		ACTIONS => {
			'VARIABLE_SYMBOL' => 320
		}
	},
	{#State 293
		ACTIONS => {
			'VARIABLE_SYMBOL' => 321
		}
	},
	{#State 294
		ACTIONS => {
			'OP17_LIST_RANGE' => 175,
			'OP06_REGEX_MATCH' => 174,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 172,
			'OP23_LOGICAL_AND' => 166,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP11_COMPARE_LT_GT' => 171,
			")" => 322
		}
	},
	{#State 295
		ACTIONS => {
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177,
			"}" => 323,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP23_LOGICAL_AND' => 166,
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => 165,
			'OP11_COMPARE_LT_GT' => 171,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 296
		ACTIONS => {
			'LPAREN' => -198,
			"}" => 324,
			'OP02_METHOD_THINARROW_NEW' => -198
		}
	},
	{#State 297
		ACTIONS => {
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP15_LOGICAL_AND' => 172,
			'OP23_LOGICAL_AND' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP08_MATH_ADD_SUB' => 170,
			"]" => 325,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 298
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'LITERAL_STRING' => 97,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'VariableOrLiteral' => 326,
			'Variable' => 245,
			'Literal' => 244
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
			'LBRACE' => 88,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			"\@{" => 115,
			'LITERAL_STRING' => 97,
			"my" => 129,
			'WORD_UPPERCASE' => 137,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_NAMED' => 128,
			'OP01_QW' => 135,
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106
		},
		GOTOS => {
			'ListElement' => 134,
			'WordScoped' => 87,
			'ListElements' => 328,
			'ArrayDereferenced' => 86,
			'Operator' => 93,
			'SubExpression' => 136,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'TypeInner' => 127,
			'HashReference' => 77,
			'Variable' => 130,
			'Literal' => 104
		}
	},
	{#State 304
		ACTIONS => {
			")" => 329
		}
	},
	{#State 305
		ACTIONS => {
			'LITERAL_NUMBER' => 332,
			"our" => 333
		},
		GOTOS => {
			'MethodOrSubroutine' => 334,
			'Subroutine' => 330,
			'Method' => 331
		}
	},
	{#State 306
		ACTIONS => {
			'LBRACE' => 335
		}
	},
	{#State 307
		ACTIONS => {
			";" => 336
		}
	},
	{#State 308
		DEFAULT => -44
	},
	{#State 309
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 337
		}
	},
	{#State 310
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 338
		}
	},
	{#State 311
		ACTIONS => {
			";" => 339
		}
	},
	{#State 312
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 340
		}
	},
	{#State 313
		DEFAULT => -171
	},
	{#State 314
		DEFAULT => -114
	},
	{#State 315
		ACTIONS => {
			'LITERAL_STRING' => 341
		}
	},
	{#State 316
		ACTIONS => {
			"\@{" => 115,
			'OP01_NAMED_VOID' => 116,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			'OP01_NAMED_VOID_SCOLON' => 92,
			"foreach" => -139,
			"if" => 84,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_PRINT' => 82,
			'OP01_NAMED' => 76,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_LOGICAL_NEG' => 99,
			'OP19_LOOP_CONTROL' => 72,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			'OP22_LOGICAL_NEG' => 103,
			"for" => -139,
			"my" => 71,
			"while" => -139,
			'WORD_UPPERCASE' => 95,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'PAREN-34' => 107,
			'Literal' => 104,
			'VariableDeclaration' => 79,
			'PLUS-40' => 342,
			'HashReference' => 77,
			'VariableModification' => 75,
			'SubExpression' => 101,
			'LoopLabel' => 100,
			'Operation' => 343,
			'HashDereferenced' => 114,
			'Expression' => 113,
			'ArrayReference' => 112,
			'Variable' => 109,
			'Operator' => 93,
			'OPTIONAL-35' => 91,
			'Statement' => 90,
			'OperatorVoid' => 89,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'Conditional' => 85
		}
	},
	{#State 317
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 344
		}
	},
	{#State 318
		DEFAULT => -191
	},
	{#State 319
		ACTIONS => {
			'OP21_LIST_COMMA' => -187,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP11_COMPARE_LT_GT' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP04_MATH_POW' => 168,
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => 175,
			'OP06_REGEX_MATCH' => 174,
			"}" => -187,
			'OP23_LOGICAL_AND' => 166,
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => 165
		}
	},
	{#State 320
		ACTIONS => {
			'LPAREN' => 345
		}
	},
	{#State 321
		ACTIONS => {
			'LPAREN' => 346
		}
	},
	{#State 322
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 347
		}
	},
	{#State 323
		DEFAULT => -165
	},
	{#State 324
		DEFAULT => -166
	},
	{#State 325
		DEFAULT => -164
	},
	{#State 326
		DEFAULT => -103
	},
	{#State 327
		DEFAULT => -124
	},
	{#State 328
		ACTIONS => {
			")" => 348
		}
	},
	{#State 329
		DEFAULT => -78
	},
	{#State 330
		DEFAULT => -75
	},
	{#State 331
		DEFAULT => -74
	},
	{#State 332
		ACTIONS => {
			";" => 349
		}
	},
	{#State 333
		ACTIONS => {
			"integer" => 56,
			'TYPE_METHOD' => 350,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 334
		DEFAULT => -57
	},
	{#State 335
		ACTIONS => {
			"}" => 352,
			"%{" => 108,
			'WORD' => 353
		},
		GOTOS => {
			'HashDereferenced' => 354,
			'HashEntryTyped' => 351
		}
	},
	{#State 336
		DEFAULT => -46
	},
	{#State 337
		ACTIONS => {
			'OP21_LIST_COMMA' => 356,
			")" => 357
		},
		GOTOS => {
			'PAREN-18' => 355
		}
	},
	{#State 338
		DEFAULT => -204
	},
	{#State 339
		DEFAULT => -168
	},
	{#State 340
		DEFAULT => -203
	},
	{#State 341
		ACTIONS => {
			'OP21_LIST_COMMA' => 358
		}
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 26,
			"if" => 84,
			'LBRACE' => 88,
			"foreach" => -139,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'OP01_NAMED' => 76,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP01_PRINT' => 82,
			'LITERAL_NUMBER' => 81,
			"my" => 71,
			"}" => 359,
			'OP19_LOOP_CONTROL' => 72,
			"for" => -139,
			"undef" => 74,
			'LBRACKET' => 73,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"\@{" => 115,
			'OP01_NAMED_VOID' => 116,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'WORD_UPPERCASE' => 95,
			"while" => -139,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 102
		},
		GOTOS => {
			'LoopLabel' => 100,
			'VariableModification' => 75,
			'SubExpression' => 101,
			'Operation' => 360,
			'Literal' => 104,
			'PAREN-34' => 107,
			'HashReference' => 77,
			'VariableDeclaration' => 79,
			'OperatorVoid' => 89,
			'Statement' => 90,
			'OPTIONAL-35' => 91,
			'Operator' => 93,
			'ArrayDereferenced' => 86,
			'Conditional' => 85,
			'WordScoped' => 87,
			'Variable' => 109,
			'Expression' => 113,
			'HashDereferenced' => 114,
			'ArrayReference' => 112
		}
	},
	{#State 343
		DEFAULT => -159
	},
	{#State 344
		ACTIONS => {
			"if" => -150,
			"elsif" => 365,
			'LBRACE' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			"foreach" => -150,
			'VARIABLE_SYMBOL' => -150,
			'WORD_SCOPED' => -150,
			"my" => -150,
			"}" => -150,
			'OP19_LOOP_CONTROL' => -150,
			"undef" => -150,
			'LBRACKET' => -150,
			"for" => -150,
			'' => -150,
			'OP01_NAMED' => -150,
			'OP01_CLOSE' => -150,
			'OP01_OPEN' => -150,
			'OP01_PRINT' => -150,
			'LITERAL_NUMBER' => -150,
			"%{" => -150,
			"else" => 362,
			'OP03_MATH_INC_DEC' => -150,
			'LPAREN' => -150,
			"\@{" => -150,
			'OP01_NAMED_VOID' => -150,
			'WORD_UPPERCASE' => -150,
			"while" => -150,
			'LITERAL_STRING' => -150,
			'OP05_LOGICAL_NEG' => -150,
			'WORD' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP05_MATH_NEG_LPAREN' => -150
		},
		GOTOS => {
			'OPTIONAL-39' => 361,
			'PAREN-36' => 363,
			'PAREN-38' => 364
		}
	},
	{#State 345
		ACTIONS => {
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"\@{" => 115,
			'LBRACE' => 88,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103
		},
		GOTOS => {
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Operator' => 93,
			'SubExpression' => 366,
			'HashReference' => 77,
			'Variable' => 130,
			'Expression' => 131,
			'ArrayReference' => 112,
			'HashDereferenced' => 114,
			'Literal' => 104
		}
	},
	{#State 346
		ACTIONS => {
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"\@{" => 115,
			"my" => 129,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP01_NAMED' => 128,
			'OP01_QW' => 135,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 104,
			'TypeInner' => 127,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'Variable' => 130,
			'HashReference' => 77,
			'SubExpression' => 136,
			'Operator' => 93,
			'WordScoped' => 87,
			'ListElement' => 134,
			'ArrayDereferenced' => 86,
			'ListElements' => 367
		}
	},
	{#State 347
		DEFAULT => -157
	},
	{#State 348
		DEFAULT => -80
	},
	{#State 349
		DEFAULT => -59
	},
	{#State 350
		ACTIONS => {
			'VARIABLE_SYMBOL' => 368
		}
	},
	{#State 351
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 369
		}
	},
	{#State 352
		ACTIONS => {
			";" => 370
		}
	},
	{#State 353
		ACTIONS => {
			'OP20_HASH_FATARROW' => 371
		}
	},
	{#State 354
		DEFAULT => -190
	},
	{#State 355
		DEFAULT => -48
	},
	{#State 356
		ACTIONS => {
			"my" => 372
		}
	},
	{#State 357
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 373
		}
	},
	{#State 358
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LBRACKET' => 73,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			"\@{" => 115,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			'LBRACE' => 88
		},
		GOTOS => {
			'SubExpression' => 374,
			'Operator' => 93,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Literal' => 104,
			'Variable' => 130,
			'HashReference' => 77,
			'ArrayReference' => 112,
			'Expression' => 131,
			'HashDereferenced' => 114
		}
	},
	{#State 359
		DEFAULT => -160
	},
	{#State 360
		DEFAULT => -158
	},
	{#State 361
		DEFAULT => -151
	},
	{#State 362
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 375
		}
	},
	{#State 363
		DEFAULT => -146
	},
	{#State 364
		DEFAULT => -149
	},
	{#State 365
		ACTIONS => {
			'LPAREN' => 376
		}
	},
	{#State 366
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 377,
			'OP16_LOGICAL_OR' => 165,
			'OP23_LOGICAL_AND' => 166,
			'OP15_LOGICAL_AND' => 172,
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP11_COMPARE_LT_GT' => 171
		}
	},
	{#State 367
		ACTIONS => {
			")" => 378
		}
	},
	{#State 368
		ACTIONS => {
			"= sub {" => 379
		}
	},
	{#State 369
		ACTIONS => {
			"}" => 381,
			'OP21_LIST_COMMA' => 382
		},
		GOTOS => {
			'PAREN-24' => 380
		}
	},
	{#State 370
		DEFAULT => -64
	},
	{#State 371
		ACTIONS => {
			"my" => 129
		},
		GOTOS => {
			'TypeInner' => 383
		}
	},
	{#State 372
		ACTIONS => {
			'WORD' => 55,
			"integer" => 56
		},
		GOTOS => {
			'Type' => 384
		}
	},
	{#State 373
		ACTIONS => {
			"\@_;" => 385
		}
	},
	{#State 374
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 181,
			";" => -81,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP04_MATH_POW' => 168,
			'OP21_LIST_COMMA' => -81,
			"]" => -81,
			")" => -81,
			'OP11_COMPARE_LT_GT' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -81,
			"}" => -81,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP15_LOGICAL_AND' => 172,
			'OP23_LOGICAL_AND' => -81,
			'OP16_LOGICAL_OR' => 165,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177
		}
	},
	{#State 375
		DEFAULT => -148
	},
	{#State 376
		ACTIONS => {
			"\@{" => 115,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97
		},
		GOTOS => {
			'SubExpression' => 386,
			'Operator' => 93,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'Literal' => 104,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Variable' => 130,
			'HashReference' => 77
		}
	},
	{#State 377
		ACTIONS => {
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP10_NAMED_UNARY' => 105,
			'LITERAL_NUMBER' => 81,
			'LBRACE' => 88,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'WORD_SCOPED' => 26,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"\@{" => 115
		},
		GOTOS => {
			'Literal' => 104,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'ArrayReference' => 112,
			'Variable' => 130,
			'HashReference' => 77,
			'SubExpression' => 387,
			'Operator' => 93,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86
		}
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 379
		ACTIONS => {
			'OP01_NAMED_VOID' => -66,
			"\@{" => -66,
			'LPAREN' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'LPAREN_MY' => 389,
			"%{" => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'WORD' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'LITERAL_STRING' => -66,
			'WORD_UPPERCASE' => -66,
			"while" => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"foreach" => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LBRACE' => -66,
			"if" => -66,
			'WORD_SCOPED' => -66,
			'VARIABLE_SYMBOL' => -66,
			"for" => -66,
			"undef" => -66,
			'LBRACKET' => -66,
			'OP19_LOOP_CONTROL' => -66,
			"my" => -66,
			'OP01_PRINT' => -66,
			'LITERAL_NUMBER' => -66,
			'OP01_OPEN' => -66,
			'OP01_CLOSE' => -66,
			'OP01_NAMED' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 390,
			'MethodArguments' => 391
		}
	},
	{#State 380
		DEFAULT => -61
	},
	{#State 381
		ACTIONS => {
			";" => 392
		}
	},
	{#State 382
		ACTIONS => {
			'WORD' => 353,
			"%{" => 108
		},
		GOTOS => {
			'HashDereferenced' => 354,
			'HashEntryTyped' => 393
		}
	},
	{#State 383
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP01_NAMED' => 128,
			"undef" => 74,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 103,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'LITERAL_STRING' => 97,
			'WORD_UPPERCASE' => 137,
			"\@{" => 115,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 26,
			"%{" => 108,
			'VARIABLE_SYMBOL' => 94,
			'LBRACE' => 88
		},
		GOTOS => {
			'Operator' => 93,
			'SubExpression' => 394,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Literal' => 104,
			'HashReference' => 77,
			'Variable' => 130,
			'Expression' => 131,
			'HashDereferenced' => 114,
			'ArrayReference' => 112
		}
	},
	{#State 384
		ACTIONS => {
			'VARIABLE_SYMBOL' => 395
		}
	},
	{#State 385
		DEFAULT => -50
	},
	{#State 386
		ACTIONS => {
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP11_COMPARE_LT_GT' => 171,
			")" => 396,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 172,
			'OP23_LOGICAL_AND' => 166,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => 176
		}
	},
	{#State 387
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 180,
			'OP04_MATH_POW' => 168,
			'OP11_COMPARE_LT_GT' => 171,
			")" => 397,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP06_REGEX_MATCH' => 174,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP23_LOGICAL_AND' => -102,
			'OP15_LOGICAL_AND' => 172,
			'OP16_LOGICAL_OR' => 165,
			'OP09_BITWISE_SHIFT' => 167,
			'OP07_STRING_REPEAT' => 178,
			'OP08_STRING_CAT' => 177,
			'OP18_TERNARY' => -102
		}
	},
	{#State 388
		DEFAULT => -156
	},
	{#State 389
		ACTIONS => {
			'TYPE_SELF' => 398
		}
	},
	{#State 390
		ACTIONS => {
			'OP01_NAMED' => 76,
			'OP01_CLOSE' => 78,
			'OP01_OPEN' => 80,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'LITERAL_NUMBER' => 81,
			'OP01_PRINT' => 82,
			"while" => -139,
			'WORD_UPPERCASE' => 95,
			"my" => 71,
			'LITERAL_STRING' => 97,
			'OP05_LOGICAL_NEG' => 99,
			'WORD' => 24,
			'OP19_LOOP_CONTROL' => 72,
			'LBRACKET' => 73,
			'OP19_LOOP_CONTROL_SCOLON' => 102,
			"undef" => 74,
			'OP22_LOGICAL_NEG' => 103,
			"for" => -139,
			'VARIABLE_SYMBOL' => 94,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			'WORD_SCOPED' => 26,
			"\@{" => 115,
			'OP01_NAMED_VOID' => 116,
			"if" => 84,
			'LBRACE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 92,
			"foreach" => -139
		},
		GOTOS => {
			'HashReference' => 77,
			'VariableDeclaration' => 79,
			'PAREN-34' => 107,
			'Literal' => 104,
			'PLUS-27' => 399,
			'Operation' => 400,
			'LoopLabel' => 100,
			'SubExpression' => 101,
			'VariableModification' => 75,
			'Variable' => 109,
			'ArrayReference' => 112,
			'Expression' => 113,
			'HashDereferenced' => 114,
			'Conditional' => 85,
			'ArrayDereferenced' => 86,
			'WordScoped' => 87,
			'Statement' => 90,
			'OPTIONAL-35' => 91,
			'OperatorVoid' => 89,
			'Operator' => 93
		}
	},
	{#State 391
		DEFAULT => -65
	},
	{#State 392
		DEFAULT => -63
	},
	{#State 393
		DEFAULT => -60
	},
	{#State 394
		ACTIONS => {
			'OP18_TERNARY' => 176,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 178,
			'OP09_BITWISE_SHIFT' => 167,
			'OP23_LOGICAL_AND' => 166,
			'OP16_LOGICAL_OR' => 165,
			'OP15_LOGICAL_AND' => 172,
			'OP12_COMPARE_EQ_NE' => 173,
			'OP17_LIST_RANGE' => 175,
			'OP06_REGEX_MATCH' => 174,
			"}" => -189,
			'OP08_MATH_ADD_SUB' => 170,
			'OP24_LOGICAL_OR_XOR' => 169,
			'OP11_COMPARE_LT_GT' => 171,
			'OP21_LIST_COMMA' => -189,
			'OP04_MATH_POW' => 168,
			'OP13_BITWISE_AND' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP14_BITWISE_OR_XOR' => 181
		}
	},
	{#State 395
		DEFAULT => -47
	},
	{#State 396
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 401
		}
	},
	{#State 397
		ACTIONS => {
			'LBRACE' => 316
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
			'VARIABLE_SYMBOL' => 94,
			'WORD_SCOPED' => 26,
			"if" => 84,
			'LBRACE' => 88,
			"foreach" => -139,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'OP01_NAMED' => 76,
			'OP01_OPEN' => 80,
			'OP01_CLOSE' => 78,
			'LITERAL_NUMBER' => 81,
			'OP01_PRINT' => 82,
			"my" => 71,
			"}" => 405,
			'OP19_LOOP_CONTROL' => 72,
			"for" => -139,
			'LBRACKET' => 73,
			"undef" => 74,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"\@{" => 115,
			'OP01_NAMED_VOID' => 116,
			'OP10_NAMED_UNARY' => 105,
			'OP05_MATH_NEG_LPAREN' => 106,
			'WORD_UPPERCASE' => 95,
			"while" => -139,
			'LITERAL_STRING' => 97,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 99,
			'OP22_LOGICAL_NEG' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 102
		},
		GOTOS => {
			'HashDereferenced' => 114,
			'Expression' => 113,
			'ArrayReference' => 112,
			'Variable' => 109,
			'Operator' => 93,
			'OperatorVoid' => 89,
			'Statement' => 90,
			'OPTIONAL-35' => 91,
			'WordScoped' => 87,
			'ArrayDereferenced' => 86,
			'Conditional' => 85,
			'Literal' => 104,
			'PAREN-34' => 107,
			'VariableDeclaration' => 79,
			'HashReference' => 77,
			'SubExpression' => 101,
			'VariableModification' => 75,
			'LoopLabel' => 100,
			'Operation' => 404
		}
	},
	{#State 400
		DEFAULT => -68
	},
	{#State 401
		DEFAULT => -145
	},
	{#State 402
		DEFAULT => -155
	},
	{#State 403
		ACTIONS => {
			'OP21_LIST_COMMA' => 406,
			")" => 408
		},
		GOTOS => {
			'PAREN-28' => 407
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
		DEFAULT => -71
	},
	{#State 408
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 411
		}
	},
	{#State 409
		DEFAULT => -69
	},
	{#State 410
		ACTIONS => {
			'WORD' => 55,
			"integer" => 56
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
#line 5783 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5790 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5797 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5804 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5815 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5826 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5833 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5840 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5847 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5854 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5861 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5868 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5875 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5882 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5889 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5896 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5903 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5910 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5921 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5935 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5946 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5968 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5975 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5982 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5989 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5996 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6003 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6010 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6017 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6024 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6035 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6046 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6053 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6060 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6071 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6078 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6085 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6096 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6107 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6118 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6125 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6132 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6139 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6146 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6171 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6178 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6196 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6203 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6210 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6217 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6224 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6231 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6238 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6245 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6256 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6263 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6277 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6299 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6306 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6313 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6320 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6327 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6338 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6345 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6352 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6359 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6370 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6381 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6403 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6414 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6568 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6579 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6590 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6601 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6612 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6623 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6645 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6667 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6678 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6689 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6700 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6711 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6722 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6733 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6740 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6747 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6754 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6787 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6798 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6809 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6820 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6831 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6845 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6852 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6859 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6870 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6881 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6892 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6903 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_135
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7042 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7049 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_140
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 5,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_151
		 'Conditional', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7164 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_152
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7175 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7186 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7197 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_155
		 'LoopFor', 10,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_156
		 'LoopForEach', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7219 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_157
		 'LoopWhile', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7230 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7237 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7244 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_160
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7255 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7262 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_163
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_164
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7302 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7313 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_167
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7324 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7335 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_169
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7346 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7357 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7364 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7371 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7378 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_176
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_177
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_178
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7425 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7443 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7450 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_182
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7461 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_183
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_184
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7490 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_187
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_188
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_189
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_190
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7555 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_194
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_195
		 'HashReference', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_196
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_197
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_198
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_199
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_200
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule Type_201
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7650 lib/RPerl/Grammar.pm
	],
	[#Rule Type_202
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7661 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_203
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7672 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_204
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7683 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_205
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7694 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_206
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7716 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7727 lib/RPerl/Grammar.pm
	]
],
#line 7730 lib/RPerl/Grammar.pm
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


#line 7987 lib/RPerl/Grammar.pm



1;
