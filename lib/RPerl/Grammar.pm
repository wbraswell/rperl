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
    our $VERSION = 0.001_930;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\=\ sub\ \{|\$TYPED_|package|foreach|elsif|while|undef|else|\@_\;|for|our|if|\@\{|\%\{|\]|\}|\;|\))}gc and return ($1, $1);

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
      /\G((?:[a-zA-Z]\w*)(?:::[a-zA-Z]\w*)*(?:::[A-Z0-9_]*)\(\))/gc and return ('CONSTANT_CALL_SCOPED', $1);
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
  [ '_PAREN' => 'PAREN-26', [ 'OP21_LIST_COMMA', 'HashEntryProperties' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'PAREN-26' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'Properties_67' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryProperties', 'STAR-27', '}', ';' ], 0 ],
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
  [ 'Expression_129' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
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
  [ 'HashEntryProperties_204' => 'HashEntryProperties', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-51', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [ 'STAR-52', 'PAREN-51' ], 0 ],
  [ '_STAR_LIST' => 'STAR-52', [  ], 0 ],
  [ 'HashReference_208' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-52', '}' ], 0 ],
  [ 'HashReference_209' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-53', [  ], 0 ],
  [ 'HashDereference_212' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_213' => 'HashDereference', [ '%{', 'OPTIONAL-53', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_214' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_215' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_216' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_217' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_218' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_219' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_220' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_221' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_222' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_223' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_224' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_225' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_226' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_227' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_228' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'VariableSymbolOrSelf_229' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_230' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_231' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_232' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'HashEntryProperties_204' => 204,
  '_PAREN' => 205,
  '_STAR_LIST' => 206,
  '_STAR_LIST' => 207,
  'HashReference_208' => 208,
  'HashReference_209' => 209,
  '_OPTIONAL' => 210,
  '_OPTIONAL' => 211,
  'HashDereference_212' => 212,
  'HashDereference_213' => 213,
  'WordScoped_214' => 214,
  'WordScoped_215' => 215,
  'LoopLabel_216' => 216,
  'Type_217' => 217,
  'Type_218' => 218,
  'Type_219' => 219,
  'TypeInner_220' => 220,
  'TypeInnerProperties_221' => 221,
  'TypeInnerProperties_222' => 222,
  'TypeInnerConstant_223' => 223,
  'VariableOrLiteral_224' => 224,
  'VariableOrLiteral_225' => 225,
  'VariableOrLiteralOrWord_226' => 226,
  'VariableOrLiteralOrWord_227' => 227,
  'VariableOrLiteralOrWord_228' => 228,
  'VariableSymbolOrSelf_229' => 229,
  'VariableSymbolOrSelf_230' => 230,
  'Literal_231' => 231,
  'Literal_232' => 232,
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
	CONSTANT_CALL_SCOPED => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 8,
			"package" => -20,
			"## no critic qw(" => 7,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'Program' => 2,
			'PAREN-1' => 4,
			'OPTIONAL-9' => 3,
			'CompileUnit' => 1,
			'ModuleHeader' => 5,
			'PLUS-2' => 6,
			'Critic' => 9
		}
	},
	{#State 1
		ACTIONS => {
			'' => 10
		}
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		ACTIONS => {
			'USE_RPERL' => 11,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 12
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'USE' => -27,
			"use parent qw(" => 15,
			"## no critic qw(" => -27,
			"use constant" => -27,
			"our" => -27
		},
		GOTOS => {
			'Class' => 13,
			'Package' => 14,
			'STAR-11' => 17,
			'Module' => 16
		}
	},
	{#State 6
		ACTIONS => {
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 7,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'Critic' => 9,
			'ModuleHeader' => 5,
			'OPTIONAL-9' => 3,
			'PAREN-1' => 18
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 19
		},
		GOTOS => {
			'PLUS-16' => 20
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
		DEFAULT => -19
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -21
	},
	{#State 12
		ACTIONS => {
			"package" => 23
		}
	},
	{#State 13
		DEFAULT => -25
	},
	{#State 14
		DEFAULT => -24
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		ACTIONS => {
			"## no critic qw(" => 7,
			'USE' => -29,
			"our" => -29,
			"use constant" => -29
		},
		GOTOS => {
			'Critic' => 27,
			'STAR-12' => 28
		}
	},
	{#State 18
		DEFAULT => -2
	},
	{#State 19
		DEFAULT => -39
	},
	{#State 20
		ACTIONS => {
			")" => 29,
			'WORD' => 30
		}
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
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 24
		DEFAULT => -215
	},
	{#State 25
		DEFAULT => -214
	},
	{#State 26
		ACTIONS => {
			")" => 33
		}
	},
	{#State 27
		DEFAULT => -26
	},
	{#State 28
		ACTIONS => {
			"use constant" => -31,
			"our" => -31,
			'USE' => 34
		},
		GOTOS => {
			'STAR-13' => 35,
			'Include' => 36
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
		ACTIONS => {
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			";" => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 41
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 42,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 46,
			'Constant' => 43,
			'PLUS-14' => 45
		}
	},
	{#State 36
		DEFAULT => -28
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
			"use strict;" => 38
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 40
		ACTIONS => {
			'USE' => 34
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 41
		ACTIONS => {
			'OP01_QW' => 51,
			";" => 52
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
			'TYPE_INTEGER' => 55,
			'WORD' => 57,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 45
		ACTIONS => {
			'LITERAL_NUMBER' => 59,
			"our" => 44
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 46
		DEFAULT => -33
	},
	{#State 47
		ACTIONS => {
			"for" => -11,
			'LPAREN' => -11,
			'WORD' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_CLOSE' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"if" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_PRINT' => -11,
			'LITERAL_NUMBER' => -11,
			'MY' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'LITERAL_STRING' => -11,
			"our" => -11,
			"## no critic qw(" => 7,
			'OP01_OPEN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"\@{" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'SELF' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'USE' => -11,
			"%{" => -11,
			"foreach" => -11,
			"use constant" => -11,
			'WORD_SCOPED' => -11,
			"undef" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			"while" => -11,
			'VARIABLE_SYMBOL' => -11,
			'LBRACKET' => -11,
			'OP01_NAMED' => -11,
			'WORD_UPPERCASE' => -11
		},
		GOTOS => {
			'STAR-5' => 60,
			'Critic' => 61
		}
	},
	{#State 48
		ACTIONS => {
			"our" => -36,
			'USE_RPERL_AFTER' => 62
		},
		GOTOS => {
			'OPTIONAL-15' => 63
		}
	},
	{#State 49
		DEFAULT => -23
	},
	{#State 50
		DEFAULT => -56,
		GOTOS => {
			'STAR-22' => 64
		}
	},
	{#State 51
		ACTIONS => {
			'WORD' => 66
		},
		GOTOS => {
			'PLUS-17' => 65
		}
	},
	{#State 52
		DEFAULT => -43
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 55
		DEFAULT => -219
	},
	{#State 56
		DEFAULT => -218
	},
	{#State 57
		DEFAULT => -217
	},
	{#State 58
		DEFAULT => -32
	},
	{#State 59
		ACTIONS => {
			";" => 69
		}
	},
	{#State 60
		ACTIONS => {
			'WORD' => -13,
			'LPAREN' => -13,
			"for" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_CLOSE' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"if" => -13,
			'LITERAL_STRING' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'MY' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_PRINT' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_OPEN' => -13,
			"our" => -13,
			"%{" => -13,
			"foreach" => -13,
			'USE' => 34,
			'SELF' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"\@{" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			'LBRACKET' => -13,
			"while" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LBRACE' => -13,
			"use constant" => -13,
			'WORD_SCOPED' => -13,
			"undef" => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED' => -13
		},
		GOTOS => {
			'Include' => 70,
			'STAR-6' => 71
		}
	},
	{#State 61
		DEFAULT => -8
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
			"our hashref \$properties" => -58,
			"use constant" => -58,
			"## no critic qw(" => 7,
			'USE' => -58
		},
		GOTOS => {
			'STAR-23' => 74,
			'Critic' => 73
		}
	},
	{#State 65
		ACTIONS => {
			'WORD' => 75,
			")" => 76
		}
	},
	{#State 66
		DEFAULT => -42
	},
	{#State 67
		ACTIONS => {
			'MY' => 78
		},
		GOTOS => {
			'TypeInnerConstant' => 77
		}
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 79
		}
	},
	{#State 69
		DEFAULT => -34
	},
	{#State 70
		DEFAULT => -10
	},
	{#State 71
		ACTIONS => {
			'OP01_NAMED_VOID' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"for" => -15,
			'LPAREN' => -15,
			'WORD' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY' => -15,
			'MY' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'LITERAL_STRING' => -15,
			'OP01_PRINT' => -15,
			'LITERAL_NUMBER' => -15,
			"if" => -15,
			"\@{" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"%{" => -15,
			"foreach" => -15,
			'SELF' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"our" => -15,
			'OP01_OPEN' => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_NAMED' => -15,
			'LBRACE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"while" => -15,
			'WORD_SCOPED' => -15,
			"undef" => -15,
			"use constant" => 42,
			'LBRACKET' => -15,
			'VARIABLE_SYMBOL' => -15
		},
		GOTOS => {
			'STAR-7' => 80,
			'Constant' => 81
		}
	},
	{#State 72
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 82
		}
	},
	{#State 73
		DEFAULT => -55
	},
	{#State 74
		ACTIONS => {
			"use constant" => -60,
			"our hashref \$properties" => -60,
			'USE' => 34
		},
		GOTOS => {
			'Include' => 83,
			'STAR-24' => 84
		}
	},
	{#State 75
		DEFAULT => -41
	},
	{#State 76
		ACTIONS => {
			";" => 85
		}
	},
	{#State 77
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86
		},
		GOTOS => {
			'Literal' => 88
		}
	},
	{#State 78
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 89
		}
	},
	{#State 79
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -47,
			'OP01_NAMED_VOID' => -47,
			'OP19_LOOP_CONTROL' => -47,
			'OP01_CLOSE' => -47,
			'OP01_NAMED_VOID_SCOLON' => -47,
			"for" => -47,
			'LPAREN' => -47,
			'WORD' => -47,
			'OP10_NAMED_UNARY' => -47,
			'LPAREN_MY' => 92,
			'OP22_LOGICAL_NEG' => -47,
			'OP01_PRINT' => -47,
			'LITERAL_NUMBER' => -47,
			'MY' => -47,
			'CONSTANT_CALL_SCOPED' => -47,
			'LITERAL_STRING' => -47,
			"if" => -47,
			'OP05_LOGICAL_NEG' => -47,
			"\@{" => -47,
			'OP19_LOOP_CONTROL_SCOLON' => -47,
			'OP01_NAMED_VOID_LPAREN' => -47,
			'SELF' => -47,
			"foreach" => -47,
			"%{" => -47,
			"}" => -47,
			'OP01_OPEN' => -47,
			'OP01_NAMED' => -47,
			'WORD_UPPERCASE' => -47,
			"undef" => -47,
			'WORD_SCOPED' => -47,
			'OP05_MATH_NEG_LPAREN' => -47,
			"while" => -47,
			'LBRACE' => -47,
			'VARIABLE_SYMBOL' => -47,
			'LBRACKET' => -47
		},
		GOTOS => {
			'OPTIONAL-18' => 90,
			'SubroutineArguments' => 91
		}
	},
	{#State 80
		ACTIONS => {
			'OP01_PRINT' => 137,
			'LITERAL_NUMBER' => 87,
			'MY' => 135,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			"if" => 131,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_CLOSE' => 125,
			'OP01_NAMED_VOID_SCOLON' => 124,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_NAMED_VOID' => 127,
			'LPAREN' => 122,
			'WORD' => 25,
			"for" => -149,
			'OP01_NAMED' => 119,
			'WORD_UPPERCASE' => 115,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			"while" => -149,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'OP01_NAMED_VOID_LPAREN' => 99,
			'SELF' => 97,
			"foreach" => -149,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP01_OPEN' => 93,
			"our" => 44
		},
		GOTOS => {
			'Literal' => 130,
			'Statement' => 109,
			'Operator' => 106,
			'VariableDeclaration' => 129,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 117,
			'LoopLabel' => 120,
			'Operation' => 116,
			'Variable' => 114,
			'Subroutine' => 132,
			'OPTIONAL-38' => 136,
			'ArrayDereference' => 134,
			'PAREN-37' => 113,
			'ArrayReference' => 94,
			'PLUS-8' => 95,
			'Conditional' => 123,
			'HashDereference' => 121,
			'Expression' => 105,
			'HashReference' => 100,
			'OperatorVoid' => 103,
			'VariableModification' => 98
		}
	},
	{#State 81
		DEFAULT => -12
	},
	{#State 82
		DEFAULT => -37
	},
	{#State 83
		DEFAULT => -57
	},
	{#State 84
		ACTIONS => {
			"use constant" => 42,
			"our hashref \$properties" => 142
		},
		GOTOS => {
			'Properties' => 141,
			'Constant' => 143
		}
	},
	{#State 85
		DEFAULT => -44
	},
	{#State 86
		DEFAULT => -232
	},
	{#State 87
		DEFAULT => -231
	},
	{#State 88
		ACTIONS => {
			";" => 144
		}
	},
	{#State 89
		ACTIONS => {
			"\$TYPED_" => 145
		}
	},
	{#State 90
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 146
		}
	},
	{#State 91
		DEFAULT => -46
	},
	{#State 92
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 147
		}
	},
	{#State 93
		ACTIONS => {
			'MY' => 148
		}
	},
	{#State 94
		DEFAULT => -138
	},
	{#State 95
		ACTIONS => {
			'LPAREN' => 122,
			'WORD' => 25,
			"for" => -149,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_CLOSE' => 125,
			'OP01_NAMED_VOID_SCOLON' => 124,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_NAMED_VOID' => 127,
			'' => -18,
			"if" => 131,
			'OP01_PRINT' => 137,
			'LITERAL_NUMBER' => 87,
			'MY' => 135,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_OPEN' => 93,
			'SELF' => 97,
			'OP01_NAMED_VOID_LPAREN' => 99,
			"%{" => 96,
			"foreach" => -149,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			"while" => -149,
			'LBRACE' => 111,
			'OP01_NAMED' => 119,
			'WORD_UPPERCASE' => 115
		},
		GOTOS => {
			'HashDereference' => 121,
			'ArrayReference' => 94,
			'Conditional' => 123,
			'VariableModification' => 98,
			'Expression' => 105,
			'OperatorVoid' => 103,
			'HashReference' => 100,
			'Statement' => 109,
			'VariableDeclaration' => 129,
			'Operator' => 106,
			'Literal' => 130,
			'Variable' => 114,
			'OPTIONAL-38' => 136,
			'PAREN-37' => 113,
			'ArrayDereference' => 134,
			'LoopLabel' => 120,
			'SubExpression' => 117,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'Operation' => 149
		}
	},
	{#State 96
		ACTIONS => {
			'SELF' => 97,
			'VARIABLE_SYMBOL' => 108,
			'MY' => 153,
			'LBRACE' => -211
		},
		GOTOS => {
			'Variable' => 152,
			'TypeInner' => 150,
			'OPTIONAL-53' => 151,
			'VariableSymbolOrSelf' => 118
		}
	},
	{#State 97
		DEFAULT => -230
	},
	{#State 98
		ACTIONS => {
			";" => 154
		}
	},
	{#State 99
		ACTIONS => {
			'OP01_QW' => 161,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'MY' => 153,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			")" => -115,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'ListElements' => 162,
			'Variable' => 157,
			'HashReference' => 100,
			'SubExpression' => 158,
			'WordScoped' => 138,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'Operator' => 106,
			'HashDereference' => 121,
			'TypeInner' => 155,
			'Literal' => 130,
			'ListElement' => 156,
			'OPTIONAL-34' => 164,
			'ArrayReference' => 94
		}
	},
	{#State 100
		DEFAULT => -140
	},
	{#State 101
		DEFAULT => -122
	},
	{#State 102
		ACTIONS => {
			'SELF' => 97,
			'LBRACKET' => -197,
			'VARIABLE_SYMBOL' => 108,
			'MY' => 153
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 118,
			'OPTIONAL-49' => 167,
			'TypeInner' => 166,
			'Variable' => 165
		}
	},
	{#State 103
		DEFAULT => -152
	},
	{#State 104
		ACTIONS => {
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111
		},
		GOTOS => {
			'Variable' => 157,
			'ArrayDereference' => 134,
			'Expression' => 163,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 168,
			'HashReference' => 100,
			'HashDereference' => 121,
			'Operator' => 106,
			'ArrayReference' => 94,
			'Literal' => 130
		}
	},
	{#State 105
		ACTIONS => {
			'OP06_REGEX_MATCH' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP16_LOGICAL_OR' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP18_TERNARY' => -134,
			";" => 169,
			'OP23_LOGICAL_AND' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP08_STRING_CAT' => -134,
			'OP04_MATH_POW' => -134
		}
	},
	{#State 106
		DEFAULT => -128
	},
	{#State 107
		ACTIONS => {
			'WORD_UPPERCASE' => 160,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'MY' => 153,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			"]" => -194,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			'OP01_QW' => 161,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25
		},
		GOTOS => {
			'OPTIONAL-48' => 170,
			'Operator' => 106,
			'TypeInner' => 155,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94,
			'ListElement' => 156,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'ListElements' => 171,
			'HashReference' => 100,
			'SubExpression' => 158,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'WordScoped' => 138
		}
	},
	{#State 108
		DEFAULT => -229
	},
	{#State 109
		DEFAULT => -81
	},
	{#State 110
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'SubExpression' => 172,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 111
		ACTIONS => {
			"}" => 179,
			'VARIABLE_SYMBOL' => 108,
			"%{" => 96,
			'LITERAL_STRING' => 86,
			'SELF' => 97,
			'WORD' => 175,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 177,
			'Literal' => 173,
			'VariableSymbolOrSelf' => 118,
			'HashEntry' => 178,
			'Variable' => 176,
			'HashDereference' => 174
		}
	},
	{#State 112
		DEFAULT => -135
	},
	{#State 113
		DEFAULT => -148
	},
	{#State 114
		ACTIONS => {
			'OP07_STRING_REPEAT' => -137,
			'OP03_MATH_INC_DEC' => 180,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP04_MATH_POW' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP08_STRING_CAT' => -137,
			'OP02_METHOD_THINARROW' => 182,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP19_VARIABLE_ASSIGN_BY' => 183,
			")" => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP18_TERNARY' => -137,
			'OP19_VARIABLE_ASSIGN' => 181,
			'OP06_REGEX_MATCH' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP16_LOGICAL_OR' => -137
		}
	},
	{#State 115
		ACTIONS => {
			'LPAREN' => 184,
			'COLON' => -216
		}
	},
	{#State 116
		DEFAULT => -17
	},
	{#State 117
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP18_TERNARY' => 188,
			'OP09_BITWISE_SHIFT' => 198,
			'OP06_REGEX_MATCH' => 194,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP17_LIST_RANGE' => 185
		}
	},
	{#State 118
		DEFAULT => -173,
		GOTOS => {
			'STAR-44' => 202
		}
	},
	{#State 119
		ACTIONS => {
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_QW' => 161,
			'OP01_OPEN' => 93,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'LITERAL_NUMBER' => 87,
			'MY' => 153,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160
		},
		GOTOS => {
			'HashReference' => 100,
			'SubExpression' => 203,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'ListElement' => 204,
			'Operator' => 106,
			'TypeInner' => 155,
			'HashDereference' => 121
		}
	},
	{#State 120
		ACTIONS => {
			'COLON' => 205
		}
	},
	{#State 121
		DEFAULT => -141
	},
	{#State 122
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'OP01_PRINT' => 208,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 206,
			'WORD_UPPERCASE' => 160,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'WordScoped' => 138,
			'SubExpression' => 207,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 123
		DEFAULT => -150
	},
	{#State 124
		DEFAULT => -118
	},
	{#State 125
		ACTIONS => {
			'FHREF_SYMBOL' => 209
		}
	},
	{#State 126
		ACTIONS => {
			'WORD_UPPERCASE' => 210
		},
		GOTOS => {
			'LoopLabel' => 211
		}
	},
	{#State 127
		ACTIONS => {
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_QW' => 161,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'MY' => 153,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86
		},
		GOTOS => {
			'Literal' => 130,
			'ListElement' => 156,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'TypeInner' => 155,
			'HashReference' => 100,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'Expression' => 163,
			'SubExpression' => 158,
			'ArrayDereference' => 134,
			'ListElements' => 212,
			'Variable' => 157
		}
	},
	{#State 128
		ACTIONS => {
			'SELF' => 97,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 118,
			'Variable' => 213
		}
	},
	{#State 129
		DEFAULT => -153
	},
	{#State 130
		DEFAULT => -136
	},
	{#State 131
		ACTIONS => {
			'LPAREN' => 214
		}
	},
	{#State 132
		DEFAULT => -14
	},
	{#State 133
		DEFAULT => -130
	},
	{#State 134
		DEFAULT => -139
	},
	{#State 135
		ACTIONS => {
			'TYPE_FHREF' => 215,
			'TYPE_INTEGER' => 55,
			'WORD' => 57,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 216
		}
	},
	{#State 136
		ACTIONS => {
			"foreach" => 223,
			"while" => 220,
			"for" => 217
		},
		GOTOS => {
			'LoopFor' => 222,
			'LoopForEach' => 218,
			'Loop' => 219,
			'LoopWhile' => 221
		}
	},
	{#State 137
		ACTIONS => {
			"\@{" => -113,
			'OP05_LOGICAL_NEG' => -113,
			'OP03_MATH_INC_DEC' => -113,
			"%{" => -113,
			'SELF' => -113,
			'OP01_CLOSE' => -113,
			'STDOUT_STDERR' => 225,
			'OP01_QW' => -113,
			'OP01_OPEN' => -113,
			'LPAREN' => -113,
			'WORD' => -113,
			'WORD_UPPERCASE' => -113,
			'OP10_NAMED_UNARY' => -113,
			'OP22_LOGICAL_NEG' => -113,
			'OP01_NAMED' => -113,
			'MY' => -113,
			'LITERAL_STRING' => -113,
			'CONSTANT_CALL_SCOPED' => -113,
			'LITERAL_NUMBER' => -113,
			'LBRACE' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'FHREF_SYMBOL_BRACES' => 227,
			"undef" => -113,
			'WORD_SCOPED' => -113,
			'LBRACKET' => -113,
			'VARIABLE_SYMBOL' => -113
		},
		GOTOS => {
			'OPTIONAL-33' => 224,
			'PAREN-32' => 226
		}
	},
	{#State 138
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 228,
			'LPAREN' => 229
		}
	},
	{#State 139
		ACTIONS => {
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_OPEN' => 93,
			'WORD' => 25,
			'LPAREN' => 122,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashReference' => 100,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'SubExpression' => 230,
			'Expression' => 163,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121
		}
	},
	{#State 140
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 128,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP04_MATH_POW' => -99,
			'OP01_CLOSE' => 125,
			'OP08_STRING_CAT' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP11_COMPARE_LT_GT' => -99,
			'LITERAL_NUMBER' => 87,
			'OP18_TERNARY' => -99,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP17_LIST_RANGE' => -99,
			"]" => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP07_STRING_REPEAT' => -99,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'SELF' => 97,
			"%{" => 96,
			"}" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP23_LOGICAL_AND' => -99,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 159,
			'OP13_BITWISE_AND' => -99,
			'WORD_UPPERCASE' => 160,
			'OP09_BITWISE_SHIFT' => -99,
			")" => -99,
			";" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP06_REGEX_MATCH' => -99,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP16_LOGICAL_OR' => -99,
			'OP15_LOGICAL_AND' => -99
		},
		GOTOS => {
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106,
			'SubExpression' => 231,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134
		}
	},
	{#State 141
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 232
		}
	},
	{#State 142
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 233
		}
	},
	{#State 143
		DEFAULT => -59
	},
	{#State 144
		DEFAULT => -45
	},
	{#State 145
		ACTIONS => {
			'WORD_UPPERCASE' => 234
		}
	},
	{#State 146
		ACTIONS => {
			'OP01_PRINT' => 137,
			'LITERAL_NUMBER' => 87,
			'MY' => 135,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			"if" => 131,
			'OP01_CLOSE' => 125,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED_VOID_SCOLON' => 124,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_NAMED_VOID' => 127,
			'LPAREN' => 122,
			'WORD' => 25,
			"for" => -149,
			'OP01_NAMED' => 119,
			'WORD_UPPERCASE' => 115,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			"while" => -149,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'SELF' => 97,
			'OP01_NAMED_VOID_LPAREN' => 99,
			"foreach" => -149,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP01_OPEN' => 93,
			"}" => 235
		},
		GOTOS => {
			'Literal' => 130,
			'Statement' => 109,
			'VariableDeclaration' => 129,
			'Operator' => 106,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'SubExpression' => 117,
			'LoopLabel' => 120,
			'Operation' => 236,
			'Variable' => 114,
			'OPTIONAL-38' => 136,
			'ArrayDereference' => 134,
			'PAREN-37' => 113,
			'ArrayReference' => 94,
			'Conditional' => 123,
			'HashDereference' => 121,
			'Expression' => 105,
			'HashReference' => 100,
			'OperatorVoid' => 103,
			'VariableModification' => 98
		}
	},
	{#State 147
		ACTIONS => {
			'VARIABLE_SYMBOL' => 237
		}
	},
	{#State 148
		ACTIONS => {
			'TYPE_FHREF' => 238
		}
	},
	{#State 149
		DEFAULT => -16
	},
	{#State 150
		DEFAULT => -210
	},
	{#State 151
		ACTIONS => {
			'LBRACE' => 111
		},
		GOTOS => {
			'HashReference' => 239
		}
	},
	{#State 152
		ACTIONS => {
			"}" => 240
		}
	},
	{#State 153
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 57,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 241
		}
	},
	{#State 154
		DEFAULT => -154
	},
	{#State 155
		ACTIONS => {
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			"undef" => 112
		},
		GOTOS => {
			'Variable' => 157,
			'ArrayDereference' => 134,
			'Expression' => 163,
			'WordScoped' => 138,
			'SubExpression' => 242,
			'VariableSymbolOrSelf' => 118,
			'HashReference' => 100,
			'HashDereference' => 121,
			'Operator' => 106,
			'ArrayReference' => 94,
			'Literal' => 130
		}
	},
	{#State 156
		DEFAULT => -186,
		GOTOS => {
			'STAR-46' => 243
		}
	},
	{#State 157
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP17_LIST_RANGE' => -137,
			"]" => -137,
			'OP06_REGEX_MATCH' => -137,
			")" => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP21_LIST_COMMA' => -137,
			";" => -137,
			'OP18_TERNARY' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP02_METHOD_THINARROW' => 182,
			"}" => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP08_STRING_CAT' => -137,
			'OP04_MATH_POW' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP03_MATH_INC_DEC' => 180
		}
	},
	{#State 158
		ACTIONS => {
			'OP21_LIST_COMMA' => -190,
			";" => -190,
			'OP18_TERNARY' => 188,
			'OP09_BITWISE_SHIFT' => 198,
			")" => -190,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			"]" => -190,
			'OP17_LIST_RANGE' => 185,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP06_REGEX_MATCH' => 194,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP23_LOGICAL_AND' => 200
		}
	},
	{#State 159
		ACTIONS => {
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			'OP01_OPEN' => 93,
			'WORD' => 25,
			'LPAREN' => 122,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'Expression' => 163,
			'SubExpression' => 244,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 160
		ACTIONS => {
			'LPAREN' => 184
		}
	},
	{#State 161
		ACTIONS => {
			'WORD' => 246
		},
		GOTOS => {
			'PLUS-47' => 245
		}
	},
	{#State 162
		DEFAULT => -114
	},
	{#State 163
		DEFAULT => -134
	},
	{#State 164
		ACTIONS => {
			")" => 247
		}
	},
	{#State 165
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 166
		DEFAULT => -196
	},
	{#State 167
		ACTIONS => {
			'LBRACKET' => 107
		},
		GOTOS => {
			'ArrayReference' => 249
		}
	},
	{#State 168
		ACTIONS => {
			'OP23_LOGICAL_AND' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			"}" => -90,
			'OP08_STRING_CAT' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP04_MATH_POW' => 191,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			"]" => -90,
			'OP17_LIST_RANGE' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP18_TERNARY' => -90,
			'OP21_LIST_COMMA' => -90,
			";" => -90,
			")" => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90
		}
	},
	{#State 169
		DEFAULT => -80
	},
	{#State 170
		ACTIONS => {
			"]" => 250
		}
	},
	{#State 171
		DEFAULT => -193
	},
	{#State 172
		ACTIONS => {
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191,
			'OP06_REGEX_MATCH' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP17_LIST_RANGE' => 185,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP09_BITWISE_SHIFT' => 198,
			")" => 251,
			'OP18_TERNARY' => 188
		}
	},
	{#State 173
		DEFAULT => -227
	},
	{#State 174
		DEFAULT => -203
	},
	{#State 175
		DEFAULT => -228
	},
	{#State 176
		DEFAULT => -226
	},
	{#State 177
		ACTIONS => {
			'OP20_HASH_FATARROW' => 252
		}
	},
	{#State 178
		DEFAULT => -207,
		GOTOS => {
			'STAR-52' => 253
		}
	},
	{#State 179
		DEFAULT => -209
	},
	{#State 180
		DEFAULT => -88
	},
	{#State 181
		ACTIONS => {
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'STDIN' => 254,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'SubExpression' => 256,
			'WordScoped' => 138,
			'SubExpressionOrStdin' => 255,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134,
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106
		}
	},
	{#State 182
		ACTIONS => {
			'LPAREN' => 257
		}
	},
	{#State 183
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_OPEN' => 93,
			'WORD' => 25,
			'LPAREN' => 122,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106,
			'SubExpression' => 258,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134
		}
	},
	{#State 184
		ACTIONS => {
			")" => 259
		}
	},
	{#State 185
		ACTIONS => {
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_OPEN' => 93,
			'WORD' => 25,
			'LPAREN' => 122,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'Variable' => 157,
			'HashReference' => 100,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'SubExpression' => 260,
			'WordScoped' => 138,
			'Operator' => 106,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94
		}
	},
	{#State 186
		ACTIONS => {
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_OPEN' => 93,
			'WORD' => 25,
			'LPAREN' => 122,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'Variable' => 157,
			'HashReference' => 100,
			'WordScoped' => 138,
			'SubExpression' => 261,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'Operator' => 106,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94
		}
	},
	{#State 187
		ACTIONS => {
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'WORD_UPPERCASE' => 160
		},
		GOTOS => {
			'Operator' => 106,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'HashReference' => 100,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 262,
			'Expression' => 163
		}
	},
	{#State 188
		ACTIONS => {
			'LITERAL_STRING' => 86,
			'VARIABLE_SYMBOL' => 108,
			'LITERAL_NUMBER' => 87,
			'SELF' => 97
		},
		GOTOS => {
			'VariableOrLiteral' => 265,
			'Variable' => 264,
			'Literal' => 263,
			'VariableSymbolOrSelf' => 118
		}
	},
	{#State 189
		ACTIONS => {
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'SubExpression' => 266,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 190
		ACTIONS => {
			'OP01_OPEN' => 93,
			'WORD' => 25,
			'LPAREN' => 122,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140
		},
		GOTOS => {
			'HashReference' => 100,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 267,
			'Expression' => 163,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121
		}
	},
	{#State 191
		ACTIONS => {
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'Variable' => 157,
			'HashReference' => 100,
			'WordScoped' => 138,
			'SubExpression' => 268,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'Operator' => 106,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94
		}
	},
	{#State 192
		ACTIONS => {
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160
		},
		GOTOS => {
			'HashReference' => 100,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 269,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121
		}
	},
	{#State 193
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107
		},
		GOTOS => {
			'Operator' => 106,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'HashReference' => 100,
			'WordScoped' => 138,
			'Expression' => 163,
			'SubExpression' => 270,
			'VariableSymbolOrSelf' => 118
		}
	},
	{#State 194
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 271
		}
	},
	{#State 195
		ACTIONS => {
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'WORD_UPPERCASE' => 160
		},
		GOTOS => {
			'Variable' => 157,
			'ArrayDereference' => 134,
			'SubExpression' => 272,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'HashReference' => 100,
			'HashDereference' => 121,
			'Operator' => 106,
			'ArrayReference' => 94,
			'Literal' => 130
		}
	},
	{#State 196
		ACTIONS => {
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'SubExpression' => 273,
			'Expression' => 163,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134,
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106
		}
	},
	{#State 197
		ACTIONS => {
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102
		},
		GOTOS => {
			'Expression' => 163,
			'SubExpression' => 274,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134,
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106
		}
	},
	{#State 198
		ACTIONS => {
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'WORD_UPPERCASE' => 160
		},
		GOTOS => {
			'HashDereference' => 121,
			'Operator' => 106,
			'ArrayReference' => 94,
			'Literal' => 130,
			'Variable' => 157,
			'ArrayDereference' => 134,
			'Expression' => 163,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 275,
			'HashReference' => 100
		}
	},
	{#State 199
		ACTIONS => {
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'Variable' => 157,
			'HashReference' => 100,
			'SubExpression' => 276,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'Operator' => 106,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94
		}
	},
	{#State 200
		ACTIONS => {
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102
		},
		GOTOS => {
			'HashReference' => 100,
			'Expression' => 163,
			'SubExpression' => 277,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121
		}
	},
	{#State 201
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_UPPERCASE' => 160,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125
		},
		GOTOS => {
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106,
			'SubExpression' => 278,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'Expression' => 163,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134
		}
	},
	{#State 202
		ACTIONS => {
			'OP23_LOGICAL_AND' => -174,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP02_METHOD_THINARROW' => -174,
			"}" => -174,
			'OP08_MATH_ADD_SUB' => -174,
			'OP08_STRING_CAT' => -174,
			'OP02_HASH_THINARROW' => 281,
			'OP02_ARRAY_THINARROW' => 280,
			'OP04_MATH_POW' => -174,
			'OP12_COMPARE_EQ_NE' => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'OP20_HASH_FATARROW' => -174,
			'OP03_MATH_INC_DEC' => -174,
			'OP07_STRING_REPEAT' => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP16_LOGICAL_OR' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			"]" => -174,
			'OP17_LIST_RANGE' => -174,
			'COLON' => -174,
			'OP06_REGEX_MATCH' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			'OP21_LIST_COMMA' => -174,
			'OP18_TERNARY' => -174,
			";" => -174,
			")" => -174,
			'OP09_BITWISE_SHIFT' => -174,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			'OP13_BITWISE_AND' => -174,
			'OP11_COMPARE_LT_GT' => -174
		},
		GOTOS => {
			'VariableRetrieval' => 279
		}
	},
	{#State 203
		ACTIONS => {
			'OP06_REGEX_MATCH' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			")" => -83,
			'OP18_TERNARY' => -83,
			'OP21_LIST_COMMA' => -190,
			";" => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP04_MATH_POW' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP08_STRING_CAT' => -83
		}
	},
	{#State 204
		ACTIONS => {
			'OP21_LIST_COMMA' => 282
		}
	},
	{#State 205
		DEFAULT => -147
	},
	{#State 206
		ACTIONS => {
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'MY' => 153,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_QW' => 161
		},
		GOTOS => {
			'Literal' => 130,
			'ListElement' => 283,
			'ArrayReference' => 94,
			'Operator' => 106,
			'TypeInner' => 155,
			'HashDereference' => 121,
			'HashReference' => 100,
			'SubExpression' => 203,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 207
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP17_LIST_RANGE' => 185,
			'OP06_REGEX_MATCH' => 194,
			'OP09_BITWISE_SHIFT' => 198,
			")" => 284,
			'OP18_TERNARY' => 188,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201
		}
	},
	{#State 208
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 285
		}
	},
	{#State 209
		DEFAULT => -86
	},
	{#State 210
		DEFAULT => -216
	},
	{#State 211
		ACTIONS => {
			";" => 286
		}
	},
	{#State 212
		ACTIONS => {
			";" => 287
		}
	},
	{#State 213
		DEFAULT => -87
	},
	{#State 214
		ACTIONS => {
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111
		},
		GOTOS => {
			'SubExpression' => 288,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134,
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106
		}
	},
	{#State 215
		ACTIONS => {
			'FHREF_SYMBOL' => 289
		}
	},
	{#State 216
		ACTIONS => {
			'VARIABLE_SYMBOL' => 290
		}
	},
	{#State 217
		ACTIONS => {
			'MY' => 291,
			'LPAREN_MY' => 292
		}
	},
	{#State 218
		DEFAULT => -163
	},
	{#State 219
		DEFAULT => -151
	},
	{#State 220
		ACTIONS => {
			'LPAREN' => 293
		}
	},
	{#State 221
		DEFAULT => -164
	},
	{#State 222
		DEFAULT => -162
	},
	{#State 223
		ACTIONS => {
			'MY' => 294
		}
	},
	{#State 224
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'MY' => 153,
			'LITERAL_NUMBER' => 87,
			'OP01_OPEN' => 93,
			'OP01_QW' => 161,
			'WORD' => 25,
			'LPAREN' => 122,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'ListElements' => 295,
			'Variable' => 157,
			'HashReference' => 100,
			'Expression' => 163,
			'SubExpression' => 158,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'Operator' => 106,
			'TypeInner' => 155,
			'HashDereference' => 121,
			'Literal' => 130,
			'ListElement' => 156,
			'ArrayReference' => 94
		}
	},
	{#State 225
		DEFAULT => -111
	},
	{#State 226
		DEFAULT => -112
	},
	{#State 227
		ACTIONS => {
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102,
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_QW' => 161,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'MY' => 153,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'WORD_UPPERCASE' => 160,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110
		},
		GOTOS => {
			'ListElements' => 296,
			'Variable' => 157,
			'ArrayDereference' => 134,
			'Expression' => 163,
			'WordScoped' => 138,
			'SubExpression' => 158,
			'VariableSymbolOrSelf' => 118,
			'HashReference' => 100,
			'HashDereference' => 121,
			'TypeInner' => 155,
			'Operator' => 106,
			'ListElement' => 156,
			'ArrayReference' => 94,
			'Literal' => 130
		}
	},
	{#State 228
		ACTIONS => {
			")" => 297
		}
	},
	{#State 229
		ACTIONS => {
			'OP01_QW' => 161,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'MY' => 153,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			")" => -125,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159
		},
		GOTOS => {
			'Operator' => 106,
			'HashDereference' => 121,
			'TypeInner' => 155,
			'Literal' => 130,
			'ArrayReference' => 94,
			'ListElement' => 156,
			'ArrayDereference' => 134,
			'OPTIONAL-35' => 299,
			'Variable' => 157,
			'ListElements' => 298,
			'HashReference' => 100,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'SubExpression' => 158
		}
	},
	{#State 230
		ACTIONS => {
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP07_STRING_REPEAT' => 201,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP23_LOGICAL_AND' => -108,
			"}" => -108,
			")" => -108,
			'OP09_BITWISE_SHIFT' => 198,
			'OP21_LIST_COMMA' => -108,
			";" => -108,
			'OP18_TERNARY' => 188,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP17_LIST_RANGE' => 185,
			"]" => -108,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP06_REGEX_MATCH' => 194
		}
	},
	{#State 231
		ACTIONS => {
			'OP06_REGEX_MATCH' => 194,
			'OP16_LOGICAL_OR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"]" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP18_TERNARY' => -98,
			'OP21_LIST_COMMA' => -98,
			";" => -98,
			")" => -98,
			'OP09_BITWISE_SHIFT' => 198,
			"}" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP07_STRING_REPEAT' => 201,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 232
		ACTIONS => {
			"our" => 300,
			'LITERAL_NUMBER' => 303
		},
		GOTOS => {
			'Method' => 301,
			'MethodOrSubroutine' => 302,
			'Subroutine' => 304
		}
	},
	{#State 233
		ACTIONS => {
			'LBRACE' => 305
		}
	},
	{#State 234
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 306
		}
	},
	{#State 235
		ACTIONS => {
			";" => 307
		}
	},
	{#State 236
		DEFAULT => -48
	},
	{#State 237
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 308
		}
	},
	{#State 238
		ACTIONS => {
			'FHREF_SYMBOL' => 309
		}
	},
	{#State 239
		ACTIONS => {
			"}" => 310
		}
	},
	{#State 240
		DEFAULT => -212
	},
	{#State 241
		ACTIONS => {
			"\$TYPED_" => 311
		}
	},
	{#State 242
		ACTIONS => {
			";" => -191,
			'OP21_LIST_COMMA' => -191,
			'OP18_TERNARY' => 188,
			'OP09_BITWISE_SHIFT' => 198,
			")" => -191,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"]" => -191,
			'OP17_LIST_RANGE' => 185,
			'OP06_REGEX_MATCH' => 194,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199
		}
	},
	{#State 243
		ACTIONS => {
			")" => -187,
			'OP21_LIST_COMMA' => 313,
			";" => -187,
			"]" => -187
		},
		GOTOS => {
			'PAREN-45' => 312
		}
	},
	{#State 244
		ACTIONS => {
			'OP04_MATH_POW' => -83,
			'OP08_STRING_CAT' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP23_LOGICAL_AND' => -83,
			"}" => -83,
			'OP21_LIST_COMMA' => -83,
			";" => -83,
			'OP18_TERNARY' => -83,
			")" => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP13_BITWISE_AND' => -83,
			"]" => -83,
			'OP17_LIST_RANGE' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP16_LOGICAL_OR' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP06_REGEX_MATCH' => -83
		}
	},
	{#State 245
		ACTIONS => {
			")" => 314,
			'WORD' => 315
		}
	},
	{#State 246
		DEFAULT => -189
	},
	{#State 247
		ACTIONS => {
			";" => 316
		}
	},
	{#State 248
		DEFAULT => -198
	},
	{#State 249
		ACTIONS => {
			"}" => 317
		}
	},
	{#State 250
		DEFAULT => -195
	},
	{#State 251
		DEFAULT => -91
	},
	{#State 252
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -201,
			'OP05_LOGICAL_NEG' => -201,
			"\@{" => -201,
			'SELF' => -201,
			'OP01_CLOSE' => -201,
			"%{" => -201,
			'LPAREN' => -201,
			'WORD' => -201,
			'OP01_OPEN' => -201,
			'OP22_LOGICAL_NEG' => -201,
			'OP10_NAMED_UNARY' => -201,
			'OP01_NAMED' => -201,
			'WORD_UPPERCASE' => -201,
			'LITERAL_NUMBER' => -201,
			'MY' => 153,
			'CONSTANT_CALL_SCOPED' => -201,
			'LITERAL_STRING' => -201,
			"undef" => -201,
			'WORD_SCOPED' => -201,
			'OP05_MATH_NEG_LPAREN' => -201,
			'LBRACE' => -201,
			'LBRACKET' => -201,
			'VARIABLE_SYMBOL' => -201
		},
		GOTOS => {
			'OPTIONAL-50' => 319,
			'TypeInner' => 318
		}
	},
	{#State 253
		ACTIONS => {
			"}" => 322,
			'OP21_LIST_COMMA' => 321
		},
		GOTOS => {
			'PAREN-51' => 320
		}
	},
	{#State 254
		DEFAULT => -144
	},
	{#State 255
		DEFAULT => -182
	},
	{#State 256
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP18_TERNARY' => 188,
			";" => -143,
			")" => -143,
			'OP09_BITWISE_SHIFT' => 198,
			'OP06_REGEX_MATCH' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP17_LIST_RANGE' => 185
		}
	},
	{#State 257
		ACTIONS => {
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			'OP01_OPEN' => 93,
			'OP01_QW' => 161,
			'WORD' => 25,
			'LPAREN' => 122,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'MY' => 153,
			'LITERAL_NUMBER' => 87,
			")" => -127,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Literal' => 130,
			'ListElement' => 156,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'TypeInner' => 155,
			'OPTIONAL-36' => 323,
			'HashReference' => 100,
			'Expression' => 163,
			'SubExpression' => 158,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'ArrayDereference' => 134,
			'ListElements' => 324,
			'Variable' => 157
		}
	},
	{#State 258
		ACTIONS => {
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191,
			'OP06_REGEX_MATCH' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP17_LIST_RANGE' => 185,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP09_BITWISE_SHIFT' => 198,
			")" => -183,
			'OP18_TERNARY' => 188,
			";" => -183
		}
	},
	{#State 259
		DEFAULT => -129
	},
	{#State 260
		ACTIONS => {
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"]" => -106,
			'OP17_LIST_RANGE' => undef,
			'OP06_REGEX_MATCH' => 194,
			'OP18_TERNARY' => -106,
			'OP21_LIST_COMMA' => -106,
			";" => -106,
			")" => -106,
			'OP09_BITWISE_SHIFT' => 198,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP23_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			"}" => -106,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201
		}
	},
	{#State 261
		ACTIONS => {
			'OP17_LIST_RANGE' => -94,
			"]" => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 194,
			'OP09_BITWISE_SHIFT' => -94,
			")" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP18_TERNARY' => -94,
			";" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP23_LOGICAL_AND' => -94,
			"}" => -94,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP07_STRING_REPEAT' => 201,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP12_COMPARE_EQ_NE' => -94
		}
	},
	{#State 262
		ACTIONS => {
			";" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP18_TERNARY' => -100,
			")" => -100,
			'OP09_BITWISE_SHIFT' => 198,
			'OP13_BITWISE_AND' => -100,
			'OP11_COMPARE_LT_GT' => undef,
			'OP16_LOGICAL_OR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"]" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP06_REGEX_MATCH' => 194,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP07_STRING_REPEAT' => 201,
			'OP23_LOGICAL_AND' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			"}" => -100
		}
	},
	{#State 263
		DEFAULT => -225
	},
	{#State 264
		DEFAULT => -224
	},
	{#State 265
		ACTIONS => {
			'COLON' => 325
		}
	},
	{#State 266
		ACTIONS => {
			'OP06_REGEX_MATCH' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP17_LIST_RANGE' => -103,
			"]" => -103,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			")" => -103,
			'OP09_BITWISE_SHIFT' => 198,
			'OP18_TERNARY' => -103,
			'OP21_LIST_COMMA' => -103,
			";" => -103,
			"}" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 267
		ACTIONS => {
			")" => -101,
			'OP09_BITWISE_SHIFT' => 198,
			'OP21_LIST_COMMA' => -101,
			";" => -101,
			'OP18_TERNARY' => -101,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => -101,
			'OP17_LIST_RANGE' => -101,
			"]" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP06_REGEX_MATCH' => 194,
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP07_STRING_REPEAT' => 201,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP23_LOGICAL_AND' => -101,
			"}" => -101
		}
	},
	{#State 268
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP23_LOGICAL_AND' => -89,
			"}" => -89,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP17_LIST_RANGE' => -89,
			"]" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP06_REGEX_MATCH' => -89,
			")" => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP18_TERNARY' => -89,
			";" => -89,
			'OP13_BITWISE_AND' => -89,
			'OP11_COMPARE_LT_GT' => -89
		}
	},
	{#State 269
		ACTIONS => {
			'OP23_LOGICAL_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			"}" => -95,
			'OP08_STRING_CAT' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP04_MATH_POW' => 191,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP07_STRING_REPEAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP17_LIST_RANGE' => -95,
			"]" => -95,
			'OP06_REGEX_MATCH' => 194,
			")" => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP18_TERNARY' => -95,
			'OP21_LIST_COMMA' => -95,
			";" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP11_COMPARE_LT_GT' => -95
		}
	},
	{#State 270
		ACTIONS => {
			"}" => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP07_STRING_REPEAT' => 201,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => -96,
			'OP08_MATH_ADD_SUB' => 192,
			'OP06_REGEX_MATCH' => 194,
			'OP17_LIST_RANGE' => -96,
			"]" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			")" => -96,
			'OP21_LIST_COMMA' => -96,
			";" => -96,
			'OP18_TERNARY' => -96
		}
	},
	{#State 271
		DEFAULT => -92
	},
	{#State 272
		ACTIONS => {
			'OP07_STRING_REPEAT' => 201,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			"}" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			")" => -104,
			'OP09_BITWISE_SHIFT' => 198,
			'OP21_LIST_COMMA' => -104,
			'OP18_TERNARY' => -104,
			";" => -104,
			'OP06_REGEX_MATCH' => 194,
			'OP17_LIST_RANGE' => -104,
			"]" => -104,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => -104,
			'OP15_LOGICAL_AND' => -104
		}
	},
	{#State 273
		ACTIONS => {
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			"}" => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP21_LIST_COMMA' => -105,
			'OP18_TERNARY' => -105,
			";" => -105,
			")" => -105,
			'OP09_BITWISE_SHIFT' => 198,
			'OP06_REGEX_MATCH' => 194,
			"]" => -105,
			'OP17_LIST_RANGE' => -105,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 186
		}
	},
	{#State 274
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => -102,
			")" => -102,
			'OP09_BITWISE_SHIFT' => 198,
			'OP21_LIST_COMMA' => -102,
			'OP18_TERNARY' => -102,
			";" => -102,
			'OP06_REGEX_MATCH' => 194,
			'OP17_LIST_RANGE' => -102,
			"]" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP07_STRING_REPEAT' => 201,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			"}" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP23_LOGICAL_AND' => -102
		}
	},
	{#State 275
		ACTIONS => {
			"]" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP06_REGEX_MATCH' => 194,
			'OP21_LIST_COMMA' => -97,
			'OP18_TERNARY' => -97,
			";" => -97,
			")" => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP23_LOGICAL_AND' => -97,
			"}" => -97,
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP14_BITWISE_OR_XOR' => -97
		}
	},
	{#State 276
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP23_LOGICAL_AND' => 200,
			"}" => -110,
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			"]" => -110,
			'OP17_LIST_RANGE' => 185,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP06_REGEX_MATCH' => 194,
			'OP21_LIST_COMMA' => -110,
			'OP18_TERNARY' => 188,
			";" => -110,
			'OP09_BITWISE_SHIFT' => 198,
			")" => -110,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187
		}
	},
	{#State 277
		ACTIONS => {
			'OP06_REGEX_MATCH' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP17_LIST_RANGE' => 185,
			"]" => -109,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP09_BITWISE_SHIFT' => 198,
			")" => -109,
			'OP18_TERNARY' => 188,
			'OP21_LIST_COMMA' => -109,
			";" => -109,
			"}" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 278
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP23_LOGICAL_AND' => -93,
			"}" => -93,
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => -93,
			'OP08_STRING_CAT' => -93,
			'OP07_STRING_REPEAT' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			"]" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			'OP06_REGEX_MATCH' => 194,
			'OP21_LIST_COMMA' => -93,
			'OP18_TERNARY' => -93,
			";" => -93,
			")" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93
		}
	},
	{#State 279
		DEFAULT => -172
	},
	{#State 280
		ACTIONS => {
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'SubExpression' => 326,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 281
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'WORD' => 327,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'HashReference' => 100,
			'Expression' => 163,
			'WordScoped' => 138,
			'SubExpression' => 328,
			'VariableSymbolOrSelf' => 118,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121
		}
	},
	{#State 282
		ACTIONS => {
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_QW' => 161,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			'MY' => 153,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'ListElements' => 329,
			'Variable' => 157,
			'HashReference' => 100,
			'WordScoped' => 138,
			'SubExpression' => 158,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'Operator' => 106,
			'TypeInner' => 155,
			'HashDereference' => 121,
			'Literal' => 130,
			'ListElement' => 156,
			'ArrayReference' => 94
		}
	},
	{#State 283
		ACTIONS => {
			'OP21_LIST_COMMA' => 330
		}
	},
	{#State 284
		DEFAULT => -142
	},
	{#State 285
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'MY' => 153,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_OPEN' => 93,
			'OP01_QW' => 161,
			'WORD' => 25,
			'LPAREN' => 122,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128
		},
		GOTOS => {
			'Variable' => 157,
			'ListElements' => 331,
			'ArrayDereference' => 134,
			'SubExpression' => 158,
			'WordScoped' => 138,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'HashReference' => 100,
			'HashDereference' => 121,
			'TypeInner' => 155,
			'Operator' => 106,
			'ArrayReference' => 94,
			'ListElement' => 156,
			'Literal' => 130
		}
	},
	{#State 286
		DEFAULT => -123
	},
	{#State 287
		DEFAULT => -120
	},
	{#State 288
		ACTIONS => {
			'OP18_TERNARY' => 188,
			")" => 332,
			'OP09_BITWISE_SHIFT' => 198,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP17_LIST_RANGE' => 185,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP06_REGEX_MATCH' => 194,
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP23_LOGICAL_AND' => 200
		}
	},
	{#State 289
		ACTIONS => {
			";" => 333
		}
	},
	{#State 290
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 336,
			";" => 334,
			'OP02_ARRAY_THINARROW' => 335
		}
	},
	{#State 291
		ACTIONS => {
			'TYPE_INTEGER' => 337
		}
	},
	{#State 292
		ACTIONS => {
			'TYPE_INTEGER' => 338
		}
	},
	{#State 293
		ACTIONS => {
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'Variable' => 157,
			'HashReference' => 100,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'Expression' => 163,
			'SubExpression' => 339,
			'Operator' => 106,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94
		}
	},
	{#State 294
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 340
		}
	},
	{#State 295
		ACTIONS => {
			";" => 341
		}
	},
	{#State 296
		ACTIONS => {
			";" => 342
		}
	},
	{#State 297
		DEFAULT => -133
	},
	{#State 298
		DEFAULT => -124
	},
	{#State 299
		ACTIONS => {
			")" => 343
		}
	},
	{#State 300
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 56,
			'TYPE_METHOD' => 344
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 301
		DEFAULT => -78
	},
	{#State 302
		DEFAULT => -61
	},
	{#State 303
		ACTIONS => {
			";" => 345
		}
	},
	{#State 304
		DEFAULT => -79
	},
	{#State 305
		ACTIONS => {
			"}" => 348,
			'WORD' => 347
		},
		GOTOS => {
			'HashEntryProperties' => 346
		}
	},
	{#State 306
		DEFAULT => -223
	},
	{#State 307
		DEFAULT => -50
	},
	{#State 308
		ACTIONS => {
			")" => 350,
			'OP21_LIST_COMMA' => 351
		},
		GOTOS => {
			'PAREN-20' => 349
		}
	},
	{#State 309
		ACTIONS => {
			'OP21_LIST_COMMA' => 352
		}
	},
	{#State 310
		DEFAULT => -213
	},
	{#State 311
		ACTIONS => {
			'WORD' => 353
		}
	},
	{#State 312
		DEFAULT => -185
	},
	{#State 313
		ACTIONS => {
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			'OP01_QW' => 161,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			'WORD_UPPERCASE' => 160,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'MY' => 153,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107
		},
		GOTOS => {
			'HashDereference' => 121,
			'TypeInner' => 155,
			'Operator' => 106,
			'ArrayReference' => 94,
			'ListElement' => 354,
			'Literal' => 130,
			'Variable' => 157,
			'ArrayDereference' => 134,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'SubExpression' => 158,
			'WordScoped' => 138,
			'HashReference' => 100
		}
	},
	{#State 314
		DEFAULT => -192
	},
	{#State 315
		DEFAULT => -188
	},
	{#State 316
		DEFAULT => -119
	},
	{#State 317
		DEFAULT => -199
	},
	{#State 318
		DEFAULT => -200
	},
	{#State 319
		ACTIONS => {
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'Expression' => 163,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 355,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 320
		DEFAULT => -206
	},
	{#State 321
		ACTIONS => {
			'SELF' => 97,
			'WORD' => 175,
			'LITERAL_NUMBER' => 87,
			'VARIABLE_SYMBOL' => 108,
			"%{" => 96,
			'LITERAL_STRING' => 86
		},
		GOTOS => {
			'Variable' => 176,
			'HashDereference' => 174,
			'HashEntry' => 356,
			'VariableSymbolOrSelf' => 118,
			'Literal' => 173,
			'VariableOrLiteralOrWord' => 177
		}
	},
	{#State 322
		DEFAULT => -208
	},
	{#State 323
		ACTIONS => {
			")" => 357
		}
	},
	{#State 324
		DEFAULT => -126
	},
	{#State 325
		ACTIONS => {
			'LITERAL_NUMBER' => 87,
			'SELF' => 97,
			'LITERAL_STRING' => 86,
			'VARIABLE_SYMBOL' => 108
		},
		GOTOS => {
			'Variable' => 264,
			'VariableOrLiteral' => 358,
			'VariableSymbolOrSelf' => 118,
			'Literal' => 263
		}
	},
	{#State 326
		ACTIONS => {
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP09_BITWISE_SHIFT' => 198,
			'OP18_TERNARY' => 188,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP17_LIST_RANGE' => 185,
			"]" => 359,
			'OP06_REGEX_MATCH' => 194
		}
	},
	{#State 327
		ACTIONS => {
			'LPAREN' => -214,
			"}" => 360,
			'OP02_METHOD_THINARROW_NEW' => -214
		}
	},
	{#State 328
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 198,
			'OP18_TERNARY' => 188,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP17_LIST_RANGE' => 185,
			'OP06_REGEX_MATCH' => 194,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			"}" => 361
		}
	},
	{#State 329
		ACTIONS => {
			";" => 362
		}
	},
	{#State 330
		ACTIONS => {
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LITERAL_NUMBER' => 87,
			'MY' => 153,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_QW' => 161,
			'OP01_OPEN' => 93,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'ListElement' => 156,
			'Operator' => 106,
			'HashDereference' => 121,
			'TypeInner' => 155,
			'HashReference' => 100,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'SubExpression' => 158,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'ListElements' => 363
		}
	},
	{#State 331
		ACTIONS => {
			")" => 364
		}
	},
	{#State 332
		ACTIONS => {
			'LBRACE' => 366
		},
		GOTOS => {
			'CodeBlock' => 365
		}
	},
	{#State 333
		DEFAULT => -181
	},
	{#State 334
		DEFAULT => -178
	},
	{#State 335
		ACTIONS => {
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'WORD_UPPERCASE' => 160,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'OP01_NAMED' => 159,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'Expression' => 163,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 367,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 336
		ACTIONS => {
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			'OP01_OPEN' => 93,
			'WORD' => 25,
			'LPAREN' => 122,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'STDIN' => 254,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'SubExpressionOrStdin' => 368,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 256,
			'Expression' => 163,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 337
		ACTIONS => {
			'VARIABLE_SYMBOL' => 369
		}
	},
	{#State 338
		ACTIONS => {
			'VARIABLE_SYMBOL' => 370
		}
	},
	{#State 339
		ACTIONS => {
			'OP18_TERNARY' => 188,
			")" => 371,
			'OP09_BITWISE_SHIFT' => 198,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP17_LIST_RANGE' => 185,
			'OP06_REGEX_MATCH' => 194,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199
		}
	},
	{#State 340
		ACTIONS => {
			'VARIABLE_SYMBOL' => 372
		}
	},
	{#State 341
		DEFAULT => -116
	},
	{#State 342
		DEFAULT => -117
	},
	{#State 343
		DEFAULT => -131
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 373
		}
	},
	{#State 345
		DEFAULT => -63
	},
	{#State 346
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 374
		}
	},
	{#State 347
		ACTIONS => {
			'OP20_HASH_FATARROW' => 375
		}
	},
	{#State 348
		ACTIONS => {
			";" => 376
		}
	},
	{#State 349
		DEFAULT => -52
	},
	{#State 350
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 351
		ACTIONS => {
			'MY' => 378
		}
	},
	{#State 352
		ACTIONS => {
			'LITERAL_STRING' => 379
		}
	},
	{#State 353
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 380
		}
	},
	{#State 354
		DEFAULT => -184
	},
	{#State 355
		ACTIONS => {
			'OP21_LIST_COMMA' => -202,
			'OP18_TERNARY' => 188,
			'OP09_BITWISE_SHIFT' => 198,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 185,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP06_REGEX_MATCH' => 194,
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP23_LOGICAL_AND' => 200,
			"}" => -202
		}
	},
	{#State 356
		DEFAULT => -205
	},
	{#State 357
		DEFAULT => -132
	},
	{#State 358
		DEFAULT => -107
	},
	{#State 359
		DEFAULT => -175
	},
	{#State 360
		DEFAULT => -177
	},
	{#State 361
		DEFAULT => -176
	},
	{#State 362
		DEFAULT => -121
	},
	{#State 363
		ACTIONS => {
			")" => 381
		}
	},
	{#State 364
		DEFAULT => -82
	},
	{#State 365
		DEFAULT => -157,
		GOTOS => {
			'STAR-40' => 382
		}
	},
	{#State 366
		ACTIONS => {
			'MY' => 135,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP01_PRINT' => 137,
			'LITERAL_NUMBER' => 87,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			"if" => 131,
			'OP01_NAMED_VOID_SCOLON' => 124,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_CLOSE' => 125,
			'OP01_NAMED_VOID' => 127,
			'OP03_MATH_INC_DEC' => 128,
			'LPAREN' => 122,
			'WORD' => 25,
			"for" => -149,
			'WORD_UPPERCASE' => 115,
			'OP01_NAMED' => 119,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP05_MATH_NEG_LPAREN' => 110,
			"while" => -149,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			"foreach" => -149,
			"%{" => 96,
			'SELF' => 97,
			'OP01_NAMED_VOID_LPAREN' => 99,
			"\@{" => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'OperatorVoid' => 103,
			'HashReference' => 100,
			'Expression' => 105,
			'VariableModification' => 98,
			'Conditional' => 123,
			'ArrayReference' => 94,
			'HashDereference' => 121,
			'Operation' => 384,
			'LoopLabel' => 120,
			'SubExpression' => 117,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'PAREN-37' => 113,
			'OPTIONAL-38' => 136,
			'ArrayDereference' => 134,
			'Variable' => 114,
			'Literal' => 130,
			'VariableDeclaration' => 129,
			'Operator' => 106,
			'PLUS-43' => 383,
			'Statement' => 109
		}
	},
	{#State 367
		ACTIONS => {
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP18_TERNARY' => 188,
			'OP09_BITWISE_SHIFT' => 198,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"]" => 385,
			'OP17_LIST_RANGE' => 185,
			'OP06_REGEX_MATCH' => 194
		}
	},
	{#State 368
		ACTIONS => {
			";" => 386
		}
	},
	{#State 369
		ACTIONS => {
			'LPAREN' => 387
		}
	},
	{#State 370
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 388
		}
	},
	{#State 371
		ACTIONS => {
			'LBRACE' => 366
		},
		GOTOS => {
			'CodeBlock' => 389
		}
	},
	{#State 372
		ACTIONS => {
			'LPAREN' => 390
		}
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 391
		}
	},
	{#State 374
		ACTIONS => {
			"}" => 393,
			'OP21_LIST_COMMA' => 394
		},
		GOTOS => {
			'PAREN-26' => 392
		}
	},
	{#State 375
		ACTIONS => {
			'MY' => 395
		},
		GOTOS => {
			'TypeInnerProperties' => 396
		}
	},
	{#State 376
		DEFAULT => -68
	},
	{#State 377
		ACTIONS => {
			"\@_;" => 397
		}
	},
	{#State 378
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'TYPE_INTEGER' => 55,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 398
		}
	},
	{#State 379
		ACTIONS => {
			'OP21_LIST_COMMA' => 399
		}
	},
	{#State 380
		DEFAULT => -220
	},
	{#State 381
		DEFAULT => -84
	},
	{#State 382
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -160,
			'OP10_NAMED_UNARY' => -160,
			"else" => 402,
			'LITERAL_NUMBER' => -160,
			'OP01_PRINT' => -160,
			'LITERAL_STRING' => -160,
			'CONSTANT_CALL_SCOPED' => -160,
			'MY' => -160,
			"if" => -160,
			'' => -160,
			'OP03_MATH_INC_DEC' => -160,
			"elsif" => 400,
			'OP01_NAMED_VOID' => -160,
			'OP01_CLOSE' => -160,
			'OP19_LOOP_CONTROL' => -160,
			'OP01_NAMED_VOID_SCOLON' => -160,
			"for" => -160,
			'WORD' => -160,
			'LPAREN' => -160,
			'OP01_NAMED' => -160,
			'WORD_UPPERCASE' => -160,
			"undef" => -160,
			'WORD_SCOPED' => -160,
			'OP05_MATH_NEG_LPAREN' => -160,
			"while" => -160,
			'LBRACE' => -160,
			'VARIABLE_SYMBOL' => -160,
			'LBRACKET' => -160,
			'OP05_LOGICAL_NEG' => -160,
			'OP19_LOOP_CONTROL_SCOLON' => -160,
			"\@{" => -160,
			'OP01_NAMED_VOID_LPAREN' => -160,
			'SELF' => -160,
			"foreach" => -160,
			"%{" => -160,
			"}" => -160,
			'OP01_OPEN' => -160
		},
		GOTOS => {
			'OPTIONAL-42' => 404,
			'PAREN-39' => 401,
			'PAREN-41' => 403
		}
	},
	{#State 383
		ACTIONS => {
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 110,
			"while" => -149,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'WORD_UPPERCASE' => 115,
			'OP01_NAMED' => 119,
			'OP01_OPEN' => 93,
			"}" => 406,
			"%{" => 96,
			"foreach" => -149,
			'SELF' => 97,
			'OP01_NAMED_VOID_LPAREN' => 99,
			"\@{" => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'OP05_LOGICAL_NEG' => 104,
			"if" => 131,
			'MY' => 135,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP01_PRINT' => 137,
			'LITERAL_NUMBER' => 87,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'LPAREN' => 122,
			'WORD' => 25,
			"for" => -149,
			'OP01_NAMED_VOID_SCOLON' => 124,
			'OP01_CLOSE' => 125,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED_VOID' => 127,
			'OP03_MATH_INC_DEC' => 128
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'SubExpression' => 117,
			'LoopLabel' => 120,
			'Operation' => 405,
			'Variable' => 114,
			'OPTIONAL-38' => 136,
			'ArrayDereference' => 134,
			'PAREN-37' => 113,
			'Literal' => 130,
			'Statement' => 109,
			'VariableDeclaration' => 129,
			'Operator' => 106,
			'Expression' => 105,
			'HashReference' => 100,
			'OperatorVoid' => 103,
			'VariableModification' => 98,
			'ArrayReference' => 94,
			'Conditional' => 123,
			'HashDereference' => 121
		}
	},
	{#State 384
		DEFAULT => -170
	},
	{#State 385
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 407
		}
	},
	{#State 386
		DEFAULT => -179
	},
	{#State 387
		ACTIONS => {
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86
		},
		GOTOS => {
			'SubExpression' => 408,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134,
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106
		}
	},
	{#State 388
		ACTIONS => {
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'LBRACE' => 111,
			'OP05_MATH_NEG_LPAREN' => 110,
			'WORD_SCOPED' => 24,
			"undef" => 112
		},
		GOTOS => {
			'ArrayReference' => 94,
			'Literal' => 130,
			'HashDereference' => 121,
			'Operator' => 106,
			'Expression' => 163,
			'WordScoped' => 138,
			'SubExpression' => 409,
			'VariableSymbolOrSelf' => 118,
			'HashReference' => 100,
			'Variable' => 157,
			'ArrayDereference' => 134
		}
	},
	{#State 389
		DEFAULT => -168
	},
	{#State 390
		ACTIONS => {
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"\@{" => 102,
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_QW' => 161,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'MY' => 153,
			'OP01_NAMED' => 159,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'WORD_UPPERCASE' => 160,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111
		},
		GOTOS => {
			'Literal' => 130,
			'ListElement' => 156,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'TypeInner' => 155,
			'HashReference' => 100,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'Expression' => 163,
			'SubExpression' => 158,
			'ArrayDereference' => 134,
			'ListElements' => 410,
			'Variable' => 157
		}
	},
	{#State 391
		ACTIONS => {
			'OP01_OPEN' => -70,
			"}" => -70,
			'OP01_NAMED_VOID_LPAREN' => -70,
			'SELF' => -70,
			"foreach" => -70,
			"%{" => -70,
			'OP05_LOGICAL_NEG' => -70,
			"\@{" => -70,
			'OP19_LOOP_CONTROL_SCOLON' => -70,
			'VARIABLE_SYMBOL' => -70,
			'LBRACKET' => -70,
			'WORD_SCOPED' => -70,
			"undef" => -70,
			'OP05_MATH_NEG_LPAREN' => -70,
			"while" => -70,
			'LBRACE' => -70,
			'OP01_NAMED' => -70,
			'WORD_UPPERCASE' => -70,
			'LPAREN' => -70,
			'WORD' => -70,
			"for" => -70,
			'OP01_CLOSE' => -70,
			'OP19_LOOP_CONTROL' => -70,
			'OP01_NAMED_VOID_SCOLON' => -70,
			'OP03_MATH_INC_DEC' => -70,
			'OP01_NAMED_VOID' => -70,
			"if" => -70,
			'OP01_PRINT' => -70,
			'LITERAL_NUMBER' => -70,
			'MY' => -70,
			'CONSTANT_CALL_SCOPED' => -70,
			'LITERAL_STRING' => -70,
			'LPAREN_MY' => 411,
			'OP10_NAMED_UNARY' => -70,
			'OP22_LOGICAL_NEG' => -70
		},
		GOTOS => {
			'OPTIONAL-28' => 413,
			'MethodArguments' => 412
		}
	},
	{#State 392
		DEFAULT => -65
	},
	{#State 393
		ACTIONS => {
			";" => 414
		}
	},
	{#State 394
		ACTIONS => {
			'WORD' => 347
		},
		GOTOS => {
			'HashEntryProperties' => 415
		}
	},
	{#State 395
		ACTIONS => {
			'WORD_SCOPED' => 56,
			'WORD' => 57,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 416
		}
	},
	{#State 396
		DEFAULT => -204
	},
	{#State 397
		DEFAULT => -54
	},
	{#State 398
		ACTIONS => {
			'VARIABLE_SYMBOL' => 417
		}
	},
	{#State 399
		ACTIONS => {
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133
		},
		GOTOS => {
			'HashReference' => 100,
			'SubExpression' => 418,
			'Expression' => 163,
			'WordScoped' => 138,
			'VariableSymbolOrSelf' => 118,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121
		}
	},
	{#State 400
		ACTIONS => {
			'LPAREN' => 419
		}
	},
	{#State 401
		DEFAULT => -156
	},
	{#State 402
		ACTIONS => {
			'LBRACE' => 366
		},
		GOTOS => {
			'CodeBlock' => 420
		}
	},
	{#State 403
		DEFAULT => -159
	},
	{#State 404
		DEFAULT => -161
	},
	{#State 405
		DEFAULT => -169
	},
	{#State 406
		DEFAULT => -171
	},
	{#State 407
		ACTIONS => {
			"undef" => 421
		}
	},
	{#State 408
		ACTIONS => {
			'OP04_MATH_POW' => 191,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP23_LOGICAL_AND' => 200,
			'OP18_TERNARY' => 188,
			'OP09_BITWISE_SHIFT' => 198,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 422,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP06_REGEX_MATCH' => 194
		}
	},
	{#State 409
		ACTIONS => {
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP17_LIST_RANGE' => 185,
			'OP06_REGEX_MATCH' => 194,
			'OP09_BITWISE_SHIFT' => 198,
			'OP18_TERNARY' => 188,
			";" => 423,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187
		}
	},
	{#State 410
		ACTIONS => {
			")" => 424
		}
	},
	{#State 411
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 425
		}
	},
	{#State 412
		DEFAULT => -69
	},
	{#State 413
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 426
		}
	},
	{#State 414
		DEFAULT => -67
	},
	{#State 415
		DEFAULT => -64
	},
	{#State 416
		ACTIONS => {
			"\$TYPED_" => 427
		}
	},
	{#State 417
		DEFAULT => -51
	},
	{#State 418
		ACTIONS => {
			"}" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191,
			'OP06_REGEX_MATCH' => 194,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"]" => -85,
			'OP17_LIST_RANGE' => 185,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP18_TERNARY' => 188,
			'OP21_LIST_COMMA' => -85,
			";" => -85,
			")" => -85,
			'OP09_BITWISE_SHIFT' => 198
		}
	},
	{#State 419
		ACTIONS => {
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			"\@{" => 102,
			'OP05_LOGICAL_NEG' => 104,
			'OP03_MATH_INC_DEC' => 128,
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'HashReference' => 100,
			'SubExpression' => 428,
			'WordScoped' => 138,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121
		}
	},
	{#State 420
		DEFAULT => -158
	},
	{#State 421
		ACTIONS => {
			";" => 429
		}
	},
	{#State 422
		ACTIONS => {
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'WORD_UPPERCASE' => 160,
			'LITERAL_NUMBER' => 87,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"%{" => 96,
			'LPAREN' => 122,
			'WORD' => 25,
			'OP01_OPEN' => 93
		},
		GOTOS => {
			'HashReference' => 100,
			'Expression' => 163,
			'WordScoped' => 138,
			'SubExpression' => 430,
			'VariableSymbolOrSelf' => 118,
			'ArrayDereference' => 134,
			'Variable' => 157,
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121
		}
	},
	{#State 423
		ACTIONS => {
			'VARIABLE_SYMBOL' => 431
		}
	},
	{#State 424
		ACTIONS => {
			'LBRACE' => 366
		},
		GOTOS => {
			'CodeBlock' => 432
		}
	},
	{#State 425
		ACTIONS => {
			'SELF' => 433
		}
	},
	{#State 426
		ACTIONS => {
			'OP01_OPEN' => 93,
			"}" => 434,
			'SELF' => 97,
			'OP01_NAMED_VOID_LPAREN' => 99,
			"%{" => 96,
			"foreach" => -149,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 101,
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			"while" => -149,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'OP01_NAMED' => 119,
			'WORD_UPPERCASE' => 115,
			'LPAREN' => 122,
			'WORD' => 25,
			"for" => -149,
			'OP01_CLOSE' => 125,
			'OP19_LOOP_CONTROL' => 126,
			'OP01_NAMED_VOID_SCOLON' => 124,
			'OP03_MATH_INC_DEC' => 128,
			'OP01_NAMED_VOID' => 127,
			"if" => 131,
			'OP01_PRINT' => 137,
			'LITERAL_NUMBER' => 87,
			'MY' => 135,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140
		},
		GOTOS => {
			'VariableModification' => 98,
			'Expression' => 105,
			'OperatorVoid' => 103,
			'HashReference' => 100,
			'HashDereference' => 121,
			'ArrayReference' => 94,
			'Conditional' => 123,
			'Variable' => 114,
			'OPTIONAL-38' => 136,
			'ArrayDereference' => 134,
			'PAREN-37' => 113,
			'LoopLabel' => 120,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 117,
			'WordScoped' => 138,
			'Operation' => 435,
			'Statement' => 109,
			'VariableDeclaration' => 129,
			'Operator' => 106,
			'Literal' => 130
		}
	},
	{#State 427
		ACTIONS => {
			'WORD' => 436
		}
	},
	{#State 428
		ACTIONS => {
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP17_LIST_RANGE' => 185,
			'OP06_REGEX_MATCH' => 194,
			'OP18_TERNARY' => 188,
			")" => 437,
			'OP09_BITWISE_SHIFT' => 198,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187
		}
	},
	{#State 429
		DEFAULT => -180
	},
	{#State 430
		ACTIONS => {
			'OP06_REGEX_MATCH' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP17_LIST_RANGE' => undef,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP09_BITWISE_SHIFT' => 198,
			")" => 438,
			'OP18_TERNARY' => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 431
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 439
		}
	},
	{#State 432
		DEFAULT => -167
	},
	{#State 433
		DEFAULT => -76,
		GOTOS => {
			'STAR-31' => 440
		}
	},
	{#State 434
		ACTIONS => {
			";" => 441
		}
	},
	{#State 435
		DEFAULT => -71
	},
	{#State 436
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 442,
			'OP02_ARRAY_THINARROW' => 443
		}
	},
	{#State 437
		ACTIONS => {
			'LBRACE' => 366
		},
		GOTOS => {
			'CodeBlock' => 444
		}
	},
	{#State 438
		ACTIONS => {
			'LBRACE' => 366
		},
		GOTOS => {
			'CodeBlock' => 445
		}
	},
	{#State 439
		ACTIONS => {
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102,
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'WORD_UPPERCASE' => 160,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_SCOPED' => 24,
			"undef" => 112,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'VariableSymbolOrSelf' => 118,
			'SubExpression' => 446,
			'Expression' => 163,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 440
		ACTIONS => {
			'OP21_LIST_COMMA' => 448,
			")" => 447
		},
		GOTOS => {
			'PAREN-30' => 449
		}
	},
	{#State 441
		DEFAULT => -73
	},
	{#State 442
		ACTIONS => {
			'VARIABLE_SYMBOL' => 108,
			'LBRACKET' => 107,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'LITERAL_NUMBER' => 87,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'WORD_UPPERCASE' => 160,
			'WORD' => 25,
			'LPAREN' => 122,
			'OP01_OPEN' => 93,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			"%{" => 96,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"\@{" => 102
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'HashDereference' => 121,
			'HashReference' => 100,
			'SubExpression' => 450,
			'Expression' => 163,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'ArrayDereference' => 134,
			'Variable' => 157
		}
	},
	{#State 443
		ACTIONS => {
			'OP01_OPEN' => 93,
			'WORD' => 25,
			'LPAREN' => 122,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			"%{" => 96,
			'OP01_CLOSE' => 125,
			'SELF' => 97,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			"undef" => 112,
			'WORD_SCOPED' => 24,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'WORD_UPPERCASE' => 160,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 139,
			'OP10_NAMED_UNARY' => 140,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 87
		},
		GOTOS => {
			'ArrayDereference' => 134,
			'Variable' => 157,
			'HashReference' => 100,
			'Expression' => 163,
			'SubExpression' => 451,
			'VariableSymbolOrSelf' => 118,
			'WordScoped' => 138,
			'Operator' => 106,
			'HashDereference' => 121,
			'Literal' => 130,
			'ArrayReference' => 94
		}
	},
	{#State 444
		DEFAULT => -155
	},
	{#State 445
		DEFAULT => -165
	},
	{#State 446
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 189,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP07_STRING_REPEAT' => 201,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP09_BITWISE_SHIFT' => 198,
			";" => 452,
			'OP18_TERNARY' => 188,
			'OP06_REGEX_MATCH' => 194,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP17_LIST_RANGE' => 185
		}
	},
	{#State 447
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 453
		}
	},
	{#State 448
		ACTIONS => {
			'MY' => 454
		}
	},
	{#State 449
		DEFAULT => -75
	},
	{#State 450
		ACTIONS => {
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP21_LIST_COMMA' => -221,
			'OP18_TERNARY' => 188,
			'OP09_BITWISE_SHIFT' => 198,
			'OP06_REGEX_MATCH' => 194,
			'OP17_LIST_RANGE' => 185,
			'OP16_LOGICAL_OR' => 196,
			'OP15_LOGICAL_AND' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			"}" => -221,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP23_LOGICAL_AND' => 200
		}
	},
	{#State 451
		ACTIONS => {
			'OP06_REGEX_MATCH' => 194,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			"]" => 455,
			'OP17_LIST_RANGE' => 185,
			'OP13_BITWISE_AND' => 197,
			'OP11_COMPARE_LT_GT' => 187,
			'OP18_TERNARY' => 188,
			'OP09_BITWISE_SHIFT' => 198,
			'OP23_LOGICAL_AND' => 200,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 201,
			'OP08_STRING_CAT' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 191
		}
	},
	{#State 452
		ACTIONS => {
			"%{" => 96,
			'SELF' => 97,
			'OP01_CLOSE' => 125,
			"\@{" => 102,
			'OP03_MATH_INC_DEC' => 128,
			'OP05_LOGICAL_NEG' => 104,
			'OP01_OPEN' => 93,
			'LPAREN' => 122,
			'WORD' => 25,
			'LITERAL_STRING' => 86,
			'CONSTANT_CALL_SCOPED' => 133,
			'LITERAL_NUMBER' => 87,
			'WORD_UPPERCASE' => 160,
			'OP10_NAMED_UNARY' => 140,
			'OP22_LOGICAL_NEG' => 139,
			'OP01_NAMED' => 159,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 108,
			'OP05_MATH_NEG_LPAREN' => 110,
			'LBRACE' => 111,
			'WORD_SCOPED' => 24,
			"undef" => 112
		},
		GOTOS => {
			'Literal' => 130,
			'ArrayReference' => 94,
			'Operator' => 106,
			'SubExpressionOrVarMod' => 456,
			'HashDereference' => 121,
			'HashReference' => 100,
			'Expression' => 163,
			'WordScoped' => 138,
			'SubExpression' => 457,
			'VariableSymbolOrSelf' => 118,
			'ArrayDereference' => 134,
			'Variable' => 114,
			'VariableModification' => 458
		}
	},
	{#State 453
		ACTIONS => {
			"\@_;" => 459
		}
	},
	{#State 454
		ACTIONS => {
			'WORD' => 57,
			'TYPE_INTEGER' => 55,
			'WORD_SCOPED' => 56
		},
		GOTOS => {
			'Type' => 460
		}
	},
	{#State 455
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 461
		}
	},
	{#State 456
		ACTIONS => {
			")" => 462
		}
	},
	{#State 457
		ACTIONS => {
			'OP18_TERNARY' => 188,
			")" => -145,
			'OP09_BITWISE_SHIFT' => 198,
			'OP11_COMPARE_LT_GT' => 187,
			'OP13_BITWISE_AND' => 197,
			'OP17_LIST_RANGE' => 185,
			'OP15_LOGICAL_AND' => 195,
			'OP16_LOGICAL_OR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 186,
			'OP06_REGEX_MATCH' => 194,
			'OP04_MATH_POW' => 191,
			'OP08_MATH_ADD_SUB' => 192,
			'OP08_STRING_CAT' => 193,
			'OP07_STRING_REPEAT' => 201,
			'OP12_COMPARE_EQ_NE' => 190,
			'OP14_BITWISE_OR_XOR' => 189,
			'OP24_LOGICAL_OR_XOR' => 199,
			'OP23_LOGICAL_AND' => 200
		}
	},
	{#State 458
		DEFAULT => -146
	},
	{#State 459
		DEFAULT => -77
	},
	{#State 460
		ACTIONS => {
			'VARIABLE_SYMBOL' => 463
		}
	},
	{#State 461
		ACTIONS => {
			"undef" => 464
		}
	},
	{#State 462
		ACTIONS => {
			'LBRACE' => 366
		},
		GOTOS => {
			'CodeBlock' => 465
		}
	},
	{#State 463
		DEFAULT => -74
	},
	{#State 464
		DEFAULT => -222
	},
	{#State 465
		DEFAULT => -166
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6531 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6538 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6545 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6552 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6563 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6574 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6581 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6588 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6602 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6609 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6616 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6623 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6630 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6637 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6644 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6651 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6658 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6676 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6690 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6697 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6719 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6737 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6744 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6765 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6779 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6786 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6797 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6822 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6847 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6854 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule Include_43
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule Include_44
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6883 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_45
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6894 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6908 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6915 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_50
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6940 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6954 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_54
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6972 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6979 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7000 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7007 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7014 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7021 lib/RPerl/Grammar.pm
	],
	[#Rule Class_63
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7032 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7053 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_67
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_68
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7075 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7096 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7103 lib/RPerl/Grammar.pm
	],
	[#Rule Method_73
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7114 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 4,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7128 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7135 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_77
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_78
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7157 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_79
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7168 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7179 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7190 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7212 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7223 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7234 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7245 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7256 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7267 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7278 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7289 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7300 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7311 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7322 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7333 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7344 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7355 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7366 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7377 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7388 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7399 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7410 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7421 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7432 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7443 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7454 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7476 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7487 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7498 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7523 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7544 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7555 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7566 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7577 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7588 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7599 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7610 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7621 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7632 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7646 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7653 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7660 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7693 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7704 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7715 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7726 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7737 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7748 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7781 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7792 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7803 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7814 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7825 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_143
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7836 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_144
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7847 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_145
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7858 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_146
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7869 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7876 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7883 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7890 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7901 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7912 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7923 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7934 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7945 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 5,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7959 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7966 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7973 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7980 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7987 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_161
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7998 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8009 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8020 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8031 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_165
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8042 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 14,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8053 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_167
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8064 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_168
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8075 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8082 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8089 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_171
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8100 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8107 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8114 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_174
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8125 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8136 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8147 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8158 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8169 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8180 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8191 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8202 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8213 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8224 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8231 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8238 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8245 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_187
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8256 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8263 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 1,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8270 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8281 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8292 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8303 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8310 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8317 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_195
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8328 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8335 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8342 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_198
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8353 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_199
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8364 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8371 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8378 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8389 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8400 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_204
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8411 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8418 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8425 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8432 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_208
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8443 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_209
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8454 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8461 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8468 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_212
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8479 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_213
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8490 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8501 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_215
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8512 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_216
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8523 lib/RPerl/Grammar.pm
	],
	[#Rule Type_217
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8534 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8545 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8556 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_220
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8567 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_221
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8578 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_222
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8589 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_223
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8600 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_224
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8611 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_225
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8622 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_226
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8633 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_227
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8644 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_228
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8655 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_229
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8666 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_230
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8677 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_231
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8688 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_232
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8699 lib/RPerl/Grammar.pm
	]
],
#line 8702 lib/RPerl/Grammar.pm
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
         'HashEntryProperties_204', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_208', 
         'HashReference_209', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_212', 
         'HashDereference_213', 
         'WordScoped_214', 
         'WordScoped_215', 
         'LoopLabel_216', 
         'Type_217', 
         'Type_218', 
         'Type_219', 
         'TypeInner_220', 
         'TypeInnerProperties_221', 
         'TypeInnerProperties_222', 
         'TypeInnerConstant_223', 
         'VariableOrLiteral_224', 
         'VariableOrLiteral_225', 
         'VariableOrLiteralOrWord_226', 
         'VariableOrLiteralOrWord_227', 
         'VariableOrLiteralOrWord_228', 
         'VariableSymbolOrSelf_229', 
         'VariableSymbolOrSelf_230', 
         'Literal_231', 
         'Literal_232', );
  $self;
}

#line 221 "lib/RPerl/Grammar.eyp"


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
Properties_67 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
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
Operator_100 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan', # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',       # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_102 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                 # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',               # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
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
Expression_129 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_130 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_131 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
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
HashEntryProperties_204 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> WORD OP20_HASH_FATARROW TypeInnerProperties
HashReference_208 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_209 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_212 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_213 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_214 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_215 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_216 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_217 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_218 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_219 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_220 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerProperties_221 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_222 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_223 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_224 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_225 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_226 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_227 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_228 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
VariableSymbolOrSelf_229 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_230 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_231 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_232 => 'RPerl::Operation::Expression::SubExpression::Literal::String'                   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 9110 lib/RPerl/Grammar.pm



1;
