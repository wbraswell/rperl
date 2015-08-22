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
    our $VERSION = 0.001_810;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\$TYPED_|\=\ sub\ \{|foreach|undef|while|elsif|else|our|for|\@_\;|\%\{|if|\@\{|\)|\}|\]|\;)}gc and return ($1, $1);

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
      /\G(\*|\/|\%|sse_mul|sse_div)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(x)\s/gc and return ('OP07_STRING_REPEAT', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->new\()/gc and return ('OP02_METHOD_THINARROW_NEW', $1);
      /\G(->[a-zA-Z]\w*)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LPAREN', $1);
      /\G(\+|-|sse_add|sse_sub)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<=|>=|<|>|lt|gt|le|ge)\s/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print|printf)\s/gc and return ('OP01_PRINT', $1);
      /\G(croak;|die;|exit;|return;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(croak\(|exit\(|return\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(croak|die|exit|return)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\()/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|keys|values|sort|length|split|join|fakebuiltin)\s/gc and return ('OP01_NAMED', $1);
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
  [ 'SubExpressionOrVarMod_145' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_146' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'PAREN-37' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'OPTIONAL-38', 'Loop' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_154' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [ 'STAR-40', 'PAREN-39' ], 0 ],
  [ '_STAR_LIST' => 'STAR-40', [  ], 0 ],
  [ '_PAREN' => 'PAREN-41', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [ 'PAREN-41' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-42', [  ], 0 ],
  [ 'Conditional_161' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-40', 'OPTIONAL-42' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_163' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_164' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_165' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_166' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpression', ';', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'SubExpression', ';', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_167' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_168' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'PLUS-43', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'Operation' ], 0 ],
  [ 'CodeBlock_171' => 'CodeBlock', [ 'LBRACE', 'PLUS-43', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'Variable_174' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-44' ], 0 ],
  [ 'VariableRetrieval_175' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_176' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_178' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_179' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_182' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin' ], 0 ],
  [ 'VariableModification_183' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'ListElements_187' => 'ListElements', [ 'ListElement', 'STAR-46' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-47', [ 'PLUS-47', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-47', [ 'WORD' ], 0 ],
  [ 'ListElement_190' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_191' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_192' => 'ListElement', [ 'OP01_QW', 'PLUS-47', ')' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'ArrayReference_195' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-48', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'ArrayDereference_198' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_199' => 'ArrayDereference', [ '@{', 'OPTIONAL-49', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashEntry_202' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-50', 'SubExpression' ], 0 ],
  [ 'HashEntry_203' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryTyped_204' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_205' => 'HashEntryTyped', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'HashReference_209' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-52', '}' ], 0 ],
  [ 'HashReference_210' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [  ], 0 ],
  [ 'HashDereference_213' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_214' => 'HashDereference', [ '%{', 'OPTIONAL-53', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_215' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_216' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_217' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_218' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_219' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_220' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_221' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_222' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_223' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_224' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_225' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_226' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_227' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'VariableSymbolOrSelf_228' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_229' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_230' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_231' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'SubExpressionOrVarMod_145' => 145,
  'SubExpressionOrVarMod_146' => 146,
  '_PAREN' => 147,
  '_OPTIONAL' => 148,
  '_OPTIONAL' => 149,
  'Statement_150' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  'Statement_153' => 153,
  'Statement_154' => 154,
  '_PAREN' => 155,
  '_STAR_LIST' => 156,
  '_STAR_LIST' => 157,
  '_PAREN' => 158,
  '_OPTIONAL' => 159,
  '_OPTIONAL' => 160,
  'Conditional_161' => 161,
  'Loop_162' => 162,
  'Loop_163' => 163,
  'Loop_164' => 164,
  'LoopFor_165' => 165,
  'LoopFor_166' => 166,
  'LoopForEach_167' => 167,
  'LoopWhile_168' => 168,
  '_PLUS_LIST' => 169,
  '_PLUS_LIST' => 170,
  'CodeBlock_171' => 171,
  '_STAR_LIST' => 172,
  '_STAR_LIST' => 173,
  'Variable_174' => 174,
  'VariableRetrieval_175' => 175,
  'VariableRetrieval_176' => 176,
  'VariableRetrieval_177' => 177,
  'VariableDeclaration_178' => 178,
  'VariableDeclaration_179' => 179,
  'VariableDeclaration_180' => 180,
  'VariableDeclaration_181' => 181,
  'VariableModification_182' => 182,
  'VariableModification_183' => 183,
  '_PAREN' => 184,
  '_STAR_LIST' => 185,
  '_STAR_LIST' => 186,
  'ListElements_187' => 187,
  '_PLUS_LIST' => 188,
  '_PLUS_LIST' => 189,
  'ListElement_190' => 190,
  'ListElement_191' => 191,
  'ListElement_192' => 192,
  '_OPTIONAL' => 193,
  '_OPTIONAL' => 194,
  'ArrayReference_195' => 195,
  '_OPTIONAL' => 196,
  '_OPTIONAL' => 197,
  'ArrayDereference_198' => 198,
  'ArrayDereference_199' => 199,
  '_OPTIONAL' => 200,
  '_OPTIONAL' => 201,
  'HashEntry_202' => 202,
  'HashEntry_203' => 203,
  'HashEntryTyped_204' => 204,
  'HashEntryTyped_205' => 205,
  '_PAREN' => 206,
  '_STAR_LIST' => 207,
  '_STAR_LIST' => 208,
  'HashReference_209' => 209,
  'HashReference_210' => 210,
  '_OPTIONAL' => 211,
  '_OPTIONAL' => 212,
  'HashDereference_213' => 213,
  'HashDereference_214' => 214,
  'WordScoped_215' => 215,
  'WordScoped_216' => 216,
  'LoopLabel_217' => 217,
  'Type_218' => 218,
  'Type_219' => 219,
  'Type_220' => 220,
  'TypeInner_221' => 221,
  'TypeInnerConstant_222' => 222,
  'VariableOrLiteral_223' => 223,
  'VariableOrLiteral_224' => 224,
  'VariableOrLiteralOrWord_225' => 225,
  'VariableOrLiteralOrWord_226' => 226,
  'VariableOrLiteralOrWord_227' => 227,
  'VariableSymbolOrSelf_228' => 228,
  'VariableSymbolOrSelf_229' => 229,
  'Literal_230' => 230,
  'Literal_231' => 231,
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
			"package" => -20,
			"## no critic qw(" => 7,
			'USE_RPERL' => -20,
			'SHEBANG' => 8
		},
		GOTOS => {
			'PAREN-1' => 9,
			'ModuleHeader' => 5,
			'OPTIONAL-9' => 6,
			'CompileUnit' => 2,
			'Program' => 3,
			'Critic' => 4,
			'PLUS-2' => 1
		}
	},
	{#State 1
		ACTIONS => {
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 7,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'Critic' => 4,
			'PAREN-1' => 10,
			'OPTIONAL-9' => 6,
			'ModuleHeader' => 5
		}
	},
	{#State 2
		ACTIONS => {
			'' => 11
		}
	},
	{#State 3
		DEFAULT => -4
	},
	{#State 4
		DEFAULT => -19
	},
	{#State 5
		ACTIONS => {
			"our" => -27,
			"use constant" => -27,
			'USE' => -27,
			"use parent qw(" => 16,
			"## no critic qw(" => -27
		},
		GOTOS => {
			'Package' => 14,
			'Class' => 15,
			'Module' => 12,
			'STAR-11' => 13
		}
	},
	{#State 6
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 18
		},
		GOTOS => {
			'OPTIONAL-10' => 17
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-16' => 19
		}
	},
	{#State 8
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Critic' => 21,
			'OPTIONAL-3' => 22
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		DEFAULT => -2
	},
	{#State 11
		DEFAULT => 0
	},
	{#State 12
		DEFAULT => -1
	},
	{#State 13
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			'USE' => -29,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Critic' => 23,
			'STAR-12' => 24
		}
	},
	{#State 14
		DEFAULT => -24
	},
	{#State 15
		DEFAULT => -25
	},
	{#State 16
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 17
		ACTIONS => {
			"package" => 28
		}
	},
	{#State 18
		DEFAULT => -21
	},
	{#State 19
		ACTIONS => {
			")" => 29,
			'WORD' => 30
		}
	},
	{#State 20
		DEFAULT => -39
	},
	{#State 21
		DEFAULT => -6
	},
	{#State 22
		ACTIONS => {
			'USE_RPERL' => 31
		}
	},
	{#State 23
		DEFAULT => -26
	},
	{#State 24
		ACTIONS => {
			"our" => -31,
			"use constant" => -31,
			'USE' => 33
		},
		GOTOS => {
			'Include' => 32,
			'STAR-13' => 34
		}
	},
	{#State 25
		ACTIONS => {
			")" => 35
		}
	},
	{#State 26
		DEFAULT => -215
	},
	{#State 27
		DEFAULT => -216
	},
	{#State 28
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 29
		DEFAULT => -40
	},
	{#State 30
		DEFAULT => -38
	},
	{#State 31
		ACTIONS => {
			"use strict;" => 38
		},
		GOTOS => {
			'Header' => 37
		}
	},
	{#State 32
		DEFAULT => -28
	},
	{#State 33
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 34
		ACTIONS => {
			"use constant" => 42,
			"our" => 44
		},
		GOTOS => {
			'Constant' => 43,
			'Subroutine' => 40,
			'PLUS-14' => 41
		}
	},
	{#State 35
		ACTIONS => {
			";" => 45
		}
	},
	{#State 36
		ACTIONS => {
			";" => 46
		}
	},
	{#State 37
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 47
		}
	},
	{#State 38
		ACTIONS => {
			"use warnings;" => 48
		}
	},
	{#State 39
		ACTIONS => {
			'OP01_QW' => 50,
			";" => 49
		}
	},
	{#State 40
		DEFAULT => -33
	},
	{#State 41
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 51
		},
		GOTOS => {
			'Subroutine' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'WORD_UPPERCASE' => 53
		}
	},
	{#State 43
		DEFAULT => -30
	},
	{#State 44
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'WORD' => 54,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 45
		ACTIONS => {
			'USE' => 33
		},
		GOTOS => {
			'Include' => 58
		}
	},
	{#State 46
		ACTIONS => {
			"use strict;" => 38
		},
		GOTOS => {
			'Header' => 59
		}
	},
	{#State 47
		ACTIONS => {
			'OP01_PRINT' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"if" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'SELF' => -11,
			"use constant" => -11,
			'LPAREN' => -11,
			'LITERAL_STRING' => -11,
			'MY' => -11,
			'OP01_OPEN' => -11,
			"while" => -11,
			'OP01_NAMED' => -11,
			"for" => -11,
			"\@{" => -11,
			'LBRACE' => -11,
			"%{" => -11,
			'OP01_CLOSE' => -11,
			"our" => -11,
			'WORD_SCOPED' => -11,
			'WORD_UPPERCASE' => -11,
			"undef" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"foreach" => -11,
			'LBRACKET' => -11,
			'USE' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"## no critic qw(" => 7,
			'WORD' => -11,
			'OP01_NAMED_VOID' => -11,
			'LITERAL_NUMBER' => -11
		},
		GOTOS => {
			'STAR-5' => 61,
			'Critic' => 60
		}
	},
	{#State 48
		ACTIONS => {
			'USE_RPERL_AFTER' => 62,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 63
		}
	},
	{#State 49
		DEFAULT => -43
	},
	{#State 50
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-17' => 64
		}
	},
	{#State 51
		ACTIONS => {
			";" => 66
		}
	},
	{#State 52
		DEFAULT => -32
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 54
		DEFAULT => -218
	},
	{#State 55
		DEFAULT => -219
	},
	{#State 56
		DEFAULT => -220
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 58
		DEFAULT => -56,
		GOTOS => {
			'STAR-22' => 69
		}
	},
	{#State 59
		DEFAULT => -23
	},
	{#State 60
		DEFAULT => -8
	},
	{#State 61
		ACTIONS => {
			'WORD_SCOPED' => -13,
			"our" => -13,
			'WORD_UPPERCASE' => -13,
			"undef" => -13,
			'OP01_CLOSE' => -13,
			"foreach" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LBRACE' => -13,
			"%{" => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'LBRACKET' => -13,
			'USE' => 33,
			'VARIABLE_SYMBOL' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"if" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_PRINT' => -13,
			'OP01_OPEN' => -13,
			'MY' => -13,
			"while" => -13,
			'OP01_NAMED' => -13,
			"\@{" => -13,
			"for" => -13,
			"use constant" => -13,
			'SELF' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			'LPAREN' => -13
		},
		GOTOS => {
			'STAR-6' => 71,
			'Include' => 70
		}
	},
	{#State 62
		DEFAULT => -35
	},
	{#State 63
		ACTIONS => {
			"our" => 72
		}
	},
	{#State 64
		ACTIONS => {
			")" => 73,
			'WORD' => 74
		}
	},
	{#State 65
		DEFAULT => -42
	},
	{#State 66
		DEFAULT => -34
	},
	{#State 67
		ACTIONS => {
			'MY' => 76
		},
		GOTOS => {
			'TypeInnerConstant' => 75
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 77
		}
	},
	{#State 69
		ACTIONS => {
			'USE' => -58,
			"use constant" => -58,
			"our hashref \$properties" => -58,
			"## no critic qw(" => 7
		},
		GOTOS => {
			'Critic' => 79,
			'STAR-23' => 78
		}
	},
	{#State 70
		DEFAULT => -10
	},
	{#State 71
		ACTIONS => {
			'MY' => -15,
			'OP01_OPEN' => -15,
			'OP01_NAMED' => -15,
			"while" => -15,
			"for" => -15,
			"\@{" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'SELF' => -15,
			"use constant" => 42,
			'LPAREN' => -15,
			'LITERAL_STRING' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"if" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_PRINT' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'WORD' => -15,
			'OP01_NAMED_VOID' => -15,
			'LITERAL_NUMBER' => -15,
			'LBRACKET' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_CLOSE' => -15,
			'WORD_SCOPED' => -15,
			"our" => -15,
			'WORD_UPPERCASE' => -15,
			"undef" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"foreach" => -15,
			'LBRACE' => -15,
			"%{" => -15
		},
		GOTOS => {
			'Constant' => 81,
			'STAR-7' => 80
		}
	},
	{#State 72
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 82
		}
	},
	{#State 73
		ACTIONS => {
			";" => 83
		}
	},
	{#State 74
		DEFAULT => -41
	},
	{#State 75
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Literal' => 86
		}
	},
	{#State 76
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 87
		}
	},
	{#State 77
		ACTIONS => {
			'OP01_NAMED_VOID' => -47,
			'WORD' => -47,
			'LITERAL_NUMBER' => -47,
			'OP01_NAMED_VOID_LPAREN' => -47,
			'LBRACKET' => -47,
			'VARIABLE_SYMBOL' => -47,
			'OP22_LOGICAL_NEG' => -47,
			'OP03_MATH_INC_DEC' => -47,
			'WORD_UPPERCASE' => -47,
			'WORD_SCOPED' => -47,
			"undef" => -47,
			'OP01_CLOSE' => -47,
			'OP19_LOOP_CONTROL' => -47,
			"foreach" => -47,
			"}" => -47,
			'OP19_LOOP_CONTROL_SCOLON' => -47,
			'LBRACE' => -47,
			"%{" => -47,
			'OP01_OPEN' => -47,
			'MY' => -47,
			'OP01_NAMED' => -47,
			"while" => -47,
			"for" => -47,
			"\@{" => -47,
			'SELF' => -47,
			'OP01_NAMED_VOID_SCOLON' => -47,
			'LITERAL_STRING' => -47,
			'LPAREN' => -47,
			"if" => -47,
			'OP05_MATH_NEG_LPAREN' => -47,
			'OP10_NAMED_UNARY' => -47,
			'OP05_LOGICAL_NEG' => -47,
			'OP01_PRINT' => -47,
			'LPAREN_MY' => 88
		},
		GOTOS => {
			'SubroutineArguments' => 89,
			'OPTIONAL-18' => 90
		}
	},
	{#State 78
		ACTIONS => {
			'USE' => 33,
			"use constant" => -60,
			"our hashref \$properties" => -60
		},
		GOTOS => {
			'STAR-24' => 92,
			'Include' => 91
		}
	},
	{#State 79
		DEFAULT => -55
	},
	{#State 80
		ACTIONS => {
			'OP01_NAMED_VOID' => 105,
			'WORD' => 26,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			"our" => 44,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 95,
			"undef" => 93,
			'OP01_CLOSE' => 97,
			'OP19_LOOP_CONTROL' => 98,
			"foreach" => -149,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'LBRACE' => 103,
			"%{" => 104,
			'OP01_OPEN' => 125,
			'MY' => 127,
			"while" => -149,
			'OP01_NAMED' => 129,
			"\@{" => 128,
			"for" => -149,
			'SELF' => 133,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'LITERAL_STRING' => 85,
			'LPAREN' => 138,
			"if" => 115,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP10_NAMED_UNARY' => 119,
			'OP05_LOGICAL_NEG' => 121,
			'OP01_PRINT' => 122
		},
		GOTOS => {
			'HashReference' => 132,
			'PLUS-8' => 134,
			'Operator' => 135,
			'Conditional' => 137,
			'Subroutine' => 110,
			'VariableDeclaration' => 109,
			'SubExpression' => 139,
			'VariableModification' => 111,
			'LoopLabel' => 106,
			'OperatorVoid' => 126,
			'Statement' => 130,
			'HashDereference' => 131,
			'ArrayReference' => 120,
			'Literal' => 101,
			'Variable' => 102,
			'Expression' => 123,
			'OPTIONAL-38' => 124,
			'ArrayDereference' => 116,
			'PAREN-37' => 94,
			'WordScoped' => 117,
			'Operation' => 96,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 81
		DEFAULT => -12
	},
	{#State 82
		DEFAULT => -37
	},
	{#State 83
		DEFAULT => -44
	},
	{#State 84
		DEFAULT => -230
	},
	{#State 85
		DEFAULT => -231
	},
	{#State 86
		ACTIONS => {
			";" => 140
		}
	},
	{#State 87
		ACTIONS => {
			"\$TYPED_" => 141
		}
	},
	{#State 88
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'WORD' => 54,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 142
		}
	},
	{#State 89
		DEFAULT => -46
	},
	{#State 90
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 143
		}
	},
	{#State 91
		DEFAULT => -57
	},
	{#State 92
		ACTIONS => {
			"our hashref \$properties" => 145,
			"use constant" => 42
		},
		GOTOS => {
			'Constant' => 146,
			'Properties' => 144
		}
	},
	{#State 93
		DEFAULT => -135
	},
	{#State 94
		DEFAULT => -148
	},
	{#State 95
		ACTIONS => {
			'LPAREN' => 147,
			'COLON' => -217
		}
	},
	{#State 96
		DEFAULT => -17
	},
	{#State 97
		ACTIONS => {
			'FHREF_SYMBOL' => 148
		}
	},
	{#State 98
		ACTIONS => {
			'WORD_UPPERCASE' => 150
		},
		GOTOS => {
			'LoopLabel' => 149
		}
	},
	{#State 99
		DEFAULT => -122
	},
	{#State 100
		DEFAULT => -173,
		GOTOS => {
			'STAR-44' => 151
		}
	},
	{#State 101
		DEFAULT => -136
	},
	{#State 102
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP02_METHOD_THINARROW' => 154,
			'OP13_BITWISE_AND' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP08_STRING_CAT' => -137,
			'OP23_LOGICAL_AND' => -137,
			")" => -137,
			'OP03_MATH_INC_DEC' => 152,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP18_TERNARY' => -137,
			'OP04_MATH_POW' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 155,
			'OP16_LOGICAL_OR' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP19_VARIABLE_ASSIGN' => 153
		}
	},
	{#State 103
		ACTIONS => {
			"%{" => 104,
			"}" => 160,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'WORD' => 157,
			'SELF' => 133
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 162,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 161,
			'Literal' => 158,
			'Variable' => 159,
			'HashEntry' => 156
		}
	},
	{#State 104
		ACTIONS => {
			'MY' => 164,
			'LBRACE' => -212,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'Variable' => 163,
			'TypeInner' => 166,
			'VariableSymbolOrSelf' => 100,
			'OPTIONAL-53' => 165
		}
	},
	{#State 105
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'OP10_NAMED_UNARY' => 119,
			'SELF' => 133,
			'OP01_QW' => 175,
			'LBRACKET' => 108,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'MY' => 164,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'HashReference' => 132,
			'Literal' => 101,
			'ArrayReference' => 120,
			'Variable' => 173,
			'TypeInner' => 167,
			'Operator' => 135,
			'ListElement' => 171,
			'ListElements' => 168,
			'Expression' => 169,
			'SubExpression' => 170
		}
	},
	{#State 106
		ACTIONS => {
			'COLON' => 176
		}
	},
	{#State 107
		ACTIONS => {
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'MY' => 164,
			'WORD' => 26,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'SELF' => 133,
			'OP01_QW' => 175,
			'LBRACKET' => 108,
			'OP10_NAMED_UNARY' => 119,
			")" => -115,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103
		},
		GOTOS => {
			'Operator' => 135,
			'TypeInner' => 167,
			'Variable' => 173,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'SubExpression' => 170,
			'ListElements' => 178,
			'Expression' => 169,
			'ListElement' => 171,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'OPTIONAL-34' => 177
		}
	},
	{#State 108
		ACTIONS => {
			'OP10_NAMED_UNARY' => 119,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"]" => -194,
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'MY' => 164,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'SELF' => 133,
			'LBRACKET' => 108,
			'OP01_QW' => 175
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'OPTIONAL-48' => 180,
			'HashDereference' => 131,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'ListElement' => 171,
			'Expression' => 169,
			'ListElements' => 179,
			'SubExpression' => 170,
			'HashReference' => 132,
			'Literal' => 101,
			'ArrayReference' => 120,
			'TypeInner' => 167,
			'Variable' => 173,
			'Operator' => 135
		}
	},
	{#State 109
		DEFAULT => -153
	},
	{#State 110
		DEFAULT => -14
	},
	{#State 111
		ACTIONS => {
			";" => 181
		}
	},
	{#State 112
		ACTIONS => {
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 119,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACKET' => 108,
			'SELF' => 133,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'SubExpression' => 182,
			'Expression' => 169,
			'Variable' => 173,
			'Operator' => 135,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132
		}
	},
	{#State 113
		ACTIONS => {
			'VARIABLE_SYMBOL' => 114,
			'SELF' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'Variable' => 183
		}
	},
	{#State 114
		DEFAULT => -228
	},
	{#State 115
		ACTIONS => {
			'LPAREN' => 184
		}
	},
	{#State 116
		DEFAULT => -139
	},
	{#State 117
		ACTIONS => {
			'LPAREN' => 187,
			'SCOPE' => 185,
			'OP02_METHOD_THINARROW_NEW' => 186
		}
	},
	{#State 118
		ACTIONS => {
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119,
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128
		},
		GOTOS => {
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'Operator' => 135,
			'Variable' => 173,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'Literal' => 101,
			'SubExpression' => 188,
			'Expression' => 169
		}
	},
	{#State 119
		ACTIONS => {
			")" => -99,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP23_LOGICAL_AND' => -99,
			"undef" => 93,
			'OP01_CLOSE' => 97,
			"}" => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP13_BITWISE_AND' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'LBRACE' => 103,
			'OP08_MATH_ADD_SUB' => -99,
			"%{" => 104,
			'WORD' => 26,
			'OP16_LOGICAL_OR' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'LITERAL_NUMBER' => 84,
			'OP21_LIST_COMMA' => -99,
			'LBRACKET' => 108,
			'OP18_TERNARY' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP08_STRING_CAT' => -99,
			"]" => -99,
			'OP10_NAMED_UNARY' => 119,
			";" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP05_LOGICAL_NEG' => 121,
			'OP07_STRING_REPEAT' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP01_OPEN' => 125,
			'OP15_LOGICAL_AND' => -99,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => -99,
			'SELF' => 133,
			'OP04_MATH_POW' => -99,
			'LITERAL_STRING' => 85,
			'LPAREN' => 138
		},
		GOTOS => {
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'SubExpression' => 189,
			'Expression' => 169,
			'Operator' => 135,
			'Variable' => 173,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132
		}
	},
	{#State 120
		DEFAULT => -138
	},
	{#State 121
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 119,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACKET' => 108,
			'SELF' => 133,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'SubExpression' => 190,
			'Expression' => 169,
			'Variable' => 173,
			'Operator' => 135,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'WordScoped' => 117,
			'ArrayDereference' => 116
		}
	},
	{#State 122
		ACTIONS => {
			"%{" => -113,
			'OP05_LOGICAL_NEG' => -113,
			'STDOUT_STDERR' => 193,
			'FHREF_SYMBOL_BRACES' => 192,
			'LBRACE' => -113,
			'OP10_NAMED_UNARY' => -113,
			"undef" => -113,
			'WORD_UPPERCASE' => -113,
			'WORD_SCOPED' => -113,
			'OP01_CLOSE' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'LITERAL_STRING' => -113,
			'LPAREN' => -113,
			'OP22_LOGICAL_NEG' => -113,
			'OP03_MATH_INC_DEC' => -113,
			'VARIABLE_SYMBOL' => -113,
			'SELF' => -113,
			'OP01_QW' => -113,
			'LBRACKET' => -113,
			"\@{" => -113,
			'OP01_NAMED' => -113,
			'LITERAL_NUMBER' => -113,
			'OP01_OPEN' => -113,
			'MY' => -113,
			'WORD' => -113
		},
		GOTOS => {
			'OPTIONAL-33' => 194,
			'PAREN-32' => 191
		}
	},
	{#State 123
		ACTIONS => {
			'OP08_STRING_CAT' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP17_LIST_RANGE' => -134,
			";" => 195,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP04_MATH_POW' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP18_TERNARY' => -134
		}
	},
	{#State 124
		ACTIONS => {
			"for" => 198,
			"foreach" => 201,
			"while" => 196
		},
		GOTOS => {
			'LoopWhile' => 202,
			'LoopFor' => 199,
			'LoopForEach' => 200,
			'Loop' => 197
		}
	},
	{#State 125
		ACTIONS => {
			'MY' => 203
		}
	},
	{#State 126
		DEFAULT => -152
	},
	{#State 127
		ACTIONS => {
			'TYPE_FHREF' => 205,
			'TYPE_INTEGER' => 56,
			'WORD' => 54,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 204
		}
	},
	{#State 128
		ACTIONS => {
			'MY' => 164,
			'LBRACKET' => -197,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114
		},
		GOTOS => {
			'OPTIONAL-49' => 207,
			'Variable' => 208,
			'TypeInner' => 206,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 129
		ACTIONS => {
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP10_NAMED_UNARY' => 119,
			'OP01_QW' => 175,
			'LBRACKET' => 108,
			'SELF' => 133,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'MY' => 164,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'ListElement' => 210,
			'Expression' => 169,
			'SubExpression' => 209,
			'HashReference' => 132,
			'Literal' => 101,
			'ArrayReference' => 120,
			'Variable' => 173,
			'TypeInner' => 167,
			'Operator' => 135
		}
	},
	{#State 130
		DEFAULT => -81
	},
	{#State 131
		DEFAULT => -141
	},
	{#State 132
		DEFAULT => -140
	},
	{#State 133
		DEFAULT => -229
	},
	{#State 134
		ACTIONS => {
			'OP01_PRINT' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_MATH_NEG_LPAREN' => 118,
			"if" => 115,
			'OP10_NAMED_UNARY' => 119,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'SELF' => 133,
			'' => -18,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'MY' => 127,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 129,
			"while" => -149,
			"\@{" => 128,
			"for" => -149,
			'LBRACE' => 103,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 95,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			"foreach" => -149,
			'OP19_LOOP_CONTROL' => 98,
			'LBRACKET' => 108,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'WORD' => 26,
			'OP01_NAMED_VOID' => 105,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'HashReference' => 132,
			'Operator' => 135,
			'VariableDeclaration' => 109,
			'Conditional' => 137,
			'VariableModification' => 111,
			'SubExpression' => 139,
			'LoopLabel' => 106,
			'OperatorVoid' => 126,
			'HashDereference' => 131,
			'Statement' => 130,
			'ArrayReference' => 120,
			'Literal' => 101,
			'Variable' => 102,
			'Expression' => 123,
			'OPTIONAL-38' => 124,
			'ArrayDereference' => 116,
			'PAREN-37' => 94,
			'Operation' => 211,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 135
		DEFAULT => -128
	},
	{#State 136
		DEFAULT => -118
	},
	{#State 137
		DEFAULT => -150
	},
	{#State 138
		ACTIONS => {
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP01_PRINT' => 212,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 214,
			"\@{" => 128,
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Operator' => 135,
			'Variable' => 173,
			'Expression' => 169,
			'SubExpression' => 213,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 139
		ACTIONS => {
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP04_MATH_POW' => 220,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP23_LOGICAL_AND' => 223,
			'OP08_STRING_CAT' => 216,
			'OP17_LIST_RANGE' => 215,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP07_STRING_REPEAT' => 218,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224
		}
	},
	{#State 140
		DEFAULT => -45
	},
	{#State 141
		ACTIONS => {
			'WORD_UPPERCASE' => 232
		}
	},
	{#State 142
		ACTIONS => {
			'VARIABLE_SYMBOL' => 233
		}
	},
	{#State 143
		ACTIONS => {
			'LBRACKET' => 108,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'WORD' => 26,
			'OP01_NAMED_VOID' => 105,
			'LITERAL_NUMBER' => 84,
			'LBRACE' => 103,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 95,
			"undef" => 93,
			"}" => 234,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'OP19_LOOP_CONTROL' => 98,
			"foreach" => -149,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'SELF' => 133,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'MY' => 127,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 129,
			"while" => -149,
			"for" => -149,
			"\@{" => 128,
			'OP01_PRINT' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_MATH_NEG_LPAREN' => 118,
			"if" => 115,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'WordScoped' => 117,
			'Operation' => 235,
			'PAREN-37' => 94,
			'ArrayDereference' => 116,
			'OPTIONAL-38' => 124,
			'Expression' => 123,
			'Variable' => 102,
			'ArrayReference' => 120,
			'Literal' => 101,
			'Statement' => 130,
			'HashDereference' => 131,
			'OperatorVoid' => 126,
			'LoopLabel' => 106,
			'VariableModification' => 111,
			'SubExpression' => 139,
			'VariableDeclaration' => 109,
			'Conditional' => 137,
			'Operator' => 135,
			'HashReference' => 132
		}
	},
	{#State 144
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 236
		}
	},
	{#State 145
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 237
		}
	},
	{#State 146
		DEFAULT => -59
	},
	{#State 147
		ACTIONS => {
			")" => 238
		}
	},
	{#State 148
		DEFAULT => -86
	},
	{#State 149
		ACTIONS => {
			";" => 239
		}
	},
	{#State 150
		DEFAULT => -217
	},
	{#State 151
		ACTIONS => {
			'OP04_MATH_POW' => -174,
			'OP21_LIST_COMMA' => -174,
			'OP06_REGEX_MATCH' => -174,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP03_MATH_INC_DEC' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			'OP18_TERNARY' => -174,
			'OP16_LOGICAL_OR' => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			'OP20_HASH_FATARROW' => -174,
			'OP09_BITWISE_SHIFT' => -174,
			'OP02_ARRAY_THINARROW' => 241,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			'OP02_METHOD_THINARROW' => -174,
			'OP13_BITWISE_AND' => -174,
			'OP11_COMPARE_LT_GT' => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'OP12_COMPARE_EQ_NE' => -174,
			'OP08_MATH_ADD_SUB' => -174,
			'OP07_STRING_REPEAT' => -174,
			"]" => -174,
			'OP08_STRING_CAT' => -174,
			'OP23_LOGICAL_AND' => -174,
			")" => -174,
			"}" => -174,
			";" => -174,
			'OP02_HASH_THINARROW' => 242,
			'OP17_LIST_RANGE' => -174,
			'COLON' => -174
		},
		GOTOS => {
			'VariableRetrieval' => 240
		}
	},
	{#State 152
		DEFAULT => -88
	},
	{#State 153
		ACTIONS => {
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133,
			'LITERAL_NUMBER' => 84,
			'STDIN' => 244,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'OP10_NAMED_UNARY' => 119,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93
		},
		GOTOS => {
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'Variable' => 173,
			'Operator' => 135,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'SubExpression' => 245,
			'SubExpressionOrStdin' => 243,
			'Expression' => 169
		}
	},
	{#State 154
		ACTIONS => {
			'LPAREN' => 246
		}
	},
	{#State 155
		ACTIONS => {
			'LBRACKET' => 108,
			'SELF' => 133,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'Operator' => 135,
			'Variable' => 173,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132,
			'SubExpression' => 247,
			'Expression' => 169,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 156
		DEFAULT => -208,
		GOTOS => {
			'STAR-52' => 248
		}
	},
	{#State 157
		DEFAULT => -227
	},
	{#State 158
		DEFAULT => -226
	},
	{#State 159
		DEFAULT => -225
	},
	{#State 160
		DEFAULT => -210
	},
	{#State 161
		DEFAULT => -203
	},
	{#State 162
		ACTIONS => {
			'OP20_HASH_FATARROW' => 249
		}
	},
	{#State 163
		ACTIONS => {
			"}" => 250
		}
	},
	{#State 164
		ACTIONS => {
			'WORD' => 54,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 251
		}
	},
	{#State 165
		ACTIONS => {
			'LBRACE' => 103
		},
		GOTOS => {
			'HashReference' => 252
		}
	},
	{#State 166
		DEFAULT => -211
	},
	{#State 167
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121
		},
		GOTOS => {
			'Variable' => 173,
			'Operator' => 135,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'SubExpression' => 253,
			'Expression' => 169,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131
		}
	},
	{#State 168
		ACTIONS => {
			";" => 254
		}
	},
	{#State 169
		DEFAULT => -134
	},
	{#State 170
		ACTIONS => {
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP21_LIST_COMMA' => -190,
			'OP04_MATH_POW' => 220,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP07_STRING_REPEAT' => 218,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			")" => -190,
			'OP23_LOGICAL_AND' => 223,
			'OP08_STRING_CAT' => 216,
			"]" => -190,
			";" => -190,
			'OP17_LIST_RANGE' => 215
		}
	},
	{#State 171
		DEFAULT => -186,
		GOTOS => {
			'STAR-46' => 255
		}
	},
	{#State 172
		ACTIONS => {
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'LITERAL_STRING' => 85,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'VARIABLE_SYMBOL' => 114,
			'SELF' => 133,
			'LBRACKET' => 108,
			'OP10_NAMED_UNARY' => 119,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103
		},
		GOTOS => {
			'SubExpression' => 256,
			'Expression' => 169,
			'Operator' => 135,
			'Variable' => 173,
			'HashReference' => 132,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'WordScoped' => 117,
			'ArrayDereference' => 116
		}
	},
	{#State 173
		ACTIONS => {
			")" => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP08_STRING_CAT' => -137,
			"]" => -137,
			";" => -137,
			"}" => -137,
			'OP17_LIST_RANGE' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP02_METHOD_THINARROW' => 154,
			'OP07_STRING_REPEAT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP04_MATH_POW' => -137,
			'OP18_TERNARY' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP03_MATH_INC_DEC' => 152
		}
	},
	{#State 174
		ACTIONS => {
			'LPAREN' => 147
		}
	},
	{#State 175
		ACTIONS => {
			'WORD' => 257
		},
		GOTOS => {
			'PLUS-47' => 258
		}
	},
	{#State 176
		DEFAULT => -147
	},
	{#State 177
		ACTIONS => {
			")" => 259
		}
	},
	{#State 178
		DEFAULT => -114
	},
	{#State 179
		DEFAULT => -193
	},
	{#State 180
		ACTIONS => {
			"]" => 260
		}
	},
	{#State 181
		DEFAULT => -154
	},
	{#State 182
		ACTIONS => {
			"]" => -108,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => -108,
			")" => -108,
			";" => -108,
			"}" => -108,
			'OP17_LIST_RANGE' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP07_STRING_REPEAT' => 218,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228,
			'OP04_MATH_POW' => 220,
			'OP21_LIST_COMMA' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP06_REGEX_MATCH' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231
		}
	},
	{#State 183
		DEFAULT => -87
	},
	{#State 184
		ACTIONS => {
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LITERAL_NUMBER' => 84,
			'SELF' => 133,
			'LBRACKET' => 108,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'OP10_NAMED_UNARY' => 119,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104
		},
		GOTOS => {
			'Expression' => 169,
			'SubExpression' => 261,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Operator' => 135,
			'Variable' => 173,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'WordScoped' => 117
		}
	},
	{#State 185
		ACTIONS => {
			'WORD_UPPERCASE' => 262
		}
	},
	{#State 186
		ACTIONS => {
			")" => 263
		}
	},
	{#State 187
		ACTIONS => {
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'WORD_SCOPED' => 27,
			")" => -125,
			'WORD_UPPERCASE' => 174,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119,
			'LBRACKET' => 108,
			'OP01_QW' => 175,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LITERAL_STRING' => 85,
			'MY' => 164,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128
		},
		GOTOS => {
			'ListElements' => 264,
			'Expression' => 169,
			'ListElement' => 171,
			'SubExpression' => 170,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Operator' => 135,
			'TypeInner' => 167,
			'Variable' => 173,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'OPTIONAL-35' => 265,
			'ArrayDereference' => 116,
			'WordScoped' => 117
		}
	},
	{#State 188
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 225,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218,
			'OP08_STRING_CAT' => 216,
			")" => 266,
			'OP23_LOGICAL_AND' => 223,
			'OP17_LIST_RANGE' => 215,
			'OP04_MATH_POW' => 220,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP09_BITWISE_SHIFT' => 228
		}
	},
	{#State 189
		ACTIONS => {
			'OP04_MATH_POW' => 220,
			'OP21_LIST_COMMA' => -98,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP09_BITWISE_SHIFT' => 228,
			'OP11_COMPARE_LT_GT' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP07_STRING_REPEAT' => 218,
			"]" => -98,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => -98,
			")" => -98,
			";" => -98,
			"}" => -98,
			'OP17_LIST_RANGE' => -98
		}
	},
	{#State 190
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP18_TERNARY' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP04_MATH_POW' => 220,
			"}" => -90,
			";" => -90,
			'OP17_LIST_RANGE' => -90,
			")" => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP08_STRING_CAT' => -90,
			"]" => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90
		}
	},
	{#State 191
		DEFAULT => -112
	},
	{#State 192
		ACTIONS => {
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119,
			'OP01_QW' => 175,
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'MY' => 164,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128
		},
		GOTOS => {
			'ListElements' => 267,
			'Expression' => 169,
			'ListElement' => 171,
			'SubExpression' => 170,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'Operator' => 135,
			'Variable' => 173,
			'TypeInner' => 167,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'WordScoped' => 117
		}
	},
	{#State 193
		DEFAULT => -111
	},
	{#State 194
		ACTIONS => {
			'LBRACKET' => 108,
			'OP01_QW' => 175,
			'SELF' => 133,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'MY' => 164,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'ListElement' => 171,
			'Expression' => 169,
			'ListElements' => 268,
			'SubExpression' => 170,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'TypeInner' => 167,
			'Variable' => 173,
			'Operator' => 135
		}
	},
	{#State 195
		DEFAULT => -80
	},
	{#State 196
		ACTIONS => {
			'LPAREN' => 269
		}
	},
	{#State 197
		DEFAULT => -151
	},
	{#State 198
		ACTIONS => {
			'LPAREN_MY' => 270,
			'MY' => 271
		}
	},
	{#State 199
		DEFAULT => -162
	},
	{#State 200
		DEFAULT => -163
	},
	{#State 201
		ACTIONS => {
			'MY' => 272
		}
	},
	{#State 202
		DEFAULT => -164
	},
	{#State 203
		ACTIONS => {
			'TYPE_FHREF' => 273
		}
	},
	{#State 204
		ACTIONS => {
			'VARIABLE_SYMBOL' => 274
		}
	},
	{#State 205
		ACTIONS => {
			'FHREF_SYMBOL' => 275
		}
	},
	{#State 206
		DEFAULT => -196
	},
	{#State 207
		ACTIONS => {
			'LBRACKET' => 108
		},
		GOTOS => {
			'ArrayReference' => 276
		}
	},
	{#State 208
		ACTIONS => {
			"}" => 277
		}
	},
	{#State 209
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			")" => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP08_STRING_CAT' => -83,
			'OP17_LIST_RANGE' => -83,
			";" => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP21_LIST_COMMA' => -190,
			'OP04_MATH_POW' => -83,
			'OP18_TERNARY' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP09_BITWISE_SHIFT' => -83
		}
	},
	{#State 210
		ACTIONS => {
			'OP21_LIST_COMMA' => 278
		}
	},
	{#State 211
		DEFAULT => -16
	},
	{#State 212
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 279
		}
	},
	{#State 213
		ACTIONS => {
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => 223,
			")" => 280,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP07_STRING_REPEAT' => 218,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228,
			'OP04_MATH_POW' => 220,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231
		}
	},
	{#State 214
		ACTIONS => {
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			'OP10_NAMED_UNARY' => 119,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'SELF' => 133,
			'OP01_QW' => 175,
			'LBRACKET' => 108,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'MY' => 164,
			'WORD' => 26
		},
		GOTOS => {
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'Expression' => 169,
			'ListElement' => 281,
			'SubExpression' => 209,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'Operator' => 135,
			'Variable' => 173,
			'TypeInner' => 167
		}
	},
	{#State 215
		ACTIONS => {
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'OP10_NAMED_UNARY' => 119,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LITERAL_NUMBER' => 84,
			'SELF' => 133,
			'LBRACKET' => 108,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113
		},
		GOTOS => {
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'Operator' => 135,
			'Variable' => 173,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'SubExpression' => 282,
			'Expression' => 169
		}
	},
	{#State 216
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP10_NAMED_UNARY' => 119,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACKET' => 108,
			'SELF' => 133,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Expression' => 169,
			'SubExpression' => 283,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'Literal' => 101,
			'Operator' => 135,
			'Variable' => 173,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'WordScoped' => 117
		}
	},
	{#State 217
		ACTIONS => {
			'OP01_OPEN' => 125,
			'WORD' => 26,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'SELF' => 133,
			'LBRACKET' => 108,
			'LITERAL_STRING' => 85,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'OP10_NAMED_UNARY' => 119,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104
		},
		GOTOS => {
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'Operator' => 135,
			'Variable' => 173,
			'Expression' => 169,
			'SubExpression' => 284,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 218
		ACTIONS => {
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119,
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128
		},
		GOTOS => {
			'Operator' => 135,
			'Variable' => 173,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132,
			'SubExpression' => 285,
			'Expression' => 169,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 219
		ACTIONS => {
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'LITERAL_STRING' => 85,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'SELF' => 133,
			'LBRACKET' => 108,
			'OP10_NAMED_UNARY' => 119,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103
		},
		GOTOS => {
			'Expression' => 169,
			'SubExpression' => 286,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Literal' => 101,
			'Operator' => 135,
			'Variable' => 173,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'WordScoped' => 117
		}
	},
	{#State 220
		ACTIONS => {
			'OP10_NAMED_UNARY' => 119,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133
		},
		GOTOS => {
			'Variable' => 173,
			'Operator' => 135,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132,
			'SubExpression' => 287,
			'Expression' => 169,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131
		}
	},
	{#State 221
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 288
		}
	},
	{#State 222
		ACTIONS => {
			'OP10_NAMED_UNARY' => 119,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'SELF' => 133,
			'LBRACKET' => 108
		},
		GOTOS => {
			'Variable' => 173,
			'Operator' => 135,
			'HashReference' => 132,
			'Literal' => 101,
			'ArrayReference' => 120,
			'SubExpression' => 289,
			'Expression' => 169,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131
		}
	},
	{#State 223
		ACTIONS => {
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104
		},
		GOTOS => {
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Variable' => 173,
			'Operator' => 135,
			'Expression' => 169,
			'SubExpression' => 290,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131
		}
	},
	{#State 224
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP10_NAMED_UNARY' => 119,
			'SELF' => 133,
			'LBRACKET' => 108,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'SubExpression' => 291,
			'Expression' => 169,
			'Operator' => 135,
			'Variable' => 173,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'WordScoped' => 117,
			'ArrayDereference' => 116
		}
	},
	{#State 225
		ACTIONS => {
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119,
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128
		},
		GOTOS => {
			'Variable' => 173,
			'Operator' => 135,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Literal' => 101,
			'SubExpression' => 292,
			'Expression' => 169,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131
		}
	},
	{#State 226
		ACTIONS => {
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACKET' => 108,
			'SELF' => 133,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 119,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104
		},
		GOTOS => {
			'Expression' => 169,
			'SubExpression' => 293,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Operator' => 135,
			'Variable' => 173,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'WordScoped' => 117
		}
	},
	{#State 227
		ACTIONS => {
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'Expression' => 169,
			'SubExpression' => 294,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Variable' => 173,
			'Operator' => 135
		}
	},
	{#State 228
		ACTIONS => {
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'OP10_NAMED_UNARY' => 119,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'WORD' => 26,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'Operator' => 135,
			'Variable' => 173,
			'HashReference' => 132,
			'Literal' => 101,
			'ArrayReference' => 120,
			'SubExpression' => 295,
			'Expression' => 169
		}
	},
	{#State 229
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'OP10_NAMED_UNARY' => 119,
			'SELF' => 133,
			'LBRACKET' => 108,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'Expression' => 169,
			'SubExpression' => 296,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Literal' => 101,
			'Operator' => 135,
			'Variable' => 173
		}
	},
	{#State 230
		ACTIONS => {
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'SELF' => 133,
			'LBRACKET' => 108,
			'OP10_NAMED_UNARY' => 119,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103
		},
		GOTOS => {
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'Operator' => 135,
			'Variable' => 173,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'SubExpression' => 297,
			'Expression' => 169
		}
	},
	{#State 231
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_NUMBER' => 84,
			'SELF' => 133
		},
		GOTOS => {
			'Variable' => 300,
			'Literal' => 299,
			'VariableSymbolOrSelf' => 100,
			'VariableOrLiteral' => 298
		}
	},
	{#State 232
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 301
		}
	},
	{#State 233
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 302
		}
	},
	{#State 234
		ACTIONS => {
			";" => 303
		}
	},
	{#State 235
		DEFAULT => -48
	},
	{#State 236
		ACTIONS => {
			'LITERAL_NUMBER' => 306,
			"our" => 304
		},
		GOTOS => {
			'Method' => 305,
			'Subroutine' => 307,
			'MethodOrSubroutine' => 308
		}
	},
	{#State 237
		ACTIONS => {
			'LBRACE' => 309
		}
	},
	{#State 238
		DEFAULT => -130
	},
	{#State 239
		DEFAULT => -123
	},
	{#State 240
		DEFAULT => -172
	},
	{#State 241
		ACTIONS => {
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Literal' => 101,
			'Variable' => 173,
			'Operator' => 135,
			'Expression' => 169,
			'SubExpression' => 310
		}
	},
	{#State 242
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'SELF' => 133,
			'LBRACKET' => 108,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'WORD' => 312,
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			'OP10_NAMED_UNARY' => 119,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97
		},
		GOTOS => {
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132,
			'Variable' => 173,
			'Operator' => 135,
			'Expression' => 169,
			'SubExpression' => 311,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131
		}
	},
	{#State 243
		DEFAULT => -182
	},
	{#State 244
		DEFAULT => -144
	},
	{#State 245
		ACTIONS => {
			")" => -143,
			'OP23_LOGICAL_AND' => 223,
			'OP08_STRING_CAT' => 216,
			'OP17_LIST_RANGE' => 215,
			";" => -143,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP07_STRING_REPEAT' => 218,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP04_MATH_POW' => 220,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230
		}
	},
	{#State 246
		ACTIONS => {
			'OP01_QW' => 175,
			'LBRACKET' => 108,
			'SELF' => 133,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'MY' => 164,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			")" => -127,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'ListElement' => 171,
			'Expression' => 169,
			'ListElements' => 314,
			'SubExpression' => 170,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Literal' => 101,
			'Variable' => 173,
			'TypeInner' => 167,
			'Operator' => 135,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayDereference' => 116,
			'OPTIONAL-36' => 313,
			'WordScoped' => 117
		}
	},
	{#State 247
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 228,
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP04_MATH_POW' => 220,
			";" => -183,
			'OP17_LIST_RANGE' => 215,
			")" => -183,
			'OP23_LOGICAL_AND' => 223,
			'OP08_STRING_CAT' => 216,
			'OP07_STRING_REPEAT' => 218,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226
		}
	},
	{#State 248
		ACTIONS => {
			"}" => 315,
			'OP21_LIST_COMMA' => 316
		},
		GOTOS => {
			'PAREN-51' => 317
		}
	},
	{#State 249
		ACTIONS => {
			'OP01_CLOSE' => -201,
			'OP05_MATH_NEG_LPAREN' => -201,
			'WORD_SCOPED' => -201,
			'WORD_UPPERCASE' => -201,
			"undef" => -201,
			'OP10_NAMED_UNARY' => -201,
			'LBRACE' => -201,
			'OP05_LOGICAL_NEG' => -201,
			"%{" => -201,
			'MY' => 164,
			'WORD' => -201,
			'OP01_OPEN' => -201,
			'LITERAL_NUMBER' => -201,
			'OP01_NAMED' => -201,
			"\@{" => -201,
			'LBRACKET' => -201,
			'SELF' => -201,
			'VARIABLE_SYMBOL' => -201,
			'OP22_LOGICAL_NEG' => -201,
			'OP03_MATH_INC_DEC' => -201,
			'LPAREN' => -201,
			'LITERAL_STRING' => -201
		},
		GOTOS => {
			'TypeInner' => 318,
			'OPTIONAL-50' => 319
		}
	},
	{#State 250
		DEFAULT => -213
	},
	{#State 251
		ACTIONS => {
			"\$TYPED_" => 320
		}
	},
	{#State 252
		ACTIONS => {
			"}" => 321
		}
	},
	{#State 253
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			";" => -191,
			'OP17_LIST_RANGE' => 215,
			'OP08_STRING_CAT' => 216,
			"]" => -191,
			")" => -191,
			'OP23_LOGICAL_AND' => 223,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP04_MATH_POW' => 220,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP21_LIST_COMMA' => -191,
			'OP09_BITWISE_SHIFT' => 228,
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229
		}
	},
	{#State 254
		DEFAULT => -120
	},
	{#State 255
		ACTIONS => {
			"]" => -187,
			'OP21_LIST_COMMA' => 322,
			")" => -187,
			";" => -187
		},
		GOTOS => {
			'PAREN-45' => 323
		}
	},
	{#State 256
		ACTIONS => {
			'OP23_LOGICAL_AND' => -83,
			")" => -83,
			"]" => -83,
			'OP08_STRING_CAT' => -83,
			"}" => -83,
			";" => -83,
			'OP17_LIST_RANGE' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP04_MATH_POW' => -83,
			'OP18_TERNARY' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83
		}
	},
	{#State 257
		DEFAULT => -189
	},
	{#State 258
		ACTIONS => {
			'WORD' => 325,
			")" => 324
		}
	},
	{#State 259
		ACTIONS => {
			";" => 326
		}
	},
	{#State 260
		DEFAULT => -195
	},
	{#State 261
		ACTIONS => {
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228,
			'OP04_MATH_POW' => 220,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => 223,
			")" => 327,
			'OP17_LIST_RANGE' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP07_STRING_REPEAT' => 218
		}
	},
	{#State 262
		ACTIONS => {
			'LPAREN' => 328
		}
	},
	{#State 263
		DEFAULT => -133
	},
	{#State 264
		DEFAULT => -124
	},
	{#State 265
		ACTIONS => {
			")" => 329
		}
	},
	{#State 266
		DEFAULT => -91
	},
	{#State 267
		ACTIONS => {
			";" => 330
		}
	},
	{#State 268
		ACTIONS => {
			";" => 331
		}
	},
	{#State 269
		ACTIONS => {
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'SubExpression' => 332,
			'Expression' => 169,
			'Variable' => 173,
			'Operator' => 135,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120
		}
	},
	{#State 270
		ACTIONS => {
			'TYPE_INTEGER' => 333
		}
	},
	{#State 271
		ACTIONS => {
			'TYPE_INTEGER' => 334
		}
	},
	{#State 272
		ACTIONS => {
			'WORD' => 54,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 335
		}
	},
	{#State 273
		ACTIONS => {
			'FHREF_SYMBOL' => 336
		}
	},
	{#State 274
		ACTIONS => {
			";" => 338,
			'OP02_ARRAY_THINARROW' => 339,
			'OP19_VARIABLE_ASSIGN' => 337
		}
	},
	{#State 275
		ACTIONS => {
			";" => 340
		}
	},
	{#State 276
		ACTIONS => {
			"}" => 341
		}
	},
	{#State 277
		DEFAULT => -198
	},
	{#State 278
		ACTIONS => {
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 125,
			'MY' => 164,
			'WORD' => 26,
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'SELF' => 133,
			'OP01_QW' => 175,
			'LBRACKET' => 108,
			'OP10_NAMED_UNARY' => 119,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"%{" => 104,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103
		},
		GOTOS => {
			'ListElements' => 342,
			'Expression' => 169,
			'ListElement' => 171,
			'SubExpression' => 170,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120,
			'Operator' => 135,
			'Variable' => 173,
			'TypeInner' => 167,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'WordScoped' => 117
		}
	},
	{#State 279
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP10_NAMED_UNARY' => 119,
			'SELF' => 133,
			'LBRACKET' => 108,
			'OP01_QW' => 175,
			'LITERAL_STRING' => 85,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 125,
			'MY' => 164,
			'WORD' => 26,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'ListElement' => 171,
			'Expression' => 169,
			'ListElements' => 343,
			'SubExpression' => 170,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132,
			'TypeInner' => 167,
			'Variable' => 173,
			'Operator' => 135,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayDereference' => 116,
			'WordScoped' => 117
		}
	},
	{#State 280
		DEFAULT => -142
	},
	{#State 281
		ACTIONS => {
			'OP21_LIST_COMMA' => 344
		}
	},
	{#State 282
		ACTIONS => {
			'OP18_TERNARY' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP21_LIST_COMMA' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP06_REGEX_MATCH' => 221,
			'OP04_MATH_POW' => 220,
			'OP09_BITWISE_SHIFT' => 228,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP07_STRING_REPEAT' => 218,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP14_BITWISE_OR_XOR' => 225,
			"}" => -106,
			'OP17_LIST_RANGE' => undef,
			";" => -106,
			'OP23_LOGICAL_AND' => -106,
			")" => -106,
			"]" => -106,
			'OP08_STRING_CAT' => 216
		}
	},
	{#State 283
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => -96,
			'OP04_MATH_POW' => 220,
			'OP21_LIST_COMMA' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP06_REGEX_MATCH' => 221,
			'OP17_LIST_RANGE' => -96,
			"}" => -96,
			";" => -96,
			"]" => -96,
			'OP08_STRING_CAT' => -96,
			'OP23_LOGICAL_AND' => -96,
			")" => -96,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP07_STRING_REPEAT' => 218,
			'OP13_BITWISE_AND' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP14_BITWISE_OR_XOR' => -96
		}
	},
	{#State 284
		ACTIONS => {
			'OP15_LOGICAL_AND' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP09_BITWISE_SHIFT' => 228,
			'OP04_MATH_POW' => 220,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => -101,
			'OP08_STRING_CAT' => 216,
			"]" => -101,
			")" => -101,
			'OP23_LOGICAL_AND' => -101,
			";" => -101,
			"}" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => -101,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218
		}
	},
	{#State 285
		ACTIONS => {
			"}" => -93,
			";" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP23_LOGICAL_AND' => -93,
			")" => -93,
			"]" => -93,
			'OP08_STRING_CAT' => -93,
			'OP07_STRING_REPEAT' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP18_TERNARY' => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP04_MATH_POW' => 220
		}
	},
	{#State 286
		ACTIONS => {
			'OP07_STRING_REPEAT' => 218,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			"}" => -104,
			";" => -104,
			'OP17_LIST_RANGE' => -104,
			")" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP08_STRING_CAT' => 216,
			"]" => -104,
			'OP18_TERNARY' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP06_REGEX_MATCH' => 221,
			'OP21_LIST_COMMA' => -104,
			'OP04_MATH_POW' => 220,
			'OP09_BITWISE_SHIFT' => 228,
			'OP15_LOGICAL_AND' => -104,
			'OP16_LOGICAL_OR' => -104
		}
	},
	{#State 287
		ACTIONS => {
			'OP07_STRING_REPEAT' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP13_BITWISE_AND' => -89,
			"}" => -89,
			'OP17_LIST_RANGE' => -89,
			";" => -89,
			")" => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP08_STRING_CAT' => -89,
			"]" => -89,
			'OP18_TERNARY' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP06_REGEX_MATCH' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP04_MATH_POW' => 220,
			'OP09_BITWISE_SHIFT' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP16_LOGICAL_OR' => -89
		}
	},
	{#State 288
		DEFAULT => -92
	},
	{#State 289
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 228,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP21_LIST_COMMA' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP06_REGEX_MATCH' => 221,
			'OP04_MATH_POW' => 220,
			"}" => -110,
			";" => -110,
			'OP17_LIST_RANGE' => 215,
			'OP23_LOGICAL_AND' => 223,
			")" => -110,
			"]" => -110,
			'OP08_STRING_CAT' => 216,
			'OP07_STRING_REPEAT' => 218,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 225
		}
	},
	{#State 290
		ACTIONS => {
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP04_MATH_POW' => 220,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP08_STRING_CAT' => 216,
			"]" => -109,
			")" => -109,
			'OP23_LOGICAL_AND' => -109,
			"}" => -109,
			";" => -109,
			'OP17_LIST_RANGE' => 215,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218
		}
	},
	{#State 291
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => -95,
			'OP04_MATH_POW' => 220,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP06_REGEX_MATCH' => 221,
			'OP21_LIST_COMMA' => -95,
			";" => -95,
			"}" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP08_STRING_CAT' => -95,
			"]" => -95,
			")" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP07_STRING_REPEAT' => 218,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP13_BITWISE_AND' => -95
		}
	},
	{#State 292
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => -103,
			";" => -103,
			"}" => -103,
			'OP17_LIST_RANGE' => -103,
			"]" => -103,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => -103,
			")" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => -103,
			'OP04_MATH_POW' => 220,
			'OP21_LIST_COMMA' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP06_REGEX_MATCH' => 221,
			'OP09_BITWISE_SHIFT' => 228,
			'OP16_LOGICAL_OR' => -103,
			'OP15_LOGICAL_AND' => -103
		}
	},
	{#State 293
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 228,
			'OP15_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP18_TERNARY' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP06_REGEX_MATCH' => 221,
			'OP21_LIST_COMMA' => -100,
			'OP04_MATH_POW' => 220,
			"}" => -100,
			";" => -100,
			'OP17_LIST_RANGE' => -100,
			")" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP08_STRING_CAT' => 216,
			"]" => -100,
			'OP07_STRING_REPEAT' => 218,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP08_MATH_ADD_SUB' => 224,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP11_COMPARE_LT_GT' => undef,
			'OP13_BITWISE_AND' => -100
		}
	},
	{#State 294
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			";" => -102,
			"}" => -102,
			'OP17_LIST_RANGE' => -102,
			"]" => -102,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => -102,
			")" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => -102,
			'OP04_MATH_POW' => 220,
			'OP21_LIST_COMMA' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP06_REGEX_MATCH' => 221,
			'OP09_BITWISE_SHIFT' => 228,
			'OP16_LOGICAL_OR' => -102,
			'OP15_LOGICAL_AND' => -102
		}
	},
	{#State 295
		ACTIONS => {
			";" => -97,
			"}" => -97,
			'OP17_LIST_RANGE' => -97,
			"]" => -97,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => -97,
			")" => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218,
			'OP13_BITWISE_AND' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => -97,
			'OP04_MATH_POW' => 220,
			'OP21_LIST_COMMA' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP06_REGEX_MATCH' => 221
		}
	},
	{#State 296
		ACTIONS => {
			'OP18_TERNARY' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP06_REGEX_MATCH' => 221,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 220,
			'OP09_BITWISE_SHIFT' => 228,
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => -105,
			'OP07_STRING_REPEAT' => 218,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			"}" => -105,
			'OP17_LIST_RANGE' => -105,
			";" => -105,
			")" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP08_STRING_CAT' => 216,
			"]" => -105
		}
	},
	{#State 297
		ACTIONS => {
			'OP15_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP04_MATH_POW' => 220,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP18_TERNARY' => -94,
			'OP08_STRING_CAT' => -94,
			"]" => -94,
			")" => -94,
			'OP23_LOGICAL_AND' => -94,
			";" => -94,
			"}" => -94,
			'OP17_LIST_RANGE' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP07_STRING_REPEAT' => 218
		}
	},
	{#State 298
		ACTIONS => {
			'COLON' => 345
		}
	},
	{#State 299
		DEFAULT => -224
	},
	{#State 300
		DEFAULT => -223
	},
	{#State 301
		DEFAULT => -222
	},
	{#State 302
		ACTIONS => {
			")" => 347,
			'OP21_LIST_COMMA' => 348
		},
		GOTOS => {
			'PAREN-20' => 346
		}
	},
	{#State 303
		DEFAULT => -50
	},
	{#State 304
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_METHOD' => 349,
			'WORD' => 54,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 305
		DEFAULT => -78
	},
	{#State 306
		ACTIONS => {
			";" => 350
		}
	},
	{#State 307
		DEFAULT => -79
	},
	{#State 308
		DEFAULT => -61
	},
	{#State 309
		ACTIONS => {
			"}" => 351,
			"%{" => 104,
			'WORD' => 352
		},
		GOTOS => {
			'HashDereference' => 354,
			'HashEntryTyped' => 353
		}
	},
	{#State 310
		ACTIONS => {
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP07_STRING_REPEAT' => 218,
			"]" => 355,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => 223,
			'OP17_LIST_RANGE' => 215,
			'OP04_MATH_POW' => 220,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228
		}
	},
	{#State 311
		ACTIONS => {
			'OP07_STRING_REPEAT' => 218,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 215,
			"}" => 356,
			'OP23_LOGICAL_AND' => 223,
			'OP08_STRING_CAT' => 216,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP04_MATH_POW' => 220,
			'OP09_BITWISE_SHIFT' => 228,
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229
		}
	},
	{#State 312
		ACTIONS => {
			'SCOPE' => -215,
			'OP02_METHOD_THINARROW_NEW' => -215,
			'LPAREN' => -215,
			"}" => 357
		}
	},
	{#State 313
		ACTIONS => {
			")" => 358
		}
	},
	{#State 314
		DEFAULT => -126
	},
	{#State 315
		DEFAULT => -209
	},
	{#State 316
		ACTIONS => {
			'LITERAL_STRING' => 85,
			"%{" => 104,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 114,
			'SELF' => 133,
			'WORD' => 157
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 161,
			'VariableOrLiteralOrWord' => 162,
			'Variable' => 159,
			'HashEntry' => 359,
			'Literal' => 158
		}
	},
	{#State 317
		DEFAULT => -207
	},
	{#State 318
		DEFAULT => -200
	},
	{#State 319
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133,
			'OP10_NAMED_UNARY' => 119,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121
		},
		GOTOS => {
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'SubExpression' => 360,
			'Expression' => 169,
			'Operator' => 135,
			'Variable' => 173,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132
		}
	},
	{#State 320
		ACTIONS => {
			'WORD' => 361
		}
	},
	{#State 321
		DEFAULT => -214
	},
	{#State 322
		ACTIONS => {
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'OP10_NAMED_UNARY' => 119,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'OP01_QW' => 175,
			'SELF' => 133,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'WORD' => 26,
			'MY' => 164,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'SubExpression' => 170,
			'ListElement' => 362,
			'Expression' => 169,
			'Variable' => 173,
			'TypeInner' => 167,
			'Operator' => 135,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'WordScoped' => 117,
			'ArrayDereference' => 116
		}
	},
	{#State 323
		DEFAULT => -185
	},
	{#State 324
		DEFAULT => -192
	},
	{#State 325
		DEFAULT => -188
	},
	{#State 326
		DEFAULT => -119
	},
	{#State 327
		ACTIONS => {
			'LBRACE' => 364
		},
		GOTOS => {
			'CodeBlock' => 363
		}
	},
	{#State 328
		ACTIONS => {
			")" => 365
		}
	},
	{#State 329
		DEFAULT => -129
	},
	{#State 330
		DEFAULT => -117
	},
	{#State 331
		DEFAULT => -116
	},
	{#State 332
		ACTIONS => {
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP04_MATH_POW' => 220,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP23_LOGICAL_AND' => 223,
			")" => 366,
			'OP08_STRING_CAT' => 216,
			'OP17_LIST_RANGE' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP07_STRING_REPEAT' => 218,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217
		}
	},
	{#State 333
		ACTIONS => {
			'VARIABLE_SYMBOL' => 367
		}
	},
	{#State 334
		ACTIONS => {
			'VARIABLE_SYMBOL' => 368
		}
	},
	{#State 335
		ACTIONS => {
			'VARIABLE_SYMBOL' => 369
		}
	},
	{#State 336
		ACTIONS => {
			'OP21_LIST_COMMA' => 370
		}
	},
	{#State 337
		ACTIONS => {
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133,
			'STDIN' => 244,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'WORD' => 26,
			'OP01_OPEN' => 125
		},
		GOTOS => {
			'SubExpression' => 245,
			'SubExpressionOrStdin' => 371,
			'Expression' => 169,
			'Variable' => 173,
			'Operator' => 135,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Literal' => 101,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'WordScoped' => 117,
			'ArrayDereference' => 116
		}
	},
	{#State 338
		DEFAULT => -178
	},
	{#State 339
		ACTIONS => {
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'OP10_NAMED_UNARY' => 119,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93
		},
		GOTOS => {
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'Variable' => 173,
			'Operator' => 135,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'SubExpression' => 372,
			'Expression' => 169
		}
	},
	{#State 340
		DEFAULT => -181
	},
	{#State 341
		DEFAULT => -199
	},
	{#State 342
		ACTIONS => {
			";" => 373
		}
	},
	{#State 343
		ACTIONS => {
			")" => 374
		}
	},
	{#State 344
		ACTIONS => {
			'OP01_OPEN' => 125,
			'WORD' => 26,
			'MY' => 164,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'SELF' => 133,
			'LBRACKET' => 108,
			'OP01_QW' => 175,
			'LITERAL_STRING' => 85,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'VARIABLE_SYMBOL' => 114,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'OP10_NAMED_UNARY' => 119,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'SubExpression' => 170,
			'ListElement' => 171,
			'Expression' => 169,
			'ListElements' => 375,
			'TypeInner' => 167,
			'Variable' => 173,
			'Operator' => 135,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120
		}
	},
	{#State 345
		ACTIONS => {
			'SELF' => 133,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Literal' => 299,
			'Variable' => 300,
			'VariableOrLiteral' => 376,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 346
		DEFAULT => -52
	},
	{#State 347
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 348
		ACTIONS => {
			'MY' => 378
		}
	},
	{#State 349
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 350
		DEFAULT => -63
	},
	{#State 351
		ACTIONS => {
			";" => 380
		}
	},
	{#State 352
		ACTIONS => {
			'OP20_HASH_FATARROW' => 381
		}
	},
	{#State 353
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 382
		}
	},
	{#State 354
		DEFAULT => -205
	},
	{#State 355
		DEFAULT => -175
	},
	{#State 356
		DEFAULT => -176
	},
	{#State 357
		DEFAULT => -177
	},
	{#State 358
		DEFAULT => -132
	},
	{#State 359
		DEFAULT => -206
	},
	{#State 360
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP07_STRING_REPEAT' => 218,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => 223,
			"}" => -202,
			'OP17_LIST_RANGE' => 215,
			'OP04_MATH_POW' => 220,
			'OP21_LIST_COMMA' => -202,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228
		}
	},
	{#State 361
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 383
		}
	},
	{#State 362
		DEFAULT => -184
	},
	{#State 363
		DEFAULT => -157,
		GOTOS => {
			'STAR-40' => 384
		}
	},
	{#State 364
		ACTIONS => {
			'LBRACKET' => 108,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'VARIABLE_SYMBOL' => 114,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'WORD' => 26,
			'OP01_NAMED_VOID' => 105,
			'LITERAL_NUMBER' => 84,
			'LBRACE' => 103,
			"%{" => 104,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 95,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			"foreach" => -149,
			'OP19_LOOP_CONTROL' => 98,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'SELF' => 133,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'MY' => 127,
			'OP01_OPEN' => 125,
			'OP01_NAMED' => 129,
			"while" => -149,
			"\@{" => 128,
			"for" => -149,
			'OP01_PRINT' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'OP05_MATH_NEG_LPAREN' => 118,
			"if" => 115,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'PLUS-43' => 386,
			'HashReference' => 132,
			'Operator' => 135,
			'Conditional' => 137,
			'VariableDeclaration' => 109,
			'SubExpression' => 139,
			'VariableModification' => 111,
			'LoopLabel' => 106,
			'OperatorVoid' => 126,
			'Statement' => 130,
			'HashDereference' => 131,
			'Literal' => 101,
			'ArrayReference' => 120,
			'Variable' => 102,
			'Expression' => 123,
			'OPTIONAL-38' => 124,
			'ArrayDereference' => 116,
			'PAREN-37' => 94,
			'Operation' => 385,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 365
		DEFAULT => -131
	},
	{#State 366
		ACTIONS => {
			'LBRACE' => 364
		},
		GOTOS => {
			'CodeBlock' => 387
		}
	},
	{#State 367
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 388
		}
	},
	{#State 368
		ACTIONS => {
			'LPAREN' => 389
		}
	},
	{#State 369
		ACTIONS => {
			'LPAREN' => 390
		}
	},
	{#State 370
		ACTIONS => {
			'LITERAL_STRING' => 391
		}
	},
	{#State 371
		ACTIONS => {
			";" => 392
		}
	},
	{#State 372
		ACTIONS => {
			'OP04_MATH_POW' => 220,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP07_STRING_REPEAT' => 218,
			"]" => 393,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => 223,
			'OP17_LIST_RANGE' => 215
		}
	},
	{#State 373
		DEFAULT => -121
	},
	{#State 374
		DEFAULT => -82
	},
	{#State 375
		ACTIONS => {
			")" => 394
		}
	},
	{#State 376
		DEFAULT => -107
	},
	{#State 377
		ACTIONS => {
			"\@_;" => 395
		}
	},
	{#State 378
		ACTIONS => {
			'WORD' => 54,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 396
		}
	},
	{#State 379
		ACTIONS => {
			"= sub {" => 397
		}
	},
	{#State 380
		DEFAULT => -68
	},
	{#State 381
		ACTIONS => {
			'MY' => 164
		},
		GOTOS => {
			'TypeInner' => 398
		}
	},
	{#State 382
		ACTIONS => {
			'OP21_LIST_COMMA' => 401,
			"}" => 400
		},
		GOTOS => {
			'PAREN-26' => 399
		}
	},
	{#State 383
		DEFAULT => -221
	},
	{#State 384
		ACTIONS => {
			'WORD' => -160,
			'OP01_NAMED_VOID' => -160,
			'LITERAL_NUMBER' => -160,
			"elsif" => 403,
			'LBRACKET' => -160,
			'OP01_NAMED_VOID_LPAREN' => -160,
			'OP22_LOGICAL_NEG' => -160,
			'OP03_MATH_INC_DEC' => -160,
			'VARIABLE_SYMBOL' => -160,
			'OP01_CLOSE' => -160,
			"undef" => -160,
			'WORD_SCOPED' => -160,
			'WORD_UPPERCASE' => -160,
			'OP19_LOOP_CONTROL_SCOLON' => -160,
			"}" => -160,
			"foreach" => -160,
			'OP19_LOOP_CONTROL' => -160,
			'LBRACE' => -160,
			"%{" => -160,
			'MY' => -160,
			'OP01_OPEN' => -160,
			"\@{" => -160,
			"for" => -160,
			"while" => -160,
			'OP01_NAMED' => -160,
			'OP01_NAMED_VOID_SCOLON' => -160,
			'SELF' => -160,
			'LPAREN' => -160,
			'' => -160,
			'LITERAL_STRING' => -160,
			'OP05_MATH_NEG_LPAREN' => -160,
			"if" => -160,
			"else" => 406,
			'OP10_NAMED_UNARY' => -160,
			'OP01_PRINT' => -160,
			'OP05_LOGICAL_NEG' => -160
		},
		GOTOS => {
			'PAREN-39' => 405,
			'OPTIONAL-42' => 404,
			'PAREN-41' => 402
		}
	},
	{#State 385
		DEFAULT => -170
	},
	{#State 386
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 121,
			'OP01_PRINT' => 122,
			"if" => 115,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP10_NAMED_UNARY' => 119,
			'SELF' => 133,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'LITERAL_STRING' => 85,
			'LPAREN' => 138,
			'OP01_OPEN' => 125,
			'MY' => 127,
			"while" => -149,
			'OP01_NAMED' => 129,
			"for" => -149,
			"\@{" => 128,
			'LBRACE' => 103,
			"%{" => 104,
			'WORD_UPPERCASE' => 95,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP01_CLOSE' => 97,
			'OP19_LOOP_CONTROL' => 98,
			"foreach" => -149,
			"}" => 408,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'LBRACKET' => 108,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'OP01_NAMED_VOID' => 105,
			'WORD' => 26,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'HashDereference' => 131,
			'Statement' => 130,
			'LoopLabel' => 106,
			'OperatorVoid' => 126,
			'VariableDeclaration' => 109,
			'Conditional' => 137,
			'VariableModification' => 111,
			'SubExpression' => 139,
			'HashReference' => 132,
			'Operator' => 135,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'PAREN-37' => 94,
			'Operation' => 407,
			'WordScoped' => 117,
			'Expression' => 123,
			'OPTIONAL-38' => 124,
			'Literal' => 101,
			'ArrayReference' => 120,
			'Variable' => 102
		}
	},
	{#State 387
		DEFAULT => -168
	},
	{#State 388
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 119,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACKET' => 108,
			'SELF' => 133,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132,
			'Operator' => 135,
			'Variable' => 173,
			'Expression' => 169,
			'SubExpression' => 409,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100
		}
	},
	{#State 389
		ACTIONS => {
			'SELF' => 133,
			'LBRACKET' => 108,
			'LITERAL_STRING' => 85,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'OP01_OPEN' => 125,
			'WORD' => 26,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'SubExpression' => 410,
			'Expression' => 169,
			'Operator' => 135,
			'Variable' => 173,
			'HashReference' => 132,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 100,
			'WordScoped' => 117,
			'ArrayDereference' => 116
		}
	},
	{#State 390
		ACTIONS => {
			'OP01_OPEN' => 125,
			'MY' => 164,
			'WORD' => 26,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LITERAL_NUMBER' => 84,
			'SELF' => 133,
			'OP01_QW' => 175,
			'LBRACKET' => 108,
			'LITERAL_STRING' => 85,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP10_NAMED_UNARY' => 119,
			'OP05_LOGICAL_NEG' => 121,
			'LBRACE' => 103,
			"%{" => 104
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132,
			'Variable' => 173,
			'TypeInner' => 167,
			'Operator' => 135,
			'ListElement' => 171,
			'ListElements' => 411,
			'Expression' => 169,
			'SubExpression' => 170
		}
	},
	{#State 391
		ACTIONS => {
			'OP21_LIST_COMMA' => 412
		}
	},
	{#State 392
		DEFAULT => -179
	},
	{#State 393
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 413
		}
	},
	{#State 394
		DEFAULT => -84
	},
	{#State 395
		DEFAULT => -54
	},
	{#State 396
		ACTIONS => {
			'VARIABLE_SYMBOL' => 414
		}
	},
	{#State 397
		ACTIONS => {
			'SELF' => -70,
			'OP01_NAMED_VOID_SCOLON' => -70,
			'LITERAL_STRING' => -70,
			'LPAREN' => -70,
			'OP01_OPEN' => -70,
			'MY' => -70,
			"\@{" => -70,
			"for" => -70,
			'OP01_NAMED' => -70,
			"while" => -70,
			'OP05_LOGICAL_NEG' => -70,
			'LPAREN_MY' => 415,
			'OP01_PRINT' => -70,
			"if" => -70,
			'OP05_MATH_NEG_LPAREN' => -70,
			'OP10_NAMED_UNARY' => -70,
			'OP01_NAMED_VOID_LPAREN' => -70,
			'LBRACKET' => -70,
			'OP22_LOGICAL_NEG' => -70,
			'OP03_MATH_INC_DEC' => -70,
			'VARIABLE_SYMBOL' => -70,
			'OP01_NAMED_VOID' => -70,
			'WORD' => -70,
			'LITERAL_NUMBER' => -70,
			'LBRACE' => -70,
			"%{" => -70,
			"undef" => -70,
			'WORD_UPPERCASE' => -70,
			'WORD_SCOPED' => -70,
			'OP01_CLOSE' => -70,
			"foreach" => -70,
			'OP19_LOOP_CONTROL' => -70,
			'OP19_LOOP_CONTROL_SCOLON' => -70,
			"}" => -70
		},
		GOTOS => {
			'OPTIONAL-28' => 416,
			'MethodArguments' => 417
		}
	},
	{#State 398
		ACTIONS => {
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'OP10_NAMED_UNARY' => 119,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'Expression' => 169,
			'SubExpression' => 418,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Variable' => 173,
			'Operator' => 135
		}
	},
	{#State 399
		DEFAULT => -65
	},
	{#State 400
		ACTIONS => {
			";" => 419
		}
	},
	{#State 401
		ACTIONS => {
			"%{" => 104,
			'WORD' => 352
		},
		GOTOS => {
			'HashEntryTyped' => 420,
			'HashDereference' => 354
		}
	},
	{#State 402
		DEFAULT => -159
	},
	{#State 403
		ACTIONS => {
			'LPAREN' => 421
		}
	},
	{#State 404
		DEFAULT => -161
	},
	{#State 405
		DEFAULT => -156
	},
	{#State 406
		ACTIONS => {
			'LBRACE' => 364
		},
		GOTOS => {
			'CodeBlock' => 422
		}
	},
	{#State 407
		DEFAULT => -169
	},
	{#State 408
		DEFAULT => -171
	},
	{#State 409
		ACTIONS => {
			'OP23_LOGICAL_AND' => 223,
			'OP08_STRING_CAT' => 216,
			";" => 423,
			'OP17_LIST_RANGE' => 215,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP07_STRING_REPEAT' => 218,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP04_MATH_POW' => 220,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230
		}
	},
	{#State 410
		ACTIONS => {
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP04_MATH_POW' => 220,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => 223,
			'OP17_LIST_RANGE' => 424,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218
		}
	},
	{#State 411
		ACTIONS => {
			")" => 425
		}
	},
	{#State 412
		ACTIONS => {
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'ArrayReference' => 120,
			'HashReference' => 132,
			'Literal' => 101,
			'Variable' => 173,
			'Operator' => 135,
			'Expression' => 169,
			'SubExpression' => 426,
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131
		}
	},
	{#State 413
		ACTIONS => {
			"undef" => 427
		}
	},
	{#State 414
		DEFAULT => -51
	},
	{#State 415
		ACTIONS => {
			'WORD' => 54,
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 428
		}
	},
	{#State 416
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 429
		}
	},
	{#State 417
		DEFAULT => -69
	},
	{#State 418
		ACTIONS => {
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228,
			'OP04_MATH_POW' => 220,
			'OP21_LIST_COMMA' => -204,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => 223,
			'OP17_LIST_RANGE' => 215,
			"}" => -204,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP07_STRING_REPEAT' => 218
		}
	},
	{#State 419
		DEFAULT => -67
	},
	{#State 420
		DEFAULT => -64
	},
	{#State 421
		ACTIONS => {
			'OP10_NAMED_UNARY' => 119,
			'OP01_CLOSE' => 97,
			'OP05_MATH_NEG_LPAREN' => 118,
			"undef" => 93,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'OP22_LOGICAL_NEG' => 112,
			'LPAREN' => 138,
			'OP03_MATH_INC_DEC' => 113,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'WordScoped' => 117,
			'ArrayDereference' => 116,
			'SubExpression' => 430,
			'Expression' => 169,
			'Variable' => 173,
			'Operator' => 135,
			'Literal' => 101,
			'HashReference' => 132,
			'ArrayReference' => 120
		}
	},
	{#State 422
		DEFAULT => -158
	},
	{#State 423
		ACTIONS => {
			'VARIABLE_SYMBOL' => 431
		}
	},
	{#State 424
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 108,
			'SELF' => 133,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			"%{" => 104,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'ArrayReference' => 120,
			'Literal' => 101,
			'HashReference' => 132,
			'Variable' => 173,
			'Operator' => 135,
			'Expression' => 169,
			'SubExpression' => 432
		}
	},
	{#State 425
		ACTIONS => {
			'LBRACE' => 364
		},
		GOTOS => {
			'CodeBlock' => 433
		}
	},
	{#State 426
		ACTIONS => {
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => 220,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP07_STRING_REPEAT' => 218,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			")" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP08_STRING_CAT' => 216,
			"]" => -85,
			"}" => -85,
			";" => -85,
			'OP17_LIST_RANGE' => 215
		}
	},
	{#State 427
		ACTIONS => {
			";" => 434
		}
	},
	{#State 428
		ACTIONS => {
			'SELF' => 435
		}
	},
	{#State 429
		ACTIONS => {
			'OP01_PRINT' => 122,
			'OP05_LOGICAL_NEG' => 121,
			'OP10_NAMED_UNARY' => 119,
			'OP05_MATH_NEG_LPAREN' => 118,
			"if" => 115,
			'LPAREN' => 138,
			'LITERAL_STRING' => 85,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'SELF' => 133,
			"for" => -149,
			"\@{" => 128,
			'OP01_NAMED' => 129,
			"while" => -149,
			'MY' => 127,
			'OP01_OPEN' => 125,
			"%{" => 104,
			'LBRACE' => 103,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			"}" => 437,
			"foreach" => -149,
			'OP19_LOOP_CONTROL' => 98,
			'OP01_CLOSE' => 97,
			"undef" => 93,
			'WORD_UPPERCASE' => 95,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 113,
			'OP22_LOGICAL_NEG' => 112,
			'VARIABLE_SYMBOL' => 114,
			'LBRACKET' => 108,
			'OP01_NAMED_VOID_LPAREN' => 107,
			'LITERAL_NUMBER' => 84,
			'WORD' => 26,
			'OP01_NAMED_VOID' => 105
		},
		GOTOS => {
			'HashDereference' => 131,
			'Statement' => 130,
			'LoopLabel' => 106,
			'OperatorVoid' => 126,
			'VariableDeclaration' => 109,
			'Conditional' => 137,
			'VariableModification' => 111,
			'SubExpression' => 139,
			'HashReference' => 132,
			'Operator' => 135,
			'VariableSymbolOrSelf' => 100,
			'ArrayDereference' => 116,
			'PAREN-37' => 94,
			'Operation' => 436,
			'WordScoped' => 117,
			'Expression' => 123,
			'OPTIONAL-38' => 124,
			'Literal' => 101,
			'ArrayReference' => 120,
			'Variable' => 102
		}
	},
	{#State 430
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP04_MATH_POW' => 220,
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP09_BITWISE_SHIFT' => 228,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP07_STRING_REPEAT' => 218,
			'OP08_MATH_ADD_SUB' => 224,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP23_LOGICAL_AND' => 223,
			")" => 438,
			'OP08_STRING_CAT' => 216,
			'OP17_LIST_RANGE' => 215
		}
	},
	{#State 431
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 439
		}
	},
	{#State 432
		ACTIONS => {
			'OP15_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 229,
			'OP09_BITWISE_SHIFT' => 228,
			'OP04_MATH_POW' => 220,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => -106,
			'OP08_STRING_CAT' => 216,
			")" => 440,
			'OP23_LOGICAL_AND' => -106,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218
		}
	},
	{#State 433
		DEFAULT => -167
	},
	{#State 434
		DEFAULT => -180
	},
	{#State 435
		DEFAULT => -76,
		GOTOS => {
			'STAR-31' => 441
		}
	},
	{#State 436
		DEFAULT => -71
	},
	{#State 437
		ACTIONS => {
			";" => 442
		}
	},
	{#State 438
		ACTIONS => {
			'LBRACE' => 364
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 439
		ACTIONS => {
			'LBRACKET' => 108,
			'SELF' => 133,
			'VARIABLE_SYMBOL' => 114,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'OP22_LOGICAL_NEG' => 112,
			'LITERAL_STRING' => 85,
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 172,
			"\@{" => 128,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 174,
			"undef" => 93,
			'OP10_NAMED_UNARY' => 119
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'WordScoped' => 117,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'HashReference' => 132,
			'Literal' => 101,
			'ArrayReference' => 120,
			'Variable' => 173,
			'Operator' => 135,
			'Expression' => 169,
			'SubExpression' => 444
		}
	},
	{#State 440
		ACTIONS => {
			'LBRACE' => 364
		},
		GOTOS => {
			'CodeBlock' => 445
		}
	},
	{#State 441
		ACTIONS => {
			'OP21_LIST_COMMA' => 446,
			")" => 447
		},
		GOTOS => {
			'PAREN-30' => 448
		}
	},
	{#State 442
		DEFAULT => -73
	},
	{#State 443
		DEFAULT => -155
	},
	{#State 444
		ACTIONS => {
			'OP18_TERNARY' => 231,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP06_REGEX_MATCH' => 221,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP04_MATH_POW' => 220,
			'OP09_BITWISE_SHIFT' => 228,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219,
			'OP07_STRING_REPEAT' => 218,
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP13_BITWISE_AND' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 225,
			";" => 449,
			'OP17_LIST_RANGE' => 215,
			'OP23_LOGICAL_AND' => 223,
			'OP08_STRING_CAT' => 216
		}
	},
	{#State 445
		DEFAULT => -165
	},
	{#State 446
		ACTIONS => {
			'MY' => 450
		}
	},
	{#State 447
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 451
		}
	},
	{#State 448
		DEFAULT => -75
	},
	{#State 449
		ACTIONS => {
			'WORD' => 26,
			'OP01_OPEN' => 125,
			'LITERAL_NUMBER' => 84,
			"\@{" => 128,
			'OP01_NAMED' => 172,
			'LBRACKET' => 108,
			'SELF' => 133,
			'OP22_LOGICAL_NEG' => 112,
			'OP03_MATH_INC_DEC' => 113,
			'LPAREN' => 138,
			'VARIABLE_SYMBOL' => 114,
			'LITERAL_STRING' => 85,
			'OP05_MATH_NEG_LPAREN' => 118,
			'OP01_CLOSE' => 97,
			"undef" => 93,
			'WORD_UPPERCASE' => 174,
			'WORD_SCOPED' => 27,
			'OP10_NAMED_UNARY' => 119,
			'LBRACE' => 103,
			'OP05_LOGICAL_NEG' => 121,
			"%{" => 104
		},
		GOTOS => {
			'SubExpression' => 454,
			'SubExpressionOrVarMod' => 453,
			'VariableModification' => 452,
			'Expression' => 169,
			'Variable' => 102,
			'Operator' => 135,
			'Literal' => 101,
			'ArrayReference' => 120,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 100,
			'HashDereference' => 131,
			'WordScoped' => 117,
			'ArrayDereference' => 116
		}
	},
	{#State 450
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 55,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 455
		}
	},
	{#State 451
		ACTIONS => {
			"\@_;" => 456
		}
	},
	{#State 452
		DEFAULT => -146
	},
	{#State 453
		ACTIONS => {
			")" => 457
		}
	},
	{#State 454
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 217,
			'OP08_MATH_ADD_SUB' => 224,
			'OP07_STRING_REPEAT' => 218,
			'OP11_COMPARE_LT_GT' => 226,
			'OP13_BITWISE_AND' => 227,
			'OP14_BITWISE_OR_XOR' => 225,
			'OP17_LIST_RANGE' => 215,
			'OP08_STRING_CAT' => 216,
			'OP23_LOGICAL_AND' => 223,
			")" => -145,
			'OP07_MATH_MULT_DIV_MOD' => 230,
			'OP18_TERNARY' => 231,
			'OP04_MATH_POW' => 220,
			'OP24_LOGICAL_OR_XOR' => 222,
			'OP06_REGEX_MATCH' => 221,
			'OP09_BITWISE_SHIFT' => 228,
			'OP16_LOGICAL_OR' => 229,
			'OP15_LOGICAL_AND' => 219
		}
	},
	{#State 455
		ACTIONS => {
			'VARIABLE_SYMBOL' => 458
		}
	},
	{#State 456
		DEFAULT => -77
	},
	{#State 457
		ACTIONS => {
			'LBRACE' => 364
		},
		GOTOS => {
			'CodeBlock' => 459
		}
	},
	{#State 458
		DEFAULT => -74
	},
	{#State 459
		DEFAULT => -166
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6383 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6390 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6397 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6404 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6415 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6426 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6433 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6440 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6447 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6454 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6461 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6468 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6475 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6482 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6489 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6496 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6503 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6521 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6528 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6535 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6542 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6549 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6560 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6571 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6589 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6603 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6610 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6617 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6624 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6638 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6663 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6674 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6688 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6699 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6706 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6713 lib/RPerl/Grammar.pm
	],
	[#Rule Include_43
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule Include_44
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6735 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_45
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6746 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6753 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6760 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6767 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_50
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6785 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6792 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6799 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6806 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_54
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6845 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6852 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6859 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6866 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6873 lib/RPerl/Grammar.pm
	],
	[#Rule Class_63
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6891 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6898 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6905 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_67
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6916 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_68
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6927 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6934 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6941 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6948 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6955 lib/RPerl/Grammar.pm
	],
	[#Rule Method_73
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 4,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6987 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_77
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6998 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_78
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7009 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_79
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7020 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7031 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7042 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7053 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7075 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7086 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7108 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7119 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7130 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7141 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7152 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7163 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7174 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7185 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7196 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7218 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7251 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7262 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7284 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7295 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7306 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7368 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7375 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7382 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7389 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7418 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7473 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7484 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7512 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7523 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7534 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7545 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7556 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7567 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7578 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7600 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7611 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7622 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7633 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7644 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7655 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7666 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7677 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_143
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7688 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_144
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7699 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_145
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7710 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_146
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7721 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7728 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7735 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7742 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7753 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7764 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7775 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7786 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7797 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 5,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7804 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7811 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7818 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7825 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7832 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7839 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_161
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7850 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7861 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7872 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7883 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_165
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7894 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 14,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7905 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_167
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7916 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_168
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7927 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7934 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7941 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_171
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7966 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_174
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7977 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7988 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7999 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8010 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8021 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8032 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8043 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8054 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8065 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8076 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8083 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8090 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8097 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_187
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8108 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8115 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8122 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8133 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8144 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8155 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8162 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8169 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_195
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8180 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8187 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8194 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_198
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8205 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_199
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8216 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8223 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8230 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8241 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8252 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_204
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8263 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_205
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8274 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8281 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8288 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8295 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_209
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8306 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8317 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8324 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8331 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_213
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8342 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_214
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8353 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_215
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8364 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8375 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_217
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8386 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8397 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8408 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8419 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_221
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8430 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_222
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8441 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_223
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8452 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_224
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8463 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_225
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8474 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_226
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8485 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_227
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8496 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_228
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8507 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_229
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8518 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_230
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8529 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_231
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8540 lib/RPerl/Grammar.pm
	]
],
#line 8543 lib/RPerl/Grammar.pm
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
         'SubExpressionOrVarMod_145', 
         'SubExpressionOrVarMod_146', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_150', 
         'Statement_151', 
         'Statement_152', 
         'Statement_153', 
         'Statement_154', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_161', 
         'Loop_162', 
         'Loop_163', 
         'Loop_164', 
         'LoopFor_165', 
         'LoopFor_166', 
         'LoopForEach_167', 
         'LoopWhile_168', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_171', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_174', 
         'VariableRetrieval_175', 
         'VariableRetrieval_176', 
         'VariableRetrieval_177', 
         'VariableDeclaration_178', 
         'VariableDeclaration_179', 
         'VariableDeclaration_180', 
         'VariableDeclaration_181', 
         'VariableModification_182', 
         'VariableModification_183', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_187', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElement_190', 
         'ListElement_191', 
         'ListElement_192', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_195', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_198', 
         'ArrayDereference_199', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_202', 
         'HashEntry_203', 
         'HashEntryTyped_204', 
         'HashEntryTyped_205', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_209', 
         'HashReference_210', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_213', 
         'HashDereference_214', 
         'WordScoped_215', 
         'WordScoped_216', 
         'LoopLabel_217', 
         'Type_218', 
         'Type_219', 
         'Type_220', 
         'TypeInner_221', 
         'TypeInnerConstant_222', 
         'VariableOrLiteral_223', 
         'VariableOrLiteral_224', 
         'VariableOrLiteralOrWord_225', 
         'VariableOrLiteralOrWord_226', 
         'VariableOrLiteralOrWord_227', 
         'VariableSymbolOrSelf_228', 
         'VariableSymbolOrSelf_229', 
         'Literal_230', 
         'Literal_231', );
  $self;
}

