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
    our $VERSION = 0.000_970;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|while\ \(|elsif\ \(|\$TYPED_|\=\ sub\ \{|package|undef|if\ \(|else|our|use|qw\(|\@_\;|my|\%\{|\@\{|\;|\)|\]|\})}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
      /\G([a-zA-Z]\w*__method)/gc and return ('TYPE_METHOD', $1);
      /\G((?:[a-zA-Z]\w*)?(?:::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
      /\G(keys|values)\s/gc and return ('KEYS_OR_VALUES', $1);
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
      /\G(sin|cos|push|pop|ETC)\s/gc and return ('OP01_NAMED', $1);
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
  [ 'SubExpression_134' => 'SubExpression', [ 'LBRACE', '}' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_136' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_137' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-34', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'PAREN-34' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Statement_141' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_142' => 'Statement', [ 'OPTIONAL-35', 'Loop' ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Conditional_152' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-37', 'OPTIONAL-39' ], 0 ],
  [ 'Loop_153' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_154' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_155' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_156' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_157' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_158' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'PLUS-40', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'Operation' ], 0 ],
  [ 'CodeBlock_161' => 'CodeBlock', [ 'LBRACE', 'PLUS-40', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ 'Variable_164' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-41' ], 0 ],
  [ 'VariableRetrieval_165' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_166' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_167' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_168' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_169' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_170' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_171' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'PAREN-42' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'WORD' ], 0 ],
  [ 'ListElements_177' => 'ListElements', [ 'ListElement', 'STAR-43' ], 0 ],
  [ 'ListElements_178' => 'ListElements', [ 'OP01_QW', 'PLUS-44', ')' ], 0 ],
  [ 'ListElement_179' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_180' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_181' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'ArrayReference_184' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-45', ']' ], 0 ],
  [ 'ArrayDereferenced_185' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_186' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'HashEntry_189' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-46', 'SubExpression' ], 0 ],
  [ 'HashEntry_190' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_191' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_192' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ 'HashReference_196' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-48', '}' ], 0 ],
  [ 'HashDereferenced_197' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_198' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_199' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_200' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_201' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_202' => 'Type', [ 'WORD' ], 0 ],
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
  'SubExpression_135' => 135,
  'SubExpressionOrStdin_136' => 136,
  'SubExpressionOrStdin_137' => 137,
  '_PAREN' => 138,
  '_OPTIONAL' => 139,
  '_OPTIONAL' => 140,
  'Statement_141' => 141,
  'Statement_142' => 142,
  'Statement_143' => 143,
  'Statement_144' => 144,
  'Statement_145' => 145,
  '_PAREN' => 146,
  '_STAR_LIST' => 147,
  '_STAR_LIST' => 148,
  '_PAREN' => 149,
  '_OPTIONAL' => 150,
  '_OPTIONAL' => 151,
  'Conditional_152' => 152,
  'Loop_153' => 153,
  'Loop_154' => 154,
  'Loop_155' => 155,
  'LoopFor_156' => 156,
  'LoopForEach_157' => 157,
  'LoopWhile_158' => 158,
  '_PLUS_LIST' => 159,
  '_PLUS_LIST' => 160,
  'CodeBlock_161' => 161,
  '_STAR_LIST' => 162,
  '_STAR_LIST' => 163,
  'Variable_164' => 164,
  'VariableRetrieval_165' => 165,
  'VariableRetrieval_166' => 166,
  'VariableRetrieval_167' => 167,
  'VariableDeclaration_168' => 168,
  'VariableDeclaration_169' => 169,
  'VariableModification_170' => 170,
  'VariableModification_171' => 171,
  '_PAREN' => 172,
  '_STAR_LIST' => 173,
  '_STAR_LIST' => 174,
  '_PLUS_LIST' => 175,
  '_PLUS_LIST' => 176,
  'ListElements_177' => 177,
  'ListElements_178' => 178,
  'ListElement_179' => 179,
  'ListElement_180' => 180,
  'ListElement_181' => 181,
  '_OPTIONAL' => 182,
  '_OPTIONAL' => 183,
  'ArrayReference_184' => 184,
  'ArrayDereferenced_185' => 185,
  'ArrayDereferenced_186' => 186,
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
  'HashDereferenced_197' => 197,
  'HashDereferenced_198' => 198,
  'WordScoped_199' => 199,
  'WordScoped_200' => 200,
  'LoopLabel_201' => 201,
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
	'elsif (' => { ISSEMANTIC => 0 },
	'filehandle_ref' => { ISSEMANTIC => 0 },
	'for my integer' => { ISSEMANTIC => 0 },
	'foreach my' => { ISSEMANTIC => 0 },
	'if (' => { ISSEMANTIC => 0 },
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
	'while (' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	COLON => { ISSEMANTIC => 1 },
	FH_REF_SYMBOL => { ISSEMANTIC => 1 },
	FH_REF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 8,
			"package" => -20,
			'SHEBANG' => 2
		},
		GOTOS => {
			'PAREN-1' => 5,
			'PLUS-2' => 4,
			'ModuleHeader' => 9,
			'Critic' => 7,
			'Program' => 6,
			'CompileUnit' => 1,
			'OPTIONAL-9' => 3
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 12,
			'OPTIONAL-3' => 11
		}
	},
	{#State 3
		ACTIONS => {
			"package" => 13
		}
	},
	{#State 4
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 8,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 3,
			'PAREN-1' => 14,
			'ModuleHeader' => 9,
			'Critic' => 7
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			'WORD' => 16
		},
		GOTOS => {
			'PLUS-14' => 15
		}
	},
	{#State 9
		ACTIONS => {
			"use parent qw(" => 19,
			"use" => -25,
			"## no critic qw(" => -25,
			"use constant" => -25,
			"our" => -25
		},
		GOTOS => {
			'Package' => 20,
			'STAR-10' => 21,
			'Class' => 17,
			'Module' => 18
		}
	},
	{#State 10
		DEFAULT => 0
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
		DEFAULT => -6
	},
	{#State 13
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 14
		DEFAULT => -2
	},
	{#State 15
		ACTIONS => {
			'WORD' => 28,
			")" => 27
		}
	},
	{#State 16
		DEFAULT => -35
	},
	{#State 17
		DEFAULT => -23
	},
	{#State 18
		DEFAULT => -1
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		DEFAULT => -22
	},
	{#State 21
		ACTIONS => {
			"use" => -27,
			"## no critic qw(" => 8,
			"our" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'Critic' => 31,
			'STAR-11' => 30
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
		DEFAULT => -200
	},
	{#State 25
		DEFAULT => -199
	},
	{#State 26
		ACTIONS => {
			";" => 34
		}
	},
	{#State 27
		DEFAULT => -36
	},
	{#State 28
		DEFAULT => -34
	},
	{#State 29
		ACTIONS => {
			")" => 35
		}
	},
	{#State 30
		ACTIONS => {
			"use" => 38,
			"our" => -29,
			"use constant" => -29
		},
		GOTOS => {
			'Include' => 37,
			'STAR-12' => 36
		}
	},
	{#State 31
		DEFAULT => -24
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"my" => -11,
			'OP05_LOGICAL_NEG' => -11,
			"undef" => -11,
			'OP01_NAMED_VOID' => -11,
			"%{" => -11,
			"## no critic qw(" => 8,
			'OP22_LOGICAL_NEG' => -11,
			"use" => -11,
			'LITERAL_STRING' => -11,
			"\@{" => -11,
			'OP01_NAMED' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LPAREN' => -11,
			'OP01_PRINT' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"while (" => -11,
			"foreach my" => -11,
			'LITERAL_NUMBER' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_CLOSE' => -11,
			'OP01_OPEN' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			'WORD' => -11,
			'LBRACKET' => -11,
			'WORD_SCOPED' => -11,
			"our" => -11,
			'VARIABLE_SYMBOL' => -11,
			"use constant" => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"for my integer" => -11,
			"if (" => -11,
			'OP10_NAMED_UNARY' => -11
		},
		GOTOS => {
			'STAR-5' => 41,
			'Critic' => 40
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
		ACTIONS => {
			";" => 43
		}
	},
	{#State 36
		ACTIONS => {
			"use constant" => 46,
			"our" => 45
		},
		GOTOS => {
			'PLUS-13' => 48,
			'Constant' => 47,
			'Subroutine' => 44
		}
	},
	{#State 37
		DEFAULT => -26
	},
	{#State 38
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 49
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
			'OP22_LOGICAL_NEG' => -13,
			"%{" => -13,
			"undef" => -13,
			'OP01_NAMED_VOID' => -13,
			"my" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_PRINT' => -13,
			'LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_NAMED' => -13,
			"\@{" => -13,
			'LITERAL_STRING' => -13,
			"use" => 38,
			'WORD' => -13,
			'LBRACE' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_OPEN' => -13,
			'OP01_CLOSE' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"foreach my" => -13,
			'LITERAL_NUMBER' => -13,
			"while (" => -13,
			'OP10_NAMED_UNARY' => -13,
			"if (" => -13,
			"for my integer" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'WORD_UPPERCASE' => -13,
			"use constant" => -13,
			'VARIABLE_SYMBOL' => -13,
			"our" => -13,
			'WORD_SCOPED' => -13,
			'LBRACKET' => -13
		},
		GOTOS => {
			'Include' => 52,
			'STAR-6' => 51
		}
	},
	{#State 42
		DEFAULT => -21
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
		DEFAULT => -31
	},
	{#State 45
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 46
		ACTIONS => {
			'WORD_UPPERCASE' => 56
		}
	},
	{#State 47
		DEFAULT => -28
	},
	{#State 48
		ACTIONS => {
			'LITERAL_NUMBER' => 57,
			"our" => 45
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 49
		ACTIONS => {
			";" => 60,
			"qw(" => 59
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -15,
			'OP01_PRINT' => -15,
			'LPAREN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"\@{" => -15,
			'OP01_NAMED' => -15,
			'LITERAL_STRING' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"%{" => -15,
			"undef" => -15,
			'OP01_NAMED_VOID' => -15,
			"my" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY' => -15,
			"for my integer" => -15,
			"if (" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'WORD_UPPERCASE' => -15,
			"our" => -15,
			"use constant" => 46,
			'VARIABLE_SYMBOL' => -15,
			'WORD_SCOPED' => -15,
			'LBRACKET' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LBRACE' => -15,
			'WORD' => -15,
			'OP01_OPEN' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_CLOSE' => -15,
			'LITERAL_NUMBER' => -15,
			"foreach my" => -15,
			"while (" => -15
		},
		GOTOS => {
			'Constant' => 62,
			'STAR-7' => 63
		}
	},
	{#State 52
		DEFAULT => -10
	},
	{#State 53
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 64
		}
	},
	{#State 54
		DEFAULT => -202
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
		DEFAULT => -33
	},
	{#State 62
		DEFAULT => -12
	},
	{#State 63
		ACTIONS => {
			"%{" => 72,
			'OP22_LOGICAL_NEG' => 70,
			'OP01_NAMED_VOID' => 73,
			"undef" => 74,
			"my" => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'OP01_PRINT' => 86,
			'LITERAL_STRING' => 93,
			"\@{" => 92,
			'OP01_NAMED' => 91,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'WORD' => 25,
			'OP01_OPEN' => 100,
			'LITERAL_NUMBER' => 104,
			"foreach my" => -140,
			'OP19_LOOP_CONTROL' => 102,
			'OP01_CLOSE' => 101,
			"while (" => -140,
			"for my integer" => -140,
			"if (" => 106,
			'OP10_NAMED_UNARY' => 105,
			'OP01_NAMED_VOID_SCOLON' => 108,
			"our" => 45,
			'VARIABLE_SYMBOL' => 111,
			'WORD_UPPERCASE' => 110,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Subroutine' => 96,
			'HashDereferenced' => 95,
			'OPTIONAL-35' => 115,
			'Operator' => 94,
			'OperatorVoid' => 112,
			'SubExpression' => 113,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'PAREN-34' => 109,
			'VariableDeclaration' => 87,
			'HashReference' => 88,
			'Conditional' => 84,
			'Literal' => 83,
			'WordScoped' => 85,
			'LoopLabel' => 77,
			'Expression' => 76,
			'VariableModification' => 103,
			'PLUS-8' => 75,
			'Statement' => 80,
			'Variable' => 97,
			'Operation' => 71
		}
	},
	{#State 64
		ACTIONS => {
			"use" => -54,
			"our hash_ref \$properties" => -54,
			"use constant" => -54,
			"## no critic qw(" => 8
		},
		GOTOS => {
			'Critic' => 116,
			'STAR-21' => 117
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 118
		}
	},
	{#State 66
		ACTIONS => {
			"my" => 120
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
			'WORD' => 122
		}
	},
	{#State 70
		ACTIONS => {
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			"%{" => 72,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111
		},
		GOTOS => {
			'Expression' => 123,
			'SubExpression' => 126,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'WordScoped' => 85,
			'Literal' => 83,
			'HashReference' => 88
		}
	},
	{#State 71
		DEFAULT => -17
	},
	{#State 72
		ACTIONS => {
			'LBRACE' => 129,
			'VARIABLE_SYMBOL' => 111
		},
		GOTOS => {
			'HashReference' => 130,
			'Variable' => 128
		}
	},
	{#State 73
		ACTIONS => {
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'KEYS_OR_VALUES' => 131,
			'OP01_QW' => 135,
			'OP05_LOGICAL_NEG' => 79,
			"my" => 132,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP01_OPEN' => 100,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'WordScoped' => 85,
			'Literal' => 83,
			'ListElement' => 134,
			'HashReference' => 88,
			'ListElements' => 136,
			'TypeInner' => 133,
			'Expression' => 123,
			'SubExpression' => 137,
			'HashDereferenced' => 95,
			'Operator' => 94
		}
	},
	{#State 74
		DEFAULT => -127
	},
	{#State 75
		ACTIONS => {
			"undef" => 74,
			'OP01_NAMED_VOID' => 73,
			"my" => 78,
			'OP05_LOGICAL_NEG' => 79,
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'OP01_NAMED' => 91,
			"\@{" => 92,
			'LITERAL_STRING' => 93,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_PRINT' => 86,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'LPAREN' => 89,
			'OP01_CLOSE' => 101,
			'OP19_LOOP_CONTROL' => 102,
			'LITERAL_NUMBER' => 104,
			"foreach my" => -140,
			"while (" => -140,
			'WORD' => 25,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'WORD_UPPERCASE' => 110,
			'' => -18,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 105,
			"if (" => 106,
			"for my integer" => -140,
			'OP01_NAMED_VOID_SCOLON' => 108
		},
		GOTOS => {
			'Statement' => 80,
			'Expression' => 76,
			'LoopLabel' => 77,
			'VariableModification' => 103,
			'Variable' => 97,
			'Operation' => 138,
			'OPTIONAL-35' => 115,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 113,
			'OperatorVoid' => 112,
			'PAREN-34' => 109,
			'VariableDeclaration' => 87,
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'Conditional' => 84,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81
		}
	},
	{#State 76
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			'OP17_LIST_RANGE' => -126,
			";" => 139,
			'OP23_LOGICAL_AND' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP04_MATH_POW' => -126,
			'OP18_TERNARY' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP16_LOGICAL_OR' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP08_STRING_CAT' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP24_LOGICAL_OR_XOR' => -126
		}
	},
	{#State 77
		ACTIONS => {
			'COLON' => 140
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 141
		}
	},
	{#State 79
		ACTIONS => {
			'OP01_OPEN' => 100,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'WORD' => 25,
			"%{" => 72,
			'OP22_LOGICAL_NEG' => 70,
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124
		},
		GOTOS => {
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 142,
			'Expression' => 123,
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81
		}
	},
	{#State 80
		DEFAULT => -77
	},
	{#State 81
		DEFAULT => -131
	},
	{#State 82
		ACTIONS => {
			'VARIABLE_SYMBOL' => 111
		},
		GOTOS => {
			'Variable' => 143
		}
	},
	{#State 83
		DEFAULT => -128
	},
	{#State 84
		DEFAULT => -141
	},
	{#State 85
		ACTIONS => {
			'LPAREN' => 145,
			'OP02_METHOD_THINARROW_NEW' => 144
		}
	},
	{#State 86
		ACTIONS => {
			'LPAREN' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'STDOUT_STDERR' => 149,
			'OP10_NAMED_UNARY' => -109,
			'LBRACKET' => -109,
			'WORD_SCOPED' => -109,
			'LITERAL_STRING' => -109,
			'VARIABLE_SYMBOL' => -109,
			"\@{" => -109,
			'OP01_NAMED' => -109,
			'WORD_UPPERCASE' => -109,
			'OP01_OPEN' => -109,
			'LBRACE' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'WORD' => -109,
			"%{" => -109,
			'OP22_LOGICAL_NEG' => -109,
			'FH_REF_SYMBOL_BRACES' => 147,
			'OP05_LOGICAL_NEG' => -109,
			"my" => -109,
			'OP01_QW' => -109,
			'LITERAL_NUMBER' => -109,
			'KEYS_OR_VALUES' => -109,
			"undef" => -109,
			'OP01_CLOSE' => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 146,
			'PAREN-30' => 148
		}
	},
	{#State 87
		DEFAULT => -144
	},
	{#State 88
		DEFAULT => -132
	},
	{#State 89
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'OP01_PRINT' => 151,
			'LPAREN' => 89,
			'OP01_NAMED' => 152,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'Expression' => 123,
			'SubExpression' => 150,
			'Operator' => 94,
			'HashDereferenced' => 95
		}
	},
	{#State 90
		DEFAULT => -115
	},
	{#State 91
		ACTIONS => {
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			'KEYS_OR_VALUES' => 131,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 100,
			"%{" => 72,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'Literal' => 83,
			'WordScoped' => 85,
			'ListElement' => 154,
			'HashReference' => 88,
			'Expression' => 123,
			'TypeInner' => 133,
			'SubExpression' => 153,
			'Operator' => 94,
			'HashDereferenced' => 95
		}
	},
	{#State 92
		ACTIONS => {
			'VARIABLE_SYMBOL' => 111,
			'LBRACKET' => 114
		},
		GOTOS => {
			'ArrayReference' => 156,
			'Variable' => 155
		}
	},
	{#State 93
		DEFAULT => -207
	},
	{#State 94
		DEFAULT => -121
	},
	{#State 95
		DEFAULT => -133
	},
	{#State 96
		DEFAULT => -14
	},
	{#State 97
		ACTIONS => {
			'OP04_MATH_POW' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP19_VARIABLE_ASSIGN' => 157,
			'OP07_STRING_REPEAT' => -129,
			'OP18_TERNARY' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP19_VARIABLE_ASSIGN_BY' => 158,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP08_STRING_CAT' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP02_METHOD_THINARROW' => 160,
			'OP06_REGEX_MATCH' => -129,
			'OP03_MATH_INC_DEC' => 159,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP15_LOGICAL_AND' => -129
		}
	},
	{#State 98
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'WORD' => 25,
			"%{" => 72,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'Expression' => 123,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 161
		}
	},
	{#State 99
		ACTIONS => {
			"}" => 163,
			"%{" => 72,
			'WORD' => 165
		},
		GOTOS => {
			'HashDereferenced' => 162,
			'HashEntry' => 164
		}
	},
	{#State 100
		ACTIONS => {
			"my" => 166
		}
	},
	{#State 101
		ACTIONS => {
			'FH_REF_SYMBOL' => 167
		}
	},
	{#State 102
		ACTIONS => {
			'WORD_UPPERCASE' => 168
		},
		GOTOS => {
			'LoopLabel' => 169
		}
	},
	{#State 103
		DEFAULT => -145
	},
	{#State 104
		DEFAULT => -208
	},
	{#State 105
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'OP11_COMPARE_LT_GT' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP04_MATH_POW' => -95,
			"undef" => 74,
			'OP21_LIST_COMMA' => -95,
			"%{" => 72,
			";" => -95,
			"}" => -95,
			'OP22_LOGICAL_NEG' => 70,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'LITERAL_STRING' => 93,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'OP13_BITWISE_AND' => -95,
			'LPAREN' => 89,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP03_MATH_INC_DEC' => 82,
			'OP16_LOGICAL_OR' => -95,
			'OP18_TERNARY' => -95,
			'LITERAL_NUMBER' => 104,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 100,
			'OP12_COMPARE_EQ_NE' => -95,
			'WORD' => 25,
			'OP17_LIST_RANGE' => -95,
			'LBRACE' => 99,
			'OP23_LOGICAL_AND' => -95,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP09_BITWISE_SHIFT' => -95,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'OP08_STRING_CAT' => -95,
			'VARIABLE_SYMBOL' => 111,
			'WORD_UPPERCASE' => 127,
			'OP15_LOGICAL_AND' => -95,
			"]" => -95,
			")" => -95,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107,
			'SubExpression' => 170,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'Expression' => 123
		}
	},
	{#State 106
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'OP01_OPEN' => 100,
			'WORD' => 25,
			"%{" => 72,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 171,
			'Expression' => 123,
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81
		}
	},
	{#State 107
		DEFAULT => -130
	},
	{#State 108
		DEFAULT => -112
	},
	{#State 109
		DEFAULT => -139
	},
	{#State 110
		ACTIONS => {
			'COLON' => -201,
			'LPAREN' => 172
		}
	},
	{#State 111
		DEFAULT => -163,
		GOTOS => {
			'STAR-41' => 173
		}
	},
	{#State 112
		DEFAULT => -143
	},
	{#State 113
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP06_REGEX_MATCH' => 181,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => 182,
			'OP07_STRING_REPEAT' => 176,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP04_MATH_POW' => 175,
			'OP09_BITWISE_SHIFT' => 188,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP17_LIST_RANGE' => 186,
			'OP23_LOGICAL_AND' => 185
		}
	},
	{#State 114
		ACTIONS => {
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			"]" => -183,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'OP05_LOGICAL_NEG' => 79,
			"my" => 132,
			'LITERAL_NUMBER' => 104,
			'KEYS_OR_VALUES' => 131,
			'OP01_QW' => 135,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 100,
			'WORD' => 25,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 70
		},
		GOTOS => {
			'TypeInner' => 133,
			'Expression' => 123,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 137,
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81,
			'ListElement' => 134,
			'ListElements' => 192,
			'HashReference' => 88,
			'OPTIONAL-45' => 191,
			'Literal' => 83,
			'WordScoped' => 85
		}
	},
	{#State 115
		ACTIONS => {
			"foreach my" => 194,
			"for my integer" => 195,
			"while (" => 193
		},
		GOTOS => {
			'LoopFor' => 199,
			'LoopForEach' => 198,
			'Loop' => 196,
			'LoopWhile' => 197
		}
	},
	{#State 116
		DEFAULT => -51
	},
	{#State 117
		ACTIONS => {
			"use" => 38,
			"our hash_ref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 201,
			'Include' => 200
		}
	},
	{#State 118
		ACTIONS => {
			'OP01_PRINT' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'LPAREN' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED' => -43,
			"\@{" => -43,
			'LITERAL_STRING' => -43,
			'LPAREN_MY' => 202,
			'OP22_LOGICAL_NEG' => -43,
			"%{" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"my" => -43,
			"undef" => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP10_NAMED_UNARY' => -43,
			"if (" => -43,
			"for my integer" => -43,
			'WORD_SCOPED' => -43,
			'LBRACKET' => -43,
			'WORD_UPPERCASE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_OPEN' => -43,
			'WORD' => -43,
			'LBRACE' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"while (" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP01_CLOSE' => -43,
			"foreach my" => -43,
			'LITERAL_NUMBER' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 203,
			'SubroutineArguments' => 204
		}
	},
	{#State 119
		ACTIONS => {
			'LITERAL_STRING' => 93,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Literal' => 205
		}
	},
	{#State 120
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 206
		}
	},
	{#State 121
		ACTIONS => {
			";" => 207
		}
	},
	{#State 122
		DEFAULT => -37
	},
	{#State 123
		DEFAULT => -126
	},
	{#State 124
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 70,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"%{" => 72,
			'WORD' => 25,
			'OP01_OPEN' => 100,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'WordScoped' => 85,
			'Literal' => 83,
			'HashReference' => 88,
			'Expression' => 123,
			'SubExpression' => 208,
			'Operator' => 94,
			'HashDereferenced' => 95
		}
	},
	{#State 125
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP15_LOGICAL_AND' => -129,
			"]" => -129,
			'OP02_METHOD_THINARROW' => 160,
			'OP03_MATH_INC_DEC' => 159,
			'OP06_REGEX_MATCH' => -129,
			")" => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP08_STRING_CAT' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			"}" => -129,
			'OP23_LOGICAL_AND' => -129,
			";" => -129,
			'OP17_LIST_RANGE' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP18_TERNARY' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP04_MATH_POW' => -129,
			'OP07_STRING_REPEAT' => -129
		}
	},
	{#State 126
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"]" => -104,
			'OP15_LOGICAL_AND' => 190,
			'OP06_REGEX_MATCH' => 181,
			")" => -104,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP09_BITWISE_SHIFT' => 188,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP21_LIST_COMMA' => -104,
			'OP17_LIST_RANGE' => 186,
			"}" => -104,
			";" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => 182,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184
		}
	},
	{#State 127
		ACTIONS => {
			'LPAREN' => 172
		}
	},
	{#State 128
		ACTIONS => {
			"}" => 209
		}
	},
	{#State 129
		ACTIONS => {
			"%{" => 72,
			'WORD' => 165
		},
		GOTOS => {
			'HashDereferenced' => 162,
			'HashEntry' => 164
		}
	},
	{#State 130
		ACTIONS => {
			"}" => 210
		}
	},
	{#State 131
		ACTIONS => {
			"%{" => 72
		},
		GOTOS => {
			'HashDereferenced' => 211
		}
	},
	{#State 132
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 133
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'WORD' => 25,
			"%{" => 72,
			'OP01_OPEN' => 100,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 213,
			'Expression' => 123,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81
		}
	},
	{#State 134
		DEFAULT => -174,
		GOTOS => {
			'STAR-43' => 214
		}
	},
	{#State 135
		ACTIONS => {
			'WORD' => 215
		},
		GOTOS => {
			'PLUS-44' => 216
		}
	},
	{#State 136
		ACTIONS => {
			";" => 217
		}
	},
	{#State 137
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 184,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 176,
			'OP16_LOGICAL_OR' => 182,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			";" => -179,
			'OP23_LOGICAL_AND' => 185,
			'OP17_LIST_RANGE' => 186,
			'OP21_LIST_COMMA' => -179,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 188,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP08_MATH_ADD_SUB' => 178,
			")" => -179,
			'OP06_REGEX_MATCH' => 181,
			'OP15_LOGICAL_AND' => 190,
			"]" => -179,
			'OP07_MATH_MULT_DIV_MOD' => 180
		}
	},
	{#State 138
		DEFAULT => -16
	},
	{#State 139
		DEFAULT => -76
	},
	{#State 140
		DEFAULT => -138
	},
	{#State 141
		ACTIONS => {
			'VARIABLE_SYMBOL' => 218
		}
	},
	{#State 142
		ACTIONS => {
			'OP13_BITWISE_AND' => -86,
			'OP08_STRING_CAT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP06_REGEX_MATCH' => -86,
			")" => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP15_LOGICAL_AND' => -86,
			"]" => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP18_TERNARY' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			";" => -86,
			"}" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP17_LIST_RANGE' => -86
		}
	},
	{#State 143
		DEFAULT => -83
	},
	{#State 144
		ACTIONS => {
			")" => 219
		}
	},
	{#State 145
		ACTIONS => {
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'KEYS_OR_VALUES' => 131,
			'LITERAL_NUMBER' => 104,
			'OP01_QW' => 135,
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79,
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			")" => -118,
			'LPAREN' => 89
		},
		GOTOS => {
			'OPTIONAL-32' => 220,
			'TypeInner' => 133,
			'Expression' => 123,
			'SubExpression' => 137,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'Literal' => 83,
			'WordScoped' => 85,
			'ListElement' => 134,
			'ListElements' => 221,
			'HashReference' => 88
		}
	},
	{#State 146
		ACTIONS => {
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'KEYS_OR_VALUES' => 131,
			'LITERAL_NUMBER' => 104,
			'OP01_QW' => 135,
			'OP05_LOGICAL_NEG' => 79,
			"my" => 132,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'SubExpression' => 137,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'TypeInner' => 133,
			'Expression' => 123,
			'Literal' => 83,
			'WordScoped' => 85,
			'ListElement' => 134,
			'ListElements' => 222,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125
		}
	},
	{#State 147
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'KEYS_OR_VALUES' => 131,
			'LITERAL_NUMBER' => 104,
			'OP01_QW' => 135,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98
		},
		GOTOS => {
			'Expression' => 123,
			'TypeInner' => 133,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 137,
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81,
			'ListElement' => 134,
			'HashReference' => 88,
			'ListElements' => 223,
			'WordScoped' => 85,
			'Literal' => 83
		}
	},
	{#State 148
		DEFAULT => -108
	},
	{#State 149
		DEFAULT => -107
	},
	{#State 150
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 188,
			'OP17_LIST_RANGE' => 186,
			'OP23_LOGICAL_AND' => 185,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => 182,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP06_REGEX_MATCH' => 181,
			")" => 224,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189
		}
	},
	{#State 151
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 225
		}
	},
	{#State 152
		ACTIONS => {
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79,
			'KEYS_OR_VALUES' => 131,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'OP01_OPEN' => 100,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"%{" => 72,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 70
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'Literal' => 83,
			'WordScoped' => 85,
			'ListElement' => 226,
			'HashReference' => 88,
			'Expression' => 123,
			'TypeInner' => 133,
			'SubExpression' => 153,
			'Operator' => 94,
			'HashDereferenced' => 95
		}
	},
	{#State 153
		ACTIONS => {
			'OP15_LOGICAL_AND' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			")" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP08_STRING_CAT' => -79,
			'OP13_BITWISE_AND' => -79,
			";" => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP21_LIST_COMMA' => -179,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP18_TERNARY' => -79,
			'OP04_MATH_POW' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP07_STRING_REPEAT' => -79
		}
	},
	{#State 154
		ACTIONS => {
			'OP21_LIST_COMMA' => 227
		}
	},
	{#State 155
		ACTIONS => {
			"}" => 228
		}
	},
	{#State 156
		ACTIONS => {
			"}" => 229
		}
	},
	{#State 157
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'WORD' => 25,
			'STDIN' => 231,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 100,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'OP05_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'SubExpression' => 232,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'Expression' => 123,
			'WordScoped' => 85,
			'Literal' => 83,
			'SubExpressionOrStdin' => 230,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107
		}
	},
	{#State 158
		ACTIONS => {
			'LITERAL_NUMBER' => 104,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP05_LOGICAL_NEG' => 79,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"%{" => 72,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LPAREN' => 89
		},
		GOTOS => {
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 233,
			'Expression' => 123
		}
	},
	{#State 159
		DEFAULT => -84
	},
	{#State 160
		ACTIONS => {
			'LPAREN' => 234
		}
	},
	{#State 161
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP06_REGEX_MATCH' => 181,
			")" => 235,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP09_BITWISE_SHIFT' => 188,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP23_LOGICAL_AND' => 185,
			'OP17_LIST_RANGE' => 186,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => 183,
			'OP16_LOGICAL_OR' => 182,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184
		}
	},
	{#State 162
		DEFAULT => -190
	},
	{#State 163
		DEFAULT => -134
	},
	{#State 164
		DEFAULT => -195,
		GOTOS => {
			'STAR-48' => 236
		}
	},
	{#State 165
		ACTIONS => {
			'OP20_HASH_FATARROW' => 237
		}
	},
	{#State 166
		ACTIONS => {
			"filehandle_ref" => 238
		}
	},
	{#State 167
		DEFAULT => -82
	},
	{#State 168
		DEFAULT => -201
	},
	{#State 169
		ACTIONS => {
			";" => 239
		}
	},
	{#State 170
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 188,
			'OP23_LOGICAL_AND' => -94,
			"}" => -94,
			";" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => 176,
			'OP18_TERNARY' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP06_REGEX_MATCH' => 181,
			")" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"]" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => -94
		}
	},
	{#State 171
		ACTIONS => {
			'OP16_LOGICAL_OR' => 182,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => 183,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP23_LOGICAL_AND' => 185,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 188,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP08_MATH_ADD_SUB' => 178,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			")" => 240,
			'OP06_REGEX_MATCH' => 181
		}
	},
	{#State 172
		ACTIONS => {
			")" => 241
		}
	},
	{#State 173
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -164,
			'OP24_LOGICAL_OR_XOR' => -164,
			'OP13_BITWISE_AND' => -164,
			'OP02_ARRAY_THINARROW' => 242,
			'OP08_STRING_CAT' => -164,
			'OP07_MATH_MULT_DIV_MOD' => -164,
			'OP15_LOGICAL_AND' => -164,
			"]" => -164,
			'OP02_METHOD_THINARROW' => -164,
			'OP06_REGEX_MATCH' => -164,
			'OP03_MATH_INC_DEC' => -164,
			")" => -164,
			'OP18_TERNARY' => -164,
			'OP11_COMPARE_LT_GT' => -164,
			'OP16_LOGICAL_OR' => -164,
			'OP04_MATH_POW' => -164,
			'OP14_BITWISE_OR_XOR' => -164,
			'OP19_VARIABLE_ASSIGN' => -164,
			'OP07_STRING_REPEAT' => -164,
			'OP09_BITWISE_SHIFT' => -164,
			'OP02_HASH_THINARROW' => 243,
			'OP17_LIST_RANGE' => -164,
			"}" => -164,
			";" => -164,
			'OP23_LOGICAL_AND' => -164,
			'OP19_VARIABLE_ASSIGN_BY' => -164,
			'COLON' => -164,
			'OP21_LIST_COMMA' => -164,
			'OP12_COMPARE_EQ_NE' => -164
		},
		GOTOS => {
			'VariableRetrieval' => 244
		}
	},
	{#State 174
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP01_OPEN' => 100,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LPAREN' => 89,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114
		},
		GOTOS => {
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 245,
			'Expression' => 123
		}
	},
	{#State 175
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'LITERAL_NUMBER' => 104,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'Expression' => 123,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 246
		}
	},
	{#State 176
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 100,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"%{" => 72,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Expression' => 123,
			'SubExpression' => 247,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107,
			'WordScoped' => 85,
			'Literal' => 83,
			'HashReference' => 88
		}
	},
	{#State 177
		ACTIONS => {
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'SubExpression' => 248,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'Expression' => 123,
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107
		}
	},
	{#State 178
		ACTIONS => {
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'WordScoped' => 85,
			'Literal' => 83,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'SubExpression' => 249,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'Expression' => 123
		}
	},
	{#State 179
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'LITERAL_NUMBER' => 104,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 250,
			'Expression' => 123,
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81
		}
	},
	{#State 180
		ACTIONS => {
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'WORD' => 25,
			"%{" => 72,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'Expression' => 123,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 251
		}
	},
	{#State 181
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 252
		}
	},
	{#State 182
		ACTIONS => {
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LPAREN' => 89
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'Expression' => 123,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 253
		}
	},
	{#State 183
		ACTIONS => {
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_NUMBER' => 104
		},
		GOTOS => {
			'Variable' => 255,
			'Literal' => 256,
			'VariableOrLiteral' => 254
		}
	},
	{#State 184
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP01_OPEN' => 100,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114
		},
		GOTOS => {
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 257,
			'Expression' => 123,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81
		}
	},
	{#State 185
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'LITERAL_NUMBER' => 104,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Expression' => 123,
			'SubExpression' => 258,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'WordScoped' => 85,
			'Literal' => 83,
			'HashReference' => 88
		}
	},
	{#State 186
		ACTIONS => {
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"%{" => 72,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111
		},
		GOTOS => {
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 259,
			'Expression' => 123,
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81
		}
	},
	{#State 187
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 100,
			"%{" => 72,
			'WORD' => 25,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107,
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'Expression' => 123,
			'SubExpression' => 260,
			'HashDereferenced' => 95,
			'Operator' => 94
		}
	},
	{#State 188
		ACTIONS => {
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'WORD' => 25,
			"%{" => 72,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'WordScoped' => 85,
			'Literal' => 83,
			'HashReference' => 88,
			'Expression' => 123,
			'SubExpression' => 261,
			'HashDereferenced' => 95,
			'Operator' => 94
		}
	},
	{#State 189
		ACTIONS => {
			'OP01_OPEN' => 100,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"%{" => 72,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 70,
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124
		},
		GOTOS => {
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'Expression' => 123,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 262
		}
	},
	{#State 190
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105
		},
		GOTOS => {
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 263,
			'Expression' => 123,
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'ArrayReference' => 107,
			'Variable' => 125,
			'ArrayDereferenced' => 81
		}
	},
	{#State 191
		ACTIONS => {
			"]" => 264
		}
	},
	{#State 192
		DEFAULT => -182
	},
	{#State 193
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'WORD' => 25,
			"%{" => 72,
			'OP22_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 100,
			'LITERAL_NUMBER' => 104,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP05_LOGICAL_NEG' => 79,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'SubExpression' => 265,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'Expression' => 123,
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107
		}
	},
	{#State 194
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 266
		}
	},
	{#State 195
		ACTIONS => {
			'VARIABLE_SYMBOL' => 267
		}
	},
	{#State 196
		DEFAULT => -142
	},
	{#State 197
		DEFAULT => -155
	},
	{#State 198
		DEFAULT => -154
	},
	{#State 199
		DEFAULT => -153
	},
	{#State 200
		DEFAULT => -53
	},
	{#State 201
		ACTIONS => {
			"our hash_ref \$properties" => 269,
			"use constant" => 46
		},
		GOTOS => {
			'Properties' => 268,
			'Constant' => 270
		}
	},
	{#State 202
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 271
		}
	},
	{#State 203
		ACTIONS => {
			"my" => 78,
			'OP05_LOGICAL_NEG' => 79,
			"while (" => -140,
			'OP19_LOOP_CONTROL' => 102,
			'OP01_NAMED_VOID' => 73,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			"foreach my" => -140,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"%{" => 72,
			'WORD' => 25,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			"\@{" => 92,
			'OP01_NAMED' => 91,
			'WORD_UPPERCASE' => 110,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'OP01_PRINT' => 86,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			"for my integer" => -140,
			"if (" => 106
		},
		GOTOS => {
			'ArrayReference' => 107,
			'PLUS-17' => 272,
			'ArrayDereferenced' => 81,
			'PAREN-34' => 109,
			'VariableDeclaration' => 87,
			'HashReference' => 88,
			'Conditional' => 84,
			'Literal' => 83,
			'WordScoped' => 85,
			'OPTIONAL-35' => 115,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 113,
			'OperatorVoid' => 112,
			'Variable' => 97,
			'Operation' => 273,
			'Expression' => 76,
			'LoopLabel' => 77,
			'VariableModification' => 103,
			'Statement' => 80
		}
	},
	{#State 204
		DEFAULT => -42
	},
	{#State 205
		ACTIONS => {
			";" => 274
		}
	},
	{#State 206
		ACTIONS => {
			"\$TYPED_" => 275
		}
	},
	{#State 207
		DEFAULT => -40
	},
	{#State 208
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP15_LOGICAL_AND' => -79,
			"]" => -79,
			'OP06_REGEX_MATCH' => -79,
			")" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			";" => -79,
			"}" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP18_TERNARY' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP04_MATH_POW' => -79,
			'OP07_STRING_REPEAT' => -79
		}
	},
	{#State 209
		DEFAULT => -197
	},
	{#State 210
		DEFAULT => -198
	},
	{#State 211
		DEFAULT => -181
	},
	{#State 212
		ACTIONS => {
			"\$TYPED_" => 276
		}
	},
	{#State 213
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 188,
			'OP23_LOGICAL_AND' => 185,
			";" => -180,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP21_LIST_COMMA' => -180,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => 183,
			'OP16_LOGICAL_OR' => 182,
			'OP06_REGEX_MATCH' => 181,
			")" => -180,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"]" => -180,
			'OP15_LOGICAL_AND' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177
		}
	},
	{#State 214
		ACTIONS => {
			"]" => -177,
			'OP21_LIST_COMMA' => 277,
			")" => -177,
			";" => -177
		},
		GOTOS => {
			'PAREN-42' => 278
		}
	},
	{#State 215
		DEFAULT => -176
	},
	{#State 216
		ACTIONS => {
			")" => 279,
			'WORD' => 280
		}
	},
	{#State 217
		DEFAULT => -113
	},
	{#State 218
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 281,
			";" => 282
		}
	},
	{#State 219
		DEFAULT => -125
	},
	{#State 220
		ACTIONS => {
			")" => 283
		}
	},
	{#State 221
		DEFAULT => -117
	},
	{#State 222
		ACTIONS => {
			";" => 284
		}
	},
	{#State 223
		ACTIONS => {
			";" => 285
		}
	},
	{#State 224
		DEFAULT => -135
	},
	{#State 225
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"%{" => 72,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 100,
			'OP01_QW' => 135,
			'KEYS_OR_VALUES' => 131,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LPAREN' => 89,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'ListElements' => 286,
			'ListElement' => 134,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107,
			'SubExpression' => 137,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'TypeInner' => 133,
			'Expression' => 123
		}
	},
	{#State 226
		ACTIONS => {
			'OP21_LIST_COMMA' => 287
		}
	},
	{#State 227
		ACTIONS => {
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LPAREN' => 89,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP01_QW' => 135,
			'KEYS_OR_VALUES' => 131,
			'LITERAL_NUMBER' => 104,
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'WORD' => 25,
			"%{" => 72,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'SubExpression' => 137,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'Expression' => 123,
			'TypeInner' => 133,
			'Literal' => 83,
			'WordScoped' => 85,
			'ListElement' => 134,
			'ListElements' => 288,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125
		}
	},
	{#State 228
		DEFAULT => -185
	},
	{#State 229
		DEFAULT => -186
	},
	{#State 230
		ACTIONS => {
			";" => 289
		}
	},
	{#State 231
		DEFAULT => -137
	},
	{#State 232
		ACTIONS => {
			'OP16_LOGICAL_OR' => 182,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => 183,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			";" => -136,
			'OP23_LOGICAL_AND' => 185,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 188,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP08_MATH_ADD_SUB' => 178,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP06_REGEX_MATCH' => 181
		}
	},
	{#State 233
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 188,
			";" => 290,
			'OP17_LIST_RANGE' => 186,
			'OP23_LOGICAL_AND' => 185,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 176,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => 183,
			'OP16_LOGICAL_OR' => 182,
			'OP06_REGEX_MATCH' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177
		}
	},
	{#State 234
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			")" => -120,
			'LPAREN' => 89,
			"\@{" => 92,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			"%{" => 72,
			'WORD' => 25,
			'OP01_OPEN' => 100,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP01_QW' => 135,
			'LITERAL_NUMBER' => 104,
			'KEYS_OR_VALUES' => 131,
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'Expression' => 123,
			'TypeInner' => 133,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 137,
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'OPTIONAL-33' => 292,
			'ListElements' => 291,
			'HashReference' => 88,
			'ListElement' => 134,
			'Literal' => 83,
			'WordScoped' => 85
		}
	},
	{#State 235
		DEFAULT => -87
	},
	{#State 236
		ACTIONS => {
			'OP21_LIST_COMMA' => 295,
			"}" => 294
		},
		GOTOS => {
			'PAREN-47' => 293
		}
	},
	{#State 237
		ACTIONS => {
			'LPAREN' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'OP10_NAMED_UNARY' => -188,
			'LBRACKET' => -188,
			'WORD_SCOPED' => -188,
			'VARIABLE_SYMBOL' => -188,
			'LITERAL_STRING' => -188,
			'OP01_NAMED' => -188,
			'WORD_UPPERCASE' => -188,
			"\@{" => -188,
			'OP01_OPEN' => -188,
			"%{" => -188,
			'WORD' => -188,
			'OP05_MATH_NEG_LPAREN' => -188,
			'LBRACE' => -188,
			'OP22_LOGICAL_NEG' => -188,
			'OP05_LOGICAL_NEG' => -188,
			"my" => 132,
			'LITERAL_NUMBER' => -188,
			"undef" => -188,
			'OP01_CLOSE' => -188
		},
		GOTOS => {
			'TypeInner' => 297,
			'OPTIONAL-46' => 296
		}
	},
	{#State 238
		ACTIONS => {
			'FH_REF_SYMBOL' => 298
		}
	},
	{#State 239
		DEFAULT => -116
	},
	{#State 240
		ACTIONS => {
			'LBRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 299
		}
	},
	{#State 241
		DEFAULT => -123
	},
	{#State 242
		ACTIONS => {
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			'OP01_OPEN' => 100,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'WORD' => 25,
			"%{" => 72,
			'OP22_LOGICAL_NEG' => 70,
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			"undef" => 74,
			'OP01_CLOSE' => 101
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107,
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'Expression' => 123,
			'SubExpression' => 301,
			'HashDereferenced' => 95,
			'Operator' => 94
		}
	},
	{#State 243
		ACTIONS => {
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 302,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93
		},
		GOTOS => {
			'SubExpression' => 303,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'Expression' => 123,
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107
		}
	},
	{#State 244
		DEFAULT => -162
	},
	{#State 245
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_MATH_ADD_SUB' => 178,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => -96,
			"]" => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			")" => -96,
			'OP06_REGEX_MATCH' => 181,
			'OP16_LOGICAL_OR' => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP18_TERNARY' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 176,
			"}" => -96,
			";" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP09_BITWISE_SHIFT' => 188
		}
	},
	{#State 246
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP08_STRING_CAT' => -85,
			'OP13_BITWISE_AND' => -85,
			"]" => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			")" => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP18_TERNARY' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP21_LIST_COMMA' => -85,
			"}" => -85,
			'OP17_LIST_RANGE' => -85,
			";" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP09_BITWISE_SHIFT' => -85
		}
	},
	{#State 247
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -89,
			"]" => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP06_REGEX_MATCH' => 181,
			")" => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_STRING_CAT' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			";" => -89,
			"}" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP18_TERNARY' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => -89
		}
	},
	{#State 248
		ACTIONS => {
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP06_REGEX_MATCH' => 181,
			")" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"]" => -106,
			'OP15_LOGICAL_AND' => 190,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => 182,
			'OP09_BITWISE_SHIFT' => 188,
			'OP21_LIST_COMMA' => -106,
			'OP12_COMPARE_EQ_NE' => 187,
			";" => -106,
			"}" => -106,
			'OP23_LOGICAL_AND' => 185,
			'OP17_LIST_RANGE' => 186
		}
	},
	{#State 249
		ACTIONS => {
			'OP13_BITWISE_AND' => -91,
			'OP08_STRING_CAT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP06_REGEX_MATCH' => 181,
			")" => -91,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => -91,
			"]" => -91,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP07_STRING_REPEAT' => 176,
			'OP18_TERNARY' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP23_LOGICAL_AND' => -91,
			"}" => -91,
			";" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP12_COMPARE_EQ_NE' => -91
		}
	},
	{#State 250
		ACTIONS => {
			'OP16_LOGICAL_OR' => -98,
			'OP18_TERNARY' => -98,
			'OP11_COMPARE_LT_GT' => 174,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP21_LIST_COMMA' => -98,
			"}" => -98,
			";" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP09_BITWISE_SHIFT' => 188,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 178,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => -98,
			"]" => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			")" => -98,
			'OP06_REGEX_MATCH' => 181
		}
	},
	{#State 251
		ACTIONS => {
			"}" => -90,
			";" => -90,
			'OP17_LIST_RANGE' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 176,
			'OP16_LOGICAL_OR' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP18_TERNARY' => -90,
			")" => -90,
			'OP06_REGEX_MATCH' => 181,
			"]" => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP08_STRING_CAT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_MATH_ADD_SUB' => -90
		}
	},
	{#State 252
		DEFAULT => -88
	},
	{#State 253
		ACTIONS => {
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP18_TERNARY' => -101,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => -101,
			'OP09_BITWISE_SHIFT' => 188,
			'OP21_LIST_COMMA' => -101,
			'OP12_COMPARE_EQ_NE' => 187,
			";" => -101,
			"}" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP06_REGEX_MATCH' => 181,
			")" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"]" => -101,
			'OP15_LOGICAL_AND' => 190
		}
	},
	{#State 254
		ACTIONS => {
			'COLON' => 304
		}
	},
	{#State 255
		DEFAULT => -205
	},
	{#State 256
		DEFAULT => -206
	},
	{#State 257
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 178,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			"]" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			")" => -99,
			'OP06_REGEX_MATCH' => 181,
			'OP16_LOGICAL_OR' => -99,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => -99,
			'OP07_STRING_REPEAT' => 176,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP21_LIST_COMMA' => -99,
			"}" => -99,
			'OP23_LOGICAL_AND' => -99,
			";" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP09_BITWISE_SHIFT' => 188
		}
	},
	{#State 258
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 187,
			'OP21_LIST_COMMA' => -105,
			"}" => -105,
			";" => -105,
			'OP17_LIST_RANGE' => 186,
			'OP23_LOGICAL_AND' => -105,
			'OP09_BITWISE_SHIFT' => 188,
			'OP07_STRING_REPEAT' => 176,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => 182,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			")" => -105,
			'OP06_REGEX_MATCH' => 181,
			'OP15_LOGICAL_AND' => 190,
			"]" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP08_MATH_ADD_SUB' => 178
		}
	},
	{#State 259
		ACTIONS => {
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_MATH_ADD_SUB' => 178,
			")" => -102,
			'OP06_REGEX_MATCH' => 181,
			'OP15_LOGICAL_AND' => 190,
			"]" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP16_LOGICAL_OR' => 182,
			'OP18_TERNARY' => -102,
			'OP11_COMPARE_LT_GT' => 174,
			'OP21_LIST_COMMA' => -102,
			'OP12_COMPARE_EQ_NE' => 187,
			"}" => -102,
			'OP23_LOGICAL_AND' => -102,
			";" => -102,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 188
		}
	},
	{#State 260
		ACTIONS => {
			'OP06_REGEX_MATCH' => 181,
			")" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"]" => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => 188,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP21_LIST_COMMA' => -97,
			";" => -97,
			"}" => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => -97,
			'OP16_LOGICAL_OR' => -97
		}
	},
	{#State 261
		ACTIONS => {
			'OP16_LOGICAL_OR' => -93,
			'OP18_TERNARY' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP21_LIST_COMMA' => -93,
			"}" => -93,
			'OP23_LOGICAL_AND' => -93,
			";" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => 178,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => -93,
			"]" => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			")" => -93,
			'OP06_REGEX_MATCH' => 181
		}
	},
	{#State 262
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP17_LIST_RANGE' => -92,
			"}" => -92,
			";" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP07_STRING_REPEAT' => 176,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP04_MATH_POW' => 175,
			'OP18_TERNARY' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP06_REGEX_MATCH' => 181,
			")" => -92,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => -92,
			"]" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP08_STRING_CAT' => -92,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => -92
		}
	},
	{#State 263
		ACTIONS => {
			'OP06_REGEX_MATCH' => 181,
			")" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"]" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP09_BITWISE_SHIFT' => 188,
			";" => -100,
			"}" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP21_LIST_COMMA' => -100,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP18_TERNARY' => -100,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => -100
		}
	},
	{#State 264
		DEFAULT => -184
	},
	{#State 265
		ACTIONS => {
			'OP16_LOGICAL_OR' => 182,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP17_LIST_RANGE' => 186,
			'OP23_LOGICAL_AND' => 185,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 188,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP08_MATH_ADD_SUB' => 178,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			")" => 305,
			'OP06_REGEX_MATCH' => 181
		}
	},
	{#State 266
		ACTIONS => {
			'VARIABLE_SYMBOL' => 306
		}
	},
	{#State 267
		ACTIONS => {
			'LPAREN' => 307
		}
	},
	{#State 268
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 308
		}
	},
	{#State 269
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 309
		}
	},
	{#State 270
		DEFAULT => -55
	},
	{#State 271
		ACTIONS => {
			'VARIABLE_SYMBOL' => 310
		}
	},
	{#State 272
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			"}" => 311,
			'OP01_NAMED_VOID' => 73,
			"undef" => 74,
			'OP05_LOGICAL_NEG' => 79,
			"my" => 78,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_PRINT' => 86,
			'LPAREN' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'OP01_NAMED' => 91,
			"\@{" => 92,
			'LITERAL_STRING' => 93,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP01_OPEN' => 100,
			'OP01_CLOSE' => 101,
			'OP19_LOOP_CONTROL' => 102,
			'LITERAL_NUMBER' => 104,
			"foreach my" => -140,
			"while (" => -140,
			'OP10_NAMED_UNARY' => 105,
			"if (" => 106,
			"for my integer" => -140,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'WORD_UPPERCASE' => 110,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114
		},
		GOTOS => {
			'SubExpression' => 113,
			'OperatorVoid' => 112,
			'OPTIONAL-35' => 115,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'WordScoped' => 85,
			'Conditional' => 84,
			'Literal' => 83,
			'PAREN-34' => 109,
			'HashReference' => 88,
			'VariableDeclaration' => 87,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Statement' => 80,
			'Expression' => 76,
			'LoopLabel' => 77,
			'VariableModification' => 103,
			'Operation' => 312,
			'Variable' => 97
		}
	},
	{#State 273
		DEFAULT => -45
	},
	{#State 274
		DEFAULT => -41
	},
	{#State 275
		ACTIONS => {
			'WORD_UPPERCASE' => 313
		}
	},
	{#State 276
		ACTIONS => {
			'WORD' => 314
		}
	},
	{#State 277
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'KEYS_OR_VALUES' => 131,
			'LITERAL_NUMBER' => 104,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'WordScoped' => 85,
			'Literal' => 83,
			'ListElement' => 315,
			'HashReference' => 88,
			'Expression' => 123,
			'TypeInner' => 133,
			'SubExpression' => 137,
			'Operator' => 94,
			'HashDereferenced' => 95
		}
	},
	{#State 278
		DEFAULT => -173
	},
	{#State 279
		DEFAULT => -178
	},
	{#State 280
		DEFAULT => -175
	},
	{#State 281
		ACTIONS => {
			'WORD' => 25,
			"%{" => 72,
			'STDIN' => 231,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP22_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 100,
			'LITERAL_NUMBER' => 104,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP05_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 232,
			'Expression' => 123,
			'SubExpressionOrStdin' => 316,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81
		}
	},
	{#State 282
		DEFAULT => -168
	},
	{#State 283
		DEFAULT => -122
	},
	{#State 284
		DEFAULT => -110
	},
	{#State 285
		DEFAULT => -111
	},
	{#State 286
		ACTIONS => {
			")" => 317
		}
	},
	{#State 287
		ACTIONS => {
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'OP01_OPEN' => 100,
			'WORD' => 25,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP22_LOGICAL_NEG' => 70,
			'OP05_LOGICAL_NEG' => 79,
			"my" => 132,
			'KEYS_OR_VALUES' => 131,
			'LITERAL_NUMBER' => 104,
			'OP01_QW' => 135,
			'OP01_CLOSE' => 101,
			"undef" => 74
		},
		GOTOS => {
			'HashReference' => 88,
			'ListElements' => 318,
			'ListElement' => 134,
			'WordScoped' => 85,
			'Literal' => 83,
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 137,
			'Expression' => 123,
			'TypeInner' => 133
		}
	},
	{#State 288
		ACTIONS => {
			";" => 319
		}
	},
	{#State 289
		DEFAULT => -170
	},
	{#State 290
		DEFAULT => -171
	},
	{#State 291
		DEFAULT => -119
	},
	{#State 292
		ACTIONS => {
			")" => 320
		}
	},
	{#State 293
		DEFAULT => -194
	},
	{#State 294
		DEFAULT => -196
	},
	{#State 295
		ACTIONS => {
			'WORD' => 165,
			"%{" => 72
		},
		GOTOS => {
			'HashEntry' => 321,
			'HashDereferenced' => 162
		}
	},
	{#State 296
		ACTIONS => {
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'OP05_LOGICAL_NEG' => 79,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			"%{" => 72,
			'WORD' => 25,
			'OP01_OPEN' => 100,
			"\@{" => 92,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LPAREN' => 89
		},
		GOTOS => {
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'SubExpression' => 322,
			'Expression' => 123
		}
	},
	{#State 297
		DEFAULT => -187
	},
	{#State 298
		ACTIONS => {
			'OP21_LIST_COMMA' => 323
		}
	},
	{#State 299
		DEFAULT => -148,
		GOTOS => {
			'STAR-37' => 324
		}
	},
	{#State 300
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 110,
			'OP01_NAMED' => 91,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'OP01_PRINT' => 86,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'LPAREN' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			"if (" => 106,
			"for my integer" => -140,
			'OP05_LOGICAL_NEG' => 79,
			"my" => 78,
			"while (" => -140,
			'OP19_LOOP_CONTROL' => 102,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP01_NAMED_VOID' => 73,
			'LITERAL_NUMBER' => 104,
			"foreach my" => -140,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99
		},
		GOTOS => {
			'ArrayReference' => 107,
			'PLUS-40' => 326,
			'ArrayDereferenced' => 81,
			'PAREN-34' => 109,
			'HashReference' => 88,
			'VariableDeclaration' => 87,
			'Literal' => 83,
			'WordScoped' => 85,
			'Conditional' => 84,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'OPTIONAL-35' => 115,
			'SubExpression' => 113,
			'OperatorVoid' => 112,
			'Variable' => 97,
			'Operation' => 325,
			'Expression' => 76,
			'LoopLabel' => 77,
			'VariableModification' => 103,
			'Statement' => 80
		}
	},
	{#State 301
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 188,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP17_LIST_RANGE' => 186,
			'OP23_LOGICAL_AND' => 185,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => 183,
			'OP16_LOGICAL_OR' => 182,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			"]" => 327,
			'OP06_REGEX_MATCH' => 181,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189
		}
	},
	{#State 302
		ACTIONS => {
			'LPAREN' => -199,
			'OP02_METHOD_THINARROW_NEW' => -199,
			"}" => 328
		}
	},
	{#State 303
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 188,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP17_LIST_RANGE' => 186,
			'OP23_LOGICAL_AND' => 185,
			"}" => 329,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => 183,
			'OP16_LOGICAL_OR' => 182,
			'OP07_STRING_REPEAT' => 176,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP04_MATH_POW' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP06_REGEX_MATCH' => 181,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189
		}
	},
	{#State 304
		ACTIONS => {
			'LITERAL_NUMBER' => 104,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93
		},
		GOTOS => {
			'Variable' => 255,
			'VariableOrLiteral' => 330,
			'Literal' => 256
		}
	},
	{#State 305
		ACTIONS => {
			'LBRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 331
		}
	},
	{#State 306
		ACTIONS => {
			'LPAREN' => 332
		}
	},
	{#State 307
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'WordScoped' => 85,
			'Literal' => 83,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'SubExpression' => 333,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'Expression' => 123
		}
	},
	{#State 308
		ACTIONS => {
			'LITERAL_NUMBER' => 335,
			"our" => 337
		},
		GOTOS => {
			'Subroutine' => 334,
			'MethodOrSubroutine' => 338,
			'Method' => 336
		}
	},
	{#State 309
		ACTIONS => {
			'LBRACE' => 339
		}
	},
	{#State 310
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 340
		}
	},
	{#State 311
		ACTIONS => {
			";" => 341
		}
	},
	{#State 312
		DEFAULT => -44
	},
	{#State 313
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 342
		}
	},
	{#State 314
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 343
		}
	},
	{#State 315
		DEFAULT => -172
	},
	{#State 316
		ACTIONS => {
			";" => 344
		}
	},
	{#State 317
		DEFAULT => -78
	},
	{#State 318
		ACTIONS => {
			")" => 345
		}
	},
	{#State 319
		DEFAULT => -114
	},
	{#State 320
		DEFAULT => -124
	},
	{#State 321
		DEFAULT => -193
	},
	{#State 322
		ACTIONS => {
			'OP06_REGEX_MATCH' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP09_BITWISE_SHIFT' => 188,
			'OP23_LOGICAL_AND' => 185,
			"}" => -189,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP21_LIST_COMMA' => -189,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => 182
		}
	},
	{#State 323
		ACTIONS => {
			'LITERAL_STRING' => 346
		}
	},
	{#State 324
		ACTIONS => {
			"elsif (" => 349,
			'OP01_NAMED_VOID_SCOLON' => -151,
			"else" => 350,
			"for my integer" => -151,
			"if (" => -151,
			'OP10_NAMED_UNARY' => -151,
			'LBRACKET' => -151,
			'WORD_SCOPED' => -151,
			'VARIABLE_SYMBOL' => -151,
			'' => -151,
			'WORD_UPPERCASE' => -151,
			'OP01_OPEN' => -151,
			'OP05_MATH_NEG_LPAREN' => -151,
			'LBRACE' => -151,
			'WORD' => -151,
			"while (" => -151,
			"foreach my" => -151,
			'LITERAL_NUMBER' => -151,
			'OP19_LOOP_CONTROL' => -151,
			'OP01_CLOSE' => -151,
			'OP19_LOOP_CONTROL_SCOLON' => -151,
			'LPAREN' => -151,
			'OP01_PRINT' => -151,
			'OP03_MATH_INC_DEC' => -151,
			'LITERAL_STRING' => -151,
			"\@{" => -151,
			'OP01_NAMED' => -151,
			"}" => -151,
			"%{" => -151,
			'OP22_LOGICAL_NEG' => -151,
			'OP05_LOGICAL_NEG' => -151,
			"my" => -151,
			'OP01_NAMED_VOID' => -151,
			"undef" => -151
		},
		GOTOS => {
			'OPTIONAL-39' => 348,
			'PAREN-36' => 347,
			'PAREN-38' => 351
		}
	},
	{#State 325
		DEFAULT => -160
	},
	{#State 326
		ACTIONS => {
			"foreach my" => -140,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			'OP19_LOOP_CONTROL' => 102,
			"while (" => -140,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP01_OPEN' => 100,
			'VARIABLE_SYMBOL' => 111,
			'WORD_UPPERCASE' => 110,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			"if (" => 106,
			"for my integer" => -140,
			'OP10_NAMED_UNARY' => 105,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'OP01_NAMED_VOID' => 73,
			"undef" => 74,
			'OP05_LOGICAL_NEG' => 79,
			"my" => 78,
			"%{" => 72,
			"}" => 353,
			'OP22_LOGICAL_NEG' => 70,
			'LITERAL_STRING' => 93,
			'OP01_NAMED' => 91,
			"\@{" => 92,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'OP01_PRINT' => 86
		},
		GOTOS => {
			'Statement' => 80,
			'LoopLabel' => 77,
			'Expression' => 76,
			'VariableModification' => 103,
			'Variable' => 97,
			'Operation' => 352,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'OPTIONAL-35' => 115,
			'OperatorVoid' => 112,
			'SubExpression' => 113,
			'PAREN-34' => 109,
			'VariableDeclaration' => 87,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Conditional' => 84,
			'Literal' => 83,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81
		}
	},
	{#State 327
		DEFAULT => -165
	},
	{#State 328
		DEFAULT => -167
	},
	{#State 329
		DEFAULT => -166
	},
	{#State 330
		DEFAULT => -103
	},
	{#State 331
		DEFAULT => -158
	},
	{#State 332
		ACTIONS => {
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			"%{" => 72,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			"my" => 132,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'KEYS_OR_VALUES' => 131,
			'OP01_QW' => 135,
			'LPAREN' => 89,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93
		},
		GOTOS => {
			'SubExpression' => 137,
			'HashDereferenced' => 95,
			'Operator' => 94,
			'Expression' => 123,
			'TypeInner' => 133,
			'Literal' => 83,
			'WordScoped' => 85,
			'ListElements' => 354,
			'HashReference' => 88,
			'ListElement' => 134,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107
		}
	},
	{#State 333
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP06_REGEX_MATCH' => 181,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP09_BITWISE_SHIFT' => 188,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP23_LOGICAL_AND' => 185,
			'OP17_LIST_RANGE' => 355,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => 182,
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184
		}
	},
	{#State 334
		DEFAULT => -75
	},
	{#State 335
		ACTIONS => {
			";" => 356
		}
	},
	{#State 336
		DEFAULT => -74
	},
	{#State 337
		ACTIONS => {
			'TYPE_METHOD' => 357,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 338
		DEFAULT => -57
	},
	{#State 339
		ACTIONS => {
			"}" => 358,
			'WORD' => 361,
			"%{" => 72
		},
		GOTOS => {
			'HashDereferenced' => 359,
			'HashEntryTyped' => 360
		}
	},
	{#State 340
		ACTIONS => {
			'OP21_LIST_COMMA' => 364,
			")" => 363
		},
		GOTOS => {
			'PAREN-18' => 362
		}
	},
	{#State 341
		DEFAULT => -46
	},
	{#State 342
		DEFAULT => -204
	},
	{#State 343
		DEFAULT => -203
	},
	{#State 344
		DEFAULT => -169
	},
	{#State 345
		DEFAULT => -80
	},
	{#State 346
		ACTIONS => {
			'OP21_LIST_COMMA' => 365
		}
	},
	{#State 347
		DEFAULT => -147
	},
	{#State 348
		DEFAULT => -152
	},
	{#State 349
		ACTIONS => {
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'OP01_OPEN' => 100,
			'WORD' => 25,
			"%{" => 72,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP22_LOGICAL_NEG' => 70,
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			"undef" => 74
		},
		GOTOS => {
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83,
			'Expression' => 123,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 366
		}
	},
	{#State 350
		ACTIONS => {
			'LBRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 367
		}
	},
	{#State 351
		DEFAULT => -150
	},
	{#State 352
		DEFAULT => -159
	},
	{#State 353
		DEFAULT => -161
	},
	{#State 354
		ACTIONS => {
			")" => 368
		}
	},
	{#State 355
		ACTIONS => {
			"%{" => 72,
			'WORD' => 25,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP22_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 100,
			'LITERAL_NUMBER' => 104,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'OP05_LOGICAL_NEG' => 79,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'LPAREN' => 89,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Expression' => 123,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'SubExpression' => 369,
			'Variable' => 125,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'HashReference' => 88,
			'WordScoped' => 85,
			'Literal' => 83
		}
	},
	{#State 356
		DEFAULT => -59
	},
	{#State 357
		ACTIONS => {
			'VARIABLE_SYMBOL' => 370
		}
	},
	{#State 358
		ACTIONS => {
			";" => 371
		}
	},
	{#State 359
		DEFAULT => -192
	},
	{#State 360
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 372
		}
	},
	{#State 361
		ACTIONS => {
			'OP20_HASH_FATARROW' => 373
		}
	},
	{#State 362
		DEFAULT => -48
	},
	{#State 363
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 374
		}
	},
	{#State 364
		ACTIONS => {
			"my" => 375
		}
	},
	{#State 365
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 104,
			"undef" => 74,
			'OP01_CLOSE' => 101,
			'OP01_OPEN' => 100,
			'WORD' => 25,
			"%{" => 72,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'OP22_LOGICAL_NEG' => 70,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93,
			'WORD_UPPERCASE' => 127,
			'OP01_NAMED' => 124,
			"\@{" => 92,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82
		},
		GOTOS => {
			'Expression' => 123,
			'SubExpression' => 376,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'ArrayReference' => 107,
			'Variable' => 125,
			'WordScoped' => 85,
			'Literal' => 83,
			'HashReference' => 88
		}
	},
	{#State 366
		ACTIONS => {
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => 182,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP09_BITWISE_SHIFT' => 188,
			'OP23_LOGICAL_AND' => 185,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP15_LOGICAL_AND' => 190,
			'OP06_REGEX_MATCH' => 181,
			")" => 377
		}
	},
	{#State 367
		DEFAULT => -149
	},
	{#State 368
		ACTIONS => {
			'LBRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 369
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP09_BITWISE_SHIFT' => 188,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP16_LOGICAL_OR' => 182,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => -102,
			")" => 379,
			'OP06_REGEX_MATCH' => 181,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_MATH_ADD_SUB' => 178
		}
	},
	{#State 370
		ACTIONS => {
			"= sub {" => 380
		}
	},
	{#State 371
		DEFAULT => -64
	},
	{#State 372
		ACTIONS => {
			"}" => 383,
			'OP21_LIST_COMMA' => 382
		},
		GOTOS => {
			'PAREN-24' => 381
		}
	},
	{#State 373
		ACTIONS => {
			"my" => 132
		},
		GOTOS => {
			'TypeInner' => 384
		}
	},
	{#State 374
		ACTIONS => {
			"\@_;" => 385
		}
	},
	{#State 375
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 386
		}
	},
	{#State 376
		ACTIONS => {
			'OP07_STRING_REPEAT' => 176,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP18_TERNARY' => 183,
			'OP11_COMPARE_LT_GT' => 174,
			'OP16_LOGICAL_OR' => 182,
			'OP09_BITWISE_SHIFT' => 188,
			'OP21_LIST_COMMA' => -81,
			'OP12_COMPARE_EQ_NE' => 187,
			";" => -81,
			"}" => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP17_LIST_RANGE' => 186,
			'OP13_BITWISE_AND' => 179,
			'OP08_STRING_CAT' => 189,
			'OP08_MATH_ADD_SUB' => 178,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => 181,
			")" => -81,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			"]" => -81,
			'OP15_LOGICAL_AND' => 190
		}
	},
	{#State 377
		ACTIONS => {
			'LBRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 378
		DEFAULT => -157
	},
	{#State 379
		ACTIONS => {
			'LBRACE' => 300
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 380
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -66,
			'LPAREN' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP01_PRINT' => -66,
			'LITERAL_STRING' => -66,
			'OP01_NAMED' => -66,
			"\@{" => -66,
			"%{" => -66,
			'OP22_LOGICAL_NEG' => -66,
			'LPAREN_MY' => 390,
			'OP01_NAMED_VOID' => -66,
			"undef" => -66,
			'OP05_LOGICAL_NEG' => -66,
			"my" => -66,
			"if (" => -66,
			"for my integer" => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'VARIABLE_SYMBOL' => -66,
			'WORD_UPPERCASE' => -66,
			'LBRACKET' => -66,
			'WORD_SCOPED' => -66,
			'WORD' => -66,
			'LBRACE' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP01_OPEN' => -66,
			"foreach my" => -66,
			'LITERAL_NUMBER' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP01_CLOSE' => -66,
			"while (" => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 391,
			'MethodArguments' => 389
		}
	},
	{#State 381
		DEFAULT => -61
	},
	{#State 382
		ACTIONS => {
			'WORD' => 361,
			"%{" => 72
		},
		GOTOS => {
			'HashDereferenced' => 359,
			'HashEntryTyped' => 392
		}
	},
	{#State 383
		ACTIONS => {
			";" => 393
		}
	},
	{#State 384
		ACTIONS => {
			'OP01_OPEN' => 100,
			'OP22_LOGICAL_NEG' => 70,
			'WORD' => 25,
			"%{" => 72,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'OP05_LOGICAL_NEG' => 79,
			'OP01_CLOSE' => 101,
			"undef" => 74,
			'LITERAL_NUMBER' => 104,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 105,
			'OP03_MATH_INC_DEC' => 82,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114,
			'OP01_NAMED' => 124,
			'WORD_UPPERCASE' => 127,
			"\@{" => 92,
			'VARIABLE_SYMBOL' => 111,
			'LITERAL_STRING' => 93
		},
		GOTOS => {
			'SubExpression' => 394,
			'Operator' => 94,
			'HashDereferenced' => 95,
			'Expression' => 123,
			'Literal' => 83,
			'WordScoped' => 85,
			'HashReference' => 88,
			'ArrayDereferenced' => 81,
			'Variable' => 125,
			'ArrayReference' => 107
		}
	},
	{#State 385
		DEFAULT => -50
	},
	{#State 386
		ACTIONS => {
			'VARIABLE_SYMBOL' => 395
		}
	},
	{#State 387
		DEFAULT => -146
	},
	{#State 388
		DEFAULT => -156
	},
	{#State 389
		DEFAULT => -65
	},
	{#State 390
		ACTIONS => {
			'TYPE_SELF' => 396
		}
	},
	{#State 391
		ACTIONS => {
			"for my integer" => -140,
			"if (" => 106,
			'OP03_MATH_INC_DEC' => 82,
			'OP10_NAMED_UNARY' => 105,
			'LPAREN' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'OP01_PRINT' => 86,
			'LITERAL_STRING' => 93,
			'VARIABLE_SYMBOL' => 111,
			"\@{" => 92,
			'WORD_UPPERCASE' => 110,
			'OP01_NAMED' => 91,
			'LBRACKET' => 114,
			'WORD_SCOPED' => 24,
			'LBRACE' => 99,
			'OP05_MATH_NEG_LPAREN' => 98,
			'WORD' => 25,
			"%{" => 72,
			'OP22_LOGICAL_NEG' => 70,
			'OP01_OPEN' => 100,
			'LITERAL_NUMBER' => 104,
			"foreach my" => -140,
			"undef" => 74,
			'OP01_NAMED_VOID' => 73,
			'OP01_CLOSE' => 101,
			'OP19_LOOP_CONTROL' => 102,
			"while (" => -140,
			"my" => 78,
			'OP05_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'Statement' => 80,
			'LoopLabel' => 77,
			'Expression' => 76,
			'VariableModification' => 103,
			'Variable' => 97,
			'Operation' => 397,
			'PLUS-27' => 398,
			'HashDereferenced' => 95,
			'OPTIONAL-35' => 115,
			'Operator' => 94,
			'OperatorVoid' => 112,
			'SubExpression' => 113,
			'PAREN-34' => 109,
			'HashReference' => 88,
			'VariableDeclaration' => 87,
			'WordScoped' => 85,
			'Conditional' => 84,
			'Literal' => 83,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81
		}
	},
	{#State 392
		DEFAULT => -60
	},
	{#State 393
		DEFAULT => -63
	},
	{#State 394
		ACTIONS => {
			"}" => -191,
			'OP17_LIST_RANGE' => 186,
			'OP23_LOGICAL_AND' => 185,
			'OP12_COMPARE_EQ_NE' => 187,
			'OP21_LIST_COMMA' => -191,
			'OP09_BITWISE_SHIFT' => 188,
			'OP04_MATH_POW' => 175,
			'OP14_BITWISE_OR_XOR' => 184,
			'OP07_STRING_REPEAT' => 176,
			'OP16_LOGICAL_OR' => 182,
			'OP11_COMPARE_LT_GT' => 174,
			'OP18_TERNARY' => 183,
			'OP06_REGEX_MATCH' => 181,
			'OP15_LOGICAL_AND' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 180,
			'OP08_STRING_CAT' => 189,
			'OP13_BITWISE_AND' => 179,
			'OP24_LOGICAL_OR_XOR' => 177,
			'OP08_MATH_ADD_SUB' => 178
		}
	},
	{#State 395
		DEFAULT => -47
	},
	{#State 396
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 399
		}
	},
	{#State 397
		DEFAULT => -68
	},
	{#State 398
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 70,
			"}" => 400,
			"%{" => 72,
			"undef" => 74,
			'OP01_NAMED_VOID' => 73,
			'OP05_LOGICAL_NEG' => 79,
			"my" => 78,
			'OP03_MATH_INC_DEC' => 82,
			'OP01_PRINT' => 86,
			'LPAREN' => 89,
			'OP19_LOOP_CONTROL_SCOLON' => 90,
			"\@{" => 92,
			'OP01_NAMED' => 91,
			'LITERAL_STRING' => 93,
			'OP05_MATH_NEG_LPAREN' => 98,
			'LBRACE' => 99,
			'WORD' => 25,
			'OP01_OPEN' => 100,
			'OP19_LOOP_CONTROL' => 102,
			'OP01_CLOSE' => 101,
			"foreach my" => -140,
			'LITERAL_NUMBER' => 104,
			"while (" => -140,
			'OP10_NAMED_UNARY' => 105,
			"for my integer" => -140,
			"if (" => 106,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'WORD_UPPERCASE' => 110,
			'VARIABLE_SYMBOL' => 111,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 114
		},
		GOTOS => {
			'Operator' => 94,
			'OPTIONAL-35' => 115,
			'HashDereferenced' => 95,
			'SubExpression' => 113,
			'OperatorVoid' => 112,
			'PAREN-34' => 109,
			'VariableDeclaration' => 87,
			'HashReference' => 88,
			'Literal' => 83,
			'WordScoped' => 85,
			'Conditional' => 84,
			'ArrayReference' => 107,
			'ArrayDereferenced' => 81,
			'Statement' => 80,
			'Expression' => 76,
			'LoopLabel' => 77,
			'VariableModification' => 103,
			'Variable' => 97,
			'Operation' => 401
		}
	},
	{#State 399
		ACTIONS => {
			'OP21_LIST_COMMA' => 403,
			")" => 402
		},
		GOTOS => {
			'PAREN-28' => 404
		}
	},
	{#State 400
		ACTIONS => {
			";" => 405
		}
	},
	{#State 401
		DEFAULT => -67
	},
	{#State 402
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 406
		}
	},
	{#State 403
		ACTIONS => {
			"my" => 407
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
			"\@_;" => 408
		}
	},
	{#State 407
		ACTIONS => {
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 409
		}
	},
	{#State 408
		DEFAULT => -73
	},
	{#State 409
		ACTIONS => {
			'VARIABLE_SYMBOL' => 410
		}
	},
	{#State 410
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5784 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5791 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 133 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5798 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5809 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5820 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5869 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5876 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5904 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5915 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5929 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6018 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6029 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6079 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6090 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6112 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6151 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6172 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6250 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6271 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6353 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6364 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6375 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6386 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6397 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6408 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6419 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6430 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6441 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6452 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6463 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6485 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6507 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6518 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6529 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6540 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6551 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6562 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6573 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6584 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6606 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6628 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6639 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6650 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6672 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6694 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6705 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6727 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 167 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6748 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_110
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6759 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6770 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6781 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6792 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6803 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6814 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6825 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6832 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6846 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 170 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6853 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_121
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6864 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6897 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_126
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6919 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6930 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6941 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6963 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6974 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6985 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6996 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7018 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_136
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7029 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_137
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7040 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7047 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_141
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7094 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7105 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7116 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7130 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7137 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7158 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_152
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7169 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_153
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7180 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7191 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_155
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7202 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_156
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_157
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_158
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7235 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_161
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_164
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_165
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_167
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7318 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_168
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_169
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_170
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_171
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7369 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7376 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7390 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7397 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_177
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_178
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7419 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_179
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_180
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7441 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_181
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7452 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_184
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_185
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_186
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7513 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_189
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7535 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_191
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7557 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_196
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_197
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_198
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_199
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7622 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_200
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7633 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_201
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7644 lib/RPerl/Grammar.pm
	],
	[#Rule Type_202
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7655 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_203
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7666 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_204
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7677 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_205
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7688 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_206
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7699 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_207
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7710 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7721 lib/RPerl/Grammar.pm
	]
],
#line 7724 lib/RPerl/Grammar.pm
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
         'SubExpression_135', 
         'SubExpressionOrStdin_136', 
         'SubExpressionOrStdin_137', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_141', 
         'Statement_142', 
         'Statement_143', 
         'Statement_144', 
         'Statement_145', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_152', 
         'Loop_153', 
         'Loop_154', 
         'Loop_155', 
         'LoopFor_156', 
         'LoopForEach_157', 
         'LoopWhile_158', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_161', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_164', 
         'VariableRetrieval_165', 
         'VariableRetrieval_166', 
         'VariableRetrieval_167', 
         'VariableDeclaration_168', 
         'VariableDeclaration_169', 
         'VariableModification_170', 
         'VariableModification_171', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_177', 
         'ListElements_178', 
         'ListElement_179', 
         'ListElement_180', 
         'ListElement_181', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_184', 
         'ArrayDereferenced_185', 
         'ArrayDereferenced_186', 
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
         'HashDereferenced_197', 
         'HashDereferenced_198', 
         'WordScoped_199', 
         'WordScoped_200', 
         'LoopLabel_201', 
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


#line 7981 lib/RPerl/Grammar.pm



1;
