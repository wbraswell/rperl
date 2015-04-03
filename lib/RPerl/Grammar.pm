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
    our $VERSION = 0.000_988;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach|package|\$TYPED_|\=\ sub\ \{|while|undef|elsif|else|use|our|for|\@_\;|\@\{|if|my|\%\{|\;|\}|\]|\))}gc and return ($1, $1);

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
			"## no critic qw(" => 9,
			'SHEBANG' => 4
		},
		GOTOS => {
			'ModuleHeader' => 3,
			'Critic' => 8,
			'PLUS-2' => 5,
			'Program' => 7,
			'CompileUnit' => 6,
			'PAREN-1' => 2,
			'OPTIONAL-9' => 1
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		ACTIONS => {
			"use parent qw(" => 12,
			"our" => -25,
			"use constant" => -25,
			"use" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'Package' => 13,
			'Class' => 11,
			'Module' => 15,
			'STAR-10' => 14
		}
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => 9,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 16,
			'OPTIONAL-3' => 17
		}
	},
	{#State 5
		ACTIONS => {
			"## no critic qw(" => 9,
			'' => -5,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 1,
			'PAREN-1' => 18,
			'Critic' => 8,
			'ModuleHeader' => 3
		}
	},
	{#State 6
		ACTIONS => {
			'' => 19
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		DEFAULT => -19
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
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 23
		}
	},
	{#State 11
		DEFAULT => -23
	},
	{#State 12
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 13
		DEFAULT => -22
	},
	{#State 14
		ACTIONS => {
			"our" => -27,
			"use" => -27,
			"use constant" => -27,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'STAR-11' => 26,
			'Critic' => 27
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		DEFAULT => -6
	},
	{#State 17
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 28
		}
	},
	{#State 18
		DEFAULT => -2
	},
	{#State 19
		DEFAULT => 0
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			")" => 30,
			'WORD' => 31
		}
	},
	{#State 22
		DEFAULT => -203
	},
	{#State 23
		ACTIONS => {
			";" => 32
		}
	},
	{#State 24
		DEFAULT => -202
	},
	{#State 25
		ACTIONS => {
			")" => 33
		}
	},
	{#State 26
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 36
		},
		GOTOS => {
			'STAR-12' => 35,
			'Include' => 34
		}
	},
	{#State 27
		DEFAULT => -24
	},
	{#State 28
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 29
		ACTIONS => {
			"use warnings;" => 38
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
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 39
		}
	},
	{#State 33
		ACTIONS => {
			";" => 40
		}
	},
	{#State 34
		DEFAULT => -26
	},
	{#State 35
		ACTIONS => {
			"our" => 44,
			"use constant" => 43
		},
		GOTOS => {
			'Subroutine' => 42,
			'PLUS-13' => 41,
			'Constant' => 45
		}
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 46
		}
	},
	{#State 37
		ACTIONS => {
			'LBRACKET' => -11,
			"my" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"%{" => -11,
			"foreach" => -11,
			'LITERAL_STRING' => -11,
			"undef" => -11,
			"\@{" => -11,
			'WORD_UPPERCASE' => -11,
			"## no critic qw(" => 9,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_NAMED' => -11,
			'VARIABLE_SYMBOL' => -11,
			'WORD_SCOPED' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_PRINT' => -11,
			"our" => -11,
			'OP01_CLOSE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_VOID' => -11,
			"for" => -11,
			"while" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"use constant" => -11,
			'WORD' => -11,
			'LPAREN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"use" => -11,
			"if" => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_OPEN' => -11,
			'OP10_NAMED_UNARY' => -11,
			'LBRACE' => -11
		},
		GOTOS => {
			'STAR-5' => 47,
			'Critic' => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use RPerl;" => 49
		}
	},
	{#State 39
		DEFAULT => -21
	},
	{#State 40
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 41
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 52
		},
		GOTOS => {
			'Subroutine' => 51
		}
	},
	{#State 42
		DEFAULT => -31
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 53
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		ACTIONS => {
			'OP01_QW' => 57,
			";" => 58
		}
	},
	{#State 47
		ACTIONS => {
			"our" => -13,
			'OP01_CLOSE' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED_VOID' => -13,
			"for" => -13,
			"while" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"use constant" => -13,
			'WORD' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'LPAREN' => -13,
			"use" => 36,
			"if" => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_OPEN' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LBRACE' => -13,
			"my" => -13,
			'LBRACKET' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"%{" => -13,
			"foreach" => -13,
			'LITERAL_STRING' => -13,
			"undef" => -13,
			"\@{" => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_NAMED' => -13,
			'VARIABLE_SYMBOL' => -13,
			'WORD_SCOPED' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_PRINT' => -13
		},
		GOTOS => {
			'Include' => 59,
			'STAR-6' => 60
		}
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		ACTIONS => {
			"our" => 61
		}
	},
	{#State 50
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 62
		}
	},
	{#State 51
		DEFAULT => -30
	},
	{#State 52
		ACTIONS => {
			";" => 63
		}
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 64
		}
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
		DEFAULT => -205
	},
	{#State 57
		ACTIONS => {
			'WORD' => 67
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 58
		DEFAULT => -39
	},
	{#State 59
		DEFAULT => -10
	},
	{#State 60
		ACTIONS => {
			'WORD' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'LPAREN' => -15,
			"our" => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"for" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"while" => -15,
			"use constant" => 43,
			'OP01_OPEN' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LBRACE' => -15,
			"if" => -15,
			'LITERAL_NUMBER' => -15,
			'LITERAL_STRING' => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			"\@{" => -15,
			'LBRACKET' => -15,
			"my" => -15,
			'OP19_LOOP_CONTROL' => -15,
			"%{" => -15,
			"foreach" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_NAMED' => -15,
			'VARIABLE_SYMBOL' => -15,
			'WORD_SCOPED' => -15,
			'OP22_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'STAR-7' => 68,
			'Constant' => 69
		}
	},
	{#State 61
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 70
		}
	},
	{#State 62
		ACTIONS => {
			"## no critic qw(" => 9,
			"use constant" => -54,
			"use" => -54,
			"our hash_ref \$properties" => -54
		},
		GOTOS => {
			'Critic' => 72,
			'STAR-21' => 71
		}
	},
	{#State 63
		DEFAULT => -32
	},
	{#State 64
		ACTIONS => {
			"my" => 74
		},
		GOTOS => {
			'TypeInnerConstant' => 73
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 75
		}
	},
	{#State 66
		ACTIONS => {
			")" => 76,
			'WORD' => 77
		}
	},
	{#State 67
		DEFAULT => -38
	},
	{#State 68
		ACTIONS => {
			'OP01_PRINT' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 111,
			'OP22_LOGICAL_NEG' => 123,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP01_NAMED' => 117,
			'OP01_NAMED_VOID_SCOLON' => 118,
			"\@{" => 102,
			'WORD_UPPERCASE' => 104,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'OP19_LOOP_CONTROL' => 109,
			"%{" => 108,
			"foreach" => -139,
			"my" => 106,
			'LBRACKET' => 105,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_NUMBER' => 95,
			"if" => 92,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'WORD' => 24,
			"for" => -139,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_NAMED_VOID' => 85,
			"our" => 44,
			'OP01_CLOSE' => 82
		},
		GOTOS => {
			'Operator' => 83,
			'Operation' => 81,
			'ArrayReference' => 107,
			'HashReference' => 110,
			'Literal' => 101,
			'LoopLabel' => 103,
			'Conditional' => 100,
			'OPTIONAL-35' => 99,
			'Variable' => 80,
			'PLUS-8' => 93,
			'VariableModification' => 119,
			'VariableDeclaration' => 116,
			'WordScoped' => 96,
			'Subroutine' => 120,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'PAREN-34' => 114,
			'SubExpression' => 88,
			'Statement' => 112,
			'Expression' => 87,
			'OperatorVoid' => 113
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		DEFAULT => -33
	},
	{#State 71
		ACTIONS => {
			"our hash_ref \$properties" => -56,
			"use constant" => -56,
			"use" => 36
		},
		GOTOS => {
			'STAR-22' => 124,
			'Include' => 125
		}
	},
	{#State 72
		DEFAULT => -51
	},
	{#State 73
		ACTIONS => {
			'LITERAL_NUMBER' => 95,
			'LITERAL_STRING' => 98
		},
		GOTOS => {
			'Literal' => 126
		}
	},
	{#State 74
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 127
		}
	},
	{#State 75
		ACTIONS => {
			"if" => -43,
			'LITERAL_NUMBER' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_OPEN' => -43,
			'LBRACE' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_CLOSE' => -43,
			"while" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"for" => -43,
			'WORD' => -43,
			"}" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'LPAREN' => -43,
			'OP01_NAMED' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'WORD_SCOPED' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_PRINT' => -43,
			"my" => -43,
			'LBRACKET' => -43,
			"foreach" => -43,
			'LPAREN_MY' => 130,
			"%{" => -43,
			'OP19_LOOP_CONTROL' => -43,
			"\@{" => -43,
			'WORD_UPPERCASE' => -43,
			"undef" => -43,
			'LITERAL_STRING' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 129,
			'OPTIONAL-16' => 128
		}
	},
	{#State 76
		ACTIONS => {
			";" => 131
		}
	},
	{#State 77
		DEFAULT => -37
	},
	{#State 78
		ACTIONS => {
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'WORD' => 24,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			'OP01_PRINT' => 135,
			'OP01_NAMED' => 136,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95
		},
		GOTOS => {
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110,
			'Operator' => 83,
			'ArrayReference' => 107,
			'Variable' => 134,
			'SubExpression' => 133,
			'Literal' => 101,
			'Expression' => 132
		}
	},
	{#State 79
		ACTIONS => {
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP01_NAMED' => 139,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'WORD' => 24,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82
		},
		GOTOS => {
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'Literal' => 101,
			'SubExpression' => 138,
			'Expression' => 132,
			'Variable' => 134
		}
	},
	{#State 80
		ACTIONS => {
			'OP23_LOGICAL_AND' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP03_MATH_INC_DEC' => 141,
			'OP09_BITWISE_SHIFT' => -129,
			'OP02_METHOD_THINARROW' => 140,
			'OP19_VARIABLE_ASSIGN' => 142,
			'OP11_COMPARE_LT_GT' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP08_STRING_CAT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 143,
			'OP04_MATH_POW' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP17_LIST_RANGE' => -129
		}
	},
	{#State 81
		DEFAULT => -17
	},
	{#State 82
		ACTIONS => {
			'FH_REF_SYMBOL' => 144
		}
	},
	{#State 83
		DEFAULT => -121
	},
	{#State 84
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Variable' => 145
		}
	},
	{#State 85
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD' => 24,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			"my" => 148,
			'OP01_CLOSE' => 82,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP01_NAMED' => 139,
			'OP01_QW' => 151
		},
		GOTOS => {
			'ListElements' => 146,
			'Variable' => 134,
			'TypeInner' => 149,
			'Expression' => 132,
			'SubExpression' => 150,
			'Literal' => 101,
			'ArrayDereference' => 94,
			'ListElement' => 147,
			'HashReference' => 110,
			'HashDereference' => 122,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83
		}
	},
	{#State 86
		ACTIONS => {
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Operator' => 83,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110,
			'WordScoped' => 96,
			'Expression' => 132,
			'SubExpression' => 152,
			'Literal' => 101,
			'Variable' => 134
		}
	},
	{#State 87
		ACTIONS => {
			'OP07_STRING_REPEAT' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP04_MATH_POW' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			";" => 153,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP18_TERNARY' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP08_STRING_CAT' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP08_MATH_ADD_SUB' => -126
		}
	},
	{#State 88
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			'OP08_MATH_ADD_SUB' => 154,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP15_LOGICAL_AND' => 166,
			'OP18_TERNARY' => 165,
			'OP23_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 170,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161
		}
	},
	{#State 89
		ACTIONS => {
			"my" => 171
		}
	},
	{#State 90
		ACTIONS => {
			'OP06_REGEX_MATCH' => -95,
			'OP07_STRING_REPEAT' => -95,
			'LITERAL_NUMBER' => 95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			";" => -95,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'LBRACE' => 91,
			"]" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD' => 24,
			'OP08_MATH_ADD_SUB' => -95,
			'OP21_LIST_COMMA' => -95,
			"}" => -95,
			'OP16_LOGICAL_OR' => -95,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_NAMED' => 139,
			'OP22_LOGICAL_NEG' => 123,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP17_LIST_RANGE' => -95,
			'OP04_MATH_POW' => -95,
			'OP13_BITWISE_AND' => -95,
			'LBRACKET' => 105,
			'OP23_LOGICAL_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP18_TERNARY' => -95,
			'OP15_LOGICAL_AND' => -95,
			"%{" => 108,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			")" => -95,
			'OP08_STRING_CAT' => -95,
			'OP11_COMPARE_LT_GT' => -95
		},
		GOTOS => {
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'SubExpression' => 172,
			'Literal' => 101,
			'Expression' => 132,
			'Variable' => 134
		}
	},
	{#State 91
		ACTIONS => {
			"}" => 173,
			"%{" => 108,
			'WORD' => 174
		},
		GOTOS => {
			'HashEntry' => 175,
			'HashDereference' => 176
		}
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 177
		}
	},
	{#State 93
		ACTIONS => {
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 95,
			"if" => 92,
			'' => -18,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD' => 24,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 86,
			"for" => -139,
			'OP01_NAMED_VOID' => 85,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'OP01_PRINT' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 111,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_NAMED' => 117,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'WORD_UPPERCASE' => 104,
			"\@{" => 102,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"foreach" => -139,
			'OP19_LOOP_CONTROL' => 109,
			"%{" => 108,
			'LBRACKET' => 105,
			"my" => 106
		},
		GOTOS => {
			'Variable' => 80,
			'OPTIONAL-35' => 99,
			'Conditional' => 100,
			'LoopLabel' => 103,
			'Literal' => 101,
			'HashReference' => 110,
			'Operation' => 178,
			'ArrayReference' => 107,
			'Operator' => 83,
			'Expression' => 87,
			'Statement' => 112,
			'OperatorVoid' => 113,
			'SubExpression' => 88,
			'PAREN-34' => 114,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'WordScoped' => 96,
			'VariableDeclaration' => 116,
			'VariableModification' => 119
		}
	},
	{#State 94
		DEFAULT => -131
	},
	{#State 95
		DEFAULT => -212
	},
	{#State 96
		ACTIONS => {
			'LPAREN' => 180,
			'OP02_METHOD_THINARROW_NEW' => 179
		}
	},
	{#State 97
		DEFAULT => -127
	},
	{#State 98
		DEFAULT => -211
	},
	{#State 99
		ACTIONS => {
			"foreach" => 183,
			"while" => 187,
			"for" => 186
		},
		GOTOS => {
			'LoopFor' => 181,
			'Loop' => 182,
			'LoopWhile' => 184,
			'LoopForEach' => 185
		}
	},
	{#State 100
		DEFAULT => -140
	},
	{#State 101
		DEFAULT => -128
	},
	{#State 102
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121,
			"my" => 148,
			'LBRACKET' => -184
		},
		GOTOS => {
			'OPTIONAL-46' => 190,
			'TypeInner' => 188,
			'Variable' => 189
		}
	},
	{#State 103
		ACTIONS => {
			'COLON' => 191
		}
	},
	{#State 104
		ACTIONS => {
			'LPAREN' => 192,
			'COLON' => -204
		}
	},
	{#State 105
		ACTIONS => {
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			"my" => 148,
			'LBRACE' => 91,
			"]" => -181,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_NAMED' => 139,
			'OP01_QW' => 151
		},
		GOTOS => {
			'ListElements' => 194,
			'Variable' => 134,
			'TypeInner' => 149,
			'Expression' => 132,
			'SubExpression' => 150,
			'Literal' => 101,
			'ArrayDereference' => 94,
			'OPTIONAL-45' => 193,
			'ListElement' => 147,
			'HashReference' => 110,
			'HashDereference' => 122,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83
		}
	},
	{#State 106
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 195
		}
	},
	{#State 107
		DEFAULT => -130
	},
	{#State 108
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121,
			'LBRACE' => -199,
			"my" => 148
		},
		GOTOS => {
			'TypeInner' => 197,
			'Variable' => 196,
			'OPTIONAL-50' => 198
		}
	},
	{#State 109
		ACTIONS => {
			'WORD_UPPERCASE' => 200
		},
		GOTOS => {
			'LoopLabel' => 199
		}
	},
	{#State 110
		DEFAULT => -132
	},
	{#State 111
		DEFAULT => -115
	},
	{#State 112
		DEFAULT => -77
	},
	{#State 113
		DEFAULT => -142
	},
	{#State 114
		DEFAULT => -138
	},
	{#State 115
		ACTIONS => {
			'OP01_QW' => -109,
			'OP01_NAMED' => -109,
			'VARIABLE_SYMBOL' => -109,
			'WORD_SCOPED' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LITERAL_NUMBER' => -109,
			'OP01_OPEN' => -109,
			'OP10_NAMED_UNARY' => -109,
			'LBRACE' => -109,
			'LBRACKET' => -109,
			"my" => -109,
			'OP01_CLOSE' => -109,
			'OP03_MATH_INC_DEC' => -109,
			"%{" => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			"undef" => -109,
			'LITERAL_STRING' => -109,
			'STDOUT_STDERR' => 201,
			"\@{" => -109,
			'WORD_UPPERCASE' => -109,
			'WORD' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'LPAREN' => -109,
			'FH_REF_SYMBOL_BRACES' => 202
		},
		GOTOS => {
			'PAREN-30' => 203,
			'OPTIONAL-31' => 204
		}
	},
	{#State 116
		DEFAULT => -143
	},
	{#State 117
		ACTIONS => {
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			"my" => 148,
			'OP01_CLOSE' => 82,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'HashReference' => 110,
			'HashDereference' => 122,
			'ListElement' => 206,
			'ArrayDereference' => 94,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83,
			'Variable' => 134,
			'TypeInner' => 149,
			'Expression' => 132,
			'Literal' => 101,
			'SubExpression' => 205
		}
	},
	{#State 118
		DEFAULT => -112
	},
	{#State 119
		DEFAULT => -144
	},
	{#State 120
		DEFAULT => -14
	},
	{#State 121
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 207
		}
	},
	{#State 122
		DEFAULT => -133
	},
	{#State 123
		ACTIONS => {
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'WORD' => 24,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Operator' => 83,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'WordScoped' => 96,
			'Expression' => 132,
			'Literal' => 101,
			'SubExpression' => 208,
			'Variable' => 134
		}
	},
	{#State 124
		ACTIONS => {
			"use constant" => 43,
			"our hash_ref \$properties" => 211
		},
		GOTOS => {
			'Constant' => 210,
			'Properties' => 209
		}
	},
	{#State 125
		DEFAULT => -53
	},
	{#State 126
		ACTIONS => {
			";" => 212
		}
	},
	{#State 127
		ACTIONS => {
			"\$TYPED_" => 213
		}
	},
	{#State 128
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 214
		}
	},
	{#State 129
		DEFAULT => -42
	},
	{#State 130
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 215
		}
	},
	{#State 131
		DEFAULT => -40
	},
	{#State 132
		DEFAULT => -126
	},
	{#State 133
		ACTIONS => {
			'OP23_LOGICAL_AND' => 167,
			'OP15_LOGICAL_AND' => 166,
			'OP18_TERNARY' => 165,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP09_BITWISE_SHIFT' => 156,
			")" => 216,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_MATH_ADD_SUB' => 154,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP13_BITWISE_AND' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 169,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157
		}
	},
	{#State 134
		ACTIONS => {
			"]" => -129,
			'OP13_BITWISE_AND' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP04_MATH_POW' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			";" => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP08_STRING_CAT' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			")" => -129,
			"}" => -129,
			'OP02_METHOD_THINARROW' => 140,
			'OP21_LIST_COMMA' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP18_TERNARY' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP03_MATH_INC_DEC' => 141
		}
	},
	{#State 135
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 217
		}
	},
	{#State 136
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			"my" => 148,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'WORD' => 24,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_NAMED' => 139,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91
		},
		GOTOS => {
			'SubExpression' => 205,
			'Literal' => 101,
			'Expression' => 132,
			'Variable' => 134,
			'TypeInner' => 149,
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'ListElement' => 218,
			'HashReference' => 110,
			'HashDereference' => 122
		}
	},
	{#State 137
		ACTIONS => {
			'LPAREN' => 192
		}
	},
	{#State 138
		ACTIONS => {
			'OP23_LOGICAL_AND' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP18_TERNARY' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			"}" => -86,
			")" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP08_STRING_CAT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP13_BITWISE_AND' => -86,
			"]" => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			";" => -86,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP24_LOGICAL_OR_XOR' => -86
		}
	},
	{#State 139
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP01_NAMED' => 139,
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24
		},
		GOTOS => {
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'SubExpression' => 219,
			'Literal' => 101,
			'Expression' => 132,
			'Variable' => 134
		}
	},
	{#State 140
		ACTIONS => {
			'LPAREN' => 220
		}
	},
	{#State 141
		DEFAULT => -84
	},
	{#State 142
		ACTIONS => {
			'WORD' => 24,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'STDIN' => 221,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Variable' => 134,
			'Expression' => 132,
			'SubExpressionOrStdin' => 222,
			'SubExpression' => 223,
			'Literal' => 101,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83
		}
	},
	{#State 143
		ACTIONS => {
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'HashDereference' => 122,
			'HashReference' => 110,
			'ArrayDereference' => 94,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83,
			'Variable' => 134,
			'Expression' => 132,
			'Literal' => 101,
			'SubExpression' => 224
		}
	},
	{#State 144
		DEFAULT => -82
	},
	{#State 145
		DEFAULT => -83
	},
	{#State 146
		ACTIONS => {
			";" => 225
		}
	},
	{#State 147
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 226
		}
	},
	{#State 148
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 227
		}
	},
	{#State 149
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP01_NAMED' => 139,
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			'LITERAL_STRING' => 98,
			"undef" => 97
		},
		GOTOS => {
			'Variable' => 134,
			'Expression' => 132,
			'SubExpression' => 228,
			'Literal' => 101,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83
		}
	},
	{#State 150
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -177,
			")" => -177,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			'OP09_BITWISE_SHIFT' => 156,
			'OP23_LOGICAL_AND' => 167,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -177,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP13_BITWISE_AND' => 170,
			"]" => -177,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160
		}
	},
	{#State 151
		ACTIONS => {
			'WORD' => 229
		},
		GOTOS => {
			'PLUS-44' => 230
		}
	},
	{#State 152
		ACTIONS => {
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161,
			'OP13_BITWISE_AND' => 170,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP23_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 156,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162,
			")" => 231,
			'OP08_MATH_ADD_SUB' => 154
		}
	},
	{#State 153
		DEFAULT => -76
	},
	{#State 154
		ACTIONS => {
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'SubExpression' => 232,
			'Literal' => 101,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122
		}
	},
	{#State 155
		ACTIONS => {
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_NAMED' => 139,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82
		},
		GOTOS => {
			'Variable' => 134,
			'SubExpression' => 233,
			'Literal' => 101,
			'Expression' => 132,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110,
			'Operator' => 83,
			'ArrayReference' => 107
		}
	},
	{#State 156
		ACTIONS => {
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'WORD' => 24,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108
		},
		GOTOS => {
			'WordScoped' => 96,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'Operator' => 83,
			'ArrayReference' => 107,
			'Variable' => 134,
			'Literal' => 101,
			'SubExpression' => 234,
			'Expression' => 132
		}
	},
	{#State 157
		ACTIONS => {
			"\@{" => 102,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'Variable' => 134,
			'Expression' => 132,
			'Literal' => 101,
			'SubExpression' => 235,
			'HashDereference' => 122,
			'HashReference' => 110,
			'ArrayDereference' => 94,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83
		}
	},
	{#State 158
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'SubExpression' => 236,
			'Literal' => 101,
			'Expression' => 132,
			'Variable' => 134
		}
	},
	{#State 159
		ACTIONS => {
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'OP01_NAMED' => 139,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'Literal' => 101,
			'SubExpression' => 237,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'HashDereference' => 122,
			'HashReference' => 110,
			'ArrayDereference' => 94
		}
	},
	{#State 160
		ACTIONS => {
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Variable' => 134,
			'Expression' => 132,
			'SubExpression' => 238,
			'Literal' => 101,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83
		}
	},
	{#State 161
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 239
		}
	},
	{#State 162
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91
		},
		GOTOS => {
			'SubExpression' => 240,
			'Literal' => 101,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110
		}
	},
	{#State 163
		ACTIONS => {
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Operator' => 83,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'WordScoped' => 96,
			'Expression' => 132,
			'SubExpression' => 241,
			'Literal' => 101,
			'Variable' => 134
		}
	},
	{#State 164
		ACTIONS => {
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Variable' => 134,
			'SubExpression' => 242,
			'Literal' => 101,
			'Expression' => 132,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'Operator' => 83,
			'ArrayReference' => 107
		}
	},
	{#State 165
		ACTIONS => {
			'LITERAL_STRING' => 98,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_NUMBER' => 95
		},
		GOTOS => {
			'Variable' => 243,
			'VariableOrLiteral' => 245,
			'Literal' => 244
		}
	},
	{#State 166
		ACTIONS => {
			'OP01_NAMED' => 139,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78
		},
		GOTOS => {
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'Operator' => 83,
			'ArrayReference' => 107,
			'Variable' => 134,
			'SubExpression' => 246,
			'Literal' => 101,
			'Expression' => 132
		}
	},
	{#State 167
		ACTIONS => {
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'OP01_NAMED' => 139,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'Expression' => 132,
			'SubExpression' => 247,
			'Literal' => 101,
			'Variable' => 134,
			'ArrayReference' => 107,
			'Operator' => 83,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110,
			'WordScoped' => 96
		}
	},
	{#State 168
		ACTIONS => {
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP01_NAMED' => 139,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90
		},
		GOTOS => {
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'HashDereference' => 122,
			'HashReference' => 110,
			'ArrayDereference' => 94,
			'Literal' => 101,
			'SubExpression' => 248,
			'Expression' => 132,
			'Variable' => 134
		}
	},
	{#State 169
		ACTIONS => {
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Operator' => 83,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'WordScoped' => 96,
			'Expression' => 132,
			'SubExpression' => 249,
			'Literal' => 101,
			'Variable' => 134
		}
	},
	{#State 170
		ACTIONS => {
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86
		},
		GOTOS => {
			'Expression' => 132,
			'SubExpression' => 250,
			'Literal' => 101,
			'Variable' => 134,
			'ArrayReference' => 107,
			'Operator' => 83,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'WordScoped' => 96
		}
	},
	{#State 171
		ACTIONS => {
			"filehandle_ref" => 251
		}
	},
	{#State 172
		ACTIONS => {
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161,
			"]" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			";" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP18_TERNARY' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP09_BITWISE_SHIFT' => 156,
			'OP11_COMPARE_LT_GT' => -94,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => -94,
			"}" => -94,
			")" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP08_MATH_ADD_SUB' => 154
		}
	},
	{#State 173
		DEFAULT => -197
	},
	{#State 174
		ACTIONS => {
			'OP20_HASH_FATARROW' => 252
		}
	},
	{#State 175
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 253
		}
	},
	{#State 176
		DEFAULT => -190
	},
	{#State 177
		ACTIONS => {
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'WORD' => 24,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108
		},
		GOTOS => {
			'Expression' => 132,
			'SubExpression' => 254,
			'Literal' => 101,
			'Variable' => 134,
			'ArrayReference' => 107,
			'Operator' => 83,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110,
			'WordScoped' => 96
		}
	},
	{#State 178
		DEFAULT => -16
	},
	{#State 179
		ACTIONS => {
			")" => 255
		}
	},
	{#State 180
		ACTIONS => {
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			")" => -118,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"my" => 148,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'OP01_QW' => 151,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'ListElements' => 256,
			'TypeInner' => 149,
			'Variable' => 134,
			'OPTIONAL-32' => 257,
			'SubExpression' => 150,
			'Literal' => 101,
			'Expression' => 132,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'ListElement' => 147,
			'HashReference' => 110,
			'HashDereference' => 122,
			'Operator' => 83,
			'ArrayReference' => 107
		}
	},
	{#State 181
		DEFAULT => -152
	},
	{#State 182
		DEFAULT => -141
	},
	{#State 183
		ACTIONS => {
			"my" => 258
		}
	},
	{#State 184
		DEFAULT => -154
	},
	{#State 185
		DEFAULT => -153
	},
	{#State 186
		ACTIONS => {
			"my" => 259
		}
	},
	{#State 187
		ACTIONS => {
			'LPAREN' => 260
		}
	},
	{#State 188
		DEFAULT => -183
	},
	{#State 189
		ACTIONS => {
			"}" => 261
		}
	},
	{#State 190
		ACTIONS => {
			'LBRACKET' => 105
		},
		GOTOS => {
			'ArrayReference' => 262
		}
	},
	{#State 191
		DEFAULT => -137
	},
	{#State 192
		ACTIONS => {
			")" => 263
		}
	},
	{#State 193
		ACTIONS => {
			"]" => 264
		}
	},
	{#State 194
		DEFAULT => -180
	},
	{#State 195
		ACTIONS => {
			'VARIABLE_SYMBOL' => 265
		}
	},
	{#State 196
		ACTIONS => {
			"}" => 266
		}
	},
	{#State 197
		DEFAULT => -198
	},
	{#State 198
		ACTIONS => {
			'LBRACE' => 91
		},
		GOTOS => {
			'HashReference' => 267
		}
	},
	{#State 199
		ACTIONS => {
			";" => 268
		}
	},
	{#State 200
		DEFAULT => -204
	},
	{#State 201
		DEFAULT => -107
	},
	{#State 202
		ACTIONS => {
			'OP01_NAMED' => 139,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP03_MATH_INC_DEC' => 84,
			"my" => 148,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'WORD' => 24,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'SubExpression' => 150,
			'Literal' => 101,
			'Expression' => 132,
			'ListElements' => 269,
			'TypeInner' => 149,
			'Variable' => 134,
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'ListElement' => 147,
			'HashDereference' => 122,
			'HashReference' => 110
		}
	},
	{#State 203
		DEFAULT => -108
	},
	{#State 204
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP01_QW' => 151,
			'OP01_NAMED' => 139,
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP01_CLOSE' => 82,
			"my" => 148,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"\@{" => 102,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137
		},
		GOTOS => {
			'ListElements' => 270,
			'Variable' => 134,
			'TypeInner' => 149,
			'Expression' => 132,
			'SubExpression' => 150,
			'Literal' => 101,
			'ArrayDereference' => 94,
			'ListElement' => 147,
			'HashReference' => 110,
			'HashDereference' => 122,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83
		}
	},
	{#State 205
		ACTIONS => {
			'OP07_STRING_REPEAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP04_MATH_POW' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP17_LIST_RANGE' => -79,
			";" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP21_LIST_COMMA' => -177,
			'OP08_MATH_ADD_SUB' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP08_STRING_CAT' => -79,
			'OP16_LOGICAL_OR' => -79,
			")" => -79
		}
	},
	{#State 206
		ACTIONS => {
			'OP21_LIST_COMMA' => 271
		}
	},
	{#State 207
		ACTIONS => {
			'OP15_LOGICAL_AND' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP18_TERNARY' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP03_MATH_INC_DEC' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP08_STRING_CAT' => -163,
			'OP11_COMPARE_LT_GT' => -163,
			")" => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			"}" => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'COLON' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP02_HASH_THINARROW' => 272,
			'OP02_ARRAY_THINARROW' => 274,
			"]" => -163,
			'OP13_BITWISE_AND' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'OP04_MATH_POW' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			";" => -163
		},
		GOTOS => {
			'VariableRetrieval' => 273
		}
	},
	{#State 208
		ACTIONS => {
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			";" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			"]" => -104,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 156,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP23_LOGICAL_AND' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP08_MATH_ADD_SUB' => 154,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162,
			")" => -104,
			"}" => -104
		}
	},
	{#State 209
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 275
		}
	},
	{#State 210
		DEFAULT => -55
	},
	{#State 211
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 276
		}
	},
	{#State 212
		DEFAULT => -41
	},
	{#State 213
		ACTIONS => {
			'WORD_UPPERCASE' => 277
		}
	},
	{#State 214
		ACTIONS => {
			'OP01_NAMED' => 117,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP19_LOOP_CONTROL_SCOLON' => 111,
			'OP01_PRINT' => 115,
			"my" => 106,
			'LBRACKET' => 105,
			"foreach" => -139,
			'OP19_LOOP_CONTROL' => 109,
			"%{" => 108,
			'WORD_UPPERCASE' => 104,
			"\@{" => 102,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"if" => 92,
			'LITERAL_NUMBER' => 95,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			'OP01_NAMED_VOID' => 85,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'OP05_MATH_NEG_LPAREN' => 86,
			"while" => -139,
			"for" => -139,
			'WORD' => 24,
			"}" => 278,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'HashReference' => 110,
			'ArrayReference' => 107,
			'Operation' => 279,
			'Operator' => 83,
			'Variable' => 80,
			'Conditional' => 100,
			'OPTIONAL-35' => 99,
			'LoopLabel' => 103,
			'Literal' => 101,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'WordScoped' => 96,
			'VariableDeclaration' => 116,
			'VariableModification' => 119,
			'OperatorVoid' => 113,
			'Expression' => 87,
			'Statement' => 112,
			'SubExpression' => 88,
			'PAREN-34' => 114
		}
	},
	{#State 215
		ACTIONS => {
			'VARIABLE_SYMBOL' => 280
		}
	},
	{#State 216
		DEFAULT => -134
	},
	{#State 217
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			"my" => 148,
			'OP01_CLOSE' => 82,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_NAMED' => 139,
			'OP01_QW' => 151
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Operator' => 83,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'ListElement' => 147,
			'WordScoped' => 96,
			'Expression' => 132,
			'Literal' => 101,
			'SubExpression' => 150,
			'TypeInner' => 149,
			'Variable' => 134,
			'ListElements' => 281
		}
	},
	{#State 218
		ACTIONS => {
			'OP21_LIST_COMMA' => 282
		}
	},
	{#State 219
		ACTIONS => {
			'OP21_LIST_COMMA' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP08_STRING_CAT' => -79,
			"}" => -79,
			")" => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP18_TERNARY' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP04_MATH_POW' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			";" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			"]" => -79,
			'OP13_BITWISE_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP06_REGEX_MATCH' => -79
		}
	},
	{#State 220
		ACTIONS => {
			'OP01_CLOSE' => 82,
			"my" => 148,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			")" => -120,
			'OP01_QW' => 151,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91
		},
		GOTOS => {
			'WordScoped' => 96,
			'HashDereference' => 122,
			'HashReference' => 110,
			'ListElement' => 147,
			'ArrayDereference' => 94,
			'Operator' => 83,
			'ArrayReference' => 107,
			'OPTIONAL-33' => 284,
			'Variable' => 134,
			'TypeInner' => 149,
			'ListElements' => 283,
			'Literal' => 101,
			'SubExpression' => 150,
			'Expression' => 132
		}
	},
	{#State 221
		DEFAULT => -136
	},
	{#State 222
		ACTIONS => {
			";" => 285
		}
	},
	{#State 223
		ACTIONS => {
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_MATH_ADD_SUB' => 154,
			'OP15_LOGICAL_AND' => 166,
			'OP18_TERNARY' => 165,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP23_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 170,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168,
			";" => -135,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161
		}
	},
	{#State 224
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 154,
			'OP11_COMPARE_LT_GT' => 162,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP09_BITWISE_SHIFT' => 156,
			'OP23_LOGICAL_AND' => 167,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => 286,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP13_BITWISE_AND' => 170,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160
		}
	},
	{#State 225
		DEFAULT => -113
	},
	{#State 226
		ACTIONS => {
			")" => -174,
			"]" => -174,
			";" => -174,
			'OP21_LIST_COMMA' => 288
		},
		GOTOS => {
			'PAREN-42' => 287
		}
	},
	{#State 227
		ACTIONS => {
			"\$TYPED_" => 289
		}
	},
	{#State 228
		ACTIONS => {
			"]" => -178,
			'OP13_BITWISE_AND' => 170,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			";" => -178,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162,
			")" => -178,
			'OP21_LIST_COMMA' => -178,
			'OP08_MATH_ADD_SUB' => 154,
			'OP15_LOGICAL_AND' => 166,
			'OP18_TERNARY' => 165,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP23_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 156
		}
	},
	{#State 229
		DEFAULT => -176
	},
	{#State 230
		ACTIONS => {
			")" => 291,
			'WORD' => 290
		}
	},
	{#State 231
		DEFAULT => -87
	},
	{#State 232
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP18_TERNARY' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP21_LIST_COMMA' => -91,
			")" => -91,
			"}" => -91,
			'OP08_STRING_CAT' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP13_BITWISE_AND' => -91,
			"]" => -91
		}
	},
	{#State 233
		ACTIONS => {
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP13_BITWISE_AND' => 170,
			"]" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP23_LOGICAL_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP15_LOGICAL_AND' => 166,
			'OP09_BITWISE_SHIFT' => 156,
			")" => -101,
			"}" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -101
		}
	},
	{#State 234
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -93,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP13_BITWISE_AND' => -93,
			"]" => -93,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -93,
			"}" => -93,
			")" => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP08_STRING_CAT' => 163,
			'OP09_BITWISE_SHIFT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP18_TERNARY' => -93
		}
	},
	{#State 235
		ACTIONS => {
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP13_BITWISE_AND' => -97,
			"]" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -97,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP17_LIST_RANGE' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP09_BITWISE_SHIFT' => 156,
			"}" => -97,
			")" => -97,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => -97,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -97
		}
	},
	{#State 236
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 164,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP23_LOGICAL_AND' => 167,
			'OP09_BITWISE_SHIFT' => 156,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162,
			")" => -106,
			"}" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP08_MATH_ADD_SUB' => 154,
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161,
			"]" => -106,
			'OP13_BITWISE_AND' => 170,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP17_LIST_RANGE' => 169,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			";" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 159
		}
	},
	{#State 237
		ACTIONS => {
			"}" => -90,
			")" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP08_STRING_CAT' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP18_TERNARY' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP13_BITWISE_AND' => -90,
			"]" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			";" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP04_MATH_POW' => 168,
			'OP17_LIST_RANGE' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160
		}
	},
	{#State 238
		ACTIONS => {
			'OP23_LOGICAL_AND' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP18_TERNARY' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			"}" => -89,
			")" => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP08_STRING_CAT' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => -89,
			'OP13_BITWISE_AND' => -89,
			"]" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			";" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP04_MATH_POW' => 168,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP17_LIST_RANGE' => -89
		}
	},
	{#State 239
		DEFAULT => -88
	},
	{#State 240
		ACTIONS => {
			'OP13_BITWISE_AND' => -96,
			"]" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -96,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			"}" => -96,
			")" => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP16_LOGICAL_OR' => -96,
			'OP08_STRING_CAT' => 163,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP18_TERNARY' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP09_BITWISE_SHIFT' => 156
		}
	},
	{#State 241
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP18_TERNARY' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -92,
			"}" => -92,
			")" => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP08_STRING_CAT' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP04_MATH_POW' => 168,
			'OP17_LIST_RANGE' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP13_BITWISE_AND' => -92,
			"]" => -92
		}
	},
	{#State 242
		ACTIONS => {
			"}" => -99,
			")" => -99,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => -99,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP18_TERNARY' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 170,
			"]" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -99,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168,
			'OP17_LIST_RANGE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160
		}
	},
	{#State 243
		DEFAULT => -209
	},
	{#State 244
		DEFAULT => -210
	},
	{#State 245
		ACTIONS => {
			'COLON' => 292
		}
	},
	{#State 246
		ACTIONS => {
			'OP13_BITWISE_AND' => 170,
			"]" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -100,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			"}" => -100,
			")" => -100,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => -100,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP18_TERNARY' => -100,
			'OP09_BITWISE_SHIFT' => 156
		}
	},
	{#State 247
		ACTIONS => {
			'OP13_BITWISE_AND' => 170,
			"]" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -105,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP17_LIST_RANGE' => 169,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			"}" => -105,
			")" => -105,
			'OP11_COMPARE_LT_GT' => 162,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP09_BITWISE_SHIFT' => 156
		}
	},
	{#State 248
		ACTIONS => {
			"]" => -85,
			'OP13_BITWISE_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => -85,
			";" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_STRING_CAT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			")" => -85,
			"}" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85
		}
	},
	{#State 249
		ACTIONS => {
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -102,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP13_BITWISE_AND' => 170,
			"]" => -102,
			'OP09_BITWISE_SHIFT' => 156,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP15_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -102,
			"}" => -102,
			")" => -102,
			'OP11_COMPARE_LT_GT' => 162,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163
		}
	},
	{#State 250
		ACTIONS => {
			'OP18_TERNARY' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP09_BITWISE_SHIFT' => 156,
			'OP16_LOGICAL_OR' => -98,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162,
			")" => -98,
			"}" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP08_MATH_ADD_SUB' => 154,
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161,
			"]" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168,
			";" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 159
		}
	},
	{#State 251
		ACTIONS => {
			'FH_REF_SYMBOL' => 293
		}
	},
	{#State 252
		ACTIONS => {
			'VARIABLE_SYMBOL' => -188,
			'WORD_SCOPED' => -188,
			'LITERAL_NUMBER' => -188,
			'OP22_LOGICAL_NEG' => -188,
			'OP01_NAMED' => -188,
			'LBRACE' => -188,
			'OP10_NAMED_UNARY' => -188,
			'OP01_OPEN' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			"%{" => -188,
			'OP01_CLOSE' => -188,
			'LBRACKET' => -188,
			"my" => 148,
			'OP03_MATH_INC_DEC' => -188,
			'OP05_LOGICAL_NEG' => -188,
			'LPAREN' => -188,
			'LITERAL_STRING' => -188,
			"undef" => -188,
			"\@{" => -188,
			'WORD' => -188,
			'WORD_UPPERCASE' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 294,
			'TypeInner' => 295
		}
	},
	{#State 253
		ACTIONS => {
			"}" => 298,
			'OP21_LIST_COMMA' => 297
		},
		GOTOS => {
			'PAREN-48' => 296
		}
	},
	{#State 254
		ACTIONS => {
			'OP23_LOGICAL_AND' => 167,
			'OP15_LOGICAL_AND' => 166,
			'OP18_TERNARY' => 165,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP09_BITWISE_SHIFT' => 156,
			")" => 299,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_MATH_ADD_SUB' => 154,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP13_BITWISE_AND' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 169,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 255
		DEFAULT => -125
	},
	{#State 256
		DEFAULT => -117
	},
	{#State 257
		ACTIONS => {
			")" => 300
		}
	},
	{#State 258
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 301
		}
	},
	{#State 259
		ACTIONS => {
			'TYPE_INTEGER' => 302
		}
	},
	{#State 260
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_NAMED' => 139,
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89
		},
		GOTOS => {
			'SubExpression' => 303,
			'Literal' => 101,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110
		}
	},
	{#State 261
		DEFAULT => -185
	},
	{#State 262
		ACTIONS => {
			"}" => 304
		}
	},
	{#State 263
		DEFAULT => -123
	},
	{#State 264
		DEFAULT => -182
	},
	{#State 265
		ACTIONS => {
			";" => 306,
			'OP19_VARIABLE_ASSIGN' => 305
		}
	},
	{#State 266
		DEFAULT => -200
	},
	{#State 267
		ACTIONS => {
			"}" => 307
		}
	},
	{#State 268
		DEFAULT => -116
	},
	{#State 269
		ACTIONS => {
			";" => 308
		}
	},
	{#State 270
		ACTIONS => {
			";" => 309
		}
	},
	{#State 271
		ACTIONS => {
			'OP01_NAMED' => 139,
			'OP01_QW' => 151,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			"my" => 148,
			'OP01_CLOSE' => 82,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78
		},
		GOTOS => {
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ListElement' => 147,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'SubExpression' => 150,
			'Literal' => 101,
			'Expression' => 132,
			'ListElements' => 310,
			'Variable' => 134,
			'TypeInner' => 149
		}
	},
	{#State 272
		ACTIONS => {
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'OP01_NAMED' => 139,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD' => 312,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'Variable' => 134,
			'Literal' => 101,
			'SubExpression' => 311,
			'Expression' => 132,
			'WordScoped' => 96,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'Operator' => 83,
			'ArrayReference' => 107
		}
	},
	{#State 273
		DEFAULT => -161
	},
	{#State 274
		ACTIONS => {
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_NAMED' => 139,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'WORD' => 24,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105
		},
		GOTOS => {
			'Variable' => 134,
			'Literal' => 101,
			'SubExpression' => 313,
			'Expression' => 132,
			'WordScoped' => 96,
			'HashDereference' => 122,
			'HashReference' => 110,
			'ArrayDereference' => 94,
			'Operator' => 83,
			'ArrayReference' => 107
		}
	},
	{#State 275
		ACTIONS => {
			"our" => 318,
			'LITERAL_NUMBER' => 315
		},
		GOTOS => {
			'MethodOrSubroutine' => 317,
			'Subroutine' => 314,
			'Method' => 316
		}
	},
	{#State 276
		ACTIONS => {
			'LBRACE' => 319
		}
	},
	{#State 277
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 320
		}
	},
	{#State 278
		ACTIONS => {
			";" => 321
		}
	},
	{#State 279
		DEFAULT => -44
	},
	{#State 280
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 322
		}
	},
	{#State 281
		ACTIONS => {
			")" => 323
		}
	},
	{#State 282
		ACTIONS => {
			'OP01_QW' => 151,
			'OP01_NAMED' => 139,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			'OP01_CLOSE' => 82,
			"my" => 148,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"\@{" => 102,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78
		},
		GOTOS => {
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'ListElement' => 147,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'SubExpression' => 150,
			'Literal' => 101,
			'Expression' => 132,
			'ListElements' => 324,
			'Variable' => 134,
			'TypeInner' => 149
		}
	},
	{#State 283
		DEFAULT => -119
	},
	{#State 284
		ACTIONS => {
			")" => 325
		}
	},
	{#State 285
		DEFAULT => -169
	},
	{#State 286
		DEFAULT => -170
	},
	{#State 287
		DEFAULT => -172
	},
	{#State 288
		ACTIONS => {
			'OP01_QW' => 151,
			'OP01_NAMED' => 139,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			"my" => 148,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'Variable' => 134,
			'TypeInner' => 149,
			'Expression' => 132,
			'Literal' => 101,
			'SubExpression' => 150,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'ListElement' => 326,
			'WordScoped' => 96,
			'ArrayReference' => 107,
			'Operator' => 83
		}
	},
	{#State 289
		ACTIONS => {
			'WORD' => 327
		}
	},
	{#State 290
		DEFAULT => -175
	},
	{#State 291
		DEFAULT => -179
	},
	{#State 292
		ACTIONS => {
			'LITERAL_NUMBER' => 95,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_STRING' => 98
		},
		GOTOS => {
			'Literal' => 244,
			'VariableOrLiteral' => 328,
			'Variable' => 243
		}
	},
	{#State 293
		ACTIONS => {
			'OP21_LIST_COMMA' => 329
		}
	},
	{#State 294
		ACTIONS => {
			"\@{" => 102,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121
		},
		GOTOS => {
			'WordScoped' => 96,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'Operator' => 83,
			'ArrayReference' => 107,
			'Variable' => 134,
			'Literal' => 101,
			'SubExpression' => 330,
			'Expression' => 132
		}
	},
	{#State 295
		DEFAULT => -187
	},
	{#State 296
		DEFAULT => -194
	},
	{#State 297
		ACTIONS => {
			'WORD' => 174,
			"%{" => 108
		},
		GOTOS => {
			'HashDereference' => 176,
			'HashEntry' => 331
		}
	},
	{#State 298
		DEFAULT => -196
	},
	{#State 299
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 333
		}
	},
	{#State 300
		DEFAULT => -122
	},
	{#State 301
		ACTIONS => {
			'VARIABLE_SYMBOL' => 334
		}
	},
	{#State 302
		ACTIONS => {
			'VARIABLE_SYMBOL' => 335
		}
	},
	{#State 303
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 156,
			'OP23_LOGICAL_AND' => 167,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 154,
			")" => 336,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP13_BITWISE_AND' => 170
		}
	},
	{#State 304
		DEFAULT => -186
	},
	{#State 305
		ACTIONS => {
			'LBRACE' => 91,
			'STDIN' => 221,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'OP01_NAMED' => 139,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"\@{" => 102,
			'WORD' => 24,
			'WORD_UPPERCASE' => 137,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'Literal' => 101,
			'SubExpression' => 223,
			'SubExpressionOrStdin' => 337,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94
		}
	},
	{#State 306
		DEFAULT => -167
	},
	{#State 307
		DEFAULT => -201
	},
	{#State 308
		DEFAULT => -111
	},
	{#State 309
		DEFAULT => -110
	},
	{#State 310
		ACTIONS => {
			";" => 338
		}
	},
	{#State 311
		ACTIONS => {
			"}" => 339,
			'OP11_COMPARE_LT_GT' => 162,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP08_MATH_ADD_SUB' => 154,
			'OP23_LOGICAL_AND' => 167,
			'OP15_LOGICAL_AND' => 166,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP18_TERNARY' => 165,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 169,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160
		}
	},
	{#State 312
		ACTIONS => {
			'LPAREN' => -202,
			"}" => 340,
			'OP02_METHOD_THINARROW_NEW' => -202
		}
	},
	{#State 313
		ACTIONS => {
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 169,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			"]" => 341,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 156,
			'OP18_TERNARY' => 165,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP15_LOGICAL_AND' => 166,
			'OP23_LOGICAL_AND' => 167,
			'OP08_MATH_ADD_SUB' => 154,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			'OP11_COMPARE_LT_GT' => 162
		}
	},
	{#State 314
		DEFAULT => -75
	},
	{#State 315
		ACTIONS => {
			";" => 342
		}
	},
	{#State 316
		DEFAULT => -74
	},
	{#State 317
		DEFAULT => -57
	},
	{#State 318
		ACTIONS => {
			'TYPE_METHOD' => 343,
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 319
		ACTIONS => {
			"%{" => 108,
			"}" => 345,
			'WORD' => 344
		},
		GOTOS => {
			'HashEntryTyped' => 347,
			'HashDereference' => 346
		}
	},
	{#State 320
		DEFAULT => -208
	},
	{#State 321
		DEFAULT => -46
	},
	{#State 322
		ACTIONS => {
			")" => 348,
			'OP21_LIST_COMMA' => 350
		},
		GOTOS => {
			'PAREN-18' => 349
		}
	},
	{#State 323
		DEFAULT => -78
	},
	{#State 324
		ACTIONS => {
			")" => 351
		}
	},
	{#State 325
		DEFAULT => -124
	},
	{#State 326
		DEFAULT => -171
	},
	{#State 327
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 352
		}
	},
	{#State 328
		DEFAULT => -103
	},
	{#State 329
		ACTIONS => {
			'LITERAL_STRING' => 353
		}
	},
	{#State 330
		ACTIONS => {
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP04_MATH_POW' => 168,
			'OP13_BITWISE_AND' => 170,
			'OP09_BITWISE_SHIFT' => 156,
			'OP23_LOGICAL_AND' => 167,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP15_LOGICAL_AND' => 166,
			'OP18_TERNARY' => 165,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -189,
			"}" => -189,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162
		}
	},
	{#State 331
		DEFAULT => -193
	},
	{#State 332
		ACTIONS => {
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD' => 24,
			"\@{" => 102,
			'WORD_UPPERCASE' => 104,
			'OP19_LOOP_CONTROL' => 109,
			"for" => -139,
			"%{" => 108,
			"foreach" => -139,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 105,
			"my" => 106,
			'OP01_CLOSE' => 82,
			'OP01_NAMED_VOID' => 85,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_PRINT' => 115,
			'LBRACE' => 91,
			'OP19_LOOP_CONTROL_SCOLON' => 111,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			"if" => 92,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'OP01_NAMED' => 117
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Operation' => 354,
			'Operator' => 83,
			'HashReference' => 110,
			'OPTIONAL-35' => 99,
			'Conditional' => 100,
			'LoopLabel' => 103,
			'Literal' => 101,
			'Variable' => 80,
			'VariableDeclaration' => 116,
			'VariableModification' => 119,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'PLUS-40' => 355,
			'WordScoped' => 96,
			'OperatorVoid' => 113,
			'Expression' => 87,
			'Statement' => 112,
			'PAREN-34' => 114,
			'SubExpression' => 88
		}
	},
	{#State 333
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 356
		}
	},
	{#State 334
		ACTIONS => {
			'LPAREN' => 357
		}
	},
	{#State 335
		ACTIONS => {
			'LPAREN' => 358
		}
	},
	{#State 336
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 359
		}
	},
	{#State 337
		ACTIONS => {
			";" => 360
		}
	},
	{#State 338
		DEFAULT => -114
	},
	{#State 339
		DEFAULT => -165
	},
	{#State 340
		DEFAULT => -166
	},
	{#State 341
		DEFAULT => -164
	},
	{#State 342
		DEFAULT => -59
	},
	{#State 343
		ACTIONS => {
			'VARIABLE_SYMBOL' => 361
		}
	},
	{#State 344
		ACTIONS => {
			'OP20_HASH_FATARROW' => 362
		}
	},
	{#State 345
		ACTIONS => {
			";" => 363
		}
	},
	{#State 346
		DEFAULT => -192
	},
	{#State 347
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 364
		}
	},
	{#State 348
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 365
		}
	},
	{#State 349
		DEFAULT => -48
	},
	{#State 350
		ACTIONS => {
			"my" => 366
		}
	},
	{#State 351
		DEFAULT => -80
	},
	{#State 352
		DEFAULT => -207
	},
	{#State 353
		ACTIONS => {
			'OP21_LIST_COMMA' => 367
		}
	},
	{#State 354
		DEFAULT => -159
	},
	{#State 355
		ACTIONS => {
			"%{" => 108,
			'OP19_LOOP_CONTROL' => 109,
			"foreach" => -139,
			'LBRACKET' => 105,
			"my" => 106,
			'WORD_UPPERCASE' => 104,
			"\@{" => 102,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'OP01_NAMED' => 117,
			'OP01_PRINT' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 111,
			"for" => -139,
			'OP05_MATH_NEG_LPAREN' => 86,
			"while" => -139,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_NAMED_VOID' => 85,
			'OP01_CLOSE' => 82,
			"}" => 368,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD' => 24,
			'LITERAL_NUMBER' => 95,
			"if" => 92,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90
		},
		GOTOS => {
			'OPTIONAL-35' => 99,
			'Conditional' => 100,
			'Literal' => 101,
			'LoopLabel' => 103,
			'Variable' => 80,
			'ArrayReference' => 107,
			'Operation' => 369,
			'Operator' => 83,
			'HashReference' => 110,
			'OperatorVoid' => 113,
			'Expression' => 87,
			'Statement' => 112,
			'PAREN-34' => 114,
			'SubExpression' => 88,
			'VariableDeclaration' => 116,
			'VariableModification' => 119,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'WordScoped' => 96
		}
	},
	{#State 356
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -150,
			'LPAREN' => -150,
			'' => -150,
			"}" => -150,
			'WORD' => -150,
			"for" => -150,
			"while" => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			'OP01_CLOSE' => -150,
			'OP01_NAMED_VOID' => -150,
			'OP03_MATH_INC_DEC' => -150,
			'LBRACE' => -150,
			'OP01_OPEN' => -150,
			'OP10_NAMED_UNARY' => -150,
			'LITERAL_NUMBER' => -150,
			"if" => -150,
			'LITERAL_STRING' => -150,
			"undef" => -150,
			"\@{" => -150,
			'WORD_UPPERCASE' => -150,
			"%{" => -150,
			'OP19_LOOP_CONTROL' => -150,
			"foreach" => -150,
			"my" => -150,
			'LBRACKET' => -150,
			"elsif" => 372,
			'OP01_PRINT' => -150,
			"else" => 374,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			'VARIABLE_SYMBOL' => -150,
			'WORD_SCOPED' => -150,
			'OP22_LOGICAL_NEG' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			'OP01_NAMED' => -150
		},
		GOTOS => {
			'OPTIONAL-39' => 370,
			'PAREN-36' => 373,
			'PAREN-38' => 371
		}
	},
	{#State 357
		ACTIONS => {
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP01_QW' => 151,
			'OP01_NAMED' => 139,
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			"my" => 148,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			'WORD_UPPERCASE' => 137,
			"\@{" => 102,
			'WORD' => 24
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Operator' => 83,
			'ListElement' => 147,
			'ArrayDereference' => 94,
			'HashDereference' => 122,
			'HashReference' => 110,
			'WordScoped' => 96,
			'Expression' => 132,
			'SubExpression' => 150,
			'Literal' => 101,
			'ListElements' => 375,
			'Variable' => 134,
			'TypeInner' => 149
		}
	},
	{#State 358
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"undef" => 97,
			'LITERAL_STRING' => 98,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP03_MATH_INC_DEC' => 84,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'OP22_LOGICAL_NEG' => 123,
			'LITERAL_NUMBER' => 95,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'Operator' => 83,
			'ArrayReference' => 107,
			'Variable' => 134,
			'SubExpression' => 376,
			'Literal' => 101,
			'Expression' => 132
		}
	},
	{#State 359
		DEFAULT => -157
	},
	{#State 360
		DEFAULT => -168
	},
	{#State 361
		ACTIONS => {
			"= sub {" => 377
		}
	},
	{#State 362
		ACTIONS => {
			"my" => 148
		},
		GOTOS => {
			'TypeInner' => 378
		}
	},
	{#State 363
		DEFAULT => -64
	},
	{#State 364
		ACTIONS => {
			'OP21_LIST_COMMA' => 380,
			"}" => 379
		},
		GOTOS => {
			'PAREN-24' => 381
		}
	},
	{#State 365
		ACTIONS => {
			"\@_;" => 382
		}
	},
	{#State 366
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 383
		}
	},
	{#State 367
		ACTIONS => {
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'OP01_NAMED' => 139,
			'LBRACE' => 91,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			"\@{" => 102,
			"undef" => 97,
			'LITERAL_STRING' => 98
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Operator' => 83,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'WordScoped' => 96,
			'Expression' => 132,
			'Literal' => 101,
			'SubExpression' => 384,
			'Variable' => 134
		}
	},
	{#State 368
		DEFAULT => -160
	},
	{#State 369
		DEFAULT => -158
	},
	{#State 370
		DEFAULT => -151
	},
	{#State 371
		DEFAULT => -149
	},
	{#State 372
		ACTIONS => {
			'LPAREN' => 385
		}
	},
	{#State 373
		DEFAULT => -146
	},
	{#State 374
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 386
		}
	},
	{#State 375
		ACTIONS => {
			")" => 387
		}
	},
	{#State 376
		ACTIONS => {
			'OP13_BITWISE_AND' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP17_LIST_RANGE' => 388,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP11_COMPARE_LT_GT' => 162,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP08_MATH_ADD_SUB' => 154,
			'OP23_LOGICAL_AND' => 167,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP15_LOGICAL_AND' => 166,
			'OP18_TERNARY' => 165,
			'OP09_BITWISE_SHIFT' => 156
		}
	},
	{#State 377
		ACTIONS => {
			'LPAREN' => -66,
			'OP05_LOGICAL_NEG' => -66,
			"}" => -66,
			'WORD' => -66,
			"for" => -66,
			"while" => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP01_CLOSE' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP01_NAMED_VOID' => -66,
			'LBRACE' => -66,
			'OP01_OPEN' => -66,
			'OP10_NAMED_UNARY' => -66,
			'LITERAL_NUMBER' => -66,
			"if" => -66,
			"undef" => -66,
			'LITERAL_STRING' => -66,
			"\@{" => -66,
			'WORD_UPPERCASE' => -66,
			'OP19_LOOP_CONTROL' => -66,
			"%{" => -66,
			"foreach" => -66,
			'LPAREN_MY' => 391,
			'LBRACKET' => -66,
			"my" => -66,
			'OP01_PRINT' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'WORD_SCOPED' => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP01_NAMED' => -66
		},
		GOTOS => {
			'MethodArguments' => 389,
			'OPTIONAL-26' => 390
		}
	},
	{#State 378
		ACTIONS => {
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 121,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP01_NAMED' => 139,
			'LBRACE' => 91,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90
		},
		GOTOS => {
			'Operator' => 83,
			'ArrayReference' => 107,
			'WordScoped' => 96,
			'HashReference' => 110,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'Literal' => 101,
			'SubExpression' => 392,
			'Expression' => 132,
			'Variable' => 134
		}
	},
	{#State 379
		ACTIONS => {
			";" => 393
		}
	},
	{#State 380
		ACTIONS => {
			"%{" => 108,
			'WORD' => 344
		},
		GOTOS => {
			'HashEntryTyped' => 394,
			'HashDereference' => 346
		}
	},
	{#State 381
		DEFAULT => -61
	},
	{#State 382
		DEFAULT => -50
	},
	{#State 383
		ACTIONS => {
			'VARIABLE_SYMBOL' => 395
		}
	},
	{#State 384
		ACTIONS => {
			"}" => -81,
			")" => -81,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP09_BITWISE_SHIFT' => 156,
			'OP13_BITWISE_AND' => 170,
			"]" => -81,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			";" => -81,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160
		}
	},
	{#State 385
		ACTIONS => {
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'LBRACKET' => 105,
			'OP01_CLOSE' => 82,
			'OP03_MATH_INC_DEC' => 84,
			"%{" => 108,
			'OP05_MATH_NEG_LPAREN' => 86,
			'OP01_OPEN' => 89,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 91,
			'OP01_NAMED' => 139,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123
		},
		GOTOS => {
			'Variable' => 134,
			'SubExpression' => 396,
			'Literal' => 101,
			'Expression' => 132,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'Operator' => 83,
			'ArrayReference' => 107
		}
	},
	{#State 386
		DEFAULT => -148
	},
	{#State 387
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 397
		}
	},
	{#State 388
		ACTIONS => {
			'OP01_CLOSE' => 82,
			'LBRACKET' => 105,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_MATH_NEG_LPAREN' => 86,
			"%{" => 108,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"\@{" => 102,
			'WORD_UPPERCASE' => 137,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 79,
			'LPAREN' => 78,
			'OP01_NAMED' => 139,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 95,
			'OP22_LOGICAL_NEG' => 123,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91
		},
		GOTOS => {
			'Variable' => 134,
			'SubExpression' => 398,
			'Literal' => 101,
			'Expression' => 132,
			'WordScoped' => 96,
			'ArrayDereference' => 94,
			'HashReference' => 110,
			'HashDereference' => 122,
			'Operator' => 83,
			'ArrayReference' => 107
		}
	},
	{#State 389
		DEFAULT => -65
	},
	{#State 390
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 399
		}
	},
	{#State 391
		ACTIONS => {
			'TYPE_SELF' => 400
		}
	},
	{#State 392
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 156,
			'OP23_LOGICAL_AND' => 167,
			'OP18_TERNARY' => 165,
			'OP15_LOGICAL_AND' => 166,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP08_MATH_ADD_SUB' => 154,
			'OP21_LIST_COMMA' => -191,
			"}" => -191,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			'OP06_REGEX_MATCH' => 161,
			'OP07_STRING_REPEAT' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP17_LIST_RANGE' => 169,
			'OP13_BITWISE_AND' => 170
		}
	},
	{#State 393
		DEFAULT => -63
	},
	{#State 394
		DEFAULT => -60
	},
	{#State 395
		DEFAULT => -47
	},
	{#State 396
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 156,
			'OP18_TERNARY' => 165,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP15_LOGICAL_AND' => 166,
			'OP23_LOGICAL_AND' => 167,
			'OP08_MATH_ADD_SUB' => 154,
			'OP11_COMPARE_LT_GT' => 162,
			'OP08_STRING_CAT' => 163,
			'OP16_LOGICAL_OR' => 155,
			")" => 401,
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP17_LIST_RANGE' => 169,
			'OP24_LOGICAL_OR_XOR' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP13_BITWISE_AND' => 170
		}
	},
	{#State 397
		DEFAULT => -156
	},
	{#State 398
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 154,
			'OP16_LOGICAL_OR' => 155,
			'OP08_STRING_CAT' => 163,
			'OP11_COMPARE_LT_GT' => 162,
			")" => 402,
			'OP09_BITWISE_SHIFT' => 156,
			'OP14_BITWISE_OR_XOR' => 164,
			'OP15_LOGICAL_AND' => 166,
			'OP18_TERNARY' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => undef,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP04_MATH_POW' => 168,
			'OP12_COMPARE_EQ_NE' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 159,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 160,
			'OP06_REGEX_MATCH' => 161
		}
	},
	{#State 399
		ACTIONS => {
			'WORD' => 24,
			"}" => 403,
			'LPAREN' => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 84,
			'OP01_NAMED_VOID' => 85,
			'OP01_CLOSE' => 82,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 86,
			"for" => -139,
			'OP10_NAMED_UNARY' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 91,
			"if" => 92,
			'LITERAL_NUMBER' => 95,
			"\@{" => 102,
			'WORD_UPPERCASE' => 104,
			'LITERAL_STRING' => 98,
			"undef" => 97,
			"my" => 106,
			'LBRACKET' => 105,
			"foreach" => -139,
			"%{" => 108,
			'OP19_LOOP_CONTROL' => 109,
			'OP19_LOOP_CONTROL_SCOLON' => 111,
			'OP01_PRINT' => 115,
			'OP01_NAMED' => 117,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'OP22_LOGICAL_NEG' => 123,
			'VARIABLE_SYMBOL' => 121,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'Variable' => 80,
			'Literal' => 101,
			'LoopLabel' => 103,
			'OPTIONAL-35' => 99,
			'Conditional' => 100,
			'HashReference' => 110,
			'Operator' => 83,
			'ArrayReference' => 107,
			'Operation' => 404,
			'PAREN-34' => 114,
			'SubExpression' => 88,
			'OperatorVoid' => 113,
			'Expression' => 87,
			'Statement' => 112,
			'WordScoped' => 96,
			'HashDereference' => 122,
			'ArrayDereference' => 94,
			'VariableModification' => 119,
			'VariableDeclaration' => 116
		}
	},
	{#State 400
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 405
		}
	},
	{#State 401
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 406
		}
	},
	{#State 402
		ACTIONS => {
			'LBRACE' => 332
		},
		GOTOS => {
			'CodeBlock' => 407
		}
	},
	{#State 403
		ACTIONS => {
			";" => 408
		}
	},
	{#State 404
		DEFAULT => -67
	},
	{#State 405
		ACTIONS => {
			'OP21_LIST_COMMA' => 409,
			")" => 411
		},
		GOTOS => {
			'PAREN-28' => 410
		}
	},
	{#State 406
		DEFAULT => -145
	},
	{#State 407
		DEFAULT => -155
	},
	{#State 408
		DEFAULT => -69
	},
	{#State 409
		ACTIONS => {
			"my" => 412
		}
	},
	{#State 410
		DEFAULT => -71
	},
	{#State 411
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 412
		ACTIONS => {
			'WORD' => 56,
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


#line 7952 lib/RPerl/Grammar.pm



1;
