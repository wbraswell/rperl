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

      m{\G(our\ hash_ref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|filehandle_ref|for\ my\ integer|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|foreach\ my|\=\ sub\ \{|elsif\ \(|\$TYPED_|package|while\ \(|undef|\(\ my|if\ \(|else|\@_\;|use|qw\(|our|my|\@\{|\%\{|\)|\}|\;|\])}gc and return ($1, $1);

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
			"## no critic qw(" => 6,
			"package" => -20,
			'SHEBANG' => 5
		},
		GOTOS => {
			'OPTIONAL-9' => 4,
			'Program' => 3,
			'PAREN-1' => 2,
			'PLUS-2' => 1,
			'Critic' => 7,
			'ModuleHeader' => 8,
			'CompileUnit' => 9
		}
	},
	{#State 1
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 6,
			'' => -5
		},
		GOTOS => {
			'OPTIONAL-9' => 4,
			'PAREN-1' => 10,
			'Critic' => 7,
			'ModuleHeader' => 8
		}
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		ACTIONS => {
			"package" => 11
		}
	},
	{#State 5
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 12,
			'OPTIONAL-3' => 13
		}
	},
	{#State 6
		ACTIONS => {
			'WORD' => 14
		},
		GOTOS => {
			'PLUS-14' => 15
		}
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			"use parent qw(" => 17,
			"use" => -25,
			"our" => -25,
			"use constant" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'STAR-10' => 18,
			'Module' => 16,
			'Class' => 20,
			'Package' => 19
		}
	},
	{#State 9
		ACTIONS => {
			'' => 21
		}
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 22
		}
	},
	{#State 12
		DEFAULT => -6
	},
	{#State 13
		ACTIONS => {
			"use strict;" => 25
		},
		GOTOS => {
			'Header' => 26
		}
	},
	{#State 14
		DEFAULT => -35
	},
	{#State 15
		ACTIONS => {
			'WORD' => 28,
			")" => 27
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 23
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 18
		ACTIONS => {
			"## no critic qw(" => 6,
			"use constant" => -27,
			"our" => -27,
			"use" => -27
		},
		GOTOS => {
			'STAR-11' => 30,
			'Critic' => 31
		}
	},
	{#State 19
		DEFAULT => -22
	},
	{#State 20
		DEFAULT => -23
	},
	{#State 21
		DEFAULT => 0
	},
	{#State 22
		ACTIONS => {
			";" => 32
		}
	},
	{#State 23
		DEFAULT => -200
	},
	{#State 24
		DEFAULT => -201
	},
	{#State 25
		ACTIONS => {
			"use warnings;" => 33
		}
	},
	{#State 26
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 34
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
			"use constant" => -29,
			"our" => -29,
			"use" => 37
		},
		GOTOS => {
			'STAR-12' => 36,
			'Include' => 38
		}
	},
	{#State 31
		DEFAULT => -24
	},
	{#State 32
		ACTIONS => {
			"use strict;" => 25
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
			"use" => -11,
			"## no critic qw(" => 6,
			'LBRACKET' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_CLOSE' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED' => -11,
			"for my integer" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LBRACE' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"if (" => -11,
			"my" => -11,
			'OP10_STRINGIFY_UNARY' => -11,
			'LITERAL_STRING' => -11,
			"our" => -11,
			'OP01_PRINT' => -11,
			'CONSTANT_SYMBOL' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"%{" => -11,
			'VARIABLE_SYMBOL' => -11,
			'WORD_SCOPED' => -11,
			"foreach my" => -11,
			'WORD' => -11,
			"undef" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_OPEN' => -11,
			'LPAREN' => -11,
			"\@{" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"while (" => -11,
			'OP01_NAMED_VOID' => -11,
			"use constant" => -11
		},
		GOTOS => {
			'STAR-5' => 41,
			'Critic' => 42
		}
	},
	{#State 35
		ACTIONS => {
			";" => 43
		}
	},
	{#State 36
		ACTIONS => {
			"our" => 45,
			"use constant" => 47
		},
		GOTOS => {
			'PLUS-13' => 48,
			'Subroutine' => 44,
			'Constant' => 46
		}
	},
	{#State 37
		ACTIONS => {
			'WORD' => 23,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 49
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
		ACTIONS => {
			"use constant" => -13,
			"while (" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"\@{" => -13,
			'OP01_OPEN' => -13,
			'LPAREN' => -13,
			'WORD' => -13,
			"undef" => -13,
			'OP10_NAMED_UNARY' => -13,
			'WORD_SCOPED' => -13,
			'VARIABLE_SYMBOL' => -13,
			"foreach my" => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'CONSTANT_SYMBOL' => -13,
			'OP01_PRINT' => -13,
			'LITERAL_STRING' => -13,
			"our" => -13,
			"my" => -13,
			'OP10_STRINGIFY_UNARY' => -13,
			"if (" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'LBRACE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"for my integer" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'LITERAL_NUMBER' => -13,
			'LBRACKET' => -13,
			"use" => 37
		},
		GOTOS => {
			'STAR-6' => 51,
			'Include' => 52
		}
	},
	{#State 42
		DEFAULT => -8
	},
	{#State 43
		ACTIONS => {
			"use" => 37
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
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 46
		DEFAULT => -28
	},
	{#State 47
		ACTIONS => {
			'CONSTANT_SYMBOL' => 56
		}
	},
	{#State 48
		ACTIONS => {
			"our" => 45,
			'LITERAL_NUMBER' => 58
		},
		GOTOS => {
			'Subroutine' => 57
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
			'CONSTANT_SYMBOL' => -15,
			"our" => -15,
			'LITERAL_STRING' => -15,
			'OP01_PRINT' => -15,
			"%{" => -15,
			"foreach my" => -15,
			'VARIABLE_SYMBOL' => -15,
			'WORD_SCOPED' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LPAREN' => -15,
			'OP01_OPEN' => -15,
			"\@{" => -15,
			'OP10_NAMED_UNARY' => -15,
			"undef" => -15,
			'WORD' => -15,
			'OP01_NAMED_VOID' => -15,
			"while (" => -15,
			"use constant" => 47,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_CLOSE' => -15,
			'LBRACE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_NAMED' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"for my integer" => -15,
			"if (" => -15,
			"my" => -15,
			'OP10_STRINGIFY_UNARY' => -15,
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
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 55
		DEFAULT => -203
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
		ACTIONS => {
			'WORD' => 69
		},
		GOTOS => {
			'PLUS-15' => 68
		}
	},
	{#State 60
		DEFAULT => -39
	},
	{#State 61
		DEFAULT => -33
	},
	{#State 62
		ACTIONS => {
			"while (" => -141,
			'OP01_NAMED_VOID' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			"undef" => 112,
			'WORD' => 111,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"foreach my" => -141,
			'VARIABLE_SYMBOL' => 108,
			'OP19_LOOP_CONTROL' => 106,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102,
			"our" => 45,
			'OP01_PRINT' => 100,
			"if (" => 98,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 97,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_NAMED_VOID_SCOLON' => 87,
			'LBRACE' => 88,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 84,
			"for my integer" => -141,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'LBRACKET' => 72
		},
		GOTOS => {
			'VariableDeclaration' => 76,
			'Literal' => 107,
			'PLUS-8' => 82,
			'HashDereferenced' => 80,
			'Statement' => 78,
			'Subroutine' => 101,
			'PAREN-34' => 71,
			'Conditional' => 70,
			'LoopLabel' => 73,
			'Variable' => 74,
			'Operation' => 105,
			'Operator' => 103,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'SubExpression' => 95,
			'Expression' => 90,
			'VariableModification' => 89,
			'ArrayDereferenced' => 91,
			'OperatorVoid' => 99,
			'OPTIONAL-35' => 86,
			'WordScoped' => 83
		}
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			"use constant" => -54,
			"## no critic qw(" => 6,
			"our hash_ref \$properties" => -54,
			"use" => -54
		},
		GOTOS => {
			'Critic' => 118,
			'STAR-21' => 119
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 120
		}
	},
	{#State 66
		ACTIONS => {
			"my" => 121
		},
		GOTOS => {
			'TypeInnerConstant' => 122
		}
	},
	{#State 67
		DEFAULT => -32
	},
	{#State 68
		ACTIONS => {
			")" => 124,
			'WORD' => 123
		}
	},
	{#State 69
		DEFAULT => -38
	},
	{#State 70
		DEFAULT => -142
	},
	{#State 71
		DEFAULT => -140
	},
	{#State 72
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'KEYS_OR_VALUES' => 125,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			'LBRACE' => 88,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'OP01_QW' => 127,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_STRING' => 102,
			"]" => -184,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104
		},
		GOTOS => {
			'ListElements' => 135,
			'Operator' => 103,
			'TypeInner' => 126,
			'Variable' => 134,
			'WordScoped' => 83,
			'ListElement' => 129,
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'OPTIONAL-45' => 131,
			'SubExpression' => 130,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'Literal' => 107
		}
	},
	{#State 73
		ACTIONS => {
			'COLON' => 136
		}
	},
	{#State 74
		ACTIONS => {
			'OP08_STRING_CAT' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP02_METHOD_THINARROW' => 138,
			'OP13_BITWISE_AND' => -130,
			'OP15_LOGICAL_AND' => -130,
			'OP19_VARIABLE_ASSIGN_BY' => 140,
			'OP09_BITWISE_SHIFT' => -130,
			'OP03_MATH_INC_DEC' => 137,
			'OP07_STRING_REPEAT' => -130,
			'OP04_MATH_POW' => -130,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP19_VARIABLE_ASSIGN' => 139,
			'OP16_LOGICAL_OR' => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP23_LOGICAL_AND' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP11_COMPARE_LT_GT' => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP18_TERNARY' => -130,
			'OP14_BITWISE_OR_XOR' => -130
		}
	},
	{#State 75
		ACTIONS => {
			'FH_REF_SYMBOL' => 141
		}
	},
	{#State 76
		DEFAULT => -145
	},
	{#State 77
		DEFAULT => -209
	},
	{#State 78
		DEFAULT => -77
	},
	{#State 79
		ACTIONS => {
			'WORD' => 23,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 88,
			"\@{" => 113,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			"%{" => 109
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'SubExpression' => 142,
			'Expression' => 132,
			'ArrayDereferenced' => 91
		}
	},
	{#State 80
		DEFAULT => -134
	},
	{#State 81
		DEFAULT => -116
	},
	{#State 82
		ACTIONS => {
			'LBRACKET' => 72,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP22_LOGICAL_NEG' => 79,
			'OP01_NAMED' => 84,
			'OP03_MATH_INC_DEC' => 85,
			"for my integer" => -141,
			'OP01_NAMED_VOID_SCOLON' => 87,
			'LBRACE' => 88,
			'OP05_LOGICAL_NEG' => 92,
			"if (" => 98,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 97,
			'LITERAL_STRING' => 102,
			'OP01_PRINT' => 100,
			'CONSTANT_SYMBOL' => 104,
			'' => -18,
			'OP19_LOOP_CONTROL' => 106,
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			"foreach my" => -141,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 111,
			"undef" => 112,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_NAMED_VOID' => 117,
			"while (" => -141
		},
		GOTOS => {
			'OPTIONAL-35' => 86,
			'WordScoped' => 83,
			'OperatorVoid' => 99,
			'SubExpression' => 95,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 91,
			'Expression' => 90,
			'VariableModification' => 89,
			'Operation' => 143,
			'Variable' => 74,
			'LoopLabel' => 73,
			'Operator' => 103,
			'PAREN-34' => 71,
			'Conditional' => 70,
			'HashDereferenced' => 80,
			'Statement' => 78,
			'VariableDeclaration' => 76,
			'Literal' => 107
		}
	},
	{#State 83
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 145,
			'LPAREN' => 144
		}
	},
	{#State 84
		ACTIONS => {
			"undef" => 112,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'LBRACE' => 88,
			"\@{" => 113,
			'KEYS_OR_VALUES' => 125,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 133,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			"%{" => 109
		},
		GOTOS => {
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'SubExpression' => 147,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'ListElement' => 146,
			'Variable' => 134,
			'TypeInner' => 126,
			'Operator' => 103
		}
	},
	{#State 85
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Variable' => 148
		}
	},
	{#State 86
		ACTIONS => {
			"foreach my" => 152,
			"while (" => 155,
			"for my integer" => 151
		},
		GOTOS => {
			'Loop' => 153,
			'LoopWhile' => 150,
			'LoopForEach' => 149,
			'LoopFor' => 154
		}
	},
	{#State 87
		DEFAULT => -113
	},
	{#State 88
		ACTIONS => {
			'WORD' => 158,
			"}" => 159,
			"%{" => 109
		},
		GOTOS => {
			'HashDereferenced' => 157,
			'HashEntry' => 156
		}
	},
	{#State 89
		DEFAULT => -146
	},
	{#State 90
		ACTIONS => {
			'OP16_LOGICAL_OR' => -127,
			'OP04_MATH_POW' => -127,
			'OP12_COMPARE_EQ_NE' => -127,
			'OP07_STRING_REPEAT' => -127,
			'OP09_BITWISE_SHIFT' => -127,
			";" => 160,
			'OP15_LOGICAL_AND' => -127,
			'OP13_BITWISE_AND' => -127,
			'OP07_MATH_MULT_DIV_MOD' => -127,
			'OP08_STRING_CAT' => -127,
			'OP14_BITWISE_OR_XOR' => -127,
			'OP18_TERNARY' => -127,
			'OP08_MATH_ADD_SUB' => -127,
			'OP11_COMPARE_LT_GT' => -127,
			'OP17_LIST_RANGE' => -127,
			'OP23_LOGICAL_AND' => -127,
			'OP24_LOGICAL_OR_XOR' => -127,
			'OP06_REGEX_MATCH' => -127
		}
	},
	{#State 91
		DEFAULT => -132
	},
	{#State 92
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"undef" => 112,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128
		},
		GOTOS => {
			'SubExpression' => 161,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103
		}
	},
	{#State 93
		DEFAULT => -133
	},
	{#State 94
		DEFAULT => -131
	},
	{#State 95
		ACTIONS => {
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP06_REGEX_MATCH' => 166,
			'OP17_LIST_RANGE' => 164,
			'OP11_COMPARE_LT_GT' => 171,
			'OP23_LOGICAL_AND' => 165,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 173,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178
		}
	},
	{#State 96
		ACTIONS => {
			"\@{" => 113,
			'LBRACE' => 88,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77
		},
		GOTOS => {
			'WordScoped' => 83,
			'Operator' => 103,
			'Variable' => 134,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 179,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'HashDereferenced' => 80
		}
	},
	{#State 97
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 180
		}
	},
	{#State 98
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'SubExpression' => 181,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103
		}
	},
	{#State 99
		DEFAULT => -144
	},
	{#State 100
		ACTIONS => {
			'OP01_CLOSE' => -110,
			'OP01_QW' => -110,
			'STDOUT_STDERR' => 182,
			'LITERAL_NUMBER' => -110,
			'VARIABLE_SYMBOL' => -110,
			'WORD_SCOPED' => -110,
			'OP22_LOGICAL_NEG' => -110,
			"%{" => -110,
			'LITERAL_STRING' => -110,
			'CONSTANT_SYMBOL' => -110,
			'LBRACKET' => -110,
			'FH_REF_SYMBOL_BRACES' => 183,
			'OP05_LOGICAL_NEG' => -110,
			'OP05_MATH_NEG_LPAREN' => -110,
			"my" => -110,
			'OP10_STRINGIFY_UNARY' => -110,
			'OP10_NAMED_UNARY' => -110,
			'OP01_NAMED' => -110,
			'WORD' => -110,
			'OP03_MATH_INC_DEC' => -110,
			"undef" => -110,
			"\@{" => -110,
			'LBRACE' => -110,
			'LPAREN' => -110,
			'OP01_OPEN' => -110,
			'KEYS_OR_VALUES' => -110
		},
		GOTOS => {
			'OPTIONAL-31' => 184,
			'PAREN-30' => 185
		}
	},
	{#State 101
		DEFAULT => -14
	},
	{#State 102
		DEFAULT => -208
	},
	{#State 103
		DEFAULT => -122
	},
	{#State 104
		ACTIONS => {
			'LPAREN' => 186
		}
	},
	{#State 105
		DEFAULT => -17
	},
	{#State 106
		ACTIONS => {
			'WORD' => 187
		},
		GOTOS => {
			'LoopLabel' => 188
		}
	},
	{#State 107
		DEFAULT => -129
	},
	{#State 108
		DEFAULT => -164,
		GOTOS => {
			'STAR-41' => 189
		}
	},
	{#State 109
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 192
		},
		GOTOS => {
			'HashReference' => 191,
			'Variable' => 190
		}
	},
	{#State 110
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -95,
			'LBRACKET' => 72,
			'LITERAL_NUMBER' => 77,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP01_CLOSE' => 75,
			'OP11_COMPARE_LT_GT' => -95,
			'OP22_LOGICAL_NEG' => 79,
			'OP01_NAMED' => 128,
			'OP03_MATH_INC_DEC' => 85,
			'OP09_BITWISE_SHIFT' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'LBRACE' => 88,
			'OP04_MATH_POW' => -95,
			'OP05_LOGICAL_NEG' => 92,
			'OP15_LOGICAL_AND' => -95,
			")" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP10_STRINGIFY_UNARY' => 96,
			'LITERAL_STRING' => 102,
			'OP18_TERNARY' => -95,
			"]" => -95,
			'CONSTANT_SYMBOL' => 104,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP06_REGEX_MATCH' => -95,
			"%{" => 109,
			'OP17_LIST_RANGE' => -95,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP23_LOGICAL_AND' => -95,
			'OP10_NAMED_UNARY' => 110,
			'OP07_STRING_REPEAT' => -95,
			'WORD' => 23,
			"undef" => 112,
			'OP21_LIST_COMMA' => -95,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			"}" => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP08_STRING_CAT' => -95,
			";" => -95
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'SubExpression' => 193,
			'Expression' => 132,
			'ArrayDereferenced' => 91
		}
	},
	{#State 111
		ACTIONS => {
			'LPAREN' => -200,
			'OP02_METHOD_THINARROW_NEW' => -200,
			'COLON' => -202
		}
	},
	{#State 112
		DEFAULT => -128
	},
	{#State 113
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 72
		},
		GOTOS => {
			'Variable' => 194,
			'ArrayReference' => 195
		}
	},
	{#State 114
		ACTIONS => {
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'OP01_PRINT' => 196,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_NAMED' => 197,
			'OP10_NAMED_UNARY' => 110,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'Literal' => 107,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'SubExpression' => 198,
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83
		}
	},
	{#State 115
		ACTIONS => {
			"my" => 199
		}
	},
	{#State 116
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'WORD' => 23,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'SubExpression' => 200,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 83
		}
	},
	{#State 117
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'OP01_QW' => 127,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 115,
			'KEYS_OR_VALUES' => 125,
			'LPAREN' => 114,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 133
		},
		GOTOS => {
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 130,
			'Literal' => 107,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'ListElement' => 129,
			'ListElements' => 201,
			'Operator' => 103,
			'Variable' => 134,
			'TypeInner' => 126
		}
	},
	{#State 118
		DEFAULT => -51
	},
	{#State 119
		ACTIONS => {
			"use" => 37,
			"our hash_ref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'Include' => 203,
			'STAR-22' => 202
		}
	},
	{#State 120
		ACTIONS => {
			'OP01_NAMED_VOID' => -43,
			"while (" => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"\@{" => -43,
			'LPAREN' => -43,
			'OP01_OPEN' => -43,
			'OP10_NAMED_UNARY' => -43,
			'WORD' => -43,
			"undef" => -43,
			'WORD_SCOPED' => -43,
			'VARIABLE_SYMBOL' => -43,
			"foreach my" => -43,
			"%{" => -43,
			'OP19_LOOP_CONTROL' => -43,
			"( my" => 206,
			'CONSTANT_SYMBOL' => -43,
			'OP01_PRINT' => -43,
			'LITERAL_STRING' => -43,
			"my" => -43,
			'OP10_STRINGIFY_UNARY' => -43,
			"if (" => -43,
			'OP05_LOGICAL_NEG' => -43,
			'LBRACE' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			"for my integer" => -43,
			'OP01_NAMED' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'OP01_CLOSE' => -43,
			'LITERAL_NUMBER' => -43,
			'LBRACKET' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 204,
			'SubroutineArguments' => 205
		}
	},
	{#State 121
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 207
		}
	},
	{#State 122
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'Literal' => 208
		}
	},
	{#State 123
		DEFAULT => -37
	},
	{#State 124
		ACTIONS => {
			";" => 209
		}
	},
	{#State 125
		ACTIONS => {
			"%{" => 109
		},
		GOTOS => {
			'HashDereferenced' => 210
		}
	},
	{#State 126
		ACTIONS => {
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'LBRACE' => 88,
			"\@{" => 113,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'WORD' => 23,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'SubExpression' => 211,
			'Expression' => 132,
			'ArrayDereferenced' => 91
		}
	},
	{#State 127
		ACTIONS => {
			'WORD' => 213
		},
		GOTOS => {
			'PLUS-44' => 212
		}
	},
	{#State 128
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			"%{" => 109,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'LBRACE' => 88,
			"\@{" => 113,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 214,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'Literal' => 107,
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83
		}
	},
	{#State 129
		DEFAULT => -175,
		GOTOS => {
			'STAR-43' => 215
		}
	},
	{#State 130
		ACTIONS => {
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP17_LIST_RANGE' => 164,
			'OP11_COMPARE_LT_GT' => 171,
			'OP23_LOGICAL_AND' => 165,
			'OP18_TERNARY' => 163,
			"]" => -180,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			";" => -180,
			'OP15_LOGICAL_AND' => 177,
			")" => -180,
			'OP13_BITWISE_AND' => 178,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP21_LIST_COMMA' => -180,
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175
		}
	},
	{#State 131
		ACTIONS => {
			"]" => 216
		}
	},
	{#State 132
		DEFAULT => -127
	},
	{#State 133
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 217
		}
	},
	{#State 134
		ACTIONS => {
			'OP13_BITWISE_AND' => -130,
			'OP02_METHOD_THINARROW' => 138,
			'OP15_LOGICAL_AND' => -130,
			";" => -130,
			")" => -130,
			'OP08_STRING_CAT' => -130,
			'OP07_MATH_MULT_DIV_MOD' => -130,
			'OP12_COMPARE_EQ_NE' => -130,
			'OP04_MATH_POW' => -130,
			"}" => -130,
			'OP16_LOGICAL_OR' => -130,
			'OP21_LIST_COMMA' => -130,
			'OP09_BITWISE_SHIFT' => -130,
			'OP03_MATH_INC_DEC' => 137,
			'OP07_STRING_REPEAT' => -130,
			'OP23_LOGICAL_AND' => -130,
			'OP17_LIST_RANGE' => -130,
			'OP11_COMPARE_LT_GT' => -130,
			'OP06_REGEX_MATCH' => -130,
			'OP24_LOGICAL_OR_XOR' => -130,
			'OP14_BITWISE_OR_XOR' => -130,
			"]" => -130,
			'OP08_MATH_ADD_SUB' => -130,
			'OP18_TERNARY' => -130
		}
	},
	{#State 135
		DEFAULT => -183
	},
	{#State 136
		DEFAULT => -139
	},
	{#State 137
		DEFAULT => -84
	},
	{#State 138
		ACTIONS => {
			'LPAREN' => 218
		}
	},
	{#State 139
		ACTIONS => {
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 77,
			'STDIN' => 219,
			'OP01_CLOSE' => 75,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'LBRACE' => 88,
			"\@{" => 113,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'SubExpressionOrStdin' => 220,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'Literal' => 107,
			'SubExpression' => 221,
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83
		}
	},
	{#State 140
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			"undef" => 112,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'LBRACE' => 88,
			"\@{" => 113
		},
		GOTOS => {
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'SubExpression' => 222,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'Operator' => 103,
			'Variable' => 134
		}
	},
	{#State 141
		DEFAULT => -82
	},
	{#State 142
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP06_REGEX_MATCH' => 166,
			'OP17_LIST_RANGE' => 164,
			'OP11_COMPARE_LT_GT' => 171,
			'OP23_LOGICAL_AND' => -105,
			'OP18_TERNARY' => 163,
			"]" => -105,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			")" => -105,
			";" => -105,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178,
			'OP07_STRING_REPEAT' => 167,
			'OP21_LIST_COMMA' => -105,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 173,
			"}" => -105,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 174
		}
	},
	{#State 143
		DEFAULT => -16
	},
	{#State 144
		ACTIONS => {
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => 96,
			")" => -119,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LBRACE' => 88,
			"\@{" => 113,
			'KEYS_OR_VALUES' => 125,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'OP01_QW' => 127,
			'LITERAL_NUMBER' => 77,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'TypeInner' => 126,
			'Variable' => 134,
			'Operator' => 103,
			'ListElements' => 223,
			'WordScoped' => 83,
			'ListElement' => 129,
			'HashDereferenced' => 80,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'SubExpression' => 130,
			'OPTIONAL-32' => 224,
			'Expression' => 132,
			'ArrayDereferenced' => 91
		}
	},
	{#State 145
		ACTIONS => {
			")" => 225
		}
	},
	{#State 146
		ACTIONS => {
			'OP21_LIST_COMMA' => 226
		}
	},
	{#State 147
		ACTIONS => {
			'OP17_LIST_RANGE' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP18_TERNARY' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			";" => -79,
			'OP15_LOGICAL_AND' => -79,
			")" => -79,
			'OP13_BITWISE_AND' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP08_STRING_CAT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP04_MATH_POW' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP21_LIST_COMMA' => -180,
			'OP09_BITWISE_SHIFT' => -79
		}
	},
	{#State 148
		DEFAULT => -83
	},
	{#State 149
		DEFAULT => -155
	},
	{#State 150
		DEFAULT => -156
	},
	{#State 151
		ACTIONS => {
			'VARIABLE_SYMBOL' => 227
		}
	},
	{#State 152
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 228
		}
	},
	{#State 153
		DEFAULT => -143
	},
	{#State 154
		DEFAULT => -154
	},
	{#State 155
		ACTIONS => {
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79
		},
		GOTOS => {
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103,
			'SubExpression' => 229,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'HashDereferenced' => 80
		}
	},
	{#State 156
		DEFAULT => -196,
		GOTOS => {
			'STAR-48' => 230
		}
	},
	{#State 157
		DEFAULT => -191
	},
	{#State 158
		ACTIONS => {
			'OP20_HASH_FATARROW' => 231
		}
	},
	{#State 159
		DEFAULT => -135
	},
	{#State 160
		DEFAULT => -76
	},
	{#State 161
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -86,
			'OP04_MATH_POW' => 175,
			"}" => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP15_LOGICAL_AND' => -86,
			";" => -86,
			")" => -86,
			'OP08_STRING_CAT' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			"]" => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP18_TERNARY' => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP24_LOGICAL_OR_XOR' => -86
		}
	},
	{#State 162
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'SubExpression' => 232,
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83
		}
	},
	{#State 163
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'LITERAL_STRING' => 102,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Literal' => 235,
			'VariableOrLiteral' => 234,
			'Variable' => 233
		}
	},
	{#State 164
		ACTIONS => {
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			"\@{" => 113,
			'LBRACE' => 88,
			'LPAREN' => 114,
			'OP01_OPEN' => 115
		},
		GOTOS => {
			'WordScoped' => 83,
			'Operator' => 103,
			'Variable' => 134,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 236,
			'Literal' => 107,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'HashDereferenced' => 80
		}
	},
	{#State 165
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'SubExpression' => 237,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'HashDereferenced' => 80
		}
	},
	{#State 166
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 238
		}
	},
	{#State 167
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96
		},
		GOTOS => {
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 239,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94
		}
	},
	{#State 168
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'SubExpression' => 240,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 83
		}
	},
	{#State 169
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			"undef" => 112,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96
		},
		GOTOS => {
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103,
			'Literal' => 107,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'SubExpression' => 241,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'HashDereferenced' => 80
		}
	},
	{#State 170
		ACTIONS => {
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112,
			'LBRACE' => 88,
			"\@{" => 113,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109
		},
		GOTOS => {
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'SubExpression' => 242,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'HashDereferenced' => 80
		}
	},
	{#State 171
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 113,
			'LBRACE' => 88,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'WORD' => 23,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'SubExpression' => 243,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 132
		}
	},
	{#State 172
		ACTIONS => {
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92
		},
		GOTOS => {
			'WordScoped' => 83,
			'Operator' => 103,
			'Variable' => 134,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'SubExpression' => 244,
			'HashDereferenced' => 80
		}
	},
	{#State 173
		ACTIONS => {
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			"\@{" => 113,
			'LBRACE' => 88,
			'LPAREN' => 114,
			'OP01_OPEN' => 115
		},
		GOTOS => {
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103,
			'SubExpression' => 245,
			'Literal' => 107,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'HashDereferenced' => 80
		}
	},
	{#State 174
		ACTIONS => {
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'LBRACE' => 88,
			"\@{" => 113,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110
		},
		GOTOS => {
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 246,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94
		}
	},
	{#State 175
		ACTIONS => {
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			'LBRACE' => 88,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75
		},
		GOTOS => {
			'SubExpression' => 247,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103
		}
	},
	{#State 176
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			'LBRACE' => 88,
			'WORD' => 23,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 248,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83
		}
	},
	{#State 177
		ACTIONS => {
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77
		},
		GOTOS => {
			'SubExpression' => 249,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103
		}
	},
	{#State 178
		ACTIONS => {
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 23,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACE' => 88,
			"\@{" => 113,
			'LPAREN' => 114,
			'OP01_OPEN' => 115
		},
		GOTOS => {
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 250,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94
		}
	},
	{#State 179
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => 173,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP13_BITWISE_AND' => 178,
			'OP15_LOGICAL_AND' => 177,
			")" => 251,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP23_LOGICAL_AND' => 165,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164
		}
	},
	{#State 180
		ACTIONS => {
			'VARIABLE_SYMBOL' => 252
		}
	},
	{#State 181
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 170,
			'OP17_LIST_RANGE' => 164,
			'OP11_COMPARE_LT_GT' => 171,
			'OP23_LOGICAL_AND' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP15_LOGICAL_AND' => 177,
			")" => 253,
			'OP13_BITWISE_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169
		}
	},
	{#State 182
		DEFAULT => -108
	},
	{#State 183
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'KEYS_OR_VALUES' => 125,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => 96,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_NUMBER' => 77,
			'OP01_QW' => 127,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 83,
			'ListElement' => 129,
			'TypeInner' => 126,
			'Variable' => 134,
			'Operator' => 103,
			'ListElements' => 254,
			'Literal' => 107,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'SubExpression' => 130,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'HashDereferenced' => 80
		}
	},
	{#State 184
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_OPEN' => 115,
			'KEYS_OR_VALUES' => 125,
			'LPAREN' => 114,
			'OP01_QW' => 127,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'SubExpression' => 130,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'TypeInner' => 126,
			'Variable' => 134,
			'ListElements' => 255,
			'Operator' => 103,
			'WordScoped' => 83,
			'ListElement' => 129
		}
	},
	{#State 185
		DEFAULT => -109
	},
	{#State 186
		ACTIONS => {
			")" => 256
		}
	},
	{#State 187
		DEFAULT => -202
	},
	{#State 188
		ACTIONS => {
			";" => 257
		}
	},
	{#State 189
		ACTIONS => {
			'OP07_STRING_REPEAT' => -165,
			'OP03_MATH_INC_DEC' => -165,
			'OP19_VARIABLE_ASSIGN_BY' => -165,
			'OP21_LIST_COMMA' => -165,
			'OP09_BITWISE_SHIFT' => -165,
			'OP16_LOGICAL_OR' => -165,
			'OP04_MATH_POW' => -165,
			"}" => -165,
			'OP12_COMPARE_EQ_NE' => -165,
			'OP19_VARIABLE_ASSIGN' => -165,
			'OP07_MATH_MULT_DIV_MOD' => -165,
			'OP08_STRING_CAT' => -165,
			")" => -165,
			'OP15_LOGICAL_AND' => -165,
			";" => -165,
			'OP02_METHOD_THINARROW' => -165,
			'OP13_BITWISE_AND' => -165,
			'OP02_ARRAY_THINARROW' => 258,
			'OP18_TERNARY' => -165,
			"]" => -165,
			'OP08_MATH_ADD_SUB' => -165,
			'OP14_BITWISE_OR_XOR' => -165,
			'OP24_LOGICAL_OR_XOR' => -165,
			'OP02_HASH_THINARROW' => 260,
			'OP06_REGEX_MATCH' => -165,
			'COLON' => -165,
			'OP11_COMPARE_LT_GT' => -165,
			'OP17_LIST_RANGE' => -165,
			'OP23_LOGICAL_AND' => -165
		},
		GOTOS => {
			'VariableRetrieval' => 259
		}
	},
	{#State 190
		ACTIONS => {
			"}" => 261
		}
	},
	{#State 191
		ACTIONS => {
			"}" => 262
		}
	},
	{#State 192
		ACTIONS => {
			'WORD' => 158,
			"%{" => 109
		},
		GOTOS => {
			'HashEntry' => 156,
			'HashDereferenced' => 157
		}
	},
	{#State 193
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			"]" => -94,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			"}" => -94,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP21_LIST_COMMA' => -94,
			";" => -94,
			'OP15_LOGICAL_AND' => -94,
			")" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169
		}
	},
	{#State 194
		ACTIONS => {
			"}" => 263
		}
	},
	{#State 195
		ACTIONS => {
			"}" => 264
		}
	},
	{#State 196
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 265
		}
	},
	{#State 197
		ACTIONS => {
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 133,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'KEYS_OR_VALUES' => 125,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112
		},
		GOTOS => {
			'ListElement' => 266,
			'WordScoped' => 83,
			'Variable' => 134,
			'TypeInner' => 126,
			'Operator' => 103,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'SubExpression' => 147,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'HashDereferenced' => 80
		}
	},
	{#State 198
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP15_LOGICAL_AND' => 177,
			")" => 267,
			'OP13_BITWISE_AND' => 178,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP23_LOGICAL_AND' => 165,
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 199
		ACTIONS => {
			"filehandle_ref" => 268
		}
	},
	{#State 200
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => 173,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP13_BITWISE_AND' => 178,
			")" => 269,
			'OP15_LOGICAL_AND' => 177,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 165,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164
		}
	},
	{#State 201
		ACTIONS => {
			";" => 270
		}
	},
	{#State 202
		ACTIONS => {
			"use constant" => 47,
			"our hash_ref \$properties" => 273
		},
		GOTOS => {
			'Constant' => 272,
			'Properties' => 271
		}
	},
	{#State 203
		DEFAULT => -53
	},
	{#State 204
		ACTIONS => {
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'OP10_NAMED_UNARY' => 110,
			"undef" => 112,
			'WORD' => 111,
			'OP01_NAMED_VOID' => 117,
			"while (" => -141,
			'OP05_MATH_NEG_LPAREN' => 116,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102,
			'OP01_PRINT' => 100,
			"%{" => 109,
			"foreach my" => -141,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP19_LOOP_CONTROL' => 106,
			'OP01_NAMED_VOID_SCOLON' => 87,
			'LBRACE' => 88,
			'OP01_NAMED' => 84,
			'OP03_MATH_INC_DEC' => 85,
			"for my integer" => -141,
			"if (" => 98,
			"my" => 97,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'LBRACKET' => 72,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75
		},
		GOTOS => {
			'VariableDeclaration' => 76,
			'Literal' => 107,
			'HashDereferenced' => 80,
			'Statement' => 78,
			'PAREN-34' => 71,
			'Conditional' => 70,
			'Operation' => 275,
			'LoopLabel' => 73,
			'Variable' => 74,
			'PLUS-17' => 274,
			'Operator' => 103,
			'SubExpression' => 95,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 91,
			'VariableModification' => 89,
			'Expression' => 90,
			'OperatorVoid' => 99,
			'OPTIONAL-35' => 86,
			'WordScoped' => 83
		}
	},
	{#State 205
		DEFAULT => -42
	},
	{#State 206
		ACTIONS => {
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 276
		}
	},
	{#State 207
		ACTIONS => {
			"\$TYPED_" => 277
		}
	},
	{#State 208
		ACTIONS => {
			";" => 278
		}
	},
	{#State 209
		DEFAULT => -40
	},
	{#State 210
		DEFAULT => -182
	},
	{#State 211
		ACTIONS => {
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP21_LIST_COMMA' => -181,
			'OP09_BITWISE_SHIFT' => 176,
			";" => -181,
			'OP15_LOGICAL_AND' => 177,
			")" => -181,
			'OP13_BITWISE_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => 163,
			"]" => -181,
			'OP08_MATH_ADD_SUB' => 170,
			'OP17_LIST_RANGE' => 164,
			'OP11_COMPARE_LT_GT' => 171,
			'OP23_LOGICAL_AND' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172
		}
	},
	{#State 212
		ACTIONS => {
			'WORD' => 279,
			")" => 280
		}
	},
	{#State 213
		DEFAULT => -177
	},
	{#State 214
		ACTIONS => {
			'OP07_STRING_REPEAT' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP16_LOGICAL_OR' => -79,
			"}" => -79,
			'OP04_MATH_POW' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP08_STRING_CAT' => -79,
			")" => -79,
			";" => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP18_TERNARY' => -79,
			"]" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP23_LOGICAL_AND' => -79
		}
	},
	{#State 215
		ACTIONS => {
			'OP21_LIST_COMMA' => 282,
			"]" => -178,
			";" => -178,
			")" => -178
		},
		GOTOS => {
			'PAREN-42' => 281
		}
	},
	{#State 216
		DEFAULT => -185
	},
	{#State 217
		ACTIONS => {
			"\$TYPED_" => 283
		}
	},
	{#State 218
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'OP01_QW' => 127,
			'LITERAL_NUMBER' => 77,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => 96,
			")" => -121,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			"\@{" => 113,
			'LBRACE' => 88,
			'LPAREN' => 114,
			'KEYS_OR_VALUES' => 125,
			'OP01_OPEN' => 115,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112
		},
		GOTOS => {
			'WordScoped' => 83,
			'ListElement' => 129,
			'ListElements' => 285,
			'Operator' => 103,
			'TypeInner' => 126,
			'Variable' => 134,
			'OPTIONAL-33' => 284,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 130,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'HashDereferenced' => 80
		}
	},
	{#State 219
		DEFAULT => -138
	},
	{#State 220
		ACTIONS => {
			";" => 286
		}
	},
	{#State 221
		ACTIONS => {
			'OP17_LIST_RANGE' => 164,
			'OP11_COMPARE_LT_GT' => 171,
			'OP23_LOGICAL_AND' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 170,
			";" => -137,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176
		}
	},
	{#State 222
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP23_LOGICAL_AND' => 165,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => 173,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP13_BITWISE_AND' => 178,
			'OP15_LOGICAL_AND' => 177,
			";" => 287
		}
	},
	{#State 223
		DEFAULT => -118
	},
	{#State 224
		ACTIONS => {
			")" => 288
		}
	},
	{#State 225
		DEFAULT => -126
	},
	{#State 226
		ACTIONS => {
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'KEYS_OR_VALUES' => 125,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 133,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_NUMBER' => 77,
			'OP01_QW' => 127,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Variable' => 134,
			'TypeInner' => 126,
			'Operator' => 103,
			'ListElements' => 289,
			'ListElement' => 129,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'SubExpression' => 130,
			'Expression' => 132,
			'ArrayDereferenced' => 91
		}
	},
	{#State 227
		ACTIONS => {
			'LPAREN' => 290
		}
	},
	{#State 228
		ACTIONS => {
			'VARIABLE_SYMBOL' => 291
		}
	},
	{#State 229
		ACTIONS => {
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP13_BITWISE_AND' => 178,
			")" => 292,
			'OP15_LOGICAL_AND' => 177,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => 173,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => 165,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 163,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 230
		ACTIONS => {
			"}" => 293,
			'OP21_LIST_COMMA' => 294
		},
		GOTOS => {
			'PAREN-47' => 295
		}
	},
	{#State 231
		ACTIONS => {
			'LPAREN' => -189,
			'OP01_OPEN' => -189,
			'LBRACE' => -189,
			"\@{" => -189,
			'OP01_NAMED' => -189,
			'OP10_NAMED_UNARY' => -189,
			'OP03_MATH_INC_DEC' => -189,
			'WORD' => -189,
			"undef" => -189,
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => -189,
			'OP05_LOGICAL_NEG' => -189,
			'OP05_MATH_NEG_LPAREN' => -189,
			'CONSTANT_SYMBOL' => -189,
			'LBRACKET' => -189,
			'LITERAL_STRING' => -189,
			"%{" => -189,
			'VARIABLE_SYMBOL' => -189,
			'WORD_SCOPED' => -189,
			'OP22_LOGICAL_NEG' => -189,
			'LITERAL_NUMBER' => -189,
			'OP01_CLOSE' => -189
		},
		GOTOS => {
			'OPTIONAL-46' => 297,
			'TypeInner' => 296
		}
	},
	{#State 232
		ACTIONS => {
			'OP17_LIST_RANGE' => -100,
			'OP11_COMPARE_LT_GT' => 171,
			'OP23_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => 170,
			"]" => -100,
			";" => -100,
			'OP15_LOGICAL_AND' => -100,
			")" => -100,
			'OP13_BITWISE_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP16_LOGICAL_OR' => -100,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			"}" => -100,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP21_LIST_COMMA' => -100
		}
	},
	{#State 233
		DEFAULT => -206
	},
	{#State 234
		ACTIONS => {
			'COLON' => 298
		}
	},
	{#State 235
		DEFAULT => -207
	},
	{#State 236
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 162,
			"]" => -103,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			"}" => -103,
			'OP16_LOGICAL_OR' => 173,
			'OP21_LIST_COMMA' => -103,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => 178,
			'OP15_LOGICAL_AND' => 177,
			";" => -103,
			")" => -103,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168
		}
	},
	{#State 237
		ACTIONS => {
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP23_LOGICAL_AND' => -106,
			'OP18_TERNARY' => 163,
			"]" => -106,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			";" => -106,
			'OP15_LOGICAL_AND' => 177,
			")" => -106,
			'OP13_BITWISE_AND' => 178,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP21_LIST_COMMA' => -106,
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NE' => 174,
			"}" => -106,
			'OP04_MATH_POW' => 175
		}
	},
	{#State 238
		DEFAULT => -88
	},
	{#State 239
		ACTIONS => {
			'OP23_LOGICAL_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP06_REGEX_MATCH' => 166,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			"]" => -89,
			'OP18_TERNARY' => -89,
			'OP13_BITWISE_AND' => -89,
			")" => -89,
			'OP15_LOGICAL_AND' => -89,
			";" => -89,
			'OP08_STRING_CAT' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP04_MATH_POW' => 175,
			"}" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP07_STRING_REPEAT' => -89
		}
	},
	{#State 240
		ACTIONS => {
			'OP17_LIST_RANGE' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP06_REGEX_MATCH' => 166,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP18_TERNARY' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			"]" => -90,
			")" => -90,
			";" => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP08_STRING_CAT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP04_MATH_POW' => 175,
			"}" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => -90,
			'OP21_LIST_COMMA' => -90
		}
	},
	{#State 241
		ACTIONS => {
			"]" => -92,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => -92,
			"}" => -92,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => -92,
			'OP08_STRING_CAT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP13_BITWISE_AND' => -92,
			'OP15_LOGICAL_AND' => -92,
			";" => -92,
			")" => -92
		}
	},
	{#State 242
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			"]" => -91,
			'OP18_TERNARY' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_STRING_CAT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP13_BITWISE_AND' => -91,
			")" => -91,
			'OP15_LOGICAL_AND' => -91,
			";" => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP07_STRING_REPEAT' => 167,
			'OP04_MATH_POW' => 175,
			"}" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP16_LOGICAL_OR' => -91
		}
	},
	{#State 243
		ACTIONS => {
			'OP16_LOGICAL_OR' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP04_MATH_POW' => 175,
			"}" => -97,
			'OP07_STRING_REPEAT' => 167,
			'OP21_LIST_COMMA' => -97,
			'OP09_BITWISE_SHIFT' => 176,
			";" => -97,
			'OP15_LOGICAL_AND' => -97,
			")" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP18_TERNARY' => -97,
			"]" => -97,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => undef,
			'OP17_LIST_RANGE' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => -97
		}
	},
	{#State 244
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP23_LOGICAL_AND' => 165,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP06_REGEX_MATCH' => 166,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 170,
			"]" => -107,
			")" => -107,
			";" => -107,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP16_LOGICAL_OR' => 173,
			"}" => -107,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP21_LIST_COMMA' => -107,
			'OP09_BITWISE_SHIFT' => 176
		}
	},
	{#State 245
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => -102,
			"]" => -102,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP06_REGEX_MATCH' => 166,
			'OP16_LOGICAL_OR' => -102,
			'OP04_MATH_POW' => 175,
			"}" => -102,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP21_LIST_COMMA' => -102,
			")" => -102,
			";" => -102,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169
		}
	},
	{#State 246
		ACTIONS => {
			'OP04_MATH_POW' => 175,
			"}" => -98,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP16_LOGICAL_OR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => -98,
			")" => -98,
			'OP15_LOGICAL_AND' => -98,
			";" => -98,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP14_BITWISE_OR_XOR' => -98,
			"]" => -98,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP11_COMPARE_LT_GT' => 171,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP06_REGEX_MATCH' => 166
		}
	},
	{#State 247
		ACTIONS => {
			"]" => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP18_TERNARY' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP17_LIST_RANGE' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP04_MATH_POW' => 175,
			"}" => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP08_STRING_CAT' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP15_LOGICAL_AND' => -85,
			";" => -85,
			")" => -85
		}
	},
	{#State 248
		ACTIONS => {
			";" => -93,
			'OP15_LOGICAL_AND' => -93,
			")" => -93,
			'OP13_BITWISE_AND' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP16_LOGICAL_OR' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP04_MATH_POW' => 175,
			"}" => -93,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP18_TERNARY' => -93,
			'OP08_MATH_ADD_SUB' => 170,
			"]" => -93
		}
	},
	{#State 249
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP06_REGEX_MATCH' => 166,
			'OP23_LOGICAL_AND' => -101,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => -101,
			"]" => -101,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -101,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP13_BITWISE_AND' => 178,
			")" => -101,
			'OP15_LOGICAL_AND' => -101,
			";" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			"}" => -101,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => -101
		}
	},
	{#State 250
		ACTIONS => {
			'OP04_MATH_POW' => 175,
			"}" => -99,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => -99,
			")" => -99,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP14_BITWISE_OR_XOR' => -99,
			"]" => -99,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => 166
		}
	},
	{#State 251
		DEFAULT => -96
	},
	{#State 252
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 299,
			";" => 300
		}
	},
	{#State 253
		ACTIONS => {
			'LBRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 301
		}
	},
	{#State 254
		ACTIONS => {
			";" => 303
		}
	},
	{#State 255
		ACTIONS => {
			";" => 304
		}
	},
	{#State 256
		DEFAULT => -124
	},
	{#State 257
		DEFAULT => -117
	},
	{#State 258
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96,
			"undef" => 112,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			'LBRACE' => 88
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 305,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83
		}
	},
	{#State 259
		DEFAULT => -163
	},
	{#State 260
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 306,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			'LBRACE' => 88,
			"\@{" => 113
		},
		GOTOS => {
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83,
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 307,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'Literal' => 107
		}
	},
	{#State 261
		DEFAULT => -198
	},
	{#State 262
		DEFAULT => -199
	},
	{#State 263
		DEFAULT => -186
	},
	{#State 264
		DEFAULT => -187
	},
	{#State 265
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'OP01_QW' => 127,
			"%{" => 109,
			'OP22_LOGICAL_NEG' => 79,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => 96,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'OP01_OPEN' => 115,
			'KEYS_OR_VALUES' => 125,
			'LPAREN' => 114,
			"\@{" => 113,
			'LBRACE' => 88
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 130,
			'Literal' => 107,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'ListElements' => 308,
			'Operator' => 103,
			'TypeInner' => 126,
			'Variable' => 134,
			'WordScoped' => 83,
			'ListElement' => 129
		}
	},
	{#State 266
		ACTIONS => {
			'OP21_LIST_COMMA' => 309
		}
	},
	{#State 267
		DEFAULT => -136
	},
	{#State 268
		ACTIONS => {
			'FH_REF_SYMBOL' => 310
		}
	},
	{#State 269
		DEFAULT => -87
	},
	{#State 270
		DEFAULT => -114
	},
	{#State 271
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 311
		}
	},
	{#State 272
		DEFAULT => -55
	},
	{#State 273
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 312
		}
	},
	{#State 274
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'OP01_PRINT' => 100,
			'CONSTANT_SYMBOL' => 104,
			'OP19_LOOP_CONTROL' => 106,
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			"foreach my" => -141,
			'WORD_SCOPED' => 24,
			'WORD' => 111,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 110,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"}" => 313,
			"\@{" => 113,
			'OP05_MATH_NEG_LPAREN' => 116,
			"while (" => -141,
			'OP01_NAMED_VOID' => 117,
			'LBRACKET' => 72,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP22_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 84,
			"for my integer" => -141,
			'OP01_NAMED_VOID_SCOLON' => 87,
			'LBRACE' => 88,
			'OP05_LOGICAL_NEG' => 92,
			"if (" => 98,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 97
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'Statement' => 78,
			'VariableDeclaration' => 76,
			'Literal' => 107,
			'Operation' => 314,
			'LoopLabel' => 73,
			'Variable' => 74,
			'Operator' => 103,
			'PAREN-34' => 71,
			'Conditional' => 70,
			'OperatorVoid' => 99,
			'SubExpression' => 95,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'ArrayDereferenced' => 91,
			'Expression' => 90,
			'VariableModification' => 89,
			'OPTIONAL-35' => 86,
			'WordScoped' => 83
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
		DEFAULT => -176
	},
	{#State 280
		DEFAULT => -179
	},
	{#State 281
		DEFAULT => -174
	},
	{#State 282
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			"\@{" => 113,
			'LBRACE' => 88,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'KEYS_OR_VALUES' => 125,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => 96
		},
		GOTOS => {
			'WordScoped' => 83,
			'ListElement' => 317,
			'Operator' => 103,
			'Variable' => 134,
			'TypeInner' => 126,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'SubExpression' => 130,
			'HashDereferenced' => 80
		}
	},
	{#State 283
		ACTIONS => {
			'WORD' => 318
		}
	},
	{#State 284
		ACTIONS => {
			")" => 319
		}
	},
	{#State 285
		DEFAULT => -120
	},
	{#State 286
		DEFAULT => -171
	},
	{#State 287
		DEFAULT => -172
	},
	{#State 288
		DEFAULT => -123
	},
	{#State 289
		ACTIONS => {
			";" => 320
		}
	},
	{#State 290
		ACTIONS => {
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'LBRACE' => 88,
			"\@{" => 113
		},
		GOTOS => {
			'SubExpression' => 321,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103
		}
	},
	{#State 291
		ACTIONS => {
			'LPAREN' => 322
		}
	},
	{#State 292
		ACTIONS => {
			'LBRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 323
		}
	},
	{#State 293
		DEFAULT => -197
	},
	{#State 294
		ACTIONS => {
			'WORD' => 158,
			"%{" => 109
		},
		GOTOS => {
			'HashDereferenced' => 157,
			'HashEntry' => 324
		}
	},
	{#State 295
		DEFAULT => -195
	},
	{#State 296
		DEFAULT => -188
	},
	{#State 297
		ACTIONS => {
			"\@{" => 113,
			'LBRACE' => 88,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 325,
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83
		}
	},
	{#State 298
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'LITERAL_NUMBER' => 77,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'VariableOrLiteral' => 326,
			'Variable' => 233,
			'Literal' => 235
		}
	},
	{#State 299
		ACTIONS => {
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			'STDIN' => 219,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23
		},
		GOTOS => {
			'HashReference' => 93,
			'Literal' => 107,
			'ArrayReference' => 94,
			'SubExpression' => 221,
			'Expression' => 132,
			'SubExpressionOrStdin' => 327,
			'ArrayDereferenced' => 91,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'Variable' => 134,
			'Operator' => 103
		}
	},
	{#State 300
		DEFAULT => -169
	},
	{#State 301
		DEFAULT => -149,
		GOTOS => {
			'STAR-37' => 328
		}
	},
	{#State 302
		ACTIONS => {
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			"foreach my" => -141,
			'WORD_SCOPED' => 24,
			'OP19_LOOP_CONTROL' => 106,
			'CONSTANT_SYMBOL' => 104,
			'LITERAL_STRING' => 102,
			'OP01_PRINT' => 100,
			"while (" => -141,
			'OP01_NAMED_VOID' => 117,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			"undef" => 112,
			'WORD' => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'LBRACKET' => 72,
			"if (" => 98,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 97,
			'OP05_LOGICAL_NEG' => 92,
			'LBRACE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 87,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 84,
			"for my integer" => -141
		},
		GOTOS => {
			'Operation' => 329,
			'LoopLabel' => 73,
			'Variable' => 74,
			'Operator' => 103,
			'Conditional' => 70,
			'PAREN-34' => 71,
			'HashDereferenced' => 80,
			'PLUS-40' => 330,
			'Statement' => 78,
			'VariableDeclaration' => 76,
			'Literal' => 107,
			'OPTIONAL-35' => 86,
			'WordScoped' => 83,
			'OperatorVoid' => 99,
			'SubExpression' => 95,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 90,
			'VariableModification' => 89
		}
	},
	{#State 303
		DEFAULT => -112
	},
	{#State 304
		DEFAULT => -111
	},
	{#State 305
		ACTIONS => {
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 170,
			"]" => 331,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP23_LOGICAL_AND' => 165,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178
		}
	},
	{#State 306
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -200,
			"}" => 332,
			'LPAREN' => -200
		}
	},
	{#State 307
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			"}" => 333,
			'OP16_LOGICAL_OR' => 173,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => 178,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 163,
			'OP23_LOGICAL_AND' => 165,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172
		}
	},
	{#State 308
		ACTIONS => {
			")" => 334
		}
	},
	{#State 309
		ACTIONS => {
			'LITERAL_STRING' => 102,
			'LBRACKET' => 72,
			'CONSTANT_SYMBOL' => 104,
			'OP01_QW' => 127,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'OP22_LOGICAL_NEG' => 79,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			"%{" => 109,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_OPEN' => 115,
			'KEYS_OR_VALUES' => 125,
			'LPAREN' => 114,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			"my" => 133,
			'OP10_STRINGIFY_UNARY' => 96
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'SubExpression' => 130,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'TypeInner' => 126,
			'Variable' => 134,
			'Operator' => 103,
			'ListElements' => 335,
			'WordScoped' => 83,
			'ListElement' => 129
		}
	},
	{#State 310
		ACTIONS => {
			'OP21_LIST_COMMA' => 336
		}
	},
	{#State 311
		ACTIONS => {
			'LITERAL_NUMBER' => 341,
			"our" => 337
		},
		GOTOS => {
			'Subroutine' => 338,
			'MethodOrSubroutine' => 340,
			'Method' => 339
		}
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 342
		}
	},
	{#State 313
		ACTIONS => {
			";" => 343
		}
	},
	{#State 314
		DEFAULT => -44
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
		DEFAULT => -173
	},
	{#State 318
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 346
		}
	},
	{#State 319
		DEFAULT => -125
	},
	{#State 320
		DEFAULT => -115
	},
	{#State 321
		ACTIONS => {
			'OP23_LOGICAL_AND' => 165,
			'OP17_LIST_RANGE' => 347,
			'OP11_COMPARE_LT_GT' => 171,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP06_REGEX_MATCH' => 166,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 163,
			'OP13_BITWISE_AND' => 178,
			'OP15_LOGICAL_AND' => 177,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP16_LOGICAL_OR' => 173,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167
		}
	},
	{#State 322
		ACTIONS => {
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'OP01_QW' => 127,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 133,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'LPAREN' => 114,
			'KEYS_OR_VALUES' => 125,
			'OP01_OPEN' => 115,
			'LBRACE' => 88,
			"\@{" => 113,
			'OP10_NAMED_UNARY' => 110,
			'OP01_NAMED' => 128,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112
		},
		GOTOS => {
			'ListElement' => 129,
			'WordScoped' => 83,
			'Operator' => 103,
			'ListElements' => 348,
			'Variable' => 134,
			'TypeInner' => 126,
			'Expression' => 132,
			'ArrayDereferenced' => 91,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'SubExpression' => 130,
			'HashDereferenced' => 80
		}
	},
	{#State 323
		DEFAULT => -159
	},
	{#State 324
		DEFAULT => -194
	},
	{#State 325
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 170,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP23_LOGICAL_AND' => 165,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP16_LOGICAL_OR' => 173,
			'OP12_COMPARE_EQ_NE' => 174,
			"}" => -190,
			'OP04_MATH_POW' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP21_LIST_COMMA' => -190,
			'OP09_BITWISE_SHIFT' => 176,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169
		}
	},
	{#State 326
		DEFAULT => -104
	},
	{#State 327
		ACTIONS => {
			";" => 349
		}
	},
	{#State 328
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -152,
			"elsif (" => 350,
			'OP01_NAMED_VOID' => -152,
			"while (" => -152,
			'OP10_NAMED_UNARY' => -152,
			'WORD' => -152,
			"undef" => -152,
			"else" => 352,
			'LPAREN' => -152,
			'OP01_OPEN' => -152,
			"\@{" => -152,
			"}" => -152,
			'' => -152,
			'OP19_LOOP_CONTROL' => -152,
			"%{" => -152,
			'WORD_SCOPED' => -152,
			'VARIABLE_SYMBOL' => -152,
			"foreach my" => -152,
			'LITERAL_STRING' => -152,
			'OP01_PRINT' => -152,
			'CONSTANT_SYMBOL' => -152,
			'OP05_LOGICAL_NEG' => -152,
			"if (" => -152,
			"my" => -152,
			'OP10_STRINGIFY_UNARY' => -152,
			'OP01_NAMED' => -152,
			'OP03_MATH_INC_DEC' => -152,
			"for my integer" => -152,
			'OP01_NAMED_VOID_SCOLON' => -152,
			'LBRACE' => -152,
			'LITERAL_NUMBER' => -152,
			'OP01_CLOSE' => -152,
			'OP19_LOOP_CONTROL_SCOLON' => -152,
			'OP22_LOGICAL_NEG' => -152,
			'LBRACKET' => -152
		},
		GOTOS => {
			'PAREN-38' => 353,
			'OPTIONAL-39' => 354,
			'PAREN-36' => 351
		}
	},
	{#State 329
		DEFAULT => -161
	},
	{#State 330
		ACTIONS => {
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'OP22_LOGICAL_NEG' => 79,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'LBRACKET' => 72,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96,
			"my" => 97,
			"if (" => 98,
			"for my integer" => -141,
			'OP01_NAMED' => 84,
			'OP03_MATH_INC_DEC' => 85,
			'LBRACE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 87,
			'OP19_LOOP_CONTROL' => 106,
			'VARIABLE_SYMBOL' => 108,
			"foreach my" => -141,
			'WORD_SCOPED' => 24,
			"%{" => 109,
			'OP01_PRINT' => 100,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP01_NAMED_VOID' => 117,
			"while (" => -141,
			'OP10_NAMED_UNARY' => 110,
			"undef" => 112,
			'WORD' => 111,
			"\@{" => 113,
			"}" => 356,
			'LPAREN' => 114,
			'OP01_OPEN' => 115
		},
		GOTOS => {
			'OperatorVoid' => 99,
			'VariableModification' => 89,
			'Expression' => 90,
			'ArrayDereferenced' => 91,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'SubExpression' => 95,
			'WordScoped' => 83,
			'OPTIONAL-35' => 86,
			'Statement' => 78,
			'HashDereferenced' => 80,
			'VariableDeclaration' => 76,
			'Literal' => 107,
			'Operator' => 103,
			'Variable' => 74,
			'LoopLabel' => 73,
			'Operation' => 355,
			'PAREN-34' => 71,
			'Conditional' => 70
		}
	},
	{#State 331
		DEFAULT => -166
	},
	{#State 332
		DEFAULT => -168
	},
	{#State 333
		DEFAULT => -167
	},
	{#State 334
		DEFAULT => -78
	},
	{#State 335
		ACTIONS => {
			")" => 357
		}
	},
	{#State 336
		ACTIONS => {
			'LITERAL_STRING' => 358
		}
	},
	{#State 337
		ACTIONS => {
			'WORD' => 55,
			'TYPE_METHOD' => 359
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 338
		DEFAULT => -75
	},
	{#State 339
		DEFAULT => -74
	},
	{#State 340
		DEFAULT => -57
	},
	{#State 341
		ACTIONS => {
			";" => 360
		}
	},
	{#State 342
		ACTIONS => {
			"}" => 363,
			"%{" => 109,
			'WORD' => 362
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
			'OP21_LIST_COMMA' => 365,
			")" => 367
		},
		GOTOS => {
			'PAREN-18' => 366
		}
	},
	{#State 345
		DEFAULT => -205
	},
	{#State 346
		DEFAULT => -204
	},
	{#State 347
		ACTIONS => {
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'LBRACE' => 88,
			"\@{" => 113,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'WORD' => 23,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			"%{" => 109,
			'OP01_CLOSE' => 75,
			'LITERAL_NUMBER' => 77,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'SubExpression' => 368,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'Literal' => 107,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 83
		}
	},
	{#State 348
		ACTIONS => {
			")" => 369
		}
	},
	{#State 349
		DEFAULT => -170
	},
	{#State 350
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 116,
			'OP05_LOGICAL_NEG' => 92,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			'WORD' => 23,
			'OP03_MATH_INC_DEC' => 85,
			"undef" => 112,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_STRING' => 102,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'SubExpression' => 370,
			'ArrayReference' => 94,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'Variable' => 134,
			'Operator' => 103,
			'WordScoped' => 83
		}
	},
	{#State 351
		DEFAULT => -148
	},
	{#State 352
		ACTIONS => {
			'LBRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 371
		}
	},
	{#State 353
		DEFAULT => -151
	},
	{#State 354
		DEFAULT => -153
	},
	{#State 355
		DEFAULT => -160
	},
	{#State 356
		DEFAULT => -162
	},
	{#State 357
		DEFAULT => -80
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
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			'OP16_LOGICAL_OR' => 173,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP13_BITWISE_AND' => 178,
			'OP15_LOGICAL_AND' => 177,
			")" => 379,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP17_LIST_RANGE' => undef,
			'OP11_COMPARE_LT_GT' => 171,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => -103
		}
	},
	{#State 369
		ACTIONS => {
			'LBRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 380
		}
	},
	{#State 370
		ACTIONS => {
			")" => 381,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			'OP16_LOGICAL_OR' => 173,
			'OP04_MATH_POW' => 175,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP09_BITWISE_SHIFT' => 176,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP23_LOGICAL_AND' => 165,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP06_REGEX_MATCH' => 166,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP18_TERNARY' => 163,
			'OP08_MATH_ADD_SUB' => 170
		}
	},
	{#State 371
		DEFAULT => -150
	},
	{#State 372
		ACTIONS => {
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			"\@{" => 113,
			'LBRACE' => 88,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23
		},
		GOTOS => {
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 382,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'HashDereferenced' => 80,
			'WordScoped' => 83,
			'Operator' => 103,
			'Variable' => 134
		}
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 383
		}
	},
	{#State 374
		ACTIONS => {
			"my" => 133
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
			"}" => 387
		},
		GOTOS => {
			'PAREN-24' => 385
		}
	},
	{#State 377
		ACTIONS => {
			'WORD' => 55
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
			'LBRACE' => 302
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
			'LBRACE' => 302
		},
		GOTOS => {
			'CodeBlock' => 391
		}
	},
	{#State 382
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP08_STRING_CAT' => 169,
			")" => -81,
			";" => -81,
			'OP15_LOGICAL_AND' => 177,
			'OP13_BITWISE_AND' => 178,
			'OP07_STRING_REPEAT' => 167,
			'OP21_LIST_COMMA' => -81,
			'OP09_BITWISE_SHIFT' => 176,
			'OP16_LOGICAL_OR' => 173,
			'OP04_MATH_POW' => 175,
			"}" => -81,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => 166,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP23_LOGICAL_AND' => -81,
			'OP18_TERNARY' => 163,
			"]" => -81,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 162
		}
	},
	{#State 383
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -66,
			'OP01_NAMED' => -66,
			"for my integer" => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LBRACE' => -66,
			'OP05_LOGICAL_NEG' => -66,
			"if (" => -66,
			"my" => -66,
			'OP10_STRINGIFY_UNARY' => -66,
			'LBRACKET' => -66,
			'LITERAL_NUMBER' => -66,
			'OP01_CLOSE' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'WORD' => -66,
			"undef" => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP01_OPEN' => -66,
			'LPAREN' => -66,
			"\@{" => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"while (" => -66,
			'OP01_NAMED_VOID' => -66,
			'LITERAL_STRING' => -66,
			'OP01_PRINT' => -66,
			'CONSTANT_SYMBOL' => -66,
			"( my" => 392,
			'OP19_LOOP_CONTROL' => -66,
			"%{" => -66,
			'VARIABLE_SYMBOL' => -66,
			"foreach my" => -66,
			'WORD_SCOPED' => -66
		},
		GOTOS => {
			'OPTIONAL-26' => 394,
			'MethodArguments' => 393
		}
	},
	{#State 384
		ACTIONS => {
			"%{" => 109,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 79,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'CONSTANT_SYMBOL' => 104,
			'LBRACKET' => 72,
			'LITERAL_STRING' => 102,
			'OP10_STRINGIFY_UNARY' => 96,
			'OP05_LOGICAL_NEG' => 92,
			'OP05_MATH_NEG_LPAREN' => 116,
			'LPAREN' => 114,
			'OP01_OPEN' => 115,
			'LBRACE' => 88,
			"\@{" => 113,
			'OP01_NAMED' => 128,
			'OP10_NAMED_UNARY' => 110,
			"undef" => 112,
			'OP03_MATH_INC_DEC' => 85,
			'WORD' => 23
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'ArrayDereferenced' => 91,
			'Expression' => 132,
			'SubExpression' => 395,
			'Literal' => 107,
			'HashReference' => 93,
			'ArrayReference' => 94,
			'Operator' => 103,
			'Variable' => 134,
			'WordScoped' => 83
		}
	},
	{#State 385
		DEFAULT => -61
	},
	{#State 386
		ACTIONS => {
			'WORD' => 362,
			"%{" => 109
		},
		GOTOS => {
			'HashDereferenced' => 361,
			'HashEntryTyped' => 396
		}
	},
	{#State 387
		ACTIONS => {
			";" => 397
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
		ACTIONS => {
			'TYPE_SELF' => 399
		}
	},
	{#State 393
		DEFAULT => -65
	},
	{#State 394
		ACTIONS => {
			'LBRACKET' => 72,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP22_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 84,
			"for my integer" => -141,
			'LBRACE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 87,
			'OP05_LOGICAL_NEG' => 92,
			"if (" => 98,
			"my" => 97,
			'OP10_STRINGIFY_UNARY' => 96,
			'LITERAL_STRING' => 102,
			'OP01_PRINT' => 100,
			'CONSTANT_SYMBOL' => 104,
			'OP19_LOOP_CONTROL' => 106,
			"%{" => 109,
			'VARIABLE_SYMBOL' => 108,
			"foreach my" => -141,
			'WORD_SCOPED' => 24,
			'WORD' => 111,
			"undef" => 112,
			'OP10_NAMED_UNARY' => 110,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"\@{" => 113,
			'OP05_MATH_NEG_LPAREN' => 116,
			"while (" => -141,
			'OP01_NAMED_VOID' => 117
		},
		GOTOS => {
			'Statement' => 78,
			'HashDereferenced' => 80,
			'VariableDeclaration' => 76,
			'Literal' => 107,
			'Operator' => 103,
			'Operation' => 401,
			'Variable' => 74,
			'LoopLabel' => 73,
			'Conditional' => 70,
			'PAREN-34' => 71,
			'OperatorVoid' => 99,
			'ArrayDereferenced' => 91,
			'VariableModification' => 89,
			'PLUS-27' => 400,
			'Expression' => 90,
			'SubExpression' => 95,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'WordScoped' => 83,
			'OPTIONAL-35' => 86
		}
	},
	{#State 395
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 163,
			'OP14_BITWISE_OR_XOR' => 162,
			'OP06_REGEX_MATCH' => 166,
			'OP24_LOGICAL_OR_XOR' => 172,
			'OP23_LOGICAL_AND' => 165,
			'OP11_COMPARE_LT_GT' => 171,
			'OP17_LIST_RANGE' => 164,
			'OP21_LIST_COMMA' => -192,
			'OP09_BITWISE_SHIFT' => 176,
			'OP07_STRING_REPEAT' => 167,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP04_MATH_POW' => 175,
			"}" => -192,
			'OP16_LOGICAL_OR' => 173,
			'OP08_STRING_CAT' => 169,
			'OP07_MATH_MULT_DIV_MOD' => 168,
			'OP13_BITWISE_AND' => 178,
			'OP15_LOGICAL_AND' => 177
		}
	},
	{#State 396
		DEFAULT => -60
	},
	{#State 397
		DEFAULT => -63
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
		ACTIONS => {
			'LBRACKET' => 72,
			'LITERAL_NUMBER' => 77,
			'OP01_CLOSE' => 75,
			'OP19_LOOP_CONTROL_SCOLON' => 81,
			'OP22_LOGICAL_NEG' => 79,
			'OP03_MATH_INC_DEC' => 85,
			'OP01_NAMED' => 84,
			"for my integer" => -141,
			'LBRACE' => 88,
			'OP01_NAMED_VOID_SCOLON' => 87,
			'OP05_LOGICAL_NEG' => 92,
			"if (" => 98,
			"my" => 97,
			'OP10_STRINGIFY_UNARY' => 96,
			'LITERAL_STRING' => 102,
			'OP01_PRINT' => 100,
			'CONSTANT_SYMBOL' => 104,
			'OP19_LOOP_CONTROL' => 106,
			"%{" => 109,
			'WORD_SCOPED' => 24,
			"foreach my" => -141,
			'VARIABLE_SYMBOL' => 108,
			"undef" => 112,
			'WORD' => 111,
			'OP10_NAMED_UNARY' => 110,
			'OP01_OPEN' => 115,
			'LPAREN' => 114,
			"}" => 403,
			"\@{" => 113,
			'OP05_MATH_NEG_LPAREN' => 116,
			"while (" => -141,
			'OP01_NAMED_VOID' => 117
		},
		GOTOS => {
			'HashDereferenced' => 80,
			'Statement' => 78,
			'Literal' => 107,
			'VariableDeclaration' => 76,
			'Operation' => 404,
			'Variable' => 74,
			'LoopLabel' => 73,
			'Operator' => 103,
			'PAREN-34' => 71,
			'Conditional' => 70,
			'OperatorVoid' => 99,
			'SubExpression' => 95,
			'ArrayReference' => 94,
			'HashReference' => 93,
			'ArrayDereferenced' => 91,
			'Expression' => 90,
			'VariableModification' => 89,
			'OPTIONAL-35' => 86,
			'WordScoped' => 83
		}
	},
	{#State 401
		DEFAULT => -68
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
			'WORD' => 55
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
