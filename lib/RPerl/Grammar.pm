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

#line 2 "lib/RPerl/Grammar.eyp"

    use strict;
    use warnings;
    our $VERSION = 0.001_434;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\$TYPED_|\=\ sub\ \{|foreach|undef|elsif|while|else|\@_\;|for|our|\%\{|if|\@\{|\)|\]|\}|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use)/gc and return ('USE', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G([+-]?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?(e[+-]?\d+)?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q\{[^}]*\}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$self)/gc and return ('SELF', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer)\s+/gc and return ('TYPE_INTEGER', $1);
      /\G(filehandleref\s+)/gc and return ('TYPE_FHREF', $1);
      /\G((?:[a-zA-Z]\w*)+(?:::[a-zA-Z]\w*)*::method)/gc and return ('TYPE_METHOD', $1);
      /\G((?:[a-zA-Z]\w*)?(?:::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
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
      /\G(croak;|die;|exit;|return;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak\(|exit\(|return\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(croak|die|exit|return)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\()/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|keys|values|sort|length|fakebuiltin)\s/gc and return ('OP01_NAMED', $1);
      /\G([a-z]\w*|[A-Z]\w*[a-z]\w*)/gc and return ('WORD', $1);
      /\G([A-Z][A-Z0-9_]*|[A-Z])/gc and return ('WORD_UPPERCASE', $1);
      /\G(::)/gc and return ('SCOPE', $1);
      /\G(:)/gc and return ('COLON', $1);
      /\G(\(\s*my)/gc and return ('LPAREN_MY', $1);
      /\G(\()/gc and return ('LPAREN', $1);
      /\G(\[)/gc and return ('LBRACKET', $1);
      /\G(\{)/gc and return ('LBRACE', $1);


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


#line 136 lib/RPerl/Grammar.pm

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
  [ 'Program_18' => 'Program', [ 'SHEBANG', 'OPTIONAL-3', 'USE_RPERL', 'Header', 'STAR-4', 'STAR-5', 'STAR-6', 'STAR-7', 'PLUS-8' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [ 'USE_RPERL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [  ], 0 ],
  [ 'ModuleHeader_23' => 'ModuleHeader', [ 'OPTIONAL-9', 'OPTIONAL-10', 'package', 'WordScoped', ';', 'Header' ], 0 ],
  [ 'Module_24' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_25' => 'Module', [ 'Class' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [ 'STAR-12', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [ 'STAR-13', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-13', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'PLUS-14', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'Subroutine' ], 0 ],
  [ 'Package_34' => 'Package', [ 'STAR-11', 'STAR-12', 'STAR-13', 'PLUS-14', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-15', [ 'USE_RPERL_AFTER' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-15', [  ], 0 ],
  [ 'Header_37' => 'Header', [ 'use strict;', 'use warnings;', 'OPTIONAL-15', 'our', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-16', [ 'PLUS-16', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-16', [ 'WORD' ], 0 ],
  [ 'Critic_40' => 'Critic', [ '## no critic qw(', 'PLUS-16', ')' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'PLUS-17', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-17', [ 'WORD' ], 0 ],
  [ 'Include_43' => 'Include', [ 'USE', 'WordScoped', ';' ], 0 ],
  [ 'Include_44' => 'Include', [ 'USE', 'WordScoped', 'OP01_QW', 'PLUS-17', ')', ';' ], 0 ],
  [ 'Constant_45' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [ 'STAR-19', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [  ], 0 ],
  [ 'Subroutine_50' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-18', 'STAR-19', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-20', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'PAREN-20' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ 'SubroutineArguments_54' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-21', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'MethodOrSubroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ 'Class_63' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-22', 'STAR-23', 'STAR-24', 'Properties', 'STAR-25', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-26', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'PAREN-26' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'Properties_67' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryTyped', 'STAR-27', '}', ';' ], 0 ],
  [ 'Properties_68' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-28', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-28', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ 'Method_73' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-28', 'STAR-29', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'PAREN-30' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ 'MethodArguments_77' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-31', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ 'MethodOrSubroutine_78' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_79' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
  [ 'Operation_80' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_81' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_83' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_109' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_110' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-32', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'PAREN-32' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-33', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-34', ')', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_122' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_123' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'WordScoped', 'SCOPE', 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_132' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-36', ')' ], 0 ],
  [ 'Expression_133' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_141' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_142' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_143' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_144' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'PAREN-37' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ 'Statement_148' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'OPTIONAL-38', 'Loop' ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [ 'STAR-40', 'PAREN-39' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [  ], 0 ],
  [ '_PAREN' => 'PAREN-41', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'PAREN-41' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Conditional_159' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-40', 'OPTIONAL-42' ], 0 ],
  [ 'Loop_160' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_161' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_163' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_164' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_165' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'PLUS-43', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'Operation' ], 0 ],
  [ 'CodeBlock_168' => 'CodeBlock', [ 'LBRACE', 'PLUS-43', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'Variable_171' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-44' ], 0 ],
  [ 'VariableRetrieval_172' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_173' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_174' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_175' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_176' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableDeclaration_177' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_178' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_179' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'ListElements_183' => 'ListElements', [ 'ListElement', 'STAR-46' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-47', [ 'PLUS-47', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-47', [ 'WORD' ], 0 ],
  [ 'ListElement_186' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_187' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'OP01_QW', 'PLUS-47', ')' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'ArrayReference_191' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-48', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'ArrayDereference_194' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_195' => 'ArrayDereference', [ '@{', 'OPTIONAL-49', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashEntry_198' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-50', 'SubExpression' ], 0 ],
  [ 'HashEntry_199' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryTyped_200' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_201' => 'HashEntryTyped', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'HashReference_205' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-52', '}' ], 0 ],
  [ 'HashReference_206' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [  ], 0 ],
  [ 'HashDereference_209' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_210' => 'HashDereference', [ '%{', 'OPTIONAL-53', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_211' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_212' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_213' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_214' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_215' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_216' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_217' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_218' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_219' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_220' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_221' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_222' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_223' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'VariableSymbolOrSelf_224' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_225' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_226' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_227' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  '_OPTIONAL' => 21,
  '_OPTIONAL' => 22,
  'ModuleHeader_23' => 23,
  'Module_24' => 24,
  'Module_25' => 25,
  '_STAR_LIST' => 26,
  '_STAR_LIST' => 27,
  '_STAR_LIST' => 28,
  '_STAR_LIST' => 29,
  '_STAR_LIST' => 30,
  '_STAR_LIST' => 31,
  '_PLUS_LIST' => 32,
  '_PLUS_LIST' => 33,
  'Package_34' => 34,
  '_OPTIONAL' => 35,
  '_OPTIONAL' => 36,
  'Header_37' => 37,
  '_PLUS_LIST' => 38,
  '_PLUS_LIST' => 39,
  'Critic_40' => 40,
  '_PLUS_LIST' => 41,
  '_PLUS_LIST' => 42,
  'Include_43' => 43,
  'Include_44' => 44,
  'Constant_45' => 45,
  '_OPTIONAL' => 46,
  '_OPTIONAL' => 47,
  '_STAR_LIST' => 48,
  '_STAR_LIST' => 49,
  'Subroutine_50' => 50,
  '_PAREN' => 51,
  '_STAR_LIST' => 52,
  '_STAR_LIST' => 53,
  'SubroutineArguments_54' => 54,
  '_STAR_LIST' => 55,
  '_STAR_LIST' => 56,
  '_STAR_LIST' => 57,
  '_STAR_LIST' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  '_STAR_LIST' => 61,
  '_STAR_LIST' => 62,
  'Class_63' => 63,
  '_PAREN' => 64,
  '_STAR_LIST' => 65,
  '_STAR_LIST' => 66,
  'Properties_67' => 67,
  'Properties_68' => 68,
  '_OPTIONAL' => 69,
  '_OPTIONAL' => 70,
  '_STAR_LIST' => 71,
  '_STAR_LIST' => 72,
  'Method_73' => 73,
  '_PAREN' => 74,
  '_STAR_LIST' => 75,
  '_STAR_LIST' => 76,
  'MethodArguments_77' => 77,
  'MethodOrSubroutine_78' => 78,
  'MethodOrSubroutine_79' => 79,
  'Operation_80' => 80,
  'Operation_81' => 81,
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
  'Operator_108' => 108,
  'Operator_109' => 109,
  'Operator_110' => 110,
  '_PAREN' => 111,
  '_OPTIONAL' => 112,
  '_OPTIONAL' => 113,
  '_OPTIONAL' => 114,
  '_OPTIONAL' => 115,
  'OperatorVoid_116' => 116,
  'OperatorVoid_117' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  'OperatorVoid_122' => 122,
  'OperatorVoid_123' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  '_OPTIONAL' => 126,
  '_OPTIONAL' => 127,
  'Expression_128' => 128,
  'Expression_129' => 129,
  'Expression_130' => 130,
  'Expression_131' => 131,
  'Expression_132' => 132,
  'Expression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpression_141' => 141,
  'SubExpression_142' => 142,
  'SubExpressionOrStdin_143' => 143,
  'SubExpressionOrStdin_144' => 144,
  '_PAREN' => 145,
  '_OPTIONAL' => 146,
  '_OPTIONAL' => 147,
  'Statement_148' => 148,
  'Statement_149' => 149,
  'Statement_150' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  '_PAREN' => 153,
  '_STAR_LIST' => 154,
  '_STAR_LIST' => 155,
  '_PAREN' => 156,
  '_OPTIONAL' => 157,
  '_OPTIONAL' => 158,
  'Conditional_159' => 159,
  'Loop_160' => 160,
  'Loop_161' => 161,
  'Loop_162' => 162,
  'LoopFor_163' => 163,
  'LoopForEach_164' => 164,
  'LoopWhile_165' => 165,
  '_PLUS_LIST' => 166,
  '_PLUS_LIST' => 167,
  'CodeBlock_168' => 168,
  '_STAR_LIST' => 169,
  '_STAR_LIST' => 170,
  'Variable_171' => 171,
  'VariableRetrieval_172' => 172,
  'VariableRetrieval_173' => 173,
  'VariableRetrieval_174' => 174,
  'VariableDeclaration_175' => 175,
  'VariableDeclaration_176' => 176,
  'VariableDeclaration_177' => 177,
  'VariableModification_178' => 178,
  'VariableModification_179' => 179,
  '_PAREN' => 180,
  '_STAR_LIST' => 181,
  '_STAR_LIST' => 182,
  'ListElements_183' => 183,
  '_PLUS_LIST' => 184,
  '_PLUS_LIST' => 185,
  'ListElement_186' => 186,
  'ListElement_187' => 187,
  'ListElement_188' => 188,
  '_OPTIONAL' => 189,
  '_OPTIONAL' => 190,
  'ArrayReference_191' => 191,
  '_OPTIONAL' => 192,
  '_OPTIONAL' => 193,
  'ArrayDereference_194' => 194,
  'ArrayDereference_195' => 195,
  '_OPTIONAL' => 196,
  '_OPTIONAL' => 197,
  'HashEntry_198' => 198,
  'HashEntry_199' => 199,
  'HashEntryTyped_200' => 200,
  'HashEntryTyped_201' => 201,
  '_PAREN' => 202,
  '_STAR_LIST' => 203,
  '_STAR_LIST' => 204,
  'HashReference_205' => 205,
  'HashReference_206' => 206,
  '_OPTIONAL' => 207,
  '_OPTIONAL' => 208,
  'HashDereference_209' => 209,
  'HashDereference_210' => 210,
  'WordScoped_211' => 211,
  'WordScoped_212' => 212,
  'LoopLabel_213' => 213,
  'Type_214' => 214,
  'Type_215' => 215,
  'Type_216' => 216,
  'TypeInner_217' => 217,
  'TypeInnerConstant_218' => 218,
  'VariableOrLiteral_219' => 219,
  'VariableOrLiteral_220' => 220,
  'VariableOrLiteralOrWord_221' => 221,
  'VariableOrLiteralOrWord_222' => 222,
  'VariableOrLiteralOrWord_223' => 223,
  'VariableSymbolOrSelf_224' => 224,
  'VariableSymbolOrSelf_225' => 225,
  'Literal_226' => 226,
  'Literal_227' => 227,
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
	'for' => { ISSEMANTIC => 0 },
	'foreach' => { ISSEMANTIC => 0 },
	'if' => { ISSEMANTIC => 0 },
	'our hashref $properties' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'undef' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent qw(' => { ISSEMANTIC => 0 },
	'use strict;' => { ISSEMANTIC => 0 },
	'use warnings;' => { ISSEMANTIC => 0 },
	'while' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	COLON => { ISSEMANTIC => 1 },
	FHREF_SYMBOL => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	LBRACE => { ISSEMANTIC => 1 },
	LBRACKET => { ISSEMANTIC => 1 },
	LITERAL_NUMBER => { ISSEMANTIC => 1 },
	LITERAL_STRING => { ISSEMANTIC => 1 },
	LPAREN => { ISSEMANTIC => 1 },
	LPAREN_MY => { ISSEMANTIC => 1 },
	MY => { ISSEMANTIC => 1 },
	OP01_CLOSE => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID_LPAREN => { ISSEMANTIC => 1 },
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
	SCOPE => { ISSEMANTIC => 1 },
	SELF => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
	TYPE_FHREF => { ISSEMANTIC => 1 },
	TYPE_INTEGER => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
	USE => { ISSEMANTIC => 1 },
	USE_RPERL => { ISSEMANTIC => 1 },
	USE_RPERL_AFTER => { ISSEMANTIC => 1 },
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
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 9,
			'Program' => 1,
			'OPTIONAL-9' => 8,
			'PLUS-2' => 4,
			'ModuleHeader' => 6,
			'CompileUnit' => 7,
			'PAREN-1' => 3
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-16' => 10
		}
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => 2,
			"package" => -20,
			'USE_RPERL' => -20,
			'' => -5
		},
		GOTOS => {
			'PAREN-1' => 12,
			'ModuleHeader' => 6,
			'OPTIONAL-9' => 8,
			'Critic' => 9
		}
	},
	{#State 5
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'OPTIONAL-3' => 14,
			'Critic' => 13
		}
	},
	{#State 6
		ACTIONS => {
			"use parent qw(" => 19,
			"## no critic qw(" => -27,
			"use constant" => -27,
			"our" => -27,
			'USE' => -27
		},
		GOTOS => {
			'Class' => 18,
			'Module' => 15,
			'Package' => 17,
			'STAR-11' => 16
		}
	},
	{#State 7
		ACTIONS => {
			'' => 20
		}
	},
	{#State 8
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 22
		},
		GOTOS => {
			'OPTIONAL-10' => 21
		}
	},
	{#State 9
		DEFAULT => -19
	},
	{#State 10
		ACTIONS => {
			")" => 24,
			'WORD' => 23
		}
	},
	{#State 11
		DEFAULT => -39
	},
	{#State 12
		DEFAULT => -2
	},
	{#State 13
		DEFAULT => -6
	},
	{#State 14
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		ACTIONS => {
			'USE' => -29,
			"our" => -29,
			"## no critic qw(" => 2,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 27,
			'Critic' => 26
		}
	},
	{#State 17
		DEFAULT => -24
	},
	{#State 18
		DEFAULT => -25
	},
	{#State 19
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 20
		DEFAULT => 0
	},
	{#State 21
		ACTIONS => {
			"package" => 31
		}
	},
	{#State 22
		DEFAULT => -21
	},
	{#State 23
		DEFAULT => -38
	},
	{#State 24
		DEFAULT => -40
	},
	{#State 25
		ACTIONS => {
			"use strict;" => 32
		},
		GOTOS => {
			'Header' => 33
		}
	},
	{#State 26
		DEFAULT => -26
	},
	{#State 27
		ACTIONS => {
			"our" => -31,
			'USE' => 34,
			"use constant" => -31
		},
		GOTOS => {
			'Include' => 36,
			'STAR-13' => 35
		}
	},
	{#State 28
		ACTIONS => {
			")" => 37
		}
	},
	{#State 29
		DEFAULT => -211
	},
	{#State 30
		DEFAULT => -212
	},
	{#State 31
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use warnings;" => 39
		}
	},
	{#State 33
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 41
		}
	},
	{#State 35
		ACTIONS => {
			"our" => 42,
			"use constant" => 44
		},
		GOTOS => {
			'PLUS-14' => 45,
			'Constant' => 46,
			'Subroutine' => 43
		}
	},
	{#State 36
		DEFAULT => -28
	},
	{#State 37
		ACTIONS => {
			";" => 47
		}
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			'USE_RPERL_AFTER' => 49,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 50
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_CLOSE' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'WORD_UPPERCASE' => -11,
			"## no critic qw(" => 2,
			'VARIABLE_SYMBOL' => -11,
			'OP01_PRINT' => -11,
			"while" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			"for" => -11,
			'OP10_NAMED_UNARY' => -11,
			'WORD' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"foreach" => -11,
			"\@{" => -11,
			'OP01_OPEN' => -11,
			'LPAREN' => -11,
			'LBRACE' => -11,
			"our" => -11,
			'OP01_NAMED_VOID' => -11,
			'MY' => -11,
			"if" => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"%{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'SELF' => -11,
			"undef" => -11,
			'USE' => -11,
			'LITERAL_NUMBER' => -11,
			'WORD_SCOPED' => -11,
			"use constant" => -11,
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL' => -11
		},
		GOTOS => {
			'STAR-5' => 52,
			'Critic' => 51
		}
	},
	{#State 41
		ACTIONS => {
			";" => 53,
			'OP01_QW' => 54
		}
	},
	{#State 42
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 58,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 43
		DEFAULT => -33
	},
	{#State 44
		ACTIONS => {
			'WORD_UPPERCASE' => 59
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 61,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 60
		}
	},
	{#State 46
		DEFAULT => -30
	},
	{#State 47
		ACTIONS => {
			'USE' => 34
		},
		GOTOS => {
			'Include' => 62
		}
	},
	{#State 48
		ACTIONS => {
			"use strict;" => 32
		},
		GOTOS => {
			'Header' => 63
		}
	},
	{#State 49
		DEFAULT => -35
	},
	{#State 50
		ACTIONS => {
			"our" => 64
		}
	},
	{#State 51
		DEFAULT => -8
	},
	{#State 52
		ACTIONS => {
			'OP01_PRINT' => -13,
			"while" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'VARIABLE_SYMBOL' => -13,
			'WORD_UPPERCASE' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			"foreach" => -13,
			'OP22_LOGICAL_NEG' => -13,
			'WORD' => -13,
			"for" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LPAREN' => -13,
			'OP01_OPEN' => -13,
			"\@{" => -13,
			"our" => -13,
			'LBRACE' => -13,
			'LITERAL_STRING' => -13,
			'MY' => -13,
			"if" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED' => -13,
			'USE' => 34,
			'LITERAL_NUMBER' => -13,
			"undef" => -13,
			'SELF' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"%{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LBRACKET' => -13,
			"use constant" => -13,
			'WORD_SCOPED' => -13
		},
		GOTOS => {
			'STAR-6' => 65,
			'Include' => 66
		}
	},
	{#State 53
		DEFAULT => -43
	},
	{#State 54
		ACTIONS => {
			'WORD' => 67
		},
		GOTOS => {
			'PLUS-17' => 68
		}
	},
	{#State 55
		DEFAULT => -216
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		}
	},
	{#State 57
		DEFAULT => -214
	},
	{#State 58
		DEFAULT => -215
	},
	{#State 59
		ACTIONS => {
			'OP20_HASH_FATARROW' => 70
		}
	},
	{#State 60
		DEFAULT => -32
	},
	{#State 61
		ACTIONS => {
			";" => 71
		}
	},
	{#State 62
		DEFAULT => -56,
		GOTOS => {
			'STAR-22' => 72
		}
	},
	{#State 63
		DEFAULT => -23
	},
	{#State 64
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 73
		}
	},
	{#State 65
		ACTIONS => {
			'SELF' => -15,
			"undef" => -15,
			'LITERAL_NUMBER' => -15,
			"%{" => -15,
			'OP05_LOGICAL_NEG' => -15,
			"use constant" => 44,
			'LBRACKET' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED_VOID' => -15,
			'MY' => -15,
			"if" => -15,
			'LITERAL_STRING' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'LPAREN' => -15,
			"\@{" => -15,
			'OP01_OPEN' => -15,
			"our" => -15,
			'LBRACE' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_PRINT' => -15,
			"while" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			'WORD_UPPERCASE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"foreach" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP10_NAMED_UNARY' => -15,
			"for" => -15,
			'WORD' => -15
		},
		GOTOS => {
			'Constant' => 75,
			'STAR-7' => 74
		}
	},
	{#State 66
		DEFAULT => -10
	},
	{#State 67
		DEFAULT => -42
	},
	{#State 68
		ACTIONS => {
			")" => 77,
			'WORD' => 76
		}
	},
	{#State 69
		ACTIONS => {
			"= sub {" => 78
		}
	},
	{#State 70
		ACTIONS => {
			'MY' => 79
		},
		GOTOS => {
			'TypeInnerConstant' => 80
		}
	},
	{#State 71
		DEFAULT => -34
	},
	{#State 72
		ACTIONS => {
			"## no critic qw(" => 2,
			"use constant" => -58,
			'USE' => -58,
			"our hashref \$properties" => -58
		},
		GOTOS => {
			'STAR-23' => 81,
			'Critic' => 82
		}
	},
	{#State 73
		DEFAULT => -37
	},
	{#State 74
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_NAMED' => 124,
			'OP01_NAMED_VOID' => 128,
			'LITERAL_STRING' => 130,
			"if" => 131,
			'MY' => 129,
			'OP19_LOOP_CONTROL' => 109,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'OP05_LOGICAL_NEG' => 116,
			"%{" => 115,
			"foreach" => -147,
			'OP22_LOGICAL_NEG' => 93,
			"for" => -147,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			'OP01_NAMED_VOID_SCOLON' => 101,
			"while" => -147,
			'OP01_PRINT' => 100,
			'VARIABLE_SYMBOL' => 98,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 104,
			'OP01_CLOSE' => 103,
			"our" => 42,
			'LBRACE' => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			"\@{" => 90
		},
		GOTOS => {
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Conditional' => 113,
			'PAREN-37' => 85,
			'SubExpression' => 86,
			'Literal' => 88,
			'VariableModification' => 83,
			'HashReference' => 84,
			'VariableDeclaration' => 108,
			'HashDereference' => 102,
			'OPTIONAL-38' => 106,
			'Statement' => 126,
			'Operator' => 127,
			'PLUS-8' => 97,
			'OperatorVoid' => 99,
			'Expression' => 123,
			'LoopLabel' => 96,
			'Operation' => 117,
			'Variable' => 119,
			'ArrayDereference' => 122,
			'Subroutine' => 120,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 75
		DEFAULT => -12
	},
	{#State 76
		DEFAULT => -41
	},
	{#State 77
		ACTIONS => {
			";" => 132
		}
	},
	{#State 78
		ACTIONS => {
			"}" => -47,
			'LBRACE' => -47,
			"\@{" => -47,
			'OP01_OPEN' => -47,
			'LPAREN' => -47,
			'OP19_LOOP_CONTROL_SCOLON' => -47,
			'OP10_NAMED_UNARY' => -47,
			"for" => -47,
			'WORD' => -47,
			'OP22_LOGICAL_NEG' => -47,
			"foreach" => -47,
			'OP01_CLOSE' => -47,
			'WORD_UPPERCASE' => -47,
			'OP05_MATH_NEG_LPAREN' => -47,
			'VARIABLE_SYMBOL' => -47,
			"while" => -47,
			'OP01_PRINT' => -47,
			'OP01_NAMED_VOID_SCOLON' => -47,
			'WORD_SCOPED' => -47,
			'LBRACKET' => -47,
			'OP19_LOOP_CONTROL' => -47,
			"%{" => -47,
			'OP05_LOGICAL_NEG' => -47,
			'SELF' => -47,
			"undef" => -47,
			'LPAREN_MY' => 134,
			'LITERAL_NUMBER' => -47,
			'OP01_NAMED' => -47,
			'OP01_NAMED_VOID_LPAREN' => -47,
			'OP03_MATH_INC_DEC' => -47,
			'OP01_NAMED_VOID' => -47,
			'MY' => -47,
			'LITERAL_STRING' => -47,
			"if" => -47
		},
		GOTOS => {
			'OPTIONAL-18' => 133,
			'SubroutineArguments' => 135
		}
	},
	{#State 79
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 58,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 136
		}
	},
	{#State 80
		ACTIONS => {
			'LITERAL_STRING' => 130,
			'LITERAL_NUMBER' => 112
		},
		GOTOS => {
			'Literal' => 137
		}
	},
	{#State 81
		ACTIONS => {
			"our hashref \$properties" => -60,
			'USE' => 34,
			"use constant" => -60
		},
		GOTOS => {
			'STAR-24' => 139,
			'Include' => 138
		}
	},
	{#State 82
		DEFAULT => -55
	},
	{#State 83
		DEFAULT => -152
	},
	{#State 84
		DEFAULT => -140
	},
	{#State 85
		DEFAULT => -146
	},
	{#State 86
		ACTIONS => {
			'OP17_LIST_RANGE' => 143,
			'OP16_LOGICAL_OR' => 142,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP08_MATH_ADD_SUB' => 153,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 155,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP09_BITWISE_SHIFT' => 151
		}
	},
	{#State 87
		ACTIONS => {
			'WORD' => 158,
			'LITERAL_STRING' => 130,
			"%{" => 115,
			"}" => 161,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'Literal' => 160,
			'HashDereference' => 157,
			'VariableOrLiteralOrWord' => 163,
			'HashEntry' => 159,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 162
		}
	},
	{#State 88
		DEFAULT => -136
	},
	{#State 89
		ACTIONS => {
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 98,
			'OP01_PRINT' => 165,
			'OP01_NAMED' => 169,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107
		},
		GOTOS => {
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127,
			'Expression' => 168,
			'SubExpression' => 164,
			'Literal' => 88,
			'Variable' => 167,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 90
		ACTIONS => {
			'MY' => 172,
			'LBRACKET' => -193,
			'SELF' => 110,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'TypeInner' => 173,
			'VariableSymbolOrSelf' => 121,
			'OPTIONAL-49' => 170,
			'Variable' => 171
		}
	},
	{#State 91
		ACTIONS => {
			'LPAREN' => 174,
			'SCOPE' => 176,
			'OP02_METHOD_THINARROW_NEW' => 175
		}
	},
	{#State 92
		ACTIONS => {
			'MY' => 177
		}
	},
	{#State 93
		ACTIONS => {
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'VARIABLE_SYMBOL' => 98,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107
		},
		GOTOS => {
			'Operator' => 127,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Variable' => 167,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'SubExpression' => 179,
			'Expression' => 168,
			'Literal' => 88
		}
	},
	{#State 94
		DEFAULT => -122
	},
	{#State 95
		ACTIONS => {
			'OP01_OPEN' => 92,
			'OP21_LIST_COMMA' => -99,
			"\@{" => 90,
			'OP24_LOGICAL_OR_XOR' => -99,
			";" => -99,
			'LPAREN' => 89,
			"]" => -99,
			"}" => -99,
			'LBRACE' => 87,
			'OP17_LIST_RANGE' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP13_BITWISE_AND' => -99,
			'WORD_UPPERCASE' => 166,
			'OP23_LOGICAL_AND' => -99,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'OP04_MATH_POW' => -99,
			'OP18_TERNARY' => -99,
			'VARIABLE_SYMBOL' => 98,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP11_COMPARE_LT_GT' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_LOGICAL_NEG' => 116,
			"%{" => 115,
			'OP07_STRING_REPEAT' => -99,
			'LITERAL_NUMBER' => 112,
			"undef" => 111,
			'SELF' => 110,
			'WORD_SCOPED' => 30,
			'OP12_COMPARE_EQ_NE' => -99,
			'LBRACKET' => 107,
			'LITERAL_STRING' => 130,
			'OP15_LOGICAL_AND' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			")" => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP01_NAMED' => 178,
			'OP06_REGEX_MATCH' => -99,
			'OP08_STRING_CAT' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP03_MATH_INC_DEC' => 118
		},
		GOTOS => {
			'SubExpression' => 180,
			'Expression' => 168,
			'Literal' => 88,
			'Variable' => 167,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 96
		ACTIONS => {
			'COLON' => 181
		}
	},
	{#State 97
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_NAMED' => 124,
			'OP03_MATH_INC_DEC' => 118,
			'' => -18,
			'OP01_NAMED_VOID' => 128,
			'LITERAL_STRING' => 130,
			"if" => 131,
			'MY' => 129,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP19_LOOP_CONTROL' => 109,
			"%{" => 115,
			'OP05_LOGICAL_NEG' => 116,
			'SELF' => 110,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			'OP10_NAMED_UNARY' => 95,
			"for" => -147,
			'WORD' => 29,
			'OP22_LOGICAL_NEG' => 93,
			"foreach" => -147,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'VARIABLE_SYMBOL' => 98,
			'OP01_PRINT' => 100,
			"while" => -147,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'LBRACE' => 87,
			"\@{" => 90,
			'OP01_OPEN' => 92,
			'LPAREN' => 89
		},
		GOTOS => {
			'PAREN-37' => 85,
			'SubExpression' => 86,
			'Literal' => 88,
			'VariableModification' => 83,
			'VariableDeclaration' => 108,
			'HashReference' => 84,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Conditional' => 113,
			'Expression' => 123,
			'LoopLabel' => 96,
			'Variable' => 119,
			'Operation' => 182,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'HashDereference' => 102,
			'OPTIONAL-38' => 106,
			'OperatorVoid' => 99,
			'Statement' => 126,
			'Operator' => 127
		}
	},
	{#State 98
		DEFAULT => -224
	},
	{#State 99
		DEFAULT => -150
	},
	{#State 100
		ACTIONS => {
			'OP05_LOGICAL_NEG' => -113,
			'OP01_OPEN' => -113,
			"%{" => -113,
			"\@{" => -113,
			'LITERAL_NUMBER' => -113,
			'LPAREN' => -113,
			"undef" => -113,
			'SELF' => -113,
			'WORD_SCOPED' => -113,
			'LBRACE' => -113,
			'FHREF_SYMBOL_BRACES' => 186,
			'LBRACKET' => -113,
			'MY' => -113,
			'LITERAL_STRING' => -113,
			'WORD_UPPERCASE' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'OP01_CLOSE' => -113,
			'OP01_QW' => -113,
			'STDOUT_STDERR' => 183,
			'VARIABLE_SYMBOL' => -113,
			'WORD' => -113,
			'OP10_NAMED_UNARY' => -113,
			'OP01_NAMED' => -113,
			'OP22_LOGICAL_NEG' => -113,
			'OP03_MATH_INC_DEC' => -113
		},
		GOTOS => {
			'PAREN-32' => 184,
			'OPTIONAL-33' => 185
		}
	},
	{#State 101
		DEFAULT => -118
	},
	{#State 102
		DEFAULT => -141
	},
	{#State 103
		ACTIONS => {
			'FHREF_SYMBOL' => 187
		}
	},
	{#State 104
		ACTIONS => {
			'LPAREN' => 188,
			'COLON' => -213
		}
	},
	{#State 105
		ACTIONS => {
			'LITERAL_NUMBER' => 112,
			'LPAREN' => 89,
			"undef" => 111,
			'SELF' => 110,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 98,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178
		},
		GOTOS => {
			'Operator' => 127,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84,
			'Expression' => 168,
			'SubExpression' => 189,
			'Literal' => 88
		}
	},
	{#State 106
		ACTIONS => {
			"for" => 190,
			"foreach" => 191,
			"while" => 193
		},
		GOTOS => {
			'Loop' => 192,
			'LoopFor' => 196,
			'LoopWhile' => 194,
			'LoopForEach' => 195
		}
	},
	{#State 107
		ACTIONS => {
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'LITERAL_STRING' => 130,
			'MY' => 172,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98,
			"]" => -190,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90,
			'LITERAL_NUMBER' => 112,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110
		},
		GOTOS => {
			'TypeInner' => 202,
			'SubExpression' => 200,
			'Expression' => 168,
			'OPTIONAL-48' => 198,
			'Literal' => 88,
			'Variable' => 167,
			'ListElements' => 201,
			'ListElement' => 199,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 108
		DEFAULT => -151
	},
	{#State 109
		ACTIONS => {
			'WORD_UPPERCASE' => 204
		},
		GOTOS => {
			'LoopLabel' => 203
		}
	},
	{#State 110
		DEFAULT => -225
	},
	{#State 111
		DEFAULT => -135
	},
	{#State 112
		DEFAULT => -226
	},
	{#State 113
		DEFAULT => -148
	},
	{#State 114
		DEFAULT => -138
	},
	{#State 115
		ACTIONS => {
			'LBRACE' => -208,
			'MY' => 172,
			'VARIABLE_SYMBOL' => 98,
			'SELF' => 110
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'OPTIONAL-53' => 207,
			'Variable' => 205,
			'TypeInner' => 206
		}
	},
	{#State 116
		ACTIONS => {
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'Variable' => 167,
			'Literal' => 88,
			'Expression' => 168,
			'SubExpression' => 208,
			'Operator' => 127,
			'WordScoped' => 91,
			'ArrayReference' => 114,
			'HashDereference' => 102
		}
	},
	{#State 117
		DEFAULT => -17
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'SELF' => 110
		},
		GOTOS => {
			'Variable' => 209,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 119
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP03_MATH_INC_DEC' => 211,
			'OP06_REGEX_MATCH' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_STRING_CAT' => -137,
			'OP04_MATH_POW' => -137,
			'OP18_TERNARY' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP19_VARIABLE_ASSIGN' => 212,
			'OP13_BITWISE_AND' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 210,
			'OP07_STRING_REPEAT' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP02_METHOD_THINARROW' => 213
		}
	},
	{#State 120
		DEFAULT => -14
	},
	{#State 121
		DEFAULT => -170,
		GOTOS => {
			'STAR-44' => 214
		}
	},
	{#State 122
		DEFAULT => -139
	},
	{#State 123
		ACTIONS => {
			'OP04_MATH_POW' => -134,
			'OP18_TERNARY' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP08_STRING_CAT' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP07_STRING_REPEAT' => -134,
			";" => 215,
			'OP17_LIST_RANGE' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP12_COMPARE_EQ_NE' => -134
		}
	},
	{#State 124
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'MY' => 172,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'OP01_QW' => 197,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'Operator' => 127,
			'WordScoped' => 91,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'ArrayDereference' => 122,
			'ListElement' => 217,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 167,
			'Literal' => 88,
			'Expression' => 168,
			'SubExpression' => 216,
			'TypeInner' => 202
		}
	},
	{#State 125
		ACTIONS => {
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			")" => -115,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'VARIABLE_SYMBOL' => 98,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'MY' => 172,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'OP01_QW' => 197
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 200,
			'TypeInner' => 202,
			'Expression' => 168,
			'HashReference' => 84,
			'ListElement' => 199,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'ListElements' => 219,
			'Variable' => 167,
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'Operator' => 127,
			'OPTIONAL-34' => 218
		}
	},
	{#State 126
		DEFAULT => -81
	},
	{#State 127
		DEFAULT => -128
	},
	{#State 128
		ACTIONS => {
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'MY' => 172,
			'LITERAL_STRING' => 130,
			'VARIABLE_SYMBOL' => 98,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107
		},
		GOTOS => {
			'Operator' => 127,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Variable' => 167,
			'ListElements' => 220,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'ListElement' => 199,
			'Expression' => 168,
			'TypeInner' => 202,
			'SubExpression' => 200,
			'Literal' => 88
		}
	},
	{#State 129
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'TYPE_FHREF' => 222,
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 221
		}
	},
	{#State 130
		DEFAULT => -227
	},
	{#State 131
		ACTIONS => {
			'LPAREN' => 223
		}
	},
	{#State 132
		DEFAULT => -44
	},
	{#State 133
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 224
		}
	},
	{#State 134
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 57,
			'WORD_SCOPED' => 58
		},
		GOTOS => {
			'Type' => 225
		}
	},
	{#State 135
		DEFAULT => -46
	},
	{#State 136
		ACTIONS => {
			"\$TYPED_" => 226
		}
	},
	{#State 137
		ACTIONS => {
			";" => 227
		}
	},
	{#State 138
		DEFAULT => -57
	},
	{#State 139
		ACTIONS => {
			"our hashref \$properties" => 230,
			"use constant" => 44
		},
		GOTOS => {
			'Constant' => 229,
			'Properties' => 228
		}
	},
	{#State 140
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'Expression' => 168,
			'SubExpression' => 231,
			'Literal' => 88,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 141
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'Expression' => 168,
			'SubExpression' => 232,
			'Literal' => 88,
			'Variable' => 167,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 142
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'VARIABLE_SYMBOL' => 98,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115
		},
		GOTOS => {
			'Variable' => 167,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'SubExpression' => 233,
			'Expression' => 168,
			'Literal' => 88,
			'Operator' => 127,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91
		}
	},
	{#State 143
		ACTIONS => {
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 234,
			'Expression' => 168,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 167,
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'Operator' => 127
		}
	},
	{#State 144
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127,
			'Expression' => 168,
			'SubExpression' => 235,
			'Literal' => 88,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 145
		ACTIONS => {
			'LITERAL_STRING' => 130,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'VariableOrLiteral' => 238,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 237,
			'Literal' => 236
		}
	},
	{#State 146
		ACTIONS => {
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'Operator' => 127,
			'Literal' => 88,
			'SubExpression' => 239,
			'Expression' => 168,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'Variable' => 167
		}
	},
	{#State 147
		ACTIONS => {
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'VARIABLE_SYMBOL' => 98,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93
		},
		GOTOS => {
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127,
			'Expression' => 168,
			'SubExpression' => 240,
			'Literal' => 88,
			'Variable' => 167,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122
		}
	},
	{#State 148
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LPAREN' => 89,
			"undef" => 111,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92
		},
		GOTOS => {
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127,
			'Expression' => 168,
			'SubExpression' => 241,
			'Literal' => 88,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 149
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178,
			'VARIABLE_SYMBOL' => 98,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP01_CLOSE' => 103,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LITERAL_NUMBER' => 112,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90
		},
		GOTOS => {
			'WordScoped' => 91,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'Operator' => 127,
			'Literal' => 88,
			'Expression' => 168,
			'SubExpression' => 242,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 167
		}
	},
	{#State 150
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127,
			'SubExpression' => 243,
			'Expression' => 168,
			'Literal' => 88,
			'Variable' => 167,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 151
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127,
			'Expression' => 168,
			'SubExpression' => 244,
			'Literal' => 88,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84
		}
	},
	{#State 152
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90,
			'LITERAL_NUMBER' => 112,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 245,
			'Expression' => 168,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 167,
			'WordScoped' => 91,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'Operator' => 127
		}
	},
	{#State 153
		ACTIONS => {
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90,
			'LITERAL_NUMBER' => 112,
			'LPAREN' => 89,
			"undef" => 111,
			'SELF' => 110,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'Variable' => 167,
			'Literal' => 88,
			'Expression' => 168,
			'SubExpression' => 246,
			'Operator' => 127,
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114
		}
	},
	{#State 154
		ACTIONS => {
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105
		},
		GOTOS => {
			'Expression' => 168,
			'SubExpression' => 247,
			'Literal' => 88,
			'Variable' => 167,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 155
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 248
		}
	},
	{#State 156
		ACTIONS => {
			'LITERAL_NUMBER' => 112,
			'LPAREN' => 89,
			"undef" => 111,
			'SELF' => 110,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'VARIABLE_SYMBOL' => 98,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178
		},
		GOTOS => {
			'SubExpression' => 249,
			'Expression' => 168,
			'Literal' => 88,
			'Variable' => 167,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 157
		DEFAULT => -199
	},
	{#State 158
		DEFAULT => -223
	},
	{#State 159
		DEFAULT => -204,
		GOTOS => {
			'STAR-52' => 250
		}
	},
	{#State 160
		DEFAULT => -222
	},
	{#State 161
		DEFAULT => -206
	},
	{#State 162
		DEFAULT => -221
	},
	{#State 163
		ACTIONS => {
			'OP20_HASH_FATARROW' => 251
		}
	},
	{#State 164
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => 252,
			'OP09_BITWISE_SHIFT' => 151,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => 140
		}
	},
	{#State 165
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 253
		}
	},
	{#State 166
		ACTIONS => {
			'LPAREN' => 188
		}
	},
	{#State 167
		ACTIONS => {
			")" => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_STRING_CAT' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP03_MATH_INC_DEC' => 211,
			'OP08_MATH_ADD_SUB' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP18_TERNARY' => -137,
			'OP04_MATH_POW' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			"]" => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP17_LIST_RANGE' => -137,
			"}" => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP02_METHOD_THINARROW' => 213,
			";" => -137
		}
	},
	{#State 168
		DEFAULT => -134
	},
	{#State 169
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'MY' => 172,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'LITERAL_NUMBER' => 112,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 216,
			'Expression' => 168,
			'TypeInner' => 202,
			'HashReference' => 84,
			'ListElement' => 254,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'Variable' => 167,
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'Operator' => 127
		}
	},
	{#State 170
		ACTIONS => {
			'LBRACKET' => 107
		},
		GOTOS => {
			'ArrayReference' => 255
		}
	},
	{#State 171
		ACTIONS => {
			"}" => 256
		}
	},
	{#State 172
		ACTIONS => {
			'WORD' => 57,
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 257
		}
	},
	{#State 173
		DEFAULT => -192
	},
	{#State 174
		ACTIONS => {
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			")" => -125,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_CLOSE' => 103,
			'OP01_QW' => 197,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'MY' => 172,
			'LITERAL_STRING' => 130,
			'VARIABLE_SYMBOL' => 98,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'LITERAL_NUMBER' => 112
		},
		GOTOS => {
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127,
			'TypeInner' => 202,
			'SubExpression' => 200,
			'Expression' => 168,
			'Literal' => 88,
			'OPTIONAL-35' => 259,
			'ListElements' => 258,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'ListElement' => 199,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 175
		ACTIONS => {
			")" => 260
		}
	},
	{#State 176
		ACTIONS => {
			'WORD_UPPERCASE' => 261
		}
	},
	{#State 177
		ACTIONS => {
			'TYPE_FHREF' => 262
		}
	},
	{#State 178
		ACTIONS => {
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'VARIABLE_SYMBOL' => 98,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112
		},
		GOTOS => {
			'Operator' => 127,
			'WordScoped' => 91,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84,
			'Variable' => 167,
			'Literal' => 88,
			'SubExpression' => 263,
			'Expression' => 168
		}
	},
	{#State 179
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 151,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP23_LOGICAL_AND' => -108,
			'OP15_LOGICAL_AND' => 152,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => -108,
			";" => -108,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			"}" => -108,
			'OP17_LIST_RANGE' => 143,
			'OP16_LOGICAL_OR' => 142,
			"]" => -108
		}
	},
	{#State 180
		ACTIONS => {
			'OP13_BITWISE_AND' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			"}" => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP17_LIST_RANGE' => -98,
			"]" => -98,
			";" => -98,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => -98,
			'OP09_BITWISE_SHIFT' => 151,
			'OP18_TERNARY' => -98,
			'OP04_MATH_POW' => 144,
			'OP23_LOGICAL_AND' => -98,
			'OP15_LOGICAL_AND' => -98
		}
	},
	{#State 181
		DEFAULT => -145
	},
	{#State 182
		DEFAULT => -16
	},
	{#State 183
		DEFAULT => -111
	},
	{#State 184
		DEFAULT => -112
	},
	{#State 185
		ACTIONS => {
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'MY' => 172,
			'LITERAL_STRING' => 130,
			'VARIABLE_SYMBOL' => 98,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93
		},
		GOTOS => {
			'Operator' => 127,
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'ListElement' => 199,
			'Variable' => 167,
			'ListElements' => 264,
			'Literal' => 88,
			'TypeInner' => 202,
			'Expression' => 168,
			'SubExpression' => 200
		}
	},
	{#State 186
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'OP01_QW' => 197,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'MY' => 172,
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'LITERAL_NUMBER' => 112,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'HashReference' => 84,
			'ListElement' => 199,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'Variable' => 167,
			'ListElements' => 265,
			'Literal' => 88,
			'TypeInner' => 202,
			'SubExpression' => 200,
			'Expression' => 168,
			'Operator' => 127,
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114
		}
	},
	{#State 187
		DEFAULT => -86
	},
	{#State 188
		ACTIONS => {
			")" => 266
		}
	},
	{#State 189
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 151,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => 267,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143
		}
	},
	{#State 190
		ACTIONS => {
			'MY' => 268
		}
	},
	{#State 191
		ACTIONS => {
			'MY' => 269
		}
	},
	{#State 192
		DEFAULT => -149
	},
	{#State 193
		ACTIONS => {
			'LPAREN' => 270
		}
	},
	{#State 194
		DEFAULT => -162
	},
	{#State 195
		DEFAULT => -161
	},
	{#State 196
		DEFAULT => -160
	},
	{#State 197
		ACTIONS => {
			'WORD' => 272
		},
		GOTOS => {
			'PLUS-47' => 271
		}
	},
	{#State 198
		ACTIONS => {
			"]" => 273
		}
	},
	{#State 199
		DEFAULT => -182,
		GOTOS => {
			'STAR-46' => 274
		}
	},
	{#State 200
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			")" => -186,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP09_BITWISE_SHIFT' => 151,
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			"]" => -186,
			'OP17_LIST_RANGE' => 143,
			'OP16_LOGICAL_OR' => 142,
			";" => -186,
			'OP21_LIST_COMMA' => -186,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 149
		}
	},
	{#State 201
		DEFAULT => -189
	},
	{#State 202
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 275,
			'Expression' => 168,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 167,
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'Operator' => 127
		}
	},
	{#State 203
		ACTIONS => {
			";" => 276
		}
	},
	{#State 204
		DEFAULT => -213
	},
	{#State 205
		ACTIONS => {
			"}" => 277
		}
	},
	{#State 206
		DEFAULT => -207
	},
	{#State 207
		ACTIONS => {
			'LBRACE' => 87
		},
		GOTOS => {
			'HashReference' => 278
		}
	},
	{#State 208
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -90,
			'OP13_BITWISE_AND' => -90,
			"]" => -90,
			"}" => -90,
			'OP17_LIST_RANGE' => -90,
			'OP16_LOGICAL_OR' => -90,
			";" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP08_STRING_CAT' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			")" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP18_TERNARY' => -90,
			'OP04_MATH_POW' => 144
		}
	},
	{#State 209
		DEFAULT => -87
	},
	{#State 210
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178,
			'VARIABLE_SYMBOL' => 98,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LITERAL_NUMBER' => 112,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90
		},
		GOTOS => {
			'Literal' => 88,
			'SubExpression' => 279,
			'Expression' => 168,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 167,
			'WordScoped' => 91,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'Operator' => 127
		}
	},
	{#State 211
		DEFAULT => -88
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'LPAREN' => 89,
			"undef" => 111,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			'LBRACKET' => 107,
			'STDIN' => 282,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'SubExpression' => 281,
			'Expression' => 168,
			'Literal' => 88,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'SubExpressionOrStdin' => 280,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 213
		ACTIONS => {
			'LPAREN' => 283
		}
	},
	{#State 214
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -171,
			'OP19_VARIABLE_ASSIGN_BY' => -171,
			'OP13_BITWISE_AND' => -171,
			"]" => -171,
			'OP20_HASH_FATARROW' => -171,
			'OP19_VARIABLE_ASSIGN' => -171,
			"}" => -171,
			'OP17_LIST_RANGE' => -171,
			'OP16_LOGICAL_OR' => -171,
			'OP02_METHOD_THINARROW' => -171,
			";" => -171,
			'OP21_LIST_COMMA' => -171,
			'COLON' => -171,
			'OP07_STRING_REPEAT' => -171,
			'OP02_HASH_THINARROW' => 284,
			'OP24_LOGICAL_OR_XOR' => -171,
			'OP06_REGEX_MATCH' => -171,
			'OP11_COMPARE_LT_GT' => -171,
			'OP14_BITWISE_OR_XOR' => -171,
			'OP08_STRING_CAT' => -171,
			'OP08_MATH_ADD_SUB' => -171,
			'OP02_ARRAY_THINARROW' => 285,
			'OP03_MATH_INC_DEC' => -171,
			")" => -171,
			'OP07_MATH_MULT_DIV_MOD' => -171,
			'OP09_BITWISE_SHIFT' => -171,
			'OP23_LOGICAL_AND' => -171,
			'OP15_LOGICAL_AND' => -171,
			'OP18_TERNARY' => -171,
			'OP04_MATH_POW' => -171
		},
		GOTOS => {
			'VariableRetrieval' => 286
		}
	},
	{#State 215
		DEFAULT => -80
	},
	{#State 216
		ACTIONS => {
			'OP17_LIST_RANGE' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP21_LIST_COMMA' => -186,
			";" => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			")" => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP08_STRING_CAT' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP18_TERNARY' => -83,
			'OP04_MATH_POW' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP09_BITWISE_SHIFT' => -83
		}
	},
	{#State 217
		ACTIONS => {
			'OP21_LIST_COMMA' => 287
		}
	},
	{#State 218
		ACTIONS => {
			")" => 288
		}
	},
	{#State 219
		DEFAULT => -114
	},
	{#State 220
		ACTIONS => {
			";" => 289
		}
	},
	{#State 221
		ACTIONS => {
			'VARIABLE_SYMBOL' => 290
		}
	},
	{#State 222
		ACTIONS => {
			'FHREF_SYMBOL' => 291
		}
	},
	{#State 223
		ACTIONS => {
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'LITERAL_NUMBER' => 112,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130
		},
		GOTOS => {
			'Expression' => 168,
			'SubExpression' => 292,
			'Literal' => 88,
			'Variable' => 167,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 224
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			"while" => -147,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'OP01_PRINT' => 100,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 93,
			"foreach" => -147,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			'OP10_NAMED_UNARY' => 95,
			"for" => -147,
			'WORD' => 29,
			'LPAREN' => 89,
			"\@{" => 90,
			'OP01_OPEN' => 92,
			'LBRACE' => 87,
			"}" => 293,
			'OP01_NAMED_VOID' => 128,
			'LITERAL_STRING' => 130,
			'MY' => 129,
			"if" => 131,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 124,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'SELF' => 110,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			"%{" => 115,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACKET' => 107,
			'OP19_LOOP_CONTROL' => 109,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'PAREN-37' => 85,
			'SubExpression' => 86,
			'Literal' => 88,
			'VariableModification' => 83,
			'VariableDeclaration' => 108,
			'HashReference' => 84,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Conditional' => 113,
			'Expression' => 123,
			'LoopLabel' => 96,
			'Operation' => 294,
			'Variable' => 119,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'HashDereference' => 102,
			'OPTIONAL-38' => 106,
			'Operator' => 127,
			'Statement' => 126,
			'OperatorVoid' => 99
		}
	},
	{#State 225
		ACTIONS => {
			'VARIABLE_SYMBOL' => 295
		}
	},
	{#State 226
		ACTIONS => {
			'WORD_UPPERCASE' => 296
		}
	},
	{#State 227
		DEFAULT => -45
	},
	{#State 228
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 297
		}
	},
	{#State 229
		DEFAULT => -59
	},
	{#State 230
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 298
		}
	},
	{#State 231
		ACTIONS => {
			"]" => -110,
			"}" => -110,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			'OP21_LIST_COMMA' => -110,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -110,
			";" => -110,
			")" => -110,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP06_REGEX_MATCH' => 155,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP09_BITWISE_SHIFT' => 151
		}
	},
	{#State 232
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 151,
			'OP15_LOGICAL_AND' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			")" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			";" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_STRING_REPEAT' => 149,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => -102,
			"]" => -102,
			'OP17_LIST_RANGE' => -102,
			'OP16_LOGICAL_OR' => -102,
			"}" => -102
		}
	},
	{#State 233
		ACTIONS => {
			'OP18_TERNARY' => -105,
			'OP04_MATH_POW' => 144,
			'OP23_LOGICAL_AND' => -105,
			'OP15_LOGICAL_AND' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => -105,
			'OP08_MATH_ADD_SUB' => 153,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP06_REGEX_MATCH' => 155,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP07_STRING_REPEAT' => 149,
			'OP21_LIST_COMMA' => -105,
			";" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP16_LOGICAL_OR' => -105,
			"}" => -105,
			"]" => -105,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150
		}
	},
	{#State 234
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 151,
			'OP23_LOGICAL_AND' => -106,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => -106,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			")" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			";" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_STRING_REPEAT' => 149,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			"]" => -106,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 142,
			"}" => -106
		}
	},
	{#State 235
		ACTIONS => {
			'OP21_LIST_COMMA' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			";" => -89,
			"]" => -89,
			"}" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			")" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP06_REGEX_MATCH' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP08_STRING_CAT' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP08_MATH_ADD_SUB' => -89
		}
	},
	{#State 236
		DEFAULT => -220
	},
	{#State 237
		DEFAULT => -219
	},
	{#State 238
		ACTIONS => {
			'COLON' => 299
		}
	},
	{#State 239
		ACTIONS => {
			";" => -109,
			'OP21_LIST_COMMA' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP07_STRING_REPEAT' => 149,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			"]" => -109,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			"}" => -109,
			'OP09_BITWISE_SHIFT' => 151,
			'OP23_LOGICAL_AND' => -109,
			'OP15_LOGICAL_AND' => 152,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			")" => -109,
			'OP07_MATH_MULT_DIV_MOD' => 156
		}
	},
	{#State 240
		ACTIONS => {
			";" => -100,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			"}" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP17_LIST_RANGE' => -100,
			"]" => -100,
			'OP09_BITWISE_SHIFT' => 151,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => -100
		}
	},
	{#State 241
		ACTIONS => {
			";" => -103,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			"}" => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP17_LIST_RANGE' => -103,
			"]" => -103,
			'OP09_BITWISE_SHIFT' => 151,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => -103
		}
	},
	{#State 242
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -93,
			")" => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP08_STRING_CAT' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP06_REGEX_MATCH' => 155,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP17_LIST_RANGE' => -93,
			"}" => -93,
			"]" => -93,
			'OP13_BITWISE_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP07_STRING_REPEAT' => -93,
			'OP21_LIST_COMMA' => -93,
			";" => -93
		}
	},
	{#State 243
		ACTIONS => {
			'OP13_BITWISE_AND' => -101,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP17_LIST_RANGE' => -101,
			"]" => -101,
			";" => -101,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 147,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => -101,
			'OP09_BITWISE_SHIFT' => 151,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 244
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => -97,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP08_STRING_CAT' => 154,
			'OP18_TERNARY' => -97,
			'OP04_MATH_POW' => 144,
			'OP15_LOGICAL_AND' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			"}" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP17_LIST_RANGE' => -97,
			"]" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			";" => -97
		}
	},
	{#State 245
		ACTIONS => {
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP21_LIST_COMMA' => -104,
			";" => -104,
			"}" => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP17_LIST_RANGE' => -104,
			"]" => -104,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP18_TERNARY' => -104,
			'OP04_MATH_POW' => 144,
			'OP15_LOGICAL_AND' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => -104,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_STRING_CAT' => 154
		}
	},
	{#State 246
		ACTIONS => {
			"]" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP17_LIST_RANGE' => -95,
			"}" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP07_STRING_REPEAT' => 149,
			";" => -95,
			")" => -95,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP11_COMPARE_LT_GT' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP08_STRING_CAT' => -95,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => -95,
			'OP09_BITWISE_SHIFT' => -95
		}
	},
	{#State 247
		ACTIONS => {
			")" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP08_STRING_CAT' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP18_TERNARY' => -96,
			'OP04_MATH_POW' => 144,
			'OP09_BITWISE_SHIFT' => -96,
			"]" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP16_LOGICAL_OR' => -96,
			"}" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_STRING_REPEAT' => 149,
			";" => -96
		}
	},
	{#State 248
		DEFAULT => -92
	},
	{#State 249
		ACTIONS => {
			";" => -94,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			"}" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP16_LOGICAL_OR' => -94,
			"]" => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP18_TERNARY' => -94,
			'OP04_MATH_POW' => 144,
			'OP15_LOGICAL_AND' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP06_REGEX_MATCH' => 155,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP08_STRING_CAT' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			")" => -94
		}
	},
	{#State 250
		ACTIONS => {
			"}" => 301,
			'OP21_LIST_COMMA' => 302
		},
		GOTOS => {
			'PAREN-51' => 300
		}
	},
	{#State 251
		ACTIONS => {
			'LBRACKET' => -197,
			'WORD_SCOPED' => -197,
			'LBRACE' => -197,
			'LITERAL_NUMBER' => -197,
			"undef" => -197,
			'LPAREN' => -197,
			'SELF' => -197,
			'OP05_LOGICAL_NEG' => -197,
			'OP01_OPEN' => -197,
			"%{" => -197,
			"\@{" => -197,
			'OP22_LOGICAL_NEG' => -197,
			'OP03_MATH_INC_DEC' => -197,
			'WORD' => -197,
			'OP10_NAMED_UNARY' => -197,
			'OP01_NAMED' => -197,
			'VARIABLE_SYMBOL' => -197,
			'LITERAL_STRING' => -197,
			'MY' => 172,
			'WORD_UPPERCASE' => -197,
			'OP05_MATH_NEG_LPAREN' => -197,
			'OP01_CLOSE' => -197
		},
		GOTOS => {
			'OPTIONAL-50' => 304,
			'TypeInner' => 303
		}
	},
	{#State 252
		DEFAULT => -142
	},
	{#State 253
		ACTIONS => {
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'VARIABLE_SYMBOL' => 98,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'MY' => 172,
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103
		},
		GOTOS => {
			'Variable' => 167,
			'ListElements' => 305,
			'ListElement' => 199,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 168,
			'SubExpression' => 200,
			'TypeInner' => 202,
			'Literal' => 88,
			'Operator' => 127,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91
		}
	},
	{#State 254
		ACTIONS => {
			'OP21_LIST_COMMA' => 306
		}
	},
	{#State 255
		ACTIONS => {
			"}" => 307
		}
	},
	{#State 256
		DEFAULT => -194
	},
	{#State 257
		ACTIONS => {
			"\$TYPED_" => 308
		}
	},
	{#State 258
		DEFAULT => -124
	},
	{#State 259
		ACTIONS => {
			")" => 309
		}
	},
	{#State 260
		DEFAULT => -133
	},
	{#State 261
		ACTIONS => {
			'LPAREN' => 310
		}
	},
	{#State 262
		ACTIONS => {
			'FHREF_SYMBOL' => 311
		}
	},
	{#State 263
		ACTIONS => {
			"]" => -83,
			"}" => -83,
			'OP17_LIST_RANGE' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			";" => -83,
			")" => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP08_STRING_CAT' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP04_MATH_POW' => -83,
			'OP18_TERNARY' => -83,
			'OP09_BITWISE_SHIFT' => -83
		}
	},
	{#State 264
		ACTIONS => {
			";" => 312
		}
	},
	{#State 265
		ACTIONS => {
			";" => 313
		}
	},
	{#State 266
		DEFAULT => -130
	},
	{#State 267
		DEFAULT => -91
	},
	{#State 268
		ACTIONS => {
			'TYPE_INTEGER' => 314
		}
	},
	{#State 269
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 315
		}
	},
	{#State 270
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90,
			'LITERAL_NUMBER' => 112,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98
		},
		GOTOS => {
			'WordScoped' => 91,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'Operator' => 127,
			'Literal' => 88,
			'Expression' => 168,
			'SubExpression' => 316,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84,
			'Variable' => 167
		}
	},
	{#State 271
		ACTIONS => {
			'WORD' => 318,
			")" => 317
		}
	},
	{#State 272
		DEFAULT => -185
	},
	{#State 273
		DEFAULT => -191
	},
	{#State 274
		ACTIONS => {
			")" => -183,
			'OP21_LIST_COMMA' => 319,
			"]" => -183,
			";" => -183
		},
		GOTOS => {
			'PAREN-45' => 320
		}
	},
	{#State 275
		ACTIONS => {
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP09_BITWISE_SHIFT' => 151,
			")" => -187,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP06_REGEX_MATCH' => 155,
			'OP11_COMPARE_LT_GT' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 154,
			'OP08_MATH_ADD_SUB' => 153,
			'OP21_LIST_COMMA' => -187,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			";" => -187,
			"]" => -187,
			'OP17_LIST_RANGE' => 143,
			'OP16_LOGICAL_OR' => 142,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141
		}
	},
	{#State 276
		DEFAULT => -123
	},
	{#State 277
		DEFAULT => -209
	},
	{#State 278
		ACTIONS => {
			"}" => 321
		}
	},
	{#State 279
		ACTIONS => {
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 149,
			";" => 322,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			'OP23_LOGICAL_AND' => 146,
			'OP15_LOGICAL_AND' => 152,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP09_BITWISE_SHIFT' => 151
		}
	},
	{#State 280
		ACTIONS => {
			";" => 323
		}
	},
	{#State 281
		ACTIONS => {
			";" => -143,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 149,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP09_BITWISE_SHIFT' => 151,
			'OP23_LOGICAL_AND' => 146,
			'OP15_LOGICAL_AND' => 152,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			'OP07_MATH_MULT_DIV_MOD' => 156
		}
	},
	{#State 282
		DEFAULT => -144
	},
	{#State 283
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'MY' => 172,
			'LITERAL_STRING' => 130,
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			")" => -127,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87
		},
		GOTOS => {
			'Operator' => 127,
			'WordScoped' => 91,
			'OPTIONAL-36' => 325,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'ListElement' => 199,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 167,
			'ListElements' => 324,
			'Literal' => 88,
			'SubExpression' => 200,
			'Expression' => 168,
			'TypeInner' => 202
		}
	},
	{#State 284
		ACTIONS => {
			'WORD' => 327,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90,
			'LITERAL_NUMBER' => 112,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110
		},
		GOTOS => {
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127,
			'Expression' => 168,
			'SubExpression' => 326,
			'Literal' => 88,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84
		}
	},
	{#State 285
		ACTIONS => {
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105
		},
		GOTOS => {
			'Operator' => 127,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'SubExpression' => 328,
			'Expression' => 168,
			'Literal' => 88
		}
	},
	{#State 286
		DEFAULT => -169
	},
	{#State 287
		ACTIONS => {
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'LITERAL_STRING' => 130,
			'MY' => 172,
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93
		},
		GOTOS => {
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127,
			'SubExpression' => 200,
			'TypeInner' => 202,
			'Expression' => 168,
			'Literal' => 88,
			'Variable' => 167,
			'ListElements' => 329,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'ListElement' => 199,
			'HashReference' => 84
		}
	},
	{#State 288
		ACTIONS => {
			";" => 330
		}
	},
	{#State 289
		DEFAULT => -120
	},
	{#State 290
		ACTIONS => {
			";" => 331,
			'OP19_VARIABLE_ASSIGN' => 332
		}
	},
	{#State 291
		ACTIONS => {
			";" => 333
		}
	},
	{#State 292
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 149,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP09_BITWISE_SHIFT' => 151,
			")" => 334,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153
		}
	},
	{#State 293
		ACTIONS => {
			";" => 335
		}
	},
	{#State 294
		DEFAULT => -48
	},
	{#State 295
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 336
		}
	},
	{#State 296
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 337
		}
	},
	{#State 297
		ACTIONS => {
			'LITERAL_NUMBER' => 340,
			"our" => 342
		},
		GOTOS => {
			'Subroutine' => 338,
			'Method' => 339,
			'MethodOrSubroutine' => 341
		}
	},
	{#State 298
		ACTIONS => {
			'LBRACE' => 343
		}
	},
	{#State 299
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			'LITERAL_STRING' => 130
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'VariableOrLiteral' => 344,
			'Variable' => 237,
			'Literal' => 236
		}
	},
	{#State 300
		DEFAULT => -203
	},
	{#State 301
		DEFAULT => -205
	},
	{#State 302
		ACTIONS => {
			"%{" => 115,
			'LITERAL_STRING' => 130,
			'WORD' => 158,
			'SELF' => 110,
			'VARIABLE_SYMBOL' => 98,
			'LITERAL_NUMBER' => 112
		},
		GOTOS => {
			'HashEntry' => 345,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 162,
			'Literal' => 160,
			'HashDereference' => 157,
			'VariableOrLiteralOrWord' => 163
		}
	},
	{#State 303
		DEFAULT => -196
	},
	{#State 304
		ACTIONS => {
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'VARIABLE_SYMBOL' => 98,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107
		},
		GOTOS => {
			'Expression' => 168,
			'SubExpression' => 346,
			'Literal' => 88,
			'Variable' => 167,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 305
		ACTIONS => {
			")" => 347
		}
	},
	{#State 306
		ACTIONS => {
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'VARIABLE_SYMBOL' => 98,
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'MY' => 172,
			'LITERAL_STRING' => 130
		},
		GOTOS => {
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Operator' => 127,
			'SubExpression' => 200,
			'TypeInner' => 202,
			'Expression' => 168,
			'Literal' => 88,
			'Variable' => 167,
			'ListElements' => 348,
			'ListElement' => 199,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 307
		DEFAULT => -195
	},
	{#State 308
		ACTIONS => {
			'WORD' => 349
		}
	},
	{#State 309
		DEFAULT => -129
	},
	{#State 310
		ACTIONS => {
			")" => 350
		}
	},
	{#State 311
		ACTIONS => {
			'OP21_LIST_COMMA' => 351
		}
	},
	{#State 312
		DEFAULT => -116
	},
	{#State 313
		DEFAULT => -117
	},
	{#State 314
		ACTIONS => {
			'VARIABLE_SYMBOL' => 352
		}
	},
	{#State 315
		ACTIONS => {
			'VARIABLE_SYMBOL' => 353
		}
	},
	{#State 316
		ACTIONS => {
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 149,
			")" => 354,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			'OP23_LOGICAL_AND' => 146,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP09_BITWISE_SHIFT' => 151
		}
	},
	{#State 317
		DEFAULT => -188
	},
	{#State 318
		DEFAULT => -184
	},
	{#State 319
		ACTIONS => {
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_CLOSE' => 103,
			'OP01_QW' => 197,
			'MY' => 172,
			'LITERAL_STRING' => 130,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'VARIABLE_SYMBOL' => 98,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			'LPAREN' => 89,
			"undef" => 111,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112
		},
		GOTOS => {
			'Operator' => 127,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Variable' => 167,
			'VariableSymbolOrSelf' => 121,
			'ListElement' => 355,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'TypeInner' => 202,
			'Expression' => 168,
			'SubExpression' => 200,
			'Literal' => 88
		}
	},
	{#State 320
		DEFAULT => -181
	},
	{#State 321
		DEFAULT => -210
	},
	{#State 322
		DEFAULT => -179
	},
	{#State 323
		DEFAULT => -178
	},
	{#State 324
		DEFAULT => -126
	},
	{#State 325
		ACTIONS => {
			")" => 356
		}
	},
	{#State 326
		ACTIONS => {
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			"}" => 357,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP23_LOGICAL_AND' => 146,
			'OP15_LOGICAL_AND' => 152,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 147,
			'OP14_BITWISE_OR_XOR' => 148
		}
	},
	{#State 327
		ACTIONS => {
			'LPAREN' => -211,
			'OP02_METHOD_THINARROW_NEW' => -211,
			'SCOPE' => -211,
			"}" => 358
		}
	},
	{#State 328
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP06_REGEX_MATCH' => 155,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_MATH_ADD_SUB' => 153,
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP09_BITWISE_SHIFT' => 151,
			"]" => 359,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => 140
		}
	},
	{#State 329
		ACTIONS => {
			";" => 360
		}
	},
	{#State 330
		DEFAULT => -119
	},
	{#State 331
		DEFAULT => -175
	},
	{#State 332
		ACTIONS => {
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'VARIABLE_SYMBOL' => 98,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'SELF' => 110,
			'LPAREN' => 89,
			"undef" => 111,
			'LITERAL_NUMBER' => 112,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'STDIN' => 282
		},
		GOTOS => {
			'Operator' => 127,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'WordScoped' => 91,
			'Variable' => 167,
			'SubExpressionOrStdin' => 361,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 168,
			'SubExpression' => 281,
			'Literal' => 88
		}
	},
	{#State 333
		DEFAULT => -177
	},
	{#State 334
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 363
		}
	},
	{#State 335
		DEFAULT => -50
	},
	{#State 336
		ACTIONS => {
			'OP21_LIST_COMMA' => 366,
			")" => 365
		},
		GOTOS => {
			'PAREN-20' => 364
		}
	},
	{#State 337
		DEFAULT => -218
	},
	{#State 338
		DEFAULT => -79
	},
	{#State 339
		DEFAULT => -78
	},
	{#State 340
		ACTIONS => {
			";" => 367
		}
	},
	{#State 341
		DEFAULT => -61
	},
	{#State 342
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'WORD' => 57,
			'TYPE_METHOD' => 368,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 343
		ACTIONS => {
			'WORD' => 370,
			"}" => 372,
			"%{" => 115
		},
		GOTOS => {
			'HashEntryTyped' => 371,
			'HashDereference' => 369
		}
	},
	{#State 344
		DEFAULT => -107
	},
	{#State 345
		DEFAULT => -202
	},
	{#State 346
		ACTIONS => {
			'OP23_LOGICAL_AND' => 146,
			'OP15_LOGICAL_AND' => 152,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP09_BITWISE_SHIFT' => 151,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_MATH_ADD_SUB' => 153,
			'OP21_LIST_COMMA' => -198,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			"}" => -198,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141
		}
	},
	{#State 347
		DEFAULT => -82
	},
	{#State 348
		ACTIONS => {
			")" => 373
		}
	},
	{#State 349
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 374
		}
	},
	{#State 350
		DEFAULT => -131
	},
	{#State 351
		ACTIONS => {
			'LITERAL_STRING' => 375
		}
	},
	{#State 352
		ACTIONS => {
			'LPAREN' => 376
		}
	},
	{#State 353
		ACTIONS => {
			'LPAREN' => 377
		}
	},
	{#State 354
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 355
		DEFAULT => -180
	},
	{#State 356
		DEFAULT => -132
	},
	{#State 357
		DEFAULT => -173
	},
	{#State 358
		DEFAULT => -174
	},
	{#State 359
		DEFAULT => -172
	},
	{#State 360
		DEFAULT => -121
	},
	{#State 361
		ACTIONS => {
			";" => 379
		}
	},
	{#State 362
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 124,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_NAMED_VOID' => 128,
			'MY' => 129,
			'LITERAL_STRING' => 130,
			"if" => 131,
			'OP19_LOOP_CONTROL' => 109,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'OP05_LOGICAL_NEG' => 116,
			"%{" => 115,
			"foreach" => -147,
			'OP22_LOGICAL_NEG' => 93,
			'OP10_NAMED_UNARY' => 95,
			"for" => -147,
			'WORD' => 29,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			"while" => -147,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'OP01_PRINT' => 100,
			'VARIABLE_SYMBOL' => 98,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 104,
			'OP01_CLOSE' => 103,
			'LBRACE' => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			"\@{" => 90
		},
		GOTOS => {
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 119,
			'Operation' => 380,
			'LoopLabel' => 96,
			'Expression' => 123,
			'OperatorVoid' => 99,
			'Operator' => 127,
			'Statement' => 126,
			'PLUS-43' => 381,
			'OPTIONAL-38' => 106,
			'HashDereference' => 102,
			'HashReference' => 84,
			'VariableDeclaration' => 108,
			'VariableModification' => 83,
			'Literal' => 88,
			'SubExpression' => 86,
			'PAREN-37' => 85,
			'Conditional' => 113,
			'WordScoped' => 91,
			'ArrayReference' => 114
		}
	},
	{#State 363
		DEFAULT => -155,
		GOTOS => {
			'STAR-40' => 382
		}
	},
	{#State 364
		DEFAULT => -52
	},
	{#State 365
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 383
		}
	},
	{#State 366
		ACTIONS => {
			'MY' => 384
		}
	},
	{#State 367
		DEFAULT => -63
	},
	{#State 368
		ACTIONS => {
			'VARIABLE_SYMBOL' => 385
		}
	},
	{#State 369
		DEFAULT => -201
	},
	{#State 370
		ACTIONS => {
			'OP20_HASH_FATARROW' => 386
		}
	},
	{#State 371
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 387
		}
	},
	{#State 372
		ACTIONS => {
			";" => 388
		}
	},
	{#State 373
		DEFAULT => -84
	},
	{#State 374
		DEFAULT => -217
	},
	{#State 375
		ACTIONS => {
			'OP21_LIST_COMMA' => 389
		}
	},
	{#State 376
		ACTIONS => {
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP01_NAMED' => 178,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'LITERAL_STRING' => 130,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"%{" => 115,
			"\@{" => 90,
			'LITERAL_NUMBER' => 112,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110
		},
		GOTOS => {
			'Variable' => 167,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'Expression' => 168,
			'SubExpression' => 390,
			'Literal' => 88,
			'Operator' => 127,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91
		}
	},
	{#State 377
		ACTIONS => {
			"%{" => 115,
			"\@{" => 90,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_OPEN' => 92,
			"undef" => 111,
			'LPAREN' => 89,
			'SELF' => 110,
			'LITERAL_NUMBER' => 112,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_QW' => 197,
			'OP01_CLOSE' => 103,
			'LITERAL_STRING' => 130,
			'MY' => 172,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'VARIABLE_SYMBOL' => 98,
			'OP01_NAMED' => 178,
			'WORD' => 29,
			'OP10_NAMED_UNARY' => 95,
			'OP22_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118
		},
		GOTOS => {
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127,
			'TypeInner' => 202,
			'SubExpression' => 200,
			'Expression' => 168,
			'Literal' => 88,
			'Variable' => 167,
			'ListElements' => 391,
			'HashReference' => 84,
			'ArrayDereference' => 122,
			'ListElement' => 199,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 378
		DEFAULT => -165
	},
	{#State 379
		DEFAULT => -176
	},
	{#State 380
		DEFAULT => -167
	},
	{#State 381
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 109,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'OP05_LOGICAL_NEG' => 116,
			"%{" => 115,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 124,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_NAMED_VOID' => 128,
			'MY' => 129,
			"if" => 131,
			'LITERAL_STRING' => 130,
			"}" => 393,
			'LBRACE' => 87,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			"\@{" => 90,
			"foreach" => -147,
			'OP22_LOGICAL_NEG' => 93,
			'OP10_NAMED_UNARY' => 95,
			"for" => -147,
			'WORD' => 29,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			'OP01_PRINT' => 100,
			"while" => -147,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'VARIABLE_SYMBOL' => 98,
			'WORD_UPPERCASE' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'Variable' => 119,
			'Operation' => 392,
			'LoopLabel' => 96,
			'Expression' => 123,
			'OperatorVoid' => 99,
			'Operator' => 127,
			'Statement' => 126,
			'OPTIONAL-38' => 106,
			'HashDereference' => 102,
			'VariableDeclaration' => 108,
			'HashReference' => 84,
			'VariableModification' => 83,
			'Literal' => 88,
			'SubExpression' => 86,
			'PAREN-37' => 85,
			'Conditional' => 113,
			'WordScoped' => 91,
			'ArrayReference' => 114
		}
	},
	{#State 382
		ACTIONS => {
			"\@{" => -158,
			'OP01_OPEN' => -158,
			'LPAREN' => -158,
			"}" => -158,
			'LBRACE' => -158,
			'OP01_CLOSE' => -158,
			'WORD_UPPERCASE' => -158,
			'OP05_MATH_NEG_LPAREN' => -158,
			'VARIABLE_SYMBOL' => -158,
			'OP01_NAMED_VOID_SCOLON' => -158,
			"while" => -158,
			'OP01_PRINT' => -158,
			'OP19_LOOP_CONTROL_SCOLON' => -158,
			'WORD' => -158,
			"for" => -158,
			'OP10_NAMED_UNARY' => -158,
			'OP22_LOGICAL_NEG' => -158,
			"foreach" => -158,
			"%{" => -158,
			'OP05_LOGICAL_NEG' => -158,
			"undef" => -158,
			'SELF' => -158,
			'LITERAL_NUMBER' => -158,
			'WORD_SCOPED' => -158,
			'LBRACKET' => -158,
			'OP19_LOOP_CONTROL' => -158,
			"if" => -158,
			'LITERAL_STRING' => -158,
			'MY' => -158,
			'OP01_NAMED_VOID' => -158,
			"else" => 396,
			'OP01_NAMED' => -158,
			'OP01_NAMED_VOID_LPAREN' => -158,
			"elsif" => 395,
			'OP03_MATH_INC_DEC' => -158,
			'' => -158
		},
		GOTOS => {
			'PAREN-41' => 397,
			'PAREN-39' => 398,
			'OPTIONAL-42' => 394
		}
	},
	{#State 383
		ACTIONS => {
			"\@_;" => 399
		}
	},
	{#State 384
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 400
		}
	},
	{#State 385
		ACTIONS => {
			"= sub {" => 401
		}
	},
	{#State 386
		ACTIONS => {
			'MY' => 172
		},
		GOTOS => {
			'TypeInner' => 402
		}
	},
	{#State 387
		ACTIONS => {
			"}" => 404,
			'OP21_LIST_COMMA' => 403
		},
		GOTOS => {
			'PAREN-26' => 405
		}
	},
	{#State 388
		DEFAULT => -68
	},
	{#State 389
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP01_CLOSE' => 103,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP01_NAMED' => 178,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'LITERAL_NUMBER' => 112,
			"\@{" => 90,
			"%{" => 115,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACKET' => 107,
			'LBRACE' => 87,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'Operator' => 127,
			'WordScoped' => 91,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'Variable' => 167,
			'Literal' => 88,
			'SubExpression' => 406,
			'Expression' => 168
		}
	},
	{#State 390
		ACTIONS => {
			'OP17_LIST_RANGE' => 407,
			'OP16_LOGICAL_OR' => 142,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 149,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP08_MATH_ADD_SUB' => 153,
			'OP11_COMPARE_LT_GT' => 147,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 155,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP15_LOGICAL_AND' => 152,
			'OP23_LOGICAL_AND' => 146,
			'OP09_BITWISE_SHIFT' => 151
		}
	},
	{#State 391
		ACTIONS => {
			")" => 408
		}
	},
	{#State 392
		DEFAULT => -166
	},
	{#State 393
		DEFAULT => -168
	},
	{#State 394
		DEFAULT => -159
	},
	{#State 395
		ACTIONS => {
			'LPAREN' => 409
		}
	},
	{#State 396
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 410
		}
	},
	{#State 397
		DEFAULT => -157
	},
	{#State 398
		DEFAULT => -154
	},
	{#State 399
		DEFAULT => -54
	},
	{#State 400
		ACTIONS => {
			'VARIABLE_SYMBOL' => 411
		}
	},
	{#State 401
		ACTIONS => {
			'OP01_CLOSE' => -70,
			'OP05_MATH_NEG_LPAREN' => -70,
			'WORD_UPPERCASE' => -70,
			'VARIABLE_SYMBOL' => -70,
			'OP01_NAMED_VOID_SCOLON' => -70,
			"while" => -70,
			'OP01_PRINT' => -70,
			'OP19_LOOP_CONTROL_SCOLON' => -70,
			'OP10_NAMED_UNARY' => -70,
			"for" => -70,
			'WORD' => -70,
			'OP22_LOGICAL_NEG' => -70,
			"foreach" => -70,
			"\@{" => -70,
			'OP01_OPEN' => -70,
			'LPAREN' => -70,
			'LBRACE' => -70,
			"}" => -70,
			'OP01_NAMED_VOID' => -70,
			'MY' => -70,
			"if" => -70,
			'LITERAL_STRING' => -70,
			'OP01_NAMED' => -70,
			'OP01_NAMED_VOID_LPAREN' => -70,
			'OP03_MATH_INC_DEC' => -70,
			"%{" => -70,
			'OP05_LOGICAL_NEG' => -70,
			'SELF' => -70,
			"undef" => -70,
			'LPAREN_MY' => 412,
			'LITERAL_NUMBER' => -70,
			'WORD_SCOPED' => -70,
			'LBRACKET' => -70,
			'OP19_LOOP_CONTROL' => -70
		},
		GOTOS => {
			'OPTIONAL-28' => 413,
			'MethodArguments' => 414
		}
	},
	{#State 402
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'WORD_UPPERCASE' => 166,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89
		},
		GOTOS => {
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127,
			'SubExpression' => 415,
			'Expression' => 168,
			'Literal' => 88,
			'Variable' => 167,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 403
		ACTIONS => {
			'WORD' => 370,
			"%{" => 115
		},
		GOTOS => {
			'HashEntryTyped' => 416,
			'HashDereference' => 369
		}
	},
	{#State 404
		ACTIONS => {
			";" => 417
		}
	},
	{#State 405
		DEFAULT => -65
	},
	{#State 406
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 151,
			'OP23_LOGICAL_AND' => -85,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			")" => -85,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			";" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_STRING_REPEAT' => 149,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141,
			"]" => -85,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			"}" => -85
		}
	},
	{#State 407
		ACTIONS => {
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'VARIABLE_SYMBOL' => 98,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87,
			'LBRACKET' => 107,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89
		},
		GOTOS => {
			'Expression' => 168,
			'SubExpression' => 418,
			'Literal' => 88,
			'Variable' => 167,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'HashDereference' => 102,
			'ArrayReference' => 114,
			'WordScoped' => 91,
			'Operator' => 127
		}
	},
	{#State 408
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 419
		}
	},
	{#State 409
		ACTIONS => {
			'VARIABLE_SYMBOL' => 98,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_UPPERCASE' => 166,
			'LITERAL_STRING' => 130,
			'OP01_CLOSE' => 103,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 93,
			'OP10_NAMED_UNARY' => 95,
			'WORD' => 29,
			'OP01_NAMED' => 178,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			'OP05_LOGICAL_NEG' => 116,
			"\@{" => 90,
			"%{" => 115,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LBRACE' => 87
		},
		GOTOS => {
			'Operator' => 127,
			'WordScoped' => 91,
			'ArrayReference' => 114,
			'HashDereference' => 102,
			'ArrayDereference' => 122,
			'HashReference' => 84,
			'VariableSymbolOrSelf' => 121,
			'Variable' => 167,
			'Literal' => 88,
			'SubExpression' => 420,
			'Expression' => 168
		}
	},
	{#State 410
		DEFAULT => -156
	},
	{#State 411
		DEFAULT => -51
	},
	{#State 412
		ACTIONS => {
			'WORD_SCOPED' => 58,
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 421
		}
	},
	{#State 413
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 422
		}
	},
	{#State 414
		DEFAULT => -69
	},
	{#State 415
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 151,
			'OP18_TERNARY' => 145,
			'OP04_MATH_POW' => 144,
			'OP23_LOGICAL_AND' => 146,
			'OP15_LOGICAL_AND' => 152,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP21_LIST_COMMA' => -200,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			"}" => -200,
			'OP17_LIST_RANGE' => 143,
			'OP16_LOGICAL_OR' => 142
		}
	},
	{#State 416
		DEFAULT => -64
	},
	{#State 417
		DEFAULT => -67
	},
	{#State 418
		ACTIONS => {
			'OP07_STRING_REPEAT' => 149,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP13_BITWISE_AND' => 141,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 142,
			'OP09_BITWISE_SHIFT' => 151,
			'OP18_TERNARY' => -106,
			'OP04_MATH_POW' => 144,
			'OP23_LOGICAL_AND' => -106,
			'OP15_LOGICAL_AND' => 152,
			'OP08_MATH_ADD_SUB' => 153,
			'OP06_REGEX_MATCH' => 155,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			")" => 423
		}
	},
	{#State 419
		DEFAULT => -164
	},
	{#State 420
		ACTIONS => {
			'OP23_LOGICAL_AND' => 146,
			'OP15_LOGICAL_AND' => 152,
			'OP04_MATH_POW' => 144,
			'OP18_TERNARY' => 145,
			'OP09_BITWISE_SHIFT' => 151,
			")" => 424,
			'OP07_MATH_MULT_DIV_MOD' => 156,
			'OP08_STRING_CAT' => 154,
			'OP14_BITWISE_OR_XOR' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 155,
			'OP08_MATH_ADD_SUB' => 153,
			'OP24_LOGICAL_OR_XOR' => 140,
			'OP07_STRING_REPEAT' => 149,
			'OP16_LOGICAL_OR' => 142,
			'OP17_LIST_RANGE' => 143,
			'OP12_COMPARE_EQ_NE' => 150,
			'OP13_BITWISE_AND' => 141
		}
	},
	{#State 421
		ACTIONS => {
			'SELF' => 425
		}
	},
	{#State 422
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 109,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 112,
			'SELF' => 110,
			"undef" => 111,
			'OP05_LOGICAL_NEG' => 116,
			"%{" => 115,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED_VOID_LPAREN' => 125,
			'OP01_NAMED' => 124,
			'OP01_NAMED_VOID' => 128,
			'LITERAL_STRING' => 130,
			'MY' => 129,
			"if" => 131,
			'LBRACE' => 87,
			"}" => 427,
			'LPAREN' => 89,
			'OP01_OPEN' => 92,
			"\@{" => 90,
			"foreach" => -147,
			'OP22_LOGICAL_NEG' => 93,
			'OP10_NAMED_UNARY' => 95,
			"for" => -147,
			'WORD' => 29,
			'OP19_LOOP_CONTROL_SCOLON' => 94,
			'OP01_NAMED_VOID_SCOLON' => 101,
			"while" => -147,
			'OP01_PRINT' => 100,
			'VARIABLE_SYMBOL' => 98,
			'WORD_UPPERCASE' => 104,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_CLOSE' => 103
		},
		GOTOS => {
			'Operation' => 426,
			'Variable' => 119,
			'ArrayDereference' => 122,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 123,
			'LoopLabel' => 96,
			'Statement' => 126,
			'Operator' => 127,
			'OperatorVoid' => 99,
			'HashDereference' => 102,
			'OPTIONAL-38' => 106,
			'VariableModification' => 83,
			'HashReference' => 84,
			'VariableDeclaration' => 108,
			'SubExpression' => 86,
			'PAREN-37' => 85,
			'Literal' => 88,
			'Conditional' => 113,
			'ArrayReference' => 114,
			'WordScoped' => 91
		}
	},
	{#State 423
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 428
		}
	},
	{#State 424
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 429
		}
	},
	{#State 425
		DEFAULT => -76,
		GOTOS => {
			'STAR-31' => 430
		}
	},
	{#State 426
		DEFAULT => -71
	},
	{#State 427
		ACTIONS => {
			";" => 431
		}
	},
	{#State 428
		DEFAULT => -163
	},
	{#State 429
		DEFAULT => -153
	},
	{#State 430
		ACTIONS => {
			'OP21_LIST_COMMA' => 433,
			")" => 434
		},
		GOTOS => {
			'PAREN-30' => 432
		}
	},
	{#State 431
		DEFAULT => -73
	},
	{#State 432
		DEFAULT => -75
	},
	{#State 433
		ACTIONS => {
			'MY' => 435
		}
	},
	{#State 434
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 436
		}
	},
	{#State 435
		ACTIONS => {
			'WORD' => 57,
			'WORD_SCOPED' => 58,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 437
		}
	},
	{#State 436
		ACTIONS => {
			"\@_;" => 438
		}
	},
	{#State 437
		ACTIONS => {
			'VARIABLE_SYMBOL' => 439
		}
	},
	{#State 438
		DEFAULT => -77
	},
	{#State 439
		DEFAULT => -74
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6069 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6076 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6083 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6090 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6112 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6133 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6140 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6147 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6161 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6168 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6175 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6182 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6196 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6228 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6235 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6246 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6275 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6289 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6296 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6310 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6317 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6324 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6335 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6342 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6349 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6360 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6367 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6374 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule Include_43
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6410 lib/RPerl/Grammar.pm
	],
	[#Rule Include_44
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6421 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_45
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6432 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6439 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6446 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6453 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6460 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_50
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6471 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6478 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6485 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6492 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_54
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6517 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6524 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6538 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6552 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6559 lib/RPerl/Grammar.pm
	],
	[#Rule Class_63
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6570 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6577 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6584 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6591 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_67
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6602 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_68
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6613 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6620 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6627 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6641 lib/RPerl/Grammar.pm
	],
	[#Rule Method_73
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6652 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 4,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6659 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_77
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6684 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_78
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6695 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_79
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6706 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6728 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6739 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6750 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6761 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6816 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6827 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6849 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6860 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6871 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6882 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6937 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6970 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6981 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6992 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7003 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7014 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7025 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7036 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7047 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7061 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7075 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7126 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7137 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7148 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7159 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7170 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7184 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7191 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7209 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7297 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7308 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7319 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7330 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7341 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_143
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_144
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 2,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7399 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7406 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7417 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7428 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7439 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7450 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7461 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 5,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7468 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7475 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7482 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7489 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7496 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7503 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_159
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7514 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_160
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7525 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7536 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7547 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_163
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7558 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_164
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7569 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_165
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7580 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7587 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7594 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_168
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7605 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7612 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7619 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_171
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7630 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_172
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7641 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_173
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7652 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7663 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_175
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7674 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_176
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7685 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_177
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7696 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_178
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7707 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_179
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7718 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7725 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7732 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7739 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_183
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7750 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7757 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 1,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7764 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_186
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7775 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7786 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7804 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7811 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_191
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7822 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7829 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7836 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_194
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7847 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_195
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7858 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7865 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7872 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_198
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7883 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_199
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7894 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_200
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7905 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_201
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7916 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7923 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7937 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_205
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7948 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_206
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7973 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_209
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7984 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_210
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7995 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_211
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8006 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_212
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8017 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8028 lib/RPerl/Grammar.pm
	],
	[#Rule Type_214
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8039 lib/RPerl/Grammar.pm
	],
	[#Rule Type_215
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8050 lib/RPerl/Grammar.pm
	],
	[#Rule Type_216
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8061 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_217
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8072 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_218
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8083 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_219
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8094 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_220
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8105 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_221
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8116 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_222
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8127 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_223
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8138 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_224
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8149 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_225
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8160 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_226
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8171 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_227
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8182 lib/RPerl/Grammar.pm
	]
],
#line 8185 lib/RPerl/Grammar.pm
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
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ModuleHeader_23', 
         'Module_24', 
         'Module_25', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_34', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Header_37', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Critic_40', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_43', 
         'Include_44', 
         'Constant_45', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Subroutine_50', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_54', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_63', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_67', 
         'Properties_68', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_73', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_77', 
         'MethodOrSubroutine_78', 
         'MethodOrSubroutine_79', 
         'Operation_80', 
         'Operation_81', 
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
         'Operator_108', 
         'Operator_109', 
         'Operator_110', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_116', 
         'OperatorVoid_117', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         'OperatorVoid_122', 
         'OperatorVoid_123', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_128', 
         'Expression_129', 
         'Expression_130', 
         'Expression_131', 
         'Expression_132', 
         'Expression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpression_141', 
         'SubExpression_142', 
         'SubExpressionOrStdin_143', 
         'SubExpressionOrStdin_144', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_148', 
         'Statement_149', 
         'Statement_150', 
         'Statement_151', 
         'Statement_152', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_159', 
         'Loop_160', 
         'Loop_161', 
         'Loop_162', 
         'LoopFor_163', 
         'LoopForEach_164', 
         'LoopWhile_165', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_168', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_171', 
         'VariableRetrieval_172', 
         'VariableRetrieval_173', 
         'VariableRetrieval_174', 
         'VariableDeclaration_175', 
         'VariableDeclaration_176', 
         'VariableDeclaration_177', 
         'VariableModification_178', 
         'VariableModification_179', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_183', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElement_186', 
         'ListElement_187', 
         'ListElement_188', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_191', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_194', 
         'ArrayDereference_195', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_198', 
         'HashEntry_199', 
         'HashEntryTyped_200', 
         'HashEntryTyped_201', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_205', 
         'HashReference_206', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_209', 
         'HashDereference_210', 
         'WordScoped_211', 
         'WordScoped_212', 
         'LoopLabel_213', 
         'Type_214', 
         'Type_215', 
         'Type_216', 
         'TypeInner_217', 
         'TypeInnerConstant_218', 
         'VariableOrLiteral_219', 
         'VariableOrLiteral_220', 
         'VariableOrLiteralOrWord_221', 
         'VariableOrLiteralOrWord_222', 
         'VariableOrLiteralOrWord_223', 
         'VariableSymbolOrSelf_224', 
         'VariableSymbolOrSelf_225', 
         'Literal_226', 
         'Literal_227', );
  $self;
}

