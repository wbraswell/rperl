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
    our $VERSION = 0.001_960;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\$TYPED_|foreach|\=\ sub\ \{|while|elsif|undef|else|\@_\;|our|for|\@\{|if|\%\{|\]|\;|\}|\))}gc and return ($1, $1);

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
      /\G(sin|cos|push|pop|keys|values|sort|length|split|join|reverse|fakebuiltin)\s/gc and return ('OP01_NAMED', $1);
      /\G([a-z]\w*|[A-Z]\w*[a-z]\w*)/gc and return ('WORD', $1);
      /\G([A-Z][A-Z0-9_]*|[A-Z])/gc and return ('WORD_UPPERCASE', $1);
      /\G(:)/gc and return ('COLON', $1);
      /\G(\(\s*my)/gc and return ('LPAREN_MY', $1);
      /\G(\()/gc and return ('LPAREN', $1);
      /\G(\[)/gc and return ('LBRACKET', $1);
      /\G(\{)/gc and return ('LBRACE', $1);
      /\G(\S+)/gc and return ('NON_WHITESPACE', $1);


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


#line 137 lib/RPerl/Grammar.pm

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
  [ 'LoopWhile_169' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'PLUS-43', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-43', [ 'Operation' ], 0 ],
  [ 'CodeBlock_172' => 'CodeBlock', [ 'LBRACE', 'PLUS-43', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'Variable_175' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-44' ], 0 ],
  [ 'VariableRetrieval_176' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_178' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_179' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_182' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_183' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin' ], 0 ],
  [ 'VariableModification_184' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-45', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [ 'STAR-46', 'PAREN-45' ], 0 ],
  [ '_STAR_LIST' => 'STAR-46', [  ], 0 ],
  [ 'ListElements_188' => 'ListElements', [ 'ListElement', 'STAR-46' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-47', [ 'PLUS-47', 'NonWhitespace' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-47', [ 'NonWhitespace' ], 0 ],
  [ 'ListElement_191' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_192' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_193' => 'ListElement', [ 'OP01_QW', 'PLUS-47', ')' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'ArrayReference_196' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-48', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-49', [  ], 0 ],
  [ 'ArrayDereference_199' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_200' => 'ArrayDereference', [ '@{', 'OPTIONAL-49', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-50', [  ], 0 ],
  [ 'HashEntry_203' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-50', 'SubExpression' ], 0 ],
  [ 'HashEntry_204' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryProperties_205' => 'HashEntryProperties', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
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
  [ 'TypeInnerProperties_222' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_223' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_224' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_225' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_226' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_227' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_228' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_229' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'VariableSymbolOrSelf_230' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_231' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_232' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_233' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
  [ 'NonWhitespace_234' => 'NonWhitespace', [ 'NON_WHITESPACE' ], 0 ],
  [ 'NonWhitespace_235' => 'NonWhitespace', [ 'WORD' ], 0 ],
  [ 'NonWhitespace_236' => 'NonWhitespace', [ 'WORD_SCOPED' ], 0 ],
  [ 'NonWhitespace_237' => 'NonWhitespace', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'NonWhitespace_238' => 'NonWhitespace', [ 'TYPE_INTEGER' ], 0 ],
  [ 'NonWhitespace_239' => 'NonWhitespace', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'NonWhitespace_240' => 'NonWhitespace', [ 'SELF' ], 0 ],
  [ 'NonWhitespace_241' => 'NonWhitespace', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'NonWhitespace_242' => 'NonWhitespace', [ 'LITERAL_STRING' ], 0 ],
  [ 'NonWhitespace_243' => 'NonWhitespace', [ 'USE' ], 0 ],
  [ 'NonWhitespace_244' => 'NonWhitespace', [ 'MY' ], 0 ],
  [ 'NonWhitespace_245' => 'NonWhitespace', [ 'FHREF_SYMBOL' ], 0 ],
  [ 'NonWhitespace_246' => 'NonWhitespace', [ 'TYPE_FHREF' ], 0 ],
  [ 'NonWhitespace_247' => 'NonWhitespace', [ 'TYPE_METHOD' ], 0 ],
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
  'LoopWhile_169' => 169,
  '_PLUS_LIST' => 170,
  '_PLUS_LIST' => 171,
  'CodeBlock_172' => 172,
  '_STAR_LIST' => 173,
  '_STAR_LIST' => 174,
  'Variable_175' => 175,
  'VariableRetrieval_176' => 176,
  'VariableRetrieval_177' => 177,
  'VariableRetrieval_178' => 178,
  'VariableDeclaration_179' => 179,
  'VariableDeclaration_180' => 180,
  'VariableDeclaration_181' => 181,
  'VariableDeclaration_182' => 182,
  'VariableModification_183' => 183,
  'VariableModification_184' => 184,
  '_PAREN' => 185,
  '_STAR_LIST' => 186,
  '_STAR_LIST' => 187,
  'ListElements_188' => 188,
  '_PLUS_LIST' => 189,
  '_PLUS_LIST' => 190,
  'ListElement_191' => 191,
  'ListElement_192' => 192,
  'ListElement_193' => 193,
  '_OPTIONAL' => 194,
  '_OPTIONAL' => 195,
  'ArrayReference_196' => 196,
  '_OPTIONAL' => 197,
  '_OPTIONAL' => 198,
  'ArrayDereference_199' => 199,
  'ArrayDereference_200' => 200,
  '_OPTIONAL' => 201,
  '_OPTIONAL' => 202,
  'HashEntry_203' => 203,
  'HashEntry_204' => 204,
  'HashEntryProperties_205' => 205,
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
  'TypeInnerProperties_222' => 222,
  'TypeInnerProperties_223' => 223,
  'TypeInnerConstant_224' => 224,
  'VariableOrLiteral_225' => 225,
  'VariableOrLiteral_226' => 226,
  'VariableOrLiteralOrWord_227' => 227,
  'VariableOrLiteralOrWord_228' => 228,
  'VariableOrLiteralOrWord_229' => 229,
  'VariableSymbolOrSelf_230' => 230,
  'VariableSymbolOrSelf_231' => 231,
  'Literal_232' => 232,
  'Literal_233' => 233,
  'NonWhitespace_234' => 234,
  'NonWhitespace_235' => 235,
  'NonWhitespace_236' => 236,
  'NonWhitespace_237' => 237,
  'NonWhitespace_238' => 238,
  'NonWhitespace_239' => 239,
  'NonWhitespace_240' => 240,
  'NonWhitespace_241' => 241,
  'NonWhitespace_242' => 242,
  'NonWhitespace_243' => 243,
  'NonWhitespace_244' => 244,
  'NonWhitespace_245' => 245,
  'NonWhitespace_246' => 246,
  'NonWhitespace_247' => 247,
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
	NON_WHITESPACE => { ISSEMANTIC => 1 },
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
			'SHEBANG' => 2,
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'PLUS-2' => 8,
			'ModuleHeader' => 1,
			'PAREN-1' => 9,
			'OPTIONAL-9' => 3,
			'Program' => 5,
			'CompileUnit' => 4,
			'Critic' => 7
		}
	},
	{#State 1
		ACTIONS => {
			'USE' => -27,
			"use constant" => -27,
			"use parent qw(" => 10,
			"our" => -27,
			"## no critic qw(" => -27
		},
		GOTOS => {
			'Module' => 13,
			'Class' => 11,
			'STAR-11' => 12,
			'Package' => 14
		}
	},
	{#State 2
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'Critic' => 16,
			'OPTIONAL-3' => 15
		}
	},
	{#State 3
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 17
		},
		GOTOS => {
			'OPTIONAL-10' => 18
		}
	},
	{#State 4
		ACTIONS => {
			'' => 19
		}
	},
	{#State 5
		DEFAULT => -4
	},
	{#State 6
		ACTIONS => {
			'WORD' => 20
		},
		GOTOS => {
			'PLUS-16' => 21
		}
	},
	{#State 7
		DEFAULT => -19
	},
	{#State 8
		ACTIONS => {
			'' => -5,
			"package" => -20,
			'USE_RPERL' => -20,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'PAREN-1' => 22,
			'OPTIONAL-9' => 3,
			'ModuleHeader' => 1,
			'Critic' => 7
		}
	},
	{#State 9
		DEFAULT => -3
	},
	{#State 10
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 11
		DEFAULT => -25
	},
	{#State 12
		ACTIONS => {
			'USE' => -29,
			"use constant" => -29,
			"our" => -29,
			"## no critic qw(" => 6
		},
		GOTOS => {
			'STAR-12' => 26,
			'Critic' => 27
		}
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		DEFAULT => -24
	},
	{#State 15
		ACTIONS => {
			'USE_RPERL' => 28
		}
	},
	{#State 16
		DEFAULT => -6
	},
	{#State 17
		DEFAULT => -21
	},
	{#State 18
		ACTIONS => {
			"package" => 29
		}
	},
	{#State 19
		DEFAULT => 0
	},
	{#State 20
		DEFAULT => -39
	},
	{#State 21
		ACTIONS => {
			")" => 31,
			'WORD' => 30
		}
	},
	{#State 22
		DEFAULT => -2
	},
	{#State 23
		DEFAULT => -216
	},
	{#State 24
		ACTIONS => {
			")" => 32
		}
	},
	{#State 25
		DEFAULT => -215
	},
	{#State 26
		ACTIONS => {
			"our" => -31,
			'USE' => 33,
			"use constant" => -31
		},
		GOTOS => {
			'STAR-13' => 34,
			'Include' => 35
		}
	},
	{#State 27
		DEFAULT => -26
	},
	{#State 28
		ACTIONS => {
			"use strict;" => 36
		},
		GOTOS => {
			'Header' => 37
		}
	},
	{#State 29
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 23
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 30
		DEFAULT => -38
	},
	{#State 31
		DEFAULT => -40
	},
	{#State 32
		ACTIONS => {
			";" => 39
		}
	},
	{#State 33
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 34
		ACTIONS => {
			"use constant" => 45,
			"our" => 43
		},
		GOTOS => {
			'Subroutine' => 44,
			'PLUS-14' => 42,
			'Constant' => 41
		}
	},
	{#State 35
		DEFAULT => -28
	},
	{#State 36
		ACTIONS => {
			"use warnings;" => 46
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
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			'USE' => 33
		},
		GOTOS => {
			'Include' => 49
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_QW' => 50,
			";" => 51
		}
	},
	{#State 41
		DEFAULT => -30
	},
	{#State 42
		ACTIONS => {
			"our" => 43,
			'LITERAL_NUMBER' => 53
		},
		GOTOS => {
			'Subroutine' => 52
		}
	},
	{#State 43
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 44
		DEFAULT => -33
	},
	{#State 45
		ACTIONS => {
			'WORD_UPPERCASE' => 58
		}
	},
	{#State 46
		ACTIONS => {
			"our" => -36,
			'USE_RPERL_AFTER' => 59
		},
		GOTOS => {
			'OPTIONAL-15' => 60
		}
	},
	{#State 47
		ACTIONS => {
			'OP10_NAMED_UNARY' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_OPEN' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'VARIABLE_SYMBOL' => -11,
			'MY' => -11,
			'USE' => -11,
			'LITERAL_NUMBER' => -11,
			"while" => -11,
			"\@{" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"foreach" => -11,
			"use constant" => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LBRACE' => -11,
			'OP01_PRINT' => -11,
			"undef" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED' => -11,
			'LBRACKET' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"our" => -11,
			'WORD' => -11,
			"## no critic qw(" => 6,
			'SELF' => -11,
			'OP01_CLOSE' => -11,
			"if" => -11,
			'WORD_SCOPED' => -11,
			'LPAREN' => -11,
			"for" => -11,
			'WORD_UPPERCASE' => -11,
			"%{" => -11,
			'OP01_NAMED_VOID' => -11
		},
		GOTOS => {
			'Critic' => 61,
			'STAR-5' => 62
		}
	},
	{#State 48
		ACTIONS => {
			"use strict;" => 36
		},
		GOTOS => {
			'Header' => 63
		}
	},
	{#State 49
		DEFAULT => -56,
		GOTOS => {
			'STAR-22' => 64
		}
	},
	{#State 50
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-17' => 66
		}
	},
	{#State 51
		DEFAULT => -43
	},
	{#State 52
		DEFAULT => -32
	},
	{#State 53
		ACTIONS => {
			";" => 67
		}
	},
	{#State 54
		DEFAULT => -218
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 56
		DEFAULT => -220
	},
	{#State 57
		DEFAULT => -219
	},
	{#State 58
		ACTIONS => {
			'OP20_HASH_FATARROW' => 69
		}
	},
	{#State 59
		DEFAULT => -35
	},
	{#State 60
		ACTIONS => {
			"our" => 70
		}
	},
	{#State 61
		DEFAULT => -8
	},
	{#State 62
		ACTIONS => {
			"our" => -13,
			'WORD' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'LBRACKET' => -13,
			'OP01_CLOSE' => -13,
			'SELF' => -13,
			'WORD_SCOPED' => -13,
			"if" => -13,
			"%{" => -13,
			"for" => -13,
			'LPAREN' => -13,
			'WORD_UPPERCASE' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_OPEN' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP10_NAMED_UNARY' => -13,
			'LITERAL_NUMBER' => -13,
			"\@{" => -13,
			"while" => -13,
			'MY' => -13,
			'USE' => 33,
			'VARIABLE_SYMBOL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"foreach" => -13,
			"use constant" => -13,
			'LITERAL_STRING' => -13,
			'OP01_PRINT' => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"undef" => -13,
			'LBRACE' => -13
		},
		GOTOS => {
			'Include' => 72,
			'STAR-6' => 71
		}
	},
	{#State 63
		DEFAULT => -23
	},
	{#State 64
		ACTIONS => {
			"## no critic qw(" => 6,
			'USE' => -58,
			"use constant" => -58,
			"our hashref \$properties" => -58
		},
		GOTOS => {
			'STAR-23' => 74,
			'Critic' => 73
		}
	},
	{#State 65
		DEFAULT => -42
	},
	{#State 66
		ACTIONS => {
			")" => 75,
			'WORD' => 76
		}
	},
	{#State 67
		DEFAULT => -34
	},
	{#State 68
		ACTIONS => {
			"= sub {" => 77
		}
	},
	{#State 69
		ACTIONS => {
			'MY' => 79
		},
		GOTOS => {
			'TypeInnerConstant' => 78
		}
	},
	{#State 70
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 80
		}
	},
	{#State 71
		ACTIONS => {
			'OP10_NAMED_UNARY' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_OPEN' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'VARIABLE_SYMBOL' => -15,
			'MY' => -15,
			"while" => -15,
			"\@{" => -15,
			'LITERAL_NUMBER' => -15,
			'LITERAL_STRING' => -15,
			"foreach" => -15,
			'OP19_LOOP_CONTROL' => -15,
			"use constant" => 45,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'LBRACE' => -15,
			"undef" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED' => -15,
			'OP01_PRINT' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LBRACKET' => -15,
			'WORD' => -15,
			"our" => -15,
			"if" => -15,
			'WORD_SCOPED' => -15,
			'SELF' => -15,
			'OP01_CLOSE' => -15,
			'WORD_UPPERCASE' => -15,
			'LPAREN' => -15,
			"for" => -15,
			"%{" => -15,
			'OP01_NAMED_VOID' => -15
		},
		GOTOS => {
			'Constant' => 81,
			'STAR-7' => 82
		}
	},
	{#State 72
		DEFAULT => -10
	},
	{#State 73
		DEFAULT => -55
	},
	{#State 74
		ACTIONS => {
			"use constant" => -60,
			'USE' => 33,
			"our hashref \$properties" => -60
		},
		GOTOS => {
			'Include' => 84,
			'STAR-24' => 83
		}
	},
	{#State 75
		ACTIONS => {
			";" => 85
		}
	},
	{#State 76
		DEFAULT => -41
	},
	{#State 77
		ACTIONS => {
			'OP01_CLOSE' => -47,
			'SELF' => -47,
			"if" => -47,
			'WORD_SCOPED' => -47,
			'OP22_LOGICAL_NEG' => -47,
			'LBRACKET' => -47,
			'WORD' => -47,
			'OP01_NAMED_VOID' => -47,
			"for" => -47,
			'LPAREN' => -47,
			'WORD_UPPERCASE' => -47,
			"%{" => -47,
			'MY' => -47,
			"}" => -47,
			'VARIABLE_SYMBOL' => -47,
			'OP05_LOGICAL_NEG' => -47,
			'OP01_NAMED_VOID_LPAREN' => -47,
			'LITERAL_NUMBER' => -47,
			"\@{" => -47,
			"while" => -47,
			'OP10_NAMED_UNARY' => -47,
			'OP05_MATH_NEG_LPAREN' => -47,
			'OP03_MATH_INC_DEC' => -47,
			'OP01_OPEN' => -47,
			'CONSTANT_CALL_SCOPED' => -47,
			'LBRACE' => -47,
			'OP01_PRINT' => -47,
			'OP01_NAMED' => -47,
			'OP19_LOOP_CONTROL_SCOLON' => -47,
			"undef" => -47,
			'LPAREN_MY' => 88,
			'OP19_LOOP_CONTROL' => -47,
			"foreach" => -47,
			'LITERAL_STRING' => -47,
			'OP01_NAMED_VOID_SCOLON' => -47
		},
		GOTOS => {
			'OPTIONAL-18' => 86,
			'SubroutineArguments' => 87
		}
	},
	{#State 78
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'Literal' => 89
		}
	},
	{#State 79
		ACTIONS => {
			'WORD' => 54,
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 92
		}
	},
	{#State 80
		DEFAULT => -37
	},
	{#State 81
		DEFAULT => -12
	},
	{#State 82
		ACTIONS => {
			"%{" => 138,
			'LPAREN' => 139,
			"for" => -149,
			'WORD_UPPERCASE' => 140,
			'OP01_NAMED_VOID' => 136,
			"our" => 43,
			'WORD' => 25,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'SELF' => 129,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 23,
			"if" => 130,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP19_LOOP_CONTROL' => 125,
			"foreach" => -149,
			'LITERAL_STRING' => 90,
			'OP01_PRINT' => 114,
			'OP19_LOOP_CONTROL_SCOLON' => 120,
			"undef" => 119,
			'OP01_NAMED' => 117,
			'LBRACE' => 121,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP10_NAMED_UNARY' => 112,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			"while" => -149,
			'OP01_NAMED_VOID_LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 98
		},
		GOTOS => {
			'OPTIONAL-38' => 123,
			'Literal' => 124,
			'PAREN-37' => 137,
			'Operation' => 115,
			'Expression' => 118,
			'Operator' => 116,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'WordScoped' => 109,
			'VariableModification' => 132,
			'Subroutine' => 110,
			'Variable' => 111,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'LoopLabel' => 126,
			'VariableDeclaration' => 127,
			'HashReference' => 93,
			'OperatorVoid' => 95,
			'Conditional' => 96,
			'PLUS-8' => 99,
			'SubExpression' => 102,
			'Statement' => 103
		}
	},
	{#State 83
		ACTIONS => {
			"our hashref \$properties" => 141,
			"use constant" => 45
		},
		GOTOS => {
			'Constant' => 143,
			'Properties' => 142
		}
	},
	{#State 84
		DEFAULT => -57
	},
	{#State 85
		DEFAULT => -44
	},
	{#State 86
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 144
		}
	},
	{#State 87
		DEFAULT => -46
	},
	{#State 88
		ACTIONS => {
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 56,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 145
		}
	},
	{#State 89
		ACTIONS => {
			";" => 146
		}
	},
	{#State 90
		DEFAULT => -233
	},
	{#State 91
		DEFAULT => -232
	},
	{#State 92
		ACTIONS => {
			"\$TYPED_" => 147
		}
	},
	{#State 93
		DEFAULT => -140
	},
	{#State 94
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'MY' => 148,
			'SELF' => 129,
			'LBRACKET' => -198
		},
		GOTOS => {
			'OPTIONAL-49' => 149,
			'Variable' => 150,
			'VariableSymbolOrSelf' => 135,
			'TypeInner' => 151
		}
	},
	{#State 95
		DEFAULT => -152
	},
	{#State 96
		DEFAULT => -150
	},
	{#State 97
		DEFAULT => -230
	},
	{#State 98
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'TYPE_FHREF' => 152,
			'WORD_SCOPED' => 57,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 153
		}
	},
	{#State 99
		ACTIONS => {
			'SELF' => 129,
			'OP01_CLOSE' => 128,
			'' => -18,
			'WORD_SCOPED' => 23,
			"if" => 130,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP01_NAMED_VOID' => 136,
			"%{" => 138,
			'LPAREN' => 139,
			"for" => -149,
			'WORD_UPPERCASE' => 140,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			"while" => -149,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_NAMED_VOID_LPAREN' => 100,
			'MY' => 98,
			'VARIABLE_SYMBOL' => 97,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP10_NAMED_UNARY' => 112,
			'OP01_PRINT' => 114,
			"undef" => 119,
			'OP19_LOOP_CONTROL_SCOLON' => 120,
			'OP01_NAMED' => 117,
			'LBRACE' => 121,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP19_LOOP_CONTROL' => 125,
			"foreach" => -149,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'OPTIONAL-38' => 123,
			'Literal' => 124,
			'PAREN-37' => 137,
			'Operation' => 154,
			'Expression' => 118,
			'Operator' => 116,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Variable' => 111,
			'VariableModification' => 132,
			'WordScoped' => 109,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'LoopLabel' => 126,
			'VariableDeclaration' => 127,
			'HashReference' => 93,
			'OperatorVoid' => 95,
			'Conditional' => 96,
			'SubExpression' => 102,
			'Statement' => 103
		}
	},
	{#State 100
		ACTIONS => {
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121,
			"%{" => 138,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"\@{" => 94,
			")" => -115,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'MY' => 148,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_QW' => 157,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133
		},
		GOTOS => {
			'ListElement' => 161,
			'OPTIONAL-34' => 162,
			'TypeInner' => 155,
			'SubExpression' => 163,
			'HashReference' => 93,
			'ListElements' => 158,
			'Expression' => 159,
			'Operator' => 116,
			'WordScoped' => 109,
			'Variable' => 164,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124
		}
	},
	{#State 101
		ACTIONS => {
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			"%{" => 138,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139
		},
		GOTOS => {
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 165,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 164,
			'WordScoped' => 109
		}
	},
	{#State 102
		ACTIONS => {
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 175,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => 166,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181
		}
	},
	{#State 103
		DEFAULT => -81
	},
	{#State 104
		DEFAULT => -139
	},
	{#State 105
		ACTIONS => {
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			"%{" => 138,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121
		},
		GOTOS => {
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'SubExpression' => 183
		}
	},
	{#State 106
		DEFAULT => -130
	},
	{#State 107
		ACTIONS => {
			'SELF' => 129,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Variable' => 184,
			'VariableSymbolOrSelf' => 135
		}
	},
	{#State 108
		ACTIONS => {
			'MY' => 185
		}
	},
	{#State 109
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 187,
			'LPAREN' => 186
		}
	},
	{#State 110
		DEFAULT => -14
	},
	{#State 111
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP18_TERNARY' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP02_METHOD_THINARROW' => 191,
			'OP09_BITWISE_SHIFT' => -137,
			'OP19_VARIABLE_ASSIGN' => 190,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP08_STRING_CAT' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP03_MATH_INC_DEC' => 189,
			'OP19_VARIABLE_ASSIGN_BY' => 188,
			'OP17_LIST_RANGE' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			")" => -137,
			'OP04_MATH_POW' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP12_COMPARE_EQ_NE' => -137
		}
	},
	{#State 112
		ACTIONS => {
			"%{" => 138,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'OP06_REGEX_MATCH' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP16_LOGICAL_OR' => -99,
			'WORD' => 25,
			'OP07_STRING_REPEAT' => -99,
			'OP22_LOGICAL_NEG' => 133,
			'OP23_LOGICAL_AND' => -99,
			'LBRACKET' => 134,
			'OP21_LIST_COMMA' => -99,
			'OP04_MATH_POW' => -99,
			'OP15_LOGICAL_AND' => -99,
			'SELF' => 129,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 23,
			'OP18_TERNARY' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP11_COMPARE_LT_GT' => -99,
			'LITERAL_STRING' => 90,
			'OP09_BITWISE_SHIFT' => -99,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			'OP13_BITWISE_AND' => -99,
			'OP08_STRING_CAT' => -99,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			";" => -99,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP17_LIST_RANGE' => -99,
			'OP08_MATH_ADD_SUB' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'OP10_NAMED_UNARY' => 112,
			"]" => -99,
			'LITERAL_NUMBER' => 91,
			")" => -99,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 101,
			"}" => -99,
			'VARIABLE_SYMBOL' => 97,
			'OP12_COMPARE_EQ_NE' => -99
		},
		GOTOS => {
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'SubExpression' => 192,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116
		}
	},
	{#State 113
		DEFAULT => -138
	},
	{#State 114
		ACTIONS => {
			'OP01_NAMED' => -113,
			"undef" => -113,
			'LBRACE' => -113,
			"%{" => -113,
			'STDOUT_STDERR' => 195,
			'WORD_UPPERCASE' => -113,
			'LITERAL_STRING' => -113,
			'LPAREN' => -113,
			'FHREF_SYMBOL_BRACES' => 196,
			"\@{" => -113,
			'LITERAL_NUMBER' => -113,
			'WORD_SCOPED' => -113,
			'MY' => -113,
			'OP01_CLOSE' => -113,
			'VARIABLE_SYMBOL' => -113,
			'SELF' => -113,
			'OP01_QW' => -113,
			'OP05_LOGICAL_NEG' => -113,
			'WORD' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'OP01_OPEN' => -113,
			'OP03_MATH_INC_DEC' => -113,
			'CONSTANT_CALL_SCOPED' => -113,
			'LBRACKET' => -113,
			'OP22_LOGICAL_NEG' => -113,
			'OP10_NAMED_UNARY' => -113
		},
		GOTOS => {
			'PAREN-32' => 193,
			'OPTIONAL-33' => 194
		}
	},
	{#State 115
		DEFAULT => -17
	},
	{#State 116
		DEFAULT => -128
	},
	{#State 117
		ACTIONS => {
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_QW' => 157,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 148,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25
		},
		GOTOS => {
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'ListElement' => 198,
			'SubExpression' => 197,
			'TypeInner' => 155
		}
	},
	{#State 118
		ACTIONS => {
			'OP06_REGEX_MATCH' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP18_TERNARY' => -134,
			'OP08_STRING_CAT' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP17_LIST_RANGE' => -134,
			";" => 199,
			'OP16_LOGICAL_OR' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP15_LOGICAL_AND' => -134,
			'OP04_MATH_POW' => -134
		}
	},
	{#State 119
		DEFAULT => -135
	},
	{#State 120
		DEFAULT => -122
	},
	{#State 121
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			'WORD' => 204,
			"%{" => 138,
			"}" => 202,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 135,
			'Variable' => 201,
			'VariableOrLiteralOrWord' => 203,
			'HashEntry' => 206,
			'HashDereference' => 205,
			'Literal' => 200
		}
	},
	{#State 122
		DEFAULT => -118
	},
	{#State 123
		ACTIONS => {
			"while" => 213,
			"foreach" => 209,
			"for" => 207
		},
		GOTOS => {
			'LoopFor' => 212,
			'LoopWhile' => 211,
			'LoopForEach' => 210,
			'Loop' => 208
		}
	},
	{#State 124
		DEFAULT => -136
	},
	{#State 125
		ACTIONS => {
			'WORD_UPPERCASE' => 214
		},
		GOTOS => {
			'LoopLabel' => 215
		}
	},
	{#State 126
		ACTIONS => {
			'COLON' => 216
		}
	},
	{#State 127
		DEFAULT => -153
	},
	{#State 128
		ACTIONS => {
			'FHREF_SYMBOL' => 217
		}
	},
	{#State 129
		DEFAULT => -231
	},
	{#State 130
		ACTIONS => {
			'LPAREN' => 218
		}
	},
	{#State 131
		DEFAULT => -141
	},
	{#State 132
		ACTIONS => {
			";" => 219
		}
	},
	{#State 133
		ACTIONS => {
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25
		},
		GOTOS => {
			'SubExpression' => 220,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104
		}
	},
	{#State 134
		ACTIONS => {
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'MY' => 148,
			'VARIABLE_SYMBOL' => 97,
			'OP01_QW' => 157,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			"]" => -195,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121,
			"%{" => 138,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139
		},
		GOTOS => {
			'HashReference' => 93,
			'ListElements' => 221,
			'Operator' => 116,
			'Expression' => 159,
			'ListElement' => 161,
			'TypeInner' => 155,
			'SubExpression' => 163,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'Variable' => 164,
			'WordScoped' => 109,
			'OPTIONAL-48' => 222,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113
		}
	},
	{#State 135
		DEFAULT => -174,
		GOTOS => {
			'STAR-44' => 223
		}
	},
	{#State 136
		ACTIONS => {
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			"%{" => 138,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_QW' => 157,
			'MY' => 148,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133
		},
		GOTOS => {
			'SubExpression' => 163,
			'TypeInner' => 155,
			'ListElement' => 161,
			'Operator' => 116,
			'Expression' => 159,
			'ListElements' => 224,
			'HashReference' => 93,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 164,
			'WordScoped' => 109,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104
		}
	},
	{#State 137
		DEFAULT => -148
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'MY' => 148,
			'SELF' => 129,
			'LBRACE' => -212
		},
		GOTOS => {
			'Variable' => 227,
			'TypeInner' => 226,
			'VariableSymbolOrSelf' => 135,
			'OPTIONAL-53' => 225
		}
	},
	{#State 139
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'LBRACE' => 121,
			'OP01_NAMED' => 229,
			"undef" => 119,
			'OP01_PRINT' => 228,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138
		},
		GOTOS => {
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 230,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'Variable' => 164,
			'WordScoped' => 109
		}
	},
	{#State 140
		ACTIONS => {
			'COLON' => -217,
			'LPAREN' => 231
		}
	},
	{#State 141
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 232
		}
	},
	{#State 142
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 233
		}
	},
	{#State 143
		DEFAULT => -59
	},
	{#State 144
		ACTIONS => {
			"}" => 234,
			'MY' => 98,
			'VARIABLE_SYMBOL' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_NAMED_VOID_LPAREN' => 100,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			"while" => -149,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'LBRACE' => 121,
			'OP01_PRINT' => 114,
			'OP01_NAMED' => 117,
			"undef" => 119,
			'OP19_LOOP_CONTROL_SCOLON' => 120,
			'OP19_LOOP_CONTROL' => 125,
			"foreach" => -149,
			'LITERAL_STRING' => 90,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP01_CLOSE' => 128,
			'SELF' => 129,
			"if" => 130,
			'WORD_SCOPED' => 23,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'WORD' => 25,
			'OP01_NAMED_VOID' => 136,
			"for" => -149,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 140,
			"%{" => 138
		},
		GOTOS => {
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'VariableModification' => 132,
			'Variable' => 111,
			'WordScoped' => 109,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'SubExpression' => 102,
			'Statement' => 103,
			'Conditional' => 96,
			'OperatorVoid' => 95,
			'HashReference' => 93,
			'VariableDeclaration' => 127,
			'LoopLabel' => 126,
			'Literal' => 124,
			'OPTIONAL-38' => 123,
			'Expression' => 118,
			'Operator' => 116,
			'PAREN-37' => 137,
			'Operation' => 235
		}
	},
	{#State 145
		ACTIONS => {
			'VARIABLE_SYMBOL' => 236
		}
	},
	{#State 146
		DEFAULT => -45
	},
	{#State 147
		ACTIONS => {
			'WORD_UPPERCASE' => 237
		}
	},
	{#State 148
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 238
		}
	},
	{#State 149
		ACTIONS => {
			'LBRACKET' => 134
		},
		GOTOS => {
			'ArrayReference' => 239
		}
	},
	{#State 150
		ACTIONS => {
			"}" => 240
		}
	},
	{#State 151
		DEFAULT => -197
	},
	{#State 152
		ACTIONS => {
			'FHREF_SYMBOL' => 241
		}
	},
	{#State 153
		ACTIONS => {
			'VARIABLE_SYMBOL' => 242
		}
	},
	{#State 154
		DEFAULT => -16
	},
	{#State 155
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91
		},
		GOTOS => {
			'SubExpression' => 243,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131
		}
	},
	{#State 156
		ACTIONS => {
			'LPAREN' => 231
		}
	},
	{#State 157
		ACTIONS => {
			'LITERAL_NUMBER' => 248,
			'WORD_SCOPED' => 256,
			'TYPE_INTEGER' => 253,
			'TYPE_FHREF' => 259,
			'SELF' => 255,
			'TYPE_METHOD' => 258,
			'MY' => 246,
			'USE' => 247,
			'VARIABLE_SYMBOL' => 245,
			'NON_WHITESPACE' => 252,
			'WORD' => 254,
			'LITERAL_STRING' => 250,
			'WORD_UPPERCASE' => 257,
			'FHREF_SYMBOL' => 251
		},
		GOTOS => {
			'PLUS-47' => 249,
			'NonWhitespace' => 244
		}
	},
	{#State 158
		DEFAULT => -114
	},
	{#State 159
		DEFAULT => -134
	},
	{#State 160
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'WORD' => 25,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'WORD_SCOPED' => 23,
			"%{" => 138,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121
		},
		GOTOS => {
			'Operator' => 116,
			'Expression' => 159,
			'HashReference' => 93,
			'SubExpression' => 260,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'Variable' => 164,
			'WordScoped' => 109
		}
	},
	{#State 161
		DEFAULT => -187,
		GOTOS => {
			'STAR-46' => 261
		}
	},
	{#State 162
		ACTIONS => {
			")" => 262
		}
	},
	{#State 163
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP23_LOGICAL_AND' => 166,
			"]" => -191,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP16_LOGICAL_OR' => 168,
			";" => -191,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP04_MATH_POW' => 170,
			'OP21_LIST_COMMA' => -191,
			")" => -191,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 171,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP11_COMPARE_LT_GT' => 177,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172
		}
	},
	{#State 164
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 189,
			";" => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			'OP23_LOGICAL_AND' => -137,
			"]" => -137,
			")" => -137,
			'OP04_MATH_POW' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP15_LOGICAL_AND' => -137,
			"}" => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP18_TERNARY' => -137,
			'OP11_COMPARE_LT_GT' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP02_METHOD_THINARROW' => 191,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP08_STRING_CAT' => -137
		}
	},
	{#State 165
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP18_TERNARY' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			'OP08_STRING_CAT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP16_LOGICAL_OR' => -90,
			";" => -90,
			'OP17_LIST_RANGE' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP23_LOGICAL_AND' => -90,
			"]" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			")" => -90,
			'OP21_LIST_COMMA' => -90,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => -90,
			"}" => -90,
			'OP12_COMPARE_EQ_NE' => -90
		}
	},
	{#State 166
		ACTIONS => {
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160
		},
		GOTOS => {
			'SubExpression' => 263,
			'Operator' => 116,
			'Expression' => 159,
			'HashReference' => 93,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'WordScoped' => 109,
			'Variable' => 164,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104
		}
	},
	{#State 167
		ACTIONS => {
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			"%{" => 138,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121
		},
		GOTOS => {
			'SubExpression' => 264,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104
		}
	},
	{#State 168
		ACTIONS => {
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			"%{" => 138,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139
		},
		GOTOS => {
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 265,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'WordScoped' => 109,
			'Variable' => 164
		}
	},
	{#State 169
		ACTIONS => {
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			"%{" => 138,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121
		},
		GOTOS => {
			'SubExpression' => 266,
			'Operator' => 116,
			'Expression' => 159,
			'HashReference' => 93,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'WordScoped' => 109,
			'Variable' => 164,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104
		}
	},
	{#State 170
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91
		},
		GOTOS => {
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'SubExpression' => 267
		}
	},
	{#State 171
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 268
		}
	},
	{#State 172
		ACTIONS => {
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 23,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134
		},
		GOTOS => {
			'SubExpression' => 269,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 164,
			'WordScoped' => 109,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104
		}
	},
	{#State 173
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'WORD' => 25,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'WordScoped' => 109,
			'Variable' => 164,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 270
		}
	},
	{#State 174
		ACTIONS => {
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139,
			"%{" => 138,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91
		},
		GOTOS => {
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'SubExpression' => 271
		}
	},
	{#State 175
		ACTIONS => {
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'WORD' => 25,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			"%{" => 138
		},
		GOTOS => {
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 272,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 164,
			'WordScoped' => 109
		}
	},
	{#State 176
		ACTIONS => {
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138
		},
		GOTOS => {
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116,
			'SubExpression' => 273
		}
	},
	{#State 177
		ACTIONS => {
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25
		},
		GOTOS => {
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'WordScoped' => 109,
			'Variable' => 164,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 274
		}
	},
	{#State 178
		ACTIONS => {
			'WORD' => 25,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			"%{" => 138,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121
		},
		GOTOS => {
			'WordScoped' => 109,
			'Variable' => 164,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'SubExpression' => 275,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159
		}
	},
	{#State 179
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			'LITERAL_STRING' => 90,
			'SELF' => 129,
			'VARIABLE_SYMBOL' => 97
		},
		GOTOS => {
			'Literal' => 277,
			'VariableSymbolOrSelf' => 135,
			'VariableOrLiteral' => 278,
			'Variable' => 276
		}
	},
	{#State 180
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116,
			'SubExpression' => 279
		}
	},
	{#State 181
		ACTIONS => {
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106
		},
		GOTOS => {
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 164,
			'WordScoped' => 109,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'SubExpression' => 280,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93
		}
	},
	{#State 182
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 23,
			"%{" => 138,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121
		},
		GOTOS => {
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'SubExpression' => 281
		}
	},
	{#State 183
		ACTIONS => {
			'OP15_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 170,
			")" => 282,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP17_LIST_RANGE' => 175,
			'OP16_LOGICAL_OR' => 168,
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP11_COMPARE_LT_GT' => 177,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP06_REGEX_MATCH' => 171
		}
	},
	{#State 184
		DEFAULT => -87
	},
	{#State 185
		ACTIONS => {
			'TYPE_FHREF' => 283
		}
	},
	{#State 186
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 148,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_QW' => 157,
			"\@{" => 94,
			")" => -125,
			'LITERAL_NUMBER' => 91,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124,
			'TypeInner' => 155,
			'SubExpression' => 163,
			'ListElement' => 161,
			'Expression' => 159,
			'Operator' => 116,
			'OPTIONAL-35' => 284,
			'HashReference' => 93,
			'ListElements' => 285
		}
	},
	{#State 187
		ACTIONS => {
			")" => 286
		}
	},
	{#State 188
		ACTIONS => {
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160
		},
		GOTOS => {
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 287,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'WordScoped' => 109,
			'Variable' => 164
		}
	},
	{#State 189
		DEFAULT => -88
	},
	{#State 190
		ACTIONS => {
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 23,
			"%{" => 138,
			'STDIN' => 289,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121
		},
		GOTOS => {
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 164,
			'WordScoped' => 109,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'SubExpression' => 288,
			'SubExpressionOrStdin' => 290,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93
		}
	},
	{#State 191
		ACTIONS => {
			'LPAREN' => 291
		}
	},
	{#State 192
		ACTIONS => {
			'OP16_LOGICAL_OR' => -98,
			";" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => -98,
			"]" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			")" => -98,
			'OP21_LIST_COMMA' => -98,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => -98,
			"}" => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP18_TERNARY' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP11_COMPARE_LT_GT' => -98,
			'OP06_REGEX_MATCH' => 171,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => -98
		}
	},
	{#State 193
		DEFAULT => -112
	},
	{#State 194
		ACTIONS => {
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_QW' => 157,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 148,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94
		},
		GOTOS => {
			'HashReference' => 93,
			'ListElements' => 292,
			'Operator' => 116,
			'Expression' => 159,
			'ListElement' => 161,
			'SubExpression' => 163,
			'TypeInner' => 155,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135
		}
	},
	{#State 195
		DEFAULT => -111
	},
	{#State 196
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'MY' => 148,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_QW' => 157,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'TypeInner' => 155,
			'SubExpression' => 163,
			'ListElement' => 161,
			'Expression' => 159,
			'Operator' => 116,
			'ListElements' => 293,
			'HashReference' => 93,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131
		}
	},
	{#State 197
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -83,
			'OP18_TERNARY' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP08_STRING_CAT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP16_LOGICAL_OR' => -83,
			";" => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP15_LOGICAL_AND' => -83,
			")" => -83,
			'OP21_LIST_COMMA' => -191,
			'OP04_MATH_POW' => -83,
			'OP12_COMPARE_EQ_NE' => -83
		}
	},
	{#State 198
		ACTIONS => {
			'OP21_LIST_COMMA' => 294
		}
	},
	{#State 199
		DEFAULT => -80
	},
	{#State 200
		DEFAULT => -228
	},
	{#State 201
		DEFAULT => -227
	},
	{#State 202
		DEFAULT => -210
	},
	{#State 203
		ACTIONS => {
			'OP20_HASH_FATARROW' => 295
		}
	},
	{#State 204
		DEFAULT => -229
	},
	{#State 205
		DEFAULT => -204
	},
	{#State 206
		DEFAULT => -208,
		GOTOS => {
			'STAR-52' => 296
		}
	},
	{#State 207
		ACTIONS => {
			'MY' => 297,
			'LPAREN_MY' => 298
		}
	},
	{#State 208
		DEFAULT => -151
	},
	{#State 209
		ACTIONS => {
			'MY' => 299
		}
	},
	{#State 210
		DEFAULT => -163
	},
	{#State 211
		DEFAULT => -164
	},
	{#State 212
		DEFAULT => -162
	},
	{#State 213
		ACTIONS => {
			'LPAREN_MY' => 301,
			'LPAREN' => 300
		}
	},
	{#State 214
		DEFAULT => -217
	},
	{#State 215
		ACTIONS => {
			";" => 302
		}
	},
	{#State 216
		DEFAULT => -147
	},
	{#State 217
		DEFAULT => -86
	},
	{#State 218
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160
		},
		GOTOS => {
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'WordScoped' => 109,
			'Variable' => 164,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'SubExpression' => 303
		}
	},
	{#State 219
		DEFAULT => -154
	},
	{#State 220
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			'OP21_LIST_COMMA' => -108,
			")" => -108,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => 169,
			"}" => -108,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP16_LOGICAL_OR' => 168,
			";" => -108,
			'OP17_LIST_RANGE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => -108,
			'OP23_LOGICAL_AND' => -108
		}
	},
	{#State 221
		DEFAULT => -194
	},
	{#State 222
		ACTIONS => {
			"]" => 304
		}
	},
	{#State 223
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -175,
			'OP19_VARIABLE_ASSIGN' => -175,
			'OP09_BITWISE_SHIFT' => -175,
			'OP02_METHOD_THINARROW' => -175,
			'OP02_ARRAY_THINARROW' => 307,
			'OP13_BITWISE_AND' => -175,
			'OP08_STRING_CAT' => -175,
			'OP11_COMPARE_LT_GT' => -175,
			'OP18_TERNARY' => -175,
			'OP24_LOGICAL_OR_XOR' => -175,
			'OP02_HASH_THINARROW' => 306,
			'OP06_REGEX_MATCH' => -175,
			'OP15_LOGICAL_AND' => -175,
			'OP04_MATH_POW' => -175,
			'OP21_LIST_COMMA' => -175,
			")" => -175,
			'OP12_COMPARE_EQ_NE' => -175,
			'OP20_HASH_FATARROW' => -175,
			"}" => -175,
			'OP17_LIST_RANGE' => -175,
			'OP19_VARIABLE_ASSIGN_BY' => -175,
			'OP03_MATH_INC_DEC' => -175,
			'OP16_LOGICAL_OR' => -175,
			";" => -175,
			'OP07_MATH_MULT_DIV_MOD' => -175,
			'COLON' => -175,
			"]" => -175,
			'OP23_LOGICAL_AND' => -175,
			'OP08_MATH_ADD_SUB' => -175,
			'OP07_STRING_REPEAT' => -175
		},
		GOTOS => {
			'VariableRetrieval' => 305
		}
	},
	{#State 224
		ACTIONS => {
			";" => 308
		}
	},
	{#State 225
		ACTIONS => {
			'LBRACE' => 121
		},
		GOTOS => {
			'HashReference' => 309
		}
	},
	{#State 226
		DEFAULT => -211
	},
	{#State 227
		ACTIONS => {
			"}" => 310
		}
	},
	{#State 228
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 311
		}
	},
	{#State 229
		ACTIONS => {
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'SELF' => 129,
			'OP01_QW' => 157,
			'OP05_LOGICAL_NEG' => 101,
			'MY' => 148,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 23,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133
		},
		GOTOS => {
			'TypeInner' => 155,
			'SubExpression' => 197,
			'ListElement' => 312,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124
		}
	},
	{#State 230
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 177,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP06_REGEX_MATCH' => 171,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP17_LIST_RANGE' => 175,
			'OP16_LOGICAL_OR' => 168,
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP15_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 170,
			")" => 313,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 231
		ACTIONS => {
			")" => 314
		}
	},
	{#State 232
		ACTIONS => {
			'LBRACE' => 315
		}
	},
	{#State 233
		ACTIONS => {
			"our" => 318,
			'LITERAL_NUMBER' => 316
		},
		GOTOS => {
			'Method' => 320,
			'Subroutine' => 317,
			'MethodOrSubroutine' => 319
		}
	},
	{#State 234
		ACTIONS => {
			";" => 321
		}
	},
	{#State 235
		DEFAULT => -48
	},
	{#State 236
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 322
		}
	},
	{#State 237
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 323
		}
	},
	{#State 238
		ACTIONS => {
			"\$TYPED_" => 324
		}
	},
	{#State 239
		ACTIONS => {
			"}" => 325
		}
	},
	{#State 240
		DEFAULT => -199
	},
	{#State 241
		ACTIONS => {
			";" => 326
		}
	},
	{#State 242
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 328,
			";" => 327,
			'OP19_VARIABLE_ASSIGN' => 329
		}
	},
	{#State 243
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 177,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP06_REGEX_MATCH' => 171,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP17_LIST_RANGE' => 175,
			";" => -192,
			'OP16_LOGICAL_OR' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => -192,
			'OP23_LOGICAL_AND' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP15_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 170,
			'OP21_LIST_COMMA' => -192,
			")" => -192,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 244
		DEFAULT => -190
	},
	{#State 245
		DEFAULT => -239
	},
	{#State 246
		DEFAULT => -244
	},
	{#State 247
		DEFAULT => -243
	},
	{#State 248
		DEFAULT => -241
	},
	{#State 249
		ACTIONS => {
			'WORD' => 254,
			'NON_WHITESPACE' => 252,
			'FHREF_SYMBOL' => 251,
			'WORD_UPPERCASE' => 257,
			'LITERAL_STRING' => 250,
			'LITERAL_NUMBER' => 248,
			")" => 330,
			'TYPE_INTEGER' => 253,
			'TYPE_FHREF' => 259,
			'WORD_SCOPED' => 256,
			'MY' => 246,
			'VARIABLE_SYMBOL' => 245,
			'USE' => 247,
			'TYPE_METHOD' => 258,
			'SELF' => 255
		},
		GOTOS => {
			'NonWhitespace' => 331
		}
	},
	{#State 250
		DEFAULT => -242
	},
	{#State 251
		DEFAULT => -245
	},
	{#State 252
		DEFAULT => -234
	},
	{#State 253
		DEFAULT => -238
	},
	{#State 254
		DEFAULT => -235
	},
	{#State 255
		DEFAULT => -240
	},
	{#State 256
		DEFAULT => -236
	},
	{#State 257
		DEFAULT => -237
	},
	{#State 258
		DEFAULT => -247
	},
	{#State 259
		DEFAULT => -246
	},
	{#State 260
		ACTIONS => {
			"}" => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			'OP21_LIST_COMMA' => -83,
			")" => -83,
			'OP04_MATH_POW' => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			"]" => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP16_LOGICAL_OR' => -83,
			";" => -83,
			'OP17_LIST_RANGE' => -83,
			'OP08_STRING_CAT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP18_TERNARY' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP11_COMPARE_LT_GT' => -83
		}
	},
	{#State 261
		ACTIONS => {
			"]" => -188,
			";" => -188,
			")" => -188,
			'OP21_LIST_COMMA' => 333
		},
		GOTOS => {
			'PAREN-45' => 332
		}
	},
	{#State 262
		ACTIONS => {
			";" => 334
		}
	},
	{#State 263
		ACTIONS => {
			"}" => -109,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP21_LIST_COMMA' => -109,
			")" => -109,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => -109,
			'OP23_LOGICAL_AND' => -109,
			'OP16_LOGICAL_OR' => 168,
			";" => -109,
			'OP17_LIST_RANGE' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP06_REGEX_MATCH' => 171,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 177
		}
	},
	{#State 264
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP08_STRING_CAT' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP18_TERNARY' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP06_REGEX_MATCH' => 171,
			")" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => -93,
			"}" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP16_LOGICAL_OR' => -93,
			";" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP07_STRING_REPEAT' => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			"]" => -93,
			'OP23_LOGICAL_AND' => -93
		}
	},
	{#State 265
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 176,
			"}" => -105,
			'OP15_LOGICAL_AND' => 169,
			'OP21_LIST_COMMA' => -105,
			'OP04_MATH_POW' => 170,
			")" => -105,
			"]" => -105,
			'OP23_LOGICAL_AND' => -105,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP17_LIST_RANGE' => -105,
			";" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => 177,
			'OP18_TERNARY' => -105,
			'OP24_LOGICAL_OR_XOR' => -105
		}
	},
	{#State 266
		ACTIONS => {
			'OP16_LOGICAL_OR' => -104,
			";" => -104,
			'OP17_LIST_RANGE' => -104,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => -104,
			"]" => -104,
			'OP21_LIST_COMMA' => -104,
			'OP04_MATH_POW' => 170,
			")" => -104,
			'OP15_LOGICAL_AND' => -104,
			"}" => -104,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP18_TERNARY' => -104,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181
		}
	},
	{#State 267
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP23_LOGICAL_AND' => -89,
			"]" => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP17_LIST_RANGE' => -89,
			";" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			"}" => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP04_MATH_POW' => 170,
			")" => -89,
			'OP06_REGEX_MATCH' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP18_TERNARY' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_STRING_CAT' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP09_BITWISE_SHIFT' => -89
		}
	},
	{#State 268
		DEFAULT => -92
	},
	{#State 269
		ACTIONS => {
			'OP06_REGEX_MATCH' => 171,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP18_TERNARY' => -103,
			'OP11_COMPARE_LT_GT' => 177,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => -103,
			"]" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP16_LOGICAL_OR' => -103,
			";" => -103,
			'OP17_LIST_RANGE' => -103,
			"}" => -103,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP21_LIST_COMMA' => -103,
			")" => -103,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => -103
		}
	},
	{#State 270
		ACTIONS => {
			'OP13_BITWISE_AND' => -94,
			'OP08_STRING_CAT' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => -94,
			'OP18_TERNARY' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			"}" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			")" => -94,
			'OP04_MATH_POW' => 170,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			"]" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP08_MATH_ADD_SUB' => -94,
			'OP07_STRING_REPEAT' => 167,
			'OP17_LIST_RANGE' => -94,
			";" => -94,
			'OP16_LOGICAL_OR' => -94
		}
	},
	{#State 271
		ACTIONS => {
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => -95,
			'OP18_TERNARY' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP08_STRING_CAT' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => -95,
			"]" => -95,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => -95,
			'OP17_LIST_RANGE' => -95,
			";" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"}" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP04_MATH_POW' => 170,
			'OP21_LIST_COMMA' => -95,
			")" => -95
		}
	},
	{#State 272
		ACTIONS => {
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP06_REGEX_MATCH' => 171,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP18_TERNARY' => -106,
			'OP11_COMPARE_LT_GT' => 177,
			"}" => -106,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP21_LIST_COMMA' => -106,
			")" => -106,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => -106,
			'OP23_LOGICAL_AND' => -106,
			'OP16_LOGICAL_OR' => 168,
			";" => -106,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 273
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			")" => -101,
			'OP21_LIST_COMMA' => -101,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => -101,
			"}" => -101,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP16_LOGICAL_OR' => -101,
			";" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			"]" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 173
		}
	},
	{#State 274
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => undef,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP18_TERNARY' => -100,
			'OP06_REGEX_MATCH' => 171,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP09_BITWISE_SHIFT' => 182,
			'OP13_BITWISE_AND' => -100,
			'OP08_STRING_CAT' => 181,
			'OP17_LIST_RANGE' => -100,
			";" => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP15_LOGICAL_AND' => -100,
			")" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP04_MATH_POW' => 170,
			'OP12_COMPARE_EQ_NE' => -100,
			"}" => -100
		}
	},
	{#State 275
		ACTIONS => {
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => 177,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => 166,
			"]" => -110,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP17_LIST_RANGE' => 175,
			";" => -110,
			'OP16_LOGICAL_OR' => 168,
			'OP12_COMPARE_EQ_NE' => 176,
			"}" => -110,
			'OP15_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 170,
			'OP21_LIST_COMMA' => -110,
			")" => -110
		}
	},
	{#State 276
		DEFAULT => -225
	},
	{#State 277
		DEFAULT => -226
	},
	{#State 278
		ACTIONS => {
			'COLON' => 335
		}
	},
	{#State 279
		ACTIONS => {
			'OP06_REGEX_MATCH' => 171,
			'OP18_TERNARY' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => 177,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => -102,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => -102,
			"]" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP16_LOGICAL_OR' => -102,
			";" => -102,
			'OP17_LIST_RANGE' => -102,
			"}" => -102,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 170,
			")" => -102,
			'OP15_LOGICAL_AND' => -102
		}
	},
	{#State 280
		ACTIONS => {
			'OP13_BITWISE_AND' => -96,
			'OP08_STRING_CAT' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP06_REGEX_MATCH' => 171,
			'OP18_TERNARY' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			"}" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP04_MATH_POW' => 170,
			")" => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			";" => -96,
			'OP17_LIST_RANGE' => -96
		}
	},
	{#State 281
		ACTIONS => {
			'OP23_LOGICAL_AND' => -97,
			"]" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP17_LIST_RANGE' => -97,
			";" => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			"}" => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP04_MATH_POW' => 170,
			")" => -97,
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP18_TERNARY' => -97,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP09_BITWISE_SHIFT' => -97
		}
	},
	{#State 282
		DEFAULT => -91
	},
	{#State 283
		ACTIONS => {
			'FHREF_SYMBOL' => 336
		}
	},
	{#State 284
		ACTIONS => {
			")" => 337
		}
	},
	{#State 285
		DEFAULT => -124
	},
	{#State 286
		DEFAULT => -133
	},
	{#State 287
		ACTIONS => {
			'OP16_LOGICAL_OR' => 168,
			";" => -184,
			'OP17_LIST_RANGE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP04_MATH_POW' => 170,
			")" => -184,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180
		}
	},
	{#State 288
		ACTIONS => {
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => 166,
			'OP16_LOGICAL_OR' => 168,
			";" => -143,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP04_MATH_POW' => 170,
			")" => -143,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 171,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 177,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172
		}
	},
	{#State 289
		DEFAULT => -144
	},
	{#State 290
		DEFAULT => -183
	},
	{#State 291
		ACTIONS => {
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 148,
			'SELF' => 129,
			'OP01_QW' => 157,
			'OP05_LOGICAL_NEG' => 101,
			"\@{" => 94,
			")" => -127,
			'LITERAL_NUMBER' => 91,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106
		},
		GOTOS => {
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 164,
			'WordScoped' => 109,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'SubExpression' => 163,
			'TypeInner' => 155,
			'ListElement' => 161,
			'OPTIONAL-36' => 339,
			'Operator' => 116,
			'Expression' => 159,
			'ListElements' => 338,
			'HashReference' => 93
		}
	},
	{#State 292
		ACTIONS => {
			";" => 340
		}
	},
	{#State 293
		ACTIONS => {
			";" => 341
		}
	},
	{#State 294
		ACTIONS => {
			'OP01_CLOSE' => 128,
			'MY' => 148,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP01_QW' => 157,
			'OP05_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'WORD' => 25,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			"%{" => 138
		},
		GOTOS => {
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'WordScoped' => 109,
			'Variable' => 164,
			'Operator' => 116,
			'Expression' => 159,
			'HashReference' => 93,
			'ListElements' => 342,
			'TypeInner' => 155,
			'SubExpression' => 163,
			'ListElement' => 161
		}
	},
	{#State 295
		ACTIONS => {
			"undef" => -202,
			'OP01_NAMED' => -202,
			'LBRACE' => -202,
			"%{" => -202,
			'LPAREN' => -202,
			'LITERAL_STRING' => -202,
			'WORD_UPPERCASE' => -202,
			'LITERAL_NUMBER' => -202,
			"\@{" => -202,
			'OP05_LOGICAL_NEG' => -202,
			'SELF' => -202,
			'OP01_CLOSE' => -202,
			'MY' => 148,
			'VARIABLE_SYMBOL' => -202,
			'WORD_SCOPED' => -202,
			'CONSTANT_CALL_SCOPED' => -202,
			'OP01_OPEN' => -202,
			'OP03_MATH_INC_DEC' => -202,
			'OP05_MATH_NEG_LPAREN' => -202,
			'WORD' => -202,
			'LBRACKET' => -202,
			'OP10_NAMED_UNARY' => -202,
			'OP22_LOGICAL_NEG' => -202
		},
		GOTOS => {
			'TypeInner' => 343,
			'OPTIONAL-50' => 344
		}
	},
	{#State 296
		ACTIONS => {
			"}" => 347,
			'OP21_LIST_COMMA' => 345
		},
		GOTOS => {
			'PAREN-51' => 346
		}
	},
	{#State 297
		ACTIONS => {
			'TYPE_INTEGER' => 348
		}
	},
	{#State 298
		ACTIONS => {
			'TYPE_INTEGER' => 349
		}
	},
	{#State 299
		ACTIONS => {
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 56,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 350
		}
	},
	{#State 300
		ACTIONS => {
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107
		},
		GOTOS => {
			'SubExpression' => 351,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116,
			'Variable' => 164,
			'WordScoped' => 109,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131
		}
	},
	{#State 301
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 352
		}
	},
	{#State 302
		DEFAULT => -123
	},
	{#State 303
		ACTIONS => {
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP17_LIST_RANGE' => 175,
			'OP16_LOGICAL_OR' => 168,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP15_LOGICAL_AND' => 169,
			")" => 353,
			'OP04_MATH_POW' => 170,
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => 177,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182
		}
	},
	{#State 304
		DEFAULT => -196
	},
	{#State 305
		DEFAULT => -173
	},
	{#State 306
		ACTIONS => {
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'WORD' => 354,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106
		},
		GOTOS => {
			'SubExpression' => 355,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124
		}
	},
	{#State 307
		ACTIONS => {
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			"%{" => 138,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121
		},
		GOTOS => {
			'SubExpression' => 356,
			'Expression' => 159,
			'Operator' => 116,
			'HashReference' => 93,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 164,
			'WordScoped' => 109,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104
		}
	},
	{#State 308
		DEFAULT => -120
	},
	{#State 309
		ACTIONS => {
			"}" => 357
		}
	},
	{#State 310
		DEFAULT => -213
	},
	{#State 311
		ACTIONS => {
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			"%{" => 138,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 148,
			'OP01_QW' => 157,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 109,
			'Variable' => 164,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'ListElement' => 161,
			'TypeInner' => 155,
			'SubExpression' => 163,
			'ListElements' => 358,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159
		}
	},
	{#State 312
		ACTIONS => {
			'OP21_LIST_COMMA' => 359
		}
	},
	{#State 313
		DEFAULT => -142
	},
	{#State 314
		DEFAULT => -129
	},
	{#State 315
		ACTIONS => {
			"}" => 361,
			'WORD' => 360
		},
		GOTOS => {
			'HashEntryProperties' => 362
		}
	},
	{#State 316
		ACTIONS => {
			";" => 363
		}
	},
	{#State 317
		DEFAULT => -79
	},
	{#State 318
		ACTIONS => {
			'WORD' => 54,
			'TYPE_METHOD' => 364,
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 319
		DEFAULT => -61
	},
	{#State 320
		DEFAULT => -78
	},
	{#State 321
		DEFAULT => -50
	},
	{#State 322
		ACTIONS => {
			'OP21_LIST_COMMA' => 365,
			")" => 367
		},
		GOTOS => {
			'PAREN-20' => 366
		}
	},
	{#State 323
		DEFAULT => -224
	},
	{#State 324
		ACTIONS => {
			'WORD' => 368
		}
	},
	{#State 325
		DEFAULT => -200
	},
	{#State 326
		DEFAULT => -182
	},
	{#State 327
		DEFAULT => -179
	},
	{#State 328
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'WORD' => 25,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			"%{" => 138
		},
		GOTOS => {
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'WordScoped' => 109,
			'Variable' => 164,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116,
			'SubExpression' => 369
		}
	},
	{#State 329
		ACTIONS => {
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'WORD' => 25,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139,
			'STDIN' => 289,
			"%{" => 138
		},
		GOTOS => {
			'SubExpression' => 288,
			'SubExpressionOrStdin' => 370,
			'Operator' => 116,
			'Expression' => 159,
			'HashReference' => 93,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124
		}
	},
	{#State 330
		DEFAULT => -193
	},
	{#State 331
		DEFAULT => -189
	},
	{#State 332
		DEFAULT => -186
	},
	{#State 333
		ACTIONS => {
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'WORD' => 25,
			'OP01_CLOSE' => 128,
			'MY' => 148,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_QW' => 157,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			"%{" => 138,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119
		},
		GOTOS => {
			'Variable' => 164,
			'WordScoped' => 109,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131,
			'ListElement' => 371,
			'TypeInner' => 155,
			'SubExpression' => 163,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159
		}
	},
	{#State 334
		DEFAULT => -119
	},
	{#State 335
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			'LITERAL_STRING' => 90,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129
		},
		GOTOS => {
			'Literal' => 277,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 276,
			'VariableOrLiteral' => 372
		}
	},
	{#State 336
		ACTIONS => {
			'OP21_LIST_COMMA' => 373
		}
	},
	{#State 337
		DEFAULT => -131
	},
	{#State 338
		DEFAULT => -126
	},
	{#State 339
		ACTIONS => {
			")" => 374
		}
	},
	{#State 340
		DEFAULT => -116
	},
	{#State 341
		DEFAULT => -117
	},
	{#State 342
		ACTIONS => {
			";" => 375
		}
	},
	{#State 343
		DEFAULT => -201
	},
	{#State 344
		ACTIONS => {
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD_SCOPED' => 23,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139,
			"%{" => 138,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160
		},
		GOTOS => {
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124,
			'WordScoped' => 109,
			'Variable' => 164,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'SubExpression' => 376
		}
	},
	{#State 345
		ACTIONS => {
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'LITERAL_STRING' => 90,
			'LITERAL_NUMBER' => 91,
			'WORD' => 204,
			"%{" => 138
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 135,
			'VariableOrLiteralOrWord' => 203,
			'Variable' => 201,
			'Literal' => 200,
			'HashDereference' => 205,
			'HashEntry' => 377
		}
	},
	{#State 346
		DEFAULT => -207
	},
	{#State 347
		DEFAULT => -209
	},
	{#State 348
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 349
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 350
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 351
		ACTIONS => {
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 175,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP04_MATH_POW' => 170,
			")" => 381,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 352
		ACTIONS => {
			'VARIABLE_SYMBOL' => 382
		}
	},
	{#State 353
		ACTIONS => {
			'LBRACE' => 383
		},
		GOTOS => {
			'CodeBlock' => 384
		}
	},
	{#State 354
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -215,
			"}" => 385,
			'LPAREN' => -215
		}
	},
	{#State 355
		ACTIONS => {
			'OP17_LIST_RANGE' => 175,
			'OP16_LOGICAL_OR' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP15_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 170,
			'OP12_COMPARE_EQ_NE' => 176,
			"}" => 386,
			'OP11_COMPARE_LT_GT' => 177,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP06_REGEX_MATCH' => 171,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181
		}
	},
	{#State 356
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => 387,
			'OP23_LOGICAL_AND' => 166
		}
	},
	{#State 357
		DEFAULT => -214
	},
	{#State 358
		ACTIONS => {
			")" => 388
		}
	},
	{#State 359
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'MY' => 148,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_QW' => 157,
			'WORD_SCOPED' => 23,
			"%{" => 138,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121
		},
		GOTOS => {
			'Expression' => 159,
			'Operator' => 116,
			'ListElements' => 389,
			'HashReference' => 93,
			'SubExpression' => 163,
			'TypeInner' => 155,
			'ListElement' => 161,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'WordScoped' => 109,
			'Variable' => 164
		}
	},
	{#State 360
		ACTIONS => {
			'OP20_HASH_FATARROW' => 390
		}
	},
	{#State 361
		ACTIONS => {
			";" => 391
		}
	},
	{#State 362
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 392
		}
	},
	{#State 363
		DEFAULT => -63
	},
	{#State 364
		ACTIONS => {
			'VARIABLE_SYMBOL' => 393
		}
	},
	{#State 365
		ACTIONS => {
			'MY' => 394
		}
	},
	{#State 366
		DEFAULT => -52
	},
	{#State 367
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 395
		}
	},
	{#State 368
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 396
		}
	},
	{#State 369
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 176,
			'OP15_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 170,
			"]" => 397,
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP17_LIST_RANGE' => 175,
			'OP16_LOGICAL_OR' => 168,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => 177,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178
		}
	},
	{#State 370
		ACTIONS => {
			";" => 398
		}
	},
	{#State 371
		DEFAULT => -185
	},
	{#State 372
		DEFAULT => -107
	},
	{#State 373
		ACTIONS => {
			'LITERAL_STRING' => 399
		}
	},
	{#State 374
		DEFAULT => -132
	},
	{#State 375
		DEFAULT => -121
	},
	{#State 376
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			'OP04_MATH_POW' => 170,
			'OP21_LIST_COMMA' => -203,
			'OP15_LOGICAL_AND' => 169,
			"}" => -203,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173
		}
	},
	{#State 377
		DEFAULT => -206
	},
	{#State 378
		ACTIONS => {
			'LPAREN' => 400
		}
	},
	{#State 379
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 401
		}
	},
	{#State 380
		ACTIONS => {
			'LPAREN' => 402
		}
	},
	{#State 381
		ACTIONS => {
			'LBRACE' => 383
		},
		GOTOS => {
			'CodeBlock' => 403
		}
	},
	{#State 382
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 404
		}
	},
	{#State 383
		ACTIONS => {
			'WORD_UPPERCASE' => 140,
			"for" => -149,
			'LPAREN' => 139,
			"%{" => 138,
			'OP01_NAMED_VOID' => 136,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'WORD' => 25,
			'WORD_SCOPED' => 23,
			"if" => 130,
			'OP01_CLOSE' => 128,
			'SELF' => 129,
			'LITERAL_STRING' => 90,
			'OP19_LOOP_CONTROL' => 125,
			"foreach" => -149,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'LBRACE' => 121,
			'OP01_NAMED' => 117,
			"undef" => 119,
			'OP19_LOOP_CONTROL_SCOLON' => 120,
			'OP01_PRINT' => 114,
			'OP10_NAMED_UNARY' => 112,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 98,
			'OP01_NAMED_VOID_LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 101,
			"while" => -149,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91
		},
		GOTOS => {
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Variable' => 111,
			'WordScoped' => 109,
			'VariableModification' => 132,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'SubExpression' => 102,
			'Statement' => 103,
			'PLUS-43' => 406,
			'Conditional' => 96,
			'OperatorVoid' => 95,
			'VariableDeclaration' => 127,
			'HashReference' => 93,
			'LoopLabel' => 126,
			'Literal' => 124,
			'OPTIONAL-38' => 123,
			'Operator' => 116,
			'Expression' => 118,
			'PAREN-37' => 137,
			'Operation' => 405
		}
	},
	{#State 384
		DEFAULT => -157,
		GOTOS => {
			'STAR-40' => 407
		}
	},
	{#State 385
		DEFAULT => -178
	},
	{#State 386
		DEFAULT => -177
	},
	{#State 387
		DEFAULT => -176
	},
	{#State 388
		DEFAULT => -82
	},
	{#State 389
		ACTIONS => {
			")" => 408
		}
	},
	{#State 390
		ACTIONS => {
			'MY' => 409
		},
		GOTOS => {
			'TypeInnerProperties' => 410
		}
	},
	{#State 391
		DEFAULT => -68
	},
	{#State 392
		ACTIONS => {
			'OP21_LIST_COMMA' => 413,
			"}" => 411
		},
		GOTOS => {
			'PAREN-26' => 412
		}
	},
	{#State 393
		ACTIONS => {
			"= sub {" => 414
		}
	},
	{#State 394
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 415
		}
	},
	{#State 395
		ACTIONS => {
			"\@_;" => 416
		}
	},
	{#State 396
		DEFAULT => -221
	},
	{#State 397
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 417
		}
	},
	{#State 398
		DEFAULT => -180
	},
	{#State 399
		ACTIONS => {
			'OP21_LIST_COMMA' => 418
		}
	},
	{#State 400
		ACTIONS => {
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'WORD' => 25,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			"%{" => 138
		},
		GOTOS => {
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'SubExpression' => 419
		}
	},
	{#State 401
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 23,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 112,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'Operator' => 116,
			'Expression' => 159,
			'HashReference' => 93,
			'SubExpression' => 420,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'WordScoped' => 109,
			'Variable' => 164
		}
	},
	{#State 402
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_QW' => 157,
			'SELF' => 129,
			'MY' => 148,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"%{" => 138,
			'LBRACE' => 121,
			"undef" => 119,
			'OP01_NAMED' => 160
		},
		GOTOS => {
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'Variable' => 164,
			'WordScoped' => 109,
			'Operator' => 116,
			'Expression' => 159,
			'ListElements' => 421,
			'HashReference' => 93,
			'TypeInner' => 155,
			'SubExpression' => 163,
			'ListElement' => 161
		}
	},
	{#State 403
		DEFAULT => -168
	},
	{#State 404
		ACTIONS => {
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'WORD' => 25,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 23,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'LPAREN' => 139,
			'STDIN' => 289,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			"%{" => 138,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119
		},
		GOTOS => {
			'SubExpressionOrStdin' => 422,
			'SubExpression' => 288,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104
		}
	},
	{#State 405
		DEFAULT => -171
	},
	{#State 406
		ACTIONS => {
			'LITERAL_STRING' => 90,
			'OP19_LOOP_CONTROL' => 125,
			"foreach" => -149,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'LBRACE' => 121,
			"undef" => 119,
			'OP19_LOOP_CONTROL_SCOLON' => 120,
			'OP01_NAMED' => 117,
			'OP01_PRINT' => 114,
			'OP10_NAMED_UNARY' => 112,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP05_LOGICAL_NEG' => 101,
			'OP01_NAMED_VOID_LPAREN' => 100,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 98,
			"}" => 423,
			"while" => -149,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_UPPERCASE' => 140,
			'LPAREN' => 139,
			"for" => -149,
			"%{" => 138,
			'OP01_NAMED_VOID' => 136,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'WORD' => 25,
			"if" => 130,
			'WORD_SCOPED' => 23,
			'SELF' => 129,
			'OP01_CLOSE' => 128
		},
		GOTOS => {
			'Conditional' => 96,
			'SubExpression' => 102,
			'Statement' => 103,
			'LoopLabel' => 126,
			'VariableDeclaration' => 127,
			'HashReference' => 93,
			'OperatorVoid' => 95,
			'VariableModification' => 132,
			'WordScoped' => 109,
			'Variable' => 111,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Operation' => 424,
			'PAREN-37' => 137,
			'Operator' => 116,
			'Expression' => 118,
			'OPTIONAL-38' => 123,
			'Literal' => 124
		}
	},
	{#State 407
		ACTIONS => {
			"for" => -160,
			'LPAREN' => -160,
			'WORD_UPPERCASE' => -160,
			"%{" => -160,
			'OP01_NAMED_VOID' => -160,
			"else" => 429,
			'LBRACKET' => -160,
			'OP22_LOGICAL_NEG' => -160,
			'WORD' => -160,
			'OP01_CLOSE' => -160,
			'SELF' => -160,
			'' => -160,
			"if" => -160,
			'WORD_SCOPED' => -160,
			'OP19_LOOP_CONTROL' => -160,
			"foreach" => -160,
			'LITERAL_STRING' => -160,
			'OP01_NAMED_VOID_SCOLON' => -160,
			'LBRACE' => -160,
			'OP01_PRINT' => -160,
			'OP01_NAMED' => -160,
			"undef" => -160,
			'OP19_LOOP_CONTROL_SCOLON' => -160,
			'OP10_NAMED_UNARY' => -160,
			'OP05_MATH_NEG_LPAREN' => -160,
			'OP03_MATH_INC_DEC' => -160,
			'CONSTANT_CALL_SCOPED' => -160,
			'OP01_OPEN' => -160,
			'VARIABLE_SYMBOL' => -160,
			'MY' => -160,
			"}" => -160,
			'OP05_LOGICAL_NEG' => -160,
			'OP01_NAMED_VOID_LPAREN' => -160,
			"elsif" => 427,
			'LITERAL_NUMBER' => -160,
			"\@{" => -160,
			"while" => -160
		},
		GOTOS => {
			'OPTIONAL-42' => 425,
			'PAREN-39' => 426,
			'PAREN-41' => 428
		}
	},
	{#State 408
		DEFAULT => -84
	},
	{#State 409
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 430
		}
	},
	{#State 410
		DEFAULT => -205
	},
	{#State 411
		ACTIONS => {
			";" => 431
		}
	},
	{#State 412
		DEFAULT => -65
	},
	{#State 413
		ACTIONS => {
			'WORD' => 360
		},
		GOTOS => {
			'HashEntryProperties' => 432
		}
	},
	{#State 414
		ACTIONS => {
			'OP10_NAMED_UNARY' => -70,
			'OP01_OPEN' => -70,
			'CONSTANT_CALL_SCOPED' => -70,
			'OP03_MATH_INC_DEC' => -70,
			'OP05_MATH_NEG_LPAREN' => -70,
			'OP05_LOGICAL_NEG' => -70,
			'OP01_NAMED_VOID_LPAREN' => -70,
			'MY' => -70,
			"}" => -70,
			'VARIABLE_SYMBOL' => -70,
			"\@{" => -70,
			"while" => -70,
			'LITERAL_NUMBER' => -70,
			'LITERAL_STRING' => -70,
			'OP19_LOOP_CONTROL' => -70,
			"foreach" => -70,
			'OP01_NAMED_VOID_SCOLON' => -70,
			'LBRACE' => -70,
			"undef" => -70,
			'LPAREN_MY' => 435,
			'OP19_LOOP_CONTROL_SCOLON' => -70,
			'OP01_NAMED' => -70,
			'OP01_PRINT' => -70,
			'LBRACKET' => -70,
			'OP22_LOGICAL_NEG' => -70,
			'WORD' => -70,
			"if" => -70,
			'WORD_SCOPED' => -70,
			'SELF' => -70,
			'OP01_CLOSE' => -70,
			'WORD_UPPERCASE' => -70,
			'LPAREN' => -70,
			"for" => -70,
			"%{" => -70,
			'OP01_NAMED_VOID' => -70
		},
		GOTOS => {
			'OPTIONAL-28' => 433,
			'MethodArguments' => 434
		}
	},
	{#State 415
		ACTIONS => {
			'VARIABLE_SYMBOL' => 436
		}
	},
	{#State 416
		DEFAULT => -54
	},
	{#State 417
		ACTIONS => {
			"undef" => 437
		}
	},
	{#State 418
		ACTIONS => {
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121,
			"%{" => 138,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112
		},
		GOTOS => {
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124,
			'Variable' => 164,
			'WordScoped' => 109,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159,
			'SubExpression' => 438
		}
	},
	{#State 419
		ACTIONS => {
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 439,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => 166,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 420
		ACTIONS => {
			'OP15_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 170,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP17_LIST_RANGE' => 175,
			";" => 440,
			'OP16_LOGICAL_OR' => 168,
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP11_COMPARE_LT_GT' => 177,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP06_REGEX_MATCH' => 171
		}
	},
	{#State 421
		ACTIONS => {
			")" => 441
		}
	},
	{#State 422
		ACTIONS => {
			")" => 442
		}
	},
	{#State 423
		DEFAULT => -172
	},
	{#State 424
		DEFAULT => -170
	},
	{#State 425
		DEFAULT => -161
	},
	{#State 426
		DEFAULT => -156
	},
	{#State 427
		ACTIONS => {
			'LPAREN' => 443
		}
	},
	{#State 428
		DEFAULT => -159
	},
	{#State 429
		ACTIONS => {
			'LBRACE' => 383
		},
		GOTOS => {
			'CodeBlock' => 444
		}
	},
	{#State 430
		ACTIONS => {
			"\$TYPED_" => 445
		}
	},
	{#State 431
		DEFAULT => -67
	},
	{#State 432
		DEFAULT => -64
	},
	{#State 433
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 446
		}
	},
	{#State 434
		DEFAULT => -69
	},
	{#State 435
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 447
		}
	},
	{#State 436
		DEFAULT => -51
	},
	{#State 437
		ACTIONS => {
			";" => 448
		}
	},
	{#State 438
		ACTIONS => {
			"}" => -85,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP21_LIST_COMMA' => -85,
			'OP04_MATH_POW' => 170,
			")" => -85,
			'OP15_LOGICAL_AND' => 169,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => -85,
			'OP23_LOGICAL_AND' => -85,
			'OP16_LOGICAL_OR' => 168,
			";" => -85,
			'OP17_LIST_RANGE' => 175,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP06_REGEX_MATCH' => 171,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 177
		}
	},
	{#State 439
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 23,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'SubExpression' => 449,
			'Operator' => 116,
			'Expression' => 159,
			'HashReference' => 93,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'WordScoped' => 109,
			'Variable' => 164,
			'ArrayDereference' => 104,
			'Literal' => 124,
			'HashDereference' => 131
		}
	},
	{#State 440
		ACTIONS => {
			'VARIABLE_SYMBOL' => 450
		}
	},
	{#State 441
		ACTIONS => {
			'LBRACE' => 383
		},
		GOTOS => {
			'CodeBlock' => 451
		}
	},
	{#State 442
		ACTIONS => {
			'LBRACE' => 383
		},
		GOTOS => {
			'CodeBlock' => 452
		}
	},
	{#State 443
		ACTIONS => {
			'WORD' => 25,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91,
			'WORD_SCOPED' => 23,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			"%{" => 138,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			'LPAREN' => 139,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121
		},
		GOTOS => {
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'SubExpression' => 453,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159
		}
	},
	{#State 444
		DEFAULT => -158
	},
	{#State 445
		ACTIONS => {
			'WORD' => 454
		}
	},
	{#State 446
		ACTIONS => {
			'OP01_CLOSE' => 128,
			'SELF' => 129,
			'WORD_SCOPED' => 23,
			"if" => 130,
			'WORD' => 25,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP01_NAMED_VOID' => 136,
			"%{" => 138,
			"for" => -149,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 140,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			"while" => -149,
			'VARIABLE_SYMBOL' => 97,
			'MY' => 98,
			"}" => 456,
			'OP01_NAMED_VOID_LPAREN' => 100,
			'OP05_LOGICAL_NEG' => 101,
			'OP05_MATH_NEG_LPAREN' => 105,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'OP10_NAMED_UNARY' => 112,
			'OP01_PRINT' => 114,
			'OP01_NAMED' => 117,
			"undef" => 119,
			'OP19_LOOP_CONTROL_SCOLON' => 120,
			'LBRACE' => 121,
			'OP01_NAMED_VOID_SCOLON' => 122,
			'OP19_LOOP_CONTROL' => 125,
			"foreach" => -149,
			'LITERAL_STRING' => 90
		},
		GOTOS => {
			'Operator' => 116,
			'Expression' => 118,
			'PAREN-37' => 137,
			'Operation' => 455,
			'OPTIONAL-38' => 123,
			'Literal' => 124,
			'SubExpression' => 102,
			'Statement' => 103,
			'Conditional' => 96,
			'OperatorVoid' => 95,
			'LoopLabel' => 126,
			'VariableDeclaration' => 127,
			'HashReference' => 93,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'VariableModification' => 132,
			'WordScoped' => 109,
			'Variable' => 111,
			'ArrayDereference' => 104,
			'HashDereference' => 131
		}
	},
	{#State 447
		ACTIONS => {
			'SELF' => 457
		}
	},
	{#State 448
		DEFAULT => -181
	},
	{#State 449
		ACTIONS => {
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => 177,
			'OP18_TERNARY' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP15_LOGICAL_AND' => 169,
			")" => 458,
			'OP04_MATH_POW' => 170,
			'OP23_LOGICAL_AND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP17_LIST_RANGE' => undef,
			'OP16_LOGICAL_OR' => 168
		}
	},
	{#State 450
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 459
		}
	},
	{#State 451
		DEFAULT => -167
	},
	{#State 452
		DEFAULT => -169
	},
	{#State 453
		ACTIONS => {
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP06_REGEX_MATCH' => 171,
			'OP11_COMPARE_LT_GT' => 177,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP15_LOGICAL_AND' => 169,
			")" => 460,
			'OP04_MATH_POW' => 170,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => 166,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP17_LIST_RANGE' => 175,
			'OP16_LOGICAL_OR' => 168
		}
	},
	{#State 454
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 462,
			'OP19_VARIABLE_ASSIGN' => 461
		}
	},
	{#State 455
		DEFAULT => -71
	},
	{#State 456
		ACTIONS => {
			";" => 463
		}
	},
	{#State 457
		DEFAULT => -76,
		GOTOS => {
			'STAR-31' => 464
		}
	},
	{#State 458
		ACTIONS => {
			'LBRACE' => 383
		},
		GOTOS => {
			'CodeBlock' => 465
		}
	},
	{#State 459
		ACTIONS => {
			'OP01_NAMED' => 160,
			"undef" => 119,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'WORD_SCOPED' => 23,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'OP01_OPEN' => 108,
			'CONSTANT_CALL_SCOPED' => 106,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112
		},
		GOTOS => {
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'HashDereference' => 131,
			'Literal' => 124,
			'ArrayDereference' => 104,
			'SubExpression' => 466,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116
		}
	},
	{#State 460
		ACTIONS => {
			'LBRACE' => 383
		},
		GOTOS => {
			'CodeBlock' => 467
		}
	},
	{#State 461
		ACTIONS => {
			'WORD_UPPERCASE' => 156,
			'LITERAL_STRING' => 90,
			'LPAREN' => 139,
			"%{" => 138,
			'LBRACE' => 121,
			'OP01_NAMED' => 160,
			"undef" => 119,
			'OP22_LOGICAL_NEG' => 133,
			'LBRACKET' => 134,
			'OP10_NAMED_UNARY' => 112,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 105,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'WORD_SCOPED' => 23,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			"\@{" => 94,
			'LITERAL_NUMBER' => 91
		},
		GOTOS => {
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104,
			'SubExpression' => 468,
			'HashReference' => 93,
			'Operator' => 116,
			'Expression' => 159
		}
	},
	{#State 462
		ACTIONS => {
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'SELF' => 129,
			'OP05_LOGICAL_NEG' => 101,
			'VARIABLE_SYMBOL' => 97,
			'OP01_CLOSE' => 128,
			'WORD_SCOPED' => 23,
			'OP01_OPEN' => 108,
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LBRACKET' => 134,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121,
			"%{" => 138,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156
		},
		GOTOS => {
			'SubExpression' => 469,
			'HashReference' => 93,
			'Expression' => 159,
			'Operator' => 116,
			'Variable' => 164,
			'WordScoped' => 109,
			'ArrayReference' => 113,
			'VariableSymbolOrSelf' => 135,
			'Literal' => 124,
			'HashDereference' => 131,
			'ArrayDereference' => 104
		}
	},
	{#State 463
		DEFAULT => -73
	},
	{#State 464
		ACTIONS => {
			")" => 470,
			'OP21_LIST_COMMA' => 472
		},
		GOTOS => {
			'PAREN-30' => 471
		}
	},
	{#State 465
		DEFAULT => -165
	},
	{#State 466
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => 166,
			'OP16_LOGICAL_OR' => 168,
			";" => 473,
			'OP17_LIST_RANGE' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP04_MATH_POW' => 170,
			'OP15_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 171,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 177,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172
		}
	},
	{#State 467
		DEFAULT => -155
	},
	{#State 468
		ACTIONS => {
			'OP04_MATH_POW' => 170,
			'OP21_LIST_COMMA' => -222,
			'OP15_LOGICAL_AND' => 169,
			"}" => -222,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP16_LOGICAL_OR' => 168,
			'OP17_LIST_RANGE' => 175,
			'OP07_STRING_REPEAT' => 167,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP23_LOGICAL_AND' => 166,
			'OP09_BITWISE_SHIFT' => 182,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP11_COMPARE_LT_GT' => 177,
			'OP06_REGEX_MATCH' => 171
		}
	},
	{#State 469
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 177,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP18_TERNARY' => 179,
			'OP06_REGEX_MATCH' => 171,
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP13_BITWISE_AND' => 180,
			'OP08_STRING_CAT' => 181,
			'OP17_LIST_RANGE' => 175,
			'OP16_LOGICAL_OR' => 168,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			"]" => 474,
			'OP23_LOGICAL_AND' => 166,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167,
			'OP15_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 170,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 470
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 475
		}
	},
	{#State 471
		DEFAULT => -75
	},
	{#State 472
		ACTIONS => {
			'MY' => 476
		}
	},
	{#State 473
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 107,
			'CONSTANT_CALL_SCOPED' => 106,
			'OP01_OPEN' => 108,
			'OP05_MATH_NEG_LPAREN' => 105,
			'WORD' => 25,
			'LBRACKET' => 134,
			'OP22_LOGICAL_NEG' => 133,
			'OP10_NAMED_UNARY' => 112,
			'LITERAL_NUMBER' => 91,
			"\@{" => 94,
			'OP05_LOGICAL_NEG' => 101,
			'SELF' => 129,
			'OP01_CLOSE' => 128,
			'VARIABLE_SYMBOL' => 97,
			'WORD_SCOPED' => 23,
			"%{" => 138,
			'LPAREN' => 139,
			'LITERAL_STRING' => 90,
			'WORD_UPPERCASE' => 156,
			"undef" => 119,
			'OP01_NAMED' => 160,
			'LBRACE' => 121
		},
		GOTOS => {
			'ArrayDereference' => 104,
			'HashDereference' => 131,
			'Literal' => 124,
			'SubExpressionOrVarMod' => 477,
			'VariableSymbolOrSelf' => 135,
			'ArrayReference' => 113,
			'VariableModification' => 479,
			'Variable' => 111,
			'WordScoped' => 109,
			'Operator' => 116,
			'Expression' => 159,
			'HashReference' => 93,
			'SubExpression' => 478
		}
	},
	{#State 474
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 480
		}
	},
	{#State 475
		ACTIONS => {
			"\@_;" => 481
		}
	},
	{#State 476
		ACTIONS => {
			'WORD' => 54,
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 482
		}
	},
	{#State 477
		ACTIONS => {
			")" => 483
		}
	},
	{#State 478
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 172,
			'OP09_BITWISE_SHIFT' => 182,
			'OP08_STRING_CAT' => 181,
			'OP13_BITWISE_AND' => 180,
			'OP11_COMPARE_LT_GT' => 177,
			'OP18_TERNARY' => 179,
			'OP24_LOGICAL_OR_XOR' => 178,
			'OP06_REGEX_MATCH' => 171,
			'OP15_LOGICAL_AND' => 169,
			")" => -145,
			'OP04_MATH_POW' => 170,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP17_LIST_RANGE' => 175,
			'OP16_LOGICAL_OR' => 168,
			'OP23_LOGICAL_AND' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 173,
			'OP08_MATH_ADD_SUB' => 174,
			'OP07_STRING_REPEAT' => 167
		}
	},
	{#State 479
		DEFAULT => -146
	},
	{#State 480
		ACTIONS => {
			"undef" => 484
		}
	},
	{#State 481
		DEFAULT => -77
	},
	{#State 482
		ACTIONS => {
			'VARIABLE_SYMBOL' => 485
		}
	},
	{#State 483
		ACTIONS => {
			'LBRACE' => 383
		},
		GOTOS => {
			'CodeBlock' => 486
		}
	},
	{#State 484
		DEFAULT => -223
	},
	{#State 485
		DEFAULT => -74
	},
	{#State 486
		DEFAULT => -166
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6713 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6720 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6727 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6734 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6745 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6756 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6770 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6777 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6784 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6798 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6812 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6819 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6826 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6833 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6840 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6851 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6858 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6865 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6872 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6890 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6912 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6919 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6940 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6954 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6961 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6968 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6979 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6993 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7011 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7018 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7029 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7036 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-17', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7043 lib/RPerl/Grammar.pm
	],
	[#Rule Include_43
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7054 lib/RPerl/Grammar.pm
	],
	[#Rule Include_44
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7065 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_45
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7076 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7097 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7104 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_50
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-20', 4,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7129 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7136 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_54
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7168 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7175 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7182 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7189 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7196 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7203 lib/RPerl/Grammar.pm
	],
	[#Rule Class_63
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7214 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7221 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7228 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7235 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_67
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7246 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_68
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7257 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 1,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-28', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7278 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule Method_73
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 4,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_77
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_78
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_79
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_80
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_81
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7438 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7449 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7460 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7471 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7482 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7504 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7515 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7559 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7581 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7592 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7603 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7614 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7625 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7636 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7658 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7669 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_109
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7680 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_110
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7691 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7698 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7712 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7719 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7726 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7737 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7748 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7759 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7770 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7781 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7792 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_122
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7803 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_123
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7814 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7821 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7828 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7835 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7842 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7875 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_132
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_133
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7941 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7963 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7974 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7985 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_141
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7996 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_142
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8007 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_143
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8018 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_144
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8029 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_145
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8040 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_146
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8051 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8058 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8065 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8072 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8083 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8094 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8105 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8116 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_154
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8127 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 5,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8134 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8141 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-40', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8148 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-41', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8155 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8162 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-42', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8169 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_161
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8180 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8191 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8202 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_164
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8213 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_165
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8224 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_166
		 'LoopFor', 14,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8235 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_167
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8246 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_168
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8257 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_169
		 'LoopWhile', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8268 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8275 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-43', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8282 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_172
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8293 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8300 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8307 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_175
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8318 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8329 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8340 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_178
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8351 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8362 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8373 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8384 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_182
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8395 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8406 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_184
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8417 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-45', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8424 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8431 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-46', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8438 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_188
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8449 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8456 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-47', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8463 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8474 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_192
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8485 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_193
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8496 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8503 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8510 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_196
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8521 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8528 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-49', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8535 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_199
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8546 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_200
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8557 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8564 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-50', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8571 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8582 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_204
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8593 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_205
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8604 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-51', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8611 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8618 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-52', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8625 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_209
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8636 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_210
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8654 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-53', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8661 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_213
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8672 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_214
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8683 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_215
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8694 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_216
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8705 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_217
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8716 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8727 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8738 lib/RPerl/Grammar.pm
	],
	[#Rule Type_220
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8749 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_221
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8760 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_222
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8771 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_223
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8782 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_224
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8793 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_225
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8804 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_226
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8815 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_227
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8826 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_228
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8837 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_229
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8848 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_230
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8859 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_231
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8870 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_232
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8881 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_233
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8892 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_234
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8903 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_235
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8914 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_236
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8925 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_237
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8936 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_238
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8947 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_239
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8958 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_240
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8969 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_241
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8980 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_242
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8991 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_243
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9002 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_244
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9013 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_245
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9024 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_246
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9035 lib/RPerl/Grammar.pm
	],
	[#Rule NonWhitespace_247
		 'NonWhitespace', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 9046 lib/RPerl/Grammar.pm
	]
],
#line 9049 lib/RPerl/Grammar.pm
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
         'LoopWhile_169', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_172', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_175', 
         'VariableRetrieval_176', 
         'VariableRetrieval_177', 
         'VariableRetrieval_178', 
         'VariableDeclaration_179', 
         'VariableDeclaration_180', 
         'VariableDeclaration_181', 
         'VariableDeclaration_182', 
         'VariableModification_183', 
         'VariableModification_184', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_188', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElement_191', 
         'ListElement_192', 
         'ListElement_193', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_196', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_199', 
         'ArrayDereference_200', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_203', 
         'HashEntry_204', 
         'HashEntryProperties_205', 
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
         'TypeInnerProperties_222', 
         'TypeInnerProperties_223', 
         'TypeInnerConstant_224', 
         'VariableOrLiteral_225', 
         'VariableOrLiteral_226', 
         'VariableOrLiteralOrWord_227', 
         'VariableOrLiteralOrWord_228', 
         'VariableOrLiteralOrWord_229', 
         'VariableSymbolOrSelf_230', 
         'VariableSymbolOrSelf_231', 
         'Literal_232', 
         'Literal_233', 
         'NonWhitespace_234', 
         'NonWhitespace_235', 
         'NonWhitespace_236', 
         'NonWhitespace_237', 
         'NonWhitespace_238', 
         'NonWhitespace_239', 
         'NonWhitespace_240', 
         'NonWhitespace_241', 
         'NonWhitespace_242', 
         'NonWhitespace_243', 
         'NonWhitespace_244', 
         'NonWhitespace_245', 
         'NonWhitespace_246', 
         'NonWhitespace_247', );
  $self;
}

