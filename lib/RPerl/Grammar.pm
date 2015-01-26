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
    our $VERSION = 0.000_960;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|filehandle_ref|for\ my\ integer|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|elsif\ \(|while\ \(|\$TYPED_|\=\ sub\ \{|package|undef|\(\ my|else|if\ \(|\@_\;|use|qw\(|our|my|\%\{|\@\{|\;|\]|\}|\))}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
      /\G([a-zA-Z]\w*__method)/gc and return ('TYPE_METHOD', $1);
      /\G([a-zA-Z]\w*(::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
      /\G(keys|values)\s/gc and return ('KEYS_OR_VALUES', $1);
      /\G(object\s+\$self)/gc and return ('TYPE_SELF', $1);
      /\G(\{\*STDOUT\}|\{\*STDERR\})/gc and return ('STDOUT_STDERR', $1);
      /\G(<STDIN>)/gc and return ('STDIN', $1);
      /\G(or|xor)\s/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)\s/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not)\s/gc and return ('OP22_LOGICAL_NEG', $1);
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
      /\G(chdir|rand|scalar[^t])\s/gc and return ('OP10_NAMED_UNARY', $1);
      /\G((?:main)?::[a-zA-Z]\w*__stringify\()/gc and return ('OP10_STRINGIFY_UNARY', $1);
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
      /\G([A-Z][A-Z0-9_]*|[A-Z])/gc and return ('CONSTANT_SYMBOL', $1);
      /\G:/gc and return ('COLON', $1);
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
  [ 'Constant_41' => 'Constant', [ 'use constant', 'CONSTANT_SYMBOL', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'PLUS-17', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'Operation' ], 0 ],
  [ 'Subroutine_46' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-16', 'PLUS-17', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-18', [ 'OP21_LIST_COMMA', 'my', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [ 'STAR-19', 'PAREN-18' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [  ], 0 ],
  [ 'SubroutineArguments_50' => 'SubroutineArguments', [ '( my', 'Type', 'VARIABLE_SYMBOL', 'STAR-19', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
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
  [ 'MethodArguments_73' => 'MethodArguments', [ '( my', 'TYPE_SELF', 'STAR-29', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
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
  [ 'Operator_96' => 'Operator', [ 'OP10_STRINGIFY_UNARY', 'SubExpression', ')' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [ 'PAREN-30' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [  ], 0 ],
  [ 'OperatorVoid_111' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-31', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_112' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_113' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'Expression_122' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_123' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-32', ')' ], 0 ],
  [ 'Expression_124' => 'Expression', [ 'CONSTANT_SYMBOL', 'LPAREN', ')' ], 0 ],
  [ 'Expression_125' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-33', ')' ], 0 ],
  [ 'Expression_126' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_127' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_128' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'ArrayDereferenced' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'HashDereferenced' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'LBRACE', '}' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_137' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_138' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-34', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'PAREN-34' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Statement_142' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'OPTIONAL-35', 'Loop' ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_146' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'elsif (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [ 'STAR-37', 'PAREN-36' ], 0 ],
  [ '_STAR_LIST' => 'STAR-37', [  ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'PAREN-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Conditional_153' => 'Conditional', [ 'if (', 'SubExpression', ')', 'CodeBlock', 'STAR-37', 'OPTIONAL-39' ], 0 ],
  [ 'Loop_154' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_155' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_156' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_157' => 'LoopFor', [ 'for my integer', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_158' => 'LoopForEach', [ 'foreach my', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_159' => 'LoopWhile', [ 'while (', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'PLUS-40', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-40', [ 'Operation' ], 0 ],
  [ 'CodeBlock_162' => 'CodeBlock', [ 'LBRACE', 'PLUS-40', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [ 'STAR-41', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-41', [  ], 0 ],
  [ 'Variable_165' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-41' ], 0 ],
  [ 'VariableRetrieval_166' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_167' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_168' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_169' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_170' => 'VariableDeclaration', [ 'my', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_171' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_172' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'PAREN-42' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'PLUS-44', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-44', [ 'WORD' ], 0 ],
  [ 'ListElements_178' => 'ListElements', [ 'ListElement', 'STAR-43' ], 0 ],
  [ 'ListElements_179' => 'ListElements', [ 'OP01_QW', 'PLUS-44', ')' ], 0 ],
  [ 'ListElement_180' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_181' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_182' => 'ListElement', [ 'KEYS_OR_VALUES', 'HashDereferenced' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-45', [  ], 0 ],
  [ 'ArrayReference_185' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-45', ']' ], 0 ],
  [ 'ArrayDereferenced_186' => 'ArrayDereferenced', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereferenced_187' => 'ArrayDereferenced', [ '@{', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'HashEntry_190' => 'HashEntry', [ 'WORD', 'OP20_HASH_FATARROW', 'OPTIONAL-46', 'SubExpression' ], 0 ],
  [ 'HashEntry_191' => 'HashEntry', [ 'HashDereferenced' ], 0 ],
  [ 'HashEntryTyped_192' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_193' => 'HashEntryTyped', [ 'HashDereferenced' ], 0 ],
  [ '_PAREN' => 'PAREN-47', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [ 'STAR-48', 'PAREN-47' ], 0 ],
  [ '_STAR_LIST' => 'STAR-48', [  ], 0 ],
  [ 'HashReference_197' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-48', '}' ], 0 ],
  [ 'HashDereferenced_198' => 'HashDereferenced', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereferenced_199' => 'HashDereferenced', [ '%{', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_200' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_201' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_202' => 'LoopLabel', [ 'WORD' ], 0 ],
  [ 'Type_203' => 'Type', [ 'WORD' ], 0 ],
  [ 'TypeInner_204' => 'TypeInner', [ 'my', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_205' => 'TypeInnerConstant', [ 'my', 'Type', '$TYPED_', 'CONSTANT_SYMBOL', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_206' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_207' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'Literal_208' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'Literal_209' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
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
  'Operator_107' => 107,
  '_PAREN' => 108,
  '_OPTIONAL' => 109,
  '_OPTIONAL' => 110,
  'OperatorVoid_111' => 111,
  'OperatorVoid_112' => 112,
  'OperatorVoid_113' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  'OperatorVoid_116' => 116,
  'OperatorVoid_117' => 117,
  '_OPTIONAL' => 118,
  '_OPTIONAL' => 119,
  '_OPTIONAL' => 120,
  '_OPTIONAL' => 121,
  'Expression_122' => 122,
  'Expression_123' => 123,
  'Expression_124' => 124,
  'Expression_125' => 125,
  'Expression_126' => 126,
  'SubExpression_127' => 127,
  'SubExpression_128' => 128,
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpressionOrStdin_137' => 137,
  'SubExpressionOrStdin_138' => 138,
  '_PAREN' => 139,
  '_OPTIONAL' => 140,
  '_OPTIONAL' => 141,
  'Statement_142' => 142,
  'Statement_143' => 143,
  'Statement_144' => 144,
  'Statement_145' => 145,
  'Statement_146' => 146,
  '_PAREN' => 147,
  '_STAR_LIST' => 148,
  '_STAR_LIST' => 149,
  '_PAREN' => 150,
  '_OPTIONAL' => 151,
  '_OPTIONAL' => 152,
  'Conditional_153' => 153,
  'Loop_154' => 154,
  'Loop_155' => 155,
  'Loop_156' => 156,
  'LoopFor_157' => 157,
  'LoopForEach_158' => 158,
  'LoopWhile_159' => 159,
  '_PLUS_LIST' => 160,
  '_PLUS_LIST' => 161,
  'CodeBlock_162' => 162,
  '_STAR_LIST' => 163,
  '_STAR_LIST' => 164,
  'Variable_165' => 165,
  'VariableRetrieval_166' => 166,
  'VariableRetrieval_167' => 167,
  'VariableRetrieval_168' => 168,
  'VariableDeclaration_169' => 169,
  'VariableDeclaration_170' => 170,
  'VariableModification_171' => 171,
  'VariableModification_172' => 172,
  '_PAREN' => 173,
  '_STAR_LIST' => 174,
  '_STAR_LIST' => 175,
  '_PLUS_LIST' => 176,
  '_PLUS_LIST' => 177,
  'ListElements_178' => 178,
  'ListElements_179' => 179,
  'ListElement_180' => 180,
  'ListElement_181' => 181,
  'ListElement_182' => 182,
  '_OPTIONAL' => 183,
  '_OPTIONAL' => 184,
  'ArrayReference_185' => 185,
  'ArrayDereferenced_186' => 186,
  'ArrayDereferenced_187' => 187,
  '_OPTIONAL' => 188,
  '_OPTIONAL' => 189,
  'HashEntry_190' => 190,
  'HashEntry_191' => 191,
  'HashEntryTyped_192' => 192,
  'HashEntryTyped_193' => 193,
  '_PAREN' => 194,
  '_STAR_LIST' => 195,
  '_STAR_LIST' => 196,
  'HashReference_197' => 197,
  'HashDereferenced_198' => 198,
  'HashDereferenced_199' => 199,
  'WordScoped_200' => 200,
  'WordScoped_201' => 201,
  'LoopLabel_202' => 202,
  'Type_203' => 203,
  'TypeInner_204' => 204,
  'TypeInnerConstant_205' => 205,
  'VariableOrLiteral_206' => 206,
  'VariableOrLiteral_207' => 207,
  'Literal_208' => 208,
  'Literal_209' => 209,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'## no critic qw(' => { ISSEMANTIC => 0 },
	'$TYPED_' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'( my' => { ISSEMANTIC => 0 },
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
	CONSTANT_SYMBOL => { ISSEMANTIC => 1 },
	FH_REF_SYMBOL => { ISSEMANTIC => 1 },
	FH_REF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LBRACE => { ISSEMANTIC => 1 },
	LBRACKET => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	LPAREN => { ISSEMANTIC => 1 },
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
	OP10_STRINGIFY_UNARY => { ISSEMANTIC => 1 },
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
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'lib/RPerl/Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			"## no critic qw(" => 9,
			'SHEBANG' => 1,
			"package" => -20
		},
		GOTOS => {
			'ModuleHeader' => 2,
			'OPTIONAL-9' => 8,
			'PAREN-1' => 7,
			'PLUS-2' => 3,
			'CompileUnit' => 4,
			'Program' => 5,
			'Critic' => 6
		}
	},
	{#State 1
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'OPTIONAL-3' => 11,
			'Critic' => 10
		}
	},
	{#State 2
		ACTIONS => {
			"## no critic qw(" => -25,
			"our" => -25,
			"use parent qw(" => 15,
			"use" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'STAR-10' => 16,
			'Module' => 13,
			'Package' => 14,
			'Class' => 12
		}
	},
	{#State 3
		ACTIONS => {
			"package" => -20,
			'' => -5,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 6,
			'OPTIONAL-9' => 8,
			'PAREN-1' => 17,
			'ModuleHeader' => 2
		}
	},
	{#State 4
		ACTIONS => {
			'' => 18
		}
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		DEFAULT => -3
	},
	{#State 8
		ACTIONS => {
			"package" => 19
		}
	},
	{#State 9
		ACTIONS => {
			'WORD' => 21
		},
		GOTOS => {
			'PLUS-14' => 20
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
		DEFAULT => -23
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		DEFAULT => -22
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 16
		ACTIONS => {
			"## no critic qw(" => 9,
			"our" => -27,
			"use constant" => -27,
			"use" => -27
		},
		GOTOS => {
			'Critic' => 28,
			'STAR-11' => 27
		}
	},
	{#State 17
		DEFAULT => -2
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 21
		DEFAULT => -35
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
		ACTIONS => {
			")" => 34
		}
	},
	{#State 26
		DEFAULT => -201
	},
	{#State 27
		ACTIONS => {
			"use" => 36,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 37
		}
	},
	{#State 28
		DEFAULT => -24
	},
	{#State 29
		ACTIONS => {
			";" => 38
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
			'OP05_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'CONSTANT_SYMBOL' => -11,
			"my" => -11,
			'OP01_NAMED' => -11,
			"while (" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_PRINT' => -11,
			'VARIABLE_SYMBOL' => -11,
			"for my integer" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_CLOSE' => -11,
			"## no critic qw(" => 9,
			'OP01_OPEN' => -11,
			"use constant" => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			"use" => -11,
			'LITERAL_STRING' => -11,
			'LITERAL_NUMBER' => -11,
			'WORD_SCOPED' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"if (" => -11,
			'OP01_NAMED_VOID' => -11,
			"our" => -11,
			"\@{" => -11,
			'LBRACKET' => -11,
			"undef" => -11,
			'LBRACE' => -11,
			'OP10_NAMED_UNARY' => -11,
			'LPAREN' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"foreach my" => -11,
			'WORD' => -11,
			"%{" => -11
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
			";" => 42
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 37
		ACTIONS => {
			"our" => 44,
			"use constant" => 45
		},
		GOTOS => {
			'PLUS-13' => 47,
			'Constant' => 48,
			'Subroutine' => 46
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 23
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		DEFAULT => -8
	},
	{#State 40
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -13,
			"if (" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_OPEN' => -13,
			"use" => 36,
			'OP10_STRINGIFY_UNARY' => -13,
			"use constant" => -13,
			'LITERAL_STRING' => -13,
			'WORD_SCOPED' => -13,
			'LITERAL_NUMBER' => -13,
			"foreach my" => -13,
			"%{" => -13,
			'WORD' => -13,
			"\@{" => -13,
			"our" => -13,
			'LBRACKET' => -13,
			"undef" => -13,
			'LBRACE' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LPAREN' => -13,
			'OP10_NAMED_UNARY' => -13,
			"while (" => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'CONSTANT_SYMBOL' => -13,
			"my" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_CLOSE' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_PRINT' => -13,
			'VARIABLE_SYMBOL' => -13,
			"for my integer" => -13
		},
		GOTOS => {
			'STAR-6' => 51,
			'Include' => 50
		}
	},
	{#State 41
		ACTIONS => {
			"our" => 52
		}
	},
	{#State 42
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 43
		ACTIONS => {
			";" => 55,
			"qw(" => 54
		}
	},
	{#State 44
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 45
		ACTIONS => {
			'CONSTANT_SYMBOL' => 58
		}
	},
	{#State 46
		DEFAULT => -31
	},
	{#State 47
		ACTIONS => {
			'LITERAL_NUMBER' => 59,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 60
		}
	},
	{#State 48
		DEFAULT => -28
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		DEFAULT => -10
	},
	{#State 51
		ACTIONS => {
			"my" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'CONSTANT_SYMBOL' => -15,
			"while (" => -15,
			'OP01_NAMED' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"for my integer" => -15,
			'OP01_PRINT' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_CLOSE' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			"use constant" => 45,
			'LITERAL_STRING' => -15,
			'WORD_SCOPED' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_OPEN' => -15,
			"if (" => -15,
			'OP01_NAMED_VOID' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"undef" => -15,
			'LBRACE' => -15,
			'LPAREN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP10_NAMED_UNARY' => -15,
			"\@{" => -15,
			"our" => -15,
			'LBRACKET' => -15,
			"%{" => -15,
			'WORD' => -15,
			"foreach my" => -15
		},
		GOTOS => {
			'Constant' => 61,
			'STAR-7' => 62
		}
	},
	{#State 52
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 63
		}
	},
	{#State 53
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 64
		}
	},
	{#State 54
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 55
		DEFAULT => -39
	},
	{#State 56
		DEFAULT => -203
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		}
	},
	{#State 58
		ACTIONS => {
			'OP20_HASH_FATARROW' => 68
		}
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
		DEFAULT => -12
	},
	{#State 62
		ACTIONS => {
			'LBRACE' => 96,
			"undef" => 97,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"our" => 44,
			"\@{" => 101,
			'LBRACKET' => 103,
			"%{" => 105,
			'WORD' => 107,
			"foreach my" => -141,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 111,
			"if (" => 112,
			'OP01_NAMED_VOID' => 115,
			'OP22_LOGICAL_NEG' => 116,
			"for my integer" => -141,
			'OP01_PRINT' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'VARIABLE_SYMBOL' => 77,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83,
			"my" => 88,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'CONSTANT_SYMBOL' => 92,
			"while (" => -141,
			'OP01_NAMED' => 94,
			'OP19_LOOP_CONTROL' => 95
		},
		GOTOS => {
			'Expression' => 91,
			'Variable' => 87,
			'OperatorVoid' => 86,
			'SubExpression' => 85,
			'Subroutine' => 117,
			'VariableModification' => 113,
			'Literal' => 114,
			'WordScoped' => 93,
			'HashDereferenced' => 102,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'PLUS-8' => 70,
			'Operator' => 73,
			'Statement' => 71,
			'PAREN-34' => 72,
			'Conditional' => 81,
			'VariableDeclaration' => 80,
			'Operation' => 82,
			'OPTIONAL-35' => 84,
			'LoopLabel' => 104,
			'ArrayReference' => 106
		}
	},
	{#State 63
		DEFAULT => -33
	},
	{#State 64
		ACTIONS => {
			"use" => -54,
			"use constant" => -54,
			"our hash_ref \$properties" => -54,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 119,
			'STAR-21' => 118
		}
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			'WORD' => 121,
			")" => 120
		}
	},
	{#State 67
		ACTIONS => {
			"= sub {" => 122
		}
	},
	{#State 68
		ACTIONS => {
			"my" => 123
		},
		GOTOS => {
			'TypeInnerConstant' => 124
		}
	},
	{#State 69
		DEFAULT => -32
	},
	{#State 70
		ACTIONS => {
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 116,
			"if (" => 112,
			'OP01_NAMED_VOID' => 115,
			"\@{" => 101,
			'LBRACKET' => 103,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			"foreach my" => -141,
			'WORD' => 107,
			"%{" => 105,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'CONSTANT_SYMBOL' => 92,
			"my" => 88,
			'OP01_NAMED' => 94,
			"while (" => -141,
			'OP19_LOOP_CONTROL' => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'OP01_PRINT' => 75,
			'VARIABLE_SYMBOL' => 77,
			"for my integer" => -141,
			'OP03_MATH_INC_DEC' => 83,
			'' => -18,
			'OP01_CLOSE' => 79
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'PAREN-34' => 72,
			'Operator' => 73,
			'Statement' => 71,
			'Operation' => 125,
			'VariableDeclaration' => 80,
			'Conditional' => 81,
			'OPTIONAL-35' => 84,
			'LoopLabel' => 104,
			'ArrayReference' => 106,
			'Expression' => 91,
			'Variable' => 87,
			'OperatorVoid' => 86,
			'SubExpression' => 85,
			'Literal' => 114,
			'VariableModification' => 113,
			'WordScoped' => 93
		}
	},
	{#State 71
		DEFAULT => -77
	},
	{#State 72
		DEFAULT => -140
	},
	{#State 73
		DEFAULT => -122
	},
	{#State 74
		DEFAULT => -116
	},
	{#State 75
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => -110,
			'LITERAL_STRING' => -110,
			'WORD_SCOPED' => -110,
			'LITERAL_NUMBER' => -110,
			"my" => -110,
			'OP05_LOGICAL_NEG' => -110,
			'CONSTANT_SYMBOL' => -110,
			'OP01_OPEN' => -110,
			'KEYS_OR_VALUES' => -110,
			'OP01_NAMED' => -110,
			'OP22_LOGICAL_NEG' => -110,
			'OP01_QW' => -110,
			"undef" => -110,
			'LBRACE' => -110,
			'OP10_NAMED_UNARY' => -110,
			'LPAREN' => -110,
			'OP05_MATH_NEG_LPAREN' => -110,
			"\@{" => -110,
			'LBRACKET' => -110,
			'VARIABLE_SYMBOL' => -110,
			'STDOUT_STDERR' => 129,
			'WORD' => -110,
			"%{" => -110,
			'OP01_CLOSE' => -110,
			'FH_REF_SYMBOL_BRACES' => 128,
			'OP03_MATH_INC_DEC' => -110
		},
		GOTOS => {
			'OPTIONAL-31' => 127,
			'PAREN-30' => 126
		}
	},
	{#State 76
		DEFAULT => -133
	},
	{#State 77
		DEFAULT => -164,
		GOTOS => {
			'STAR-41' => 130
		}
	},
	{#State 78
		DEFAULT => -132
	},
	{#State 79
		ACTIONS => {
			'FH_REF_SYMBOL' => 131
		}
	},
	{#State 80
		DEFAULT => -145
	},
	{#State 81
		DEFAULT => -142
	},
	{#State 82
		DEFAULT => -17
	},
	{#State 83
		ACTIONS => {
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'Variable' => 132
		}
	},
	{#State 84
		ACTIONS => {
			"while (" => 139,
			"foreach my" => 133,
			"for my integer" => 137
		},
		GOTOS => {
			'LoopWhile' => 136,
			'LoopFor' => 134,
			'Loop' => 138,
			'LoopForEach' => 135
		}
	},
	{#State 85
		ACTIONS => {
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP23_LOGICAL_AND' => 142,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 149,
			'OP04_MATH_POW' => 148,
			'OP24_LOGICAL_OR_XOR' => 147,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140
		}
	},
	{#State 86
		DEFAULT => -144
	},
	{#State 87
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -130,
			'OP07_STRING_REPEAT' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP08_STRING_CAT' => -130,
			'OP23_LOGICAL_AND' => -130,
			'OP19_VARIABLE_ASSIGN_BY' => 159,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP04_MATH_POW' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			'OP18_TERNARY' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP02_METHOD_THINARROW' => 157,
			'OP19_VARIABLE_ASSIGN' => 160,
			'OP11_COMPARE_LT_GT' => -130,
			'OP16_LOGICAL_OR' => -130,
			'OP03_MATH_INC_DEC' => 158,
			'OP24_LOGICAL_OR_XOR' => -130
		}
	},
	{#State 88
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 161
		}
	},
	{#State 89
		ACTIONS => {
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 97,
			'LBRACE' => 96,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"\@{" => 101,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP10_STRINGIFY_UNARY' => 108,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP05_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Variable' => 164,
			'SubExpression' => 163,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78
		}
	},
	{#State 90
		DEFAULT => -113
	},
	{#State 91
		ACTIONS => {
			'OP15_LOGICAL_AND' => -127,
			'OP12_COMPARE_EQ_NE' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP08_STRING_CAT' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP07_STRING_REPEAT' => -127,
			";" => 166,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP16_LOGICAL_OR' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			'OP17_LIST_RANGE' => -127,
			'OP18_TERNARY' => -127,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP09_BITWISE_SHIFT' => -127,
			'OP13_BITWISE_AND' => -127,
			'OP04_MATH_POW' => -127
		}
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 167
		}
	},
	{#State 93
		ACTIONS => {
			'LPAREN' => 168,
			'OP02_METHOD_THINARROW_NEW' => 169
		}
	},
	{#State 94
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"undef" => 97,
			'LBRACE' => 96,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 173,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			"my" => 171,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 172,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'TypeInner' => 174,
			'ListElement' => 170
		}
	},
	{#State 95
		ACTIONS => {
			'WORD' => 175
		},
		GOTOS => {
			'LoopLabel' => 176
		}
	},
	{#State 96
		ACTIONS => {
			"}" => 180,
			"%{" => 105,
			'WORD' => 178
		},
		GOTOS => {
			'HashEntry' => 179,
			'HashDereferenced' => 177
		}
	},
	{#State 97
		DEFAULT => -128
	},
	{#State 98
		ACTIONS => {
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			'LBRACE' => 96,
			"undef" => 97,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'OP01_PRINT' => 183,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 182,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'SubExpression' => 181,
			'Variable' => 164,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78
		}
	},
	{#State 99
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			'LBRACE' => 96,
			"undef" => 97,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165
		},
		GOTOS => {
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'Operator' => 73,
			'SubExpression' => 184,
			'Variable' => 164,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114
		}
	},
	{#State 100
		ACTIONS => {
			'OP21_LIST_COMMA' => -95,
			'OP04_MATH_POW' => -95,
			'OP13_BITWISE_AND' => -95,
			'VARIABLE_SYMBOL' => 77,
			'OP09_BITWISE_SHIFT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP03_MATH_INC_DEC' => 83,
			'OP16_LOGICAL_OR' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			";" => -95,
			'OP01_CLOSE' => 79,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP08_STRING_CAT' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP01_NAMED' => 165,
			"}" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"\@{" => 101,
			'LBRACKET' => 103,
			"undef" => 97,
			'LBRACE' => 96,
			'OP18_TERNARY' => -95,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			'OP11_COMPARE_LT_GT' => -95,
			")" => -95,
			"%{" => 105,
			'WORD' => 24,
			'OP07_STRING_REPEAT' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			"]" => -95,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 116,
			'OP23_LOGICAL_AND' => -95,
			'OP15_LOGICAL_AND' => -95
		},
		GOTOS => {
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Variable' => 164,
			'SubExpression' => 185,
			'Operator' => 73,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76
		}
	},
	{#State 101
		ACTIONS => {
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'ArrayReference' => 186,
			'Variable' => 187
		}
	},
	{#State 102
		DEFAULT => -134
	},
	{#State 103
		ACTIONS => {
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"undef" => 97,
			'LBRACE' => 96,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP10_STRINGIFY_UNARY' => 108,
			"]" => -184,
			"my" => 171,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'OP01_QW' => 189,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'KEYS_OR_VALUES' => 173
		},
		GOTOS => {
			'Operator' => 73,
			'SubExpression' => 192,
			'Variable' => 164,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Literal' => 114,
			'ListElement' => 191,
			'TypeInner' => 174,
			'OPTIONAL-45' => 188,
			'ListElements' => 190
		}
	},
	{#State 104
		ACTIONS => {
			'COLON' => 193
		}
	},
	{#State 105
		ACTIONS => {
			'VARIABLE_SYMBOL' => 77,
			'LBRACE' => 194
		},
		GOTOS => {
			'Variable' => 196,
			'HashReference' => 195
		}
	},
	{#State 106
		DEFAULT => -131
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => -200,
			'OP02_METHOD_THINARROW_NEW' => -200,
			'COLON' => -202
		}
	},
	{#State 108
		ACTIONS => {
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'SubExpression' => 197,
			'Variable' => 164,
			'Operator' => 73
		}
	},
	{#State 109
		DEFAULT => -209
	},
	{#State 110
		DEFAULT => -208
	},
	{#State 111
		ACTIONS => {
			"my" => 198
		}
	},
	{#State 112
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"undef" => 97,
			'LBRACE' => 96,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100
		},
		GOTOS => {
			'Operator' => 73,
			'SubExpression' => 199,
			'Variable' => 164,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Literal' => 114
		}
	},
	{#State 113
		DEFAULT => -146
	},
	{#State 114
		DEFAULT => -129
	},
	{#State 115
		ACTIONS => {
			'OP01_QW' => 189,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'KEYS_OR_VALUES' => 173,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"my" => 171,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP03_MATH_INC_DEC' => 83,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			'LBRACE' => 96,
			"undef" => 97
		},
		GOTOS => {
			'ListElement' => 191,
			'TypeInner' => 174,
			'ListElements' => 200,
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Variable' => 164,
			'SubExpression' => 192,
			'Operator' => 73
		}
	},
	{#State 116
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			'LBRACE' => 96,
			"undef" => 97,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101
		},
		GOTOS => {
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'SubExpression' => 201,
			'Variable' => 164,
			'Operator' => 73,
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106
		}
	},
	{#State 117
		DEFAULT => -14
	},
	{#State 118
		ACTIONS => {
			"our hash_ref \$properties" => -56,
			"use" => 36,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 202,
			'Include' => 203
		}
	},
	{#State 119
		DEFAULT => -51
	},
	{#State 120
		ACTIONS => {
			";" => 204
		}
	},
	{#State 121
		DEFAULT => -37
	},
	{#State 122
		ACTIONS => {
			"undef" => -43,
			'LBRACE' => -43,
			'LPAREN' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP10_NAMED_UNARY' => -43,
			"\@{" => -43,
			'LBRACKET' => -43,
			"%{" => -43,
			'WORD' => -43,
			"foreach my" => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			'LITERAL_STRING' => -43,
			'WORD_SCOPED' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_OPEN' => -43,
			"if (" => -43,
			'OP01_NAMED_VOID' => -43,
			'OP22_LOGICAL_NEG' => -43,
			"for my integer" => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_PRINT' => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_CLOSE' => -43,
			'OP03_MATH_INC_DEC' => -43,
			"my" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'CONSTANT_SYMBOL' => -43,
			"( my" => 207,
			"while (" => -43,
			'OP01_NAMED' => -43,
			'OP19_LOOP_CONTROL' => -43
		},
		GOTOS => {
			'SubroutineArguments' => 206,
			'OPTIONAL-16' => 205
		}
	},
	{#State 123
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 208
		}
	},
	{#State 124
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110
		},
		GOTOS => {
			'Literal' => 209
		}
	},
	{#State 125
		DEFAULT => -16
	},
	{#State 126
		DEFAULT => -109
	},
	{#State 127
		ACTIONS => {
			'OP01_NAMED' => 165,
			'OP01_QW' => 189,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 173,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			"my" => 171,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"undef" => 97,
			'LBRACE' => 96,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98
		},
		GOTOS => {
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 192,
			'ListElements' => 210,
			'TypeInner' => 174,
			'ListElement' => 191,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Literal' => 114
		}
	},
	{#State 128
		ACTIONS => {
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"my" => 171,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_QW' => 189,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'KEYS_OR_VALUES' => 173,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24
		},
		GOTOS => {
			'Variable' => 164,
			'SubExpression' => 192,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'TypeInner' => 174,
			'ListElement' => 191,
			'ListElements' => 211
		}
	},
	{#State 129
		DEFAULT => -108
	},
	{#State 130
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -165,
			'OP16_LOGICAL_OR' => -165,
			'OP11_COMPARE_LT_GT' => -165,
			'OP19_VARIABLE_ASSIGN' => -165,
			'OP02_METHOD_THINARROW' => -165,
			'OP24_LOGICAL_OR_XOR' => -165,
			")" => -165,
			";" => -165,
			'OP13_BITWISE_AND' => -165,
			'OP02_ARRAY_THINARROW' => 213,
			'OP02_HASH_THINARROW' => 214,
			'OP21_LIST_COMMA' => -165,
			'OP04_MATH_POW' => -165,
			'OP17_LIST_RANGE' => -165,
			'OP18_TERNARY' => -165,
			'OP14_BITWISE_OR_XOR' => -165,
			'OP07_MATH_MULT_DIV_MOD' => -165,
			'OP09_BITWISE_SHIFT' => -165,
			'OP23_LOGICAL_AND' => -165,
			'COLON' => -165,
			"}" => -165,
			'OP08_STRING_CAT' => -165,
			'OP06_REGEX_MATCH' => -165,
			'OP15_LOGICAL_AND' => -165,
			'OP12_COMPARE_EQ_NE' => -165,
			'OP19_VARIABLE_ASSIGN_BY' => -165,
			'OP07_STRING_REPEAT' => -165,
			'OP08_MATH_ADD_SUB' => -165,
			"]" => -165
		},
		GOTOS => {
			'VariableRetrieval' => 212
		}
	},
	{#State 131
		DEFAULT => -82
	},
	{#State 132
		DEFAULT => -83
	},
	{#State 133
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 215
		}
	},
	{#State 134
		DEFAULT => -154
	},
	{#State 135
		DEFAULT => -155
	},
	{#State 136
		DEFAULT => -156
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => 216
		}
	},
	{#State 138
		DEFAULT => -143
	},
	{#State 139
		ACTIONS => {
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'SubExpression' => 217,
			'Variable' => 164,
			'Operator' => 73,
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106
		}
	},
	{#State 140
		ACTIONS => {
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP05_LOGICAL_NEG' => 89,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'LBRACE' => 96,
			"undef" => 97
		},
		GOTOS => {
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'SubExpression' => 218,
			'Variable' => 164,
			'Operator' => 73
		}
	},
	{#State 141
		ACTIONS => {
			'VARIABLE_SYMBOL' => 77,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110
		},
		GOTOS => {
			'Variable' => 220,
			'Literal' => 219,
			'VariableOrLiteral' => 221
		}
	},
	{#State 142
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'OP03_MATH_INC_DEC' => 83,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"undef" => 97,
			'LBRACE' => 96,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100
		},
		GOTOS => {
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'Operator' => 73,
			'SubExpression' => 222,
			'Variable' => 164,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114
		}
	},
	{#State 143
		ACTIONS => {
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			"undef" => 97,
			'LBRACE' => 96,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92
		},
		GOTOS => {
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'Operator' => 73,
			'SubExpression' => 223,
			'Variable' => 164,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102
		}
	},
	{#State 144
		ACTIONS => {
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 96,
			"undef" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92
		},
		GOTOS => {
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Variable' => 164,
			'SubExpression' => 224,
			'Operator' => 73,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76
		}
	},
	{#State 145
		ACTIONS => {
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89
		},
		GOTOS => {
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Variable' => 164,
			'SubExpression' => 225,
			'Operator' => 73,
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106
		}
	},
	{#State 146
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 96,
			"undef" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Variable' => 164,
			'SubExpression' => 226,
			'Operator' => 73
		}
	},
	{#State 147
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 96,
			"undef" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103
		},
		GOTOS => {
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 227,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102
		}
	},
	{#State 148
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'OP10_STRINGIFY_UNARY' => 108,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LBRACE' => 96,
			"undef" => 97,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"\@{" => 101,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83
		},
		GOTOS => {
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'Operator' => 73,
			'SubExpression' => 228,
			'Variable' => 164,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Literal' => 114
		}
	},
	{#State 149
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'Variable' => 164,
			'SubExpression' => 229,
			'Operator' => 73,
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106
		}
	},
	{#State 150
		ACTIONS => {
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 96,
			"undef" => 97,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92
		},
		GOTOS => {
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Variable' => 164,
			'SubExpression' => 230,
			'Operator' => 73,
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93
		}
	},
	{#State 151
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			'LBRACE' => 96,
			"undef" => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP10_STRINGIFY_UNARY' => 108
		},
		GOTOS => {
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'Operator' => 73,
			'SubExpression' => 231,
			'Variable' => 164,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114
		}
	},
	{#State 152
		ACTIONS => {
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 97,
			'LBRACE' => 96,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"\@{" => 101,
			'WORD' => 24,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'OP03_MATH_INC_DEC' => 83,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP10_STRINGIFY_UNARY' => 108,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'Operator' => 73,
			'SubExpression' => 232,
			'Variable' => 164
		}
	},
	{#State 153
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Variable' => 164,
			'SubExpression' => 233,
			'Operator' => 73,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76
		}
	},
	{#State 154
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			'LBRACE' => 96,
			"undef" => 97
		},
		GOTOS => {
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 234,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Literal' => 114
		}
	},
	{#State 155
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 235
		}
	},
	{#State 156
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101
		},
		GOTOS => {
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Variable' => 164,
			'SubExpression' => 236,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78
		}
	},
	{#State 157
		ACTIONS => {
			'LPAREN' => 237
		}
	},
	{#State 158
		DEFAULT => -84
	},
	{#State 159
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 238,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162
		}
	},
	{#State 160
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'STDIN' => 241,
			'OP03_MATH_INC_DEC' => 83,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165
		},
		GOTOS => {
			'SubExpressionOrStdin' => 239,
			'SubExpression' => 240,
			'Variable' => 164,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93
		}
	},
	{#State 161
		ACTIONS => {
			'VARIABLE_SYMBOL' => 242
		}
	},
	{#State 162
		DEFAULT => -127
	},
	{#State 163
		ACTIONS => {
			'OP13_BITWISE_AND' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => -86,
			'OP18_TERNARY' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			")" => -86,
			";" => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			"]" => -86,
			'OP23_LOGICAL_AND' => -86,
			"}" => -86,
			'OP08_STRING_CAT' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP12_COMPARE_EQ_NE' => -86
		}
	},
	{#State 164
		ACTIONS => {
			'OP17_LIST_RANGE' => -130,
			'OP18_TERNARY' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP21_LIST_COMMA' => -130,
			'OP04_MATH_POW' => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			")" => -130,
			";" => -130,
			'OP03_MATH_INC_DEC' => 158,
			'OP16_LOGICAL_OR' => -130,
			'OP11_COMPARE_LT_GT' => -130,
			'OP02_METHOD_THINARROW' => 157,
			"]" => -130,
			'OP07_STRING_REPEAT' => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP23_LOGICAL_AND' => -130,
			"}" => -130,
			'OP08_STRING_CAT' => -130,
			'OP06_REGEX_MATCH' => -130
		}
	},
	{#State 165
		ACTIONS => {
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			"undef" => 97,
			'LBRACE' => 96,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'Operator' => 73,
			'SubExpression' => 243,
			'Variable' => 164
		}
	},
	{#State 166
		DEFAULT => -76
	},
	{#State 167
		ACTIONS => {
			")" => 244
		}
	},
	{#State 168
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			"my" => 171,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'OP10_STRINGIFY_UNARY' => 108,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP05_LOGICAL_NEG' => 89,
			'KEYS_OR_VALUES' => 173,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_QW' => 189,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 97,
			'LBRACE' => 96,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"\@{" => 101,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			")" => -119,
			'OP03_MATH_INC_DEC' => 83
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'SubExpression' => 192,
			'Variable' => 164,
			'Operator' => 73,
			'TypeInner' => 174,
			'ListElement' => 191,
			'ListElements' => 245,
			'OPTIONAL-32' => 246,
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106
		}
	},
	{#State 169
		ACTIONS => {
			")" => 247
		}
	},
	{#State 170
		ACTIONS => {
			'OP21_LIST_COMMA' => 248
		}
	},
	{#State 171
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 249
		}
	},
	{#State 172
		ACTIONS => {
			")" => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			";" => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP18_TERNARY' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP21_LIST_COMMA' => -180,
			'OP04_MATH_POW' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_MATH_ADD_SUB' => -79
		}
	},
	{#State 173
		ACTIONS => {
			"%{" => 105
		},
		GOTOS => {
			'HashDereferenced' => 250
		}
	},
	{#State 174
		ACTIONS => {
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98
		},
		GOTOS => {
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 251
		}
	},
	{#State 175
		DEFAULT => -202
	},
	{#State 176
		ACTIONS => {
			";" => 252
		}
	},
	{#State 177
		DEFAULT => -191
	},
	{#State 178
		ACTIONS => {
			'OP20_HASH_FATARROW' => 253
		}
	},
	{#State 179
		DEFAULT => -196,
		GOTOS => {
			'STAR-48' => 254
		}
	},
	{#State 180
		DEFAULT => -135
	},
	{#State 181
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => 146,
			")" => 255,
			'OP24_LOGICAL_OR_XOR' => 147,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => 142,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143
		}
	},
	{#State 182
		ACTIONS => {
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP05_LOGICAL_NEG' => 89,
			"my" => 171,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 173,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			"\@{" => 101,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			"undef" => 97,
			'LBRACE' => 96,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79
		},
		GOTOS => {
			'SubExpression' => 172,
			'Variable' => 164,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'TypeInner' => 174,
			'ListElement' => 256
		}
	},
	{#State 183
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 257
		}
	},
	{#State 184
		ACTIONS => {
			")" => 258,
			'OP24_LOGICAL_OR_XOR' => 147,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => 142,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 185
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP16_LOGICAL_OR' => -94,
			";" => -94,
			")" => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			"]" => -94,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			"}" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP15_LOGICAL_AND' => -94
		}
	},
	{#State 186
		ACTIONS => {
			"}" => 259
		}
	},
	{#State 187
		ACTIONS => {
			"}" => 260
		}
	},
	{#State 188
		ACTIONS => {
			"]" => 261
		}
	},
	{#State 189
		ACTIONS => {
			'WORD' => 263
		},
		GOTOS => {
			'PLUS-44' => 262
		}
	},
	{#State 190
		DEFAULT => -183
	},
	{#State 191
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 264
		}
	},
	{#State 192
		ACTIONS => {
			'OP13_BITWISE_AND' => 149,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -180,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			";" => -180,
			'OP24_LOGICAL_OR_XOR' => 147,
			")" => -180,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			"]" => -180,
			'OP23_LOGICAL_AND' => 142,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156
		}
	},
	{#State 193
		DEFAULT => -139
	},
	{#State 194
		ACTIONS => {
			"%{" => 105,
			'WORD' => 178
		},
		GOTOS => {
			'HashEntry' => 179,
			'HashDereferenced' => 177
		}
	},
	{#State 195
		ACTIONS => {
			"}" => 265
		}
	},
	{#State 196
		ACTIONS => {
			"}" => 266
		}
	},
	{#State 197
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP23_LOGICAL_AND' => 142,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 149,
			'OP04_MATH_POW' => 148,
			'OP24_LOGICAL_OR_XOR' => 147,
			")" => 267,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140
		}
	},
	{#State 198
		ACTIONS => {
			"filehandle_ref" => 268
		}
	},
	{#State 199
		ACTIONS => {
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP13_BITWISE_AND' => 149,
			'OP04_MATH_POW' => 148,
			'OP24_LOGICAL_OR_XOR' => 147,
			")" => 269,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => 146,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP23_LOGICAL_AND' => 142,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155
		}
	},
	{#State 200
		ACTIONS => {
			";" => 270
		}
	},
	{#State 201
		ACTIONS => {
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			'OP24_LOGICAL_OR_XOR' => -105,
			")" => -105,
			";" => -105,
			'OP13_BITWISE_AND' => 149,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP23_LOGICAL_AND' => -105,
			"}" => -105,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			"]" => -105
		}
	},
	{#State 202
		ACTIONS => {
			"use constant" => 45,
			"our hash_ref \$properties" => 273
		},
		GOTOS => {
			'Constant' => 271,
			'Properties' => 272
		}
	},
	{#State 203
		DEFAULT => -53
	},
	{#State 204
		DEFAULT => -40
	},
	{#State 205
		ACTIONS => {
			"while (" => -141,
			'OP01_NAMED' => 94,
			'OP19_LOOP_CONTROL' => 95,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'CONSTANT_SYMBOL' => 92,
			"my" => 88,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'OP01_PRINT' => 75,
			'VARIABLE_SYMBOL' => 77,
			"for my integer" => -141,
			'OP22_LOGICAL_NEG' => 116,
			"if (" => 112,
			'OP01_NAMED_VOID' => 115,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			"foreach my" => -141,
			'WORD' => 107,
			"%{" => 105,
			"\@{" => 101,
			'LBRACKET' => 103,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'Literal' => 114,
			'VariableModification' => 113,
			'WordScoped' => 93,
			'SubExpression' => 85,
			'OperatorVoid' => 86,
			'Variable' => 87,
			'Expression' => 91,
			'LoopLabel' => 104,
			'ArrayReference' => 106,
			'VariableDeclaration' => 80,
			'Conditional' => 81,
			'Operation' => 275,
			'OPTIONAL-35' => 84,
			'PLUS-17' => 274,
			'Operator' => 73,
			'PAREN-34' => 72,
			'Statement' => 71,
			'HashDereferenced' => 102,
			'HashReference' => 76,
			'ArrayDereferenced' => 78
		}
	},
	{#State 206
		DEFAULT => -42
	},
	{#State 207
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 276
		}
	},
	{#State 208
		ACTIONS => {
			"\$TYPED_" => 277
		}
	},
	{#State 209
		ACTIONS => {
			";" => 278
		}
	},
	{#State 210
		ACTIONS => {
			";" => 279
		}
	},
	{#State 211
		ACTIONS => {
			";" => 280
		}
	},
	{#State 212
		DEFAULT => -163
	},
	{#State 213
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			"undef" => 97,
			'LBRACE' => 96,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103
		},
		GOTOS => {
			'Operator' => 73,
			'SubExpression' => 281,
			'Variable' => 164,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114
		}
	},
	{#State 214
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 282,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			'LBRACE' => 96,
			"undef" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100
		},
		GOTOS => {
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 283,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114
		}
	},
	{#State 215
		ACTIONS => {
			'VARIABLE_SYMBOL' => 284
		}
	},
	{#State 216
		ACTIONS => {
			'LPAREN' => 285
		}
	},
	{#State 217
		ACTIONS => {
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP23_LOGICAL_AND' => 142,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP13_BITWISE_AND' => 149,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => 146,
			")" => 286,
			'OP24_LOGICAL_OR_XOR' => 147
		}
	},
	{#State 218
		ACTIONS => {
			"]" => -97,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			"}" => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP18_TERNARY' => -97,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -97,
			'OP13_BITWISE_AND' => -97,
			";" => -97,
			")" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP11_COMPARE_LT_GT' => undef,
			'OP16_LOGICAL_OR' => -97
		}
	},
	{#State 219
		DEFAULT => -207
	},
	{#State 220
		DEFAULT => -206
	},
	{#State 221
		ACTIONS => {
			'COLON' => 287
		}
	},
	{#State 222
		ACTIONS => {
			'OP23_LOGICAL_AND' => -106,
			"}" => -106,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			"]" => -106,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			'OP24_LOGICAL_OR_XOR' => -106,
			")" => -106,
			";" => -106,
			'OP13_BITWISE_AND' => 149,
			'OP21_LIST_COMMA' => -106,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150
		}
	},
	{#State 223
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => -101,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			"}" => -101,
			'OP23_LOGICAL_AND' => -101,
			"]" => -101,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			";" => -101,
			")" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP17_LIST_RANGE' => -101,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -101,
			'OP13_BITWISE_AND' => 149
		}
	},
	{#State 224
		ACTIONS => {
			'OP16_LOGICAL_OR' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			")" => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			";" => -89,
			'OP21_LIST_COMMA' => -89,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP18_TERNARY' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP08_STRING_CAT' => -89,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => -89,
			"}" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			"]" => -89
		}
	},
	{#State 225
		ACTIONS => {
			'OP16_LOGICAL_OR' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			")" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			";" => -91,
			'OP21_LIST_COMMA' => -91,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP18_TERNARY' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_STRING_CAT' => -91,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => -91,
			"}" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => -91,
			"]" => -91
		}
	},
	{#State 226
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP17_LIST_RANGE' => -102,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			")" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			";" => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP11_COMPARE_LT_GT' => 140,
			"]" => -102,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => -102,
			"}" => -102
		}
	},
	{#State 227
		ACTIONS => {
			"]" => -107,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => 142,
			"}" => -107,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP21_LIST_COMMA' => -107,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			")" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			";" => -107,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140
		}
	},
	{#State 228
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			")" => -85,
			";" => -85,
			'OP13_BITWISE_AND' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => 148,
			'OP18_TERNARY' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP23_LOGICAL_AND' => -85,
			"}" => -85,
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			"]" => -85
		}
	},
	{#State 229
		ACTIONS => {
			"]" => -99,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => -99,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => -99,
			"}" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => -99,
			")" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			";" => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP11_COMPARE_LT_GT' => 140
		}
	},
	{#State 230
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			"}" => -93,
			'OP23_LOGICAL_AND' => -93,
			"]" => -93,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			";" => -93,
			")" => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP18_TERNARY' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -93,
			'OP13_BITWISE_AND' => -93
		}
	},
	{#State 231
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP18_TERNARY' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			";" => -90,
			")" => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP07_STRING_REPEAT' => 144,
			"]" => -90,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => -90,
			"}" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP15_LOGICAL_AND' => -90
		}
	},
	{#State 232
		ACTIONS => {
			'OP13_BITWISE_AND' => 149,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -103,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP18_TERNARY' => -103,
			'OP17_LIST_RANGE' => undef,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			";" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			")" => -103,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			"]" => -103,
			"}" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156
		}
	},
	{#State 233
		ACTIONS => {
			'OP13_BITWISE_AND' => 149,
			'OP21_LIST_COMMA' => -100,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => -100,
			'OP18_TERNARY' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP16_LOGICAL_OR' => -100,
			'OP11_COMPARE_LT_GT' => 140,
			'OP24_LOGICAL_OR_XOR' => -100,
			")" => -100,
			";" => -100,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			"]" => -100,
			'OP23_LOGICAL_AND' => -100,
			"}" => -100,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP15_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 156
		}
	},
	{#State 234
		ACTIONS => {
			'OP13_BITWISE_AND' => -92,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP18_TERNARY' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			";" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			")" => -92,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			"]" => -92,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP12_COMPARE_EQ_NE' => -92
		}
	},
	{#State 235
		DEFAULT => -88
	},
	{#State 236
		ACTIONS => {
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			"}" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP15_LOGICAL_AND' => -98,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			"]" => -98,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => -98,
			";" => -98,
			")" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			'OP17_LIST_RANGE' => -98
		}
	},
	{#State 237
		ACTIONS => {
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"undef" => 97,
			'LBRACE' => 96,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			'OP03_MATH_INC_DEC' => 83,
			")" => -121,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP10_STRINGIFY_UNARY' => 108,
			"my" => 171,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_QW' => 189,
			'OP01_NAMED' => 165,
			'KEYS_OR_VALUES' => 173
		},
		GOTOS => {
			'WordScoped' => 93,
			'OPTIONAL-33' => 289,
			'ArrayReference' => 106,
			'Literal' => 114,
			'ListElement' => 191,
			'ListElements' => 288,
			'TypeInner' => 174,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 192,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102
		}
	},
	{#State 238
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP23_LOGICAL_AND' => 142,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			";" => 290,
			'OP24_LOGICAL_OR_XOR' => 147,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149
		}
	},
	{#State 239
		ACTIONS => {
			";" => 291
		}
	},
	{#State 240
		ACTIONS => {
			";" => -137,
			'OP24_LOGICAL_OR_XOR' => 147,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP13_BITWISE_AND' => 149,
			'OP04_MATH_POW' => 148,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP23_LOGICAL_AND' => 142,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144
		}
	},
	{#State 241
		DEFAULT => -138
	},
	{#State 242
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 293,
			";" => 292
		}
	},
	{#State 243
		ACTIONS => {
			'OP18_TERNARY' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP04_MATH_POW' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			")" => -79,
			";" => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			"]" => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP23_LOGICAL_AND' => -79,
			"}" => -79,
			'OP08_STRING_CAT' => -79,
			'OP06_REGEX_MATCH' => -79
		}
	},
	{#State 244
		DEFAULT => -124
	},
	{#State 245
		DEFAULT => -118
	},
	{#State 246
		ACTIONS => {
			")" => 294
		}
	},
	{#State 247
		DEFAULT => -126
	},
	{#State 248
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			"my" => 171,
			'WORD_SCOPED' => 26,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_QW' => 189,
			'KEYS_OR_VALUES' => 173,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP03_MATH_INC_DEC' => 83,
			'WORD' => 24,
			'OP01_CLOSE' => 79,
			"%{" => 105
		},
		GOTOS => {
			'ListElements' => 295,
			'TypeInner' => 174,
			'ListElement' => 191,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 192
		}
	},
	{#State 249
		ACTIONS => {
			"\$TYPED_" => 296
		}
	},
	{#State 250
		DEFAULT => -182
	},
	{#State 251
		ACTIONS => {
			")" => -181,
			'OP24_LOGICAL_OR_XOR' => 147,
			";" => -181,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP21_LIST_COMMA' => -181,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => 142,
			"]" => -181,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 252
		DEFAULT => -117
	},
	{#State 253
		ACTIONS => {
			'OP01_NAMED' => -189,
			'OP22_LOGICAL_NEG' => -189,
			'OP10_STRINGIFY_UNARY' => -189,
			"my" => 171,
			'LITERAL_STRING' => -189,
			'WORD_SCOPED' => -189,
			'LITERAL_NUMBER' => -189,
			'OP05_LOGICAL_NEG' => -189,
			'CONSTANT_SYMBOL' => -189,
			'OP01_OPEN' => -189,
			'WORD' => -189,
			'OP01_CLOSE' => -189,
			"%{" => -189,
			'OP03_MATH_INC_DEC' => -189,
			"undef" => -189,
			'LBRACE' => -189,
			'OP10_NAMED_UNARY' => -189,
			'OP05_MATH_NEG_LPAREN' => -189,
			'LPAREN' => -189,
			"\@{" => -189,
			'LBRACKET' => -189,
			'VARIABLE_SYMBOL' => -189
		},
		GOTOS => {
			'TypeInner' => 297,
			'OPTIONAL-46' => 298
		}
	},
	{#State 254
		ACTIONS => {
			"}" => 300,
			'OP21_LIST_COMMA' => 299
		},
		GOTOS => {
			'PAREN-47' => 301
		}
	},
	{#State 255
		DEFAULT => -136
	},
	{#State 256
		ACTIONS => {
			'OP21_LIST_COMMA' => 302
		}
	},
	{#State 257
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_QW' => 189,
			'OP01_NAMED' => 165,
			'KEYS_OR_VALUES' => 173,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			"my" => 171,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP03_MATH_INC_DEC' => 83,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96
		},
		GOTOS => {
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'ListElements' => 303,
			'TypeInner' => 174,
			'ListElement' => 191,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 192,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162
		}
	},
	{#State 258
		DEFAULT => -87
	},
	{#State 259
		DEFAULT => -187
	},
	{#State 260
		DEFAULT => -186
	},
	{#State 261
		DEFAULT => -185
	},
	{#State 262
		ACTIONS => {
			'WORD' => 304,
			")" => 305
		}
	},
	{#State 263
		DEFAULT => -177
	},
	{#State 264
		ACTIONS => {
			")" => -178,
			";" => -178,
			"]" => -178,
			'OP21_LIST_COMMA' => 306
		},
		GOTOS => {
			'PAREN-42' => 307
		}
	},
	{#State 265
		DEFAULT => -199
	},
	{#State 266
		DEFAULT => -198
	},
	{#State 267
		DEFAULT => -96
	},
	{#State 268
		ACTIONS => {
			'FH_REF_SYMBOL' => 308
		}
	},
	{#State 269
		ACTIONS => {
			'LBRACE' => 310
		},
		GOTOS => {
			'CodeBlock' => 309
		}
	},
	{#State 270
		DEFAULT => -114
	},
	{#State 271
		DEFAULT => -55
	},
	{#State 272
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 311
		}
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 274
		ACTIONS => {
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			'LBRACE' => 96,
			"undef" => 97,
			'LBRACKET' => 103,
			"\@{" => 101,
			"%{" => 105,
			'WORD' => 107,
			"foreach my" => -141,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'OP01_NAMED_VOID' => 115,
			"if (" => 112,
			'OP22_LOGICAL_NEG' => 116,
			"for my integer" => -141,
			'VARIABLE_SYMBOL' => 77,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'OP01_PRINT' => 75,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83,
			"my" => 88,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP19_LOOP_CONTROL' => 95,
			"}" => 314,
			"while (" => -141,
			'OP01_NAMED' => 94
		},
		GOTOS => {
			'WordScoped' => 93,
			'VariableModification' => 113,
			'Literal' => 114,
			'Expression' => 91,
			'OperatorVoid' => 86,
			'Variable' => 87,
			'SubExpression' => 85,
			'OPTIONAL-35' => 84,
			'VariableDeclaration' => 80,
			'Conditional' => 81,
			'Operation' => 313,
			'LoopLabel' => 104,
			'ArrayReference' => 106,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'PAREN-34' => 72,
			'Statement' => 71,
			'Operator' => 73
		}
	},
	{#State 275
		DEFAULT => -45
	},
	{#State 276
		ACTIONS => {
			'VARIABLE_SYMBOL' => 315
		}
	},
	{#State 277
		ACTIONS => {
			'CONSTANT_SYMBOL' => 316
		}
	},
	{#State 278
		DEFAULT => -41
	},
	{#State 279
		DEFAULT => -111
	},
	{#State 280
		DEFAULT => -112
	},
	{#State 281
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => 146,
			'OP24_LOGICAL_OR_XOR' => 147,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			"]" => 317,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => 142,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143
		}
	},
	{#State 282
		ACTIONS => {
			'LPAREN' => -200,
			"}" => 318,
			'OP02_METHOD_THINARROW_NEW' => -200
		}
	},
	{#State 283
		ACTIONS => {
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP23_LOGICAL_AND' => 142,
			"}" => 319,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP15_LOGICAL_AND' => 143,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP13_BITWISE_AND' => 149,
			'OP04_MATH_POW' => 148,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => 146,
			'OP24_LOGICAL_OR_XOR' => 147
		}
	},
	{#State 284
		ACTIONS => {
			'LPAREN' => 320
		}
	},
	{#State 285
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			"undef" => 97,
			'LBRACE' => 96,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83
		},
		GOTOS => {
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 321,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114
		}
	},
	{#State 286
		ACTIONS => {
			'LBRACE' => 310
		},
		GOTOS => {
			'CodeBlock' => 322
		}
	},
	{#State 287
		ACTIONS => {
			'VARIABLE_SYMBOL' => 77,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110
		},
		GOTOS => {
			'VariableOrLiteral' => 323,
			'Variable' => 220,
			'Literal' => 219
		}
	},
	{#State 288
		DEFAULT => -120
	},
	{#State 289
		ACTIONS => {
			")" => 324
		}
	},
	{#State 290
		DEFAULT => -172
	},
	{#State 291
		DEFAULT => -171
	},
	{#State 292
		DEFAULT => -169
	},
	{#State 293
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'STDIN' => 241,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			'LBRACE' => 96,
			"undef" => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108
		},
		GOTOS => {
			'Expression' => 162,
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'SubExpression' => 240,
			'Variable' => 164,
			'SubExpressionOrStdin' => 325,
			'Operator' => 73,
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106
		}
	},
	{#State 294
		DEFAULT => -123
	},
	{#State 295
		ACTIONS => {
			";" => 326
		}
	},
	{#State 296
		ACTIONS => {
			'WORD' => 327
		}
	},
	{#State 297
		DEFAULT => -188
	},
	{#State 298
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101
		},
		GOTOS => {
			'Operator' => 73,
			'SubExpression' => 328,
			'Variable' => 164,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114
		}
	},
	{#State 299
		ACTIONS => {
			'WORD' => 178,
			"%{" => 105
		},
		GOTOS => {
			'HashEntry' => 329,
			'HashDereferenced' => 177
		}
	},
	{#State 300
		DEFAULT => -197
	},
	{#State 301
		DEFAULT => -195
	},
	{#State 302
		ACTIONS => {
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			"my" => 171,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'KEYS_OR_VALUES' => 173,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_QW' => 189,
			'OP01_NAMED' => 165,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83
		},
		GOTOS => {
			'ListElement' => 191,
			'TypeInner' => 174,
			'ListElements' => 330,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Literal' => 114,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'Operator' => 73,
			'Variable' => 164,
			'SubExpression' => 192
		}
	},
	{#State 303
		ACTIONS => {
			")" => 331
		}
	},
	{#State 304
		DEFAULT => -176
	},
	{#State 305
		DEFAULT => -179
	},
	{#State 306
		ACTIONS => {
			'KEYS_OR_VALUES' => 173,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			"my" => 171,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'Operator' => 73,
			'SubExpression' => 192,
			'Variable' => 164,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Literal' => 114,
			'ListElement' => 332,
			'TypeInner' => 174
		}
	},
	{#State 307
		DEFAULT => -174
	},
	{#State 308
		ACTIONS => {
			'OP21_LIST_COMMA' => 333
		}
	},
	{#State 309
		DEFAULT => -149,
		GOTOS => {
			'STAR-37' => 334
		}
	},
	{#State 310
		ACTIONS => {
			'OP01_OPEN' => 111,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED_VOID' => 115,
			"if (" => 112,
			'LBRACKET' => 103,
			"\@{" => 101,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			"foreach my" => -141,
			"%{" => 105,
			'WORD' => 107,
			'CONSTANT_SYMBOL' => 92,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP05_LOGICAL_NEG' => 89,
			"my" => 88,
			'OP19_LOOP_CONTROL' => 95,
			"while (" => -141,
			'OP01_NAMED' => 94,
			'VARIABLE_SYMBOL' => 77,
			'OP01_PRINT' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			"for my integer" => -141,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79
		},
		GOTOS => {
			'HashDereferenced' => 102,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Operator' => 73,
			'PAREN-34' => 72,
			'Statement' => 71,
			'Operation' => 335,
			'Conditional' => 81,
			'VariableDeclaration' => 80,
			'PLUS-40' => 336,
			'OPTIONAL-35' => 84,
			'ArrayReference' => 106,
			'LoopLabel' => 104,
			'Expression' => 91,
			'OperatorVoid' => 86,
			'Variable' => 87,
			'SubExpression' => 85,
			'VariableModification' => 113,
			'Literal' => 114,
			'WordScoped' => 93
		}
	},
	{#State 311
		ACTIONS => {
			'LITERAL_NUMBER' => 338,
			"our" => 340
		},
		GOTOS => {
			'MethodOrSubroutine' => 337,
			'Method' => 341,
			'Subroutine' => 339
		}
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 342
		}
	},
	{#State 313
		DEFAULT => -44
	},
	{#State 314
		ACTIONS => {
			";" => 343
		}
	},
	{#State 315
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 344
		}
	},
	{#State 316
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 345
		}
	},
	{#State 317
		DEFAULT => -166
	},
	{#State 318
		DEFAULT => -168
	},
	{#State 319
		DEFAULT => -167
	},
	{#State 320
		ACTIONS => {
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			"undef" => 97,
			'LBRACE' => 96,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			'KEYS_OR_VALUES' => 173,
			'OP01_QW' => 189,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP10_STRINGIFY_UNARY' => 108,
			"my" => 171,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92
		},
		GOTOS => {
			'ListElement' => 191,
			'TypeInner' => 174,
			'ListElements' => 346,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'Operator' => 73,
			'SubExpression' => 192,
			'Variable' => 164
		}
	},
	{#State 321
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP23_LOGICAL_AND' => 142,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP17_LIST_RANGE' => 347,
			'OP18_TERNARY' => 141,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => 146,
			'OP24_LOGICAL_OR_XOR' => 147
		}
	},
	{#State 322
		DEFAULT => -159
	},
	{#State 323
		DEFAULT => -104
	},
	{#State 324
		DEFAULT => -125
	},
	{#State 325
		ACTIONS => {
			";" => 348
		}
	},
	{#State 326
		DEFAULT => -115
	},
	{#State 327
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 349
		}
	},
	{#State 328
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -190,
			'OP13_BITWISE_AND' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			'OP24_LOGICAL_OR_XOR' => 147,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			"}" => -190,
			'OP23_LOGICAL_AND' => 142,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143
		}
	},
	{#State 329
		DEFAULT => -194
	},
	{#State 330
		ACTIONS => {
			")" => 350
		}
	},
	{#State 331
		DEFAULT => -78
	},
	{#State 332
		DEFAULT => -173
	},
	{#State 333
		ACTIONS => {
			'LITERAL_STRING' => 351
		}
	},
	{#State 334
		ACTIONS => {
			"else" => 355,
			'OP01_NAMED_VOID' => -152,
			"if (" => -152,
			'OP22_LOGICAL_NEG' => -152,
			'LITERAL_STRING' => -152,
			'WORD_SCOPED' => -152,
			'LITERAL_NUMBER' => -152,
			'OP10_STRINGIFY_UNARY' => -152,
			'OP01_OPEN' => -152,
			"%{" => -152,
			'WORD' => -152,
			"foreach my" => -152,
			'OP05_MATH_NEG_LPAREN' => -152,
			'LPAREN' => -152,
			'OP10_NAMED_UNARY' => -152,
			'LBRACE' => -152,
			"undef" => -152,
			'LBRACKET' => -152,
			"\@{" => -152,
			"}" => -152,
			'OP19_LOOP_CONTROL' => -152,
			"while (" => -152,
			'OP01_NAMED' => -152,
			"my" => -152,
			'CONSTANT_SYMBOL' => -152,
			'OP01_NAMED_VOID_SCOLON' => -152,
			'OP05_LOGICAL_NEG' => -152,
			'OP01_CLOSE' => -152,
			'' => -152,
			'OP03_MATH_INC_DEC' => -152,
			"elsif (" => 353,
			"for my integer" => -152,
			'VARIABLE_SYMBOL' => -152,
			'OP19_LOOP_CONTROL_SCOLON' => -152,
			'OP01_PRINT' => -152
		},
		GOTOS => {
			'PAREN-36' => 352,
			'PAREN-38' => 354,
			'OPTIONAL-39' => 356
		}
	},
	{#State 335
		DEFAULT => -161
	},
	{#State 336
		ACTIONS => {
			"}" => 357,
			'OP19_LOOP_CONTROL' => 95,
			'OP01_NAMED' => 94,
			"while (" => -141,
			"my" => 88,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83,
			"for my integer" => -141,
			'VARIABLE_SYMBOL' => 77,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'OP01_PRINT' => 75,
			'OP01_NAMED_VOID' => 115,
			"if (" => 112,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'OP10_STRINGIFY_UNARY' => 108,
			'OP01_OPEN' => 111,
			'WORD' => 107,
			"%{" => 105,
			"foreach my" => -141,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			"undef" => 97,
			'LBRACE' => 96,
			'LBRACKET' => 103,
			"\@{" => 101
		},
		GOTOS => {
			'Literal' => 114,
			'VariableModification' => 113,
			'WordScoped' => 93,
			'SubExpression' => 85,
			'Variable' => 87,
			'OperatorVoid' => 86,
			'Expression' => 91,
			'LoopLabel' => 104,
			'ArrayReference' => 106,
			'Conditional' => 81,
			'VariableDeclaration' => 80,
			'Operation' => 358,
			'OPTIONAL-35' => 84,
			'Statement' => 71,
			'Operator' => 73,
			'PAREN-34' => 72,
			'HashDereferenced' => 102,
			'HashReference' => 76,
			'ArrayDereferenced' => 78
		}
	},
	{#State 337
		DEFAULT => -57
	},
	{#State 338
		ACTIONS => {
			";" => 359
		}
	},
	{#State 339
		DEFAULT => -75
	},
	{#State 340
		ACTIONS => {
			'WORD' => 56,
			'TYPE_METHOD' => 360
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 341
		DEFAULT => -74
	},
	{#State 342
		ACTIONS => {
			"%{" => 105,
			'WORD' => 362,
			"}" => 363
		},
		GOTOS => {
			'HashEntryTyped' => 364,
			'HashDereferenced' => 361
		}
	},
	{#State 343
		DEFAULT => -46
	},
	{#State 344
		ACTIONS => {
			")" => 367,
			'OP21_LIST_COMMA' => 365
		},
		GOTOS => {
			'PAREN-18' => 366
		}
	},
	{#State 345
		DEFAULT => -205
	},
	{#State 346
		ACTIONS => {
			")" => 368
		}
	},
	{#State 347
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 83,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"\@{" => 101,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"undef" => 97,
			'LBRACE' => 96,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP05_LOGICAL_NEG' => 89,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'OP10_STRINGIFY_UNARY' => 108
		},
		GOTOS => {
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'Expression' => 162,
			'HashDereferenced' => 102,
			'Operator' => 73,
			'SubExpression' => 369,
			'Variable' => 164,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Literal' => 114
		}
	},
	{#State 348
		DEFAULT => -170
	},
	{#State 349
		DEFAULT => -204
	},
	{#State 350
		DEFAULT => -80
	},
	{#State 351
		ACTIONS => {
			'OP21_LIST_COMMA' => 370
		}
	},
	{#State 352
		DEFAULT => -148
	},
	{#State 353
		ACTIONS => {
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'WORD' => 24,
			'OP03_MATH_INC_DEC' => 83,
			"undef" => 97,
			'LBRACE' => 96,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			'OP10_STRINGIFY_UNARY' => 108,
			'WORD_SCOPED' => 26,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'SubExpression' => 371,
			'Variable' => 164,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78
		}
	},
	{#State 354
		DEFAULT => -151
	},
	{#State 355
		ACTIONS => {
			'LBRACE' => 310
		},
		GOTOS => {
			'CodeBlock' => 372
		}
	},
	{#State 356
		DEFAULT => -153
	},
	{#State 357
		DEFAULT => -162
	},
	{#State 358
		DEFAULT => -160
	},
	{#State 359
		DEFAULT => -59
	},
	{#State 360
		ACTIONS => {
			'VARIABLE_SYMBOL' => 373
		}
	},
	{#State 361
		DEFAULT => -193
	},
	{#State 362
		ACTIONS => {
			'OP20_HASH_FATARROW' => 374
		}
	},
	{#State 363
		ACTIONS => {
			";" => 375
		}
	},
	{#State 364
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 376
		}
	},
	{#State 365
		ACTIONS => {
			"my" => 377
		}
	},
	{#State 366
		DEFAULT => -48
	},
	{#State 367
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 378
		}
	},
	{#State 368
		ACTIONS => {
			'LBRACE' => 310
		},
		GOTOS => {
			'CodeBlock' => 379
		}
	},
	{#State 369
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -103,
			")" => 380,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -103,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => -103,
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145
		}
	},
	{#State 370
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 89,
			'OP01_OPEN' => 111,
			'CONSTANT_SYMBOL' => 92,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 110,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 116,
			'OP01_NAMED' => 165,
			"\@{" => 101,
			'VARIABLE_SYMBOL' => 77,
			'LBRACKET' => 103,
			"undef" => 97,
			'LBRACE' => 96,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79,
			"%{" => 105,
			'WORD' => 24
		},
		GOTOS => {
			'Literal' => 114,
			'WordScoped' => 93,
			'ArrayReference' => 106,
			'Variable' => 164,
			'SubExpression' => 381,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78
		}
	},
	{#State 371
		ACTIONS => {
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			'OP24_LOGICAL_OR_XOR' => 147,
			")" => 382,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP09_BITWISE_SHIFT' => 150,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP23_LOGICAL_AND' => 142,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144
		}
	},
	{#State 372
		DEFAULT => -150
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 383
		}
	},
	{#State 374
		ACTIONS => {
			"my" => 171
		},
		GOTOS => {
			'TypeInner' => 384
		}
	},
	{#State 375
		DEFAULT => -64
	},
	{#State 376
		ACTIONS => {
			'OP21_LIST_COMMA' => 386,
			"}" => 385
		},
		GOTOS => {
			'PAREN-24' => 387
		}
	},
	{#State 377
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 388
		}
	},
	{#State 378
		ACTIONS => {
			"\@_;" => 389
		}
	},
	{#State 379
		DEFAULT => -158
	},
	{#State 380
		ACTIONS => {
			'LBRACE' => 310
		},
		GOTOS => {
			'CodeBlock' => 390
		}
	},
	{#State 381
		ACTIONS => {
			'OP04_MATH_POW' => 148,
			'OP21_LIST_COMMA' => -81,
			'OP13_BITWISE_AND' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP17_LIST_RANGE' => 152,
			'OP18_TERNARY' => 141,
			'OP16_LOGICAL_OR' => 146,
			'OP11_COMPARE_LT_GT' => 140,
			";" => -81,
			")" => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP08_MATH_ADD_SUB' => 145,
			'OP07_STRING_REPEAT' => 144,
			"]" => -81,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			"}" => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143
		}
	},
	{#State 382
		ACTIONS => {
			'LBRACE' => 310
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 383
		ACTIONS => {
			"\@{" => -66,
			'LBRACKET' => -66,
			"undef" => -66,
			'LBRACE' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'LPAREN' => -66,
			'OP10_NAMED_UNARY' => -66,
			"foreach my" => -66,
			"%{" => -66,
			'WORD' => -66,
			'OP01_OPEN' => -66,
			'OP10_STRINGIFY_UNARY' => -66,
			'LITERAL_STRING' => -66,
			'LITERAL_NUMBER' => -66,
			'WORD_SCOPED' => -66,
			'OP22_LOGICAL_NEG' => -66,
			"if (" => -66,
			'OP01_NAMED_VOID' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP01_PRINT' => -66,
			'VARIABLE_SYMBOL' => -66,
			"for my integer" => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP01_CLOSE' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'CONSTANT_SYMBOL' => -66,
			"my" => -66,
			"( my" => 393,
			'OP01_NAMED' => -66,
			"while (" => -66,
			'OP19_LOOP_CONTROL' => -66
		},
		GOTOS => {
			'MethodArguments' => 392,
			'OPTIONAL-26' => 394
		}
	},
	{#State 384
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			'OP01_OPEN' => 111,
			'OP01_NAMED' => 165,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACE' => 96,
			"undef" => 97,
			'OP10_NAMED_UNARY' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 98,
			"\@{" => 101,
			'LBRACKET' => 103,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 24,
			"%{" => 105,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83
		},
		GOTOS => {
			'Literal' => 114,
			'ArrayReference' => 106,
			'WordScoped' => 93,
			'Variable' => 164,
			'SubExpression' => 395,
			'Operator' => 73,
			'HashDereferenced' => 102,
			'Expression' => 162,
			'HashReference' => 76,
			'ArrayDereferenced' => 78
		}
	},
	{#State 385
		ACTIONS => {
			";" => 396
		}
	},
	{#State 386
		ACTIONS => {
			'WORD' => 362,
			"%{" => 105
		},
		GOTOS => {
			'HashDereferenced' => 361,
			'HashEntryTyped' => 397
		}
	},
	{#State 387
		DEFAULT => -61
	},
	{#State 388
		ACTIONS => {
			'VARIABLE_SYMBOL' => 398
		}
	},
	{#State 389
		DEFAULT => -50
	},
	{#State 390
		DEFAULT => -157
	},
	{#State 391
		DEFAULT => -147
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
		ACTIONS => {
			"undef" => 97,
			'LBRACE' => 96,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"\@{" => 101,
			'LBRACKET' => 103,
			"%{" => 105,
			'WORD' => 107,
			"foreach my" => -141,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'OP01_OPEN' => 111,
			"if (" => 112,
			'OP01_NAMED_VOID' => 115,
			'OP22_LOGICAL_NEG' => 116,
			"for my integer" => -141,
			'OP01_PRINT' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'VARIABLE_SYMBOL' => 77,
			'OP01_CLOSE' => 79,
			'OP03_MATH_INC_DEC' => 83,
			"my" => 88,
			'OP05_LOGICAL_NEG' => 89,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'CONSTANT_SYMBOL' => 92,
			"while (" => -141,
			'OP01_NAMED' => 94,
			'OP19_LOOP_CONTROL' => 95
		},
		GOTOS => {
			'Expression' => 91,
			'Variable' => 87,
			'SubExpression' => 85,
			'OperatorVoid' => 86,
			'WordScoped' => 93,
			'VariableModification' => 113,
			'Literal' => 114,
			'ArrayDereferenced' => 78,
			'HashReference' => 76,
			'HashDereferenced' => 102,
			'Statement' => 71,
			'Operator' => 73,
			'PAREN-34' => 72,
			'PLUS-27' => 401,
			'OPTIONAL-35' => 84,
			'Operation' => 400,
			'VariableDeclaration' => 80,
			'Conditional' => 81,
			'LoopLabel' => 104,
			'ArrayReference' => 106
		}
	},
	{#State 395
		ACTIONS => {
			'OP07_STRING_REPEAT' => 144,
			'OP08_MATH_ADD_SUB' => 145,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP23_LOGICAL_AND' => 142,
			"}" => -192,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP15_LOGICAL_AND' => 143,
			'OP21_LIST_COMMA' => -192,
			'OP04_MATH_POW' => 148,
			'OP13_BITWISE_AND' => 149,
			'OP09_BITWISE_SHIFT' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 151,
			'OP18_TERNARY' => 141,
			'OP17_LIST_RANGE' => 152,
			'OP14_BITWISE_OR_XOR' => 153,
			'OP11_COMPARE_LT_GT' => 140,
			'OP16_LOGICAL_OR' => 146,
			'OP24_LOGICAL_OR_XOR' => 147
		}
	},
	{#State 396
		DEFAULT => -63
	},
	{#State 397
		DEFAULT => -60
	},
	{#State 398
		DEFAULT => -47
	},
	{#State 399
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 402
		}
	},
	{#State 400
		DEFAULT => -68
	},
	{#State 401
		ACTIONS => {
			'OP01_OPEN' => 111,
			'OP10_STRINGIFY_UNARY' => 108,
			'LITERAL_STRING' => 110,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 116,
			"if (" => 112,
			'OP01_NAMED_VOID' => 115,
			"\@{" => 101,
			'LBRACKET' => 103,
			"undef" => 97,
			'LBRACE' => 96,
			'LPAREN' => 98,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP10_NAMED_UNARY' => 100,
			"foreach my" => -141,
			"%{" => 105,
			'WORD' => 107,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP05_LOGICAL_NEG' => 89,
			'CONSTANT_SYMBOL' => 92,
			"my" => 88,
			'OP01_NAMED' => 94,
			"while (" => -141,
			"}" => 403,
			'OP19_LOOP_CONTROL' => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 74,
			'OP01_PRINT' => 75,
			'VARIABLE_SYMBOL' => 77,
			"for my integer" => -141,
			'OP03_MATH_INC_DEC' => 83,
			'OP01_CLOSE' => 79
		},
		GOTOS => {
			'WordScoped' => 93,
			'Literal' => 114,
			'VariableModification' => 113,
			'Expression' => 91,
			'Variable' => 87,
			'SubExpression' => 85,
			'OperatorVoid' => 86,
			'OPTIONAL-35' => 84,
			'Conditional' => 81,
			'VariableDeclaration' => 80,
			'Operation' => 404,
			'LoopLabel' => 104,
			'ArrayReference' => 106,
			'HashReference' => 76,
			'ArrayDereferenced' => 78,
			'HashDereferenced' => 102,
			'Statement' => 71,
			'Operator' => 73,
			'PAREN-34' => 72
		}
	},
	{#State 402
		ACTIONS => {
			'OP21_LIST_COMMA' => 407,
			")" => 405
		},
		GOTOS => {
			'PAREN-28' => 406
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
			'OP19_VARIABLE_ASSIGN' => 409
		}
	},
	{#State 406
		DEFAULT => -71
	},
	{#State 407
		ACTIONS => {
			"my" => 410
		}
	},
	{#State 408
		DEFAULT => -69
	},
	{#State 409
		ACTIONS => {
			"\@_;" => 411
		}
	},
	{#State 410
		ACTIONS => {
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 412
		}
	},
	{#State 411
		DEFAULT => -73
	},
	{#State 412
		ACTIONS => {
			'VARIABLE_SYMBOL' => 413
		}
	},
	{#State 413
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5907 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5914 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5921 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 134 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5928 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5939 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5950 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5957 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5964 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5978 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5985 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5992 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5999 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6013 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6020 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6027 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 135 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6034 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6045 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6052 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 136 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6059 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6070 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6081 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6092 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6099 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6106 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6113 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6120 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6127 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6134 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6141 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6170 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6177 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6184 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6195 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6202 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6209 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6220 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6231 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6242 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6256 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6263 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6270 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6281 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6295 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6302 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6313 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6320 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6327 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6341 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6348 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6362 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6369 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6380 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6387 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6394 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6401 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6412 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6423 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6430 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6437 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6444 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6451 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6462 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6469 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6476 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6483 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6494 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6505 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6516 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6527 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6538 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6549 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6560 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6571 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6593 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6604 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6615 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6637 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6648 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6659 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6670 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6692 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6703 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6714 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6725 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6736 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6747 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6780 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6802 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6813 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6824 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6835 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6846 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6857 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6868 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6889 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_111
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6911 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6994 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_122
		 'Expression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_123
		 'Expression', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7016 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7027 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7038 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7049 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_127
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7060 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_128
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7126 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7137 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7148 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7159 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_137
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7170 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_138
		 'SubExpressionOrStdin', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7181 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-34', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7202 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_142
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7213 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7224 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7235 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7246 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 4,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7278 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7299 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_153
		 'Conditional', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_154
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_155
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7332 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_157
		 'LoopFor', 8,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7354 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_158
		 'LoopForEach', 7,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7365 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_159
		 'LoopWhile', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7376 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7390 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_162
		 'CodeBlock', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7415 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_165
		 'Variable', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7426 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_166
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_167
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7448 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_169
		 'VariableDeclaration', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7470 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_170
		 'VariableDeclaration', 6,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7481 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_171
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7492 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_172
		 'VariableModification', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7503 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7538 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_178
		 'ListElements', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_179
		 'ListElements', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7560 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_180
		 'ListElement', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7571 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_181
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7582 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 2,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7593 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_185
		 'ArrayReference', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_186
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereferenced_187
		 'ArrayDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7654 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_190
		 'HashEntry', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7665 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_191
		 'HashEntry', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7676 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_192
		 'HashEntryTyped', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7687 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_193
		 'HashEntryTyped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7698 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-47', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7712 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7719 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_197
		 'HashReference', 4,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7730 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_198
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7741 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereferenced_199
		 'HashDereferenced', 3,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7752 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_200
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7763 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_201
		 'WordScoped', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7774 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_202
		 'LoopLabel', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7785 lib/RPerl/Grammar.pm
	],
	[#Rule Type_203
		 'Type', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7796 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_204
		 'TypeInner', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7807 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_205
		 'TypeInnerConstant', 5,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7818 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_206
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7829 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_207
		 'VariableOrLiteral', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7840 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_208
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7851 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_209
		 'Literal', 1,
sub {
#line 14 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7862 lib/RPerl/Grammar.pm
	]
],
#line 7865 lib/RPerl/Grammar.pm
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
         'Operator_107', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_111', 
         'OperatorVoid_112', 
         'OperatorVoid_113', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         'OperatorVoid_116', 
         'OperatorVoid_117', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_122', 
         'Expression_123', 
         'Expression_124', 
         'Expression_125', 
         'Expression_126', 
         'SubExpression_127', 
         'SubExpression_128', 
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpressionOrStdin_137', 
         'SubExpressionOrStdin_138', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_142', 
         'Statement_143', 
         'Statement_144', 
         'Statement_145', 
         'Statement_146', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_153', 
         'Loop_154', 
         'Loop_155', 
         'Loop_156', 
         'LoopFor_157', 
         'LoopForEach_158', 
         'LoopWhile_159', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_162', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_165', 
         'VariableRetrieval_166', 
         'VariableRetrieval_167', 
         'VariableRetrieval_168', 
         'VariableDeclaration_169', 
         'VariableDeclaration_170', 
         'VariableModification_171', 
         'VariableModification_172', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElements_178', 
         'ListElements_179', 
         'ListElement_180', 
         'ListElement_181', 
         'ListElement_182', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_185', 
         'ArrayDereferenced_186', 
         'ArrayDereferenced_187', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_190', 
         'HashEntry_191', 
         'HashEntryTyped_192', 
         'HashEntryTyped_193', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_197', 
         'HashDereferenced_198', 
         'HashDereferenced_199', 
         'WordScoped_200', 
         'WordScoped_201', 
         'LoopLabel_202', 
         'Type_203', 
         'TypeInner_204', 
         'TypeInnerConstant_205', 
         'VariableOrLiteral_206', 
         'VariableOrLiteral_207', 
         'Literal_208', 
         'Literal_209', );
  $self;
}

#line 214 "lib/RPerl/Grammar.eyp"


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


#line 8123 lib/RPerl/Grammar.pm



1;
