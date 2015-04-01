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
    our $VERSION = 0.000_986;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|foreach|\=\ sub\ \{|\$TYPED_|while|undef|elsif|else|our|for|use|\@_\;|\%\{|\@\{|if|my|\]|\)|\}|\;)}gc and return ($1, $1);

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
			"package" => -20,
			"## no critic qw(" => 9,
			'SHEBANG' => 2
		},
		GOTOS => {
			'PLUS-2' => 8,
			'CompileUnit' => 3,
			'ModuleHeader' => 7,
			'Critic' => 6,
			'PAREN-1' => 1,
			'Program' => 5,
			'OPTIONAL-9' => 4
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 9,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 11,
			'Critic' => 10
		}
	},
	{#State 3
		ACTIONS => {
			'' => 12
		}
	},
	{#State 4
		ACTIONS => {
			"package" => 13
		}
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		ACTIONS => {
			"use" => -25,
			"use parent qw(" => 17,
			"use constant" => -25,
			"our" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Class' => 15,
			'STAR-10' => 14,
			'Module' => 16,
			'Package' => 18
		}
	},
	{#State 8
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 9,
			'' => -5
		},
		GOTOS => {
			'Critic' => 6,
			'ModuleHeader' => 7,
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
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 14
		ACTIONS => {
			"our" => -27,
			"## no critic qw(" => 9,
			"use constant" => -27,
			"use" => -27
		},
		GOTOS => {
			'STAR-11' => 27,
			'Critic' => 28
		}
	},
	{#State 15
		DEFAULT => -23
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 18
		DEFAULT => -22
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			'WORD' => 31,
			")" => 30
		}
	},
	{#State 22
		ACTIONS => {
			"use warnings;" => 32
		}
	},
	{#State 23
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 33
		}
	},
	{#State 24
		DEFAULT => -201
	},
	{#State 25
		ACTIONS => {
			";" => 34
		}
	},
	{#State 26
		DEFAULT => -200
	},
	{#State 27
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 36
		},
		GOTOS => {
			'STAR-12' => 37,
			'Include' => 35
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
		DEFAULT => -36
	},
	{#State 31
		DEFAULT => -34
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"while" => -11,
			'OP01_PRINT' => -11,
			'VARIABLE_SYMBOL' => -11,
			'LBRACE' => -11,
			"## no critic qw(" => 9,
			'OP03_MATH_INC_DEC' => -11,
			"use" => -11,
			'LPAREN' => -11,
			"undef" => -11,
			"%{" => -11,
			"our" => -11,
			'WORD_SCOPED' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED' => -11,
			'OP01_OPEN' => -11,
			"\@{" => -11,
			"my" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"if" => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED_VOID' => -11,
			"foreach" => -11,
			'LITERAL_NUMBER' => -11,
			'LBRACKET' => -11,
			'WORD_UPPERCASE' => -11,
			'WORD' => -11,
			"for" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"use constant" => -11
		},
		GOTOS => {
			'Critic' => 41,
			'STAR-5' => 40
		}
	},
	{#State 34
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 42
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 37
		ACTIONS => {
			"use constant" => 47,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 48,
			'Constant' => 46,
			'PLUS-13' => 45
		}
	},
	{#State 38
		ACTIONS => {
			";" => 49
		}
	},
	{#State 39
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_NAMED_VOID' => -13,
			"foreach" => -13,
			'OP01_CLOSE' => -13,
			"if" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"\@{" => -13,
			'OP01_NAMED' => -13,
			'OP01_OPEN' => -13,
			"my" => -13,
			'LITERAL_STRING' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"%{" => -13,
			"our" => -13,
			'WORD_SCOPED' => -13,
			"undef" => -13,
			'LPAREN' => -13,
			"use" => 36,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACE' => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			"while" => -13,
			"use constant" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"for" => -13,
			'WORD' => -13,
			'WORD_UPPERCASE' => -13,
			'LBRACKET' => -13,
			'LITERAL_NUMBER' => -13
		},
		GOTOS => {
			'Include' => 52,
			'STAR-6' => 51
		}
	},
	{#State 41
		DEFAULT => -8
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
			'TYPE_INTEGER' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 59,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 46
		DEFAULT => -28
	},
	{#State 47
		ACTIONS => {
			'WORD_UPPERCASE' => 60
		}
	},
	{#State 48
		DEFAULT => -31
	},
	{#State 49
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 62
		}
	},
	{#State 51
		ACTIONS => {
			"use constant" => 47,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD' => -15,
			"for" => -15,
			'WORD_UPPERCASE' => -15,
			'LITERAL_NUMBER' => -15,
			'LBRACKET' => -15,
			'OP01_CLOSE' => -15,
			"foreach" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"if" => -15,
			'LITERAL_STRING' => -15,
			"my" => -15,
			"\@{" => -15,
			'OP01_NAMED' => -15,
			'OP01_OPEN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"undef" => -15,
			'WORD_SCOPED' => -15,
			"our" => -15,
			"%{" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'LPAREN' => -15,
			'OP01_PRINT' => -15,
			'LBRACE' => -15,
			'VARIABLE_SYMBOL' => -15,
			"while" => -15
		},
		GOTOS => {
			'STAR-7' => 64,
			'Constant' => 63
		}
	},
	{#State 52
		DEFAULT => -10
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
		DEFAULT => -204
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		}
	},
	{#State 57
		DEFAULT => -203
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
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 70
		}
	},
	{#State 62
		DEFAULT => -33
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 76,
			'WORD_UPPERCASE' => 83,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'OP19_LOOP_CONTROL' => 81,
			'OP01_NAMED_VOID_SCOLON' => 79,
			"for" => -139,
			'WORD' => 26,
			"\@{" => 101,
			'OP01_NAMED' => 100,
			'OP01_OPEN' => 103,
			"my" => 98,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED_VOID' => 91,
			"foreach" => -139,
			'OP01_CLOSE' => 89,
			"if" => 95,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 92,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'OP01_PRINT' => 113,
			"while" => -139,
			"our" => 44,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110
		},
		GOTOS => {
			'HashDereference' => 112,
			'VariableModification' => 84,
			'Literal' => 114,
			'VariableDeclaration' => 86,
			'Subroutine' => 87,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'LoopLabel' => 106,
			'Variable' => 108,
			'WordScoped' => 82,
			'Operation' => 97,
			'OPTIONAL-35' => 102,
			'ArrayReference' => 99,
			'PLUS-8' => 77,
			'Expression' => 78,
			'HashReference' => 90,
			'SubExpression' => 71,
			'Conditional' => 72,
			'Statement' => 74,
			'OperatorVoid' => 73,
			'PAREN-34' => 75
		}
	},
	{#State 65
		ACTIONS => {
			")" => 117,
			'WORD' => 118
		}
	},
	{#State 66
		DEFAULT => -38
	},
	{#State 67
		ACTIONS => {
			"= sub {" => 119
		}
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			"my" => 120
		},
		GOTOS => {
			'TypeInnerConstant' => 121
		}
	},
	{#State 70
		ACTIONS => {
			"use constant" => -54,
			"## no critic qw(" => 9,
			"use" => -54,
			"our hash_ref \$properties" => -54
		},
		GOTOS => {
			'Critic' => 123,
			'STAR-21' => 122
		}
	},
	{#State 71
		ACTIONS => {
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP13_BITWISE_AND' => 125,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP17_LIST_RANGE' => 134,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_STRING_REPEAT' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			'OP23_LOGICAL_AND' => 137,
			'OP08_MATH_ADD_SUB' => 129,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP04_MATH_POW' => 140,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139
		}
	},
	{#State 72
		DEFAULT => -140
	},
	{#State 73
		DEFAULT => -142
	},
	{#State 74
		DEFAULT => -77
	},
	{#State 75
		DEFAULT => -138
	},
	{#State 76
		ACTIONS => {
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111
		},
		GOTOS => {
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'Expression' => 143,
			'Variable' => 144,
			'SubExpression' => 142,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Operator' => 107,
			'WordScoped' => 82
		}
	},
	{#State 77
		ACTIONS => {
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 83,
			'' => -18,
			"for" => -139,
			'WORD' => 26,
			'OP19_LOOP_CONTROL' => 81,
			'OP01_NAMED_VOID_SCOLON' => 79,
			'OP05_MATH_NEG_LPAREN' => 76,
			"while" => -139,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'OP01_PRINT' => 113,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 101,
			'OP01_NAMED' => 100,
			'OP01_OPEN' => 103,
			"my" => 98,
			'LITERAL_STRING' => 96,
			"if" => 95,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP19_LOOP_CONTROL_SCOLON' => 92,
			"foreach" => -139,
			'OP01_NAMED_VOID' => 91,
			'OP01_CLOSE' => 89
		},
		GOTOS => {
			'VariableModification' => 84,
			'Literal' => 114,
			'HashDereference' => 112,
			'VariableDeclaration' => 86,
			'Variable' => 108,
			'ArrayDereference' => 80,
			'LoopLabel' => 106,
			'Operator' => 107,
			'WordScoped' => 82,
			'OPTIONAL-35' => 102,
			'ArrayReference' => 99,
			'Operation' => 146,
			'Expression' => 78,
			'Conditional' => 72,
			'SubExpression' => 71,
			'HashReference' => 90,
			'OperatorVoid' => 73,
			'Statement' => 74,
			'PAREN-34' => 75
		}
	},
	{#State 78
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP18_TERNARY' => -126,
			'OP08_STRING_CAT' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			";" => 147,
			'OP04_MATH_POW' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP11_COMPARE_LT_GT' => -126
		}
	},
	{#State 79
		DEFAULT => -112
	},
	{#State 80
		DEFAULT => -131
	},
	{#State 81
		ACTIONS => {
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'LoopLabel' => 148
		}
	},
	{#State 82
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 150,
			'LPAREN' => 151
		}
	},
	{#State 83
		ACTIONS => {
			'COLON' => -202,
			'LPAREN' => 152
		}
	},
	{#State 84
		DEFAULT => -144
	},
	{#State 85
		DEFAULT => -210
	},
	{#State 86
		DEFAULT => -143
	},
	{#State 87
		DEFAULT => -14
	},
	{#State 88
		ACTIONS => {
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'OP01_QW' => 156,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"my" => 157,
			'OP05_LOGICAL_NEG' => 104,
			"]" => -181,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94
		},
		GOTOS => {
			'SubExpression' => 155,
			'Variable' => 144,
			'HashReference' => 90,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'ListElement' => 158,
			'WordScoped' => 82,
			'TypeInner' => 154,
			'OPTIONAL-45' => 159,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'ListElements' => 153,
			'Expression' => 143
		}
	},
	{#State 89
		ACTIONS => {
			'FH_REF_SYMBOL' => 160
		}
	},
	{#State 90
		DEFAULT => -132
	},
	{#State 91
		ACTIONS => {
			'OP01_QW' => 156,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"my" => 157,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'ListElements' => 161,
			'Expression' => 143,
			'SubExpression' => 155,
			'Variable' => 144,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'ListElement' => 158,
			'WordScoped' => 82,
			'TypeInner' => 154
		}
	},
	{#State 92
		DEFAULT => -115
	},
	{#State 93
		ACTIONS => {
			'LBRACKET' => 88,
			'OP16_LOGICAL_OR' => -95,
			'LITERAL_NUMBER' => 85,
			'OP07_STRING_REPEAT' => -95,
			'WORD_UPPERCASE' => 141,
			'OP13_BITWISE_AND' => -95,
			'WORD' => 26,
			'OP09_BITWISE_SHIFT' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			")" => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP15_LOGICAL_AND' => -95,
			"}" => -95,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'OP12_COMPARE_EQ_NE' => -95,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'OP17_LIST_RANGE' => -95,
			'OP06_REGEX_MATCH' => -95,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'OP21_LIST_COMMA' => -95,
			'OP08_STRING_CAT' => -95,
			'OP18_TERNARY' => -95,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 104,
			'OP04_MATH_POW' => -95,
			"]" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP23_LOGICAL_AND' => -95,
			";" => -95,
			'LITERAL_STRING' => 96,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'OP11_COMPARE_LT_GT' => -95
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'Expression' => 143,
			'SubExpression' => 162,
			'Variable' => 144,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'WordScoped' => 82
		}
	},
	{#State 94
		ACTIONS => {
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'Variable' => 144,
			'SubExpression' => 163,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'WordScoped' => 82,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'Expression' => 143
		}
	},
	{#State 95
		ACTIONS => {
			'LPAREN' => 164
		}
	},
	{#State 96
		DEFAULT => -209
	},
	{#State 97
		DEFAULT => -17
	},
	{#State 98
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 165
		}
	},
	{#State 99
		DEFAULT => -130
	},
	{#State 100
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			"my" => 157
		},
		GOTOS => {
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'Expression' => 143,
			'SubExpression' => 166,
			'Variable' => 144,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Operator' => 107,
			'ListElement' => 167,
			'WordScoped' => 82,
			'TypeInner' => 154
		}
	},
	{#State 101
		ACTIONS => {
			"my" => 157,
			'VARIABLE_SYMBOL' => 115,
			'LBRACKET' => -184
		},
		GOTOS => {
			'Variable' => 170,
			'TypeInner' => 169,
			'OPTIONAL-46' => 168
		}
	},
	{#State 102
		ACTIONS => {
			"foreach" => 175,
			"for" => 177,
			"while" => 173
		},
		GOTOS => {
			'LoopFor' => 174,
			'LoopForEach' => 172,
			'LoopWhile' => 171,
			'Loop' => 176
		}
	},
	{#State 103
		ACTIONS => {
			"my" => 178
		}
	},
	{#State 104
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 141,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114,
			'Expression' => 143,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'SubExpression' => 179,
			'Variable' => 144,
			'WordScoped' => 82
		}
	},
	{#State 105
		DEFAULT => -127
	},
	{#State 106
		ACTIONS => {
			'COLON' => 180
		}
	},
	{#State 107
		DEFAULT => -121
	},
	{#State 108
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 181,
			'OP19_VARIABLE_ASSIGN_BY' => 183,
			'OP15_LOGICAL_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP04_MATH_POW' => -129,
			'OP02_METHOD_THINARROW' => 182,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP03_MATH_INC_DEC' => 184,
			'OP17_LIST_RANGE' => -129,
			'OP08_STRING_CAT' => -129,
			'OP18_TERNARY' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP12_COMPARE_EQ_NE' => -129
		}
	},
	{#State 109
		ACTIONS => {
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 185,
			'HashReference' => 186
		}
	},
	{#State 110
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 187
		}
	},
	{#State 111
		ACTIONS => {
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'OP01_PRINT' => 188,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 189,
			"\@{" => 101,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94
		},
		GOTOS => {
			'Expression' => 143,
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'WordScoped' => 82,
			'Variable' => 144,
			'SubExpression' => 190,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80
		}
	},
	{#State 112
		DEFAULT => -133
	},
	{#State 113
		ACTIONS => {
			'LPAREN' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'WORD' => -109,
			"%{" => -109,
			'WORD_SCOPED' => -109,
			"undef" => -109,
			'OP01_QW' => -109,
			'LBRACKET' => -109,
			'LITERAL_NUMBER' => -109,
			'LBRACE' => -109,
			'VARIABLE_SYMBOL' => -109,
			'WORD_UPPERCASE' => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'OP01_CLOSE' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'STDOUT_STDERR' => 193,
			'FH_REF_SYMBOL_BRACES' => 194,
			'OP01_NAMED' => -109,
			'OP01_OPEN' => -109,
			"\@{" => -109,
			"my" => -109,
			'LITERAL_STRING' => -109,
			'OP05_MATH_NEG_LPAREN' => -109
		},
		GOTOS => {
			'PAREN-30' => 192,
			'OPTIONAL-31' => 191
		}
	},
	{#State 114
		DEFAULT => -128
	},
	{#State 115
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 195
		}
	},
	{#State 116
		ACTIONS => {
			"}" => 198,
			'WORD' => 197,
			"%{" => 109
		},
		GOTOS => {
			'HashEntry' => 196,
			'HashDereference' => 199
		}
	},
	{#State 117
		ACTIONS => {
			";" => 200
		}
	},
	{#State 118
		DEFAULT => -37
	},
	{#State 119
		ACTIONS => {
			'LITERAL_STRING' => -43,
			'OP01_OPEN' => -43,
			"\@{" => -43,
			'OP01_NAMED' => -43,
			"my" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_CLOSE' => -43,
			'OP01_NAMED_VOID' => -43,
			"foreach" => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			"if" => -43,
			'OP01_PRINT' => -43,
			'LBRACE' => -43,
			'VARIABLE_SYMBOL' => -43,
			"while" => -43,
			'LPAREN_MY' => 203,
			"undef" => -43,
			"%{" => -43,
			'WORD_SCOPED' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'LPAREN' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'WORD_UPPERCASE' => -43,
			'LITERAL_NUMBER' => -43,
			'LBRACKET' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'WORD' => -43,
			"for" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 201,
			'OPTIONAL-16' => 202
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 121
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'Literal' => 205
		}
	},
	{#State 122
		ACTIONS => {
			"use" => 36,
			"our hash_ref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 206,
			'STAR-22' => 207
		}
	},
	{#State 123
		DEFAULT => -51
	},
	{#State 124
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111
		},
		GOTOS => {
			'WordScoped' => 82,
			'HashReference' => 90,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'SubExpression' => 208,
			'Variable' => 144,
			'Expression' => 143,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99
		}
	},
	{#State 125
		ACTIONS => {
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'ArrayDereference' => 80,
			'Operator' => 107,
			'HashReference' => 90,
			'SubExpression' => 209,
			'Variable' => 144,
			'WordScoped' => 82,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'Expression' => 143
		}
	},
	{#State 126
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP05_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89
		},
		GOTOS => {
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114,
			'Expression' => 143,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'SubExpression' => 210,
			'Variable' => 144,
			'WordScoped' => 82
		}
	},
	{#State 127
		ACTIONS => {
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			"undef" => 105,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93
		},
		GOTOS => {
			'Expression' => 143,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'WordScoped' => 82,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'HashReference' => 90,
			'Variable' => 144,
			'SubExpression' => 211
		}
	},
	{#State 128
		ACTIONS => {
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'Expression' => 143,
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'WordScoped' => 82,
			'Variable' => 144,
			'SubExpression' => 212,
			'HashReference' => 90,
			'Operator' => 107,
			'ArrayDereference' => 80
		}
	},
	{#State 129
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			"undef" => 105
		},
		GOTOS => {
			'WordScoped' => 82,
			'Variable' => 144,
			'SubExpression' => 213,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Operator' => 107,
			'Expression' => 143,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112
		}
	},
	{#State 130
		ACTIONS => {
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 82,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'SubExpression' => 214,
			'Variable' => 144,
			'Expression' => 143,
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114
		}
	},
	{#State 131
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141
		},
		GOTOS => {
			'Variable' => 144,
			'SubExpression' => 215,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'WordScoped' => 82,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'Expression' => 143
		}
	},
	{#State 132
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 96,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 216,
			'Literal' => 218,
			'VariableOrLiteral' => 217
		}
	},
	{#State 133
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 219
		}
	},
	{#State 134
		ACTIONS => {
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP05_LOGICAL_NEG' => 104,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'Expression' => 143,
			'SubExpression' => 220,
			'Variable' => 144,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'WordScoped' => 82
		}
	},
	{#State 135
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 141,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"\@{" => 101
		},
		GOTOS => {
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'Expression' => 143,
			'Variable' => 144,
			'SubExpression' => 221,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'WordScoped' => 82
		}
	},
	{#State 136
		ACTIONS => {
			'WORD_UPPERCASE' => 141,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			"undef" => 105,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94
		},
		GOTOS => {
			'WordScoped' => 82,
			'Variable' => 144,
			'SubExpression' => 222,
			'HashReference' => 90,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'Expression' => 143,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112
		}
	},
	{#State 137
		ACTIONS => {
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'WordScoped' => 82,
			'Variable' => 144,
			'SubExpression' => 223,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Expression' => 143,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112
		}
	},
	{#State 138
		ACTIONS => {
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89
		},
		GOTOS => {
			'Expression' => 143,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'WordScoped' => 82,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Operator' => 107,
			'Variable' => 144,
			'SubExpression' => 224
		}
	},
	{#State 139
		ACTIONS => {
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP05_LOGICAL_NEG' => 104,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			'WORD_UPPERCASE' => 141,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88
		},
		GOTOS => {
			'ArrayDereference' => 80,
			'Operator' => 107,
			'HashReference' => 90,
			'Variable' => 144,
			'SubExpression' => 225,
			'WordScoped' => 82,
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114,
			'Expression' => 143
		}
	},
	{#State 140
		ACTIONS => {
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP05_LOGICAL_NEG' => 104,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88
		},
		GOTOS => {
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'SubExpression' => 226,
			'Variable' => 144,
			'WordScoped' => 82,
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114,
			'Expression' => 143
		}
	},
	{#State 141
		ACTIONS => {
			'LPAREN' => 152
		}
	},
	{#State 142
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_STRING_REPEAT' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP13_BITWISE_AND' => 125,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => 137,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			")" => 227,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP04_MATH_POW' => 140,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128
		}
	},
	{#State 143
		DEFAULT => -126
	},
	{#State 144
		ACTIONS => {
			'OP21_LIST_COMMA' => -129,
			'OP18_TERNARY' => -129,
			'OP08_STRING_CAT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP03_MATH_INC_DEC' => 184,
			'OP09_BITWISE_SHIFT' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP07_STRING_REPEAT' => -129,
			"}" => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			";" => -129,
			'OP04_MATH_POW' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			"]" => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			")" => -129,
			'OP02_METHOD_THINARROW' => 182
		}
	},
	{#State 145
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89
		},
		GOTOS => {
			'Expression' => 143,
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114,
			'WordScoped' => 82,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Variable' => 144,
			'SubExpression' => 228
		}
	},
	{#State 146
		DEFAULT => -16
	},
	{#State 147
		DEFAULT => -76
	},
	{#State 148
		ACTIONS => {
			";" => 229
		}
	},
	{#State 149
		DEFAULT => -202
	},
	{#State 150
		ACTIONS => {
			")" => 230
		}
	},
	{#State 151
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'OP01_QW' => 156,
			'LBRACKET' => 88,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			")" => -118,
			'OP05_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"my" => 157,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89
		},
		GOTOS => {
			'ListElements' => 232,
			'Expression' => 143,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'OPTIONAL-32' => 231,
			'WordScoped' => 82,
			'ListElement' => 158,
			'TypeInner' => 154,
			'Variable' => 144,
			'SubExpression' => 155,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Operator' => 107
		}
	},
	{#State 152
		ACTIONS => {
			")" => 233
		}
	},
	{#State 153
		DEFAULT => -180
	},
	{#State 154
		ACTIONS => {
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76
		},
		GOTOS => {
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114,
			'Expression' => 143,
			'HashReference' => 90,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'SubExpression' => 234,
			'Variable' => 144,
			'WordScoped' => 82
		}
	},
	{#State 155
		ACTIONS => {
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP21_LIST_COMMA' => -177,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP17_LIST_RANGE' => 134,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_STRING_REPEAT' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128,
			";" => -177,
			'OP23_LOGICAL_AND' => 137,
			'OP08_MATH_ADD_SUB' => 129,
			'OP14_BITWISE_OR_XOR' => 138,
			")" => -177,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP24_LOGICAL_OR_XOR' => 130,
			"]" => -177,
			'OP04_MATH_POW' => 140
		}
	},
	{#State 156
		ACTIONS => {
			'WORD' => 236
		},
		GOTOS => {
			'PLUS-44' => 235
		}
	},
	{#State 157
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 237
		}
	},
	{#State 158
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 238
		}
	},
	{#State 159
		ACTIONS => {
			"]" => 239
		}
	},
	{#State 160
		DEFAULT => -82
	},
	{#State 161
		ACTIONS => {
			";" => 240
		}
	},
	{#State 162
		ACTIONS => {
			'OP13_BITWISE_AND' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP21_LIST_COMMA' => -94,
			'OP18_TERNARY' => -94,
			'OP08_STRING_CAT' => 131,
			'OP16_LOGICAL_OR' => -94,
			'OP07_STRING_REPEAT' => 126,
			"}" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP04_MATH_POW' => 140,
			"]" => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			")" => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -94,
			";" => -94
		}
	},
	{#State 163
		ACTIONS => {
			'OP13_BITWISE_AND' => 125,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP21_LIST_COMMA' => -104,
			'OP07_STRING_REPEAT' => 126,
			"}" => -104,
			'OP16_LOGICAL_OR' => 127,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			"]" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP04_MATH_POW' => 140,
			'OP14_BITWISE_OR_XOR' => 138,
			")" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -104,
			";" => -104
		}
	},
	{#State 164
		ACTIONS => {
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			"undef" => 105,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'Expression' => 143,
			'SubExpression' => 241,
			'Variable' => 144,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'HashReference' => 90,
			'WordScoped' => 82
		}
	},
	{#State 165
		ACTIONS => {
			'VARIABLE_SYMBOL' => 242
		}
	},
	{#State 166
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -79,
			")" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP04_MATH_POW' => -79,
			";" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP18_TERNARY' => -79,
			'OP08_STRING_CAT' => -79,
			'OP21_LIST_COMMA' => -177
		}
	},
	{#State 167
		ACTIONS => {
			'OP21_LIST_COMMA' => 243
		}
	},
	{#State 168
		ACTIONS => {
			'LBRACKET' => 88
		},
		GOTOS => {
			'ArrayReference' => 244
		}
	},
	{#State 169
		DEFAULT => -183
	},
	{#State 170
		ACTIONS => {
			"}" => 245
		}
	},
	{#State 171
		DEFAULT => -154
	},
	{#State 172
		DEFAULT => -153
	},
	{#State 173
		ACTIONS => {
			'LPAREN' => 246
		}
	},
	{#State 174
		DEFAULT => -152
	},
	{#State 175
		ACTIONS => {
			"my" => 247
		}
	},
	{#State 176
		DEFAULT => -141
	},
	{#State 177
		ACTIONS => {
			"my" => 248
		}
	},
	{#State 178
		ACTIONS => {
			"filehandle_ref" => 249
		}
	},
	{#State 179
		ACTIONS => {
			'OP07_STRING_REPEAT' => -86,
			"}" => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP18_TERNARY' => -86,
			'OP08_STRING_CAT' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			"]" => -86,
			'OP04_MATH_POW' => 140,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			")" => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			";" => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP11_COMPARE_LT_GT' => -86
		}
	},
	{#State 180
		DEFAULT => -137
	},
	{#State 181
		ACTIONS => {
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			"undef" => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 141,
			'STDIN' => 251,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'Expression' => 143,
			'SubExpression' => 252,
			'Variable' => 144,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'WordScoped' => 82,
			'SubExpressionOrStdin' => 250
		}
	},
	{#State 182
		ACTIONS => {
			'LPAREN' => 253
		}
	},
	{#State 183
		ACTIONS => {
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP05_LOGICAL_NEG' => 104,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'Expression' => 143,
			'SubExpression' => 254,
			'Variable' => 144,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'WordScoped' => 82
		}
	},
	{#State 184
		DEFAULT => -84
	},
	{#State 185
		ACTIONS => {
			"}" => 255
		}
	},
	{#State 186
		ACTIONS => {
			"}" => 256
		}
	},
	{#State 187
		DEFAULT => -83
	},
	{#State 188
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 257
		}
	},
	{#State 189
		ACTIONS => {
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			"undef" => 105,
			'OP01_QW' => 156,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			"my" => 157,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'ListElement' => 258,
			'WordScoped' => 82,
			'TypeInner' => 154,
			'SubExpression' => 166,
			'Variable' => 144,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Operator' => 107,
			'Expression' => 143,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112
		}
	},
	{#State 190
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => 137,
			")" => 259,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => 132,
			'OP17_LIST_RANGE' => 134,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP13_BITWISE_AND' => 125
		}
	},
	{#State 191
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'OP01_QW' => 156,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"my" => 157,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93
		},
		GOTOS => {
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Variable' => 144,
			'SubExpression' => 155,
			'TypeInner' => 154,
			'WordScoped' => 82,
			'ListElement' => 158,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'Expression' => 143,
			'ListElements' => 260
		}
	},
	{#State 192
		DEFAULT => -108
	},
	{#State 193
		DEFAULT => -107
	},
	{#State 194
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			"my" => 157,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'LITERAL_NUMBER' => 85,
			'OP01_QW' => 156,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109
		},
		GOTOS => {
			'TypeInner' => 154,
			'WordScoped' => 82,
			'ListElement' => 158,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Variable' => 144,
			'SubExpression' => 155,
			'Expression' => 143,
			'ListElements' => 261,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99
		}
	},
	{#State 195
		ACTIONS => {
			'OP13_BITWISE_AND' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP02_HASH_THINARROW' => 263,
			'COLON' => -163,
			'OP08_STRING_CAT' => -163,
			'OP18_TERNARY' => -163,
			'OP21_LIST_COMMA' => -163,
			"}" => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP02_ARRAY_THINARROW' => 262,
			'OP16_LOGICAL_OR' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			"]" => -163,
			'OP04_MATH_POW' => -163,
			'OP02_METHOD_THINARROW' => -163,
			")" => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP23_LOGICAL_AND' => -163,
			";" => -163
		},
		GOTOS => {
			'VariableRetrieval' => 264
		}
	},
	{#State 196
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 265
		}
	},
	{#State 197
		ACTIONS => {
			'OP20_HASH_FATARROW' => 266
		}
	},
	{#State 198
		DEFAULT => -197
	},
	{#State 199
		DEFAULT => -190
	},
	{#State 200
		DEFAULT => -40
	},
	{#State 201
		DEFAULT => -42
	},
	{#State 202
		ACTIONS => {
			'OP01_NAMED_VOID' => 91,
			"foreach" => -139,
			'OP01_CLOSE' => 89,
			"if" => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 92,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			"my" => 98,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 100,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP19_LOOP_CONTROL' => 81,
			'OP01_NAMED_VOID_SCOLON' => 79,
			"undef" => 105,
			'LPAREN' => 111,
			"for" => -139,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'WORD_UPPERCASE' => 83,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'OP01_PRINT' => 113,
			'LBRACKET' => 88,
			"while" => -139,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'VariableDeclaration' => 86,
			'Literal' => 114,
			'VariableModification' => 84,
			'HashDereference' => 112,
			'WordScoped' => 82,
			'Variable' => 108,
			'Operator' => 107,
			'LoopLabel' => 106,
			'ArrayDereference' => 80,
			'Expression' => 78,
			'ArrayReference' => 99,
			'OPTIONAL-35' => 102,
			'Operation' => 268,
			'OperatorVoid' => 73,
			'Statement' => 74,
			'PAREN-34' => 75,
			'SubExpression' => 71,
			'Conditional' => 72,
			'PLUS-17' => 267,
			'HashReference' => 90
		}
	},
	{#State 203
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 269
		}
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
		DEFAULT => -53
	},
	{#State 207
		ACTIONS => {
			"our hash_ref \$properties" => 274,
			"use constant" => 47
		},
		GOTOS => {
			'Constant' => 273,
			'Properties' => 272
		}
	},
	{#State 208
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			")" => -93,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			"]" => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP04_MATH_POW' => 140,
			";" => -93,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => -93,
			'OP21_LIST_COMMA' => -93,
			"}" => -93,
			'OP07_STRING_REPEAT' => 126,
			'OP16_LOGICAL_OR' => -93,
			'OP12_COMPARE_EQ_NE' => -93
		}
	},
	{#State 209
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 135,
			'OP16_LOGICAL_OR' => -98,
			'OP07_STRING_REPEAT' => 126,
			"}" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP13_BITWISE_AND' => -98,
			";" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP08_MATH_ADD_SUB' => 129,
			")" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP04_MATH_POW' => 140,
			"]" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => -98
		}
	},
	{#State 210
		ACTIONS => {
			'OP07_STRING_REPEAT' => -89,
			"}" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP08_STRING_CAT' => -89,
			'OP18_TERNARY' => -89,
			'OP21_LIST_COMMA' => -89,
			"]" => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP04_MATH_POW' => 140,
			")" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP23_LOGICAL_AND' => -89,
			";" => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89
		}
	},
	{#State 211
		ACTIONS => {
			'OP13_BITWISE_AND' => 125,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP17_LIST_RANGE' => -101,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP07_STRING_REPEAT' => 126,
			"}" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			"]" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP04_MATH_POW' => 140,
			")" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -101,
			";" => -101
		}
	},
	{#State 212
		ACTIONS => {
			'OP21_LIST_COMMA' => -100,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP16_LOGICAL_OR' => -100,
			'OP07_STRING_REPEAT' => 126,
			"}" => -100,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => -100,
			";" => -100,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -100,
			")" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -100,
			"]" => -100
		}
	},
	{#State 213
		ACTIONS => {
			'OP15_LOGICAL_AND' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP04_MATH_POW' => 140,
			"]" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			")" => -91,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP08_MATH_ADD_SUB' => -91,
			'OP23_LOGICAL_AND' => -91,
			";" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP08_STRING_CAT' => -91,
			'OP18_TERNARY' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP07_STRING_REPEAT' => 126,
			"}" => -91,
			'OP12_COMPARE_EQ_NE' => -91
		}
	},
	{#State 214
		ACTIONS => {
			'OP16_LOGICAL_OR' => 127,
			"}" => -106,
			'OP07_STRING_REPEAT' => 126,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP17_LIST_RANGE' => 134,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP21_LIST_COMMA' => -106,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => 132,
			")" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -106,
			"]" => -106,
			";" => -106,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => 137,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128
		}
	},
	{#State 215
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -92,
			'OP15_LOGICAL_AND' => -92,
			";" => -92,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -92,
			")" => -92,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -92,
			"]" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP08_STRING_CAT' => -92,
			'OP18_TERNARY' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP07_STRING_REPEAT' => 126,
			"}" => -92
		}
	},
	{#State 216
		DEFAULT => -207
	},
	{#State 217
		ACTIONS => {
			'COLON' => 275
		}
	},
	{#State 218
		DEFAULT => -208
	},
	{#State 219
		DEFAULT => -88
	},
	{#State 220
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128,
			";" => -102,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -102,
			")" => -102,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -102,
			"]" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => -102,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126,
			"}" => -102
		}
	},
	{#State 221
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => -97,
			")" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP04_MATH_POW' => 140,
			"]" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			";" => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP08_MATH_ADD_SUB' => 129,
			'OP17_LIST_RANGE' => -97,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP13_BITWISE_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => -97,
			'OP16_LOGICAL_OR' => -97,
			"}" => -97,
			'OP07_STRING_REPEAT' => 126,
			'OP12_COMPARE_EQ_NE' => undef
		}
	},
	{#State 222
		ACTIONS => {
			'OP21_LIST_COMMA' => -96,
			'OP18_TERNARY' => -96,
			'OP08_STRING_CAT' => 131,
			'OP13_BITWISE_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP16_LOGICAL_OR' => -96,
			"}" => -96,
			'OP07_STRING_REPEAT' => 126,
			'OP15_LOGICAL_AND' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -96,
			'OP08_MATH_ADD_SUB' => 129,
			";" => -96,
			'OP04_MATH_POW' => 140,
			"]" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			")" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 139
		}
	},
	{#State 223
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128,
			";" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP08_MATH_ADD_SUB' => 129,
			")" => -105,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP04_MATH_POW' => 140,
			"]" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP17_LIST_RANGE' => 134,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126,
			"}" => -105
		}
	},
	{#State 224
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP08_MATH_ADD_SUB' => 129,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			")" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP04_MATH_POW' => 140,
			"]" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP16_LOGICAL_OR' => -99,
			'OP07_STRING_REPEAT' => 126,
			"}" => -99
		}
	},
	{#State 225
		ACTIONS => {
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -90,
			"]" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			")" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP23_LOGICAL_AND' => -90,
			";" => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP07_STRING_REPEAT' => 126,
			"}" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP06_REGEX_MATCH' => 133,
			'OP21_LIST_COMMA' => -90,
			'OP18_TERNARY' => -90,
			'OP08_STRING_CAT' => -90
		}
	},
	{#State 226
		ACTIONS => {
			";" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			")" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -85,
			"]" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP07_STRING_REPEAT' => -85,
			"}" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP18_TERNARY' => -85,
			'OP08_STRING_CAT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP13_BITWISE_AND' => -85
		}
	},
	{#State 227
		DEFAULT => -87
	},
	{#State 228
		ACTIONS => {
			'OP13_BITWISE_AND' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP08_STRING_CAT' => -79,
			'OP18_TERNARY' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP07_STRING_REPEAT' => -79,
			"}" => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP04_MATH_POW' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			"]" => -79,
			")" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP23_LOGICAL_AND' => -79,
			";" => -79
		}
	},
	{#State 229
		DEFAULT => -116
	},
	{#State 230
		DEFAULT => -125
	},
	{#State 231
		ACTIONS => {
			")" => 276
		}
	},
	{#State 232
		DEFAULT => -117
	},
	{#State 233
		DEFAULT => -123
	},
	{#State 234
		ACTIONS => {
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			'OP24_LOGICAL_OR_XOR' => 130,
			"]" => -178,
			'OP04_MATH_POW' => 140,
			'OP14_BITWISE_OR_XOR' => 138,
			")" => -178,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP23_LOGICAL_AND' => 137,
			'OP08_MATH_ADD_SUB' => 129,
			";" => -178,
			'OP13_BITWISE_AND' => 125,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => 132,
			'OP21_LIST_COMMA' => -178,
			'OP07_STRING_REPEAT' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP12_COMPARE_EQ_NE' => 135
		}
	},
	{#State 235
		ACTIONS => {
			")" => 278,
			'WORD' => 277
		}
	},
	{#State 236
		DEFAULT => -176
	},
	{#State 237
		ACTIONS => {
			"\$TYPED_" => 279
		}
	},
	{#State 238
		ACTIONS => {
			'OP21_LIST_COMMA' => 280,
			";" => -174,
			"]" => -174,
			")" => -174
		},
		GOTOS => {
			'PAREN-42' => 281
		}
	},
	{#State 239
		DEFAULT => -182
	},
	{#State 240
		DEFAULT => -113
	},
	{#State 241
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128,
			'OP14_BITWISE_OR_XOR' => 138,
			")" => 282,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP23_LOGICAL_AND' => 137,
			'OP08_MATH_ADD_SUB' => 129,
			'OP17_LIST_RANGE' => 134,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => 132,
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126,
			'OP12_COMPARE_EQ_NE' => 135
		}
	},
	{#State 242
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 284,
			";" => 283
		}
	},
	{#State 243
		ACTIONS => {
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'OP01_QW' => 156,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			"my" => 157,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'TypeInner' => 154,
			'WordScoped' => 82,
			'ListElement' => 158,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'HashReference' => 90,
			'Variable' => 144,
			'SubExpression' => 155,
			'Expression' => 143,
			'ListElements' => 285,
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114
		}
	},
	{#State 244
		ACTIONS => {
			"}" => 286
		}
	},
	{#State 245
		DEFAULT => -185
	},
	{#State 246
		ACTIONS => {
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP05_LOGICAL_NEG' => 104,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88
		},
		GOTOS => {
			'Expression' => 143,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'WordScoped' => 82,
			'SubExpression' => 287,
			'Variable' => 144,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80
		}
	},
	{#State 247
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 288
		}
	},
	{#State 248
		ACTIONS => {
			'TYPE_INTEGER' => 289
		}
	},
	{#State 249
		ACTIONS => {
			'FH_REF_SYMBOL' => 290
		}
	},
	{#State 250
		ACTIONS => {
			";" => 291
		}
	},
	{#State 251
		DEFAULT => -136
	},
	{#State 252
		ACTIONS => {
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP04_MATH_POW' => 140,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => 137,
			";" => -135,
			'OP13_BITWISE_AND' => 125,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP17_LIST_RANGE' => 134,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => 132,
			'OP07_STRING_REPEAT' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP12_COMPARE_EQ_NE' => 135
		}
	},
	{#State 253
		ACTIONS => {
			")" => -120,
			'OP05_LOGICAL_NEG' => 104,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			"my" => 157,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'OP01_QW' => 156,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ListElement' => 158,
			'WordScoped' => 82,
			'TypeInner' => 154,
			'SubExpression' => 155,
			'Variable' => 144,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'ListElements' => 293,
			'Expression' => 143,
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'OPTIONAL-33' => 292
		}
	},
	{#State 254
		ACTIONS => {
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP13_BITWISE_AND' => 125,
			'OP17_LIST_RANGE' => 134,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP23_LOGICAL_AND' => 137,
			'OP08_MATH_ADD_SUB' => 129,
			";" => 294,
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136
		}
	},
	{#State 255
		DEFAULT => -198
	},
	{#State 256
		DEFAULT => -199
	},
	{#State 257
		ACTIONS => {
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			"my" => 157,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LBRACKET' => 88,
			'OP01_QW' => 156,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141
		},
		GOTOS => {
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'Expression' => 143,
			'ListElements' => 295,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'HashReference' => 90,
			'Variable' => 144,
			'SubExpression' => 155,
			'TypeInner' => 154,
			'ListElement' => 158,
			'WordScoped' => 82
		}
	},
	{#State 258
		ACTIONS => {
			'OP21_LIST_COMMA' => 296
		}
	},
	{#State 259
		DEFAULT => -134
	},
	{#State 260
		ACTIONS => {
			";" => 297
		}
	},
	{#State 261
		ACTIONS => {
			";" => 298
		}
	},
	{#State 262
		ACTIONS => {
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			"undef" => 105,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94
		},
		GOTOS => {
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'Expression' => 143,
			'SubExpression' => 299,
			'Variable' => 144,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Operator' => 107,
			'WordScoped' => 82
		}
	},
	{#State 263
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'LPAREN' => 111,
			'WORD' => 300,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105
		},
		GOTOS => {
			'WordScoped' => 82,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Variable' => 144,
			'SubExpression' => 301,
			'Expression' => 143,
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114
		}
	},
	{#State 264
		DEFAULT => -161
	},
	{#State 265
		ACTIONS => {
			'OP21_LIST_COMMA' => 302,
			"}" => 303
		},
		GOTOS => {
			'PAREN-48' => 304
		}
	},
	{#State 266
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -188,
			'OP10_NAMED_UNARY' => -188,
			'OP01_CLOSE' => -188,
			'OP05_LOGICAL_NEG' => -188,
			'LITERAL_STRING' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'OP01_NAMED' => -188,
			'OP01_OPEN' => -188,
			"\@{" => -188,
			"my" => 157,
			'OP03_MATH_INC_DEC' => -188,
			'WORD' => -188,
			'LPAREN' => -188,
			"undef" => -188,
			"%{" => -188,
			'WORD_SCOPED' => -188,
			'LITERAL_NUMBER' => -188,
			'LBRACKET' => -188,
			'LBRACE' => -188,
			'VARIABLE_SYMBOL' => -188,
			'WORD_UPPERCASE' => -188
		},
		GOTOS => {
			'TypeInner' => 305,
			'OPTIONAL-47' => 306
		}
	},
	{#State 267
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 81,
			'OP01_NAMED_VOID_SCOLON' => 79,
			"for" => -139,
			'WORD' => 26,
			'WORD_UPPERCASE' => 83,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 76,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'OP01_PRINT' => 113,
			"while" => -139,
			"}" => 307,
			'OP01_NAMED_VOID' => 91,
			"foreach" => -139,
			'OP01_CLOSE' => 89,
			"if" => 95,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 92,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP01_NAMED' => 100,
			"my" => 98,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'VariableDeclaration' => 86,
			'VariableModification' => 84,
			'Literal' => 114,
			'HashDereference' => 112,
			'WordScoped' => 82,
			'Variable' => 108,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'LoopLabel' => 106,
			'Expression' => 78,
			'OPTIONAL-35' => 102,
			'ArrayReference' => 99,
			'Operation' => 308,
			'OperatorVoid' => 73,
			'PAREN-34' => 75,
			'Statement' => 74,
			'SubExpression' => 71,
			'Conditional' => 72,
			'HashReference' => 90
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
		ACTIONS => {
			'WORD_UPPERCASE' => 310
		}
	},
	{#State 271
		DEFAULT => -41
	},
	{#State 272
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 311
		}
	},
	{#State 273
		DEFAULT => -55
	},
	{#State 274
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 275
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'VariableOrLiteral' => 313,
			'Literal' => 218,
			'Variable' => 216
		}
	},
	{#State 276
		DEFAULT => -122
	},
	{#State 277
		DEFAULT => -175
	},
	{#State 278
		DEFAULT => -179
	},
	{#State 279
		ACTIONS => {
			'WORD' => 314
		}
	},
	{#State 280
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			"my" => 157,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'LBRACKET' => 88,
			'OP01_QW' => 156,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			"undef" => 105
		},
		GOTOS => {
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'SubExpression' => 155,
			'Variable' => 144,
			'TypeInner' => 154,
			'WordScoped' => 82,
			'ListElement' => 315,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'Expression' => 143
		}
	},
	{#State 281
		DEFAULT => -172
	},
	{#State 282
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 317
		}
	},
	{#State 283
		DEFAULT => -167
	},
	{#State 284
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 141,
			'STDIN' => 251,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109
		},
		GOTOS => {
			'Variable' => 144,
			'SubExpression' => 252,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Operator' => 107,
			'WordScoped' => 82,
			'SubExpressionOrStdin' => 318,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'Expression' => 143
		}
	},
	{#State 285
		ACTIONS => {
			";" => 319
		}
	},
	{#State 286
		DEFAULT => -186
	},
	{#State 287
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128,
			'OP23_LOGICAL_AND' => 137,
			'OP08_MATH_ADD_SUB' => 129,
			")" => 320,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => 132,
			'OP17_LIST_RANGE' => 134,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126
		}
	},
	{#State 288
		ACTIONS => {
			'VARIABLE_SYMBOL' => 321
		}
	},
	{#State 289
		ACTIONS => {
			'VARIABLE_SYMBOL' => 322
		}
	},
	{#State 290
		ACTIONS => {
			'OP21_LIST_COMMA' => 323
		}
	},
	{#State 291
		DEFAULT => -169
	},
	{#State 292
		ACTIONS => {
			")" => 324
		}
	},
	{#State 293
		DEFAULT => -119
	},
	{#State 294
		DEFAULT => -170
	},
	{#State 295
		ACTIONS => {
			")" => 325
		}
	},
	{#State 296
		ACTIONS => {
			"\@{" => 101,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"my" => 157,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'OP01_QW' => 156,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'TypeInner' => 154,
			'WordScoped' => 82,
			'ListElement' => 158,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Variable' => 144,
			'SubExpression' => 155,
			'Expression' => 143,
			'ListElements' => 326,
			'HashDereference' => 112,
			'ArrayReference' => 99,
			'Literal' => 114
		}
	},
	{#State 297
		DEFAULT => -110
	},
	{#State 298
		DEFAULT => -111
	},
	{#State 299
		ACTIONS => {
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => 137,
			"]" => 327,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP04_MATH_POW' => 140,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP13_BITWISE_AND' => 125,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP17_LIST_RANGE' => 134,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_STRING_REPEAT' => 126,
			'OP16_LOGICAL_OR' => 127
		}
	},
	{#State 300
		ACTIONS => {
			'LPAREN' => -200,
			"}" => 328,
			'OP02_METHOD_THINARROW_NEW' => -200
		}
	},
	{#State 301
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => 137,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128,
			'OP16_LOGICAL_OR' => 127,
			"}" => 329,
			'OP07_STRING_REPEAT' => 126,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP17_LIST_RANGE' => 134,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP13_BITWISE_AND' => 125,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => 132
		}
	},
	{#State 302
		ACTIONS => {
			'WORD' => 197,
			"%{" => 109
		},
		GOTOS => {
			'HashEntry' => 330,
			'HashDereference' => 199
		}
	},
	{#State 303
		DEFAULT => -196
	},
	{#State 304
		DEFAULT => -194
	},
	{#State 305
		DEFAULT => -187
	},
	{#State 306
		ACTIONS => {
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 145,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26
		},
		GOTOS => {
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'Expression' => 143,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'SubExpression' => 331,
			'Variable' => 144,
			'WordScoped' => 82
		}
	},
	{#State 307
		ACTIONS => {
			";" => 332
		}
	},
	{#State 308
		DEFAULT => -44
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
			"our" => 337,
			'LITERAL_NUMBER' => 335
		},
		GOTOS => {
			'Subroutine' => 336,
			'MethodOrSubroutine' => 339,
			'Method' => 338
		}
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 340
		}
	},
	{#State 313
		DEFAULT => -103
	},
	{#State 314
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 341
		}
	},
	{#State 315
		DEFAULT => -171
	},
	{#State 316
		ACTIONS => {
			'OP01_PRINT' => 113,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 83,
			'LITERAL_NUMBER' => 85,
			"while" => -139,
			'LBRACKET' => 88,
			"undef" => 105,
			'OP01_NAMED_VOID_SCOLON' => 79,
			'OP19_LOOP_CONTROL' => 81,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			"for" => -139,
			'LPAREN' => 111,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 100,
			"\@{" => 101,
			"my" => 98,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			"foreach" => -139,
			'OP01_NAMED_VOID' => 91,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 92,
			"if" => 95
		},
		GOTOS => {
			'OperatorVoid' => 73,
			'Statement' => 74,
			'PAREN-34' => 75,
			'SubExpression' => 71,
			'Conditional' => 72,
			'HashReference' => 90,
			'PLUS-40' => 343,
			'Expression' => 78,
			'OPTIONAL-35' => 102,
			'ArrayReference' => 99,
			'Operation' => 342,
			'WordScoped' => 82,
			'Variable' => 108,
			'Operator' => 107,
			'LoopLabel' => 106,
			'ArrayDereference' => 80,
			'VariableDeclaration' => 86,
			'VariableModification' => 84,
			'Literal' => 114,
			'HashDereference' => 112
		}
	},
	{#State 317
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 344
		}
	},
	{#State 318
		ACTIONS => {
			";" => 345
		}
	},
	{#State 319
		DEFAULT => -114
	},
	{#State 320
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 346
		}
	},
	{#State 321
		ACTIONS => {
			'LPAREN' => 347
		}
	},
	{#State 322
		ACTIONS => {
			'LPAREN' => 348
		}
	},
	{#State 323
		ACTIONS => {
			'LITERAL_STRING' => 349
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
			")" => 350
		}
	},
	{#State 327
		DEFAULT => -164
	},
	{#State 328
		DEFAULT => -166
	},
	{#State 329
		DEFAULT => -165
	},
	{#State 330
		DEFAULT => -193
	},
	{#State 331
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_STRING_REPEAT' => 126,
			"}" => -189,
			'OP16_LOGICAL_OR' => 127,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP21_LIST_COMMA' => -189,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP17_LIST_RANGE' => 134,
			'OP13_BITWISE_AND' => 125,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP04_MATH_POW' => 140,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128
		}
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
			";" => 354
		}
	},
	{#State 336
		DEFAULT => -75
	},
	{#State 337
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55,
			'TYPE_METHOD' => 355
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 338
		DEFAULT => -74
	},
	{#State 339
		DEFAULT => -57
	},
	{#State 340
		ACTIONS => {
			"%{" => 109,
			"}" => 358,
			'WORD' => 356
		},
		GOTOS => {
			'HashEntryTyped' => 357,
			'HashDereference' => 359
		}
	},
	{#State 341
		DEFAULT => -205
	},
	{#State 342
		DEFAULT => -159
	},
	{#State 343
		ACTIONS => {
			"\@{" => 101,
			'OP01_NAMED' => 100,
			'OP01_OPEN' => 103,
			"my" => 98,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED_VOID' => 91,
			"foreach" => -139,
			'OP01_CLOSE' => 89,
			"if" => 95,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP19_LOOP_CONTROL_SCOLON' => 92,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'OP01_PRINT' => 113,
			"while" => -139,
			"}" => 361,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'OP05_MATH_NEG_LPAREN' => 76,
			'WORD_UPPERCASE' => 83,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'OP19_LOOP_CONTROL' => 81,
			'OP01_NAMED_VOID_SCOLON' => 79,
			"for" => -139,
			'WORD' => 26
		},
		GOTOS => {
			'Literal' => 114,
			'VariableModification' => 84,
			'HashDereference' => 112,
			'VariableDeclaration' => 86,
			'Variable' => 108,
			'LoopLabel' => 106,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'WordScoped' => 82,
			'ArrayReference' => 99,
			'OPTIONAL-35' => 102,
			'Operation' => 360,
			'Expression' => 78,
			'Conditional' => 72,
			'SubExpression' => 71,
			'HashReference' => 90,
			'OperatorVoid' => 73,
			'Statement' => 74,
			'PAREN-34' => 75
		}
	},
	{#State 344
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -150,
			'LBRACKET' => -150,
			'LITERAL_NUMBER' => -150,
			"else" => 362,
			'WORD_UPPERCASE' => -150,
			"for" => -150,
			'' => -150,
			'WORD' => -150,
			'OP19_LOOP_CONTROL' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP05_LOGICAL_NEG' => -150,
			"my" => -150,
			'OP01_OPEN' => -150,
			"\@{" => -150,
			'OP01_NAMED' => -150,
			'LITERAL_STRING' => -150,
			"elsif" => 365,
			"if" => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP01_NAMED_VOID' => -150,
			"foreach" => -150,
			'OP01_CLOSE' => -150,
			"while" => -150,
			"}" => -150,
			'VARIABLE_SYMBOL' => -150,
			'LBRACE' => -150,
			'OP01_PRINT' => -150,
			'LPAREN' => -150,
			'OP03_MATH_INC_DEC' => -150,
			'WORD_SCOPED' => -150,
			"%{" => -150,
			"undef" => -150
		},
		GOTOS => {
			'PAREN-36' => 364,
			'PAREN-38' => 366,
			'OPTIONAL-39' => 363
		}
	},
	{#State 345
		DEFAULT => -168
	},
	{#State 346
		DEFAULT => -157
	},
	{#State 347
		ACTIONS => {
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			"my" => 157,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LPAREN' => 111,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'OP01_QW' => 156,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141
		},
		GOTOS => {
			'TypeInner' => 154,
			'WordScoped' => 82,
			'ListElement' => 158,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Variable' => 144,
			'SubExpression' => 155,
			'Expression' => 143,
			'ListElements' => 367,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99
		}
	},
	{#State 348
		ACTIONS => {
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'WORD_UPPERCASE' => 141,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111
		},
		GOTOS => {
			'Expression' => 143,
			'Literal' => 114,
			'ArrayReference' => 99,
			'HashDereference' => 112,
			'WordScoped' => 82,
			'SubExpression' => 368,
			'Variable' => 144,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90
		}
	},
	{#State 349
		ACTIONS => {
			'OP21_LIST_COMMA' => 369
		}
	},
	{#State 350
		DEFAULT => -80
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
		DEFAULT => -59
	},
	{#State 355
		ACTIONS => {
			'VARIABLE_SYMBOL' => 372
		}
	},
	{#State 356
		ACTIONS => {
			'OP20_HASH_FATARROW' => 373
		}
	},
	{#State 357
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 374
		}
	},
	{#State 358
		ACTIONS => {
			";" => 375
		}
	},
	{#State 359
		DEFAULT => -192
	},
	{#State 360
		DEFAULT => -158
	},
	{#State 361
		DEFAULT => -160
	},
	{#State 362
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 376
		}
	},
	{#State 363
		DEFAULT => -151
	},
	{#State 364
		DEFAULT => -146
	},
	{#State 365
		ACTIONS => {
			'LPAREN' => 377
		}
	},
	{#State 366
		DEFAULT => -149
	},
	{#State 367
		ACTIONS => {
			")" => 378
		}
	},
	{#State 368
		ACTIONS => {
			'OP23_LOGICAL_AND' => 137,
			'OP08_MATH_ADD_SUB' => 129,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP13_BITWISE_AND' => 125,
			'OP17_LIST_RANGE' => 379,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133
		}
	},
	{#State 369
		ACTIONS => {
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			'WORD' => 26,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 141,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'OP01_CLOSE' => 89,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'Expression' => 143,
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'WordScoped' => 82,
			'SubExpression' => 380,
			'Variable' => 144,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80
		}
	},
	{#State 370
		ACTIONS => {
			"\@_;" => 381
		}
	},
	{#State 371
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 382
		}
	},
	{#State 372
		ACTIONS => {
			"= sub {" => 383
		}
	},
	{#State 373
		ACTIONS => {
			"my" => 157
		},
		GOTOS => {
			'TypeInner' => 384
		}
	},
	{#State 374
		ACTIONS => {
			"}" => 387,
			'OP21_LIST_COMMA' => 385
		},
		GOTOS => {
			'PAREN-24' => 386
		}
	},
	{#State 375
		DEFAULT => -64
	},
	{#State 376
		DEFAULT => -148
	},
	{#State 377
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'WORD_UPPERCASE' => 141,
			'LBRACE' => 116,
			'VARIABLE_SYMBOL' => 115,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"undef" => 105,
			'WORD_SCOPED' => 24,
			"%{" => 109
		},
		GOTOS => {
			'Expression' => 143,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'WordScoped' => 82,
			'HashReference' => 90,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'SubExpression' => 388,
			'Variable' => 144
		}
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 379
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			"\@{" => 101,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP01_CLOSE' => 89,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 88,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			'LPAREN' => 111,
			"undef" => 105,
			"%{" => 109,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Expression' => 143,
			'HashDereference' => 112,
			'Literal' => 114,
			'ArrayReference' => 99,
			'WordScoped' => 82,
			'Operator' => 107,
			'ArrayDereference' => 80,
			'HashReference' => 90,
			'Variable' => 144,
			'SubExpression' => 390
		}
	},
	{#State 380
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_STRING_REPEAT' => 126,
			"}" => -81,
			'OP16_LOGICAL_OR' => 127,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP21_LIST_COMMA' => -81,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP17_LIST_RANGE' => 134,
			'OP13_BITWISE_AND' => 125,
			";" => -81,
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => -81,
			")" => -81,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP24_LOGICAL_OR_XOR' => -81,
			"]" => -81,
			'OP04_MATH_POW' => 140,
			'OP11_COMPARE_LT_GT' => 136,
			'OP15_LOGICAL_AND' => 128
		}
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
		ACTIONS => {
			'OP10_NAMED_UNARY' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			"if" => -66,
			'OP01_CLOSE' => -66,
			'OP01_NAMED_VOID' => -66,
			"foreach" => -66,
			'OP05_LOGICAL_NEG' => -66,
			'LITERAL_STRING' => -66,
			'OP01_OPEN' => -66,
			"\@{" => -66,
			'OP01_NAMED' => -66,
			"my" => -66,
			'OP03_MATH_INC_DEC' => -66,
			'LPAREN' => -66,
			"undef" => -66,
			"%{" => -66,
			'WORD_SCOPED' => -66,
			"while" => -66,
			'LPAREN_MY' => 393,
			'OP01_PRINT' => -66,
			'LBRACE' => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'WORD' => -66,
			"for" => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'LITERAL_NUMBER' => -66,
			'LBRACKET' => -66,
			'WORD_UPPERCASE' => -66
		},
		GOTOS => {
			'MethodArguments' => 394,
			'OPTIONAL-26' => 392
		}
	},
	{#State 384
		ACTIONS => {
			'LPAREN' => 111,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 141,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP01_CLOSE' => 89,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 76,
			'LITERAL_STRING' => 96
		},
		GOTOS => {
			'Expression' => 143,
			'ArrayReference' => 99,
			'Literal' => 114,
			'HashDereference' => 112,
			'WordScoped' => 82,
			'Variable' => 144,
			'SubExpression' => 395,
			'Operator' => 107,
			'HashReference' => 90,
			'ArrayDereference' => 80
		}
	},
	{#State 385
		ACTIONS => {
			'WORD' => 356,
			"%{" => 109
		},
		GOTOS => {
			'HashEntryTyped' => 396,
			'HashDereference' => 359
		}
	},
	{#State 386
		DEFAULT => -61
	},
	{#State 387
		ACTIONS => {
			";" => 397
		}
	},
	{#State 388
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 129,
			'OP23_LOGICAL_AND' => 137,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP04_MATH_POW' => 140,
			'OP14_BITWISE_OR_XOR' => 138,
			")" => 398,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP07_STRING_REPEAT' => 126,
			'OP16_LOGICAL_OR' => 127,
			'OP08_STRING_CAT' => 131,
			'OP18_TERNARY' => 132,
			'OP13_BITWISE_AND' => 125,
			'OP09_BITWISE_SHIFT' => 124,
			'OP06_REGEX_MATCH' => 133,
			'OP17_LIST_RANGE' => 134
		}
	},
	{#State 389
		DEFAULT => -156
	},
	{#State 390
		ACTIONS => {
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => -102,
			")" => 399,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP23_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 129,
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP13_BITWISE_AND' => 125,
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP18_TERNARY' => -102,
			'OP08_STRING_CAT' => 131
		}
	},
	{#State 391
		DEFAULT => -47
	},
	{#State 392
		ACTIONS => {
			'OP01_NAMED' => 100,
			'OP01_OPEN' => 103,
			"\@{" => 101,
			"my" => 98,
			'LITERAL_STRING' => 96,
			'OP05_MATH_NEG_LPAREN' => 76,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_NAMED_VOID' => 91,
			"foreach" => -139,
			'OP01_CLOSE' => 89,
			"if" => 95,
			'OP22_LOGICAL_NEG' => 94,
			'OP10_NAMED_UNARY' => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 92,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'WORD_UPPERCASE' => 83,
			'OP01_PRINT' => 113,
			"while" => -139,
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			"%{" => 109,
			'OP19_LOOP_CONTROL' => 81,
			'WORD_SCOPED' => 24,
			'OP01_NAMED_VOID_SCOLON' => 79,
			"undef" => 105,
			'LPAREN' => 111,
			"for" => -139,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 110
		},
		GOTOS => {
			'HashDereference' => 112,
			'VariableModification' => 84,
			'Literal' => 114,
			'VariableDeclaration' => 86,
			'LoopLabel' => 106,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'Variable' => 108,
			'PLUS-27' => 401,
			'WordScoped' => 82,
			'Operation' => 400,
			'OPTIONAL-35' => 102,
			'ArrayReference' => 99,
			'Expression' => 78,
			'HashReference' => 90,
			'Conditional' => 72,
			'SubExpression' => 71,
			'PAREN-34' => 75,
			'OperatorVoid' => 73,
			'Statement' => 74
		}
	},
	{#State 393
		ACTIONS => {
			'TYPE_SELF' => 402
		}
	},
	{#State 394
		DEFAULT => -65
	},
	{#State 395
		ACTIONS => {
			'OP13_BITWISE_AND' => 125,
			'OP17_LIST_RANGE' => 134,
			'OP06_REGEX_MATCH' => 133,
			'OP09_BITWISE_SHIFT' => 124,
			'OP21_LIST_COMMA' => -191,
			'OP18_TERNARY' => 132,
			'OP08_STRING_CAT' => 131,
			'OP16_LOGICAL_OR' => 127,
			'OP07_STRING_REPEAT' => 126,
			"}" => -191,
			'OP12_COMPARE_EQ_NE' => 135,
			'OP15_LOGICAL_AND' => 128,
			'OP11_COMPARE_LT_GT' => 136,
			'OP04_MATH_POW' => 140,
			'OP24_LOGICAL_OR_XOR' => 130,
			'OP07_MATH_MULT_DIV_MOD' => 139,
			'OP14_BITWISE_OR_XOR' => 138,
			'OP23_LOGICAL_AND' => 137,
			'OP08_MATH_ADD_SUB' => 129
		}
	},
	{#State 396
		DEFAULT => -60
	},
	{#State 397
		DEFAULT => -63
	},
	{#State 398
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 403
		}
	},
	{#State 399
		ACTIONS => {
			'LBRACE' => 316
		},
		GOTOS => {
			'CodeBlock' => 404
		}
	},
	{#State 400
		DEFAULT => -68
	},
	{#State 401
		ACTIONS => {
			'LBRACKET' => 88,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 83,
			"for" => -139,
			'WORD' => 26,
			'OP19_LOOP_CONTROL' => 81,
			'OP01_NAMED_VOID_SCOLON' => 79,
			'OP05_MATH_NEG_LPAREN' => 76,
			"while" => -139,
			"}" => 406,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 116,
			'OP01_PRINT' => 113,
			'LPAREN' => 111,
			'OP03_MATH_INC_DEC' => 110,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_OPEN' => 103,
			'OP01_NAMED' => 100,
			"\@{" => 101,
			"my" => 98,
			'LITERAL_STRING' => 96,
			"if" => 95,
			'OP10_NAMED_UNARY' => 93,
			'OP22_LOGICAL_NEG' => 94,
			'OP19_LOOP_CONTROL_SCOLON' => 92,
			'OP01_NAMED_VOID' => 91,
			"foreach" => -139,
			'OP01_CLOSE' => 89
		},
		GOTOS => {
			'Variable' => 108,
			'ArrayDereference' => 80,
			'Operator' => 107,
			'LoopLabel' => 106,
			'WordScoped' => 82,
			'VariableModification' => 84,
			'Literal' => 114,
			'HashDereference' => 112,
			'VariableDeclaration' => 86,
			'Conditional' => 72,
			'SubExpression' => 71,
			'HashReference' => 90,
			'PAREN-34' => 75,
			'OperatorVoid' => 73,
			'Statement' => 74,
			'OPTIONAL-35' => 102,
			'ArrayReference' => 99,
			'Operation' => 405,
			'Expression' => 78
		}
	},
	{#State 402
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 407
		}
	},
	{#State 403
		DEFAULT => -145
	},
	{#State 404
		DEFAULT => -155
	},
	{#State 405
		DEFAULT => -67
	},
	{#State 406
		ACTIONS => {
			";" => 408
		}
	},
	{#State 407
		ACTIONS => {
			'OP21_LIST_COMMA' => 411,
			")" => 410
		},
		GOTOS => {
			'PAREN-28' => 409
		}
	},
	{#State 408
		DEFAULT => -69
	},
	{#State 409
		DEFAULT => -71
	},
	{#State 410
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 412
		}
	},
	{#State 411
		ACTIONS => {
			"my" => 413
		}
	},
	{#State 412
		ACTIONS => {
			"\@_;" => 414
		}
	},
	{#State 413
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 415
		}
	},
	{#State 414
		DEFAULT => -73
	},
	{#State 415
		ACTIONS => {
			'VARIABLE_SYMBOL' => 416
		}
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
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5810 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5817 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
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
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5853 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5860 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5867 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5874 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5881 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
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
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5948 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
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
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5995 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6002 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6009 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6016 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
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
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6073 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
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
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6098 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
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
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6145 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6152 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
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
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6191 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
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
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6216 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6223 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6230 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6237 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6244 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6251 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
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
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6283 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6290 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
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
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6326 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6333 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
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
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6365 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6372 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
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
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6760 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 168 "lib/RPerl/Grammar.eyp"
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
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
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
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7062 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7069 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
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
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7138 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7145 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7152 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7159 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
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
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
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
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7282 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
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
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7384 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7391 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
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
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
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
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7463 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
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
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
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
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
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
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7582 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-49', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
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


#line 8023 lib/RPerl/Grammar.pm



1;
