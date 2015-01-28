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

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|foreach\ my|use\ RPerl\;|elsif\ \(|package|\$TYPED_|\=\ sub\ \{|while\ \(|undef|else|\(\ my|if\ \(|use|\@_\;|our|qw\(|\@\{|my|\%\{|\;|\}|\]|\))}gc and return ($1, $1);

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
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
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
  [ 'MethodArguments_73' => 'MethodArguments', [ '( my', 'TYPE_CLASS_OR_SELF', 'STAR-29', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
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
	TYPE_CLASS_OR_SELF => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 3,
			'SHEBANG' => 4,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 1,
			'Critic' => 2,
			'ModuleHeader' => 6,
			'CompileUnit' => 5,
			'PLUS-2' => 7,
			'PAREN-1' => 9,
			'Program' => 8
		}
	},
	{#State 1
		ACTIONS => {
			"package" => 10
		}
	},
	{#State 2
		DEFAULT => -19
	},
	{#State 3
		ACTIONS => {
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-14' => 11
		}
	},
	{#State 4
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 14,
			'OPTIONAL-3' => 13
		}
	},
	{#State 5
		ACTIONS => {
			'' => 15
		}
	},
	{#State 6
		ACTIONS => {
			"use" => -25,
			"## no critic qw(" => -25,
			"use parent qw(" => 19,
			"use constant" => -25,
			"our" => -25
		},
		GOTOS => {
			'Package' => 18,
			'STAR-10' => 20,
			'Class' => 17,
			'Module' => 16
		}
	},
	{#State 7
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 3,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 21,
			'Critic' => 2,
			'OPTIONAL-9' => 1,
			'ModuleHeader' => 6
		}
	},
	{#State 8
		DEFAULT => -4
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 11
		ACTIONS => {
			'WORD' => 25,
			")" => 26
		}
	},
	{#State 12
		DEFAULT => -35
	},
	{#State 13
		ACTIONS => {
			"use strict;" => 27
		},
		GOTOS => {
			'Header' => 28
		}
	},
	{#State 14
		DEFAULT => -6
	},
	{#State 15
		DEFAULT => 0
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
			'WORD_SCOPED' => 23,
			'WORD' => 22
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		ACTIONS => {
			"our" => -27,
			"use constant" => -27,
			"## no critic qw(" => 3,
			"use" => -27
		},
		GOTOS => {
			'Critic' => 30,
			'STAR-11' => 31
		}
	},
	{#State 21
		DEFAULT => -2
	},
	{#State 22
		DEFAULT => -200
	},
	{#State 23
		DEFAULT => -201
	},
	{#State 24
		ACTIONS => {
			";" => 32
		}
	},
	{#State 25
		DEFAULT => -34
	},
	{#State 26
		DEFAULT => -36
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
			"our" => -29,
			"use constant" => -29,
			"use" => 36
		},
		GOTOS => {
			'Include' => 38,
			'STAR-12' => 37
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
			'OP01_NAMED_VOID' => -11,
			'LBRACE' => -11,
			'WORD_SCOPED' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_PRINT' => -11,
			'CONSTANT_SYMBOL' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"use constant" => -11,
			'OP01_CLOSE' => -11,
			"for my integer" => -11,
			"%{" => -11,
			'WORD' => -11,
			'OP01_NAMED' => -11,
			"## no critic qw(" => 3,
			"use" => -11,
			"if (" => -11,
			'LITERAL_NUMBER' => -11,
			"foreach my" => -11,
			'OP01_OPEN' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LBRACKET' => -11,
			"undef" => -11,
			"while (" => -11,
			'LITERAL_STRING' => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			"\@{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'LPAREN' => -11,
			"our" => -11,
			'VARIABLE_SYMBOL' => -11,
			"my" => -11
		},
		GOTOS => {
			'Critic' => 41,
			'STAR-5' => 42
		}
	},
	{#State 35
		ACTIONS => {
			";" => 43
		}
	},
	{#State 36
		ACTIONS => {
			'WORD' => 22,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 44
		}
	},
	{#State 37
		ACTIONS => {
			"our" => 47,
			"use constant" => 46
		},
		GOTOS => {
			'Constant' => 48,
			'PLUS-13' => 49,
			'Subroutine' => 45
		}
	},
	{#State 38
		DEFAULT => -26
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
		DEFAULT => -8
	},
	{#State 42
		ACTIONS => {
			'WORD_SCOPED' => -13,
			'LBRACE' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"use constant" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'CONSTANT_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			'WORD' => -13,
			"%{" => -13,
			"for my integer" => -13,
			'OP01_CLOSE' => -13,
			"if (" => -13,
			"use" => 36,
			'OP01_NAMED' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"undef" => -13,
			'OP01_OPEN' => -13,
			"foreach my" => -13,
			'OP10_NAMED_UNARY' => -13,
			'LITERAL_NUMBER' => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			"\@{" => -13,
			'LITERAL_STRING' => -13,
			"while (" => -13,
			"our" => -13,
			'VARIABLE_SYMBOL' => -13,
			"my" => -13,
			'LPAREN' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP05_LOGICAL_NEG' => -13
		},
		GOTOS => {
			'Include' => 52,
			'STAR-6' => 51
		}
	},
	{#State 43
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 53
		}
	},
	{#State 44
		ACTIONS => {
			";" => 55,
			"qw(" => 54
		}
	},
	{#State 45
		DEFAULT => -31
	},
	{#State 46
		ACTIONS => {
			'CONSTANT_SYMBOL' => 56
		}
	},
	{#State 47
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 48
		DEFAULT => -28
	},
	{#State 49
		ACTIONS => {
			'LITERAL_NUMBER' => 59,
			"our" => 47
		},
		GOTOS => {
			'Subroutine' => 60
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 61
		}
	},
	{#State 51
		ACTIONS => {
			'LBRACE' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"use constant" => 46,
			'CONSTANT_SYMBOL' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_PRINT' => -15,
			'WORD' => -15,
			"%{" => -15,
			'OP01_CLOSE' => -15,
			"for my integer" => -15,
			"if (" => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'LBRACKET' => -15,
			"undef" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_OPEN' => -15,
			"foreach my" => -15,
			'LITERAL_NUMBER' => -15,
			"\@{" => -15,
			'OP10_STRINGIFY_UNARY' => -15,
			"while (" => -15,
			'LITERAL_STRING' => -15,
			"my" => -15,
			'VARIABLE_SYMBOL' => -15,
			"our" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LPAREN' => -15,
			'OP05_LOGICAL_NEG' => -15
		},
		GOTOS => {
			'STAR-7' => 62,
			'Constant' => 63
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
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 58
		DEFAULT => -203
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
		DEFAULT => -33
	},
	{#State 62
		ACTIONS => {
			'WORD' => 104,
			'OP01_CLOSE' => 108,
			"for my integer" => -141,
			"%{" => 105,
			'OP01_PRINT' => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'CONSTANT_SYMBOL' => 100,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_NAMED_VOID' => 112,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			"our" => 47,
			'VARIABLE_SYMBOL' => 77,
			"my" => 79,
			'OP05_LOGICAL_NEG' => 85,
			'OP19_LOOP_CONTROL' => 83,
			'LPAREN' => 84,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			"while (" => -141,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'LITERAL_NUMBER' => 99,
			"foreach my" => -141,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			"if (" => 89,
			'OP01_NAMED' => 90
		},
		GOTOS => {
			'LoopLabel' => 80,
			'HashReference' => 78,
			'PAREN-34' => 103,
			'ArrayDereferenced' => 81,
			'Statement' => 106,
			'Expression' => 107,
			'VariableDeclaration' => 82,
			'OPTIONAL-35' => 86,
			'Variable' => 87,
			'Subroutine' => 73,
			'VariableModification' => 70,
			'WordScoped' => 75,
			'Conditional' => 76,
			'Literal' => 114,
			'HashDereferenced' => 95,
			'Operation' => 98,
			'SubExpression' => 88,
			'ArrayReference' => 111,
			'PLUS-8' => 109,
			'Operator' => 113,
			'OperatorVoid' => 91
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			"## no critic qw(" => 3,
			"use" => -54,
			"our hash_ref \$properties" => -54,
			"use constant" => -54
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
			"my" => 122
		},
		GOTOS => {
			'TypeInnerConstant' => 123
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 124
		}
	},
	{#State 69
		DEFAULT => -32
	},
	{#State 70
		DEFAULT => -146
	},
	{#State 71
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			"%{" => 105,
			'LPAREN' => 84,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72
		},
		GOTOS => {
			'Expression' => 128,
			'Variable' => 127,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'WordScoped' => 75,
			'ArrayReference' => 111,
			'SubExpression' => 125,
			'Operator' => 113
		}
	},
	{#State 72
		ACTIONS => {
			'LBRACKET' => 93,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'ArrayReference' => 129,
			'Variable' => 130
		}
	},
	{#State 73
		DEFAULT => -14
	},
	{#State 74
		DEFAULT => -208
	},
	{#State 75
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 131,
			'LPAREN' => 132
		}
	},
	{#State 76
		DEFAULT => -142
	},
	{#State 77
		DEFAULT => -164,
		GOTOS => {
			'STAR-41' => 133
		}
	},
	{#State 78
		DEFAULT => -133
	},
	{#State 79
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 134
		}
	},
	{#State 80
		ACTIONS => {
			'COLON' => 135
		}
	},
	{#State 81
		DEFAULT => -132
	},
	{#State 82
		DEFAULT => -145
	},
	{#State 83
		ACTIONS => {
			'WORD' => 136
		},
		GOTOS => {
			'LoopLabel' => 137
		}
	},
	{#State 84
		ACTIONS => {
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP01_PRINT' => 140,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'LPAREN' => 84,
			"%{" => 105,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 138,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128,
			'Operator' => 113,
			'SubExpression' => 139,
			'ArrayReference' => 111,
			'WordScoped' => 75
		}
	},
	{#State 85
		ACTIONS => {
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'LPAREN' => 84,
			"%{" => 105,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			'LBRACKET' => 93,
			"undef" => 94
		},
		GOTOS => {
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Expression' => 128,
			'Variable' => 127,
			'SubExpression' => 141,
			'ArrayReference' => 111,
			'Operator' => 113,
			'WordScoped' => 75
		}
	},
	{#State 86
		ACTIONS => {
			"for my integer" => 142,
			"while (" => 144,
			"foreach my" => 148
		},
		GOTOS => {
			'LoopFor' => 146,
			'LoopWhile' => 147,
			'LoopForEach' => 145,
			'Loop' => 143
		}
	},
	{#State 87
		ACTIONS => {
			'OP16_LOGICAL_OR' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP08_STRING_CAT' => -130,
			'OP02_METHOD_THINARROW' => 152,
			'OP08_MATH_ADD_SUB' => -130,
			'OP19_VARIABLE_ASSIGN' => 150,
			'OP04_MATH_POW' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP19_VARIABLE_ASSIGN_BY' => 149,
			'OP03_MATH_INC_DEC' => 151,
			'OP11_COMPARE_LT_GT' => -130,
			'OP07_STRING_REPEAT' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP18_TERNARY' => -130,
			'OP23_LOGICAL_AND' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130
		}
	},
	{#State 88
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP11_COMPARE_LT_GT' => 164,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_STRING_CAT' => 161,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 89
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			"%{" => 105,
			'LPAREN' => 84,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 75,
			'Operator' => 113,
			'SubExpression' => 170,
			'ArrayReference' => 111,
			'Variable' => 127,
			'Expression' => 128,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78
		}
	},
	{#State 90
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'LPAREN' => 84,
			"%{" => 105,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			"my" => 171,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'KEYS_OR_VALUES' => 174,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LBRACKET' => 93,
			"undef" => 94
		},
		GOTOS => {
			'Operator' => 113,
			'SubExpression' => 172,
			'ArrayReference' => 111,
			'ListElement' => 173,
			'WordScoped' => 75,
			'ArrayDereferenced' => 81,
			'TypeInner' => 175,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128
		}
	},
	{#State 91
		DEFAULT => -144
	},
	{#State 92
		DEFAULT => -113
	},
	{#State 93
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'OP01_QW' => 180,
			"]" => -184,
			"%{" => 105,
			'LPAREN' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			"my" => 171,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'KEYS_OR_VALUES' => 174,
			'OP22_LOGICAL_NEG' => 116,
			"undef" => 94,
			'LBRACKET' => 93
		},
		GOTOS => {
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ListElements' => 176,
			'TypeInner' => 175,
			'ArrayDereferenced' => 81,
			'Expression' => 128,
			'Variable' => 127,
			'ArrayReference' => 111,
			'SubExpression' => 177,
			'Operator' => 113,
			'OPTIONAL-45' => 179,
			'WordScoped' => 75,
			'ListElement' => 178
		}
	},
	{#State 94
		DEFAULT => -128
	},
	{#State 95
		DEFAULT => -134
	},
	{#State 96
		ACTIONS => {
			"my" => 181
		}
	},
	{#State 97
		ACTIONS => {
			'CONSTANT_SYMBOL' => 100,
			'OP16_LOGICAL_OR' => -95,
			"]" => -95,
			"%{" => 105,
			'OP08_STRING_CAT' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP01_CLOSE' => 108,
			'WORD' => 22,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP23_LOGICAL_AND' => -95,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP03_MATH_INC_DEC' => 117,
			'OP07_STRING_REPEAT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP22_LOGICAL_NEG' => 116,
			"}" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP13_BITWISE_AND' => -95,
			'LITERAL_STRING' => 74,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'OP17_LIST_RANGE' => -95,
			")" => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP04_MATH_POW' => -95,
			'LPAREN' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'OP01_NAMED' => 126,
			";" => -95,
			'OP18_TERNARY' => -95,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'OP11_COMPARE_LT_GT' => -95,
			'LITERAL_NUMBER' => 99,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP09_BITWISE_SHIFT' => -95,
			'OP06_REGEX_MATCH' => -95
		},
		GOTOS => {
			'WordScoped' => 75,
			'SubExpression' => 182,
			'ArrayReference' => 111,
			'Operator' => 113,
			'Expression' => 128,
			'Variable' => 127,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81
		}
	},
	{#State 98
		DEFAULT => -17
	},
	{#State 99
		DEFAULT => -209
	},
	{#State 100
		ACTIONS => {
			'LPAREN' => 183
		}
	},
	{#State 101
		DEFAULT => -116
	},
	{#State 102
		ACTIONS => {
			'WORD_SCOPED' => -110,
			'LBRACE' => -110,
			'OP01_NAMED' => -110,
			'LBRACKET' => -110,
			"undef" => -110,
			'STDOUT_STDERR' => 184,
			'OP05_MATH_NEG_LPAREN' => -110,
			'OP10_NAMED_UNARY' => -110,
			'OP01_OPEN' => -110,
			'LITERAL_NUMBER' => -110,
			'OP03_MATH_INC_DEC' => -110,
			'OP22_LOGICAL_NEG' => -110,
			'KEYS_OR_VALUES' => -110,
			"\@{" => -110,
			'OP10_STRINGIFY_UNARY' => -110,
			'LITERAL_STRING' => -110,
			'CONSTANT_SYMBOL' => -110,
			"my" => -110,
			'VARIABLE_SYMBOL' => -110,
			'WORD' => -110,
			'OP01_QW' => -110,
			'LPAREN' => -110,
			"%{" => -110,
			'FH_REF_SYMBOL_BRACES' => 186,
			'OP01_CLOSE' => -110,
			'OP05_LOGICAL_NEG' => -110
		},
		GOTOS => {
			'OPTIONAL-31' => 185,
			'PAREN-30' => 187
		}
	},
	{#State 103
		DEFAULT => -140
	},
	{#State 104
		ACTIONS => {
			'COLON' => -202,
			'LPAREN' => -200,
			'OP02_METHOD_THINARROW_NEW' => -200
		}
	},
	{#State 105
		ACTIONS => {
			'LBRACE' => 190,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'HashReference' => 189,
			'Variable' => 188
		}
	},
	{#State 106
		DEFAULT => -77
	},
	{#State 107
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP06_REGEX_MATCH' => -127,
			'OP09_BITWISE_SHIFT' => -127,
			'OP13_BITWISE_AND' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP18_TERNARY' => -127,
			'OP07_STRING_REPEAT' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP15_LOGICAL_AND' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			";" => 191,
			'OP12_COMPARE_EQ_NE' => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			'OP04_MATH_POW' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP08_STRING_CAT' => -127,
			'OP17_LIST_RANGE' => -127,
			'OP16_LOGICAL_OR' => -127
		}
	},
	{#State 108
		ACTIONS => {
			'FH_REF_SYMBOL' => 192
		}
	},
	{#State 109
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED_VOID' => 112,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'CONSTANT_SYMBOL' => 100,
			'OP01_PRINT' => 102,
			"%{" => 105,
			'' => -18,
			"for my integer" => -141,
			'OP01_CLOSE' => 108,
			'WORD' => 104,
			'OP01_NAMED' => 90,
			"if (" => 89,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			"foreach my" => -141,
			'LITERAL_NUMBER' => 99,
			'OP01_NAMED_VOID_SCOLON' => 92,
			"undef" => 94,
			'LBRACKET' => 93,
			"while (" => -141,
			'LITERAL_STRING' => 74,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'OP19_LOOP_CONTROL' => 83,
			'LPAREN' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"my" => 79,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'Operation' => 193,
			'Literal' => 114,
			'HashDereferenced' => 95,
			'OperatorVoid' => 91,
			'SubExpression' => 88,
			'ArrayReference' => 111,
			'Operator' => 113,
			'VariableDeclaration' => 82,
			'Expression' => 107,
			'Statement' => 106,
			'Variable' => 87,
			'OPTIONAL-35' => 86,
			'HashReference' => 78,
			'LoopLabel' => 80,
			'PAREN-34' => 103,
			'ArrayDereferenced' => 81,
			'WordScoped' => 75,
			'Conditional' => 76,
			'VariableModification' => 70
		}
	},
	{#State 110
		ACTIONS => {
			"}" => 195,
			'WORD' => 196,
			"%{" => 105
		},
		GOTOS => {
			'HashDereferenced' => 197,
			'HashEntry' => 194
		}
	},
	{#State 111
		DEFAULT => -131
	},
	{#State 112
		ACTIONS => {
			'LBRACKET' => 93,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 174,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'WORD' => 22,
			"my" => 171,
			'VARIABLE_SYMBOL' => 77,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_QW' => 180,
			'LPAREN' => 84,
			"%{" => 105,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100
		},
		GOTOS => {
			'WordScoped' => 75,
			'ListElement' => 178,
			'SubExpression' => 177,
			'ArrayReference' => 111,
			'Operator' => 113,
			'Expression' => 128,
			'Variable' => 127,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'ListElements' => 198,
			'TypeInner' => 175
		}
	},
	{#State 113
		DEFAULT => -122
	},
	{#State 114
		DEFAULT => -129
	},
	{#State 115
		ACTIONS => {
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'LBRACKET' => 93,
			"undef" => 94,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22
		},
		GOTOS => {
			'SubExpression' => 199,
			'ArrayReference' => 111,
			'Operator' => 113,
			'WordScoped' => 75,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Expression' => 128,
			'Variable' => 127
		}
	},
	{#State 116
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71
		},
		GOTOS => {
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'Expression' => 128,
			'Variable' => 127,
			'SubExpression' => 200,
			'ArrayReference' => 111,
			'Operator' => 113,
			'WordScoped' => 75
		}
	},
	{#State 117
		ACTIONS => {
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'Variable' => 201
		}
	},
	{#State 118
		ACTIONS => {
			"use" => 36,
			"our hash_ref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 203,
			'STAR-22' => 202
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
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 205
		}
	},
	{#State 123
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'Literal' => 206
		}
	},
	{#State 124
		ACTIONS => {
			'OP01_NAMED' => -43,
			"if (" => -43,
			'LITERAL_NUMBER' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP01_OPEN' => -43,
			"foreach my" => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'LBRACKET' => -43,
			"undef" => -43,
			"while (" => -43,
			'LITERAL_STRING' => -43,
			"( my" => 207,
			"\@{" => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP19_LOOP_CONTROL' => -43,
			'LPAREN' => -43,
			"my" => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP01_NAMED_VOID' => -43,
			'WORD_SCOPED' => -43,
			'LBRACE' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_PRINT' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'CONSTANT_SYMBOL' => -43,
			"for my integer" => -43,
			'OP01_CLOSE' => -43,
			"%{" => -43,
			'WORD' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 208,
			'SubroutineArguments' => 209
		}
	},
	{#State 125
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP11_COMPARE_LT_GT' => 164,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => 156,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_STRING_CAT' => 161,
			")" => 210,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 168
		}
	},
	{#State 126
		ACTIONS => {
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'Variable' => 127,
			'Expression' => 128,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78,
			'WordScoped' => 75,
			'Operator' => 113,
			'SubExpression' => 211,
			'ArrayReference' => 111
		}
	},
	{#State 127
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -130,
			";" => -130,
			'OP23_LOGICAL_AND' => -130,
			'OP18_TERNARY' => -130,
			'OP03_MATH_INC_DEC' => 151,
			'OP11_COMPARE_LT_GT' => -130,
			'OP07_STRING_REPEAT' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			"}" => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP13_BITWISE_AND' => -130,
			'OP16_LOGICAL_OR' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP08_MATH_ADD_SUB' => -130,
			")" => -130,
			"]" => -130,
			'OP04_MATH_POW' => -130,
			'OP08_STRING_CAT' => -130,
			'OP21_LIST_COMMA' => -130,
			'OP02_METHOD_THINARROW' => 152,
			'OP14_BITWISE_OR_XOR' => -130
		}
	},
	{#State 128
		DEFAULT => -127
	},
	{#State 129
		ACTIONS => {
			"}" => 212
		}
	},
	{#State 130
		ACTIONS => {
			"}" => 213
		}
	},
	{#State 131
		ACTIONS => {
			")" => 214
		}
	},
	{#State 132
		ACTIONS => {
			"%{" => 105,
			'LPAREN' => 84,
			")" => -119,
			'OP01_QW' => 180,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			"my" => 171,
			'WORD' => 22,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 174,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110
		},
		GOTOS => {
			'ArrayReference' => 111,
			'SubExpression' => 177,
			'Operator' => 113,
			'OPTIONAL-32' => 216,
			'WordScoped' => 75,
			'ListElement' => 178,
			'HashReference' => 78,
			'Literal' => 114,
			'TypeInner' => 175,
			'ListElements' => 215,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'Expression' => 128,
			'Variable' => 127
		}
	},
	{#State 133
		ACTIONS => {
			'OP23_LOGICAL_AND' => -165,
			'OP18_TERNARY' => -165,
			'OP11_COMPARE_LT_GT' => -165,
			'OP03_MATH_INC_DEC' => -165,
			'OP07_STRING_REPEAT' => -165,
			'OP24_LOGICAL_OR_XOR' => -165,
			'OP15_LOGICAL_AND' => -165,
			'OP02_HASH_THINARROW' => 219,
			"}" => -165,
			'OP07_MATH_MULT_DIV_MOD' => -165,
			'OP06_REGEX_MATCH' => -165,
			'OP09_BITWISE_SHIFT' => -165,
			'OP13_BITWISE_AND' => -165,
			'COLON' => -165,
			'OP12_COMPARE_EQ_NE' => -165,
			'OP19_VARIABLE_ASSIGN_BY' => -165,
			";" => -165,
			")" => -165,
			'OP08_MATH_ADD_SUB' => -165,
			'OP19_VARIABLE_ASSIGN' => -165,
			'OP04_MATH_POW' => -165,
			"]" => -165,
			'OP08_STRING_CAT' => -165,
			'OP21_LIST_COMMA' => -165,
			'OP02_METHOD_THINARROW' => -165,
			'OP14_BITWISE_OR_XOR' => -165,
			'OP02_ARRAY_THINARROW' => 218,
			'OP16_LOGICAL_OR' => -165,
			'OP17_LIST_RANGE' => -165
		},
		GOTOS => {
			'VariableRetrieval' => 217
		}
	},
	{#State 134
		ACTIONS => {
			'VARIABLE_SYMBOL' => 220
		}
	},
	{#State 135
		DEFAULT => -139
	},
	{#State 136
		DEFAULT => -202
	},
	{#State 137
		ACTIONS => {
			";" => 221
		}
	},
	{#State 138
		ACTIONS => {
			'LBRACKET' => 93,
			"undef" => 94,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 174,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'WORD' => 22,
			"my" => 171,
			'VARIABLE_SYMBOL' => 77,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			"%{" => 105,
			'LPAREN' => 84,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'TypeInner' => 175,
			'Expression' => 128,
			'Variable' => 127,
			'ArrayReference' => 111,
			'SubExpression' => 172,
			'Operator' => 113,
			'WordScoped' => 75,
			'ListElement' => 222
		}
	},
	{#State 139
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP11_COMPARE_LT_GT' => 164,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => 156,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_MATH_ADD_SUB' => 169,
			")" => 223,
			'OP04_MATH_POW' => 168,
			'OP08_STRING_CAT' => 161
		}
	},
	{#State 140
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 224
		}
	},
	{#State 141
		ACTIONS => {
			";" => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			"}" => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP18_TERNARY' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			")" => -86,
			'OP08_MATH_ADD_SUB' => -86,
			"]" => -86,
			'OP04_MATH_POW' => 168,
			'OP08_STRING_CAT' => -86,
			'OP21_LIST_COMMA' => -86
		}
	},
	{#State 142
		ACTIONS => {
			'VARIABLE_SYMBOL' => 225
		}
	},
	{#State 143
		DEFAULT => -143
	},
	{#State 144
		ACTIONS => {
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			"undef" => 94,
			'LBRACKET' => 93
		},
		GOTOS => {
			'Variable' => 127,
			'Expression' => 128,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78,
			'WordScoped' => 75,
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 226
		}
	},
	{#State 145
		DEFAULT => -155
	},
	{#State 146
		DEFAULT => -154
	},
	{#State 147
		DEFAULT => -156
	},
	{#State 148
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 227
		}
	},
	{#State 149
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'LBRACKET' => 93,
			"undef" => 94,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			"%{" => 105,
			'LPAREN' => 84
		},
		GOTOS => {
			'Expression' => 128,
			'Variable' => 127,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'WordScoped' => 75,
			'SubExpression' => 228,
			'ArrayReference' => 111,
			'Operator' => 113
		}
	},
	{#State 150
		ACTIONS => {
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			'STDIN' => 229,
			"\@{" => 72
		},
		GOTOS => {
			'WordScoped' => 75,
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 230,
			'Variable' => 127,
			'SubExpressionOrStdin' => 231,
			'Expression' => 128,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78
		}
	},
	{#State 151
		DEFAULT => -84
	},
	{#State 152
		ACTIONS => {
			'LPAREN' => 232
		}
	},
	{#State 153
		ACTIONS => {
			"undef" => 94,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 126,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			"%{" => 105,
			'LPAREN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'WordScoped' => 75,
			'ArrayReference' => 111,
			'SubExpression' => 233,
			'Operator' => 113,
			'Expression' => 128,
			'Variable' => 127,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81
		}
	},
	{#State 154
		ACTIONS => {
			'LPAREN' => 84,
			"%{" => 105,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'Operator' => 113,
			'SubExpression' => 234,
			'ArrayReference' => 111,
			'WordScoped' => 75,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78,
			'Variable' => 127,
			'Expression' => 128
		}
	},
	{#State 155
		ACTIONS => {
			"undef" => 94,
			'LBRACKET' => 93,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 126,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'Expression' => 128,
			'Variable' => 127,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'WordScoped' => 75,
			'ArrayReference' => 111,
			'SubExpression' => 235,
			'Operator' => 113
		}
	},
	{#State 156
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			"%{" => 105,
			'LPAREN' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117
		},
		GOTOS => {
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Expression' => 128,
			'Variable' => 127,
			'ArrayReference' => 111,
			'SubExpression' => 236,
			'Operator' => 113,
			'WordScoped' => 75
		}
	},
	{#State 157
		ACTIONS => {
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'LBRACKET' => 93,
			"undef" => 94,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22
		},
		GOTOS => {
			'Operator' => 113,
			'SubExpression' => 237,
			'ArrayReference' => 111,
			'WordScoped' => 75,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128
		}
	},
	{#State 158
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			"%{" => 105,
			'LPAREN' => 84,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71
		},
		GOTOS => {
			'WordScoped' => 75,
			'ArrayReference' => 111,
			'SubExpression' => 238,
			'Operator' => 113,
			'Expression' => 128,
			'Variable' => 127,
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95
		}
	},
	{#State 159
		ACTIONS => {
			'LBRACKET' => 93,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100
		},
		GOTOS => {
			'Expression' => 128,
			'Variable' => 127,
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'WordScoped' => 75,
			'SubExpression' => 239,
			'ArrayReference' => 111,
			'Operator' => 113
		}
	},
	{#State 160
		ACTIONS => {
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			"%{" => 105,
			'LPAREN' => 84,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128,
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 240,
			'WordScoped' => 75
		}
	},
	{#State 161
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LPAREN' => 84,
			"%{" => 105,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'LBRACKET' => 93,
			"undef" => 94
		},
		GOTOS => {
			'WordScoped' => 75,
			'SubExpression' => 241,
			'ArrayReference' => 111,
			'Operator' => 113,
			'Expression' => 128,
			'Variable' => 127,
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95
		}
	},
	{#State 162
		ACTIONS => {
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			"%{" => 105,
			'LPAREN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 126,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'ArrayReference' => 111,
			'SubExpression' => 242,
			'Operator' => 113,
			'WordScoped' => 75,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Expression' => 128,
			'Variable' => 127
		}
	},
	{#State 163
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 99,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'Variable' => 245,
			'Literal' => 244,
			'VariableOrLiteral' => 243
		}
	},
	{#State 164
		ACTIONS => {
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'LPAREN' => 84,
			"%{" => 105,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LBRACKET' => 93,
			"undef" => 94
		},
		GOTOS => {
			'Operator' => 113,
			'SubExpression' => 246,
			'ArrayReference' => 111,
			'WordScoped' => 75,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128
		}
	},
	{#State 165
		ACTIONS => {
			'LBRACKET' => 93,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'WordScoped' => 75,
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 247,
			'Variable' => 127,
			'Expression' => 128,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114
		}
	},
	{#State 166
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 248
		}
	},
	{#State 167
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'LPAREN' => 84,
			"%{" => 105,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 126,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128,
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 249,
			'WordScoped' => 75
		}
	},
	{#State 168
		ACTIONS => {
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			"%{" => 105,
			'LPAREN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126
		},
		GOTOS => {
			'ArrayReference' => 111,
			'SubExpression' => 250,
			'Operator' => 113,
			'WordScoped' => 75,
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'Expression' => 128,
			'Variable' => 127
		}
	},
	{#State 169
		ACTIONS => {
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			"%{" => 105,
			'LPAREN' => 84,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			"undef" => 94,
			'LBRACKET' => 93
		},
		GOTOS => {
			'WordScoped' => 75,
			'ArrayReference' => 111,
			'SubExpression' => 251,
			'Operator' => 113,
			'Expression' => 128,
			'Variable' => 127,
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95
		}
	},
	{#State 170
		ACTIONS => {
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			")" => 252,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP16_LOGICAL_OR' => 160,
			'OP17_LIST_RANGE' => 167,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP11_COMPARE_LT_GT' => 164,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP12_COMPARE_EQ_NE' => 153
		}
	},
	{#State 171
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 253
		}
	},
	{#State 172
		ACTIONS => {
			'OP23_LOGICAL_AND' => -79,
			'OP18_TERNARY' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			";" => -79,
			")" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP04_MATH_POW' => -79,
			'OP08_STRING_CAT' => -79,
			'OP21_LIST_COMMA' => -180,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP17_LIST_RANGE' => -79
		}
	},
	{#State 173
		ACTIONS => {
			'OP21_LIST_COMMA' => 254
		}
	},
	{#State 174
		ACTIONS => {
			"%{" => 105
		},
		GOTOS => {
			'HashDereferenced' => 255
		}
	},
	{#State 175
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			"%{" => 105,
			'LPAREN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71
		},
		GOTOS => {
			'Expression' => 128,
			'Variable' => 127,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'WordScoped' => 75,
			'SubExpression' => 256,
			'ArrayReference' => 111,
			'Operator' => 113
		}
	},
	{#State 176
		DEFAULT => -183
	},
	{#State 177
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_STRING_CAT' => 161,
			'OP21_LIST_COMMA' => -180,
			")" => -180,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 168,
			"]" => -180,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP11_COMPARE_LT_GT' => 164,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 154,
			";" => -180,
			'OP12_COMPARE_EQ_NE' => 153
		}
	},
	{#State 178
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 257
		}
	},
	{#State 179
		ACTIONS => {
			"]" => 258
		}
	},
	{#State 180
		ACTIONS => {
			'WORD' => 260
		},
		GOTOS => {
			'PLUS-44' => 259
		}
	},
	{#State 181
		ACTIONS => {
			"filehandle_ref" => 261
		}
	},
	{#State 182
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -94,
			";" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => 157,
			'OP18_TERNARY' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => -94,
			"}" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP16_LOGICAL_OR' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP08_STRING_CAT' => 161,
			'OP21_LIST_COMMA' => -94,
			'OP08_MATH_ADD_SUB' => 169,
			")" => -94,
			"]" => -94,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => -94
		}
	},
	{#State 183
		ACTIONS => {
			")" => 262
		}
	},
	{#State 184
		DEFAULT => -108
	},
	{#State 185
		ACTIONS => {
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_QW' => 180,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'VARIABLE_SYMBOL' => 77,
			"my" => 171,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'KEYS_OR_VALUES' => 174,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110
		},
		GOTOS => {
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 177,
			'ListElement' => 178,
			'WordScoped' => 75,
			'ListElements' => 263,
			'ArrayDereferenced' => 81,
			'TypeInner' => 175,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128
		}
	},
	{#State 186
		ACTIONS => {
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 126,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'KEYS_OR_VALUES' => 174,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'VARIABLE_SYMBOL' => 77,
			"my" => 171,
			'WORD' => 22,
			"%{" => 105,
			'LPAREN' => 84,
			'OP01_QW' => 180,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108
		},
		GOTOS => {
			'TypeInner' => 175,
			'ListElements' => 264,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128,
			'Operator' => 113,
			'SubExpression' => 177,
			'ArrayReference' => 111,
			'ListElement' => 178,
			'WordScoped' => 75
		}
	},
	{#State 187
		DEFAULT => -109
	},
	{#State 188
		ACTIONS => {
			"}" => 265
		}
	},
	{#State 189
		ACTIONS => {
			"}" => 266
		}
	},
	{#State 190
		ACTIONS => {
			'WORD' => 196,
			"%{" => 105
		},
		GOTOS => {
			'HashEntry' => 194,
			'HashDereferenced' => 197
		}
	},
	{#State 191
		DEFAULT => -76
	},
	{#State 192
		DEFAULT => -82
	},
	{#State 193
		DEFAULT => -16
	},
	{#State 194
		DEFAULT => -196,
		GOTOS => {
			'STAR-48' => 267
		}
	},
	{#State 195
		DEFAULT => -135
	},
	{#State 196
		ACTIONS => {
			'OP20_HASH_FATARROW' => 268
		}
	},
	{#State 197
		DEFAULT => -191
	},
	{#State 198
		ACTIONS => {
			";" => 269
		}
	},
	{#State 199
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP11_COMPARE_LT_GT' => 164,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			")" => 270
		}
	},
	{#State 200
		ACTIONS => {
			";" => -105,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP06_REGEX_MATCH' => 166,
			"}" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => -105,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_STRING_CAT' => 161,
			'OP21_LIST_COMMA' => -105,
			'OP08_MATH_ADD_SUB' => 169,
			")" => -105,
			'OP04_MATH_POW' => 168,
			"]" => -105
		}
	},
	{#State 201
		DEFAULT => -83
	},
	{#State 202
		ACTIONS => {
			"use constant" => 46,
			"our hash_ref \$properties" => 273
		},
		GOTOS => {
			'Properties' => 272,
			'Constant' => 271
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
			"\$TYPED_" => 274
		}
	},
	{#State 206
		ACTIONS => {
			";" => 275
		}
	},
	{#State 207
		ACTIONS => {
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 276
		}
	},
	{#State 208
		ACTIONS => {
			'OP01_PRINT' => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'CONSTANT_SYMBOL' => 100,
			'OP01_CLOSE' => 108,
			"for my integer" => -141,
			"%{" => 105,
			'WORD' => 104,
			'OP01_NAMED_VOID' => 112,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 115,
			'LITERAL_STRING' => 74,
			"while (" => -141,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'OP05_LOGICAL_NEG' => 85,
			'LPAREN' => 84,
			'OP19_LOOP_CONTROL' => 83,
			"my" => 79,
			'VARIABLE_SYMBOL' => 77,
			'OP01_NAMED' => 90,
			"if (" => 89,
			'LITERAL_NUMBER' => 99,
			'OP10_NAMED_UNARY' => 97,
			"foreach my" => -141,
			'OP01_OPEN' => 96,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'LBRACKET' => 93,
			"undef" => 94
		},
		GOTOS => {
			'Literal' => 114,
			'HashDereferenced' => 95,
			'Operation' => 278,
			'ArrayReference' => 111,
			'SubExpression' => 88,
			'Operator' => 113,
			'OperatorVoid' => 91,
			'HashReference' => 78,
			'LoopLabel' => 80,
			'ArrayDereferenced' => 81,
			'PAREN-34' => 103,
			'VariableDeclaration' => 82,
			'Statement' => 106,
			'Expression' => 107,
			'PLUS-17' => 277,
			'OPTIONAL-35' => 86,
			'Variable' => 87,
			'VariableModification' => 70,
			'WordScoped' => 75,
			'Conditional' => 76
		}
	},
	{#State 209
		DEFAULT => -42
	},
	{#State 210
		DEFAULT => -96
	},
	{#State 211
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -79,
			";" => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP18_TERNARY' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP13_BITWISE_AND' => -79,
			"}" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP08_STRING_CAT' => -79,
			'OP21_LIST_COMMA' => -79,
			")" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			"]" => -79,
			'OP04_MATH_POW' => -79,
			'OP14_BITWISE_OR_XOR' => -79
		}
	},
	{#State 212
		DEFAULT => -187
	},
	{#State 213
		DEFAULT => -186
	},
	{#State 214
		DEFAULT => -126
	},
	{#State 215
		DEFAULT => -118
	},
	{#State 216
		ACTIONS => {
			")" => 279
		}
	},
	{#State 217
		DEFAULT => -163
	},
	{#State 218
		ACTIONS => {
			"undef" => 94,
			'LBRACKET' => 93,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			"%{" => 105,
			'LPAREN' => 84,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128,
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 280,
			'WordScoped' => 75
		}
	},
	{#State 219
		ACTIONS => {
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'LBRACKET' => 93,
			"undef" => 94,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 281
		},
		GOTOS => {
			'WordScoped' => 75,
			'Operator' => 113,
			'SubExpression' => 282,
			'ArrayReference' => 111,
			'Variable' => 127,
			'Expression' => 128,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78
		}
	},
	{#State 220
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 283,
			";" => 284
		}
	},
	{#State 221
		DEFAULT => -117
	},
	{#State 222
		ACTIONS => {
			'OP21_LIST_COMMA' => 285
		}
	},
	{#State 223
		DEFAULT => -136
	},
	{#State 224
		ACTIONS => {
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 174,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'LBRACKET' => 93,
			"undef" => 94,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_QW' => 180,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			"my" => 171,
			'WORD' => 22
		},
		GOTOS => {
			'Operator' => 113,
			'SubExpression' => 177,
			'ArrayReference' => 111,
			'ListElement' => 178,
			'WordScoped' => 75,
			'HashDereferenced' => 95,
			'TypeInner' => 175,
			'ArrayDereferenced' => 81,
			'ListElements' => 286,
			'Literal' => 114,
			'HashReference' => 78,
			'Variable' => 127,
			'Expression' => 128
		}
	},
	{#State 225
		ACTIONS => {
			'LPAREN' => 287
		}
	},
	{#State 226
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => 156,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP11_COMPARE_LT_GT' => 164,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP16_LOGICAL_OR' => 160,
			'OP17_LIST_RANGE' => 167,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			")" => 288,
			'OP08_MATH_ADD_SUB' => 169,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 227
		ACTIONS => {
			'VARIABLE_SYMBOL' => 289
		}
	},
	{#State 228
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			";" => 290,
			'OP11_COMPARE_LT_GT' => 164,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 154,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP16_LOGICAL_OR' => 160,
			'OP17_LIST_RANGE' => 167,
			'OP08_STRING_CAT' => 161,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 229
		DEFAULT => -138
	},
	{#State 230
		ACTIONS => {
			";" => -137,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP11_COMPARE_LT_GT' => 164,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP08_STRING_CAT' => 161
		}
	},
	{#State 231
		ACTIONS => {
			";" => 291
		}
	},
	{#State 232
		ACTIONS => {
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 174,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			'LBRACKET' => 93,
			"undef" => 94,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'OP01_QW' => 180,
			")" => -121,
			'LPAREN' => 84,
			"%{" => 105,
			'WORD' => 22,
			"my" => 171,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'HashDereferenced' => 95,
			'TypeInner' => 175,
			'ListElements' => 292,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78,
			'Variable' => 127,
			'Expression' => 128,
			'Operator' => 113,
			'OPTIONAL-33' => 293,
			'SubExpression' => 177,
			'ArrayReference' => 111,
			'ListElement' => 178,
			'WordScoped' => 75
		}
	},
	{#State 233
		ACTIONS => {
			'OP18_TERNARY' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_STRING_REPEAT' => 157,
			'OP11_COMPARE_LT_GT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP12_COMPARE_EQ_NE' => undef,
			";" => -98,
			'OP04_MATH_POW' => 168,
			"]" => -98,
			")" => -98,
			'OP08_MATH_ADD_SUB' => 169,
			'OP21_LIST_COMMA' => -98,
			'OP08_STRING_CAT' => 161,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP17_LIST_RANGE' => -98
		}
	},
	{#State 234
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 162,
			'OP21_LIST_COMMA' => -106,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			"]" => -106,
			")" => -106,
			'OP08_MATH_ADD_SUB' => 169,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP13_BITWISE_AND' => 159,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -106,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => 156,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => 164,
			'OP23_LOGICAL_AND' => -106,
			'OP18_TERNARY' => 163,
			";" => -106,
			'OP12_COMPARE_EQ_NE' => 153
		}
	},
	{#State 235
		ACTIONS => {
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP21_LIST_COMMA' => -107,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			"]" => -107,
			")" => -107,
			'OP08_MATH_ADD_SUB' => 169,
			";" => -107,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -107,
			'OP15_LOGICAL_AND' => 156,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP07_STRING_REPEAT' => 157,
			'OP11_COMPARE_LT_GT' => 164,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163
		}
	},
	{#State 236
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -101,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP11_COMPARE_LT_GT' => 164,
			'OP18_TERNARY' => -101,
			'OP23_LOGICAL_AND' => -101,
			";" => -101,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP21_LIST_COMMA' => -101,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			"]" => -101,
			'OP08_MATH_ADD_SUB' => 169,
			")" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP16_LOGICAL_OR' => -101
		}
	},
	{#State 237
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -89,
			'OP08_STRING_CAT' => -89,
			'OP21_LIST_COMMA' => -89,
			")" => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP04_MATH_POW' => 168,
			"]" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => -89,
			"}" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP18_TERNARY' => -89,
			";" => -89,
			'OP12_COMPARE_EQ_NE' => -89
		}
	},
	{#State 238
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -90,
			";" => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP18_TERNARY' => -90,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			"}" => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP08_STRING_CAT' => -90,
			"]" => -90,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => -90,
			")" => -90,
			'OP14_BITWISE_OR_XOR' => -90
		}
	},
	{#State 239
		ACTIONS => {
			'OP04_MATH_POW' => 168,
			"]" => -99,
			")" => -99,
			'OP08_MATH_ADD_SUB' => 169,
			'OP21_LIST_COMMA' => -99,
			'OP08_STRING_CAT' => 161,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP18_TERNARY' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => 157,
			'OP11_COMPARE_LT_GT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -99,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => -99,
			'OP12_COMPARE_EQ_NE' => 153,
			";" => -99
		}
	},
	{#State 240
		ACTIONS => {
			'OP17_LIST_RANGE' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP21_LIST_COMMA' => -102,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			"]" => -102,
			'OP08_MATH_ADD_SUB' => 169,
			")" => -102,
			";" => -102,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -102,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => 164,
			'OP23_LOGICAL_AND' => -102,
			'OP18_TERNARY' => -102
		}
	},
	{#State 241
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -92,
			";" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP18_TERNARY' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => -92,
			"}" => -92,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP08_MATH_ADD_SUB' => 169,
			")" => -92,
			'OP04_MATH_POW' => 168,
			"]" => -92,
			'OP08_STRING_CAT' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP14_BITWISE_OR_XOR' => -92
		}
	},
	{#State 242
		ACTIONS => {
			";" => -100,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_STRING_REPEAT' => 157,
			'OP11_COMPARE_LT_GT' => 164,
			'OP23_LOGICAL_AND' => -100,
			'OP18_TERNARY' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			"]" => -100,
			'OP08_MATH_ADD_SUB' => 169,
			")" => -100
		}
	},
	{#State 243
		ACTIONS => {
			'COLON' => 294
		}
	},
	{#State 244
		DEFAULT => -207
	},
	{#State 245
		DEFAULT => -206
	},
	{#State 246
		ACTIONS => {
			'OP08_STRING_CAT' => 161,
			'OP21_LIST_COMMA' => -97,
			")" => -97,
			'OP08_MATH_ADD_SUB' => 169,
			"]" => -97,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP11_COMPARE_LT_GT' => undef,
			'OP15_LOGICAL_AND' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP07_STRING_REPEAT' => 157,
			'OP23_LOGICAL_AND' => -97,
			'OP18_TERNARY' => -97,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => -97,
			"}" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP12_COMPARE_EQ_NE' => -97,
			";" => -97
		}
	},
	{#State 247
		ACTIONS => {
			";" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			"}" => -93,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP13_BITWISE_AND' => -93,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP18_TERNARY' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP07_STRING_REPEAT' => 157,
			'OP17_LIST_RANGE' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP08_MATH_ADD_SUB' => 169,
			")" => -93,
			"]" => -93,
			'OP04_MATH_POW' => 168,
			'OP08_STRING_CAT' => 161,
			'OP21_LIST_COMMA' => -93
		}
	},
	{#State 248
		DEFAULT => -88
	},
	{#State 249
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			";" => -103,
			'OP18_TERNARY' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => -103,
			"}" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP16_LOGICAL_OR' => 160,
			'OP17_LIST_RANGE' => undef,
			")" => -103,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 168,
			"]" => -103,
			'OP08_STRING_CAT' => 161,
			'OP21_LIST_COMMA' => -103,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 250
		ACTIONS => {
			'OP04_MATH_POW' => 168,
			"]" => -85,
			")" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP08_STRING_CAT' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP18_TERNARY' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			"}" => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			";" => -85
		}
	},
	{#State 251
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP08_STRING_CAT' => -91,
			'OP04_MATH_POW' => 168,
			"]" => -91,
			'OP08_MATH_ADD_SUB' => -91,
			")" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP18_TERNARY' => -91,
			";" => -91,
			'OP12_COMPARE_EQ_NE' => -91
		}
	},
	{#State 252
		ACTIONS => {
			'LBRACE' => 295
		},
		GOTOS => {
			'CodeBlock' => 296
		}
	},
	{#State 253
		ACTIONS => {
			"\$TYPED_" => 297
		}
	},
	{#State 254
		ACTIONS => {
			'LBRACKET' => 93,
			"undef" => 94,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'KEYS_OR_VALUES' => 174,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'WORD' => 22,
			"my" => 171,
			'VARIABLE_SYMBOL' => 77,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'OP01_QW' => 180,
			"%{" => 105,
			'LPAREN' => 84,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100
		},
		GOTOS => {
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'ListElements' => 298,
			'TypeInner' => 175,
			'Expression' => 128,
			'Variable' => 127,
			'SubExpression' => 177,
			'ArrayReference' => 111,
			'Operator' => 113,
			'WordScoped' => 75,
			'ListElement' => 178
		}
	},
	{#State 255
		DEFAULT => -182
	},
	{#State 256
		ACTIONS => {
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_MATH_ADD_SUB' => 169,
			")" => -181,
			"]" => -181,
			'OP04_MATH_POW' => 168,
			'OP08_STRING_CAT' => 161,
			'OP21_LIST_COMMA' => -181,
			";" => -181,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP13_BITWISE_AND' => 159,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP11_COMPARE_LT_GT' => 164,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => 155
		}
	},
	{#State 257
		ACTIONS => {
			";" => -178,
			")" => -178,
			"]" => -178,
			'OP21_LIST_COMMA' => 300
		},
		GOTOS => {
			'PAREN-42' => 299
		}
	},
	{#State 258
		DEFAULT => -185
	},
	{#State 259
		ACTIONS => {
			")" => 301,
			'WORD' => 302
		}
	},
	{#State 260
		DEFAULT => -177
	},
	{#State 261
		ACTIONS => {
			'FH_REF_SYMBOL' => 303
		}
	},
	{#State 262
		DEFAULT => -124
	},
	{#State 263
		ACTIONS => {
			";" => 304
		}
	},
	{#State 264
		ACTIONS => {
			";" => 305
		}
	},
	{#State 265
		DEFAULT => -198
	},
	{#State 266
		DEFAULT => -199
	},
	{#State 267
		ACTIONS => {
			'OP21_LIST_COMMA' => 308,
			"}" => 307
		},
		GOTOS => {
			'PAREN-47' => 306
		}
	},
	{#State 268
		ACTIONS => {
			"\@{" => -189,
			'OP10_STRINGIFY_UNARY' => -189,
			'LITERAL_STRING' => -189,
			'CONSTANT_SYMBOL' => -189,
			'WORD' => -189,
			"my" => 171,
			'VARIABLE_SYMBOL' => -189,
			'OP01_CLOSE' => -189,
			'OP05_LOGICAL_NEG' => -189,
			"%{" => -189,
			'LPAREN' => -189,
			'LBRACE' => -189,
			'WORD_SCOPED' => -189,
			'OP01_NAMED' => -189,
			'LBRACKET' => -189,
			"undef" => -189,
			'OP03_MATH_INC_DEC' => -189,
			'LITERAL_NUMBER' => -189,
			'OP22_LOGICAL_NEG' => -189,
			'OP10_NAMED_UNARY' => -189,
			'OP05_MATH_NEG_LPAREN' => -189,
			'OP01_OPEN' => -189
		},
		GOTOS => {
			'OPTIONAL-46' => 310,
			'TypeInner' => 309
		}
	},
	{#State 269
		DEFAULT => -114
	},
	{#State 270
		DEFAULT => -87
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
			'CONSTANT_SYMBOL' => 313
		}
	},
	{#State 275
		DEFAULT => -41
	},
	{#State 276
		ACTIONS => {
			'VARIABLE_SYMBOL' => 314
		}
	},
	{#State 277
		ACTIONS => {
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'LITERAL_NUMBER' => 99,
			'OP10_NAMED_UNARY' => 97,
			"foreach my" => -141,
			'OP01_OPEN' => 96,
			"if (" => 89,
			'OP01_NAMED' => 90,
			"my" => 79,
			'VARIABLE_SYMBOL' => 77,
			'OP05_LOGICAL_NEG' => 85,
			'LPAREN' => 84,
			'OP19_LOOP_CONTROL' => 83,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			"while (" => -141,
			'LITERAL_STRING' => 74,
			"}" => 315,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_NAMED_VOID' => 112,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'WORD' => 104,
			'OP01_CLOSE' => 108,
			"for my integer" => -141,
			"%{" => 105,
			'OP01_PRINT' => 102,
			'CONSTANT_SYMBOL' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 101
		},
		GOTOS => {
			'OperatorVoid' => 91,
			'Operator' => 113,
			'SubExpression' => 88,
			'ArrayReference' => 111,
			'Operation' => 316,
			'HashDereferenced' => 95,
			'Literal' => 114,
			'Conditional' => 76,
			'WordScoped' => 75,
			'VariableModification' => 70,
			'OPTIONAL-35' => 86,
			'Variable' => 87,
			'Expression' => 107,
			'Statement' => 106,
			'VariableDeclaration' => 82,
			'PAREN-34' => 103,
			'ArrayDereferenced' => 81,
			'LoopLabel' => 80,
			'HashReference' => 78
		}
	},
	{#State 278
		DEFAULT => -45
	},
	{#State 279
		DEFAULT => -123
	},
	{#State 280
		ACTIONS => {
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			"]" => 317,
			'OP08_MATH_ADD_SUB' => 169,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP11_COMPARE_LT_GT' => 164,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 154
		}
	},
	{#State 281
		ACTIONS => {
			"}" => 318,
			'OP02_METHOD_THINARROW_NEW' => -200,
			'LPAREN' => -200
		}
	},
	{#State 282
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP11_COMPARE_LT_GT' => 164,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => 319,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP16_LOGICAL_OR' => 160,
			'OP17_LIST_RANGE' => 167
		}
	},
	{#State 283
		ACTIONS => {
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 97,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_OPEN' => 96,
			"undef" => 94,
			'LBRACKET' => 93,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			"\@{" => 72,
			'STDIN' => 229,
			'OP10_STRINGIFY_UNARY' => 71,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			"%{" => 105,
			'LPAREN' => 84,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'SubExpression' => 230,
			'ArrayReference' => 111,
			'Operator' => 113,
			'WordScoped' => 75,
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'Expression' => 128,
			'SubExpressionOrStdin' => 320,
			'Variable' => 127
		}
	},
	{#State 284
		DEFAULT => -169
	},
	{#State 285
		ACTIONS => {
			'KEYS_OR_VALUES' => 174,
			'OP22_LOGICAL_NEG' => 116,
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_QW' => 180,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			"my" => 171,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72
		},
		GOTOS => {
			'ListElement' => 178,
			'WordScoped' => 75,
			'Operator' => 113,
			'SubExpression' => 177,
			'ArrayReference' => 111,
			'Variable' => 127,
			'Expression' => 128,
			'ListElements' => 321,
			'TypeInner' => 175,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114
		}
	},
	{#State 286
		ACTIONS => {
			")" => 322
		}
	},
	{#State 287
		ACTIONS => {
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'LPAREN' => 84,
			"%{" => 105,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72
		},
		GOTOS => {
			'Expression' => 128,
			'Variable' => 127,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'WordScoped' => 75,
			'ArrayReference' => 111,
			'SubExpression' => 323,
			'Operator' => 113
		}
	},
	{#State 288
		ACTIONS => {
			'LBRACE' => 295
		},
		GOTOS => {
			'CodeBlock' => 324
		}
	},
	{#State 289
		ACTIONS => {
			'LPAREN' => 325
		}
	},
	{#State 290
		DEFAULT => -172
	},
	{#State 291
		DEFAULT => -171
	},
	{#State 292
		DEFAULT => -120
	},
	{#State 293
		ACTIONS => {
			")" => 326
		}
	},
	{#State 294
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 99,
			'VARIABLE_SYMBOL' => 77
		},
		GOTOS => {
			'Literal' => 244,
			'VariableOrLiteral' => 327,
			'Variable' => 245
		}
	},
	{#State 295
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 85,
			'LPAREN' => 84,
			'OP19_LOOP_CONTROL' => 83,
			'VARIABLE_SYMBOL' => 77,
			"my" => 79,
			"while (" => -141,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LITERAL_NUMBER' => 99,
			"foreach my" => -141,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'OP01_NAMED' => 90,
			"if (" => 89,
			'OP01_CLOSE' => 108,
			"for my integer" => -141,
			"%{" => 105,
			'WORD' => 104,
			'OP01_PRINT' => 102,
			'CONSTANT_SYMBOL' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP01_NAMED_VOID' => 112,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110
		},
		GOTOS => {
			'Operation' => 329,
			'HashDereferenced' => 95,
			'Literal' => 114,
			'PLUS-40' => 328,
			'OperatorVoid' => 91,
			'Operator' => 113,
			'SubExpression' => 88,
			'ArrayReference' => 111,
			'Variable' => 87,
			'OPTIONAL-35' => 86,
			'VariableDeclaration' => 82,
			'Expression' => 107,
			'Statement' => 106,
			'PAREN-34' => 103,
			'ArrayDereferenced' => 81,
			'HashReference' => 78,
			'LoopLabel' => 80,
			'Conditional' => 76,
			'WordScoped' => 75,
			'VariableModification' => 70
		}
	},
	{#State 296
		DEFAULT => -149,
		GOTOS => {
			'STAR-37' => 330
		}
	},
	{#State 297
		ACTIONS => {
			'WORD' => 331
		}
	},
	{#State 298
		ACTIONS => {
			";" => 332
		}
	},
	{#State 299
		DEFAULT => -174
	},
	{#State 300
		ACTIONS => {
			'LPAREN' => 84,
			"%{" => 105,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			"my" => 171,
			'WORD' => 22,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'KEYS_OR_VALUES' => 174,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 75,
			'ListElement' => 333,
			'SubExpression' => 177,
			'ArrayReference' => 111,
			'Operator' => 113,
			'Expression' => 128,
			'Variable' => 127,
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'TypeInner' => 175,
			'HashDereferenced' => 95
		}
	},
	{#State 301
		DEFAULT => -179
	},
	{#State 302
		DEFAULT => -176
	},
	{#State 303
		ACTIONS => {
			'OP21_LIST_COMMA' => 334
		}
	},
	{#State 304
		DEFAULT => -111
	},
	{#State 305
		DEFAULT => -112
	},
	{#State 306
		DEFAULT => -195
	},
	{#State 307
		DEFAULT => -197
	},
	{#State 308
		ACTIONS => {
			"%{" => 105,
			'WORD' => 196
		},
		GOTOS => {
			'HashEntry' => 335,
			'HashDereferenced' => 197
		}
	},
	{#State 309
		DEFAULT => -188
	},
	{#State 310
		ACTIONS => {
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_NAMED' => 126,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			"%{" => 105,
			'LPAREN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72
		},
		GOTOS => {
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114,
			'Variable' => 127,
			'Expression' => 128,
			'Operator' => 113,
			'SubExpression' => 336,
			'ArrayReference' => 111,
			'WordScoped' => 75
		}
	},
	{#State 311
		ACTIONS => {
			"our" => 338,
			'LITERAL_NUMBER' => 340
		},
		GOTOS => {
			'MethodOrSubroutine' => 337,
			'Subroutine' => 339,
			'Method' => 341
		}
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 342
		}
	},
	{#State 313
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 343
		}
	},
	{#State 314
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 344
		}
	},
	{#State 315
		ACTIONS => {
			";" => 345
		}
	},
	{#State 316
		DEFAULT => -44
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
			";" => 346
		}
	},
	{#State 321
		ACTIONS => {
			")" => 347
		}
	},
	{#State 322
		DEFAULT => -78
	},
	{#State 323
		ACTIONS => {
			'OP17_LIST_RANGE' => 348,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_STRING_CAT' => 161,
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP11_COMPARE_LT_GT' => 164,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 154
		}
	},
	{#State 324
		DEFAULT => -159
	},
	{#State 325
		ACTIONS => {
			'LBRACKET' => 93,
			"undef" => 94,
			'KEYS_OR_VALUES' => 174,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			"my" => 171,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			"%{" => 105,
			'LPAREN' => 84,
			'OP01_QW' => 180,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'HashReference' => 78,
			'Literal' => 114,
			'ArrayDereferenced' => 81,
			'TypeInner' => 175,
			'ListElements' => 349,
			'HashDereferenced' => 95,
			'Expression' => 128,
			'Variable' => 127,
			'ArrayReference' => 111,
			'SubExpression' => 177,
			'Operator' => 113,
			'WordScoped' => 75,
			'ListElement' => 178
		}
	},
	{#State 326
		DEFAULT => -125
	},
	{#State 327
		DEFAULT => -104
	},
	{#State 328
		ACTIONS => {
			'CONSTANT_SYMBOL' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP01_PRINT' => 102,
			'WORD' => 104,
			"%{" => 105,
			"for my integer" => -141,
			'OP01_CLOSE' => 108,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED_VOID' => 112,
			"}" => 350,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			"while (" => -141,
			'LITERAL_STRING' => 74,
			"my" => 79,
			'VARIABLE_SYMBOL' => 77,
			'OP19_LOOP_CONTROL' => 83,
			'LPAREN' => 84,
			'OP05_LOGICAL_NEG' => 85,
			"if (" => 89,
			'OP01_NAMED' => 90,
			'OP01_NAMED_VOID_SCOLON' => 92,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			"foreach my" => -141,
			'LITERAL_NUMBER' => 99
		},
		GOTOS => {
			'Conditional' => 76,
			'WordScoped' => 75,
			'VariableModification' => 70,
			'Variable' => 87,
			'OPTIONAL-35' => 86,
			'Statement' => 106,
			'Expression' => 107,
			'VariableDeclaration' => 82,
			'PAREN-34' => 103,
			'ArrayDereferenced' => 81,
			'LoopLabel' => 80,
			'HashReference' => 78,
			'OperatorVoid' => 91,
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 88,
			'Operation' => 351,
			'HashDereferenced' => 95,
			'Literal' => 114
		}
	},
	{#State 329
		DEFAULT => -161
	},
	{#State 330
		ACTIONS => {
			'OP01_NAMED_VOID' => -152,
			'LBRACE' => -152,
			'WORD_SCOPED' => -152,
			"elsif (" => 353,
			"}" => -152,
			'OP22_LOGICAL_NEG' => -152,
			'OP03_MATH_INC_DEC' => -152,
			'OP05_MATH_NEG_LPAREN' => -152,
			'OP01_PRINT' => -152,
			'OP19_LOOP_CONTROL_SCOLON' => -152,
			'CONSTANT_SYMBOL' => -152,
			'WORD' => -152,
			'OP01_CLOSE' => -152,
			"for my integer" => -152,
			'' => -152,
			"else" => 355,
			"%{" => -152,
			"if (" => -152,
			'OP01_NAMED' => -152,
			'OP01_NAMED_VOID_SCOLON' => -152,
			'LBRACKET' => -152,
			"undef" => -152,
			'LITERAL_NUMBER' => -152,
			"foreach my" => -152,
			'OP01_OPEN' => -152,
			'OP10_NAMED_UNARY' => -152,
			'OP10_STRINGIFY_UNARY' => -152,
			"\@{" => -152,
			"while (" => -152,
			'LITERAL_STRING' => -152,
			'VARIABLE_SYMBOL' => -152,
			"my" => -152,
			'OP05_LOGICAL_NEG' => -152,
			'LPAREN' => -152,
			'OP19_LOOP_CONTROL' => -152
		},
		GOTOS => {
			'OPTIONAL-39' => 354,
			'PAREN-36' => 356,
			'PAREN-38' => 352
		}
	},
	{#State 331
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 357
		}
	},
	{#State 332
		DEFAULT => -115
	},
	{#State 333
		DEFAULT => -173
	},
	{#State 334
		ACTIONS => {
			'LITERAL_STRING' => 358
		}
	},
	{#State 335
		DEFAULT => -194
	},
	{#State 336
		ACTIONS => {
			'OP04_MATH_POW' => 168,
			'OP08_MATH_ADD_SUB' => 169,
			'OP21_LIST_COMMA' => -190,
			'OP08_STRING_CAT' => 161,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP16_LOGICAL_OR' => 160,
			'OP17_LIST_RANGE' => 167,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 154,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP11_COMPARE_LT_GT' => 164,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -190,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP13_BITWISE_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 153
		}
	},
	{#State 337
		DEFAULT => -57
	},
	{#State 338
		ACTIONS => {
			'WORD' => 58,
			'TYPE_METHOD' => 359
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 339
		DEFAULT => -75
	},
	{#State 340
		ACTIONS => {
			";" => 360
		}
	},
	{#State 341
		DEFAULT => -74
	},
	{#State 342
		ACTIONS => {
			"%{" => 105,
			"}" => 364,
			'WORD' => 363
		},
		GOTOS => {
			'HashDereferenced' => 362,
			'HashEntryTyped' => 361
		}
	},
	{#State 343
		DEFAULT => -205
	},
	{#State 344
		ACTIONS => {
			'OP21_LIST_COMMA' => 365,
			")" => 366
		},
		GOTOS => {
			'PAREN-18' => 367
		}
	},
	{#State 345
		DEFAULT => -46
	},
	{#State 346
		DEFAULT => -170
	},
	{#State 347
		DEFAULT => -80
	},
	{#State 348
		ACTIONS => {
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED' => 126,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			"%{" => 105,
			'LPAREN' => 84,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108
		},
		GOTOS => {
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 368,
			'WordScoped' => 75,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78,
			'Variable' => 127,
			'Expression' => 128
		}
	},
	{#State 349
		ACTIONS => {
			")" => 369
		}
	},
	{#State 350
		DEFAULT => -162
	},
	{#State 351
		DEFAULT => -160
	},
	{#State 352
		DEFAULT => -151
	},
	{#State 353
		ACTIONS => {
			'LBRACKET' => 93,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'LPAREN' => 84,
			"%{" => 105,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			'CONSTANT_SYMBOL' => 100
		},
		GOTOS => {
			'Variable' => 127,
			'Expression' => 128,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Literal' => 114,
			'HashReference' => 78,
			'WordScoped' => 75,
			'Operator' => 113,
			'ArrayReference' => 111,
			'SubExpression' => 370
		}
	},
	{#State 354
		DEFAULT => -153
	},
	{#State 355
		ACTIONS => {
			'LBRACE' => 295
		},
		GOTOS => {
			'CodeBlock' => 371
		}
	},
	{#State 356
		DEFAULT => -148
	},
	{#State 357
		DEFAULT => -204
	},
	{#State 358
		ACTIONS => {
			'OP21_LIST_COMMA' => 372
		}
	},
	{#State 359
		ACTIONS => {
			'VARIABLE_SYMBOL' => 373
		}
	},
	{#State 360
		DEFAULT => -59
	},
	{#State 361
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 374
		}
	},
	{#State 362
		DEFAULT => -193
	},
	{#State 363
		ACTIONS => {
			'OP20_HASH_FATARROW' => 375
		}
	},
	{#State 364
		ACTIONS => {
			";" => 376
		}
	},
	{#State 365
		ACTIONS => {
			"my" => 377
		}
	},
	{#State 366
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 378
		}
	},
	{#State 367
		DEFAULT => -48
	},
	{#State 368
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP18_TERNARY' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => 156,
			'OP11_COMPARE_LT_GT' => 164,
			'OP12_COMPARE_EQ_NE' => 153,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP04_MATH_POW' => 168,
			")" => 379,
			'OP08_MATH_ADD_SUB' => 169,
			'OP08_STRING_CAT' => 161,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 160
		}
	},
	{#State 369
		ACTIONS => {
			'LBRACE' => 295
		},
		GOTOS => {
			'CodeBlock' => 380
		}
	},
	{#State 370
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 153,
			'OP11_COMPARE_LT_GT' => 164,
			'OP07_STRING_REPEAT' => 157,
			'OP24_LOGICAL_OR_XOR' => 155,
			'OP15_LOGICAL_AND' => 156,
			'OP23_LOGICAL_AND' => 154,
			'OP18_TERNARY' => 163,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP16_LOGICAL_OR' => 160,
			'OP17_LIST_RANGE' => 167,
			'OP08_STRING_CAT' => 161,
			")" => 381,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 168,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 371
		DEFAULT => -150
	},
	{#State 372
		ACTIONS => {
			'LITERAL_NUMBER' => 99,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_NAMED' => 126,
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 85,
			'OP01_CLOSE' => 108,
			'LPAREN' => 84,
			"%{" => 105,
			'WORD' => 22,
			'VARIABLE_SYMBOL' => 77,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71
		},
		GOTOS => {
			'SubExpression' => 382,
			'ArrayReference' => 111,
			'Operator' => 113,
			'WordScoped' => 75,
			'Literal' => 114,
			'HashReference' => 78,
			'HashDereferenced' => 95,
			'ArrayDereferenced' => 81,
			'Expression' => 128,
			'Variable' => 127
		}
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 383
		}
	},
	{#State 374
		ACTIONS => {
			'OP21_LIST_COMMA' => 385,
			"}" => 384
		},
		GOTOS => {
			'PAREN-24' => 386
		}
	},
	{#State 375
		ACTIONS => {
			"my" => 171
		},
		GOTOS => {
			'TypeInner' => 387
		}
	},
	{#State 376
		DEFAULT => -64
	},
	{#State 377
		ACTIONS => {
			'WORD' => 58
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
		ACTIONS => {
			'LBRACE' => 295
		},
		GOTOS => {
			'CodeBlock' => 390
		}
	},
	{#State 380
		DEFAULT => -158
	},
	{#State 381
		ACTIONS => {
			'LBRACE' => 295
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 382
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 162,
			"]" => -81,
			'OP04_MATH_POW' => 168,
			")" => -81,
			'OP08_MATH_ADD_SUB' => 169,
			'OP21_LIST_COMMA' => -81,
			'OP08_STRING_CAT' => 161,
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			"}" => -81,
			'OP13_BITWISE_AND' => 159,
			'OP09_BITWISE_SHIFT' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -81,
			'OP18_TERNARY' => 163,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP15_LOGICAL_AND' => 156,
			'OP07_STRING_REPEAT' => 157,
			'OP11_COMPARE_LT_GT' => 164,
			";" => -81,
			'OP12_COMPARE_EQ_NE' => 153
		}
	},
	{#State 383
		ACTIONS => {
			'OP01_NAMED_VOID' => -66,
			'WORD_SCOPED' => -66,
			'LBRACE' => -66,
			'OP03_MATH_INC_DEC' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP01_PRINT' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'CONSTANT_SYMBOL' => -66,
			"for my integer" => -66,
			'OP01_CLOSE' => -66,
			"%{" => -66,
			'WORD' => -66,
			'OP01_NAMED' => -66,
			"if (" => -66,
			'LITERAL_NUMBER' => -66,
			'OP10_NAMED_UNARY' => -66,
			"foreach my" => -66,
			'OP01_OPEN' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LBRACKET' => -66,
			"undef" => -66,
			"while (" => -66,
			'LITERAL_STRING' => -66,
			"( my" => 394,
			"\@{" => -66,
			'OP10_STRINGIFY_UNARY' => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'LPAREN' => -66,
			"my" => -66,
			'VARIABLE_SYMBOL' => -66
		},
		GOTOS => {
			'MethodArguments' => 392,
			'OPTIONAL-26' => 393
		}
	},
	{#State 384
		ACTIONS => {
			";" => 395
		}
	},
	{#State 385
		ACTIONS => {
			'WORD' => 363,
			"%{" => 105
		},
		GOTOS => {
			'HashEntryTyped' => 396,
			'HashDereferenced' => 362
		}
	},
	{#State 386
		DEFAULT => -61
	},
	{#State 387
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'CONSTANT_SYMBOL' => 100,
			'LITERAL_STRING' => 74,
			'VARIABLE_SYMBOL' => 77,
			'WORD' => 22,
			"%{" => 105,
			'LPAREN' => 84,
			'OP01_CLOSE' => 108,
			'OP05_LOGICAL_NEG' => 85,
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED' => 126,
			'LBRACKET' => 93,
			"undef" => 94,
			'OP01_OPEN' => 96,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			'LITERAL_NUMBER' => 99
		},
		GOTOS => {
			'WordScoped' => 75,
			'Operator' => 113,
			'SubExpression' => 397,
			'ArrayReference' => 111,
			'Variable' => 127,
			'Expression' => 128,
			'ArrayDereferenced' => 81,
			'HashDereferenced' => 95,
			'HashReference' => 78,
			'Literal' => 114
		}
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
			'LBRACE' => 110,
			'WORD_SCOPED' => 23,
			'OP01_NAMED_VOID' => 112,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP03_MATH_INC_DEC' => 117,
			'OP22_LOGICAL_NEG' => 116,
			'CONSTANT_SYMBOL' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP01_PRINT' => 102,
			'WORD' => 104,
			"%{" => 105,
			"for my integer" => -141,
			'OP01_CLOSE' => 108,
			"if (" => 89,
			'OP01_NAMED' => 90,
			'OP01_NAMED_VOID_SCOLON' => 92,
			"undef" => 94,
			'LBRACKET' => 93,
			'OP10_NAMED_UNARY' => 97,
			'OP01_OPEN' => 96,
			"foreach my" => -141,
			'LITERAL_NUMBER' => 99,
			"\@{" => 72,
			'OP10_STRINGIFY_UNARY' => 71,
			'LITERAL_STRING' => 74,
			"while (" => -141,
			"my" => 79,
			'VARIABLE_SYMBOL' => 77,
			'LPAREN' => 84,
			'OP19_LOOP_CONTROL' => 83,
			'OP05_LOGICAL_NEG' => 85
		},
		GOTOS => {
			'Operation' => 400,
			'PLUS-27' => 399,
			'Literal' => 114,
			'HashDereferenced' => 95,
			'OperatorVoid' => 91,
			'SubExpression' => 88,
			'ArrayReference' => 111,
			'Operator' => 113,
			'VariableDeclaration' => 82,
			'Expression' => 107,
			'Statement' => 106,
			'OPTIONAL-35' => 86,
			'Variable' => 87,
			'HashReference' => 78,
			'LoopLabel' => 80,
			'ArrayDereferenced' => 81,
			'PAREN-34' => 103,
			'WordScoped' => 75,
			'Conditional' => 76,
			'VariableModification' => 70
		}
	},
	{#State 394
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 401
		}
	},
	{#State 395
		DEFAULT => -63
	},
	{#State 396
		DEFAULT => -60
	},
	{#State 397
		ACTIONS => {
			'OP17_LIST_RANGE' => 167,
			'OP16_LOGICAL_OR' => 160,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_MATH_ADD_SUB' => 169,
			'OP04_MATH_POW' => 168,
			'OP08_STRING_CAT' => 161,
			'OP21_LIST_COMMA' => -192,
			'OP12_COMPARE_EQ_NE' => 153,
			"}" => -192,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP06_REGEX_MATCH' => 166,
			'OP09_BITWISE_SHIFT' => 165,
			'OP13_BITWISE_AND' => 159,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 154,
			'OP11_COMPARE_LT_GT' => 164,
			'OP07_STRING_REPEAT' => 157,
			'OP15_LOGICAL_AND' => 156,
			'OP24_LOGICAL_OR_XOR' => 155
		}
	},
	{#State 398
		DEFAULT => -47
	},
	{#State 399
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'LBRACE' => 110,
			'OP01_NAMED_VOID' => 112,
			'OP05_MATH_NEG_LPAREN' => 115,
			'OP22_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 117,
			"}" => 403,
			'CONSTANT_SYMBOL' => 100,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP01_PRINT' => 102,
			"%{" => 105,
			"for my integer" => -141,
			'OP01_CLOSE' => 108,
			'WORD' => 104,
			'OP01_NAMED' => 90,
			"if (" => 89,
			"foreach my" => -141,
			'OP01_OPEN' => 96,
			'OP10_NAMED_UNARY' => 97,
			'LITERAL_NUMBER' => 99,
			"undef" => 94,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'LBRACKET' => 93,
			"while (" => -141,
			'LITERAL_STRING' => 74,
			'OP10_STRINGIFY_UNARY' => 71,
			"\@{" => 72,
			'LPAREN' => 84,
			'OP19_LOOP_CONTROL' => 83,
			'OP05_LOGICAL_NEG' => 85,
			'VARIABLE_SYMBOL' => 77,
			"my" => 79
		},
		GOTOS => {
			'OperatorVoid' => 91,
			'ArrayReference' => 111,
			'SubExpression' => 88,
			'Operator' => 113,
			'Operation' => 402,
			'Literal' => 114,
			'HashDereferenced' => 95,
			'WordScoped' => 75,
			'Conditional' => 76,
			'VariableModification' => 70,
			'VariableDeclaration' => 82,
			'Statement' => 106,
			'Expression' => 107,
			'OPTIONAL-35' => 86,
			'Variable' => 87,
			'HashReference' => 78,
			'LoopLabel' => 80,
			'PAREN-34' => 103,
			'ArrayDereferenced' => 81
		}
	},
	{#State 400
		DEFAULT => -68
	},
	{#State 401
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 404
		}
	},
	{#State 402
		DEFAULT => -67
	},
	{#State 403
		ACTIONS => {
			";" => 405
		}
	},
	{#State 404
		ACTIONS => {
			")" => 407,
			'OP21_LIST_COMMA' => 406
		},
		GOTOS => {
			'PAREN-28' => 408
		}
	},
	{#State 405
		DEFAULT => -69
	},
	{#State 406
		ACTIONS => {
			"my" => 409
		}
	},
	{#State 407
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 408
		DEFAULT => -71
	},
	{#State 409
		ACTIONS => {
			'WORD' => 58
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
