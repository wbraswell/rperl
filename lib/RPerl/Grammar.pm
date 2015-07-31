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
    our $VERSION = 0.001_330;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|foreach|package|\$TYPED_|\=\ sub\ \{|elsif|while|undef|else|for|our|\@_\;|if|\@\{|\%\{|\)|\]|\}|\;)}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G(\s*use\s+RPerl\s*;\s*)/gc and return ('USE_RPERL', $1);
      /\G(\s*use\s+RPerl::AfterSubclass\s*;\s*)/gc and return ('USE_RPERL_AFTER', $1);
      /\G(use)/gc and return ('USE', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G([+-]?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?(e[+-]?\d+)?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q\{[^}]*\}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer)\s+/gc and return ('TYPE_INTEGER', $1);
      /\G(filehandleref\s+)/gc and return ('TYPE_FHREF', $1);
      /\G([a-zA-Z]\w*::method)/gc and return ('TYPE_METHOD', $1);
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
  [ 'Program_18' => 'Program', [ 'SHEBANG', 'USE_RPERL', 'OPTIONAL-3', 'Header', 'STAR-4', 'STAR-5', 'STAR-6', 'STAR-7', 'PLUS-8' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [ 'USE_RPERL' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-10', [ 'Critic' ], 0 ],
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
  [ 'MethodArguments_77' => 'MethodArguments', [ 'LPAREN_MY', 'TYPE_SELF', 'STAR-31', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
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
  [ 'Variable_171' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-44' ], 0 ],
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
  [ 'Literal_224' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_225' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'Literal_224' => 224,
  'Literal_225' => 225,
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
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
	TYPE_FHREF => { ISSEMANTIC => 1 },
	TYPE_INTEGER => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
	TYPE_SELF => { ISSEMANTIC => 1 },
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
			'USE_RPERL' => 1,
			"package" => -20,
			"## no critic qw(" => -20,
			'SHEBANG' => 3
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'PAREN-1' => 2,
			'OPTIONAL-9' => 6,
			'PLUS-2' => 7,
			'CompileUnit' => 8,
			'Program' => 4
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		DEFAULT => -3
	},
	{#State 3
		ACTIONS => {
			'USE_RPERL' => 9
		}
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			"use constant" => -27,
			"## no critic qw(" => -27,
			"our" => -27,
			"use parent qw(" => 14,
			'USE' => -27
		},
		GOTOS => {
			'Module' => 13,
			'Package' => 10,
			'Class' => 11,
			'STAR-11' => 12
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 15,
			"package" => -22
		},
		GOTOS => {
			'Critic' => 16,
			'OPTIONAL-10' => 17
		}
	},
	{#State 7
		ACTIONS => {
			'' => -5,
			'USE_RPERL' => 1,
			"package" => -20,
			"## no critic qw(" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 6,
			'PAREN-1' => 18,
			'ModuleHeader' => 5
		}
	},
	{#State 8
		ACTIONS => {
			'' => 19
		}
	},
	{#State 9
		ACTIONS => {
			"use strict;" => -7,
			"## no critic qw(" => 15
		},
		GOTOS => {
			'OPTIONAL-3' => 21,
			'Critic' => 20
		}
	},
	{#State 10
		DEFAULT => -24
	},
	{#State 11
		DEFAULT => -25
	},
	{#State 12
		ACTIONS => {
			'USE' => -29,
			"our" => -29,
			"## no critic qw(" => 15,
			"use constant" => -29
		},
		GOTOS => {
			'STAR-12' => 22,
			'Critic' => 23
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 15
		ACTIONS => {
			'WORD' => 28
		},
		GOTOS => {
			'PLUS-16' => 27
		}
	},
	{#State 16
		DEFAULT => -21
	},
	{#State 17
		ACTIONS => {
			"package" => 29
		}
	},
	{#State 18
		DEFAULT => -2
	},
	{#State 19
		DEFAULT => 0
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		ACTIONS => {
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 22
		ACTIONS => {
			"use constant" => -31,
			'USE' => 34,
			"our" => -31
		},
		GOTOS => {
			'Include' => 32,
			'STAR-13' => 33
		}
	},
	{#State 23
		DEFAULT => -26
	},
	{#State 24
		DEFAULT => -211
	},
	{#State 25
		DEFAULT => -212
	},
	{#State 26
		ACTIONS => {
			")" => 35
		}
	},
	{#State 27
		ACTIONS => {
			'WORD' => 36,
			")" => 37
		}
	},
	{#State 28
		DEFAULT => -39
	},
	{#State 29
		ACTIONS => {
			'WORD' => 24,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 30
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 39
		}
	},
	{#State 31
		ACTIONS => {
			"use warnings;" => 40
		}
	},
	{#State 32
		DEFAULT => -28
	},
	{#State 33
		ACTIONS => {
			"our" => 43,
			"use constant" => 41
		},
		GOTOS => {
			'Constant' => 44,
			'Subroutine' => 42,
			'PLUS-14' => 45
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 46
		}
	},
	{#State 35
		ACTIONS => {
			";" => 47
		}
	},
	{#State 36
		DEFAULT => -38
	},
	{#State 37
		DEFAULT => -40
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED' => -11,
			'LPAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP10_NAMED_UNARY' => -11,
			"foreach" => -11,
			"use constant" => -11,
			'USE' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LITERAL_STRING' => -11,
			"## no critic qw(" => 15,
			"while" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED_VOID' => -11,
			"our" => -11,
			'LITERAL_NUMBER' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'WORD_SCOPED' => -11,
			"for" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"\@{" => -11,
			'OP01_OPEN' => -11,
			'LBRACKET' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"%{" => -11,
			'WORD' => -11,
			"if" => -11,
			'MY' => -11,
			"undef" => -11,
			'LBRACE' => -11,
			'OP01_PRINT' => -11
		},
		GOTOS => {
			'STAR-5' => 49,
			'Critic' => 50
		}
	},
	{#State 40
		ACTIONS => {
			'USE_RPERL_AFTER' => 51,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 52
		}
	},
	{#State 41
		ACTIONS => {
			'WORD_UPPERCASE' => 53
		}
	},
	{#State 42
		DEFAULT => -33
	},
	{#State 43
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 44
		DEFAULT => -30
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 58,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 59
		}
	},
	{#State 46
		ACTIONS => {
			";" => 60,
			'OP01_QW' => 61
		}
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
			"use strict;" => 31
		},
		GOTOS => {
			'Header' => 63
		}
	},
	{#State 49
		ACTIONS => {
			'USE' => 34,
			'OP05_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			"while" => -13,
			'OP10_NAMED_UNARY' => -13,
			"foreach" => -13,
			"use constant" => -13,
			'OP01_NAMED' => -13,
			'LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LBRACE' => -13,
			'OP01_PRINT' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'LBRACKET' => -13,
			'MY' => -13,
			"undef" => -13,
			"%{" => -13,
			'WORD' => -13,
			"if" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"for" => -13,
			"\@{" => -13,
			'OP01_OPEN' => -13,
			'OP01_NAMED_VOID' => -13,
			"our" => -13,
			'WORD_SCOPED' => -13,
			'LITERAL_NUMBER' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13
		},
		GOTOS => {
			'STAR-6' => 64,
			'Include' => 65
		}
	},
	{#State 50
		DEFAULT => -8
	},
	{#State 51
		DEFAULT => -35
	},
	{#State 52
		ACTIONS => {
			"our" => 66
		}
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 54
		DEFAULT => -215
	},
	{#State 55
		DEFAULT => -214
	},
	{#State 56
		DEFAULT => -216
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 58
		ACTIONS => {
			";" => 69
		}
	},
	{#State 59
		DEFAULT => -32
	},
	{#State 60
		DEFAULT => -43
	},
	{#State 61
		ACTIONS => {
			'WORD' => 70
		},
		GOTOS => {
			'PLUS-17' => 71
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
			'MY' => -15,
			"undef" => -15,
			"%{" => -15,
			'WORD' => -15,
			"if" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'LBRACKET' => -15,
			'OP01_PRINT' => -15,
			'LBRACE' => -15,
			'WORD_SCOPED' => -15,
			'LITERAL_NUMBER' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_NAMED_VOID' => -15,
			"our" => -15,
			"\@{" => -15,
			'OP01_OPEN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"for" => -15,
			"use constant" => 41,
			'OP10_NAMED_UNARY' => -15,
			"foreach" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LITERAL_STRING' => -15,
			"while" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED' => -15,
			'LPAREN' => -15,
			'OP01_CLOSE' => -15
		},
		GOTOS => {
			'STAR-7' => 73,
			'Constant' => 74
		}
	},
	{#State 65
		DEFAULT => -10
	},
	{#State 66
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 75
		}
	},
	{#State 67
		ACTIONS => {
			'MY' => 76
		},
		GOTOS => {
			'TypeInnerConstant' => 77
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 78
		}
	},
	{#State 69
		DEFAULT => -34
	},
	{#State 70
		DEFAULT => -42
	},
	{#State 71
		ACTIONS => {
			'WORD' => 79,
			")" => 80
		}
	},
	{#State 72
		ACTIONS => {
			"our hashref \$properties" => -58,
			"## no critic qw(" => 15,
			"use constant" => -58,
			'USE' => -58
		},
		GOTOS => {
			'Critic' => 82,
			'STAR-23' => 81
		}
	},
	{#State 73
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 87,
			'OP19_LOOP_CONTROL_SCOLON' => 86,
			"while" => -147,
			'LITERAL_STRING' => 85,
			"foreach" => -147,
			'OP10_NAMED_UNARY' => 84,
			'LPAREN' => 100,
			'OP01_NAMED' => 101,
			'OP01_CLOSE' => 97,
			'OP01_NAMED_VOID_LPAREN' => 96,
			'WORD_UPPERCASE' => 95,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'LBRACE' => 113,
			'OP01_PRINT' => 109,
			'OP19_LOOP_CONTROL' => 108,
			'LBRACKET' => 106,
			'MY' => 104,
			"undef" => 105,
			"if" => 103,
			"%{" => 102,
			'WORD' => 24,
			'OP05_MATH_NEG_LPAREN' => 129,
			"for" => -147,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			"our" => 43,
			'OP01_NAMED_VOID' => 121,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114
		},
		GOTOS => {
			'SubExpression' => 89,
			'Conditional' => 88,
			'Statement' => 112,
			'OperatorVoid' => 110,
			'WordScoped' => 111,
			'Variable' => 107,
			'VariableModification' => 83,
			'VariableDeclaration' => 128,
			'PLUS-8' => 98,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'HashDereference' => 126,
			'Expression' => 94,
			'PAREN-37' => 124,
			'Subroutine' => 91,
			'OPTIONAL-38' => 122,
			'Operation' => 92,
			'LoopLabel' => 117,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118
		}
	},
	{#State 74
		DEFAULT => -12
	},
	{#State 75
		DEFAULT => -37
	},
	{#State 76
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD' => 55,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 130
		}
	},
	{#State 77
		ACTIONS => {
			'LITERAL_NUMBER' => 114,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Literal' => 131
		}
	},
	{#State 78
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -47,
			'LITERAL_STRING' => -47,
			"while" => -47,
			'OP05_LOGICAL_NEG' => -47,
			'LPAREN_MY' => 134,
			'OP10_NAMED_UNARY' => -47,
			"foreach" => -47,
			'OP01_NAMED_VOID_LPAREN' => -47,
			'OP03_MATH_INC_DEC' => -47,
			'WORD_UPPERCASE' => -47,
			'LPAREN' => -47,
			'OP01_NAMED' => -47,
			'OP01_CLOSE' => -47,
			"}" => -47,
			'OP01_NAMED_VOID_SCOLON' => -47,
			'OP01_PRINT' => -47,
			'LBRACE' => -47,
			"undef" => -47,
			'MY' => -47,
			"%{" => -47,
			'WORD' => -47,
			"if" => -47,
			'OP19_LOOP_CONTROL' => -47,
			'LBRACKET' => -47,
			"\@{" => -47,
			'OP01_OPEN' => -47,
			'OP05_MATH_NEG_LPAREN' => -47,
			"for" => -47,
			'WORD_SCOPED' => -47,
			'LITERAL_NUMBER' => -47,
			'VARIABLE_SYMBOL' => -47,
			'OP22_LOGICAL_NEG' => -47,
			'OP01_NAMED_VOID' => -47
		},
		GOTOS => {
			'SubroutineArguments' => 133,
			'OPTIONAL-18' => 132
		}
	},
	{#State 79
		DEFAULT => -41
	},
	{#State 80
		ACTIONS => {
			";" => 135
		}
	},
	{#State 81
		ACTIONS => {
			'USE' => 34,
			"our hashref \$properties" => -60,
			"use constant" => -60
		},
		GOTOS => {
			'Include' => 137,
			'STAR-24' => 136
		}
	},
	{#State 82
		DEFAULT => -55
	},
	{#State 83
		DEFAULT => -152
	},
	{#State 84
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP13_BITWISE_AND' => -99,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP24_LOGICAL_OR_XOR' => -99,
			'WORD_SCOPED' => 25,
			'OP14_BITWISE_OR_XOR' => -99,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			")" => -99,
			'LITERAL_NUMBER' => 114,
			'LBRACE' => 113,
			'OP15_LOGICAL_AND' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP08_STRING_CAT' => -99,
			'LBRACKET' => 106,
			'OP17_LIST_RANGE' => -99,
			"undef" => 105,
			'OP06_REGEX_MATCH' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'WORD' => 24,
			'OP16_LOGICAL_OR' => -99,
			"]" => -99,
			"%{" => 102,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 140,
			'OP07_STRING_REPEAT' => -99,
			'OP03_MATH_INC_DEC' => 93,
			'OP23_LOGICAL_AND' => -99,
			'OP18_TERNARY' => -99,
			"}" => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP05_LOGICAL_NEG' => 87,
			'OP04_MATH_POW' => -99,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 84,
			'OP11_COMPARE_LT_GT' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			";" => -99
		},
		GOTOS => {
			'Variable' => 138,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 139,
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126
		}
	},
	{#State 85
		DEFAULT => -225
	},
	{#State 86
		DEFAULT => -122
	},
	{#State 87
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			"undef" => 105,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116
		},
		GOTOS => {
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Variable' => 138,
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111,
			'SubExpression' => 143,
			'ArrayDereference' => 127,
			'HashReference' => 99
		}
	},
	{#State 88
		DEFAULT => -148
	},
	{#State 89
		ACTIONS => {
			'OP04_MATH_POW' => 150,
			'OP09_BITWISE_SHIFT' => 149,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP08_MATH_ADD_SUB' => 155,
			'OP16_LOGICAL_OR' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_STRING_CAT' => 154,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 145,
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151
		}
	},
	{#State 90
		DEFAULT => -118
	},
	{#State 91
		DEFAULT => -14
	},
	{#State 92
		DEFAULT => -17
	},
	{#State 93
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116
		},
		GOTOS => {
			'Variable' => 161
		}
	},
	{#State 94
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP04_MATH_POW' => -134,
			'OP08_STRING_CAT' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP16_LOGICAL_OR' => -134,
			";" => 162,
			'OP08_MATH_ADD_SUB' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP18_TERNARY' => -134,
			'OP14_BITWISE_OR_XOR' => -134
		}
	},
	{#State 95
		ACTIONS => {
			'COLON' => -213,
			'LPAREN' => 163
		}
	},
	{#State 96
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'MY' => 164,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 25,
			")" => -115,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 166
		},
		GOTOS => {
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138,
			'ListElement' => 168,
			'HashDereference' => 126,
			'TypeInner' => 167,
			'Expression' => 141,
			'WordScoped' => 111,
			'ListElements' => 165,
			'OPTIONAL-34' => 169,
			'SubExpression' => 170,
			'ArrayDereference' => 127,
			'HashReference' => 99
		}
	},
	{#State 97
		ACTIONS => {
			'FHREF_SYMBOL' => 171
		}
	},
	{#State 98
		ACTIONS => {
			'OP10_NAMED_UNARY' => 84,
			"foreach" => -147,
			'OP05_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 85,
			"while" => -147,
			'OP19_LOOP_CONTROL_SCOLON' => 86,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP01_CLOSE' => 97,
			'LPAREN' => 100,
			'OP01_NAMED' => 101,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 95,
			'OP01_NAMED_VOID_LPAREN' => 96,
			'LBRACKET' => 106,
			'' => -18,
			'OP19_LOOP_CONTROL' => 108,
			'WORD' => 24,
			"%{" => 102,
			"if" => 103,
			'MY' => 104,
			"undef" => 105,
			'LBRACE' => 113,
			'OP01_PRINT' => 109,
			'OP01_NAMED_VOID' => 121,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'WORD_SCOPED' => 25,
			"for" => -147,
			'OP05_MATH_NEG_LPAREN' => 129,
			"\@{" => 123,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'Variable' => 107,
			'VariableModification' => 83,
			'SubExpression' => 89,
			'Conditional' => 88,
			'Statement' => 112,
			'OperatorVoid' => 110,
			'WordScoped' => 111,
			'OPTIONAL-38' => 122,
			'Operation' => 172,
			'LoopLabel' => 117,
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'VariableDeclaration' => 128,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'HashDereference' => 126,
			'PAREN-37' => 124,
			'Expression' => 94
		}
	},
	{#State 99
		DEFAULT => -140
	},
	{#State 100
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 174,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'OP01_PRINT' => 175,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24
		},
		GOTOS => {
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 173,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'Variable' => 138
		}
	},
	{#State 101
		ACTIONS => {
			"undef" => 105,
			'MY' => 164,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'OP01_QW' => 166,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'ListElement' => 176,
			'Variable' => 138,
			'WordScoped' => 111,
			'TypeInner' => 167,
			'Expression' => 141,
			'HashDereference' => 126,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 177
		}
	},
	{#State 102
		ACTIONS => {
			'LBRACE' => -208,
			'VARIABLE_SYMBOL' => 116,
			'MY' => 164
		},
		GOTOS => {
			'OPTIONAL-53' => 179,
			'Variable' => 180,
			'TypeInner' => 178
		}
	},
	{#State 103
		ACTIONS => {
			'LPAREN' => 181
		}
	},
	{#State 104
		ACTIONS => {
			'WORD' => 55,
			'WORD_SCOPED' => 54,
			'TYPE_INTEGER' => 56,
			'TYPE_FHREF' => 182
		},
		GOTOS => {
			'Type' => 183
		}
	},
	{#State 105
		DEFAULT => -135
	},
	{#State 106
		ACTIONS => {
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'MY' => 164,
			"undef" => 105,
			"]" => -190,
			"%{" => 102,
			'WORD' => 24,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 85,
			'OP01_QW' => 166,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'OPTIONAL-48' => 185,
			'ListElement' => 168,
			'Variable' => 138,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 170,
			'ListElements' => 184,
			'WordScoped' => 111,
			'TypeInner' => 167,
			'Expression' => 141,
			'HashDereference' => 126
		}
	},
	{#State 107
		ACTIONS => {
			'OP13_BITWISE_AND' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP03_MATH_INC_DEC' => 189,
			'OP18_TERNARY' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP04_MATH_POW' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 188,
			'OP09_BITWISE_SHIFT' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP08_STRING_CAT' => -137,
			'OP19_VARIABLE_ASSIGN' => 187,
			'OP02_METHOD_THINARROW' => 186
		}
	},
	{#State 108
		ACTIONS => {
			'WORD_UPPERCASE' => 191
		},
		GOTOS => {
			'LoopLabel' => 190
		}
	},
	{#State 109
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 195,
			'LBRACE' => -113,
			'STDOUT_STDERR' => 194,
			'OP05_LOGICAL_NEG' => -113,
			'LITERAL_STRING' => -113,
			'OP10_NAMED_UNARY' => -113,
			'LBRACKET' => -113,
			"undef" => -113,
			'MY' => -113,
			'WORD' => -113,
			"%{" => -113,
			'OP01_NAMED' => -113,
			'LPAREN' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'OP01_CLOSE' => -113,
			'OP01_OPEN' => -113,
			'WORD_UPPERCASE' => -113,
			'OP03_MATH_INC_DEC' => -113,
			"\@{" => -113,
			'OP01_QW' => -113,
			'WORD_SCOPED' => -113,
			'OP22_LOGICAL_NEG' => -113,
			'VARIABLE_SYMBOL' => -113,
			'LITERAL_NUMBER' => -113
		},
		GOTOS => {
			'OPTIONAL-33' => 192,
			'PAREN-32' => 193
		}
	},
	{#State 110
		DEFAULT => -150
	},
	{#State 111
		ACTIONS => {
			'LPAREN' => 197,
			'OP02_METHOD_THINARROW_NEW' => 198,
			'SCOPE' => 196
		}
	},
	{#State 112
		DEFAULT => -81
	},
	{#State 113
		ACTIONS => {
			"}" => 205,
			'VARIABLE_SYMBOL' => 116,
			"%{" => 102,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 114,
			'WORD' => 201
		},
		GOTOS => {
			'Variable' => 200,
			'VariableOrLiteralOrWord' => 202,
			'HashDereference' => 203,
			'HashEntry' => 199,
			'Literal' => 204
		}
	},
	{#State 114
		DEFAULT => -224
	},
	{#State 115
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111,
			'SubExpression' => 206,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138
		}
	},
	{#State 116
		DEFAULT => -170,
		GOTOS => {
			'STAR-44' => 207
		}
	},
	{#State 117
		ACTIONS => {
			'COLON' => 208
		}
	},
	{#State 118
		DEFAULT => -136
	},
	{#State 119
		DEFAULT => -138
	},
	{#State 120
		DEFAULT => -128
	},
	{#State 121
		ACTIONS => {
			"undef" => 105,
			'MY' => 164,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 166,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 170,
			'ListElements' => 209,
			'WordScoped' => 111,
			'TypeInner' => 167,
			'Expression' => 141,
			'HashDereference' => 126,
			'ListElement' => 168,
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120
		}
	},
	{#State 122
		ACTIONS => {
			"while" => 213,
			"for" => 214,
			"foreach" => 211
		},
		GOTOS => {
			'LoopWhile' => 210,
			'LoopFor' => 216,
			'LoopForEach' => 215,
			'Loop' => 212
		}
	},
	{#State 123
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			'MY' => 164,
			'LBRACKET' => -193
		},
		GOTOS => {
			'Variable' => 219,
			'OPTIONAL-49' => 218,
			'TypeInner' => 217
		}
	},
	{#State 124
		DEFAULT => -146
	},
	{#State 125
		ACTIONS => {
			'MY' => 220
		}
	},
	{#State 126
		DEFAULT => -141
	},
	{#State 127
		DEFAULT => -139
	},
	{#State 128
		DEFAULT => -151
	},
	{#State 129
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138,
			'WordScoped' => 111,
			'HashDereference' => 126,
			'Expression' => 141,
			'HashReference' => 99,
			'SubExpression' => 221,
			'ArrayDereference' => 127
		}
	},
	{#State 130
		ACTIONS => {
			"\$TYPED_" => 222
		}
	},
	{#State 131
		ACTIONS => {
			";" => 223
		}
	},
	{#State 132
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 224
		}
	},
	{#State 133
		DEFAULT => -46
	},
	{#State 134
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 225
		}
	},
	{#State 135
		DEFAULT => -44
	},
	{#State 136
		ACTIONS => {
			"our hashref \$properties" => 226,
			"use constant" => 41
		},
		GOTOS => {
			'Properties' => 227,
			'Constant' => 228
		}
	},
	{#State 137
		DEFAULT => -57
	},
	{#State 138
		ACTIONS => {
			'OP08_STRING_CAT' => -137,
			'OP02_METHOD_THINARROW' => 186,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP17_LIST_RANGE' => -137,
			";" => -137,
			"]" => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP04_MATH_POW' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP23_LOGICAL_AND' => -137,
			"}" => -137,
			'OP18_TERNARY' => -137,
			")" => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP03_MATH_INC_DEC' => 189
		}
	},
	{#State 139
		ACTIONS => {
			";" => -98,
			'OP16_LOGICAL_OR' => -98,
			"]" => -98,
			'OP08_MATH_ADD_SUB' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -98,
			'OP09_BITWISE_SHIFT' => 149,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP15_LOGICAL_AND' => -98,
			")" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			"}" => -98,
			'OP18_TERNARY' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => -98
		}
	},
	{#State 140
		ACTIONS => {
			'LPAREN' => 163
		}
	},
	{#State 141
		DEFAULT => -134
	},
	{#State 142
		ACTIONS => {
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 229,
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126
		}
	},
	{#State 143
		ACTIONS => {
			'OP21_LIST_COMMA' => -90,
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP16_LOGICAL_OR' => -90,
			";" => -90,
			"]" => -90,
			'OP08_STRING_CAT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP18_TERNARY' => -90,
			"}" => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			")" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP24_LOGICAL_OR_XOR' => -90
		}
	},
	{#State 144
		ACTIONS => {
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'HashReference' => 99,
			'SubExpression' => 230,
			'ArrayDereference' => 127,
			'WordScoped' => 111,
			'HashDereference' => 126,
			'Expression' => 141,
			'Variable' => 138,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118
		}
	},
	{#State 145
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 114
		},
		GOTOS => {
			'VariableOrLiteral' => 233,
			'Variable' => 232,
			'Literal' => 231
		}
	},
	{#State 146
		ACTIONS => {
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140
		},
		GOTOS => {
			'WordScoped' => 111,
			'HashDereference' => 126,
			'Expression' => 141,
			'HashReference' => 99,
			'SubExpression' => 234,
			'ArrayDereference' => 127,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Variable' => 138
		}
	},
	{#State 147
		ACTIONS => {
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84
		},
		GOTOS => {
			'HashReference' => 99,
			'SubExpression' => 235,
			'ArrayDereference' => 127,
			'WordScoped' => 111,
			'HashDereference' => 126,
			'Expression' => 141,
			'Variable' => 138,
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119
		}
	},
	{#State 148
		ACTIONS => {
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			"undef" => 105,
			'WORD' => 24,
			"%{" => 102,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116
		},
		GOTOS => {
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 236,
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126
		}
	},
	{#State 149
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'OP01_CLOSE' => 97,
			"undef" => 105,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'SubExpression' => 237,
			'HashReference' => 99,
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111,
			'Variable' => 138,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120
		}
	},
	{#State 150
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			"undef" => 105,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'SubExpression' => 238,
			'HashReference' => 99,
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111,
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120
		}
	},
	{#State 151
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'Variable' => 138,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'SubExpression' => 239,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111
		}
	},
	{#State 152
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_CLOSE' => 97,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'Variable' => 138,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'ArrayDereference' => 127,
			'SubExpression' => 240,
			'HashReference' => 99,
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111
		}
	},
	{#State 153
		ACTIONS => {
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24
		},
		GOTOS => {
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Variable' => 138,
			'WordScoped' => 111,
			'HashDereference' => 126,
			'Expression' => 141,
			'HashReference' => 99,
			'SubExpression' => 241,
			'ArrayDereference' => 127
		}
	},
	{#State 154
		ACTIONS => {
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'SubExpression' => 242,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111,
			'Variable' => 138,
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119
		}
	},
	{#State 155
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			'OP01_CLOSE' => 97,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'SubExpression' => 243,
			'HashReference' => 99,
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111,
			'Variable' => 138,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120
		}
	},
	{#State 156
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84
		},
		GOTOS => {
			'Variable' => 138,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'HashReference' => 99,
			'SubExpression' => 244,
			'ArrayDereference' => 127,
			'WordScoped' => 111,
			'HashDereference' => 126,
			'Expression' => 141
		}
	},
	{#State 157
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 245,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'Variable' => 138
		}
	},
	{#State 158
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 246
		}
	},
	{#State 159
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114
		},
		GOTOS => {
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138,
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111,
			'SubExpression' => 247,
			'ArrayDereference' => 127,
			'HashReference' => 99
		}
	},
	{#State 160
		ACTIONS => {
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116
		},
		GOTOS => {
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 248,
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126
		}
	},
	{#State 161
		DEFAULT => -87
	},
	{#State 162
		DEFAULT => -80
	},
	{#State 163
		ACTIONS => {
			")" => 249
		}
	},
	{#State 164
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 250
		}
	},
	{#State 165
		DEFAULT => -114
	},
	{#State 166
		ACTIONS => {
			'WORD' => 252
		},
		GOTOS => {
			'PLUS-47' => 251
		}
	},
	{#State 167
		ACTIONS => {
			'OP01_CLOSE' => 97,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105
		},
		GOTOS => {
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 253,
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126,
			'Variable' => 138,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120
		}
	},
	{#State 168
		DEFAULT => -182,
		GOTOS => {
			'STAR-46' => 254
		}
	},
	{#State 169
		ACTIONS => {
			")" => 255
		}
	},
	{#State 170
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP17_LIST_RANGE' => 157,
			'OP16_LOGICAL_OR' => 156,
			";" => -186,
			"]" => -186,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -186,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 149,
			'OP18_TERNARY' => 145,
			")" => -186,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP23_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146
		}
	},
	{#State 171
		DEFAULT => -86
	},
	{#State 172
		DEFAULT => -16
	},
	{#State 173
		ACTIONS => {
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP17_LIST_RANGE' => 157,
			'OP16_LOGICAL_OR' => 156,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 149,
			'OP18_TERNARY' => 145,
			")" => 256,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP23_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146
		}
	},
	{#State 174
		ACTIONS => {
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP01_QW' => 166,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 25,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'MY' => 164
		},
		GOTOS => {
			'Expression' => 141,
			'TypeInner' => 167,
			'HashDereference' => 126,
			'WordScoped' => 111,
			'ArrayDereference' => 127,
			'SubExpression' => 177,
			'HashReference' => 99,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'ListElement' => 257,
			'Variable' => 138
		}
	},
	{#State 175
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 258
		}
	},
	{#State 176
		ACTIONS => {
			'OP21_LIST_COMMA' => 259
		}
	},
	{#State 177
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP04_MATH_POW' => -83,
			'OP21_LIST_COMMA' => -186,
			'OP08_STRING_CAT' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP17_LIST_RANGE' => -83,
			";" => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP18_TERNARY' => -83,
			")" => -83,
			'OP14_BITWISE_OR_XOR' => -83
		}
	},
	{#State 178
		DEFAULT => -207
	},
	{#State 179
		ACTIONS => {
			'LBRACE' => 113
		},
		GOTOS => {
			'HashReference' => 260
		}
	},
	{#State 180
		ACTIONS => {
			"}" => 261
		}
	},
	{#State 181
		ACTIONS => {
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_CLOSE' => 97,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142
		},
		GOTOS => {
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 262,
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126,
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120
		}
	},
	{#State 182
		ACTIONS => {
			'FHREF_SYMBOL' => 263
		}
	},
	{#State 183
		ACTIONS => {
			'VARIABLE_SYMBOL' => 264
		}
	},
	{#State 184
		DEFAULT => -189
	},
	{#State 185
		ACTIONS => {
			"]" => 265
		}
	},
	{#State 186
		ACTIONS => {
			'LPAREN' => 266
		}
	},
	{#State 187
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'STDIN' => 268,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			"undef" => 105,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111,
			'SubExpression' => 269,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'Operator' => 120,
			'SubExpressionOrStdin' => 267,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138
		}
	},
	{#State 188
		ACTIONS => {
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 97,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'WordScoped' => 111,
			'HashDereference' => 126,
			'Expression' => 141,
			'HashReference' => 99,
			'SubExpression' => 270,
			'ArrayDereference' => 127,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Variable' => 138
		}
	},
	{#State 189
		DEFAULT => -88
	},
	{#State 190
		ACTIONS => {
			";" => 271
		}
	},
	{#State 191
		DEFAULT => -213
	},
	{#State 192
		ACTIONS => {
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'OP01_QW' => 166,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'MY' => 164,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84
		},
		GOTOS => {
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'ListElement' => 168,
			'Variable' => 138,
			'TypeInner' => 167,
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111,
			'ListElements' => 272,
			'ArrayDereference' => 127,
			'SubExpression' => 170,
			'HashReference' => 99
		}
	},
	{#State 193
		DEFAULT => -112
	},
	{#State 194
		DEFAULT => -111
	},
	{#State 195
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'OP01_QW' => 166,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			"undef" => 105,
			'MY' => 164,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Variable' => 138,
			'ListElement' => 168,
			'WordScoped' => 111,
			'ListElements' => 273,
			'HashDereference' => 126,
			'Expression' => 141,
			'TypeInner' => 167,
			'HashReference' => 99,
			'SubExpression' => 170,
			'ArrayDereference' => 127
		}
	},
	{#State 196
		ACTIONS => {
			'WORD_UPPERCASE' => 274
		}
	},
	{#State 197
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			")" => -125,
			'LITERAL_NUMBER' => 114,
			'OP01_QW' => 166,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'MY' => 164,
			"undef" => 105,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'Operator' => 120,
			'OPTIONAL-35' => 276,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138,
			'ListElement' => 168,
			'ListElements' => 275,
			'WordScoped' => 111,
			'HashDereference' => 126,
			'TypeInner' => 167,
			'Expression' => 141,
			'HashReference' => 99,
			'SubExpression' => 170,
			'ArrayDereference' => 127
		}
	},
	{#State 198
		ACTIONS => {
			")" => 277
		}
	},
	{#State 199
		DEFAULT => -204,
		GOTOS => {
			'STAR-52' => 278
		}
	},
	{#State 200
		DEFAULT => -221
	},
	{#State 201
		DEFAULT => -223
	},
	{#State 202
		ACTIONS => {
			'OP20_HASH_FATARROW' => 279
		}
	},
	{#State 203
		DEFAULT => -199
	},
	{#State 204
		DEFAULT => -222
	},
	{#State 205
		DEFAULT => -206
	},
	{#State 206
		ACTIONS => {
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP18_TERNARY' => 145,
			"}" => -108,
			'OP14_BITWISE_OR_XOR' => 152,
			")" => -108,
			'OP23_LOGICAL_AND' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP21_LIST_COMMA' => -108,
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 158,
			'OP08_MATH_ADD_SUB' => 155,
			";" => -108,
			"]" => -108,
			'OP16_LOGICAL_OR' => 156,
			'OP08_STRING_CAT' => 154
		}
	},
	{#State 207
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -171,
			'OP19_VARIABLE_ASSIGN_BY' => -171,
			'OP12_COMPARE_EQ_NE' => -171,
			'COLON' => -171,
			'OP15_LOGICAL_AND' => -171,
			'OP02_ARRAY_THINARROW' => 280,
			'OP04_MATH_POW' => -171,
			'OP21_LIST_COMMA' => -171,
			'OP02_METHOD_THINARROW' => -171,
			'OP19_VARIABLE_ASSIGN' => -171,
			'OP08_STRING_CAT' => -171,
			"]" => -171,
			";" => -171,
			'OP16_LOGICAL_OR' => -171,
			'OP08_MATH_ADD_SUB' => -171,
			'OP07_MATH_MULT_DIV_MOD' => -171,
			'OP06_REGEX_MATCH' => -171,
			'OP11_COMPARE_LT_GT' => -171,
			'OP17_LIST_RANGE' => -171,
			'OP20_HASH_FATARROW' => -171,
			'OP07_STRING_REPEAT' => -171,
			'OP03_MATH_INC_DEC' => -171,
			'OP13_BITWISE_AND' => -171,
			'OP24_LOGICAL_OR_XOR' => -171,
			'OP23_LOGICAL_AND' => -171,
			'OP02_HASH_THINARROW' => 282,
			")" => -171,
			'OP14_BITWISE_OR_XOR' => -171,
			"}" => -171,
			'OP18_TERNARY' => -171
		},
		GOTOS => {
			'VariableRetrieval' => 281
		}
	},
	{#State 208
		DEFAULT => -145
	},
	{#State 209
		ACTIONS => {
			";" => 283
		}
	},
	{#State 210
		DEFAULT => -162
	},
	{#State 211
		ACTIONS => {
			'MY' => 284
		}
	},
	{#State 212
		DEFAULT => -149
	},
	{#State 213
		ACTIONS => {
			'LPAREN' => 285
		}
	},
	{#State 214
		ACTIONS => {
			'MY' => 286
		}
	},
	{#State 215
		DEFAULT => -161
	},
	{#State 216
		DEFAULT => -160
	},
	{#State 217
		DEFAULT => -192
	},
	{#State 218
		ACTIONS => {
			'LBRACKET' => 106
		},
		GOTOS => {
			'ArrayReference' => 287
		}
	},
	{#State 219
		ACTIONS => {
			"}" => 288
		}
	},
	{#State 220
		ACTIONS => {
			'TYPE_FHREF' => 289
		}
	},
	{#State 221
		ACTIONS => {
			'OP18_TERNARY' => 145,
			")" => 290,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP23_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP17_LIST_RANGE' => 157,
			'OP16_LOGICAL_OR' => 156,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 149
		}
	},
	{#State 222
		ACTIONS => {
			'WORD_UPPERCASE' => 291
		}
	},
	{#State 223
		DEFAULT => -45
	},
	{#State 224
		ACTIONS => {
			"}" => 292,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 95,
			'OP01_NAMED_VOID_LPAREN' => 96,
			'OP01_CLOSE' => 97,
			'LPAREN' => 100,
			'OP01_NAMED' => 101,
			'OP10_NAMED_UNARY' => 84,
			"foreach" => -147,
			'LITERAL_STRING' => 85,
			"while" => -147,
			'OP19_LOOP_CONTROL_SCOLON' => 86,
			'OP05_LOGICAL_NEG' => 87,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 25,
			'OP01_NAMED_VOID' => 121,
			"\@{" => 123,
			'OP01_OPEN' => 125,
			"for" => -147,
			'OP05_MATH_NEG_LPAREN' => 129,
			"%{" => 102,
			'WORD' => 24,
			"if" => 103,
			"undef" => 105,
			'MY' => 104,
			'LBRACKET' => 106,
			'OP19_LOOP_CONTROL' => 108,
			'OP01_PRINT' => 109,
			'LBRACE' => 113
		},
		GOTOS => {
			'VariableModification' => 83,
			'Variable' => 107,
			'Statement' => 112,
			'SubExpression' => 89,
			'Conditional' => 88,
			'WordScoped' => 111,
			'OperatorVoid' => 110,
			'OPTIONAL-38' => 122,
			'Operation' => 293,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'LoopLabel' => 117,
			'HashReference' => 99,
			'VariableDeclaration' => 128,
			'ArrayDereference' => 127,
			'HashDereference' => 126,
			'PAREN-37' => 124,
			'Expression' => 94
		}
	},
	{#State 225
		ACTIONS => {
			'VARIABLE_SYMBOL' => 294
		}
	},
	{#State 226
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 295
		}
	},
	{#State 227
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 296
		}
	},
	{#State 228
		DEFAULT => -59
	},
	{#State 229
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP04_MATH_POW' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP08_STRING_CAT' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP17_LIST_RANGE' => -83,
			";" => -83,
			"]" => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP23_LOGICAL_AND' => -83,
			"}" => -83,
			'OP18_TERNARY' => -83,
			")" => -83,
			'OP14_BITWISE_OR_XOR' => -83
		}
	},
	{#State 230
		ACTIONS => {
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149,
			'OP21_LIST_COMMA' => -109,
			'OP04_MATH_POW' => 150,
			'OP08_STRING_CAT' => 154,
			'OP17_LIST_RANGE' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_MATH_ADD_SUB' => 155,
			";" => -109,
			"]" => -109,
			'OP16_LOGICAL_OR' => 156,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP23_LOGICAL_AND' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP18_TERNARY' => 145,
			"}" => -109,
			'OP14_BITWISE_OR_XOR' => 152,
			")" => -109
		}
	},
	{#State 231
		DEFAULT => -220
	},
	{#State 232
		DEFAULT => -219
	},
	{#State 233
		ACTIONS => {
			'COLON' => 297
		}
	},
	{#State 234
		ACTIONS => {
			'OP17_LIST_RANGE' => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP06_REGEX_MATCH' => 158,
			'OP08_MATH_ADD_SUB' => -93,
			";" => -93,
			"]" => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP08_STRING_CAT' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP18_TERNARY' => -93,
			"}" => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			")" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP07_STRING_REPEAT' => -93
		}
	},
	{#State 235
		ACTIONS => {
			"}" => -100,
			'OP18_TERNARY' => -100,
			")" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP07_STRING_REPEAT' => 146,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP17_LIST_RANGE' => -100,
			'OP16_LOGICAL_OR' => -100,
			";" => -100,
			"]" => -100,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => 149
		}
	},
	{#State 236
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP23_LOGICAL_AND' => -94,
			"}" => -94,
			'OP18_TERNARY' => -94,
			")" => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP07_STRING_REPEAT' => 146,
			'OP08_STRING_CAT' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => -94,
			'OP17_LIST_RANGE' => -94,
			"]" => -94,
			";" => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -94
		}
	},
	{#State 237
		ACTIONS => {
			'OP08_STRING_CAT' => 154,
			'OP08_MATH_ADD_SUB' => 155,
			'OP16_LOGICAL_OR' => -97,
			";" => -97,
			"]" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP04_MATH_POW' => 150,
			'OP23_LOGICAL_AND' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			")" => -97,
			'OP18_TERNARY' => -97,
			"}" => -97,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => -97
		}
	},
	{#State 238
		ACTIONS => {
			"}" => -89,
			'OP18_TERNARY' => -89,
			")" => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP06_REGEX_MATCH' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP17_LIST_RANGE' => -89,
			";" => -89,
			'OP16_LOGICAL_OR' => -89,
			"]" => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP08_STRING_CAT' => -89,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP09_BITWISE_SHIFT' => -89
		}
	},
	{#State 239
		ACTIONS => {
			")" => -110,
			'OP14_BITWISE_OR_XOR' => 152,
			"}" => -110,
			'OP18_TERNARY' => 145,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => 144,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			"]" => -110,
			";" => -110,
			'OP16_LOGICAL_OR' => 156,
			'OP08_MATH_ADD_SUB' => 155,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP17_LIST_RANGE' => 157,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -110,
			'OP09_BITWISE_SHIFT' => 149,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159
		}
	},
	{#State 240
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 149,
			'OP15_LOGICAL_AND' => -103,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP21_LIST_COMMA' => -103,
			'OP04_MATH_POW' => 150,
			'OP08_STRING_CAT' => 154,
			'OP08_MATH_ADD_SUB' => 155,
			";" => -103,
			'OP16_LOGICAL_OR' => -103,
			"]" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			'OP23_LOGICAL_AND' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			")" => -103,
			'OP18_TERNARY' => -103,
			"}" => -103
		}
	},
	{#State 241
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP23_LOGICAL_AND' => -102,
			"}" => -102,
			'OP18_TERNARY' => -102,
			")" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP13_BITWISE_AND' => -102,
			'OP07_STRING_REPEAT' => 146,
			'OP08_STRING_CAT' => 154,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP17_LIST_RANGE' => -102,
			";" => -102,
			'OP16_LOGICAL_OR' => -102,
			"]" => -102,
			'OP08_MATH_ADD_SUB' => 155,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => -102,
			'OP09_BITWISE_SHIFT' => 149,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -102
		}
	},
	{#State 242
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -96,
			'OP08_STRING_CAT' => -96,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => -96,
			'OP17_LIST_RANGE' => -96,
			";" => -96,
			'OP16_LOGICAL_OR' => -96,
			"]" => -96,
			'OP08_MATH_ADD_SUB' => 155,
			'OP13_BITWISE_AND' => -96,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP23_LOGICAL_AND' => -96,
			"}" => -96,
			'OP18_TERNARY' => -96,
			")" => -96,
			'OP14_BITWISE_OR_XOR' => -96
		}
	},
	{#State 243
		ACTIONS => {
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP23_LOGICAL_AND' => -95,
			")" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			"}" => -95,
			'OP18_TERNARY' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -95,
			'OP08_STRING_CAT' => -95,
			"]" => -95,
			";" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => -95,
			'OP17_LIST_RANGE' => -95
		}
	},
	{#State 244
		ACTIONS => {
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -105,
			'OP09_BITWISE_SHIFT' => 149,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159,
			"]" => -105,
			";" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP17_LIST_RANGE' => -105,
			'OP08_STRING_CAT' => 154,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			")" => -105,
			'OP14_BITWISE_OR_XOR' => 152,
			"}" => -105,
			'OP18_TERNARY' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP23_LOGICAL_AND' => -105
		}
	},
	{#State 245
		ACTIONS => {
			'OP18_TERNARY' => -106,
			"}" => -106,
			'OP14_BITWISE_OR_XOR' => 152,
			")" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP17_LIST_RANGE' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_MATH_ADD_SUB' => 155,
			";" => -106,
			'OP16_LOGICAL_OR' => 156,
			"]" => -106,
			'OP08_STRING_CAT' => 154,
			'OP21_LIST_COMMA' => -106,
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149
		}
	},
	{#State 246
		DEFAULT => -92
	},
	{#State 247
		ACTIONS => {
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			")" => -104,
			'OP14_BITWISE_OR_XOR' => 152,
			"}" => -104,
			'OP18_TERNARY' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -104,
			'OP09_BITWISE_SHIFT' => 149,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => -104,
			";" => -104,
			'OP16_LOGICAL_OR' => -104,
			"]" => -104,
			'OP08_MATH_ADD_SUB' => 155,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP17_LIST_RANGE' => -104,
			'OP08_STRING_CAT' => 154
		}
	},
	{#State 248
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => undef,
			'OP15_LOGICAL_AND' => -101,
			'OP09_BITWISE_SHIFT' => 149,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -101,
			'OP08_STRING_CAT' => 154,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP17_LIST_RANGE' => -101,
			";" => -101,
			"]" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP08_MATH_ADD_SUB' => 155,
			'OP13_BITWISE_AND' => -101,
			'OP07_STRING_REPEAT' => 146,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP23_LOGICAL_AND' => -101,
			"}" => -101,
			'OP18_TERNARY' => -101,
			")" => -101,
			'OP14_BITWISE_OR_XOR' => -101
		}
	},
	{#State 249
		DEFAULT => -130
	},
	{#State 250
		ACTIONS => {
			"\$TYPED_" => 298
		}
	},
	{#State 251
		ACTIONS => {
			'WORD' => 299,
			")" => 300
		}
	},
	{#State 252
		DEFAULT => -185
	},
	{#State 253
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 149,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -187,
			'OP08_STRING_CAT' => 154,
			";" => -187,
			"]" => -187,
			'OP16_LOGICAL_OR' => 156,
			'OP08_MATH_ADD_SUB' => 155,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP17_LIST_RANGE' => 157,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP23_LOGICAL_AND' => 144,
			")" => -187,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 145
		}
	},
	{#State 254
		ACTIONS => {
			'OP21_LIST_COMMA' => 301,
			")" => -183,
			";" => -183,
			"]" => -183
		},
		GOTOS => {
			'PAREN-45' => 302
		}
	},
	{#State 255
		ACTIONS => {
			";" => 303
		}
	},
	{#State 256
		DEFAULT => -142
	},
	{#State 257
		ACTIONS => {
			'OP21_LIST_COMMA' => 304
		}
	},
	{#State 258
		ACTIONS => {
			'MY' => 164,
			"undef" => 105,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 166,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 170,
			'WordScoped' => 111,
			'ListElements' => 305,
			'TypeInner' => 167,
			'Expression' => 141,
			'HashDereference' => 126,
			'ListElement' => 168,
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120
		}
	},
	{#State 259
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 166,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			"undef" => 105,
			'MY' => 164,
			'WORD' => 24,
			"%{" => 102,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106
		},
		GOTOS => {
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'ListElement' => 168,
			'Variable' => 138,
			'ListElements' => 306,
			'WordScoped' => 111,
			'Expression' => 141,
			'TypeInner' => 167,
			'HashDereference' => 126,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 170
		}
	},
	{#State 260
		ACTIONS => {
			"}" => 307
		}
	},
	{#State 261
		DEFAULT => -209
	},
	{#State 262
		ACTIONS => {
			'OP18_TERNARY' => 145,
			'OP14_BITWISE_OR_XOR' => 152,
			")" => 308,
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP17_LIST_RANGE' => 157,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP08_MATH_ADD_SUB' => 155,
			'OP16_LOGICAL_OR' => 156,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149
		}
	},
	{#State 263
		ACTIONS => {
			";" => 309
		}
	},
	{#State 264
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 310,
			";" => 311
		}
	},
	{#State 265
		DEFAULT => -191
	},
	{#State 266
		ACTIONS => {
			'MY' => 164,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'WORD_SCOPED' => 25,
			")" => -127,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'OP01_QW' => 166,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'WordScoped' => 111,
			'ListElements' => 313,
			'HashDereference' => 126,
			'Expression' => 141,
			'TypeInner' => 167,
			'HashReference' => 99,
			'OPTIONAL-36' => 312,
			'SubExpression' => 170,
			'ArrayDereference' => 127,
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138,
			'ListElement' => 168
		}
	},
	{#State 267
		ACTIONS => {
			";" => 314
		}
	},
	{#State 268
		DEFAULT => -144
	},
	{#State 269
		ACTIONS => {
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP18_TERNARY' => 145,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_MATH_ADD_SUB' => 155,
			";" => -143,
			'OP16_LOGICAL_OR' => 156,
			'OP08_STRING_CAT' => 154
		}
	},
	{#State 270
		ACTIONS => {
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP18_TERNARY' => 145,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP08_STRING_CAT' => 154,
			'OP17_LIST_RANGE' => 157,
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_MATH_ADD_SUB' => 155,
			";" => 315,
			'OP16_LOGICAL_OR' => 156,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149,
			'OP04_MATH_POW' => 150
		}
	},
	{#State 271
		DEFAULT => -123
	},
	{#State 272
		ACTIONS => {
			";" => 316
		}
	},
	{#State 273
		ACTIONS => {
			";" => 317
		}
	},
	{#State 274
		ACTIONS => {
			'LPAREN' => 318
		}
	},
	{#State 275
		DEFAULT => -124
	},
	{#State 276
		ACTIONS => {
			")" => 319
		}
	},
	{#State 277
		DEFAULT => -133
	},
	{#State 278
		ACTIONS => {
			"}" => 320,
			'OP21_LIST_COMMA' => 322
		},
		GOTOS => {
			'PAREN-51' => 321
		}
	},
	{#State 279
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -197,
			"\@{" => -197,
			'OP01_OPEN' => -197,
			'WORD_UPPERCASE' => -197,
			'LPAREN' => -197,
			'OP01_NAMED' => -197,
			'OP05_MATH_NEG_LPAREN' => -197,
			'OP01_CLOSE' => -197,
			'WORD_SCOPED' => -197,
			'LITERAL_NUMBER' => -197,
			'VARIABLE_SYMBOL' => -197,
			'OP22_LOGICAL_NEG' => -197,
			'LITERAL_STRING' => -197,
			'LBRACE' => -197,
			'OP05_LOGICAL_NEG' => -197,
			"undef" => -197,
			'MY' => 164,
			"%{" => -197,
			'WORD' => -197,
			'OP10_NAMED_UNARY' => -197,
			'LBRACKET' => -197
		},
		GOTOS => {
			'TypeInner' => 324,
			'OPTIONAL-50' => 323
		}
	},
	{#State 280
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114
		},
		GOTOS => {
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138,
			'WordScoped' => 111,
			'HashDereference' => 126,
			'Expression' => 141,
			'HashReference' => 99,
			'SubExpression' => 325,
			'ArrayDereference' => 127
		}
	},
	{#State 281
		DEFAULT => -169
	},
	{#State 282
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_CLOSE' => 97,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 327,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			'LITERAL_STRING' => 85,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'ArrayDereference' => 127,
			'SubExpression' => 326,
			'HashReference' => 99,
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111
		}
	},
	{#State 283
		DEFAULT => -120
	},
	{#State 284
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 328
		}
	},
	{#State 285
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25
		},
		GOTOS => {
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 329,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'Variable' => 138
		}
	},
	{#State 286
		ACTIONS => {
			'TYPE_INTEGER' => 330
		}
	},
	{#State 287
		ACTIONS => {
			"}" => 331
		}
	},
	{#State 288
		DEFAULT => -194
	},
	{#State 289
		ACTIONS => {
			'FHREF_SYMBOL' => 332
		}
	},
	{#State 290
		DEFAULT => -91
	},
	{#State 291
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 333
		}
	},
	{#State 292
		ACTIONS => {
			";" => 334
		}
	},
	{#State 293
		DEFAULT => -48
	},
	{#State 294
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 335
		}
	},
	{#State 295
		ACTIONS => {
			'LBRACE' => 336
		}
	},
	{#State 296
		ACTIONS => {
			"our" => 340,
			'LITERAL_NUMBER' => 339
		},
		GOTOS => {
			'Method' => 337,
			'MethodOrSubroutine' => 338,
			'Subroutine' => 341
		}
	},
	{#State 297
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'VariableOrLiteral' => 342,
			'Variable' => 232,
			'Literal' => 231
		}
	},
	{#State 298
		ACTIONS => {
			'WORD' => 343
		}
	},
	{#State 299
		DEFAULT => -184
	},
	{#State 300
		DEFAULT => -188
	},
	{#State 301
		ACTIONS => {
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_CLOSE' => 97,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'OP01_QW' => 166,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'MY' => 164,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84
		},
		GOTOS => {
			'ArrayDereference' => 127,
			'SubExpression' => 170,
			'HashReference' => 99,
			'TypeInner' => 167,
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111,
			'ListElement' => 344,
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120
		}
	},
	{#State 302
		DEFAULT => -181
	},
	{#State 303
		DEFAULT => -119
	},
	{#State 304
		ACTIONS => {
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'MY' => 164,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'WORD_SCOPED' => 25,
			'OP01_QW' => 166,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_NAMED' => 142
		},
		GOTOS => {
			'Variable' => 138,
			'ListElement' => 168,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'SubExpression' => 170,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'HashDereference' => 126,
			'TypeInner' => 167,
			'Expression' => 141,
			'ListElements' => 345,
			'WordScoped' => 111
		}
	},
	{#State 305
		ACTIONS => {
			")" => 346
		}
	},
	{#State 306
		ACTIONS => {
			";" => 347
		}
	},
	{#State 307
		DEFAULT => -210
	},
	{#State 308
		ACTIONS => {
			'LBRACE' => 348
		},
		GOTOS => {
			'CodeBlock' => 349
		}
	},
	{#State 309
		DEFAULT => -177
	},
	{#State 310
		ACTIONS => {
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'STDIN' => 268,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84
		},
		GOTOS => {
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111,
			'SubExpression' => 269,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'Operator' => 120,
			'SubExpressionOrStdin' => 350,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Variable' => 138
		}
	},
	{#State 311
		DEFAULT => -175
	},
	{#State 312
		ACTIONS => {
			")" => 351
		}
	},
	{#State 313
		DEFAULT => -126
	},
	{#State 314
		DEFAULT => -178
	},
	{#State 315
		DEFAULT => -179
	},
	{#State 316
		DEFAULT => -116
	},
	{#State 317
		DEFAULT => -117
	},
	{#State 318
		ACTIONS => {
			")" => 352
		}
	},
	{#State 319
		DEFAULT => -129
	},
	{#State 320
		DEFAULT => -205
	},
	{#State 321
		DEFAULT => -203
	},
	{#State 322
		ACTIONS => {
			'LITERAL_NUMBER' => 114,
			'WORD' => 201,
			"%{" => 102,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 116
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 202,
			'Variable' => 200,
			'HashEntry' => 353,
			'HashDereference' => 203,
			'Literal' => 204
		}
	},
	{#State 323
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Variable' => 138,
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'SubExpression' => 354,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111
		}
	},
	{#State 324
		DEFAULT => -196
	},
	{#State 325
		ACTIONS => {
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP18_TERNARY' => 145,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP08_MATH_ADD_SUB' => 155,
			"]" => 355,
			'OP16_LOGICAL_OR' => 156,
			'OP08_STRING_CAT' => 154
		}
	},
	{#State 326
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 152,
			"}" => 356,
			'OP18_TERNARY' => 145,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP23_LOGICAL_AND' => 144,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			'OP16_LOGICAL_OR' => 156,
			'OP08_MATH_ADD_SUB' => 155,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP17_LIST_RANGE' => 157,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP09_BITWISE_SHIFT' => 149,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159
		}
	},
	{#State 327
		ACTIONS => {
			'LPAREN' => -211,
			'OP02_METHOD_THINARROW_NEW' => -211,
			'SCOPE' => -211,
			"}" => 357
		}
	},
	{#State 328
		ACTIONS => {
			'VARIABLE_SYMBOL' => 358
		}
	},
	{#State 329
		ACTIONS => {
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149,
			'OP17_LIST_RANGE' => 157,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_MATH_ADD_SUB' => 155,
			'OP16_LOGICAL_OR' => 156,
			'OP08_STRING_CAT' => 154,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146,
			'OP18_TERNARY' => 145,
			'OP14_BITWISE_OR_XOR' => 152,
			")" => 359,
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151
		}
	},
	{#State 330
		ACTIONS => {
			'VARIABLE_SYMBOL' => 360
		}
	},
	{#State 331
		DEFAULT => -195
	},
	{#State 332
		ACTIONS => {
			'OP21_LIST_COMMA' => 361
		}
	},
	{#State 333
		DEFAULT => -218
	},
	{#State 334
		DEFAULT => -50
	},
	{#State 335
		ACTIONS => {
			'OP21_LIST_COMMA' => 363,
			")" => 362
		},
		GOTOS => {
			'PAREN-20' => 364
		}
	},
	{#State 336
		ACTIONS => {
			'WORD' => 365,
			"%{" => 102,
			"}" => 368
		},
		GOTOS => {
			'HashDereference' => 366,
			'HashEntryTyped' => 367
		}
	},
	{#State 337
		DEFAULT => -78
	},
	{#State 338
		DEFAULT => -61
	},
	{#State 339
		ACTIONS => {
			";" => 369
		}
	},
	{#State 340
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD' => 55,
			'WORD_SCOPED' => 54,
			'TYPE_METHOD' => 370
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 341
		DEFAULT => -79
	},
	{#State 342
		DEFAULT => -107
	},
	{#State 343
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 344
		DEFAULT => -180
	},
	{#State 345
		ACTIONS => {
			")" => 372
		}
	},
	{#State 346
		DEFAULT => -82
	},
	{#State 347
		DEFAULT => -121
	},
	{#State 348
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 86,
			"while" => -147,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			"foreach" => -147,
			'OP10_NAMED_UNARY' => 84,
			'OP01_NAMED_VOID_LPAREN' => 96,
			'WORD_UPPERCASE' => 95,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_NAMED' => 101,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP01_PRINT' => 109,
			'LBRACE' => 113,
			'MY' => 104,
			"undef" => 105,
			"if" => 103,
			"%{" => 102,
			'WORD' => 24,
			'OP19_LOOP_CONTROL' => 108,
			'LBRACKET' => 106,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP05_MATH_NEG_LPAREN' => 129,
			"for" => -147,
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'OP01_NAMED_VOID' => 121
		},
		GOTOS => {
			'VariableModification' => 83,
			'Variable' => 107,
			'WordScoped' => 111,
			'OperatorVoid' => 110,
			'Statement' => 112,
			'SubExpression' => 89,
			'Conditional' => 88,
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'LoopLabel' => 117,
			'OPTIONAL-38' => 122,
			'Operation' => 374,
			'HashDereference' => 126,
			'Expression' => 94,
			'PAREN-37' => 124,
			'HashReference' => 99,
			'VariableDeclaration' => 128,
			'PLUS-43' => 373,
			'ArrayDereference' => 127
		}
	},
	{#State 349
		DEFAULT => -155,
		GOTOS => {
			'STAR-40' => 375
		}
	},
	{#State 350
		ACTIONS => {
			";" => 376
		}
	},
	{#State 351
		DEFAULT => -132
	},
	{#State 352
		DEFAULT => -131
	},
	{#State 353
		DEFAULT => -202
	},
	{#State 354
		ACTIONS => {
			'OP17_LIST_RANGE' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147,
			'OP08_MATH_ADD_SUB' => 155,
			'OP16_LOGICAL_OR' => 156,
			'OP08_STRING_CAT' => 154,
			'OP21_LIST_COMMA' => -198,
			'OP04_MATH_POW' => 150,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP09_BITWISE_SHIFT' => 149,
			'OP18_TERNARY' => 145,
			"}" => -198,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146
		}
	},
	{#State 355
		DEFAULT => -172
	},
	{#State 356
		DEFAULT => -173
	},
	{#State 357
		DEFAULT => -174
	},
	{#State 358
		ACTIONS => {
			'LPAREN' => 377
		}
	},
	{#State 359
		ACTIONS => {
			'LBRACE' => 348
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 360
		ACTIONS => {
			'LPAREN' => 379
		}
	},
	{#State 361
		ACTIONS => {
			'LITERAL_STRING' => 380
		}
	},
	{#State 362
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 381
		}
	},
	{#State 363
		ACTIONS => {
			'MY' => 382
		}
	},
	{#State 364
		DEFAULT => -52
	},
	{#State 365
		ACTIONS => {
			'OP20_HASH_FATARROW' => 383
		}
	},
	{#State 366
		DEFAULT => -201
	},
	{#State 367
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 384
		}
	},
	{#State 368
		ACTIONS => {
			";" => 385
		}
	},
	{#State 369
		DEFAULT => -63
	},
	{#State 370
		ACTIONS => {
			'VARIABLE_SYMBOL' => 386
		}
	},
	{#State 371
		DEFAULT => -217
	},
	{#State 372
		DEFAULT => -84
	},
	{#State 373
		ACTIONS => {
			'WORD_SCOPED' => 25,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'OP01_NAMED_VOID' => 121,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP05_MATH_NEG_LPAREN' => 129,
			"for" => -147,
			'MY' => 104,
			"undef" => 105,
			"if" => 103,
			"%{" => 102,
			'WORD' => 24,
			'OP19_LOOP_CONTROL' => 108,
			'LBRACKET' => 106,
			'OP01_PRINT' => 109,
			'LBRACE' => 113,
			"}" => 388,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP01_NAMED_VOID_LPAREN' => 96,
			'WORD_UPPERCASE' => 95,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_NAMED' => 101,
			'LPAREN' => 100,
			'OP01_CLOSE' => 97,
			"foreach" => -147,
			'OP10_NAMED_UNARY' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 86,
			"while" => -147,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87
		},
		GOTOS => {
			'VariableModification' => 83,
			'Variable' => 107,
			'Statement' => 112,
			'Conditional' => 88,
			'SubExpression' => 89,
			'OperatorVoid' => 110,
			'WordScoped' => 111,
			'Operation' => 387,
			'OPTIONAL-38' => 122,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'LoopLabel' => 117,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'VariableDeclaration' => 128,
			'Expression' => 94,
			'PAREN-37' => 124,
			'HashDereference' => 126
		}
	},
	{#State 374
		DEFAULT => -167
	},
	{#State 375
		ACTIONS => {
			'OP01_NAMED' => -158,
			'LPAREN' => -158,
			'OP01_CLOSE' => -158,
			'OP01_NAMED_VOID_LPAREN' => -158,
			'OP03_MATH_INC_DEC' => -158,
			'WORD_UPPERCASE' => -158,
			"}" => -158,
			'OP01_NAMED_VOID_SCOLON' => -158,
			'OP05_LOGICAL_NEG' => -158,
			'OP19_LOOP_CONTROL_SCOLON' => -158,
			'LITERAL_STRING' => -158,
			"while" => -158,
			'OP10_NAMED_UNARY' => -158,
			"foreach" => -158,
			"else" => 393,
			'OP05_MATH_NEG_LPAREN' => -158,
			"for" => -158,
			"\@{" => -158,
			'OP01_OPEN' => -158,
			'OP01_NAMED_VOID' => -158,
			'WORD_SCOPED' => -158,
			"elsif" => 390,
			'LITERAL_NUMBER' => -158,
			'VARIABLE_SYMBOL' => -158,
			'OP22_LOGICAL_NEG' => -158,
			'LBRACE' => -158,
			'OP01_PRINT' => -158,
			'OP19_LOOP_CONTROL' => -158,
			'LBRACKET' => -158,
			'' => -158,
			'MY' => -158,
			"undef" => -158,
			"%{" => -158,
			'WORD' => -158,
			"if" => -158
		},
		GOTOS => {
			'PAREN-39' => 391,
			'PAREN-41' => 392,
			'OPTIONAL-42' => 389
		}
	},
	{#State 376
		DEFAULT => -176
	},
	{#State 377
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'MY' => 164,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 142,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 25,
			'OP01_QW' => 166
		},
		GOTOS => {
			'TypeInner' => 167,
			'Expression' => 141,
			'HashDereference' => 126,
			'ListElements' => 394,
			'WordScoped' => 111,
			'ArrayDereference' => 127,
			'SubExpression' => 170,
			'HashReference' => 99,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'ListElement' => 168,
			'Variable' => 138
		}
	},
	{#State 378
		DEFAULT => -165
	},
	{#State 379
		ACTIONS => {
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'HashDereference' => 126,
			'Expression' => 141,
			'WordScoped' => 111,
			'SubExpression' => 395,
			'ArrayDereference' => 127,
			'HashReference' => 99,
			'Operator' => 120,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Variable' => 138
		}
	},
	{#State 380
		ACTIONS => {
			'OP21_LIST_COMMA' => 396
		}
	},
	{#State 381
		ACTIONS => {
			"\@_;" => 397
		}
	},
	{#State 382
		ACTIONS => {
			'WORD_SCOPED' => 54,
			'WORD' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 398
		}
	},
	{#State 383
		ACTIONS => {
			'MY' => 164
		},
		GOTOS => {
			'TypeInner' => 399
		}
	},
	{#State 384
		ACTIONS => {
			'OP21_LIST_COMMA' => 401,
			"}" => 400
		},
		GOTOS => {
			'PAREN-26' => 402
		}
	},
	{#State 385
		DEFAULT => -68
	},
	{#State 386
		ACTIONS => {
			"= sub {" => 403
		}
	},
	{#State 387
		DEFAULT => -166
	},
	{#State 388
		DEFAULT => -168
	},
	{#State 389
		DEFAULT => -159
	},
	{#State 390
		ACTIONS => {
			'LPAREN' => 404
		}
	},
	{#State 391
		DEFAULT => -154
	},
	{#State 392
		DEFAULT => -157
	},
	{#State 393
		ACTIONS => {
			'LBRACE' => 348
		},
		GOTOS => {
			'CodeBlock' => 405
		}
	},
	{#State 394
		ACTIONS => {
			")" => 406
		}
	},
	{#State 395
		ACTIONS => {
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 145,
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			'OP08_STRING_CAT' => 154,
			'OP08_MATH_ADD_SUB' => 155,
			'OP16_LOGICAL_OR' => 156,
			'OP17_LIST_RANGE' => 407,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP09_BITWISE_SHIFT' => 149,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP04_MATH_POW' => 150
		}
	},
	{#State 396
		ACTIONS => {
			"\@{" => 123,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP01_CLOSE' => 97,
			'OP01_NAMED' => 142,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LITERAL_NUMBER' => 114,
			'VARIABLE_SYMBOL' => 116,
			'OP22_LOGICAL_NEG' => 115,
			'WORD_SCOPED' => 25,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84
		},
		GOTOS => {
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111,
			'ArrayDereference' => 127,
			'SubExpression' => 408,
			'HashReference' => 99,
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'Variable' => 138
		}
	},
	{#State 397
		DEFAULT => -54
	},
	{#State 398
		ACTIONS => {
			'VARIABLE_SYMBOL' => 409
		}
	},
	{#State 399
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			'OP01_CLOSE' => 97,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'WORD_UPPERCASE' => 140,
			'OP01_OPEN' => 125,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 87,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 84,
			'LBRACKET' => 106,
			"undef" => 105,
			"%{" => 102,
			'WORD' => 24
		},
		GOTOS => {
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 410,
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126
		}
	},
	{#State 400
		ACTIONS => {
			";" => 411
		}
	},
	{#State 401
		ACTIONS => {
			"%{" => 102,
			'WORD' => 365
		},
		GOTOS => {
			'HashEntryTyped' => 412,
			'HashDereference' => 366
		}
	},
	{#State 402
		DEFAULT => -65
	},
	{#State 403
		ACTIONS => {
			'OP01_NAMED_VOID' => -70,
			'WORD_SCOPED' => -70,
			'LITERAL_NUMBER' => -70,
			'OP22_LOGICAL_NEG' => -70,
			'VARIABLE_SYMBOL' => -70,
			'OP05_MATH_NEG_LPAREN' => -70,
			"for" => -70,
			"\@{" => -70,
			'OP01_OPEN' => -70,
			'OP19_LOOP_CONTROL' => -70,
			'LBRACKET' => -70,
			"undef" => -70,
			'MY' => -70,
			'WORD' => -70,
			"%{" => -70,
			"if" => -70,
			'LBRACE' => -70,
			'OP01_PRINT' => -70,
			"}" => -70,
			'OP01_NAMED_VOID_SCOLON' => -70,
			'LPAREN' => -70,
			'OP01_NAMED' => -70,
			'OP01_CLOSE' => -70,
			'OP01_NAMED_VOID_LPAREN' => -70,
			'OP03_MATH_INC_DEC' => -70,
			'WORD_UPPERCASE' => -70,
			'OP10_NAMED_UNARY' => -70,
			"foreach" => -70,
			'OP05_LOGICAL_NEG' => -70,
			'LPAREN_MY' => 415,
			'OP19_LOOP_CONTROL_SCOLON' => -70,
			'LITERAL_STRING' => -70,
			"while" => -70
		},
		GOTOS => {
			'MethodArguments' => 414,
			'OPTIONAL-28' => 413
		}
	},
	{#State 404
		ACTIONS => {
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'WORD_SCOPED' => 25,
			'OP01_CLOSE' => 97,
			'LPAREN' => 100,
			'OP05_MATH_NEG_LPAREN' => 129,
			'OP01_NAMED' => 142,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'WORD' => 24,
			"%{" => 102,
			"undef" => 105,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Literal' => 118,
			'ArrayReference' => 119,
			'Operator' => 120,
			'Variable' => 138,
			'WordScoped' => 111,
			'Expression' => 141,
			'HashDereference' => 126,
			'HashReference' => 99,
			'ArrayDereference' => 127,
			'SubExpression' => 416
		}
	},
	{#State 405
		DEFAULT => -156
	},
	{#State 406
		ACTIONS => {
			'LBRACE' => 348
		},
		GOTOS => {
			'CodeBlock' => 417
		}
	},
	{#State 407
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'LITERAL_NUMBER' => 114,
			'WORD_SCOPED' => 25,
			'OP01_OPEN' => 125,
			'WORD_UPPERCASE' => 140,
			'OP03_MATH_INC_DEC' => 93,
			"\@{" => 123,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 129,
			'LPAREN' => 100,
			'OP01_NAMED' => 142,
			"%{" => 102,
			'WORD' => 24,
			"undef" => 105,
			'LBRACKET' => 106,
			'OP10_NAMED_UNARY' => 84,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 87,
			'LBRACE' => 113
		},
		GOTOS => {
			'Variable' => 138,
			'ArrayReference' => 119,
			'Literal' => 118,
			'Operator' => 120,
			'ArrayDereference' => 127,
			'SubExpression' => 418,
			'HashReference' => 99,
			'Expression' => 141,
			'HashDereference' => 126,
			'WordScoped' => 111
		}
	},
	{#State 408
		ACTIONS => {
			'OP08_STRING_CAT' => 154,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP11_COMPARE_LT_GT' => 147,
			'OP17_LIST_RANGE' => 157,
			";" => -85,
			'OP16_LOGICAL_OR' => 156,
			"]" => -85,
			'OP08_MATH_ADD_SUB' => 155,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 149,
			'OP04_MATH_POW' => 150,
			'OP21_LIST_COMMA' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP23_LOGICAL_AND' => -85,
			"}" => -85,
			'OP18_TERNARY' => 145,
			")" => -85,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146
		}
	},
	{#State 409
		DEFAULT => -51
	},
	{#State 410
		ACTIONS => {
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			'OP23_LOGICAL_AND' => 144,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => 145,
			"}" => -200,
			'OP09_BITWISE_SHIFT' => 149,
			'OP15_LOGICAL_AND' => 159,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP21_LIST_COMMA' => -200,
			'OP04_MATH_POW' => 150,
			'OP08_STRING_CAT' => 154,
			'OP08_MATH_ADD_SUB' => 155,
			'OP16_LOGICAL_OR' => 156,
			'OP17_LIST_RANGE' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP11_COMPARE_LT_GT' => 147
		}
	},
	{#State 411
		DEFAULT => -67
	},
	{#State 412
		DEFAULT => -64
	},
	{#State 413
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 419
		}
	},
	{#State 414
		DEFAULT => -69
	},
	{#State 415
		ACTIONS => {
			'TYPE_SELF' => 420
		}
	},
	{#State 416
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 147,
			'OP06_REGEX_MATCH' => 158,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP17_LIST_RANGE' => 157,
			'OP16_LOGICAL_OR' => 156,
			'OP08_MATH_ADD_SUB' => 155,
			'OP08_STRING_CAT' => 154,
			'OP04_MATH_POW' => 150,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP09_BITWISE_SHIFT' => 149,
			'OP18_TERNARY' => 145,
			")" => 421,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP24_LOGICAL_OR_XOR' => 151,
			'OP23_LOGICAL_AND' => 144,
			'OP13_BITWISE_AND' => 153,
			'OP07_STRING_REPEAT' => 146
		}
	},
	{#State 417
		DEFAULT => -164
	},
	{#State 418
		ACTIONS => {
			'OP07_STRING_REPEAT' => 146,
			'OP13_BITWISE_AND' => 153,
			")" => 422,
			'OP14_BITWISE_OR_XOR' => 152,
			'OP18_TERNARY' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP04_MATH_POW' => 150,
			'OP09_BITWISE_SHIFT' => 149,
			'OP12_COMPARE_EQ_NE' => 160,
			'OP15_LOGICAL_AND' => 159,
			'OP16_LOGICAL_OR' => 156,
			'OP08_MATH_ADD_SUB' => 155,
			'OP11_COMPARE_LT_GT' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 148,
			'OP06_REGEX_MATCH' => 158,
			'OP17_LIST_RANGE' => undef,
			'OP08_STRING_CAT' => 154
		}
	},
	{#State 419
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 86,
			'LITERAL_STRING' => 85,
			"while" => -147,
			'OP05_LOGICAL_NEG' => 87,
			'OP10_NAMED_UNARY' => 84,
			"foreach" => -147,
			'OP01_NAMED_VOID_LPAREN' => 96,
			'OP03_MATH_INC_DEC' => 93,
			'WORD_UPPERCASE' => 95,
			'LPAREN' => 100,
			'OP01_NAMED' => 101,
			'OP01_CLOSE' => 97,
			"}" => 424,
			'OP01_NAMED_VOID_SCOLON' => 90,
			'OP01_PRINT' => 109,
			'LBRACE' => 113,
			"undef" => 105,
			'MY' => 104,
			'WORD' => 24,
			"%{" => 102,
			"if" => 103,
			'OP19_LOOP_CONTROL' => 108,
			'LBRACKET' => 106,
			"\@{" => 123,
			'OP01_OPEN' => 125,
			'OP05_MATH_NEG_LPAREN' => 129,
			"for" => -147,
			'WORD_SCOPED' => 25,
			'LITERAL_NUMBER' => 114,
			'OP22_LOGICAL_NEG' => 115,
			'VARIABLE_SYMBOL' => 116,
			'OP01_NAMED_VOID' => 121
		},
		GOTOS => {
			'OPTIONAL-38' => 122,
			'Operation' => 423,
			'Operator' => 120,
			'ArrayReference' => 119,
			'Literal' => 118,
			'LoopLabel' => 117,
			'HashReference' => 99,
			'VariableDeclaration' => 128,
			'ArrayDereference' => 127,
			'HashDereference' => 126,
			'Expression' => 94,
			'PAREN-37' => 124,
			'VariableModification' => 83,
			'Variable' => 107,
			'Statement' => 112,
			'SubExpression' => 89,
			'Conditional' => 88,
			'WordScoped' => 111,
			'OperatorVoid' => 110
		}
	},
	{#State 420
		DEFAULT => -76,
		GOTOS => {
			'STAR-31' => 425
		}
	},
	{#State 421
		ACTIONS => {
			'LBRACE' => 348
		},
		GOTOS => {
			'CodeBlock' => 426
		}
	},
	{#State 422
		ACTIONS => {
			'LBRACE' => 348
		},
		GOTOS => {
			'CodeBlock' => 427
		}
	},
	{#State 423
		DEFAULT => -71
	},
	{#State 424
		ACTIONS => {
			";" => 428
		}
	},
	{#State 425
		ACTIONS => {
			")" => 430,
			'OP21_LIST_COMMA' => 431
		},
		GOTOS => {
			'PAREN-30' => 429
		}
	},
	{#State 426
		DEFAULT => -153
	},
	{#State 427
		DEFAULT => -163
	},
	{#State 428
		DEFAULT => -73
	},
	{#State 429
		DEFAULT => -75
	},
	{#State 430
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 432
		}
	},
	{#State 431
		ACTIONS => {
			'MY' => 433
		}
	},
	{#State 432
		ACTIONS => {
			"\@_;" => 434
		}
	},
	{#State 433
		ACTIONS => {
			'WORD' => 55,
			'WORD_SCOPED' => 54,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 435
		}
	},
	{#State 434
		DEFAULT => -77
	},
	{#State 435
		ACTIONS => {
			'VARIABLE_SYMBOL' => 436
		}
	},
	{#State 436
		DEFAULT => -74
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5948 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5959 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5966 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5973 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5980 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5994 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6001 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6008 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6022 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6029 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6036 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6043 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6068 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6075 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6082 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6115 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6122 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6143 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6150 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6157 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6164 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6171 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6182 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6189 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6196 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6207 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6214 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6221 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6232 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6239 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6246 lib/RPerl/Grammar.pm
	],
	[#Rule Include_43
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6257 lib/RPerl/Grammar.pm
	],
	[#Rule Include_44
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_45
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6279 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6286 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6293 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6307 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_50
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6318 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6325 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6332 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6339 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_54
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6350 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6357 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6364 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6371 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6392 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6399 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6406 lib/RPerl/Grammar.pm
	],
	[#Rule Class_63
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6424 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6431 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6438 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_67
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6449 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_68
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6460 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 1,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6467 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6474 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6481 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule Method_73
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 4,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6506 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6513 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6520 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_77
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_78
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_79
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6553 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6564 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6575 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6586 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6597 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6608 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6619 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6630 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6641 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6652 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6663 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6674 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6685 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6696 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6707 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6718 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6729 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6740 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6762 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6773 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6784 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6795 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6828 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6839 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 177 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6929 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6940 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6951 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6962 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6995 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7017 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7031 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7038 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7056 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7067 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7078 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7111 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7188 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7199 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7210 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_143
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7221 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_144
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7232 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7239 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7246 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7297 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7308 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 5,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7336 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7343 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_159
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_160
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_163
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_164
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_165
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7434 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7441 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_168
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7452 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7459 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7466 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_171
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7477 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_172
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7488 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_173
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7499 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7510 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_175
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7521 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_176
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7532 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_177
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7543 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_178
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7554 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_179
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7565 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7572 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7579 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7586 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_183
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7597 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 2,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7604 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_186
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7622 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7633 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7644 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7651 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7658 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_191
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7669 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7676 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7683 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_194
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7694 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_195
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7712 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7719 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_198
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7730 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_199
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7741 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_200
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7752 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_201
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7763 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7784 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_205
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7795 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_206
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7806 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7813 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7820 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_209
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7831 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_210
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7842 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_211
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_212
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7875 lib/RPerl/Grammar.pm
	],
	[#Rule Type_214
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule Type_215
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule Type_216
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_217
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_218
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_219
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7941 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_220
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_221
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7963 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_222
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7974 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_223
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7985 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_224
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7996 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_225
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8007 lib/RPerl/Grammar.pm
	]
],
#line 8010 lib/RPerl/Grammar.pm
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
         'Literal_224', 
         'Literal_225', );
  $self;
}

#line 217 "lib/RPerl/Grammar.eyp"


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
Program_18 => 'RPerl::CompileUnit::Program',                                # Program -> SHEBANG USE_RPERL OPTIONAL-3 Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
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
Variable_171 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VARIABLE_SYMBOL STAR-42
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
Literal_224 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_225 => 'RPerl::Operation::Expression::SubExpression::Literal::String'                   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8404 lib/RPerl/Grammar.pm



1;