#line 219 "lib/RPerl/Grammar.eyp"


{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, use the following process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run scripts/grammar_recompile.sh
# 3. Run new & existing grammar parse-only tests
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
SubExpressionOrVarMod_145 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_146 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_150 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_151 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_152 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_153 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_154 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_161 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_162 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_163 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_164 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_165 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_166 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpression ';' VARIABLE_SYMBOL OP11_COMPARE_LT_GT SubExpression ';' SubExpressionOrVarMod ')' CodeBlock
LoopForEach_167 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_168 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
CodeBlock_171 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_174 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_175 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_176 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_177 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_178 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_179 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableDeclaration_180 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_181 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_182 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrStdin
VariableModification_183 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_187 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_190 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_191 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_192 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW PLUS-44 ')'
ArrayReference_195 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_198 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_199 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_202 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_203 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntryTyped_204 => 'RPerl::DataStructure::Hash::EntryTyped',                                 # HashEntryTyped -> WORD OP20_HASH_FATARROW TypeInner SubExpression
HashEntryTyped_205 => 'RPerl::Operation::Expression::SubExpression::HashDereference',           # HashEntryTyped -> HashDereference
HashReference_209 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_210 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_213 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_214 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_215 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_216 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_217 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_218 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_219 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_220 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_221 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_222 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_223 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_224 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_225 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_226 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_227 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
VariableSymbolOrSelf_228 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_229 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_230 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_231 => 'RPerl::Operation::Expression::SubExpression::Literal::String'                   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8949 lib/RPerl/Grammar.pm



1;
