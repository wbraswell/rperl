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
    our $VERSION = 0.001_999;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\$TYPED_|package|foreach|\=\ sub\ \{|while|elsif|undef|else|for|\@_\;|our|if|\%\{|\@\{|\)|\;|\}|\])}gc and return ($1, $1);

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
      /\G(\@ARGV)/gc and return ('ARGV', $1);
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


#line 138 lib/RPerl/Grammar.pm

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
  [ 'SubExpressionOrInput_141' => 'SubExpressionOrInput', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrInput_142' => 'SubExpressionOrInput', [ 'FHREF_SYMBOL_IN' ], 0 ],
  [ 'SubExpressionOrInput_143' => 'SubExpressionOrInput', [ 'STDIN' ], 0 ],
  [ 'SubExpressionOrVarMod_144' => 'SubExpressionOrVarMod', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrVarMod_145' => 'SubExpressionOrVarMod', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-36', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [ 'PAREN-36' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-37', [  ], 0 ],
  [ 'Statement_149' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_150' => 'Statement', [ 'OPTIONAL-37', 'Loop' ], 0 ],
  [ 'Statement_151' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_152' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_153' => 'Statement', [ 'VariableModification', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-38', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [ 'STAR-39', 'PAREN-38' ], 0 ],
  [ '_STAR_LIST' => 'STAR-39', [  ], 0 ],
  [ '_PAREN' => 'PAREN-40', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [ 'PAREN-40' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-41', [  ], 0 ],
  [ 'Conditional_160' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-39', 'OPTIONAL-41' ], 0 ],
  [ 'Loop_161' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_162' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_163' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_164' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopFor_165' => 'LoopFor', [ 'for', 'LPAREN_MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpression', ';', 'VARIABLE_SYMBOL', 'OP11_COMPARE_LT_GT', 'SubExpression', ';', 'SubExpressionOrVarMod', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_166' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_167' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_168' => 'LoopWhile', [ 'while', 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'PLUS-42', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-42', [ 'Operation' ], 0 ],
  [ 'CodeBlock_171' => 'CodeBlock', [ 'LBRACE', 'PLUS-42', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'Variable_174' => 'Variable', [ 'VariableSymbolOrSelf', 'STAR-43' ], 0 ],
  [ 'VariableRetrieval_175' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_176' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_177' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_178' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_179' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput', ';' ], 0 ],
  [ 'VariableDeclaration_180' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef', ';' ], 0 ],
  [ 'VariableDeclaration_181' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_182' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrInput' ], 0 ],
  [ 'VariableModification_183' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-44', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [ 'STAR-45', 'PAREN-44' ], 0 ],
  [ '_STAR_LIST' => 'STAR-45', [  ], 0 ],
  [ 'ListElements_187' => 'ListElements', [ 'ListElement', 'STAR-45' ], 0 ],
  [ 'ListElement_188' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_189' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_190' => 'ListElement', [ 'OP01_QW' ], 0 ],
  [ 'ListElement_191' => 'ListElement', [ 'ARGV' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_194' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_197' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_198' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_201' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_202' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryProperties_203' => 'HashEntryProperties', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_207' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_208' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_211' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_212' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_213' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_214' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_215' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_216' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_217' => 'Type', [ 'WORD_SCOPED' ], 0 ],
  [ 'Type_218' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_219' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerProperties_220' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN', 'SubExpression' ], 0 ],
  [ 'TypeInnerProperties_221' => 'TypeInnerProperties', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP02_ARRAY_THINARROW', 'SubExpression', ']', 'OP19_VARIABLE_ASSIGN', 'undef' ], 0 ],
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
  'SubExpressionOrInput_141' => 141,
  'SubExpressionOrInput_142' => 142,
  'SubExpressionOrInput_143' => 143,
  'SubExpressionOrVarMod_144' => 144,
  'SubExpressionOrVarMod_145' => 145,
  '_PAREN' => 146,
  '_OPTIONAL' => 147,
  '_OPTIONAL' => 148,
  'Statement_149' => 149,
  'Statement_150' => 150,
  'Statement_151' => 151,
  'Statement_152' => 152,
  'Statement_153' => 153,
  '_PAREN' => 154,
  '_STAR_LIST' => 155,
  '_STAR_LIST' => 156,
  '_PAREN' => 157,
  '_OPTIONAL' => 158,
  '_OPTIONAL' => 159,
  'Conditional_160' => 160,
  'Loop_161' => 161,
  'Loop_162' => 162,
  'Loop_163' => 163,
  'LoopFor_164' => 164,
  'LoopFor_165' => 165,
  'LoopForEach_166' => 166,
  'LoopWhile_167' => 167,
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
  'ListElement_188' => 188,
  'ListElement_189' => 189,
  'ListElement_190' => 190,
  'ListElement_191' => 191,
  '_OPTIONAL' => 192,
  '_OPTIONAL' => 193,
  'ArrayReference_194' => 194,
  '_OPTIONAL' => 195,
  '_OPTIONAL' => 196,
  'ArrayDereference_197' => 197,
  'ArrayDereference_198' => 198,
  '_OPTIONAL' => 199,
  '_OPTIONAL' => 200,
  'HashEntry_201' => 201,
  'HashEntry_202' => 202,
  'HashEntryProperties_203' => 203,
  '_PAREN' => 204,
  '_STAR_LIST' => 205,
  '_STAR_LIST' => 206,
  'HashReference_207' => 207,
  'HashReference_208' => 208,
  '_OPTIONAL' => 209,
  '_OPTIONAL' => 210,
  'HashDereference_211' => 211,
  'HashDereference_212' => 212,
  'WordScoped_213' => 213,
  'WordScoped_214' => 214,
  'LoopLabel_215' => 215,
  'Type_216' => 216,
  'Type_217' => 217,
  'Type_218' => 218,
  'TypeInner_219' => 219,
  'TypeInnerProperties_220' => 220,
  'TypeInnerProperties_221' => 221,
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
	ARGV => { ISSEMANTIC => 1 },
	COLON => { ISSEMANTIC => 1 },
	CONSTANT_CALL_SCOPED => { ISSEMANTIC => 1 },
	FHREF_SYMBOL => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
	FHREF_SYMBOL_IN => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 2,
			"package" => -20,
			'USE_RPERL' => -20,
			'SHEBANG' => 7
		},
		GOTOS => {
			'PAREN-1' => 5,
			'ModuleHeader' => 4,
			'OPTIONAL-9' => 9,
			'CompileUnit' => 3,
			'Critic' => 6,
			'Program' => 1,
			'PLUS-2' => 8
		}
	},
	{#State 1
		DEFAULT => -4
	},
	{#State 2
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'PLUS-16' => 11
		}
	},
	{#State 3
		ACTIONS => {
			'' => 12
		}
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => -27,
			"use parent qw(" => 15,
			'USE' => -27,
			"our" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'Package' => 16,
			'Module' => 14,
			'STAR-11' => 13,
			'Class' => 17
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		ACTIONS => {
			'USE_RPERL' => -7,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'OPTIONAL-3' => 18,
			'Critic' => 19
		}
	},
	{#State 8
		ACTIONS => {
			'USE_RPERL' => -20,
			"package" => -20,
			"## no critic qw(" => 2,
			'' => -5
		},
		GOTOS => {
			'Critic' => 6,
			'OPTIONAL-9' => 9,
			'ModuleHeader' => 4,
			'PAREN-1' => 20
		}
	},
	{#State 9
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 21
		},
		GOTOS => {
			'OPTIONAL-10' => 22
		}
	},
	{#State 10
		DEFAULT => -39
	},
	{#State 11
		ACTIONS => {
			'WORD' => 23,
			")" => 24
		}
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			"use constant" => -29,
			"our" => -29,
			'USE' => -29,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 26,
			'STAR-12' => 25
		}
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 16
		DEFAULT => -24
	},
	{#State 17
		DEFAULT => -25
	},
	{#State 18
		ACTIONS => {
			'USE_RPERL' => 30
		}
	},
	{#State 19
		DEFAULT => -6
	},
	{#State 20
		DEFAULT => -2
	},
	{#State 21
		DEFAULT => -21
	},
	{#State 22
		ACTIONS => {
			"package" => 31
		}
	},
	{#State 23
		DEFAULT => -38
	},
	{#State 24
		DEFAULT => -40
	},
	{#State 25
		ACTIONS => {
			'USE' => 33,
			"use constant" => -31,
			"our" => -31
		},
		GOTOS => {
			'STAR-13' => 32,
			'Include' => 34
		}
	},
	{#State 26
		DEFAULT => -26
	},
	{#State 27
		ACTIONS => {
			")" => 35
		}
	},
	{#State 28
		DEFAULT => -214
	},
	{#State 29
		DEFAULT => -213
	},
	{#State 30
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 36
		}
	},
	{#State 31
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'WordScoped' => 38
		}
	},
	{#State 32
		ACTIONS => {
			"our" => 42,
			"use constant" => 43
		},
		GOTOS => {
			'PLUS-14' => 40,
			'Constant' => 41,
			'Subroutine' => 39
		}
	},
	{#State 33
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 44
		}
	},
	{#State 34
		DEFAULT => -28
	},
	{#State 35
		ACTIONS => {
			";" => 45
		}
	},
	{#State 36
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 46
		}
	},
	{#State 37
		ACTIONS => {
			"use warnings;" => 47
		}
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		DEFAULT => -33
	},
	{#State 40
		ACTIONS => {
			"our" => 42,
			'LITERAL_NUMBER' => 49
		},
		GOTOS => {
			'Subroutine' => 50
		}
	},
	{#State 41
		DEFAULT => -30
	},
	{#State 42
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'WORD' => 53,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 43
		ACTIONS => {
			'WORD_UPPERCASE' => 55
		}
	},
	{#State 44
		ACTIONS => {
			";" => 56,
			'OP01_QW' => 57
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
			'CONSTANT_CALL_SCOPED' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"for" => -11,
			'USE' => -11,
			'WORD_SCOPED' => -11,
			'WORD_UPPERCASE' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"undef" => -11,
			'OP01_PRINT' => -11,
			'LBRACKET' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP01_OPEN' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LITERAL_NUMBER' => -11,
			'LITERAL_STRING' => -11,
			"while" => -11,
			"\@{" => -11,
			"%{" => -11,
			"if" => -11,
			'OP19_LOOP_CONTROL' => -11,
			"## no critic qw(" => 2,
			'OP05_LOGICAL_NEG' => -11,
			'SELF' => -11,
			"our" => -11,
			'WORD' => -11,
			"use constant" => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'LBRACE' => -11,
			'OP01_CLOSE' => -11,
			"foreach" => -11,
			'LPAREN' => -11,
			'OP01_NAMED' => -11,
			'VARIABLE_SYMBOL' => -11,
			'MY' => -11,
			'OP22_LOGICAL_NEG' => -11
		},
		GOTOS => {
			'Critic' => 60,
			'STAR-5' => 59
		}
	},
	{#State 47
		ACTIONS => {
			'USE_RPERL_AFTER' => 61,
			"our" => -36
		},
		GOTOS => {
			'OPTIONAL-15' => 62
		}
	},
	{#State 48
		ACTIONS => {
			"use strict;" => 37
		},
		GOTOS => {
			'Header' => 63
		}
	},
	{#State 49
		ACTIONS => {
			";" => 64
		}
	},
	{#State 50
		DEFAULT => -32
	},
	{#State 51
		DEFAULT => -218
	},
	{#State 52
		DEFAULT => -217
	},
	{#State 53
		DEFAULT => -216
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 55
		ACTIONS => {
			'OP20_HASH_FATARROW' => 66
		}
	},
	{#State 56
		DEFAULT => -41
	},
	{#State 57
		ACTIONS => {
			";" => 67
		}
	},
	{#State 58
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 68
		}
	},
	{#State 59
		ACTIONS => {
			'OP01_PRINT' => -13,
			'LBRACKET' => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP01_OPEN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LITERAL_NUMBER' => -13,
			'LITERAL_STRING' => -13,
			"while" => -13,
			'OP10_NAMED_UNARY' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_NAMED_VOID' => -13,
			'WORD_SCOPED' => -13,
			"for" => -13,
			'USE' => 33,
			'WORD_UPPERCASE' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"undef" => -13,
			'OP01_NAMED' => -13,
			'VARIABLE_SYMBOL' => -13,
			'MY' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"\@{" => -13,
			"%{" => -13,
			"if" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'SELF' => -13,
			"our" => -13,
			"use constant" => -13,
			'WORD' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'LBRACE' => -13,
			'OP01_CLOSE' => -13,
			"foreach" => -13,
			'LPAREN' => -13
		},
		GOTOS => {
			'Include' => 70,
			'STAR-6' => 69
		}
	},
	{#State 60
		DEFAULT => -8
	},
	{#State 61
		DEFAULT => -35
	},
	{#State 62
		ACTIONS => {
			"our" => 71
		}
	},
	{#State 63
		DEFAULT => -23
	},
	{#State 64
		DEFAULT => -34
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 72
		}
	},
	{#State 66
		ACTIONS => {
			'MY' => 74
		},
		GOTOS => {
			'TypeInnerConstant' => 73
		}
	},
	{#State 67
		DEFAULT => -42
	},
	{#State 68
		ACTIONS => {
			"our hashref \$properties" => -56,
			"use constant" => -56,
			"## no critic qw(" => 2,
			'USE' => -56
		},
		GOTOS => {
			'STAR-22' => 76,
			'Critic' => 75
		}
	},
	{#State 69
		ACTIONS => {
			"if" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"%{" => -15,
			"\@{" => -15,
			'OP01_CLOSE' => -15,
			'LPAREN' => -15,
			"foreach" => -15,
			'SELF' => -15,
			'LBRACE' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"use constant" => 43,
			"our" => -15,
			'WORD' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP01_NAMED' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'MY' => -15,
			'OP01_NAMED_VOID' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'WORD_SCOPED' => -15,
			"for" => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			'OP01_OPEN' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LBRACKET' => -15,
			'OP01_PRINT' => -15,
			"while" => -15,
			'LITERAL_NUMBER' => -15,
			'LITERAL_STRING' => -15
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
			'SELF' => -45,
			'LBRACE' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'WORD' => -45,
			'OP01_CLOSE' => -45,
			'LPAREN' => -45,
			"foreach" => -45,
			"%{" => -45,
			"\@{" => -45,
			"if" => -45,
			'OP19_LOOP_CONTROL' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'MY' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'OP01_NAMED' => -45,
			'VARIABLE_SYMBOL' => -45,
			'WORD_UPPERCASE' => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			"undef" => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'OP10_NAMED_UNARY' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP01_NAMED_VOID' => -45,
			"for" => -45,
			"}" => -45,
			'WORD_SCOPED' => -45,
			'LITERAL_NUMBER' => -45,
			'LITERAL_STRING' => -45,
			"while" => -45,
			'LPAREN_MY' => 82,
			'LBRACKET' => -45,
			'OP01_PRINT' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'OP01_OPEN' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 80,
			'OPTIONAL-17' => 81
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
			'TYPE_INTEGER' => 51,
			'WORD' => 53,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 86
		}
	},
	{#State 75
		DEFAULT => -53
	},
	{#State 76
		ACTIONS => {
			'USE' => 33,
			"use constant" => -58,
			"our hashref \$properties" => -58
		},
		GOTOS => {
			'STAR-23' => 88,
			'Include' => 87
		}
	},
	{#State 77
		ACTIONS => {
			"for" => -148,
			'WORD_SCOPED' => 28,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'OP01_NAMED_VOID' => 103,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 110,
			'OP05_MATH_NEG_LPAREN' => 108,
			'WORD_UPPERCASE' => 107,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_PRINT' => 92,
			'LBRACKET' => 91,
			"while" => -148,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP05_LOGICAL_NEG' => 127,
			"if" => 126,
			'OP19_LOOP_CONTROL' => 125,
			"\@{" => 124,
			"%{" => 123,
			"foreach" => -148,
			'LPAREN' => 134,
			'OP01_CLOSE' => 133,
			"our" => 42,
			'WORD' => 29,
			'OP01_NAMED_VOID_LPAREN' => 131,
			'LBRACE' => 130,
			'SELF' => 128,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 113,
			'OP22_LOGICAL_NEG' => 120,
			'MY' => 118
		},
		GOTOS => {
			'LoopLabel' => 89,
			'Variable' => 90,
			'Statement' => 111,
			'Conditional' => 112,
			'VariableSymbolOrSelf' => 114,
			'OperatorVoid' => 116,
			'ArrayDereference' => 117,
			'PLUS-8' => 119,
			'SubExpression' => 96,
			'PAREN-36' => 121,
			'Literal' => 122,
			'WordScoped' => 99,
			'Operation' => 100,
			'Subroutine' => 102,
			'ArrayReference' => 104,
			'OPTIONAL-37' => 105,
			'Operator' => 106,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Expression' => 109,
			'VariableDeclaration' => 135,
			'VariableModification' => 136
		}
	},
	{#State 78
		DEFAULT => -12
	},
	{#State 79
		DEFAULT => -37
	},
	{#State 80
		DEFAULT => -44
	},
	{#State 81
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 137
		}
	},
	{#State 82
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 51,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 138
		}
	},
	{#State 83
		ACTIONS => {
			";" => 139
		}
	},
	{#State 84
		DEFAULT => -230
	},
	{#State 85
		DEFAULT => -231
	},
	{#State 86
		ACTIONS => {
			"\$TYPED_" => 140
		}
	},
	{#State 87
		DEFAULT => -55
	},
	{#State 88
		ACTIONS => {
			"our hashref \$properties" => 142,
			"use constant" => 43
		},
		GOTOS => {
			'Properties' => 141,
			'Constant' => 143
		}
	},
	{#State 89
		ACTIONS => {
			'COLON' => 144
		}
	},
	{#State 90
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN_BY' => 148,
			'OP03_MATH_INC_DEC' => 147,
			'OP02_METHOD_THINARROW' => 146,
			'OP19_VARIABLE_ASSIGN' => 145,
			'OP09_BITWISE_SHIFT' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP15_LOGICAL_AND' => -135,
			")" => -135,
			'OP13_BITWISE_AND' => -135,
			'OP04_MATH_POW' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP18_TERNARY' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP08_STRING_CAT' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP17_LIST_RANGE' => -135
		}
	},
	{#State 91
		ACTIONS => {
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'ARGV' => 160,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"%{" => 123,
			"\@{" => 124,
			'OP22_LOGICAL_NEG' => 120,
			"]" => -193,
			'LITERAL_NUMBER' => 84,
			'MY' => 158,
			'LITERAL_STRING' => 85,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91
		},
		GOTOS => {
			'OPTIONAL-46' => 155,
			'Expression' => 154,
			'SubExpression' => 149,
			'ListElements' => 153,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'VariableSymbolOrSelf' => 114,
			'ListElement' => 156,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99
		}
	},
	{#State 92
		ACTIONS => {
			'OP01_CLOSE' => -111,
			'OP05_MATH_NEG_LPAREN' => -111,
			'LPAREN' => -111,
			"undef" => -111,
			'WORD_UPPERCASE' => -111,
			'SELF' => -111,
			'ARGV' => -111,
			'LBRACE' => -111,
			'WORD' => -111,
			'OP05_LOGICAL_NEG' => -111,
			'STDOUT_STDERR' => 162,
			'WORD_SCOPED' => -111,
			'CONSTANT_CALL_SCOPED' => -111,
			'OP10_NAMED_UNARY' => -111,
			"%{" => -111,
			"\@{" => -111,
			'OP22_LOGICAL_NEG' => -111,
			'LITERAL_NUMBER' => -111,
			'MY' => -111,
			'FHREF_SYMBOL_BRACES' => 164,
			'LITERAL_STRING' => -111,
			'OP01_OPEN' => -111,
			'OP03_MATH_INC_DEC' => -111,
			'OP01_QW' => -111,
			'VARIABLE_SYMBOL' => -111,
			'OP01_NAMED' => -111,
			'LBRACKET' => -111
		},
		GOTOS => {
			'PAREN-31' => 163,
			'OPTIONAL-32' => 161
		}
	},
	{#State 93
		ACTIONS => {
			'SELF' => 128,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 165,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 94
		ACTIONS => {
			'MY' => 166
		}
	},
	{#State 95
		DEFAULT => -120
	},
	{#State 96
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 173,
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 178,
			'OP07_STRING_REPEAT' => 177
		}
	},
	{#State 97
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'LBRACKET' => 91,
			"]" => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP06_REGEX_MATCH' => -97,
			'LITERAL_STRING' => 85,
			'OP23_LOGICAL_AND' => -97,
			'LITERAL_NUMBER' => 84,
			'WORD_SCOPED' => 28,
			"}" => -97,
			'OP08_MATH_ADD_SUB' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"undef" => 110,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			'OP05_MATH_NEG_LPAREN' => 108,
			'WORD_UPPERCASE' => 152,
			'VARIABLE_SYMBOL' => 115,
			'OP09_BITWISE_SHIFT' => -97,
			'OP01_NAMED' => 159,
			'OP13_BITWISE_AND' => -97,
			'OP22_LOGICAL_NEG' => 120,
			")" => -97,
			'OP11_COMPARE_LT_GT' => -97,
			'OP12_COMPARE_EQ_NE' => -97,
			'OP05_LOGICAL_NEG' => 127,
			'OP18_TERNARY' => -97,
			'OP07_STRING_REPEAT' => -97,
			";" => -97,
			"\@{" => 124,
			'OP21_LIST_COMMA' => -97,
			"%{" => 123,
			'OP16_LOGICAL_OR' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP04_MATH_POW' => -97,
			'OP17_LIST_RANGE' => -97,
			'LPAREN' => 134,
			'OP01_CLOSE' => 133,
			'OP08_STRING_CAT' => -97,
			'WORD' => 29,
			'LBRACE' => 130,
			'SELF' => 128
		},
		GOTOS => {
			'Expression' => 154,
			'SubExpression' => 184,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99
		}
	},
	{#State 98
		DEFAULT => -128
	},
	{#State 99
		ACTIONS => {
			'LPAREN' => 185,
			'OP02_METHOD_THINARROW_NEW' => 186
		}
	},
	{#State 100
		DEFAULT => -17
	},
	{#State 101
		DEFAULT => -116
	},
	{#State 102
		DEFAULT => -14
	},
	{#State 103
		ACTIONS => {
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'ARGV' => 160,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 84,
			'MY' => 158,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'ListElements' => 187,
			'SubExpression' => 149,
			'Expression' => 154,
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'ListElement' => 156,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'WordScoped' => 99,
			'Literal' => 122,
			'Variable' => 150
		}
	},
	{#State 104
		DEFAULT => -136
	},
	{#State 105
		ACTIONS => {
			"while" => 191,
			"foreach" => 190,
			"for" => 194
		},
		GOTOS => {
			'LoopWhile' => 193,
			'LoopFor' => 188,
			'LoopForEach' => 192,
			'Loop' => 189
		}
	},
	{#State 106
		DEFAULT => -126
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => 195,
			'COLON' => -215
		}
	},
	{#State 108
		ACTIONS => {
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110
		},
		GOTOS => {
			'SubExpression' => 196,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99
		}
	},
	{#State 109
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			";" => 197,
			'OP07_STRING_REPEAT' => -132,
			'OP18_TERNARY' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP04_MATH_POW' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP08_STRING_CAT' => -132
		}
	},
	{#State 110
		DEFAULT => -133
	},
	{#State 111
		DEFAULT => -79
	},
	{#State 112
		DEFAULT => -149
	},
	{#State 113
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LBRACE' => 130,
			'ARGV' => 160,
			'WORD' => 29,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_QW' => 151,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'MY' => 158
		},
		GOTOS => {
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 199,
			'Expression' => 154,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'ListElement' => 198,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 114
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 200
		}
	},
	{#State 115
		DEFAULT => -228
	},
	{#State 116
		DEFAULT => -151
	},
	{#State 117
		DEFAULT => -137
	},
	{#State 118
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 51,
			'TYPE_FHREF' => 202,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 201
		}
	},
	{#State 119
		ACTIONS => {
			"while" => -148,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_PRINT' => 92,
			'LBRACKET' => 91,
			"undef" => 110,
			'OP05_MATH_NEG_LPAREN' => 108,
			'WORD_UPPERCASE' => 107,
			'WORD_SCOPED' => 28,
			"for" => -148,
			'' => -18,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'OP01_NAMED_VOID' => 103,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 120,
			'MY' => 118,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 113,
			"foreach" => -148,
			'LPAREN' => 134,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'LBRACE' => 130,
			'OP01_NAMED_VOID_LPAREN' => 131,
			'SELF' => 128,
			'OP05_LOGICAL_NEG' => 127,
			'OP19_LOOP_CONTROL' => 125,
			"if" => 126,
			"\@{" => 124,
			"%{" => 123
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'Variable' => 90,
			'LoopLabel' => 89,
			'Statement' => 111,
			'Conditional' => 112,
			'SubExpression' => 96,
			'PAREN-36' => 121,
			'OperatorVoid' => 116,
			'ArrayDereference' => 117,
			'ArrayReference' => 104,
			'Operation' => 203,
			'OPTIONAL-37' => 105,
			'Literal' => 122,
			'WordScoped' => 99,
			'Expression' => 109,
			'VariableModification' => 136,
			'VariableDeclaration' => 135,
			'Operator' => 106,
			'HashDereference' => 129,
			'HashReference' => 132
		}
	},
	{#State 120
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 204,
			'Expression' => 154,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 121
		DEFAULT => -147
	},
	{#State 122
		DEFAULT => -134
	},
	{#State 123
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'SELF' => 128,
			'MY' => 158,
			'LBRACE' => -210
		},
		GOTOS => {
			'OPTIONAL-51' => 207,
			'Variable' => 205,
			'VariableSymbolOrSelf' => 114,
			'TypeInner' => 206
		}
	},
	{#State 124
		ACTIONS => {
			'MY' => 158,
			'SELF' => 128,
			'LBRACKET' => -196,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'TypeInner' => 209,
			'VariableSymbolOrSelf' => 114,
			'OPTIONAL-47' => 208,
			'Variable' => 210
		}
	},
	{#State 125
		ACTIONS => {
			'WORD_UPPERCASE' => 212
		},
		GOTOS => {
			'LoopLabel' => 211
		}
	},
	{#State 126
		ACTIONS => {
			'LPAREN' => 213
		}
	},
	{#State 127
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"\@{" => 124,
			"%{" => 123
		},
		GOTOS => {
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'Expression' => 154,
			'SubExpression' => 214,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132
		}
	},
	{#State 128
		DEFAULT => -229
	},
	{#State 129
		DEFAULT => -139
	},
	{#State 130
		ACTIONS => {
			'SELF' => 128,
			'LITERAL_NUMBER' => 84,
			'WORD' => 218,
			"%{" => 123,
			'LITERAL_STRING' => 85,
			"}" => 215,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'HashEntry' => 216,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 219,
			'VariableOrLiteralOrWord' => 221,
			'Literal' => 220,
			'Variable' => 217
		}
	},
	{#State 131
		ACTIONS => {
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'ARGV' => 160,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'MY' => 158,
			'LITERAL_STRING' => 85,
			")" => -113,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 115,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159
		},
		GOTOS => {
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Expression' => 154,
			'SubExpression' => 149,
			'ListElements' => 223,
			'Literal' => 122,
			'Variable' => 150,
			'OPTIONAL-33' => 222,
			'WordScoped' => 99,
			'TypeInner' => 157,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'ListElement' => 156
		}
	},
	{#State 132
		DEFAULT => -138
	},
	{#State 133
		ACTIONS => {
			'FHREF_SYMBOL' => 224
		}
	},
	{#State 134
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'OP01_PRINT' => 225,
			'LBRACKET' => 91,
			'OP01_NAMED' => 227,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"\@{" => 124,
			"%{" => 123,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'WORD' => 29,
			'LBRACE' => 130
		},
		GOTOS => {
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 226,
			'Expression' => 154,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 135
		DEFAULT => -152
	},
	{#State 136
		ACTIONS => {
			";" => 228
		}
	},
	{#State 137
		ACTIONS => {
			"%{" => 123,
			"\@{" => 124,
			'OP05_LOGICAL_NEG' => 127,
			"if" => 126,
			'OP19_LOOP_CONTROL' => 125,
			'OP01_NAMED_VOID_LPAREN' => 131,
			'LBRACE' => 130,
			'WORD' => 29,
			'SELF' => 128,
			'LPAREN' => 134,
			"foreach" => -148,
			'OP01_CLOSE' => 133,
			'OP01_NAMED' => 113,
			'VARIABLE_SYMBOL' => 115,
			'MY' => 118,
			'OP22_LOGICAL_NEG' => 120,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'WORD_SCOPED' => 28,
			"for" => -148,
			"}" => 229,
			'OP01_NAMED_VOID' => 103,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'WORD_UPPERCASE' => 107,
			"undef" => 110,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LBRACKET' => 91,
			'OP01_PRINT' => 92,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			"while" => -148
		},
		GOTOS => {
			'HashReference' => 132,
			'HashDereference' => 129,
			'Operator' => 106,
			'VariableDeclaration' => 135,
			'VariableModification' => 136,
			'Expression' => 109,
			'WordScoped' => 99,
			'Literal' => 122,
			'OPTIONAL-37' => 105,
			'ArrayReference' => 104,
			'Operation' => 230,
			'ArrayDereference' => 117,
			'OperatorVoid' => 116,
			'PAREN-36' => 121,
			'SubExpression' => 96,
			'Conditional' => 112,
			'Statement' => 111,
			'LoopLabel' => 89,
			'Variable' => 90,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 231
		}
	},
	{#State 139
		DEFAULT => -43
	},
	{#State 140
		ACTIONS => {
			'WORD_UPPERCASE' => 232
		}
	},
	{#State 141
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 233
		}
	},
	{#State 142
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 234
		}
	},
	{#State 143
		DEFAULT => -57
	},
	{#State 144
		DEFAULT => -146
	},
	{#State 145
		ACTIONS => {
			'FHREF_SYMBOL_IN' => 236,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'STDIN' => 235,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128
		},
		GOTOS => {
			'SubExpression' => 238,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpressionOrInput' => 237,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99
		}
	},
	{#State 146
		ACTIONS => {
			'LPAREN' => 239
		}
	},
	{#State 147
		DEFAULT => -86
	},
	{#State 148
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'LBRACE' => 130,
			'WORD' => 29
		},
		GOTOS => {
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Expression' => 154,
			'SubExpression' => 240,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 149
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP21_LIST_COMMA' => -188,
			'OP16_LOGICAL_OR' => 181,
			";" => -188,
			'OP18_TERNARY' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP09_BITWISE_SHIFT' => 173,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP06_REGEX_MATCH' => 167,
			")" => -188,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169,
			"]" => -188,
			'OP13_BITWISE_AND' => 174
		}
	},
	{#State 150
		ACTIONS => {
			'OP02_METHOD_THINARROW' => 146,
			'OP03_MATH_INC_DEC' => 147,
			'OP09_BITWISE_SHIFT' => -135,
			'OP13_BITWISE_AND' => -135,
			"]" => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP06_REGEX_MATCH' => -135,
			")" => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			"}" => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP18_TERNARY' => -135,
			";" => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP21_LIST_COMMA' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP04_MATH_POW' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP08_STRING_CAT' => -135
		}
	},
	{#State 151
		DEFAULT => -190
	},
	{#State 152
		ACTIONS => {
			'LPAREN' => 195
		}
	},
	{#State 153
		DEFAULT => -192
	},
	{#State 154
		DEFAULT => -132
	},
	{#State 155
		ACTIONS => {
			"]" => 241
		}
	},
	{#State 156
		DEFAULT => -186,
		GOTOS => {
			'STAR-45' => 242
		}
	},
	{#State 157
		ACTIONS => {
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LBRACE' => 130,
			'WORD' => 29,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Expression' => 154,
			'SubExpression' => 243
		}
	},
	{#State 158
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 51,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 244
		}
	},
	{#State 159
		ACTIONS => {
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"%{" => 123,
			"\@{" => 124,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'SubExpression' => 245,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117
		}
	},
	{#State 160
		DEFAULT => -191
	},
	{#State 161
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'MY' => 158,
			'LITERAL_STRING' => 85,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'ARGV' => 160,
			'LBRACE' => 130,
			'WORD' => 29
		},
		GOTOS => {
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'TypeInner' => 157,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'ListElement' => 156,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Expression' => 154,
			'SubExpression' => 149,
			'ListElements' => 246
		}
	},
	{#State 162
		DEFAULT => -109
	},
	{#State 163
		DEFAULT => -110
	},
	{#State 164
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LBRACE' => 130,
			'ARGV' => 160,
			'WORD' => 29,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_QW' => 151,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'MY' => 158
		},
		GOTOS => {
			'ListElement' => 156,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'SubExpression' => 149,
			'ListElements' => 247,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117
		}
	},
	{#State 165
		DEFAULT => -85
	},
	{#State 166
		ACTIONS => {
			'TYPE_FHREF' => 248
		}
	},
	{#State 167
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 249
		}
	},
	{#State 168
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'LBRACE' => 130,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Expression' => 154,
			'SubExpression' => 250,
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104
		}
	},
	{#State 169
		ACTIONS => {
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120,
			"\@{" => 124,
			"%{" => 123,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 29,
			'LBRACE' => 130,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Literal' => 122,
			'Variable' => 150,
			'SubExpression' => 251,
			'Expression' => 154,
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106
		}
	},
	{#State 170
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Expression' => 154,
			'SubExpression' => 252,
			'WordScoped' => 99,
			'Literal' => 122,
			'Variable' => 150,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104
		}
	},
	{#State 171
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"\@{" => 124,
			"%{" => 123,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'LBRACE' => 130
		},
		GOTOS => {
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'SubExpression' => 253,
			'Expression' => 154
		}
	},
	{#State 172
		ACTIONS => {
			"%{" => 123,
			"\@{" => 124,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LBRACE' => 130,
			'WORD' => 29,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 254,
			'Expression' => 154,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 173
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			"%{" => 123,
			"\@{" => 124,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LBRACE' => 130,
			'WORD' => 29,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'SubExpression' => 255,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99
		}
	},
	{#State 174
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LBRACE' => 130,
			'WORD' => 29,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128
		},
		GOTOS => {
			'WordScoped' => 99,
			'Literal' => 122,
			'Variable' => 150,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Expression' => 154,
			'SubExpression' => 256
		}
	},
	{#State 175
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'SubExpression' => 257,
			'Expression' => 154,
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106
		}
	},
	{#State 176
		ACTIONS => {
			"\@{" => 124,
			"%{" => 123,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'SubExpression' => 258,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117
		}
	},
	{#State 177
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'LBRACE' => 130,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98
		},
		GOTOS => {
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'SubExpression' => 259,
			'Expression' => 154,
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104
		}
	},
	{#State 178
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_STRING' => 85,
			'SELF' => 128,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Variable' => 261,
			'Literal' => 262,
			'VariableOrLiteral' => 260,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 179
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'SubExpression' => 263,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99
		}
	},
	{#State 180
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'WORD' => 29,
			'LBRACE' => 130,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"\@{" => 124,
			"%{" => 123,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127
		},
		GOTOS => {
			'SubExpression' => 264,
			'Expression' => 154,
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122
		}
	},
	{#State 181
		ACTIONS => {
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"\@{" => 124,
			"%{" => 123,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'WORD' => 29,
			'LBRACE' => 130,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'SubExpression' => 265,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117
		}
	},
	{#State 182
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128
		},
		GOTOS => {
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'Expression' => 154,
			'SubExpression' => 266,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132
		}
	},
	{#State 183
		ACTIONS => {
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LBRACE' => 130,
			'WORD' => 29,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159
		},
		GOTOS => {
			'Expression' => 154,
			'SubExpression' => 267,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Literal' => 122,
			'Variable' => 150
		}
	},
	{#State 184
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 173,
			")" => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP06_REGEX_MATCH' => 167,
			'OP23_LOGICAL_AND' => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			"]" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP16_LOGICAL_OR' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP04_MATH_POW' => 179,
			"}" => -96,
			'OP08_MATH_ADD_SUB' => 170,
			";" => -96,
			'OP18_TERNARY' => -96,
			'OP07_STRING_REPEAT' => 177,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 172
		}
	},
	{#State 185
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'WORD' => 29,
			'LBRACE' => 130,
			'ARGV' => 160,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"\@{" => 124,
			"%{" => 123,
			'OP22_LOGICAL_NEG' => 120,
			'MY' => 158,
			'LITERAL_NUMBER' => 84,
			")" => -123,
			'LITERAL_STRING' => 85,
			'OP01_QW' => 151,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159
		},
		GOTOS => {
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'VariableSymbolOrSelf' => 114,
			'ListElement' => 156,
			'OPTIONAL-34' => 268,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Expression' => 154,
			'SubExpression' => 149,
			'ListElements' => 269
		}
	},
	{#State 186
		ACTIONS => {
			")" => 270
		}
	},
	{#State 187
		ACTIONS => {
			";" => 271
		}
	},
	{#State 188
		DEFAULT => -161
	},
	{#State 189
		DEFAULT => -150
	},
	{#State 190
		ACTIONS => {
			'MY' => 272
		}
	},
	{#State 191
		ACTIONS => {
			'LPAREN_MY' => 274,
			'LPAREN' => 273
		}
	},
	{#State 192
		DEFAULT => -162
	},
	{#State 193
		DEFAULT => -163
	},
	{#State 194
		ACTIONS => {
			'LPAREN_MY' => 275,
			'MY' => 276
		}
	},
	{#State 195
		ACTIONS => {
			")" => 277
		}
	},
	{#State 196
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP08_STRING_CAT' => 183,
			'OP18_TERNARY' => 178,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP13_BITWISE_AND' => 174,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => 169,
			'OP15_LOGICAL_AND' => 168,
			'OP06_REGEX_MATCH' => 167,
			")" => 278,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 197
		DEFAULT => -78
	},
	{#State 198
		ACTIONS => {
			'OP21_LIST_COMMA' => 279
		}
	},
	{#State 199
		ACTIONS => {
			'OP17_LIST_RANGE' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP08_STRING_CAT' => -81,
			'OP07_STRING_REPEAT' => -81,
			";" => -81,
			'OP18_TERNARY' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP21_LIST_COMMA' => -188,
			'OP16_LOGICAL_OR' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP04_MATH_POW' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP15_LOGICAL_AND' => -81,
			")" => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP09_BITWISE_SHIFT' => -81
		}
	},
	{#State 200
		ACTIONS => {
			"}" => -174,
			'OP20_HASH_FATARROW' => -174,
			'OP07_STRING_REPEAT' => -174,
			'OP08_MATH_ADD_SUB' => -174,
			'OP18_TERNARY' => -174,
			";" => -174,
			'OP16_LOGICAL_OR' => -174,
			'OP21_LIST_COMMA' => -174,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'OP04_MATH_POW' => -174,
			'OP02_ARRAY_THINARROW' => 282,
			'OP17_LIST_RANGE' => -174,
			'COLON' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			'OP08_STRING_CAT' => -174,
			'OP03_MATH_INC_DEC' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			'OP02_METHOD_THINARROW' => -174,
			'OP09_BITWISE_SHIFT' => -174,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			'OP13_BITWISE_AND' => -174,
			"]" => -174,
			'OP02_HASH_THINARROW' => 280,
			'OP23_LOGICAL_AND' => -174,
			'OP06_REGEX_MATCH' => -174,
			")" => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP12_COMPARE_EQ_NE' => -174,
			'OP11_COMPARE_LT_GT' => -174
		},
		GOTOS => {
			'VariableRetrieval' => 281
		}
	},
	{#State 201
		ACTIONS => {
			'VARIABLE_SYMBOL' => 283
		}
	},
	{#State 202
		ACTIONS => {
			'FHREF_SYMBOL' => 284
		}
	},
	{#State 203
		DEFAULT => -16
	},
	{#State 204
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP08_STRING_CAT' => 183,
			";" => -106,
			'OP18_TERNARY' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 170,
			"}" => -106,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP16_LOGICAL_OR' => 181,
			'OP21_LIST_COMMA' => -106,
			"]" => -106,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP06_REGEX_MATCH' => 167,
			")" => -106,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => -106,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 205
		ACTIONS => {
			"}" => 285
		}
	},
	{#State 206
		DEFAULT => -209
	},
	{#State 207
		ACTIONS => {
			'LBRACE' => 130
		},
		GOTOS => {
			'HashReference' => 286
		}
	},
	{#State 208
		ACTIONS => {
			'LBRACKET' => 91
		},
		GOTOS => {
			'ArrayReference' => 287
		}
	},
	{#State 209
		DEFAULT => -195
	},
	{#State 210
		ACTIONS => {
			"}" => 288
		}
	},
	{#State 211
		ACTIONS => {
			";" => 289
		}
	},
	{#State 212
		DEFAULT => -215
	},
	{#State 213
		ACTIONS => {
			"\@{" => 124,
			"%{" => 123,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'WORD' => 29,
			'LBRACE' => 130,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'SubExpression' => 290,
			'Expression' => 154,
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Literal' => 122,
			'Variable' => 150
		}
	},
	{#State 214
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -88,
			'OP16_LOGICAL_OR' => -88,
			'OP21_LIST_COMMA' => -88,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => -88,
			"}" => -88,
			";" => -88,
			'OP18_TERNARY' => -88,
			'OP07_STRING_REPEAT' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP08_STRING_CAT' => -88,
			'OP17_LIST_RANGE' => -88,
			'OP07_MATH_MULT_DIV_MOD' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			")" => -88,
			'OP06_REGEX_MATCH' => -88,
			'OP15_LOGICAL_AND' => -88,
			'OP23_LOGICAL_AND' => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			"]" => -88,
			'OP13_BITWISE_AND' => -88
		}
	},
	{#State 215
		DEFAULT => -208
	},
	{#State 216
		DEFAULT => -206,
		GOTOS => {
			'STAR-50' => 291
		}
	},
	{#State 217
		DEFAULT => -225
	},
	{#State 218
		DEFAULT => -227
	},
	{#State 219
		DEFAULT => -202
	},
	{#State 220
		DEFAULT => -226
	},
	{#State 221
		ACTIONS => {
			'OP20_HASH_FATARROW' => 292
		}
	},
	{#State 222
		ACTIONS => {
			")" => 293
		}
	},
	{#State 223
		DEFAULT => -112
	},
	{#State 224
		DEFAULT => -84
	},
	{#State 225
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 294
		}
	},
	{#State 226
		ACTIONS => {
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => 169,
			'OP15_LOGICAL_AND' => 168,
			'OP06_REGEX_MATCH' => 167,
			")" => 295,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 227
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'MY' => 158,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 115,
			'OP01_QW' => 151,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'WORD' => 29,
			'LBRACE' => 130,
			'ARGV' => 160,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"\@{" => 124,
			"%{" => 123,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127
		},
		GOTOS => {
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'ListElement' => 296,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 199,
			'Expression' => 154
		}
	},
	{#State 228
		DEFAULT => -153
	},
	{#State 229
		ACTIONS => {
			";" => 297
		}
	},
	{#State 230
		DEFAULT => -46
	},
	{#State 231
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 298
		}
	},
	{#State 232
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 233
		ACTIONS => {
			"our" => 300,
			'LITERAL_NUMBER' => 303
		},
		GOTOS => {
			'Method' => 301,
			'Subroutine' => 302,
			'MethodOrSubroutine' => 304
		}
	},
	{#State 234
		ACTIONS => {
			'LBRACE' => 305
		}
	},
	{#State 235
		DEFAULT => -143
	},
	{#State 236
		DEFAULT => -142
	},
	{#State 237
		DEFAULT => -182
	},
	{#State 238
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP08_MATH_ADD_SUB' => 170,
			";" => -141,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 178,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP06_REGEX_MATCH' => 167,
			")" => -141,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP13_BITWISE_AND' => 174
		}
	},
	{#State 239
		ACTIONS => {
			'LBRACE' => 130,
			'ARGV' => 160,
			'WORD' => 29,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LITERAL_STRING' => 85,
			")" => -125,
			'LITERAL_NUMBER' => 84,
			'MY' => 158,
			'OP22_LOGICAL_NEG' => 120,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_QW' => 151
		},
		GOTOS => {
			'ListElement' => 156,
			'OPTIONAL-35' => 306,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'SubExpression' => 149,
			'ListElements' => 307,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117
		}
	},
	{#State 240
		ACTIONS => {
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 183,
			'OP18_TERNARY' => 178,
			";" => -183,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP13_BITWISE_AND' => 174,
			")" => -183,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 241
		DEFAULT => -194
	},
	{#State 242
		ACTIONS => {
			";" => -187,
			"]" => -187,
			'OP21_LIST_COMMA' => 308,
			")" => -187
		},
		GOTOS => {
			'PAREN-44' => 309
		}
	},
	{#State 243
		ACTIONS => {
			'OP23_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 167,
			")" => -189,
			'OP15_LOGICAL_AND' => 168,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP13_BITWISE_AND' => 174,
			"]" => -189,
			'OP09_BITWISE_SHIFT' => 173,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP16_LOGICAL_OR' => 181,
			'OP21_LIST_COMMA' => -189,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP07_STRING_REPEAT' => 177,
			";" => -189,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 178
		}
	},
	{#State 244
		ACTIONS => {
			"\$TYPED_" => 310
		}
	},
	{#State 245
		ACTIONS => {
			'OP17_LIST_RANGE' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP08_STRING_CAT' => -81,
			"}" => -81,
			'OP08_MATH_ADD_SUB' => -81,
			";" => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP18_TERNARY' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP21_LIST_COMMA' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP04_MATH_POW' => -81,
			"]" => -81,
			'OP13_BITWISE_AND' => -81,
			'OP06_REGEX_MATCH' => -81,
			")" => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP09_BITWISE_SHIFT' => -81
		}
	},
	{#State 246
		ACTIONS => {
			";" => 311
		}
	},
	{#State 247
		ACTIONS => {
			";" => 312
		}
	},
	{#State 248
		ACTIONS => {
			'FHREF_SYMBOL' => 313
		}
	},
	{#State 249
		DEFAULT => -90
	},
	{#State 250
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => -102,
			'OP08_STRING_CAT' => 183,
			";" => -102,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -102,
			'OP07_STRING_REPEAT' => 177,
			"}" => -102,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP16_LOGICAL_OR' => -102,
			'OP21_LIST_COMMA' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP13_BITWISE_AND' => 174,
			"]" => -102,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => -102,
			'OP15_LOGICAL_AND' => -102,
			")" => -102,
			'OP06_REGEX_MATCH' => 167,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 251
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP16_LOGICAL_OR' => 181,
			'OP21_LIST_COMMA' => -107,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			"}" => -107,
			";" => -107,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 178,
			'OP08_MATH_ADD_SUB' => 170,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			")" => -107,
			'OP15_LOGICAL_AND' => 168,
			'OP06_REGEX_MATCH' => 167,
			'OP23_LOGICAL_AND' => -107,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			"]" => -107,
			'OP13_BITWISE_AND' => 174
		}
	},
	{#State 252
		ACTIONS => {
			'OP23_LOGICAL_AND' => -93,
			")" => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP06_REGEX_MATCH' => 167,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP13_BITWISE_AND' => -93,
			"]" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP08_STRING_CAT' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP16_LOGICAL_OR' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP04_MATH_POW' => 179,
			"}" => -93,
			";" => -93,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => -93,
			'OP08_MATH_ADD_SUB' => -93
		}
	},
	{#State 253
		ACTIONS => {
			'OP13_BITWISE_AND' => 174,
			"]" => -108,
			'OP23_LOGICAL_AND' => 169,
			'OP15_LOGICAL_AND' => 168,
			")" => -108,
			'OP06_REGEX_MATCH' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP09_BITWISE_SHIFT' => 173,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 183,
			"}" => -108,
			";" => -108,
			'OP18_TERNARY' => 178,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP21_LIST_COMMA' => -108,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179
		}
	},
	{#State 254
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -92,
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			";" => -92,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => -92,
			"}" => -92,
			'OP08_STRING_CAT' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP15_LOGICAL_AND' => -92,
			")" => -92,
			'OP06_REGEX_MATCH' => 167,
			'OP13_BITWISE_AND' => -92,
			"]" => -92
		}
	},
	{#State 255
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => 167,
			")" => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP13_BITWISE_AND' => -95,
			"]" => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => -95,
			"}" => -95,
			";" => -95,
			'OP18_TERNARY' => -95,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 172
		}
	},
	{#State 256
		ACTIONS => {
			";" => -100,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => 170,
			"}" => -100,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP04_MATH_POW' => 179,
			'OP16_LOGICAL_OR' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => -100,
			'OP08_STRING_CAT' => 183,
			'OP09_BITWISE_SHIFT' => 173,
			'OP13_BITWISE_AND' => -100,
			"]" => -100,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => -100,
			")" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 167
		}
	},
	{#State 257
		ACTIONS => {
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP04_MATH_POW' => 179,
			"}" => -98,
			'OP07_STRING_REPEAT' => 177,
			";" => -98,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -98,
			")" => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP06_REGEX_MATCH' => 167,
			'OP23_LOGICAL_AND' => -98,
			'OP11_COMPARE_LT_GT' => undef,
			'OP12_COMPARE_EQ_NE' => -98,
			"]" => -98,
			'OP13_BITWISE_AND' => -98,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 258
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 173,
			"]" => -99,
			'OP13_BITWISE_AND' => -99,
			")" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP06_REGEX_MATCH' => 167,
			'OP23_LOGICAL_AND' => -99,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => undef,
			"}" => -99,
			'OP07_STRING_REPEAT' => 177,
			";" => -99,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 183
		}
	},
	{#State 259
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP16_LOGICAL_OR' => -91,
			";" => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP18_TERNARY' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			"}" => -91,
			'OP08_STRING_CAT' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP17_LIST_RANGE' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP06_REGEX_MATCH' => 167,
			")" => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP23_LOGICAL_AND' => -91,
			"]" => -91,
			'OP13_BITWISE_AND' => -91
		}
	},
	{#State 260
		ACTIONS => {
			'COLON' => 314
		}
	},
	{#State 261
		DEFAULT => -223
	},
	{#State 262
		DEFAULT => -224
	},
	{#State 263
		ACTIONS => {
			"]" => -87,
			'OP13_BITWISE_AND' => -87,
			'OP11_COMPARE_LT_GT' => -87,
			'OP12_COMPARE_EQ_NE' => -87,
			'OP06_REGEX_MATCH' => -87,
			")" => -87,
			'OP15_LOGICAL_AND' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP07_MATH_MULT_DIV_MOD' => -87,
			'OP17_LIST_RANGE' => -87,
			'OP08_STRING_CAT' => -87,
			";" => -87,
			'OP18_TERNARY' => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP08_MATH_ADD_SUB' => -87,
			"}" => -87,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP16_LOGICAL_OR' => -87,
			'OP21_LIST_COMMA' => -87
		}
	},
	{#State 264
		ACTIONS => {
			'OP07_STRING_REPEAT' => 177,
			";" => -101,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -101,
			"}" => -101,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP16_LOGICAL_OR' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => -101,
			'OP08_STRING_CAT' => 183,
			'OP09_BITWISE_SHIFT' => 173,
			"]" => -101,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP06_REGEX_MATCH' => 167,
			")" => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP23_LOGICAL_AND' => -101
		}
	},
	{#State 265
		ACTIONS => {
			'OP07_STRING_REPEAT' => 177,
			";" => -103,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -103,
			"}" => -103,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP16_LOGICAL_OR' => -103,
			'OP21_LIST_COMMA' => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => -103,
			'OP08_STRING_CAT' => 183,
			'OP09_BITWISE_SHIFT' => 173,
			'OP13_BITWISE_AND' => 174,
			"]" => -103,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 167,
			")" => -103,
			'OP15_LOGICAL_AND' => 168
		}
	},
	{#State 266
		ACTIONS => {
			'OP17_LIST_RANGE' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 183,
			"}" => -104,
			'OP07_STRING_REPEAT' => 177,
			";" => -104,
			'OP18_TERNARY' => -104,
			'OP08_MATH_ADD_SUB' => 170,
			'OP21_LIST_COMMA' => -104,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP13_BITWISE_AND' => 174,
			"]" => -104,
			'OP23_LOGICAL_AND' => -104,
			")" => -104,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 267
		ACTIONS => {
			'OP16_LOGICAL_OR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP04_MATH_POW' => 179,
			"}" => -94,
			'OP07_STRING_REPEAT' => 177,
			";" => -94,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -94,
			'OP08_STRING_CAT' => -94,
			'OP17_LIST_RANGE' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => -94,
			'OP23_LOGICAL_AND' => -94,
			")" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 167,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP13_BITWISE_AND' => -94,
			"]" => -94
		}
	},
	{#State 268
		ACTIONS => {
			")" => 315
		}
	},
	{#State 269
		DEFAULT => -122
	},
	{#State 270
		DEFAULT => -131
	},
	{#State 271
		DEFAULT => -118
	},
	{#State 272
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 316
		}
	},
	{#State 273
		ACTIONS => {
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LBRACE' => 130,
			'WORD' => 29,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'Expression' => 154,
			'SubExpression' => 317,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129
		}
	},
	{#State 274
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_INTEGER' => 51,
			'WORD' => 53
		},
		GOTOS => {
			'Type' => 318
		}
	},
	{#State 275
		ACTIONS => {
			'TYPE_INTEGER' => 319
		}
	},
	{#State 276
		ACTIONS => {
			'TYPE_INTEGER' => 320
		}
	},
	{#State 277
		DEFAULT => -127
	},
	{#State 278
		DEFAULT => -89
	},
	{#State 279
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'MY' => 158,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 115,
			'OP01_QW' => 151,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'ARGV' => 160,
			'LBRACE' => 130,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97
		},
		GOTOS => {
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Expression' => 154,
			'SubExpression' => 149,
			'ListElements' => 321,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'TypeInner' => 157,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'ListElement' => 156
		}
	},
	{#State 280
		ACTIONS => {
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LBRACE' => 130,
			'WORD' => 322,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108
		},
		GOTOS => {
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'SubExpression' => 323,
			'Expression' => 154
		}
	},
	{#State 281
		DEFAULT => -172
	},
	{#State 282
		ACTIONS => {
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LBRACE' => 130,
			'WORD' => 29,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91
		},
		GOTOS => {
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'SubExpression' => 324,
			'Expression' => 154
		}
	},
	{#State 283
		ACTIONS => {
			";" => 327,
			'OP19_VARIABLE_ASSIGN' => 325,
			'OP02_ARRAY_THINARROW' => 326
		}
	},
	{#State 284
		ACTIONS => {
			";" => 328
		}
	},
	{#State 285
		DEFAULT => -211
	},
	{#State 286
		ACTIONS => {
			"}" => 329
		}
	},
	{#State 287
		ACTIONS => {
			"}" => 330
		}
	},
	{#State 288
		DEFAULT => -197
	},
	{#State 289
		DEFAULT => -121
	},
	{#State 290
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 173,
			'OP06_REGEX_MATCH' => 167,
			")" => 331,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP13_BITWISE_AND' => 174,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP18_TERNARY' => 178,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172
		}
	},
	{#State 291
		ACTIONS => {
			"}" => 333,
			'OP21_LIST_COMMA' => 334
		},
		GOTOS => {
			'PAREN-49' => 332
		}
	},
	{#State 292
		ACTIONS => {
			'WORD_SCOPED' => -200,
			'OP05_LOGICAL_NEG' => -200,
			'CONSTANT_CALL_SCOPED' => -200,
			'OP10_NAMED_UNARY' => -200,
			"\@{" => -200,
			"%{" => -200,
			'OP05_MATH_NEG_LPAREN' => -200,
			'OP01_CLOSE' => -200,
			"undef" => -200,
			'LPAREN' => -200,
			'WORD_UPPERCASE' => -200,
			'SELF' => -200,
			'WORD' => -200,
			'LBRACE' => -200,
			'OP01_OPEN' => -200,
			'OP03_MATH_INC_DEC' => -200,
			'VARIABLE_SYMBOL' => -200,
			'OP01_NAMED' => -200,
			'LBRACKET' => -200,
			'OP22_LOGICAL_NEG' => -200,
			'MY' => 158,
			'LITERAL_NUMBER' => -200,
			'LITERAL_STRING' => -200
		},
		GOTOS => {
			'TypeInner' => 336,
			'OPTIONAL-48' => 335
		}
	},
	{#State 293
		ACTIONS => {
			";" => 337
		}
	},
	{#State 294
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'ARGV' => 160,
			'LBRACE' => 130,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'VARIABLE_SYMBOL' => 115,
			'OP01_QW' => 151,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'MY' => 158,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Expression' => 154,
			'ListElements' => 338,
			'SubExpression' => 149,
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'ListElement' => 156
		}
	},
	{#State 295
		DEFAULT => -140
	},
	{#State 296
		ACTIONS => {
			'OP21_LIST_COMMA' => 339
		}
	},
	{#State 297
		DEFAULT => -48
	},
	{#State 298
		ACTIONS => {
			'OP21_LIST_COMMA' => 342,
			")" => 340
		},
		GOTOS => {
			'PAREN-19' => 341
		}
	},
	{#State 299
		DEFAULT => -222
	},
	{#State 300
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'TYPE_METHOD' => 343,
			'WORD' => 53,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 301
		DEFAULT => -76
	},
	{#State 302
		DEFAULT => -77
	},
	{#State 303
		ACTIONS => {
			";" => 344
		}
	},
	{#State 304
		DEFAULT => -59
	},
	{#State 305
		ACTIONS => {
			"}" => 345,
			'WORD' => 346
		},
		GOTOS => {
			'HashEntryProperties' => 347
		}
	},
	{#State 306
		ACTIONS => {
			")" => 348
		}
	},
	{#State 307
		DEFAULT => -124
	},
	{#State 308
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"\@{" => 124,
			"%{" => 123,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'ARGV' => 160,
			'LBRACE' => 130,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP01_QW' => 151,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'MY' => 158,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'ListElement' => 349,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 149,
			'Expression' => 154
		}
	},
	{#State 309
		DEFAULT => -185
	},
	{#State 310
		ACTIONS => {
			'WORD' => 350
		}
	},
	{#State 311
		DEFAULT => -114
	},
	{#State 312
		DEFAULT => -115
	},
	{#State 313
		ACTIONS => {
			'OP21_LIST_COMMA' => 351
		}
	},
	{#State 314
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'SELF' => 128,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 261,
			'Literal' => 262,
			'VariableOrLiteral' => 352,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 315
		DEFAULT => -129
	},
	{#State 316
		ACTIONS => {
			'VARIABLE_SYMBOL' => 353
		}
	},
	{#State 317
		ACTIONS => {
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 178,
			'OP08_MATH_ADD_SUB' => 170,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP08_STRING_CAT' => 183,
			'OP09_BITWISE_SHIFT' => 173,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			")" => 354,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169
		}
	},
	{#State 318
		ACTIONS => {
			'VARIABLE_SYMBOL' => 355
		}
	},
	{#State 319
		ACTIONS => {
			'VARIABLE_SYMBOL' => 356
		}
	},
	{#State 320
		ACTIONS => {
			'VARIABLE_SYMBOL' => 357
		}
	},
	{#State 321
		ACTIONS => {
			";" => 358
		}
	},
	{#State 322
		ACTIONS => {
			"}" => 359,
			'LPAREN' => -213,
			'OP02_METHOD_THINARROW_NEW' => -213
		}
	},
	{#State 323
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 178,
			"}" => 360,
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP09_BITWISE_SHIFT' => 173,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP13_BITWISE_AND' => 174
		}
	},
	{#State 324
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP08_STRING_CAT' => 183,
			'OP18_TERNARY' => 178,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			"]" => 361,
			'OP13_BITWISE_AND' => 174,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 325
		ACTIONS => {
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"%{" => 123,
			'STDIN' => 235,
			"\@{" => 124,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'FHREF_SYMBOL_IN' => 236
		},
		GOTOS => {
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'SubExpression' => 238,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'SubExpressionOrInput' => 362,
			'ArrayDereference' => 117
		}
	},
	{#State 326
		ACTIONS => {
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"\@{" => 124,
			"%{" => 123,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93
		},
		GOTOS => {
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 363,
			'Expression' => 154
		}
	},
	{#State 327
		DEFAULT => -178
	},
	{#State 328
		DEFAULT => -181
	},
	{#State 329
		DEFAULT => -212
	},
	{#State 330
		DEFAULT => -198
	},
	{#State 331
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 364
		}
	},
	{#State 332
		DEFAULT => -205
	},
	{#State 333
		DEFAULT => -207
	},
	{#State 334
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'WORD' => 218,
			"%{" => 123,
			'LITERAL_STRING' => 85,
			'SELF' => 128,
			'LITERAL_NUMBER' => 84
		},
		GOTOS => {
			'Literal' => 220,
			'Variable' => 217,
			'VariableOrLiteralOrWord' => 221,
			'HashDereference' => 219,
			'HashEntry' => 366,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 335
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"\@{" => 124,
			"%{" => 123
		},
		GOTOS => {
			'SubExpression' => 367,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99
		}
	},
	{#State 336
		DEFAULT => -199
	},
	{#State 337
		DEFAULT => -117
	},
	{#State 338
		ACTIONS => {
			")" => 368
		}
	},
	{#State 339
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 120,
			'MY' => 158,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP01_QW' => 151,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'ARGV' => 160,
			'LBRACE' => 130,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"\@{" => 124,
			"%{" => 123
		},
		GOTOS => {
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Expression' => 154,
			'SubExpression' => 149,
			'ListElements' => 369,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'TypeInner' => 157,
			'VariableSymbolOrSelf' => 114,
			'ListElement' => 156
		}
	},
	{#State 340
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 370
		}
	},
	{#State 341
		DEFAULT => -50
	},
	{#State 342
		ACTIONS => {
			'MY' => 371
		}
	},
	{#State 343
		ACTIONS => {
			'VARIABLE_SYMBOL' => 372
		}
	},
	{#State 344
		DEFAULT => -61
	},
	{#State 345
		ACTIONS => {
			";" => 373
		}
	},
	{#State 346
		ACTIONS => {
			'OP20_HASH_FATARROW' => 374
		}
	},
	{#State 347
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 375
		}
	},
	{#State 348
		DEFAULT => -130
	},
	{#State 349
		DEFAULT => -184
	},
	{#State 350
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 376
		}
	},
	{#State 351
		ACTIONS => {
			'LITERAL_STRING' => 377
		}
	},
	{#State 352
		DEFAULT => -105
	},
	{#State 353
		ACTIONS => {
			'LPAREN' => 378
		}
	},
	{#State 354
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 379
		}
	},
	{#State 355
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 380
		}
	},
	{#State 356
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 381
		}
	},
	{#State 357
		ACTIONS => {
			'LPAREN' => 382
		}
	},
	{#State 358
		DEFAULT => -119
	},
	{#State 359
		DEFAULT => -177
	},
	{#State 360
		DEFAULT => -176
	},
	{#State 361
		DEFAULT => -175
	},
	{#State 362
		ACTIONS => {
			";" => 383
		}
	},
	{#State 363
		ACTIONS => {
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 183,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 178,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			"]" => 384,
			'OP13_BITWISE_AND' => 174,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 364
		DEFAULT => -156,
		GOTOS => {
			'STAR-39' => 385
		}
	},
	{#State 365
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => 101,
			'OP01_NAMED_VOID' => 103,
			'WORD_SCOPED' => 28,
			"for" => -148,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 110,
			'WORD_UPPERCASE' => 107,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_PRINT' => 92,
			'LBRACKET' => 91,
			"while" => -148,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP19_LOOP_CONTROL' => 125,
			"if" => 126,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'OP01_CLOSE' => 133,
			"foreach" => -148,
			'LPAREN' => 134,
			'SELF' => 128,
			'WORD' => 29,
			'OP01_NAMED_VOID_LPAREN' => 131,
			'LBRACE' => 130,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 113,
			'OP22_LOGICAL_NEG' => 120,
			'MY' => 118
		},
		GOTOS => {
			'Conditional' => 112,
			'PLUS-42' => 386,
			'Statement' => 111,
			'Variable' => 90,
			'LoopLabel' => 89,
			'VariableSymbolOrSelf' => 114,
			'ArrayDereference' => 117,
			'OperatorVoid' => 116,
			'PAREN-36' => 121,
			'SubExpression' => 96,
			'WordScoped' => 99,
			'Literal' => 122,
			'OPTIONAL-37' => 105,
			'Operation' => 387,
			'ArrayReference' => 104,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Operator' => 106,
			'VariableModification' => 136,
			'VariableDeclaration' => 135,
			'Expression' => 109
		}
	},
	{#State 366
		DEFAULT => -204
	},
	{#State 367
		ACTIONS => {
			'OP15_LOGICAL_AND' => 168,
			'OP06_REGEX_MATCH' => 167,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 173,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP21_LIST_COMMA' => -201,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			"}" => -201,
			'OP18_TERNARY' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP08_MATH_ADD_SUB' => 170
		}
	},
	{#State 368
		DEFAULT => -80
	},
	{#State 369
		ACTIONS => {
			")" => 388
		}
	},
	{#State 370
		ACTIONS => {
			"\@_;" => 389
		}
	},
	{#State 371
		ACTIONS => {
			'WORD' => 53,
			'TYPE_INTEGER' => 51,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 390
		}
	},
	{#State 372
		ACTIONS => {
			"= sub {" => 391
		}
	},
	{#State 373
		DEFAULT => -66
	},
	{#State 374
		ACTIONS => {
			'MY' => 392
		},
		GOTOS => {
			'TypeInnerProperties' => 393
		}
	},
	{#State 375
		ACTIONS => {
			'OP21_LIST_COMMA' => 394,
			"}" => 395
		},
		GOTOS => {
			'PAREN-25' => 396
		}
	},
	{#State 376
		DEFAULT => -219
	},
	{#State 377
		ACTIONS => {
			'OP21_LIST_COMMA' => 397
		}
	},
	{#State 378
		ACTIONS => {
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_QW' => 151,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 84,
			'MY' => 158,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"%{" => 123,
			"\@{" => 124,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'ARGV' => 160,
			'LBRACE' => 130,
			'WORD' => 29,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LPAREN' => 134,
			"undef" => 110
		},
		GOTOS => {
			'ListElement' => 156,
			'TypeInner' => 157,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'SubExpression' => 149,
			'ListElements' => 398,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117
		}
	},
	{#State 379
		DEFAULT => -167
	},
	{#State 380
		ACTIONS => {
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"\@{" => 124,
			"%{" => 123,
			'STDIN' => 235,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'LBRACE' => 130,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'FHREF_SYMBOL_IN' => 236,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85
		},
		GOTOS => {
			'SubExpression' => 238,
			'Expression' => 154,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'SubExpressionOrInput' => 399,
			'ArrayDereference' => 117,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99
		}
	},
	{#State 381
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'LBRACE' => 130,
			'WORD' => 29,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			"%{" => 123,
			"\@{" => 124,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97
		},
		GOTOS => {
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Expression' => 154,
			'SubExpression' => 400
		}
	},
	{#State 382
		ACTIONS => {
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"\@{" => 124,
			"%{" => 123,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'LBRACE' => 130,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Literal' => 122,
			'Variable' => 150,
			'Expression' => 154,
			'SubExpression' => 401,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129
		}
	},
	{#State 383
		DEFAULT => -179
	},
	{#State 384
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 402
		}
	},
	{#State 385
		ACTIONS => {
			'MY' => -159,
			'OP22_LOGICAL_NEG' => -159,
			'OP01_NAMED' => -159,
			'VARIABLE_SYMBOL' => -159,
			'SELF' => -159,
			'OP01_NAMED_VOID_LPAREN' => -159,
			'LBRACE' => -159,
			'WORD' => -159,
			'OP01_CLOSE' => -159,
			'LPAREN' => -159,
			"foreach" => -159,
			"%{" => -159,
			"\@{" => -159,
			"if" => -159,
			'OP19_LOOP_CONTROL' => -159,
			'OP05_LOGICAL_NEG' => -159,
			'LITERAL_NUMBER' => -159,
			"elsif" => 407,
			'LITERAL_STRING' => -159,
			"while" => -159,
			"else" => 405,
			'LBRACKET' => -159,
			'OP01_PRINT' => -159,
			'OP01_OPEN' => -159,
			'OP03_MATH_INC_DEC' => -159,
			'OP19_LOOP_CONTROL_SCOLON' => -159,
			'WORD_UPPERCASE' => -159,
			'OP05_MATH_NEG_LPAREN' => -159,
			"undef" => -159,
			'OP10_NAMED_UNARY' => -159,
			'CONSTANT_CALL_SCOPED' => -159,
			'OP01_NAMED_VOID' => -159,
			'OP01_NAMED_VOID_SCOLON' => -159,
			'' => -159,
			"}" => -159,
			"for" => -159,
			'WORD_SCOPED' => -159
		},
		GOTOS => {
			'PAREN-38' => 406,
			'OPTIONAL-41' => 403,
			'PAREN-40' => 404
		}
	},
	{#State 386
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP01_PRINT' => 92,
			'LBRACKET' => 91,
			"while" => -148,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP01_NAMED_VOID' => 103,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'WORD_SCOPED' => 28,
			"for" => -148,
			"}" => 409,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_MATH_NEG_LPAREN' => 108,
			"undef" => 110,
			'WORD_UPPERCASE' => 107,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 113,
			'OP22_LOGICAL_NEG' => 120,
			'MY' => 118,
			'OP19_LOOP_CONTROL' => 125,
			"if" => 126,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'OP01_CLOSE' => 133,
			"foreach" => -148,
			'LPAREN' => 134,
			'SELF' => 128,
			'WORD' => 29,
			'OP01_NAMED_VOID_LPAREN' => 131,
			'LBRACE' => 130
		},
		GOTOS => {
			'PAREN-36' => 121,
			'SubExpression' => 96,
			'ArrayDereference' => 117,
			'OperatorVoid' => 116,
			'VariableSymbolOrSelf' => 114,
			'Conditional' => 112,
			'Statement' => 111,
			'Variable' => 90,
			'LoopLabel' => 89,
			'VariableModification' => 136,
			'VariableDeclaration' => 135,
			'Expression' => 109,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Operator' => 106,
			'OPTIONAL-37' => 105,
			'Operation' => 408,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Literal' => 122
		}
	},
	{#State 387
		DEFAULT => -170
	},
	{#State 388
		DEFAULT => -82
	},
	{#State 389
		DEFAULT => -52
	},
	{#State 390
		ACTIONS => {
			'VARIABLE_SYMBOL' => 410
		}
	},
	{#State 391
		ACTIONS => {
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP01_OPEN' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'LBRACKET' => -68,
			'LPAREN_MY' => 412,
			'OP01_PRINT' => -68,
			"while" => -68,
			'LITERAL_STRING' => -68,
			'LITERAL_NUMBER' => -68,
			"}" => -68,
			"for" => -68,
			'WORD_SCOPED' => -68,
			'OP01_NAMED_VOID' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'OP10_NAMED_UNARY' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			"undef" => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			'WORD_UPPERCASE' => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP01_NAMED' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'MY' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP19_LOOP_CONTROL' => -68,
			"if" => -68,
			"%{" => -68,
			"\@{" => -68,
			'LPAREN' => -68,
			"foreach" => -68,
			'OP01_CLOSE' => -68,
			'LBRACE' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			'WORD' => -68,
			'SELF' => -68
		},
		GOTOS => {
			'MethodArguments' => 413,
			'OPTIONAL-27' => 411
		}
	},
	{#State 392
		ACTIONS => {
			'WORD_SCOPED' => 52,
			'WORD' => 53,
			'TYPE_INTEGER' => 51
		},
		GOTOS => {
			'Type' => 414
		}
	},
	{#State 393
		DEFAULT => -203
	},
	{#State 394
		ACTIONS => {
			'WORD' => 346
		},
		GOTOS => {
			'HashEntryProperties' => 415
		}
	},
	{#State 395
		ACTIONS => {
			";" => 416
		}
	},
	{#State 396
		DEFAULT => -63
	},
	{#State 397
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			"\@{" => 124,
			"%{" => 123,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 110,
			'LPAREN' => 134,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'LBRACE' => 130,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152
		},
		GOTOS => {
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Expression' => 154,
			'SubExpression' => 417
		}
	},
	{#State 398
		ACTIONS => {
			")" => 418
		}
	},
	{#State 399
		ACTIONS => {
			")" => 419
		}
	},
	{#State 400
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP18_TERNARY' => 178,
			";" => 420,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP15_LOGICAL_AND' => 168,
			'OP06_REGEX_MATCH' => 167,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP13_BITWISE_AND' => 174
		}
	},
	{#State 401
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 178,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 421,
			'OP08_STRING_CAT' => 183,
			'OP09_BITWISE_SHIFT' => 173,
			'OP13_BITWISE_AND' => 174,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168
		}
	},
	{#State 402
		ACTIONS => {
			"undef" => 422
		}
	},
	{#State 403
		DEFAULT => -160
	},
	{#State 404
		DEFAULT => -158
	},
	{#State 405
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 423
		}
	},
	{#State 406
		DEFAULT => -155
	},
	{#State 407
		ACTIONS => {
			'LPAREN' => 424
		}
	},
	{#State 408
		DEFAULT => -169
	},
	{#State 409
		DEFAULT => -171
	},
	{#State 410
		DEFAULT => -49
	},
	{#State 411
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 425
		}
	},
	{#State 412
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 53,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 426
		}
	},
	{#State 413
		DEFAULT => -67
	},
	{#State 414
		ACTIONS => {
			"\$TYPED_" => 427
		}
	},
	{#State 415
		DEFAULT => -62
	},
	{#State 416
		DEFAULT => -65
	},
	{#State 417
		ACTIONS => {
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -83,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP18_TERNARY' => 178,
			";" => -83,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			"}" => -83,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP23_LOGICAL_AND' => -83,
			")" => -83,
			'OP15_LOGICAL_AND' => 168,
			'OP06_REGEX_MATCH' => 167,
			'OP13_BITWISE_AND' => 174,
			"]" => -83,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 418
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 428
		}
	},
	{#State 419
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 429
		}
	},
	{#State 420
		ACTIONS => {
			'VARIABLE_SYMBOL' => 430
		}
	},
	{#State 421
		ACTIONS => {
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"\@{" => 124,
			"%{" => 123,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'LBRACE' => 130,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134
		},
		GOTOS => {
			'Expression' => 154,
			'SubExpression' => 431,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104,
			'WordScoped' => 99,
			'Literal' => 122,
			'Variable' => 150
		}
	},
	{#State 422
		ACTIONS => {
			";" => 432
		}
	},
	{#State 423
		DEFAULT => -157
	},
	{#State 424
		ACTIONS => {
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'LBRACE' => 130,
			'WORD' => 29,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			"%{" => 123,
			"\@{" => 124,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28
		},
		GOTOS => {
			'ArrayDereference' => 117,
			'Operator' => 106,
			'HashReference' => 132,
			'HashDereference' => 129,
			'Expression' => 154,
			'SubExpression' => 433,
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104
		}
	},
	{#State 425
		ACTIONS => {
			"for" => -148,
			"}" => 434,
			'WORD_SCOPED' => 28,
			'OP01_NAMED_VOID' => 103,
			'OP01_NAMED_VOID_SCOLON' => 101,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"undef" => 110,
			'OP05_MATH_NEG_LPAREN' => 108,
			'WORD_UPPERCASE' => 107,
			'OP19_LOOP_CONTROL_SCOLON' => 95,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'OP01_PRINT' => 92,
			'LBRACKET' => 91,
			"while" => -148,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP05_LOGICAL_NEG' => 127,
			"if" => 126,
			'OP19_LOOP_CONTROL' => 125,
			"\@{" => 124,
			"%{" => 123,
			"foreach" => -148,
			'LPAREN' => 134,
			'OP01_CLOSE' => 133,
			'WORD' => 29,
			'OP01_NAMED_VOID_LPAREN' => 131,
			'LBRACE' => 130,
			'SELF' => 128,
			'VARIABLE_SYMBOL' => 115,
			'OP01_NAMED' => 113,
			'OP22_LOGICAL_NEG' => 120,
			'MY' => 118
		},
		GOTOS => {
			'Operation' => 435,
			'ArrayReference' => 104,
			'OPTIONAL-37' => 105,
			'Literal' => 122,
			'WordScoped' => 99,
			'Expression' => 109,
			'VariableModification' => 136,
			'VariableDeclaration' => 135,
			'Operator' => 106,
			'HashDereference' => 129,
			'HashReference' => 132,
			'VariableSymbolOrSelf' => 114,
			'Variable' => 90,
			'LoopLabel' => 89,
			'Statement' => 111,
			'Conditional' => 112,
			'SubExpression' => 96,
			'PAREN-36' => 121,
			'OperatorVoid' => 116,
			'ArrayDereference' => 117
		}
	},
	{#State 426
		ACTIONS => {
			'SELF' => 436
		}
	},
	{#State 427
		ACTIONS => {
			'WORD' => 437
		}
	},
	{#State 428
		DEFAULT => -166
	},
	{#State 429
		DEFAULT => -168
	},
	{#State 430
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 438
		}
	},
	{#State 431
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP16_LOGICAL_OR' => 181,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => -104,
			'OP07_STRING_REPEAT' => 177,
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP09_BITWISE_SHIFT' => 173,
			'OP15_LOGICAL_AND' => 168,
			")" => 439,
			'OP06_REGEX_MATCH' => 167,
			'OP23_LOGICAL_AND' => -104,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP13_BITWISE_AND' => 174
		}
	},
	{#State 432
		DEFAULT => -180
	},
	{#State 433
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 173,
			'OP13_BITWISE_AND' => 174,
			'OP23_LOGICAL_AND' => 169,
			'OP06_REGEX_MATCH' => 167,
			")" => 440,
			'OP15_LOGICAL_AND' => 168,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 178,
			'OP16_LOGICAL_OR' => 181,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 183
		}
	},
	{#State 434
		ACTIONS => {
			";" => 441
		}
	},
	{#State 435
		DEFAULT => -69
	},
	{#State 436
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 442
		}
	},
	{#State 437
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 444,
			'OP02_ARRAY_THINARROW' => 443
		}
	},
	{#State 438
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'VARIABLE_SYMBOL' => 115,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"\@{" => 124,
			"%{" => 123
		},
		GOTOS => {
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 445,
			'Expression' => 154,
			'Variable' => 150,
			'Literal' => 122,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 439
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 446
		}
	},
	{#State 440
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 447
		}
	},
	{#State 441
		DEFAULT => -71
	},
	{#State 442
		ACTIONS => {
			")" => 449,
			'OP21_LIST_COMMA' => 448
		},
		GOTOS => {
			'PAREN-29' => 450
		}
	},
	{#State 443
		ACTIONS => {
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP22_LOGICAL_NEG' => 120,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'WORD' => 29,
			'LBRACE' => 130,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP10_NAMED_UNARY' => 97,
			"\@{" => 124,
			"%{" => 123,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127
		},
		GOTOS => {
			'Literal' => 122,
			'Variable' => 150,
			'WordScoped' => 99,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114,
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 451,
			'Expression' => 154
		}
	},
	{#State 444
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 120,
			'LITERAL_NUMBER' => 84,
			'LITERAL_STRING' => 85,
			'OP03_MATH_INC_DEC' => 93,
			'OP01_OPEN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'LBRACKET' => 91,
			'OP01_NAMED' => 159,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_CLOSE' => 133,
			"undef" => 110,
			'LPAREN' => 134,
			'SELF' => 128,
			'WORD_UPPERCASE' => 152,
			'WORD' => 29,
			'LBRACE' => 130,
			'WORD_SCOPED' => 28,
			'OP05_LOGICAL_NEG' => 127,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			"\@{" => 124,
			"%{" => 123
		},
		GOTOS => {
			'HashReference' => 132,
			'HashDereference' => 129,
			'ArrayDereference' => 117,
			'Operator' => 106,
			'SubExpression' => 452,
			'Expression' => 154,
			'WordScoped' => 99,
			'Variable' => 150,
			'Literal' => 122,
			'VariableSymbolOrSelf' => 114,
			'ArrayReference' => 104
		}
	},
	{#State 445
		ACTIONS => {
			";" => 453,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 183,
			'OP09_BITWISE_SHIFT' => 173,
			'OP13_BITWISE_AND' => 174,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176
		}
	},
	{#State 446
		DEFAULT => -164
	},
	{#State 447
		DEFAULT => -154
	},
	{#State 448
		ACTIONS => {
			'MY' => 454
		}
	},
	{#State 449
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 455
		}
	},
	{#State 450
		DEFAULT => -73
	},
	{#State 451
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 173,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP06_REGEX_MATCH' => 167,
			'OP15_LOGICAL_AND' => 168,
			'OP23_LOGICAL_AND' => 169,
			"]" => 456,
			'OP13_BITWISE_AND' => 174,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP17_LIST_RANGE' => 182
		}
	},
	{#State 452
		ACTIONS => {
			'OP08_STRING_CAT' => 183,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP16_LOGICAL_OR' => 181,
			'OP21_LIST_COMMA' => -220,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			"}" => -220,
			'OP08_MATH_ADD_SUB' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 178,
			'OP23_LOGICAL_AND' => 169,
			'OP15_LOGICAL_AND' => 168,
			'OP06_REGEX_MATCH' => 167,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP11_COMPARE_LT_GT' => 175,
			'OP13_BITWISE_AND' => 174,
			'OP09_BITWISE_SHIFT' => 173
		}
	},
	{#State 453
		ACTIONS => {
			"%{" => 123,
			"\@{" => 124,
			'OP10_NAMED_UNARY' => 97,
			'CONSTANT_CALL_SCOPED' => 98,
			'OP05_LOGICAL_NEG' => 127,
			'WORD_SCOPED' => 28,
			'LBRACE' => 130,
			'WORD' => 29,
			'WORD_UPPERCASE' => 152,
			'SELF' => 128,
			'LPAREN' => 134,
			"undef" => 110,
			'OP01_CLOSE' => 133,
			'OP05_MATH_NEG_LPAREN' => 108,
			'OP01_NAMED' => 159,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 115,
			'OP01_OPEN' => 94,
			'OP03_MATH_INC_DEC' => 93,
			'LITERAL_STRING' => 85,
			'LITERAL_NUMBER' => 84,
			'OP22_LOGICAL_NEG' => 120
		},
		GOTOS => {
			'HashDereference' => 129,
			'HashReference' => 132,
			'Operator' => 106,
			'ArrayDereference' => 117,
			'SubExpression' => 459,
			'VariableModification' => 457,
			'Expression' => 154,
			'Variable' => 90,
			'Literal' => 122,
			'WordScoped' => 99,
			'SubExpressionOrVarMod' => 458,
			'ArrayReference' => 104,
			'VariableSymbolOrSelf' => 114
		}
	},
	{#State 454
		ACTIONS => {
			'TYPE_INTEGER' => 51,
			'WORD' => 53,
			'WORD_SCOPED' => 52
		},
		GOTOS => {
			'Type' => 460
		}
	},
	{#State 455
		ACTIONS => {
			"\@_;" => 461
		}
	},
	{#State 456
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 462
		}
	},
	{#State 457
		DEFAULT => -145
	},
	{#State 458
		ACTIONS => {
			")" => 463
		}
	},
	{#State 459
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 173,
			'OP13_BITWISE_AND' => 174,
			'OP15_LOGICAL_AND' => 168,
			")" => -144,
			'OP06_REGEX_MATCH' => 167,
			'OP23_LOGICAL_AND' => 169,
			'OP11_COMPARE_LT_GT' => 175,
			'OP12_COMPARE_EQ_NE' => 176,
			'OP08_MATH_ADD_SUB' => 170,
			'OP18_TERNARY' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP24_LOGICAL_OR_XOR' => 171,
			'OP16_LOGICAL_OR' => 181,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP17_LIST_RANGE' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 172,
			'OP08_STRING_CAT' => 183
		}
	},
	{#State 460
		ACTIONS => {
			'VARIABLE_SYMBOL' => 464
		}
	},
	{#State 461
		DEFAULT => -75
	},
	{#State 462
		ACTIONS => {
			"undef" => 465
		}
	},
	{#State 463
		ACTIONS => {
			'LBRACE' => 365
		},
		GOTOS => {
			'CodeBlock' => 466
		}
	},
	{#State 464
		DEFAULT => -72
	},
	{#State 465
		DEFAULT => -221
	},
	{#State 466
		DEFAULT => -165
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6595 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6602 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6609 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6616 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6627 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6638 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6645 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6652 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6659 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6666 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6673 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6680 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6687 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6694 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6701 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6715 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6722 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6733 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6740 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6747 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6754 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6761 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6772 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6783 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6794 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6801 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6808 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6815 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6822 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6829 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6836 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6843 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6850 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6861 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6868 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6893 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6900 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6911 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6922 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6933 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6944 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6951 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6965 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 158 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6972 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6983 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6990 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7004 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7015 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7022 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7029 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7036 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7043 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7050 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7064 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7071 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7082 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7089 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7096 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7103 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7114 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7146 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 163 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7153 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7164 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7171 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7178 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7185 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7196 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7207 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7218 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7240 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7251 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7262 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7273 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7284 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7295 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7306 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7317 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7339 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7350 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7361 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7372 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7383 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7394 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7405 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7416 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7427 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7438 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7449 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7460 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7471 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7482 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7493 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7504 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7515 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7526 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7548 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7559 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7566 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7573 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7580 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7587 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7594 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7605 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7616 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7627 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7638 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7660 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7682 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 183 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7696 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7703 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7710 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7721 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7732 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7743 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7754 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7765 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7776 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7787 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7798 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7809 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7820 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7831 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7842 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7853 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7864 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7875 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_141
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7886 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_142
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7897 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7908 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_144
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7919 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_145
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7930 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7937 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7944 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7951 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7962 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7973 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7984 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7995 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8006 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8013 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8020 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8027 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8034 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8041 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8048 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_160
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8059 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8070 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8081 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8092 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_164
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8103 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_165
		 'LoopFor', 14,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8114 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_166
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8125 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_167
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8136 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_168
		 'LoopWhile', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8147 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8154 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8161 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_171
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8172 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8179 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8186 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_174
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8197 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8208 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8219 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8230 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8241 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8252 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8263 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8274 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8285 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8296 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8303 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8310 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 202 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8317 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_187
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8328 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8339 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8350 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8361 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8372 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8379 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 204 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8386 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_194
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8397 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8404 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8411 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_197
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8422 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_198
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8433 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8440 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8447 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_201
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8458 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8469 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_203
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8480 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8487 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8494 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 208 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8501 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_207
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8512 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_208
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8523 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8530 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8537 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_211
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8548 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_212
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8559 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_213
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8570 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8581 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_215
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8592 lib/RPerl/Grammar.pm
	],
	[#Rule Type_216
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8603 lib/RPerl/Grammar.pm
	],
	[#Rule Type_217
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8614 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8625 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_219
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8636 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_220
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8647 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_221
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8658 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_222
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8669 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_223
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8680 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_224
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8691 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_225
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8702 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_226
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8713 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_227
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8724 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_228
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8735 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_229
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8746 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_230
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8757 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_231
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8768 lib/RPerl/Grammar.pm
	]
],
#line 8771 lib/RPerl/Grammar.pm
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
         'SubExpressionOrInput_141', 
         'SubExpressionOrInput_142', 
         'SubExpressionOrInput_143', 
         'SubExpressionOrVarMod_144', 
         'SubExpressionOrVarMod_145', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_149', 
         'Statement_150', 
         'Statement_151', 
         'Statement_152', 
         'Statement_153', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_160', 
         'Loop_161', 
         'Loop_162', 
         'Loop_163', 
         'LoopFor_164', 
         'LoopFor_165', 
         'LoopForEach_166', 
         'LoopWhile_167', 
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
         'ListElement_188', 
         'ListElement_189', 
         'ListElement_190', 
         'ListElement_191', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_194', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_197', 
         'ArrayDereference_198', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_201', 
         'HashEntry_202', 
         'HashEntryProperties_203', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_207', 
         'HashReference_208', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_211', 
         'HashDereference_212', 
         'WordScoped_213', 
         'WordScoped_214', 
         'LoopLabel_215', 
         'Type_216', 
         'Type_217', 
         'Type_218', 
         'TypeInner_219', 
         'TypeInnerProperties_220', 
         'TypeInnerProperties_221', 
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

