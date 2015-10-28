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
    our $VERSION = 0.002_000;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|package|foreach|\$TYPED_|\=\ sub\ \{|undef|while|elsif|else|\@_\;|for|our|\%\{|\@\{|if|\}|\]|\;|\))}gc and return ($1, $1);

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
      /\G(sin|cos|push|pop|keys|values|sort|length|split|join|reverse|chomp|-e|-r|-f|-T|defined|exists|fakebuiltin)\s/gc and return ('OP01_NAMED', $1);
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
			'USE_RPERL' => -20,
			"package" => -20,
			'SHEBANG' => 2,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'PAREN-1' => 3,
			'ModuleHeader' => 8,
			'CompileUnit' => 9,
			'PLUS-2' => 4,
			'Critic' => 5,
			'Program' => 7,
			'OPTIONAL-9' => 6
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
			'USE_RPERL' => -7,
			"## no critic qw(" => 1
		},
		GOTOS => {
			'OPTIONAL-3' => 12,
			'Critic' => 13
		}
	},
	{#State 3
		DEFAULT => -3
	},
	{#State 4
		ACTIONS => {
			"package" => -20,
			'USE_RPERL' => -20,
			"## no critic qw(" => 1,
			'' => -5
		},
		GOTOS => {
			'OPTIONAL-9' => 6,
			'Critic' => 5,
			'ModuleHeader' => 8,
			'PAREN-1' => 14
		}
	},
	{#State 5
		DEFAULT => -19
	},
	{#State 6
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 16
		},
		GOTOS => {
			'OPTIONAL-10' => 15
		}
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"our" => -27,
			"use constant" => -27,
			"## no critic qw(" => -27,
			'USE' => -27,
			"use parent qw(" => 21
		},
		GOTOS => {
			'STAR-11' => 17,
			'Class' => 18,
			'Package' => 20,
			'Module' => 19
		}
	},
	{#State 9
		ACTIONS => {
			'' => 22
		}
	},
	{#State 10
		ACTIONS => {
			'WORD' => 23,
			")" => 24
		}
	},
	{#State 11
		DEFAULT => -39
	},
	{#State 12
		ACTIONS => {
			'USE_RPERL' => 25
		}
	},
	{#State 13
		DEFAULT => -6
	},
	{#State 14
		DEFAULT => -2
	},
	{#State 15
		ACTIONS => {
			"package" => 26
		}
	},
	{#State 16
		DEFAULT => -21
	},
	{#State 17
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"## no critic qw(" => 1,
			'USE' => -29
		},
		GOTOS => {
			'Critic' => 27,
			'STAR-12' => 28
		}
	},
	{#State 18
		DEFAULT => -25
	},
	{#State 19
		DEFAULT => -1
	},
	{#State 20
		DEFAULT => -24
	},
	{#State 21
		ACTIONS => {
			'WORD' => 29,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		DEFAULT => 0
	},
	{#State 23
		DEFAULT => -38
	},
	{#State 24
		DEFAULT => -40
	},
	{#State 25
		ACTIONS => {
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 32
		}
	},
	{#State 26
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 34
		}
	},
	{#State 27
		DEFAULT => -26
	},
	{#State 28
		ACTIONS => {
			'USE' => 36,
			"our" => -31,
			"use constant" => -31
		},
		GOTOS => {
			'Include' => 35,
			'STAR-13' => 37
		}
	},
	{#State 29
		DEFAULT => -213
	},
	{#State 30
		DEFAULT => -214
	},
	{#State 31
		ACTIONS => {
			")" => 38
		}
	},
	{#State 32
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use warnings;" => 40
		}
	},
	{#State 34
		ACTIONS => {
			";" => 41
		}
	},
	{#State 35
		DEFAULT => -28
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD' => 29
		},
		GOTOS => {
			'WordScoped' => 42
		}
	},
	{#State 37
		ACTIONS => {
			"our" => 44,
			"use constant" => 46
		},
		GOTOS => {
			'Subroutine' => 47,
			'PLUS-14' => 43,
			'Constant' => 45
		}
	},
	{#State 38
		ACTIONS => {
			";" => 48
		}
	},
	{#State 39
		ACTIONS => {
			'SELF' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'LBRACKET' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			"%{" => -11,
			'OP01_NAMED' => -11,
			'MY' => -11,
			'WORD_SCOPED' => -11,
			"use constant" => -11,
			'USE' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"undef" => -11,
			"our" => -11,
			"while" => -11,
			'OP01_PRINT' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LPAREN' => -11,
			"## no critic qw(" => 1,
			'OP01_CLOSE' => -11,
			'LITERAL_STRING' => -11,
			'WORD' => -11,
			"foreach" => -11,
			"\@{" => -11,
			'OP01_OPEN' => -11,
			"if" => -11,
			'VARIABLE_SYMBOL' => -11,
			'WORD_UPPERCASE' => -11,
			'LITERAL_NUMBER' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"for" => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED_VOID' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LBRACE' => -11,
			'OP10_NAMED_UNARY' => -11
		},
		GOTOS => {
			'Critic' => 49,
			'STAR-5' => 50
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
			"use strict;" => 33
		},
		GOTOS => {
			'Header' => 53
		}
	},
	{#State 42
		ACTIONS => {
			";" => 55,
			'OP01_QW' => 54
		}
	},
	{#State 43
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 56
		},
		GOTOS => {
			'Subroutine' => 57
		}
	},
	{#State 44
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 61
		}
	},
	{#State 45
		DEFAULT => -30
	},
	{#State 46
		ACTIONS => {
			'WORD_UPPERCASE' => 62
		}
	},
	{#State 47
		DEFAULT => -33
	},
	{#State 48
		ACTIONS => {
			'USE' => 36
		},
		GOTOS => {
			'Include' => 63
		}
	},
	{#State 49
		DEFAULT => -8
	},
	{#State 50
		ACTIONS => {
			'WORD' => -13,
			'LITERAL_STRING' => -13,
			'OP01_CLOSE' => -13,
			'LPAREN' => -13,
			'VARIABLE_SYMBOL' => -13,
			"if" => -13,
			"foreach" => -13,
			'OP01_OPEN' => -13,
			"\@{" => -13,
			'OP19_LOOP_CONTROL' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			"for" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LITERAL_NUMBER' => -13,
			'WORD_UPPERCASE' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP05_LOGICAL_NEG' => -13,
			'OP01_NAMED_VOID' => -13,
			'LBRACE' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			'LBRACKET' => -13,
			'SELF' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'MY' => -13,
			'WORD_SCOPED' => -13,
			"use constant" => -13,
			"%{" => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP01_NAMED' => -13,
			"while" => -13,
			'OP01_PRINT' => -13,
			"our" => -13,
			'OP03_MATH_INC_DEC' => -13,
			"undef" => -13,
			'USE' => 36,
			'OP05_MATH_NEG_LPAREN' => -13
		},
		GOTOS => {
			'STAR-6' => 64,
			'Include' => 65
		}
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
		DEFAULT => -23
	},
	{#State 54
		ACTIONS => {
			";" => 67
		}
	},
	{#State 55
		DEFAULT => -41
	},
	{#State 56
		ACTIONS => {
			";" => 68
		}
	},
	{#State 57
		DEFAULT => -32
	},
	{#State 58
		DEFAULT => -216
	},
	{#State 59
		DEFAULT => -218
	},
	{#State 60
		DEFAULT => -217
	},
	{#State 61
		ACTIONS => {
			'VARIABLE_SYMBOL' => 69
		}
	},
	{#State 62
		ACTIONS => {
			'OP20_HASH_FATARROW' => 70
		}
	},
	{#State 63
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 71
		}
	},
	{#State 64
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -15,
			"%{" => -15,
			'OP01_NAMED' => -15,
			'MY' => -15,
			"use constant" => 46,
			'WORD_SCOPED' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"undef" => -15,
			"our" => -15,
			'OP01_PRINT' => -15,
			"while" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'SELF' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'LBRACKET' => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			'WORD_UPPERCASE' => -15,
			'LITERAL_NUMBER' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"for" => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID' => -15,
			'LBRACE' => -15,
			'OP10_NAMED_UNARY' => -15,
			'LPAREN' => -15,
			'OP01_CLOSE' => -15,
			'LITERAL_STRING' => -15,
			'WORD' => -15,
			"foreach" => -15,
			"\@{" => -15,
			'OP01_OPEN' => -15,
			"if" => -15,
			'VARIABLE_SYMBOL' => -15
		},
		GOTOS => {
			'STAR-7' => 72,
			'Constant' => 73
		}
	},
	{#State 65
		DEFAULT => -10
	},
	{#State 66
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 74
		}
	},
	{#State 67
		DEFAULT => -42
	},
	{#State 68
		DEFAULT => -34
	},
	{#State 69
		ACTIONS => {
			"= sub {" => 75
		}
	},
	{#State 70
		ACTIONS => {
			'MY' => 77
		},
		GOTOS => {
			'TypeInnerConstant' => 76
		}
	},
	{#State 71
		ACTIONS => {
			"## no critic qw(" => 1,
			'USE' => -56,
			"our hashref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'STAR-22' => 79,
			'Critic' => 78
		}
	},
	{#State 72
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"while" => -148,
			'OP01_PRINT' => 90,
			"our" => 44,
			'OP03_MATH_INC_DEC' => 92,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'MY' => 80,
			'WORD_SCOPED' => 30,
			"%{" => 84,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP01_NAMED' => 89,
			'VARIABLE_SYMBOL' => 123,
			"if" => 124,
			"foreach" => -148,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'OP10_NAMED_UNARY' => 115,
			'OP01_NAMED_VOID' => 117,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			'OP01_NAMED_VOID_LPAREN' => 105,
			"for" => -148,
			'OP19_LOOP_CONTROL' => 106,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 110
		},
		GOTOS => {
			'Variable' => 96,
			'Operator' => 119,
			'PLUS-8' => 125,
			'SubExpression' => 102,
			'Expression' => 103,
			'VariableModification' => 99,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'VariableDeclaration' => 83,
			'Operation' => 108,
			'Subroutine' => 81,
			'Statement' => 82,
			'Conditional' => 104,
			'HashDereference' => 112,
			'HashReference' => 111,
			'OPTIONAL-37' => 87,
			'OperatorVoid' => 85,
			'LoopLabel' => 86,
			'PAREN-36' => 91,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Literal' => 93
		}
	},
	{#State 73
		DEFAULT => -12
	},
	{#State 74
		DEFAULT => -37
	},
	{#State 75
		ACTIONS => {
			'WORD_SCOPED' => -45,
			'MY' => -45,
			'OP01_NAMED' => -45,
			"%{" => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'OP03_MATH_INC_DEC' => -45,
			"while" => -45,
			'OP01_PRINT' => -45,
			"undef" => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			'LPAREN_MY' => 130,
			"}" => -45,
			'CONSTANT_CALL_SCOPED' => -45,
			'LBRACKET' => -45,
			'OP22_LOGICAL_NEG' => -45,
			'SELF' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'OP01_NAMED_VOID_LPAREN' => -45,
			'OP19_LOOP_CONTROL' => -45,
			"for" => -45,
			'LITERAL_NUMBER' => -45,
			'WORD_UPPERCASE' => -45,
			'OP10_NAMED_UNARY' => -45,
			'LBRACE' => -45,
			'OP01_NAMED_VOID' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'WORD' => -45,
			'LITERAL_STRING' => -45,
			'OP01_CLOSE' => -45,
			'LPAREN' => -45,
			'VARIABLE_SYMBOL' => -45,
			"if" => -45,
			'OP01_OPEN' => -45,
			"\@{" => -45,
			"foreach" => -45
		},
		GOTOS => {
			'OPTIONAL-17' => 132,
			'SubroutineArguments' => 131
		}
	},
	{#State 76
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			'LITERAL_STRING' => 120
		},
		GOTOS => {
			'Literal' => 133
		}
	},
	{#State 77
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 59
		},
		GOTOS => {
			'Type' => 134
		}
	},
	{#State 78
		DEFAULT => -53
	},
	{#State 79
		ACTIONS => {
			"our hashref \$properties" => -58,
			"use constant" => -58,
			'USE' => 36
		},
		GOTOS => {
			'STAR-23' => 136,
			'Include' => 135
		}
	},
	{#State 80
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60,
			'WORD' => 58,
			'TYPE_FHREF' => 137
		},
		GOTOS => {
			'Type' => 138
		}
	},
	{#State 81
		DEFAULT => -14
	},
	{#State 82
		DEFAULT => -79
	},
	{#State 83
		DEFAULT => -152
	},
	{#State 84
		ACTIONS => {
			'SELF' => 101,
			'LBRACE' => -210,
			'MY' => 141,
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'TypeInner' => 139,
			'VariableSymbolOrSelf' => 127,
			'Variable' => 142,
			'OPTIONAL-51' => 140
		}
	},
	{#State 85
		DEFAULT => -151
	},
	{#State 86
		ACTIONS => {
			'COLON' => 143
		}
	},
	{#State 87
		ACTIONS => {
			"foreach" => 146,
			"for" => 144,
			"while" => 148
		},
		GOTOS => {
			'Loop' => 147,
			'LoopWhile' => 145,
			'LoopForEach' => 150,
			'LoopFor' => 149
		}
	},
	{#State 88
		DEFAULT => -116
	},
	{#State 89
		ACTIONS => {
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'MY' => 141,
			'ARGV' => 157,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98
		},
		GOTOS => {
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154,
			'VariableSymbolOrSelf' => 127,
			'TypeInner' => 153,
			'ArrayDereference' => 126,
			'ListElement' => 151,
			'Literal' => 93,
			'SubExpression' => 155,
			'Expression' => 156,
			'ArrayReference' => 113,
			'WordScoped' => 114
		}
	},
	{#State 90
		ACTIONS => {
			'OP01_NAMED' => -111,
			'OP01_QW' => -111,
			'WORD_UPPERCASE' => -111,
			'LITERAL_NUMBER' => -111,
			"%{" => -111,
			'WORD_SCOPED' => -111,
			'ARGV' => -111,
			'MY' => -111,
			'OP05_MATH_NEG_LPAREN' => -111,
			"undef" => -111,
			'LBRACE' => -111,
			'OP05_LOGICAL_NEG' => -111,
			'OP10_NAMED_UNARY' => -111,
			'OP03_MATH_INC_DEC' => -111,
			'STDOUT_STDERR' => 161,
			'LPAREN' => -111,
			'OP01_CLOSE' => -111,
			'LITERAL_STRING' => -111,
			'WORD' => -111,
			'FHREF_SYMBOL_BRACES' => 163,
			'OP22_LOGICAL_NEG' => -111,
			'SELF' => -111,
			"\@{" => -111,
			'OP01_OPEN' => -111,
			'LBRACKET' => -111,
			'CONSTANT_CALL_SCOPED' => -111,
			'VARIABLE_SYMBOL' => -111
		},
		GOTOS => {
			'OPTIONAL-32' => 160,
			'PAREN-31' => 162
		}
	},
	{#State 91
		DEFAULT => -147
	},
	{#State 92
		ACTIONS => {
			'SELF' => 101,
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'Variable' => 164,
			'VariableSymbolOrSelf' => 127
		}
	},
	{#State 93
		DEFAULT => -134
	},
	{#State 94
		DEFAULT => -133
	},
	{#State 95
		ACTIONS => {
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119,
			'SubExpression' => 165,
			'Expression' => 156,
			'Literal' => 93,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 96
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 169,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP08_STRING_CAT' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP17_LIST_RANGE' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP19_VARIABLE_ASSIGN_BY' => 166,
			'OP06_REGEX_MATCH' => -135,
			'OP19_VARIABLE_ASSIGN' => 168,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP04_MATH_POW' => -135,
			'OP02_METHOD_THINARROW' => 167,
			'OP13_BITWISE_AND' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP18_TERNARY' => -135,
			")" => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP08_MATH_ADD_SUB' => -135
		}
	},
	{#State 97
		DEFAULT => -128
	},
	{#State 98
		ACTIONS => {
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 128,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			'OP01_NAMED' => 158,
			'OP01_QW' => 159,
			"]" => -193,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_SCOPED' => 30,
			'ARGV' => 157,
			'MY' => 141,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92
		},
		GOTOS => {
			'Literal' => 93,
			'ListElement' => 173,
			'TypeInner' => 153,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Expression' => 156,
			'SubExpression' => 171,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'ListElements' => 172,
			'HashDereference' => 112,
			'HashReference' => 111,
			'OPTIONAL-46' => 170,
			'Variable' => 154,
			'Operator' => 119
		}
	},
	{#State 99
		ACTIONS => {
			";" => 174
		}
	},
	{#State 100
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 128
		},
		GOTOS => {
			'Literal' => 93,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Expression' => 156,
			'SubExpression' => 175,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119
		}
	},
	{#State 101
		DEFAULT => -229
	},
	{#State 102
		ACTIONS => {
			'OP17_LIST_RANGE' => 176,
			'OP15_LOGICAL_AND' => 184,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP18_TERNARY' => 180,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191
		}
	},
	{#State 103
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -132,
			'OP08_STRING_CAT' => -132,
			'OP16_LOGICAL_OR' => -132,
			";" => 193,
			'OP07_STRING_REPEAT' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP04_MATH_POW' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP18_TERNARY' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP09_BITWISE_SHIFT' => -132
		}
	},
	{#State 104
		DEFAULT => -149
	},
	{#State 105
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			")" => -113,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			'OP01_QW' => 159,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 30,
			'ARGV' => 157,
			'MY' => 141
		},
		GOTOS => {
			'HashReference' => 111,
			'HashDereference' => 112,
			'OPTIONAL-33' => 195,
			'Operator' => 119,
			'Variable' => 154,
			'SubExpression' => 171,
			'Expression' => 156,
			'VariableSymbolOrSelf' => 127,
			'ListElement' => 173,
			'ArrayDereference' => 126,
			'TypeInner' => 153,
			'Literal' => 93,
			'ListElements' => 194,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 106
		ACTIONS => {
			'WORD_UPPERCASE' => 196
		},
		GOTOS => {
			'LoopLabel' => 197
		}
	},
	{#State 107
		DEFAULT => -120
	},
	{#State 108
		DEFAULT => -17
	},
	{#State 109
		DEFAULT => -230
	},
	{#State 110
		ACTIONS => {
			'COLON' => -215,
			'LPAREN' => 198
		}
	},
	{#State 111
		DEFAULT => -138
	},
	{#State 112
		DEFAULT => -139
	},
	{#State 113
		DEFAULT => -136
	},
	{#State 114
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 199,
			'LPAREN' => 200
		}
	},
	{#State 115
		ACTIONS => {
			'OP21_LIST_COMMA' => -97,
			'OP10_NAMED_UNARY' => 115,
			'OP08_STRING_CAT' => -97,
			'LBRACE' => 118,
			";" => -97,
			'OP05_LOGICAL_NEG' => 116,
			'OP17_LIST_RANGE' => -97,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP06_REGEX_MATCH' => -97,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'OP04_MATH_POW' => -97,
			'OP23_LOGICAL_AND' => -97,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP18_TERNARY' => -97,
			'OP01_CLOSE' => 121,
			'OP09_BITWISE_SHIFT' => -97,
			'LPAREN' => 122,
			'OP03_MATH_INC_DEC' => 92,
			'OP12_COMPARE_EQ_NE' => -97,
			"undef" => 94,
			'OP16_LOGICAL_OR' => -97,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP07_STRING_REPEAT' => -97,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			"%{" => 84,
			"]" => -97,
			'OP15_LOGICAL_AND' => -97,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP13_BITWISE_AND' => -97,
			'OP11_COMPARE_LT_GT' => -97,
			")" => -97,
			'OP08_MATH_ADD_SUB' => -97,
			"}" => -97
		},
		GOTOS => {
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Expression' => 156,
			'SubExpression' => 201,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111
		}
	},
	{#State 116
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 128,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120
		},
		GOTOS => {
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119,
			'Expression' => 156,
			'SubExpression' => 202,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 117
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'MY' => 141,
			'ARGV' => 157,
			'WORD_SCOPED' => 30,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 128,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122
		},
		GOTOS => {
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ListElement' => 173,
			'TypeInner' => 153,
			'ArrayDereference' => 126,
			'SubExpression' => 171,
			'Expression' => 156,
			'ArrayReference' => 113,
			'ListElements' => 203,
			'WordScoped' => 114
		}
	},
	{#State 118
		ACTIONS => {
			'WORD' => 206,
			'LITERAL_STRING' => 120,
			'VARIABLE_SYMBOL' => 123,
			'SELF' => 101,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			"}" => 208
		},
		GOTOS => {
			'HashDereference' => 207,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 210,
			'VariableOrLiteralOrWord' => 205,
			'Variable' => 209,
			'HashEntry' => 204
		}
	},
	{#State 119
		DEFAULT => -126
	},
	{#State 120
		DEFAULT => -231
	},
	{#State 121
		ACTIONS => {
			'FHREF_SYMBOL' => 211
		}
	},
	{#State 122
		ACTIONS => {
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_NAMED' => 214,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'WORD_SCOPED' => 30,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_PRINT' => 213
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'Literal' => 93,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Expression' => 156,
			'SubExpression' => 212,
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111
		}
	},
	{#State 123
		DEFAULT => -228
	},
	{#State 124
		ACTIONS => {
			'LPAREN' => 215
		}
	},
	{#State 125
		ACTIONS => {
			"foreach" => -148,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 123,
			"if" => 124,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_NAMED_VOID' => 117,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 110,
			"for" => -148,
			'OP19_LOOP_CONTROL' => 106,
			'OP01_NAMED_VOID_LPAREN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			"while" => -148,
			'OP01_PRINT' => 90,
			'OP03_MATH_INC_DEC' => 92,
			"%{" => 84,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'OP01_NAMED' => 89,
			'' => -18,
			'MY' => 80,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'VariableModification' => 99,
			'SubExpression' => 102,
			'Expression' => 103,
			'Operator' => 119,
			'Variable' => 96,
			'Literal' => 93,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'PAREN-36' => 91,
			'OPTIONAL-37' => 87,
			'LoopLabel' => 86,
			'OperatorVoid' => 85,
			'HashReference' => 111,
			'HashDereference' => 112,
			'Conditional' => 104,
			'Statement' => 82,
			'Operation' => 216,
			'VariableDeclaration' => 83
		}
	},
	{#State 126
		DEFAULT => -137
	},
	{#State 127
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 217
		}
	},
	{#State 128
		ACTIONS => {
			'MY' => 218
		}
	},
	{#State 129
		ACTIONS => {
			'VARIABLE_SYMBOL' => 123,
			'MY' => 141,
			'LBRACKET' => -196,
			'SELF' => 101
		},
		GOTOS => {
			'OPTIONAL-47' => 221,
			'TypeInner' => 219,
			'VariableSymbolOrSelf' => 127,
			'Variable' => 220
		}
	},
	{#State 130
		ACTIONS => {
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 59,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 222
		}
	},
	{#State 131
		DEFAULT => -44
	},
	{#State 132
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 223
		}
	},
	{#State 133
		ACTIONS => {
			";" => 224
		}
	},
	{#State 134
		ACTIONS => {
			"\$TYPED_" => 225
		}
	},
	{#State 135
		DEFAULT => -55
	},
	{#State 136
		ACTIONS => {
			"use constant" => 46,
			"our hashref \$properties" => 226
		},
		GOTOS => {
			'Properties' => 227,
			'Constant' => 228
		}
	},
	{#State 137
		ACTIONS => {
			'FHREF_SYMBOL' => 229
		}
	},
	{#State 138
		ACTIONS => {
			'VARIABLE_SYMBOL' => 230
		}
	},
	{#State 139
		DEFAULT => -209
	},
	{#State 140
		ACTIONS => {
			'LBRACE' => 118
		},
		GOTOS => {
			'HashReference' => 231
		}
	},
	{#State 141
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 232
		}
	},
	{#State 142
		ACTIONS => {
			"}" => 233
		}
	},
	{#State 143
		DEFAULT => -146
	},
	{#State 144
		ACTIONS => {
			'MY' => 235,
			'LPAREN_MY' => 234
		}
	},
	{#State 145
		DEFAULT => -163
	},
	{#State 146
		ACTIONS => {
			'MY' => 236
		}
	},
	{#State 147
		DEFAULT => -150
	},
	{#State 148
		ACTIONS => {
			'LPAREN' => 237,
			'LPAREN_MY' => 238
		}
	},
	{#State 149
		DEFAULT => -161
	},
	{#State 150
		DEFAULT => -162
	},
	{#State 151
		ACTIONS => {
			'OP21_LIST_COMMA' => 239
		}
	},
	{#State 152
		ACTIONS => {
			'LPAREN' => 198
		}
	},
	{#State 153
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'SubExpression' => 240,
			'Expression' => 156,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 154
		ACTIONS => {
			"}" => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			")" => -135,
			'OP18_TERNARY' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP04_MATH_POW' => -135,
			'OP02_METHOD_THINARROW' => 167,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP15_LOGICAL_AND' => -135,
			"]" => -135,
			'OP17_LIST_RANGE' => -135,
			'OP07_STRING_REPEAT' => -135,
			";" => -135,
			'OP08_STRING_CAT' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP21_LIST_COMMA' => -135,
			'OP03_MATH_INC_DEC' => 169
		}
	},
	{#State 155
		ACTIONS => {
			'OP04_MATH_POW' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			")" => -81,
			'OP18_TERNARY' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP08_STRING_CAT' => -81,
			";" => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP21_LIST_COMMA' => -188,
			'OP15_LOGICAL_AND' => -81,
			'OP17_LIST_RANGE' => -81
		}
	},
	{#State 156
		DEFAULT => -132
	},
	{#State 157
		DEFAULT => -191
	},
	{#State 158
		ACTIONS => {
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'SELF' => 101,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 128,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 158,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Expression' => 156,
			'SubExpression' => 241,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93
		}
	},
	{#State 159
		DEFAULT => -190
	},
	{#State 160
		ACTIONS => {
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 30,
			'ARGV' => 157,
			'MY' => 141,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			'OP01_QW' => 159,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			'SELF' => 101,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 128,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121
		},
		GOTOS => {
			'ListElements' => 242,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 171,
			'Expression' => 156,
			'Literal' => 93,
			'ArrayDereference' => 126,
			'TypeInner' => 153,
			'ListElement' => 173,
			'VariableSymbolOrSelf' => 127,
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111
		}
	},
	{#State 161
		DEFAULT => -109
	},
	{#State 162
		DEFAULT => -110
	},
	{#State 163
		ACTIONS => {
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'MY' => 141,
			'ARGV' => 157,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'ListElements' => 243,
			'ArrayDereference' => 126,
			'ListElement' => 173,
			'VariableSymbolOrSelf' => 127,
			'TypeInner' => 153,
			'Literal' => 93,
			'Expression' => 156,
			'SubExpression' => 171,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 164
		DEFAULT => -85
	},
	{#State 165
		ACTIONS => {
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP18_TERNARY' => 180,
			")" => 244,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 166
		ACTIONS => {
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 128,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'SubExpression' => 245,
			'Expression' => 156,
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111
		}
	},
	{#State 167
		ACTIONS => {
			'LPAREN' => 246
		}
	},
	{#State 168
		ACTIONS => {
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 30,
			'FHREF_SYMBOL_IN' => 247,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'STDIN' => 248,
			'VARIABLE_SYMBOL' => 123,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Expression' => 156,
			'SubExpression' => 250,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'SubExpressionOrInput' => 249
		}
	},
	{#State 169
		DEFAULT => -86
	},
	{#State 170
		ACTIONS => {
			"]" => 251
		}
	},
	{#State 171
		ACTIONS => {
			";" => -188,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -188,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 184,
			"]" => -188,
			'OP17_LIST_RANGE' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP18_TERNARY' => 180,
			")" => -188,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178
		}
	},
	{#State 172
		DEFAULT => -192
	},
	{#State 173
		DEFAULT => -186,
		GOTOS => {
			'STAR-45' => 252
		}
	},
	{#State 174
		DEFAULT => -153
	},
	{#State 175
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			")" => -106,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP11_COMPARE_LT_GT' => 190,
			"}" => -106,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => -106,
			";" => -106,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -106,
			'OP12_COMPARE_EQ_NE' => 185,
			"]" => -106,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176
		}
	},
	{#State 176
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29
		},
		GOTOS => {
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154,
			'Expression' => 156,
			'SubExpression' => 253,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 177
		ACTIONS => {
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'WORD_SCOPED' => 30,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95
		},
		GOTOS => {
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Expression' => 156,
			'SubExpression' => 254,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 178
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'SELF' => 101,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'Expression' => 156,
			'SubExpression' => 255,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 179
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'WORD_SCOPED' => 30,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'SELF' => 101,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122
		},
		GOTOS => {
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119,
			'SubExpression' => 256,
			'Expression' => 156,
			'Literal' => 93,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 180
		ACTIONS => {
			'VARIABLE_SYMBOL' => 123,
			'LITERAL_STRING' => 120,
			'LITERAL_NUMBER' => 109,
			'SELF' => 101
		},
		GOTOS => {
			'VariableOrLiteral' => 258,
			'Variable' => 257,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 259
		}
	},
	{#State 181
		ACTIONS => {
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_NAMED' => 158,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'SubExpression' => 260,
			'Expression' => 156,
			'Literal' => 93,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119
		}
	},
	{#State 182
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 261
		}
	},
	{#State 183
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'SELF' => 101
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93,
			'SubExpression' => 262,
			'Expression' => 156
		}
	},
	{#State 184
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120
		},
		GOTOS => {
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 263,
			'Expression' => 156,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111
		}
	},
	{#State 185
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152
		},
		GOTOS => {
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'SubExpression' => 264,
			'Expression' => 156,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119
		}
	},
	{#State 186
		ACTIONS => {
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 265,
			'Expression' => 156,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93
		}
	},
	{#State 187
		ACTIONS => {
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 128,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 266,
			'Expression' => 156,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93
		}
	},
	{#State 188
		ACTIONS => {
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 128,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'Expression' => 156,
			'SubExpression' => 267,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154
		}
	},
	{#State 189
		ACTIONS => {
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			'SELF' => 101,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 128,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'Expression' => 156,
			'SubExpression' => 268,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154
		}
	},
	{#State 190
		ACTIONS => {
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 128,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 30,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93,
			'SubExpression' => 269,
			'Expression' => 156,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 191
		ACTIONS => {
			'OP01_NAMED' => 158,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'WORD_SCOPED' => 30,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'Literal' => 93,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'SubExpression' => 270,
			'Expression' => 156,
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111
		}
	},
	{#State 192
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 271,
			'Expression' => 156,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93
		}
	},
	{#State 193
		DEFAULT => -78
	},
	{#State 194
		DEFAULT => -112
	},
	{#State 195
		ACTIONS => {
			")" => 272
		}
	},
	{#State 196
		DEFAULT => -215
	},
	{#State 197
		ACTIONS => {
			";" => 273
		}
	},
	{#State 198
		ACTIONS => {
			")" => 274
		}
	},
	{#State 199
		ACTIONS => {
			")" => 275
		}
	},
	{#State 200
		ACTIONS => {
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 128,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			")" => -123,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158,
			'MY' => 141,
			'WORD_SCOPED' => 30,
			'ARGV' => 157
		},
		GOTOS => {
			'HashDereference' => 112,
			'OPTIONAL-34' => 277,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119,
			'SubExpression' => 171,
			'Expression' => 156,
			'Literal' => 93,
			'TypeInner' => 153,
			'VariableSymbolOrSelf' => 127,
			'ListElement' => 173,
			'ArrayDereference' => 126,
			'ListElements' => 276,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 201
		ACTIONS => {
			'OP15_LOGICAL_AND' => -96,
			"]" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => -96,
			";" => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP21_LIST_COMMA' => -96,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			"}" => -96,
			'OP11_COMPARE_LT_GT' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			")" => -96,
			'OP18_TERNARY' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 202
		ACTIONS => {
			'OP06_REGEX_MATCH' => -88,
			'OP07_MATH_MULT_DIV_MOD' => -88,
			'OP14_BITWISE_OR_XOR' => -88,
			'OP04_MATH_POW' => 183,
			'OP23_LOGICAL_AND' => -88,
			'OP13_BITWISE_AND' => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			")" => -88,
			'OP18_TERNARY' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			"}" => -88,
			'OP21_LIST_COMMA' => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			'OP08_STRING_CAT' => -88,
			'OP16_LOGICAL_OR' => -88,
			";" => -88,
			'OP07_STRING_REPEAT' => -88,
			'OP17_LIST_RANGE' => -88,
			'OP15_LOGICAL_AND' => -88,
			"]" => -88
		}
	},
	{#State 203
		ACTIONS => {
			";" => 278
		}
	},
	{#State 204
		DEFAULT => -206,
		GOTOS => {
			'STAR-50' => 279
		}
	},
	{#State 205
		ACTIONS => {
			'OP20_HASH_FATARROW' => 280
		}
	},
	{#State 206
		DEFAULT => -227
	},
	{#State 207
		DEFAULT => -202
	},
	{#State 208
		DEFAULT => -208
	},
	{#State 209
		DEFAULT => -225
	},
	{#State 210
		DEFAULT => -226
	},
	{#State 211
		DEFAULT => -84
	},
	{#State 212
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			")" => 281,
			'OP18_TERNARY' => 180,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 185
		}
	},
	{#State 213
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 282
		}
	},
	{#State 214
		ACTIONS => {
			'OP01_OPEN' => 128,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_NAMED' => 158,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'ARGV' => 157,
			'WORD_SCOPED' => 30,
			'MY' => 141
		},
		GOTOS => {
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 155,
			'Expression' => 156,
			'Literal' => 93,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'TypeInner' => 153,
			'ListElement' => 283,
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111
		}
	},
	{#State 215
		ACTIONS => {
			'OP01_NAMED' => 158,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'WORD_SCOPED' => 30,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'Expression' => 156,
			'SubExpression' => 284
		}
	},
	{#State 216
		DEFAULT => -16
	},
	{#State 217
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => -174,
			'OP02_HASH_THINARROW' => 286,
			'OP03_MATH_INC_DEC' => -174,
			'OP21_LIST_COMMA' => -174,
			'OP07_STRING_REPEAT' => -174,
			'OP08_STRING_CAT' => -174,
			'OP16_LOGICAL_OR' => -174,
			";" => -174,
			'OP17_LIST_RANGE' => -174,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			"]" => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			'OP06_REGEX_MATCH' => -174,
			'OP02_METHOD_THINARROW' => -174,
			'OP02_ARRAY_THINARROW' => 285,
			'OP04_MATH_POW' => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			'OP23_LOGICAL_AND' => -174,
			'OP13_BITWISE_AND' => -174,
			'OP08_MATH_ADD_SUB' => -174,
			'OP09_BITWISE_SHIFT' => -174,
			"}" => -174,
			'OP20_HASH_FATARROW' => -174,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP11_COMPARE_LT_GT' => -174,
			'COLON' => -174,
			'OP18_TERNARY' => -174,
			")" => -174
		},
		GOTOS => {
			'VariableRetrieval' => 287
		}
	},
	{#State 218
		ACTIONS => {
			'TYPE_FHREF' => 288
		}
	},
	{#State 219
		DEFAULT => -195
	},
	{#State 220
		ACTIONS => {
			"}" => 289
		}
	},
	{#State 221
		ACTIONS => {
			'LBRACKET' => 98
		},
		GOTOS => {
			'ArrayReference' => 290
		}
	},
	{#State 222
		ACTIONS => {
			'VARIABLE_SYMBOL' => 291
		}
	},
	{#State 223
		ACTIONS => {
			"while" => -148,
			'OP01_PRINT' => 90,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'MY' => 80,
			'WORD_SCOPED' => 30,
			'OP01_NAMED_VOID_SCOLON' => 88,
			"%{" => 84,
			'OP01_NAMED' => 89,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"}" => 292,
			'OP10_NAMED_UNARY' => 115,
			'OP05_LOGICAL_NEG' => 116,
			'OP01_NAMED_VOID' => 117,
			'LBRACE' => 118,
			'OP19_LOOP_CONTROL' => 106,
			"for" => -148,
			'OP01_NAMED_VOID_LPAREN' => 105,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'WORD_UPPERCASE' => 110,
			'LITERAL_NUMBER' => 109,
			"if" => 124,
			'VARIABLE_SYMBOL' => 123,
			"foreach" => -148,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121
		},
		GOTOS => {
			'Variable' => 96,
			'Operator' => 119,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'SubExpression' => 102,
			'Expression' => 103,
			'VariableModification' => 99,
			'OPTIONAL-37' => 87,
			'LoopLabel' => 86,
			'OperatorVoid' => 85,
			'HashDereference' => 112,
			'HashReference' => 111,
			'Statement' => 82,
			'Conditional' => 104,
			'VariableDeclaration' => 83,
			'Operation' => 293,
			'Literal' => 93,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'PAREN-36' => 91
		}
	},
	{#State 224
		DEFAULT => -43
	},
	{#State 225
		ACTIONS => {
			'WORD_UPPERCASE' => 294
		}
	},
	{#State 226
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 295
		}
	},
	{#State 227
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 296
		}
	},
	{#State 228
		DEFAULT => -57
	},
	{#State 229
		ACTIONS => {
			";" => 297
		}
	},
	{#State 230
		ACTIONS => {
			";" => 300,
			'OP02_ARRAY_THINARROW' => 298,
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 231
		ACTIONS => {
			"}" => 301
		}
	},
	{#State 232
		ACTIONS => {
			"\$TYPED_" => 302
		}
	},
	{#State 233
		DEFAULT => -211
	},
	{#State 234
		ACTIONS => {
			'TYPE_INTEGER' => 303
		}
	},
	{#State 235
		ACTIONS => {
			'TYPE_INTEGER' => 304
		}
	},
	{#State 236
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 59
		},
		GOTOS => {
			'Type' => 305
		}
	},
	{#State 237
		ACTIONS => {
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_NAMED' => 158,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'WORD_SCOPED' => 30,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Expression' => 156,
			'SubExpression' => 306,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 238
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 307
		}
	},
	{#State 239
		ACTIONS => {
			'ARGV' => 157,
			'WORD_SCOPED' => 30,
			'MY' => 141,
			'OP01_NAMED' => 158,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129
		},
		GOTOS => {
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111,
			'WordScoped' => 114,
			'ListElements' => 308,
			'ArrayReference' => 113,
			'Expression' => 156,
			'SubExpression' => 171,
			'Literal' => 93,
			'TypeInner' => 153,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'ListElement' => 173
		}
	},
	{#State 240
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -189,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			";" => -189,
			'OP17_LIST_RANGE' => 176,
			"]" => -189,
			'OP15_LOGICAL_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			")" => -189,
			'OP18_TERNARY' => 180
		}
	},
	{#State 241
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP04_MATH_POW' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			")" => -81,
			'OP18_TERNARY' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			"}" => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP08_STRING_CAT' => -81,
			";" => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP21_LIST_COMMA' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			"]" => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP17_LIST_RANGE' => -81
		}
	},
	{#State 242
		ACTIONS => {
			";" => 309
		}
	},
	{#State 243
		ACTIONS => {
			";" => 310
		}
	},
	{#State 244
		DEFAULT => -89
	},
	{#State 245
		ACTIONS => {
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			")" => -183,
			'OP18_TERNARY' => 180,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			";" => -183,
			'OP17_LIST_RANGE' => 176,
			'OP15_LOGICAL_AND' => 184
		}
	},
	{#State 246
		ACTIONS => {
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'SELF' => 101,
			'OP01_OPEN' => 128,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			")" => -125,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'MY' => 141,
			'WORD_SCOPED' => 30,
			'ARGV' => 157,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158
		},
		GOTOS => {
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'OPTIONAL-35' => 312,
			'Operator' => 119,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'TypeInner' => 153,
			'ListElement' => 173,
			'ArrayDereference' => 126,
			'Expression' => 156,
			'SubExpression' => 171,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'ListElements' => 311
		}
	},
	{#State 247
		DEFAULT => -142
	},
	{#State 248
		DEFAULT => -143
	},
	{#State 249
		DEFAULT => -182
	},
	{#State 250
		ACTIONS => {
			'OP17_LIST_RANGE' => 176,
			'OP15_LOGICAL_AND' => 184,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP07_STRING_REPEAT' => 186,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			";" => -141,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			")" => -141,
			'OP18_TERNARY' => 180,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191
		}
	},
	{#State 251
		DEFAULT => -194
	},
	{#State 252
		ACTIONS => {
			'OP21_LIST_COMMA' => 314,
			"]" => -187,
			";" => -187,
			")" => -187
		},
		GOTOS => {
			'PAREN-44' => 313
		}
	},
	{#State 253
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP18_TERNARY' => -104,
			")" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP11_COMPARE_LT_GT' => 190,
			"}" => -104,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => -104,
			";" => -104,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -104,
			'OP12_COMPARE_EQ_NE' => 185,
			"]" => -104,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => undef
		}
	},
	{#State 254
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP11_COMPARE_LT_GT' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP18_TERNARY' => -94,
			")" => -94,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => -94,
			"}" => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP13_BITWISE_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP08_STRING_CAT' => -94,
			";" => -94,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			"]" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP17_LIST_RANGE' => -94
		}
	},
	{#State 255
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			"}" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP11_COMPARE_LT_GT' => 190,
			'OP18_TERNARY' => 180,
			")" => -107,
			'OP23_LOGICAL_AND' => -107,
			'OP13_BITWISE_AND' => 188,
			'OP04_MATH_POW' => 183,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP06_REGEX_MATCH' => 182,
			'OP15_LOGICAL_AND' => 184,
			"]" => -107,
			'OP17_LIST_RANGE' => 176,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			";" => -107,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -107
		}
	},
	{#State 256
		ACTIONS => {
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => -95,
			";" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP21_LIST_COMMA' => -95,
			'OP15_LOGICAL_AND' => -95,
			"]" => -95,
			'OP17_LIST_RANGE' => -95,
			'OP04_MATH_POW' => 183,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP06_REGEX_MATCH' => 182,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => -95,
			"}" => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP18_TERNARY' => -95,
			")" => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP13_BITWISE_AND' => -95
		}
	},
	{#State 257
		DEFAULT => -223
	},
	{#State 258
		ACTIONS => {
			'COLON' => 315
		}
	},
	{#State 259
		DEFAULT => -224
	},
	{#State 260
		ACTIONS => {
			'OP17_LIST_RANGE' => 176,
			'OP15_LOGICAL_AND' => 184,
			"]" => -108,
			'OP21_LIST_COMMA' => -108,
			'OP12_COMPARE_EQ_NE' => 185,
			";" => -108,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178,
			'OP18_TERNARY' => 180,
			")" => -108,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => -108,
			"}" => -108,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP06_REGEX_MATCH' => 182,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183
		}
	},
	{#State 261
		DEFAULT => -90
	},
	{#State 262
		ACTIONS => {
			"]" => -87,
			'OP15_LOGICAL_AND' => -87,
			'OP17_LIST_RANGE' => -87,
			";" => -87,
			'OP08_STRING_CAT' => -87,
			'OP16_LOGICAL_OR' => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP21_LIST_COMMA' => -87,
			'OP12_COMPARE_EQ_NE' => -87,
			'OP18_TERNARY' => -87,
			")" => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP11_COMPARE_LT_GT' => -87,
			"}" => -87,
			'OP08_MATH_ADD_SUB' => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP13_BITWISE_AND' => -87,
			'OP23_LOGICAL_AND' => -87,
			'OP07_MATH_MULT_DIV_MOD' => -87,
			'OP14_BITWISE_OR_XOR' => -87,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => -87
		}
	},
	{#State 263
		ACTIONS => {
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP23_LOGICAL_AND' => -102,
			'OP13_BITWISE_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			"}" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => 190,
			")" => -102,
			'OP18_TERNARY' => -102,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -102,
			'OP07_STRING_REPEAT' => 186,
			'OP16_LOGICAL_OR' => -102,
			'OP08_STRING_CAT' => 177,
			";" => -102,
			'OP17_LIST_RANGE' => -102,
			"]" => -102,
			'OP15_LOGICAL_AND' => -102
		}
	},
	{#State 264
		ACTIONS => {
			'OP13_BITWISE_AND' => -99,
			'OP23_LOGICAL_AND' => -99,
			"}" => -99,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			")" => -99,
			'OP18_TERNARY' => -99,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP17_LIST_RANGE' => -99,
			"]" => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP21_LIST_COMMA' => -99,
			'OP07_STRING_REPEAT' => 186,
			";" => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP08_STRING_CAT' => 177
		}
	},
	{#State 265
		ACTIONS => {
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			"}" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP18_TERNARY' => -91,
			")" => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP08_STRING_CAT' => -91,
			'OP16_LOGICAL_OR' => -91,
			";" => -91,
			'OP17_LIST_RANGE' => -91,
			"]" => -91,
			'OP15_LOGICAL_AND' => -91
		}
	},
	{#State 266
		ACTIONS => {
			'OP15_LOGICAL_AND' => 184,
			"]" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP07_STRING_REPEAT' => 186,
			'OP16_LOGICAL_OR' => -103,
			'OP08_STRING_CAT' => 177,
			";" => -103,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -103,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			"}" => -103,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP11_COMPARE_LT_GT' => 190,
			'OP18_TERNARY' => -103,
			")" => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP13_BITWISE_AND' => 188,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 267
		ACTIONS => {
			"]" => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP17_LIST_RANGE' => -100,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => -100,
			";" => -100,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -100,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP11_COMPARE_LT_GT' => 190,
			'OP18_TERNARY' => -100,
			")" => -100,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			"}" => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => -100,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 268
		ACTIONS => {
			"]" => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP08_STRING_CAT' => -93,
			'OP16_LOGICAL_OR' => -93,
			";" => -93,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			")" => -93,
			'OP18_TERNARY' => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			"}" => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 269
		ACTIONS => {
			'OP07_STRING_REPEAT' => 186,
			'OP16_LOGICAL_OR' => -98,
			'OP08_STRING_CAT' => 177,
			";" => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP15_LOGICAL_AND' => -98,
			"]" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP06_REGEX_MATCH' => 182,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			"}" => -98,
			'OP11_COMPARE_LT_GT' => undef,
			'OP24_LOGICAL_OR_XOR' => -98,
			")" => -98,
			'OP18_TERNARY' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP13_BITWISE_AND' => -98
		}
	},
	{#State 270
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			")" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			"]" => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP17_LIST_RANGE' => -92,
			'OP08_STRING_CAT' => -92,
			'OP16_LOGICAL_OR' => -92,
			";" => -92,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -92,
			'OP12_COMPARE_EQ_NE' => -92
		}
	},
	{#State 271
		ACTIONS => {
			'OP15_LOGICAL_AND' => -101,
			"]" => -101,
			'OP17_LIST_RANGE' => -101,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => -101,
			";" => -101,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -101,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			"}" => -101,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP18_TERNARY' => -101,
			")" => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP13_BITWISE_AND' => 188,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 272
		ACTIONS => {
			";" => 316
		}
	},
	{#State 273
		DEFAULT => -121
	},
	{#State 274
		DEFAULT => -127
	},
	{#State 275
		DEFAULT => -131
	},
	{#State 276
		DEFAULT => -122
	},
	{#State 277
		ACTIONS => {
			")" => 317
		}
	},
	{#State 278
		DEFAULT => -118
	},
	{#State 279
		ACTIONS => {
			'OP21_LIST_COMMA' => 320,
			"}" => 318
		},
		GOTOS => {
			'PAREN-49' => 319
		}
	},
	{#State 280
		ACTIONS => {
			'OP10_NAMED_UNARY' => -200,
			'OP03_MATH_INC_DEC' => -200,
			'OP05_MATH_NEG_LPAREN' => -200,
			'LBRACE' => -200,
			"undef" => -200,
			'OP05_LOGICAL_NEG' => -200,
			'WORD_SCOPED' => -200,
			'MY' => 141,
			'OP01_NAMED' => -200,
			'WORD_UPPERCASE' => -200,
			"%{" => -200,
			'LITERAL_NUMBER' => -200,
			'LBRACKET' => -200,
			'CONSTANT_CALL_SCOPED' => -200,
			'VARIABLE_SYMBOL' => -200,
			'OP22_LOGICAL_NEG' => -200,
			'SELF' => -200,
			"\@{" => -200,
			'OP01_OPEN' => -200,
			'LITERAL_STRING' => -200,
			'WORD' => -200,
			'LPAREN' => -200,
			'OP01_CLOSE' => -200
		},
		GOTOS => {
			'TypeInner' => 322,
			'OPTIONAL-48' => 321
		}
	},
	{#State 281
		DEFAULT => -140
	},
	{#State 282
		ACTIONS => {
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'MY' => 141,
			'ARGV' => 157,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115
		},
		GOTOS => {
			'ArrayReference' => 113,
			'ListElements' => 323,
			'WordScoped' => 114,
			'TypeInner' => 153,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'ListElement' => 173,
			'Literal' => 93,
			'Expression' => 156,
			'SubExpression' => 171,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 283
		ACTIONS => {
			'OP21_LIST_COMMA' => 324
		}
	},
	{#State 284
		ACTIONS => {
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP18_TERNARY' => 180,
			")" => 325,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188
		}
	},
	{#State 285
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Expression' => 156,
			'SubExpression' => 326,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93
		}
	},
	{#State 286
		ACTIONS => {
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			'LITERAL_STRING' => 120,
			'WORD' => 327,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 158
		},
		GOTOS => {
			'Expression' => 156,
			'SubExpression' => 328,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154
		}
	},
	{#State 287
		DEFAULT => -172
	},
	{#State 288
		ACTIONS => {
			'FHREF_SYMBOL' => 329
		}
	},
	{#State 289
		DEFAULT => -197
	},
	{#State 290
		ACTIONS => {
			"}" => 330
		}
	},
	{#State 291
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 331
		}
	},
	{#State 292
		ACTIONS => {
			";" => 332
		}
	},
	{#State 293
		DEFAULT => -46
	},
	{#State 294
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 333
		}
	},
	{#State 295
		ACTIONS => {
			'LBRACE' => 334
		}
	},
	{#State 296
		ACTIONS => {
			'LITERAL_NUMBER' => 337,
			"our" => 336
		},
		GOTOS => {
			'Method' => 339,
			'Subroutine' => 335,
			'MethodOrSubroutine' => 338
		}
	},
	{#State 297
		DEFAULT => -181
	},
	{#State 298
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 116,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			'OP01_OPEN' => 128,
			'SELF' => 101,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'Expression' => 156,
			'SubExpression' => 340,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 299
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'FHREF_SYMBOL_IN' => 247,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'STDIN' => 248,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 128
		},
		GOTOS => {
			'SubExpression' => 250,
			'Expression' => 156,
			'SubExpressionOrInput' => 341,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119
		}
	},
	{#State 300
		DEFAULT => -178
	},
	{#State 301
		DEFAULT => -212
	},
	{#State 302
		ACTIONS => {
			'WORD' => 342
		}
	},
	{#State 303
		ACTIONS => {
			'VARIABLE_SYMBOL' => 343
		}
	},
	{#State 304
		ACTIONS => {
			'VARIABLE_SYMBOL' => 344
		}
	},
	{#State 305
		ACTIONS => {
			'VARIABLE_SYMBOL' => 345
		}
	},
	{#State 306
		ACTIONS => {
			'OP04_MATH_POW' => 183,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP06_REGEX_MATCH' => 182,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP18_TERNARY' => 180,
			")" => 346,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176
		}
	},
	{#State 307
		ACTIONS => {
			'VARIABLE_SYMBOL' => 347
		}
	},
	{#State 308
		ACTIONS => {
			";" => 348
		}
	},
	{#State 309
		DEFAULT => -114
	},
	{#State 310
		DEFAULT => -115
	},
	{#State 311
		DEFAULT => -124
	},
	{#State 312
		ACTIONS => {
			")" => 349
		}
	},
	{#State 313
		DEFAULT => -185
	},
	{#State 314
		ACTIONS => {
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'ARGV' => 157,
			'WORD_SCOPED' => 30,
			'MY' => 141,
			'OP01_NAMED' => 158,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP01_QW' => 159,
			'WORD_UPPERCASE' => 152,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116
		},
		GOTOS => {
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119,
			'Expression' => 156,
			'SubExpression' => 171,
			'Literal' => 93,
			'TypeInner' => 153,
			'ListElement' => 350,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 315
		ACTIONS => {
			'LITERAL_STRING' => 120,
			'VARIABLE_SYMBOL' => 123,
			'SELF' => 101,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 127,
			'Literal' => 259,
			'VariableOrLiteral' => 351,
			'Variable' => 257
		}
	},
	{#State 316
		DEFAULT => -117
	},
	{#State 317
		DEFAULT => -129
	},
	{#State 318
		DEFAULT => -207
	},
	{#State 319
		DEFAULT => -205
	},
	{#State 320
		ACTIONS => {
			'WORD' => 206,
			'LITERAL_STRING' => 120,
			'VARIABLE_SYMBOL' => 123,
			'SELF' => 101,
			"%{" => 84,
			'LITERAL_NUMBER' => 109
		},
		GOTOS => {
			'HashDereference' => 207,
			'Literal' => 210,
			'VariableSymbolOrSelf' => 127,
			'HashEntry' => 352,
			'Variable' => 209,
			'VariableOrLiteralOrWord' => 205
		}
	},
	{#State 321
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP01_NAMED' => 158,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 128
		},
		GOTOS => {
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 353,
			'Expression' => 156,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126
		}
	},
	{#State 322
		DEFAULT => -199
	},
	{#State 323
		ACTIONS => {
			")" => 354
		}
	},
	{#State 324
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'SELF' => 101,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'ARGV' => 157,
			'WORD_SCOPED' => 30,
			'MY' => 141,
			'OP01_NAMED' => 158,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'OP01_QW' => 159
		},
		GOTOS => {
			'Variable' => 154,
			'Operator' => 119,
			'HashDereference' => 112,
			'HashReference' => 111,
			'WordScoped' => 114,
			'ListElements' => 355,
			'ArrayReference' => 113,
			'SubExpression' => 171,
			'Expression' => 156,
			'Literal' => 93,
			'ListElement' => 173,
			'TypeInner' => 153,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127
		}
	},
	{#State 325
		ACTIONS => {
			'LBRACE' => 356
		},
		GOTOS => {
			'CodeBlock' => 357
		}
	},
	{#State 326
		ACTIONS => {
			"]" => 358,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 327
		ACTIONS => {
			'LPAREN' => -213,
			"}" => 359,
			'OP02_METHOD_THINARROW_NEW' => -213
		}
	},
	{#State 328
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 185,
			'OP07_STRING_REPEAT' => 186,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP17_LIST_RANGE' => 176,
			'OP15_LOGICAL_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178,
			"}" => 360,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP18_TERNARY' => 180,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181
		}
	},
	{#State 329
		ACTIONS => {
			'OP21_LIST_COMMA' => 361
		}
	},
	{#State 330
		DEFAULT => -198
	},
	{#State 331
		ACTIONS => {
			'OP21_LIST_COMMA' => 362,
			")" => 363
		},
		GOTOS => {
			'PAREN-19' => 364
		}
	},
	{#State 332
		DEFAULT => -48
	},
	{#State 333
		DEFAULT => -222
	},
	{#State 334
		ACTIONS => {
			'WORD' => 366,
			"}" => 365
		},
		GOTOS => {
			'HashEntryProperties' => 367
		}
	},
	{#State 335
		DEFAULT => -77
	},
	{#State 336
		ACTIONS => {
			'WORD' => 58,
			'WORD_SCOPED' => 60,
			'TYPE_INTEGER' => 59,
			'TYPE_METHOD' => 368
		},
		GOTOS => {
			'Type' => 61
		}
	},
	{#State 337
		ACTIONS => {
			";" => 369
		}
	},
	{#State 338
		DEFAULT => -59
	},
	{#State 339
		DEFAULT => -76
	},
	{#State 340
		ACTIONS => {
			'OP17_LIST_RANGE' => 176,
			"]" => 370,
			'OP15_LOGICAL_AND' => 184,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP07_STRING_REPEAT' => 186,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			'OP18_TERNARY' => 180,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191
		}
	},
	{#State 341
		ACTIONS => {
			";" => 371
		}
	},
	{#State 342
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 372
		}
	},
	{#State 343
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 373
		}
	},
	{#State 344
		ACTIONS => {
			'LPAREN' => 374
		}
	},
	{#State 345
		ACTIONS => {
			'LPAREN' => 375
		}
	},
	{#State 346
		ACTIONS => {
			'LBRACE' => 356
		},
		GOTOS => {
			'CodeBlock' => 376
		}
	},
	{#State 347
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 348
		DEFAULT => -119
	},
	{#State 349
		DEFAULT => -130
	},
	{#State 350
		DEFAULT => -184
	},
	{#State 351
		DEFAULT => -105
	},
	{#State 352
		DEFAULT => -204
	},
	{#State 353
		ACTIONS => {
			'OP21_LIST_COMMA' => -201,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 186,
			'OP17_LIST_RANGE' => 176,
			'OP15_LOGICAL_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178,
			'OP18_TERNARY' => 180,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			"}" => -201,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189
		}
	},
	{#State 354
		DEFAULT => -80
	},
	{#State 355
		ACTIONS => {
			")" => 378
		}
	},
	{#State 356
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			"while" => -148,
			'OP01_PRINT' => 90,
			'OP03_MATH_INC_DEC' => 92,
			'OP01_NAMED_VOID_SCOLON' => 88,
			"%{" => 84,
			'OP01_NAMED' => 89,
			'MY' => 80,
			'WORD_SCOPED' => 30,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'OP01_NAMED_VOID' => 117,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			'OP10_NAMED_UNARY' => 115,
			'WORD_UPPERCASE' => 110,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED_VOID_LPAREN' => 105,
			'OP19_LOOP_CONTROL' => 106,
			"for" => -148,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			"foreach" => -148,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			"if" => 124,
			'VARIABLE_SYMBOL' => 123,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 96,
			'VariableModification' => 99,
			'SubExpression' => 102,
			'Expression' => 103,
			'PLUS-42' => 379,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Operation' => 380,
			'VariableDeclaration' => 83,
			'Conditional' => 104,
			'Statement' => 82,
			'HashReference' => 111,
			'HashDereference' => 112,
			'OPTIONAL-37' => 87,
			'LoopLabel' => 86,
			'OperatorVoid' => 85,
			'WordScoped' => 114,
			'PAREN-36' => 91,
			'ArrayReference' => 113,
			'Literal' => 93
		}
	},
	{#State 357
		DEFAULT => -156,
		GOTOS => {
			'STAR-39' => 381
		}
	},
	{#State 358
		DEFAULT => -175
	},
	{#State 359
		DEFAULT => -177
	},
	{#State 360
		DEFAULT => -176
	},
	{#State 361
		ACTIONS => {
			'LITERAL_STRING' => 382
		}
	},
	{#State 362
		ACTIONS => {
			'MY' => 383
		}
	},
	{#State 363
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 384
		}
	},
	{#State 364
		DEFAULT => -50
	},
	{#State 365
		ACTIONS => {
			";" => 385
		}
	},
	{#State 366
		ACTIONS => {
			'OP20_HASH_FATARROW' => 386
		}
	},
	{#State 367
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 387
		}
	},
	{#State 368
		ACTIONS => {
			'VARIABLE_SYMBOL' => 388
		}
	},
	{#State 369
		DEFAULT => -61
	},
	{#State 370
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 389
		}
	},
	{#State 371
		DEFAULT => -179
	},
	{#State 372
		DEFAULT => -219
	},
	{#State 373
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'SELF' => 101,
			'OP01_OPEN' => 128,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29
		},
		GOTOS => {
			'SubExpression' => 390,
			'Expression' => 156,
			'Literal' => 93,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119
		}
	},
	{#State 374
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP05_LOGICAL_NEG' => 116,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'VARIABLE_SYMBOL' => 123,
			'OP01_OPEN' => 128,
			'SELF' => 101,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100
		},
		GOTOS => {
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'SubExpression' => 391,
			'Expression' => 156,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 375
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'ARGV' => 157,
			'MY' => 141,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			'OP01_QW' => 159,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'OP01_OPEN' => 128
		},
		GOTOS => {
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'TypeInner' => 153,
			'ListElement' => 173,
			'SubExpression' => 171,
			'Expression' => 156,
			'ArrayReference' => 113,
			'ListElements' => 392,
			'WordScoped' => 114,
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119
		}
	},
	{#State 376
		DEFAULT => -167
	},
	{#State 377
		ACTIONS => {
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'STDIN' => 248,
			'VARIABLE_SYMBOL' => 123,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'SELF' => 101,
			'OP01_OPEN' => 128,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'LBRACE' => 118,
			'OP05_LOGICAL_NEG' => 116,
			'WORD_SCOPED' => 30,
			'FHREF_SYMBOL_IN' => 247,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			'LITERAL_NUMBER' => 109,
			"%{" => 84
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'SubExpressionOrInput' => 393,
			'Literal' => 93,
			'SubExpression' => 250,
			'Expression' => 156,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154
		}
	},
	{#State 378
		DEFAULT => -82
	},
	{#State 379
		ACTIONS => {
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			"}" => 395,
			'OP05_MATH_NEG_LPAREN' => 95,
			"undef" => 94,
			'OP03_MATH_INC_DEC' => 92,
			'OP01_PRINT' => 90,
			"while" => -148,
			'OP01_NAMED' => 89,
			'OP01_NAMED_VOID_SCOLON' => 88,
			"%{" => 84,
			'WORD_SCOPED' => 30,
			'MY' => 80,
			"\@{" => 129,
			'OP01_OPEN' => 128,
			"foreach" => -148,
			"if" => 124,
			'VARIABLE_SYMBOL' => 123,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LBRACE' => 118,
			'OP01_NAMED_VOID' => 117,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 115,
			'WORD_UPPERCASE' => 110,
			'LITERAL_NUMBER' => 109,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			'OP01_NAMED_VOID_LPAREN' => 105,
			"for" => -148,
			'OP19_LOOP_CONTROL' => 106
		},
		GOTOS => {
			'VariableModification' => 99,
			'Expression' => 103,
			'SubExpression' => 102,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Operator' => 119,
			'Variable' => 96,
			'Literal' => 93,
			'PAREN-36' => 91,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'HashReference' => 111,
			'HashDereference' => 112,
			'LoopLabel' => 86,
			'OPTIONAL-37' => 87,
			'OperatorVoid' => 85,
			'Operation' => 394,
			'VariableDeclaration' => 83,
			'Conditional' => 104,
			'Statement' => 82
		}
	},
	{#State 380
		DEFAULT => -170
	},
	{#State 381
		ACTIONS => {
			"}" => -159,
			'SELF' => -159,
			'OP22_LOGICAL_NEG' => -159,
			"else" => 397,
			'LBRACKET' => -159,
			'CONSTANT_CALL_SCOPED' => -159,
			'OP01_NAMED_VOID_SCOLON' => -159,
			"%{" => -159,
			'OP01_NAMED' => -159,
			'' => -159,
			'MY' => -159,
			'WORD_SCOPED' => -159,
			'OP05_MATH_NEG_LPAREN' => -159,
			"undef" => -159,
			"while" => -159,
			'OP01_PRINT' => -159,
			'OP03_MATH_INC_DEC' => -159,
			'LPAREN' => -159,
			'OP01_CLOSE' => -159,
			'LITERAL_STRING' => -159,
			'WORD' => -159,
			"elsif" => 400,
			"foreach" => -159,
			"\@{" => -159,
			'OP01_OPEN' => -159,
			"if" => -159,
			'VARIABLE_SYMBOL' => -159,
			'WORD_UPPERCASE' => -159,
			'LITERAL_NUMBER' => -159,
			'OP19_LOOP_CONTROL' => -159,
			'OP01_NAMED_VOID_LPAREN' => -159,
			"for" => -159,
			'OP19_LOOP_CONTROL_SCOLON' => -159,
			'OP05_LOGICAL_NEG' => -159,
			'OP01_NAMED_VOID' => -159,
			'LBRACE' => -159,
			'OP10_NAMED_UNARY' => -159
		},
		GOTOS => {
			'PAREN-40' => 396,
			'PAREN-38' => 398,
			'OPTIONAL-41' => 399
		}
	},
	{#State 382
		ACTIONS => {
			'OP21_LIST_COMMA' => 401
		}
	},
	{#State 383
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 402
		}
	},
	{#State 384
		ACTIONS => {
			"\@_;" => 403
		}
	},
	{#State 385
		DEFAULT => -66
	},
	{#State 386
		ACTIONS => {
			'MY' => 405
		},
		GOTOS => {
			'TypeInnerProperties' => 404
		}
	},
	{#State 387
		ACTIONS => {
			"}" => 408,
			'OP21_LIST_COMMA' => 407
		},
		GOTOS => {
			'PAREN-25' => 406
		}
	},
	{#State 388
		ACTIONS => {
			"= sub {" => 409
		}
	},
	{#State 389
		ACTIONS => {
			"undef" => 410
		}
	},
	{#State 390
		ACTIONS => {
			'OP17_LIST_RANGE' => 176,
			'OP15_LOGICAL_AND' => 184,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			";" => 411,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP18_TERNARY' => 180,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192
		}
	},
	{#State 391
		ACTIONS => {
			'OP06_REGEX_MATCH' => 182,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP18_TERNARY' => 180,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP17_LIST_RANGE' => 412,
			'OP15_LOGICAL_AND' => 184
		}
	},
	{#State 392
		ACTIONS => {
			")" => 413
		}
	},
	{#State 393
		ACTIONS => {
			")" => 414
		}
	},
	{#State 394
		DEFAULT => -169
	},
	{#State 395
		DEFAULT => -171
	},
	{#State 396
		DEFAULT => -158
	},
	{#State 397
		ACTIONS => {
			'LBRACE' => 356
		},
		GOTOS => {
			'CodeBlock' => 415
		}
	},
	{#State 398
		DEFAULT => -155
	},
	{#State 399
		DEFAULT => -160
	},
	{#State 400
		ACTIONS => {
			'LPAREN' => 416
		}
	},
	{#State 401
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 116,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'OP01_OPEN' => 128,
			'VARIABLE_SYMBOL' => 123,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LITERAL_STRING' => 120,
			'WORD' => 29
		},
		GOTOS => {
			'HashDereference' => 112,
			'HashReference' => 111,
			'Variable' => 154,
			'Operator' => 119,
			'Expression' => 156,
			'SubExpression' => 417,
			'Literal' => 93,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 402
		ACTIONS => {
			'VARIABLE_SYMBOL' => 418
		}
	},
	{#State 403
		DEFAULT => -52
	},
	{#State 404
		DEFAULT => -203
	},
	{#State 405
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 419
		}
	},
	{#State 406
		DEFAULT => -63
	},
	{#State 407
		ACTIONS => {
			'WORD' => 366
		},
		GOTOS => {
			'HashEntryProperties' => 420
		}
	},
	{#State 408
		ACTIONS => {
			";" => 421
		}
	},
	{#State 409
		ACTIONS => {
			"\@{" => -68,
			'OP01_OPEN' => -68,
			"foreach" => -68,
			"if" => -68,
			'VARIABLE_SYMBOL' => -68,
			'LPAREN' => -68,
			'OP01_CLOSE' => -68,
			'LITERAL_STRING' => -68,
			'WORD' => -68,
			'LBRACE' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'OP01_NAMED_VOID' => -68,
			'OP10_NAMED_UNARY' => -68,
			'WORD_UPPERCASE' => -68,
			'LITERAL_NUMBER' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'OP01_NAMED_VOID_LPAREN' => -68,
			"for" => -68,
			'OP19_LOOP_CONTROL' => -68,
			'OP22_LOGICAL_NEG' => -68,
			'SELF' => -68,
			'LBRACKET' => -68,
			'CONSTANT_CALL_SCOPED' => -68,
			"}" => -68,
			'LPAREN_MY' => 424,
			'OP05_MATH_NEG_LPAREN' => -68,
			"undef" => -68,
			'OP03_MATH_INC_DEC' => -68,
			'OP01_PRINT' => -68,
			"while" => -68,
			'OP01_NAMED' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			"%{" => -68,
			'WORD_SCOPED' => -68,
			'MY' => -68
		},
		GOTOS => {
			'OPTIONAL-27' => 422,
			'MethodArguments' => 423
		}
	},
	{#State 410
		ACTIONS => {
			";" => 425
		}
	},
	{#State 411
		ACTIONS => {
			'VARIABLE_SYMBOL' => 426
		}
	},
	{#State 412
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 158,
			'WORD_UPPERCASE' => 152,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'OP10_NAMED_UNARY' => 115,
			'OP03_MATH_INC_DEC' => 92,
			'OP05_MATH_NEG_LPAREN' => 95,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_LOGICAL_NEG' => 116,
			'LITERAL_STRING' => 120,
			'WORD' => 29,
			'LPAREN' => 122,
			'OP01_CLOSE' => 121,
			'LBRACKET' => 98,
			'CONSTANT_CALL_SCOPED' => 97,
			'VARIABLE_SYMBOL' => 123,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'OP01_OPEN' => 128
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Expression' => 156,
			'SubExpression' => 427,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93
		}
	},
	{#State 413
		ACTIONS => {
			'LBRACE' => 356
		},
		GOTOS => {
			'CodeBlock' => 428
		}
	},
	{#State 414
		ACTIONS => {
			'LBRACE' => 356
		},
		GOTOS => {
			'CodeBlock' => 429
		}
	},
	{#State 415
		DEFAULT => -157
	},
	{#State 416
		ACTIONS => {
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'WORD_SCOPED' => 30,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95
		},
		GOTOS => {
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'Expression' => 156,
			'SubExpression' => 430,
			'ArrayReference' => 113,
			'WordScoped' => 114
		}
	},
	{#State 417
		ACTIONS => {
			'OP07_STRING_REPEAT' => 186,
			";" => -83,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP21_LIST_COMMA' => -83,
			'OP15_LOGICAL_AND' => 184,
			"]" => -83,
			'OP17_LIST_RANGE' => 176,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP06_REGEX_MATCH' => 182,
			"}" => -83,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP18_TERNARY' => 180,
			")" => -83,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP11_COMPARE_LT_GT' => 190,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => -83
		}
	},
	{#State 418
		DEFAULT => -49
	},
	{#State 419
		ACTIONS => {
			"\$TYPED_" => 431
		}
	},
	{#State 420
		DEFAULT => -62
	},
	{#State 421
		DEFAULT => -65
	},
	{#State 422
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 432
		}
	},
	{#State 423
		DEFAULT => -67
	},
	{#State 424
		ACTIONS => {
			'WORD' => 58,
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60
		},
		GOTOS => {
			'Type' => 433
		}
	},
	{#State 425
		DEFAULT => -180
	},
	{#State 426
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 434
		}
	},
	{#State 427
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 185,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP17_LIST_RANGE' => undef,
			'OP15_LOGICAL_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 183,
			'OP23_LOGICAL_AND' => -104,
			'OP13_BITWISE_AND' => 188,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => -104,
			")" => 435,
			'OP18_TERNARY' => -104,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179
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
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 183,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			'OP18_TERNARY' => 180,
			")" => 436,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP17_LIST_RANGE' => 176,
			'OP15_LOGICAL_AND' => 184
		}
	},
	{#State 431
		ACTIONS => {
			'WORD' => 437
		}
	},
	{#State 432
		ACTIONS => {
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			"foreach" => -148,
			'VARIABLE_SYMBOL' => 123,
			"if" => 124,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 110,
			'OP19_LOOP_CONTROL_SCOLON' => 107,
			"for" => -148,
			'OP19_LOOP_CONTROL' => 106,
			'OP01_NAMED_VOID_LPAREN' => 105,
			'LBRACE' => 118,
			'OP01_NAMED_VOID' => 117,
			'OP05_LOGICAL_NEG' => 116,
			'OP10_NAMED_UNARY' => 115,
			"}" => 439,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_NAMED' => 89,
			"%{" => 84,
			'OP01_NAMED_VOID_SCOLON' => 88,
			'WORD_SCOPED' => 30,
			'MY' => 80,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP01_PRINT' => 90,
			"while" => -148
		},
		GOTOS => {
			'Operator' => 119,
			'Variable' => 96,
			'VariableModification' => 99,
			'SubExpression' => 102,
			'Expression' => 103,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Operation' => 438,
			'VariableDeclaration' => 83,
			'Conditional' => 104,
			'Statement' => 82,
			'HashReference' => 111,
			'HashDereference' => 112,
			'OperatorVoid' => 85,
			'OPTIONAL-37' => 87,
			'LoopLabel' => 86,
			'PAREN-36' => 91,
			'WordScoped' => 114,
			'ArrayReference' => 113,
			'Literal' => 93
		}
	},
	{#State 433
		ACTIONS => {
			'SELF' => 440
		}
	},
	{#State 434
		ACTIONS => {
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'WORD_SCOPED' => 30,
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158
		},
		GOTOS => {
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'SubExpression' => 441,
			'Expression' => 156,
			'Operator' => 119,
			'Variable' => 154,
			'HashReference' => 111,
			'HashDereference' => 112
		}
	},
	{#State 435
		ACTIONS => {
			'LBRACE' => 356
		},
		GOTOS => {
			'CodeBlock' => 442
		}
	},
	{#State 436
		ACTIONS => {
			'LBRACE' => 356
		},
		GOTOS => {
			'CodeBlock' => 443
		}
	},
	{#State 437
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 444,
			'OP19_VARIABLE_ASSIGN' => 445
		}
	},
	{#State 438
		DEFAULT => -69
	},
	{#State 439
		ACTIONS => {
			";" => 446
		}
	},
	{#State 440
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 447
		}
	},
	{#State 441
		ACTIONS => {
			'OP07_STRING_REPEAT' => 186,
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			";" => 448,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176,
			'OP04_MATH_POW' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP06_REGEX_MATCH' => 182,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP11_COMPARE_LT_GT' => 190,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP18_TERNARY' => 180,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188
		}
	},
	{#State 442
		DEFAULT => -164
	},
	{#State 443
		DEFAULT => -154
	},
	{#State 444
		ACTIONS => {
			'LITERAL_NUMBER' => 109,
			"%{" => 84,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			"\@{" => 129,
			'SELF' => 101,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98
		},
		GOTOS => {
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154,
			'Expression' => 156,
			'SubExpression' => 449,
			'ArrayDereference' => 126,
			'VariableSymbolOrSelf' => 127,
			'Literal' => 93,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 445
		ACTIONS => {
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'WORD_SCOPED' => 30,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_OPEN' => 128,
			'OP22_LOGICAL_NEG' => 100,
			'SELF' => 101,
			"\@{" => 129,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98
		},
		GOTOS => {
			'HashReference' => 111,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 154,
			'SubExpression' => 450,
			'Expression' => 156,
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'WordScoped' => 114,
			'ArrayReference' => 113
		}
	},
	{#State 446
		DEFAULT => -71
	},
	{#State 447
		ACTIONS => {
			")" => 451,
			'OP21_LIST_COMMA' => 453
		},
		GOTOS => {
			'PAREN-29' => 452
		}
	},
	{#State 448
		ACTIONS => {
			'WORD' => 29,
			'LITERAL_STRING' => 120,
			'OP01_CLOSE' => 121,
			'LPAREN' => 122,
			'VARIABLE_SYMBOL' => 123,
			'CONSTANT_CALL_SCOPED' => 97,
			'LBRACKET' => 98,
			'OP01_OPEN' => 128,
			"\@{" => 129,
			'SELF' => 101,
			'OP22_LOGICAL_NEG' => 100,
			'WORD_SCOPED' => 30,
			"%{" => 84,
			'LITERAL_NUMBER' => 109,
			'WORD_UPPERCASE' => 152,
			'OP01_NAMED' => 158,
			'OP03_MATH_INC_DEC' => 92,
			'OP10_NAMED_UNARY' => 115,
			'OP05_LOGICAL_NEG' => 116,
			'LBRACE' => 118,
			"undef" => 94,
			'OP05_MATH_NEG_LPAREN' => 95
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 127,
			'ArrayDereference' => 126,
			'Literal' => 93,
			'VariableModification' => 455,
			'Expression' => 156,
			'SubExpression' => 454,
			'ArrayReference' => 113,
			'WordScoped' => 114,
			'HashReference' => 111,
			'SubExpressionOrVarMod' => 456,
			'HashDereference' => 112,
			'Operator' => 119,
			'Variable' => 96
		}
	},
	{#State 449
		ACTIONS => {
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 184,
			"]" => 457,
			'OP17_LIST_RANGE' => 176,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP18_TERNARY' => 180,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			'OP09_BITWISE_SHIFT' => 179,
			'OP08_MATH_ADD_SUB' => 189,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178
		}
	},
	{#State 450
		ACTIONS => {
			'OP08_STRING_CAT' => 177,
			'OP16_LOGICAL_OR' => 187,
			'OP07_STRING_REPEAT' => 186,
			'OP21_LIST_COMMA' => -220,
			'OP12_COMPARE_EQ_NE' => 185,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			'OP18_TERNARY' => 180,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			"}" => -220,
			'OP23_LOGICAL_AND' => 178,
			'OP13_BITWISE_AND' => 188
		}
	},
	{#State 451
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 458
		}
	},
	{#State 452
		DEFAULT => -73
	},
	{#State 453
		ACTIONS => {
			'MY' => 459
		}
	},
	{#State 454
		ACTIONS => {
			'OP18_TERNARY' => 180,
			")" => -144,
			'OP24_LOGICAL_OR_XOR' => 181,
			'OP11_COMPARE_LT_GT' => 190,
			'OP08_MATH_ADD_SUB' => 189,
			'OP09_BITWISE_SHIFT' => 179,
			'OP13_BITWISE_AND' => 188,
			'OP23_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 191,
			'OP14_BITWISE_OR_XOR' => 192,
			'OP04_MATH_POW' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP15_LOGICAL_AND' => 184,
			'OP17_LIST_RANGE' => 176,
			'OP16_LOGICAL_OR' => 187,
			'OP08_STRING_CAT' => 177,
			'OP07_STRING_REPEAT' => 186,
			'OP12_COMPARE_EQ_NE' => 185
		}
	},
	{#State 455
		DEFAULT => -145
	},
	{#State 456
		ACTIONS => {
			")" => 460
		}
	},
	{#State 457
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 461
		}
	},
	{#State 458
		ACTIONS => {
			"\@_;" => 462
		}
	},
	{#State 459
		ACTIONS => {
			'TYPE_INTEGER' => 59,
			'WORD_SCOPED' => 60,
			'WORD' => 58
		},
		GOTOS => {
			'Type' => 463
		}
	},
	{#State 460
		ACTIONS => {
			'LBRACE' => 356
		},
		GOTOS => {
			'CodeBlock' => 464
		}
	},
	{#State 461
		ACTIONS => {
			"undef" => 465
		}
	},
	{#State 462
		DEFAULT => -75
	},
	{#State 463
		ACTIONS => {
			'VARIABLE_SYMBOL' => 466
		}
	},
	{#State 464
		DEFAULT => -165
	},
	{#State 465
		DEFAULT => -221
	},
	{#State 466
		DEFAULT => -72
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
