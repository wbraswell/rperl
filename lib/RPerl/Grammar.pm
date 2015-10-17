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
    our $VERSION = 0.001_996;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\=\ sub\ \{|\$TYPED_|foreach|elsif|undef|while|else|our|for|\@_\;|\@\{|if|\%\{|\;|\)|\]|\})}gc and return ($1, $1);

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
      /\G(qw\([^()]*\))/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|keys|values|sort|length|split|join|reverse|chomp|fakebuiltin)\s/gc and return ('OP01_NAMED', $1);
      /\G(:)/gc and return ('COLON', $1);
      /\G(\(\s*my)/gc and return ('LPAREN_MY', $1);
      /\G(\()/gc and return ('LPAREN', $1);
      /\G(\[)/gc and return ('LBRACKET', $1);
      /\G(\{)/gc and return ('LBRACE', $1);
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
  [ 'Include_41' => 'Include', [ 'USE', 'WordScoped', ';' ], 0 ],
  [ 'Include_42' => 'Include', [ 'USE', 'WordScoped', 'OP01_QW', ';' ], 0 ],
  [ 'Constant_43' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-18', [ 'STAR-18', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-18', [  ], 0 ],
  [ 'Subroutine_48' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-17', 'STAR-18', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-19', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'PAREN-19' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ 'SubroutineArguments_52' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-20', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [ 'STAR-24', 'MethodOrSubroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-24', [  ], 0 ],
  [ 'Class_61' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-21', 'STAR-22', 'STAR-23', 'Properties', 'STAR-24', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-25', [ 'OP21_LIST_COMMA', 'HashEntryProperties' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [ 'STAR-26', 'PAREN-25' ], 0 ],
  [ '_STAR_LIST' => 'STAR-26', [  ], 0 ],
  [ 'Properties_65' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryProperties', 'STAR-26', '}', ';' ], 0 ],
  [ 'Properties_66' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [ 'STAR-28', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-28', [  ], 0 ],
  [ 'Method_71' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-27', 'STAR-28', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-29', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [ 'STAR-30', 'PAREN-29' ], 0 ],
  [ '_STAR_LIST' => 'STAR-30', [  ], 0 ],
  [ 'MethodArguments_75' => 'MethodArguments', [ 'LPAREN_MY', 'Type', 'SELF', 'STAR-30', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ 'MethodOrSubroutine_76' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_77' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
  [ 'Operation_78' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_79' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_80' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_81' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_83' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_107' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_108' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-31', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'PAREN-31' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-32', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-33', ')', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_120' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_121' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-35', [  ], 0 ],
  [ 'Expression_126' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_127' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'CONSTANT_CALL_SCOPED' ], 0 ],
  [ 'Expression_129' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_130' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-35', ')' ], 0 ],
  [ 'Expression_131' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_138' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_139' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_140' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_141' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_142' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_143' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_144' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'PAREN-36' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Statement_148' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'OPTIONAL-37', 'Loop' ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [ 'STAR-39', 'PAREN-38' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [  ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'PAREN-40' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'Conditional_159' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-39', 'OPTIONAL-41' ], 0 ],
  [ 'Loop_160' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_161' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_163' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_164' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpression', ';', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'SubExpression', ';', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_165' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_166' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_167' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'PLUS-42', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'Operation' ], 0 ],
  [ 'CodeBlock_170' => 'CodeBlock', [ 'LBRACE', 'PLUS-42', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'Variable_173' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-43' ], 0 ],
  [ 'VariableRetrieval_174' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_175' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_176' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_177' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_178' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableDeclaration_179' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_181' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin' ], 0 ],
  [ 'VariableModification_182' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'PAREN-44' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'ListElements_186' => 'ListElements', [ 'ListElement', 'STAR-45' ], 0 ],
  [ 'ListElement_187' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_189' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_192' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_195' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_196' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_199' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_200' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryProperties_201' => 'HashEntryProperties', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_205' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_206' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_209' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_210' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_211' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_212' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_213' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_214' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_215' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_216' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_217' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_218' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_219' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
  [ 'TypeInnerConstant_220' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_221' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_222' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_223' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_224' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_225' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'VariableSymbolOrSelf_226' => 'VariableSymbolOrSelf', [ 'VARIABLE_SYMBOL' ], 0 ],
  [ 'VariableSymbolOrSelf_227' => 'VariableSymbolOrSelf', [ 'SELF' ], 0 ],
  [ 'Literal_228' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_229' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'Include_41' => 41,
  'Include_42' => 42,
  'Constant_43' => 43,
  '_OPTIONAL' => 44,
  '_OPTIONAL' => 45,
  '_STAR_LIST' => 46,
  '_STAR_LIST' => 47,
  'Subroutine_48' => 48,
  '_PAREN' => 49,
  '_STAR_LIST' => 50,
  '_STAR_LIST' => 51,
  'SubroutineArguments_52' => 52,
  '_STAR_LIST' => 53,
  '_STAR_LIST' => 54,
  '_STAR_LIST' => 55,
  '_STAR_LIST' => 56,
  '_STAR_LIST' => 57,
  '_STAR_LIST' => 58,
  '_STAR_LIST' => 59,
  '_STAR_LIST' => 60,
  'Class_61' => 61,
  '_PAREN' => 62,
  '_STAR_LIST' => 63,
  '_STAR_LIST' => 64,
  'Properties_65' => 65,
  'Properties_66' => 66,
  '_OPTIONAL' => 67,
  '_OPTIONAL' => 68,
  '_STAR_LIST' => 69,
  '_STAR_LIST' => 70,
  'Method_71' => 71,
  '_PAREN' => 72,
  '_STAR_LIST' => 73,
  '_STAR_LIST' => 74,
  'MethodArguments_75' => 75,
  'MethodOrSubroutine_76' => 76,
  'MethodOrSubroutine_77' => 77,
  'Operation_78' => 78,
  'Operation_79' => 79,
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
  'Operator_108' => 108,
  '_PAREN' => 109,
  '_OPTIONAL' => 110,
  '_OPTIONAL' => 111,
  '_OPTIONAL' => 112,
  '_OPTIONAL' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  'OperatorVoid_116' => 116,
  'OperatorVoid_117' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  'OperatorVoid_120' => 120,
  'OperatorVoid_121' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  '_OPTIONAL' => 124,
  '_OPTIONAL' => 125,
  'Expression_126' => 126,
  'Expression_127' => 127,
  'Expression_128' => 128,
  'Expression_129' => 129,
  'Expression_130' => 130,
  'Expression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpression_138' => 138,
  'SubExpression_139' => 139,
  'SubExpression_140' => 140,
  'SubExpressionOrStdin_141' => 141,
  'SubExpressionOrStdin_142' => 142,
  'SubExpressionOrVarMod_143' => 143,
  'SubExpressionOrVarMod_144' => 144,
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
  'LoopFor_164' => 164,
  'LoopForEach_165' => 165,
  'LoopWhile_166' => 166,
  'LoopWhile_167' => 167,
  '_PLUS_LIST' => 168,
  '_PLUS_LIST' => 169,
  'CodeBlock_170' => 170,
  '_STAR_LIST' => 171,
  '_STAR_LIST' => 172,
  'Variable_173' => 173,
  'VariableRetrieval_174' => 174,
  'VariableRetrieval_175' => 175,
  'VariableRetrieval_176' => 176,
  'VariableDeclaration_177' => 177,
  'VariableDeclaration_178' => 178,
  'VariableDeclaration_179' => 179,
  'VariableDeclaration_180' => 180,
  'VariableModification_181' => 181,
  'VariableModification_182' => 182,
  '_PAREN' => 183,
  '_STAR_LIST' => 184,
  '_STAR_LIST' => 185,
  'ListElements_186' => 186,
  'ListElement_187' => 187,
  'ListElement_188' => 188,
  'ListElement_189' => 189,
  '_OPTIONAL' => 190,
  '_OPTIONAL' => 191,
  'ArrayReference_192' => 192,
  '_OPTIONAL' => 193,
  '_OPTIONAL' => 194,
  'ArrayDereference_195' => 195,
  'ArrayDereference_196' => 196,
  '_OPTIONAL' => 197,
  '_OPTIONAL' => 198,
  'HashEntry_199' => 199,
  'HashEntry_200' => 200,
  'HashEntryProperties_201' => 201,
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
  'TypeInnerProperties_218' => 218,
  'TypeInnerProperties_219' => 219,
  'TypeInnerConstant_220' => 220,
  'VariableOrLiteral_221' => 221,
  'VariableOrLiteral_222' => 222,
  'VariableOrLiteralOrWord_223' => 223,
  'VariableOrLiteralOrWord_224' => 224,
  'VariableOrLiteralOrWord_225' => 225,
  'VariableSymbolOrSelf_226' => 226,
  'VariableSymbolOrSelf_227' => 227,
  'Literal_228' => 228,
  'Literal_229' => 229,
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
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 3,
			'SHEBANG' => 9
		},
		GOTOS => {
			'Critic' => 6,
			'ModuleHeader' => 8,
			'PLUS-2' => 5,
			'PAREN-1' => 4,
			'Program' => 2,
			'CompileUnit' => 1,
			'OPTIONAL-9' => 7
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
			'WORD' => 12
		},
		GOTOS => {
			'PLUS-16' => 11
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'' => -5,
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 6,
			'PAREN-1' => 13,
			'ModuleHeader' => 8,
			'OPTIONAL-9' => 7
		}
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 15
		},
		GOTOS => {
			'OPTIONAL-10' => 14
		}
	},
	{#State 8
		ACTIONS => {
			"use parent qw(" => 19,
			'USE' => -27,
			"## no critic qw(" => -27,
			"our" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'Module' => 16,
			'Class' => 20,
			'Package' => 17,
			'STAR-11' => 18
		}
	},
	{#State 9
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 22,
			'OPTIONAL-3' => 21
		}
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		ACTIONS => {
			")" => 23,
			'WORD' => 24
		}
	},
	{#State 12
		DEFAULT => -39
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		ACTIONS => {
			"package" => 25
		}
	},
	{#State 15
		DEFAULT => -21
	},
	{#State 16
		DEFAULT => -1
	},
	{#State 17
		DEFAULT => -24
	},
	{#State 18
		ACTIONS => {
			'USE' => -29,
			"our" => -29,
			"use constant" => -29,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-12' => 27
		}
	},
	{#State 19
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 29
		}
	},
	{#State 20
		DEFAULT => -25
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
		DEFAULT => -40
	},
	{#State 24
		DEFAULT => -38
	},
	{#State 25
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 26
		DEFAULT => -26
	},
	{#State 27
		ACTIONS => {
			"our" => -31,
			"use constant" => -31,
			'USE' => 34
		},
		GOTOS => {
			'STAR-13' => 35,
			'Include' => 33
		}
	},
	{#State 28
		DEFAULT => -211
	},
	{#State 29
		ACTIONS => {
			")" => 36
		}
	},
	{#State 30
		DEFAULT => -212
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
		DEFAULT => -28
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 28
		},
		GOTOS => {
			'WordScoped' => 40
		}
	},
	{#State 35
		ACTIONS => {
			"use constant" => 43,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 45,
			'Constant' => 44,
			'PLUS-14' => 41
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
			"use strict;" => 38
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 40
		ACTIONS => {
			'OP01_QW' => 50,
			";" => 51
		}
	},
	{#State 41
		ACTIONS => {
			'LITERAL_NUMBER' => 53,
			"our" => 42
		},
		GOTOS => {
			'Subroutine' => 52
		}
	},
	{#State 42
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD' => 57,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 58
		}
	},
	{#State 44
		DEFAULT => -30
	},
	{#State 45
		DEFAULT => -33
	},
	{#State 46
		ACTIONS => {
			'USE' => 34
		},
		GOTOS => {
			'Include' => 59
		}
	},
	{#State 47
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -11,
			'OP10_NAMED_UNARY' => -11,
			"our" => -11,
			'SELF' => -11,
			'LITERAL_STRING' => -11,
			'WORD_SCOPED' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LBRACKET' => -11,
			"## no critic qw(" => 3,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"if" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'VARIABLE_SYMBOL' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_CLOSE' => -11,
			'OP03_MATH_INC_DEC' => -11,
			"use constant" => -11,
			"foreach" => -11,
			"while" => -11,
			'OP01_OPEN' => -11,
			'LITERAL_NUMBER' => -11,
			"\@{" => -11,
			"for" => -11,
			'USE' => -11,
			'WORD_UPPERCASE' => -11,
			'MY' => -11,
			'LBRACE' => -11,
			'WORD' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"undef" => -11,
			'OP01_PRINT' => -11,
			'LPAREN' => -11,
			"%{" => -11,
			'OP19_LOOP_CONTROL' => -11
		},
		GOTOS => {
			'Critic' => 60,
			'STAR-5' => 61
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
		ACTIONS => {
			";" => 64
		}
	},
	{#State 51
		DEFAULT => -41
	},
	{#State 52
		DEFAULT => -32
	},
	{#State 53
		ACTIONS => {
			";" => 65
		}
	},
	{#State 54
		DEFAULT => -215
	},
	{#State 55
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 56
		DEFAULT => -216
	},
	{#State 57
		DEFAULT => -214
	},
	{#State 58
		ACTIONS => {
			'OP20_HASH_FATARROW' => 67
		}
	},
	{#State 59
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 68
		}
	},
	{#State 60
		DEFAULT => -8
	},
	{#State 61
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -13,
			"if" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LBRACKET' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			'WORD_SCOPED' => -13,
			'SELF' => -13,
			"our" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"%{" => -13,
			'LPAREN' => -13,
			'OP01_PRINT' => -13,
			"undef" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD' => -13,
			'LBRACE' => -13,
			'MY' => -13,
			'WORD_UPPERCASE' => -13,
			'USE' => 34,
			"for" => -13,
			"\@{" => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_OPEN' => -13,
			"while" => -13,
			"foreach" => -13,
			"use constant" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_CLOSE' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'VARIABLE_SYMBOL' => -13
		},
		GOTOS => {
			'STAR-6' => 70,
			'Include' => 69
		}
	},
	{#State 62
		DEFAULT => -35
	},
	{#State 63
		ACTIONS => {
			"our" => 71
		}
	},
	{#State 64
		DEFAULT => -42
	},
	{#State 65
		DEFAULT => -34
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 72
		}
	},
	{#State 67
		ACTIONS => {
			'MY' => 74
		},
		GOTOS => {
			'TypeInnerConstant' => 73
		}
	},
	{#State 68
		ACTIONS => {
			'USE' => -56,
			"our hashref \$properties" => -56,
			"use constant" => -56,
			"## no critic qw(" => 3
		},
		GOTOS => {
			'STAR-22' => 75,
			'Critic' => 76
		}
	},
	{#State 69
		DEFAULT => -10
	},
	{#State 70
		ACTIONS => {
			'OP01_NAMED' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			"if" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"our" => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LITERAL_STRING' => -15,
			'WORD_SCOPED' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'LBRACKET' => -15,
			'SELF' => -15,
			'WORD' => -15,
			'OP01_NAMED_VOID' => -15,
			'MY' => -15,
			'WORD_UPPERCASE' => -15,
			'LBRACE' => -15,
			'LPAREN' => -15,
			"%{" => -15,
			'OP19_LOOP_CONTROL' => -15,
			"undef" => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_PRINT' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"use constant" => 43,
			"foreach" => -15,
			'VARIABLE_SYMBOL' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP01_CLOSE' => -15,
			"for" => -15,
			"while" => -15,
			'OP01_OPEN' => -15,
			'LITERAL_NUMBER' => -15,
			"\@{" => -15
		},
		GOTOS => {
			'STAR-7' => 77,
			'Constant' => 78
		}
	},
	{#State 71
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 79
		}
	},
	{#State 72
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -45,
			"if" => -45,
			"}" => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP01_NAMED' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'WORD_SCOPED' => -45,
			'LITERAL_STRING' => -45,
			'LBRACKET' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'SELF' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'OP10_NAMED_UNARY' => -45,
			"%{" => -45,
			'LPAREN' => -45,
			'OP19_LOOP_CONTROL' => -45,
			"undef" => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP01_PRINT' => -45,
			'WORD' => -45,
			'OP01_NAMED_VOID' => -45,
			'MY' => -45,
			'WORD_UPPERCASE' => -45,
			'LBRACE' => -45,
			"for" => -45,
			'OP01_OPEN' => -45,
			"while" => -45,
			"\@{" => -45,
			'LITERAL_NUMBER' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'LPAREN_MY' => 80,
			"foreach" => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP01_CLOSE' => -45,
			'CONSTANT_CALL_SCOPED' => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 82,
			'SubroutineArguments' => 81
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'Literal' => 83
		}
	},
	{#State 74
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 54,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 86
		}
	},
	{#State 75
		ACTIONS => {
			'USE' => 34,
			"our hashref \$properties" => -58,
			"use constant" => -58
		},
		GOTOS => {
			'STAR-23' => 87,
			'Include' => 88
		}
	},
	{#State 76
		DEFAULT => -53
	},
	{#State 77
		ACTIONS => {
			"for" => -147,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			"while" => -147,
			"foreach" => -147,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP19_LOOP_CONTROL' => 122,
			"%{" => 120,
			'LPAREN' => 119,
			'OP01_PRINT' => 118,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED_VOID' => 112,
			'WORD' => 28,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 110,
			'MY' => 109,
			'LBRACKET' => 107,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'SELF' => 106,
			"our" => 42,
			'OP10_NAMED_UNARY' => 102,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"if" => 97,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP01_NAMED' => 92,
			'OP19_LOOP_CONTROL_SCOLON' => 89
		},
		GOTOS => {
			'Literal' => 116,
			'LoopLabel' => 117,
			'Statement' => 95,
			'WordScoped' => 96,
			'OPTIONAL-37' => 98,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 91,
			'Variable' => 90,
			'Conditional' => 93,
			'Operation' => 113,
			'Expression' => 131,
			'SubExpression' => 135,
			'OperatorVoid' => 105,
			'VariableDeclaration' => 133,
			'Operator' => 104,
			'HashReference' => 136,
			'ArrayReference' => 123,
			'Subroutine' => 128,
			'VariableModification' => 101,
			'PAREN-36' => 126,
			'HashDereference' => 125,
			'PLUS-8' => 103
		}
	},
	{#State 78
		DEFAULT => -12
	},
	{#State 79
		DEFAULT => -37
	},
	{#State 80
		ACTIONS => {
			'WORD' => 57,
			'WORD_SCOPED' => 54,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 137
		}
	},
	{#State 81
		DEFAULT => -44
	},
	{#State 82
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 138
		}
	},
	{#State 83
		ACTIONS => {
			";" => 139
		}
	},
	{#State 84
		DEFAULT => -228
	},
	{#State 85
		DEFAULT => -229
	},
	{#State 86
		ACTIONS => {
			"\$TYPED_" => 140
		}
	},
	{#State 87
		ACTIONS => {
			"our hashref \$properties" => 143,
			"use constant" => 43
		},
		GOTOS => {
			'Properties' => 142,
			'Constant' => 141
		}
	},
	{#State 88
		DEFAULT => -55
	},
	{#State 89
		DEFAULT => -120
	},
	{#State 90
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP03_MATH_INC_DEC' => 146,
			'OP11_COMPARE_LT_GT' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP02_METHOD_THINARROW' => 144,
			'OP13_BITWISE_AND' => -135,
			'OP18_TERNARY' => -135,
			'OP08_STRING_CAT' => -135,
			")" => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP04_MATH_POW' => -135,
			'OP19_VARIABLE_ASSIGN_BY' => 145,
			'OP07_STRING_REPEAT' => -135,
			'OP19_VARIABLE_ASSIGN' => 147,
			'OP07_MATH_MULT_DIV_MOD' => -135
		}
	},
	{#State 91
		DEFAULT => -137
	},
	{#State 92
		ACTIONS => {
			'LPAREN' => 119,
			"%{" => 120,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'MY' => 151,
			'OP01_QW' => 156,
			'LBRACE' => 111,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'OP03_MATH_INC_DEC' => 130,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102
		},
		GOTOS => {
			'SubExpression' => 149,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'TypeInner' => 153,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ListElement' => 150,
			'ArrayReference' => 123
		}
	},
	{#State 93
		DEFAULT => -148
	},
	{#State 94
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'LBRACE' => 111,
			'OP01_QW' => 156,
			'WORD_UPPERCASE' => 152,
			")" => -113,
			'MY' => 151,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'SubExpression' => 158,
			'Literal' => 116,
			'Operator' => 104,
			'TypeInner' => 153,
			'Expression' => 148,
			'OPTIONAL-33' => 159,
			'ListElements' => 157,
			'ArrayDereference' => 91,
			'ListElement' => 160,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayReference' => 123
		}
	},
	{#State 95
		DEFAULT => -79
	},
	{#State 96
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 161,
			'LPAREN' => 162
		}
	},
	{#State 97
		ACTIONS => {
			'LPAREN' => 163
		}
	},
	{#State 98
		ACTIONS => {
			"while" => 166,
			"for" => 168,
			"foreach" => 169
		},
		GOTOS => {
			'LoopForEach' => 170,
			'LoopFor' => 165,
			'LoopWhile' => 167,
			'Loop' => 164
		}
	},
	{#State 99
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'LPAREN' => 119,
			"%{" => 120,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114
		},
		GOTOS => {
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayReference' => 123,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'SubExpression' => 171,
			'Operator' => 104,
			'Literal' => 116,
			'Expression' => 148
		}
	},
	{#State 100
		ACTIONS => {
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107
		},
		GOTOS => {
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'SubExpression' => 172,
			'Literal' => 116,
			'Operator' => 104,
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125
		}
	},
	{#State 101
		ACTIONS => {
			";" => 173
		}
	},
	{#State 102
		ACTIONS => {
			'OP10_NAMED_UNARY' => 102,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP22_LOGICAL_NEG' => 100,
			'OP17_LIST_RANGE' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'SELF' => 106,
			'OP24_LOGICAL_OR_XOR' => -97,
			'LBRACKET' => 107,
			'OP13_BITWISE_AND' => -97,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			";" => -97,
			"]" => -97,
			'OP01_NAMED' => 154,
			"}" => -97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP08_MATH_ADD_SUB' => -97,
			'VARIABLE_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 130,
			'OP21_LIST_COMMA' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP16_LOGICAL_OR' => -97,
			'OP01_OPEN' => 132,
			'OP06_REGEX_MATCH' => -97,
			'OP15_LOGICAL_AND' => -97,
			'LBRACE' => 111,
			'OP18_TERNARY' => -97,
			'OP08_STRING_CAT' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			")" => -97,
			'WORD_UPPERCASE' => 152,
			'OP04_MATH_POW' => -97,
			'OP23_LOGICAL_AND' => -97,
			'WORD' => 28,
			'OP07_STRING_REPEAT' => -97,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'LPAREN' => 119,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			"%{" => 120
		},
		GOTOS => {
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'Expression' => 148,
			'SubExpression' => 174,
			'Operator' => 104,
			'Literal' => 116,
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 103
		ACTIONS => {
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			"foreach" => -147,
			'OP03_MATH_INC_DEC' => 130,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			"while" => -147,
			"for" => -147,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 110,
			'MY' => 109,
			'OP01_NAMED_VOID' => 112,
			'WORD' => 28,
			'OP01_PRINT' => 118,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP19_LOOP_CONTROL' => 122,
			"%{" => 120,
			'LPAREN' => 119,
			'OP10_NAMED_UNARY' => 102,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 106,
			'LBRACKET' => 107,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'OP19_LOOP_CONTROL_SCOLON' => 89,
			'' => -18,
			'OP01_NAMED' => 92,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP05_MATH_NEG_LPAREN' => 99,
			"if" => 97
		},
		GOTOS => {
			'Expression' => 131,
			'SubExpression' => 135,
			'VariableDeclaration' => 133,
			'OperatorVoid' => 105,
			'Operator' => 104,
			'HashReference' => 136,
			'ArrayReference' => 123,
			'VariableModification' => 101,
			'HashDereference' => 125,
			'PAREN-36' => 126,
			'LoopLabel' => 117,
			'Literal' => 116,
			'WordScoped' => 96,
			'Statement' => 95,
			'OPTIONAL-37' => 98,
			'VariableSymbolOrSelf' => 121,
			'ArrayDereference' => 91,
			'Variable' => 90,
			'Conditional' => 93,
			'Operation' => 175
		}
	},
	{#State 104
		DEFAULT => -126
	},
	{#State 105
		DEFAULT => -150
	},
	{#State 106
		DEFAULT => -227
	},
	{#State 107
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'WORD_UPPERCASE' => 152,
			'MY' => 151,
			'OP01_QW' => 156,
			'LBRACE' => 111,
			"]" => -191,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 158,
			'Expression' => 148,
			'TypeInner' => 153,
			'OPTIONAL-46' => 176,
			'ListElements' => 177,
			'ListElement' => 160,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123
		}
	},
	{#State 108
		DEFAULT => -116
	},
	{#State 109
		ACTIONS => {
			'WORD_SCOPED' => 54,
			'WORD' => 57,
			'TYPE_FHREF' => 179,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 178
		}
	},
	{#State 110
		ACTIONS => {
			'COLON' => -213,
			'LPAREN' => 180
		}
	},
	{#State 111
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"}" => 182,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			"%{" => 120,
			'WORD' => 186,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'VariableOrLiteralOrWord' => 184,
			'HashDereference' => 187,
			'Literal' => 185,
			'HashEntry' => 181,
			'Variable' => 183
		}
	},
	{#State 112
		ACTIONS => {
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119,
			'OP01_QW' => 156,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'MY' => 151,
			'WORD' => 28,
			'OP01_NAMED' => 154
		},
		GOTOS => {
			'SubExpression' => 158,
			'Operator' => 104,
			'Literal' => 116,
			'Expression' => 148,
			'TypeInner' => 153,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ListElement' => 160,
			'ArrayReference' => 123,
			'ListElements' => 188
		}
	},
	{#State 113
		DEFAULT => -17
	},
	{#State 114
		DEFAULT => -133
	},
	{#State 115
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'LPAREN' => 119,
			"%{" => 120,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'Expression' => 148,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 189,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91
		}
	},
	{#State 116
		DEFAULT => -134
	},
	{#State 117
		ACTIONS => {
			'COLON' => 190
		}
	},
	{#State 118
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -111,
			'VARIABLE_SYMBOL' => -111,
			'OP10_NAMED_UNARY' => -111,
			'OP01_CLOSE' => -111,
			'CONSTANT_CALL_SCOPED' => -111,
			'OP03_MATH_INC_DEC' => -111,
			'OP01_OPEN' => -111,
			"\@{" => -111,
			'SELF' => -111,
			'LITERAL_NUMBER' => -111,
			'LITERAL_STRING' => -111,
			'WORD_SCOPED' => -111,
			'LBRACKET' => -111,
			'MY' => -111,
			'WORD_UPPERCASE' => -111,
			'LBRACE' => -111,
			'OP01_QW' => -111,
			'FHREF_SYMBOL_BRACES' => 191,
			'WORD' => -111,
			'OP01_NAMED' => -111,
			"undef" => -111,
			'OP05_LOGICAL_NEG' => -111,
			'STDOUT_STDERR' => 194,
			"%{" => -111,
			'LPAREN' => -111,
			'OP05_MATH_NEG_LPAREN' => -111
		},
		GOTOS => {
			'OPTIONAL-32' => 192,
			'PAREN-31' => 193
		}
	},
	{#State 119
		ACTIONS => {
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'WORD' => 28,
			'OP01_NAMED' => 195,
			'OP01_PRINT' => 196,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119
		},
		GOTOS => {
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 197,
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91
		}
	},
	{#State 120
		ACTIONS => {
			'MY' => 151,
			'VARIABLE_SYMBOL' => 124,
			'LBRACE' => -208,
			'SELF' => 106
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'TypeInner' => 199,
			'OPTIONAL-51' => 200,
			'Variable' => 198
		}
	},
	{#State 121
		DEFAULT => -172,
		GOTOS => {
			'STAR-43' => 201
		}
	},
	{#State 122
		ACTIONS => {
			'WORD_UPPERCASE' => 202
		},
		GOTOS => {
			'LoopLabel' => 203
		}
	},
	{#State 123
		DEFAULT => -136
	},
	{#State 124
		DEFAULT => -226
	},
	{#State 125
		DEFAULT => -139
	},
	{#State 126
		DEFAULT => -146
	},
	{#State 127
		DEFAULT => -128
	},
	{#State 128
		DEFAULT => -14
	},
	{#State 129
		ACTIONS => {
			'FHREF_SYMBOL' => 204
		}
	},
	{#State 130
		ACTIONS => {
			'SELF' => 106,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'Variable' => 205,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 131
		ACTIONS => {
			'OP23_LOGICAL_AND' => -132,
			'OP04_MATH_POW' => -132,
			'OP18_TERNARY' => -132,
			";" => 206,
			'OP08_STRING_CAT' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP16_LOGICAL_OR' => -132
		}
	},
	{#State 132
		ACTIONS => {
			'MY' => 207
		}
	},
	{#State 133
		DEFAULT => -151
	},
	{#State 134
		ACTIONS => {
			'LBRACKET' => -194,
			'MY' => 151,
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 106
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'TypeInner' => 209,
			'OPTIONAL-47' => 210,
			'Variable' => 208
		}
	},
	{#State 135
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			'OP18_TERNARY' => 222,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227
		}
	},
	{#State 136
		DEFAULT => -138
	},
	{#State 137
		ACTIONS => {
			'VARIABLE_SYMBOL' => 228
		}
	},
	{#State 138
		ACTIONS => {
			'OP01_NAMED_VOID' => 112,
			'WORD' => 28,
			'LBRACE' => 111,
			'MY' => 109,
			'WORD_UPPERCASE' => 110,
			'OP19_LOOP_CONTROL' => 122,
			"%{" => 120,
			'LPAREN' => 119,
			'OP01_PRINT' => 118,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"foreach" => -147,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			"for" => -147,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			"while" => -147,
			'OP01_NAMED' => 92,
			'OP19_LOOP_CONTROL_SCOLON' => 89,
			'OP05_MATH_NEG_LPAREN' => 99,
			"if" => 97,
			"}" => 229,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP10_NAMED_UNARY' => 102,
			'OP22_LOGICAL_NEG' => 100,
			'LBRACKET' => 107,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'SELF' => 106
		},
		GOTOS => {
			'Literal' => 116,
			'LoopLabel' => 117,
			'VariableSymbolOrSelf' => 121,
			'OPTIONAL-37' => 98,
			'WordScoped' => 96,
			'Statement' => 95,
			'Variable' => 90,
			'ArrayDereference' => 91,
			'Operation' => 230,
			'Conditional' => 93,
			'Operator' => 104,
			'VariableDeclaration' => 133,
			'SubExpression' => 135,
			'OperatorVoid' => 105,
			'Expression' => 131,
			'HashReference' => 136,
			'HashDereference' => 125,
			'PAREN-36' => 126,
			'VariableModification' => 101,
			'ArrayReference' => 123
		}
	},
	{#State 139
		DEFAULT => -43
	},
	{#State 140
		ACTIONS => {
			'WORD_UPPERCASE' => 231
		}
	},
	{#State 141
		DEFAULT => -57
	},
	{#State 142
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 232
		}
	},
	{#State 143
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 233
		}
	},
	{#State 144
		ACTIONS => {
			'LPAREN' => 234
		}
	},
	{#State 145
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'LPAREN' => 119,
			"%{" => 120,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayReference' => 123,
			'SubExpression' => 235,
			'Operator' => 104,
			'Literal' => 116,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96
		}
	},
	{#State 146
		DEFAULT => -86
	},
	{#State 147
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'STDIN' => 237,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 130,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 154,
			'WORD' => 28
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'SubExpression' => 238,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'SubExpressionOrStdin' => 236,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayReference' => 123
		}
	},
	{#State 148
		DEFAULT => -132
	},
	{#State 149
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP04_MATH_POW' => -81,
			'OP23_LOGICAL_AND' => -81,
			";" => -81,
			'OP18_TERNARY' => -81,
			")" => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP08_STRING_CAT' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP21_LIST_COMMA' => -187,
			'OP16_LOGICAL_OR' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP17_LIST_RANGE' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP14_BITWISE_OR_XOR' => -81
		}
	},
	{#State 150
		ACTIONS => {
			'OP21_LIST_COMMA' => 239
		}
	},
	{#State 151
		ACTIONS => {
			'WORD' => 57,
			'WORD_SCOPED' => 54,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 240
		}
	},
	{#State 152
		ACTIONS => {
			'LPAREN' => 180
		}
	},
	{#State 153
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114
		},
		GOTOS => {
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125,
			'Expression' => 148,
			'SubExpression' => 241,
			'Operator' => 104,
			'Literal' => 116,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 154
		ACTIONS => {
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 130,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119
		},
		GOTOS => {
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayReference' => 123,
			'SubExpression' => 242,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136
		}
	},
	{#State 155
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP03_MATH_INC_DEC' => 146,
			'OP21_LIST_COMMA' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP02_METHOD_THINARROW' => 144,
			";" => -135,
			'OP18_TERNARY' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP08_STRING_CAT' => -135,
			")" => -135,
			'OP04_MATH_POW' => -135,
			'OP23_LOGICAL_AND' => -135,
			"]" => -135,
			"}" => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135
		}
	},
	{#State 156
		DEFAULT => -189
	},
	{#State 157
		DEFAULT => -112
	},
	{#State 158
		ACTIONS => {
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP21_LIST_COMMA' => -187,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => 212,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			'OP23_LOGICAL_AND' => 219,
			'OP04_MATH_POW' => 218,
			"]" => -187,
			'OP18_TERNARY' => 222,
			";" => -187,
			'OP08_STRING_CAT' => 221,
			")" => -187,
			'OP09_BITWISE_SHIFT' => 220
		}
	},
	{#State 159
		ACTIONS => {
			")" => 243
		}
	},
	{#State 160
		DEFAULT => -185,
		GOTOS => {
			'STAR-45' => 244
		}
	},
	{#State 161
		ACTIONS => {
			")" => 245
		}
	},
	{#State 162
		ACTIONS => {
			'OP01_NAMED' => 154,
			'WORD' => 28,
			")" => -123,
			'WORD_UPPERCASE' => 152,
			'MY' => 151,
			'LBRACE' => 111,
			'OP01_QW' => 156,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 130,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'ListElements' => 246,
			'Variable' => 155,
			'HashDereference' => 125,
			'ListElement' => 160,
			'ArrayDereference' => 91,
			'ArrayReference' => 123,
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'Literal' => 116,
			'Operator' => 104,
			'OPTIONAL-34' => 247,
			'SubExpression' => 158,
			'Expression' => 148,
			'TypeInner' => 153
		}
	},
	{#State 163
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'LPAREN' => 119,
			"%{" => 120,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 248,
			'Expression' => 148
		}
	},
	{#State 164
		DEFAULT => -149
	},
	{#State 165
		DEFAULT => -160
	},
	{#State 166
		ACTIONS => {
			'LPAREN' => 249,
			'LPAREN_MY' => 250
		}
	},
	{#State 167
		DEFAULT => -162
	},
	{#State 168
		ACTIONS => {
			'MY' => 251,
			'LPAREN_MY' => 252
		}
	},
	{#State 169
		ACTIONS => {
			'MY' => 253
		}
	},
	{#State 170
		DEFAULT => -161
	},
	{#State 171
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			'OP18_TERNARY' => 222,
			'OP09_BITWISE_SHIFT' => 220,
			")" => 254,
			'OP08_STRING_CAT' => 221,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227
		}
	},
	{#State 172
		ACTIONS => {
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => -106,
			"]" => -106,
			'OP18_TERNARY' => 222,
			";" => -106,
			")" => -106,
			'OP08_STRING_CAT' => 221,
			'OP09_BITWISE_SHIFT' => 220,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			"}" => -106,
			'OP07_STRING_REPEAT' => 217,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP21_LIST_COMMA' => -106,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP06_REGEX_MATCH' => 213
		}
	},
	{#State 173
		DEFAULT => -152
	},
	{#State 174
		ACTIONS => {
			'OP17_LIST_RANGE' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP06_REGEX_MATCH' => 213,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => -96,
			"]" => -96,
			'OP18_TERNARY' => -96,
			";" => -96,
			'OP09_BITWISE_SHIFT' => 220,
			")" => -96,
			'OP08_STRING_CAT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			"}" => -96,
			'OP07_STRING_REPEAT' => 217
		}
	},
	{#State 175
		DEFAULT => -16
	},
	{#State 176
		ACTIONS => {
			"]" => 255
		}
	},
	{#State 177
		DEFAULT => -190
	},
	{#State 178
		ACTIONS => {
			'VARIABLE_SYMBOL' => 256
		}
	},
	{#State 179
		ACTIONS => {
			'FHREF_SYMBOL' => 257
		}
	},
	{#State 180
		ACTIONS => {
			")" => 258
		}
	},
	{#State 181
		DEFAULT => -204,
		GOTOS => {
			'STAR-50' => 259
		}
	},
	{#State 182
		DEFAULT => -206
	},
	{#State 183
		DEFAULT => -223
	},
	{#State 184
		ACTIONS => {
			'OP20_HASH_FATARROW' => 260
		}
	},
	{#State 185
		DEFAULT => -224
	},
	{#State 186
		DEFAULT => -225
	},
	{#State 187
		DEFAULT => -200
	},
	{#State 188
		ACTIONS => {
			";" => 261
		}
	},
	{#State 189
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -88,
			"}" => -88,
			'OP07_STRING_REPEAT' => -88,
			'OP23_LOGICAL_AND' => -88,
			'OP04_MATH_POW' => 218,
			"]" => -88,
			";" => -88,
			'OP18_TERNARY' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			")" => -88,
			'OP08_STRING_CAT' => -88,
			'OP15_LOGICAL_AND' => -88,
			'OP13_BITWISE_AND' => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			'OP21_LIST_COMMA' => -88,
			'OP06_REGEX_MATCH' => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			'OP16_LOGICAL_OR' => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP17_LIST_RANGE' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP14_BITWISE_OR_XOR' => -88
		}
	},
	{#State 190
		DEFAULT => -145
	},
	{#State 191
		ACTIONS => {
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'WORD_UPPERCASE' => 152,
			'MY' => 151,
			'OP01_QW' => 156,
			'LBRACE' => 111,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP03_MATH_INC_DEC' => 130,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134
		},
		GOTOS => {
			'ListElements' => 262,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125,
			'ListElement' => 160,
			'ArrayReference' => 123,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'SubExpression' => 158,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'TypeInner' => 153
		}
	},
	{#State 192
		ACTIONS => {
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			'OP03_MATH_INC_DEC' => 130,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'OP01_QW' => 156,
			'LBRACE' => 111,
			'MY' => 151,
			'WORD_UPPERCASE' => 152
		},
		GOTOS => {
			'Expression' => 148,
			'TypeInner' => 153,
			'SubExpression' => 158,
			'Operator' => 104,
			'Literal' => 116,
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121,
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'ListElement' => 160,
			'HashDereference' => 125,
			'ListElements' => 263
		}
	},
	{#State 193
		DEFAULT => -110
	},
	{#State 194
		DEFAULT => -109
	},
	{#State 195
		ACTIONS => {
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			'OP01_QW' => 156,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'MY' => 151,
			'WORD' => 28,
			'OP01_NAMED' => 154
		},
		GOTOS => {
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ListElement' => 264,
			'Expression' => 148,
			'TypeInner' => 153,
			'SubExpression' => 149,
			'Literal' => 116,
			'Operator' => 104,
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 196
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 265
		}
	},
	{#State 197
		ACTIONS => {
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP18_TERNARY' => 222,
			'OP08_STRING_CAT' => 221,
			")" => 266,
			'OP09_BITWISE_SHIFT' => 220,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226
		}
	},
	{#State 198
		ACTIONS => {
			"}" => 267
		}
	},
	{#State 199
		DEFAULT => -207
	},
	{#State 200
		ACTIONS => {
			'LBRACE' => 111
		},
		GOTOS => {
			'HashReference' => 268
		}
	},
	{#State 201
		ACTIONS => {
			";" => -173,
			'OP18_TERNARY' => -173,
			")" => -173,
			'OP08_STRING_CAT' => -173,
			'OP09_BITWISE_SHIFT' => -173,
			'OP23_LOGICAL_AND' => -173,
			'OP04_MATH_POW' => -173,
			'OP19_VARIABLE_ASSIGN_BY' => -173,
			'OP02_HASH_THINARROW' => 271,
			"]" => -173,
			"}" => -173,
			'OP07_STRING_REPEAT' => -173,
			'OP19_VARIABLE_ASSIGN' => -173,
			'OP07_MATH_MULT_DIV_MOD' => -173,
			'OP08_MATH_ADD_SUB' => -173,
			'OP02_ARRAY_THINARROW' => 270,
			'OP14_BITWISE_OR_XOR' => -173,
			'OP03_MATH_INC_DEC' => -173,
			'OP11_COMPARE_LT_GT' => -173,
			'OP17_LIST_RANGE' => -173,
			'OP12_COMPARE_EQ_NE' => -173,
			'OP21_LIST_COMMA' => -173,
			'OP24_LOGICAL_OR_XOR' => -173,
			'OP06_REGEX_MATCH' => -173,
			'OP16_LOGICAL_OR' => -173,
			'OP15_LOGICAL_AND' => -173,
			'COLON' => -173,
			'OP20_HASH_FATARROW' => -173,
			'OP02_METHOD_THINARROW' => -173,
			'OP13_BITWISE_AND' => -173
		},
		GOTOS => {
			'VariableRetrieval' => 269
		}
	},
	{#State 202
		DEFAULT => -213
	},
	{#State 203
		ACTIONS => {
			";" => 272
		}
	},
	{#State 204
		DEFAULT => -84
	},
	{#State 205
		DEFAULT => -85
	},
	{#State 206
		DEFAULT => -78
	},
	{#State 207
		ACTIONS => {
			'TYPE_FHREF' => 273
		}
	},
	{#State 208
		ACTIONS => {
			"}" => 274
		}
	},
	{#State 209
		DEFAULT => -193
	},
	{#State 210
		ACTIONS => {
			'LBRACKET' => 107
		},
		GOTOS => {
			'ArrayReference' => 275
		}
	},
	{#State 211
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'OP01_OPEN' => 132,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'SubExpression' => 276,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayReference' => 123
		}
	},
	{#State 212
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'SubExpression' => 277,
			'Operator' => 104,
			'Literal' => 116
		}
	},
	{#State 213
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 278
		}
	},
	{#State 214
		ACTIONS => {
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107
		},
		GOTOS => {
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayReference' => 123,
			'SubExpression' => 279,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96
		}
	},
	{#State 215
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'SubExpression' => 280,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayReference' => 123
		}
	},
	{#State 216
		ACTIONS => {
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 130,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			'OP01_OPEN' => 132
		},
		GOTOS => {
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91,
			'ArrayReference' => 123,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 281,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136
		}
	},
	{#State 217
		ACTIONS => {
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'WORD' => 28,
			'OP01_NAMED' => 154
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 282,
			'Expression' => 148,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91,
			'ArrayReference' => 123
		}
	},
	{#State 218
		ACTIONS => {
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'OP03_MATH_INC_DEC' => 130,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127
		},
		GOTOS => {
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'SubExpression' => 283,
			'Operator' => 104,
			'Literal' => 116,
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155
		}
	},
	{#State 219
		ACTIONS => {
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'OP01_OPEN' => 132,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152
		},
		GOTOS => {
			'Expression' => 148,
			'SubExpression' => 284,
			'Literal' => 116,
			'Operator' => 104,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155
		}
	},
	{#State 220
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 130,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 285,
			'Expression' => 148,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91,
			'ArrayReference' => 123
		}
	},
	{#State 221
		ACTIONS => {
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 154,
			'WORD' => 28
		},
		GOTOS => {
			'Expression' => 148,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 286,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91
		}
	},
	{#State 222
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'VariableOrLiteral' => 288,
			'Variable' => 289,
			'Literal' => 287
		}
	},
	{#State 223
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120
		},
		GOTOS => {
			'Expression' => 148,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 290,
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121,
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91
		}
	},
	{#State 224
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			"\@{" => 134,
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111
		},
		GOTOS => {
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 291,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96
		}
	},
	{#State 225
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'LPAREN' => 119,
			"%{" => 120,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 292,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123
		}
	},
	{#State 226
		ACTIONS => {
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 130,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'WORD' => 28,
			'OP01_NAMED' => 154
		},
		GOTOS => {
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 293
		}
	},
	{#State 227
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120
		},
		GOTOS => {
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'SubExpression' => 294,
			'Literal' => 116,
			'Operator' => 104
		}
	},
	{#State 228
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 295
		}
	},
	{#State 229
		ACTIONS => {
			";" => 296
		}
	},
	{#State 230
		DEFAULT => -46
	},
	{#State 231
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 297
		}
	},
	{#State 232
		ACTIONS => {
			"our" => 301,
			'LITERAL_NUMBER' => 299
		},
		GOTOS => {
			'Subroutine' => 298,
			'MethodOrSubroutine' => 302,
			'Method' => 300
		}
	},
	{#State 233
		ACTIONS => {
			'LBRACE' => 303
		}
	},
	{#State 234
		ACTIONS => {
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'OP01_QW' => 156,
			'LBRACE' => 111,
			'MY' => 151,
			")" => -125,
			'WORD_UPPERCASE' => 152,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP01_OPEN' => 132
		},
		GOTOS => {
			'ListElement' => 160,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123,
			'ListElements' => 304,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 158,
			'TypeInner' => 153,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'OPTIONAL-35' => 305,
			'HashReference' => 136,
			'WordScoped' => 96
		}
	},
	{#State 235
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			'OP23_LOGICAL_AND' => 219,
			'OP04_MATH_POW' => 218,
			'OP18_TERNARY' => 222,
			";" => -182,
			")" => -182,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 212,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227
		}
	},
	{#State 236
		DEFAULT => -181
	},
	{#State 237
		DEFAULT => -142
	},
	{#State 238
		ACTIONS => {
			'OP18_TERNARY' => 222,
			";" => -141,
			'OP08_STRING_CAT' => 221,
			")" => -141,
			'OP09_BITWISE_SHIFT' => 220,
			'OP23_LOGICAL_AND' => 219,
			'OP04_MATH_POW' => 218,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => 212,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223
		}
	},
	{#State 239
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			"\@{" => 134,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'MY' => 151,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_QW' => 156,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114
		},
		GOTOS => {
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ListElement' => 160,
			'ArrayDereference' => 91,
			'ListElements' => 306,
			'TypeInner' => 153,
			'Expression' => 148,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 158,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 240
		ACTIONS => {
			"\$TYPED_" => 307
		}
	},
	{#State 241
		ACTIONS => {
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP21_LIST_COMMA' => -188,
			"]" => -188,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			")" => -188,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			";" => -188,
			'OP18_TERNARY' => 222,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217
		}
	},
	{#State 242
		ACTIONS => {
			'OP21_LIST_COMMA' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP17_LIST_RANGE' => -81,
			"}" => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			";" => -81,
			'OP18_TERNARY' => -81,
			")" => -81,
			'OP08_STRING_CAT' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP04_MATH_POW' => -81,
			"]" => -81
		}
	},
	{#State 243
		ACTIONS => {
			";" => 308
		}
	},
	{#State 244
		ACTIONS => {
			"]" => -186,
			")" => -186,
			";" => -186,
			'OP21_LIST_COMMA' => 310
		},
		GOTOS => {
			'PAREN-44' => 309
		}
	},
	{#State 245
		DEFAULT => -131
	},
	{#State 246
		DEFAULT => -122
	},
	{#State 247
		ACTIONS => {
			")" => 311
		}
	},
	{#State 248
		ACTIONS => {
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP09_BITWISE_SHIFT' => 220,
			")" => 312,
			'OP08_STRING_CAT' => 221,
			'OP18_TERNARY' => 222,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			'OP16_LOGICAL_OR' => 212,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226
		}
	},
	{#State 249
		ACTIONS => {
			'LPAREN' => 119,
			"%{" => 120,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			"\@{" => 134,
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102
		},
		GOTOS => {
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 313,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123
		}
	},
	{#State 250
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD' => 57,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 314
		}
	},
	{#State 251
		ACTIONS => {
			'TYPE_INTEGER' => 315
		}
	},
	{#State 252
		ACTIONS => {
			'TYPE_INTEGER' => 316
		}
	},
	{#State 253
		ACTIONS => {
			'WORD' => 57,
			'WORD_SCOPED' => 54,
			'TYPE_INTEGER' => 56
		},
		GOTOS => {
			'Type' => 317
		}
	},
	{#State 254
		DEFAULT => -89
	},
	{#State 255
		DEFAULT => -192
	},
	{#State 256
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 320,
			'OP02_ARRAY_THINARROW' => 318,
			";" => 319
		}
	},
	{#State 257
		ACTIONS => {
			";" => 321
		}
	},
	{#State 258
		DEFAULT => -127
	},
	{#State 259
		ACTIONS => {
			"}" => 323,
			'OP21_LIST_COMMA' => 324
		},
		GOTOS => {
			'PAREN-49' => 322
		}
	},
	{#State 260
		ACTIONS => {
			'LBRACE' => -198,
			'MY' => 151,
			'WORD_UPPERCASE' => -198,
			'OP01_NAMED' => -198,
			'WORD' => -198,
			"undef" => -198,
			'OP05_LOGICAL_NEG' => -198,
			'OP05_MATH_NEG_LPAREN' => -198,
			"%{" => -198,
			'LPAREN' => -198,
			'OP01_CLOSE' => -198,
			'OP10_NAMED_UNARY' => -198,
			'CONSTANT_CALL_SCOPED' => -198,
			'VARIABLE_SYMBOL' => -198,
			'OP22_LOGICAL_NEG' => -198,
			'OP03_MATH_INC_DEC' => -198,
			'LITERAL_NUMBER' => -198,
			'SELF' => -198,
			"\@{" => -198,
			'OP01_OPEN' => -198,
			'LBRACKET' => -198,
			'LITERAL_STRING' => -198,
			'WORD_SCOPED' => -198
		},
		GOTOS => {
			'TypeInner' => 325,
			'OPTIONAL-48' => 326
		}
	},
	{#State 261
		DEFAULT => -118
	},
	{#State 262
		ACTIONS => {
			";" => 327
		}
	},
	{#State 263
		ACTIONS => {
			";" => 328
		}
	},
	{#State 264
		ACTIONS => {
			'OP21_LIST_COMMA' => 329
		}
	},
	{#State 265
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'MY' => 151,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_QW' => 156
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'SubExpression' => 158,
			'Operator' => 104,
			'Literal' => 116,
			'TypeInner' => 153,
			'Expression' => 148,
			'ListElements' => 330,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'ListElement' => 160,
			'Variable' => 155,
			'ArrayReference' => 123
		}
	},
	{#State 266
		DEFAULT => -140
	},
	{#State 267
		DEFAULT => -209
	},
	{#State 268
		ACTIONS => {
			"}" => 331
		}
	},
	{#State 269
		DEFAULT => -171
	},
	{#State 270
		ACTIONS => {
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 154,
			'WORD' => 28
		},
		GOTOS => {
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'Expression' => 148,
			'SubExpression' => 332,
			'Operator' => 104,
			'Literal' => 116,
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 271
		ACTIONS => {
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 154,
			'WORD' => 334
		},
		GOTOS => {
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'SubExpression' => 333,
			'Operator' => 104,
			'Literal' => 116,
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155
		}
	},
	{#State 272
		DEFAULT => -121
	},
	{#State 273
		ACTIONS => {
			'FHREF_SYMBOL' => 335
		}
	},
	{#State 274
		DEFAULT => -195
	},
	{#State 275
		ACTIONS => {
			"}" => 336
		}
	},
	{#State 276
		ACTIONS => {
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP06_REGEX_MATCH' => 213,
			'OP21_LIST_COMMA' => -102,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP17_LIST_RANGE' => -102,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			"}" => -102,
			"]" => -102,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => -102,
			")" => -102,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP18_TERNARY' => -102,
			";" => -102
		}
	},
	{#State 277
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 220,
			")" => -103,
			'OP08_STRING_CAT' => 221,
			'OP18_TERNARY' => -103,
			";" => -103,
			"]" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP04_MATH_POW' => 218,
			'OP07_STRING_REPEAT' => 217,
			"}" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => -103,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211
		}
	},
	{#State 278
		DEFAULT => -90
	},
	{#State 279
		ACTIONS => {
			'OP13_BITWISE_AND' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP17_LIST_RANGE' => -99,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP08_MATH_ADD_SUB' => 215,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			"}" => -99,
			"]" => -99,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => -99,
			'OP08_STRING_CAT' => 221,
			")" => -99,
			'OP09_BITWISE_SHIFT' => 220,
			'OP18_TERNARY' => -99,
			";" => -99
		}
	},
	{#State 280
		ACTIONS => {
			'OP21_LIST_COMMA' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP17_LIST_RANGE' => -93,
			"}" => -93,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			";" => -93,
			'OP18_TERNARY' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			")" => -93,
			'OP08_STRING_CAT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP04_MATH_POW' => 218,
			"]" => -93
		}
	},
	{#State 281
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP07_STRING_REPEAT' => 217,
			"}" => -92,
			"]" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP04_MATH_POW' => 218,
			")" => -92,
			'OP08_STRING_CAT' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP18_TERNARY' => -92,
			";" => -92,
			'OP13_BITWISE_AND' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP08_MATH_ADD_SUB' => -92
		}
	},
	{#State 282
		ACTIONS => {
			"]" => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP04_MATH_POW' => 218,
			'OP09_BITWISE_SHIFT' => -91,
			")" => -91,
			'OP08_STRING_CAT' => -91,
			";" => -91,
			'OP18_TERNARY' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP07_STRING_REPEAT' => -91,
			"}" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP12_COMPARE_EQ_NE' => -91
		}
	},
	{#State 283
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -87,
			"}" => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP04_MATH_POW' => 218,
			"]" => -87,
			";" => -87,
			'OP18_TERNARY' => -87,
			'OP08_STRING_CAT' => -87,
			")" => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP15_LOGICAL_AND' => -87,
			'OP13_BITWISE_AND' => -87,
			'OP12_COMPARE_EQ_NE' => -87,
			'OP21_LIST_COMMA' => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP06_REGEX_MATCH' => -87,
			'OP16_LOGICAL_OR' => -87,
			'OP11_COMPARE_LT_GT' => -87,
			'OP17_LIST_RANGE' => -87,
			'OP08_MATH_ADD_SUB' => -87,
			'OP14_BITWISE_OR_XOR' => -87
		}
	},
	{#State 284
		ACTIONS => {
			")" => -107,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP18_TERNARY' => 222,
			";" => -107,
			"]" => -107,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => -107,
			'OP07_STRING_REPEAT' => 217,
			"}" => -107,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP06_REGEX_MATCH' => 213,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP21_LIST_COMMA' => -107,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211
		}
	},
	{#State 285
		ACTIONS => {
			'OP15_LOGICAL_AND' => -95,
			'OP13_BITWISE_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			"}" => -95,
			'OP07_STRING_REPEAT' => 217,
			'OP23_LOGICAL_AND' => -95,
			'OP04_MATH_POW' => 218,
			"]" => -95,
			";" => -95,
			'OP18_TERNARY' => -95,
			")" => -95,
			'OP08_STRING_CAT' => 221,
			'OP09_BITWISE_SHIFT' => -95
		}
	},
	{#State 286
		ACTIONS => {
			"]" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP04_MATH_POW' => 218,
			'OP09_BITWISE_SHIFT' => -94,
			")" => -94,
			'OP08_STRING_CAT' => -94,
			";" => -94,
			'OP18_TERNARY' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			"}" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP08_MATH_ADD_SUB' => 215,
			'OP13_BITWISE_AND' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP12_COMPARE_EQ_NE' => -94
		}
	},
	{#State 287
		DEFAULT => -222
	},
	{#State 288
		ACTIONS => {
			'COLON' => 337
		}
	},
	{#State 289
		DEFAULT => -221
	},
	{#State 290
		ACTIONS => {
			'OP17_LIST_RANGE' => -100,
			'OP11_COMPARE_LT_GT' => 226,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP08_MATH_ADD_SUB' => 215,
			'OP13_BITWISE_AND' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP06_REGEX_MATCH' => 213,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => 214,
			"]" => -100,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => -100,
			'OP09_BITWISE_SHIFT' => 220,
			")" => -100,
			'OP08_STRING_CAT' => 221,
			";" => -100,
			'OP18_TERNARY' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			"}" => -100
		}
	},
	{#State 291
		ACTIONS => {
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP21_LIST_COMMA' => -108,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP06_REGEX_MATCH' => 213,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			"}" => -108,
			'OP07_STRING_REPEAT' => 217,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			"]" => -108,
			";" => -108,
			'OP18_TERNARY' => 222,
			")" => -108,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221
		}
	},
	{#State 292
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			"}" => -104,
			"]" => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP04_MATH_POW' => 218,
			'OP08_STRING_CAT' => 221,
			")" => -104,
			'OP09_BITWISE_SHIFT' => 220,
			'OP18_TERNARY' => -104,
			";" => -104,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => 212,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP21_LIST_COMMA' => -104,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215
		}
	},
	{#State 293
		ACTIONS => {
			'OP07_STRING_REPEAT' => 217,
			"}" => -98,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_STRING_CAT' => 221,
			")" => -98,
			'OP09_BITWISE_SHIFT' => 220,
			";" => -98,
			'OP18_TERNARY' => -98,
			"]" => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 218,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 215,
			'OP11_COMPARE_LT_GT' => undef,
			'OP17_LIST_RANGE' => -98
		}
	},
	{#State 294
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => -101,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP21_LIST_COMMA' => -101,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => -101,
			")" => -101,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP18_TERNARY' => -101,
			";" => -101,
			"]" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP04_MATH_POW' => 218,
			'OP07_STRING_REPEAT' => 217,
			"}" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 216
		}
	},
	{#State 295
		ACTIONS => {
			")" => 339,
			'OP21_LIST_COMMA' => 338
		},
		GOTOS => {
			'PAREN-19' => 340
		}
	},
	{#State 296
		DEFAULT => -48
	},
	{#State 297
		DEFAULT => -220
	},
	{#State 298
		DEFAULT => -77
	},
	{#State 299
		ACTIONS => {
			";" => 341
		}
	},
	{#State 300
		DEFAULT => -76
	},
	{#State 301
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'TYPE_METHOD' => 342,
			'WORD' => 57,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 55
		}
	},
	{#State 302
		DEFAULT => -59
	},
	{#State 303
		ACTIONS => {
			"}" => 345,
			'WORD' => 344
		},
		GOTOS => {
			'HashEntryProperties' => 343
		}
	},
	{#State 304
		DEFAULT => -124
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
		ACTIONS => {
			'WORD' => 348
		}
	},
	{#State 308
		DEFAULT => -117
	},
	{#State 309
		DEFAULT => -184
	},
	{#State 310
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'WORD_UPPERCASE' => 152,
			'MY' => 151,
			'LBRACE' => 111,
			'OP01_QW' => 156
		},
		GOTOS => {
			'ArrayDereference' => 91,
			'ListElement' => 349,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayReference' => 123,
			'SubExpression' => 158,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'TypeInner' => 153,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96
		}
	},
	{#State 311
		DEFAULT => -129
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 351
		},
		GOTOS => {
			'CodeBlock' => 350
		}
	},
	{#State 313
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => 212,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP18_TERNARY' => 222,
			'OP08_STRING_CAT' => 221,
			'OP09_BITWISE_SHIFT' => 220,
			")" => 352,
			'OP23_LOGICAL_AND' => 219,
			'OP04_MATH_POW' => 218,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216
		}
	},
	{#State 314
		ACTIONS => {
			'VARIABLE_SYMBOL' => 353
		}
	},
	{#State 315
		ACTIONS => {
			'VARIABLE_SYMBOL' => 354
		}
	},
	{#State 316
		ACTIONS => {
			'VARIABLE_SYMBOL' => 355
		}
	},
	{#State 317
		ACTIONS => {
			'VARIABLE_SYMBOL' => 356
		}
	},
	{#State 318
		ACTIONS => {
			'OP01_OPEN' => 132,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP03_MATH_INC_DEC' => 130,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_NAMED' => 154,
			'WORD' => 28
		},
		GOTOS => {
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 357,
			'Expression' => 148,
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136
		}
	},
	{#State 319
		DEFAULT => -177
	},
	{#State 320
		ACTIONS => {
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP05_MATH_NEG_LPAREN' => 99,
			"%{" => 120,
			'LPAREN' => 119,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'LBRACKET' => 107,
			'STDIN' => 237,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP01_OPEN' => 132
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 238,
			'Expression' => 148,
			'SubExpressionOrStdin' => 358,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91,
			'ArrayReference' => 123
		}
	},
	{#State 321
		DEFAULT => -180
	},
	{#State 322
		DEFAULT => -203
	},
	{#State 323
		DEFAULT => -205
	},
	{#State 324
		ACTIONS => {
			'WORD' => 186,
			'LITERAL_STRING' => 85,
			"%{" => 120,
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 184,
			'VariableSymbolOrSelf' => 121,
			'Literal' => 185,
			'Variable' => 183,
			'HashEntry' => 359,
			'HashDereference' => 187
		}
	},
	{#State 325
		DEFAULT => -197
	},
	{#State 326
		ACTIONS => {
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134
		},
		GOTOS => {
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'SubExpression' => 360,
			'Literal' => 116,
			'Operator' => 104,
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125
		}
	},
	{#State 327
		DEFAULT => -115
	},
	{#State 328
		DEFAULT => -114
	},
	{#State 329
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 107,
			'MY' => 151,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_QW' => 156,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'SubExpression' => 158,
			'Operator' => 104,
			'Literal' => 116,
			'TypeInner' => 153,
			'Expression' => 148,
			'ListElements' => 361,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125,
			'ListElement' => 160,
			'ArrayReference' => 123
		}
	},
	{#State 330
		ACTIONS => {
			")" => 362
		}
	},
	{#State 331
		DEFAULT => -210
	},
	{#State 332
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP18_TERNARY' => 222,
			"]" => 363,
			'OP23_LOGICAL_AND' => 219,
			'OP04_MATH_POW' => 218,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => 212,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211
		}
	},
	{#State 333
		ACTIONS => {
			'OP18_TERNARY' => 222,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			"}" => 364,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223
		}
	},
	{#State 334
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => -211,
			'LPAREN' => -211,
			"}" => 365
		}
	},
	{#State 335
		ACTIONS => {
			'OP21_LIST_COMMA' => 366
		}
	},
	{#State 336
		DEFAULT => -196
	},
	{#State 337
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'Variable' => 289,
			'Literal' => 287,
			'VariableOrLiteral' => 367
		}
	},
	{#State 338
		ACTIONS => {
			'MY' => 368
		}
	},
	{#State 339
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 369
		}
	},
	{#State 340
		DEFAULT => -50
	},
	{#State 341
		DEFAULT => -61
	},
	{#State 342
		ACTIONS => {
			'VARIABLE_SYMBOL' => 370
		}
	},
	{#State 343
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 371
		}
	},
	{#State 344
		ACTIONS => {
			'OP20_HASH_FATARROW' => 372
		}
	},
	{#State 345
		ACTIONS => {
			";" => 373
		}
	},
	{#State 346
		DEFAULT => -130
	},
	{#State 347
		DEFAULT => -119
	},
	{#State 348
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 374
		}
	},
	{#State 349
		DEFAULT => -183
	},
	{#State 350
		DEFAULT => -155,
		GOTOS => {
			'STAR-39' => 375
		}
	},
	{#State 351
		ACTIONS => {
			"while" => -147,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			"for" => -147,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP03_MATH_INC_DEC' => 130,
			"foreach" => -147,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_PRINT' => 118,
			'LPAREN' => 119,
			"%{" => 120,
			'OP19_LOOP_CONTROL' => 122,
			'WORD_UPPERCASE' => 110,
			'MY' => 109,
			'LBRACE' => 111,
			'WORD' => 28,
			'OP01_NAMED_VOID' => 112,
			'SELF' => 106,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'LBRACKET' => 107,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 102,
			'OP01_NAMED_VOID_LPAREN' => 94,
			"if" => 97,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP19_LOOP_CONTROL_SCOLON' => 89,
			'OP01_NAMED' => 92
		},
		GOTOS => {
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'PAREN-36' => 126,
			'VariableModification' => 101,
			'HashReference' => 136,
			'Expression' => 131,
			'Operator' => 104,
			'VariableDeclaration' => 133,
			'OperatorVoid' => 105,
			'SubExpression' => 135,
			'Conditional' => 93,
			'Operation' => 376,
			'Variable' => 90,
			'ArrayDereference' => 91,
			'Statement' => 95,
			'PLUS-42' => 377,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'OPTIONAL-37' => 98,
			'Literal' => 116,
			'LoopLabel' => 117
		}
	},
	{#State 352
		ACTIONS => {
			'LBRACE' => 351
		},
		GOTOS => {
			'CodeBlock' => 378
		}
	},
	{#State 353
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 379
		}
	},
	{#State 354
		ACTIONS => {
			'LPAREN' => 380
		}
	},
	{#State 355
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 381
		}
	},
	{#State 356
		ACTIONS => {
			'LPAREN' => 382
		}
	},
	{#State 357
		ACTIONS => {
			'OP08_STRING_CAT' => 221,
			'OP09_BITWISE_SHIFT' => 220,
			'OP18_TERNARY' => 222,
			"]" => 383,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211
		}
	},
	{#State 358
		ACTIONS => {
			";" => 384
		}
	},
	{#State 359
		DEFAULT => -202
	},
	{#State 360
		ACTIONS => {
			'OP23_LOGICAL_AND' => 219,
			'OP04_MATH_POW' => 218,
			'OP18_TERNARY' => 222,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			"}" => -199,
			'OP07_STRING_REPEAT' => 217,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP21_LIST_COMMA' => -199,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 212
		}
	},
	{#State 361
		ACTIONS => {
			")" => 385
		}
	},
	{#State 362
		DEFAULT => -80
	},
	{#State 363
		DEFAULT => -174
	},
	{#State 364
		DEFAULT => -175
	},
	{#State 365
		DEFAULT => -176
	},
	{#State 366
		ACTIONS => {
			'LITERAL_STRING' => 386
		}
	},
	{#State 367
		DEFAULT => -105
	},
	{#State 368
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 54,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 387
		}
	},
	{#State 369
		ACTIONS => {
			"\@_;" => 388
		}
	},
	{#State 370
		ACTIONS => {
			"= sub {" => 389
		}
	},
	{#State 371
		ACTIONS => {
			"}" => 391,
			'OP21_LIST_COMMA' => 392
		},
		GOTOS => {
			'PAREN-25' => 390
		}
	},
	{#State 372
		ACTIONS => {
			'MY' => 394
		},
		GOTOS => {
			'TypeInnerProperties' => 393
		}
	},
	{#State 373
		DEFAULT => -66
	},
	{#State 374
		DEFAULT => -217
	},
	{#State 375
		ACTIONS => {
			"for" => -158,
			"while" => -158,
			'OP01_OPEN' => -158,
			"\@{" => -158,
			'LITERAL_NUMBER' => -158,
			'OP03_MATH_INC_DEC' => -158,
			"foreach" => -158,
			'VARIABLE_SYMBOL' => -158,
			'CONSTANT_CALL_SCOPED' => -158,
			'OP01_CLOSE' => -158,
			'LPAREN' => -158,
			"%{" => -158,
			'OP19_LOOP_CONTROL' => -158,
			'OP05_LOGICAL_NEG' => -158,
			"undef" => -158,
			'OP01_PRINT' => -158,
			'WORD' => -158,
			'OP01_NAMED_VOID' => -158,
			'MY' => -158,
			'WORD_UPPERCASE' => -158,
			'LBRACE' => -158,
			'LITERAL_STRING' => -158,
			'WORD_SCOPED' => -158,
			"else" => 396,
			'LBRACKET' => -158,
			'OP01_NAMED_VOID_SCOLON' => -158,
			'SELF' => -158,
			"elsif" => 398,
			'OP22_LOGICAL_NEG' => -158,
			'OP10_NAMED_UNARY' => -158,
			"if" => -158,
			'OP05_MATH_NEG_LPAREN' => -158,
			'OP01_NAMED_VOID_LPAREN' => -158,
			"}" => -158,
			'OP01_NAMED' => -158,
			'' => -158,
			'OP19_LOOP_CONTROL_SCOLON' => -158
		},
		GOTOS => {
			'PAREN-38' => 397,
			'PAREN-40' => 399,
			'OPTIONAL-41' => 395
		}
	},
	{#State 376
		DEFAULT => -169
	},
	{#State 377
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 122,
			"%{" => 120,
			'LPAREN' => 119,
			'OP01_PRINT' => 118,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'OP01_NAMED_VOID' => 112,
			'WORD' => 28,
			'LBRACE' => 111,
			'MY' => 109,
			'WORD_UPPERCASE' => 110,
			"for" => -147,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			"while" => -147,
			"foreach" => -147,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			'OP05_MATH_NEG_LPAREN' => 99,
			"if" => 97,
			"}" => 400,
			'OP01_NAMED_VOID_LPAREN' => 94,
			'OP01_NAMED' => 92,
			'OP19_LOOP_CONTROL_SCOLON' => 89,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'SELF' => 106,
			'OP10_NAMED_UNARY' => 102,
			'OP22_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'Conditional' => 93,
			'Operation' => 401,
			'ArrayDereference' => 91,
			'Variable' => 90,
			'Statement' => 95,
			'WordScoped' => 96,
			'OPTIONAL-37' => 98,
			'VariableSymbolOrSelf' => 121,
			'Literal' => 116,
			'LoopLabel' => 117,
			'ArrayReference' => 123,
			'VariableModification' => 101,
			'PAREN-36' => 126,
			'HashDereference' => 125,
			'HashReference' => 136,
			'Expression' => 131,
			'OperatorVoid' => 105,
			'SubExpression' => 135,
			'VariableDeclaration' => 133,
			'Operator' => 104
		}
	},
	{#State 378
		DEFAULT => -166
	},
	{#State 379
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'STDIN' => 237,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'OP03_MATH_INC_DEC' => 130,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111
		},
		GOTOS => {
			'Expression' => 148,
			'SubExpression' => 238,
			'Literal' => 116,
			'Operator' => 104,
			'WordScoped' => 96,
			'HashReference' => 136,
			'VariableSymbolOrSelf' => 121,
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'SubExpressionOrStdin' => 402
		}
	},
	{#State 380
		ACTIONS => {
			'OP01_OPEN' => 132,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'OP03_MATH_INC_DEC' => 130,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			'LPAREN' => 119,
			"%{" => 120,
			'OP05_MATH_NEG_LPAREN' => 99,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'WORD' => 28,
			'OP01_NAMED' => 154
		},
		GOTOS => {
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91,
			'Expression' => 148,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 403,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 381
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 127,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP03_MATH_INC_DEC' => 130,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120
		},
		GOTOS => {
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'SubExpression' => 404,
			'Literal' => 116,
			'Operator' => 104
		}
	},
	{#State 382
		ACTIONS => {
			'MY' => 151,
			'WORD_UPPERCASE' => 152,
			'OP01_QW' => 156,
			'LBRACE' => 111,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107
		},
		GOTOS => {
			'ListElements' => 405,
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ListElement' => 160,
			'ArrayDereference' => 91,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'TypeInner' => 153,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 158
		}
	},
	{#State 383
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 406
		}
	},
	{#State 384
		DEFAULT => -178
	},
	{#State 385
		DEFAULT => -82
	},
	{#State 386
		ACTIONS => {
			'OP21_LIST_COMMA' => 407
		}
	},
	{#State 387
		ACTIONS => {
			'VARIABLE_SYMBOL' => 408
		}
	},
	{#State 388
		DEFAULT => -52
	},
	{#State 389
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => -68,
			"if" => -68,
			"}" => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'OP01_NAMED' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'LBRACKET' => -68,
			'LITERAL_STRING' => -68,
			'WORD_SCOPED' => -68,
			'SELF' => -68,
			'OP10_NAMED_UNARY' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'OP19_LOOP_CONTROL' => -68,
			"%{" => -68,
			'LPAREN' => -68,
			'OP01_PRINT' => -68,
			"undef" => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP01_NAMED_VOID' => -68,
			'WORD' => -68,
			'LBRACE' => -68,
			'WORD_UPPERCASE' => -68,
			'MY' => -68,
			"for" => -68,
			"\@{" => -68,
			'LITERAL_NUMBER' => -68,
			'OP01_OPEN' => -68,
			"while" => -68,
			"foreach" => -68,
			'OP03_MATH_INC_DEC' => -68,
			'LPAREN_MY' => 409,
			'OP01_CLOSE' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			'VARIABLE_SYMBOL' => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 411,
			'MethodArguments' => 410
		}
	},
	{#State 390
		DEFAULT => -63
	},
	{#State 391
		ACTIONS => {
			";" => 412
		}
	},
	{#State 392
		ACTIONS => {
			'WORD' => 344
		},
		GOTOS => {
			'HashEntryProperties' => 413
		}
	},
	{#State 393
		DEFAULT => -201
	},
	{#State 394
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD' => 57,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 414
		}
	},
	{#State 395
		DEFAULT => -159
	},
	{#State 396
		ACTIONS => {
			'LBRACE' => 351
		},
		GOTOS => {
			'CodeBlock' => 415
		}
	},
	{#State 397
		DEFAULT => -154
	},
	{#State 398
		ACTIONS => {
			'LPAREN' => 416
		}
	},
	{#State 399
		DEFAULT => -157
	},
	{#State 400
		DEFAULT => -170
	},
	{#State 401
		DEFAULT => -168
	},
	{#State 402
		ACTIONS => {
			")" => 417
		}
	},
	{#State 403
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			'OP18_TERNARY' => 222,
			'OP08_STRING_CAT' => 221,
			'OP09_BITWISE_SHIFT' => 220,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP17_LIST_RANGE' => 418,
			'OP11_COMPARE_LT_GT' => 226,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227
		}
	},
	{#State 404
		ACTIONS => {
			'OP23_LOGICAL_AND' => 219,
			'OP04_MATH_POW' => 218,
			";" => 419,
			'OP18_TERNARY' => 222,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP16_LOGICAL_OR' => 212
		}
	},
	{#State 405
		ACTIONS => {
			")" => 420
		}
	},
	{#State 406
		ACTIONS => {
			"undef" => 421
		}
	},
	{#State 407
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 107,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 422,
			'Expression' => 148,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123
		}
	},
	{#State 408
		DEFAULT => -49
	},
	{#State 409
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD_SCOPED' => 54,
			'WORD' => 57
		},
		GOTOS => {
			'Type' => 423
		}
	},
	{#State 410
		DEFAULT => -67
	},
	{#State 411
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 424
		}
	},
	{#State 412
		DEFAULT => -65
	},
	{#State 413
		DEFAULT => -62
	},
	{#State 414
		ACTIONS => {
			"\$TYPED_" => 425
		}
	},
	{#State 415
		DEFAULT => -156
	},
	{#State 416
		ACTIONS => {
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107
		},
		GOTOS => {
			'ArrayReference' => 123,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'Expression' => 148,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 426,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121
		}
	},
	{#State 417
		ACTIONS => {
			'LBRACE' => 351
		},
		GOTOS => {
			'CodeBlock' => 427
		}
	},
	{#State 418
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP10_NAMED_UNARY' => 102,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'SELF' => 106,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'Literal' => 116,
			'Operator' => 104,
			'SubExpression' => 428,
			'Expression' => 148,
			'Variable' => 155,
			'HashDereference' => 125,
			'ArrayDereference' => 91,
			'ArrayReference' => 123
		}
	},
	{#State 419
		ACTIONS => {
			'VARIABLE_SYMBOL' => 429
		}
	},
	{#State 420
		ACTIONS => {
			'LBRACE' => 351
		},
		GOTOS => {
			'CodeBlock' => 430
		}
	},
	{#State 421
		ACTIONS => {
			";" => 431
		}
	},
	{#State 422
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP21_LIST_COMMA' => -83,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP16_LOGICAL_OR' => 212,
			'OP23_LOGICAL_AND' => -83,
			'OP04_MATH_POW' => 218,
			"]" => -83,
			'OP18_TERNARY' => 222,
			";" => -83,
			'OP08_STRING_CAT' => 221,
			")" => -83,
			'OP09_BITWISE_SHIFT' => 220,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			"}" => -83,
			'OP07_STRING_REPEAT' => 217
		}
	},
	{#State 423
		ACTIONS => {
			'SELF' => 432
		}
	},
	{#State 424
		ACTIONS => {
			'OP10_NAMED_UNARY' => 102,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_NAMED_VOID_SCOLON' => 108,
			'LBRACKET' => 107,
			'WORD_SCOPED' => 30,
			'LITERAL_STRING' => 85,
			'SELF' => 106,
			'OP01_NAMED' => 92,
			'OP19_LOOP_CONTROL_SCOLON' => 89,
			'OP05_MATH_NEG_LPAREN' => 99,
			"if" => 97,
			"}" => 434,
			'OP01_NAMED_VOID_LPAREN' => 94,
			"foreach" => -147,
			'OP03_MATH_INC_DEC' => 130,
			'OP01_CLOSE' => 129,
			'CONSTANT_CALL_SCOPED' => 127,
			'VARIABLE_SYMBOL' => 124,
			"for" => -147,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'OP01_OPEN' => 132,
			"while" => -147,
			'OP01_NAMED_VOID' => 112,
			'WORD' => 28,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 110,
			'MY' => 109,
			'OP19_LOOP_CONTROL' => 122,
			"%{" => 120,
			'LPAREN' => 119,
			'OP01_PRINT' => 118,
			'OP05_LOGICAL_NEG' => 115,
			"undef" => 114
		},
		GOTOS => {
			'Variable' => 90,
			'ArrayDereference' => 91,
			'Operation' => 433,
			'Conditional' => 93,
			'LoopLabel' => 117,
			'Literal' => 116,
			'VariableSymbolOrSelf' => 121,
			'OPTIONAL-37' => 98,
			'WordScoped' => 96,
			'Statement' => 95,
			'PAREN-36' => 126,
			'HashDereference' => 125,
			'VariableModification' => 101,
			'ArrayReference' => 123,
			'Operator' => 104,
			'VariableDeclaration' => 133,
			'OperatorVoid' => 105,
			'SubExpression' => 135,
			'Expression' => 131,
			'HashReference' => 136
		}
	},
	{#State 425
		ACTIONS => {
			'WORD' => 435
		}
	},
	{#State 426
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP18_TERNARY' => 222,
			'OP09_BITWISE_SHIFT' => 220,
			")" => 436,
			'OP08_STRING_CAT' => 221,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219
		}
	},
	{#State 427
		DEFAULT => -167
	},
	{#State 428
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => 212,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => undef,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_STRING_CAT' => 221,
			")" => 437,
			'OP09_BITWISE_SHIFT' => 220,
			'OP18_TERNARY' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP04_MATH_POW' => 218
		}
	},
	{#State 429
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 438
		}
	},
	{#State 430
		DEFAULT => -165
	},
	{#State 431
		DEFAULT => -179
	},
	{#State 432
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 439
		}
	},
	{#State 433
		DEFAULT => -69
	},
	{#State 434
		ACTIONS => {
			";" => 440
		}
	},
	{#State 435
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 442,
			'OP02_ARRAY_THINARROW' => 441
		}
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 351
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 437
		ACTIONS => {
			'LBRACE' => 351
		},
		GOTOS => {
			'CodeBlock' => 444
		}
	},
	{#State 438
		ACTIONS => {
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP05_MATH_NEG_LPAREN' => 99,
			'LPAREN' => 119,
			"%{" => 120,
			'LBRACE' => 111,
			'WORD_UPPERCASE' => 152,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'OP01_OPEN' => 132,
			'LBRACKET' => 107,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'CONSTANT_CALL_SCOPED' => 127,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP03_MATH_INC_DEC' => 130
		},
		GOTOS => {
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'Operator' => 104,
			'Literal' => 116,
			'SubExpression' => 445,
			'ArrayReference' => 123,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayDereference' => 91
		}
	},
	{#State 439
		ACTIONS => {
			'OP21_LIST_COMMA' => 447,
			")" => 446
		},
		GOTOS => {
			'PAREN-29' => 448
		}
	},
	{#State 440
		DEFAULT => -71
	},
	{#State 441
		ACTIONS => {
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'OP01_NAMED' => 154,
			'WORD' => 28,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'SELF' => 106,
			"\@{" => 134,
			'LITERAL_NUMBER' => 84,
			'OP03_MATH_INC_DEC' => 130,
			'VARIABLE_SYMBOL' => 124,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127
		},
		GOTOS => {
			'ArrayReference' => 123,
			'ArrayDereference' => 91,
			'Variable' => 155,
			'HashDereference' => 125,
			'HashReference' => 136,
			'WordScoped' => 96,
			'VariableSymbolOrSelf' => 121,
			'Expression' => 148,
			'SubExpression' => 449,
			'Literal' => 116,
			'Operator' => 104
		}
	},
	{#State 442
		ACTIONS => {
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			'LITERAL_NUMBER' => 84,
			"\@{" => 134,
			'SELF' => 106,
			'OP03_MATH_INC_DEC' => 130,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 121,
			'WordScoped' => 96,
			'HashReference' => 136,
			'SubExpression' => 450,
			'Literal' => 116,
			'Operator' => 104,
			'Expression' => 148,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 155,
			'ArrayReference' => 123
		}
	},
	{#State 443
		DEFAULT => -153
	},
	{#State 444
		DEFAULT => -163
	},
	{#State 445
		ACTIONS => {
			'OP18_TERNARY' => 222,
			";" => 451,
			'OP09_BITWISE_SHIFT' => 220,
			'OP08_STRING_CAT' => 221,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			'OP07_STRING_REPEAT' => 217,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223
		}
	},
	{#State 446
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 452
		}
	},
	{#State 447
		ACTIONS => {
			'MY' => 453
		}
	},
	{#State 448
		DEFAULT => -73
	},
	{#State 449
		ACTIONS => {
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			"]" => 454,
			'OP18_TERNARY' => 222,
			'OP08_STRING_CAT' => 221,
			'OP09_BITWISE_SHIFT' => 220,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217,
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224
		}
	},
	{#State 450
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 227,
			'OP08_MATH_ADD_SUB' => 215,
			'OP11_COMPARE_LT_GT' => 226,
			'OP17_LIST_RANGE' => 225,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP06_REGEX_MATCH' => 213,
			'OP16_LOGICAL_OR' => 212,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP21_LIST_COMMA' => -218,
			'OP13_BITWISE_AND' => 223,
			'OP15_LOGICAL_AND' => 211,
			'OP08_STRING_CAT' => 221,
			'OP09_BITWISE_SHIFT' => 220,
			'OP18_TERNARY' => 222,
			'OP23_LOGICAL_AND' => 219,
			'OP04_MATH_POW' => 218,
			'OP07_STRING_REPEAT' => 217,
			"}" => -218,
			'OP07_MATH_MULT_DIV_MOD' => 216
		}
	},
	{#State 451
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 130,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 124,
			'OP01_CLOSE' => 129,
			'OP10_NAMED_UNARY' => 102,
			'CONSTANT_CALL_SCOPED' => 127,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 30,
			'LBRACKET' => 107,
			'OP01_OPEN' => 132,
			"\@{" => 134,
			'SELF' => 106,
			'LITERAL_NUMBER' => 84,
			'WORD' => 28,
			'OP01_NAMED' => 154,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 111,
			"%{" => 120,
			'LPAREN' => 119,
			'OP05_MATH_NEG_LPAREN' => 99,
			"undef" => 114,
			'OP05_LOGICAL_NEG' => 115
		},
		GOTOS => {
			'VariableModification' => 455,
			'ArrayDereference' => 91,
			'HashDereference' => 125,
			'Variable' => 90,
			'SubExpressionOrVarMod' => 456,
			'ArrayReference' => 123,
			'VariableSymbolOrSelf' => 121,
			'HashReference' => 136,
			'WordScoped' => 96,
			'SubExpression' => 457,
			'Operator' => 104,
			'Literal' => 116,
			'Expression' => 148
		}
	},
	{#State 452
		ACTIONS => {
			"\@_;" => 458
		}
	},
	{#State 453
		ACTIONS => {
			'TYPE_INTEGER' => 56,
			'WORD' => 57,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 459
		}
	},
	{#State 454
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 460
		}
	},
	{#State 455
		DEFAULT => -144
	},
	{#State 456
		ACTIONS => {
			")" => 461
		}
	},
	{#State 457
		ACTIONS => {
			'OP17_LIST_RANGE' => 225,
			'OP11_COMPARE_LT_GT' => 226,
			'OP08_MATH_ADD_SUB' => 215,
			'OP14_BITWISE_OR_XOR' => 227,
			'OP15_LOGICAL_AND' => 211,
			'OP13_BITWISE_AND' => 223,
			'OP12_COMPARE_EQ_NE' => 214,
			'OP16_LOGICAL_OR' => 212,
			'OP06_REGEX_MATCH' => 213,
			'OP24_LOGICAL_OR_XOR' => 224,
			'OP04_MATH_POW' => 218,
			'OP23_LOGICAL_AND' => 219,
			'OP18_TERNARY' => 222,
			'OP08_STRING_CAT' => 221,
			")" => -143,
			'OP09_BITWISE_SHIFT' => 220,
			'OP07_MATH_MULT_DIV_MOD' => 216,
			'OP07_STRING_REPEAT' => 217
		}
	},
	{#State 458
		DEFAULT => -75
	},
	{#State 459
		ACTIONS => {
			'VARIABLE_SYMBOL' => 462
		}
	},
	{#State 460
		ACTIONS => {
			"undef" => 463
		}
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 351
		},
		GOTOS => {
			'CodeBlock' => 464
		}
	},
	{#State 462
		DEFAULT => -72
	},
	{#State 463
		DEFAULT => -219
	},
	{#State 464
		DEFAULT => -164
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6563 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6570 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6577 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6584 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6606 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6613 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6620 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6627 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6634 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6641 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6648 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6655 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6662 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6669 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6676 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6683 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6690 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6701 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6715 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6722 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6729 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6740 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6751 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6762 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6776 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6790 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6797 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6804 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6811 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6818 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6843 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6854 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6868 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6879 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6890 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6901 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6912 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6919 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6926 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6940 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6951 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6972 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6983 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6990 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7011 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7018 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7025 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7032 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7039 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7093 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7100 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7114 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7121 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7164 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7175 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7186 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7197 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7219 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7230 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7307 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7318 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7329 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7340 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7351 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7362 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7373 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7384 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7395 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7406 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7417 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7428 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7439 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7450 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7461 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7494 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7505 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7527 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7534 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 178 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7555 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7584 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7595 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7606 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7617 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7639 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7650 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7657 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7664 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7678 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7700 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7711 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7722 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7733 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7744 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7755 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7788 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7799 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7810 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7821 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7832 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7843 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_141
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7854 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_142
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7865 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_143
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7876 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_144
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7887 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7894 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7901 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7941 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7952 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7963 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7970 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7977 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7984 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7991 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7998 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8005 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_159
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8016 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_160
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8027 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8038 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8049 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_163
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8060 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_164
		 'LoopFor', 14,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8071 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_165
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8082 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_166
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8093 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_167
		 'LoopWhile', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8104 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8111 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8118 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_170
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8129 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8136 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8143 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_173
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8154 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8165 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8176 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8187 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_177
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8198 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8209 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8220 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8231 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_181
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8242 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8253 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8260 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8267 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 200 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8274 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_186
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8285 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8296 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8307 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8318 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8325 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8332 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_192
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8343 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8350 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8357 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_195
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8368 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_196
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8379 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8386 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8393 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_199
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8404 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_200
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8415 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_201
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8426 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8433 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8440 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8447 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_205
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8458 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_206
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8469 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8476 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8483 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_209
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8494 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_210
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8505 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_211
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8516 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_212
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8527 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8538 lib/RPerl/Grammar.pm
	],
	[#Rule Type_214
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8549 lib/RPerl/Grammar.pm
	],
	[#Rule Type_215
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8560 lib/RPerl/Grammar.pm
	],
	[#Rule Type_216
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8571 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_217
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8582 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_218
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8593 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_219
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8604 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_220
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8615 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_221
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8626 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_222
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8637 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_223
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8648 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_224
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8659 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_225
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8670 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_226
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8681 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_227
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8692 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_228
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8703 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_229
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8714 lib/RPerl/Grammar.pm
	]
],
#line 8717 lib/RPerl/Grammar.pm
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
         'Include_41', 
         'Include_42', 
         'Constant_43', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Subroutine_48', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_52', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_61', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_65', 
         'Properties_66', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_71', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_75', 
         'MethodOrSubroutine_76', 
         'MethodOrSubroutine_77', 
         'Operation_78', 
         'Operation_79', 
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
         'Operator_108', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         'OperatorVoid_116', 
         'OperatorVoid_117', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         'OperatorVoid_120', 
         'OperatorVoid_121', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_126', 
         'Expression_127', 
         'Expression_128', 
         'Expression_129', 
         'Expression_130', 
         'Expression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpression_138', 
         'SubExpression_139', 
         'SubExpression_140', 
         'SubExpressionOrStdin_141', 
         'SubExpressionOrStdin_142', 
         'SubExpressionOrVarMod_143', 
         'SubExpressionOrVarMod_144', 
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
         'LoopFor_164', 
         'LoopForEach_165', 
         'LoopWhile_166', 
         'LoopWhile_167', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_170', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_173', 
         'VariableRetrieval_174', 
         'VariableRetrieval_175', 
         'VariableRetrieval_176', 
         'VariableDeclaration_177', 
         'VariableDeclaration_178', 
         'VariableDeclaration_179', 
         'VariableDeclaration_180', 
         'VariableModification_181', 
         'VariableModification_182', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_186', 
         'ListElement_187', 
         'ListElement_188', 
         'ListElement_189', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_192', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_195', 
         'ArrayDereference_196', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_199', 
         'HashEntry_200', 
         'HashEntryProperties_201', 
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
         'TypeInnerProperties_218', 
         'TypeInnerProperties_219', 
         'TypeInnerConstant_220', 
         'VariableOrLiteral_221', 
         'VariableOrLiteral_222', 
         'VariableOrLiteralOrWord_223', 
         'VariableOrLiteralOrWord_224', 
         'VariableOrLiteralOrWord_225', 
         'VariableSymbolOrSelf_226', 
         'VariableSymbolOrSelf_227', 
         'Literal_228', 
         'Literal_229', );
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
Include_41 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped ';'
Include_42 => 'RPerl::CompileUnit::Include',                                # Include -> USE WordScoped OP01_QW ';'
Constant_43 => 'RPerl::CompileUnit::Constant',                              # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_48 => 'RPerl::CodeBlock::Subroutine',                            # Subroutine -> 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_52 => 'RPerl::CodeBlock::Subroutine::Arguments',        # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@_;'
Class_61 => 'RPerl::CompileUnit::Module::Class::Generator',                 # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_65 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryProperties STAR-27 '}' ';'
Properties_66 => 'RPerl::DataStructure::Hash::Properties',                  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_71 => 'RPerl::CodeBlock::Subroutine::Method',                        # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_75 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',    # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_76 => 'RPerl::CodeBlock::Subroutine::Method',            # MethodOrSubroutine -> Method
MethodOrSubroutine_77 => 'RPerl::CodeBlock::Subroutine',                    # MethodOrSubroutine -> Subroutine
Operation_78 => 'RPerl::Operation::Expression',                             # Operation -> Expression ';'
Operation_79 => 'RPerl::Operation::Statement',                              # Operation -> Statement
Operator_80 => 'RPerl::Operation::Expression::Operator::Print',             # Operator -> LPAREN OP01_PRINT FHREF_SYMBOL_BRACES ListElements ')'
Operator_81 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> OP01_NAMED SubExpression
Operator_82 => 'RPerl::Operation::Expression::Operator::Named',             # Operator -> LPAREN OP01_NAMED ListElement OP21_LIST_COMMA ListElements ')'
Operator_83 => 'RPerl::Operation::Expression::Operator::Open',              # Operator -> OP01_OPEN MY TYPE_FHREF FHREF_SYMBOL OP21_LIST_COMMA LITERAL_STRING OP21_LIST_COMMA SubExpression
Operator_84 => 'RPerl::Operation::Expression::Operator::Close',             # Operator -> OP01_CLOSE FHREF_SYMBOL
Operator_85 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> OP03_MATH_INC_DEC Variable
Operator_86 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',      # Operator -> Variable OP03_MATH_INC_DEC
Operator_87 => 'RPerl::Operation::Expression::Operator::Math::Power',                   # Operator -> SubExpression OP04_MATH_POW SubExpression
Operator_88 => 'RPerl::Operation::Expression::Operator::Logical::Negation',             # Operator -> OP05_LOGICAL_NEG SubExpression
Operator_89 => 'RPerl::Operation::Expression::Operator::Math::Negative',                # Operator -> OP05_MATH_NEG_LPAREN SubExpression ')'
Operator_90 => 'RPerl::Operation::Expression::Operator::RegularExpression',             # Operator -> SubExpression OP06_REGEX_MATCH OP06_REGEX_PATTERN
Operator_91 => 'RPerl::Operation::Expression::Operator::String::Repeat',                # Operator -> SubExpression OP07_STRING_REPEAT SubExpression
Operator_92 => 'RPerl::Operation::Expression::Operator::Math::MultiplyDivideModulo',    # Operator -> SubExpression OP07_MATH_MULT_DIV_MOD SubExpression
Operator_93 => 'RPerl::Operation::Expression::Operator::Math::AddSubtract',             # Operator -> SubExpression OP08_MATH_ADD_SUB SubExpression
Operator_94 => 'RPerl::Operation::Expression::Operator::String::Concatenate',           # Operator -> SubExpression OP08_STRING_CAT SubExpression
Operator_95 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',                # Operator -> SubExpression OP09_BITWISE_SHIFT SubExpression
Operator_96 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY SubExpression
Operator_97 => 'RPerl::Operation::Expression::Operator::NamedUnary',                    # Operator -> OP10_NAMED_UNARY
Operator_98 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan', # Operator -> SubExpression OP11_COMPARE_LT_GT SubExpression
Operator_99 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',       # Operator -> SubExpression OP12_COMPARE_EQ_NE SubExpression
Operator_100 => 'RPerl::Operation::Expression::Operator::Bitwise::And',                 # Operator -> SubExpression OP13_BITWISE_AND SubExpression
Operator_101 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',               # Operator -> SubExpression OP14_BITWISE_OR_XOR SubExpression
Operator_102 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP15_LOGICAL_AND SubExpression
Operator_103 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP16_LOGICAL_OR SubExpression
Operator_104 => 'RPerl::Operation::Expression::Operator::List::Range',                  # Operator -> SubExpression OP17_LIST_RANGE SubExpression
Operator_105 => 'RPerl::Operation::Expression::Operator::Ternary',                      # Operator -> SubExpression OP18_TERNARY VariableOrLiteral COLON VariableOrLiteral
Operator_106 => 'RPerl::Operation::Expression::Operator::Logical::Negation',            # Operator -> OP22_LOGICAL_NEG SubExpression
Operator_107 => 'RPerl::Operation::Expression::Operator::Logical::And',                 # Operator -> SubExpression OP23_LOGICAL_AND SubExpression
Operator_108 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',               # Operator -> SubExpression OP24_LOGICAL_OR_XOR SubExpression
OperatorVoid_114 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_115 => 'RPerl::Operation::Statement::OperatorVoid::Print',                 # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_116 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_117 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_118 => 'RPerl::Operation::Statement::OperatorVoid::Named',                 # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_119 => 'RPerl::Operation::Expression::Operator::Named',                    # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_120 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_121 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',           # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_126 => 'RPerl::Operation::Expression::Operator',                                     # Expression -> Operator
Expression_127 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> WORD_UPPERCASE LPAREN ')'
Expression_128 => 'RPerl::Operation::Expression::ConstantCall',                                 # Expression -> CONSTANT_CALL_SCOPED
Expression_129 => 'RPerl::Operation::Expression::SubroutineCall',                               # Expression -> WordScoped LPAREN OPTIONAL-33 ')'
Expression_130 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',                   # Expression -> Variable OP02_METHOD_THINARROW LPAREN OPTIONAL-34 ')'
Expression_131 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',  # Expression -> WordScoped OP02_METHOD_THINARROW_NEW ')'
SubExpression_132 => 'RPerl::Operation::Expression',                                            # SubExpression -> Expression
SubExpression_133 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',         # SubExpression -> 'undef'
SubExpression_134 => 'RPerl::Operation::Expression::SubExpression::Literal',                    # SubExpression -> Literal
SubExpression_135 => 'RPerl::Operation::Expression::SubExpression::Variable',                   # SubExpression -> Variable
SubExpression_136 => 'RPerl::DataStructure::Array::Reference',                                  # SubExpression -> ArrayReference
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',           # SubExpression -> ArrayDereference
SubExpression_138 => 'RPerl::DataStructure::Hash::Reference',                                   # SubExpression -> HashReference
SubExpression_139 => 'RPerl::Operation::Expression::SubExpression::HashDereference',            # SubExpression -> HashDereference
SubExpression_140 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',                # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrStdin_141 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrStdin -> SubExpression
SubExpressionOrStdin_142 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrStdin -> STDIN
SubExpressionOrVarMod_143 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_144 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_148 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_149 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_150 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_151 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_152 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_159 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_160 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_161 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_162 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_163 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_164 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpression ';' VARIABLE_SYMBOL OP11_COMPARE_LT_GT SubExpression ';' SubExpressionOrVarMod ')' CodeBlock
LoopForEach_165 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_166 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_167 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ')' CodeBlock
CodeBlock_170 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_173 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_174 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_175 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_176 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_177 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_178 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrStdin ';'
VariableDeclaration_179 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_180 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_181 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrStdin
VariableModification_182 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_186 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_187 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_188 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_189 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ArrayReference_192 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_195 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_196 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_199 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_200 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntryProperties_201 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> WORD OP20_HASH_FATARROW TypeInnerProperties
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
TypeInnerProperties_218 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_219 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_220 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_221 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_222 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_223 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_224 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_225 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
VariableSymbolOrSelf_226 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_227 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_228 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_229 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 9123 lib/RPerl/Grammar.pm



1;
