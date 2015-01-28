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
    our $VERSION = 0.000_961;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|for\ my\ integer|filehandle_ref|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|package|while\ \(|elsif\ \(|\$TYPED_|\=\ sub\ \{|undef|if\ \(|else|use|qw\(|our|\@_\;|my|\@\{|\%\{|\)|\;|\}|\])}gc and return ($1, $1);

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
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
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
      /\G(print)\s/gc and return ('OP01_PRINT', $1);
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
  [ 'MethodArguments_73' => 'MethodArguments', [ 'LPAREN_MY', 'TYPE_CLASS_OR_SELF', 'STAR-29', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
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
	TYPE_CLASS_OR_SELF => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 2,
			'SHEBANG' => 1,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 3,
			'CompileUnit' => 6,
			'Critic' => 5,
			'Program' => 4,
			'OPTIONAL-9' => 8,
			'PLUS-2' => 7,
			'ModuleHeader' => 9
		}
	},
	{#State 1
		ACTIONS => {
			"## no critic qw(" => 2,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 11,
			'Critic' => 10
		}
	},
	{#State 2
		ACTIONS => {
			'WORD' => 13
		},
		GOTOS => {
			'PLUS-14' => 12
		}
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		ACTIONS => {
			'' => 14
		}
	},
	{#State 7
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 2,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 15,
			'ModuleHeader' => 9,
			'OPTIONAL-9' => 8,
			'Critic' => 5
		}
	},
	{#State 8
		ACTIONS => {
			"package" => 16
		}
	},
	{#State 9
		ACTIONS => {
			"our" => -25,
			"use" => -25,
			"use parent qw(" => 21,
			"## no critic qw(" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'Module' => 17,
			'Class' => 18,
			'Package' => 20,
			'STAR-10' => 19
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
		ACTIONS => {
			")" => 24,
			'WORD' => 25
		}
	},
	{#State 13
		DEFAULT => -35
	},
	{#State 14
		DEFAULT => 0
	},
	{#State 15
		DEFAULT => -2
	},
	{#State 16
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 28
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
			"use constant" => -27,
			"## no critic qw(" => 2,
			"use" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 30,
			'Critic' => 29
		}
	},
	{#State 20
		DEFAULT => -22
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 31
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
		DEFAULT => -36
	},
	{#State 25
		DEFAULT => -34
	},
	{#State 26
		DEFAULT => -200
	},
	{#State 27
		DEFAULT => -199
	},
	{#State 28
		ACTIONS => {
			";" => 34
		}
	},
	{#State 29
		DEFAULT => -24
	},
	{#State 30
		ACTIONS => {
			"use" => 36,
			"our" => -29,
			"use constant" => -29
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 37
		}
	},
	{#State 31
		ACTIONS => {
			")" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LITERAL_STRING' => -11,
			'WORD_UPPERCASE' => -11,
			"if (" => -11,
			'WORD' => -11,
			"while (" => -11,
			"undef" => -11,
			"my" => -11,
			'LPAREN' => -11,
			"for my integer" => -11,
			'OP10_NAMED_UNARY' => -11,
			"use constant" => -11,
			'VARIABLE_SYMBOL' => -11,
			"foreach my" => -11,
			"## no critic qw(" => 2,
			'WORD_SCOPED' => -11,
			"use" => -11,
			'OP22_LOGICAL_NEG' => -11,
			"our" => -11,
			'OP01_OPEN' => -11,
			"\@{" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"%{" => -11,
			'OP01_CLOSE' => -11,
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_PRINT' => -11,
			'OP01_NAMED' => -11,
			'LBRACE' => -11
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
			'WORD' => 27,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 37
		ACTIONS => {
			"use constant" => 45,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 46,
			'Constant' => 47,
			'PLUS-13' => 48
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
			"use" => 36,
			'WORD_SCOPED' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_OPEN' => -13,
			"our" => -13,
			"\@{" => -13,
			'LBRACKET' => -13,
			'LITERAL_NUMBER' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_CLOSE' => -13,
			"%{" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_NAMED' => -13,
			'OP01_PRINT' => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'WORD_UPPERCASE' => -13,
			'LITERAL_STRING' => -13,
			"undef" => -13,
			"while (" => -13,
			'WORD' => -13,
			"if (" => -13,
			"my" => -13,
			"for my integer" => -13,
			'OP10_NAMED_UNARY' => -13,
			'LPAREN' => -13,
			"foreach my" => -13,
			"use constant" => -13,
			'VARIABLE_SYMBOL' => -13
		},
		GOTOS => {
			'STAR-6' => 52,
			'Include' => 51
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
			"qw(" => 54,
			";" => 53
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 45
		ACTIONS => {
			'WORD_UPPERCASE' => 57
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
			'LITERAL_NUMBER' => 58,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 59
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 60
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 61
		}
	},
	{#State 51
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			"while (" => -15,
			"undef" => -15,
			'WORD' => -15,
			"if (" => -15,
			'WORD_UPPERCASE' => -15,
			'LITERAL_STRING' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"foreach my" => -15,
			'VARIABLE_SYMBOL' => -15,
			"use constant" => 45,
			'OP10_NAMED_UNARY' => -15,
			"for my integer" => -15,
			'LPAREN' => -15,
			"my" => -15,
			"\@{" => -15,
			"our" => -15,
			'OP01_OPEN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'WORD_SCOPED' => -15,
			'LBRACE' => -15,
			'OP01_NAMED' => -15,
			'OP01_PRINT' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_CLOSE' => -15,
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LITERAL_NUMBER' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"%{" => -15
		},
		GOTOS => {
			'Constant' => 62,
			'STAR-7' => 63
		}
	},
	{#State 53
		DEFAULT => -39
	},
	{#State 54
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 64
		}
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
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
		ACTIONS => {
			";" => 68
		}
	},
	{#State 59
		DEFAULT => -30
	},
	{#State 60
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 69
		}
	},
	{#State 61
		DEFAULT => -33
	},
	{#State 62
		DEFAULT => -12
	},
	{#State 63
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			"foreach my" => -140,
			"my" => 115,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			"for my integer" => -140,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 97,
			'WORD' => 27,
			"if (" => 96,
			"undef" => 95,
			"while (" => -140,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'LBRACE' => 79,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP19_LOOP_CONTROL' => 89,
			'OP01_CLOSE' => 88,
			'OP01_PRINT' => 85,
			'OP01_NAMED_VOID' => 84,
			'OP01_NAMED' => 86,
			'OP01_OPEN' => 74,
			"our" => 44,
			"\@{" => 71,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'LoopLabel' => 77,
			'PAREN-34' => 75,
			'VariableModification' => 76,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'VariableDeclaration' => 98,
			'HashDereferenced' => 100,
			'SubExpression' => 72,
			'Expression' => 70,
			'Subroutine' => 94,
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113,
			'PLUS-8' => 110,
			'OperatorVoid' => 83,
			'Variable' => 80,
			'OPTIONAL-35' => 107,
			'Conditional' => 81,
			'WordScoped' => 109,
			'Operation' => 82,
			'Statement' => 106
		}
	},
	{#State 64
		ACTIONS => {
			")" => 116,
			'WORD' => 117
		}
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 118
		}
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
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			"our hash_ref \$properties" => -54,
			"## no critic qw(" => 2,
			"use constant" => -54,
			"use" => -54
		},
		GOTOS => {
			'STAR-21' => 122,
			'Critic' => 121
		}
	},
	{#State 70
		ACTIONS => {
			'OP04_MATH_POW' => -126,
			'OP07_STRING_REPEAT' => -126,
			'OP14_BITWISE_OR_XOR' => -126,
			'OP07_MATH_MULT_DIV_MOD' => -126,
			'OP17_LIST_RANGE' => -126,
			'OP12_COMPARE_EQ_NE' => -126,
			";" => 123,
			'OP18_TERNARY' => -126,
			'OP06_REGEX_MATCH' => -126,
			'OP13_BITWISE_AND' => -126,
			'OP23_LOGICAL_AND' => -126,
			'OP09_BITWISE_SHIFT' => -126,
			'OP11_COMPARE_LT_GT' => -126,
			'OP24_LOGICAL_OR_XOR' => -126,
			'OP08_STRING_CAT' => -126,
			'OP15_LOGICAL_AND' => -126,
			'OP08_MATH_ADD_SUB' => -126,
			'OP16_LOGICAL_OR' => -126
		}
	},
	{#State 71
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 91
		},
		GOTOS => {
			'ArrayReference' => 124,
			'Variable' => 125
		}
	},
	{#State 72
		ACTIONS => {
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => 139,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP16_LOGICAL_OR' => 140,
			'OP15_LOGICAL_AND' => 131,
			'OP08_MATH_ADD_SUB' => 132,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => 129,
			'OP06_REGEX_MATCH' => 127,
			'OP18_TERNARY' => 138
		}
	},
	{#State 73
		DEFAULT => -131
	},
	{#State 74
		ACTIONS => {
			"my" => 143
		}
	},
	{#State 75
		DEFAULT => -139
	},
	{#State 76
		DEFAULT => -145
	},
	{#State 77
		ACTIONS => {
			'COLON' => 144
		}
	},
	{#State 78
		ACTIONS => {
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'Expression' => 148,
			'Variable' => 146,
			'SubExpression' => 147,
			'WordScoped' => 109,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100
		}
	},
	{#State 79
		ACTIONS => {
			"}" => 150,
			'WORD' => 152,
			"%{" => 93
		},
		GOTOS => {
			'HashDereferenced' => 153,
			'HashEntry' => 151
		}
	},
	{#State 80
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP18_TERNARY' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP04_MATH_POW' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP08_STRING_CAT' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP03_MATH_INC_DEC' => 154,
			'OP02_METHOD_THINARROW' => 156,
			'OP16_LOGICAL_OR' => -129,
			'OP19_VARIABLE_ASSIGN' => 157,
			'OP19_VARIABLE_ASSIGN_BY' => 155,
			'OP08_MATH_ADD_SUB' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP23_LOGICAL_AND' => -129
		}
	},
	{#State 81
		DEFAULT => -141
	},
	{#State 82
		DEFAULT => -17
	},
	{#State 83
		DEFAULT => -143
	},
	{#State 84
		ACTIONS => {
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			"my" => 158,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'OP01_QW' => 164,
			'KEYS_OR_VALUES' => 163,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74
		},
		GOTOS => {
			'ListElements' => 159,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'WordScoped' => 109,
			'SubExpression' => 161,
			'Variable' => 146,
			'TypeInner' => 162,
			'Expression' => 148,
			'ArrayReference' => 87,
			'ListElement' => 160,
			'Operator' => 113,
			'Literal' => 111
		}
	},
	{#State 85
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -109,
			"%{" => -109,
			'OP01_CLOSE' => -109,
			'LBRACKET' => -109,
			"my" => -109,
			'LITERAL_NUMBER' => -109,
			'OP01_NAMED' => -109,
			'LPAREN' => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP01_QW' => -109,
			'KEYS_OR_VALUES' => -109,
			'VARIABLE_SYMBOL' => -109,
			'LBRACE' => -109,
			'STDOUT_STDERR' => 165,
			'FH_REF_SYMBOL_BRACES' => 166,
			'WORD_SCOPED' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LITERAL_STRING' => -109,
			'WORD_UPPERCASE' => -109,
			'OP01_OPEN' => -109,
			'WORD' => -109,
			"\@{" => -109,
			"undef" => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 167,
			'PAREN-30' => 168
		}
	},
	{#State 86
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP22_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			"my" => 158,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP01_CLOSE' => 88,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			'KEYS_OR_VALUES' => 163,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 169,
			'TypeInner' => 162,
			'Expression' => 148,
			'ArrayReference' => 87,
			'ListElement' => 170,
			'Operator' => 113,
			'Literal' => 111
		}
	},
	{#State 87
		DEFAULT => -130
	},
	{#State 88
		ACTIONS => {
			'FH_REF_SYMBOL' => 171
		}
	},
	{#State 89
		ACTIONS => {
			'WORD_UPPERCASE' => 173
		},
		GOTOS => {
			'LoopLabel' => 172
		}
	},
	{#State 90
		DEFAULT => -208
	},
	{#State 91
		ACTIONS => {
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'KEYS_OR_VALUES' => 163,
			'OP01_QW' => 164,
			'LBRACE' => 79,
			"]" => -183,
			'VARIABLE_SYMBOL' => 108,
			"my" => 158,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145
		},
		GOTOS => {
			'ListElement' => 160,
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113,
			'SubExpression' => 161,
			'Variable' => 146,
			'WordScoped' => 109,
			'Expression' => 148,
			'TypeInner' => 162,
			'ListElements' => 175,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'HashDereferenced' => 100,
			'OPTIONAL-45' => 174
		}
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'Expression' => 148,
			'WordScoped' => 109,
			'SubExpression' => 176,
			'Variable' => 146
		}
	},
	{#State 93
		ACTIONS => {
			'LBRACE' => 178,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'HashReference' => 177,
			'Variable' => 179
		}
	},
	{#State 94
		DEFAULT => -14
	},
	{#State 95
		DEFAULT => -127
	},
	{#State 96
		ACTIONS => {
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'Expression' => 148,
			'WordScoped' => 109,
			'SubExpression' => 180,
			'Variable' => 146,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 97
		ACTIONS => {
			'COLON' => -201,
			'LPAREN' => 181
		}
	},
	{#State 98
		DEFAULT => -144
	},
	{#State 99
		DEFAULT => -132
	},
	{#State 100
		DEFAULT => -133
	},
	{#State 101
		DEFAULT => -207
	},
	{#State 102
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Variable' => 182
		}
	},
	{#State 103
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP22_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'Expression' => 148,
			'Variable' => 146,
			'SubExpression' => 183,
			'WordScoped' => 109
		}
	},
	{#State 104
		DEFAULT => -112
	},
	{#State 105
		DEFAULT => -115
	},
	{#State 106
		DEFAULT => -77
	},
	{#State 107
		ACTIONS => {
			"for my integer" => 188,
			"while (" => 184,
			"foreach my" => 187
		},
		GOTOS => {
			'LoopFor' => 186,
			'LoopForEach' => 189,
			'Loop' => 185,
			'LoopWhile' => 190
		}
	},
	{#State 108
		DEFAULT => -163,
		GOTOS => {
			'STAR-41' => 191
		}
	},
	{#State 109
		ACTIONS => {
			'LPAREN' => 193,
			'OP02_METHOD_THINARROW_NEW' => 192
		}
	},
	{#State 110
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			"\@{" => 71,
			'' => -18,
			'OP01_OPEN' => 74,
			'OP01_NAMED' => 86,
			'OP01_NAMED_VOID' => 84,
			'OP01_PRINT' => 85,
			'LBRACKET' => 91,
			'OP19_LOOP_CONTROL' => 89,
			'LITERAL_NUMBER' => 90,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACE' => 79,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			"undef" => 95,
			"while (" => -140,
			'WORD' => 27,
			"if (" => 96,
			'WORD_UPPERCASE' => 97,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY' => 112,
			"for my integer" => -140,
			'LPAREN' => 114,
			"my" => 115,
			"foreach my" => -140,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'LoopLabel' => 77,
			'SubExpression' => 72,
			'Expression' => 70,
			'VariableModification' => 76,
			'PAREN-34' => 75,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'VariableDeclaration' => 98,
			'HashDereferenced' => 100,
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113,
			'OPTIONAL-35' => 107,
			'Conditional' => 81,
			'Variable' => 80,
			'WordScoped' => 109,
			'Operation' => 194,
			'Statement' => 106,
			'OperatorVoid' => 83
		}
	},
	{#State 111
		DEFAULT => -128
	},
	{#State 112
		ACTIONS => {
			'OP16_LOGICAL_OR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP24_LOGICAL_OR_XOR' => -95,
			"undef" => 95,
			'WORD' => 27,
			'OP23_LOGICAL_AND' => -95,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			'OP18_TERNARY' => -95,
			";" => -95,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'VARIABLE_SYMBOL' => 108,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP04_MATH_POW' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP22_LOGICAL_NEG' => 78,
			"}" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP08_STRING_CAT' => -95,
			'WORD_SCOPED' => 26,
			"\@{" => 71,
			'OP21_LIST_COMMA' => -95,
			'OP01_OPEN' => 74,
			'OP13_BITWISE_AND' => -95,
			'OP01_NAMED' => 145,
			")" => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP01_CLOSE' => 88,
			'OP17_LIST_RANGE' => -95,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'LBRACE' => 79,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			"]" => -95
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 195,
			'Expression' => 148,
			'ArrayReference' => 87,
			'Operator' => 113,
			'Literal' => 111
		}
	},
	{#State 113
		DEFAULT => -121
	},
	{#State 114
		ACTIONS => {
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			'LPAREN' => 114,
			'OP01_PRINT' => 196,
			'OP01_NAMED' => 197,
			'OP10_NAMED_UNARY' => 112,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP22_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'WORD' => 27,
			"undef" => 95,
			"\@{" => 71
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'Expression' => 148,
			'Variable' => 146,
			'SubExpression' => 198,
			'WordScoped' => 109,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100
		}
	},
	{#State 115
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 199
		}
	},
	{#State 116
		ACTIONS => {
			";" => 200
		}
	},
	{#State 117
		DEFAULT => -37
	},
	{#State 118
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"if (" => -43,
			'WORD' => -43,
			"undef" => -43,
			"while (" => -43,
			'LITERAL_STRING' => -43,
			'WORD_UPPERCASE' => -43,
			'LPAREN' => -43,
			"for my integer" => -43,
			'OP10_NAMED_UNARY' => -43,
			"my" => -43,
			'VARIABLE_SYMBOL' => -43,
			"foreach my" => -43,
			'OP22_LOGICAL_NEG' => -43,
			'WORD_SCOPED' => -43,
			'LPAREN_MY' => 202,
			"\@{" => -43,
			'OP01_OPEN' => -43,
			'OP01_PRINT' => -43,
			'OP01_NAMED_VOID' => -43,
			'OP01_NAMED' => -43,
			"%{" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LBRACKET' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_CLOSE' => -43,
			'LBRACE' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 201,
			'OPTIONAL-16' => 203
		}
	},
	{#State 119
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 120
		ACTIONS => {
			'LITERAL_NUMBER' => 90,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'Literal' => 205
		}
	},
	{#State 121
		DEFAULT => -51
	},
	{#State 122
		ACTIONS => {
			"our hash_ref \$properties" => -56,
			"use constant" => -56,
			"use" => 36
		},
		GOTOS => {
			'Include' => 206,
			'STAR-22' => 207
		}
	},
	{#State 123
		DEFAULT => -76
	},
	{#State 124
		ACTIONS => {
			"}" => 208
		}
	},
	{#State 125
		ACTIONS => {
			"}" => 209
		}
	},
	{#State 126
		ACTIONS => {
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP22_LOGICAL_NEG' => 78,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP01_CLOSE' => 88,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 210,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 127
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 211
		}
	},
	{#State 128
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'WORD' => 27,
			"undef" => 95,
			"\@{" => 71,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Operator' => 113,
			'Literal' => 111,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 212,
			'Expression' => 148
		}
	},
	{#State 129
		ACTIONS => {
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'Expression' => 148,
			'Variable' => 146,
			'SubExpression' => 213,
			'WordScoped' => 109
		}
	},
	{#State 130
		ACTIONS => {
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NEG' => 78,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'Expression' => 148,
			'WordScoped' => 109,
			'SubExpression' => 214,
			'Variable' => 146
		}
	},
	{#State 131
		ACTIONS => {
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NEG' => 78,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'HashDereferenced' => 100,
			'Expression' => 148,
			'Variable' => 146,
			'SubExpression' => 215,
			'WordScoped' => 109
		}
	},
	{#State 132
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP01_CLOSE' => 88,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79
		},
		GOTOS => {
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 216,
			'Expression' => 148,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'ArrayReference' => 87,
			'Operator' => 113,
			'Literal' => 111
		}
	},
	{#State 133
		ACTIONS => {
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NEG' => 78,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Operator' => 113,
			'Literal' => 111,
			'WordScoped' => 109,
			'SubExpression' => 217,
			'Variable' => 146,
			'Expression' => 148,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73
		}
	},
	{#State 134
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP22_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'Expression' => 148,
			'SubExpression' => 218,
			'Variable' => 146,
			'WordScoped' => 109
		}
	},
	{#State 135
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 78,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'Expression' => 148,
			'SubExpression' => 219,
			'Variable' => 146,
			'WordScoped' => 109,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'HashDereferenced' => 100
		}
	},
	{#State 136
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 220
		}
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP01_CLOSE' => 88,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 221,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 90,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'Literal' => 224,
			'VariableOrLiteral' => 223,
			'Variable' => 222
		}
	},
	{#State 139
		ACTIONS => {
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 225,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 140
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 78,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'Variable' => 146,
			'SubExpression' => 226,
			'WordScoped' => 109,
			'Expression' => 148
		}
	},
	{#State 141
		ACTIONS => {
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'Variable' => 146,
			'SubExpression' => 227,
			'WordScoped' => 109,
			'Expression' => 148
		}
	},
	{#State 142
		ACTIONS => {
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'SubExpression' => 228,
			'Variable' => 146,
			'WordScoped' => 109,
			'Expression' => 148,
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113
		}
	},
	{#State 143
		ACTIONS => {
			"filehandle_ref" => 229
		}
	},
	{#State 144
		DEFAULT => -138
	},
	{#State 145
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP22_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'WORD' => 27,
			"undef" => 95,
			"\@{" => 71
		},
		GOTOS => {
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'Expression' => 148,
			'Variable' => 146,
			'SubExpression' => 230,
			'WordScoped' => 109,
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87
		}
	},
	{#State 146
		ACTIONS => {
			'OP15_LOGICAL_AND' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP16_LOGICAL_OR' => -129,
			"}" => -129,
			'OP02_METHOD_THINARROW' => 156,
			'OP03_MATH_INC_DEC' => 154,
			'OP11_COMPARE_LT_GT' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP08_STRING_CAT' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP21_LIST_COMMA' => -129,
			'OP13_BITWISE_AND' => -129,
			";" => -129,
			'OP18_TERNARY' => -129,
			")" => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP14_BITWISE_OR_XOR' => -129,
			"]" => -129,
			'OP04_MATH_POW' => -129,
			'OP07_STRING_REPEAT' => -129
		}
	},
	{#State 147
		ACTIONS => {
			'OP21_LIST_COMMA' => -104,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP08_STRING_CAT' => 133,
			'OP15_LOGICAL_AND' => 131,
			'OP08_MATH_ADD_SUB' => 132,
			"}" => -104,
			'OP16_LOGICAL_OR' => 140,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			"]" => -104,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128,
			";" => -104,
			'OP18_TERNARY' => 138,
			'OP06_REGEX_MATCH' => 127,
			")" => -104
		}
	},
	{#State 148
		DEFAULT => -126
	},
	{#State 149
		ACTIONS => {
			'LPAREN' => 181
		}
	},
	{#State 150
		DEFAULT => -134
	},
	{#State 151
		DEFAULT => -195,
		GOTOS => {
			'STAR-48' => 231
		}
	},
	{#State 152
		ACTIONS => {
			'OP20_HASH_FATARROW' => 232
		}
	},
	{#State 153
		DEFAULT => -190
	},
	{#State 154
		DEFAULT => -84
	},
	{#State 155
		ACTIONS => {
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NEG' => 78,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93
		},
		GOTOS => {
			'Variable' => 146,
			'SubExpression' => 233,
			'WordScoped' => 109,
			'Expression' => 148,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113
		}
	},
	{#State 156
		ACTIONS => {
			'LPAREN' => 234
		}
	},
	{#State 157
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'STDIN' => 235,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'SubExpressionOrStdin' => 237,
			'ArrayReference' => 87,
			'Expression' => 148,
			'Variable' => 146,
			'SubExpression' => 236,
			'WordScoped' => 109,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100
		}
	},
	{#State 158
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 238
		}
	},
	{#State 159
		ACTIONS => {
			";" => 239
		}
	},
	{#State 160
		DEFAULT => -174,
		GOTOS => {
			'STAR-43' => 240
		}
	},
	{#State 161
		ACTIONS => {
			'OP23_LOGICAL_AND' => 139,
			'OP13_BITWISE_AND' => 130,
			'OP21_LIST_COMMA' => -179,
			'OP16_LOGICAL_OR' => 140,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			"]" => -179,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP06_REGEX_MATCH' => 127,
			")" => -179,
			";" => -179,
			'OP18_TERNARY' => 138,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => 129
		}
	},
	{#State 162
		ACTIONS => {
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD' => 27,
			"undef" => 95,
			"\@{" => 71,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'Variable' => 146,
			'SubExpression' => 241,
			'WordScoped' => 109,
			'Expression' => 148
		}
	},
	{#State 163
		ACTIONS => {
			"%{" => 93
		},
		GOTOS => {
			'HashDereferenced' => 242
		}
	},
	{#State 164
		ACTIONS => {
			'WORD' => 243
		},
		GOTOS => {
			'PLUS-44' => 244
		}
	},
	{#State 165
		DEFAULT => -107
	},
	{#State 166
		ACTIONS => {
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NEG' => 78,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'KEYS_OR_VALUES' => 163,
			'OP01_QW' => 164,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			"my" => 158,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92
		},
		GOTOS => {
			'TypeInner' => 162,
			'Expression' => 148,
			'WordScoped' => 109,
			'SubExpression' => 161,
			'Variable' => 146,
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'ListElements' => 245,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'ListElement' => 160
		}
	},
	{#State 167
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD' => 27,
			"undef" => 95,
			"\@{" => 71,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 90,
			"my" => 158,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'OP01_QW' => 164,
			'KEYS_OR_VALUES' => 163
		},
		GOTOS => {
			'Expression' => 148,
			'TypeInner' => 162,
			'SubExpression' => 161,
			'Variable' => 146,
			'WordScoped' => 109,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'ListElements' => 246,
			'Literal' => 111,
			'Operator' => 113,
			'ListElement' => 160,
			'ArrayReference' => 87
		}
	},
	{#State 168
		DEFAULT => -108
	},
	{#State 169
		ACTIONS => {
			'OP21_LIST_COMMA' => -179,
			'OP13_BITWISE_AND' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP08_STRING_CAT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP04_MATH_POW' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			";" => -79,
			'OP18_TERNARY' => -79,
			'OP06_REGEX_MATCH' => -79,
			")" => -79
		}
	},
	{#State 170
		ACTIONS => {
			'OP21_LIST_COMMA' => 247
		}
	},
	{#State 171
		DEFAULT => -82
	},
	{#State 172
		ACTIONS => {
			";" => 248
		}
	},
	{#State 173
		DEFAULT => -201
	},
	{#State 174
		ACTIONS => {
			"]" => 249
		}
	},
	{#State 175
		DEFAULT => -182
	},
	{#State 176
		ACTIONS => {
			'OP16_LOGICAL_OR' => 140,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP23_LOGICAL_AND' => 139,
			'OP13_BITWISE_AND' => 130,
			'OP06_REGEX_MATCH' => 127,
			")" => 250,
			'OP18_TERNARY' => 138,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => 129,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137
		}
	},
	{#State 177
		ACTIONS => {
			"}" => 251
		}
	},
	{#State 178
		ACTIONS => {
			'WORD' => 152,
			"%{" => 93
		},
		GOTOS => {
			'HashDereferenced' => 153,
			'HashEntry' => 151
		}
	},
	{#State 179
		ACTIONS => {
			"}" => 252
		}
	},
	{#State 180
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP16_LOGICAL_OR' => 140,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => 139,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => 129,
			'OP06_REGEX_MATCH' => 127,
			")" => 253,
			'OP18_TERNARY' => 138,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135
		}
	},
	{#State 181
		ACTIONS => {
			")" => 254
		}
	},
	{#State 182
		DEFAULT => -83
	},
	{#State 183
		ACTIONS => {
			"]" => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP04_MATH_POW' => 137,
			")" => -86,
			'OP06_REGEX_MATCH' => -86,
			";" => -86,
			'OP18_TERNARY' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP16_LOGICAL_OR' => -86,
			"}" => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP08_STRING_CAT' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP09_BITWISE_SHIFT' => -86
		}
	},
	{#State 184
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 78,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 255
		}
	},
	{#State 185
		DEFAULT => -142
	},
	{#State 186
		DEFAULT => -153
	},
	{#State 187
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 256
		}
	},
	{#State 188
		ACTIONS => {
			'VARIABLE_SYMBOL' => 257
		}
	},
	{#State 189
		DEFAULT => -154
	},
	{#State 190
		DEFAULT => -155
	},
	{#State 191
		ACTIONS => {
			";" => -164,
			'OP18_TERNARY' => -164,
			'OP06_REGEX_MATCH' => -164,
			")" => -164,
			'OP17_LIST_RANGE' => -164,
			'OP12_COMPARE_EQ_NE' => -164,
			'OP07_MATH_MULT_DIV_MOD' => -164,
			'OP14_BITWISE_OR_XOR' => -164,
			"]" => -164,
			'OP04_MATH_POW' => -164,
			'COLON' => -164,
			'OP07_STRING_REPEAT' => -164,
			'OP19_VARIABLE_ASSIGN' => -164,
			'OP15_LOGICAL_AND' => -164,
			'OP19_VARIABLE_ASSIGN_BY' => -164,
			'OP08_MATH_ADD_SUB' => -164,
			'OP02_HASH_THINARROW' => 259,
			'OP02_METHOD_THINARROW' => -164,
			"}" => -164,
			'OP16_LOGICAL_OR' => -164,
			'OP09_BITWISE_SHIFT' => -164,
			'OP03_MATH_INC_DEC' => -164,
			'OP11_COMPARE_LT_GT' => -164,
			'OP02_ARRAY_THINARROW' => 260,
			'OP24_LOGICAL_OR_XOR' => -164,
			'OP08_STRING_CAT' => -164,
			'OP23_LOGICAL_AND' => -164,
			'OP21_LIST_COMMA' => -164,
			'OP13_BITWISE_AND' => -164
		},
		GOTOS => {
			'VariableRetrieval' => 258
		}
	},
	{#State 192
		ACTIONS => {
			")" => 261
		}
	},
	{#State 193
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			")" => -118,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			"my" => 158,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'KEYS_OR_VALUES' => 163,
			'OP01_QW' => 164
		},
		GOTOS => {
			'ArrayReference' => 87,
			'ListElement' => 160,
			'Operator' => 113,
			'Literal' => 111,
			'OPTIONAL-32' => 263,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 161,
			'TypeInner' => 162,
			'Expression' => 148,
			'ListElements' => 262,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73
		}
	},
	{#State 194
		DEFAULT => -16
	},
	{#State 195
		ACTIONS => {
			'OP13_BITWISE_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP09_BITWISE_SHIFT' => 134,
			'OP16_LOGICAL_OR' => -94,
			"}" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP08_MATH_ADD_SUB' => 132,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP14_BITWISE_OR_XOR' => -94,
			"]" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP17_LIST_RANGE' => -94,
			")" => -94,
			'OP06_REGEX_MATCH' => 127,
			'OP18_TERNARY' => -94,
			";" => -94
		}
	},
	{#State 196
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 264
		}
	},
	{#State 197
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP01_CLOSE' => 88,
			"my" => 158,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'KEYS_OR_VALUES' => 163,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'ListElement' => 265,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'TypeInner' => 162,
			'Expression' => 148,
			'WordScoped' => 109,
			'SubExpression' => 169,
			'Variable' => 146
		}
	},
	{#State 198
		ACTIONS => {
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP18_TERNARY' => 138,
			'OP06_REGEX_MATCH' => 127,
			")" => 266,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => 139,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP16_LOGICAL_OR' => 140
		}
	},
	{#State 199
		ACTIONS => {
			'VARIABLE_SYMBOL' => 267
		}
	},
	{#State 200
		DEFAULT => -40
	},
	{#State 201
		DEFAULT => -42
	},
	{#State 202
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 268
		}
	},
	{#State 203
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			"foreach my" => -140,
			'OP01_NAMED' => 86,
			'OP01_PRINT' => 85,
			'OP01_NAMED_VOID' => 84,
			'LPAREN' => 114,
			"for my integer" => -140,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'OP19_LOOP_CONTROL' => 89,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			"my" => 115,
			"if (" => 96,
			'WORD' => 27,
			"while (" => -140,
			"\@{" => 71,
			"undef" => 95,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 97,
			'OP01_OPEN' => 74,
			'OP22_LOGICAL_NEG' => 78,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP01_NAMED_VOID_SCOLON' => 104
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'VariableDeclaration' => 98,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'VariableModification' => 76,
			'PAREN-34' => 75,
			'Expression' => 70,
			'SubExpression' => 72,
			'LoopLabel' => 77,
			'OperatorVoid' => 83,
			'PLUS-17' => 269,
			'Statement' => 106,
			'Operation' => 270,
			'WordScoped' => 109,
			'Variable' => 80,
			'Conditional' => 81,
			'OPTIONAL-35' => 107,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 204
		ACTIONS => {
			"\$TYPED_" => 271
		}
	},
	{#State 205
		ACTIONS => {
			";" => 272
		}
	},
	{#State 206
		DEFAULT => -53
	},
	{#State 207
		ACTIONS => {
			"use constant" => 45,
			"our hash_ref \$properties" => 275
		},
		GOTOS => {
			'Properties' => 273,
			'Constant' => 274
		}
	},
	{#State 208
		DEFAULT => -186
	},
	{#State 209
		DEFAULT => -185
	},
	{#State 210
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP06_REGEX_MATCH' => 127,
			")" => -90,
			";" => -90,
			'OP18_TERNARY' => -90,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			"]" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_STRING_CAT' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			"}" => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP23_LOGICAL_AND' => -90
		}
	},
	{#State 211
		DEFAULT => -88
	},
	{#State 212
		ACTIONS => {
			'OP18_TERNARY' => -97,
			";" => -97,
			'OP06_REGEX_MATCH' => 127,
			")" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP14_BITWISE_OR_XOR' => -97,
			"]" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => -97,
			"}" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP08_STRING_CAT' => 133,
			'OP23_LOGICAL_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP13_BITWISE_AND' => -97
		}
	},
	{#State 213
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP13_BITWISE_AND' => 130,
			'OP15_LOGICAL_AND' => 131,
			'OP08_MATH_ADD_SUB' => 132,
			'OP16_LOGICAL_OR' => 140,
			"}" => -102,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP14_BITWISE_OR_XOR' => 135,
			"]" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP18_TERNARY' => -102,
			";" => -102,
			")" => -102,
			'OP06_REGEX_MATCH' => 127,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 128
		}
	},
	{#State 214
		ACTIONS => {
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP14_BITWISE_OR_XOR' => -98,
			"]" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => -98,
			")" => -98,
			'OP06_REGEX_MATCH' => 127,
			'OP18_TERNARY' => -98,
			";" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP16_LOGICAL_OR' => -98,
			"}" => -98,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => -98
		}
	},
	{#State 215
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => -100,
			"}" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP08_STRING_CAT' => 133,
			'OP23_LOGICAL_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP13_BITWISE_AND' => 130,
			";" => -100,
			'OP18_TERNARY' => -100,
			'OP06_REGEX_MATCH' => 127,
			")" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP12_COMPARE_EQ_NE' => 128,
			"]" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136
		}
	},
	{#State 216
		ACTIONS => {
			'OP21_LIST_COMMA' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP08_STRING_CAT' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			"}" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP14_BITWISE_OR_XOR' => -91,
			"]" => -91,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP17_LIST_RANGE' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP18_TERNARY' => -91,
			";" => -91,
			'OP06_REGEX_MATCH' => 127,
			")" => -91
		}
	},
	{#State 217
		ACTIONS => {
			"]" => -92,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP06_REGEX_MATCH' => 127,
			")" => -92,
			'OP18_TERNARY' => -92,
			";" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP21_LIST_COMMA' => -92,
			"}" => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP08_MATH_ADD_SUB' => 132,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP08_STRING_CAT' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP11_COMPARE_LT_GT' => -92
		}
	},
	{#State 218
		ACTIONS => {
			'OP21_LIST_COMMA' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP08_STRING_CAT' => 133,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => -93,
			"}" => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP14_BITWISE_OR_XOR' => -93,
			"]" => -93,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP17_LIST_RANGE' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			";" => -93,
			'OP18_TERNARY' => -93,
			'OP06_REGEX_MATCH' => 127,
			")" => -93
		}
	},
	{#State 219
		ACTIONS => {
			'OP18_TERNARY' => -99,
			";" => -99,
			")" => -99,
			'OP06_REGEX_MATCH' => 127,
			'OP17_LIST_RANGE' => -99,
			'OP12_COMPARE_EQ_NE' => 128,
			"]" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP15_LOGICAL_AND' => -99,
			'OP08_MATH_ADD_SUB' => 132,
			'OP16_LOGICAL_OR' => -99,
			"}" => -99,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP13_BITWISE_AND' => 130
		}
	},
	{#State 220
		ACTIONS => {
			"}" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP08_STRING_CAT' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP06_REGEX_MATCH' => 127,
			")" => -89,
			'OP18_TERNARY' => -89,
			";" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP17_LIST_RANGE' => -89,
			"]" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP04_MATH_POW' => 137
		}
	},
	{#State 221
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP08_STRING_CAT' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP15_LOGICAL_AND' => -85,
			"}" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			";" => -85,
			'OP18_TERNARY' => -85,
			'OP06_REGEX_MATCH' => -85,
			")" => -85,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			"]" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85
		}
	},
	{#State 222
		DEFAULT => -205
	},
	{#State 223
		ACTIONS => {
			'COLON' => 276
		}
	},
	{#State 224
		DEFAULT => -206
	},
	{#State 225
		ACTIONS => {
			";" => -105,
			'OP18_TERNARY' => 138,
			")" => -105,
			'OP06_REGEX_MATCH' => 127,
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP14_BITWISE_OR_XOR' => 135,
			"]" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP16_LOGICAL_OR' => 140,
			"}" => -105,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP21_LIST_COMMA' => -105,
			'OP13_BITWISE_AND' => 130
		}
	},
	{#State 226
		ACTIONS => {
			"]" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			";" => -101,
			'OP18_TERNARY' => -101,
			")" => -101,
			'OP06_REGEX_MATCH' => 127,
			'OP17_LIST_RANGE' => -101,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP23_LOGICAL_AND' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP13_BITWISE_AND' => 130,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP16_LOGICAL_OR' => -101,
			"}" => -101,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -101
		}
	},
	{#State 227
		ACTIONS => {
			'OP23_LOGICAL_AND' => 139,
			'OP21_LIST_COMMA' => -106,
			'OP13_BITWISE_AND' => 130,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			"}" => -106,
			'OP16_LOGICAL_OR' => 140,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_STRING_CAT' => 133,
			"]" => -106,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP18_TERNARY' => 138,
			";" => -106,
			'OP06_REGEX_MATCH' => 127,
			")" => -106,
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128
		}
	},
	{#State 228
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => -96,
			"}" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => undef,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_STRING_CAT' => 133,
			'OP23_LOGICAL_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP13_BITWISE_AND' => -96,
			";" => -96,
			'OP18_TERNARY' => -96,
			'OP06_REGEX_MATCH' => 127,
			")" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			"]" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136
		}
	},
	{#State 229
		ACTIONS => {
			'FH_REF_SYMBOL' => 277
		}
	},
	{#State 230
		ACTIONS => {
			"}" => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP08_STRING_CAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP06_REGEX_MATCH' => -79,
			")" => -79,
			";" => -79,
			'OP18_TERNARY' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			"]" => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP04_MATH_POW' => -79
		}
	},
	{#State 231
		ACTIONS => {
			"}" => 279,
			'OP21_LIST_COMMA' => 278
		},
		GOTOS => {
			'PAREN-47' => 280
		}
	},
	{#State 232
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -188,
			'OP03_MATH_INC_DEC' => -188,
			'OP05_LOGICAL_NEG' => -188,
			'WORD_SCOPED' => -188,
			"\@{" => -188,
			"undef" => -188,
			'WORD' => -188,
			'WORD_UPPERCASE' => -188,
			'OP01_OPEN' => -188,
			'LITERAL_STRING' => -188,
			'OP10_NAMED_UNARY' => -188,
			'OP01_NAMED' => -188,
			'LPAREN' => -188,
			'OP01_CLOSE' => -188,
			'LITERAL_NUMBER' => -188,
			'LBRACKET' => -188,
			"my" => 158,
			'OP05_MATH_NEG_LPAREN' => -188,
			"%{" => -188,
			'LBRACE' => -188,
			'VARIABLE_SYMBOL' => -188
		},
		GOTOS => {
			'TypeInner' => 282,
			'OPTIONAL-46' => 281
		}
	},
	{#State 233
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			";" => 283,
			'OP18_TERNARY' => 138,
			'OP06_REGEX_MATCH' => 127,
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP23_LOGICAL_AND' => 139,
			'OP13_BITWISE_AND' => 130,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP16_LOGICAL_OR' => 140,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133
		}
	},
	{#State 234
		ACTIONS => {
			'LPAREN' => 114,
			")" => -120,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			"my" => 158,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'OP01_QW' => 164,
			'KEYS_OR_VALUES' => 163,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD' => 27,
			"undef" => 95,
			"\@{" => 71,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'ListElements' => 285,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'Variable' => 146,
			'SubExpression' => 161,
			'WordScoped' => 109,
			'Expression' => 148,
			'TypeInner' => 162,
			'ListElement' => 160,
			'OPTIONAL-33' => 284,
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113
		}
	},
	{#State 235
		DEFAULT => -137
	},
	{#State 236
		ACTIONS => {
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => 129,
			'OP06_REGEX_MATCH' => 127,
			";" => -136,
			'OP18_TERNARY' => 138,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => 139,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP16_LOGICAL_OR' => 140,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131
		}
	},
	{#State 237
		ACTIONS => {
			";" => 286
		}
	},
	{#State 238
		ACTIONS => {
			"\$TYPED_" => 287
		}
	},
	{#State 239
		DEFAULT => -113
	},
	{#State 240
		ACTIONS => {
			"]" => -177,
			")" => -177,
			";" => -177,
			'OP21_LIST_COMMA' => 289
		},
		GOTOS => {
			'PAREN-42' => 288
		}
	},
	{#State 241
		ACTIONS => {
			'OP21_LIST_COMMA' => -180,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => 139,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP15_LOGICAL_AND' => 131,
			'OP08_MATH_ADD_SUB' => 132,
			'OP16_LOGICAL_OR' => 140,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			"]" => -180,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128,
			";" => -180,
			'OP18_TERNARY' => 138,
			")" => -180,
			'OP06_REGEX_MATCH' => 127
		}
	},
	{#State 242
		DEFAULT => -181
	},
	{#State 243
		DEFAULT => -176
	},
	{#State 244
		ACTIONS => {
			'WORD' => 291,
			")" => 290
		}
	},
	{#State 245
		ACTIONS => {
			";" => 292
		}
	},
	{#State 246
		ACTIONS => {
			";" => 293
		}
	},
	{#State 247
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			"my" => 158,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			'OP01_QW' => 164,
			'KEYS_OR_VALUES' => 163,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP22_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'ListElement' => 160,
			'TypeInner' => 162,
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 161,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'ListElements' => 294
		}
	},
	{#State 248
		DEFAULT => -116
	},
	{#State 249
		DEFAULT => -184
	},
	{#State 250
		DEFAULT => -87
	},
	{#State 251
		DEFAULT => -198
	},
	{#State 252
		DEFAULT => -197
	},
	{#State 253
		ACTIONS => {
			'LBRACE' => 296
		},
		GOTOS => {
			'CodeBlock' => 295
		}
	},
	{#State 254
		DEFAULT => -123
	},
	{#State 255
		ACTIONS => {
			'OP23_LOGICAL_AND' => 139,
			'OP13_BITWISE_AND' => 130,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP16_LOGICAL_OR' => 140,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP18_TERNARY' => 138,
			'OP06_REGEX_MATCH' => 127,
			")" => 297,
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128
		}
	},
	{#State 256
		ACTIONS => {
			'VARIABLE_SYMBOL' => 298
		}
	},
	{#State 257
		ACTIONS => {
			'LPAREN' => 299
		}
	},
	{#State 258
		DEFAULT => -162
	},
	{#State 259
		ACTIONS => {
			'OP01_CLOSE' => 88,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 301
		},
		GOTOS => {
			'WordScoped' => 109,
			'SubExpression' => 300,
			'Variable' => 146,
			'Expression' => 148,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'ArrayReference' => 87,
			'Operator' => 113,
			'Literal' => 111
		}
	},
	{#State 260
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 78,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'ArrayReference' => 87,
			'Operator' => 113,
			'Literal' => 111,
			'WordScoped' => 109,
			'SubExpression' => 302,
			'Variable' => 146,
			'Expression' => 148,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73
		}
	},
	{#State 261
		DEFAULT => -125
	},
	{#State 262
		DEFAULT => -117
	},
	{#State 263
		ACTIONS => {
			")" => 303
		}
	},
	{#State 264
		ACTIONS => {
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 90,
			"my" => 158,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			'KEYS_OR_VALUES' => 163,
			'OP01_QW' => 164,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'OP22_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'WORD' => 27,
			"undef" => 95,
			"\@{" => 71
		},
		GOTOS => {
			'TypeInner' => 162,
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 161,
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'ListElements' => 304,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'ListElement' => 160
		}
	},
	{#State 265
		ACTIONS => {
			'OP21_LIST_COMMA' => 305
		}
	},
	{#State 266
		DEFAULT => -135
	},
	{#State 267
		ACTIONS => {
			";" => 307,
			'OP19_VARIABLE_ASSIGN' => 306
		}
	},
	{#State 268
		ACTIONS => {
			'VARIABLE_SYMBOL' => 308
		}
	},
	{#State 269
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			"foreach my" => -140,
			"my" => 115,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			"for my integer" => -140,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 97,
			'WORD' => 27,
			"if (" => 96,
			"while (" => -140,
			"undef" => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'LBRACE' => 79,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'OP19_LOOP_CONTROL' => 89,
			'LITERAL_NUMBER' => 90,
			'OP01_NAMED_VOID' => 84,
			'OP01_PRINT' => 85,
			'OP01_NAMED' => 86,
			'OP01_OPEN' => 74,
			"\@{" => 71,
			'WORD_SCOPED' => 26,
			"}" => 309,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'VariableDeclaration' => 98,
			'PAREN-34' => 75,
			'VariableModification' => 76,
			'Expression' => 70,
			'SubExpression' => 72,
			'LoopLabel' => 77,
			'OperatorVoid' => 83,
			'Statement' => 106,
			'WordScoped' => 109,
			'Operation' => 310,
			'Variable' => 80,
			'Conditional' => 81,
			'OPTIONAL-35' => 107,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 270
		DEFAULT => -45
	},
	{#State 271
		ACTIONS => {
			'WORD_UPPERCASE' => 311
		}
	},
	{#State 272
		DEFAULT => -41
	},
	{#State 273
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 312
		}
	},
	{#State 274
		DEFAULT => -55
	},
	{#State 275
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 313
		}
	},
	{#State 276
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_STRING' => 101,
			'LITERAL_NUMBER' => 90
		},
		GOTOS => {
			'Variable' => 222,
			'Literal' => 224,
			'VariableOrLiteral' => 314
		}
	},
	{#State 277
		ACTIONS => {
			'OP21_LIST_COMMA' => 315
		}
	},
	{#State 278
		ACTIONS => {
			"%{" => 93,
			'WORD' => 152
		},
		GOTOS => {
			'HashEntry' => 316,
			'HashDereferenced' => 153
		}
	},
	{#State 279
		DEFAULT => -196
	},
	{#State 280
		DEFAULT => -194
	},
	{#State 281
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'Expression' => 148,
			'WordScoped' => 109,
			'SubExpression' => 317,
			'Variable' => 146,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 282
		DEFAULT => -187
	},
	{#State 283
		DEFAULT => -171
	},
	{#State 284
		ACTIONS => {
			")" => 318
		}
	},
	{#State 285
		DEFAULT => -119
	},
	{#State 286
		DEFAULT => -170
	},
	{#State 287
		ACTIONS => {
			'WORD' => 319
		}
	},
	{#State 288
		DEFAULT => -173
	},
	{#State 289
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'KEYS_OR_VALUES' => 163,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			"my" => 158,
			'OP01_CLOSE' => 88,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102
		},
		GOTOS => {
			'ListElement' => 320,
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113,
			'Variable' => 146,
			'SubExpression' => 161,
			'WordScoped' => 109,
			'Expression' => 148,
			'TypeInner' => 162,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'HashDereferenced' => 100
		}
	},
	{#State 290
		DEFAULT => -178
	},
	{#State 291
		DEFAULT => -175
	},
	{#State 292
		DEFAULT => -111
	},
	{#State 293
		DEFAULT => -110
	},
	{#State 294
		ACTIONS => {
			";" => 321
		}
	},
	{#State 295
		DEFAULT => -148,
		GOTOS => {
			'STAR-37' => 322
		}
	},
	{#State 296
		ACTIONS => {
			'LBRACE' => 79,
			"foreach my" => -140,
			'VARIABLE_SYMBOL' => 108,
			"my" => 115,
			'OP19_LOOP_CONTROL' => 89,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 112,
			"for my integer" => -140,
			'LPAREN' => 114,
			'OP01_NAMED' => 86,
			'OP01_PRINT' => 85,
			'OP01_NAMED_VOID' => 84,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 97,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			"while (" => -140,
			"if (" => 96,
			'WORD' => 27,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'OperatorVoid' => 83,
			'Operation' => 323,
			'WordScoped' => 109,
			'Variable' => 80,
			'OPTIONAL-35' => 107,
			'Conditional' => 81,
			'Statement' => 106,
			'ArrayReference' => 87,
			'Operator' => 113,
			'Literal' => 111,
			'PAREN-34' => 75,
			'VariableModification' => 76,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'VariableDeclaration' => 98,
			'ArrayDereferenced' => 73,
			'SubExpression' => 72,
			'Expression' => 70,
			'PLUS-40' => 324,
			'LoopLabel' => 77
		}
	},
	{#State 297
		ACTIONS => {
			'LBRACE' => 296
		},
		GOTOS => {
			'CodeBlock' => 325
		}
	},
	{#State 298
		ACTIONS => {
			'LPAREN' => 326
		}
	},
	{#State 299
		ACTIONS => {
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 78,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102,
			'WORD_SCOPED' => 26,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'Expression' => 148,
			'Variable' => 146,
			'SubExpression' => 327,
			'WordScoped' => 109,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'HashDereferenced' => 100
		}
	},
	{#State 300
		ACTIONS => {
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => 129,
			'OP06_REGEX_MATCH' => 127,
			'OP18_TERNARY' => 138,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => 139,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			"}" => 328,
			'OP16_LOGICAL_OR' => 140,
			'OP15_LOGICAL_AND' => 131,
			'OP08_MATH_ADD_SUB' => 132
		}
	},
	{#State 301
		ACTIONS => {
			'LPAREN' => -199,
			"}" => 329,
			'OP02_METHOD_THINARROW_NEW' => -199
		}
	},
	{#State 302
		ACTIONS => {
			'OP23_LOGICAL_AND' => 139,
			'OP13_BITWISE_AND' => 130,
			'OP16_LOGICAL_OR' => 140,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			"]" => 330,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP06_REGEX_MATCH' => 127,
			'OP18_TERNARY' => 138,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => 129
		}
	},
	{#State 303
		DEFAULT => -122
	},
	{#State 304
		ACTIONS => {
			")" => 331
		}
	},
	{#State 305
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			"my" => 158,
			'LITERAL_NUMBER' => 90,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'OP10_NAMED_UNARY' => 112,
			'OP01_QW' => 164,
			'KEYS_OR_VALUES' => 163,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP22_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 101,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95
		},
		GOTOS => {
			'ListElements' => 332,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 161,
			'TypeInner' => 162,
			'Expression' => 148,
			'ArrayReference' => 87,
			'ListElement' => 160,
			'Operator' => 113,
			'Literal' => 111
		}
	},
	{#State 306
		ACTIONS => {
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP01_CLOSE' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 145,
			'LPAREN' => 114,
			'WORD_UPPERCASE' => 149,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			'STDIN' => 235
		},
		GOTOS => {
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 236,
			'Expression' => 148,
			'ArrayReference' => 87,
			'SubExpressionOrStdin' => 333,
			'Operator' => 113,
			'Literal' => 111
		}
	},
	{#State 307
		DEFAULT => -168
	},
	{#State 308
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 334
		}
	},
	{#State 309
		ACTIONS => {
			";" => 335
		}
	},
	{#State 310
		DEFAULT => -44
	},
	{#State 311
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 336
		}
	},
	{#State 312
		ACTIONS => {
			"our" => 337,
			'LITERAL_NUMBER' => 338
		},
		GOTOS => {
			'Subroutine' => 340,
			'MethodOrSubroutine' => 339,
			'Method' => 341
		}
	},
	{#State 313
		ACTIONS => {
			'LBRACE' => 342
		}
	},
	{#State 314
		DEFAULT => -103
	},
	{#State 315
		ACTIONS => {
			'LITERAL_STRING' => 343
		}
	},
	{#State 316
		DEFAULT => -193
	},
	{#State 317
		ACTIONS => {
			"}" => -189,
			'OP16_LOGICAL_OR' => 140,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_STRING_CAT' => 133,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP23_LOGICAL_AND' => 139,
			'OP13_BITWISE_AND' => 130,
			'OP21_LIST_COMMA' => -189,
			'OP06_REGEX_MATCH' => 127,
			'OP18_TERNARY' => 138,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => 129,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137
		}
	},
	{#State 318
		DEFAULT => -124
	},
	{#State 319
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 344
		}
	},
	{#State 320
		DEFAULT => -172
	},
	{#State 321
		DEFAULT => -114
	},
	{#State 322
		ACTIONS => {
			"\@{" => -151,
			'' => -151,
			'OP01_OPEN' => -151,
			'OP22_LOGICAL_NEG' => -151,
			"}" => -151,
			'WORD_SCOPED' => -151,
			'LBRACE' => -151,
			'OP01_NAMED' => -151,
			'OP01_PRINT' => -151,
			'OP01_NAMED_VOID' => -151,
			'OP01_CLOSE' => -151,
			'LBRACKET' => -151,
			'LITERAL_NUMBER' => -151,
			'OP19_LOOP_CONTROL' => -151,
			'OP05_MATH_NEG_LPAREN' => -151,
			"%{" => -151,
			"while (" => -151,
			"undef" => -151,
			"if (" => -151,
			'WORD' => -151,
			'WORD_UPPERCASE' => -151,
			'LITERAL_STRING' => -151,
			'OP05_LOGICAL_NEG' => -151,
			'OP03_MATH_INC_DEC' => -151,
			'OP01_NAMED_VOID_SCOLON' => -151,
			"elsif (" => 347,
			'OP19_LOOP_CONTROL_SCOLON' => -151,
			"foreach my" => -151,
			'VARIABLE_SYMBOL' => -151,
			"else" => 349,
			'OP10_NAMED_UNARY' => -151,
			"for my integer" => -151,
			'LPAREN' => -151,
			"my" => -151
		},
		GOTOS => {
			'PAREN-38' => 346,
			'OPTIONAL-39' => 345,
			'PAREN-36' => 348
		}
	},
	{#State 323
		DEFAULT => -160
	},
	{#State 324
		ACTIONS => {
			'OP01_PRINT' => 85,
			'OP01_NAMED' => 86,
			'OP01_NAMED_VOID' => 84,
			'LBRACKET' => 91,
			'OP19_LOOP_CONTROL' => 89,
			'LITERAL_NUMBER' => 90,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACE' => 79,
			'OP22_LOGICAL_NEG' => 78,
			"}" => 351,
			'WORD_SCOPED' => 26,
			"\@{" => 71,
			'OP01_OPEN' => 74,
			"for my integer" => -140,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			"my" => 115,
			"foreach my" => -140,
			'VARIABLE_SYMBOL' => 108,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			"undef" => 95,
			"while (" => -140,
			'WORD' => 27,
			"if (" => 96,
			'WORD_UPPERCASE' => 97,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'OperatorVoid' => 83,
			'Statement' => 106,
			'Variable' => 80,
			'OPTIONAL-35' => 107,
			'Conditional' => 81,
			'WordScoped' => 109,
			'Operation' => 350,
			'Literal' => 111,
			'Operator' => 113,
			'ArrayReference' => 87,
			'VariableDeclaration' => 98,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'HashDereferenced' => 100,
			'PAREN-34' => 75,
			'VariableModification' => 76,
			'Expression' => 70,
			'SubExpression' => 72,
			'LoopLabel' => 77
		}
	},
	{#State 325
		DEFAULT => -158
	},
	{#State 326
		ACTIONS => {
			'OP01_QW' => 164,
			'KEYS_OR_VALUES' => 163,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 90,
			"my" => 158,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'Variable' => 146,
			'SubExpression' => 161,
			'WordScoped' => 109,
			'Expression' => 148,
			'TypeInner' => 162,
			'ListElements' => 352,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'HashDereferenced' => 100,
			'ListElement' => 160,
			'ArrayReference' => 87,
			'Literal' => 111,
			'Operator' => 113
		}
	},
	{#State 327
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP18_TERNARY' => 138,
			'OP06_REGEX_MATCH' => 127,
			'OP17_LIST_RANGE' => 353,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP23_LOGICAL_AND' => 139,
			'OP13_BITWISE_AND' => 130,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP16_LOGICAL_OR' => 140,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => 141
		}
	},
	{#State 328
		DEFAULT => -166
	},
	{#State 329
		DEFAULT => -167
	},
	{#State 330
		DEFAULT => -165
	},
	{#State 331
		DEFAULT => -78
	},
	{#State 332
		ACTIONS => {
			")" => 354
		}
	},
	{#State 333
		ACTIONS => {
			";" => 355
		}
	},
	{#State 334
		ACTIONS => {
			'OP21_LIST_COMMA' => 357,
			")" => 358
		},
		GOTOS => {
			'PAREN-18' => 356
		}
	},
	{#State 335
		DEFAULT => -46
	},
	{#State 336
		DEFAULT => -204
	},
	{#State 337
		ACTIONS => {
			'TYPE_METHOD' => 359,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 338
		ACTIONS => {
			";" => 360
		}
	},
	{#State 339
		DEFAULT => -57
	},
	{#State 340
		DEFAULT => -75
	},
	{#State 341
		DEFAULT => -74
	},
	{#State 342
		ACTIONS => {
			'WORD' => 364,
			"}" => 361,
			"%{" => 93
		},
		GOTOS => {
			'HashEntryTyped' => 362,
			'HashDereferenced' => 363
		}
	},
	{#State 343
		ACTIONS => {
			'OP21_LIST_COMMA' => 365
		}
	},
	{#State 344
		DEFAULT => -203
	},
	{#State 345
		DEFAULT => -152
	},
	{#State 346
		DEFAULT => -150
	},
	{#State 347
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'WORD' => 27,
			"undef" => 95,
			"\@{" => 71,
			'WORD_SCOPED' => 26,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP22_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 366,
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99
		}
	},
	{#State 348
		DEFAULT => -147
	},
	{#State 349
		ACTIONS => {
			'LBRACE' => 296
		},
		GOTOS => {
			'CodeBlock' => 367
		}
	},
	{#State 350
		DEFAULT => -159
	},
	{#State 351
		DEFAULT => -161
	},
	{#State 352
		ACTIONS => {
			")" => 368
		}
	},
	{#State 353
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 79,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'OP10_NAMED_UNARY' => 112,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			'WORD' => 27,
			"\@{" => 71,
			"undef" => 95,
			'LITERAL_STRING' => 101,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'OP22_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 103,
			'OP03_MATH_INC_DEC' => 102
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'Expression' => 148,
			'WordScoped' => 109,
			'SubExpression' => 369,
			'Variable' => 146,
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99
		}
	},
	{#State 354
		DEFAULT => -80
	},
	{#State 355
		DEFAULT => -169
	},
	{#State 356
		DEFAULT => -48
	},
	{#State 357
		ACTIONS => {
			"my" => 370
		}
	},
	{#State 358
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 359
		ACTIONS => {
			'VARIABLE_SYMBOL' => 372
		}
	},
	{#State 360
		DEFAULT => -59
	},
	{#State 361
		ACTIONS => {
			";" => 373
		}
	},
	{#State 362
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 374
		}
	},
	{#State 363
		DEFAULT => -192
	},
	{#State 364
		ACTIONS => {
			'OP20_HASH_FATARROW' => 375
		}
	},
	{#State 365
		ACTIONS => {
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			"\@{" => 71,
			"undef" => 95,
			'WORD' => 27,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101,
			'OP22_LOGICAL_NEG' => 78,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Expression' => 148,
			'WordScoped' => 109,
			'Variable' => 146,
			'SubExpression' => 376,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87
		}
	},
	{#State 366
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP18_TERNARY' => 138,
			")" => 377,
			'OP06_REGEX_MATCH' => 127,
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP23_LOGICAL_AND' => 139,
			'OP13_BITWISE_AND' => 130,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP16_LOGICAL_OR' => 140,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => 141
		}
	},
	{#State 367
		DEFAULT => -149
	},
	{#State 368
		ACTIONS => {
			'LBRACE' => 296
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 369
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 128,
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 127,
			")" => 379,
			'OP18_TERNARY' => -102,
			'OP07_STRING_REPEAT' => 136,
			'OP04_MATH_POW' => 137,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP08_STRING_CAT' => 133,
			'OP09_BITWISE_SHIFT' => 134,
			'OP11_COMPARE_LT_GT' => 142,
			'OP16_LOGICAL_OR' => 140,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => -102
		}
	},
	{#State 370
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 380
		}
	},
	{#State 371
		ACTIONS => {
			"\@_;" => 381
		}
	},
	{#State 372
		ACTIONS => {
			"= sub {" => 382
		}
	},
	{#State 373
		DEFAULT => -64
	},
	{#State 374
		ACTIONS => {
			'OP21_LIST_COMMA' => 384,
			"}" => 385
		},
		GOTOS => {
			'PAREN-24' => 383
		}
	},
	{#State 375
		ACTIONS => {
			"my" => 158
		},
		GOTOS => {
			'TypeInner' => 386
		}
	},
	{#State 376
		ACTIONS => {
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP18_TERNARY' => 138,
			";" => -81,
			")" => -81,
			'OP06_REGEX_MATCH' => 127,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			"]" => -81,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP15_LOGICAL_AND' => 131,
			'OP08_MATH_ADD_SUB' => 132,
			'OP16_LOGICAL_OR' => 140,
			"}" => -81,
			'OP21_LIST_COMMA' => -81,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => -81
		}
	},
	{#State 377
		ACTIONS => {
			'LBRACE' => 296
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
			'LBRACE' => 296
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 380
		ACTIONS => {
			'VARIABLE_SYMBOL' => 389
		}
	},
	{#State 381
		DEFAULT => -50
	},
	{#State 382
		ACTIONS => {
			"foreach my" => -66,
			'VARIABLE_SYMBOL' => -66,
			"my" => -66,
			"for my integer" => -66,
			'OP10_NAMED_UNARY' => -66,
			'LPAREN' => -66,
			'WORD_UPPERCASE' => -66,
			'LITERAL_STRING' => -66,
			"while (" => -66,
			"undef" => -66,
			"if (" => -66,
			'WORD' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'LBRACE' => -66,
			'OP01_CLOSE' => -66,
			'LBRACKET' => -66,
			'LITERAL_NUMBER' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"%{" => -66,
			'OP01_NAMED' => -66,
			'OP01_PRINT' => -66,
			'OP01_NAMED_VOID' => -66,
			'OP01_OPEN' => -66,
			"\@{" => -66,
			'WORD_SCOPED' => -66,
			'LPAREN_MY' => 392,
			'OP22_LOGICAL_NEG' => -66
		},
		GOTOS => {
			'MethodArguments' => 391,
			'OPTIONAL-26' => 390
		}
	},
	{#State 383
		DEFAULT => -61
	},
	{#State 384
		ACTIONS => {
			"%{" => 93,
			'WORD' => 364
		},
		GOTOS => {
			'HashEntryTyped' => 393,
			'HashDereferenced' => 363
		}
	},
	{#State 385
		ACTIONS => {
			";" => 394
		}
	},
	{#State 386
		ACTIONS => {
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114,
			'OP01_NAMED' => 145,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'LBRACE' => 79,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 78,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'WORD_SCOPED' => 26,
			"undef" => 95,
			"\@{" => 71,
			'WORD' => 27,
			'OP01_OPEN' => 74,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 101
		},
		GOTOS => {
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'HashDereferenced' => 100,
			'ArrayDereferenced' => 73,
			'HashReference' => 99,
			'Expression' => 148,
			'WordScoped' => 109,
			'SubExpression' => 395,
			'Variable' => 146
		}
	},
	{#State 387
		DEFAULT => -146
	},
	{#State 388
		DEFAULT => -156
	},
	{#State 389
		DEFAULT => -47
	},
	{#State 390
		ACTIONS => {
			'WORD_UPPERCASE' => 97,
			'OP01_OPEN' => 74,
			'LITERAL_STRING' => 101,
			"while (" => -140,
			"undef" => 95,
			"\@{" => 71,
			"if (" => 96,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'WORD_SCOPED' => 26,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'OP22_LOGICAL_NEG' => 78,
			'LBRACE' => 79,
			"foreach my" => -140,
			'VARIABLE_SYMBOL' => 108,
			'OP01_CLOSE' => 88,
			"my" => 115,
			'LBRACKET' => 91,
			'OP19_LOOP_CONTROL' => 89,
			'LITERAL_NUMBER' => 90,
			'OP05_MATH_NEG_LPAREN' => 92,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 112,
			"for my integer" => -140,
			'OP01_PRINT' => 85,
			'OP01_NAMED' => 86,
			'OP01_NAMED_VOID' => 84,
			'LPAREN' => 114
		},
		GOTOS => {
			'LoopLabel' => 77,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'ArrayDereferenced' => 73,
			'VariableDeclaration' => 98,
			'PAREN-34' => 75,
			'VariableModification' => 76,
			'Expression' => 70,
			'PLUS-27' => 397,
			'SubExpression' => 72,
			'Operator' => 113,
			'Literal' => 111,
			'ArrayReference' => 87,
			'OperatorVoid' => 83,
			'Statement' => 106,
			'Operation' => 396,
			'WordScoped' => 109,
			'Variable' => 80,
			'OPTIONAL-35' => 107,
			'Conditional' => 81
		}
	},
	{#State 391
		DEFAULT => -65
	},
	{#State 392
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 398
		}
	},
	{#State 393
		DEFAULT => -60
	},
	{#State 394
		DEFAULT => -63
	},
	{#State 395
		ACTIONS => {
			'OP17_LIST_RANGE' => 129,
			'OP12_COMPARE_EQ_NE' => 128,
			'OP18_TERNARY' => 138,
			'OP06_REGEX_MATCH' => 127,
			'OP04_MATH_POW' => 137,
			'OP07_STRING_REPEAT' => 136,
			'OP07_MATH_MULT_DIV_MOD' => 126,
			'OP14_BITWISE_OR_XOR' => 135,
			'OP11_COMPARE_LT_GT' => 142,
			'OP09_BITWISE_SHIFT' => 134,
			'OP08_STRING_CAT' => 133,
			'OP24_LOGICAL_OR_XOR' => 141,
			'OP08_MATH_ADD_SUB' => 132,
			'OP15_LOGICAL_AND' => 131,
			'OP16_LOGICAL_OR' => 140,
			"}" => -191,
			'OP21_LIST_COMMA' => -191,
			'OP13_BITWISE_AND' => 130,
			'OP23_LOGICAL_AND' => 139
		}
	},
	{#State 396
		DEFAULT => -68
	},
	{#State 397
		ACTIONS => {
			'OP01_OPEN' => 74,
			"\@{" => 71,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 78,
			"}" => 400,
			'LBRACE' => 79,
			'LITERAL_NUMBER' => 90,
			'LBRACKET' => 91,
			'OP19_LOOP_CONTROL' => 89,
			'OP01_CLOSE' => 88,
			"%{" => 93,
			'OP05_MATH_NEG_LPAREN' => 92,
			'OP01_NAMED' => 86,
			'OP01_NAMED_VOID' => 84,
			'OP01_PRINT' => 85,
			'WORD_UPPERCASE' => 97,
			'LITERAL_STRING' => 101,
			"undef" => 95,
			"while (" => -140,
			'WORD' => 27,
			"if (" => 96,
			'OP01_NAMED_VOID_SCOLON' => 104,
			'OP03_MATH_INC_DEC' => 102,
			'OP05_LOGICAL_NEG' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			"foreach my" => -140,
			'VARIABLE_SYMBOL' => 108,
			"my" => 115,
			"for my integer" => -140,
			'OP10_NAMED_UNARY' => 112,
			'LPAREN' => 114
		},
		GOTOS => {
			'SubExpression' => 72,
			'Expression' => 70,
			'VariableModification' => 76,
			'PAREN-34' => 75,
			'HashDereferenced' => 100,
			'HashReference' => 99,
			'VariableDeclaration' => 98,
			'ArrayDereferenced' => 73,
			'LoopLabel' => 77,
			'WordScoped' => 109,
			'Operation' => 399,
			'Conditional' => 81,
			'Variable' => 80,
			'OPTIONAL-35' => 107,
			'Statement' => 106,
			'OperatorVoid' => 83,
			'ArrayReference' => 87,
			'Operator' => 113,
			'Literal' => 111
		}
	},
	{#State 398
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 401
		}
	},
	{#State 399
		DEFAULT => -67
	},
	{#State 400
		ACTIONS => {
			";" => 402
		}
	},
	{#State 401
		ACTIONS => {
			")" => 404,
			'OP21_LIST_COMMA' => 403
		},
		GOTOS => {
			'PAREN-28' => 405
		}
	},
	{#State 402
		DEFAULT => -69
	},
	{#State 403
		ACTIONS => {
			"my" => 406
		}
	},
	{#State 404
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 405
		DEFAULT => -71
	},
	{#State 406
		ACTIONS => {
			'WORD' => 56
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
#line 5777 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5784 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5791 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
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
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5827 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5834 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5869 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5876 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5883 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5890 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5897 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 137 "lib/RPerl/Grammar.eyp"
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
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
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
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5983 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5990 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5997 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6011 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
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
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
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
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6072 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
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
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
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
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6158 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
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
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6211 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6218 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6225 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
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
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
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
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
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
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
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
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
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
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6832 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6846 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
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
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7047 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
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
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7130 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7137 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7151 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
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
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
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
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
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
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7369 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7376 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7390 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
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
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
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
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
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
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7564 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
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

#line 217 "lib/RPerl/Grammar.eyp"


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