#line 224 "lib/RPerl/Grammar.eyp"


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
LoopWhile_169 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ')' CodeBlock
CodeBlock_172 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_175 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_176 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_177 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_178 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_179 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_180 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableDeclaration_181 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_182 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_183 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrStdin
VariableModification_184 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_188 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_191 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_192 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_193 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW PLUS-44 ')'
ArrayReference_196 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_199 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_200 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_203 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_204 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntryProperties_205 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> WORD OP20_HASH_FATARROW TypeInnerProperties
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
TypeInnerProperties_222 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_223 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_224 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_225 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_226 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_227 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_228 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_229 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
VariableSymbolOrSelf_230 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_231 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_232 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_233 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
NonWhitespace_234 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> NON_WHITESPACE
NonWhitespace_235 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> WORD
NonWhitespace_236 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> WORD_SCOPED
NonWhitespace_237 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> WORD_UPPERCASE
NonWhitespace_238 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> TYPE_INTEGER
NonWhitespace_239 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> VARIABLE_SYMBOL
NonWhitespace_240 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> SELF
NonWhitespace_241 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> LITERAL_NUMBER
NonWhitespace_242 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> LITERAL_STRING
NonWhitespace_243 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> USE
NonWhitespace_244 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> MY
NonWhitespace_245 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> FHREF_SYMBOL
NonWhitespace_246 => 'RPerl::NonGenerator',                                                     # NonWhitespace -> TYPE_FHREF
NonWhitespace_247 => 'RPerl::NonGenerator'                                                      # NonWhitespace -> TYPE_METHOD
};

    1;
}

=for None

=cut


#line 9487 lib/RPerl/Grammar.pm



1;
