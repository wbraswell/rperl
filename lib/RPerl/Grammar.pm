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
    our $VERSION = 0.001_998;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\=\ sub\ \{|package|foreach|\$TYPED_|while|undef|elsif|else|our|\@_\;|for|\@\{|\%\{|if|\;|\}|\]|\))}gc and return ($1, $1);

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
      /\G(\<\$[A-Z][A-Z0-9_]*\>)/gc and return ('FHREF_SYMBOL_IN', $1);
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
      /\G(sin|cos|push|pop|keys|values|sort|length|split|join|reverse|chomp|-e|-r|-f|-T|fakebuiltin)\s/gc and return ('OP01_NAMED', $1);
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
			"## no critic qw(" => 1,
			"package" => -20,
			'SHEBANG' => 8
		},
		GOTOS => {
			'OPTIONAL-9' => 2,
			'Critic' => 3,
			'PAREN-1' => 9,
			'ModuleHeader' => 5,
			'Program' => 4,
			'CompileUnit' => 7,
			'PLUS-2' => 6
		}
	},
	{#State 1
		ACTIONS => {
			'WORD' => 11
		},
		GOTOS => {
			'PLUS-16' => 10
		}
	},
	{#State 2
		ACTIONS => {
			'USE_RPERL' => 13,
			"package" => -22
		},
		GOTOS => {
			'OPTIONAL-10' => 12
		}
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		DEFAULT => -4
	},
	{#State 5
		ACTIONS => {
			"use parent qw(" => 14,
			'USE' => -27,
			"## no critic qw(" => -27,
			"our" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'Module' => 15,
			'STAR-11' => 18,
			'Class' => 17,
			'Package' => 16
		}
	},
	{#State 6
		ACTIONS => {
			'USE_RPERL' => -20,
			'' => -5,
			"package" => -20,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'ModuleHeader' => 5,
			'Critic' => 3,
			'PAREN-1' => 19,
			'OPTIONAL-9' => 2
		}
	},
	{#State 7
		ACTIONS => {
			'' => 20
		}
	},
	{#State 8
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'OPTIONAL-3' => 21,
			'Critic' => 22
		}
	},
	{#State 9
		DEFAULT => -3
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
		ACTIONS => {
			"package" => 25
		}
	},
	{#State 13
		DEFAULT => -21
	},
	{#State 14
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 28
		}
	},
	{#State 15
		DEFAULT => -1
	},
	{#State 16
		DEFAULT => -24
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		ACTIONS => {
			'USE' => -29,
			"use constant" => -29,
			"our" => -29,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'Critic' => 29,
			'STAR-12' => 30
		}
	},
	{#State 19
		DEFAULT => -2
	},
	{#State 20
		DEFAULT => 0
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
		DEFAULT => -38
	},
	{#State 24
		DEFAULT => -40
	},
	{#State 25
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 32
		}
	},
	{#State 26
		DEFAULT => -211
	},
	{#State 27
		DEFAULT => -212
	},
	{#State 28
		ACTIONS => {
			")" => 33
		}
	},
	{#State 29
		DEFAULT => -26
	},
	{#State 30
		ACTIONS => {
			'USE' => 36,
			"our" => -31,
			"use constant" => -31
		},
		GOTOS => {
			'STAR-13' => 35,
			'Include' => 34
		}
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
		DEFAULT => -28
	},
	{#State 35
		ACTIONS => {
			"our" => 42,
			"use constant" => 43
		},
		GOTOS => {
			'Constant' => 41,
			'Subroutine' => 45,
			'PLUS-14' => 44
		}
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 46
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
			'USE' => 36
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 41
		DEFAULT => -30
	},
	{#State 42
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 54,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 44
		ACTIONS => {
			"our" => 42,
			'LITERAL_NUMBER' => 57
		},
		GOTOS => {
			'Subroutine' => 56
		}
	},
	{#State 45
		DEFAULT => -33
	},
	{#State 46
		ACTIONS => {
			'OP01_QW' => 59,
			";" => 58
		}
	},
	{#State 47
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'OP01_CLOSE' => -11,
			"for" => -11,
			'OP01_NAMED_VOID' => -11,
			'WORD_SCOPED' => -11,
			'OP01_PRINT' => -11,
			'MY' => -11,
			"## no critic qw(" => 1,
			'VARIABLE_SYMBOL' => -11,
			"undef" => -11,
			'SELF' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'LITERAL_STRING' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			"our" => -11,
			"use constant" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'OP01_NAMED' => -11,
			'WORD' => -11,
			'WORD_UPPERCASE' => -11,
			"foreach" => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP01_OPEN' => -11,
			"%{" => -11,
			'LPAREN' => -11,
			'LBRACKET' => -11,
			"while" => -11,
			"if" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'USE' => -11,
			"\@{" => -11,
			'OP10_NAMED_UNARY' => -11
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
		DEFAULT => -23
	},
	{#State 50
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 64
		}
	},
	{#State 51
		DEFAULT => -216
	},
	{#State 52
		DEFAULT => -215
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 54
		DEFAULT => -214
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
		}
	},
	{#State 56
		DEFAULT => -32
	},
	{#State 57
		ACTIONS => {
			";" => 67
		}
	},
	{#State 58
		DEFAULT => -41
	},
	{#State 59
		ACTIONS => {
			";" => 68
		}
	},
	{#State 60
		DEFAULT => -8
	},
	{#State 61
		ACTIONS => {
			"foreach" => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP01_OPEN' => -13,
			"our" => -13,
			'OP19_LOOP_CONTROL' => -13,
			"use constant" => -13,
			'OP01_NAMED' => -13,
			'WORD' => -13,
			'WORD_UPPERCASE' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'USE' => 36,
			"\@{" => -13,
			'OP10_NAMED_UNARY' => -13,
			"%{" => -13,
			'LPAREN' => -13,
			'LBRACKET' => -13,
			"while" => -13,
			"if" => -13,
			'WORD_SCOPED' => -13,
			'OP01_PRINT' => -13,
			'MY' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_CLOSE' => -13,
			"for" => -13,
			'OP01_NAMED_VOID' => -13,
			'SELF' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'LBRACE' => -13,
			'VARIABLE_SYMBOL' => -13,
			"undef" => -13
		},
		GOTOS => {
			'Include' => 70,
			'STAR-6' => 69
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
		ACTIONS => {
			"our hashref \$properties" => -56,
			'USE' => -56,
			"## no critic qw(" => 1,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 72,
			'Critic' => 73
		}
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 66
		ACTIONS => {
			'MY' => 75
		},
		GOTOS => {
			'TypeInnerConstant' => 76
		}
	},
	{#State 67
		DEFAULT => -34
	},
	{#State 68
		DEFAULT => -42
	},
	{#State 69
		ACTIONS => {
			'LITERAL_STRING' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'SELF' => -15,
			'LBRACE' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"undef" => -15,
			'VARIABLE_SYMBOL' => -15,
			'WORD_SCOPED' => -15,
			'OP01_PRINT' => -15,
			'MY' => -15,
			'OP01_CLOSE' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID' => -15,
			"for" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP10_NAMED_UNARY' => -15,
			"\@{" => -15,
			'LBRACKET' => -15,
			"%{" => -15,
			'LPAREN' => -15,
			"if" => -15,
			"while" => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"foreach" => -15,
			'OP01_OPEN' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'WORD' => -15,
			'OP01_NAMED' => -15,
			'OP19_LOOP_CONTROL' => -15,
			"use constant" => 43,
			"our" => -15,
			'WORD_UPPERCASE' => -15
		},
		GOTOS => {
			'STAR-7' => 77,
			'Constant' => 78
		}
	},
	{#State 70
		DEFAULT => -10
	},
	{#State 71
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 79
		}
	},
	{#State 72
		ACTIONS => {
			'USE' => 36,
			"use constant" => -58,
			"our hashref \$properties" => -58
		},
		GOTOS => {
			'Include' => 81,
			'STAR-23' => 80
		}
	},
	{#State 73
		DEFAULT => -53
	},
	{#State 74
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			"\@{" => -45,
			'OP10_NAMED_UNARY' => -45,
			"%{" => -45,
			'LPAREN' => -45,
			'LBRACKET' => -45,
			"while" => -45,
			"if" => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			"foreach" => -45,
			'LITERAL_NUMBER' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'OP01_OPEN' => -45,
			"}" => -45,
			'OP19_LOOP_CONTROL' => -45,
			'WORD' => -45,
			'OP01_NAMED' => -45,
			'WORD_UPPERCASE' => -45,
			'LITERAL_STRING' => -45,
			'SELF' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'LBRACE' => -45,
			'LPAREN_MY' => 84,
			"undef" => -45,
			'VARIABLE_SYMBOL' => -45,
			'WORD_SCOPED' => -45,
			'OP01_PRINT' => -45,
			'MY' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'OP01_CLOSE' => -45,
			"for" => -45,
			'OP01_NAMED_VOID' => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 82,
			'SubroutineArguments' => 83
		}
	},
	{#State 75
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD_SCOPED' => 52,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 85
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 88
		}
	},
	{#State 77
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => 93,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'LBRACKET' => 101,
			"%{" => 98,
			'LPAREN' => 97,
			"if" => 95,
			"while" => -147,
			'CONSTANT_CALL_SCOPED' => 107,
			"foreach" => -147,
			'OP01_OPEN' => 105,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_VOID_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 112,
			'OP19_LOOP_CONTROL' => 110,
			"our" => 42,
			'WORD_UPPERCASE' => 108,
			'LITERAL_STRING' => 87,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'SELF' => 119,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'WORD_SCOPED' => 27,
			'MY' => 126,
			'OP01_PRINT' => 125,
			'OP01_CLOSE' => 136,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_NAMED_VOID' => 133,
			"for" => -147
		},
		GOTOS => {
			'LoopLabel' => 109,
			'VariableDeclaration' => 131,
			'PAREN-36' => 132,
			'Expression' => 130,
			'HashDereference' => 129,
			'VariableSymbolOrSelf' => 111,
			'Operation' => 127,
			'WordScoped' => 104,
			'OPTIONAL-37' => 128,
			'SubExpression' => 106,
			'Conditional' => 122,
			'Operator' => 121,
			'VariableModification' => 96,
			'ArrayReference' => 120,
			'Variable' => 94,
			'Literal' => 99,
			'PLUS-8' => 100,
			'OperatorVoid' => 89,
			'ArrayDereference' => 116,
			'Subroutine' => 117,
			'Statement' => 115,
			'HashReference' => 92
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
			"our hashref \$properties" => 137,
			"use constant" => 43
		},
		GOTOS => {
			'Properties' => 138,
			'Constant' => 139
		}
	},
	{#State 81
		DEFAULT => -55
	},
	{#State 82
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 140
		}
	},
	{#State 83
		DEFAULT => -44
	},
	{#State 84
		ACTIONS => {
			'WORD' => 54,
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 141
		}
	},
	{#State 85
		ACTIONS => {
			"\$TYPED_" => 142
		}
	},
	{#State 86
		DEFAULT => -228
	},
	{#State 87
		DEFAULT => -229
	},
	{#State 88
		ACTIONS => {
			";" => 143
		}
	},
	{#State 89
		DEFAULT => -150
	},
	{#State 90
		ACTIONS => {
			'LBRACKET' => -194,
			'SELF' => 119,
			'VARIABLE_SYMBOL' => 124,
			'MY' => 144
		},
		GOTOS => {
			'Variable' => 146,
			'OPTIONAL-47' => 147,
			'TypeInner' => 145,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 91
		ACTIONS => {
			'OP18_TERNARY' => -97,
			'OP22_LOGICAL_NEG' => 135,
			'OP16_LOGICAL_OR' => -97,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_CLOSE' => 136,
			'OP21_LIST_COMMA' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			")" => -97,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 124,
			'OP14_BITWISE_OR_XOR' => -97,
			"undef" => 123,
			"]" => -97,
			'OP13_BITWISE_AND' => -97,
			'OP08_MATH_ADD_SUB' => -97,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			";" => -97,
			'LBRACE' => 114,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP04_MATH_POW' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP07_STRING_REPEAT' => -97,
			'OP08_STRING_CAT' => -97,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105,
			"}" => -97,
			'OP17_LIST_RANGE' => -97,
			'OP15_LOGICAL_AND' => -97,
			"%{" => 98,
			'LPAREN' => 97,
			'LBRACKET' => 101,
			'OP23_LOGICAL_AND' => -97,
			'OP06_REGEX_MATCH' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'Operator' => 121,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Variable' => 152,
			'HashDereference' => 129,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'WordScoped' => 104,
			'ArrayDereference' => 116,
			'SubExpression' => 151,
			'HashReference' => 92
		}
	},
	{#State 92
		DEFAULT => -138
	},
	{#State 93
		DEFAULT => -120
	},
	{#State 94
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -135,
			")" => -135,
			'OP19_VARIABLE_ASSIGN_BY' => 153,
			'OP17_LIST_RANGE' => -135,
			'OP03_MATH_INC_DEC' => 154,
			'OP04_MATH_POW' => -135,
			'OP02_METHOD_THINARROW' => 155,
			'OP11_COMPARE_LT_GT' => -135,
			'OP18_TERNARY' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP08_STRING_CAT' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP19_VARIABLE_ASSIGN' => 156,
			'OP15_LOGICAL_AND' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP13_BITWISE_AND' => -135
		}
	},
	{#State 95
		ACTIONS => {
			'LPAREN' => 157
		}
	},
	{#State 96
		ACTIONS => {
			";" => 158
		}
	},
	{#State 97
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'OP01_PRINT' => 159,
			'OP01_OPEN' => 105,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 160,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'LPAREN' => 97,
			"%{" => 98
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'SubExpression' => 161,
			'HashReference' => 92,
			'WordScoped' => 104,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Variable' => 152,
			'HashDereference' => 129,
			'Operator' => 121
		}
	},
	{#State 98
		ACTIONS => {
			'LBRACE' => -208,
			'MY' => 144,
			'SELF' => 119,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'TypeInner' => 162,
			'Variable' => 164,
			'OPTIONAL-51' => 163,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 99
		DEFAULT => -134
	},
	{#State 100
		ACTIONS => {
			"while" => -147,
			"if" => 95,
			'LPAREN' => 97,
			"%{" => 98,
			'LBRACKET' => 101,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'' => -18,
			'OP19_LOOP_CONTROL_SCOLON' => 93,
			'WORD_UPPERCASE' => 108,
			'OP19_LOOP_CONTROL' => 110,
			'OP01_NAMED' => 112,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_VOID_LPAREN' => 102,
			'OP01_OPEN' => 105,
			"foreach" => -147,
			'CONSTANT_CALL_SCOPED' => 107,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'SELF' => 119,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'LITERAL_STRING' => 87,
			"for" => -147,
			'OP01_NAMED_VOID' => 133,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_CLOSE' => 136,
			'OP01_PRINT' => 125,
			'MY' => 126,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'OperatorVoid' => 89,
			'HashReference' => 92,
			'Statement' => 115,
			'ArrayDereference' => 116,
			'Variable' => 94,
			'ArrayReference' => 120,
			'Conditional' => 122,
			'VariableModification' => 96,
			'Operator' => 121,
			'Literal' => 99,
			'WordScoped' => 104,
			'Operation' => 165,
			'SubExpression' => 106,
			'OPTIONAL-37' => 128,
			'HashDereference' => 129,
			'Expression' => 130,
			'VariableDeclaration' => 131,
			'PAREN-36' => 132,
			'LoopLabel' => 109,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 101
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105,
			'MY' => 144,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 149,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			"]" => -191,
			'LPAREN' => 97,
			"%{" => 98,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101
		},
		GOTOS => {
			'TypeInner' => 166,
			'Operator' => 121,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Variable' => 152,
			'HashDereference' => 129,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'OPTIONAL-46' => 169,
			'WordScoped' => 104,
			'ListElement' => 170,
			'ListElements' => 171,
			'SubExpression' => 168,
			'ArrayDereference' => 116,
			'HashReference' => 92
		}
	},
	{#State 102
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'MY' => 144,
			'OP01_OPEN' => 105,
			'CONSTANT_CALL_SCOPED' => 107,
			")" => -113,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 149,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			'LPAREN' => 97,
			"%{" => 98,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101
		},
		GOTOS => {
			'ListElements' => 172,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 168,
			'WordScoped' => 104,
			'ListElement' => 170,
			'OPTIONAL-33' => 173,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'Operator' => 121,
			'TypeInner' => 166,
			'HashDereference' => 129,
			'Variable' => 152,
			'ArrayReference' => 120,
			'Expression' => 148
		}
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 119
		},
		GOTOS => {
			'Variable' => 174,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 104
		ACTIONS => {
			'LPAREN' => 176,
			'OP02_METHOD_THINARROW_NEW' => 175
		}
	},
	{#State 105
		ACTIONS => {
			'MY' => 177
		}
	},
	{#State 106
		ACTIONS => {
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 194
		}
	},
	{#State 107
		DEFAULT => -128
	},
	{#State 108
		ACTIONS => {
			'LPAREN' => 195,
			'COLON' => -213
		}
	},
	{#State 109
		ACTIONS => {
			'COLON' => 196
		}
	},
	{#State 110
		ACTIONS => {
			'WORD_UPPERCASE' => 197
		},
		GOTOS => {
			'LoopLabel' => 198
		}
	},
	{#State 111
		DEFAULT => -172,
		GOTOS => {
			'STAR-43' => 199
		}
	},
	{#State 112
		ACTIONS => {
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			'SELF' => 119,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			"%{" => 98,
			'LPAREN' => 97,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'OP01_OPEN' => 105,
			'MY' => 144,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'ListElement' => 201,
			'WordScoped' => 104,
			'SubExpression' => 200,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Variable' => 152,
			'HashDereference' => 129,
			'Operator' => 121,
			'TypeInner' => 166,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 113
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 202,
			'WordScoped' => 104,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'Operator' => 121,
			'Variable' => 152,
			'HashDereference' => 129,
			'ArrayReference' => 120,
			'Expression' => 148
		}
	},
	{#State 114
		ACTIONS => {
			"}" => 203,
			'LITERAL_NUMBER' => 86,
			'WORD' => 205,
			'LITERAL_STRING' => 87,
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 119,
			"%{" => 98
		},
		GOTOS => {
			'HashEntry' => 209,
			'VariableOrLiteralOrWord' => 204,
			'HashDereference' => 208,
			'Variable' => 206,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 207
		}
	},
	{#State 115
		DEFAULT => -79
	},
	{#State 116
		DEFAULT => -137
	},
	{#State 117
		DEFAULT => -14
	},
	{#State 118
		DEFAULT => -116
	},
	{#State 119
		DEFAULT => -227
	},
	{#State 120
		DEFAULT => -136
	},
	{#State 121
		DEFAULT => -126
	},
	{#State 122
		DEFAULT => -148
	},
	{#State 123
		DEFAULT => -133
	},
	{#State 124
		DEFAULT => -226
	},
	{#State 125
		ACTIONS => {
			'SELF' => -111,
			'OP01_QW' => -111,
			'LITERAL_STRING' => -111,
			'LBRACE' => -111,
			'OP10_NAMED_UNARY' => -111,
			"\@{" => -111,
			'OP05_MATH_NEG_LPAREN' => -111,
			'VARIABLE_SYMBOL' => -111,
			"undef" => -111,
			'LBRACKET' => -111,
			"%{" => -111,
			'LPAREN' => -111,
			'CONSTANT_CALL_SCOPED' => -111,
			'STDOUT_STDERR' => 211,
			'FHREF_SYMBOL_BRACES' => 212,
			'WORD_SCOPED' => -111,
			'MY' => -111,
			'OP01_OPEN' => -111,
			'OP03_MATH_INC_DEC' => -111,
			'LITERAL_NUMBER' => -111,
			'OP01_NAMED' => -111,
			'WORD' => -111,
			'OP01_CLOSE' => -111,
			'OP22_LOGICAL_NEG' => -111,
			'OP05_LOGICAL_NEG' => -111,
			'WORD_UPPERCASE' => -111
		},
		GOTOS => {
			'PAREN-31' => 210,
			'OPTIONAL-32' => 213
		}
	},
	{#State 126
		ACTIONS => {
			'TYPE_FHREF' => 215,
			'TYPE_INTEGER' => 51,
			'WORD' => 54,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 214
		}
	},
	{#State 127
		DEFAULT => -17
	},
	{#State 128
		ACTIONS => {
			"foreach" => 218,
			"while" => 220,
			"for" => 216
		},
		GOTOS => {
			'Loop' => 219,
			'LoopFor' => 221,
			'LoopWhile' => 222,
			'LoopForEach' => 217
		}
	},
	{#State 129
		DEFAULT => -139
	},
	{#State 130
		ACTIONS => {
			'OP23_LOGICAL_AND' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			";" => 223,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP08_STRING_CAT' => -132,
			'OP18_TERNARY' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP04_MATH_POW' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP12_COMPARE_EQ_NE' => -132
		}
	},
	{#State 131
		DEFAULT => -151
	},
	{#State 132
		DEFAULT => -146
	},
	{#State 133
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'LPAREN' => 97,
			"%{" => 98,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'MY' => 144,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'TypeInner' => 166,
			'Operator' => 121,
			'HashDereference' => 129,
			'Variable' => 152,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'ListElement' => 170,
			'ListElements' => 224,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 168
		}
	},
	{#State 134
		ACTIONS => {
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			"undef" => 123,
			'LBRACKET' => 101,
			'VARIABLE_SYMBOL' => 124,
			'LPAREN' => 97,
			"%{" => 98,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'OP01_OPEN' => 105,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'SubExpression' => 225,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Variable' => 152,
			'HashDereference' => 129,
			'Operator' => 121
		}
	},
	{#State 135
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_UPPERCASE' => 149,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			"%{" => 98,
			'LPAREN' => 97,
			"undef" => 123,
			'LBRACKET' => 101,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'WordScoped' => 104,
			'HashReference' => 92,
			'SubExpression' => 226,
			'ArrayDereference' => 116,
			'Operator' => 121,
			'HashDereference' => 129,
			'Variable' => 152,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 136
		ACTIONS => {
			'FHREF_SYMBOL' => 227
		}
	},
	{#State 137
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 228
		}
	},
	{#State 138
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 229
		}
	},
	{#State 139
		DEFAULT => -57
	},
	{#State 140
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 107,
			"foreach" => -147,
			"}" => 231,
			'OP01_OPEN' => 105,
			'OP01_NAMED_VOID_LPAREN' => 102,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'WORD' => 26,
			'OP01_NAMED' => 112,
			'OP19_LOOP_CONTROL' => 110,
			'WORD_UPPERCASE' => 108,
			'OP19_LOOP_CONTROL_SCOLON' => 93,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98,
			"if" => 95,
			"while" => -147,
			'WORD_SCOPED' => 27,
			'OP01_PRINT' => 125,
			'MY' => 126,
			'OP01_CLOSE' => 136,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_NAMED_VOID' => 133,
			"for" => -147,
			'LITERAL_STRING' => 87,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'SELF' => 119,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'Statement' => 115,
			'OperatorVoid' => 89,
			'Literal' => 99,
			'VariableModification' => 96,
			'Conditional' => 122,
			'Operator' => 121,
			'Variable' => 94,
			'ArrayReference' => 120,
			'OPTIONAL-37' => 128,
			'SubExpression' => 106,
			'WordScoped' => 104,
			'Operation' => 230,
			'VariableSymbolOrSelf' => 111,
			'PAREN-36' => 132,
			'VariableDeclaration' => 131,
			'LoopLabel' => 109,
			'HashDereference' => 129,
			'Expression' => 130
		}
	},
	{#State 141
		ACTIONS => {
			'VARIABLE_SYMBOL' => 232
		}
	},
	{#State 142
		ACTIONS => {
			'WORD_UPPERCASE' => 233
		}
	},
	{#State 143
		DEFAULT => -43
	},
	{#State 144
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'WORD' => 54,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 234
		}
	},
	{#State 145
		DEFAULT => -193
	},
	{#State 146
		ACTIONS => {
			"}" => 235
		}
	},
	{#State 147
		ACTIONS => {
			'LBRACKET' => 101
		},
		GOTOS => {
			'ArrayReference' => 236
		}
	},
	{#State 148
		DEFAULT => -132
	},
	{#State 149
		ACTIONS => {
			'LPAREN' => 195
		}
	},
	{#State 150
		ACTIONS => {
			"%{" => 98,
			'LPAREN' => 97,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'WORD_UPPERCASE' => 149,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107
		},
		GOTOS => {
			'WordScoped' => 104,
			'ArrayDereference' => 116,
			'SubExpression' => 237,
			'HashReference' => 92,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 151
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => -96,
			"]" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			";" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP18_TERNARY' => -96,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -96,
			")" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP17_LIST_RANGE' => -96,
			"}" => -96
		}
	},
	{#State 152
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -135,
			";" => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP13_BITWISE_AND' => -135,
			"]" => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP03_MATH_INC_DEC' => 154,
			"}" => -135,
			'OP17_LIST_RANGE' => -135,
			")" => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP21_LIST_COMMA' => -135,
			'OP08_STRING_CAT' => -135,
			'OP18_TERNARY' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP02_METHOD_THINARROW' => 155,
			'OP11_COMPARE_LT_GT' => -135,
			'OP04_MATH_POW' => -135
		}
	},
	{#State 153
		ACTIONS => {
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'LPAREN' => 97,
			"%{" => 98,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113
		},
		GOTOS => {
			'Variable' => 152,
			'HashDereference' => 129,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Operator' => 121,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'WordScoped' => 104,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 238
		}
	},
	{#State 154
		DEFAULT => -86
	},
	{#State 155
		ACTIONS => {
			'LPAREN' => 239
		}
	},
	{#State 156
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'LPAREN' => 97,
			"%{" => 98,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'STDIN' => 240,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'SubExpressionOrStdin' => 241,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'Operator' => 121,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'SubExpression' => 242,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104
		}
	},
	{#State 157
		ACTIONS => {
			"%{" => 98,
			'LPAREN' => 97,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'WORD_UPPERCASE' => 149,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Operator' => 121,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'SubExpression' => 243,
			'ArrayDereference' => 116,
			'HashReference' => 92
		}
	},
	{#State 158
		DEFAULT => -152
	},
	{#State 159
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 244
		}
	},
	{#State 160
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'WORD_UPPERCASE' => 149,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'MY' => 144,
			'OP01_OPEN' => 105,
			'LPAREN' => 97,
			"%{" => 98,
			"undef" => 123,
			'LBRACKET' => 101,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			'SELF' => 119,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114
		},
		GOTOS => {
			'WordScoped' => 104,
			'ListElement' => 245,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 200,
			'Operator' => 121,
			'TypeInner' => 166,
			'HashDereference' => 129,
			'Variable' => 152,
			'Expression' => 148,
			'ArrayReference' => 120,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99
		}
	},
	{#State 161
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 188,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP17_LIST_RANGE' => 186,
			")" => 246,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193
		}
	},
	{#State 162
		DEFAULT => -207
	},
	{#State 163
		ACTIONS => {
			'LBRACE' => 114
		},
		GOTOS => {
			'HashReference' => 247
		}
	},
	{#State 164
		ACTIONS => {
			"}" => 248
		}
	},
	{#State 165
		DEFAULT => -16
	},
	{#State 166
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			"%{" => 98,
			'LPAREN' => 97,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Operator' => 121,
			'HashDereference' => 129,
			'Variable' => 152,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 249
		}
	},
	{#State 167
		DEFAULT => -189
	},
	{#State 168
		ACTIONS => {
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => 192,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -187,
			")" => -187,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 186,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			"]" => -187,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => -187
		}
	},
	{#State 169
		ACTIONS => {
			"]" => 250
		}
	},
	{#State 170
		DEFAULT => -185,
		GOTOS => {
			'STAR-45' => 251
		}
	},
	{#State 171
		DEFAULT => -190
	},
	{#State 172
		DEFAULT => -112
	},
	{#State 173
		ACTIONS => {
			")" => 252
		}
	},
	{#State 174
		DEFAULT => -85
	},
	{#State 175
		ACTIONS => {
			")" => 253
		}
	},
	{#State 176
		ACTIONS => {
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'MY' => 144,
			'OP01_OPEN' => 105,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			")" => -123,
			'WORD_UPPERCASE' => 149,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			'SELF' => 119,
			"%{" => 98,
			'LPAREN' => 97,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'TypeInner' => 166,
			'Operator' => 121,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'OPTIONAL-34' => 254,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'ListElement' => 170,
			'ListElements' => 255,
			'ArrayDereference' => 116,
			'SubExpression' => 168,
			'HashReference' => 92
		}
	},
	{#State 177
		ACTIONS => {
			'TYPE_FHREF' => 256
		}
	},
	{#State 178
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"%{" => 98,
			'LPAREN' => 97,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Variable' => 152,
			'HashDereference' => 129,
			'Operator' => 121,
			'ArrayDereference' => 116,
			'SubExpression' => 257,
			'HashReference' => 92,
			'WordScoped' => 104
		}
	},
	{#State 179
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 258
		}
	},
	{#State 180
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'WORD_UPPERCASE' => 149,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105,
			"%{" => 98,
			'LPAREN' => 97,
			"undef" => 123,
			'LBRACKET' => 101,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114
		},
		GOTOS => {
			'WordScoped' => 104,
			'ArrayDereference' => 116,
			'SubExpression' => 259,
			'HashReference' => 92,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 181
		ACTIONS => {
			"undef" => 123,
			'LBRACKET' => 101,
			'VARIABLE_SYMBOL' => 124,
			"%{" => 98,
			'LPAREN' => 97,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'WORD_UPPERCASE' => 149,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_OPEN' => 105,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107
		},
		GOTOS => {
			'Expression' => 148,
			'ArrayReference' => 120,
			'Variable' => 152,
			'HashDereference' => 129,
			'Operator' => 121,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'WordScoped' => 104,
			'ArrayDereference' => 116,
			'SubExpression' => 260,
			'HashReference' => 92
		}
	},
	{#State 182
		ACTIONS => {
			'WORD_UPPERCASE' => 149,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_OPEN' => 105,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			"%{" => 98,
			'LPAREN' => 97,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LITERAL_STRING' => 87,
			'SELF' => 119
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'SubExpression' => 261,
			'HashReference' => 92,
			'WordScoped' => 104,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'Operator' => 121,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Variable' => 152,
			'HashDereference' => 129
		}
	},
	{#State 183
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'WORD_UPPERCASE' => 149,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105,
			'LPAREN' => 97,
			"%{" => 98,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91
		},
		GOTOS => {
			'WordScoped' => 104,
			'ArrayDereference' => 116,
			'SubExpression' => 262,
			'HashReference' => 92,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Variable' => 152,
			'HashDereference' => 129,
			'Operator' => 121,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99
		}
	},
	{#State 184
		ACTIONS => {
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87
		},
		GOTOS => {
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'SubExpression' => 263,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104
		}
	},
	{#State 185
		ACTIONS => {
			'LPAREN' => 97,
			"%{" => 98,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'WORD_UPPERCASE' => 149,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'WordScoped' => 104,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 264,
			'Variable' => 152,
			'HashDereference' => 129,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Operator' => 121,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 186
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'LPAREN' => 97,
			"%{" => 98,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'SubExpression' => 265,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104
		}
	},
	{#State 187
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'LPAREN' => 97,
			"%{" => 98,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_UPPERCASE' => 149,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150
		},
		GOTOS => {
			'SubExpression' => 266,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121
		}
	},
	{#State 188
		ACTIONS => {
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			"%{" => 98,
			'LPAREN' => 97
		},
		GOTOS => {
			'SubExpression' => 267,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121
		}
	},
	{#State 189
		ACTIONS => {
			'LPAREN' => 97,
			"%{" => 98,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105
		},
		GOTOS => {
			'HashReference' => 92,
			'SubExpression' => 268,
			'ArrayDereference' => 116,
			'WordScoped' => 104,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'Operator' => 121,
			'HashDereference' => 129,
			'Variable' => 152,
			'Expression' => 148,
			'ArrayReference' => 120
		}
	},
	{#State 190
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98
		},
		GOTOS => {
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'SubExpression' => 269,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104
		}
	},
	{#State 191
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'WORD_UPPERCASE' => 149,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105,
			"%{" => 98,
			'LPAREN' => 97,
			"undef" => 123,
			'LBRACKET' => 101,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'Operator' => 121,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'SubExpression' => 270,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104
		}
	},
	{#State 192
		ACTIONS => {
			'LITERAL_STRING' => 87,
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 119,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'VariableOrLiteral' => 273,
			'Literal' => 272,
			'VariableSymbolOrSelf' => 111,
			'Variable' => 271
		}
	},
	{#State 193
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'ArrayDereference' => 116,
			'SubExpression' => 274,
			'HashReference' => 92,
			'WordScoped' => 104
		}
	},
	{#State 194
		ACTIONS => {
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			"%{" => 98,
			'LPAREN' => 97,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'SubExpression' => 275,
			'ArrayDereference' => 116,
			'HashReference' => 92
		}
	},
	{#State 195
		ACTIONS => {
			")" => 276
		}
	},
	{#State 196
		DEFAULT => -145
	},
	{#State 197
		DEFAULT => -213
	},
	{#State 198
		ACTIONS => {
			";" => 277
		}
	},
	{#State 199
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -173,
			'OP17_LIST_RANGE' => -173,
			"}" => -173,
			'OP12_COMPARE_EQ_NE' => -173,
			'OP19_VARIABLE_ASSIGN_BY' => -173,
			")" => -173,
			'OP21_LIST_COMMA' => -173,
			'OP07_STRING_REPEAT' => -173,
			'OP08_STRING_CAT' => -173,
			'OP18_TERNARY' => -173,
			'OP16_LOGICAL_OR' => -173,
			'OP02_METHOD_THINARROW' => -173,
			'OP11_COMPARE_LT_GT' => -173,
			'OP04_MATH_POW' => -173,
			'COLON' => -173,
			";" => -173,
			'OP02_ARRAY_THINARROW' => 279,
			'OP07_MATH_MULT_DIV_MOD' => -173,
			'OP09_BITWISE_SHIFT' => -173,
			'OP08_MATH_ADD_SUB' => -173,
			'OP24_LOGICAL_OR_XOR' => -173,
			'OP23_LOGICAL_AND' => -173,
			'OP20_HASH_FATARROW' => -173,
			'OP13_BITWISE_AND' => -173,
			"]" => -173,
			'OP06_REGEX_MATCH' => -173,
			'OP19_VARIABLE_ASSIGN' => -173,
			'OP02_HASH_THINARROW' => 278,
			'OP15_LOGICAL_AND' => -173,
			'OP14_BITWISE_OR_XOR' => -173
		},
		GOTOS => {
			'VariableRetrieval' => 280
		}
	},
	{#State 200
		ACTIONS => {
			'OP23_LOGICAL_AND' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			";" => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP21_LIST_COMMA' => -187,
			'OP08_STRING_CAT' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP18_TERNARY' => -81,
			'OP04_MATH_POW' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP17_LIST_RANGE' => -81,
			")" => -81,
			'OP12_COMPARE_EQ_NE' => -81
		}
	},
	{#State 201
		ACTIONS => {
			'OP21_LIST_COMMA' => 281
		}
	},
	{#State 202
		ACTIONS => {
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 188,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => 192,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => 282
		}
	},
	{#State 203
		DEFAULT => -206
	},
	{#State 204
		ACTIONS => {
			'OP20_HASH_FATARROW' => 283
		}
	},
	{#State 205
		DEFAULT => -225
	},
	{#State 206
		DEFAULT => -223
	},
	{#State 207
		DEFAULT => -224
	},
	{#State 208
		DEFAULT => -200
	},
	{#State 209
		DEFAULT => -204,
		GOTOS => {
			'STAR-50' => 284
		}
	},
	{#State 210
		DEFAULT => -110
	},
	{#State 211
		DEFAULT => -109
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			"%{" => 98,
			'LPAREN' => 97,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'MY' => 144,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'WordScoped' => 104,
			'ListElement' => 170,
			'ListElements' => 285,
			'ArrayDereference' => 116,
			'SubExpression' => 168,
			'HashReference' => 92,
			'Operator' => 121,
			'TypeInner' => 166,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 213
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'MY' => 144,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'WORD_UPPERCASE' => 149,
			'SELF' => 119,
			'OP01_QW' => 167,
			'LITERAL_STRING' => 87,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'LPAREN' => 97,
			"%{" => 98,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123
		},
		GOTOS => {
			'ListElement' => 170,
			'WordScoped' => 104,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 168,
			'ListElements' => 286,
			'Variable' => 152,
			'HashDereference' => 129,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Operator' => 121,
			'TypeInner' => 166,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 214
		ACTIONS => {
			'VARIABLE_SYMBOL' => 287
		}
	},
	{#State 215
		ACTIONS => {
			'FHREF_SYMBOL' => 288
		}
	},
	{#State 216
		ACTIONS => {
			'MY' => 289,
			'LPAREN_MY' => 290
		}
	},
	{#State 217
		DEFAULT => -161
	},
	{#State 218
		ACTIONS => {
			'MY' => 291
		}
	},
	{#State 219
		DEFAULT => -149
	},
	{#State 220
		ACTIONS => {
			'LPAREN_MY' => 292,
			'LPAREN' => 293
		}
	},
	{#State 221
		DEFAULT => -160
	},
	{#State 222
		DEFAULT => -162
	},
	{#State 223
		DEFAULT => -78
	},
	{#State 224
		ACTIONS => {
			";" => 294
		}
	},
	{#State 225
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -88,
			'OP15_LOGICAL_AND' => -88,
			'OP06_REGEX_MATCH' => -88,
			'OP23_LOGICAL_AND' => -88,
			"]" => -88,
			'OP13_BITWISE_AND' => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			";" => -88,
			'OP07_MATH_MULT_DIV_MOD' => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP04_MATH_POW' => 183,
			'OP18_TERNARY' => -88,
			'OP16_LOGICAL_OR' => -88,
			'OP08_STRING_CAT' => -88,
			'OP07_STRING_REPEAT' => -88,
			'OP21_LIST_COMMA' => -88,
			")" => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			'OP17_LIST_RANGE' => -88,
			"}" => -88
		}
	},
	{#State 226
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -106,
			")" => -106,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 186,
			"}" => -106,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => -106,
			"]" => -106,
			'OP13_BITWISE_AND' => 188,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			";" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 191
		}
	},
	{#State 227
		DEFAULT => -84
	},
	{#State 228
		ACTIONS => {
			'LBRACE' => 295
		}
	},
	{#State 229
		ACTIONS => {
			"our" => 297,
			'LITERAL_NUMBER' => 298
		},
		GOTOS => {
			'Subroutine' => 299,
			'Method' => 300,
			'MethodOrSubroutine' => 296
		}
	},
	{#State 230
		DEFAULT => -46
	},
	{#State 231
		ACTIONS => {
			";" => 301
		}
	},
	{#State 232
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 302
		}
	},
	{#State 233
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 303
		}
	},
	{#State 234
		ACTIONS => {
			"\$TYPED_" => 304
		}
	},
	{#State 235
		DEFAULT => -195
	},
	{#State 236
		ACTIONS => {
			"}" => 305
		}
	},
	{#State 237
		ACTIONS => {
			'OP08_STRING_CAT' => -81,
			'OP21_LIST_COMMA' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP04_MATH_POW' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP18_TERNARY' => -81,
			'OP16_LOGICAL_OR' => -81,
			"}" => -81,
			'OP17_LIST_RANGE' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			")" => -81,
			'OP06_REGEX_MATCH' => -81,
			"]" => -81,
			'OP13_BITWISE_AND' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			";" => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP09_BITWISE_SHIFT' => -81
		}
	},
	{#State 238
		ACTIONS => {
			";" => -182,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP23_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => -182,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183
		}
	},
	{#State 239
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			"%{" => 98,
			'LPAREN' => 97,
			'MY' => 144,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			")" => -125,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'OPTIONAL-35' => 306,
			'Operator' => 121,
			'TypeInner' => 166,
			'HashDereference' => 129,
			'Variable' => 152,
			'ArrayReference' => 120,
			'Expression' => 148,
			'ListElements' => 307,
			'HashReference' => 92,
			'SubExpression' => 168,
			'ArrayDereference' => 116,
			'WordScoped' => 104,
			'ListElement' => 170
		}
	},
	{#State 240
		DEFAULT => -142
	},
	{#State 241
		DEFAULT => -181
	},
	{#State 242
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => -141,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			")" => -141,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 186,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => 192,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185
		}
	},
	{#State 243
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP23_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => 308,
			'OP17_LIST_RANGE' => 186,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184
		}
	},
	{#State 244
		ACTIONS => {
			'SELF' => 119,
			'OP01_QW' => 167,
			'LITERAL_STRING' => 87,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"%{" => 98,
			'LPAREN' => 97,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'MY' => 144,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'WordScoped' => 104,
			'ListElement' => 170,
			'ListElements' => 309,
			'SubExpression' => 168,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'TypeInner' => 166,
			'Operator' => 121,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Variable' => 152,
			'HashDereference' => 129,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 245
		ACTIONS => {
			'OP21_LIST_COMMA' => 310
		}
	},
	{#State 246
		DEFAULT => -140
	},
	{#State 247
		ACTIONS => {
			"}" => 311
		}
	},
	{#State 248
		DEFAULT => -209
	},
	{#State 249
		ACTIONS => {
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => 180,
			"]" => -188,
			'OP13_BITWISE_AND' => 188,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			";" => -188,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -188,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => 192,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => -188
		}
	},
	{#State 250
		DEFAULT => -192
	},
	{#State 251
		ACTIONS => {
			")" => -186,
			'OP21_LIST_COMMA' => 313,
			"]" => -186,
			";" => -186
		},
		GOTOS => {
			'PAREN-44' => 312
		}
	},
	{#State 252
		ACTIONS => {
			";" => 314
		}
	},
	{#State 253
		DEFAULT => -131
	},
	{#State 254
		ACTIONS => {
			")" => 315
		}
	},
	{#State 255
		DEFAULT => -122
	},
	{#State 256
		ACTIONS => {
			'FHREF_SYMBOL' => 316
		}
	},
	{#State 257
		ACTIONS => {
			'OP17_LIST_RANGE' => -102,
			"}" => -102,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => -102,
			'OP21_LIST_COMMA' => -102,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP16_LOGICAL_OR' => -102,
			'OP18_TERNARY' => -102,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			";" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP23_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => 188,
			"]" => -102,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => -102,
			'OP14_BITWISE_OR_XOR' => 187
		}
	},
	{#State 258
		DEFAULT => -90
	},
	{#State 259
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => -107,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			"]" => -107,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => -107,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => -107,
			"}" => -107,
			'OP17_LIST_RANGE' => 186,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => 192,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -107
		}
	},
	{#State 260
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -95,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => -95,
			'OP18_TERNARY' => -95,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -95,
			")" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"}" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => 179,
			"]" => -95,
			'OP13_BITWISE_AND' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => -95
		}
	},
	{#State 261
		ACTIONS => {
			'OP08_STRING_CAT' => 184,
			'OP21_LIST_COMMA' => -98,
			'OP07_STRING_REPEAT' => 185,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => undef,
			'OP16_LOGICAL_OR' => -98,
			'OP18_TERNARY' => -98,
			"}" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			")" => -98,
			'OP06_REGEX_MATCH' => 179,
			"]" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => -98,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181
		}
	},
	{#State 262
		ACTIONS => {
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => -87,
			'OP18_TERNARY' => -87,
			'OP16_LOGICAL_OR' => -87,
			'OP08_STRING_CAT' => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP21_LIST_COMMA' => -87,
			")" => -87,
			'OP12_COMPARE_EQ_NE' => -87,
			"}" => -87,
			'OP17_LIST_RANGE' => -87,
			'OP14_BITWISE_OR_XOR' => -87,
			'OP15_LOGICAL_AND' => -87,
			'OP06_REGEX_MATCH' => -87,
			"]" => -87,
			'OP13_BITWISE_AND' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP08_MATH_ADD_SUB' => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP07_MATH_MULT_DIV_MOD' => -87,
			";" => -87
		}
	},
	{#State 263
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => -94,
			"]" => -94,
			'OP13_BITWISE_AND' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			'OP08_MATH_ADD_SUB' => 190,
			";" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP18_TERNARY' => -94,
			'OP08_STRING_CAT' => -94,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -94,
			")" => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP17_LIST_RANGE' => -94,
			"}" => -94
		}
	},
	{#State 264
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -91,
			")" => -91,
			'OP17_LIST_RANGE' => -91,
			"}" => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => -91,
			'OP18_TERNARY' => -91,
			'OP08_STRING_CAT' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			";" => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => -91,
			"]" => -91,
			'OP13_BITWISE_AND' => -91
		}
	},
	{#State 265
		ACTIONS => {
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => -104,
			'OP08_STRING_CAT' => 184,
			'OP21_LIST_COMMA' => -104,
			'OP07_STRING_REPEAT' => 185,
			")" => -104,
			'OP12_COMPARE_EQ_NE' => 194,
			"}" => -104,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			"]" => -104,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => -104
		}
	},
	{#State 266
		ACTIONS => {
			'OP21_LIST_COMMA' => -101,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP18_TERNARY' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP17_LIST_RANGE' => -101,
			"}" => -101,
			")" => -101,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP23_LOGICAL_AND' => -101,
			'OP13_BITWISE_AND' => 188,
			"]" => -101,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			";" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => -101
		}
	},
	{#State 267
		ACTIONS => {
			";" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => -100,
			"]" => -100,
			'OP13_BITWISE_AND' => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			"}" => -100,
			")" => -100,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -100,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => -100,
			'OP18_TERNARY' => -100
		}
	},
	{#State 268
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => -108,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP06_REGEX_MATCH' => 179,
			"]" => -108,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			"}" => -108,
			'OP17_LIST_RANGE' => 186,
			")" => -108,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -108,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193
		}
	},
	{#State 269
		ACTIONS => {
			";" => -93,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => -93,
			"]" => -93,
			'OP13_BITWISE_AND' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			"}" => -93,
			")" => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP08_STRING_CAT' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP07_STRING_REPEAT' => 185,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => -93,
			'OP18_TERNARY' => -93,
			'OP16_LOGICAL_OR' => -93
		}
	},
	{#State 270
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			";" => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP13_BITWISE_AND' => -92,
			"]" => -92,
			'OP06_REGEX_MATCH' => 179,
			'OP12_COMPARE_EQ_NE' => -92,
			")" => -92,
			'OP17_LIST_RANGE' => -92,
			"}" => -92,
			'OP18_TERNARY' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => -92
		}
	},
	{#State 271
		DEFAULT => -221
	},
	{#State 272
		DEFAULT => -222
	},
	{#State 273
		ACTIONS => {
			'COLON' => 317
		}
	},
	{#State 274
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 194,
			")" => -103,
			'OP17_LIST_RANGE' => -103,
			"}" => -103,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => -103,
			'OP18_TERNARY' => -103,
			'OP08_STRING_CAT' => 184,
			'OP21_LIST_COMMA' => -103,
			'OP07_STRING_REPEAT' => 185,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			";" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => -103,
			"]" => -103,
			'OP13_BITWISE_AND' => 188
		}
	},
	{#State 275
		ACTIONS => {
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -99,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => -99,
			'OP18_TERNARY' => -99,
			'OP17_LIST_RANGE' => -99,
			"}" => -99,
			'OP12_COMPARE_EQ_NE' => undef,
			")" => -99,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => -99,
			"]" => -99,
			'OP13_BITWISE_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP15_LOGICAL_AND' => -99,
			";" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190
		}
	},
	{#State 276
		DEFAULT => -127
	},
	{#State 277
		DEFAULT => -121
	},
	{#State 278
		ACTIONS => {
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"%{" => 98,
			'LPAREN' => 97,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'WORD' => 319,
			'OP01_CLOSE' => 136,
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'Operator' => 121,
			'Variable' => 152,
			'HashDereference' => 129,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 318,
			'WordScoped' => 104
		}
	},
	{#State 279
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'WORD_UPPERCASE' => 149,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"%{" => 98,
			'LPAREN' => 97,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101
		},
		GOTOS => {
			'WordScoped' => 104,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 320,
			'Variable' => 152,
			'HashDereference' => 129,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Operator' => 121,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99
		}
	},
	{#State 280
		DEFAULT => -171
	},
	{#State 281
		ACTIONS => {
			'WORD_UPPERCASE' => 149,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105,
			'MY' => 144,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'LPAREN' => 97,
			"%{" => 98,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'SELF' => 119,
			'OP01_QW' => 167,
			'LITERAL_STRING' => 87
		},
		GOTOS => {
			'ListElement' => 170,
			'WordScoped' => 104,
			'ArrayDereference' => 116,
			'SubExpression' => 168,
			'HashReference' => 92,
			'ListElements' => 321,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'TypeInner' => 166,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 282
		DEFAULT => -89
	},
	{#State 283
		ACTIONS => {
			'OP01_OPEN' => -198,
			'MY' => 144,
			'LITERAL_NUMBER' => -198,
			'OP03_MATH_INC_DEC' => -198,
			'WORD_SCOPED' => -198,
			'CONSTANT_CALL_SCOPED' => -198,
			'WORD_UPPERCASE' => -198,
			'OP01_CLOSE' => -198,
			'WORD' => -198,
			'OP01_NAMED' => -198,
			'OP05_LOGICAL_NEG' => -198,
			'OP22_LOGICAL_NEG' => -198,
			'LBRACE' => -198,
			'OP10_NAMED_UNARY' => -198,
			'OP05_MATH_NEG_LPAREN' => -198,
			"\@{" => -198,
			'LITERAL_STRING' => -198,
			'SELF' => -198,
			'LBRACKET' => -198,
			"undef" => -198,
			'VARIABLE_SYMBOL' => -198,
			"%{" => -198,
			'LPAREN' => -198
		},
		GOTOS => {
			'OPTIONAL-48' => 323,
			'TypeInner' => 322
		}
	},
	{#State 284
		ACTIONS => {
			'OP21_LIST_COMMA' => 326,
			"}" => 324
		},
		GOTOS => {
			'PAREN-49' => 325
		}
	},
	{#State 285
		ACTIONS => {
			";" => 327
		}
	},
	{#State 286
		ACTIONS => {
			";" => 328
		}
	},
	{#State 287
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 331,
			'OP02_ARRAY_THINARROW' => 329,
			";" => 330
		}
	},
	{#State 288
		ACTIONS => {
			";" => 332
		}
	},
	{#State 289
		ACTIONS => {
			'TYPE_INTEGER' => 333
		}
	},
	{#State 290
		ACTIONS => {
			'TYPE_INTEGER' => 334
		}
	},
	{#State 291
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD_SCOPED' => 52,
			'WORD' => 54
		},
		GOTOS => {
			'Type' => 335
		}
	},
	{#State 292
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'WORD' => 54,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 336
		}
	},
	{#State 293
		ACTIONS => {
			'LPAREN' => 97,
			"%{" => 98,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105
		},
		GOTOS => {
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'HashDereference' => 129,
			'Variable' => 152,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Operator' => 121,
			'HashReference' => 92,
			'SubExpression' => 337,
			'ArrayDereference' => 116,
			'WordScoped' => 104
		}
	},
	{#State 294
		DEFAULT => -118
	},
	{#State 295
		ACTIONS => {
			'WORD' => 339,
			"}" => 340
		},
		GOTOS => {
			'HashEntryProperties' => 338
		}
	},
	{#State 296
		DEFAULT => -59
	},
	{#State 297
		ACTIONS => {
			'TYPE_METHOD' => 341,
			'WORD' => 54,
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 298
		ACTIONS => {
			";" => 342
		}
	},
	{#State 299
		DEFAULT => -77
	},
	{#State 300
		DEFAULT => -76
	},
	{#State 301
		DEFAULT => -48
	},
	{#State 302
		ACTIONS => {
			'OP21_LIST_COMMA' => 343,
			")" => 345
		},
		GOTOS => {
			'PAREN-19' => 344
		}
	},
	{#State 303
		DEFAULT => -220
	},
	{#State 304
		ACTIONS => {
			'WORD' => 346
		}
	},
	{#State 305
		DEFAULT => -196
	},
	{#State 306
		ACTIONS => {
			")" => 347
		}
	},
	{#State 307
		DEFAULT => -124
	},
	{#State 308
		ACTIONS => {
			'LBRACE' => 349
		},
		GOTOS => {
			'CodeBlock' => 348
		}
	},
	{#State 309
		ACTIONS => {
			")" => 350
		}
	},
	{#State 310
		ACTIONS => {
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'OP01_QW' => 167,
			'LITERAL_STRING' => 87,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'LPAREN' => 97,
			"%{" => 98,
			'OP01_OPEN' => 105,
			'MY' => 144,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'SubExpression' => 168,
			'HashReference' => 92,
			'ListElements' => 351,
			'ListElement' => 170,
			'WordScoped' => 104,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121,
			'TypeInner' => 166
		}
	},
	{#State 311
		DEFAULT => -210
	},
	{#State 312
		DEFAULT => -184
	},
	{#State 313
		ACTIONS => {
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'MY' => 144,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			"%{" => 98,
			'LPAREN' => 97,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP01_QW' => 167,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113
		},
		GOTOS => {
			'Variable' => 152,
			'HashDereference' => 129,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Operator' => 121,
			'TypeInner' => 166,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ListElement' => 352,
			'WordScoped' => 104,
			'HashReference' => 92,
			'SubExpression' => 168,
			'ArrayDereference' => 116
		}
	},
	{#State 314
		DEFAULT => -117
	},
	{#State 315
		DEFAULT => -129
	},
	{#State 316
		ACTIONS => {
			'OP21_LIST_COMMA' => 353
		}
	},
	{#State 317
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Literal' => 272,
			'VariableSymbolOrSelf' => 111,
			'VariableOrLiteral' => 354,
			'Variable' => 271
		}
	},
	{#State 318
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 186,
			"}" => 355,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP23_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 188,
			'OP06_REGEX_MATCH' => 179
		}
	},
	{#State 319
		ACTIONS => {
			"}" => 356,
			'OP02_METHOD_THINARROW_NEW' => -211,
			'LPAREN' => -211
		}
	},
	{#State 320
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			"]" => 357,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 186
		}
	},
	{#State 321
		ACTIONS => {
			";" => 358
		}
	},
	{#State 322
		DEFAULT => -197
	},
	{#State 323
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'Operator' => 121,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Variable' => 152,
			'HashDereference' => 129,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'SubExpression' => 359,
			'ArrayDereference' => 116,
			'HashReference' => 92
		}
	},
	{#State 324
		DEFAULT => -205
	},
	{#State 325
		DEFAULT => -203
	},
	{#State 326
		ACTIONS => {
			'WORD' => 205,
			'LITERAL_STRING' => 87,
			'VARIABLE_SYMBOL' => 124,
			'SELF' => 119,
			"%{" => 98,
			'LITERAL_NUMBER' => 86
		},
		GOTOS => {
			'Variable' => 206,
			'HashDereference' => 208,
			'HashEntry' => 360,
			'VariableOrLiteralOrWord' => 204,
			'Literal' => 207,
			'VariableSymbolOrSelf' => 111
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
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98
		},
		GOTOS => {
			'Operator' => 121,
			'HashDereference' => 129,
			'Variable' => 152,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 361
		}
	},
	{#State 330
		DEFAULT => -177
	},
	{#State 331
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'OP01_OPEN' => 105,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'STDIN' => 240,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'LPAREN' => 97,
			"%{" => 98
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'SubExpressionOrStdin' => 362,
			'Variable' => 152,
			'HashDereference' => 129,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Operator' => 121,
			'HashReference' => 92,
			'SubExpression' => 242,
			'ArrayDereference' => 116,
			'WordScoped' => 104
		}
	},
	{#State 332
		DEFAULT => -180
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
			'VARIABLE_SYMBOL' => 366
		}
	},
	{#State 337
		ACTIONS => {
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP17_LIST_RANGE' => 186,
			")" => 367,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP06_REGEX_MATCH' => 179,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190
		}
	},
	{#State 338
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 368
		}
	},
	{#State 339
		ACTIONS => {
			'OP20_HASH_FATARROW' => 369
		}
	},
	{#State 340
		ACTIONS => {
			";" => 370
		}
	},
	{#State 341
		ACTIONS => {
			'VARIABLE_SYMBOL' => 371
		}
	},
	{#State 342
		DEFAULT => -61
	},
	{#State 343
		ACTIONS => {
			'MY' => 372
		}
	},
	{#State 344
		DEFAULT => -50
	},
	{#State 345
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 373
		}
	},
	{#State 346
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 374
		}
	},
	{#State 347
		DEFAULT => -130
	},
	{#State 348
		DEFAULT => -155,
		GOTOS => {
			'STAR-39' => 375
		}
	},
	{#State 349
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'OP01_NAMED_VOID_SCOLON' => 118,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_CLOSE' => 136,
			"for" => -147,
			'OP01_NAMED_VOID' => 133,
			'WORD_SCOPED' => 27,
			'MY' => 126,
			'OP01_PRINT' => 125,
			'LPAREN' => 97,
			"%{" => 98,
			'LBRACKET' => 101,
			"while" => -147,
			"if" => 95,
			'OP19_LOOP_CONTROL_SCOLON' => 93,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'OP19_LOOP_CONTROL' => 110,
			'OP01_NAMED' => 112,
			'WORD' => 26,
			'WORD_UPPERCASE' => 108,
			"foreach" => -147,
			'CONSTANT_CALL_SCOPED' => 107,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_NAMED_VOID_LPAREN' => 102,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105
		},
		GOTOS => {
			'PLUS-42' => 376,
			'Literal' => 99,
			'Operator' => 121,
			'VariableModification' => 96,
			'Conditional' => 122,
			'Variable' => 94,
			'ArrayReference' => 120,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'Statement' => 115,
			'OperatorVoid' => 89,
			'VariableSymbolOrSelf' => 111,
			'PAREN-36' => 132,
			'VariableDeclaration' => 131,
			'LoopLabel' => 109,
			'HashDereference' => 129,
			'Expression' => 130,
			'OPTIONAL-37' => 128,
			'SubExpression' => 106,
			'WordScoped' => 104,
			'Operation' => 377
		}
	},
	{#State 350
		DEFAULT => -80
	},
	{#State 351
		ACTIONS => {
			")" => 378
		}
	},
	{#State 352
		DEFAULT => -183
	},
	{#State 353
		ACTIONS => {
			'LITERAL_STRING' => 379
		}
	},
	{#State 354
		DEFAULT => -105
	},
	{#State 355
		DEFAULT => -175
	},
	{#State 356
		DEFAULT => -176
	},
	{#State 357
		DEFAULT => -174
	},
	{#State 358
		DEFAULT => -119
	},
	{#State 359
		ACTIONS => {
			"}" => -199,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP08_STRING_CAT' => 184,
			'OP21_LIST_COMMA' => -199,
			'OP07_STRING_REPEAT' => 185,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP06_REGEX_MATCH' => 179,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178
		}
	},
	{#State 360
		DEFAULT => -202
	},
	{#State 361
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => 180,
			"]" => 380,
			'OP13_BITWISE_AND' => 188,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 186,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => 192,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185
		}
	},
	{#State 362
		ACTIONS => {
			";" => 381
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
			'LPAREN' => 384
		}
	},
	{#State 366
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 385
		}
	},
	{#State 367
		ACTIONS => {
			'LBRACE' => 349
		},
		GOTOS => {
			'CodeBlock' => 386
		}
	},
	{#State 368
		ACTIONS => {
			"}" => 387,
			'OP21_LIST_COMMA' => 389
		},
		GOTOS => {
			'PAREN-25' => 388
		}
	},
	{#State 369
		ACTIONS => {
			'MY' => 390
		},
		GOTOS => {
			'TypeInnerProperties' => 391
		}
	},
	{#State 370
		DEFAULT => -66
	},
	{#State 371
		ACTIONS => {
			"= sub {" => 392
		}
	},
	{#State 372
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 54,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 393
		}
	},
	{#State 373
		ACTIONS => {
			"\@_;" => 394
		}
	},
	{#State 374
		DEFAULT => -217
	},
	{#State 375
		ACTIONS => {
			"while" => -158,
			"if" => -158,
			'LPAREN' => -158,
			"%{" => -158,
			'LBRACKET' => -158,
			"\@{" => -158,
			'OP10_NAMED_UNARY' => -158,
			'OP19_LOOP_CONTROL_SCOLON' => -158,
			'' => -158,
			'WORD_UPPERCASE' => -158,
			"elsif" => 398,
			'OP19_LOOP_CONTROL' => -158,
			'WORD' => -158,
			'OP01_NAMED' => -158,
			'OP01_NAMED_VOID_LPAREN' => -158,
			'LITERAL_NUMBER' => -158,
			'OP03_MATH_INC_DEC' => -158,
			'OP01_OPEN' => -158,
			"}" => -158,
			"foreach" => -158,
			'CONSTANT_CALL_SCOPED' => -158,
			"undef" => -158,
			'VARIABLE_SYMBOL' => -158,
			'OP05_MATH_NEG_LPAREN' => -158,
			'LBRACE' => -158,
			'LITERAL_STRING' => -158,
			'OP01_NAMED_VOID_SCOLON' => -158,
			'SELF' => -158,
			"for" => -158,
			'OP01_NAMED_VOID' => -158,
			'OP05_LOGICAL_NEG' => -158,
			'OP22_LOGICAL_NEG' => -158,
			'OP01_CLOSE' => -158,
			'MY' => -158,
			'OP01_PRINT' => -158,
			"else" => 395,
			'WORD_SCOPED' => -158
		},
		GOTOS => {
			'PAREN-38' => 397,
			'PAREN-40' => 399,
			'OPTIONAL-41' => 396
		}
	},
	{#State 376
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 118,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'WORD_SCOPED' => 27,
			'OP01_PRINT' => 125,
			'MY' => 126,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_CLOSE' => 136,
			"for" => -147,
			'OP01_NAMED_VOID' => 133,
			'OP19_LOOP_CONTROL_SCOLON' => 93,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			"%{" => 98,
			'LPAREN' => 97,
			'LBRACKET' => 101,
			"while" => -147,
			"if" => 95,
			'CONSTANT_CALL_SCOPED' => 107,
			"foreach" => -147,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_VOID_LPAREN' => 102,
			"}" => 401,
			'OP01_OPEN' => 105,
			'OP19_LOOP_CONTROL' => 110,
			'OP01_NAMED' => 112,
			'WORD' => 26,
			'WORD_UPPERCASE' => 108
		},
		GOTOS => {
			'OPTIONAL-37' => 128,
			'SubExpression' => 106,
			'WordScoped' => 104,
			'Operation' => 400,
			'VariableSymbolOrSelf' => 111,
			'PAREN-36' => 132,
			'VariableDeclaration' => 131,
			'LoopLabel' => 109,
			'HashDereference' => 129,
			'Expression' => 130,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'Statement' => 115,
			'OperatorVoid' => 89,
			'Literal' => 99,
			'VariableModification' => 96,
			'Conditional' => 122,
			'Operator' => 121,
			'Variable' => 94,
			'ArrayReference' => 120
		}
	},
	{#State 377
		DEFAULT => -169
	},
	{#State 378
		DEFAULT => -82
	},
	{#State 379
		ACTIONS => {
			'OP21_LIST_COMMA' => 402
		}
	},
	{#State 380
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 403
		}
	},
	{#State 381
		DEFAULT => -178
	},
	{#State 382
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'SubExpression' => 404,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'WordScoped' => 104,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Variable' => 152,
			'HashDereference' => 129,
			'Operator' => 121
		}
	},
	{#State 383
		ACTIONS => {
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			"%{" => 98,
			'LPAREN' => 97,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87
		},
		GOTOS => {
			'Operator' => 121,
			'Variable' => 152,
			'HashDereference' => 129,
			'Expression' => 148,
			'ArrayReference' => 120,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'WordScoped' => 104,
			'HashReference' => 92,
			'SubExpression' => 405,
			'ArrayDereference' => 116
		}
	},
	{#State 384
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'MY' => 144,
			'OP01_OPEN' => 105,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 149,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'SELF' => 119,
			'OP01_QW' => 167,
			'LITERAL_STRING' => 87,
			"%{" => 98,
			'LPAREN' => 97,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123
		},
		GOTOS => {
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'Operator' => 121,
			'TypeInner' => 166,
			'HashDereference' => 129,
			'Variable' => 152,
			'Expression' => 148,
			'ArrayReference' => 120,
			'ListElements' => 406,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 168,
			'WordScoped' => 104,
			'ListElement' => 170
		}
	},
	{#State 385
		ACTIONS => {
			'STDIN' => 240,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD_UPPERCASE' => 149,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'OP01_OPEN' => 105,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'LPAREN' => 97,
			"%{" => 98,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90
		},
		GOTOS => {
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 242,
			'WordScoped' => 104,
			'SubExpressionOrStdin' => 407,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'Operator' => 121,
			'Variable' => 152,
			'HashDereference' => 129,
			'Expression' => 148,
			'ArrayReference' => 120
		}
	},
	{#State 386
		DEFAULT => -166
	},
	{#State 387
		ACTIONS => {
			";" => 408
		}
	},
	{#State 388
		DEFAULT => -63
	},
	{#State 389
		ACTIONS => {
			'WORD' => 339
		},
		GOTOS => {
			'HashEntryProperties' => 409
		}
	},
	{#State 390
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 54,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 410
		}
	},
	{#State 391
		DEFAULT => -201
	},
	{#State 392
		ACTIONS => {
			'LPAREN_MY' => 412,
			'VARIABLE_SYMBOL' => -68,
			"undef" => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'LBRACE' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'SELF' => -68,
			'LITERAL_STRING' => -68,
			"for" => -68,
			'OP01_NAMED_VOID' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP01_CLOSE' => -68,
			'OP01_PRINT' => -68,
			'MY' => -68,
			'WORD_SCOPED' => -68,
			"while" => -68,
			"if" => -68,
			"%{" => -68,
			'LPAREN' => -68,
			'LBRACKET' => -68,
			"\@{" => -68,
			'OP10_NAMED_UNARY' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'WORD_UPPERCASE' => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP01_NAMED' => -68,
			'WORD' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'LITERAL_NUMBER' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'OP01_OPEN' => -68,
			"}" => -68,
			"foreach" => -68,
			'CONSTANT_CALL_SCOPED' => -68
		},
		GOTOS => {
			'MethodArguments' => 411,
			'OPTIONAL-27' => 413
		}
	},
	{#State 393
		ACTIONS => {
			'VARIABLE_SYMBOL' => 414
		}
	},
	{#State 394
		DEFAULT => -52
	},
	{#State 395
		ACTIONS => {
			'LBRACE' => 349
		},
		GOTOS => {
			'CodeBlock' => 415
		}
	},
	{#State 396
		DEFAULT => -159
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
		DEFAULT => -168
	},
	{#State 401
		DEFAULT => -170
	},
	{#State 402
		ACTIONS => {
			"%{" => 98,
			'LPAREN' => 97,
			"undef" => 123,
			'LBRACKET' => 101,
			'VARIABLE_SYMBOL' => 124,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150,
			'WORD_UPPERCASE' => 149,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105
		},
		GOTOS => {
			'Operator' => 121,
			'Expression' => 148,
			'ArrayReference' => 120,
			'HashDereference' => 129,
			'Variable' => 152,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'SubExpression' => 417,
			'ArrayDereference' => 116,
			'HashReference' => 92
		}
	},
	{#State 403
		ACTIONS => {
			"undef" => 418
		}
	},
	{#State 404
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 419,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 188,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 191
		}
	},
	{#State 405
		ACTIONS => {
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP06_REGEX_MATCH' => 179,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => 420,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 186
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
		DEFAULT => -65
	},
	{#State 409
		DEFAULT => -62
	},
	{#State 410
		ACTIONS => {
			"\$TYPED_" => 423
		}
	},
	{#State 411
		DEFAULT => -67
	},
	{#State 412
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 54,
			'WORD_SCOPED' => 52
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
		DEFAULT => -49
	},
	{#State 415
		DEFAULT => -156
	},
	{#State 416
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'WORD_UPPERCASE' => 149,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_OPEN' => 105,
			"%{" => 98,
			'LPAREN' => 97,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114
		},
		GOTOS => {
			'WordScoped' => 104,
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 426,
			'Operator' => 121,
			'HashDereference' => 129,
			'Variable' => 152,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 417
		ACTIONS => {
			'OP06_REGEX_MATCH' => 179,
			"]" => -83,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => -83,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_STRING_CAT' => 184,
			'OP21_LIST_COMMA' => -83,
			'OP07_STRING_REPEAT' => 185,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			"}" => -83,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => -83
		}
	},
	{#State 418
		ACTIONS => {
			";" => 427
		}
	},
	{#State 419
		ACTIONS => {
			'VARIABLE_SYMBOL' => 124,
			"undef" => 123,
			'LBRACKET' => 101,
			"%{" => 98,
			'LPAREN' => 97,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27
		},
		GOTOS => {
			'ArrayDereference' => 116,
			'SubExpression' => 428,
			'HashReference' => 92,
			'WordScoped' => 104,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'Operator' => 121
		}
	},
	{#State 420
		ACTIONS => {
			'VARIABLE_SYMBOL' => 429
		}
	},
	{#State 421
		ACTIONS => {
			'LBRACE' => 349
		},
		GOTOS => {
			'CodeBlock' => 430
		}
	},
	{#State 422
		ACTIONS => {
			'LBRACE' => 349
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
			'WORD_UPPERCASE' => 108,
			'WORD' => 26,
			'OP01_NAMED' => 112,
			'OP19_LOOP_CONTROL' => 110,
			'OP01_OPEN' => 105,
			"}" => 434,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED_VOID_LPAREN' => 102,
			'OP03_MATH_INC_DEC' => 103,
			'CONSTANT_CALL_SCOPED' => 107,
			"foreach" => -147,
			"if" => 95,
			"while" => -147,
			'LBRACKET' => 101,
			'LPAREN' => 97,
			"%{" => 98,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP19_LOOP_CONTROL_SCOLON' => 93,
			'OP01_NAMED_VOID' => 133,
			"for" => -147,
			'OP01_CLOSE' => 136,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'OP01_PRINT' => 125,
			'MY' => 126,
			'WORD_SCOPED' => 27,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP01_NAMED_VOID_SCOLON' => 118
		},
		GOTOS => {
			'Literal' => 99,
			'ArrayReference' => 120,
			'Variable' => 94,
			'Conditional' => 122,
			'VariableModification' => 96,
			'Operator' => 121,
			'ArrayDereference' => 116,
			'Statement' => 115,
			'HashReference' => 92,
			'OperatorVoid' => 89,
			'VariableSymbolOrSelf' => 111,
			'Expression' => 130,
			'HashDereference' => 129,
			'LoopLabel' => 109,
			'PAREN-36' => 132,
			'VariableDeclaration' => 131,
			'SubExpression' => 106,
			'OPTIONAL-37' => 128,
			'Operation' => 435,
			'WordScoped' => 104
		}
	},
	{#State 426
		ACTIONS => {
			'OP17_LIST_RANGE' => 186,
			")" => 436,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP23_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187
		}
	},
	{#State 427
		DEFAULT => -179
	},
	{#State 428
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => -104,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP17_LIST_RANGE' => undef,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => 437,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => -104,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182
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
		DEFAULT => -167
	},
	{#State 432
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 439,
			'OP02_ARRAY_THINARROW' => 440
		}
	},
	{#State 433
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 441
		}
	},
	{#State 434
		ACTIONS => {
			";" => 442
		}
	},
	{#State 435
		DEFAULT => -69
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 349
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 437
		ACTIONS => {
			'LBRACE' => 349
		},
		GOTOS => {
			'CodeBlock' => 444
		}
	},
	{#State 438
		ACTIONS => {
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'WORD_UPPERCASE' => 149,
			'OP01_NAMED' => 150,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'LBRACE' => 114,
			'OP10_NAMED_UNARY' => 91,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			'LPAREN' => 97,
			"%{" => 98
		},
		GOTOS => {
			'HashReference' => 92,
			'ArrayDereference' => 116,
			'SubExpression' => 445,
			'WordScoped' => 104,
			'VariableSymbolOrSelf' => 111,
			'Literal' => 99,
			'HashDereference' => 129,
			'Variable' => 152,
			'Expression' => 148,
			'ArrayReference' => 120,
			'Operator' => 121
		}
	},
	{#State 439
		ACTIONS => {
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103,
			'OP01_OPEN' => 105,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP01_NAMED' => 150,
			'WORD_UPPERCASE' => 149,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			'LPAREN' => 97,
			"%{" => 98,
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124
		},
		GOTOS => {
			'WordScoped' => 104,
			'SubExpression' => 446,
			'ArrayDereference' => 116,
			'HashReference' => 92,
			'Operator' => 121,
			'ArrayReference' => 120,
			'Expression' => 148,
			'HashDereference' => 129,
			'Variable' => 152,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111
		}
	},
	{#State 440
		ACTIONS => {
			'LBRACKET' => 101,
			"undef" => 123,
			'VARIABLE_SYMBOL' => 124,
			'LPAREN' => 97,
			"%{" => 98,
			'LITERAL_STRING' => 87,
			'SELF' => 119,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			'OP05_MATH_NEG_LPAREN' => 113,
			"\@{" => 90,
			'OP01_CLOSE' => 136,
			'WORD' => 26,
			'OP01_NAMED' => 150,
			'OP05_LOGICAL_NEG' => 134,
			'OP22_LOGICAL_NEG' => 135,
			'WORD_UPPERCASE' => 149,
			'WORD_SCOPED' => 27,
			'CONSTANT_CALL_SCOPED' => 107,
			'OP01_OPEN' => 105,
			'LITERAL_NUMBER' => 86,
			'OP03_MATH_INC_DEC' => 103
		},
		GOTOS => {
			'Operator' => 121,
			'ArrayReference' => 120,
			'Expression' => 148,
			'Variable' => 152,
			'HashDereference' => 129,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'ArrayDereference' => 116,
			'SubExpression' => 447,
			'HashReference' => 92
		}
	},
	{#State 441
		ACTIONS => {
			")" => 449,
			'OP21_LIST_COMMA' => 450
		},
		GOTOS => {
			'PAREN-29' => 448
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
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP16_LOGICAL_OR' => 193,
			'OP18_TERNARY' => 192,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			";" => 451,
			'OP08_MATH_ADD_SUB' => 190,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187
		}
	},
	{#State 446
		ACTIONS => {
			'OP23_LOGICAL_AND' => 180,
			'OP13_BITWISE_AND' => 188,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP07_STRING_REPEAT' => 185,
			'OP21_LIST_COMMA' => -218,
			'OP08_STRING_CAT' => 184,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP17_LIST_RANGE' => 186,
			"}" => -218,
			'OP12_COMPARE_EQ_NE' => 194
		}
	},
	{#State 447
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 189,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP15_LOGICAL_AND' => 178,
			'OP06_REGEX_MATCH' => 179,
			'OP23_LOGICAL_AND' => 180,
			"]" => 452,
			'OP13_BITWISE_AND' => 188,
			'OP12_COMPARE_EQ_NE' => 194,
			'OP17_LIST_RANGE' => 186,
			'OP11_COMPARE_LT_GT' => 182,
			'OP04_MATH_POW' => 183,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP08_STRING_CAT' => 184,
			'OP07_STRING_REPEAT' => 185
		}
	},
	{#State 448
		DEFAULT => -73
	},
	{#State 449
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 453
		}
	},
	{#State 450
		ACTIONS => {
			'MY' => 454
		}
	},
	{#State 451
		ACTIONS => {
			'SELF' => 119,
			'LITERAL_STRING' => 87,
			'OP10_NAMED_UNARY' => 91,
			'LBRACE' => 114,
			"\@{" => 90,
			'OP05_MATH_NEG_LPAREN' => 113,
			'VARIABLE_SYMBOL' => 124,
			'LBRACKET' => 101,
			"undef" => 123,
			"%{" => 98,
			'LPAREN' => 97,
			'CONSTANT_CALL_SCOPED' => 107,
			'WORD_SCOPED' => 27,
			'OP01_OPEN' => 105,
			'OP03_MATH_INC_DEC' => 103,
			'LITERAL_NUMBER' => 86,
			'OP01_NAMED' => 150,
			'WORD' => 26,
			'OP01_CLOSE' => 136,
			'OP22_LOGICAL_NEG' => 135,
			'OP05_LOGICAL_NEG' => 134,
			'WORD_UPPERCASE' => 149
		},
		GOTOS => {
			'Expression' => 148,
			'ArrayReference' => 120,
			'Variable' => 94,
			'HashDereference' => 129,
			'Operator' => 121,
			'VariableModification' => 457,
			'Literal' => 99,
			'VariableSymbolOrSelf' => 111,
			'WordScoped' => 104,
			'SubExpression' => 456,
			'ArrayDereference' => 116,
			'SubExpressionOrVarMod' => 455,
			'HashReference' => 92
		}
	},
	{#State 452
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 458
		}
	},
	{#State 453
		ACTIONS => {
			"\@_;" => 459
		}
	},
	{#State 454
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 54,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 460
		}
	},
	{#State 455
		ACTIONS => {
			")" => 461
		}
	},
	{#State 456
		ACTIONS => {
			'OP07_STRING_REPEAT' => 185,
			'OP08_STRING_CAT' => 184,
			'OP18_TERNARY' => 192,
			'OP16_LOGICAL_OR' => 193,
			'OP04_MATH_POW' => 183,
			'OP11_COMPARE_LT_GT' => 182,
			'OP17_LIST_RANGE' => 186,
			'OP12_COMPARE_EQ_NE' => 194,
			")" => -143,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 180,
			'OP06_REGEX_MATCH' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 187,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP09_BITWISE_SHIFT' => 181,
			'OP08_MATH_ADD_SUB' => 190,
			'OP24_LOGICAL_OR_XOR' => 189
		}
	},
	{#State 457
		DEFAULT => -144
	},
	{#State 458
		ACTIONS => {
			"undef" => 462
		}
	},
	{#State 459
		DEFAULT => -75
	},
	{#State 460
		ACTIONS => {
			'VARIABLE_SYMBOL' => 463
		}
	},
	{#State 461
		ACTIONS => {
			'LBRACE' => 349
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
#line 6564 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6571 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6578 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6585 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6596 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6607 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6614 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6621 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6628 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6635 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6649 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6656 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6663 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6670 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6677 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6684 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6691 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6702 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6709 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6716 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6723 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6752 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6770 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6777 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6784 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6798 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6812 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6819 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6830 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6837 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6844 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6855 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6862 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6869 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6880 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6891 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6902 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6913 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6920 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6927 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6934 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6941 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6952 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6959 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6966 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6973 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6984 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6998 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7005 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7012 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7026 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7033 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7040 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7051 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7058 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7065 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7072 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7083 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7094 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7108 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7140 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7147 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7154 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7165 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7176 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7187 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7209 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7220 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7231 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7242 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7253 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7264 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7275 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7286 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7297 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7308 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7319 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7330 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7341 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7418 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7473 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7484 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7495 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7506 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7517 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7528 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7535 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7542 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7549 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7556 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7574 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7585 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7607 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7618 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7629 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7640 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7651 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7658 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7665 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7672 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7679 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7690 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7701 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7712 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7723 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7734 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7745 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7756 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7767 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7778 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7789 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7800 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7811 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7822 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7833 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7844 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_141
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7855 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_142
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7866 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_143
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7877 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_144
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7888 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7895 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7902 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7909 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_148
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7920 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7931 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7942 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7953 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7964 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7971 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7978 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7985 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7992 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7999 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8006 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_159
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8017 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_160
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8028 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8039 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8050 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_163
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8061 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_164
		 'LoopFor', 14,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8072 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_165
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8083 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_166
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8094 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_167
		 'LoopWhile', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8105 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8112 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8119 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_170
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8130 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8137 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8144 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_173
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8155 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_174
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8166 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8177 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8188 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_177
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8199 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8210 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8221 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8232 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_181
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8243 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8254 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8261 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8268 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 201 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8275 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_186
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8286 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_187
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8297 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8308 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8319 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8326 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8333 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_192
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8344 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8351 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8358 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_195
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8369 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_196
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8380 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8387 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8394 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_199
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8405 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_200
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8416 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_201
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8427 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8434 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8441 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8448 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_205
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8459 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_206
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8470 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8477 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8484 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_209
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8495 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_210
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8506 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_211
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8517 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_212
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8528 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_213
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8539 lib/RPerl/Grammar.pm
	],
	[#Rule Type_214
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8550 lib/RPerl/Grammar.pm
	],
	[#Rule Type_215
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8561 lib/RPerl/Grammar.pm
	],
	[#Rule Type_216
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8572 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_217
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8583 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_218
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8594 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_219
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8605 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_220
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8616 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_221
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8627 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_222
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8638 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_223
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8649 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_224
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8660 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_225
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8671 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_226
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8682 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_227
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8693 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_228
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8704 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_229
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8715 lib/RPerl/Grammar.pm
	]
],
#line 8718 lib/RPerl/Grammar.pm
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

#line 222 "lib/RPerl/Grammar.eyp"


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


#line 9124 lib/RPerl/Grammar.pm



1;
