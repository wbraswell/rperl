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
    our $VERSION = 0.001_995;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|\=\ sub\ \{|foreach|\$TYPED_|undef|elsif|while|else|for|\@_\;|our|if|\@\{|\%\{|\]|\;|\)|\})}gc and return ($1, $1);

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
      /\G(sin|cos|push|pop|keys|values|sort|length|split|join|reverse|fakebuiltin)\s/gc and return ('OP01_NAMED', $1);
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
			"package" => -20,
			'SHEBANG' => 7,
			"## no critic qw(" => 5,
			'USE_RPERL' => -20
		},
		GOTOS => {
			'Program' => 6,
			'Critic' => 1,
			'OPTIONAL-9' => 2,
			'ModuleHeader' => 3,
			'CompileUnit' => 8,
			'PAREN-1' => 4,
			'PLUS-2' => 9
		}
	},
	{#State 1
		DEFAULT => -19
	},
	{#State 2
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 11
		},
		GOTOS => {
			'OPTIONAL-10' => 10
		}
	},
	{#State 3
		ACTIONS => {
			"use constant" => -27,
			"use parent qw(" => 15,
			'USE' => -27,
			"## no critic qw(" => -27,
			"our" => -27
		},
		GOTOS => {
			'STAR-11' => 14,
			'Class' => 12,
			'Package' => 16,
			'Module' => 13
		}
	},
	{#State 4
		DEFAULT => -3
	},
	{#State 5
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-16' => 17
		}
	},
	{#State 6
		DEFAULT => -4
	},
	{#State 7
		ACTIONS => {
			"## no critic qw(" => 5,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 20,
			'Critic' => 19
		}
	},
	{#State 8
		ACTIONS => {
			'' => 21
		}
	},
	{#State 9
		ACTIONS => {
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 5,
			'' => -5
		},
		GOTOS => {
			'ModuleHeader' => 3,
			'PAREN-1' => 22,
			'Critic' => 1,
			'OPTIONAL-9' => 2
		}
	},
	{#State 10
		ACTIONS => {
			"package" => 23
		}
	},
	{#State 11
		DEFAULT => -21
	},
	{#State 12
		DEFAULT => -25
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		ACTIONS => {
			"use constant" => -29,
			'USE' => -29,
			"## no critic qw(" => 5,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 25,
			'Critic' => 24
		}
	},
	{#State 15
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 26
		}
	},
	{#State 16
		DEFAULT => -24
	},
	{#State 17
		ACTIONS => {
			'WORD' => 29,
			")" => 30
		}
	},
	{#State 18
		DEFAULT => -39
	},
	{#State 19
		DEFAULT => -6
	},
	{#State 20
		ACTIONS => {
			'USE_RPERL' => 31
		}
	},
	{#State 21
		DEFAULT => 0
	},
	{#State 22
		DEFAULT => -2
	},
	{#State 23
		ACTIONS => {
			'WORD' => 27,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 24
		DEFAULT => -26
	},
	{#State 25
		ACTIONS => {
			"our" => -31,
			'USE' => 34,
			"use constant" => -31
		},
		GOTOS => {
			'Include' => 35,
			'STAR-13' => 33
		}
	},
	{#State 26
		ACTIONS => {
			")" => 36
		}
	},
	{#State 27
		DEFAULT => -211
	},
	{#State 28
		DEFAULT => -212
	},
	{#State 29
		DEFAULT => -38
	},
	{#State 30
		DEFAULT => -40
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
			"our" => 44,
			"use constant" => 43
		},
		GOTOS => {
			'PLUS-14' => 42,
			'Subroutine' => 41,
			'Constant' => 40
		}
	},
	{#State 34
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 27
		},
		GOTOS => {
			'WordScoped' => 45
		}
	},
	{#State 35
		DEFAULT => -28
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
		DEFAULT => -30
	},
	{#State 41
		DEFAULT => -33
	},
	{#State 42
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 51
		},
		GOTOS => {
			'Subroutine' => 50
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 52
		}
	},
	{#State 44
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 53,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 45
		ACTIONS => {
			";" => 57,
			'OP01_QW' => 58
		}
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
			'OP01_NAMED_VOID_LPAREN' => -11,
			'LPAREN' => -11,
			'VARIABLE_SYMBOL' => -11,
			'USE' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			"\@{" => -11,
			"undef" => -11,
			'WORD_UPPERCASE' => -11,
			'OP01_PRINT' => -11,
			"use constant" => -11,
			'LBRACKET' => -11,
			'WORD' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'MY' => -11,
			"while" => -11,
			'OP01_NAMED' => -11,
			"## no critic qw(" => 5,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID' => -11,
			"for" => -11,
			'OP10_NAMED_UNARY' => -11,
			'LITERAL_STRING' => -11,
			'OP01_OPEN' => -11,
			"our" => -11,
			"if" => -11,
			'WORD_SCOPED' => -11,
			'LBRACE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'OP01_CLOSE' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LITERAL_NUMBER' => -11,
			"foreach" => -11,
			'SELF' => -11,
			"%{" => -11
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
		DEFAULT => -32
	},
	{#State 51
		ACTIONS => {
			";" => 64
		}
	},
	{#State 52
		ACTIONS => {
			'OP20_HASH_FATARROW' => 65
		}
	},
	{#State 53
		DEFAULT => -214
	},
	{#State 54
		DEFAULT => -216
	},
	{#State 55
		DEFAULT => -215
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 57
		DEFAULT => -41
	},
	{#State 58
		ACTIONS => {
			";" => 67
		}
	},
	{#State 59
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 68
		}
	},
	{#State 60
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'VARIABLE_SYMBOL' => -13,
			'LPAREN' => -13,
			'USE' => 34,
			"undef" => -13,
			"\@{" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'WORD_UPPERCASE' => -13,
			"use constant" => -13,
			'OP01_PRINT' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LBRACKET' => -13,
			'WORD' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			"while" => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED' => -13,
			'MY' => -13,
			"for" => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_OPEN' => -13,
			"our" => -13,
			'LITERAL_STRING' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LBRACE' => -13,
			'WORD_SCOPED' => -13,
			"if" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'SELF' => -13,
			"foreach" => -13,
			"%{" => -13,
			'LITERAL_NUMBER' => -13
		},
		GOTOS => {
			'Include' => 69,
			'STAR-6' => 70
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
			"our" => 71
		}
	},
	{#State 64
		DEFAULT => -34
	},
	{#State 65
		ACTIONS => {
			'MY' => 72
		},
		GOTOS => {
			'TypeInnerConstant' => 73
		}
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 67
		DEFAULT => -42
	},
	{#State 68
		ACTIONS => {
			"use constant" => -56,
			"## no critic qw(" => 5,
			'USE' => -56,
			"our hashref \$properties" => -56
		},
		GOTOS => {
			'Critic' => 76,
			'STAR-22' => 75
		}
	},
	{#State 69
		DEFAULT => -10
	},
	{#State 70
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'LPAREN' => -15,
			'VARIABLE_SYMBOL' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"\@{" => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_PRINT' => -15,
			"use constant" => 43,
			'LBRACKET' => -15,
			'WORD' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'MY' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"while" => -15,
			'OP01_NAMED' => -15,
			'OP01_NAMED_VOID' => -15,
			"for" => -15,
			'LITERAL_STRING' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP01_OPEN' => -15,
			"our" => -15,
			"if" => -15,
			'WORD_SCOPED' => -15,
			'LBRACE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'OP01_CLOSE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'LITERAL_NUMBER' => -15,
			"foreach" => -15,
			"%{" => -15,
			'SELF' => -15
		},
		GOTOS => {
			'Constant' => 77,
			'STAR-7' => 78
		}
	},
	{#State 71
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 79
		}
	},
	{#State 72
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 80
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_NUMBER' => 83,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'Literal' => 81
		}
	},
	{#State 74
		ACTIONS => {
			"for" => -45,
			'OP01_NAMED_VOID' => -45,
			'MY' => -45,
			'OP01_NAMED' => -45,
			"}" => -45,
			"while" => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'LBRACKET' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'WORD' => -45,
			'OP19_LOOP_CONTROL' => -45,
			'LITERAL_NUMBER' => -45,
			'SELF' => -45,
			"%{" => -45,
			"foreach" => -45,
			'OP01_CLOSE' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			"if" => -45,
			'WORD_SCOPED' => -45,
			'LBRACE' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'LITERAL_STRING' => -45,
			'OP10_NAMED_UNARY' => -45,
			'OP01_OPEN' => -45,
			'LPAREN_MY' => 84,
			'LPAREN' => -45,
			'VARIABLE_SYMBOL' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP01_PRINT' => -45,
			'WORD_UPPERCASE' => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			"\@{" => -45,
			"undef" => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 85,
			'SubroutineArguments' => 86
		}
	},
	{#State 75
		ACTIONS => {
			'USE' => 34,
			"use constant" => -58,
			"our hashref \$properties" => -58
		},
		GOTOS => {
			'Include' => 88,
			'STAR-23' => 87
		}
	},
	{#State 76
		DEFAULT => -53
	},
	{#State 77
		DEFAULT => -12
	},
	{#State 78
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'WORD_UPPERCASE' => 119,
			'OP01_PRINT' => 126,
			'OP22_LOGICAL_NEG' => 132,
			'OP01_NAMED_VOID_LPAREN' => 133,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"our" => 44,
			"if" => 90,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			"foreach" => -147,
			'SELF' => 104,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP19_LOOP_CONTROL' => 113,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'MY' => 115,
			"while" => -147,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 117,
			"for" => -147,
			'OP01_NAMED_VOID' => 114
		},
		GOTOS => {
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 101,
			'PLUS-8' => 102,
			'Conditional' => 106,
			'ArrayDereference' => 125,
			'OperatorVoid' => 105,
			'VariableDeclaration' => 99,
			'Variable' => 124,
			'HashDereference' => 89,
			'SubExpression' => 92,
			'Operator' => 91,
			'VariableModification' => 93,
			'Operation' => 94,
			'Literal' => 120,
			'PAREN-36' => 96,
			'VariableSymbolOrSelf' => 116,
			'LoopLabel' => 136,
			'Subroutine' => 135,
			'OPTIONAL-37' => 134,
			'HashReference' => 128,
			'Statement' => 130
		}
	},
	{#State 79
		DEFAULT => -37
	},
	{#State 80
		ACTIONS => {
			"\$TYPED_" => 137
		}
	},
	{#State 81
		ACTIONS => {
			";" => 138
		}
	},
	{#State 82
		DEFAULT => -229
	},
	{#State 83
		DEFAULT => -228
	},
	{#State 84
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 139
		}
	},
	{#State 85
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 140
		}
	},
	{#State 86
		DEFAULT => -44
	},
	{#State 87
		ACTIONS => {
			"our hashref \$properties" => 141,
			"use constant" => 43
		},
		GOTOS => {
			'Properties' => 143,
			'Constant' => 142
		}
	},
	{#State 88
		DEFAULT => -55
	},
	{#State 89
		DEFAULT => -139
	},
	{#State 90
		ACTIONS => {
			'LPAREN' => 144
		}
	},
	{#State 91
		DEFAULT => -126
	},
	{#State 92
		ACTIONS => {
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP17_LIST_RANGE' => 154,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP06_REGEX_MATCH' => 150,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156
		}
	},
	{#State 93
		ACTIONS => {
			";" => 162
		}
	},
	{#State 94
		DEFAULT => -17
	},
	{#State 95
		ACTIONS => {
			'WORD' => 163,
			'LITERAL_STRING' => 82,
			"}" => 164,
			'SELF' => 104,
			"%{" => 103,
			'LITERAL_NUMBER' => 83,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'Literal' => 169,
			'HashDereference' => 166,
			'VariableOrLiteralOrWord' => 167,
			'Variable' => 168,
			'HashEntry' => 165,
			'VariableSymbolOrSelf' => 116
		}
	},
	{#State 96
		DEFAULT => -146
	},
	{#State 97
		DEFAULT => -116
	},
	{#State 98
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => -97,
			"\@{" => 122,
			"undef" => 123,
			'CONSTANT_CALL_SCOPED' => 121,
			'WORD_UPPERCASE' => 170,
			'OP04_MATH_POW' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP13_BITWISE_AND' => -97,
			";" => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP22_LOGICAL_NEG' => 132,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP06_REGEX_MATCH' => -97,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP11_COMPARE_LT_GT' => -97,
			'OP16_LOGICAL_OR' => -97,
			"]" => -97,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP07_STRING_REPEAT' => -97,
			'OP18_TERNARY' => -97,
			'OP01_OPEN' => 100,
			'OP17_LIST_RANGE' => -97,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'OP14_BITWISE_OR_XOR' => -97,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP08_STRING_CAT' => -97,
			"}" => -97,
			'OP15_LOGICAL_AND' => -97,
			")" => -97,
			'OP21_LIST_COMMA' => -97,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'OP23_LOGICAL_AND' => -97
		},
		GOTOS => {
			'Operator' => 91,
			'HashDereference' => 89,
			'SubExpression' => 174,
			'HashReference' => 128,
			'Literal' => 120,
			'Variable' => 171,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127
		}
	},
	{#State 99
		DEFAULT => -151
	},
	{#State 100
		ACTIONS => {
			'MY' => 175
		}
	},
	{#State 101
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			";" => 176,
			'OP13_BITWISE_AND' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP08_STRING_CAT' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP04_MATH_POW' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP18_TERNARY' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP06_REGEX_MATCH' => -132
		}
	},
	{#State 102
		ACTIONS => {
			'OP01_NAMED_VOID' => 114,
			"for" => -147,
			'MY' => 115,
			'OP01_NAMED' => 117,
			"while" => -147,
			'' => -18,
			'OP05_LOGICAL_NEG' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP19_LOOP_CONTROL' => 113,
			'LITERAL_NUMBER' => 83,
			"foreach" => -147,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			"if" => 90,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'OP01_OPEN' => 100,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'OP01_NAMED_VOID_LPAREN' => 133,
			'OP01_PRINT' => 126,
			'WORD_UPPERCASE' => 119,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123
		},
		GOTOS => {
			'LoopLabel' => 136,
			'VariableSymbolOrSelf' => 116,
			'HashReference' => 128,
			'Statement' => 130,
			'OPTIONAL-37' => 134,
			'Expression' => 101,
			'OperatorVoid' => 105,
			'ArrayDereference' => 125,
			'Conditional' => 106,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'SubExpression' => 92,
			'HashDereference' => 89,
			'Operator' => 91,
			'VariableModification' => 93,
			'Operation' => 177,
			'PAREN-36' => 96,
			'Literal' => 120,
			'VariableDeclaration' => 99,
			'Variable' => 124
		}
	},
	{#State 103
		ACTIONS => {
			'MY' => 179,
			'LBRACE' => -208,
			'VARIABLE_SYMBOL' => 131,
			'SELF' => 104
		},
		GOTOS => {
			'TypeInner' => 178,
			'Variable' => 180,
			'VariableSymbolOrSelf' => 116,
			'OPTIONAL-51' => 181
		}
	},
	{#State 104
		DEFAULT => -227
	},
	{#State 105
		DEFAULT => -150
	},
	{#State 106
		DEFAULT => -148
	},
	{#State 107
		ACTIONS => {
			'FHREF_SYMBOL' => 182
		}
	},
	{#State 108
		ACTIONS => {
			'LPAREN' => 183,
			'OP02_METHOD_THINARROW_NEW' => 184
		}
	},
	{#State 109
		ACTIONS => {
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132
		},
		GOTOS => {
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173,
			'Variable' => 171,
			'Literal' => 120,
			'HashReference' => 128,
			'Operator' => 91,
			'SubExpression' => 185,
			'HashDereference' => 89
		}
	},
	{#State 110
		DEFAULT => -120
	},
	{#State 111
		ACTIONS => {
			'VARIABLE_SYMBOL' => 131,
			'SELF' => 104
		},
		GOTOS => {
			'Variable' => 186,
			'VariableSymbolOrSelf' => 116
		}
	},
	{#State 112
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			"]" => -191,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LPAREN' => 129,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LBRACKET' => 112,
			'MY' => 179,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ListElements' => 187,
			'ArrayReference' => 127,
			'OPTIONAL-46' => 192,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'ListElement' => 190,
			'TypeInner' => 189,
			'Variable' => 171,
			'SubExpression' => 188,
			'HashDereference' => 89,
			'Operator' => 91,
			'HashReference' => 128,
			'Literal' => 120
		}
	},
	{#State 113
		ACTIONS => {
			'WORD_UPPERCASE' => 194
		},
		GOTOS => {
			'LoopLabel' => 193
		}
	},
	{#State 114
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'MY' => 179,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ListElements' => 195,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'ListElement' => 190,
			'TypeInner' => 189,
			'Variable' => 171,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Operator' => 91,
			'SubExpression' => 188,
			'Literal' => 120
		}
	},
	{#State 115
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_FHREF' => 197,
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 196
		}
	},
	{#State 116
		DEFAULT => -172,
		GOTOS => {
			'STAR-43' => 198
		}
	},
	{#State 117
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'OP01_OPEN' => 100,
			"undef" => 123,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'MY' => 179,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'OP22_LOGICAL_NEG' => 132,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129
		},
		GOTOS => {
			'Expression' => 173,
			'ArrayDereference' => 125,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'SubExpression' => 200,
			'Operator' => 91,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Literal' => 120,
			'ListElement' => 199,
			'TypeInner' => 189,
			'Variable' => 171
		}
	},
	{#State 118
		ACTIONS => {
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'Literal' => 120,
			'HashDereference' => 89,
			'SubExpression' => 201,
			'Operator' => 91,
			'HashReference' => 128,
			'Variable' => 171
		}
	},
	{#State 119
		ACTIONS => {
			'LPAREN' => 202,
			'COLON' => -213
		}
	},
	{#State 120
		DEFAULT => -134
	},
	{#State 121
		DEFAULT => -128
	},
	{#State 122
		ACTIONS => {
			'LBRACKET' => -194,
			'MY' => 179,
			'SELF' => 104,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 116,
			'OPTIONAL-47' => 204,
			'Variable' => 203,
			'TypeInner' => 205
		}
	},
	{#State 123
		DEFAULT => -133
	},
	{#State 124
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP19_VARIABLE_ASSIGN_BY' => 208,
			'OP15_LOGICAL_AND' => -135,
			")" => -135,
			'OP08_STRING_CAT' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP03_MATH_INC_DEC' => 207,
			'OP08_MATH_ADD_SUB' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP19_VARIABLE_ASSIGN' => 206,
			'OP04_MATH_POW' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP02_METHOD_THINARROW' => 209,
			'OP17_LIST_RANGE' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP18_TERNARY' => -135
		}
	},
	{#State 125
		DEFAULT => -137
	},
	{#State 126
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -111,
			'WORD' => -111,
			'LBRACKET' => -111,
			'OP22_LOGICAL_NEG' => -111,
			'VARIABLE_SYMBOL' => -111,
			'OP01_QW' => -111,
			'LPAREN' => -111,
			'OP01_NAMED' => -111,
			'OP05_LOGICAL_NEG' => -111,
			'STDOUT_STDERR' => 213,
			'MY' => -111,
			"undef" => -111,
			'OP01_OPEN' => -111,
			"\@{" => -111,
			'CONSTANT_CALL_SCOPED' => -111,
			'OP10_NAMED_UNARY' => -111,
			'LITERAL_STRING' => -111,
			'WORD_UPPERCASE' => -111,
			'LBRACE' => -111,
			'WORD_SCOPED' => -111,
			'FHREF_SYMBOL_BRACES' => 212,
			'OP05_MATH_NEG_LPAREN' => -111,
			'OP01_CLOSE' => -111,
			'SELF' => -111,
			"%{" => -111,
			'LITERAL_NUMBER' => -111
		},
		GOTOS => {
			'PAREN-31' => 210,
			'OPTIONAL-32' => 211
		}
	},
	{#State 127
		DEFAULT => -136
	},
	{#State 128
		DEFAULT => -138
	},
	{#State 129
		ACTIONS => {
			'OP01_NAMED' => 216,
			'OP05_LOGICAL_NEG' => 118,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP01_CLOSE' => 107,
			'OP01_PRINT' => 214,
			'OP05_MATH_NEG_LPAREN' => 109,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121
		},
		GOTOS => {
			'Variable' => 171,
			'Literal' => 120,
			'Operator' => 91,
			'SubExpression' => 215,
			'HashDereference' => 89,
			'HashReference' => 128,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 130
		DEFAULT => -79
	},
	{#State 131
		DEFAULT => -226
	},
	{#State 132
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'SubExpression' => 217,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Operator' => 91,
			'Literal' => 120,
			'Variable' => 171,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127
		}
	},
	{#State 133
		ACTIONS => {
			'MY' => 179,
			")" => -113,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'LPAREN' => 129,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123
		},
		GOTOS => {
			'HashReference' => 128,
			'SubExpression' => 188,
			'Operator' => 91,
			'HashDereference' => 89,
			'Literal' => 120,
			'ListElement' => 190,
			'Variable' => 171,
			'TypeInner' => 189,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'OPTIONAL-33' => 218,
			'ArrayReference' => 127,
			'ListElements' => 219
		}
	},
	{#State 134
		ACTIONS => {
			"for" => 221,
			"foreach" => 224,
			"while" => 222
		},
		GOTOS => {
			'LoopForEach' => 223,
			'LoopFor' => 225,
			'Loop' => 226,
			'LoopWhile' => 220
		}
	},
	{#State 135
		DEFAULT => -14
	},
	{#State 136
		ACTIONS => {
			'COLON' => 227
		}
	},
	{#State 137
		ACTIONS => {
			'WORD_UPPERCASE' => 228
		}
	},
	{#State 138
		DEFAULT => -43
	},
	{#State 139
		ACTIONS => {
			'VARIABLE_SYMBOL' => 229
		}
	},
	{#State 140
		ACTIONS => {
			"for" => -147,
			'OP01_NAMED_VOID' => 114,
			'MY' => 115,
			'OP01_NAMED' => 117,
			"while" => -147,
			"}" => 230,
			'OP05_LOGICAL_NEG' => 118,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP19_LOOP_CONTROL' => 113,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"foreach" => -147,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			"if" => 90,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'OP01_NAMED_VOID_LPAREN' => 133,
			'OP01_PRINT' => 126,
			'WORD_UPPERCASE' => 119,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123
		},
		GOTOS => {
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'ArrayDereference' => 125,
			'OperatorVoid' => 105,
			'Conditional' => 106,
			'Expression' => 101,
			'Variable' => 124,
			'VariableDeclaration' => 99,
			'Literal' => 120,
			'PAREN-36' => 96,
			'Operation' => 231,
			'VariableModification' => 93,
			'Operator' => 91,
			'SubExpression' => 92,
			'HashDereference' => 89,
			'VariableSymbolOrSelf' => 116,
			'LoopLabel' => 136,
			'OPTIONAL-37' => 134,
			'Statement' => 130,
			'HashReference' => 128
		}
	},
	{#State 141
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 232
		}
	},
	{#State 142
		DEFAULT => -57
	},
	{#State 143
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 233
		}
	},
	{#State 144
		ACTIONS => {
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170
		},
		GOTOS => {
			'Expression' => 173,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'HashDereference' => 89,
			'SubExpression' => 234,
			'Operator' => 91,
			'HashReference' => 128,
			'Literal' => 120,
			'Variable' => 171
		}
	},
	{#State 145
		ACTIONS => {
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP22_LOGICAL_NEG' => 132,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'Variable' => 171,
			'Literal' => 120,
			'SubExpression' => 235,
			'HashReference' => 128,
			'Operator' => 91,
			'HashDereference' => 89,
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 146
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP22_LOGICAL_NEG' => 132,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129
		},
		GOTOS => {
			'Variable' => 171,
			'Literal' => 120,
			'HashDereference' => 89,
			'SubExpression' => 236,
			'HashReference' => 128,
			'Operator' => 91,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 147
		ACTIONS => {
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP22_LOGICAL_NEG' => 132,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'Variable' => 171,
			'SubExpression' => 237,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Operator' => 91,
			'Literal' => 120
		}
	},
	{#State 148
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 132,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104
		},
		GOTOS => {
			'HashReference' => 128,
			'Operator' => 91,
			'SubExpression' => 238,
			'HashDereference' => 89,
			'Literal' => 120,
			'Variable' => 171,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127
		}
	},
	{#State 149
		ACTIONS => {
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123
		},
		GOTOS => {
			'Operator' => 91,
			'HashReference' => 128,
			'SubExpression' => 239,
			'HashDereference' => 89,
			'Literal' => 120,
			'Variable' => 171,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127
		}
	},
	{#State 150
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 240
		}
	},
	{#State 151
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP22_LOGICAL_NEG' => 132,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118
		},
		GOTOS => {
			'Literal' => 120,
			'SubExpression' => 241,
			'HashReference' => 128,
			'Operator' => 91,
			'HashDereference' => 89,
			'Variable' => 171,
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108
		}
	},
	{#State 152
		ACTIONS => {
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'Literal' => 120,
			'SubExpression' => 242,
			'Operator' => 91,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Variable' => 171
		}
	},
	{#State 153
		ACTIONS => {
			'VARIABLE_SYMBOL' => 131,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 116,
			'Variable' => 244,
			'VariableOrLiteral' => 243,
			'Literal' => 245
		}
	},
	{#State 154
		ACTIONS => {
			'OP01_OPEN' => 100,
			"undef" => 123,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'SELF' => 104,
			"%{" => 103,
			'LITERAL_NUMBER' => 83,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP22_LOGICAL_NEG' => 132,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'Expression' => 173,
			'ArrayDereference' => 125,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 246,
			'Literal' => 120,
			'Variable' => 171
		}
	},
	{#State 155
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP22_LOGICAL_NEG' => 132,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'Expression' => 173,
			'ArrayDereference' => 125,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'SubExpression' => 247,
			'Operator' => 91,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Literal' => 120,
			'Variable' => 171
		}
	},
	{#State 156
		ACTIONS => {
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95
		},
		GOTOS => {
			'Literal' => 120,
			'Operator' => 91,
			'HashReference' => 128,
			'HashDereference' => 89,
			'SubExpression' => 248,
			'Variable' => 171,
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116
		}
	},
	{#State 157
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP22_LOGICAL_NEG' => 132,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			'OP01_OPEN' => 100,
			"undef" => 123,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'Variable' => 171,
			'Operator' => 91,
			'SubExpression' => 249,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Literal' => 120
		}
	},
	{#State 158
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'Variable' => 171,
			'HashReference' => 128,
			'SubExpression' => 250,
			'HashDereference' => 89,
			'Operator' => 91,
			'Literal' => 120,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125
		}
	},
	{#State 159
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP22_LOGICAL_NEG' => 132,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'Operator' => 91,
			'HashReference' => 128,
			'SubExpression' => 251,
			'HashDereference' => 89,
			'Literal' => 120,
			'Variable' => 171,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127
		}
	},
	{#State 160
		ACTIONS => {
			'SELF' => 104,
			"%{" => 103,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP22_LOGICAL_NEG' => 132
		},
		GOTOS => {
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173,
			'Variable' => 171,
			'Literal' => 120,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 252
		}
	},
	{#State 161
		ACTIONS => {
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP22_LOGICAL_NEG' => 132,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayDereference' => 125,
			'Expression' => 173,
			'Variable' => 171,
			'Literal' => 120,
			'SubExpression' => 253,
			'HashReference' => 128,
			'Operator' => 91,
			'HashDereference' => 89
		}
	},
	{#State 162
		DEFAULT => -152
	},
	{#State 163
		DEFAULT => -225
	},
	{#State 164
		DEFAULT => -206
	},
	{#State 165
		DEFAULT => -204,
		GOTOS => {
			'STAR-50' => 254
		}
	},
	{#State 166
		DEFAULT => -200
	},
	{#State 167
		ACTIONS => {
			'OP20_HASH_FATARROW' => 255
		}
	},
	{#State 168
		DEFAULT => -223
	},
	{#State 169
		DEFAULT => -224
	},
	{#State 170
		ACTIONS => {
			'LPAREN' => 202
		}
	},
	{#State 171
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -135,
			'OP02_METHOD_THINARROW' => 209,
			'OP04_MATH_POW' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP18_TERNARY' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP16_LOGICAL_OR' => -135,
			"]" => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP03_MATH_INC_DEC' => 207,
			'OP12_COMPARE_EQ_NE' => -135,
			";" => -135,
			'OP13_BITWISE_AND' => -135,
			'OP15_LOGICAL_AND' => -135,
			")" => -135,
			'OP21_LIST_COMMA' => -135,
			"}" => -135,
			'OP08_STRING_CAT' => -135,
			'OP24_LOGICAL_OR_XOR' => -135
		}
	},
	{#State 172
		ACTIONS => {
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"undef" => 123,
			"\@{" => 122,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'OP22_LOGICAL_NEG' => 132
		},
		GOTOS => {
			'Variable' => 171,
			'SubExpression' => 256,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Operator' => 91,
			'Literal' => 120,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125
		}
	},
	{#State 173
		DEFAULT => -132
	},
	{#State 174
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -96,
			'OP04_MATH_POW' => 161,
			'OP17_LIST_RANGE' => -96,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -96,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => -96,
			"]" => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP06_REGEX_MATCH' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => -96,
			'OP09_BITWISE_SHIFT' => 159,
			'OP12_COMPARE_EQ_NE' => -96,
			";" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP15_LOGICAL_AND' => -96,
			")" => -96,
			'OP21_LIST_COMMA' => -96,
			"}" => -96,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => -96
		}
	},
	{#State 175
		ACTIONS => {
			'TYPE_FHREF' => 257
		}
	},
	{#State 176
		DEFAULT => -78
	},
	{#State 177
		DEFAULT => -16
	},
	{#State 178
		DEFAULT => -207
	},
	{#State 179
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 258
		}
	},
	{#State 180
		ACTIONS => {
			"}" => 259
		}
	},
	{#State 181
		ACTIONS => {
			'LBRACE' => 95
		},
		GOTOS => {
			'HashReference' => 260
		}
	},
	{#State 182
		DEFAULT => -84
	},
	{#State 183
		ACTIONS => {
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'MY' => 179,
			")" => -123,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'LPAREN' => 129,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27
		},
		GOTOS => {
			'TypeInner' => 189,
			'Variable' => 171,
			'ListElement' => 190,
			'Literal' => 120,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 188,
			'OPTIONAL-34' => 261,
			'HashReference' => 128,
			'ListElements' => 262,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 184
		ACTIONS => {
			")" => 263
		}
	},
	{#State 185
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP17_LIST_RANGE' => 154,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 146,
			")" => 264
		}
	},
	{#State 186
		DEFAULT => -85
	},
	{#State 187
		DEFAULT => -190
	},
	{#State 188
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP17_LIST_RANGE' => 154,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -187,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP09_BITWISE_SHIFT' => 159,
			'OP13_BITWISE_AND' => 155,
			";" => -187,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 146,
			")" => -187,
			'OP21_LIST_COMMA' => -187
		}
	},
	{#State 189
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'SELF' => 104,
			"%{" => 103,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'HashReference' => 128,
			'SubExpression' => 265,
			'HashDereference' => 89,
			'Operator' => 91,
			'Literal' => 120,
			'Variable' => 171,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127
		}
	},
	{#State 190
		DEFAULT => -185,
		GOTOS => {
			'STAR-45' => 266
		}
	},
	{#State 191
		DEFAULT => -189
	},
	{#State 192
		ACTIONS => {
			"]" => 267
		}
	},
	{#State 193
		ACTIONS => {
			";" => 268
		}
	},
	{#State 194
		DEFAULT => -213
	},
	{#State 195
		ACTIONS => {
			";" => 269
		}
	},
	{#State 196
		ACTIONS => {
			'VARIABLE_SYMBOL' => 270
		}
	},
	{#State 197
		ACTIONS => {
			'FHREF_SYMBOL' => 271
		}
	},
	{#State 198
		ACTIONS => {
			'OP02_HASH_THINARROW' => 273,
			'OP08_MATH_ADD_SUB' => -173,
			"]" => -173,
			'OP16_LOGICAL_OR' => -173,
			'OP11_COMPARE_LT_GT' => -173,
			'OP06_REGEX_MATCH' => -173,
			'OP19_VARIABLE_ASSIGN' => -173,
			'OP04_MATH_POW' => -173,
			'OP14_BITWISE_OR_XOR' => -173,
			'OP02_METHOD_THINARROW' => -173,
			'OP17_LIST_RANGE' => -173,
			'OP18_TERNARY' => -173,
			'OP07_STRING_REPEAT' => -173,
			'OP12_COMPARE_EQ_NE' => -173,
			'OP19_VARIABLE_ASSIGN_BY' => -173,
			";" => -173,
			'OP13_BITWISE_AND' => -173,
			")" => -173,
			'COLON' => -173,
			'OP21_LIST_COMMA' => -173,
			'OP15_LOGICAL_AND' => -173,
			'OP24_LOGICAL_OR_XOR' => -173,
			'OP08_STRING_CAT' => -173,
			"}" => -173,
			'OP20_HASH_FATARROW' => -173,
			'OP07_MATH_MULT_DIV_MOD' => -173,
			'OP23_LOGICAL_AND' => -173,
			'OP03_MATH_INC_DEC' => -173,
			'OP09_BITWISE_SHIFT' => -173,
			'OP02_ARRAY_THINARROW' => 274
		},
		GOTOS => {
			'VariableRetrieval' => 272
		}
	},
	{#State 199
		ACTIONS => {
			'OP21_LIST_COMMA' => 275
		}
	},
	{#State 200
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP04_MATH_POW' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP18_TERNARY' => -81,
			'OP17_LIST_RANGE' => -81,
			'OP13_BITWISE_AND' => -81,
			";" => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP08_STRING_CAT' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP15_LOGICAL_AND' => -81,
			")" => -81,
			'OP21_LIST_COMMA' => -187,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP09_BITWISE_SHIFT' => -81
		}
	},
	{#State 201
		ACTIONS => {
			'OP13_BITWISE_AND' => -88,
			";" => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			"}" => -88,
			'OP08_STRING_CAT' => -88,
			'OP21_LIST_COMMA' => -88,
			")" => -88,
			'OP15_LOGICAL_AND' => -88,
			'OP23_LOGICAL_AND' => -88,
			'OP07_MATH_MULT_DIV_MOD' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			'OP16_LOGICAL_OR' => -88,
			"]" => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP06_REGEX_MATCH' => -88,
			'OP14_BITWISE_OR_XOR' => -88,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => -88,
			'OP07_STRING_REPEAT' => -88,
			'OP17_LIST_RANGE' => -88
		}
	},
	{#State 202
		ACTIONS => {
			")" => 276
		}
	},
	{#State 203
		ACTIONS => {
			"}" => 277
		}
	},
	{#State 204
		ACTIONS => {
			'LBRACKET' => 112
		},
		GOTOS => {
			'ArrayReference' => 278
		}
	},
	{#State 205
		DEFAULT => -193
	},
	{#State 206
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'CONSTANT_CALL_SCOPED' => 121,
			'STDIN' => 281,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"undef" => 123,
			"\@{" => 122,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP22_LOGICAL_NEG' => 132,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'SubExpressionOrStdin' => 279,
			'Variable' => 171,
			'Literal' => 120,
			'Operator' => 91,
			'HashReference' => 128,
			'SubExpression' => 280,
			'HashDereference' => 89,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 207
		DEFAULT => -86
	},
	{#State 208
		ACTIONS => {
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'Literal' => 120,
			'SubExpression' => 282,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Operator' => 91,
			'Variable' => 171
		}
	},
	{#State 209
		ACTIONS => {
			'LPAREN' => 283
		}
	},
	{#State 210
		DEFAULT => -110
	},
	{#State 211
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'MY' => 179,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP22_LOGICAL_NEG' => 132,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_QW' => 191
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'ListElements' => 284,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'ListElement' => 190,
			'TypeInner' => 189,
			'Variable' => 171,
			'SubExpression' => 188,
			'Operator' => 91,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Literal' => 120
		}
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => 131,
			'OP01_QW' => 191,
			'LPAREN' => 129,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'MY' => 179,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109
		},
		GOTOS => {
			'Expression' => 173,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ListElements' => 285,
			'ArrayReference' => 127,
			'SubExpression' => 188,
			'HashReference' => 128,
			'Operator' => 91,
			'HashDereference' => 89,
			'Literal' => 120,
			'ListElement' => 190,
			'Variable' => 171,
			'TypeInner' => 189
		}
	},
	{#State 213
		DEFAULT => -109
	},
	{#State 214
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 286
		}
	},
	{#State 215
		ACTIONS => {
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP18_TERNARY' => 153,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => 154,
			'OP16_LOGICAL_OR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP08_STRING_CAT' => 145,
			")" => 287,
			'OP15_LOGICAL_AND' => 146
		}
	},
	{#State 216
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LPAREN' => 129,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131,
			'MY' => 179,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'ListElement' => 288,
			'TypeInner' => 189,
			'Variable' => 171,
			'Operator' => 91,
			'HashReference' => 128,
			'SubExpression' => 200,
			'HashDereference' => 89,
			'Literal' => 120
		}
	},
	{#State 217
		ACTIONS => {
			'OP06_REGEX_MATCH' => 150,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -106,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP15_LOGICAL_AND' => 146,
			")" => -106,
			'OP21_LIST_COMMA' => -106,
			"}" => -106,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP12_COMPARE_EQ_NE' => 156,
			";" => -106,
			'OP13_BITWISE_AND' => 155,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => -106,
			'OP07_MATH_MULT_DIV_MOD' => 158
		}
	},
	{#State 218
		ACTIONS => {
			")" => 289
		}
	},
	{#State 219
		DEFAULT => -112
	},
	{#State 220
		DEFAULT => -162
	},
	{#State 221
		ACTIONS => {
			'LPAREN_MY' => 291,
			'MY' => 290
		}
	},
	{#State 222
		ACTIONS => {
			'LPAREN' => 293,
			'LPAREN_MY' => 292
		}
	},
	{#State 223
		DEFAULT => -161
	},
	{#State 224
		ACTIONS => {
			'MY' => 294
		}
	},
	{#State 225
		DEFAULT => -160
	},
	{#State 226
		DEFAULT => -149
	},
	{#State 227
		DEFAULT => -145
	},
	{#State 228
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 295
		}
	},
	{#State 229
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 296
		}
	},
	{#State 230
		ACTIONS => {
			";" => 297
		}
	},
	{#State 231
		DEFAULT => -46
	},
	{#State 232
		ACTIONS => {
			'LBRACE' => 298
		}
	},
	{#State 233
		ACTIONS => {
			"our" => 303,
			'LITERAL_NUMBER' => 301
		},
		GOTOS => {
			'Method' => 299,
			'MethodOrSubroutine' => 302,
			'Subroutine' => 300
		}
	},
	{#State 234
		ACTIONS => {
			'OP15_LOGICAL_AND' => 146,
			")" => 304,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP09_BITWISE_SHIFT' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP06_REGEX_MATCH' => 150,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161
		}
	},
	{#State 235
		ACTIONS => {
			'OP13_BITWISE_AND' => -94,
			";" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			"}" => -94,
			'OP08_STRING_CAT' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP21_LIST_COMMA' => -94,
			")" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP16_LOGICAL_OR' => -94,
			"]" => -94,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -94,
			'OP17_LIST_RANGE' => -94
		}
	},
	{#State 236
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP08_STRING_CAT' => 145,
			"}" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP15_LOGICAL_AND' => -102,
			")" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP13_BITWISE_AND' => 155,
			";" => -102,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -102,
			'OP17_LIST_RANGE' => -102,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP06_REGEX_MATCH' => 150,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -102,
			'OP16_LOGICAL_OR' => -102,
			'OP08_MATH_ADD_SUB' => 160
		}
	},
	{#State 237
		ACTIONS => {
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -107,
			'OP16_LOGICAL_OR' => 149,
			'OP06_REGEX_MATCH' => 150,
			'OP23_LOGICAL_AND' => -107,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP12_COMPARE_EQ_NE' => 156,
			";" => -107,
			'OP13_BITWISE_AND' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP21_LIST_COMMA' => -107,
			")" => -107,
			"}" => -107,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => -107
		}
	},
	{#State 238
		ACTIONS => {
			'OP16_LOGICAL_OR' => -98,
			"]" => -98,
			'OP11_COMPARE_LT_GT' => undef,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP18_TERNARY' => -98,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => -98,
			'OP13_BITWISE_AND' => -98,
			";" => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			"}" => -98,
			'OP08_STRING_CAT' => 145,
			'OP21_LIST_COMMA' => -98,
			")" => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP09_BITWISE_SHIFT' => 159
		}
	},
	{#State 239
		ACTIONS => {
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -103,
			'OP17_LIST_RANGE' => -103,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -103,
			'OP16_LOGICAL_OR' => -103,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP23_LOGICAL_AND' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP13_BITWISE_AND' => 155,
			";" => -103,
			'OP12_COMPARE_EQ_NE' => 156,
			"}" => -103,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP15_LOGICAL_AND' => 146,
			")" => -103,
			'OP21_LIST_COMMA' => -103
		}
	},
	{#State 240
		DEFAULT => -90
	},
	{#State 241
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP21_LIST_COMMA' => -101,
			")" => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			"}" => -101,
			'OP08_STRING_CAT' => 145,
			'OP12_COMPARE_EQ_NE' => 156,
			";" => -101,
			'OP13_BITWISE_AND' => 155,
			'OP17_LIST_RANGE' => -101,
			'OP18_TERNARY' => -101,
			'OP07_STRING_REPEAT' => 152,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP04_MATH_POW' => 161,
			'OP06_REGEX_MATCH' => 150,
			'OP08_MATH_ADD_SUB' => 160,
			'OP16_LOGICAL_OR' => -101,
			"]" => -101,
			'OP11_COMPARE_LT_GT' => 148
		}
	},
	{#State 242
		ACTIONS => {
			'OP06_REGEX_MATCH' => 150,
			'OP16_LOGICAL_OR' => -91,
			"]" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP18_TERNARY' => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			"}" => -91,
			'OP08_STRING_CAT' => -91,
			'OP21_LIST_COMMA' => -91,
			")" => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP13_BITWISE_AND' => -91,
			";" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP23_LOGICAL_AND' => -91
		}
	},
	{#State 243
		ACTIONS => {
			'COLON' => 305
		}
	},
	{#State 244
		DEFAULT => -221
	},
	{#State 245
		DEFAULT => -222
	},
	{#State 246
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => -104,
			'OP15_LOGICAL_AND' => 146,
			'OP21_LIST_COMMA' => -104,
			")" => -104,
			'OP08_STRING_CAT' => 145,
			"}" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP12_COMPARE_EQ_NE' => 156,
			";" => -104,
			'OP13_BITWISE_AND' => 155,
			'OP17_LIST_RANGE' => undef,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -104,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 150,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			"]" => -104
		}
	},
	{#State 247
		ACTIONS => {
			'OP06_REGEX_MATCH' => 150,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => -100,
			"]" => -100,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => -100,
			"}" => -100,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP21_LIST_COMMA' => -100,
			")" => -100,
			'OP13_BITWISE_AND' => -100,
			";" => -100,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 158
		}
	},
	{#State 248
		ACTIONS => {
			'OP06_REGEX_MATCH' => 150,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => -99,
			"]" => -99,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => -99,
			"}" => -99,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			")" => -99,
			'OP21_LIST_COMMA' => -99,
			'OP13_BITWISE_AND' => -99,
			";" => -99,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 158
		}
	},
	{#State 249
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP08_STRING_CAT' => 145,
			"}" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP15_LOGICAL_AND' => 146,
			'OP21_LIST_COMMA' => -108,
			")" => -108,
			'OP13_BITWISE_AND' => 155,
			";" => -108,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP17_LIST_RANGE' => 154,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 150,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -108,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160
		}
	},
	{#State 250
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -92,
			'OP16_LOGICAL_OR' => -92,
			"]" => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP06_REGEX_MATCH' => 150,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP13_BITWISE_AND' => -92,
			";" => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			"}" => -92,
			'OP08_STRING_CAT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP21_LIST_COMMA' => -92,
			")" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP09_BITWISE_SHIFT' => -92
		}
	},
	{#State 251
		ACTIONS => {
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -95,
			'OP17_LIST_RANGE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			"]" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => -95,
			'OP09_BITWISE_SHIFT' => -95,
			'OP13_BITWISE_AND' => -95,
			";" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"}" => -95,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			")" => -95
		}
	},
	{#State 252
		ACTIONS => {
			'OP17_LIST_RANGE' => -93,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -93,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP06_REGEX_MATCH' => 150,
			'OP08_MATH_ADD_SUB' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP16_LOGICAL_OR' => -93,
			"]" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP15_LOGICAL_AND' => -93,
			")" => -93,
			'OP21_LIST_COMMA' => -93,
			'OP08_STRING_CAT' => -93,
			"}" => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			";" => -93,
			'OP13_BITWISE_AND' => -93
		}
	},
	{#State 253
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP12_COMPARE_EQ_NE' => -87,
			";" => -87,
			'OP13_BITWISE_AND' => -87,
			'OP15_LOGICAL_AND' => -87,
			")" => -87,
			'OP21_LIST_COMMA' => -87,
			'OP08_STRING_CAT' => -87,
			"}" => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP14_BITWISE_OR_XOR' => -87,
			'OP04_MATH_POW' => 161,
			'OP17_LIST_RANGE' => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP18_TERNARY' => -87,
			'OP08_MATH_ADD_SUB' => -87,
			'OP11_COMPARE_LT_GT' => -87,
			"]" => -87,
			'OP16_LOGICAL_OR' => -87,
			'OP06_REGEX_MATCH' => -87
		}
	},
	{#State 254
		ACTIONS => {
			"}" => 307,
			'OP21_LIST_COMMA' => 306
		},
		GOTOS => {
			'PAREN-49' => 308
		}
	},
	{#State 255
		ACTIONS => {
			'OP01_CLOSE' => -198,
			'OP05_MATH_NEG_LPAREN' => -198,
			'LITERAL_NUMBER' => -198,
			'SELF' => -198,
			"%{" => -198,
			"\@{" => -198,
			'OP01_OPEN' => -198,
			"undef" => -198,
			'LITERAL_STRING' => -198,
			'OP10_NAMED_UNARY' => -198,
			'CONSTANT_CALL_SCOPED' => -198,
			'LBRACE' => -198,
			'WORD_UPPERCASE' => -198,
			'WORD_SCOPED' => -198,
			'OP05_LOGICAL_NEG' => -198,
			'OP01_NAMED' => -198,
			'MY' => 179,
			'OP22_LOGICAL_NEG' => -198,
			'WORD' => -198,
			'OP03_MATH_INC_DEC' => -198,
			'LBRACKET' => -198,
			'VARIABLE_SYMBOL' => -198,
			'LPAREN' => -198
		},
		GOTOS => {
			'TypeInner' => 309,
			'OPTIONAL-48' => 310
		}
	},
	{#State 256
		ACTIONS => {
			'OP17_LIST_RANGE' => -81,
			'OP18_TERNARY' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP04_MATH_POW' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP16_LOGICAL_OR' => -81,
			"]" => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			")" => -81,
			'OP21_LIST_COMMA' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			"}" => -81,
			'OP08_STRING_CAT' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			";" => -81,
			'OP13_BITWISE_AND' => -81
		}
	},
	{#State 257
		ACTIONS => {
			'FHREF_SYMBOL' => 311
		}
	},
	{#State 258
		ACTIONS => {
			"\$TYPED_" => 312
		}
	},
	{#State 259
		DEFAULT => -209
	},
	{#State 260
		ACTIONS => {
			"}" => 313
		}
	},
	{#State 261
		ACTIONS => {
			")" => 314
		}
	},
	{#State 262
		DEFAULT => -122
	},
	{#State 263
		DEFAULT => -131
	},
	{#State 264
		DEFAULT => -89
	},
	{#State 265
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP09_BITWISE_SHIFT' => 159,
			'OP12_COMPARE_EQ_NE' => 156,
			";" => -188,
			'OP13_BITWISE_AND' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP21_LIST_COMMA' => -188,
			")" => -188,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			"]" => -188,
			'OP16_LOGICAL_OR' => 149,
			'OP06_REGEX_MATCH' => 150
		}
	},
	{#State 266
		ACTIONS => {
			")" => -186,
			'OP21_LIST_COMMA' => 316,
			"]" => -186,
			";" => -186
		},
		GOTOS => {
			'PAREN-44' => 315
		}
	},
	{#State 267
		DEFAULT => -192
	},
	{#State 268
		DEFAULT => -121
	},
	{#State 269
		DEFAULT => -118
	},
	{#State 270
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 319,
			";" => 317,
			'OP02_ARRAY_THINARROW' => 318
		}
	},
	{#State 271
		ACTIONS => {
			";" => 320
		}
	},
	{#State 272
		DEFAULT => -171
	},
	{#State 273
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 321,
			'LBRACKET' => 112,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'Variable' => 171,
			'HashReference' => 128,
			'SubExpression' => 322,
			'HashDereference' => 89,
			'Operator' => 91,
			'Literal' => 120
		}
	},
	{#State 274
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'Variable' => 171,
			'SubExpression' => 323,
			'HashDereference' => 89,
			'Operator' => 91,
			'HashReference' => 128,
			'Literal' => 120
		}
	},
	{#State 275
		ACTIONS => {
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'MY' => 179,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_QW' => 191,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ListElements' => 324,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'Literal' => 120,
			'Operator' => 91,
			'HashReference' => 128,
			'SubExpression' => 188,
			'HashDereference' => 89,
			'TypeInner' => 189,
			'Variable' => 171,
			'ListElement' => 190
		}
	},
	{#State 276
		DEFAULT => -127
	},
	{#State 277
		DEFAULT => -195
	},
	{#State 278
		ACTIONS => {
			"}" => 325
		}
	},
	{#State 279
		DEFAULT => -181
	},
	{#State 280
		ACTIONS => {
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP06_REGEX_MATCH' => 150,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP15_LOGICAL_AND' => 146,
			")" => -141,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP12_COMPARE_EQ_NE' => 156,
			";" => -141,
			'OP13_BITWISE_AND' => 155
		}
	},
	{#State 281
		DEFAULT => -142
	},
	{#State 282
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 146,
			")" => -182,
			'OP13_BITWISE_AND' => 155,
			";" => -182,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP17_LIST_RANGE' => 154,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 150,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160
		}
	},
	{#State 283
		ACTIONS => {
			'SELF' => 104,
			"%{" => 103,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			")" => -125,
			'MY' => 179,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP22_LOGICAL_NEG' => 132
		},
		GOTOS => {
			'ListElements' => 326,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173,
			'TypeInner' => 189,
			'OPTIONAL-35' => 327,
			'Variable' => 171,
			'ListElement' => 190,
			'Literal' => 120,
			'HashReference' => 128,
			'Operator' => 91,
			'SubExpression' => 188,
			'HashDereference' => 89
		}
	},
	{#State 284
		ACTIONS => {
			";" => 328
		}
	},
	{#State 285
		ACTIONS => {
			";" => 329
		}
	},
	{#State 286
		ACTIONS => {
			'MY' => 179,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_QW' => 191,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123
		},
		GOTOS => {
			'TypeInner' => 189,
			'Variable' => 171,
			'ListElement' => 190,
			'Literal' => 120,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 188,
			'HashReference' => 128,
			'ArrayReference' => 127,
			'ListElements' => 330,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 287
		DEFAULT => -140
	},
	{#State 288
		ACTIONS => {
			'OP21_LIST_COMMA' => 331
		}
	},
	{#State 289
		ACTIONS => {
			";" => 332
		}
	},
	{#State 290
		ACTIONS => {
			'TYPE_INTEGER' => 333
		}
	},
	{#State 291
		ACTIONS => {
			'TYPE_INTEGER' => 334
		}
	},
	{#State 292
		ACTIONS => {
			'TYPE_INTEGER' => 54,
			'WORD' => 53,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 335
		}
	},
	{#State 293
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"undef" => 123,
			"\@{" => 122,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118
		},
		GOTOS => {
			'Variable' => 171,
			'SubExpression' => 336,
			'Operator' => 91,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Literal' => 120,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125
		}
	},
	{#State 294
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 337
		}
	},
	{#State 295
		DEFAULT => -220
	},
	{#State 296
		ACTIONS => {
			")" => 339,
			'OP21_LIST_COMMA' => 340
		},
		GOTOS => {
			'PAREN-19' => 338
		}
	},
	{#State 297
		DEFAULT => -48
	},
	{#State 298
		ACTIONS => {
			'WORD' => 342,
			"}" => 341
		},
		GOTOS => {
			'HashEntryProperties' => 343
		}
	},
	{#State 299
		DEFAULT => -76
	},
	{#State 300
		DEFAULT => -77
	},
	{#State 301
		ACTIONS => {
			";" => 344
		}
	},
	{#State 302
		DEFAULT => -59
	},
	{#State 303
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 54,
			'TYPE_METHOD' => 345,
			'WORD_SCOPED' => 55
		},
		GOTOS => {
			'Type' => 56
		}
	},
	{#State 304
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 347
		}
	},
	{#State 305
		ACTIONS => {
			'VARIABLE_SYMBOL' => 131,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 116,
			'Variable' => 244,
			'VariableOrLiteral' => 348,
			'Literal' => 245
		}
	},
	{#State 306
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'WORD' => 163,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 167,
			'HashDereference' => 166,
			'Literal' => 169,
			'VariableSymbolOrSelf' => 116,
			'HashEntry' => 349,
			'Variable' => 168
		}
	},
	{#State 307
		DEFAULT => -205
	},
	{#State 308
		DEFAULT => -203
	},
	{#State 309
		DEFAULT => -197
	},
	{#State 310
		ACTIONS => {
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'Literal' => 120,
			'Operator' => 91,
			'HashReference' => 128,
			'SubExpression' => 350,
			'HashDereference' => 89,
			'Variable' => 171
		}
	},
	{#State 311
		ACTIONS => {
			'OP21_LIST_COMMA' => 351
		}
	},
	{#State 312
		ACTIONS => {
			'WORD' => 352
		}
	},
	{#State 313
		DEFAULT => -210
	},
	{#State 314
		DEFAULT => -129
	},
	{#State 315
		DEFAULT => -184
	},
	{#State 316
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'MY' => 179,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83
		},
		GOTOS => {
			'Expression' => 173,
			'ArrayDereference' => 125,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'HashReference' => 128,
			'SubExpression' => 188,
			'HashDereference' => 89,
			'Operator' => 91,
			'Literal' => 120,
			'ListElement' => 353,
			'TypeInner' => 189,
			'Variable' => 171
		}
	},
	{#State 317
		DEFAULT => -177
	},
	{#State 318
		ACTIONS => {
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109
		},
		GOTOS => {
			'Variable' => 171,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 354,
			'Literal' => 120,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125
		}
	},
	{#State 319
		ACTIONS => {
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'OP22_LOGICAL_NEG' => 132,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'STDIN' => 281,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'Variable' => 171,
			'SubExpressionOrStdin' => 355,
			'SubExpression' => 280,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Operator' => 91,
			'Literal' => 120
		}
	},
	{#State 320
		DEFAULT => -180
	},
	{#State 321
		ACTIONS => {
			"}" => 356,
			'OP02_METHOD_THINARROW_NEW' => -211,
			'LPAREN' => -211
		}
	},
	{#State 322
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP15_LOGICAL_AND' => 146,
			'OP08_STRING_CAT' => 145,
			"}" => 357,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP09_BITWISE_SHIFT' => 159,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP06_REGEX_MATCH' => 150,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153
		}
	},
	{#State 323
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP18_TERNARY' => 153,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => 154,
			'OP16_LOGICAL_OR' => 149,
			"]" => 358,
			'OP11_COMPARE_LT_GT' => 148,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP09_BITWISE_SHIFT' => 159,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 146
		}
	},
	{#State 324
		ACTIONS => {
			";" => 359
		}
	},
	{#State 325
		DEFAULT => -196
	},
	{#State 326
		DEFAULT => -124
	},
	{#State 327
		ACTIONS => {
			")" => 360
		}
	},
	{#State 328
		DEFAULT => -114
	},
	{#State 329
		DEFAULT => -115
	},
	{#State 330
		ACTIONS => {
			")" => 361
		}
	},
	{#State 331
		ACTIONS => {
			'VARIABLE_SYMBOL' => 131,
			'OP01_QW' => 191,
			'LPAREN' => 129,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'MY' => 179,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109
		},
		GOTOS => {
			'Expression' => 173,
			'ArrayDereference' => 125,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'ListElements' => 362,
			'SubExpression' => 188,
			'Operator' => 91,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Literal' => 120,
			'ListElement' => 190,
			'Variable' => 171,
			'TypeInner' => 189
		}
	},
	{#State 332
		DEFAULT => -117
	},
	{#State 333
		ACTIONS => {
			'VARIABLE_SYMBOL' => 363
		}
	},
	{#State 334
		ACTIONS => {
			'VARIABLE_SYMBOL' => 364
		}
	},
	{#State 335
		ACTIONS => {
			'VARIABLE_SYMBOL' => 365
		}
	},
	{#State 336
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP08_STRING_CAT' => 145,
			")" => 366,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP06_REGEX_MATCH' => 150,
			'OP16_LOGICAL_OR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP08_MATH_ADD_SUB' => 160,
			'OP18_TERNARY' => 153,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => 154,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151
		}
	},
	{#State 337
		ACTIONS => {
			'VARIABLE_SYMBOL' => 367
		}
	},
	{#State 338
		DEFAULT => -50
	},
	{#State 339
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 368
		}
	},
	{#State 340
		ACTIONS => {
			'MY' => 369
		}
	},
	{#State 341
		ACTIONS => {
			";" => 370
		}
	},
	{#State 342
		ACTIONS => {
			'OP20_HASH_FATARROW' => 371
		}
	},
	{#State 343
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 372
		}
	},
	{#State 344
		DEFAULT => -61
	},
	{#State 345
		ACTIONS => {
			'VARIABLE_SYMBOL' => 373
		}
	},
	{#State 346
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => 133,
			'OP22_LOGICAL_NEG' => 132,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'CONSTANT_CALL_SCOPED' => 121,
			"undef" => 123,
			"\@{" => 122,
			'WORD_UPPERCASE' => 119,
			'OP01_PRINT' => 126,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP19_LOOP_CONTROL' => 113,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'MY' => 115,
			'OP01_NAMED' => 117,
			"while" => -147,
			'OP05_LOGICAL_NEG' => 118,
			"for" => -147,
			'OP01_NAMED_VOID' => 114,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			"if" => 90,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'LBRACE' => 95,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'SELF' => 104,
			"foreach" => -147,
			"%{" => 103,
			'LITERAL_NUMBER' => 83
		},
		GOTOS => {
			'HashReference' => 128,
			'Statement' => 130,
			'OPTIONAL-37' => 134,
			'LoopLabel' => 136,
			'VariableSymbolOrSelf' => 116,
			'Operation' => 374,
			'Literal' => 120,
			'PLUS-42' => 375,
			'PAREN-36' => 96,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 92,
			'VariableModification' => 93,
			'Variable' => 124,
			'VariableDeclaration' => 99,
			'OperatorVoid' => 105,
			'Conditional' => 106,
			'ArrayDereference' => 125,
			'Expression' => 101,
			'ArrayReference' => 127,
			'WordScoped' => 108
		}
	},
	{#State 347
		DEFAULT => -155,
		GOTOS => {
			'STAR-39' => 376
		}
	},
	{#State 348
		DEFAULT => -105
	},
	{#State 349
		DEFAULT => -202
	},
	{#State 350
		ACTIONS => {
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			"}" => -199,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 146,
			'OP21_LIST_COMMA' => -199,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP09_BITWISE_SHIFT' => 159,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP17_LIST_RANGE' => 154
		}
	},
	{#State 351
		ACTIONS => {
			'LITERAL_STRING' => 377
		}
	},
	{#State 352
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 378
		}
	},
	{#State 353
		DEFAULT => -183
	},
	{#State 354
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP18_TERNARY' => 153,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => 154,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP06_REGEX_MATCH' => 150,
			"]" => 379,
			'OP16_LOGICAL_OR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP08_MATH_ADD_SUB' => 160
		}
	},
	{#State 355
		ACTIONS => {
			";" => 380
		}
	},
	{#State 356
		DEFAULT => -176
	},
	{#State 357
		DEFAULT => -175
	},
	{#State 358
		DEFAULT => -174
	},
	{#State 359
		DEFAULT => -119
	},
	{#State 360
		DEFAULT => -130
	},
	{#State 361
		DEFAULT => -80
	},
	{#State 362
		ACTIONS => {
			")" => 381
		}
	},
	{#State 363
		ACTIONS => {
			'LPAREN' => 382
		}
	},
	{#State 364
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 383
		}
	},
	{#State 365
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 384
		}
	},
	{#State 366
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 385
		}
	},
	{#State 367
		ACTIONS => {
			'LPAREN' => 386
		}
	},
	{#State 368
		ACTIONS => {
			"\@_;" => 387
		}
	},
	{#State 369
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 388
		}
	},
	{#State 370
		DEFAULT => -66
	},
	{#State 371
		ACTIONS => {
			'MY' => 389
		},
		GOTOS => {
			'TypeInnerProperties' => 390
		}
	},
	{#State 372
		ACTIONS => {
			'OP21_LIST_COMMA' => 392,
			"}" => 393
		},
		GOTOS => {
			'PAREN-25' => 391
		}
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 394
		}
	},
	{#State 374
		DEFAULT => -169
	},
	{#State 375
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'OP01_OPEN' => 100,
			"if" => 90,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"foreach" => -147,
			"%{" => 103,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP19_LOOP_CONTROL' => 113,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'MY' => 115,
			"while" => -147,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 117,
			"}" => 396,
			"for" => -147,
			'OP01_NAMED_VOID' => 114,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'WORD_UPPERCASE' => 119,
			'OP01_PRINT' => 126,
			'OP22_LOGICAL_NEG' => 132,
			'OP01_NAMED_VOID_LPAREN' => 133,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 101,
			'OperatorVoid' => 105,
			'ArrayDereference' => 125,
			'Conditional' => 106,
			'VariableDeclaration' => 99,
			'Variable' => 124,
			'SubExpression' => 92,
			'Operator' => 91,
			'HashDereference' => 89,
			'VariableModification' => 93,
			'Operation' => 395,
			'Literal' => 120,
			'PAREN-36' => 96,
			'VariableSymbolOrSelf' => 116,
			'LoopLabel' => 136,
			'OPTIONAL-37' => 134,
			'HashReference' => 128,
			'Statement' => 130
		}
	},
	{#State 376
		ACTIONS => {
			'LPAREN' => -158,
			'VARIABLE_SYMBOL' => -158,
			'OP01_NAMED_VOID_LPAREN' => -158,
			'OP22_LOGICAL_NEG' => -158,
			'OP01_PRINT' => -158,
			'WORD_UPPERCASE' => -158,
			'CONSTANT_CALL_SCOPED' => -158,
			"undef" => -158,
			"\@{" => -158,
			"elsif" => 400,
			'OP01_NAMED_VOID' => -158,
			"for" => -158,
			"else" => 399,
			'MY' => -158,
			"}" => -158,
			"while" => -158,
			'OP01_NAMED' => -158,
			'OP05_LOGICAL_NEG' => -158,
			'' => -158,
			'OP19_LOOP_CONTROL_SCOLON' => -158,
			'OP03_MATH_INC_DEC' => -158,
			'WORD' => -158,
			'LBRACKET' => -158,
			'OP19_LOOP_CONTROL' => -158,
			'SELF' => -158,
			"foreach" => -158,
			"%{" => -158,
			'LITERAL_NUMBER' => -158,
			'OP05_MATH_NEG_LPAREN' => -158,
			'OP01_CLOSE' => -158,
			'WORD_SCOPED' => -158,
			"if" => -158,
			'OP01_NAMED_VOID_SCOLON' => -158,
			'LBRACE' => -158,
			'OP10_NAMED_UNARY' => -158,
			'LITERAL_STRING' => -158,
			'OP01_OPEN' => -158
		},
		GOTOS => {
			'PAREN-40' => 401,
			'OPTIONAL-41' => 398,
			'PAREN-38' => 397
		}
	},
	{#State 377
		ACTIONS => {
			'OP21_LIST_COMMA' => 402
		}
	},
	{#State 378
		DEFAULT => -217
	},
	{#State 379
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 403
		}
	},
	{#State 380
		DEFAULT => -178
	},
	{#State 381
		DEFAULT => -82
	},
	{#State 382
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'Literal' => 120,
			'SubExpression' => 404,
			'Operator' => 91,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Variable' => 171
		}
	},
	{#State 383
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'SELF' => 104,
			"%{" => 103,
			'LITERAL_NUMBER' => 83
		},
		GOTOS => {
			'Variable' => 171,
			'Literal' => 120,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 405,
			'HashReference' => 128,
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 384
		ACTIONS => {
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'STDIN' => 281,
			'CONSTANT_CALL_SCOPED' => 121,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'Variable' => 171,
			'SubExpressionOrStdin' => 406,
			'Literal' => 120,
			'SubExpression' => 280,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Operator' => 91,
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 385
		DEFAULT => -166
	},
	{#State 386
		ACTIONS => {
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'MY' => 179,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LPAREN' => 129,
			'OP01_QW' => 191,
			'VARIABLE_SYMBOL' => 131
		},
		GOTOS => {
			'TypeInner' => 189,
			'Variable' => 171,
			'ListElement' => 190,
			'Literal' => 120,
			'HashReference' => 128,
			'Operator' => 91,
			'SubExpression' => 188,
			'HashDereference' => 89,
			'ListElements' => 407,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 387
		DEFAULT => -52
	},
	{#State 388
		ACTIONS => {
			'VARIABLE_SYMBOL' => 408
		}
	},
	{#State 389
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 409
		}
	},
	{#State 390
		DEFAULT => -201
	},
	{#State 391
		DEFAULT => -63
	},
	{#State 392
		ACTIONS => {
			'WORD' => 342
		},
		GOTOS => {
			'HashEntryProperties' => 410
		}
	},
	{#State 393
		ACTIONS => {
			";" => 411
		}
	},
	{#State 394
		ACTIONS => {
			'LPAREN_MY' => 412,
			'VARIABLE_SYMBOL' => -68,
			'LPAREN' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'OP01_PRINT' => -68,
			'WORD_UPPERCASE' => -68,
			"\@{" => -68,
			"undef" => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			"for" => -68,
			'OP01_NAMED_VOID' => -68,
			"while" => -68,
			"}" => -68,
			'OP01_NAMED' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'MY' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'WORD' => -68,
			'LBRACKET' => -68,
			'LITERAL_NUMBER' => -68,
			"%{" => -68,
			'SELF' => -68,
			"foreach" => -68,
			'OP01_CLOSE' => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'LBRACE' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			"if" => -68,
			'WORD_SCOPED' => -68,
			'OP01_OPEN' => -68,
			'OP10_NAMED_UNARY' => -68,
			'LITERAL_STRING' => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 413,
			'MethodArguments' => 414
		}
	},
	{#State 395
		DEFAULT => -168
	},
	{#State 396
		DEFAULT => -170
	},
	{#State 397
		DEFAULT => -154
	},
	{#State 398
		DEFAULT => -159
	},
	{#State 399
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 415
		}
	},
	{#State 400
		ACTIONS => {
			'LPAREN' => 416
		}
	},
	{#State 401
		DEFAULT => -157
	},
	{#State 402
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'Variable' => 171,
			'HashReference' => 128,
			'SubExpression' => 417,
			'Operator' => 91,
			'HashDereference' => 89,
			'Literal' => 120,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125
		}
	},
	{#State 403
		ACTIONS => {
			"undef" => 418
		}
	},
	{#State 404
		ACTIONS => {
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP17_LIST_RANGE' => 419,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP09_BITWISE_SHIFT' => 159,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 146
		}
	},
	{#State 405
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147,
			'OP09_BITWISE_SHIFT' => 159,
			";" => 420,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP18_TERNARY' => 153,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => 154,
			'OP16_LOGICAL_OR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150
		}
	},
	{#State 406
		ACTIONS => {
			")" => 421
		}
	},
	{#State 407
		ACTIONS => {
			")" => 422
		}
	},
	{#State 408
		DEFAULT => -49
	},
	{#State 409
		ACTIONS => {
			"\$TYPED_" => 423
		}
	},
	{#State 410
		DEFAULT => -62
	},
	{#State 411
		DEFAULT => -65
	},
	{#State 412
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'WORD' => 53,
			'TYPE_INTEGER' => 54
		},
		GOTOS => {
			'Type' => 424
		}
	},
	{#State 413
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 425
		}
	},
	{#State 414
		DEFAULT => -67
	},
	{#State 415
		DEFAULT => -156
	},
	{#State 416
		ACTIONS => {
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			'SELF' => 104,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP22_LOGICAL_NEG' => 132,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27
		},
		GOTOS => {
			'Variable' => 171,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 426,
			'Literal' => 120,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125
		}
	},
	{#State 417
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => -83,
			'OP09_BITWISE_SHIFT' => 159,
			'OP13_BITWISE_AND' => 155,
			";" => -83,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP08_STRING_CAT' => 145,
			"}" => -83,
			'OP21_LIST_COMMA' => -83,
			")" => -83,
			'OP15_LOGICAL_AND' => 146,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP18_TERNARY' => 153,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => 154,
			"]" => -83,
			'OP16_LOGICAL_OR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150
		}
	},
	{#State 418
		ACTIONS => {
			";" => 427
		}
	},
	{#State 419
		ACTIONS => {
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'WORD_SCOPED' => 28,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			'OP01_OPEN' => 100,
			"undef" => 123,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111
		},
		GOTOS => {
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'Variable' => 171,
			'SubExpression' => 428,
			'HashReference' => 128,
			'Operator' => 91,
			'HashDereference' => 89,
			'Literal' => 120
		}
	},
	{#State 420
		ACTIONS => {
			'VARIABLE_SYMBOL' => 429
		}
	},
	{#State 421
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 430
		}
	},
	{#State 422
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 431
		}
	},
	{#State 423
		ACTIONS => {
			'WORD' => 432
		}
	},
	{#State 424
		ACTIONS => {
			'SELF' => 433
		}
	},
	{#State 425
		ACTIONS => {
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP22_LOGICAL_NEG' => 132,
			'OP01_NAMED_VOID_LPAREN' => 133,
			'OP01_PRINT' => 126,
			'WORD_UPPERCASE' => 119,
			"\@{" => 122,
			"undef" => 123,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP01_NAMED_VOID' => 114,
			"for" => -147,
			'OP05_LOGICAL_NEG' => 118,
			"while" => -147,
			'OP01_NAMED' => 117,
			"}" => 435,
			'MY' => 115,
			'OP19_LOOP_CONTROL_SCOLON' => 110,
			'OP19_LOOP_CONTROL' => 113,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'LITERAL_NUMBER' => 83,
			"%{" => 103,
			"foreach" => -147,
			'SELF' => 104,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LBRACE' => 95,
			'OP01_NAMED_VOID_SCOLON' => 97,
			"if" => 90,
			'WORD_SCOPED' => 28,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98
		},
		GOTOS => {
			'VariableDeclaration' => 99,
			'Variable' => 124,
			'HashDereference' => 89,
			'SubExpression' => 92,
			'Operator' => 91,
			'VariableModification' => 93,
			'Operation' => 434,
			'Literal' => 120,
			'PAREN-36' => 96,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 101,
			'ArrayDereference' => 125,
			'Conditional' => 106,
			'OperatorVoid' => 105,
			'OPTIONAL-37' => 134,
			'HashReference' => 128,
			'Statement' => 130,
			'LoopLabel' => 136,
			'VariableSymbolOrSelf' => 116
		}
	},
	{#State 426
		ACTIONS => {
			'OP15_LOGICAL_AND' => 146,
			")" => 436,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP06_REGEX_MATCH' => 150,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161
		}
	},
	{#State 427
		DEFAULT => -179
	},
	{#State 428
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160,
			'OP06_REGEX_MATCH' => 150,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => -104,
			'OP17_LIST_RANGE' => undef,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP15_LOGICAL_AND' => 146,
			")" => 437,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => -104,
			'OP09_BITWISE_SHIFT' => 159
		}
	},
	{#State 429
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 438
		}
	},
	{#State 430
		DEFAULT => -167
	},
	{#State 431
		DEFAULT => -165
	},
	{#State 432
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 440,
			'OP02_ARRAY_THINARROW' => 439
		}
	},
	{#State 433
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 441
		}
	},
	{#State 434
		DEFAULT => -69
	},
	{#State 435
		ACTIONS => {
			";" => 442
		}
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 437
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 444
		}
	},
	{#State 438
		ACTIONS => {
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'WORD_SCOPED' => 28,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'WORD' => 27,
			'OP22_LOGICAL_NEG' => 132
		},
		GOTOS => {
			'Variable' => 171,
			'Literal' => 120,
			'HashDereference' => 89,
			'SubExpression' => 445,
			'Operator' => 91,
			'HashReference' => 128,
			'ArrayReference' => 127,
			'WordScoped' => 108,
			'VariableSymbolOrSelf' => 116,
			'ArrayDereference' => 125,
			'Expression' => 173
		}
	},
	{#State 439
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'LBRACE' => 95,
			'WORD_UPPERCASE' => 170,
			'OP10_NAMED_UNARY' => 98,
			'LITERAL_STRING' => 82,
			'CONSTANT_CALL_SCOPED' => 121,
			"\@{" => 122,
			"undef" => 123,
			'OP01_OPEN' => 100,
			'LITERAL_NUMBER' => 83,
			'SELF' => 104,
			"%{" => 103,
			'OP01_CLOSE' => 107,
			'OP05_MATH_NEG_LPAREN' => 109,
			'LPAREN' => 129,
			'VARIABLE_SYMBOL' => 131,
			'OP22_LOGICAL_NEG' => 132,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'WORD' => 27,
			'OP05_LOGICAL_NEG' => 118,
			'OP01_NAMED' => 172
		},
		GOTOS => {
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'Literal' => 120,
			'SubExpression' => 446,
			'Operator' => 91,
			'HashDereference' => 89,
			'HashReference' => 128,
			'Variable' => 171
		}
	},
	{#State 440
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			"%{" => 103,
			'SELF' => 104,
			'LITERAL_NUMBER' => 83,
			"undef" => 123,
			'OP01_OPEN' => 100,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'WORD' => 27,
			'LBRACKET' => 112,
			'OP03_MATH_INC_DEC' => 111,
			'OP22_LOGICAL_NEG' => 132,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129
		},
		GOTOS => {
			'Literal' => 120,
			'HashReference' => 128,
			'HashDereference' => 89,
			'Operator' => 91,
			'SubExpression' => 447,
			'Variable' => 171,
			'ArrayDereference' => 125,
			'Expression' => 173,
			'ArrayReference' => 127,
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108
		}
	},
	{#State 441
		ACTIONS => {
			'OP21_LIST_COMMA' => 448,
			")" => 449
		},
		GOTOS => {
			'PAREN-29' => 450
		}
	},
	{#State 442
		DEFAULT => -71
	},
	{#State 443
		DEFAULT => -153
	},
	{#State 444
		DEFAULT => -163
	},
	{#State 445
		ACTIONS => {
			'OP06_REGEX_MATCH' => 150,
			'OP16_LOGICAL_OR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP08_MATH_ADD_SUB' => 160,
			'OP18_TERNARY' => 153,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => 154,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 146,
			";" => 451,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158
		}
	},
	{#State 446
		ACTIONS => {
			'OP06_REGEX_MATCH' => 150,
			"]" => 452,
			'OP16_LOGICAL_OR' => 149,
			'OP11_COMPARE_LT_GT' => 148,
			'OP08_MATH_ADD_SUB' => 160,
			'OP18_TERNARY' => 153,
			'OP07_STRING_REPEAT' => 152,
			'OP17_LIST_RANGE' => 154,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP04_MATH_POW' => 161,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP08_STRING_CAT' => 145,
			'OP15_LOGICAL_AND' => 146,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP09_BITWISE_SHIFT' => 159,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP23_LOGICAL_AND' => 147
		}
	},
	{#State 447
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP15_LOGICAL_AND' => 146,
			'OP21_LIST_COMMA' => -218,
			"}" => -218,
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP13_BITWISE_AND' => 155,
			'OP17_LIST_RANGE' => 154,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151,
			'OP06_REGEX_MATCH' => 150,
			'OP08_MATH_ADD_SUB' => 160,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149
		}
	},
	{#State 448
		ACTIONS => {
			'MY' => 453
		}
	},
	{#State 449
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 454
		}
	},
	{#State 450
		DEFAULT => -73
	},
	{#State 451
		ACTIONS => {
			'SELF' => 104,
			"%{" => 103,
			'LITERAL_NUMBER' => 83,
			'OP05_MATH_NEG_LPAREN' => 109,
			'OP01_CLOSE' => 107,
			'WORD_UPPERCASE' => 170,
			'LBRACE' => 95,
			'WORD_SCOPED' => 28,
			'OP01_OPEN' => 100,
			"undef" => 123,
			"\@{" => 122,
			'CONSTANT_CALL_SCOPED' => 121,
			'LITERAL_STRING' => 82,
			'OP10_NAMED_UNARY' => 98,
			'OP01_NAMED' => 172,
			'OP05_LOGICAL_NEG' => 118,
			'VARIABLE_SYMBOL' => 131,
			'LPAREN' => 129,
			'WORD' => 27,
			'OP03_MATH_INC_DEC' => 111,
			'LBRACKET' => 112,
			'OP22_LOGICAL_NEG' => 132
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 116,
			'WordScoped' => 108,
			'ArrayReference' => 127,
			'Expression' => 173,
			'ArrayDereference' => 125,
			'Variable' => 124,
			'SubExpressionOrVarMod' => 457,
			'VariableModification' => 456,
			'HashReference' => 128,
			'SubExpression' => 455,
			'Operator' => 91,
			'HashDereference' => 89,
			'Literal' => 120
		}
	},
	{#State 452
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 458
		}
	},
	{#State 453
		ACTIONS => {
			'WORD_SCOPED' => 55,
			'TYPE_INTEGER' => 54,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 459
		}
	},
	{#State 454
		ACTIONS => {
			"\@_;" => 460
		}
	},
	{#State 455
		ACTIONS => {
			'OP08_STRING_CAT' => 145,
			'OP24_LOGICAL_OR_XOR' => 157,
			'OP15_LOGICAL_AND' => 146,
			")" => -143,
			'OP13_BITWISE_AND' => 155,
			'OP12_COMPARE_EQ_NE' => 156,
			'OP09_BITWISE_SHIFT' => 159,
			'OP23_LOGICAL_AND' => 147,
			'OP07_MATH_MULT_DIV_MOD' => 158,
			'OP06_REGEX_MATCH' => 150,
			'OP11_COMPARE_LT_GT' => 148,
			'OP16_LOGICAL_OR' => 149,
			'OP08_MATH_ADD_SUB' => 160,
			'OP07_STRING_REPEAT' => 152,
			'OP18_TERNARY' => 153,
			'OP17_LIST_RANGE' => 154,
			'OP04_MATH_POW' => 161,
			'OP14_BITWISE_OR_XOR' => 151
		}
	},
	{#State 456
		DEFAULT => -144
	},
	{#State 457
		ACTIONS => {
			")" => 461
		}
	},
	{#State 458
		ACTIONS => {
			"undef" => 462
		}
	},
	{#State 459
		ACTIONS => {
			'VARIABLE_SYMBOL' => 463
		}
	},
	{#State 460
		DEFAULT => -75
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 346
		},
		GOTOS => {
			'CodeBlock' => 464
		}
	},
	{#State 462
		DEFAULT => -219
	},
	{#State 463
		DEFAULT => -72
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
