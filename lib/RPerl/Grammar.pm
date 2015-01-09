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

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\=\ sub\ \{|package|\$TYPED_|elsif\ \(|while\ \(|undef|if\ \(|else|\(\ my|qw\(|our|use|\@_\;|my|\%\{|\@\{|\;|\)|\}|\])}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$[a-zA-Z]\w*[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
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
      /\G([A-Z][A-Z0-9_]*)/gc and return ('CONSTANT_SYMBOL', $1);
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
			"package" => -20,
			'SHEBANG' => 6
		},
		GOTOS => {
			'ModuleHeader' => 4,
			'Program' => 5,
			'PAREN-1' => 3,
			'OPTIONAL-9' => 8,
			'PLUS-2' => 7,
			'Critic' => 2,
			'CompileUnit' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			"use" => -25,
			"## no critic qw(" => -25,
			"use parent qw(" => 13,
			"our" => -25,
			"use constant" => -25
		},
		GOTOS => {
			'Module' => 14,
			'Class' => 12,
			'Package' => 11,
			'STAR-10' => 15
		}
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 9,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 16,
			'Critic' => 17
		}
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 9,
			"package" => -20,
			'' => -5
		},
		GOTOS => {
			'OPTIONAL-9' => 8,
			'Critic' => 2,
			'PAREN-1' => 18,
			'ModuleHeader' => 4
		}
	},
	{#State 8
		ACTIONS => {
			"package" => 19
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
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -22
	},
	{#State 12
		DEFAULT => -23
	},
	{#State 13
		ACTIONS => {
			'WORD' => 22,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 23
		}
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		ACTIONS => {
			"## no critic qw(" => 9,
			"use" => -27,
			"use constant" => -27,
			"our" => -27
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-11' => 25
		}
	},
	{#State 16
		ACTIONS => {
			"use strict;" => 27
		},
		GOTOS => {
			'Header' => 28
		}
	},
	{#State 17
		DEFAULT => -6
	},
	{#State 18
		DEFAULT => -2
	},
	{#State 19
		ACTIONS => {
			'WORD' => 22,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		DEFAULT => -35
	},
	{#State 21
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 22
		DEFAULT => -200
	},
	{#State 23
		ACTIONS => {
			")" => 32
		}
	},
	{#State 24
		DEFAULT => -201
	},
	{#State 25
		ACTIONS => {
			"use" => 34,
			"use constant" => -29,
			"our" => -29
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 33
		}
	},
	{#State 26
		DEFAULT => -24
	},
	{#State 27
		ACTIONS => {
			"use warnings;" => 36
		}
	},
	{#State 28
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
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
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use constant" => 44,
			"our" => 41
		},
		GOTOS => {
			'Constant' => 40,
			'PLUS-13' => 43,
			'Subroutine' => 42
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 45
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			"use RPerl;" => 46
		}
	},
	{#State 37
		ACTIONS => {
			"undef" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"\@{" => -11,
			'OP01_CLOSE' => -11,
			"## no critic qw(" => 9,
			'LITERAL_STRING' => -11,
			'LBRACKET' => -11,
			'WORD_SCOPED' => -11,
			"use constant" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"foreach my" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_OPEN' => -11,
			"for my integer" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"while (" => -11,
			'OP01_NAMED' => -11,
			'CONSTANT_SYMBOL' => -11,
			'OP01_PRINT' => -11,
			"our" => -11,
			'WORD' => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			'OP01_NAMED_VOID' => -11,
			"if (" => -11,
			'LPAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"%{" => -11,
			'VARIABLE_SYMBOL' => -11,
			'LBRACE' => -11,
			"use" => -11,
			"my" => -11
		},
		GOTOS => {
			'Critic' => 48,
			'STAR-5' => 47
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 27
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 40
		DEFAULT => -28
	},
	{#State 41
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 42
		DEFAULT => -31
	},
	{#State 43
		ACTIONS => {
			"our" => 41,
			'LITERAL_NUMBER' => 54
		},
		GOTOS => {
			'Subroutine' => 53
		}
	},
	{#State 44
		ACTIONS => {
			'CONSTANT_SYMBOL' => 55
		}
	},
	{#State 45
		ACTIONS => {
			";" => 56,
			"qw(" => 57
		}
	},
	{#State 46
		ACTIONS => {
			"our" => 58
		}
	},
	{#State 47
		ACTIONS => {
			"\@{" => -13,
			'OP01_CLOSE' => -13,
			"undef" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"use constant" => -13,
			'LITERAL_STRING' => -13,
			'LBRACKET' => -13,
			'WORD_SCOPED' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_OPEN' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"foreach my" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"while (" => -13,
			'OP19_LOOP_CONTROL' => -13,
			"for my integer" => -13,
			'CONSTANT_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			"our" => -13,
			'WORD' => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			'OP01_NAMED' => -13,
			'LPAREN' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED_VOID' => -13,
			"if (" => -13,
			"%{" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"my" => -13,
			"use" => 34,
			'LBRACE' => -13
		},
		GOTOS => {
			'STAR-6' => 59,
			'Include' => 60
		}
	},
	{#State 48
		DEFAULT => -8
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 61
		}
	},
	{#State 51
		DEFAULT => -203
	},
	{#State 52
		ACTIONS => {
			'VARIABLE_SYMBOL' => 62
		}
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
		DEFAULT => -39
	},
	{#State 57
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 58
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 67
		}
	},
	{#State 59
		ACTIONS => {
			"my" => -15,
			'LBRACE' => -15,
			"%{" => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LPAREN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED_VOID' => -15,
			"if (" => -15,
			'CONSTANT_SYMBOL' => -15,
			'OP01_PRINT' => -15,
			"our" => -15,
			'WORD' => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			'OP01_NAMED' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"while (" => -15,
			'OP19_LOOP_CONTROL' => -15,
			"for my integer" => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_OPEN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"foreach my" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"use constant" => 44,
			'LITERAL_STRING' => -15,
			'LBRACKET' => -15,
			'WORD_SCOPED' => -15,
			"\@{" => -15,
			'OP01_CLOSE' => -15,
			"undef" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15
		},
		GOTOS => {
			'STAR-7' => 68,
			'Constant' => 69
		}
	},
	{#State 60
		DEFAULT => -10
	},
	{#State 61
		ACTIONS => {
			"our hash_ref \$properties" => -54,
			"use constant" => -54,
			"use" => -54,
			"## no critic qw(" => 9
		},
		GOTOS => {
			'Critic' => 71,
			'STAR-21' => 70
		}
	},
	{#State 62
		ACTIONS => {
			"= sub {" => 72
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
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			'WORD' => 75,
			")" => 76
		}
	},
	{#State 67
		DEFAULT => -33
	},
	{#State 68
		ACTIONS => {
			'LBRACE' => 112,
			"my" => 110,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED_VOID' => 100,
			"if (" => 99,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 107,
			"our" => 41,
			'OP01_PRINT' => 103,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 101,
			'OP10_STRINGIFY_UNARY' => 105,
			"for my integer" => -141,
			'OP05_LOGICAL_NEG' => 86,
			"while (" => -141,
			'OP19_LOOP_CONTROL' => 87,
			'OP05_MATH_NEG_LPAREN' => 93,
			"foreach my" => -141,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			"undef" => 84,
			'OP01_NAMED_VOID_SCOLON' => 85,
			"\@{" => 81,
			'OP01_CLOSE' => 82
		},
		GOTOS => {
			'Subroutine' => 104,
			'VariableModification' => 80,
			'ArrayReference' => 106,
			'VariableDeclaration' => 83,
			'HashDereferenced' => 108,
			'Expression' => 96,
			'Operation' => 98,
			'WordScoped' => 78,
			'Literal' => 113,
			'OPTIONAL-35' => 88,
			'PAREN-34' => 117,
			'PLUS-8' => 118,
			'HashReference' => 116,
			'Statement' => 121,
			'LoopLabel' => 91,
			'Conditional' => 92,
			'Operator' => 120,
			'SubExpression' => 122,
			'OperatorVoid' => 123,
			'ArrayDereferenced' => 111,
			'Variable' => 109
		}
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			"use" => 34,
			"our hash_ref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 126,
			'Include' => 125
		}
	},
	{#State 71
		DEFAULT => -51
	},
	{#State 72
		ACTIONS => {
			'LBRACE' => -43,
			"( my" => 128,
			"my" => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP10_NAMED_UNARY' => -43,
			"%{" => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED_VOID' => -43,
			"if (" => -43,
			'LPAREN' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP01_NAMED' => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			'OP01_PRINT' => -43,
			'CONSTANT_SYMBOL' => -43,
			'WORD' => -43,
			"for my integer" => -43,
			"while (" => -43,
			'OP19_LOOP_CONTROL' => -43,
			'OP05_LOGICAL_NEG' => -43,
			"foreach my" => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'LITERAL_NUMBER' => -43,
			'OP01_OPEN' => -43,
			'LBRACKET' => -43,
			'WORD_SCOPED' => -43,
			'LITERAL_STRING' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			"undef" => -43,
			'OP01_CLOSE' => -43,
			"\@{" => -43
		},
		GOTOS => {
			'SubroutineArguments' => 127,
			'OPTIONAL-16' => 129
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 90
		},
		GOTOS => {
			'Literal' => 130
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 131
		}
	},
	{#State 75
		DEFAULT => -37
	},
	{#State 76
		ACTIONS => {
			";" => 132
		}
	},
	{#State 77
		DEFAULT => -208
	},
	{#State 78
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 134,
			'LPAREN' => 133
		}
	},
	{#State 79
		ACTIONS => {
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			"]" => -184,
			'LBRACKET' => 79,
			'OP01_QW' => 141,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_LOGICAL_NEG' => 86,
			'KEYS_OR_VALUES' => 143,
			"my" => 144,
			'LBRACE' => 112
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'ListElements' => 136,
			'Expression' => 140,
			'TypeInner' => 137,
			'WordScoped' => 78,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'ListElement' => 138,
			'Literal' => 113,
			'HashDereferenced' => 108,
			'SubExpression' => 142,
			'OPTIONAL-45' => 135,
			'Operator' => 120
		}
	},
	{#State 80
		DEFAULT => -146
	},
	{#State 81
		ACTIONS => {
			'LBRACKET' => 79,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 146,
			'ArrayReference' => 147
		}
	},
	{#State 82
		ACTIONS => {
			'FH_REF_SYMBOL' => 148
		}
	},
	{#State 83
		DEFAULT => -145
	},
	{#State 84
		DEFAULT => -128
	},
	{#State 85
		DEFAULT => -113
	},
	{#State 86
		ACTIONS => {
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112
		},
		GOTOS => {
			'WordScoped' => 78,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'HashDereferenced' => 108,
			'SubExpression' => 149,
			'Operator' => 120,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113
		}
	},
	{#State 87
		ACTIONS => {
			'WORD' => 151
		},
		GOTOS => {
			'LoopLabel' => 150
		}
	},
	{#State 88
		ACTIONS => {
			"foreach my" => 157,
			"for my integer" => 155,
			"while (" => 156
		},
		GOTOS => {
			'LoopForEach' => 152,
			'LoopWhile' => 154,
			'Loop' => 153,
			'LoopFor' => 158
		}
	},
	{#State 89
		ACTIONS => {
			"my" => 159
		}
	},
	{#State 90
		DEFAULT => -209
	},
	{#State 91
		ACTIONS => {
			'COLON' => 160
		}
	},
	{#State 92
		DEFAULT => -142
	},
	{#State 93
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP01_OPEN' => 89,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90
		},
		GOTOS => {
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'WordScoped' => 78,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'SubExpression' => 161,
			'HashDereferenced' => 108,
			'Operator' => 120
		}
	},
	{#State 94
		DEFAULT => -116
	},
	{#State 95
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 162
		}
	},
	{#State 96
		ACTIONS => {
			'OP07_STRING_REPEAT' => -127,
			'OP13_BITWISE_AND' => -127,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP15_LOGICAL_AND' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP16_LOGICAL_OR' => -127,
			'OP09_BITWISE_SHIFT' => -127,
			";" => 163,
			'OP17_LIST_RANGE' => -127,
			'OP18_TERNARY' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP12_COMPARE_EQ_NE' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP04_MATH_POW' => -127,
			'OP08_STRING_CAT' => -127
		}
	},
	{#State 97
		ACTIONS => {
			"undef" => 84,
			'OP01_NAMED' => 165,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'OP01_PRINT' => 164,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'Expression' => 140,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'WordScoped' => 78,
			'Literal' => 113,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 166
		}
	},
	{#State 98
		DEFAULT => -17
	},
	{#State 99
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"undef" => 84,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'WordScoped' => 78,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Expression' => 140,
			'HashDereferenced' => 108,
			'SubExpression' => 167,
			'Operator' => 120,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Literal' => 113
		}
	},
	{#State 100
		ACTIONS => {
			"my" => 144,
			'KEYS_OR_VALUES' => 143,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 79,
			'OP01_QW' => 141,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'OP01_NAMED' => 139,
			"undef" => 84
		},
		GOTOS => {
			'WordScoped' => 78,
			'TypeInner' => 137,
			'Expression' => 140,
			'ListElements' => 168,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 142,
			'Literal' => 113,
			'HashReference' => 116,
			'ListElement' => 138,
			'ArrayReference' => 106
		}
	},
	{#State 101
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -200,
			'LPAREN' => -200,
			'COLON' => -202
		}
	},
	{#State 102
		ACTIONS => {
			'LPAREN' => 169
		}
	},
	{#State 103
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -110,
			'OP05_MATH_NEG_LPAREN' => -110,
			'OP10_NAMED_UNARY' => -110,
			'FH_REF_SYMBOL_BRACES' => 170,
			'VARIABLE_SYMBOL' => -110,
			'LITERAL_NUMBER' => -110,
			"%{" => -110,
			'OP01_OPEN' => -110,
			'LBRACE' => -110,
			"my" => -110,
			'KEYS_OR_VALUES' => -110,
			'OP05_LOGICAL_NEG' => -110,
			'OP01_NAMED' => -110,
			"undef" => -110,
			'OP01_CLOSE' => -110,
			'STDOUT_STDERR' => 172,
			'OP10_STRINGIFY_UNARY' => -110,
			'CONSTANT_SYMBOL' => -110,
			"\@{" => -110,
			'WORD' => -110,
			'OP01_QW' => -110,
			'LBRACKET' => -110,
			'WORD_SCOPED' => -110,
			'LITERAL_STRING' => -110,
			'LPAREN' => -110,
			'OP03_MATH_INC_DEC' => -110
		},
		GOTOS => {
			'OPTIONAL-31' => 173,
			'PAREN-30' => 171
		}
	},
	{#State 104
		DEFAULT => -14
	},
	{#State 105
		ACTIONS => {
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP01_OPEN' => 89,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112
		},
		GOTOS => {
			'HashDereferenced' => 108,
			'SubExpression' => 174,
			'Operator' => 120,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Literal' => 113,
			'WordScoped' => 78,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Expression' => 140
		}
	},
	{#State 106
		DEFAULT => -131
	},
	{#State 107
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'OP05_LOGICAL_NEG' => 86,
			'KEYS_OR_VALUES' => 143,
			"my" => 144,
			'LBRACE' => 112,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124
		},
		GOTOS => {
			'ListElement' => 176,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'SubExpression' => 175,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'WordScoped' => 78,
			'TypeInner' => 137
		}
	},
	{#State 108
		DEFAULT => -134
	},
	{#State 109
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP19_VARIABLE_ASSIGN' => 177,
			'OP18_TERNARY' => -130,
			'OP04_MATH_POW' => -130,
			'OP08_STRING_CAT' => -130,
			'OP02_METHOD_THINARROW' => 178,
			'OP03_MATH_INC_DEC' => 179,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP19_VARIABLE_ASSIGN_BY' => 180,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP07_STRING_REPEAT' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP23_LOGICAL_AND' => -130,
			'OP11_COMPARE_LT_GT' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP16_LOGICAL_OR' => -130
		}
	},
	{#State 110
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 181
		}
	},
	{#State 111
		DEFAULT => -132
	},
	{#State 112
		ACTIONS => {
			"}" => 184,
			'WORD' => 183,
			"%{" => 114
		},
		GOTOS => {
			'HashDereferenced' => 182,
			'HashEntry' => 185
		}
	},
	{#State 113
		DEFAULT => -129
	},
	{#State 114
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 188
		},
		GOTOS => {
			'Variable' => 187,
			'HashReference' => 186
		}
	},
	{#State 115
		DEFAULT => -164,
		GOTOS => {
			'STAR-41' => 189
		}
	},
	{#State 116
		DEFAULT => -133
	},
	{#State 117
		DEFAULT => -140
	},
	{#State 118
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 105,
			'WORD' => 101,
			'CONSTANT_SYMBOL' => 102,
			'OP01_PRINT' => 103,
			'OP01_NAMED' => 107,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			"if (" => 99,
			'OP01_NAMED_VOID' => 100,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			"my" => 110,
			'LBRACE' => 112,
			'OP01_CLOSE' => 82,
			"\@{" => 81,
			'OP01_NAMED_VOID_SCOLON' => 85,
			"undef" => 84,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			"foreach my" => -141,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP19_LOOP_CONTROL' => 87,
			'' => -18,
			"while (" => -141,
			'OP05_LOGICAL_NEG' => 86,
			"for my integer" => -141
		},
		GOTOS => {
			'VariableDeclaration' => 83,
			'HashDereferenced' => 108,
			'VariableModification' => 80,
			'ArrayReference' => 106,
			'WordScoped' => 78,
			'Expression' => 96,
			'Operation' => 190,
			'Operator' => 120,
			'Statement' => 121,
			'Conditional' => 92,
			'LoopLabel' => 91,
			'OperatorVoid' => 123,
			'SubExpression' => 122,
			'OPTIONAL-35' => 88,
			'Literal' => 113,
			'HashReference' => 116,
			'PAREN-34' => 117,
			'Variable' => 109,
			'ArrayDereferenced' => 111
		}
	},
	{#State 119
		ACTIONS => {
			"undef" => 84,
			'OP01_CLOSE' => 82,
			"\@{" => 81,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			"]" => -95,
			'LITERAL_STRING' => 77,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP07_STRING_REPEAT' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP05_MATH_NEG_LPAREN' => 93,
			")" => -95,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'OP05_LOGICAL_NEG' => 86,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP01_NAMED' => 139,
			'OP08_MATH_ADD_SUB' => -95,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			'OP18_TERNARY' => -95,
			'WORD' => 22,
			'OP08_STRING_CAT' => -95,
			"}" => -95,
			'OP04_MATH_POW' => -95,
			'OP06_REGEX_MATCH' => -95,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP23_LOGICAL_AND' => -95,
			'OP22_LOGICAL_NEG' => 124,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP10_NAMED_UNARY' => 119,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP21_LIST_COMMA' => -95,
			'OP17_LIST_RANGE' => -95,
			'LBRACE' => 112,
			'OP16_LOGICAL_OR' => -95,
			";" => -95,
			'OP09_BITWISE_SHIFT' => -95
		},
		GOTOS => {
			'SubExpression' => 191,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Literal' => 113,
			'WordScoped' => 78,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Expression' => 140
		}
	},
	{#State 120
		DEFAULT => -122
	},
	{#State 121
		DEFAULT => -77
	},
	{#State 122
		ACTIONS => {
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			'OP07_STRING_REPEAT' => 192,
			'OP15_LOGICAL_AND' => 194,
			'OP23_LOGICAL_AND' => 199,
			'OP11_COMPARE_LT_GT' => 195,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207,
			'OP18_TERNARY' => 205,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203
		}
	},
	{#State 123
		DEFAULT => -144
	},
	{#State 124
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP01_OPEN' => 89,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112
		},
		GOTOS => {
			'WordScoped' => 78,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'SubExpression' => 209,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113
		}
	},
	{#State 125
		DEFAULT => -53
	},
	{#State 126
		ACTIONS => {
			"use constant" => 44,
			"our hash_ref \$properties" => 210
		},
		GOTOS => {
			'Constant' => 212,
			'Properties' => 211
		}
	},
	{#State 127
		DEFAULT => -42
	},
	{#State 128
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 213
		}
	},
	{#State 129
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 87,
			"while (" => -141,
			'OP05_LOGICAL_NEG' => 86,
			"for my integer" => -141,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			"foreach my" => -141,
			'OP05_MATH_NEG_LPAREN' => 93,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP01_CLOSE' => 82,
			"\@{" => 81,
			'OP01_NAMED_VOID_SCOLON' => 85,
			"undef" => 84,
			"my" => 110,
			'LBRACE' => 112,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			"if (" => 99,
			'OP01_NAMED_VOID' => 100,
			'OP10_STRINGIFY_UNARY' => 105,
			'WORD' => 101,
			'OP01_PRINT' => 103,
			'CONSTANT_SYMBOL' => 102,
			'OP01_NAMED' => 107
		},
		GOTOS => {
			'HashDereferenced' => 108,
			'VariableDeclaration' => 83,
			'ArrayReference' => 106,
			'VariableModification' => 80,
			'WordScoped' => 78,
			'PLUS-17' => 214,
			'Operation' => 215,
			'Expression' => 96,
			'OperatorVoid' => 123,
			'SubExpression' => 122,
			'Operator' => 120,
			'Statement' => 121,
			'LoopLabel' => 91,
			'Conditional' => 92,
			'HashReference' => 116,
			'PAREN-34' => 117,
			'Literal' => 113,
			'OPTIONAL-35' => 88,
			'Variable' => 109,
			'ArrayDereferenced' => 111
		}
	},
	{#State 130
		ACTIONS => {
			";" => 216
		}
	},
	{#State 131
		ACTIONS => {
			"\$TYPED_" => 217
		}
	},
	{#State 132
		DEFAULT => -40
	},
	{#State 133
		ACTIONS => {
			"my" => 144,
			'OP05_LOGICAL_NEG' => 86,
			'KEYS_OR_VALUES' => 143,
			'LBRACE' => 112,
			'OP01_OPEN' => 89,
			")" => -119,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP01_QW' => 141,
			'LITERAL_STRING' => 77,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP01_NAMED' => 139,
			"undef" => 84
		},
		GOTOS => {
			'Literal' => 113,
			'OPTIONAL-32' => 219,
			'HashReference' => 116,
			'ListElement' => 138,
			'ArrayReference' => 106,
			'Operator' => 120,
			'SubExpression' => 142,
			'HashDereferenced' => 108,
			'Expression' => 140,
			'ListElements' => 218,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'WordScoped' => 78,
			'TypeInner' => 137
		}
	},
	{#State 134
		ACTIONS => {
			")" => 220
		}
	},
	{#State 135
		ACTIONS => {
			"]" => 221
		}
	},
	{#State 136
		DEFAULT => -183
	},
	{#State 137
		ACTIONS => {
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP01_OPEN' => 89,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81
		},
		GOTOS => {
			'Operator' => 120,
			'SubExpression' => 222,
			'HashDereferenced' => 108,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'WordScoped' => 78,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145
		}
	},
	{#State 138
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 223
		}
	},
	{#State 139
		ACTIONS => {
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP01_OPEN' => 89,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82
		},
		GOTOS => {
			'WordScoped' => 78,
			'Expression' => 140,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Operator' => 120,
			'SubExpression' => 224,
			'HashDereferenced' => 108,
			'Literal' => 113,
			'HashReference' => 116,
			'ArrayReference' => 106
		}
	},
	{#State 140
		DEFAULT => -127
	},
	{#State 141
		ACTIONS => {
			'WORD' => 225
		},
		GOTOS => {
			'PLUS-44' => 226
		}
	},
	{#State 142
		ACTIONS => {
			'OP17_LIST_RANGE' => 200,
			'OP09_BITWISE_SHIFT' => 201,
			";" => -180,
			'OP16_LOGICAL_OR' => 202,
			'OP11_COMPARE_LT_GT' => 195,
			'OP23_LOGICAL_AND' => 199,
			'OP15_LOGICAL_AND' => 194,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP21_LIST_COMMA' => -180,
			")" => -180,
			'OP08_STRING_CAT' => 207,
			"]" => -180,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => 205
		}
	},
	{#State 143
		ACTIONS => {
			"%{" => 114
		},
		GOTOS => {
			'HashDereferenced' => 227
		}
	},
	{#State 144
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 228
		}
	},
	{#State 145
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -130,
			'OP23_LOGICAL_AND' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP07_STRING_REPEAT' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			")" => -130,
			'OP21_LIST_COMMA' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP16_LOGICAL_OR' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			";" => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			'OP18_TERNARY' => -130,
			"]" => -130,
			'OP08_STRING_CAT' => -130,
			'OP04_MATH_POW' => -130,
			"}" => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP02_METHOD_THINARROW' => 178,
			'OP03_MATH_INC_DEC' => 179
		}
	},
	{#State 146
		ACTIONS => {
			"}" => 229
		}
	},
	{#State 147
		ACTIONS => {
			"}" => 230
		}
	},
	{#State 148
		DEFAULT => -82
	},
	{#State 149
		ACTIONS => {
			"]" => -86,
			'OP08_STRING_CAT' => -86,
			'OP04_MATH_POW' => 206,
			"}" => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			'OP18_TERNARY' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			";" => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP21_LIST_COMMA' => -86,
			")" => -86
		}
	},
	{#State 150
		ACTIONS => {
			";" => 231
		}
	},
	{#State 151
		DEFAULT => -202
	},
	{#State 152
		DEFAULT => -155
	},
	{#State 153
		DEFAULT => -143
	},
	{#State 154
		DEFAULT => -156
	},
	{#State 155
		ACTIONS => {
			'VARIABLE_SYMBOL' => 232
		}
	},
	{#State 156
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 89,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'OP01_NAMED' => 139,
			"undef" => 84
		},
		GOTOS => {
			'HashDereferenced' => 108,
			'SubExpression' => 233,
			'Operator' => 120,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'WordScoped' => 78,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140
		}
	},
	{#State 157
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 234
		}
	},
	{#State 158
		DEFAULT => -154
	},
	{#State 159
		ACTIONS => {
			"filehandle_ref" => 235
		}
	},
	{#State 160
		DEFAULT => -139
	},
	{#State 161
		ACTIONS => {
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207,
			'OP18_TERNARY' => 205,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			'OP17_LIST_RANGE' => 200,
			")" => 236,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP23_LOGICAL_AND' => 199,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194
		}
	},
	{#State 162
		DEFAULT => -83
	},
	{#State 163
		DEFAULT => -76
	},
	{#State 164
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 237
		}
	},
	{#State 165
		ACTIONS => {
			"undef" => 84,
			'OP01_NAMED' => 139,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'KEYS_OR_VALUES' => 143,
			'OP05_LOGICAL_NEG' => 86,
			"my" => 144
		},
		GOTOS => {
			'ArrayReference' => 106,
			'HashReference' => 116,
			'ListElement' => 238,
			'Literal' => 113,
			'HashDereferenced' => 108,
			'SubExpression' => 175,
			'Operator' => 120,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Expression' => 140,
			'TypeInner' => 137,
			'WordScoped' => 78
		}
	},
	{#State 166
		ACTIONS => {
			")" => 239,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP23_LOGICAL_AND' => 199,
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP18_TERNARY' => 205,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207
		}
	},
	{#State 167
		ACTIONS => {
			'OP17_LIST_RANGE' => 200,
			'OP09_BITWISE_SHIFT' => 201,
			'OP16_LOGICAL_OR' => 202,
			'OP13_BITWISE_AND' => 193,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			'OP23_LOGICAL_AND' => 199,
			")" => 240,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP18_TERNARY' => 205
		}
	},
	{#State 168
		ACTIONS => {
			";" => 241
		}
	},
	{#State 169
		ACTIONS => {
			")" => 242
		}
	},
	{#State 170
		ACTIONS => {
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LITERAL_STRING' => 77,
			'OP01_QW' => 141,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'KEYS_OR_VALUES' => 143,
			'OP05_LOGICAL_NEG' => 86,
			"my" => 144,
			'LBRACE' => 112,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124
		},
		GOTOS => {
			'Literal' => 113,
			'HashReference' => 116,
			'ListElement' => 138,
			'ArrayReference' => 106,
			'Operator' => 120,
			'SubExpression' => 142,
			'HashDereferenced' => 108,
			'Expression' => 140,
			'ListElements' => 243,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'WordScoped' => 78,
			'TypeInner' => 137
		}
	},
	{#State 171
		DEFAULT => -109
	},
	{#State 172
		DEFAULT => -108
	},
	{#State 173
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'KEYS_OR_VALUES' => 143,
			'OP05_LOGICAL_NEG' => 86,
			"my" => 144,
			"undef" => 84,
			'OP01_NAMED' => 139,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'OP01_QW' => 141,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95
		},
		GOTOS => {
			'HashReference' => 116,
			'ListElement' => 138,
			'ArrayReference' => 106,
			'Literal' => 113,
			'SubExpression' => 142,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'Variable' => 145,
			'ListElements' => 244,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'WordScoped' => 78,
			'TypeInner' => 137
		}
	},
	{#State 174
		ACTIONS => {
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			'OP17_LIST_RANGE' => 200,
			")" => 245,
			'OP23_LOGICAL_AND' => 199,
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP13_BITWISE_AND' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP08_STRING_CAT' => 207,
			'OP04_MATH_POW' => 206,
			'OP18_TERNARY' => 205,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204
		}
	},
	{#State 175
		ACTIONS => {
			")" => -79,
			'OP21_LIST_COMMA' => -180,
			'OP23_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			";" => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP18_TERNARY' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP08_STRING_CAT' => -79,
			'OP04_MATH_POW' => -79
		}
	},
	{#State 176
		ACTIONS => {
			'OP21_LIST_COMMA' => 246
		}
	},
	{#State 177
		ACTIONS => {
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP01_OPEN' => 89,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'STDIN' => 249,
			"%{" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97
		},
		GOTOS => {
			'HashDereferenced' => 108,
			'SubExpression' => 248,
			'Operator' => 120,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'SubExpressionOrStdin' => 247,
			'WordScoped' => 78,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140
		}
	},
	{#State 178
		ACTIONS => {
			'LPAREN' => 250
		}
	},
	{#State 179
		DEFAULT => -84
	},
	{#State 180
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95
		},
		GOTOS => {
			'Operator' => 120,
			'SubExpression' => 251,
			'HashDereferenced' => 108,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'WordScoped' => 78,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145
		}
	},
	{#State 181
		ACTIONS => {
			'VARIABLE_SYMBOL' => 252
		}
	},
	{#State 182
		DEFAULT => -191
	},
	{#State 183
		ACTIONS => {
			'OP20_HASH_FATARROW' => 253
		}
	},
	{#State 184
		DEFAULT => -135
	},
	{#State 185
		DEFAULT => -196,
		GOTOS => {
			'STAR-48' => 254
		}
	},
	{#State 186
		ACTIONS => {
			"}" => 255
		}
	},
	{#State 187
		ACTIONS => {
			"}" => 256
		}
	},
	{#State 188
		ACTIONS => {
			'WORD' => 183,
			"%{" => 114
		},
		GOTOS => {
			'HashDereferenced' => 182,
			'HashEntry' => 185
		}
	},
	{#State 189
		ACTIONS => {
			'OP07_STRING_REPEAT' => -165,
			'OP13_BITWISE_AND' => -165,
			'OP07_MATH_MULT_DIV_MOD' => -165,
			'OP23_LOGICAL_AND' => -165,
			'OP11_COMPARE_LT_GT' => -165,
			'OP15_LOGICAL_AND' => -165,
			'OP21_LIST_COMMA' => -165,
			")" => -165,
			'OP17_LIST_RANGE' => -165,
			";" => -165,
			'OP09_BITWISE_SHIFT' => -165,
			'OP16_LOGICAL_OR' => -165,
			'OP02_HASH_THINARROW' => 258,
			'OP02_ARRAY_THINARROW' => 259,
			'COLON' => -165,
			'OP08_MATH_ADD_SUB' => -165,
			'OP14_BITWISE_OR_XOR' => -165,
			'OP18_TERNARY' => -165,
			'OP19_VARIABLE_ASSIGN' => -165,
			'OP04_MATH_POW' => -165,
			"}" => -165,
			"]" => -165,
			'OP08_STRING_CAT' => -165,
			'OP02_METHOD_THINARROW' => -165,
			'OP03_MATH_INC_DEC' => -165,
			'OP06_REGEX_MATCH' => -165,
			'OP12_COMPARE_EQ_NE' => -165,
			'OP19_VARIABLE_ASSIGN_BY' => -165,
			'OP24_LOGICAL_OR_XOR' => -165
		},
		GOTOS => {
			'VariableRetrieval' => 257
		}
	},
	{#State 190
		DEFAULT => -16
	},
	{#State 191
		ACTIONS => {
			'OP18_TERNARY' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 203,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP06_REGEX_MATCH' => 208,
			'OP24_LOGICAL_OR_XOR' => -94,
			"}" => -94,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207,
			"]" => -94,
			'OP21_LIST_COMMA' => -94,
			")" => -94,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP09_BITWISE_SHIFT' => 201,
			";" => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP17_LIST_RANGE' => -94
		}
	},
	{#State 192
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Literal' => 113,
			'HashDereferenced' => 108,
			'SubExpression' => 260,
			'Operator' => 120,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Expression' => 140,
			'WordScoped' => 78
		}
	},
	{#State 193
		ACTIONS => {
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP01_OPEN' => 89,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97
		},
		GOTOS => {
			'WordScoped' => 78,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'HashDereferenced' => 108,
			'SubExpression' => 261,
			'Operator' => 120,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113
		}
	},
	{#State 194
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP01_OPEN' => 89,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			"%{" => 114
		},
		GOTOS => {
			'WordScoped' => 78,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 262,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116
		}
	},
	{#State 195
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 84,
			'OP01_NAMED' => 139,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP01_OPEN' => 89
		},
		GOTOS => {
			'WordScoped' => 78,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'SubExpression' => 263,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113
		}
	},
	{#State 196
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'OP01_OPEN' => 89,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_NAMED' => 139,
			"undef" => 84
		},
		GOTOS => {
			'Literal' => 113,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 264,
			'Expression' => 140,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'WordScoped' => 78
		}
	},
	{#State 197
		ACTIONS => {
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'Literal' => 113,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 265,
			'Expression' => 140,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'WordScoped' => 78
		}
	},
	{#State 198
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			"undef" => 84,
			'OP01_NAMED' => 139,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95
		},
		GOTOS => {
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'WordScoped' => 78,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Operator' => 120,
			'SubExpression' => 266,
			'HashDereferenced' => 108
		}
	},
	{#State 199
		ACTIONS => {
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79
		},
		GOTOS => {
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 267,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'WordScoped' => 78
		}
	},
	{#State 200
		ACTIONS => {
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'WordScoped' => 78,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Operator' => 120,
			'SubExpression' => 268,
			'HashDereferenced' => 108
		}
	},
	{#State 201
		ACTIONS => {
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'HashDereferenced' => 108,
			'SubExpression' => 269,
			'Operator' => 120,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'WordScoped' => 78
		}
	},
	{#State 202
		ACTIONS => {
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89
		},
		GOTOS => {
			'Literal' => 113,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 270,
			'Expression' => 140,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'WordScoped' => 78
		}
	},
	{#State 203
		ACTIONS => {
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP01_OPEN' => 89,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Expression' => 140,
			'WordScoped' => 78,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Literal' => 113,
			'SubExpression' => 271,
			'HashDereferenced' => 108,
			'Operator' => 120
		}
	},
	{#State 204
		ACTIONS => {
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP01_OPEN' => 89,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90
		},
		GOTOS => {
			'Operator' => 120,
			'SubExpression' => 272,
			'HashDereferenced' => 108,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'WordScoped' => 78,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145
		}
	},
	{#State 205
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Literal' => 274,
			'Variable' => 273,
			'VariableOrLiteral' => 275
		}
	},
	{#State 206
		ACTIONS => {
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82
		},
		GOTOS => {
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 276,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'WordScoped' => 78,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145
		}
	},
	{#State 207
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112
		},
		GOTOS => {
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'SubExpression' => 277,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'WordScoped' => 78
		}
	},
	{#State 208
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 278
		}
	},
	{#State 209
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			'OP07_STRING_REPEAT' => 192,
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP23_LOGICAL_AND' => -105,
			")" => -105,
			'OP21_LIST_COMMA' => -105,
			'OP17_LIST_RANGE' => 200,
			'OP16_LOGICAL_OR' => 202,
			";" => -105,
			'OP09_BITWISE_SHIFT' => 201,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP18_TERNARY' => 205,
			'OP04_MATH_POW' => 206,
			"}" => -105,
			"]" => -105,
			'OP08_STRING_CAT' => 207,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP24_LOGICAL_OR_XOR' => -105
		}
	},
	{#State 210
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 279
		}
	},
	{#State 211
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 280
		}
	},
	{#State 212
		DEFAULT => -55
	},
	{#State 213
		ACTIONS => {
			'VARIABLE_SYMBOL' => 281
		}
	},
	{#State 214
		ACTIONS => {
			"for my integer" => -141,
			'OP19_LOOP_CONTROL' => 87,
			"while (" => -141,
			'OP05_LOGICAL_NEG' => 86,
			"foreach my" => -141,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			'OP05_MATH_NEG_LPAREN' => 93,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'OP01_NAMED_VOID_SCOLON' => 85,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			"\@{" => 81,
			'LBRACE' => 112,
			"my" => 110,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP01_NAMED_VOID' => 100,
			"}" => 282,
			"if (" => 99,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 107,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			'OP01_PRINT' => 103,
			'WORD' => 101
		},
		GOTOS => {
			'WordScoped' => 78,
			'Operation' => 283,
			'Expression' => 96,
			'VariableDeclaration' => 83,
			'HashDereferenced' => 108,
			'VariableModification' => 80,
			'ArrayReference' => 106,
			'Variable' => 109,
			'ArrayDereferenced' => 111,
			'Operator' => 120,
			'Statement' => 121,
			'LoopLabel' => 91,
			'Conditional' => 92,
			'OperatorVoid' => 123,
			'SubExpression' => 122,
			'Literal' => 113,
			'OPTIONAL-35' => 88,
			'HashReference' => 116,
			'PAREN-34' => 117
		}
	},
	{#State 215
		DEFAULT => -45
	},
	{#State 216
		DEFAULT => -41
	},
	{#State 217
		ACTIONS => {
			'CONSTANT_SYMBOL' => 284
		}
	},
	{#State 218
		DEFAULT => -118
	},
	{#State 219
		ACTIONS => {
			")" => 285
		}
	},
	{#State 220
		DEFAULT => -126
	},
	{#State 221
		DEFAULT => -185
	},
	{#State 222
		ACTIONS => {
			'OP17_LIST_RANGE' => 200,
			'OP09_BITWISE_SHIFT' => 201,
			";" => -181,
			'OP16_LOGICAL_OR' => 202,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			'OP23_LOGICAL_AND' => 199,
			'OP13_BITWISE_AND' => 193,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP21_LIST_COMMA' => -181,
			")" => -181,
			"]" => -181,
			'OP08_STRING_CAT' => 207,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP18_TERNARY' => 205
		}
	},
	{#State 223
		ACTIONS => {
			";" => -178,
			'OP21_LIST_COMMA' => 287,
			")" => -178,
			"]" => -178
		},
		GOTOS => {
			'PAREN-42' => 286
		}
	},
	{#State 224
		ACTIONS => {
			'OP15_LOGICAL_AND' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP21_LIST_COMMA' => -79,
			")" => -79,
			'OP17_LIST_RANGE' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			";" => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP18_TERNARY' => -79,
			'OP08_STRING_CAT' => -79,
			"]" => -79,
			"}" => -79,
			'OP04_MATH_POW' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP12_COMPARE_EQ_NE' => -79
		}
	},
	{#State 225
		DEFAULT => -177
	},
	{#State 226
		ACTIONS => {
			'WORD' => 288,
			")" => 289
		}
	},
	{#State 227
		DEFAULT => -182
	},
	{#State 228
		ACTIONS => {
			"\$TYPED_" => 290
		}
	},
	{#State 229
		DEFAULT => -186
	},
	{#State 230
		DEFAULT => -187
	},
	{#State 231
		DEFAULT => -117
	},
	{#State 232
		ACTIONS => {
			'LPAREN' => 291
		}
	},
	{#State 233
		ACTIONS => {
			'OP17_LIST_RANGE' => 200,
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			'OP23_LOGICAL_AND' => 199,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			")" => 292,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => 205
		}
	},
	{#State 234
		ACTIONS => {
			'VARIABLE_SYMBOL' => 293
		}
	},
	{#State 235
		ACTIONS => {
			'FH_REF_SYMBOL' => 294
		}
	},
	{#State 236
		DEFAULT => -87
	},
	{#State 237
		ACTIONS => {
			'LBRACE' => 112,
			'KEYS_OR_VALUES' => 143,
			'OP05_LOGICAL_NEG' => 86,
			"my" => 144,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'LITERAL_STRING' => 77,
			'OP01_QW' => 141,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105
		},
		GOTOS => {
			'TypeInner' => 137,
			'WordScoped' => 78,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'ListElements' => 295,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 142,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'ListElement' => 138
		}
	},
	{#State 238
		ACTIONS => {
			'OP21_LIST_COMMA' => 296
		}
	},
	{#State 239
		DEFAULT => -136
	},
	{#State 240
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 297
		}
	},
	{#State 241
		DEFAULT => -114
	},
	{#State 242
		DEFAULT => -124
	},
	{#State 243
		ACTIONS => {
			";" => 299
		}
	},
	{#State 244
		ACTIONS => {
			";" => 300
		}
	},
	{#State 245
		DEFAULT => -96
	},
	{#State 246
		ACTIONS => {
			'OP01_OPEN' => 89,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_LOGICAL_NEG' => 86,
			'KEYS_OR_VALUES' => 143,
			"my" => 144,
			'LBRACE' => 112,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 141,
			'LBRACKET' => 79
		},
		GOTOS => {
			'TypeInner' => 137,
			'WordScoped' => 78,
			'ArrayDereferenced' => 111,
			'ListElements' => 301,
			'Variable' => 145,
			'Expression' => 140,
			'HashDereferenced' => 108,
			'SubExpression' => 142,
			'Operator' => 120,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'ListElement' => 138,
			'Literal' => 113
		}
	},
	{#State 247
		ACTIONS => {
			";" => 302
		}
	},
	{#State 248
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP08_STRING_CAT' => 207,
			'OP04_MATH_POW' => 206,
			'OP18_TERNARY' => 205,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			";" => -137,
			'OP09_BITWISE_SHIFT' => 201,
			'OP16_LOGICAL_OR' => 202,
			'OP17_LIST_RANGE' => 200,
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP23_LOGICAL_AND' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193
		}
	},
	{#State 249
		DEFAULT => -138
	},
	{#State 250
		ACTIONS => {
			"my" => 144,
			'KEYS_OR_VALUES' => 143,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			")" => -121,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 79,
			'OP01_QW' => 141,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_NAMED' => 139,
			"undef" => 84
		},
		GOTOS => {
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'ListElements' => 304,
			'TypeInner' => 137,
			'WordScoped' => 78,
			'Literal' => 113,
			'ArrayReference' => 106,
			'ListElement' => 138,
			'HashReference' => 116,
			'OPTIONAL-33' => 303,
			'Operator' => 120,
			'SubExpression' => 142,
			'HashDereferenced' => 108
		}
	},
	{#State 251
		ACTIONS => {
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			";" => 305,
			'OP17_LIST_RANGE' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			'OP23_LOGICAL_AND' => 199,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207,
			'OP18_TERNARY' => 205,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203
		}
	},
	{#State 252
		ACTIONS => {
			";" => 306,
			'OP19_VARIABLE_ASSIGN' => 307
		}
	},
	{#State 253
		ACTIONS => {
			'LBRACE' => -189,
			"my" => 144,
			'OP05_LOGICAL_NEG' => -189,
			'OP22_LOGICAL_NEG' => -189,
			'OP05_MATH_NEG_LPAREN' => -189,
			'OP10_NAMED_UNARY' => -189,
			'VARIABLE_SYMBOL' => -189,
			'LITERAL_NUMBER' => -189,
			"%{" => -189,
			'OP01_OPEN' => -189,
			'LBRACKET' => -189,
			'WORD_SCOPED' => -189,
			'LITERAL_STRING' => -189,
			'LPAREN' => -189,
			'OP03_MATH_INC_DEC' => -189,
			'OP01_NAMED' => -189,
			"undef" => -189,
			'OP01_CLOSE' => -189,
			'OP10_STRINGIFY_UNARY' => -189,
			"\@{" => -189,
			'CONSTANT_SYMBOL' => -189,
			'WORD' => -189
		},
		GOTOS => {
			'OPTIONAL-46' => 309,
			'TypeInner' => 308
		}
	},
	{#State 254
		ACTIONS => {
			"}" => 311,
			'OP21_LIST_COMMA' => 310
		},
		GOTOS => {
			'PAREN-47' => 312
		}
	},
	{#State 255
		DEFAULT => -199
	},
	{#State 256
		DEFAULT => -198
	},
	{#State 257
		DEFAULT => -163
	},
	{#State 258
		ACTIONS => {
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'WORD' => 313,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Expression' => 140,
			'WordScoped' => 78,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Literal' => 113,
			'HashDereferenced' => 108,
			'SubExpression' => 314,
			'Operator' => 120
		}
	},
	{#State 259
		ACTIONS => {
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP01_OPEN' => 89,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81
		},
		GOTOS => {
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'SubExpression' => 315,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'WordScoped' => 78
		}
	},
	{#State 260
		ACTIONS => {
			'OP21_LIST_COMMA' => -89,
			")" => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			";" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP18_TERNARY' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			"}" => -89,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => -89,
			"]" => -89
		}
	},
	{#State 261
		ACTIONS => {
			'OP23_LOGICAL_AND' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => -99,
			'OP07_STRING_REPEAT' => 192,
			")" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP09_BITWISE_SHIFT' => 201,
			";" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => -99,
			'OP08_STRING_CAT' => 207,
			"]" => -99,
			'OP04_MATH_POW' => 206,
			"}" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196
		}
	},
	{#State 262
		ACTIONS => {
			'OP18_TERNARY' => -101,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			"]" => -101,
			'OP08_STRING_CAT' => 207,
			"}" => -101,
			'OP04_MATH_POW' => 206,
			'OP21_LIST_COMMA' => -101,
			")" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => 195,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			";" => -101,
			'OP09_BITWISE_SHIFT' => 201,
			'OP16_LOGICAL_OR' => -101,
			'OP17_LIST_RANGE' => -101
		}
	},
	{#State 263
		ACTIONS => {
			'OP15_LOGICAL_AND' => -97,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => -97,
			'OP07_STRING_REPEAT' => 192,
			")" => -97,
			'OP21_LIST_COMMA' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP09_BITWISE_SHIFT' => 201,
			";" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => -97,
			'OP08_STRING_CAT' => 207,
			"]" => -97,
			'OP04_MATH_POW' => 206,
			"}" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => -97
		}
	},
	{#State 264
		ACTIONS => {
			'OP17_LIST_RANGE' => -98,
			";" => -98,
			'OP09_BITWISE_SHIFT' => 201,
			'OP16_LOGICAL_OR' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP21_LIST_COMMA' => -98,
			")" => -98,
			'OP04_MATH_POW' => 206,
			"}" => -98,
			"]" => -98,
			'OP08_STRING_CAT' => 207,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => -98
		}
	},
	{#State 265
		ACTIONS => {
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP23_LOGICAL_AND' => 199,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			'OP07_STRING_REPEAT' => 192,
			")" => -107,
			'OP21_LIST_COMMA' => -107,
			'OP17_LIST_RANGE' => 200,
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			";" => -107,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP18_TERNARY' => 205,
			"]" => -107,
			'OP08_STRING_CAT' => 207,
			"}" => -107,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208
		}
	},
	{#State 266
		ACTIONS => {
			"]" => -90,
			'OP08_STRING_CAT' => -90,
			'OP04_MATH_POW' => 206,
			"}" => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP18_TERNARY' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			";" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_STRING_REPEAT' => 192,
			")" => -90,
			'OP21_LIST_COMMA' => -90
		}
	},
	{#State 267
		ACTIONS => {
			"}" => -106,
			'OP04_MATH_POW' => 206,
			"]" => -106,
			'OP08_STRING_CAT' => 207,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP18_TERNARY' => 205,
			'OP17_LIST_RANGE' => 200,
			'OP16_LOGICAL_OR' => 202,
			";" => -106,
			'OP09_BITWISE_SHIFT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			'OP23_LOGICAL_AND' => -106,
			")" => -106,
			'OP21_LIST_COMMA' => -106
		}
	},
	{#State 268
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP18_TERNARY' => -103,
			'OP04_MATH_POW' => 206,
			"}" => -103,
			"]" => -103,
			'OP08_STRING_CAT' => 207,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			'OP23_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			")" => -103,
			'OP21_LIST_COMMA' => -103,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 202,
			";" => -103,
			'OP09_BITWISE_SHIFT' => 201
		}
	},
	{#State 269
		ACTIONS => {
			'OP18_TERNARY' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => 203,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP06_REGEX_MATCH' => 208,
			"]" => -93,
			'OP08_STRING_CAT' => 207,
			"}" => -93,
			'OP04_MATH_POW' => 206,
			")" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP16_LOGICAL_OR' => -93,
			";" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP17_LIST_RANGE' => -93
		}
	},
	{#State 270
		ACTIONS => {
			'OP17_LIST_RANGE' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP09_BITWISE_SHIFT' => 201,
			";" => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			")" => -102,
			'OP21_LIST_COMMA' => -102,
			"]" => -102,
			'OP08_STRING_CAT' => 207,
			"}" => -102,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP18_TERNARY' => -102
		}
	},
	{#State 271
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -91,
			";" => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP21_LIST_COMMA' => -91,
			")" => -91,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP06_REGEX_MATCH' => 208,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP04_MATH_POW' => 206,
			"}" => -91,
			"]" => -91,
			'OP08_STRING_CAT' => -91,
			'OP18_TERNARY' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91
		}
	},
	{#State 272
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -100,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => -100,
			'OP08_STRING_CAT' => 207,
			"]" => -100,
			'OP04_MATH_POW' => 206,
			"}" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP15_LOGICAL_AND' => -100,
			'OP11_COMPARE_LT_GT' => 195,
			'OP23_LOGICAL_AND' => -100,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP21_LIST_COMMA' => -100,
			")" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP09_BITWISE_SHIFT' => 201,
			";" => -100,
			'OP16_LOGICAL_OR' => -100
		}
	},
	{#State 273
		DEFAULT => -206
	},
	{#State 274
		DEFAULT => -207
	},
	{#State 275
		ACTIONS => {
			'COLON' => 316
		}
	},
	{#State 276
		ACTIONS => {
			'OP17_LIST_RANGE' => -85,
			";" => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP21_LIST_COMMA' => -85,
			")" => -85,
			"}" => -85,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => -85,
			"]" => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP18_TERNARY' => -85
		}
	},
	{#State 277
		ACTIONS => {
			'OP21_LIST_COMMA' => -92,
			")" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => -92,
			'OP07_STRING_REPEAT' => 192,
			";" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP18_TERNARY' => -92,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP06_REGEX_MATCH' => 208,
			"]" => -92,
			'OP08_STRING_CAT' => -92,
			'OP04_MATH_POW' => 206,
			"}" => -92
		}
	},
	{#State 278
		DEFAULT => -88
	},
	{#State 279
		ACTIONS => {
			'LBRACE' => 317
		}
	},
	{#State 280
		ACTIONS => {
			'LITERAL_NUMBER' => 318,
			"our" => 320
		},
		GOTOS => {
			'MethodOrSubroutine' => 321,
			'Method' => 322,
			'Subroutine' => 319
		}
	},
	{#State 281
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 323
		}
	},
	{#State 282
		ACTIONS => {
			";" => 324
		}
	},
	{#State 283
		DEFAULT => -44
	},
	{#State 284
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 325
		}
	},
	{#State 285
		DEFAULT => -123
	},
	{#State 286
		DEFAULT => -174
	},
	{#State 287
		ACTIONS => {
			"my" => 144,
			'KEYS_OR_VALUES' => 143,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'OP01_OPEN' => 89,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_NAMED' => 139,
			"undef" => 84
		},
		GOTOS => {
			'ArrayReference' => 106,
			'HashReference' => 116,
			'ListElement' => 326,
			'Literal' => 113,
			'SubExpression' => 142,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'Expression' => 140,
			'TypeInner' => 137,
			'WordScoped' => 78
		}
	},
	{#State 288
		DEFAULT => -176
	},
	{#State 289
		DEFAULT => -179
	},
	{#State 290
		ACTIONS => {
			'WORD' => 327
		}
	},
	{#State 291
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'WordScoped' => 78,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'SubExpression' => 328,
			'HashDereferenced' => 108,
			'Operator' => 120
		}
	},
	{#State 292
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 329
		}
	},
	{#State 293
		ACTIONS => {
			'LPAREN' => 330
		}
	},
	{#State 294
		ACTIONS => {
			'OP21_LIST_COMMA' => 331
		}
	},
	{#State 295
		ACTIONS => {
			")" => 332
		}
	},
	{#State 296
		ACTIONS => {
			'LBRACE' => 112,
			"my" => 144,
			'KEYS_OR_VALUES' => 143,
			'OP05_LOGICAL_NEG' => 86,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'VARIABLE_SYMBOL' => 115,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'OP01_QW' => 141,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22
		},
		GOTOS => {
			'TypeInner' => 137,
			'WordScoped' => 78,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'ListElements' => 333,
			'Operator' => 120,
			'SubExpression' => 142,
			'HashDereferenced' => 108,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'ListElement' => 138
		}
	},
	{#State 297
		DEFAULT => -149,
		GOTOS => {
			'STAR-37' => 334
		}
	},
	{#State 298
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LBRACE' => 112,
			"my" => 110,
			'OP01_NAMED' => 107,
			'OP10_STRINGIFY_UNARY' => 105,
			'WORD' => 101,
			'OP01_PRINT' => 103,
			'CONSTANT_SYMBOL' => 102,
			"if (" => 99,
			'OP01_NAMED_VOID' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			"foreach my" => -141,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			"for my integer" => -141,
			'OP19_LOOP_CONTROL' => 87,
			"while (" => -141,
			'OP05_LOGICAL_NEG' => 86,
			'OP01_NAMED_VOID_SCOLON' => 85,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			"\@{" => 81,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'OPTIONAL-35' => 88,
			'Literal' => 113,
			'PAREN-34' => 117,
			'HashReference' => 116,
			'Statement' => 121,
			'Conditional' => 92,
			'LoopLabel' => 91,
			'Operator' => 120,
			'OperatorVoid' => 123,
			'SubExpression' => 122,
			'ArrayDereferenced' => 111,
			'Variable' => 109,
			'VariableModification' => 80,
			'ArrayReference' => 106,
			'VariableDeclaration' => 83,
			'HashDereferenced' => 108,
			'Expression' => 96,
			'Operation' => 336,
			'PLUS-40' => 335,
			'WordScoped' => 78
		}
	},
	{#State 299
		DEFAULT => -112
	},
	{#State 300
		DEFAULT => -111
	},
	{#State 301
		ACTIONS => {
			";" => 337
		}
	},
	{#State 302
		DEFAULT => -171
	},
	{#State 303
		ACTIONS => {
			")" => 338
		}
	},
	{#State 304
		DEFAULT => -120
	},
	{#State 305
		DEFAULT => -172
	},
	{#State 306
		DEFAULT => -169
	},
	{#State 307
		ACTIONS => {
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'STDIN' => 249,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 78,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'HashDereferenced' => 108,
			'SubExpression' => 248,
			'Operator' => 120,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'SubExpressionOrStdin' => 339
		}
	},
	{#State 308
		DEFAULT => -188
	},
	{#State 309
		ACTIONS => {
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			'CONSTANT_SYMBOL' => 102,
			"\@{" => 81,
			'WORD' => 22,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86
		},
		GOTOS => {
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'WordScoped' => 78,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113,
			'HashDereferenced' => 108,
			'SubExpression' => 340,
			'Operator' => 120
		}
	},
	{#State 310
		ACTIONS => {
			'WORD' => 183,
			"%{" => 114
		},
		GOTOS => {
			'HashEntry' => 341,
			'HashDereferenced' => 182
		}
	},
	{#State 311
		DEFAULT => -197
	},
	{#State 312
		DEFAULT => -195
	},
	{#State 313
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -200,
			"}" => 342,
			'LPAREN' => -200
		}
	},
	{#State 314
		ACTIONS => {
			'OP23_LOGICAL_AND' => 199,
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			'OP17_LIST_RANGE' => 200,
			'OP09_BITWISE_SHIFT' => 201,
			'OP16_LOGICAL_OR' => 202,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => 205,
			'OP08_STRING_CAT' => 207,
			'OP04_MATH_POW' => 206,
			"}" => 343,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196
		}
	},
	{#State 315
		ACTIONS => {
			"]" => 344,
			'OP08_STRING_CAT' => 207,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP18_TERNARY' => 205,
			'OP17_LIST_RANGE' => 200,
			'OP09_BITWISE_SHIFT' => 201,
			'OP16_LOGICAL_OR' => 202,
			'OP23_LOGICAL_AND' => 199,
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP13_BITWISE_AND' => 193,
			'OP07_STRING_REPEAT' => 192
		}
	},
	{#State 316
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'LITERAL_STRING' => 77
		},
		GOTOS => {
			'Variable' => 273,
			'Literal' => 274,
			'VariableOrLiteral' => 345
		}
	},
	{#State 317
		ACTIONS => {
			"}" => 349,
			"%{" => 114,
			'WORD' => 347
		},
		GOTOS => {
			'HashEntryTyped' => 346,
			'HashDereferenced' => 348
		}
	},
	{#State 318
		ACTIONS => {
			";" => 350
		}
	},
	{#State 319
		DEFAULT => -75
	},
	{#State 320
		ACTIONS => {
			'WORD' => 51,
			'TYPE_METHOD' => 351
		},
		GOTOS => {
			'Type' => 52
		}
	},
	{#State 321
		DEFAULT => -57
	},
	{#State 322
		DEFAULT => -74
	},
	{#State 323
		ACTIONS => {
			'OP21_LIST_COMMA' => 354,
			")" => 352
		},
		GOTOS => {
			'PAREN-18' => 353
		}
	},
	{#State 324
		DEFAULT => -46
	},
	{#State 325
		DEFAULT => -205
	},
	{#State 326
		DEFAULT => -173
	},
	{#State 327
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 355
		}
	},
	{#State 328
		ACTIONS => {
			'OP08_STRING_CAT' => 207,
			'OP04_MATH_POW' => 206,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => 205,
			'OP17_LIST_RANGE' => 356,
			'OP09_BITWISE_SHIFT' => 201,
			'OP16_LOGICAL_OR' => 202,
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP23_LOGICAL_AND' => 199,
			'OP13_BITWISE_AND' => 193,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198
		}
	},
	{#State 329
		DEFAULT => -159
	},
	{#State 330
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 86,
			'KEYS_OR_VALUES' => 143,
			"my" => 144,
			'LBRACE' => 112,
			'OP01_OPEN' => 89,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 90,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'OP01_QW' => 141,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'WordScoped' => 78,
			'TypeInner' => 137,
			'ListElements' => 357,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'SubExpression' => 142,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'HashReference' => 116,
			'ListElement' => 138,
			'ArrayReference' => 106,
			'Literal' => 113
		}
	},
	{#State 331
		ACTIONS => {
			'LITERAL_STRING' => 358
		}
	},
	{#State 332
		DEFAULT => -78
	},
	{#State 333
		ACTIONS => {
			")" => 359
		}
	},
	{#State 334
		ACTIONS => {
			'OP01_NAMED' => -152,
			'CONSTANT_SYMBOL' => -152,
			'OP01_PRINT' => -152,
			'WORD' => -152,
			'OP10_STRINGIFY_UNARY' => -152,
			'OP01_NAMED_VOID' => -152,
			"if (" => -152,
			"}" => -152,
			'LPAREN' => -152,
			'OP03_MATH_INC_DEC' => -152,
			'OP10_NAMED_UNARY' => -152,
			'OP22_LOGICAL_NEG' => -152,
			"elsif (" => 360,
			"%{" => -152,
			'VARIABLE_SYMBOL' => -152,
			'LBRACE' => -152,
			"else" => 362,
			"my" => -152,
			"undef" => -152,
			'OP01_NAMED_VOID_SCOLON' => -152,
			"\@{" => -152,
			'OP01_CLOSE' => -152,
			'LITERAL_STRING' => -152,
			'LBRACKET' => -152,
			'WORD_SCOPED' => -152,
			'OP05_MATH_NEG_LPAREN' => -152,
			"foreach my" => -152,
			'OP19_LOOP_CONTROL_SCOLON' => -152,
			'LITERAL_NUMBER' => -152,
			'OP01_OPEN' => -152,
			"for my integer" => -152,
			'OP05_LOGICAL_NEG' => -152,
			'' => -152,
			"while (" => -152,
			'OP19_LOOP_CONTROL' => -152
		},
		GOTOS => {
			'PAREN-38' => 363,
			'PAREN-36' => 361,
			'OPTIONAL-39' => 364
		}
	},
	{#State 335
		ACTIONS => {
			'OP01_CLOSE' => 82,
			"\@{" => 81,
			'OP01_NAMED_VOID_SCOLON' => 85,
			"undef" => 84,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'LITERAL_STRING' => 77,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			"foreach my" => -141,
			'OP05_MATH_NEG_LPAREN' => 93,
			"while (" => -141,
			'OP19_LOOP_CONTROL' => 87,
			'OP05_LOGICAL_NEG' => 86,
			"for my integer" => -141,
			'OP10_STRINGIFY_UNARY' => 105,
			'WORD' => 101,
			'OP01_PRINT' => 103,
			'CONSTANT_SYMBOL' => 102,
			'OP01_NAMED' => 107,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			"}" => 366,
			"if (" => 99,
			'OP01_NAMED_VOID' => 100,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP22_LOGICAL_NEG' => 124,
			'OP10_NAMED_UNARY' => 119,
			"my" => 110,
			'LBRACE' => 112
		},
		GOTOS => {
			'Operation' => 365,
			'Expression' => 96,
			'WordScoped' => 78,
			'ArrayReference' => 106,
			'VariableModification' => 80,
			'HashDereferenced' => 108,
			'VariableDeclaration' => 83,
			'ArrayDereferenced' => 111,
			'Variable' => 109,
			'PAREN-34' => 117,
			'HashReference' => 116,
			'Literal' => 113,
			'OPTIONAL-35' => 88,
			'SubExpression' => 122,
			'OperatorVoid' => 123,
			'LoopLabel' => 91,
			'Statement' => 121,
			'Conditional' => 92,
			'Operator' => 120
		}
	},
	{#State 336
		DEFAULT => -161
	},
	{#State 337
		DEFAULT => -115
	},
	{#State 338
		DEFAULT => -125
	},
	{#State 339
		ACTIONS => {
			";" => 367
		}
	},
	{#State 340
		ACTIONS => {
			'OP17_LIST_RANGE' => 200,
			'OP09_BITWISE_SHIFT' => 201,
			'OP16_LOGICAL_OR' => 202,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			'OP23_LOGICAL_AND' => 199,
			'OP21_LIST_COMMA' => -190,
			"}" => -190,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => 205
		}
	},
	{#State 341
		DEFAULT => -194
	},
	{#State 342
		DEFAULT => -168
	},
	{#State 343
		DEFAULT => -167
	},
	{#State 344
		DEFAULT => -166
	},
	{#State 345
		DEFAULT => -104
	},
	{#State 346
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 368
		}
	},
	{#State 347
		ACTIONS => {
			'OP20_HASH_FATARROW' => 369
		}
	},
	{#State 348
		DEFAULT => -193
	},
	{#State 349
		ACTIONS => {
			";" => 370
		}
	},
	{#State 350
		DEFAULT => -59
	},
	{#State 351
		ACTIONS => {
			'VARIABLE_SYMBOL' => 371
		}
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 372
		}
	},
	{#State 353
		DEFAULT => -48
	},
	{#State 354
		ACTIONS => {
			"my" => 373
		}
	},
	{#State 355
		DEFAULT => -204
	},
	{#State 356
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'OP01_OPEN' => 89,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 374,
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'WordScoped' => 78,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145
		}
	},
	{#State 357
		ACTIONS => {
			")" => 375
		}
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 376
		}
	},
	{#State 359
		DEFAULT => -80
	},
	{#State 360
		ACTIONS => {
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79
		},
		GOTOS => {
			'WordScoped' => 78,
			'Expression' => 140,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Operator' => 120,
			'HashDereferenced' => 108,
			'SubExpression' => 377,
			'Literal' => 113,
			'HashReference' => 116,
			'ArrayReference' => 106
		}
	},
	{#State 361
		DEFAULT => -148
	},
	{#State 362
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 363
		DEFAULT => -151
	},
	{#State 364
		DEFAULT => -153
	},
	{#State 365
		DEFAULT => -160
	},
	{#State 366
		DEFAULT => -162
	},
	{#State 367
		DEFAULT => -170
	},
	{#State 368
		ACTIONS => {
			'OP21_LIST_COMMA' => 380,
			"}" => 379
		},
		GOTOS => {
			'PAREN-24' => 381
		}
	},
	{#State 369
		ACTIONS => {
			"my" => 144
		},
		GOTOS => {
			'TypeInner' => 382
		}
	},
	{#State 370
		DEFAULT => -64
	},
	{#State 371
		ACTIONS => {
			"= sub {" => 383
		}
	},
	{#State 372
		ACTIONS => {
			"\@_;" => 384
		}
	},
	{#State 373
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 385
		}
	},
	{#State 374
		ACTIONS => {
			")" => 386,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP23_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			'OP17_LIST_RANGE' => undef,
			'OP18_TERNARY' => -103,
			'OP08_MATH_ADD_SUB' => 203,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207
		}
	},
	{#State 375
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 376
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 124,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP10_NAMED_UNARY' => 119,
			'LITERAL_NUMBER' => 90,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 89,
			'LBRACE' => 112,
			'OP05_LOGICAL_NEG' => 86,
			'OP01_NAMED' => 139,
			"undef" => 84,
			'OP01_CLOSE' => 82,
			'OP10_STRINGIFY_UNARY' => 105,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 22,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 77,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95
		},
		GOTOS => {
			'WordScoped' => 78,
			'Variable' => 145,
			'ArrayDereferenced' => 111,
			'Expression' => 140,
			'SubExpression' => 388,
			'HashDereferenced' => 108,
			'Operator' => 120,
			'HashReference' => 116,
			'ArrayReference' => 106,
			'Literal' => 113
		}
	},
	{#State 377
		ACTIONS => {
			'OP13_BITWISE_AND' => 193,
			'OP07_STRING_REPEAT' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP15_LOGICAL_AND' => 194,
			'OP11_COMPARE_LT_GT' => 195,
			'OP23_LOGICAL_AND' => 199,
			")" => 389,
			'OP17_LIST_RANGE' => 200,
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP18_TERNARY' => 205,
			'OP04_MATH_POW' => 206,
			'OP08_STRING_CAT' => 207,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP24_LOGICAL_OR_XOR' => 197
		}
	},
	{#State 378
		DEFAULT => -150
	},
	{#State 379
		ACTIONS => {
			";" => 390
		}
	},
	{#State 380
		ACTIONS => {
			"%{" => 114,
			'WORD' => 347
		},
		GOTOS => {
			'HashEntryTyped' => 391,
			'HashDereferenced' => 348
		}
	},
	{#State 381
		DEFAULT => -61
	},
	{#State 382
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 86,
			'LBRACE' => 112,
			'OP01_OPEN' => 89,
			"%{" => 114,
			'LITERAL_NUMBER' => 90,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP22_LOGICAL_NEG' => 124,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			'WORD' => 22,
			"\@{" => 81,
			'CONSTANT_SYMBOL' => 102,
			'OP10_STRINGIFY_UNARY' => 105,
			'OP01_CLOSE' => 82,
			"undef" => 84,
			'OP01_NAMED' => 139
		},
		GOTOS => {
			'Literal' => 113,
			'ArrayReference' => 106,
			'HashReference' => 116,
			'Operator' => 120,
			'SubExpression' => 392,
			'HashDereferenced' => 108,
			'Expression' => 140,
			'ArrayDereferenced' => 111,
			'Variable' => 145,
			'WordScoped' => 78
		}
	},
	{#State 383
		ACTIONS => {
			'LITERAL_STRING' => -66,
			'WORD_SCOPED' => -66,
			'LBRACKET' => -66,
			"\@{" => -66,
			'OP01_CLOSE' => -66,
			"undef" => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP19_LOOP_CONTROL' => -66,
			"while (" => -66,
			"for my integer" => -66,
			'OP01_OPEN' => -66,
			'LITERAL_NUMBER' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			"foreach my" => -66,
			'OP03_MATH_INC_DEC' => -66,
			'LPAREN' => -66,
			"if (" => -66,
			'OP01_NAMED_VOID' => -66,
			'WORD' => -66,
			'CONSTANT_SYMBOL' => -66,
			'OP01_PRINT' => -66,
			'OP10_STRINGIFY_UNARY' => -66,
			'OP01_NAMED' => -66,
			"( my" => 395,
			"my" => -66,
			'LBRACE' => -66,
			"%{" => -66,
			'VARIABLE_SYMBOL' => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP22_LOGICAL_NEG' => -66
		},
		GOTOS => {
			'MethodArguments' => 393,
			'OPTIONAL-26' => 394
		}
	},
	{#State 384
		DEFAULT => -50
	},
	{#State 385
		ACTIONS => {
			'VARIABLE_SYMBOL' => 396
		}
	},
	{#State 386
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 397
		}
	},
	{#State 387
		DEFAULT => -158
	},
	{#State 388
		ACTIONS => {
			")" => -81,
			'OP21_LIST_COMMA' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP11_COMPARE_LT_GT' => 195,
			'OP15_LOGICAL_AND' => 194,
			'OP07_STRING_REPEAT' => 192,
			'OP13_BITWISE_AND' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP16_LOGICAL_OR' => 202,
			";" => -81,
			'OP09_BITWISE_SHIFT' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP18_TERNARY' => 205,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => 208,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP08_STRING_CAT' => 207,
			"]" => -81,
			"}" => -81,
			'OP04_MATH_POW' => 206
		}
	},
	{#State 389
		ACTIONS => {
			'LBRACE' => 298
		},
		GOTOS => {
			'CodeBlock' => 398
		}
	},
	{#State 390
		DEFAULT => -63
	},
	{#State 391
		DEFAULT => -60
	},
	{#State 392
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 197,
			'OP12_COMPARE_EQ_NE' => 196,
			'OP06_REGEX_MATCH' => 208,
			'OP08_STRING_CAT' => 207,
			"}" => -192,
			'OP04_MATH_POW' => 206,
			'OP18_TERNARY' => 205,
			'OP14_BITWISE_OR_XOR' => 204,
			'OP08_MATH_ADD_SUB' => 203,
			'OP16_LOGICAL_OR' => 202,
			'OP09_BITWISE_SHIFT' => 201,
			'OP17_LIST_RANGE' => 200,
			'OP21_LIST_COMMA' => -192,
			'OP15_LOGICAL_AND' => 194,
			'OP23_LOGICAL_AND' => 199,
			'OP11_COMPARE_LT_GT' => 195,
			'OP13_BITWISE_AND' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 198,
			'OP07_STRING_REPEAT' => 192
		}
	},
	{#State 393
		DEFAULT => -65
	},
	{#State 394
		ACTIONS => {
			'LBRACE' => 112,
			"my" => 110,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED_VOID' => 100,
			"if (" => 99,
			'LPAREN' => 97,
			'OP03_MATH_INC_DEC' => 95,
			'OP01_NAMED' => 107,
			'OP01_PRINT' => 103,
			'CONSTANT_SYMBOL' => 102,
			'WORD' => 101,
			'OP10_STRINGIFY_UNARY' => 105,
			"for my integer" => -141,
			'OP05_LOGICAL_NEG' => 86,
			'OP19_LOOP_CONTROL' => 87,
			"while (" => -141,
			'OP05_MATH_NEG_LPAREN' => 93,
			"foreach my" => -141,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			'LITERAL_NUMBER' => 90,
			'OP01_OPEN' => 89,
			'LITERAL_STRING' => 77,
			'LBRACKET' => 79,
			'WORD_SCOPED' => 24,
			"undef" => 84,
			'OP01_NAMED_VOID_SCOLON' => 85,
			"\@{" => 81,
			'OP01_CLOSE' => 82
		},
		GOTOS => {
			'ArrayDereferenced' => 111,
			'Variable' => 109,
			'PLUS-27' => 400,
			'PAREN-34' => 117,
			'HashReference' => 116,
			'OPTIONAL-35' => 88,
			'Literal' => 113,
			'OperatorVoid' => 123,
			'SubExpression' => 122,
			'LoopLabel' => 91,
			'Statement' => 121,
			'Conditional' => 92,
			'Operator' => 120,
			'Expression' => 96,
			'Operation' => 399,
			'WordScoped' => 78,
			'ArrayReference' => 106,
			'VariableModification' => 80,
			'HashDereferenced' => 108,
			'VariableDeclaration' => 83
		}
	},
	{#State 395
		ACTIONS => {
			'TYPE_SELF' => 401
		}
	},
	{#State 396
		DEFAULT => -47
	},
	{#State 397
		DEFAULT => -157
	},
	{#State 398
		DEFAULT => -147
	},
	{#State 399
		DEFAULT => -68
	},
	{#State 400
		ACTIONS => {
			"}" => 402,
			"if (" => 99,
			'OP01_NAMED_VOID' => 100,
			'OP03_MATH_INC_DEC' => 95,
			'LPAREN' => 97,
			'OP01_NAMED' => 107,
			'WORD' => 101,
			'CONSTANT_SYMBOL' => 102,
			'OP01_PRINT' => 103,
			'OP10_STRINGIFY_UNARY' => 105,
			'LBRACE' => 112,
			"my" => 110,
			'OP10_NAMED_UNARY' => 119,
			'OP22_LOGICAL_NEG' => 124,
			"%{" => 114,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_STRING' => 77,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 79,
			"undef" => 84,
			'OP01_NAMED_VOID_SCOLON' => 85,
			"\@{" => 81,
			'OP01_CLOSE' => 82,
			"for my integer" => -141,
			'OP05_LOGICAL_NEG' => 86,
			"while (" => -141,
			'OP19_LOOP_CONTROL' => 87,
			'OP05_MATH_NEG_LPAREN' => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			"foreach my" => -141,
			'OP01_OPEN' => 89,
			'LITERAL_NUMBER' => 90
		},
		GOTOS => {
			'HashReference' => 116,
			'PAREN-34' => 117,
			'Literal' => 113,
			'OPTIONAL-35' => 88,
			'OperatorVoid' => 123,
			'SubExpression' => 122,
			'Operator' => 120,
			'Statement' => 121,
			'LoopLabel' => 91,
			'Conditional' => 92,
			'Variable' => 109,
			'ArrayDereferenced' => 111,
			'ArrayReference' => 106,
			'VariableModification' => 80,
			'HashDereferenced' => 108,
			'VariableDeclaration' => 83,
			'Expression' => 96,
			'Operation' => 403,
			'WordScoped' => 78
		}
	},
	{#State 401
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 404
		}
	},
	{#State 402
		ACTIONS => {
			";" => 405
		}
	},
	{#State 403
		DEFAULT => -67
	},
	{#State 404
		ACTIONS => {
			'OP21_LIST_COMMA' => 407,
			")" => 408
		},
		GOTOS => {
			'PAREN-28' => 406
		}
	},
	{#State 405
		DEFAULT => -69
	},
	{#State 406
		DEFAULT => -71
	},
	{#State 407
		ACTIONS => {
			"my" => 409
		}
	},
	{#State 408
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 409
		ACTIONS => {
			'WORD' => 51
		},
		GOTOS => {
			'Type' => 411
		}
	},
	{#State 410
		ACTIONS => {
			"\@_;" => 412
		}
	},
	{#State 411
		ACTIONS => {
			'VARIABLE_SYMBOL' => 413
		}
	},
	{#State 412
		DEFAULT => -73
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
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6249 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6256 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6263 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
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
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6288 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6295 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
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
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6320 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6327 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6334 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6341 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6348 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6355 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6362 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
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
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6387 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6394 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
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
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6430 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6437 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6444 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-27', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
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
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6469 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6476 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
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
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 171 "lib/RPerl/Grammar.eyp"
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
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
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
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7195 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
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
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-37', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7278 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 2,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7292 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
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
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-40', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
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
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7408 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-41', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
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
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7531 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-44', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
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
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-45', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
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
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
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
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7712 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-48', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
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

#line 211 "lib/RPerl/Grammar.eyp"


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
