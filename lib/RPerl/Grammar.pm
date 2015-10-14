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
    our $VERSION = 0.001_980;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\=\ sub\ \{|foreach|\$TYPED_|while|undef|elsif|else|\@_\;|our|for|\%\{|if|\@\{|\;|\]|\}|\))}gc and return ($1, $1);

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
      /\G(\+|-\s|sse_add|sse_sub)/gc and return ('OP08_MATH_ADD_SUB', $1);
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
      /\G(:)/gc and return ('COLON', $1);
      /\G(\(\s*my)/gc and return ('LPAREN_MY', $1);
      /\G(\()/gc and return ('LPAREN', $1);
      /\G(\[)/gc and return ('LBRACKET', $1);
      /\G(\{)/gc and return ('LBRACE', $1);
      /\G([^\s()]*[^\w\s()]+[^\s()]*)/gc and return ('NON_WHITESPACE', $1);
      /\G([a-z]\w*|[A-Z]\w*[a-z]\w*)/gc and return ('WORD', $1);
      /\G([A-Z][A-Z0-9_]*|[A-Z])/gc and return ('WORD_UPPERCASE', $1);


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
			'USE_RPERL' => -20,
			"## no critic qw(" => 3,
			"package" => -20,
			'SHEBANG' => 9
		},
		GOTOS => {
			'PAREN-1' => 4,
			'OPTIONAL-9' => 5,
			'CompileUnit' => 6,
			'Program' => 7,
			'PLUS-2' => 8,
			'Critic' => 1,
			'ModuleHeader' => 2
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"use constant" => -27,
			'USE' => -27,
			"use parent qw(" => 11,
			"## no critic qw(" => -27,
			"our" => -27
		},
		GOTOS => {
			'Package' => 13,
			'Module' => 14,
			'Class' => 12,
			'STAR-11' => 10
		}
	},
	{#State 3
		ACTIONS => {
			'WORD' => 16
		},
		GOTOS => {
			'PLUS-16' => 15
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'USE_RPERL' => 18,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 17
		}
	},
	{#State 6
		ACTIONS => {
			'' => 19
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"package" => -20,
			"## no critic qw(" => 3,
			'USE_RPERL' => -20,
			'' => -5
		},
		GOTOS => {
			'OPTIONAL-9' => 5,
			'PAREN-1' => 20,
			'Critic' => 1,
			'ModuleHeader' => 2
		}
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => 3,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 21,
			'Critic' => 22
		}
	},
	{#State 10
		ACTIONS => {
			"use constant" => -29,
			'USE' => -29,
			"our" => -29,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'STAR-12' => 24,
			'Critic' => 23
		}
	},
	{#State 11
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 12
		DEFAULT => -25
	},
	{#State 13
		DEFAULT => -24
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		ACTIONS => {
			'WORD' => 29,
			")" => 28
		}
	},
	{#State 16
		DEFAULT => -39
	},
	{#State 17
		ACTIONS => {
			"package" => 30
		}
	},
	{#State 18
		DEFAULT => -21
	},
	{#State 19
		DEFAULT => 0
	},
	{#State 20
		DEFAULT => -2
	},
	{#State 21
		ACTIONS => {
			'USE_RPERL' => 31
		}
	},
	{#State 22
		DEFAULT => -6
	},
	{#State 23
		DEFAULT => -26
	},
	{#State 24
		ACTIONS => {
			"use constant" => -31,
			'USE' => 32,
			"our" => -31
		},
		GOTOS => {
			'STAR-13' => 34,
			'Include' => 33
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
		DEFAULT => -40
	},
	{#State 29
		DEFAULT => -38
	},
	{#State 30
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 31
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 38
		}
	},
	{#State 32
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 39
		}
	},
	{#State 33
		DEFAULT => -28
	},
	{#State 34
		ACTIONS => {
			"our" => 42,
			"use constant" => 41
		},
		GOTOS => {
			'Constant' => 44,
			'PLUS-14' => 40,
			'Subroutine' => 43
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
		ACTIONS => {
			"use warnings;" => 47
		}
	},
	{#State 38
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 48
		}
	},
	{#State 39
		ACTIONS => {
			'OP01_QW' => 50,
			";" => 49
		}
	},
	{#State 40
		ACTIONS => {
			'LITERAL_NUMBER' => 52,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 51
		}
	},
	{#State 41
		ACTIONS => {
			'WORD_UPPERCASE' => 53
		}
	},
	{#State 42
		ACTIONS => {
			'WORD' => 56,
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 43
		DEFAULT => -33
	},
	{#State 44
		DEFAULT => -30
	},
	{#State 45
		ACTIONS => {
			'USE' => 32
		},
		GOTOS => {
			'Include' => 58
		}
	},
	{#State 46
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 59
		}
	},
	{#State 47
		ACTIONS => {
			'USE_RPERL_AFTER' => 60,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 61
		}
	},
	{#State 48
		ACTIONS => {
			"foreach" => -11,
			"for" => -11,
			'WORD' => -11,
			'MY' => -11,
			'OP01_NAMED' => -11,
			'LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"\@{" => -11,
			'OP01_OPEN' => -11,
			'VARIABLE_SYMBOL' => -11,
			"our" => -11,
			'LBRACE' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"%{" => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"if" => -11,
			'WORD_SCOPED' => -11,
			"undef" => -11,
			"use constant" => -11,
			'LITERAL_NUMBER' => -11,
			'WORD_UPPERCASE' => -11,
			"while" => -11,
			'LBRACKET' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP10_NAMED_UNARY' => -11,
			"## no critic qw(" => 3,
			'SELF' => -11,
			'USE' => -11,
			'OP01_PRINT' => -11,
			'OP01_CLOSE' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LITERAL_STRING' => -11,
			'OP05_MATH_NEG_LPAREN' => -11
		},
		GOTOS => {
			'Critic' => 63,
			'STAR-5' => 62
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
		DEFAULT => -32
	},
	{#State 52
		ACTIONS => {
			";" => 66
		}
	},
	{#State 53
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 54
		DEFAULT => -220
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 68
		}
	},
	{#State 56
		DEFAULT => -218
	},
	{#State 57
		DEFAULT => -219
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
		DEFAULT => -35
	},
	{#State 61
		ACTIONS => {
			"our" => 70
		}
	},
	{#State 62
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'USE' => 32,
			'OP01_CLOSE' => -13,
			'OP01_PRINT' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP10_NAMED_UNARY' => -13,
			'SELF' => -13,
			"use constant" => -13,
			"undef" => -13,
			'LITERAL_NUMBER' => -13,
			'WORD_UPPERCASE' => -13,
			"while" => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"%{" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			"if" => -13,
			'WORD_SCOPED' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"\@{" => -13,
			'OP01_OPEN' => -13,
			'VARIABLE_SYMBOL' => -13,
			"our" => -13,
			'LBRACE' => -13,
			"foreach" => -13,
			'WORD' => -13,
			"for" => -13,
			'MY' => -13,
			'OP01_NAMED' => -13,
			'LPAREN' => -13
		},
		GOTOS => {
			'STAR-6' => 72,
			'Include' => 71
		}
	},
	{#State 63
		DEFAULT => -8
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
			"use constant" => -58,
			"our hashref \$properties" => -58,
			'USE' => -58,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 78,
			'STAR-23' => 79
		}
	},
	{#State 70
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 80
		}
	},
	{#State 71
		DEFAULT => -10
	},
	{#State 72
		ACTIONS => {
			'VARIABLE_SYMBOL' => -15,
			"our" => -15,
			'LBRACE' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"\@{" => -15,
			'OP01_OPEN' => -15,
			'WORD' => -15,
			"for" => -15,
			'MY' => -15,
			'OP01_NAMED' => -15,
			'LPAREN' => -15,
			"foreach" => -15,
			'LBRACKET' => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			"use constant" => 41,
			'LITERAL_NUMBER' => -15,
			"while" => -15,
			'WORD_SCOPED' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"%{" => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"if" => -15,
			'OP01_PRINT' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'SELF' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LITERAL_STRING' => -15
		},
		GOTOS => {
			'Constant' => 82,
			'STAR-7' => 81
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
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86
		},
		GOTOS => {
			'Literal' => 84
		}
	},
	{#State 76
		ACTIONS => {
			'WORD_SCOPED' => 57,
			'WORD' => 56,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 87
		}
	},
	{#State 77
		ACTIONS => {
			'LITERAL_NUMBER' => -47,
			"undef" => -47,
			'WORD_UPPERCASE' => -47,
			"while" => -47,
			"}" => -47,
			'LBRACKET' => -47,
			'OP01_NAMED_VOID_LPAREN' => -47,
			"%{" => -47,
			'OP03_MATH_INC_DEC' => -47,
			'OP01_NAMED_VOID_SCOLON' => -47,
			"if" => -47,
			'WORD_SCOPED' => -47,
			'OP22_LOGICAL_NEG' => -47,
			"\@{" => -47,
			'OP19_LOOP_CONTROL' => -47,
			'OP01_OPEN' => -47,
			'VARIABLE_SYMBOL' => -47,
			'LBRACE' => -47,
			"foreach" => -47,
			"for" => -47,
			'WORD' => -47,
			'MY' => -47,
			'OP01_NAMED' => -47,
			'LPAREN' => -47,
			'OP19_LOOP_CONTROL_SCOLON' => -47,
			'LITERAL_STRING' => -47,
			'OP05_MATH_NEG_LPAREN' => -47,
			'LPAREN_MY' => 90,
			'OP01_CLOSE' => -47,
			'OP01_PRINT' => -47,
			'OP05_LOGICAL_NEG' => -47,
			'OP01_NAMED_VOID' => -47,
			'CONSTANT_CALL_SCOPED' => -47,
			'OP10_NAMED_UNARY' => -47,
			'SELF' => -47
		},
		GOTOS => {
			'SubroutineArguments' => 88,
			'OPTIONAL-18' => 89
		}
	},
	{#State 78
		DEFAULT => -55
	},
	{#State 79
		ACTIONS => {
			'USE' => 32,
			"our hashref \$properties" => -60,
			"use constant" => -60
		},
		GOTOS => {
			'STAR-24' => 91,
			'Include' => 92
		}
	},
	{#State 80
		DEFAULT => -37
	},
	{#State 81
		ACTIONS => {
			"foreach" => -149,
			'MY' => 134,
			"for" => -149,
			'WORD' => 26,
			'LPAREN' => 131,
			'OP01_NAMED' => 132,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			'OP19_LOOP_CONTROL' => 137,
			"\@{" => 136,
			"our" => 42,
			'VARIABLE_SYMBOL' => 140,
			'LBRACE' => 139,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'OP01_NAMED_VOID_LPAREN' => 122,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			"if" => 116,
			'WORD_SCOPED' => 27,
			"while" => -149,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_UPPERCASE' => 125,
			'LBRACKET' => 128,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'SELF' => 106,
			'OP01_PRINT' => 114,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_NAMED_VOID' => 112,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'LITERAL_STRING' => 86,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'ArrayReference' => 100,
			'OPTIONAL-38' => 127,
			'Expression' => 101,
			'SubExpression' => 129,
			'HashReference' => 98,
			'PLUS-8' => 124,
			'Literal' => 95,
			'OperatorVoid' => 123,
			'ArrayDereference' => 94,
			'HashDereference' => 96,
			'VariableModification' => 97,
			'LoopLabel' => 117,
			'Variable' => 121,
			'VariableDeclaration' => 93,
			'Statement' => 115,
			'PAREN-37' => 108,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'WordScoped' => 105,
			'Conditional' => 133,
			'Operation' => 107,
			'Subroutine' => 130
		}
	},
	{#State 82
		DEFAULT => -12
	},
	{#State 83
		DEFAULT => -44
	},
	{#State 84
		ACTIONS => {
			";" => 141
		}
	},
	{#State 85
		DEFAULT => -232
	},
	{#State 86
		DEFAULT => -233
	},
	{#State 87
		ACTIONS => {
			"\$TYPED_" => 142
		}
	},
	{#State 88
		DEFAULT => -46
	},
	{#State 89
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 143
		}
	},
	{#State 90
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 144
		}
	},
	{#State 91
		ACTIONS => {
			"our hashref \$properties" => 147,
			"use constant" => 41
		},
		GOTOS => {
			'Properties' => 146,
			'Constant' => 145
		}
	},
	{#State 92
		DEFAULT => -57
	},
	{#State 93
		DEFAULT => -153
	},
	{#State 94
		DEFAULT => -139
	},
	{#State 95
		DEFAULT => -136
	},
	{#State 96
		DEFAULT => -141
	},
	{#State 97
		ACTIONS => {
			";" => 148
		}
	},
	{#State 98
		DEFAULT => -140
	},
	{#State 99
		DEFAULT => -122
	},
	{#State 100
		DEFAULT => -138
	},
	{#State 101
		ACTIONS => {
			'OP08_STRING_CAT' => -134,
			'OP15_LOGICAL_AND' => -134,
			";" => 149,
			'OP07_MATH_MULT_DIV_MOD' => -134,
			'OP04_MATH_POW' => -134,
			'OP12_COMPARE_EQ_NE' => -134,
			'OP11_COMPARE_LT_GT' => -134,
			'OP08_MATH_ADD_SUB' => -134,
			'OP18_TERNARY' => -134,
			'OP09_BITWISE_SHIFT' => -134,
			'OP13_BITWISE_AND' => -134,
			'OP14_BITWISE_OR_XOR' => -134,
			'OP23_LOGICAL_AND' => -134,
			'OP17_LIST_RANGE' => -134,
			'OP24_LOGICAL_OR_XOR' => -134,
			'OP07_STRING_REPEAT' => -134,
			'OP06_REGEX_MATCH' => -134,
			'OP16_LOGICAL_OR' => -134
		}
	},
	{#State 102
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150
		},
		GOTOS => {
			'HashDereference' => 96,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Variable' => 153,
			'SubExpression' => 152,
			'Expression' => 154,
			'ArrayReference' => 100,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110
		}
	},
	{#State 103
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -99,
			'OP18_TERNARY' => -99,
			'OP09_BITWISE_SHIFT' => -99,
			'OP07_MATH_MULT_DIV_MOD' => -99,
			'LITERAL_STRING' => 86,
			'OP08_STRING_CAT' => -99,
			'OP12_COMPARE_EQ_NE' => -99,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP04_MATH_POW' => -99,
			'OP10_NAMED_UNARY' => 103,
			'OP17_LIST_RANGE' => -99,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP23_LOGICAL_AND' => -99,
			'SELF' => 106,
			'OP06_REGEX_MATCH' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			")" => -99,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_CLOSE' => 113,
			'OP08_MATH_ADD_SUB' => -99,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'OP13_BITWISE_AND' => -99,
			'WORD_SCOPED' => 27,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			"}" => -99,
			'LBRACKET' => 128,
			"]" => -99,
			'LPAREN' => 131,
			'OP16_LOGICAL_OR' => -99,
			'OP01_NAMED' => 150,
			'OP07_STRING_REPEAT' => -99,
			'WORD' => 26,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 140,
			'OP14_BITWISE_OR_XOR' => -99
		},
		GOTOS => {
			'ArrayReference' => 100,
			'SubExpression' => 155,
			'Expression' => 154,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'HashDereference' => 96,
			'Variable' => 153
		}
	},
	{#State 104
		DEFAULT => -130
	},
	{#State 105
		ACTIONS => {
			'LPAREN' => 157,
			'OP02_METHOD_THINARROW_NEW' => 156
		}
	},
	{#State 106
		DEFAULT => -231
	},
	{#State 107
		DEFAULT => -17
	},
	{#State 108
		DEFAULT => -148
	},
	{#State 109
		DEFAULT => -174,
		GOTOS => {
			'STAR-44' => 158
		}
	},
	{#State 110
		DEFAULT => -128
	},
	{#State 111
		ACTIONS => {
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120
		},
		GOTOS => {
			'SubExpression' => 159,
			'Expression' => 154,
			'ArrayReference' => 100,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'Variable' => 153
		}
	},
	{#State 112
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'MY' => 165,
			'WORD' => 26,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'Expression' => 154,
			'SubExpression' => 164,
			'ArrayReference' => 100,
			'TypeInner' => 161,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashDereference' => 96,
			'ListElement' => 160,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'WordScoped' => 105,
			'Variable' => 153,
			'ListElements' => 163
		}
	},
	{#State 113
		ACTIONS => {
			'FHREF_SYMBOL' => 166
		}
	},
	{#State 114
		ACTIONS => {
			'WORD_SCOPED' => -113,
			"%{" => -113,
			'OP03_MATH_INC_DEC' => -113,
			'OP05_MATH_NEG_LPAREN' => -113,
			'LBRACKET' => -113,
			'LITERAL_NUMBER' => -113,
			'WORD_UPPERCASE' => -113,
			'LITERAL_STRING' => -113,
			"undef" => -113,
			'WORD' => -113,
			'MY' => -113,
			'OP01_NAMED' => -113,
			'LPAREN' => -113,
			'SELF' => -113,
			'FHREF_SYMBOL_BRACES' => 170,
			'CONSTANT_CALL_SCOPED' => -113,
			'OP10_NAMED_UNARY' => -113,
			'VARIABLE_SYMBOL' => -113,
			'OP01_CLOSE' => -113,
			'LBRACE' => -113,
			'OP01_QW' => -113,
			'OP05_LOGICAL_NEG' => -113,
			'OP22_LOGICAL_NEG' => -113,
			"\@{" => -113,
			'OP01_OPEN' => -113,
			'STDOUT_STDERR' => 167
		},
		GOTOS => {
			'OPTIONAL-33' => 169,
			'PAREN-32' => 168
		}
	},
	{#State 115
		DEFAULT => -81
	},
	{#State 116
		ACTIONS => {
			'LPAREN' => 171
		}
	},
	{#State 117
		ACTIONS => {
			'COLON' => 172
		}
	},
	{#State 118
		DEFAULT => -118
	},
	{#State 119
		ACTIONS => {
			'SELF' => 106,
			'LBRACE' => -212,
			'MY' => 165,
			'VARIABLE_SYMBOL' => 140
		},
		GOTOS => {
			'TypeInner' => 174,
			'OPTIONAL-53' => 175,
			'Variable' => 173,
			'VariableSymbolOrSelf' => 109
		}
	},
	{#State 120
		ACTIONS => {
			'VARIABLE_SYMBOL' => 140,
			'SELF' => 106
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'Variable' => 176
		}
	},
	{#State 121
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP16_LOGICAL_OR' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP19_VARIABLE_ASSIGN' => 180,
			")" => -137,
			'OP18_TERNARY' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP13_BITWISE_AND' => -137,
			'OP03_MATH_INC_DEC' => 178,
			'OP19_VARIABLE_ASSIGN_BY' => 179,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP04_MATH_POW' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			'OP08_STRING_CAT' => -137,
			'OP02_METHOD_THINARROW' => 177,
			'OP15_LOGICAL_AND' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137
		}
	},
	{#State 122
		ACTIONS => {
			'MY' => 165,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_QW' => 162,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			")" => -115,
			"\@{" => 136,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LITERAL_STRING' => 86,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			"undef" => 126
		},
		GOTOS => {
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'ListElement' => 160,
			'Literal' => 95,
			'Variable' => 153,
			'ListElements' => 181,
			'OPTIONAL-34' => 182,
			'Expression' => 154,
			'SubExpression' => 164,
			'ArrayReference' => 100,
			'TypeInner' => 161,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110
		}
	},
	{#State 123
		DEFAULT => -152
	},
	{#State 124
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP01_NAMED_VOID_SCOLON' => 118,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'OP01_NAMED_VOID_LPAREN' => 122,
			'' => -18,
			"if" => 116,
			'LBRACKET' => 128,
			"while" => -149,
			"undef" => 126,
			'WORD_UPPERCASE' => 125,
			'LITERAL_NUMBER' => 85,
			'MY' => 134,
			"for" => -149,
			'WORD' => 26,
			'LPAREN' => 131,
			'OP01_NAMED' => 132,
			"foreach" => -149,
			'VARIABLE_SYMBOL' => 140,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			'OP19_LOOP_CONTROL' => 137,
			"\@{" => 136,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'LITERAL_STRING' => 86,
			'SELF' => 106,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP01_CLOSE' => 113,
			'OP01_PRINT' => 114,
			'OP01_NAMED_VOID' => 112,
			'OP05_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'Operation' => 183,
			'Conditional' => 133,
			'WordScoped' => 105,
			'Statement' => 115,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'PAREN-37' => 108,
			'VariableModification' => 97,
			'HashDereference' => 96,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'OperatorVoid' => 123,
			'Variable' => 121,
			'VariableDeclaration' => 93,
			'LoopLabel' => 117,
			'Expression' => 101,
			'SubExpression' => 129,
			'ArrayReference' => 100,
			'OPTIONAL-38' => 127,
			'HashReference' => 98
		}
	},
	{#State 125
		ACTIONS => {
			'COLON' => -217,
			'LPAREN' => 184
		}
	},
	{#State 126
		DEFAULT => -135
	},
	{#State 127
		ACTIONS => {
			"while" => 187,
			"foreach" => 189,
			"for" => 188
		},
		GOTOS => {
			'LoopFor' => 185,
			'Loop' => 191,
			'LoopWhile' => 190,
			'LoopForEach' => 186
		}
	},
	{#State 128
		ACTIONS => {
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD' => 26,
			'MY' => 165,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 139,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			"]" => -195,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'TypeInner' => 161,
			'OPTIONAL-48' => 192,
			'ArrayReference' => 100,
			'Expression' => 154,
			'SubExpression' => 164,
			'ListElements' => 193,
			'Variable' => 153,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'ListElement' => 160,
			'HashDereference' => 96
		}
	},
	{#State 129
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207,
			'OP08_STRING_CAT' => 198,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 206,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195
		}
	},
	{#State 130
		DEFAULT => -14
	},
	{#State 131
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 213,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP01_PRINT' => 211,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128
		},
		GOTOS => {
			'Variable' => 153,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'HashDereference' => 96,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'ArrayReference' => 100,
			'SubExpression' => 212,
			'Expression' => 154
		}
	},
	{#State 132
		ACTIONS => {
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD' => 26,
			'MY' => 165,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_QW' => 162,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'Variable' => 153,
			'ListElement' => 214,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'HashDereference' => 96,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98,
			'TypeInner' => 161,
			'ArrayReference' => 100,
			'Expression' => 154,
			'SubExpression' => 215
		}
	},
	{#State 133
		DEFAULT => -150
	},
	{#State 134
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 56,
			'WORD_SCOPED' => 57,
			'TYPE_FHREF' => 217
		},
		GOTOS => {
			'Type' => 216
		}
	},
	{#State 135
		ACTIONS => {
			'MY' => 218
		}
	},
	{#State 136
		ACTIONS => {
			'MY' => 165,
			'VARIABLE_SYMBOL' => 140,
			'LBRACKET' => -198,
			'SELF' => 106
		},
		GOTOS => {
			'TypeInner' => 219,
			'OPTIONAL-49' => 221,
			'Variable' => 220,
			'VariableSymbolOrSelf' => 109
		}
	},
	{#State 137
		ACTIONS => {
			'WORD_UPPERCASE' => 223
		},
		GOTOS => {
			'LoopLabel' => 222
		}
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119
		},
		GOTOS => {
			'Variable' => 153,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'HashDereference' => 96,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'ArrayReference' => 100,
			'SubExpression' => 224,
			'Expression' => 154
		}
	},
	{#State 139
		ACTIONS => {
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"%{" => 119,
			'SELF' => 106,
			"}" => 225,
			'VARIABLE_SYMBOL' => 140,
			'WORD' => 228
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 231,
			'Literal' => 229,
			'HashEntry' => 227,
			'HashDereference' => 230,
			'VariableSymbolOrSelf' => 109,
			'Variable' => 226
		}
	},
	{#State 140
		DEFAULT => -230
	},
	{#State 141
		DEFAULT => -45
	},
	{#State 142
		ACTIONS => {
			'WORD_UPPERCASE' => 232
		}
	},
	{#State 143
		ACTIONS => {
			"if" => 116,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'OP01_NAMED_VOID_LPAREN' => 122,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 125,
			"undef" => 126,
			"while" => -149,
			'LBRACKET' => 128,
			"}" => 234,
			"foreach" => -149,
			'OP01_NAMED' => 132,
			'LPAREN' => 131,
			'WORD' => 26,
			"for" => -149,
			'MY' => 134,
			'OP19_LOOP_CONTROL' => 137,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 140,
			'LITERAL_STRING' => 86,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'OP05_MATH_NEG_LPAREN' => 102,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'SELF' => 106,
			'OP01_NAMED_VOID' => 112,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_PRINT' => 114,
			'OP01_CLOSE' => 113
		},
		GOTOS => {
			'Statement' => 115,
			'PAREN-37' => 108,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'WordScoped' => 105,
			'Conditional' => 133,
			'Operation' => 233,
			'OPTIONAL-38' => 127,
			'ArrayReference' => 100,
			'Expression' => 101,
			'SubExpression' => 129,
			'HashReference' => 98,
			'Literal' => 95,
			'OperatorVoid' => 123,
			'ArrayDereference' => 94,
			'HashDereference' => 96,
			'VariableModification' => 97,
			'LoopLabel' => 117,
			'VariableDeclaration' => 93,
			'Variable' => 121
		}
	},
	{#State 144
		ACTIONS => {
			'VARIABLE_SYMBOL' => 235
		}
	},
	{#State 145
		DEFAULT => -59
	},
	{#State 146
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 236
		}
	},
	{#State 147
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 237
		}
	},
	{#State 148
		DEFAULT => -154
	},
	{#State 149
		DEFAULT => -80
	},
	{#State 150
		ACTIONS => {
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120
		},
		GOTOS => {
			'Variable' => 153,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'HashDereference' => 96,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'SubExpression' => 238,
			'Expression' => 154
		}
	},
	{#State 151
		ACTIONS => {
			'LPAREN' => 184
		}
	},
	{#State 152
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			")" => 239,
			'OP16_LOGICAL_OR' => 208,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP08_STRING_CAT' => 198,
			'OP13_BITWISE_AND' => 206,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194
		}
	},
	{#State 153
		ACTIONS => {
			'OP08_STRING_CAT' => -137,
			'OP15_LOGICAL_AND' => -137,
			'OP07_MATH_MULT_DIV_MOD' => -137,
			";" => -137,
			'OP02_METHOD_THINARROW' => 177,
			"]" => -137,
			'OP04_MATH_POW' => -137,
			'OP12_COMPARE_EQ_NE' => -137,
			"}" => -137,
			'OP03_MATH_INC_DEC' => 178,
			'OP11_COMPARE_LT_GT' => -137,
			'OP08_MATH_ADD_SUB' => -137,
			'OP18_TERNARY' => -137,
			'OP09_BITWISE_SHIFT' => -137,
			'OP13_BITWISE_AND' => -137,
			")" => -137,
			'OP14_BITWISE_OR_XOR' => -137,
			'OP23_LOGICAL_AND' => -137,
			'OP17_LIST_RANGE' => -137,
			'OP07_STRING_REPEAT' => -137,
			'OP06_REGEX_MATCH' => -137,
			'OP21_LIST_COMMA' => -137,
			'OP24_LOGICAL_OR_XOR' => -137,
			'OP16_LOGICAL_OR' => -137
		}
	},
	{#State 154
		DEFAULT => -134
	},
	{#State 155
		ACTIONS => {
			'OP16_LOGICAL_OR' => -98,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP21_LIST_COMMA' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP17_LIST_RANGE' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			")" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP18_TERNARY' => -98,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			"}" => -98,
			'OP04_MATH_POW' => 200,
			"]" => -98,
			'OP15_LOGICAL_AND' => -98,
			";" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP08_STRING_CAT' => 198
		}
	},
	{#State 156
		ACTIONS => {
			")" => 240
		}
	},
	{#State 157
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'LBRACE' => 139,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			"\@{" => 136,
			")" => -125,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD' => 26,
			'MY' => 165,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'OPTIONAL-35' => 241,
			'HashDereference' => 96,
			'ListElement' => 160,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'Variable' => 153,
			'ListElements' => 242,
			'TypeInner' => 161,
			'Expression' => 154,
			'SubExpression' => 164,
			'ArrayReference' => 100,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98
		}
	},
	{#State 158
		ACTIONS => {
			'OP16_LOGICAL_OR' => -175,
			'OP24_LOGICAL_OR_XOR' => -175,
			'OP21_LIST_COMMA' => -175,
			'OP07_STRING_REPEAT' => -175,
			'OP06_REGEX_MATCH' => -175,
			'OP17_LIST_RANGE' => -175,
			'OP23_LOGICAL_AND' => -175,
			'OP20_HASH_FATARROW' => -175,
			'OP14_BITWISE_OR_XOR' => -175,
			")" => -175,
			'OP19_VARIABLE_ASSIGN' => -175,
			'OP13_BITWISE_AND' => -175,
			'OP18_TERNARY' => -175,
			'OP09_BITWISE_SHIFT' => -175,
			'OP08_MATH_ADD_SUB' => -175,
			'OP02_ARRAY_THINARROW' => 243,
			'OP19_VARIABLE_ASSIGN_BY' => -175,
			'OP11_COMPARE_LT_GT' => -175,
			'OP03_MATH_INC_DEC' => -175,
			'OP12_COMPARE_EQ_NE' => -175,
			"}" => -175,
			'OP02_HASH_THINARROW' => 245,
			'OP04_MATH_POW' => -175,
			"]" => -175,
			'OP02_METHOD_THINARROW' => -175,
			'OP15_LOGICAL_AND' => -175,
			";" => -175,
			'OP07_MATH_MULT_DIV_MOD' => -175,
			'COLON' => -175,
			'OP08_STRING_CAT' => -175
		},
		GOTOS => {
			'VariableRetrieval' => 244
		}
	},
	{#State 159
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -90,
			")" => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP21_LIST_COMMA' => -90,
			'OP06_REGEX_MATCH' => -90,
			'OP07_STRING_REPEAT' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP17_LIST_RANGE' => -90,
			"]" => -90,
			'OP04_MATH_POW' => 200,
			"}" => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP08_STRING_CAT' => -90,
			";" => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP18_TERNARY' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP08_MATH_ADD_SUB' => -90
		}
	},
	{#State 160
		DEFAULT => -187,
		GOTOS => {
			'STAR-46' => 246
		}
	},
	{#State 161
		ACTIONS => {
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD' => 26,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138
		},
		GOTOS => {
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'Expression' => 154,
			'SubExpression' => 247,
			'Variable' => 153,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'HashDereference' => 96
		}
	},
	{#State 162
		ACTIONS => {
			'VARIABLE_SYMBOL' => 258,
			'TYPE_INTEGER' => 251,
			'NON_WHITESPACE' => 253,
			'WORD_UPPERCASE' => 262,
			'LITERAL_NUMBER' => 263,
			'LITERAL_STRING' => 252,
			'USE' => 250,
			'TYPE_METHOD' => 261,
			'WORD' => 255,
			'MY' => 254,
			'WORD_SCOPED' => 259,
			'SELF' => 248,
			'FHREF_SYMBOL' => 249,
			'TYPE_FHREF' => 257
		},
		GOTOS => {
			'NonWhitespace' => 256,
			'PLUS-47' => 260
		}
	},
	{#State 163
		ACTIONS => {
			";" => 264
		}
	},
	{#State 164
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -191,
			'OP21_LIST_COMMA' => -191,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			"]" => -191,
			'OP04_MATH_POW' => 200,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP08_STRING_CAT' => 198,
			";" => -191,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205
		}
	},
	{#State 165
		ACTIONS => {
			'WORD_SCOPED' => 57,
			'WORD' => 56,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 265
		}
	},
	{#State 166
		DEFAULT => -86
	},
	{#State 167
		DEFAULT => -111
	},
	{#State 168
		DEFAULT => -112
	},
	{#State 169
		ACTIONS => {
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD' => 26,
			'MY' => 165
		},
		GOTOS => {
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'ListElement' => 160,
			'HashDereference' => 96,
			'ListElements' => 266,
			'Variable' => 153,
			'ArrayReference' => 100,
			'SubExpression' => 164,
			'Expression' => 154,
			'TypeInner' => 161,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110
		}
	},
	{#State 170
		ACTIONS => {
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD' => 26,
			'MY' => 165,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131
		},
		GOTOS => {
			'Variable' => 153,
			'ListElements' => 267,
			'HashDereference' => 96,
			'ListElement' => 160,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'TypeInner' => 161,
			'Expression' => 154,
			'SubExpression' => 164,
			'ArrayReference' => 100
		}
	},
	{#State 171
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128
		},
		GOTOS => {
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'SubExpression' => 268,
			'Expression' => 154,
			'ArrayReference' => 100,
			'Variable' => 153,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95
		}
	},
	{#State 172
		DEFAULT => -147
	},
	{#State 173
		ACTIONS => {
			"}" => 269
		}
	},
	{#State 174
		DEFAULT => -211
	},
	{#State 175
		ACTIONS => {
			'LBRACE' => 139
		},
		GOTOS => {
			'HashReference' => 270
		}
	},
	{#State 176
		DEFAULT => -87
	},
	{#State 177
		ACTIONS => {
			'LPAREN' => 271
		}
	},
	{#State 178
		DEFAULT => -88
	},
	{#State 179
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'HashDereference' => 96,
			'Variable' => 153,
			'ArrayReference' => 100,
			'SubExpression' => 272,
			'Expression' => 154,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98
		}
	},
	{#State 180
		ACTIONS => {
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'STDIN' => 274,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'SubExpression' => 273,
			'Expression' => 154,
			'Variable' => 153,
			'SubExpressionOrStdin' => 275,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'HashDereference' => 96
		}
	},
	{#State 181
		DEFAULT => -114
	},
	{#State 182
		ACTIONS => {
			")" => 276
		}
	},
	{#State 183
		DEFAULT => -16
	},
	{#State 184
		ACTIONS => {
			")" => 277
		}
	},
	{#State 185
		DEFAULT => -162
	},
	{#State 186
		DEFAULT => -163
	},
	{#State 187
		ACTIONS => {
			'LPAREN_MY' => 279,
			'LPAREN' => 278
		}
	},
	{#State 188
		ACTIONS => {
			'MY' => 280,
			'LPAREN_MY' => 281
		}
	},
	{#State 189
		ACTIONS => {
			'MY' => 282
		}
	},
	{#State 190
		DEFAULT => -164
	},
	{#State 191
		DEFAULT => -151
	},
	{#State 192
		ACTIONS => {
			"]" => 283
		}
	},
	{#State 193
		DEFAULT => -194
	},
	{#State 194
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'WORD' => 26
		},
		GOTOS => {
			'HashDereference' => 96,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'Variable' => 153,
			'SubExpression' => 284,
			'Expression' => 154,
			'ArrayReference' => 100,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98
		}
	},
	{#State 195
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119
		},
		GOTOS => {
			'Variable' => 153,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'HashDereference' => 96,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'SubExpression' => 285,
			'Expression' => 154
		}
	},
	{#State 196
		ACTIONS => {
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			'VARIABLE_SYMBOL' => 140,
			'SELF' => 106
		},
		GOTOS => {
			'Literal' => 286,
			'Variable' => 288,
			'VariableOrLiteral' => 287,
			'VariableSymbolOrSelf' => 109
		}
	},
	{#State 197
		ACTIONS => {
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD' => 26,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Expression' => 154,
			'SubExpression' => 289,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'HashDereference' => 96,
			'Variable' => 153
		}
	},
	{#State 198
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'WORD' => 26,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136
		},
		GOTOS => {
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'Expression' => 154,
			'SubExpression' => 290,
			'ArrayReference' => 100,
			'Variable' => 153,
			'HashDereference' => 96,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94
		}
	},
	{#State 199
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'Expression' => 154,
			'SubExpression' => 291,
			'ArrayReference' => 100,
			'Variable' => 153,
			'HashDereference' => 96,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94
		}
	},
	{#State 200
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139
		},
		GOTOS => {
			'ArrayReference' => 100,
			'Expression' => 154,
			'SubExpression' => 292,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'HashDereference' => 96,
			'Variable' => 153
		}
	},
	{#State 201
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'ArrayReference' => 100,
			'SubExpression' => 293,
			'Expression' => 154,
			'Variable' => 153,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'HashDereference' => 96
		}
	},
	{#State 202
		ACTIONS => {
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131
		},
		GOTOS => {
			'SubExpression' => 294,
			'Expression' => 154,
			'ArrayReference' => 100,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashDereference' => 96,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'Variable' => 153
		}
	},
	{#State 203
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 295
		}
	},
	{#State 204
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135
		},
		GOTOS => {
			'Variable' => 153,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 296,
			'Expression' => 154,
			'ArrayReference' => 100
		}
	},
	{#State 205
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'Expression' => 154,
			'SubExpression' => 297,
			'ArrayReference' => 100,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'WordScoped' => 105,
			'Variable' => 153
		}
	},
	{#State 206
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'SubExpression' => 298,
			'Expression' => 154,
			'ArrayReference' => 100,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'Variable' => 153
		}
	},
	{#State 207
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD' => 26,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140
		},
		GOTOS => {
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'ArrayReference' => 100,
			'SubExpression' => 299,
			'Expression' => 154,
			'Variable' => 153,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'HashDereference' => 96
		}
	},
	{#State 208
		ACTIONS => {
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP22_LOGICAL_NEG' => 138,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104
		},
		GOTOS => {
			'HashDereference' => 96,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'Variable' => 153,
			'SubExpression' => 300,
			'Expression' => 154,
			'ArrayReference' => 100,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98
		}
	},
	{#State 209
		ACTIONS => {
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP22_LOGICAL_NEG' => 138,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113
		},
		GOTOS => {
			'Variable' => 153,
			'HashDereference' => 96,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 301,
			'Expression' => 154,
			'ArrayReference' => 100
		}
	},
	{#State 210
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD' => 26,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138
		},
		GOTOS => {
			'Variable' => 153,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'HashDereference' => 96,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'ArrayReference' => 100,
			'Expression' => 154,
			'SubExpression' => 302
		}
	},
	{#State 211
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 303
		}
	},
	{#State 212
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			")" => 304,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 200,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP08_STRING_CAT' => 198,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205
		}
	},
	{#State 213
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD' => 26,
			'MY' => 165,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140
		},
		GOTOS => {
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 215,
			'Expression' => 154,
			'ArrayReference' => 100,
			'TypeInner' => 161,
			'Variable' => 153,
			'HashDereference' => 96,
			'WordScoped' => 105,
			'ListElement' => 305,
			'ArrayDereference' => 94,
			'Literal' => 95
		}
	},
	{#State 214
		ACTIONS => {
			'OP21_LIST_COMMA' => 306
		}
	},
	{#State 215
		ACTIONS => {
			'OP23_LOGICAL_AND' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP21_LIST_COMMA' => -191,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP16_LOGICAL_OR' => -83,
			")" => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP18_TERNARY' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP13_BITWISE_AND' => -83,
			'OP08_STRING_CAT' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			";" => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP04_MATH_POW' => -83,
			'OP12_COMPARE_EQ_NE' => -83
		}
	},
	{#State 216
		ACTIONS => {
			'VARIABLE_SYMBOL' => 307
		}
	},
	{#State 217
		ACTIONS => {
			'FHREF_SYMBOL' => 308
		}
	},
	{#State 218
		ACTIONS => {
			'TYPE_FHREF' => 309
		}
	},
	{#State 219
		DEFAULT => -197
	},
	{#State 220
		ACTIONS => {
			"}" => 310
		}
	},
	{#State 221
		ACTIONS => {
			'LBRACKET' => 128
		},
		GOTOS => {
			'ArrayReference' => 311
		}
	},
	{#State 222
		ACTIONS => {
			";" => 312
		}
	},
	{#State 223
		DEFAULT => -217
	},
	{#State 224
		ACTIONS => {
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP21_LIST_COMMA' => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => -108,
			'OP17_LIST_RANGE' => 201,
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -108,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP04_MATH_POW' => 200,
			"]" => -108,
			'OP12_COMPARE_EQ_NE' => 199,
			"}" => -108,
			'OP08_STRING_CAT' => 198,
			";" => -108,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197
		}
	},
	{#State 225
		DEFAULT => -210
	},
	{#State 226
		DEFAULT => -227
	},
	{#State 227
		DEFAULT => -208,
		GOTOS => {
			'STAR-52' => 313
		}
	},
	{#State 228
		DEFAULT => -229
	},
	{#State 229
		DEFAULT => -228
	},
	{#State 230
		DEFAULT => -204
	},
	{#State 231
		ACTIONS => {
			'OP20_HASH_FATARROW' => 314
		}
	},
	{#State 232
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 315
		}
	},
	{#State 233
		DEFAULT => -48
	},
	{#State 234
		ACTIONS => {
			";" => 316
		}
	},
	{#State 235
		DEFAULT => -53,
		GOTOS => {
			'STAR-21' => 317
		}
	},
	{#State 236
		ACTIONS => {
			'LITERAL_NUMBER' => 322,
			"our" => 318
		},
		GOTOS => {
			'Method' => 320,
			'Subroutine' => 319,
			'MethodOrSubroutine' => 321
		}
	},
	{#State 237
		ACTIONS => {
			'LBRACE' => 323
		}
	},
	{#State 238
		ACTIONS => {
			'OP08_STRING_CAT' => -83,
			";" => -83,
			'OP15_LOGICAL_AND' => -83,
			'OP07_MATH_MULT_DIV_MOD' => -83,
			'OP04_MATH_POW' => -83,
			"]" => -83,
			'OP12_COMPARE_EQ_NE' => -83,
			"}" => -83,
			'OP11_COMPARE_LT_GT' => -83,
			'OP08_MATH_ADD_SUB' => -83,
			'OP18_TERNARY' => -83,
			'OP09_BITWISE_SHIFT' => -83,
			'OP13_BITWISE_AND' => -83,
			")" => -83,
			'OP14_BITWISE_OR_XOR' => -83,
			'OP23_LOGICAL_AND' => -83,
			'OP17_LIST_RANGE' => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP21_LIST_COMMA' => -83,
			'OP06_REGEX_MATCH' => -83,
			'OP07_STRING_REPEAT' => -83,
			'OP16_LOGICAL_OR' => -83
		}
	},
	{#State 239
		DEFAULT => -91
	},
	{#State 240
		DEFAULT => -133
	},
	{#State 241
		ACTIONS => {
			")" => 324
		}
	},
	{#State 242
		DEFAULT => -124
	},
	{#State 243
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'SubExpression' => 325,
			'Expression' => 154,
			'ArrayReference' => 100,
			'Variable' => 153,
			'HashDereference' => 96,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Literal' => 95
		}
	},
	{#State 244
		DEFAULT => -173
	},
	{#State 245
		ACTIONS => {
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'WORD' => 327,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98,
			'Expression' => 154,
			'SubExpression' => 326,
			'ArrayReference' => 100,
			'Variable' => 153,
			'HashDereference' => 96,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94
		}
	},
	{#State 246
		ACTIONS => {
			";" => -188,
			")" => -188,
			"]" => -188,
			'OP21_LIST_COMMA' => 328
		},
		GOTOS => {
			'PAREN-45' => 329
		}
	},
	{#State 247
		ACTIONS => {
			")" => -192,
			'OP14_BITWISE_OR_XOR' => 210,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP16_LOGICAL_OR' => 208,
			'OP21_LIST_COMMA' => -192,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			";" => -192,
			'OP15_LOGICAL_AND' => 207,
			'OP08_STRING_CAT' => 198,
			'OP12_COMPARE_EQ_NE' => 199,
			"]" => -192,
			'OP04_MATH_POW' => 200,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 206,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195
		}
	},
	{#State 248
		DEFAULT => -240
	},
	{#State 249
		DEFAULT => -245
	},
	{#State 250
		DEFAULT => -243
	},
	{#State 251
		DEFAULT => -238
	},
	{#State 252
		DEFAULT => -242
	},
	{#State 253
		DEFAULT => -234
	},
	{#State 254
		DEFAULT => -244
	},
	{#State 255
		DEFAULT => -235
	},
	{#State 256
		DEFAULT => -190
	},
	{#State 257
		DEFAULT => -246
	},
	{#State 258
		DEFAULT => -239
	},
	{#State 259
		DEFAULT => -236
	},
	{#State 260
		ACTIONS => {
			'TYPE_FHREF' => 257,
			'FHREF_SYMBOL' => 249,
			'SELF' => 248,
			'WORD_SCOPED' => 259,
			'MY' => 254,
			'WORD' => 255,
			'TYPE_METHOD' => 261,
			'USE' => 250,
			")" => 330,
			'WORD_UPPERCASE' => 262,
			'LITERAL_NUMBER' => 263,
			'LITERAL_STRING' => 252,
			'NON_WHITESPACE' => 253,
			'TYPE_INTEGER' => 251,
			'VARIABLE_SYMBOL' => 258
		},
		GOTOS => {
			'NonWhitespace' => 331
		}
	},
	{#State 261
		DEFAULT => -247
	},
	{#State 262
		DEFAULT => -237
	},
	{#State 263
		DEFAULT => -241
	},
	{#State 264
		DEFAULT => -120
	},
	{#State 265
		ACTIONS => {
			"\$TYPED_" => 332
		}
	},
	{#State 266
		ACTIONS => {
			";" => 333
		}
	},
	{#State 267
		ACTIONS => {
			";" => 334
		}
	},
	{#State 268
		ACTIONS => {
			'OP13_BITWISE_AND' => 206,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP08_STRING_CAT' => 198,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP14_BITWISE_OR_XOR' => 210,
			")" => 335
		}
	},
	{#State 269
		DEFAULT => -213
	},
	{#State 270
		ACTIONS => {
			"}" => 336
		}
	},
	{#State 271
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'MY' => 165,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			")" => -127,
			'OP22_LOGICAL_NEG' => 138
		},
		GOTOS => {
			'SubExpression' => 164,
			'Expression' => 154,
			'ArrayReference' => 100,
			'TypeInner' => 161,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'ListElement' => 160,
			'OPTIONAL-36' => 337,
			'Variable' => 153,
			'ListElements' => 338
		}
	},
	{#State 272
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP13_BITWISE_AND' => 206,
			'OP08_STRING_CAT' => 198,
			";" => -184,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP04_MATH_POW' => 200,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP16_LOGICAL_OR' => 208,
			")" => -184,
			'OP14_BITWISE_OR_XOR' => 210
		}
	},
	{#State 273
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -143,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 200,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP08_STRING_CAT' => 198,
			";" => -143,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205
		}
	},
	{#State 274
		DEFAULT => -144
	},
	{#State 275
		DEFAULT => -183
	},
	{#State 276
		ACTIONS => {
			";" => 339
		}
	},
	{#State 277
		DEFAULT => -129
	},
	{#State 278
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150
		},
		GOTOS => {
			'ArrayReference' => 100,
			'SubExpression' => 340,
			'Expression' => 154,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'HashDereference' => 96,
			'Variable' => 153
		}
	},
	{#State 279
		ACTIONS => {
			'WORD' => 56,
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 341
		}
	},
	{#State 280
		ACTIONS => {
			'TYPE_INTEGER' => 342
		}
	},
	{#State 281
		ACTIONS => {
			'TYPE_INTEGER' => 343
		}
	},
	{#State 282
		ACTIONS => {
			'WORD' => 56,
			'WORD_SCOPED' => 57,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 344
		}
	},
	{#State 283
		DEFAULT => -196
	},
	{#State 284
		ACTIONS => {
			'OP04_MATH_POW' => 200,
			"]" => -100,
			"}" => -100,
			'OP12_COMPARE_EQ_NE' => -100,
			'OP08_STRING_CAT' => 198,
			";" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_MATH_ADD_SUB' => 205,
			'OP14_BITWISE_OR_XOR' => -100,
			")" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100
		}
	},
	{#State 285
		ACTIONS => {
			'OP15_LOGICAL_AND' => -97,
			";" => -97,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP08_STRING_CAT' => 198,
			"}" => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP04_MATH_POW' => 200,
			"]" => -97,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => -97,
			'OP13_BITWISE_AND' => -97,
			'OP18_TERNARY' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			")" => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209
		}
	},
	{#State 286
		DEFAULT => -226
	},
	{#State 287
		ACTIONS => {
			'COLON' => 345
		}
	},
	{#State 288
		DEFAULT => -225
	},
	{#State 289
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -94,
			")" => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP04_MATH_POW' => 200,
			"]" => -94,
			"}" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP08_STRING_CAT' => -94,
			";" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP07_MATH_MULT_DIV_MOD' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP18_TERNARY' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP08_MATH_ADD_SUB' => -94
		}
	},
	{#State 290
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 197,
			";" => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP08_STRING_CAT' => -96,
			"}" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP04_MATH_POW' => 200,
			"]" => -96,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP18_TERNARY' => -96,
			'OP09_BITWISE_SHIFT' => -96,
			")" => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP17_LIST_RANGE' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203
		}
	},
	{#State 291
		ACTIONS => {
			"}" => -101,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP04_MATH_POW' => 200,
			"]" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			";" => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP08_STRING_CAT' => 198,
			'OP13_BITWISE_AND' => -101,
			'OP18_TERNARY' => -101,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP14_BITWISE_OR_XOR' => -101,
			")" => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP21_LIST_COMMA' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP17_LIST_RANGE' => -101,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 292
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -89,
			")" => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP21_LIST_COMMA' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP06_REGEX_MATCH' => -89,
			'OP17_LIST_RANGE' => -89,
			'OP23_LOGICAL_AND' => -89,
			"}" => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP04_MATH_POW' => 200,
			"]" => -89,
			'OP15_LOGICAL_AND' => -89,
			";" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP08_STRING_CAT' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP18_TERNARY' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP11_COMPARE_LT_GT' => -89
		}
	},
	{#State 293
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => -106,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP04_MATH_POW' => 200,
			"]" => -106,
			'OP12_COMPARE_EQ_NE' => 199,
			"}" => -106,
			'OP08_STRING_CAT' => 198,
			";" => -106,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP21_LIST_COMMA' => -106,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => -106,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -106
		}
	},
	{#State 294
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -109,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => -109,
			'OP21_LIST_COMMA' => -109,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => -109,
			"}" => -109,
			'OP12_COMPARE_EQ_NE' => 199,
			"]" => -109,
			'OP04_MATH_POW' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			";" => -109,
			'OP15_LOGICAL_AND' => 207,
			'OP08_STRING_CAT' => 198,
			'OP13_BITWISE_AND' => 206,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194
		}
	},
	{#State 295
		DEFAULT => -92
	},
	{#State 296
		ACTIONS => {
			"}" => -110,
			'OP12_COMPARE_EQ_NE' => 199,
			"]" => -110,
			'OP04_MATH_POW' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			";" => -110,
			'OP15_LOGICAL_AND' => 207,
			'OP08_STRING_CAT' => 198,
			'OP13_BITWISE_AND' => 206,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -110,
			'OP16_LOGICAL_OR' => 208,
			'OP21_LIST_COMMA' => -110,
			'OP24_LOGICAL_OR_XOR' => -110,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202
		}
	},
	{#State 297
		ACTIONS => {
			'OP16_LOGICAL_OR' => -95,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			")" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP18_TERNARY' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"}" => -95,
			'OP04_MATH_POW' => 200,
			"]" => -95,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			";" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP08_STRING_CAT' => -95
		}
	},
	{#State 298
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP16_LOGICAL_OR' => -102,
			")" => -102,
			'OP14_BITWISE_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP18_TERNARY' => -102,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => -102,
			'OP08_STRING_CAT' => 198,
			";" => -102,
			'OP15_LOGICAL_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			"]" => -102,
			'OP04_MATH_POW' => 200,
			"}" => -102,
			'OP12_COMPARE_EQ_NE' => 199
		}
	},
	{#State 299
		ACTIONS => {
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP21_LIST_COMMA' => -104,
			'OP16_LOGICAL_OR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP17_LIST_RANGE' => -104,
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -104,
			'OP18_TERNARY' => -104,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP04_MATH_POW' => 200,
			"]" => -104,
			'OP12_COMPARE_EQ_NE' => 199,
			"}" => -104,
			'OP08_STRING_CAT' => 198,
			";" => -104,
			'OP15_LOGICAL_AND' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 197
		}
	},
	{#State 300
		ACTIONS => {
			"}" => -105,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200,
			"]" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			";" => -105,
			'OP15_LOGICAL_AND' => 207,
			'OP08_STRING_CAT' => 198,
			'OP13_BITWISE_AND' => 206,
			'OP18_TERNARY' => -105,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -105,
			'OP16_LOGICAL_OR' => -105,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP21_LIST_COMMA' => -105,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP17_LIST_RANGE' => -105,
			'OP23_LOGICAL_AND' => -105
		}
	},
	{#State 301
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -93,
			")" => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP07_STRING_REPEAT' => -93,
			'OP06_REGEX_MATCH' => 203,
			'OP16_LOGICAL_OR' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			"]" => -93,
			'OP04_MATH_POW' => 200,
			"}" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP08_STRING_CAT' => -93,
			";" => -93,
			'OP07_MATH_MULT_DIV_MOD' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP18_TERNARY' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP08_MATH_ADD_SUB' => -93
		}
	},
	{#State 302
		ACTIONS => {
			'OP23_LOGICAL_AND' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => -103,
			")" => -103,
			'OP14_BITWISE_OR_XOR' => -103,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP18_TERNARY' => -103,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP08_STRING_CAT' => 198,
			";" => -103,
			'OP15_LOGICAL_AND' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			"]" => -103,
			'OP04_MATH_POW' => 200,
			"}" => -103,
			'OP12_COMPARE_EQ_NE' => 199
		}
	},
	{#State 303
		ACTIONS => {
			'MY' => 165,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'Expression' => 154,
			'SubExpression' => 164,
			'ArrayReference' => 100,
			'TypeInner' => 161,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'ListElement' => 160,
			'Literal' => 95,
			'WordScoped' => 105,
			'Variable' => 153,
			'ListElements' => 346
		}
	},
	{#State 304
		DEFAULT => -142
	},
	{#State 305
		ACTIONS => {
			'OP21_LIST_COMMA' => 347
		}
	},
	{#State 306
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'MY' => 165,
			'WORD' => 26,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_QW' => 162,
			'LBRACE' => 139
		},
		GOTOS => {
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 164,
			'Expression' => 154,
			'ArrayReference' => 100,
			'TypeInner' => 161,
			'Variable' => 153,
			'ListElements' => 348,
			'HashDereference' => 96,
			'WordScoped' => 105,
			'ListElement' => 160,
			'ArrayDereference' => 94,
			'Literal' => 95
		}
	},
	{#State 307
		ACTIONS => {
			";" => 350,
			'OP02_ARRAY_THINARROW' => 349,
			'OP19_VARIABLE_ASSIGN' => 351
		}
	},
	{#State 308
		ACTIONS => {
			";" => 352
		}
	},
	{#State 309
		ACTIONS => {
			'FHREF_SYMBOL' => 353
		}
	},
	{#State 310
		DEFAULT => -199
	},
	{#State 311
		ACTIONS => {
			"}" => 354
		}
	},
	{#State 312
		DEFAULT => -123
	},
	{#State 313
		ACTIONS => {
			'OP21_LIST_COMMA' => 356,
			"}" => 357
		},
		GOTOS => {
			'PAREN-51' => 355
		}
	},
	{#State 314
		ACTIONS => {
			'MY' => 165,
			'WORD' => -202,
			'LPAREN' => -202,
			'SELF' => -202,
			'OP01_NAMED' => -202,
			'OP10_NAMED_UNARY' => -202,
			'CONSTANT_CALL_SCOPED' => -202,
			'OP01_CLOSE' => -202,
			'VARIABLE_SYMBOL' => -202,
			'OP05_LOGICAL_NEG' => -202,
			'LBRACE' => -202,
			'OP22_LOGICAL_NEG' => -202,
			'OP01_OPEN' => -202,
			"\@{" => -202,
			'WORD_SCOPED' => -202,
			"%{" => -202,
			'OP03_MATH_INC_DEC' => -202,
			'LBRACKET' => -202,
			'OP05_MATH_NEG_LPAREN' => -202,
			'WORD_UPPERCASE' => -202,
			'LITERAL_NUMBER' => -202,
			"undef" => -202,
			'LITERAL_STRING' => -202
		},
		GOTOS => {
			'OPTIONAL-50' => 359,
			'TypeInner' => 358
		}
	},
	{#State 315
		DEFAULT => -224
	},
	{#State 316
		DEFAULT => -50
	},
	{#State 317
		ACTIONS => {
			")" => 360,
			'OP21_LIST_COMMA' => 361
		},
		GOTOS => {
			'PAREN-20' => 362
		}
	},
	{#State 318
		ACTIONS => {
			'TYPE_METHOD' => 363,
			'TYPE_INTEGER' => 54,
			'WORD' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 319
		DEFAULT => -79
	},
	{#State 320
		DEFAULT => -78
	},
	{#State 321
		DEFAULT => -61
	},
	{#State 322
		ACTIONS => {
			";" => 364
		}
	},
	{#State 323
		ACTIONS => {
			"}" => 367,
			'WORD' => 366
		},
		GOTOS => {
			'HashEntryProperties' => 365
		}
	},
	{#State 324
		DEFAULT => -131
	},
	{#State 325
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			'OP14_BITWISE_OR_XOR' => 210,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP04_MATH_POW' => 200,
			"]" => 368,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP08_STRING_CAT' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207
		}
	},
	{#State 326
		ACTIONS => {
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP16_LOGICAL_OR' => 208,
			'OP14_BITWISE_OR_XOR' => 210,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP13_BITWISE_AND' => 206,
			'OP08_STRING_CAT' => 198,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP04_MATH_POW' => 200,
			'OP12_COMPARE_EQ_NE' => 199,
			"}" => 369
		}
	},
	{#State 327
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -215,
			'LPAREN' => -215,
			"}" => 370
		}
	},
	{#State 328
		ACTIONS => {
			'MY' => 165,
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'ArrayReference' => 100,
			'SubExpression' => 164,
			'Expression' => 154,
			'TypeInner' => 161,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'WordScoped' => 105,
			'ListElement' => 371,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'HashDereference' => 96,
			'Variable' => 153
		}
	},
	{#State 329
		DEFAULT => -186
	},
	{#State 330
		DEFAULT => -193
	},
	{#State 331
		DEFAULT => -189
	},
	{#State 332
		ACTIONS => {
			'WORD' => 372
		}
	},
	{#State 333
		DEFAULT => -116
	},
	{#State 334
		DEFAULT => -117
	},
	{#State 335
		ACTIONS => {
			'LBRACE' => 374
		},
		GOTOS => {
			'CodeBlock' => 373
		}
	},
	{#State 336
		DEFAULT => -214
	},
	{#State 337
		ACTIONS => {
			")" => 375
		}
	},
	{#State 338
		DEFAULT => -126
	},
	{#State 339
		DEFAULT => -119
	},
	{#State 340
		ACTIONS => {
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP14_BITWISE_OR_XOR' => 210,
			")" => 376,
			'OP13_BITWISE_AND' => 206,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207,
			'OP08_STRING_CAT' => 198
		}
	},
	{#State 341
		ACTIONS => {
			'VARIABLE_SYMBOL' => 377
		}
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 378
		}
	},
	{#State 343
		ACTIONS => {
			'VARIABLE_SYMBOL' => 379
		}
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 380
		}
	},
	{#State 345
		ACTIONS => {
			'VARIABLE_SYMBOL' => 140,
			'SELF' => 106,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'Literal' => 286,
			'Variable' => 288,
			'VariableSymbolOrSelf' => 109,
			'VariableOrLiteral' => 381
		}
	},
	{#State 346
		ACTIONS => {
			")" => 382
		}
	},
	{#State 347
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD' => 26,
			'MY' => 165,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128
		},
		GOTOS => {
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 164,
			'Expression' => 154,
			'ArrayReference' => 100,
			'TypeInner' => 161,
			'Variable' => 153,
			'ListElements' => 383,
			'HashDereference' => 96,
			'Literal' => 95,
			'ListElement' => 160,
			'ArrayDereference' => 94,
			'WordScoped' => 105
		}
	},
	{#State 348
		ACTIONS => {
			";" => 384
		}
	},
	{#State 349
		ACTIONS => {
			'WORD' => 26,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'HashDereference' => 96,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Variable' => 153,
			'Expression' => 154,
			'SubExpression' => 385,
			'ArrayReference' => 100,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110
		}
	},
	{#State 350
		DEFAULT => -179
	},
	{#State 351
		ACTIONS => {
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'WORD_UPPERCASE' => 151,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD' => 26,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'STDIN' => 274
		},
		GOTOS => {
			'Variable' => 153,
			'SubExpressionOrStdin' => 386,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'HashDereference' => 96,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'SubExpression' => 273,
			'Expression' => 154
		}
	},
	{#State 352
		DEFAULT => -182
	},
	{#State 353
		ACTIONS => {
			'OP21_LIST_COMMA' => 387
		}
	},
	{#State 354
		DEFAULT => -200
	},
	{#State 355
		DEFAULT => -207
	},
	{#State 356
		ACTIONS => {
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"%{" => 119,
			'SELF' => 106,
			'WORD' => 228,
			'VARIABLE_SYMBOL' => 140
		},
		GOTOS => {
			'HashDereference' => 230,
			'Literal' => 229,
			'HashEntry' => 388,
			'VariableOrLiteralOrWord' => 231,
			'Variable' => 226,
			'VariableSymbolOrSelf' => 109
		}
	},
	{#State 357
		DEFAULT => -209
	},
	{#State 358
		DEFAULT => -201
	},
	{#State 359
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'SubExpression' => 389,
			'Expression' => 154,
			'ArrayReference' => 100,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98,
			'HashDereference' => 96,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Variable' => 153
		}
	},
	{#State 360
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 390
		}
	},
	{#State 361
		ACTIONS => {
			'MY' => 391
		}
	},
	{#State 362
		DEFAULT => -52
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 392
		}
	},
	{#State 364
		DEFAULT => -63
	},
	{#State 365
		DEFAULT => -66,
		GOTOS => {
			'STAR-27' => 393
		}
	},
	{#State 366
		ACTIONS => {
			'OP20_HASH_FATARROW' => 394
		}
	},
	{#State 367
		ACTIONS => {
			";" => 395
		}
	},
	{#State 368
		DEFAULT => -176
	},
	{#State 369
		DEFAULT => -177
	},
	{#State 370
		DEFAULT => -178
	},
	{#State 371
		DEFAULT => -185
	},
	{#State 372
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 396
		}
	},
	{#State 373
		DEFAULT => -157,
		GOTOS => {
			'STAR-40' => 397
		}
	},
	{#State 374
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'LITERAL_STRING' => 86,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP01_PRINT' => 114,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_NAMED_VOID' => 112,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'SELF' => 106,
			"while" => -149,
			'WORD_UPPERCASE' => 125,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 128,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'OP03_MATH_INC_DEC' => 120,
			'OP01_NAMED_VOID_LPAREN' => 122,
			"%{" => 119,
			"if" => 116,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			'OP19_LOOP_CONTROL' => 137,
			"\@{" => 136,
			'VARIABLE_SYMBOL' => 140,
			'LBRACE' => 139,
			"foreach" => -149,
			'MY' => 134,
			"for" => -149,
			'WORD' => 26,
			'LPAREN' => 131,
			'OP01_NAMED' => 132
		},
		GOTOS => {
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'PAREN-37' => 108,
			'Statement' => 115,
			'Conditional' => 133,
			'Operation' => 399,
			'WordScoped' => 105,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'OPTIONAL-38' => 127,
			'SubExpression' => 129,
			'Expression' => 101,
			'LoopLabel' => 117,
			'PLUS-43' => 398,
			'Variable' => 121,
			'VariableDeclaration' => 93,
			'VariableModification' => 97,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'OperatorVoid' => 123,
			'HashDereference' => 96
		}
	},
	{#State 375
		DEFAULT => -132
	},
	{#State 376
		ACTIONS => {
			'LBRACE' => 374
		},
		GOTOS => {
			'CodeBlock' => 400
		}
	},
	{#State 377
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 401
		}
	},
	{#State 378
		ACTIONS => {
			'LPAREN' => 402
		}
	},
	{#State 379
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 403
		}
	},
	{#State 380
		ACTIONS => {
			'LPAREN' => 404
		}
	},
	{#State 381
		DEFAULT => -107
	},
	{#State 382
		DEFAULT => -82
	},
	{#State 383
		ACTIONS => {
			")" => 405
		}
	},
	{#State 384
		DEFAULT => -121
	},
	{#State 385
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 206,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207,
			'OP08_STRING_CAT' => 198,
			'OP12_COMPARE_EQ_NE' => 199,
			"]" => 406,
			'OP04_MATH_POW' => 200,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP14_BITWISE_OR_XOR' => 210
		}
	},
	{#State 386
		ACTIONS => {
			";" => 407
		}
	},
	{#State 387
		ACTIONS => {
			'LITERAL_STRING' => 408
		}
	},
	{#State 388
		DEFAULT => -206
	},
	{#State 389
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			'OP21_LIST_COMMA' => -203,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			'OP04_MATH_POW' => 200,
			"}" => -203,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP08_STRING_CAT' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205
		}
	},
	{#State 390
		ACTIONS => {
			"\@_;" => 409
		}
	},
	{#State 391
		ACTIONS => {
			'WORD_SCOPED' => 57,
			'WORD' => 56,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 410
		}
	},
	{#State 392
		ACTIONS => {
			"= sub {" => 411
		}
	},
	{#State 393
		ACTIONS => {
			"}" => 412,
			'OP21_LIST_COMMA' => 414
		},
		GOTOS => {
			'PAREN-26' => 413
		}
	},
	{#State 394
		ACTIONS => {
			'MY' => 415
		},
		GOTOS => {
			'TypeInnerProperties' => 416
		}
	},
	{#State 395
		DEFAULT => -68
	},
	{#State 396
		DEFAULT => -221
	},
	{#State 397
		ACTIONS => {
			'OP01_PRINT' => -160,
			'OP01_CLOSE' => -160,
			'OP05_LOGICAL_NEG' => -160,
			'OP01_NAMED_VOID' => -160,
			"else" => 420,
			'SELF' => -160,
			'CONSTANT_CALL_SCOPED' => -160,
			'OP10_NAMED_UNARY' => -160,
			"elsif" => 417,
			'OP05_MATH_NEG_LPAREN' => -160,
			'OP19_LOOP_CONTROL_SCOLON' => -160,
			'LITERAL_STRING' => -160,
			'VARIABLE_SYMBOL' => -160,
			'LBRACE' => -160,
			'OP22_LOGICAL_NEG' => -160,
			'OP19_LOOP_CONTROL' => -160,
			"\@{" => -160,
			'OP01_OPEN' => -160,
			"for" => -160,
			'WORD' => -160,
			'MY' => -160,
			'OP01_NAMED' => -160,
			'LPAREN' => -160,
			"foreach" => -160,
			'LBRACKET' => -160,
			"}" => -160,
			"undef" => -160,
			'WORD_UPPERCASE' => -160,
			'LITERAL_NUMBER' => -160,
			"while" => -160,
			'WORD_SCOPED' => -160,
			'OP03_MATH_INC_DEC' => -160,
			'OP01_NAMED_VOID_LPAREN' => -160,
			"%{" => -160,
			'OP01_NAMED_VOID_SCOLON' => -160,
			"if" => -160,
			'' => -160
		},
		GOTOS => {
			'PAREN-41' => 421,
			'OPTIONAL-42' => 419,
			'PAREN-39' => 418
		}
	},
	{#State 398
		ACTIONS => {
			"while" => -149,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_UPPERCASE' => 125,
			"}" => 423,
			'LBRACKET' => 128,
			'OP01_NAMED_VOID_SCOLON' => 118,
			"%{" => 119,
			'OP01_NAMED_VOID_LPAREN' => 122,
			'OP03_MATH_INC_DEC' => 120,
			"if" => 116,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			'OP19_LOOP_CONTROL' => 137,
			"\@{" => 136,
			'VARIABLE_SYMBOL' => 140,
			'LBRACE' => 139,
			"foreach" => -149,
			'MY' => 134,
			'WORD' => 26,
			"for" => -149,
			'LPAREN' => 131,
			'OP01_NAMED' => 132,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'LITERAL_STRING' => 86,
			'OP05_MATH_NEG_LPAREN' => 102,
			'OP01_PRINT' => 114,
			'OP01_CLOSE' => 113,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_NAMED_VOID' => 112,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'SELF' => 106
		},
		GOTOS => {
			'LoopLabel' => 117,
			'Variable' => 121,
			'VariableDeclaration' => 93,
			'VariableModification' => 97,
			'OperatorVoid' => 123,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'HashDereference' => 96,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'OPTIONAL-38' => 127,
			'SubExpression' => 129,
			'Expression' => 101,
			'Conditional' => 133,
			'Operation' => 422,
			'WordScoped' => 105,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'PAREN-37' => 108,
			'Statement' => 115
		}
	},
	{#State 399
		DEFAULT => -171
	},
	{#State 400
		DEFAULT => -168
	},
	{#State 401
		ACTIONS => {
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'STDIN' => 274,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131
		},
		GOTOS => {
			'Literal' => 95,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'HashDereference' => 96,
			'SubExpressionOrStdin' => 424,
			'Variable' => 153,
			'ArrayReference' => 100,
			'Expression' => 154,
			'SubExpression' => 273,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109
		}
	},
	{#State 402
		ACTIONS => {
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD' => 26,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'WORD_SCOPED' => 27,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151
		},
		GOTOS => {
			'Variable' => 153,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'WordScoped' => 105,
			'HashDereference' => 96,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'SubExpression' => 425,
			'Expression' => 154
		}
	},
	{#State 403
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'SubExpression' => 426,
			'Expression' => 154,
			'ArrayReference' => 100,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'HashDereference' => 96,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'Variable' => 153
		}
	},
	{#State 404
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'LBRACE' => 139,
			'OP01_QW' => 162,
			'OP05_LOGICAL_NEG' => 111,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'WORD' => 26,
			'MY' => 165,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98,
			'TypeInner' => 161,
			'SubExpression' => 164,
			'Expression' => 154,
			'ArrayReference' => 100,
			'Variable' => 153,
			'ListElements' => 427,
			'HashDereference' => 96,
			'ListElement' => 160,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Literal' => 95
		}
	},
	{#State 405
		DEFAULT => -84
	},
	{#State 406
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 428
		}
	},
	{#State 407
		DEFAULT => -180
	},
	{#State 408
		ACTIONS => {
			'OP21_LIST_COMMA' => 429
		}
	},
	{#State 409
		DEFAULT => -54
	},
	{#State 410
		ACTIONS => {
			'VARIABLE_SYMBOL' => 430
		}
	},
	{#State 411
		ACTIONS => {
			'LPAREN_MY' => 431,
			'OP05_MATH_NEG_LPAREN' => -70,
			'OP19_LOOP_CONTROL_SCOLON' => -70,
			'LITERAL_STRING' => -70,
			'SELF' => -70,
			'CONSTANT_CALL_SCOPED' => -70,
			'OP10_NAMED_UNARY' => -70,
			'OP01_CLOSE' => -70,
			'OP01_PRINT' => -70,
			'OP01_NAMED_VOID' => -70,
			'OP05_LOGICAL_NEG' => -70,
			'WORD_SCOPED' => -70,
			'OP03_MATH_INC_DEC' => -70,
			'OP01_NAMED_VOID_LPAREN' => -70,
			"%{" => -70,
			'OP01_NAMED_VOID_SCOLON' => -70,
			"if" => -70,
			"}" => -70,
			'LBRACKET' => -70,
			"undef" => -70,
			'LITERAL_NUMBER' => -70,
			'WORD_UPPERCASE' => -70,
			"while" => -70,
			"for" => -70,
			'WORD' => -70,
			'MY' => -70,
			'OP01_NAMED' => -70,
			'LPAREN' => -70,
			"foreach" => -70,
			'VARIABLE_SYMBOL' => -70,
			'LBRACE' => -70,
			'OP22_LOGICAL_NEG' => -70,
			'OP19_LOOP_CONTROL' => -70,
			"\@{" => -70,
			'OP01_OPEN' => -70
		},
		GOTOS => {
			'OPTIONAL-28' => 432,
			'MethodArguments' => 433
		}
	},
	{#State 412
		ACTIONS => {
			";" => 434
		}
	},
	{#State 413
		DEFAULT => -65
	},
	{#State 414
		ACTIONS => {
			'WORD' => 366
		},
		GOTOS => {
			'HashEntryProperties' => 435
		}
	},
	{#State 415
		ACTIONS => {
			'WORD_SCOPED' => 57,
			'WORD' => 56,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 436
		}
	},
	{#State 416
		DEFAULT => -205
	},
	{#State 417
		ACTIONS => {
			'LPAREN' => 437
		}
	},
	{#State 418
		DEFAULT => -156
	},
	{#State 419
		DEFAULT => -161
	},
	{#State 420
		ACTIONS => {
			'LBRACE' => 374
		},
		GOTOS => {
			'CodeBlock' => 438
		}
	},
	{#State 421
		DEFAULT => -159
	},
	{#State 422
		DEFAULT => -170
	},
	{#State 423
		DEFAULT => -172
	},
	{#State 424
		ACTIONS => {
			")" => 439
		}
	},
	{#State 425
		ACTIONS => {
			'OP08_STRING_CAT' => 198,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP04_MATH_POW' => 200,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP14_BITWISE_OR_XOR' => 210,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 440,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => 208
		}
	},
	{#State 426
		ACTIONS => {
			'OP13_BITWISE_AND' => 206,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207,
			";" => 441,
			'OP08_STRING_CAT' => 198,
			'OP16_LOGICAL_OR' => 208,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP14_BITWISE_OR_XOR' => 210
		}
	},
	{#State 427
		ACTIONS => {
			")" => 442
		}
	},
	{#State 428
		ACTIONS => {
			"undef" => 443
		}
	},
	{#State 429
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'LPAREN' => 131,
			'WORD' => 26,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140
		},
		GOTOS => {
			'HashDereference' => 96,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'Variable' => 153,
			'SubExpression' => 444,
			'Expression' => 154,
			'ArrayReference' => 100,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'HashReference' => 98
		}
	},
	{#State 430
		DEFAULT => -51
	},
	{#State 431
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 56,
			'WORD_SCOPED' => 57
		},
		GOTOS => {
			'Type' => 445
		}
	},
	{#State 432
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 446
		}
	},
	{#State 433
		DEFAULT => -69
	},
	{#State 434
		DEFAULT => -67
	},
	{#State 435
		DEFAULT => -64
	},
	{#State 436
		ACTIONS => {
			"\$TYPED_" => 447
		}
	},
	{#State 437
		ACTIONS => {
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102
		},
		GOTOS => {
			'Variable' => 153,
			'HashDereference' => 96,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'SubExpression' => 448,
			'Expression' => 154,
			'ArrayReference' => 100
		}
	},
	{#State 438
		DEFAULT => -158
	},
	{#State 439
		ACTIONS => {
			'LBRACE' => 374
		},
		GOTOS => {
			'CodeBlock' => 449
		}
	},
	{#State 440
		ACTIONS => {
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111
		},
		GOTOS => {
			'Variable' => 153,
			'HashDereference' => 96,
			'WordScoped' => 105,
			'Literal' => 95,
			'ArrayDereference' => 94,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'SubExpression' => 450,
			'Expression' => 154,
			'ArrayReference' => 100
		}
	},
	{#State 441
		ACTIONS => {
			'VARIABLE_SYMBOL' => 451
		}
	},
	{#State 442
		ACTIONS => {
			'LBRACE' => 374
		},
		GOTOS => {
			'CodeBlock' => 452
		}
	},
	{#State 443
		ACTIONS => {
			";" => 453
		}
	},
	{#State 444
		ACTIONS => {
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP21_LIST_COMMA' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => -85,
			'OP17_LIST_RANGE' => 201,
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -85,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			"]" => -85,
			'OP04_MATH_POW' => 200,
			'OP12_COMPARE_EQ_NE' => 199,
			"}" => -85,
			'OP08_STRING_CAT' => 198,
			";" => -85,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197
		}
	},
	{#State 445
		ACTIONS => {
			'SELF' => 454
		}
	},
	{#State 446
		ACTIONS => {
			"%{" => 119,
			'OP01_NAMED_VOID_LPAREN' => 122,
			'OP03_MATH_INC_DEC' => 120,
			'OP01_NAMED_VOID_SCOLON' => 118,
			"if" => 116,
			'WORD_SCOPED' => 27,
			'LITERAL_NUMBER' => 85,
			"undef" => 126,
			'WORD_UPPERCASE' => 125,
			"while" => -149,
			'LBRACKET' => 128,
			"}" => 456,
			"foreach" => -149,
			"for" => -149,
			'WORD' => 26,
			'MY' => 134,
			'OP01_NAMED' => 132,
			'LPAREN' => 131,
			'OP22_LOGICAL_NEG' => 138,
			"\@{" => 136,
			'OP19_LOOP_CONTROL' => 137,
			'OP01_OPEN' => 135,
			'VARIABLE_SYMBOL' => 140,
			'LBRACE' => 139,
			'OP19_LOOP_CONTROL_SCOLON' => 99,
			'LITERAL_STRING' => 86,
			'OP05_MATH_NEG_LPAREN' => 102,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'SELF' => 106,
			'OP01_CLOSE' => 113,
			'OP01_PRINT' => 114,
			'OP05_LOGICAL_NEG' => 111,
			'OP01_NAMED_VOID' => 112
		},
		GOTOS => {
			'WordScoped' => 105,
			'Conditional' => 133,
			'Operation' => 455,
			'PAREN-37' => 108,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110,
			'Statement' => 115,
			'LoopLabel' => 117,
			'VariableDeclaration' => 93,
			'Variable' => 121,
			'ArrayDereference' => 94,
			'OperatorVoid' => 123,
			'Literal' => 95,
			'HashDereference' => 96,
			'VariableModification' => 97,
			'HashReference' => 98,
			'ArrayReference' => 100,
			'OPTIONAL-38' => 127,
			'Expression' => 101,
			'SubExpression' => 129
		}
	},
	{#State 447
		ACTIONS => {
			'WORD' => 457
		}
	},
	{#State 448
		ACTIONS => {
			")" => 458,
			'OP14_BITWISE_OR_XOR' => 210,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP16_LOGICAL_OR' => 208,
			'OP08_STRING_CAT' => 198,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP04_MATH_POW' => 200,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP13_BITWISE_AND' => 206
		}
	},
	{#State 449
		DEFAULT => -169
	},
	{#State 450
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP23_LOGICAL_AND' => -106,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			")" => 459,
			'OP14_BITWISE_OR_XOR' => 210,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194,
			'OP13_BITWISE_AND' => 206,
			'OP18_TERNARY' => -106,
			'OP09_BITWISE_SHIFT' => 195,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP08_STRING_CAT' => 198,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200
		}
	},
	{#State 451
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 460
		}
	},
	{#State 452
		DEFAULT => -167
	},
	{#State 453
		DEFAULT => -181
	},
	{#State 454
		DEFAULT => -76,
		GOTOS => {
			'STAR-31' => 461
		}
	},
	{#State 455
		DEFAULT => -71
	},
	{#State 456
		ACTIONS => {
			";" => 462
		}
	},
	{#State 457
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 464,
			'OP19_VARIABLE_ASSIGN' => 463
		}
	},
	{#State 458
		ACTIONS => {
			'LBRACE' => 374
		},
		GOTOS => {
			'CodeBlock' => 465
		}
	},
	{#State 459
		ACTIONS => {
			'LBRACE' => 374
		},
		GOTOS => {
			'CodeBlock' => 466
		}
	},
	{#State 460
		ACTIONS => {
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'OP05_MATH_NEG_LPAREN' => 102,
			'LBRACKET' => 128,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			"\@{" => 136,
			'OP01_OPEN' => 135,
			'OP22_LOGICAL_NEG' => 138,
			'LBRACE' => 139,
			'OP05_LOGICAL_NEG' => 111,
			'VARIABLE_SYMBOL' => 140,
			'OP01_CLOSE' => 113,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP10_NAMED_UNARY' => 103,
			'OP01_NAMED' => 150,
			'LPAREN' => 131,
			'SELF' => 106,
			'WORD' => 26
		},
		GOTOS => {
			'Literal' => 95,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'HashDereference' => 96,
			'Variable' => 153,
			'ArrayReference' => 100,
			'Expression' => 154,
			'SubExpression' => 467,
			'HashReference' => 98,
			'VariableSymbolOrSelf' => 109,
			'Operator' => 110
		}
	},
	{#State 461
		ACTIONS => {
			'OP21_LIST_COMMA' => 469,
			")" => 468
		},
		GOTOS => {
			'PAREN-30' => 470
		}
	},
	{#State 462
		DEFAULT => -73
	},
	{#State 463
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'LITERAL_NUMBER' => 85,
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'WORD_UPPERCASE' => 151,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Expression' => 154,
			'SubExpression' => 471,
			'ArrayReference' => 100,
			'HashReference' => 98,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashDereference' => 96,
			'Literal' => 95,
			'WordScoped' => 105,
			'ArrayDereference' => 94,
			'Variable' => 153
		}
	},
	{#State 464
		ACTIONS => {
			'LITERAL_STRING' => 86,
			"undef" => 126,
			'LITERAL_NUMBER' => 85,
			'WORD_UPPERCASE' => 151,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 120,
			'WORD_SCOPED' => 27,
			'OP22_LOGICAL_NEG' => 138,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'WORD' => 26,
			'LPAREN' => 131,
			'SELF' => 106,
			'OP01_NAMED' => 150
		},
		GOTOS => {
			'Expression' => 154,
			'SubExpression' => 472,
			'ArrayReference' => 100,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'WordScoped' => 105,
			'Literal' => 95,
			'Variable' => 153
		}
	},
	{#State 465
		DEFAULT => -155
	},
	{#State 466
		DEFAULT => -165
	},
	{#State 467
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			'OP16_LOGICAL_OR' => 208,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			";" => 473,
			'OP08_STRING_CAT' => 198,
			'OP13_BITWISE_AND' => 206,
			'OP18_TERNARY' => 196,
			'OP09_BITWISE_SHIFT' => 195,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194
		}
	},
	{#State 468
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 474
		}
	},
	{#State 469
		ACTIONS => {
			'MY' => 475
		}
	},
	{#State 470
		DEFAULT => -75
	},
	{#State 471
		ACTIONS => {
			'OP04_MATH_POW' => 200,
			"}" => -222,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP08_STRING_CAT' => 198,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP13_BITWISE_AND' => 206,
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP14_BITWISE_OR_XOR' => 210,
			'OP21_LIST_COMMA' => -222,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201
		}
	},
	{#State 472
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 194,
			'OP08_MATH_ADD_SUB' => 205,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP13_BITWISE_AND' => 206,
			'OP08_STRING_CAT' => 198,
			'OP15_LOGICAL_AND' => 207,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP04_MATH_POW' => 200,
			"]" => 476,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP23_LOGICAL_AND' => 202,
			'OP17_LIST_RANGE' => 201,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP06_REGEX_MATCH' => 203,
			'OP07_STRING_REPEAT' => 209,
			'OP16_LOGICAL_OR' => 208,
			'OP14_BITWISE_OR_XOR' => 210
		}
	},
	{#State 473
		ACTIONS => {
			'SELF' => 106,
			'LPAREN' => 131,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 103,
			'CONSTANT_CALL_SCOPED' => 104,
			'OP05_LOGICAL_NEG' => 111,
			'LBRACE' => 139,
			'OP01_CLOSE' => 113,
			'VARIABLE_SYMBOL' => 140,
			'OP01_OPEN' => 135,
			"\@{" => 136,
			'OP22_LOGICAL_NEG' => 138,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 120,
			"%{" => 119,
			'LBRACKET' => 128,
			'OP05_MATH_NEG_LPAREN' => 102,
			'WORD_UPPERCASE' => 151,
			"undef" => 126,
			'LITERAL_STRING' => 86,
			'LITERAL_NUMBER' => 85
		},
		GOTOS => {
			'Variable' => 121,
			'SubExpressionOrVarMod' => 478,
			'VariableModification' => 477,
			'HashDereference' => 96,
			'ArrayDereference' => 94,
			'Literal' => 95,
			'WordScoped' => 105,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 109,
			'HashReference' => 98,
			'SubExpression' => 479,
			'Expression' => 154,
			'ArrayReference' => 100
		}
	},
	{#State 474
		ACTIONS => {
			"\@_;" => 480
		}
	},
	{#State 475
		ACTIONS => {
			'WORD_SCOPED' => 57,
			'WORD' => 56,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 481
		}
	},
	{#State 476
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 482
		}
	},
	{#State 477
		DEFAULT => -146
	},
	{#State 478
		ACTIONS => {
			")" => 483
		}
	},
	{#State 479
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 210,
			")" => -145,
			'OP16_LOGICAL_OR' => 208,
			'OP07_STRING_REPEAT' => 209,
			'OP06_REGEX_MATCH' => 203,
			'OP24_LOGICAL_OR_XOR' => 204,
			'OP17_LIST_RANGE' => 201,
			'OP23_LOGICAL_AND' => 202,
			'OP12_COMPARE_EQ_NE' => 199,
			'OP04_MATH_POW' => 200,
			'OP07_MATH_MULT_DIV_MOD' => 197,
			'OP15_LOGICAL_AND' => 207,
			'OP08_STRING_CAT' => 198,
			'OP13_BITWISE_AND' => 206,
			'OP09_BITWISE_SHIFT' => 195,
			'OP18_TERNARY' => 196,
			'OP08_MATH_ADD_SUB' => 205,
			'OP11_COMPARE_LT_GT' => 194
		}
	},
	{#State 480
		DEFAULT => -77
	},
	{#State 481
		ACTIONS => {
			'VARIABLE_SYMBOL' => 484
		}
	},
	{#State 482
		ACTIONS => {
			"undef" => 485
		}
	},
	{#State 483
		ACTIONS => {
			'LBRACE' => 374
		},
		GOTOS => {
			'CodeBlock' => 486
		}
	},
	{#State 484
		DEFAULT => -74
	},
	{#State 485
		DEFAULT => -223
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
