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
    our $VERSION = 0.000_994;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach|\=\ sub\ \{|package|\$TYPED_|while|elsif|undef|else|use|our|\@_\;|for|\%\{|\@\{|if|my|\)|\;|\]|\})}gc and return ($1, $1);

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
			"## no critic qw(" => 3,
			"package" => -20,
			'SHEBANG' => 9
		},
		GOTOS => {
			'PAREN-1' => 8,
			'Critic' => 4,
			'CompileUnit' => 5,
			'ModuleHeader' => 7,
			'OPTIONAL-9' => 1,
			'Program' => 6,
			'PLUS-2' => 2
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => 3,
			'' => -5,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 11,
			'Critic' => 4,
			'ModuleHeader' => 7,
			'OPTIONAL-9' => 1
		}
	},
	{#State 3
		ACTIONS => {
			'WORD' => 13
		},
		GOTOS => {
			'PLUS-14' => 12
		}
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		ACTIONS => {
			'' => 14
		}
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => -25,
			"our" => -25,
			"use parent qw(" => 16,
			"use" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'STAR-10' => 17,
			'Class' => 15,
			'Package' => 19,
			'Module' => 18
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => 3,
			"use strict;" => -7
		},
		GOTOS => {
			'Critic' => 21,
			'OPTIONAL-3' => 20
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
		DEFAULT => -2
	},
	{#State 12
		ACTIONS => {
			")" => 25,
			'WORD' => 26
		}
	},
	{#State 13
		DEFAULT => -35
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		DEFAULT => -23
	},
	{#State 16
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 17
		ACTIONS => {
			"use constant" => -27,
			"use" => -27,
			"## no critic qw(" => 3,
			"our" => -27
		},
		GOTOS => {
			'Critic' => 29,
			'STAR-11' => 28
		}
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		DEFAULT => -22
	},
	{#State 20
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 21
		DEFAULT => -6
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
		DEFAULT => -36
	},
	{#State 26
		DEFAULT => -34
	},
	{#State 27
		ACTIONS => {
			")" => 33
		}
	},
	{#State 28
		ACTIONS => {
			"use constant" => -29,
			"use" => 35,
			"our" => -29
		},
		GOTOS => {
			'Include' => 34,
			'STAR-12' => 36
		}
	},
	{#State 29
		DEFAULT => -24
	},
	{#State 30
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 31
		ACTIONS => {
			"use warnings;" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 31
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
			'WORD' => 24,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 41
		}
	},
	{#State 36
		ACTIONS => {
			"our" => 42,
			"use constant" => 44
		},
		GOTOS => {
			'PLUS-13' => 45,
			'Constant' => 46,
			'Subroutine' => 43
		}
	},
	{#State 37
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"## no critic qw(" => 3,
			"if" => -11,
			"use" => -11,
			"use constant" => -11,
			'WORD' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			"while" => -11,
			"our" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LITERAL_NUMBER' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"foreach" => -11,
			"%{" => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_CLOSE' => -11,
			"my" => -11,
			'LITERAL_STRING' => -11,
			'OP01_OPEN' => -11,
			'LPAREN' => -11,
			'OP01_NAMED' => -11,
			"undef" => -11,
			"\@{" => -11,
			'LBRACKET' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP01_PRINT' => -11,
			'WORD_SCOPED' => -11
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
			"use" => 35
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 41
		ACTIONS => {
			";" => 51,
			'OP01_QW' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 43
		DEFAULT => -31
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 56
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 58,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 46
		DEFAULT => -28
	},
	{#State 47
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -13,
			"\@{" => -13,
			'LBRACKET' => -13,
			'OP01_PRINT' => -13,
			'WORD_SCOPED' => -13,
			'LBRACE' => -13,
			'VARIABLE_SYMBOL' => -13,
			'LITERAL_STRING' => -13,
			'OP01_OPEN' => -13,
			'LPAREN' => -13,
			'OP01_NAMED' => -13,
			"undef" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP10_NAMED_UNARY' => -13,
			"foreach" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LITERAL_NUMBER' => -13,
			"my" => -13,
			"%{" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"for" => -13,
			'WORD_UPPERCASE' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"if" => -13,
			"use" => 35,
			"use constant" => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"while" => -13,
			"our" => -13
		},
		GOTOS => {
			'STAR-6' => 60,
			'Include' => 59
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
		DEFAULT => -39
	},
	{#State 52
		ACTIONS => {
			'WORD' => 64
		},
		GOTOS => {
			'PLUS-15' => 63
		}
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 54
		DEFAULT => -205
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
		DEFAULT => -30
	},
	{#State 58
		ACTIONS => {
			";" => 67
		}
	},
	{#State 59
		DEFAULT => -10
	},
	{#State 60
		ACTIONS => {
			'OP01_NAMED' => -15,
			'LPAREN' => -15,
			"undef" => -15,
			'LITERAL_STRING' => -15,
			'OP01_OPEN' => -15,
			'OP01_PRINT' => -15,
			'WORD_SCOPED' => -15,
			'LBRACE' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"\@{" => -15,
			'LBRACKET' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"our" => -15,
			"while" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'WORD_UPPERCASE' => -15,
			"for" => -15,
			"if" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'WORD' => -15,
			"use constant" => 44,
			"my" => -15,
			'OP01_NAMED_VOID' => -15,
			"%{" => -15,
			'OP01_CLOSE' => -15,
			"foreach" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LITERAL_NUMBER' => -15
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
			"our hash_ref \$properties" => -54,
			"use constant" => -54,
			"use" => -54,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 72,
			'STAR-21' => 71
		}
	},
	{#State 63
		ACTIONS => {
			'WORD' => 74,
			")" => 73
		}
	},
	{#State 64
		DEFAULT => -38
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 75
		}
	},
	{#State 66
		ACTIONS => {
			"my" => 77
		},
		GOTOS => {
			'TypeInnerConstant' => 76
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'OP19_LOOP_CONTROL' => 94,
			'OP10_NAMED_UNARY' => 90,
			'OP19_LOOP_CONTROL_SCOLON' => 91,
			"foreach" => -139,
			'OP01_CLOSE' => 102,
			"%{" => 99,
			'OP01_NAMED_VOID' => 100,
			"my" => 98,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			"if" => 82,
			'OP05_LOGICAL_NEG' => 81,
			"for" => -139,
			'WORD_UPPERCASE' => 80,
			'OP01_NAMED_VOID_SCOLON' => 78,
			"while" => -139,
			"our" => 42,
			'OP22_LOGICAL_NEG' => 86,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP05_MATH_NEG_LPAREN' => 114,
			'VARIABLE_SYMBOL' => 123,
			'LBRACE' => 122,
			'WORD_SCOPED' => 22,
			'OP01_PRINT' => 120,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'OP01_NAMED' => 109,
			'LPAREN' => 108
		},
		GOTOS => {
			'VariableModification' => 79,
			'HashDereference' => 105,
			'OPTIONAL-35' => 83,
			'WordScoped' => 106,
			'Conditional' => 85,
			'SubExpression' => 107,
			'Subroutine' => 110,
			'LoopLabel' => 89,
			'Expression' => 113,
			'Operator' => 87,
			'Variable' => 88,
			'Statement' => 112,
			'ArrayReference' => 93,
			'VariableDeclaration' => 92,
			'HashReference' => 117,
			'PLUS-8' => 116,
			'PAREN-34' => 119,
			'Literal' => 95,
			'OperatorVoid' => 97,
			'Operation' => 121,
			'ArrayDereference' => 101
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
			"use" => 35,
			"use constant" => -56,
			"our hash_ref \$properties" => -56
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
		ACTIONS => {
			";" => 126
		}
	},
	{#State 74
		DEFAULT => -37
	},
	{#State 75
		ACTIONS => {
			'OP01_NAMED_VOID' => -43,
			"%{" => -43,
			'OP01_CLOSE' => -43,
			"my" => -43,
			'OP19_LOOP_CONTROL' => -43,
			"}" => -43,
			'LITERAL_NUMBER' => -43,
			"foreach" => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			"while" => -43,
			'OP22_LOGICAL_NEG' => -43,
			"if" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'WORD' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'WORD_UPPERCASE' => -43,
			"for" => -43,
			'LBRACE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_PRINT' => -43,
			'WORD_SCOPED' => -43,
			"\@{" => -43,
			'LBRACKET' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_NAMED' => -43,
			'LPAREN' => -43,
			"undef" => -43,
			'LPAREN_MY' => 128,
			'LITERAL_STRING' => -43,
			'OP01_OPEN' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 127,
			'SubroutineArguments' => 129
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'Literal' => 130
		}
	},
	{#State 77
		ACTIONS => {
			'WORD' => 54,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 131
		}
	},
	{#State 78
		DEFAULT => -112
	},
	{#State 79
		DEFAULT => -144
	},
	{#State 80
		ACTIONS => {
			'LPAREN' => 132,
			'COLON' => -204
		}
	},
	{#State 81
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			"%{" => 99,
			'LBRACE' => 122,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 137,
			'WordScoped' => 106,
			'Literal' => 95,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135
		}
	},
	{#State 82
		ACTIONS => {
			'LPAREN' => 138
		}
	},
	{#State 83
		ACTIONS => {
			"while" => 145,
			"foreach" => 141,
			"for" => 143
		},
		GOTOS => {
			'LoopForEach' => 139,
			'Loop' => 140,
			'LoopFor' => 142,
			'LoopWhile' => 144
		}
	},
	{#State 84
		ACTIONS => {
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'Variable' => 146
		}
	},
	{#State 85
		DEFAULT => -140
	},
	{#State 86
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'WORD_SCOPED' => 22,
			'LBRACE' => 122,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102
		},
		GOTOS => {
			'Literal' => 95,
			'WordScoped' => 106,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135,
			'ArrayDereference' => 101,
			'SubExpression' => 147
		}
	},
	{#State 87
		DEFAULT => -121
	},
	{#State 88
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 149,
			'OP19_VARIABLE_ASSIGN_BY' => 151,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP18_TERNARY' => -129,
			'OP19_VARIABLE_ASSIGN' => 148,
			'OP04_MATH_POW' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP03_MATH_INC_DEC' => 150,
			'OP11_COMPARE_LT_GT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP08_STRING_CAT' => -129
		}
	},
	{#State 89
		ACTIONS => {
			'COLON' => 152
		}
	},
	{#State 90
		ACTIONS => {
			'OP07_STRING_REPEAT' => -95,
			'OP01_CLOSE' => 102,
			"%{" => 99,
			'OP10_NAMED_UNARY' => 90,
			'OP21_LIST_COMMA' => -95,
			'LITERAL_NUMBER' => 96,
			"}" => -95,
			"]" => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP22_LOGICAL_NEG' => 86,
			'OP15_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP04_MATH_POW' => -95,
			'WORD_UPPERCASE' => 134,
			'OP17_LIST_RANGE' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			";" => -95,
			'WORD_SCOPED' => 22,
			'OP08_MATH_ADD_SUB' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'VARIABLE_SYMBOL' => 123,
			'OP13_BITWISE_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'LBRACE' => 122,
			'OP05_MATH_NEG_LPAREN' => 114,
			")" => -95,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			"undef" => 111,
			'OP08_STRING_CAT' => -95,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP18_TERNARY' => -95,
			'OP23_LOGICAL_AND' => -95
		},
		GOTOS => {
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'WordScoped' => 106,
			'Literal' => 95,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'SubExpression' => 153,
			'ArrayDereference' => 101
		}
	},
	{#State 91
		DEFAULT => -115
	},
	{#State 92
		DEFAULT => -143
	},
	{#State 93
		DEFAULT => -130
	},
	{#State 94
		ACTIONS => {
			'WORD_UPPERCASE' => 155
		},
		GOTOS => {
			'LoopLabel' => 154
		}
	},
	{#State 95
		DEFAULT => -128
	},
	{#State 96
		DEFAULT => -212
	},
	{#State 97
		DEFAULT => -142
	},
	{#State 98
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 156
		}
	},
	{#State 99
		ACTIONS => {
			"my" => 159,
			'LBRACE' => -199,
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'OPTIONAL-50' => 158,
			'TypeInner' => 157,
			'Variable' => 160
		}
	},
	{#State 100
		ACTIONS => {
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 86,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			"my" => 159,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 106,
			'Literal' => 95,
			'ListElement' => 162,
			'ListElements' => 161,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135,
			'ArrayDereference' => 101,
			'SubExpression' => 163,
			'TypeInner' => 164
		}
	},
	{#State 101
		DEFAULT => -131
	},
	{#State 102
		ACTIONS => {
			'FH_REF_SYMBOL' => 166
		}
	},
	{#State 103
		DEFAULT => -211
	},
	{#State 104
		ACTIONS => {
			"my" => 167
		}
	},
	{#State 105
		DEFAULT => -133
	},
	{#State 106
		ACTIONS => {
			'LPAREN' => 168,
			'OP02_METHOD_THINARROW_NEW' => 169
		}
	},
	{#State 107
		ACTIONS => {
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			'OP11_COMPARE_LT_GT' => 170,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => 178,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 179
		}
	},
	{#State 108
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'OP01_PRINT' => 189,
			'WORD_SCOPED' => 22,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'LPAREN' => 108,
			'OP01_NAMED' => 187,
			"undef" => 111
		},
		GOTOS => {
			'Literal' => 95,
			'WordScoped' => 106,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'ArrayDereference' => 101,
			'SubExpression' => 188
		}
	},
	{#State 109
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"my" => 159,
			'WORD_SCOPED' => 22,
			'LBRACE' => 122,
			"%{" => 99,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'OP01_QW' => 165
		},
		GOTOS => {
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117,
			'ListElement' => 190,
			'WordScoped' => 106,
			'Literal' => 95,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'ArrayDereference' => 101,
			'TypeInner' => 164,
			'SubExpression' => 191
		}
	},
	{#State 110
		DEFAULT => -14
	},
	{#State 111
		DEFAULT => -127
	},
	{#State 112
		DEFAULT => -77
	},
	{#State 113
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			";" => 192,
			'OP04_MATH_POW' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP18_TERNARY' => -126,
			'OP08_STRING_CAT' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP07_STRING_REPEAT' => -126
		}
	},
	{#State 114
		ACTIONS => {
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			"%{" => 99,
			'LBRACE' => 122,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 193,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135
		}
	},
	{#State 115
		ACTIONS => {
			"my" => 159,
			'LBRACKET' => -184,
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'TypeInner' => 195,
			'OPTIONAL-46' => 196,
			'Variable' => 194
		}
	},
	{#State 116
		ACTIONS => {
			"foreach" => -139,
			'OP19_LOOP_CONTROL_SCOLON' => 91,
			'OP10_NAMED_UNARY' => 90,
			'LITERAL_NUMBER' => 96,
			'OP19_LOOP_CONTROL' => 94,
			"my" => 98,
			'OP01_CLOSE' => 102,
			"%{" => 99,
			'OP01_NAMED_VOID' => 100,
			'WORD_UPPERCASE' => 80,
			"for" => -139,
			'OP01_NAMED_VOID_SCOLON' => 78,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			"if" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'OP22_LOGICAL_NEG' => 86,
			'' => -18,
			"while" => -139,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LBRACKET' => 118,
			"\@{" => 115,
			'WORD_SCOPED' => 22,
			'OP01_PRINT' => 120,
			'VARIABLE_SYMBOL' => 123,
			'LBRACE' => 122,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'OP01_NAMED' => 109,
			'LPAREN' => 108
		},
		GOTOS => {
			'OperatorVoid' => 97,
			'Operation' => 197,
			'ArrayDereference' => 101,
			'LoopLabel' => 89,
			'Expression' => 113,
			'Variable' => 88,
			'Operator' => 87,
			'Statement' => 112,
			'ArrayReference' => 93,
			'VariableDeclaration' => 92,
			'HashReference' => 117,
			'PAREN-34' => 119,
			'Literal' => 95,
			'Conditional' => 85,
			'SubExpression' => 107,
			'VariableModification' => 79,
			'HashDereference' => 105,
			'OPTIONAL-35' => 83,
			'WordScoped' => 106
		}
	},
	{#State 117
		DEFAULT => -132
	},
	{#State 118
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			"my" => 159,
			'WORD_SCOPED' => 22,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			"]" => -181
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 163,
			'OPTIONAL-45' => 199,
			'TypeInner' => 164,
			'Literal' => 95,
			'WordScoped' => 106,
			'ListElement' => 162,
			'ListElements' => 198,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135
		}
	},
	{#State 119
		DEFAULT => -138
	},
	{#State 120
		ACTIONS => {
			"my" => -109,
			'WORD_SCOPED' => -109,
			'OP01_CLOSE' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP01_QW' => -109,
			'LBRACE' => -109,
			"%{" => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'LBRACKET' => -109,
			'LITERAL_NUMBER' => -109,
			"\@{" => -109,
			'STDOUT_STDERR' => 202,
			'OP22_LOGICAL_NEG' => -109,
			"undef" => -109,
			'OP01_NAMED' => -109,
			'LPAREN' => -109,
			'WORD_UPPERCASE' => -109,
			'OP01_OPEN' => -109,
			'FH_REF_SYMBOL_BRACES' => 201,
			'LITERAL_STRING' => -109,
			'WORD' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'OP03_MATH_INC_DEC' => -109
		},
		GOTOS => {
			'PAREN-30' => 200,
			'OPTIONAL-31' => 203
		}
	},
	{#State 121
		DEFAULT => -17
	},
	{#State 122
		ACTIONS => {
			"}" => 206,
			"%{" => 99,
			'WORD' => 207
		},
		GOTOS => {
			'HashDereference' => 205,
			'HashEntry' => 204
		}
	},
	{#State 123
		DEFAULT => -162,
		GOTOS => {
			'STAR-41' => 208
		}
	},
	{#State 124
		ACTIONS => {
			"our hash_ref \$properties" => 210,
			"use constant" => 44
		},
		GOTOS => {
			'Constant' => 209,
			'Properties' => 211
		}
	},
	{#State 125
		DEFAULT => -53
	},
	{#State 126
		DEFAULT => -40
	},
	{#State 127
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 212
		}
	},
	{#State 128
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 213
		}
	},
	{#State 129
		DEFAULT => -42
	},
	{#State 130
		ACTIONS => {
			";" => 214
		}
	},
	{#State 131
		ACTIONS => {
			"\$TYPED_" => 215
		}
	},
	{#State 132
		ACTIONS => {
			")" => 216
		}
	},
	{#State 133
		ACTIONS => {
			'OP06_REGEX_MATCH' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP08_STRING_CAT' => -129,
			'OP18_TERNARY' => -129,
			'OP04_MATH_POW' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP03_MATH_INC_DEC' => 150,
			";" => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP02_METHOD_THINARROW' => 149,
			"}" => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			"]" => -129,
			")" => -129
		}
	},
	{#State 134
		ACTIONS => {
			'LPAREN' => 132
		}
	},
	{#State 135
		DEFAULT => -126
	},
	{#State 136
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'LBRACE' => 122,
			"%{" => 99,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 217,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'Expression' => 135,
			'Variable' => 133,
			'Operator' => 87
		}
	},
	{#State 137
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			"]" => -86,
			"}" => -86,
			")" => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP08_STRING_CAT' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP18_TERNARY' => -86,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -86,
			";" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP23_LOGICAL_AND' => -86
		}
	},
	{#State 138
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'WORD_SCOPED' => 22,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 218,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117,
			'WordScoped' => 106,
			'Literal' => 95,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133
		}
	},
	{#State 139
		DEFAULT => -153
	},
	{#State 140
		DEFAULT => -141
	},
	{#State 141
		ACTIONS => {
			"my" => 219
		}
	},
	{#State 142
		DEFAULT => -152
	},
	{#State 143
		ACTIONS => {
			"my" => 220
		}
	},
	{#State 144
		DEFAULT => -154
	},
	{#State 145
		ACTIONS => {
			'LPAREN' => 221
		}
	},
	{#State 146
		DEFAULT => -83
	},
	{#State 147
		ACTIONS => {
			'OP15_LOGICAL_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => 179,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			";" => -104,
			'OP11_COMPARE_LT_GT' => 170,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => -104,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP08_MATH_ADD_SUB' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 183,
			'OP21_LIST_COMMA' => -104,
			"]" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"}" => -104,
			")" => -104
		}
	},
	{#State 148
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 86,
			'STDIN' => 223
		},
		GOTOS => {
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117,
			'WordScoped' => 106,
			'Literal' => 95,
			'SubExpressionOrStdin' => 222,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'ArrayDereference' => 101,
			'SubExpression' => 224
		}
	},
	{#State 149
		ACTIONS => {
			'LPAREN' => 225
		}
	},
	{#State 150
		DEFAULT => -84
	},
	{#State 151
		ACTIONS => {
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'WORD_SCOPED' => 22,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			"%{" => 99,
			'LBRACE' => 122,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108
		},
		GOTOS => {
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Literal' => 95,
			'WordScoped' => 106,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'ArrayDereference' => 101,
			'SubExpression' => 226
		}
	},
	{#State 152
		DEFAULT => -137
	},
	{#State 153
		ACTIONS => {
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => -94,
			'OP18_TERNARY' => -94,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -94,
			";" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 185,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			"}" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"]" => -94,
			")" => -94
		}
	},
	{#State 154
		ACTIONS => {
			";" => 227
		}
	},
	{#State 155
		DEFAULT => -204
	},
	{#State 156
		ACTIONS => {
			'VARIABLE_SYMBOL' => 228
		}
	},
	{#State 157
		DEFAULT => -198
	},
	{#State 158
		ACTIONS => {
			'LBRACE' => 122
		},
		GOTOS => {
			'HashReference' => 229
		}
	},
	{#State 159
		ACTIONS => {
			'WORD' => 54,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 230
		}
	},
	{#State 160
		ACTIONS => {
			"}" => 231
		}
	},
	{#State 161
		ACTIONS => {
			";" => 232
		}
	},
	{#State 162
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 233
		}
	},
	{#State 163
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP21_LIST_COMMA' => -177,
			")" => -177,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"]" => -177,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 179,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -177
		}
	},
	{#State 164
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'LBRACE' => 122,
			"%{" => 99,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'WordScoped' => 106,
			'Literal' => 95,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'SubExpression' => 234,
			'ArrayDereference' => 101
		}
	},
	{#State 165
		ACTIONS => {
			'WORD' => 235
		},
		GOTOS => {
			'PLUS-44' => 236
		}
	},
	{#State 166
		DEFAULT => -82
	},
	{#State 167
		ACTIONS => {
			"filehandle_ref" => 237
		}
	},
	{#State 168
		ACTIONS => {
			'LBRACE' => 122,
			"%{" => 99,
			'OP01_CLOSE' => 102,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 123,
			'WORD_SCOPED' => 22,
			"my" => 159,
			"\@{" => 115,
			'LBRACKET' => 118,
			")" => -118,
			'LITERAL_NUMBER' => 96,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'OP22_LOGICAL_NEG' => 86,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 163,
			'TypeInner' => 164,
			'WordScoped' => 106,
			'Literal' => 95,
			'ListElement' => 162,
			'ListElements' => 239,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'OPTIONAL-32' => 238,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135
		}
	},
	{#State 169
		ACTIONS => {
			")" => 240
		}
	},
	{#State 170
		ACTIONS => {
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'WORD_SCOPED' => 22,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'OP22_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 241,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'Literal' => 95,
			'WordScoped' => 106,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135
		}
	},
	{#State 171
		ACTIONS => {
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 86,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'WordScoped' => 106,
			'Literal' => 95,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135,
			'ArrayDereference' => 101,
			'SubExpression' => 242
		}
	},
	{#State 172
		ACTIONS => {
			'LBRACE' => 122,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'WORD_SCOPED' => 22,
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'OP22_LOGICAL_NEG' => 86,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 24,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 243,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135
		}
	},
	{#State 173
		ACTIONS => {
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 122,
			"%{" => 99,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'WORD_SCOPED' => 22,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'OP22_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'SubExpression' => 244,
			'ArrayDereference' => 101,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'WordScoped' => 106,
			'Literal' => 95
		}
	},
	{#State 174
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 86,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'WORD_SCOPED' => 22,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117,
			'Literal' => 95,
			'WordScoped' => 106,
			'Expression' => 135,
			'Variable' => 133,
			'Operator' => 87,
			'ArrayDereference' => 101,
			'SubExpression' => 245
		}
	},
	{#State 175
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'WORD_SCOPED' => 22,
			'LBRACE' => 122,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102
		},
		GOTOS => {
			'SubExpression' => 246,
			'ArrayDereference' => 101,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'Literal' => 95,
			'WordScoped' => 106,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117
		}
	},
	{#State 176
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 247
		}
	},
	{#State 177
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			"%{" => 99,
			'LBRACE' => 122,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81
		},
		GOTOS => {
			'SubExpression' => 248,
			'ArrayDereference' => 101,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'WordScoped' => 106,
			'Literal' => 95,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117
		}
	},
	{#State 178
		ACTIONS => {
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			"%{" => 99,
			'LBRACE' => 122,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 249,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135
		}
	},
	{#State 179
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'VARIABLE_SYMBOL' => 123,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'Literal' => 251,
			'VariableOrLiteral' => 252,
			'Variable' => 250
		}
	},
	{#State 180
		ACTIONS => {
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			'LBRACE' => 122,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'WORD_SCOPED' => 22,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 24,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'OP22_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'WordScoped' => 106,
			'Literal' => 95,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'SubExpression' => 253,
			'ArrayDereference' => 101
		}
	},
	{#State 181
		ACTIONS => {
			'WORD_SCOPED' => 22,
			"%{" => 99,
			'LBRACE' => 122,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'OP22_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 24
		},
		GOTOS => {
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'Literal' => 95,
			'WordScoped' => 106,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117,
			'SubExpression' => 254,
			'ArrayDereference' => 101
		}
	},
	{#State 182
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81
		},
		GOTOS => {
			'Literal' => 95,
			'WordScoped' => 106,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'ArrayDereference' => 101,
			'SubExpression' => 255
		}
	},
	{#State 183
		ACTIONS => {
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			"%{" => 99,
			'LBRACE' => 122,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'WordScoped' => 106,
			'Literal' => 95,
			'SubExpression' => 256,
			'ArrayDereference' => 101
		}
	},
	{#State 184
		ACTIONS => {
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 86,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			"%{" => 99,
			'LBRACE' => 122,
			'WORD_SCOPED' => 22
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 257,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'Literal' => 95,
			'WordScoped' => 106,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133
		}
	},
	{#State 185
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'WORD_SCOPED' => 22,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 258,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'Literal' => 95,
			'WordScoped' => 106,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135
		}
	},
	{#State 186
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81
		},
		GOTOS => {
			'Expression' => 135,
			'Variable' => 133,
			'Operator' => 87,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'WordScoped' => 106,
			'Literal' => 95,
			'SubExpression' => 259,
			'ArrayDereference' => 101
		}
	},
	{#State 187
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 86,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			"my" => 159,
			'WORD_SCOPED' => 22,
			'LBRACE' => 122,
			"%{" => 99,
			'OP01_CLOSE' => 102,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'TypeInner' => 164,
			'SubExpression' => 191,
			'ArrayDereference' => 101,
			'Expression' => 135,
			'Variable' => 133,
			'Operator' => 87,
			'ListElement' => 260,
			'Literal' => 95,
			'WordScoped' => 106,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117
		}
	},
	{#State 188
		ACTIONS => {
			")" => 261,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 183,
			'OP17_LIST_RANGE' => 172,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => 178,
			'OP15_LOGICAL_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 174
		}
	},
	{#State 189
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 262
		}
	},
	{#State 190
		ACTIONS => {
			'OP21_LIST_COMMA' => 263
		}
	},
	{#State 191
		ACTIONS => {
			'OP13_BITWISE_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			")" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP21_LIST_COMMA' => -177,
			'OP16_LOGICAL_OR' => -79,
			'OP08_STRING_CAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			";" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP04_MATH_POW' => -79,
			'OP18_TERNARY' => -79
		}
	},
	{#State 192
		DEFAULT => -76
	},
	{#State 193
		ACTIONS => {
			")" => 264,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 175,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180
		}
	},
	{#State 194
		ACTIONS => {
			"}" => 265
		}
	},
	{#State 195
		DEFAULT => -183
	},
	{#State 196
		ACTIONS => {
			'LBRACKET' => 118
		},
		GOTOS => {
			'ArrayReference' => 266
		}
	},
	{#State 197
		DEFAULT => -16
	},
	{#State 198
		DEFAULT => -180
	},
	{#State 199
		ACTIONS => {
			"]" => 267
		}
	},
	{#State 200
		DEFAULT => -108
	},
	{#State 201
		ACTIONS => {
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 86,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'VARIABLE_SYMBOL' => 123,
			'OP01_QW' => 165,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			'WORD_SCOPED' => 22,
			"my" => 159
		},
		GOTOS => {
			'SubExpression' => 163,
			'TypeInner' => 164,
			'ArrayDereference' => 101,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'Literal' => 95,
			'WordScoped' => 106,
			'ListElement' => 162,
			'ListElements' => 268
		}
	},
	{#State 202
		DEFAULT => -107
	},
	{#State 203
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"my" => 159,
			'WORD_SCOPED' => 22,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'OP01_QW' => 165
		},
		GOTOS => {
			'SubExpression' => 163,
			'TypeInner' => 164,
			'ArrayDereference' => 101,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'Literal' => 95,
			'WordScoped' => 106,
			'ListElement' => 162,
			'ListElements' => 269,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105
		}
	},
	{#State 204
		DEFAULT => -195,
		GOTOS => {
			'STAR-49' => 270
		}
	},
	{#State 205
		DEFAULT => -190
	},
	{#State 206
		DEFAULT => -197
	},
	{#State 207
		ACTIONS => {
			'OP20_HASH_FATARROW' => 271
		}
	},
	{#State 208
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 273,
			'OP13_BITWISE_AND' => -163,
			'OP09_BITWISE_SHIFT' => -163,
			'OP08_MATH_ADD_SUB' => -163,
			'OP07_STRING_REPEAT' => -163,
			'OP24_LOGICAL_OR_XOR' => -163,
			'COLON' => -163,
			")" => -163,
			"}" => -163,
			'OP07_MATH_MULT_DIV_MOD' => -163,
			"]" => -163,
			'OP19_VARIABLE_ASSIGN_BY' => -163,
			'OP21_LIST_COMMA' => -163,
			'OP02_METHOD_THINARROW' => -163,
			'OP08_STRING_CAT' => -163,
			'OP16_LOGICAL_OR' => -163,
			'OP06_REGEX_MATCH' => -163,
			'OP14_BITWISE_OR_XOR' => -163,
			'OP15_LOGICAL_AND' => -163,
			'OP12_COMPARE_EQ_NE' => -163,
			'OP23_LOGICAL_AND' => -163,
			'OP02_HASH_THINARROW' => 272,
			'OP11_COMPARE_LT_GT' => -163,
			'OP03_MATH_INC_DEC' => -163,
			";" => -163,
			'OP04_MATH_POW' => -163,
			'OP17_LIST_RANGE' => -163,
			'OP19_VARIABLE_ASSIGN' => -163,
			'OP18_TERNARY' => -163
		},
		GOTOS => {
			'VariableRetrieval' => 274
		}
	},
	{#State 209
		DEFAULT => -55
	},
	{#State 210
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 275
		}
	},
	{#State 211
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 276
		}
	},
	{#State 212
		ACTIONS => {
			"my" => 98,
			'OP01_NAMED_VOID' => 100,
			"%{" => 99,
			'OP01_CLOSE' => 102,
			"foreach" => -139,
			'OP19_LOOP_CONTROL_SCOLON' => 91,
			'OP10_NAMED_UNARY' => 90,
			"}" => 278,
			'OP19_LOOP_CONTROL' => 94,
			'LITERAL_NUMBER' => 96,
			'OP22_LOGICAL_NEG' => 86,
			"while" => -139,
			'OP01_NAMED_VOID_SCOLON' => 78,
			'WORD_UPPERCASE' => 80,
			"for" => -139,
			'OP05_LOGICAL_NEG' => 81,
			"if" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP01_PRINT' => 120,
			'WORD_SCOPED' => 22,
			'LBRACE' => 122,
			'VARIABLE_SYMBOL' => 123,
			'OP05_MATH_NEG_LPAREN' => 114,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LPAREN' => 108,
			'OP01_NAMED' => 109,
			"undef" => 111,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104
		},
		GOTOS => {
			'SubExpression' => 107,
			'Conditional' => 85,
			'VariableModification' => 79,
			'WordScoped' => 106,
			'HashDereference' => 105,
			'OPTIONAL-35' => 83,
			'OperatorVoid' => 97,
			'Operation' => 277,
			'ArrayDereference' => 101,
			'Expression' => 113,
			'LoopLabel' => 89,
			'Operator' => 87,
			'Statement' => 112,
			'Variable' => 88,
			'PAREN-34' => 119,
			'Literal' => 95,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'VariableDeclaration' => 92
		}
	},
	{#State 213
		ACTIONS => {
			'VARIABLE_SYMBOL' => 279
		}
	},
	{#State 214
		DEFAULT => -41
	},
	{#State 215
		ACTIONS => {
			'WORD_UPPERCASE' => 280
		}
	},
	{#State 216
		DEFAULT => -123
	},
	{#State 217
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP21_LIST_COMMA' => -79,
			"}" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			"]" => -79,
			")" => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP08_STRING_CAT' => -79,
			'OP18_TERNARY' => -79,
			'OP04_MATH_POW' => -79,
			'OP17_LIST_RANGE' => -79,
			";" => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP11_COMPARE_LT_GT' => -79
		}
	},
	{#State 218
		ACTIONS => {
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP15_LOGICAL_AND' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 179,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			")" => 281,
			'OP07_MATH_MULT_DIV_MOD' => 182
		}
	},
	{#State 219
		ACTIONS => {
			'WORD' => 54,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 282
		}
	},
	{#State 220
		ACTIONS => {
			'TYPE_INTEGER' => 283
		}
	},
	{#State 221
		ACTIONS => {
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 86,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'LBRACE' => 122,
			"%{" => 99,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 284,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'WordScoped' => 106,
			'Literal' => 95,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135
		}
	},
	{#State 222
		ACTIONS => {
			";" => 285
		}
	},
	{#State 223
		DEFAULT => -136
	},
	{#State 224
		ACTIONS => {
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP15_LOGICAL_AND' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => 181,
			";" => -135,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP18_TERNARY' => 179,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172
		}
	},
	{#State 225
		ACTIONS => {
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'OP01_QW' => 165,
			'LBRACE' => 122,
			"%{" => 99,
			"my" => 159,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 118,
			")" => -120,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 86,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'TypeInner' => 164,
			'SubExpression' => 163,
			'ArrayDereference' => 101,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'ListElements' => 287,
			'ListElement' => 162,
			'WordScoped' => 106,
			'Literal' => 95,
			'OPTIONAL-33' => 286
		}
	},
	{#State 226
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 171,
			";" => 288,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180
		}
	},
	{#State 227
		DEFAULT => -116
	},
	{#State 228
		ACTIONS => {
			";" => 289,
			'OP19_VARIABLE_ASSIGN' => 290
		}
	},
	{#State 229
		ACTIONS => {
			"}" => 291
		}
	},
	{#State 230
		ACTIONS => {
			"\$TYPED_" => 292
		}
	},
	{#State 231
		DEFAULT => -200
	},
	{#State 232
		DEFAULT => -113
	},
	{#State 233
		ACTIONS => {
			'OP21_LIST_COMMA' => 293,
			")" => -174,
			"]" => -174,
			";" => -174
		},
		GOTOS => {
			'PAREN-42' => 294
		}
	},
	{#State 234
		ACTIONS => {
			'OP21_LIST_COMMA' => -178,
			")" => -178,
			"]" => -178,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP17_LIST_RANGE' => 172,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 171,
			";" => -178,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 175,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180
		}
	},
	{#State 235
		DEFAULT => -176
	},
	{#State 236
		ACTIONS => {
			")" => 296,
			'WORD' => 295
		}
	},
	{#State 237
		ACTIONS => {
			'FH_REF_SYMBOL' => 297
		}
	},
	{#State 238
		ACTIONS => {
			")" => 298
		}
	},
	{#State 239
		DEFAULT => -117
	},
	{#State 240
		DEFAULT => -125
	},
	{#State 241
		ACTIONS => {
			'OP16_LOGICAL_OR' => -96,
			'OP08_STRING_CAT' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			";" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP18_TERNARY' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 185,
			"}" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"]" => -96,
			")" => -96,
			'OP21_LIST_COMMA' => -96
		}
	},
	{#State 242
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -97,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => -97,
			'OP09_BITWISE_SHIFT' => 184,
			'OP21_LIST_COMMA' => -97,
			")" => -97,
			"}" => -97,
			"]" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 182
		}
	},
	{#State 243
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => -102,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => undef,
			";" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 185,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP21_LIST_COMMA' => -102,
			"}" => -102,
			"]" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			")" => -102
		}
	},
	{#State 244
		ACTIONS => {
			'OP16_LOGICAL_OR' => -85,
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP15_LOGICAL_AND' => -85,
			";" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP18_TERNARY' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP04_MATH_POW' => 173,
			'OP09_BITWISE_SHIFT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			"}" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			"]" => -85,
			")" => -85,
			'OP21_LIST_COMMA' => -85
		}
	},
	{#State 245
		ACTIONS => {
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => 185,
			"]" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"}" => -101,
			")" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => -101,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 181,
			";" => -101,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => -101,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP18_TERNARY' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP04_MATH_POW' => 173
		}
	},
	{#State 246
		ACTIONS => {
			'OP21_LIST_COMMA' => -100,
			"}" => -100,
			"]" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			")" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 185,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP18_TERNARY' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP04_MATH_POW' => 173,
			";" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP16_LOGICAL_OR' => -100,
			'OP08_STRING_CAT' => 180
		}
	},
	{#State 247
		DEFAULT => -88
	},
	{#State 248
		ACTIONS => {
			'OP16_LOGICAL_OR' => -89,
			'OP08_STRING_CAT' => -89,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			";" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP07_STRING_REPEAT' => -89,
			")" => -89,
			"}" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			"]" => -89,
			'OP21_LIST_COMMA' => -89
		}
	},
	{#State 249
		ACTIONS => {
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP08_MATH_ADD_SUB' => 185,
			"}" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"]" => -105,
			")" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 174,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			";" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP18_TERNARY' => 179,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172
		}
	},
	{#State 250
		DEFAULT => -209
	},
	{#State 251
		DEFAULT => -210
	},
	{#State 252
		ACTIONS => {
			'COLON' => 299
		}
	},
	{#State 253
		ACTIONS => {
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP08_STRING_CAT' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -92,
			'OP18_TERNARY' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP23_LOGICAL_AND' => -92,
			";" => -92,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP07_STRING_REPEAT' => 177,
			'OP09_BITWISE_SHIFT' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP21_LIST_COMMA' => -92,
			")" => -92,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"]" => -92,
			"}" => -92
		}
	},
	{#State 254
		ACTIONS => {
			'OP17_LIST_RANGE' => -99,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => -99,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => 176,
			'OP16_LOGICAL_OR' => -99,
			'OP08_STRING_CAT' => 180,
			'OP21_LIST_COMMA' => -99,
			")" => -99,
			"}" => -99,
			"]" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184
		}
	},
	{#State 255
		ACTIONS => {
			'OP21_LIST_COMMA' => -90,
			")" => -90,
			"}" => -90,
			"]" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP07_STRING_REPEAT' => 177,
			'OP09_BITWISE_SHIFT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -90,
			'OP18_TERNARY' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			";" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP06_REGEX_MATCH' => 176,
			'OP16_LOGICAL_OR' => -90,
			'OP08_STRING_CAT' => -90
		}
	},
	{#State 256
		ACTIONS => {
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -98,
			'OP18_TERNARY' => -98,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => -98,
			'OP12_COMPARE_EQ_NE' => 171,
			";" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP06_REGEX_MATCH' => 176,
			'OP16_LOGICAL_OR' => -98,
			'OP08_STRING_CAT' => 180,
			'OP21_LIST_COMMA' => -98,
			")" => -98,
			"]" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"}" => -98,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_STRING_REPEAT' => 177,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => -98
		}
	},
	{#State 257
		ACTIONS => {
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => 185,
			'OP09_BITWISE_SHIFT' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP21_LIST_COMMA' => -93,
			"}" => -93,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"]" => -93,
			")" => -93,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => -93,
			'OP18_TERNARY' => -93,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -93,
			";" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93
		}
	},
	{#State 258
		ACTIONS => {
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"]" => -91,
			"}" => -91,
			")" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP08_STRING_CAT' => -91,
			'OP18_TERNARY' => -91,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => -91,
			";" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP23_LOGICAL_AND' => -91
		}
	},
	{#State 259
		ACTIONS => {
			'OP21_LIST_COMMA' => -106,
			"]" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"}" => -106,
			")" => -106,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => 185,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP18_TERNARY' => 179,
			'OP17_LIST_RANGE' => 172,
			'OP04_MATH_POW' => 173,
			";" => -106,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 174
		}
	},
	{#State 260
		ACTIONS => {
			'OP21_LIST_COMMA' => 300
		}
	},
	{#State 261
		DEFAULT => -134
	},
	{#State 262
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'WORD_SCOPED' => 22,
			"my" => 159,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102
		},
		GOTOS => {
			'Expression' => 135,
			'Variable' => 133,
			'Operator' => 87,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'ListElements' => 301,
			'ListElement' => 162,
			'Literal' => 95,
			'WordScoped' => 106,
			'TypeInner' => 164,
			'SubExpression' => 163,
			'ArrayDereference' => 101
		}
	},
	{#State 263
		ACTIONS => {
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'WORD_SCOPED' => 22,
			"my" => 159,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			"%{" => 99,
			'LBRACE' => 122
		},
		GOTOS => {
			'TypeInner' => 164,
			'SubExpression' => 163,
			'ArrayDereference' => 101,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'ListElement' => 162,
			'ListElements' => 302,
			'WordScoped' => 106,
			'Literal' => 95
		}
	},
	{#State 264
		DEFAULT => -87
	},
	{#State 265
		DEFAULT => -185
	},
	{#State 266
		ACTIONS => {
			"}" => 303
		}
	},
	{#State 267
		DEFAULT => -182
	},
	{#State 268
		ACTIONS => {
			";" => 304
		}
	},
	{#State 269
		ACTIONS => {
			";" => 305
		}
	},
	{#State 270
		ACTIONS => {
			"}" => 307,
			'OP21_LIST_COMMA' => 308
		},
		GOTOS => {
			'PAREN-48' => 306
		}
	},
	{#State 271
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'WORD' => -188,
			'LITERAL_STRING' => -188,
			'WORD_UPPERCASE' => -188,
			'OP01_OPEN' => -188,
			'LPAREN' => -188,
			'OP01_NAMED' => -188,
			"undef" => -188,
			'OP22_LOGICAL_NEG' => -188,
			"\@{" => -188,
			'LBRACKET' => -188,
			'LITERAL_NUMBER' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'OP10_NAMED_UNARY' => -188,
			"%{" => -188,
			'LBRACE' => -188,
			'OP01_CLOSE' => -188,
			'VARIABLE_SYMBOL' => -188,
			"my" => 159,
			'WORD_SCOPED' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 310,
			'TypeInner' => 309
		}
	},
	{#State 272
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'LBRACE' => 122,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'OP22_LOGICAL_NEG' => 86,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 312
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 311,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'WordScoped' => 106,
			'Literal' => 95,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135
		}
	},
	{#State 273
		ACTIONS => {
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'WORD_SCOPED' => 22,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'OP22_LOGICAL_NEG' => 86,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 313,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'Expression' => 135,
			'Variable' => 133,
			'Operator' => 87
		}
	},
	{#State 274
		DEFAULT => -161
	},
	{#State 275
		ACTIONS => {
			'LBRACE' => 314
		}
	},
	{#State 276
		ACTIONS => {
			'LITERAL_NUMBER' => 317,
			"our" => 319
		},
		GOTOS => {
			'MethodOrSubroutine' => 318,
			'Method' => 316,
			'Subroutine' => 315
		}
	},
	{#State 277
		DEFAULT => -44
	},
	{#State 278
		ACTIONS => {
			";" => 320
		}
	},
	{#State 279
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 321
		}
	},
	{#State 280
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 322
		}
	},
	{#State 281
		ACTIONS => {
			'LBRACE' => 324
		},
		GOTOS => {
			'CodeBlock' => 323
		}
	},
	{#State 282
		ACTIONS => {
			'VARIABLE_SYMBOL' => 325
		}
	},
	{#State 283
		ACTIONS => {
			'VARIABLE_SYMBOL' => 326
		}
	},
	{#State 284
		ACTIONS => {
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP15_LOGICAL_AND' => 175,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			")" => 327,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 183
		}
	},
	{#State 285
		DEFAULT => -169
	},
	{#State 286
		ACTIONS => {
			")" => 328
		}
	},
	{#State 287
		DEFAULT => -119
	},
	{#State 288
		DEFAULT => -170
	},
	{#State 289
		DEFAULT => -167
	},
	{#State 290
		ACTIONS => {
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			'WORD_SCOPED' => 22,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 86,
			'STDIN' => 223,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 224,
			'SubExpressionOrStdin' => 329,
			'WordScoped' => 106,
			'Literal' => 95,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135
		}
	},
	{#State 291
		DEFAULT => -201
	},
	{#State 292
		ACTIONS => {
			'WORD' => 330
		}
	},
	{#State 293
		ACTIONS => {
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_QW' => 165,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'WORD_SCOPED' => 22,
			"my" => 159,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 24,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			"undef" => 111,
			'OP22_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'ListElement' => 331,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'ArrayDereference' => 101,
			'TypeInner' => 164,
			'SubExpression' => 163
		}
	},
	{#State 294
		DEFAULT => -172
	},
	{#State 295
		DEFAULT => -175
	},
	{#State 296
		DEFAULT => -179
	},
	{#State 297
		ACTIONS => {
			'OP21_LIST_COMMA' => 332
		}
	},
	{#State 298
		DEFAULT => -122
	},
	{#State 299
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'VARIABLE_SYMBOL' => 123,
			'LITERAL_NUMBER' => 96
		},
		GOTOS => {
			'Literal' => 251,
			'Variable' => 250,
			'VariableOrLiteral' => 333
		}
	},
	{#State 300
		ACTIONS => {
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'WORD_SCOPED' => 22,
			"my" => 159,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'OP01_QW' => 165,
			"%{" => 99,
			'LBRACE' => 122
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 163,
			'TypeInner' => 164,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'Literal' => 95,
			'WordScoped' => 106,
			'ListElement' => 162,
			'ListElements' => 334,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135
		}
	},
	{#State 301
		ACTIONS => {
			")" => 335
		}
	},
	{#State 302
		ACTIONS => {
			";" => 336
		}
	},
	{#State 303
		DEFAULT => -186
	},
	{#State 304
		DEFAULT => -111
	},
	{#State 305
		DEFAULT => -110
	},
	{#State 306
		DEFAULT => -194
	},
	{#State 307
		DEFAULT => -196
	},
	{#State 308
		ACTIONS => {
			'WORD' => 207,
			"%{" => 99
		},
		GOTOS => {
			'HashDereference' => 205,
			'HashEntry' => 337
		}
	},
	{#State 309
		DEFAULT => -187
	},
	{#State 310
		ACTIONS => {
			'WORD_SCOPED' => 22,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			"%{" => 99,
			'LBRACE' => 122,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84
		},
		GOTOS => {
			'SubExpression' => 338,
			'ArrayDereference' => 101,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117
		}
	},
	{#State 311
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 183,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 185,
			"}" => 339,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 174,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP18_TERNARY' => 179,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172
		}
	},
	{#State 312
		ACTIONS => {
			'LPAREN' => -202,
			'OP02_METHOD_THINARROW_NEW' => -202,
			"}" => 340
		}
	},
	{#State 313
		ACTIONS => {
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 175,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP18_TERNARY' => 179,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 185,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			"]" => 341,
			'OP07_MATH_MULT_DIV_MOD' => 182
		}
	},
	{#State 314
		ACTIONS => {
			"}" => 342,
			"%{" => 99,
			'WORD' => 343
		},
		GOTOS => {
			'HashEntryTyped' => 344,
			'HashDereference' => 345
		}
	},
	{#State 315
		DEFAULT => -75
	},
	{#State 316
		DEFAULT => -74
	},
	{#State 317
		ACTIONS => {
			";" => 346
		}
	},
	{#State 318
		DEFAULT => -57
	},
	{#State 319
		ACTIONS => {
			'WORD' => 54,
			'TYPE_METHOD' => 347,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 320
		DEFAULT => -46
	},
	{#State 321
		ACTIONS => {
			")" => 348,
			'OP21_LIST_COMMA' => 349
		},
		GOTOS => {
			'PAREN-18' => 350
		}
	},
	{#State 322
		DEFAULT => -208
	},
	{#State 323
		DEFAULT => -147,
		GOTOS => {
			'STAR-37' => 351
		}
	},
	{#State 324
		ACTIONS => {
			"for" => -139,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 80,
			'LITERAL_STRING' => 103,
			'OP01_NAMED_VOID_SCOLON' => 78,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			"if" => 82,
			'OP05_LOGICAL_NEG' => 81,
			'OP22_LOGICAL_NEG' => 86,
			"undef" => 111,
			"while" => -139,
			'OP01_NAMED' => 109,
			'LPAREN' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 91,
			'OP10_NAMED_UNARY' => 90,
			"foreach" => -139,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'OP19_LOOP_CONTROL' => 94,
			"\@{" => 115,
			'WORD_SCOPED' => 22,
			"my" => 98,
			'OP01_PRINT' => 120,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'OP01_NAMED_VOID' => 100,
			"%{" => 99,
			'LBRACE' => 122
		},
		GOTOS => {
			'HashDereference' => 105,
			'OPTIONAL-35' => 83,
			'WordScoped' => 106,
			'VariableModification' => 79,
			'Conditional' => 85,
			'SubExpression' => 107,
			'ArrayReference' => 93,
			'VariableDeclaration' => 92,
			'PLUS-40' => 353,
			'HashReference' => 117,
			'PAREN-34' => 119,
			'Literal' => 95,
			'Expression' => 113,
			'LoopLabel' => 89,
			'Statement' => 112,
			'Operator' => 87,
			'Variable' => 88,
			'ArrayDereference' => 101,
			'OperatorVoid' => 97,
			'Operation' => 352
		}
	},
	{#State 325
		ACTIONS => {
			'LPAREN' => 354
		}
	},
	{#State 326
		ACTIONS => {
			'LPAREN' => 355
		}
	},
	{#State 327
		ACTIONS => {
			'LBRACE' => 324
		},
		GOTOS => {
			'CodeBlock' => 356
		}
	},
	{#State 328
		DEFAULT => -124
	},
	{#State 329
		ACTIONS => {
			";" => 357
		}
	},
	{#State 330
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 358
		}
	},
	{#State 331
		DEFAULT => -171
	},
	{#State 332
		ACTIONS => {
			'LITERAL_STRING' => 359
		}
	},
	{#State 333
		DEFAULT => -103
	},
	{#State 334
		ACTIONS => {
			")" => 360
		}
	},
	{#State 335
		DEFAULT => -78
	},
	{#State 336
		DEFAULT => -114
	},
	{#State 337
		DEFAULT => -193
	},
	{#State 338
		ACTIONS => {
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 175,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 174,
			'OP17_LIST_RANGE' => 172,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 183,
			'OP21_LIST_COMMA' => -189,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"}" => -189
		}
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
		ACTIONS => {
			";" => 361
		}
	},
	{#State 343
		ACTIONS => {
			'OP20_HASH_FATARROW' => 362
		}
	},
	{#State 344
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 363
		}
	},
	{#State 345
		DEFAULT => -192
	},
	{#State 346
		DEFAULT => -59
	},
	{#State 347
		ACTIONS => {
			'VARIABLE_SYMBOL' => 364
		}
	},
	{#State 348
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 365
		}
	},
	{#State 349
		ACTIONS => {
			"my" => 366
		}
	},
	{#State 350
		DEFAULT => -48
	},
	{#State 351
		ACTIONS => {
			'LITERAL_STRING' => -150,
			'OP01_OPEN' => -150,
			"else" => 367,
			'LPAREN' => -150,
			'OP01_NAMED' => -150,
			"undef" => -150,
			'OP05_MATH_NEG_LPAREN' => -150,
			"\@{" => -150,
			'LBRACKET' => -150,
			'OP01_PRINT' => -150,
			'WORD_SCOPED' => -150,
			'LBRACE' => -150,
			'VARIABLE_SYMBOL' => -150,
			'OP01_NAMED_VOID_SCOLON' => -150,
			"for" => -150,
			'WORD_UPPERCASE' => -150,
			'OP03_MATH_INC_DEC' => -150,
			"if" => -150,
			'OP05_LOGICAL_NEG' => -150,
			'WORD' => -150,
			'OP22_LOGICAL_NEG' => -150,
			"while" => -150,
			'' => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP19_LOOP_CONTROL_SCOLON' => -150,
			"foreach" => -150,
			'OP19_LOOP_CONTROL' => -150,
			"}" => -150,
			'LITERAL_NUMBER' => -150,
			"elsif" => 371,
			"my" => -150,
			'OP01_NAMED_VOID' => -150,
			"%{" => -150,
			'OP01_CLOSE' => -150
		},
		GOTOS => {
			'OPTIONAL-39' => 370,
			'PAREN-36' => 369,
			'PAREN-38' => 368
		}
	},
	{#State 352
		DEFAULT => -159
	},
	{#State 353
		ACTIONS => {
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'OP01_NAMED' => 109,
			'LPAREN' => 108,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP05_MATH_NEG_LPAREN' => 114,
			'VARIABLE_SYMBOL' => 123,
			'LBRACE' => 122,
			'WORD_SCOPED' => 22,
			'OP01_PRINT' => 120,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			"if" => 82,
			'OP03_MATH_INC_DEC' => 84,
			'WORD_UPPERCASE' => 80,
			"for" => -139,
			'OP01_NAMED_VOID_SCOLON' => 78,
			"while" => -139,
			'OP22_LOGICAL_NEG' => 86,
			'LITERAL_NUMBER' => 96,
			'OP19_LOOP_CONTROL' => 94,
			"}" => 373,
			"foreach" => -139,
			'OP10_NAMED_UNARY' => 90,
			'OP19_LOOP_CONTROL_SCOLON' => 91,
			'OP01_CLOSE' => 102,
			'OP01_NAMED_VOID' => 100,
			"%{" => 99,
			"my" => 98
		},
		GOTOS => {
			'VariableModification' => 79,
			'WordScoped' => 106,
			'OPTIONAL-35' => 83,
			'HashDereference' => 105,
			'SubExpression' => 107,
			'Conditional' => 85,
			'Operator' => 87,
			'Variable' => 88,
			'Statement' => 112,
			'LoopLabel' => 89,
			'Expression' => 113,
			'Literal' => 95,
			'PAREN-34' => 119,
			'VariableDeclaration' => 92,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'Operation' => 372,
			'OperatorVoid' => 97,
			'ArrayDereference' => 101
		}
	},
	{#State 354
		ACTIONS => {
			'WORD_SCOPED' => 22,
			"my" => 159,
			'LBRACE' => 122,
			"%{" => 99,
			'VARIABLE_SYMBOL' => 123,
			'OP01_QW' => 165,
			'OP01_CLOSE' => 102,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			'OP22_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'LITERAL_STRING' => 103,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'WORD' => 24
		},
		GOTOS => {
			'SubExpression' => 163,
			'TypeInner' => 164,
			'ArrayDereference' => 101,
			'Variable' => 133,
			'Operator' => 87,
			'Expression' => 135,
			'Literal' => 95,
			'WordScoped' => 106,
			'ListElements' => 374,
			'ListElement' => 162,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93
		}
	},
	{#State 355
		ACTIONS => {
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111,
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'WORD_SCOPED' => 22,
			"%{" => 99,
			'LBRACE' => 122,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'SubExpression' => 375,
			'ArrayDereference' => 101
		}
	},
	{#State 356
		DEFAULT => -157
	},
	{#State 357
		DEFAULT => -168
	},
	{#State 358
		DEFAULT => -207
	},
	{#State 359
		ACTIONS => {
			'OP21_LIST_COMMA' => 376
		}
	},
	{#State 360
		DEFAULT => -80
	},
	{#State 361
		DEFAULT => -64
	},
	{#State 362
		ACTIONS => {
			"my" => 159
		},
		GOTOS => {
			'TypeInner' => 377
		}
	},
	{#State 363
		ACTIONS => {
			'OP21_LIST_COMMA' => 380,
			"}" => 379
		},
		GOTOS => {
			'PAREN-24' => 378
		}
	},
	{#State 364
		ACTIONS => {
			"= sub {" => 381
		}
	},
	{#State 365
		ACTIONS => {
			"\@_;" => 382
		}
	},
	{#State 366
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 383
		}
	},
	{#State 367
		ACTIONS => {
			'LBRACE' => 324
		},
		GOTOS => {
			'CodeBlock' => 384
		}
	},
	{#State 368
		DEFAULT => -149
	},
	{#State 369
		DEFAULT => -146
	},
	{#State 370
		DEFAULT => -151
	},
	{#State 371
		ACTIONS => {
			'LPAREN' => 385
		}
	},
	{#State 372
		DEFAULT => -158
	},
	{#State 373
		DEFAULT => -160
	},
	{#State 374
		ACTIONS => {
			")" => 386
		}
	},
	{#State 375
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 185,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP18_TERNARY' => 179,
			'OP17_LIST_RANGE' => 387,
			'OP04_MATH_POW' => 173,
			'OP23_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 174
		}
	},
	{#State 376
		ACTIONS => {
			"undef" => 111,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			'OP22_LOGICAL_NEG' => 86,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			"%{" => 99,
			'LBRACE' => 122,
			'WORD_SCOPED' => 22,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114
		},
		GOTOS => {
			'SubExpression' => 388,
			'ArrayDereference' => 101,
			'Expression' => 135,
			'Operator' => 87,
			'Variable' => 133,
			'Literal' => 95,
			'WordScoped' => 106,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'HashReference' => 117
		}
	},
	{#State 377
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'WORD_SCOPED' => 22,
			'LBRACE' => 122,
			"%{" => 99,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111
		},
		GOTOS => {
			'SubExpression' => 389,
			'ArrayDereference' => 101,
			'Expression' => 135,
			'Variable' => 133,
			'Operator' => 87,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'HashReference' => 117,
			'Literal' => 95,
			'WordScoped' => 106
		}
	},
	{#State 378
		DEFAULT => -61
	},
	{#State 379
		ACTIONS => {
			";" => 390
		}
	},
	{#State 380
		ACTIONS => {
			"%{" => 99,
			'WORD' => 343
		},
		GOTOS => {
			'HashDereference' => 345,
			'HashEntryTyped' => 391
		}
	},
	{#State 381
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -66,
			"\@{" => -66,
			'LBRACKET' => -66,
			'OP01_PRINT' => -66,
			'WORD_SCOPED' => -66,
			'LBRACE' => -66,
			'VARIABLE_SYMBOL' => -66,
			'LITERAL_STRING' => -66,
			'OP01_OPEN' => -66,
			'LPAREN_MY' => 393,
			'OP01_NAMED' => -66,
			'LPAREN' => -66,
			"undef" => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			"foreach" => -66,
			"}" => -66,
			'OP19_LOOP_CONTROL' => -66,
			'LITERAL_NUMBER' => -66,
			"my" => -66,
			'OP01_NAMED_VOID' => -66,
			"%{" => -66,
			'OP01_CLOSE' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			"for" => -66,
			'WORD_UPPERCASE' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP05_LOGICAL_NEG' => -66,
			"if" => -66,
			'WORD' => -66,
			'OP22_LOGICAL_NEG' => -66,
			"while" => -66
		},
		GOTOS => {
			'MethodArguments' => 392,
			'OPTIONAL-26' => 394
		}
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
		DEFAULT => -148
	},
	{#State 385
		ACTIONS => {
			'LITERAL_NUMBER' => 96,
			'LBRACKET' => 118,
			"\@{" => 115,
			'OP10_NAMED_UNARY' => 90,
			'OP05_MATH_NEG_LPAREN' => 114,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 102,
			'LBRACE' => 122,
			"%{" => 99,
			'WORD_SCOPED' => 22,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			'OP05_LOGICAL_NEG' => 81,
			'OP01_OPEN' => 104,
			'WORD_UPPERCASE' => 134,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 136,
			'OP22_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'WordScoped' => 106,
			'Literal' => 95,
			'HashReference' => 117,
			'ArrayReference' => 93,
			'HashDereference' => 105,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135,
			'ArrayDereference' => 101,
			'SubExpression' => 396
		}
	},
	{#State 386
		ACTIONS => {
			'LBRACE' => 324
		},
		GOTOS => {
			'CodeBlock' => 397
		}
	},
	{#State 387
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 114,
			'OP10_NAMED_UNARY' => 90,
			"\@{" => 115,
			'LBRACKET' => 118,
			'LITERAL_NUMBER' => 96,
			'WORD_SCOPED' => 22,
			'LBRACE' => 122,
			"%{" => 99,
			'OP01_CLOSE' => 102,
			'VARIABLE_SYMBOL' => 123,
			'LITERAL_STRING' => 103,
			'WORD_UPPERCASE' => 134,
			'OP01_OPEN' => 104,
			'OP05_LOGICAL_NEG' => 81,
			'OP03_MATH_INC_DEC' => 84,
			'WORD' => 24,
			'OP22_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 136,
			'LPAREN' => 108,
			"undef" => 111
		},
		GOTOS => {
			'ArrayDereference' => 101,
			'SubExpression' => 398,
			'HashReference' => 117,
			'HashDereference' => 105,
			'ArrayReference' => 93,
			'Literal' => 95,
			'WordScoped' => 106,
			'Operator' => 87,
			'Variable' => 133,
			'Expression' => 135
		}
	},
	{#State 388
		ACTIONS => {
			'OP21_LIST_COMMA' => -81,
			")" => -81,
			"}" => -81,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			"]" => -81,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP17_LIST_RANGE' => 172,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => 179,
			'OP23_LOGICAL_AND' => -81,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP11_COMPARE_LT_GT' => 170,
			";" => -81,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 176,
			'OP15_LOGICAL_AND' => 175,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180
		}
	},
	{#State 389
		ACTIONS => {
			'OP21_LIST_COMMA' => -191,
			"}" => -191,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 183,
			'OP04_MATH_POW' => 173,
			'OP17_LIST_RANGE' => 172,
			'OP18_TERNARY' => 179,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => 178,
			'OP11_COMPARE_LT_GT' => 170,
			'OP15_LOGICAL_AND' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP08_STRING_CAT' => 180,
			'OP16_LOGICAL_OR' => 174
		}
	},
	{#State 390
		DEFAULT => -63
	},
	{#State 391
		DEFAULT => -60
	},
	{#State 392
		DEFAULT => -65
	},
	{#State 393
		ACTIONS => {
			'TYPE_SELF' => 399
		}
	},
	{#State 394
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 400
		}
	},
	{#State 395
		DEFAULT => -47
	},
	{#State 396
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 170,
			'OP23_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP17_LIST_RANGE' => 172,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => 179,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP06_REGEX_MATCH' => 176,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 175,
			")" => 401,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP13_BITWISE_AND' => 183,
			'OP09_BITWISE_SHIFT' => 184,
			'OP08_MATH_ADD_SUB' => 185,
			'OP24_LOGICAL_OR_XOR' => 186,
			'OP07_STRING_REPEAT' => 177
		}
	},
	{#State 397
		DEFAULT => -156
	},
	{#State 398
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 184,
			'OP13_BITWISE_AND' => 183,
			'OP08_MATH_ADD_SUB' => 185,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => -102,
			")" => 402,
			'OP07_MATH_MULT_DIV_MOD' => 182,
			'OP16_LOGICAL_OR' => 174,
			'OP08_STRING_CAT' => 180,
			'OP14_BITWISE_OR_XOR' => 181,
			'OP15_LOGICAL_AND' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP12_COMPARE_EQ_NE' => 171,
			'OP23_LOGICAL_AND' => -102,
			'OP11_COMPARE_LT_GT' => 170,
			'OP17_LIST_RANGE' => undef,
			'OP04_MATH_POW' => 173,
			'OP18_TERNARY' => -102
		}
	},
	{#State 399
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 403
		}
	},
	{#State 400
		ACTIONS => {
			'OP01_OPEN' => 104,
			'LITERAL_STRING' => 103,
			"undef" => 111,
			'LPAREN' => 108,
			'OP01_NAMED' => 109,
			'OP05_MATH_NEG_LPAREN' => 114,
			'LBRACKET' => 118,
			"\@{" => 115,
			'WORD_SCOPED' => 22,
			'OP01_PRINT' => 120,
			'VARIABLE_SYMBOL' => 123,
			'LBRACE' => 122,
			"for" => -139,
			'WORD_UPPERCASE' => 80,
			'OP01_NAMED_VOID_SCOLON' => 78,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 84,
			"if" => 82,
			'OP05_LOGICAL_NEG' => 81,
			'OP22_LOGICAL_NEG' => 86,
			"while" => -139,
			'OP10_NAMED_UNARY' => 90,
			'OP19_LOOP_CONTROL_SCOLON' => 91,
			"foreach" => -139,
			'LITERAL_NUMBER' => 96,
			'OP19_LOOP_CONTROL' => 94,
			"}" => 404,
			"my" => 98,
			'OP01_CLOSE' => 102,
			'OP01_NAMED_VOID' => 100,
			"%{" => 99
		},
		GOTOS => {
			'VariableModification' => 79,
			'OPTIONAL-35' => 83,
			'HashDereference' => 105,
			'WordScoped' => 106,
			'Conditional' => 85,
			'SubExpression' => 107,
			'Statement' => 112,
			'Operator' => 87,
			'Variable' => 88,
			'LoopLabel' => 89,
			'Expression' => 113,
			'HashReference' => 117,
			'VariableDeclaration' => 92,
			'ArrayReference' => 93,
			'Literal' => 95,
			'PAREN-34' => 119,
			'Operation' => 405,
			'OperatorVoid' => 97,
			'ArrayDereference' => 101
		}
	},
	{#State 401
		ACTIONS => {
			'LBRACE' => 324
		},
		GOTOS => {
			'CodeBlock' => 406
		}
	},
	{#State 402
		ACTIONS => {
			'LBRACE' => 324
		},
		GOTOS => {
			'CodeBlock' => 407
		}
	},
	{#State 403
		ACTIONS => {
			'OP21_LIST_COMMA' => 408,
			")" => 410
		},
		GOTOS => {
			'PAREN-28' => 409
		}
	},
	{#State 404
		ACTIONS => {
			";" => 411
		}
	},
	{#State 405
		DEFAULT => -67
	},
	{#State 406
		DEFAULT => -145
	},
	{#State 407
		DEFAULT => -155
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
			'TYPE_INTEGER' => 55,
			'WORD' => 54
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
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run scripts/grammar_recompile.sh
# 3. Run new & existing grammar tests
# 4. Copy updates from Grammar.output file into this file, below this line only
# 5. Run scripts/grammar_recompile.sh again
our string__hash_ref $rules = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',
CompileUnit_5 => 'RPerl::CompileUnit::Module',
Program_18 => 'RPerl::CompileUnit::Program',
ModuleHeader_21 => 'RPerl::CompileUnit::Module::Header',
Module_22 => 'RPerl::CompileUnit::Module::Package',
Module_23 => 'RPerl::CompileUnit::Module::Class::Generator',
Package_32 => 'RPerl::CompileUnit::Module::Package',
Header_33 => 'RPerl::CompileUnit::Module::Header',
Critic_36 => 'RPerl::CompileUnit::Critic',
Include_39 => 'RPerl::CompileUnit::Include',
Include_40 => 'RPerl::CompileUnit::Include',
Constant_41 => 'RPerl::CompileUnit::Constant',
Subroutine_46 => 'RPerl::CodeBlock::Subroutine',
SubroutineArguments_50 => 'RPerl::CodeBlock::Subroutine::Arguments',
Class_59 => 'RPerl::CompileUnit::Module::Class::Generator',
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


#line 8065 lib/RPerl/Grammar.pm



1;