#line 215 "lib/RPerl/Grammar.eyp"


{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run scripts/grammar_recompile.sh
# 3. Run new & existing grammar tests
# 4. Copy updates from Grammar.output file into this file, below this line only
# 5. Run scripts/grammar_recompile.sh again
our string_hashref $RULES = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',                             # CompileUnit -> Program
CompileUnit_5 => 'RPerl::CompileUnit::Module',                              # CompileUnit -> PLUS-2
Program_18 => 'RPerl::CompileUnit::Program',                                # Program -> SHEBANG OPTIONAL-3 USE_RPERL Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
ModuleHeader_23 => 'RPerl::CompileUnit::Module::Header',                    # ModuleHeader -> OPTIONAL-9 OPTIONAL-10 'package' WordScoped ';' Header
Module_24 => 'RPerl::CompileUnit::Module::Package',                         # Module -> Package
Module_25 => 'RPerl::CompileUnit::Module::Class::Generator',                # Module -> Class
Package_34 => 'RPerl::CompileUnit::Module::Package',                        # Package -> STAR-10 STAR-11 STAR-12 PLUS-13 LITERAL_NUMBER ';'
Header_37 => 'RPerl::NonGenerator',                                         # Header -> 'use strict;' 'use warnings;' OPTIONAL-15 'our' VERSION_NUMBER_ASSIGN
Critic_40 => 'RPerl::CompileUnit::Critic',                                  # Critic -> '## no critic qw(' PLUS-14 ')'
Include_43 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped ';'
Include_44 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped OP01_QW PLUS-15 ')' ';'
Constant_45 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_50 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_54 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@_;'
Class_63 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_67 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryTyped STAR-25 '}' ';'
Properties_68 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_73 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_77 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_78 => 'RPerl::CodeBlock::Subroutine::Method',            # MethodOrSubroutine -> Method
MethodOrSubroutine_79 => 'RPerl::CodeBlock::Subroutine',                    # MethodOrSubroutine -> Subroutine
Operation_80 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_81 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_82 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_83 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_84 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_85 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_86 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_87 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> OP03_MATH_INC_DEC Variable
Operator_88 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> Variable OP03_MATH_INC_DEC
Operator_89 => 'RPerl::Operation::Expression::Operator::Math::Power',                   # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_90 => 'RPerl::Operation::Expression::Operator::Logical::Negation',             # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_91 => 'RPerl::Operation::Expression::Operator::Math::Negative',                # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_92 => 'RPerl::Operation::Expression::Operator::RegularExpression',             # Operator -> SubExpression OP06_REGEX_MATCH OP06_REGEX_PATTERN
Operator_93 => 'RPerl::Operation::Expression::Operator::String::Repeat',                # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_94 => 'RPerl::Operation::Expression::Operator::Math::MultiplyDivideModulo',    # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_95 => 'RPerl::Operation::Expression::Operator::Math::AddSubtract',             # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_96 => 'RPerl::Operation::Expression::Operator::String::Concatenate',           # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_97 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_98 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY SubExpression
Operator_99 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY
Operator_100 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',  # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',        # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_102 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                  # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',                # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_104 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_105 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_106 => 'RPerl::Operation::Expression::Operator::List::Range',                  # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::Ternary',                      # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_108 => 'RPerl::Operation::Expression::Operator::Logical::Negation',            # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_109 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_110 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_116 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_117 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_118 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_119 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_120 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_121 => 'RPerl::Operation::Expression::Operator::Named',                    # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_122 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_123 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_128 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_129 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_130 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_131 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WordScoped SCOPE WORD_UPPERCASE LPAREN ')'
Expression_132 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_133 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_134 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_135 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_136 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_138 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_139 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_140 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_141 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_142 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrStdin_143 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrStdin -> SubExpression
SubExpressionOrStdin_144 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrStdin -> STDIN
Statement_148 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_149 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_150 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_151 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_152 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification
Conditional_159 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_160 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_161 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_162 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_163 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopForEach_164 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_165 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
CodeBlock_168 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_171 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_172 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_173 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_174 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_175 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_176 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableDeclaration_177 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_178 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableModification_179 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression ';'
ListElements_183 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_186 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_187 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_188 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW PLUS-44 ')'
ArrayReference_191 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_194 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_195 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_198 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_199 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntryTyped_200 => 'RPerl::DataStructure::Hash::EntryTyped',                                 # HashEntryTyped -> WORD OP20_HASH_FATARROW TypeInner SubExpression
HashEntryTyped_201 => 'RPerl::Operation::Expression::SubExpression::HashDereference',           # HashEntryTyped -> HashDereference
HashReference_205 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_206 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_209 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_210 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_211 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_212 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_213 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_214 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_215 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_216 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_217 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_218 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_219 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_220 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_221 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_222 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_223 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
VariableSymbolOrSelf_224 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_225 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_226 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_227 => 'RPerl::Operation::Expression::SubExpression::Literal::String'                   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8583 lib/RPerl/Grammar.pm



1;