#line 223 "lib/RPerl/Grammar.eyp"


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
SubExpressionOrInput_141 => 'RPerl::Operation::Expression::SubExpression',                      # SubExpressionOrInput -> SubExpression
SubExpressionOrInput_142 => 'RPerl::InputOutput::FilehandleIn',                                 # SubExpressionOrInput -> FHREF_SYMBOL_IN
SubExpressionOrInput_143 => 'RPerl::InputOutput::Stdin',                                        # SubExpressionOrInput -> STDIN
SubExpressionOrVarMod_144 => 'RPerl::Operation::Expression::SubExpression',                     # SubExpressionOrVarMod -> SubExpression
SubExpressionOrVarMod_145 => 'RPerl::Operation::Statement::VariableModification',               # SubExpressionOrVarMod -> VariableModification
Statement_149 => 'RPerl::Operation::Statement::Conditional',                                    # Statement -> Conditional
Statement_150 => 'RPerl::Operation::Statement::Loop',                                           # Statement -> OPTIONAL-36 Loop
Statement_151 => 'RPerl::Operation::Statement::OperatorVoid',                                   # Statement -> OperatorVoid
Statement_152 => 'RPerl::Operation::Statement::VariableDeclaration',                            # Statement -> VariableDeclaration
Statement_153 => 'RPerl::Operation::Statement::VariableModification',                           # Statement -> VariableModification ';'
Conditional_160 => 'RPerl::Operation::Statement::Conditional',                                  # Conditional -> 'if' LPAREN SubExpression ')' CodeBlock STAR-38 OPTIONAL-40
Loop_161 => 'RPerl::Operation::Statement::Loop::For',                                           # Loop -> LoopFor
Loop_162 => 'RPerl::Operation::Statement::Loop::ForEach',                                       # Loop -> LoopForEach
Loop_163 => 'RPerl::Operation::Statement::Loop::While',                                         # Loop -> LoopWhile
LoopFor_164 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' MY TYPE_INTEGER VARIABLE_SYMBOL LPAREN SubExpression OP17_LIST_RANGE SubExpression ')' CodeBlock
LoopFor_165 => 'RPerl::Operation::Statement::Loop::For',                                        # LoopFor -> 'for' LPAREN_MY TYPE_INTEGER VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpression ';' VARIABLE_SYMBOL OP11_COMPARE_LT_GT SubExpression ';' SubExpressionOrVarMod ')' CodeBlock
LoopForEach_166 => 'RPerl::Operation::Statement::Loop::ForEach',                                # LoopForEach -> 'foreach' MY Type VARIABLE_SYMBOL LPAREN ListElements ')' CodeBlock
LoopWhile_167 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN SubExpression ')' CodeBlock
LoopWhile_168 => 'RPerl::Operation::Statement::Loop::While',                                    # LoopWhile -> 'while' LPAREN_MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ')' CodeBlock
CodeBlock_171 => 'RPerl::CodeBlock',                                                            # CodeBlock -> LBRACE PLUS-41 '}'
Variable_174 => 'RPerl::Operation::Expression::SubExpression::Variable',                        # Variable -> VariableSymbolOrSelf STAR-44
VariableRetrieval_175 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_ARRAY_THINARROW SubExpression ']'
VariableRetrieval_176 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW SubExpression '}'
VariableRetrieval_177 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',    # VariableRetrieval -> OP02_HASH_THINARROW WORD '}'
VariableDeclaration_178 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL ';'
VariableDeclaration_179 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP19_VARIABLE_ASSIGN SubExpressionOrInput ';'
VariableDeclaration_180 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY Type VARIABLE_SYMBOL OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef' ';'
VariableDeclaration_181 => 'RPerl::Operation::Statement::VariableDeclaration',                  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_182 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN SubExpressionOrInput
VariableModification_183 => 'RPerl::Operation::Statement::VariableModification',                # VariableModification -> Variable OP19_VARIABLE_ASSIGN_BY SubExpression
ListElements_187 => 'RPerl::DataStructure::Array::ListElements',                                # ListElements -> ListElement STAR-43
ListElement_188 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> SubExpression
ListElement_189 => 'RPerl::Operation::Expression::SubExpression',                               # ListElement -> TypeInner SubExpression
ListElement_190 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> OP01_QW
ListElement_191 => 'RPerl::DataStructure::Array::ListElement',                                  # ListElement -> ARGV
ArrayReference_194 => 'RPerl::DataStructure::Array::Reference',                                 # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_197 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' Variable '}'
ArrayDereference_198 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',        # ArrayDereference -> '@{' OPTIONAL-47 ArrayReference '}'
HashEntry_201 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_202 => 'RPerl::Operation::Expression::SubExpression::HashDereference',                # HashEntry -> HashDereference
HashEntryProperties_203 => 'RPerl::NonGenerator',                                               # HashEntryProperties -> WORD OP20_HASH_FATARROW TypeInnerProperties
HashReference_207 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE HashEntry STAR-50 '}'
HashReference_208 => 'RPerl::DataStructure::Hash::Reference',                                   # HashReference -> LBRACE '}'
HashDereference_211 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' Variable '}'
HashDereference_212 => 'RPerl::Operation::Expression::SubExpression::HashDereference',          # HashDereference -> '%{' OPTIONAL-51 HashReference '}'
WordScoped_213 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD
WordScoped_214 => 'RPerl::NonGenerator',                                                        # WordScoped -> WORD_SCOPED
LoopLabel_215 => 'RPerl::NonGenerator',                                                         # LoopLabel -> WORD_UPPERCASE  # RPerl::Operation::Statement -> LoopLabel COLON
Type_216 => 'RPerl::NonGenerator',                                                              # Type -> WORD
Type_217 => 'RPerl::NonGenerator',                                                              # Type -> WORD_SCOPED
Type_218 => 'RPerl::NonGenerator',                                                              # Type -> TYPE_INTEGER
TypeInner_219 => 'RPerl::DataType::TypeInner',                                                  # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerProperties_220 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN SubExpression
TypeInnerProperties_221 => 'RPerl::NonGenerator',                                               # TypeInnerProperties -> MY Type '$TYPED_' WORD OP02_ARRAY_THINARROW SubExpression ']' OP19_VARIABLE_ASSIGN 'undef'
TypeInnerConstant_222 => 'RPerl::NonGenerator',                                                 # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_223 => 'RPerl::Operation::Expression::SubExpression::Variable',               # VariableOrLiteral -> Variable
VariableOrLiteral_224 => 'RPerl::Operation::Expression::SubExpression::Literal',                # VariableOrLiteral -> Literal
VariableOrLiteralOrWord_225 => 'RPerl::Operation::Expression::SubExpression::Variable',         # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_226 => 'RPerl::Operation::Expression::SubExpression::Literal',          # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_227 => 'RPerl::NonGenerator',                                           # VariableOrLiteralOrWord -> WORD
VariableSymbolOrSelf_228 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> VARIABLE_SYMBOL
VariableSymbolOrSelf_229 => 'RPerl::NonGenerator',                                              # VariableSymbolOrSelf -> SELF
Literal_230 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',                  # Literal -> LITERAL_NUMBER
Literal_231 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 9181 lib/RPerl/Grammar.pm



1;
