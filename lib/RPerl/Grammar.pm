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
    our $VERSION = 0.002_001;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|\$TYPED_|foreach|\=\ sub\ \{|package|undef|while|elsif|else|our|for|\@_\;|\%\{|\@\{|if|\]|\)|\;|\})}gc and return ($1, $1);

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
      /\G(\%ENV)/gc and return ('ENV', $1);
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


#line 139 lib/RPerl/Grammar.pm

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
  [ 'HashEntry_203' => 'HashEntry', [ 'ENV' ], 0 ],
  [ 'HashEntryProperties_204' => 'HashEntryProperties', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInnerProperties' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_208' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_209' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_212' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_213' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
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
	ARGV => { ISSEMANTIC => 1 },
	COLON => { ISSEMANTIC => 1 },
	CONSTANT_CALL_SCOPED => { ISSEMANTIC => 1 },
	ENV => { ISSEMANTIC => 1 },
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
			"package" => -20,
			'USE_RPERL' => -20,
			'SHEBANG' => 9,
			"## no critic qw(" => 5
		},
		GOTOS => {
			'PLUS-2' => 8,
			'Program' => 7,
			'OPTIONAL-9' => 4,
			'Critic' => 6,
			'ModuleHeader' => 3,
			'CompileUnit' => 2,
			'PAREN-1' => 1
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		ACTIONS => {
			'' => 10
		}
	},
	{#State 3
		ACTIONS => {
			"use constant" => -27,
			"## no critic qw(" => -27,
			'USE' => -27,
			"use parent qw(" => 15,
			"our" => -27
		},
		GOTOS => {
			'Package' => 12,
			'Class' => 11,
			'STAR-11' => 14,
			'Module' => 13
		}
	},
	{#State 4
		ACTIONS => {
			"package" => -22,
			'USE_RPERL' => 17
		},
		GOTOS => {
			'OPTIONAL-10' => 16
		}
	},
	{#State 5
		ACTIONS => {
			'WORD' => 18
		},
		GOTOS => {
			'PLUS-16' => 19
		}
	},
	{#State 6
		DEFAULT => -19
	},
	{#State 7
		DEFAULT => -4
	},
	{#State 8
		ACTIONS => {
			"package" => -20,
			'USE_RPERL' => -20,
			'' => -5,
			"## no critic qw(" => 5
		},
		GOTOS => {
			'ModuleHeader' => 3,
			'PAREN-1' => 20,
			'Critic' => 6,
			'OPTIONAL-9' => 4
		}
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => 5,
			'USE_RPERL' => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 22,
			'Critic' => 21
		}
	},
	{#State 10
		DEFAULT => 0
	},
	{#State 11
		DEFAULT => -25
	},
	{#State 12
		DEFAULT => -24
	},
	{#State 13
		DEFAULT => -1
	},
	{#State 14
		ACTIONS => {
			"use constant" => -29,
			"## no critic qw(" => 5,
			'USE' => -29,
			"our" => -29
		},
		GOTOS => {
			'STAR-12' => 24,
			'Critic' => 23
		}
	},
	{#State 15
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 27
		}
	},
	{#State 16
		ACTIONS => {
			"package" => 28
		}
	},
	{#State 17
		DEFAULT => -21
	},
	{#State 18
		DEFAULT => -39
	},
	{#State 19
		ACTIONS => {
			'WORD' => 29,
			")" => 30
		}
	},
	{#State 20
		DEFAULT => -2
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
			'USE' => 32,
			"our" => -31,
			"use constant" => -31
		},
		GOTOS => {
			'STAR-13' => 34,
			'Include' => 33
		}
	},
	{#State 25
		DEFAULT => -214
	},
	{#State 26
		DEFAULT => -215
	},
	{#State 27
		ACTIONS => {
			")" => 35
		}
	},
	{#State 28
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 36
		}
	},
	{#State 29
		DEFAULT => -38
	},
	{#State 30
		DEFAULT => -40
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
			'WORD_SCOPED' => 26,
			'WORD' => 25
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
			"use constant" => 40,
			"our" => 43
		},
		GOTOS => {
			'PLUS-14' => 44,
			'Constant' => 42,
			'Subroutine' => 41
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
			'OP01_QW' => 49,
			";" => 50
		}
	},
	{#State 40
		ACTIONS => {
			'WORD_UPPERCASE' => 51
		}
	},
	{#State 41
		DEFAULT => -33
	},
	{#State 42
		DEFAULT => -30
	},
	{#State 43
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 44
		ACTIONS => {
			"our" => 43,
			'LITERAL_NUMBER' => 56
		},
		GOTOS => {
			'Subroutine' => 57
		}
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
			"our" => -36,
			'USE_RPERL_AFTER' => 61
		},
		GOTOS => {
			'OPTIONAL-15' => 60
		}
	},
	{#State 48
		ACTIONS => {
			'MY' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'LITERAL_STRING' => -11,
			'OP01_NAMED' => -11,
			"\@{" => -11,
			"## no critic qw(" => 5,
			"our" => -11,
			'LPAREN' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP19_LOOP_CONTROL' => -11,
			'CONSTANT_CALL_SCOPED' => -11,
			"while" => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP03_MATH_INC_DEC' => -11,
			'OP22_LOGICAL_NEG' => -11,
			"%{" => -11,
			'OP01_PRINT' => -11,
			'LITERAL_NUMBER' => -11,
			'USE' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'LBRACE' => -11,
			"if" => -11,
			'OP01_OPEN' => -11,
			"foreach" => -11,
			'LBRACKET' => -11,
			'WORD_UPPERCASE' => -11,
			'SELF' => -11,
			"for" => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			"undef" => -11,
			'WORD_SCOPED' => -11,
			'WORD' => -11,
			'OP05_LOGICAL_NEG' => -11,
			"use constant" => -11,
			'OP01_NAMED_VOID' => -11
		},
		GOTOS => {
			'STAR-5' => 62,
			'Critic' => 63
		}
	},
	{#State 49
		ACTIONS => {
			";" => 64
		}
	},
	{#State 50
		DEFAULT => -41
	},
	{#State 51
		ACTIONS => {
			'OP20_HASH_FATARROW' => 65
		}
	},
	{#State 52
		DEFAULT => -219
	},
	{#State 53
		ACTIONS => {
			'VARIABLE_SYMBOL' => 66
		}
	},
	{#State 54
		DEFAULT => -218
	},
	{#State 55
		DEFAULT => -217
	},
	{#State 56
		ACTIONS => {
			";" => 67
		}
	},
	{#State 57
		DEFAULT => -32
	},
	{#State 58
		DEFAULT => -54,
		GOTOS => {
			'STAR-21' => 68
		}
	},
	{#State 59
		DEFAULT => -23
	},
	{#State 60
		ACTIONS => {
			"our" => 69
		}
	},
	{#State 61
		DEFAULT => -35
	},
	{#State 62
		ACTIONS => {
			'LPAREN' => -13,
			"our" => -13,
			'OP01_CLOSE' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'MY' => -13,
			'LITERAL_STRING' => -13,
			'OP01_NAMED' => -13,
			"\@{" => -13,
			"%{" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP01_PRINT' => -13,
			'LITERAL_NUMBER' => -13,
			'OP19_LOOP_CONTROL' => -13,
			'VARIABLE_SYMBOL' => -13,
			'CONSTANT_CALL_SCOPED' => -13,
			"while" => -13,
			'OP10_NAMED_UNARY' => -13,
			'LBRACKET' => -13,
			"foreach" => -13,
			'WORD_UPPERCASE' => -13,
			'SELF' => -13,
			"for" => -13,
			'USE' => 32,
			'OP05_MATH_NEG_LPAREN' => -13,
			"if" => -13,
			'LBRACE' => -13,
			'OP01_OPEN' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"use constant" => -13,
			'OP01_NAMED_VOID' => -13,
			"undef" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'WORD' => -13,
			'WORD_SCOPED' => -13
		},
		GOTOS => {
			'Include' => 70,
			'STAR-6' => 71
		}
	},
	{#State 63
		DEFAULT => -8
	},
	{#State 64
		DEFAULT => -42
	},
	{#State 65
		ACTIONS => {
			'MY' => 73
		},
		GOTOS => {
			'TypeInnerConstant' => 72
		}
	},
	{#State 66
		ACTIONS => {
			"= sub {" => 74
		}
	},
	{#State 67
		DEFAULT => -34
	},
	{#State 68
		ACTIONS => {
			'USE' => -56,
			"## no critic qw(" => 5,
			"our hashref \$properties" => -56,
			"use constant" => -56
		},
		GOTOS => {
			'Critic' => 76,
			'STAR-22' => 75
		}
	},
	{#State 69
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 77
		}
	},
	{#State 70
		DEFAULT => -10
	},
	{#State 71
		ACTIONS => {
			"for" => -15,
			'LBRACKET' => -15,
			"foreach" => -15,
			'SELF' => -15,
			'WORD_UPPERCASE' => -15,
			'LBRACE' => -15,
			"if" => -15,
			'OP01_OPEN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"use constant" => 40,
			'OP01_NAMED_VOID' => -15,
			'OP05_LOGICAL_NEG' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			"undef" => -15,
			'WORD_SCOPED' => -15,
			'WORD' => -15,
			'OP01_CLOSE' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			"our" => -15,
			'LPAREN' => -15,
			'OP01_NAMED' => -15,
			"\@{" => -15,
			'MY' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LITERAL_STRING' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_PRINT' => -15,
			'OP03_MATH_INC_DEC' => -15,
			'OP22_LOGICAL_NEG' => -15,
			"%{" => -15,
			'CONSTANT_CALL_SCOPED' => -15,
			"while" => -15,
			'OP10_NAMED_UNARY' => -15,
			'VARIABLE_SYMBOL' => -15,
			'OP19_LOOP_CONTROL' => -15
		},
		GOTOS => {
			'STAR-7' => 79,
			'Constant' => 78
		}
	},
	{#State 72
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Literal' => 80
		}
	},
	{#State 73
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 55,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 83
		}
	},
	{#State 74
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => -45,
			'OP10_NAMED_UNARY' => -45,
			"while" => -45,
			'OP19_LOOP_CONTROL' => -45,
			'VARIABLE_SYMBOL' => -45,
			'LITERAL_NUMBER' => -45,
			'OP01_PRINT' => -45,
			'OP03_MATH_INC_DEC' => -45,
			'OP22_LOGICAL_NEG' => -45,
			"%{" => -45,
			'OP01_NAMED' => -45,
			"\@{" => -45,
			'MY' => -45,
			'LITERAL_STRING' => -45,
			'OP19_LOOP_CONTROL_SCOLON' => -45,
			'OP01_CLOSE' => -45,
			'OP01_NAMED_VOID_SCOLON' => -45,
			'LPAREN' => -45,
			'LPAREN_MY' => 85,
			'OP01_NAMED_VOID_LPAREN' => -45,
			"undef" => -45,
			'WORD_SCOPED' => -45,
			'WORD' => -45,
			'OP01_NAMED_VOID' => -45,
			'OP05_LOGICAL_NEG' => -45,
			'LBRACE' => -45,
			"if" => -45,
			'OP01_OPEN' => -45,
			"}" => -45,
			'OP05_MATH_NEG_LPAREN' => -45,
			"for" => -45,
			'LBRACKET' => -45,
			"foreach" => -45,
			'SELF' => -45,
			'WORD_UPPERCASE' => -45
		},
		GOTOS => {
			'SubroutineArguments' => 84,
			'OPTIONAL-17' => 86
		}
	},
	{#State 75
		ACTIONS => {
			'USE' => 32,
			"our hashref \$properties" => -58,
			"use constant" => -58
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
		DEFAULT => -37
	},
	{#State 78
		DEFAULT => -12
	},
	{#State 79
		ACTIONS => {
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			'OP01_PRINT' => 123,
			'LITERAL_NUMBER' => 81,
			'OP19_LOOP_CONTROL' => 111,
			'VARIABLE_SYMBOL' => 112,
			'OP10_NAMED_UNARY' => 114,
			"while" => -148,
			'CONSTANT_CALL_SCOPED' => 116,
			'LPAREN' => 132,
			"our" => 43,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'OP01_CLOSE' => 135,
			'OP19_LOOP_CONTROL_SCOLON' => 125,
			'MY' => 124,
			'LITERAL_STRING' => 82,
			"\@{" => 127,
			'OP01_NAMED' => 129,
			'OP05_LOGICAL_NEG' => 93,
			'OP01_NAMED_VOID' => 94,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			"undef" => 90,
			'OP01_NAMED_VOID_LPAREN' => 89,
			'SELF' => 106,
			'WORD_UPPERCASE' => 108,
			"foreach" => -148,
			'LBRACKET' => 109,
			"for" => -148,
			'OP05_MATH_NEG_LPAREN' => 97,
			'OP01_OPEN' => 100,
			"if" => 105,
			'LBRACE' => 104
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'LoopLabel' => 113,
			'WordScoped' => 120,
			'SubExpression' => 121,
			'OperatorVoid' => 122,
			'Subroutine' => 95,
			'Operation' => 96,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'Statement' => 103,
			'OPTIONAL-37' => 101,
			'Conditional' => 102,
			'Variable' => 128,
			'HashReference' => 130,
			'PAREN-36' => 99,
			'VariableDeclaration' => 126,
			'VariableSymbolOrSelf' => 98,
			'Operator' => 110,
			'VariableModification' => 134,
			'Literal' => 107,
			'PLUS-8' => 131,
			'Expression' => 133
		}
	},
	{#State 80
		ACTIONS => {
			";" => 137
		}
	},
	{#State 81
		DEFAULT => -231
	},
	{#State 82
		DEFAULT => -232
	},
	{#State 83
		ACTIONS => {
			"\$TYPED_" => 138
		}
	},
	{#State 84
		DEFAULT => -44
	},
	{#State 85
		ACTIONS => {
			'WORD_SCOPED' => 54,
			'WORD' => 55,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 139
		}
	},
	{#State 86
		DEFAULT => -47,
		GOTOS => {
			'STAR-18' => 140
		}
	},
	{#State 87
		ACTIONS => {
			"our hashref \$properties" => 142,
			"use constant" => 40
		},
		GOTOS => {
			'Properties' => 141,
			'Constant' => 143
		}
	},
	{#State 88
		DEFAULT => -55
	},
	{#State 89
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'OP01_QW' => 146,
			'CONSTANT_CALL_SCOPED' => 116,
			'ARGV' => 155,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			")" => -113,
			"undef" => 90,
			'OP01_CLOSE' => 135,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'MY' => 151,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'ListElements' => 154,
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91,
			'TypeInner' => 147,
			'SubExpression' => 153,
			'ListElement' => 152,
			'WordScoped' => 120,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 98,
			'OPTIONAL-33' => 145,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115
		}
	},
	{#State 90
		DEFAULT => -133
	},
	{#State 91
		DEFAULT => -136
	},
	{#State 92
		DEFAULT => -139
	},
	{#State 93
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'OP01_CLOSE' => 135,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'SubExpression' => 156,
			'Operator' => 110,
			'WordScoped' => 120,
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 94
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'MY' => 151,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97
		},
		GOTOS => {
			'WordScoped' => 120,
			'Operator' => 110,
			'ListElement' => 152,
			'SubExpression' => 153,
			'TypeInner' => 147,
			'ArrayReference' => 91,
			'Literal' => 107,
			'HashDereference' => 92,
			'Expression' => 148,
			'ListElements' => 157,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 95
		DEFAULT => -14
	},
	{#State 96
		DEFAULT => -17
	},
	{#State 97
		ACTIONS => {
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'OP01_CLOSE' => 135,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91,
			'SubExpression' => 158,
			'WordScoped' => 120,
			'Operator' => 110
		}
	},
	{#State 98
		DEFAULT => -173,
		GOTOS => {
			'STAR-43' => 159
		}
	},
	{#State 99
		DEFAULT => -147
	},
	{#State 100
		ACTIONS => {
			'MY' => 160
		}
	},
	{#State 101
		ACTIONS => {
			"for" => 166,
			"while" => 162,
			"foreach" => 165
		},
		GOTOS => {
			'LoopWhile' => 163,
			'LoopForEach' => 164,
			'Loop' => 167,
			'LoopFor' => 161
		}
	},
	{#State 102
		DEFAULT => -149
	},
	{#State 103
		DEFAULT => -79
	},
	{#State 104
		ACTIONS => {
			"%{" => 119,
			'SELF' => 106,
			'LITERAL_NUMBER' => 81,
			'ENV' => 175,
			'LITERAL_STRING' => 82,
			"}" => 169,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 172
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'HashDereference' => 170,
			'Literal' => 168,
			'HashEntry' => 173,
			'Variable' => 174,
			'VariableOrLiteralOrWord' => 171
		}
	},
	{#State 105
		ACTIONS => {
			'LPAREN' => 176
		}
	},
	{#State 106
		DEFAULT => -230
	},
	{#State 107
		DEFAULT => -134
	},
	{#State 108
		ACTIONS => {
			'LPAREN' => 177,
			'COLON' => -216
		}
	},
	{#State 109
		ACTIONS => {
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			"]" => -193,
			'LITERAL_NUMBER' => 81,
			"undef" => 90,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'OP01_QW' => 146,
			'CONSTANT_CALL_SCOPED' => 116,
			'ARGV' => 155,
			'OP10_NAMED_UNARY' => 114,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'OP01_CLOSE' => 135,
			'LITERAL_STRING' => 82,
			'MY' => 151,
			'OP05_MATH_NEG_LPAREN' => 97,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"\@{" => 127,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149,
			'VariableSymbolOrSelf' => 98,
			'Operator' => 110,
			'WordScoped' => 120,
			'ListElement' => 152,
			'SubExpression' => 153,
			'TypeInner' => 147,
			'ArrayReference' => 91,
			'OPTIONAL-46' => 179,
			'Literal' => 107,
			'HashDereference' => 92,
			'ListElements' => 178,
			'Expression' => 148
		}
	},
	{#State 110
		DEFAULT => -126
	},
	{#State 111
		ACTIONS => {
			'WORD_UPPERCASE' => 181
		},
		GOTOS => {
			'LoopLabel' => 180
		}
	},
	{#State 112
		DEFAULT => -229
	},
	{#State 113
		ACTIONS => {
			'COLON' => 182
		}
	},
	{#State 114
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'OP07_MATH_MULT_DIV_MOD' => -97,
			")" => -97,
			'WORD' => 25,
			"undef" => 90,
			'OP06_REGEX_MATCH' => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP07_STRING_REPEAT' => -97,
			'OP04_MATH_POW' => -97,
			'OP17_LIST_RANGE' => -97,
			'OP05_LOGICAL_NEG' => 93,
			";" => -97,
			"]" => -97,
			'OP05_MATH_NEG_LPAREN' => 97,
			"}" => -97,
			'OP01_OPEN' => 100,
			'LBRACE' => 104,
			'OP08_MATH_ADD_SUB' => -97,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'OP12_COMPARE_EQ_NE' => -97,
			'LBRACKET' => 109,
			'VARIABLE_SYMBOL' => 112,
			'OP11_COMPARE_LT_GT' => -97,
			'OP08_STRING_CAT' => -97,
			'OP09_BITWISE_SHIFT' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP21_LIST_COMMA' => -97,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'OP18_TERNARY' => -97,
			'LITERAL_STRING' => 82,
			"\@{" => 127,
			'OP13_BITWISE_AND' => -97,
			'OP01_NAMED' => 150,
			'OP16_LOGICAL_OR' => -97,
			'LPAREN' => 132,
			'OP15_LOGICAL_AND' => -97,
			'OP01_CLOSE' => 135,
			'OP14_BITWISE_OR_XOR' => -97
		},
		GOTOS => {
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 183,
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 115
		DEFAULT => -137
	},
	{#State 116
		DEFAULT => -128
	},
	{#State 117
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			"%{" => 119,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 184,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149
		}
	},
	{#State 118
		ACTIONS => {
			'VARIABLE_SYMBOL' => 112,
			'SELF' => 106
		},
		GOTOS => {
			'Variable' => 185,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 119
		ACTIONS => {
			'LBRACE' => -211,
			'SELF' => 106,
			'VARIABLE_SYMBOL' => 112,
			'MY' => 151
		},
		GOTOS => {
			'OPTIONAL-51' => 188,
			'VariableSymbolOrSelf' => 98,
			'TypeInner' => 187,
			'Variable' => 186
		}
	},
	{#State 120
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 189,
			'LPAREN' => 190
		}
	},
	{#State 121
		ACTIONS => {
			'OP18_TERNARY' => 202,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194
		}
	},
	{#State 122
		DEFAULT => -151
	},
	{#State 123
		ACTIONS => {
			'STDOUT_STDERR' => 210,
			'WORD' => -111,
			'WORD_SCOPED' => -111,
			'VARIABLE_SYMBOL' => -111,
			"undef" => -111,
			'OP10_NAMED_UNARY' => -111,
			'ARGV' => -111,
			'CONSTANT_CALL_SCOPED' => -111,
			'OP01_QW' => -111,
			"%{" => -111,
			'OP05_LOGICAL_NEG' => -111,
			'OP03_MATH_INC_DEC' => -111,
			'OP22_LOGICAL_NEG' => -111,
			'LITERAL_NUMBER' => -111,
			'OP05_MATH_NEG_LPAREN' => -111,
			'MY' => -111,
			'LITERAL_STRING' => -111,
			'FHREF_SYMBOL_BRACES' => 209,
			"\@{" => -111,
			'OP01_OPEN' => -111,
			'OP01_NAMED' => -111,
			'LBRACE' => -111,
			'LPAREN' => -111,
			'WORD_UPPERCASE' => -111,
			'SELF' => -111,
			'LBRACKET' => -111,
			'OP01_CLOSE' => -111
		},
		GOTOS => {
			'PAREN-31' => 208,
			'OPTIONAL-32' => 211
		}
	},
	{#State 124
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD_SCOPED' => 54,
			'WORD' => 55,
			'TYPE_FHREF' => 213
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 125
		DEFAULT => -120
	},
	{#State 126
		DEFAULT => -152
	},
	{#State 127
		ACTIONS => {
			'LBRACKET' => -196,
			'MY' => 151,
			'SELF' => 106,
			'VARIABLE_SYMBOL' => 112
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'OPTIONAL-47' => 216,
			'TypeInner' => 215,
			'Variable' => 214
		}
	},
	{#State 128
		ACTIONS => {
			'OP15_LOGICAL_AND' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP18_TERNARY' => -135,
			'OP03_MATH_INC_DEC' => 219,
			'OP17_LIST_RANGE' => -135,
			'OP04_MATH_POW' => -135,
			'OP02_METHOD_THINARROW' => 217,
			'OP07_STRING_REPEAT' => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP19_VARIABLE_ASSIGN_BY' => 220,
			'OP11_COMPARE_LT_GT' => -135,
			'OP08_STRING_CAT' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP19_VARIABLE_ASSIGN' => 218,
			")" => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135
		}
	},
	{#State 129
		ACTIONS => {
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'OP05_MATH_NEG_LPAREN' => 97,
			'MY' => 151,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'ARGV' => 155,
			'OP01_QW' => 146
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149,
			'Expression' => 148,
			'HashDereference' => 92,
			'ArrayReference' => 91,
			'Literal' => 107,
			'SubExpression' => 221,
			'TypeInner' => 147,
			'WordScoped' => 120,
			'Operator' => 110,
			'ListElement' => 222
		}
	},
	{#State 130
		DEFAULT => -138
	},
	{#State 131
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"while" => -148,
			'OP19_LOOP_CONTROL' => 111,
			'VARIABLE_SYMBOL' => 112,
			'OP01_PRINT' => 123,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 129,
			"\@{" => 127,
			'OP19_LOOP_CONTROL_SCOLON' => 125,
			'MY' => 124,
			'LITERAL_STRING' => 82,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'OP01_CLOSE' => 135,
			'LPAREN' => 132,
			"undef" => 90,
			'OP01_NAMED_VOID_LPAREN' => 89,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'OP01_NAMED_VOID' => 94,
			'OP05_LOGICAL_NEG' => 93,
			"if" => 105,
			'LBRACE' => 104,
			'OP01_OPEN' => 100,
			'OP05_MATH_NEG_LPAREN' => 97,
			"for" => -148,
			"foreach" => -148,
			'LBRACKET' => 109,
			'' => -18,
			'WORD_UPPERCASE' => 108,
			'SELF' => 106
		},
		GOTOS => {
			'LoopLabel' => 113,
			'ArrayDereference' => 115,
			'HashDereference' => 92,
			'ArrayReference' => 91,
			'SubExpression' => 121,
			'OperatorVoid' => 122,
			'Operation' => 223,
			'WordScoped' => 120,
			'VariableSymbolOrSelf' => 98,
			'PAREN-36' => 99,
			'VariableDeclaration' => 126,
			'HashReference' => 130,
			'Variable' => 128,
			'Conditional' => 102,
			'OPTIONAL-37' => 101,
			'Statement' => 103,
			'Expression' => 133,
			'Literal' => 107,
			'Operator' => 110,
			'VariableModification' => 134
		}
	},
	{#State 132
		ACTIONS => {
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 226,
			'LBRACE' => 104,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			'OP01_PRINT' => 224,
			'LITERAL_NUMBER' => 81,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91,
			'SubExpression' => 225,
			'WordScoped' => 120,
			'Operator' => 110
		}
	},
	{#State 133
		ACTIONS => {
			'OP04_MATH_POW' => -132,
			'OP17_LIST_RANGE' => -132,
			";" => 227,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP08_STRING_CAT' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP18_TERNARY' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP08_MATH_ADD_SUB' => -132
		}
	},
	{#State 134
		ACTIONS => {
			";" => 228
		}
	},
	{#State 135
		ACTIONS => {
			'FHREF_SYMBOL' => 229
		}
	},
	{#State 136
		DEFAULT => -116
	},
	{#State 137
		DEFAULT => -43
	},
	{#State 138
		ACTIONS => {
			'WORD_UPPERCASE' => 230
		}
	},
	{#State 139
		ACTIONS => {
			'VARIABLE_SYMBOL' => 231
		}
	},
	{#State 140
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 111,
			'VARIABLE_SYMBOL' => 112,
			'OP10_NAMED_UNARY' => 114,
			"while" => -148,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'OP01_PRINT' => 123,
			'LITERAL_STRING' => 82,
			'MY' => 124,
			'OP19_LOOP_CONTROL_SCOLON' => 125,
			"\@{" => 127,
			'OP01_NAMED' => 129,
			'LPAREN' => 132,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'OP01_CLOSE' => 135,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"undef" => 90,
			'OP05_LOGICAL_NEG' => 93,
			'OP01_NAMED_VOID' => 94,
			'OP05_MATH_NEG_LPAREN' => 97,
			"}" => 232,
			'OP01_OPEN' => 100,
			'LBRACE' => 104,
			"if" => 105,
			'SELF' => 106,
			'WORD_UPPERCASE' => 108,
			'LBRACKET' => 109,
			"foreach" => -148,
			"for" => -148
		},
		GOTOS => {
			'OperatorVoid' => 122,
			'SubExpression' => 121,
			'Operation' => 233,
			'WordScoped' => 120,
			'HashDereference' => 92,
			'ArrayReference' => 91,
			'ArrayDereference' => 115,
			'LoopLabel' => 113,
			'VariableModification' => 134,
			'Operator' => 110,
			'Expression' => 133,
			'Literal' => 107,
			'HashReference' => 130,
			'Variable' => 128,
			'Statement' => 103,
			'OPTIONAL-37' => 101,
			'Conditional' => 102,
			'VariableDeclaration' => 126,
			'VariableSymbolOrSelf' => 98,
			'PAREN-36' => 99
		}
	},
	{#State 141
		DEFAULT => -60,
		GOTOS => {
			'STAR-24' => 234
		}
	},
	{#State 142
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 235
		}
	},
	{#State 143
		DEFAULT => -57
	},
	{#State 144
		ACTIONS => {
			'LPAREN' => 177
		}
	},
	{#State 145
		ACTIONS => {
			")" => 236
		}
	},
	{#State 146
		DEFAULT => -190
	},
	{#State 147
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'LBRACKET' => 109
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 237,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130
		}
	},
	{#State 148
		DEFAULT => -132
	},
	{#State 149
		ACTIONS => {
			"}" => -135,
			'OP18_TERNARY' => -135,
			'OP08_MATH_ADD_SUB' => -135,
			'OP13_BITWISE_AND' => -135,
			'OP12_COMPARE_EQ_NE' => -135,
			'OP16_LOGICAL_OR' => -135,
			'OP15_LOGICAL_AND' => -135,
			'OP14_BITWISE_OR_XOR' => -135,
			'OP08_STRING_CAT' => -135,
			'OP11_COMPARE_LT_GT' => -135,
			'OP09_BITWISE_SHIFT' => -135,
			'OP07_MATH_MULT_DIV_MOD' => -135,
			")" => -135,
			'OP24_LOGICAL_OR_XOR' => -135,
			'OP07_STRING_REPEAT' => -135,
			'OP06_REGEX_MATCH' => -135,
			'OP23_LOGICAL_AND' => -135,
			'OP03_MATH_INC_DEC' => 219,
			'OP17_LIST_RANGE' => -135,
			'OP21_LIST_COMMA' => -135,
			'OP02_METHOD_THINARROW' => 217,
			'OP04_MATH_POW' => -135,
			"]" => -135,
			";" => -135
		}
	},
	{#State 150
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 238,
			'Literal' => 107,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'Expression' => 148
		}
	},
	{#State 151
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 55,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 239
		}
	},
	{#State 152
		DEFAULT => -186,
		GOTOS => {
			'STAR-45' => 240
		}
	},
	{#State 153
		ACTIONS => {
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -188,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP09_BITWISE_SHIFT' => 205,
			";" => -188,
			"]" => -188,
			'OP21_LIST_COMMA' => -188,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP18_TERNARY' => 202,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191
		}
	},
	{#State 154
		DEFAULT => -112
	},
	{#State 155
		DEFAULT => -191
	},
	{#State 156
		ACTIONS => {
			'OP08_STRING_CAT' => -88,
			'OP09_BITWISE_SHIFT' => -88,
			'OP11_COMPARE_LT_GT' => -88,
			'OP07_MATH_MULT_DIV_MOD' => -88,
			")" => -88,
			'OP24_LOGICAL_OR_XOR' => -88,
			'OP07_STRING_REPEAT' => -88,
			'OP06_REGEX_MATCH' => -88,
			'OP23_LOGICAL_AND' => -88,
			'OP17_LIST_RANGE' => -88,
			'OP21_LIST_COMMA' => -88,
			'OP04_MATH_POW' => 194,
			"]" => -88,
			";" => -88,
			"}" => -88,
			'OP18_TERNARY' => -88,
			'OP08_MATH_ADD_SUB' => -88,
			'OP13_BITWISE_AND' => -88,
			'OP12_COMPARE_EQ_NE' => -88,
			'OP16_LOGICAL_OR' => -88,
			'OP14_BITWISE_OR_XOR' => -88,
			'OP15_LOGICAL_AND' => -88
		}
	},
	{#State 157
		ACTIONS => {
			";" => 241
		}
	},
	{#State 158
		ACTIONS => {
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => 202,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			")" => 242,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194
		}
	},
	{#State 159
		ACTIONS => {
			'OP18_TERNARY' => -174,
			"}" => -174,
			'OP13_BITWISE_AND' => -174,
			'OP08_MATH_ADD_SUB' => -174,
			'OP12_COMPARE_EQ_NE' => -174,
			'OP16_LOGICAL_OR' => -174,
			'OP15_LOGICAL_AND' => -174,
			'OP14_BITWISE_OR_XOR' => -174,
			'COLON' => -174,
			'OP09_BITWISE_SHIFT' => -174,
			'OP11_COMPARE_LT_GT' => -174,
			'OP19_VARIABLE_ASSIGN' => -174,
			'OP08_STRING_CAT' => -174,
			'OP07_MATH_MULT_DIV_MOD' => -174,
			")" => -174,
			'OP02_ARRAY_THINARROW' => 243,
			'OP24_LOGICAL_OR_XOR' => -174,
			'OP07_STRING_REPEAT' => -174,
			'OP23_LOGICAL_AND' => -174,
			'OP19_VARIABLE_ASSIGN_BY' => -174,
			'OP06_REGEX_MATCH' => -174,
			'OP17_LIST_RANGE' => -174,
			'OP03_MATH_INC_DEC' => -174,
			'OP20_HASH_FATARROW' => -174,
			'OP04_MATH_POW' => -174,
			'OP21_LIST_COMMA' => -174,
			'OP02_METHOD_THINARROW' => -174,
			"]" => -174,
			";" => -174,
			'OP02_HASH_THINARROW' => 244
		},
		GOTOS => {
			'VariableRetrieval' => 245
		}
	},
	{#State 160
		ACTIONS => {
			'TYPE_FHREF' => 246
		}
	},
	{#State 161
		DEFAULT => -161
	},
	{#State 162
		ACTIONS => {
			'LPAREN' => 248,
			'LPAREN_MY' => 247
		}
	},
	{#State 163
		DEFAULT => -163
	},
	{#State 164
		DEFAULT => -162
	},
	{#State 165
		ACTIONS => {
			'MY' => 249
		}
	},
	{#State 166
		ACTIONS => {
			'MY' => 251,
			'LPAREN_MY' => 250
		}
	},
	{#State 167
		DEFAULT => -150
	},
	{#State 168
		DEFAULT => -227
	},
	{#State 169
		DEFAULT => -209
	},
	{#State 170
		DEFAULT => -202
	},
	{#State 171
		ACTIONS => {
			'OP20_HASH_FATARROW' => 252
		}
	},
	{#State 172
		DEFAULT => -228
	},
	{#State 173
		DEFAULT => -207,
		GOTOS => {
			'STAR-50' => 253
		}
	},
	{#State 174
		DEFAULT => -226
	},
	{#State 175
		DEFAULT => -203
	},
	{#State 176
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LPAREN' => 132,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 254
		}
	},
	{#State 177
		ACTIONS => {
			")" => 255
		}
	},
	{#State 178
		DEFAULT => -192
	},
	{#State 179
		ACTIONS => {
			"]" => 256
		}
	},
	{#State 180
		ACTIONS => {
			";" => 257
		}
	},
	{#State 181
		DEFAULT => -216
	},
	{#State 182
		DEFAULT => -146
	},
	{#State 183
		ACTIONS => {
			'OP04_MATH_POW' => 194,
			'OP21_LIST_COMMA' => -96,
			'OP17_LIST_RANGE' => -96,
			";" => -96,
			"]" => -96,
			")" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => -96,
			'OP08_STRING_CAT' => 206,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => -96,
			'OP24_LOGICAL_OR_XOR' => -96,
			'OP07_STRING_REPEAT' => 197,
			'OP16_LOGICAL_OR' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP18_TERNARY' => -96,
			"}" => -96,
			'OP13_BITWISE_AND' => -96,
			'OP08_MATH_ADD_SUB' => 192
		}
	},
	{#State 184
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			"}" => -106,
			'OP18_TERNARY' => 202,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			'OP07_STRING_REPEAT' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -106,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP08_STRING_CAT' => 206,
			";" => -106,
			"]" => -106,
			'OP21_LIST_COMMA' => -106,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193
		}
	},
	{#State 185
		DEFAULT => -85
	},
	{#State 186
		ACTIONS => {
			"}" => 258
		}
	},
	{#State 187
		DEFAULT => -210
	},
	{#State 188
		ACTIONS => {
			'LBRACE' => 104
		},
		GOTOS => {
			'HashReference' => 259
		}
	},
	{#State 189
		ACTIONS => {
			")" => 260
		}
	},
	{#State 190
		ACTIONS => {
			'MY' => 151,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACKET' => 109,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'OP01_CLOSE' => 135,
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			")" => -123,
			'WORD' => 25,
			'ARGV' => 155,
			'OP01_QW' => 146,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'OPTIONAL-34' => 262,
			'HashDereference' => 92,
			'Expression' => 148,
			'ListElements' => 261,
			'Literal' => 107,
			'ArrayReference' => 91,
			'SubExpression' => 153,
			'TypeInner' => 147,
			'ListElement' => 152,
			'WordScoped' => 120,
			'Operator' => 110
		}
	},
	{#State 191
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 263,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149
		}
	},
	{#State 192
		ACTIONS => {
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'LITERAL_NUMBER' => 81,
			"undef" => 90,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			'LBRACKET' => 109,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'OP01_CLOSE' => 135,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"\@{" => 127,
			'OP01_OPEN' => 100
		},
		GOTOS => {
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98,
			'SubExpression' => 264,
			'WordScoped' => 120,
			'Operator' => 110,
			'HashDereference' => 92,
			'Expression' => 148,
			'Literal' => 107,
			'ArrayReference' => 91
		}
	},
	{#State 193
		ACTIONS => {
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149,
			'Expression' => 148,
			'HashDereference' => 92,
			'ArrayReference' => 91,
			'Literal' => 107,
			'SubExpression' => 265,
			'Operator' => 110,
			'WordScoped' => 120
		}
	},
	{#State 194
		ACTIONS => {
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LBRACKET' => 109,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93
		},
		GOTOS => {
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91,
			'SubExpression' => 266,
			'WordScoped' => 120,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115
		}
	},
	{#State 195
		ACTIONS => {
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91,
			'SubExpression' => 267,
			'Operator' => 110,
			'WordScoped' => 120
		}
	},
	{#State 196
		ACTIONS => {
			"%{" => 119,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			'LITERAL_NUMBER' => 81,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'Literal' => 107,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'Expression' => 148,
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 268
		}
	},
	{#State 197
		ACTIONS => {
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112
		},
		GOTOS => {
			'SubExpression' => 269,
			'WordScoped' => 120,
			'Operator' => 110,
			'HashDereference' => 92,
			'Expression' => 148,
			'Literal' => 107,
			'ArrayReference' => 91,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 198
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 270
		}
	},
	{#State 199
		ACTIONS => {
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 271,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149
		}
	},
	{#State 200
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 98,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 272,
			'ArrayReference' => 91,
			'Literal' => 107,
			'HashDereference' => 92,
			'Expression' => 148
		}
	},
	{#State 201
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'OP01_CLOSE' => 135,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'HashDereference' => 92,
			'Expression' => 148,
			'Literal' => 107,
			'ArrayReference' => 91,
			'SubExpression' => 273,
			'WordScoped' => 120,
			'Operator' => 110
		}
	},
	{#State 202
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'SELF' => 106,
			'VARIABLE_SYMBOL' => 112,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'Literal' => 274,
			'VariableSymbolOrSelf' => 98,
			'VariableOrLiteral' => 275,
			'Variable' => 276
		}
	},
	{#State 203
		ACTIONS => {
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25
		},
		GOTOS => {
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 277,
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 204
		ACTIONS => {
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			"undef" => 90
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149,
			'HashDereference' => 92,
			'Expression' => 148,
			'ArrayReference' => 91,
			'Literal' => 107,
			'SubExpression' => 278,
			'WordScoped' => 120,
			'Operator' => 110
		}
	},
	{#State 205
		ACTIONS => {
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'LITERAL_NUMBER' => 81,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104
		},
		GOTOS => {
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98,
			'SubExpression' => 279,
			'WordScoped' => 120,
			'Operator' => 110,
			'HashDereference' => 92,
			'Expression' => 148,
			'Literal' => 107,
			'ArrayReference' => 91
		}
	},
	{#State 206
		ACTIONS => {
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90
		},
		GOTOS => {
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 280,
			'Literal' => 107,
			'ArrayReference' => 91,
			'Expression' => 148,
			'HashDereference' => 92,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 207
		ACTIONS => {
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'OP01_CLOSE' => 135,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			"undef" => 90,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114
		},
		GOTOS => {
			'SubExpression' => 281,
			'Operator' => 110,
			'WordScoped' => 120,
			'HashDereference' => 92,
			'Expression' => 148,
			'Literal' => 107,
			'ArrayReference' => 91,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 208
		DEFAULT => -110
	},
	{#State 209
		ACTIONS => {
			'LITERAL_STRING' => 82,
			'MY' => 151,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'OP01_CLOSE' => 135,
			"undef" => 90,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98,
			'ListElement' => 152,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 153,
			'TypeInner' => 147,
			'Literal' => 107,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'ListElements' => 282,
			'Expression' => 148
		}
	},
	{#State 210
		DEFAULT => -109
	},
	{#State 211
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'MY' => 151,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'Operator' => 110,
			'WordScoped' => 120,
			'ListElement' => 152,
			'SubExpression' => 153,
			'TypeInner' => 147,
			'ArrayReference' => 91,
			'Literal' => 107,
			'HashDereference' => 92,
			'Expression' => 148,
			'ListElements' => 283,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 212
		ACTIONS => {
			'VARIABLE_SYMBOL' => 284
		}
	},
	{#State 213
		ACTIONS => {
			'FHREF_SYMBOL' => 285
		}
	},
	{#State 214
		ACTIONS => {
			"}" => 286
		}
	},
	{#State 215
		DEFAULT => -195
	},
	{#State 216
		ACTIONS => {
			'LBRACKET' => 109
		},
		GOTOS => {
			'ArrayReference' => 287
		}
	},
	{#State 217
		ACTIONS => {
			'LPAREN' => 288
		}
	},
	{#State 218
		ACTIONS => {
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'FHREF_SYMBOL_IN' => 292,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'STDIN' => 290,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90
		},
		GOTOS => {
			'Literal' => 107,
			'ArrayReference' => 91,
			'SubExpressionOrInput' => 289,
			'Expression' => 148,
			'HashDereference' => 92,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 291,
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115
		}
	},
	{#State 219
		DEFAULT => -86
	},
	{#State 220
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 293
		}
	},
	{#State 221
		ACTIONS => {
			'OP07_STRING_REPEAT' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP08_STRING_CAT' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			")" => -81,
			";" => -81,
			'OP17_LIST_RANGE' => -81,
			'OP21_LIST_COMMA' => -188,
			'OP04_MATH_POW' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP18_TERNARY' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP16_LOGICAL_OR' => -81
		}
	},
	{#State 222
		ACTIONS => {
			'OP21_LIST_COMMA' => 294
		}
	},
	{#State 223
		DEFAULT => -16
	},
	{#State 224
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 295
		}
	},
	{#State 225
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			'OP18_TERNARY' => 202,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			")" => 296,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP23_LOGICAL_AND' => 207,
			'OP06_REGEX_MATCH' => 198
		}
	},
	{#State 226
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LITERAL_STRING' => 82,
			'MY' => 151,
			'OP05_MATH_NEG_LPAREN' => 97
		},
		GOTOS => {
			'Literal' => 107,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'Expression' => 148,
			'ListElement' => 297,
			'WordScoped' => 120,
			'Operator' => 110,
			'TypeInner' => 147,
			'SubExpression' => 221,
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115
		}
	},
	{#State 227
		DEFAULT => -78
	},
	{#State 228
		DEFAULT => -153
	},
	{#State 229
		DEFAULT => -84
	},
	{#State 230
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 298
		}
	},
	{#State 231
		DEFAULT => -51,
		GOTOS => {
			'STAR-20' => 299
		}
	},
	{#State 232
		ACTIONS => {
			";" => 300
		}
	},
	{#State 233
		DEFAULT => -46
	},
	{#State 234
		ACTIONS => {
			"our" => 303,
			'LITERAL_NUMBER' => 305
		},
		GOTOS => {
			'Subroutine' => 302,
			'Method' => 301,
			'MethodOrSubroutine' => 304
		}
	},
	{#State 235
		ACTIONS => {
			'LBRACE' => 306
		}
	},
	{#State 236
		ACTIONS => {
			";" => 307
		}
	},
	{#State 237
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP18_TERNARY' => 202,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -189,
			'OP11_COMPARE_LT_GT' => 204,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			";" => -189,
			"]" => -189,
			'OP21_LIST_COMMA' => -189,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193
		}
	},
	{#State 238
		ACTIONS => {
			"]" => -81,
			";" => -81,
			'OP17_LIST_RANGE' => -81,
			'OP04_MATH_POW' => -81,
			'OP21_LIST_COMMA' => -81,
			'OP07_STRING_REPEAT' => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP06_REGEX_MATCH' => -81,
			'OP23_LOGICAL_AND' => -81,
			'OP08_STRING_CAT' => -81,
			'OP11_COMPARE_LT_GT' => -81,
			'OP09_BITWISE_SHIFT' => -81,
			'OP07_MATH_MULT_DIV_MOD' => -81,
			")" => -81,
			'OP15_LOGICAL_AND' => -81,
			'OP14_BITWISE_OR_XOR' => -81,
			'OP12_COMPARE_EQ_NE' => -81,
			'OP16_LOGICAL_OR' => -81,
			'OP13_BITWISE_AND' => -81,
			'OP08_MATH_ADD_SUB' => -81,
			'OP18_TERNARY' => -81,
			"}" => -81
		}
	},
	{#State 239
		ACTIONS => {
			"\$TYPED_" => 308
		}
	},
	{#State 240
		ACTIONS => {
			")" => -187,
			'OP21_LIST_COMMA' => 310,
			";" => -187,
			"]" => -187
		},
		GOTOS => {
			'PAREN-44' => 309
		}
	},
	{#State 241
		DEFAULT => -118
	},
	{#State 242
		DEFAULT => -89
	},
	{#State 243
		ACTIONS => {
			"undef" => 90,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'OP01_CLOSE' => 135
		},
		GOTOS => {
			'SubExpression' => 311,
			'Operator' => 110,
			'WordScoped' => 120,
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 244
		ACTIONS => {
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"%{" => 119,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'LITERAL_NUMBER' => 81,
			'WORD' => 313,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149,
			'HashDereference' => 92,
			'Expression' => 148,
			'ArrayReference' => 91,
			'Literal' => 107,
			'SubExpression' => 312,
			'Operator' => 110,
			'WordScoped' => 120
		}
	},
	{#State 245
		DEFAULT => -172
	},
	{#State 246
		ACTIONS => {
			'FHREF_SYMBOL' => 314
		}
	},
	{#State 247
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 315
		}
	},
	{#State 248
		ACTIONS => {
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119
		},
		GOTOS => {
			'SubExpression' => 316,
			'WordScoped' => 120,
			'Operator' => 110,
			'HashDereference' => 92,
			'Expression' => 148,
			'Literal' => 107,
			'ArrayReference' => 91,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 249
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 55,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 317
		}
	},
	{#State 250
		ACTIONS => {
			'TYPE_INTEGER' => 318
		}
	},
	{#State 251
		ACTIONS => {
			'TYPE_INTEGER' => 319
		}
	},
	{#State 252
		ACTIONS => {
			'WORD_SCOPED' => -200,
			'VARIABLE_SYMBOL' => -200,
			'WORD' => -200,
			"undef" => -200,
			'OP10_NAMED_UNARY' => -200,
			'CONSTANT_CALL_SCOPED' => -200,
			'OP22_LOGICAL_NEG' => -200,
			'OP03_MATH_INC_DEC' => -200,
			'OP05_LOGICAL_NEG' => -200,
			"%{" => -200,
			'LITERAL_NUMBER' => -200,
			'OP05_MATH_NEG_LPAREN' => -200,
			'MY' => 151,
			'LITERAL_STRING' => -200,
			'OP01_OPEN' => -200,
			"\@{" => -200,
			'LBRACE' => -200,
			'OP01_NAMED' => -200,
			'WORD_UPPERCASE' => -200,
			'LPAREN' => -200,
			'SELF' => -200,
			'LBRACKET' => -200,
			'OP01_CLOSE' => -200
		},
		GOTOS => {
			'OPTIONAL-48' => 321,
			'TypeInner' => 320
		}
	},
	{#State 253
		ACTIONS => {
			'OP21_LIST_COMMA' => 324,
			"}" => 323
		},
		GOTOS => {
			'PAREN-49' => 322
		}
	},
	{#State 254
		ACTIONS => {
			")" => 325,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP09_BITWISE_SHIFT' => 205,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193,
			'OP18_TERNARY' => 202,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201
		}
	},
	{#State 255
		DEFAULT => -127
	},
	{#State 256
		DEFAULT => -194
	},
	{#State 257
		DEFAULT => -121
	},
	{#State 258
		DEFAULT => -212
	},
	{#State 259
		ACTIONS => {
			"}" => 326
		}
	},
	{#State 260
		DEFAULT => -131
	},
	{#State 261
		DEFAULT => -122
	},
	{#State 262
		ACTIONS => {
			")" => 327
		}
	},
	{#State 263
		ACTIONS => {
			"}" => -99,
			'OP18_TERNARY' => -99,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => -99,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP16_LOGICAL_OR' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP11_COMPARE_LT_GT' => 204,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -99,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP07_STRING_REPEAT' => 197,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => -99,
			'OP17_LIST_RANGE' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP04_MATH_POW' => 194,
			"]" => -99,
			";" => -99
		}
	},
	{#State 264
		ACTIONS => {
			'OP17_LIST_RANGE' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP04_MATH_POW' => 194,
			"]" => -93,
			";" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP08_STRING_CAT' => -93,
			'OP11_COMPARE_LT_GT' => -93,
			")" => -93,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => -93,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP15_LOGICAL_AND' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			"}" => -93,
			'OP18_TERNARY' => -93,
			'OP08_MATH_ADD_SUB' => -93,
			'OP13_BITWISE_AND' => -93
		}
	},
	{#State 265
		ACTIONS => {
			"]" => -104,
			";" => -104,
			'OP17_LIST_RANGE' => undef,
			'OP04_MATH_POW' => 194,
			'OP21_LIST_COMMA' => -104,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP23_LOGICAL_AND' => -104,
			'OP06_REGEX_MATCH' => 198,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -104,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => -104,
			"}" => -104
		}
	},
	{#State 266
		ACTIONS => {
			'OP23_LOGICAL_AND' => -87,
			'OP06_REGEX_MATCH' => -87,
			'OP24_LOGICAL_OR_XOR' => -87,
			'OP07_STRING_REPEAT' => -87,
			'OP07_MATH_MULT_DIV_MOD' => -87,
			")" => -87,
			'OP11_COMPARE_LT_GT' => -87,
			'OP09_BITWISE_SHIFT' => -87,
			'OP08_STRING_CAT' => -87,
			";" => -87,
			"]" => -87,
			'OP21_LIST_COMMA' => -87,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => -87,
			'OP08_MATH_ADD_SUB' => -87,
			'OP13_BITWISE_AND' => -87,
			"}" => -87,
			'OP18_TERNARY' => -87,
			'OP15_LOGICAL_AND' => -87,
			'OP14_BITWISE_OR_XOR' => -87,
			'OP16_LOGICAL_OR' => -87,
			'OP12_COMPARE_EQ_NE' => -87
		}
	},
	{#State 267
		ACTIONS => {
			'OP15_LOGICAL_AND' => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP08_MATH_ADD_SUB' => -92,
			'OP13_BITWISE_AND' => -92,
			"}" => -92,
			'OP18_TERNARY' => -92,
			";" => -92,
			"]" => -92,
			'OP21_LIST_COMMA' => -92,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP06_REGEX_MATCH' => 198,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP07_STRING_REPEAT' => 197,
			")" => -92,
			'OP07_MATH_MULT_DIV_MOD' => -92,
			'OP08_STRING_CAT' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			'OP09_BITWISE_SHIFT' => -92
		}
	},
	{#State 268
		ACTIONS => {
			'OP04_MATH_POW' => 194,
			'OP21_LIST_COMMA' => -108,
			'OP17_LIST_RANGE' => 193,
			";" => -108,
			"]" => -108,
			")" => -108,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => -108,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP18_TERNARY' => 202,
			"}" => -108,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192
		}
	},
	{#State 269
		ACTIONS => {
			'OP18_TERNARY' => -91,
			"}" => -91,
			'OP13_BITWISE_AND' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => -91,
			")" => -91,
			'OP08_STRING_CAT' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP07_STRING_REPEAT' => -91,
			'OP04_MATH_POW' => 194,
			'OP21_LIST_COMMA' => -91,
			'OP17_LIST_RANGE' => -91,
			";" => -91,
			"]" => -91
		}
	},
	{#State 270
		DEFAULT => -90
	},
	{#State 271
		ACTIONS => {
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => -103,
			"}" => -103,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => -103,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => -103,
			'OP23_LOGICAL_AND' => -103,
			'OP06_REGEX_MATCH' => 198,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			")" => -103,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			"]" => -103,
			";" => -103,
			'OP17_LIST_RANGE' => -103,
			'OP04_MATH_POW' => 194,
			'OP21_LIST_COMMA' => -103
		}
	},
	{#State 272
		ACTIONS => {
			'OP21_LIST_COMMA' => -102,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => -102,
			";" => -102,
			"]" => -102,
			")" => -102,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP07_STRING_REPEAT' => 197,
			'OP16_LOGICAL_OR' => -102,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => -102,
			"}" => -102,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203
		}
	},
	{#State 273
		ACTIONS => {
			"}" => -101,
			'OP18_TERNARY' => -101,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => -101,
			'OP15_LOGICAL_AND' => -101,
			'OP14_BITWISE_OR_XOR' => -101,
			'OP11_COMPARE_LT_GT' => 204,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP07_STRING_REPEAT' => 197,
			'OP23_LOGICAL_AND' => -101,
			'OP06_REGEX_MATCH' => 198,
			'OP17_LIST_RANGE' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP04_MATH_POW' => 194,
			"]" => -101,
			";" => -101
		}
	},
	{#State 274
		DEFAULT => -225
	},
	{#State 275
		ACTIONS => {
			'COLON' => 328
		}
	},
	{#State 276
		DEFAULT => -224
	},
	{#State 277
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => -100,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => -100,
			"}" => -100,
			'OP18_TERNARY' => -100,
			"]" => -100,
			";" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP21_LIST_COMMA' => -100,
			'OP04_MATH_POW' => 194,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP06_REGEX_MATCH' => 198,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -100
		}
	},
	{#State 278
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -98,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => undef,
			'OP23_LOGICAL_AND' => -98,
			'OP06_REGEX_MATCH' => 198,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP07_STRING_REPEAT' => 197,
			'OP21_LIST_COMMA' => -98,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => -98,
			";" => -98,
			"]" => -98,
			"}" => -98,
			'OP18_TERNARY' => -98,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP12_COMPARE_EQ_NE' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP15_LOGICAL_AND' => -98
		}
	},
	{#State 279
		ACTIONS => {
			'OP13_BITWISE_AND' => -95,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => -95,
			"}" => -95,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP23_LOGICAL_AND' => -95,
			'OP06_REGEX_MATCH' => 198,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -95,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			";" => -95,
			"]" => -95,
			'OP04_MATH_POW' => 194,
			'OP21_LIST_COMMA' => -95,
			'OP17_LIST_RANGE' => -95
		}
	},
	{#State 280
		ACTIONS => {
			'OP23_LOGICAL_AND' => -94,
			'OP06_REGEX_MATCH' => 198,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP08_STRING_CAT' => -94,
			'OP09_BITWISE_SHIFT' => -94,
			";" => -94,
			"]" => -94,
			'OP21_LIST_COMMA' => -94,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => -94,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => -94,
			"}" => -94,
			'OP18_TERNARY' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP16_LOGICAL_OR' => -94,
			'OP12_COMPARE_EQ_NE' => -94
		}
	},
	{#State 281
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP08_STRING_CAT' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -107,
			'OP24_LOGICAL_OR_XOR' => -107,
			'OP07_STRING_REPEAT' => 197,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => -107,
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194,
			'OP21_LIST_COMMA' => -107,
			"]" => -107,
			";" => -107,
			'OP18_TERNARY' => 202,
			"}" => -107,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200
		}
	},
	{#State 282
		ACTIONS => {
			";" => 329
		}
	},
	{#State 283
		ACTIONS => {
			";" => 330
		}
	},
	{#State 284
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 331,
			'OP02_ARRAY_THINARROW' => 332,
			";" => 333
		}
	},
	{#State 285
		ACTIONS => {
			";" => 334
		}
	},
	{#State 286
		DEFAULT => -197
	},
	{#State 287
		ACTIONS => {
			"}" => 335
		}
	},
	{#State 288
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			")" => -125,
			"undef" => 90,
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'MY' => 151
		},
		GOTOS => {
			'OPTIONAL-35' => 337,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 98,
			'SubExpression' => 153,
			'TypeInner' => 147,
			'WordScoped' => 120,
			'Operator' => 110,
			'ListElement' => 152,
			'HashDereference' => 92,
			'ListElements' => 336,
			'Expression' => 148,
			'ArrayReference' => 91,
			'Literal' => 107
		}
	},
	{#State 289
		DEFAULT => -182
	},
	{#State 290
		DEFAULT => -143
	},
	{#State 291
		ACTIONS => {
			";" => -141,
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP11_COMPARE_LT_GT' => 204,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			")" => -141,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => 202
		}
	},
	{#State 292
		DEFAULT => -142
	},
	{#State 293
		ACTIONS => {
			'OP18_TERNARY' => 202,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			")" => -183,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193,
			";" => -183
		}
	},
	{#State 294
		ACTIONS => {
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LPAREN' => 132,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'MY' => 151,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Literal' => 107,
			'ListElements' => 338,
			'HashDereference' => 92,
			'Expression' => 148,
			'WordScoped' => 120,
			'Operator' => 110,
			'ListElement' => 152,
			'SubExpression' => 153,
			'TypeInner' => 147,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149
		}
	},
	{#State 295
		ACTIONS => {
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'OP05_MATH_NEG_LPAREN' => 97,
			'MY' => 151,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'CONSTANT_CALL_SCOPED' => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'Literal' => 107,
			'ArrayReference' => 91,
			'ListElements' => 339,
			'HashDereference' => 92,
			'Expression' => 148,
			'ListElement' => 152,
			'WordScoped' => 120,
			'Operator' => 110,
			'TypeInner' => 147,
			'SubExpression' => 153
		}
	},
	{#State 296
		DEFAULT => -140
	},
	{#State 297
		ACTIONS => {
			'OP21_LIST_COMMA' => 340
		}
	},
	{#State 298
		DEFAULT => -223
	},
	{#State 299
		ACTIONS => {
			")" => 341,
			'OP21_LIST_COMMA' => 342
		},
		GOTOS => {
			'PAREN-19' => 343
		}
	},
	{#State 300
		DEFAULT => -48
	},
	{#State 301
		DEFAULT => -76
	},
	{#State 302
		DEFAULT => -77
	},
	{#State 303
		ACTIONS => {
			'TYPE_METHOD' => 344,
			'WORD' => 55,
			'WORD_SCOPED' => 54,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 53
		}
	},
	{#State 304
		DEFAULT => -59
	},
	{#State 305
		ACTIONS => {
			";" => 345
		}
	},
	{#State 306
		ACTIONS => {
			"}" => 347,
			'WORD' => 346
		},
		GOTOS => {
			'HashEntryProperties' => 348
		}
	},
	{#State 307
		DEFAULT => -117
	},
	{#State 308
		ACTIONS => {
			'WORD' => 349
		}
	},
	{#State 309
		DEFAULT => -185
	},
	{#State 310
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => 116,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'LITERAL_NUMBER' => 81,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'LITERAL_STRING' => 82,
			'MY' => 151,
			'OP05_MATH_NEG_LPAREN' => 97,
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106
		},
		GOTOS => {
			'TypeInner' => 147,
			'SubExpression' => 153,
			'Operator' => 110,
			'WordScoped' => 120,
			'ListElement' => 350,
			'Expression' => 148,
			'HashDereference' => 92,
			'ArrayReference' => 91,
			'Literal' => 107,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 311
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP18_TERNARY' => 202,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194,
			"]" => 351,
			'OP11_COMPARE_LT_GT' => 204,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP23_LOGICAL_AND' => 207,
			'OP06_REGEX_MATCH' => 198
		}
	},
	{#State 312
		ACTIONS => {
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => 202,
			"}" => 352,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP11_COMPARE_LT_GT' => 204,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194
		}
	},
	{#State 313
		ACTIONS => {
			"}" => 353,
			'LPAREN' => -214,
			'OP02_METHOD_THINARROW_NEW' => -214
		}
	},
	{#State 314
		ACTIONS => {
			'OP21_LIST_COMMA' => 354
		}
	},
	{#State 315
		ACTIONS => {
			'VARIABLE_SYMBOL' => 355
		}
	},
	{#State 316
		ACTIONS => {
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => 356,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP23_LOGICAL_AND' => 207,
			'OP06_REGEX_MATCH' => 198,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			'OP18_TERNARY' => 202,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192
		}
	},
	{#State 317
		ACTIONS => {
			'VARIABLE_SYMBOL' => 357
		}
	},
	{#State 318
		ACTIONS => {
			'VARIABLE_SYMBOL' => 358
		}
	},
	{#State 319
		ACTIONS => {
			'VARIABLE_SYMBOL' => 359
		}
	},
	{#State 320
		DEFAULT => -199
	},
	{#State 321
		ACTIONS => {
			"undef" => 90,
			'WORD' => 25,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"%{" => 119,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'OP01_CLOSE' => 135
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149,
			'VariableSymbolOrSelf' => 98,
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 360,
			'ArrayReference' => 91,
			'Literal' => 107,
			'HashDereference' => 92,
			'Expression' => 148
		}
	},
	{#State 322
		DEFAULT => -206
	},
	{#State 323
		DEFAULT => -208
	},
	{#State 324
		ACTIONS => {
			'WORD' => 172,
			'SELF' => 106,
			'VARIABLE_SYMBOL' => 112,
			"%{" => 119,
			'LITERAL_STRING' => 82,
			'ENV' => 175,
			'LITERAL_NUMBER' => 81
		},
		GOTOS => {
			'Variable' => 174,
			'VariableOrLiteralOrWord' => 171,
			'HashDereference' => 170,
			'VariableSymbolOrSelf' => 98,
			'HashEntry' => 361,
			'Literal' => 168
		}
	},
	{#State 325
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 363
		}
	},
	{#State 326
		DEFAULT => -213
	},
	{#State 327
		DEFAULT => -129
	},
	{#State 328
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'VARIABLE_SYMBOL' => 112,
			'SELF' => 106,
			'LITERAL_STRING' => 82
		},
		GOTOS => {
			'Variable' => 276,
			'VariableOrLiteral' => 364,
			'VariableSymbolOrSelf' => 98,
			'Literal' => 274
		}
	},
	{#State 329
		DEFAULT => -115
	},
	{#State 330
		DEFAULT => -114
	},
	{#State 331
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'STDIN' => 290,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			"undef" => 90,
			'FHREF_SYMBOL_IN' => 292,
			'LITERAL_NUMBER' => 81,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'LBRACKET' => 109
		},
		GOTOS => {
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98,
			'SubExpression' => 291,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpressionOrInput' => 365,
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91
		}
	},
	{#State 332
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LPAREN' => 132,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97
		},
		GOTOS => {
			'Expression' => 148,
			'HashDereference' => 92,
			'ArrayReference' => 91,
			'Literal' => 107,
			'SubExpression' => 366,
			'WordScoped' => 120,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130
		}
	},
	{#State 333
		DEFAULT => -178
	},
	{#State 334
		DEFAULT => -181
	},
	{#State 335
		DEFAULT => -198
	},
	{#State 336
		DEFAULT => -124
	},
	{#State 337
		ACTIONS => {
			")" => 367
		}
	},
	{#State 338
		ACTIONS => {
			";" => 368
		}
	},
	{#State 339
		ACTIONS => {
			")" => 369
		}
	},
	{#State 340
		ACTIONS => {
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'MY' => 151,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_NUMBER' => 81,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP01_QW' => 146,
			'ARGV' => 155,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25
		},
		GOTOS => {
			'ListElement' => 152,
			'WordScoped' => 120,
			'Operator' => 110,
			'TypeInner' => 147,
			'SubExpression' => 153,
			'Literal' => 107,
			'ArrayReference' => 91,
			'Expression' => 148,
			'ListElements' => 370,
			'HashDereference' => 92,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 341
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 371
		}
	},
	{#State 342
		ACTIONS => {
			'MY' => 372
		}
	},
	{#State 343
		DEFAULT => -50
	},
	{#State 344
		ACTIONS => {
			'VARIABLE_SYMBOL' => 373
		}
	},
	{#State 345
		DEFAULT => -61
	},
	{#State 346
		ACTIONS => {
			'OP20_HASH_FATARROW' => 374
		}
	},
	{#State 347
		ACTIONS => {
			";" => 375
		}
	},
	{#State 348
		DEFAULT => -64,
		GOTOS => {
			'STAR-26' => 376
		}
	},
	{#State 349
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 350
		DEFAULT => -184
	},
	{#State 351
		DEFAULT => -175
	},
	{#State 352
		DEFAULT => -176
	},
	{#State 353
		DEFAULT => -177
	},
	{#State 354
		ACTIONS => {
			'LITERAL_STRING' => 378
		}
	},
	{#State 355
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 379
		}
	},
	{#State 356
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 380
		}
	},
	{#State 357
		ACTIONS => {
			'LPAREN' => 381
		}
	},
	{#State 358
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 382
		}
	},
	{#State 359
		ACTIONS => {
			'LPAREN' => 383
		}
	},
	{#State 360
		ACTIONS => {
			'OP17_LIST_RANGE' => 193,
			'OP21_LIST_COMMA' => -201,
			'OP04_MATH_POW' => 194,
			'OP11_COMPARE_LT_GT' => 204,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			"}" => -201,
			'OP18_TERNARY' => 202,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203
		}
	},
	{#State 361
		DEFAULT => -205
	},
	{#State 362
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"undef" => 90,
			'OP01_NAMED_VOID' => 94,
			'OP05_LOGICAL_NEG' => 93,
			'OP01_OPEN' => 100,
			'LBRACE' => 104,
			"if" => 105,
			'OP05_MATH_NEG_LPAREN' => 97,
			"for" => -148,
			'WORD_UPPERCASE' => 108,
			'SELF' => 106,
			'LBRACKET' => 109,
			"foreach" => -148,
			'OP10_NAMED_UNARY' => 114,
			"while" => -148,
			'CONSTANT_CALL_SCOPED' => 116,
			'VARIABLE_SYMBOL' => 112,
			'OP19_LOOP_CONTROL' => 111,
			'LITERAL_NUMBER' => 81,
			'OP01_PRINT' => 123,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			"\@{" => 127,
			'OP01_NAMED' => 129,
			'MY' => 124,
			'OP19_LOOP_CONTROL_SCOLON' => 125,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'LPAREN' => 132
		},
		GOTOS => {
			'Literal' => 107,
			'Expression' => 133,
			'Operator' => 110,
			'VariableModification' => 134,
			'PAREN-36' => 99,
			'VariableSymbolOrSelf' => 98,
			'VariableDeclaration' => 126,
			'OPTIONAL-37' => 101,
			'Statement' => 103,
			'Conditional' => 102,
			'Variable' => 128,
			'HashReference' => 130,
			'PLUS-42' => 384,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'WordScoped' => 120,
			'SubExpression' => 121,
			'OperatorVoid' => 122,
			'Operation' => 385,
			'LoopLabel' => 113,
			'ArrayDereference' => 115
		}
	},
	{#State 363
		DEFAULT => -156,
		GOTOS => {
			'STAR-39' => 386
		}
	},
	{#State 364
		DEFAULT => -105
	},
	{#State 365
		ACTIONS => {
			";" => 387
		}
	},
	{#State 366
		ACTIONS => {
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			"]" => 388,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP18_TERNARY' => 202,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191
		}
	},
	{#State 367
		DEFAULT => -130
	},
	{#State 368
		DEFAULT => -119
	},
	{#State 369
		DEFAULT => -80
	},
	{#State 370
		ACTIONS => {
			")" => 389
		}
	},
	{#State 371
		ACTIONS => {
			"\@_;" => 390
		}
	},
	{#State 372
		ACTIONS => {
			'WORD_SCOPED' => 54,
			'WORD' => 55,
			'TYPE_INTEGER' => 52
		},
		GOTOS => {
			'Type' => 391
		}
	},
	{#State 373
		ACTIONS => {
			"= sub {" => 392
		}
	},
	{#State 374
		ACTIONS => {
			'MY' => 393
		},
		GOTOS => {
			'TypeInnerProperties' => 394
		}
	},
	{#State 375
		DEFAULT => -66
	},
	{#State 376
		ACTIONS => {
			"}" => 397,
			'OP21_LIST_COMMA' => 395
		},
		GOTOS => {
			'PAREN-25' => 396
		}
	},
	{#State 377
		DEFAULT => -220
	},
	{#State 378
		ACTIONS => {
			'OP21_LIST_COMMA' => 398
		}
	},
	{#State 379
		ACTIONS => {
			"undef" => 90,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'STDIN' => 290,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"%{" => 119,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'LITERAL_NUMBER' => 81,
			'FHREF_SYMBOL_IN' => 292,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'LBRACKET' => 109,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'OP01_CLOSE' => 135
		},
		GOTOS => {
			'Expression' => 148,
			'HashDereference' => 92,
			'SubExpressionOrInput' => 399,
			'ArrayReference' => 91,
			'Literal' => 107,
			'SubExpression' => 291,
			'WordScoped' => 120,
			'Operator' => 110,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'HashReference' => 130,
			'Variable' => 149
		}
	},
	{#State 380
		DEFAULT => -167
	},
	{#State 381
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'OP01_QW' => 146,
			'CONSTANT_CALL_SCOPED' => 116,
			'ARGV' => 155,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'MY' => 151,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'LBRACKET' => 109
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'HashDereference' => 92,
			'Expression' => 148,
			'ListElements' => 400,
			'Literal' => 107,
			'ArrayReference' => 91,
			'TypeInner' => 147,
			'SubExpression' => 153,
			'ListElement' => 152,
			'WordScoped' => 120,
			'Operator' => 110
		}
	},
	{#State 382
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'SELF' => 106,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97
		},
		GOTOS => {
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'VariableSymbolOrSelf' => 98,
			'SubExpression' => 401,
			'WordScoped' => 120,
			'Operator' => 110,
			'Expression' => 148,
			'HashDereference' => 92,
			'ArrayReference' => 91,
			'Literal' => 107
		}
	},
	{#State 383
		ACTIONS => {
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'OP01_CLOSE' => 135
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'Literal' => 107,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'Expression' => 148,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 402
		}
	},
	{#State 384
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 111,
			'VARIABLE_SYMBOL' => 112,
			'CONSTANT_CALL_SCOPED' => 116,
			"while" => -148,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 118,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'OP01_PRINT' => 123,
			'LITERAL_STRING' => 82,
			'MY' => 124,
			'OP19_LOOP_CONTROL_SCOLON' => 125,
			'OP01_NAMED' => 129,
			"\@{" => 127,
			'LPAREN' => 132,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'OP01_CLOSE' => 135,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP05_LOGICAL_NEG' => 93,
			'OP01_NAMED_VOID' => 94,
			"}" => 403,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			"if" => 105,
			'OP01_OPEN' => 100,
			'LBRACKET' => 109,
			"foreach" => -148,
			'SELF' => 106,
			'WORD_UPPERCASE' => 108,
			"for" => -148
		},
		GOTOS => {
			'OPTIONAL-37' => 101,
			'Conditional' => 102,
			'Statement' => 103,
			'HashReference' => 130,
			'Variable' => 128,
			'VariableDeclaration' => 126,
			'VariableSymbolOrSelf' => 98,
			'PAREN-36' => 99,
			'Operator' => 110,
			'VariableModification' => 134,
			'Literal' => 107,
			'Expression' => 133,
			'ArrayDereference' => 115,
			'LoopLabel' => 113,
			'WordScoped' => 120,
			'OperatorVoid' => 122,
			'SubExpression' => 121,
			'Operation' => 404,
			'ArrayReference' => 91,
			'HashDereference' => 92
		}
	},
	{#State 385
		DEFAULT => -170
	},
	{#State 386
		ACTIONS => {
			'OP01_NAMED_VOID_SCOLON' => -159,
			'OP01_CLOSE' => -159,
			'LPAREN' => -159,
			"\@{" => -159,
			'OP01_NAMED' => -159,
			'OP19_LOOP_CONTROL_SCOLON' => -159,
			'MY' => -159,
			'LITERAL_STRING' => -159,
			'LITERAL_NUMBER' => -159,
			'OP01_PRINT' => -159,
			'OP22_LOGICAL_NEG' => -159,
			'OP03_MATH_INC_DEC' => -159,
			"%{" => -159,
			"while" => -159,
			'OP10_NAMED_UNARY' => -159,
			'CONSTANT_CALL_SCOPED' => -159,
			'OP19_LOOP_CONTROL' => -159,
			'VARIABLE_SYMBOL' => -159,
			"for" => -159,
			'WORD_UPPERCASE' => -159,
			'SELF' => -159,
			'' => -159,
			'LBRACKET' => -159,
			"foreach" => -159,
			'OP01_OPEN' => -159,
			"else" => 409,
			'LBRACE' => -159,
			"if" => -159,
			'OP05_MATH_NEG_LPAREN' => -159,
			"}" => -159,
			'OP01_NAMED_VOID' => -159,
			"elsif" => 407,
			'OP05_LOGICAL_NEG' => -159,
			'WORD_SCOPED' => -159,
			'WORD' => -159,
			'OP01_NAMED_VOID_LPAREN' => -159,
			"undef" => -159
		},
		GOTOS => {
			'PAREN-38' => 406,
			'OPTIONAL-41' => 405,
			'PAREN-40' => 408
		}
	},
	{#State 387
		DEFAULT => -179
	},
	{#State 388
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 410
		}
	},
	{#State 389
		DEFAULT => -82
	},
	{#State 390
		DEFAULT => -52
	},
	{#State 391
		ACTIONS => {
			'VARIABLE_SYMBOL' => 411
		}
	},
	{#State 392
		ACTIONS => {
			'CONSTANT_CALL_SCOPED' => -68,
			'OP10_NAMED_UNARY' => -68,
			"while" => -68,
			'OP19_LOOP_CONTROL' => -68,
			'VARIABLE_SYMBOL' => -68,
			'OP01_PRINT' => -68,
			'LITERAL_NUMBER' => -68,
			'OP03_MATH_INC_DEC' => -68,
			'OP22_LOGICAL_NEG' => -68,
			"%{" => -68,
			'OP01_NAMED' => -68,
			"\@{" => -68,
			'LITERAL_STRING' => -68,
			'OP19_LOOP_CONTROL_SCOLON' => -68,
			'MY' => -68,
			'OP01_NAMED_VOID_SCOLON' => -68,
			'OP01_CLOSE' => -68,
			'LPAREN' => -68,
			'LPAREN_MY' => 414,
			'OP01_NAMED_VOID_LPAREN' => -68,
			"undef" => -68,
			'WORD_SCOPED' => -68,
			'WORD' => -68,
			'OP01_NAMED_VOID' => -68,
			'OP05_LOGICAL_NEG' => -68,
			'LBRACE' => -68,
			"if" => -68,
			'OP01_OPEN' => -68,
			"}" => -68,
			'OP05_MATH_NEG_LPAREN' => -68,
			"for" => -68,
			"foreach" => -68,
			'LBRACKET' => -68,
			'SELF' => -68,
			'WORD_UPPERCASE' => -68
		},
		GOTOS => {
			'MethodArguments' => 413,
			'OPTIONAL-27' => 412
		}
	},
	{#State 393
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 55,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 415
		}
	},
	{#State 394
		DEFAULT => -204
	},
	{#State 395
		ACTIONS => {
			'WORD' => 346
		},
		GOTOS => {
			'HashEntryProperties' => 416
		}
	},
	{#State 396
		DEFAULT => -63
	},
	{#State 397
		ACTIONS => {
			";" => 417
		}
	},
	{#State 398
		ACTIONS => {
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			"\@{" => 127,
			'OP01_OPEN' => 100,
			'OP01_NAMED' => 150,
			'LBRACE' => 104,
			"%{" => 119,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			'LITERAL_NUMBER' => 81,
			'WORD' => 25,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 418
		}
	},
	{#State 399
		ACTIONS => {
			")" => 419
		}
	},
	{#State 400
		ACTIONS => {
			")" => 420
		}
	},
	{#State 401
		ACTIONS => {
			'OP18_TERNARY' => 202,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP09_BITWISE_SHIFT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP23_LOGICAL_AND' => 207,
			'OP06_REGEX_MATCH' => 198,
			'OP17_LIST_RANGE' => 193,
			'OP04_MATH_POW' => 194,
			";" => 421
		}
	},
	{#State 402
		ACTIONS => {
			'OP18_TERNARY' => 202,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP08_STRING_CAT' => 206,
			'OP23_LOGICAL_AND' => 207,
			'OP06_REGEX_MATCH' => 198,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 422
		}
	},
	{#State 403
		DEFAULT => -171
	},
	{#State 404
		DEFAULT => -169
	},
	{#State 405
		DEFAULT => -160
	},
	{#State 406
		DEFAULT => -155
	},
	{#State 407
		ACTIONS => {
			'LPAREN' => 423
		}
	},
	{#State 408
		DEFAULT => -158
	},
	{#State 409
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 424
		}
	},
	{#State 410
		ACTIONS => {
			"undef" => 425
		}
	},
	{#State 411
		DEFAULT => -49
	},
	{#State 412
		DEFAULT => -70,
		GOTOS => {
			'STAR-28' => 426
		}
	},
	{#State 413
		DEFAULT => -67
	},
	{#State 414
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD_SCOPED' => 54,
			'WORD' => 55
		},
		GOTOS => {
			'Type' => 427
		}
	},
	{#State 415
		ACTIONS => {
			"\$TYPED_" => 428
		}
	},
	{#State 416
		DEFAULT => -62
	},
	{#State 417
		DEFAULT => -65
	},
	{#State 418
		ACTIONS => {
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => 202,
			"}" => -83,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP23_LOGICAL_AND' => -83,
			'OP06_REGEX_MATCH' => 198,
			'OP24_LOGICAL_OR_XOR' => -83,
			'OP07_STRING_REPEAT' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -83,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			";" => -83,
			"]" => -83,
			'OP04_MATH_POW' => 194,
			'OP21_LIST_COMMA' => -83,
			'OP17_LIST_RANGE' => 193
		}
	},
	{#State 419
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 429
		}
	},
	{#State 420
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 430
		}
	},
	{#State 421
		ACTIONS => {
			'VARIABLE_SYMBOL' => 431
		}
	},
	{#State 422
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			'LBRACKET' => 109,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'OP01_CLOSE' => 135,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127
		},
		GOTOS => {
			'Literal' => 107,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'Expression' => 148,
			'Operator' => 110,
			'WordScoped' => 120,
			'SubExpression' => 432,
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115
		}
	},
	{#State 423
		ACTIONS => {
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'LBRACKET' => 109,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119
		},
		GOTOS => {
			'ArrayReference' => 91,
			'Literal' => 107,
			'Expression' => 148,
			'HashDereference' => 92,
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 433,
			'VariableSymbolOrSelf' => 98,
			'ArrayDereference' => 115,
			'Variable' => 149,
			'HashReference' => 130
		}
	},
	{#State 424
		DEFAULT => -157
	},
	{#State 425
		ACTIONS => {
			";" => 434
		}
	},
	{#State 426
		ACTIONS => {
			'OP01_OPEN' => 100,
			'LBRACE' => 104,
			"if" => 105,
			'OP05_MATH_NEG_LPAREN' => 97,
			"}" => 435,
			"for" => -148,
			'SELF' => 106,
			'WORD_UPPERCASE' => 108,
			'LBRACKET' => 109,
			"foreach" => -148,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			'OP01_NAMED_VOID_LPAREN' => 89,
			"undef" => 90,
			'OP01_NAMED_VOID' => 94,
			'OP05_LOGICAL_NEG' => 93,
			"\@{" => 127,
			'OP01_NAMED' => 129,
			'OP19_LOOP_CONTROL_SCOLON' => 125,
			'MY' => 124,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'OP01_NAMED_VOID_SCOLON' => 136,
			'LPAREN' => 132,
			'OP10_NAMED_UNARY' => 114,
			"while" => -148,
			'CONSTANT_CALL_SCOPED' => 116,
			'VARIABLE_SYMBOL' => 112,
			'OP19_LOOP_CONTROL' => 111,
			'OP01_PRINT' => 123,
			'LITERAL_NUMBER' => 81,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119
		},
		GOTOS => {
			'Literal' => 107,
			'Expression' => 133,
			'Operator' => 110,
			'VariableModification' => 134,
			'VariableSymbolOrSelf' => 98,
			'PAREN-36' => 99,
			'VariableDeclaration' => 126,
			'Statement' => 103,
			'OPTIONAL-37' => 101,
			'Conditional' => 102,
			'HashReference' => 130,
			'Variable' => 128,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'WordScoped' => 120,
			'Operation' => 436,
			'SubExpression' => 121,
			'OperatorVoid' => 122,
			'LoopLabel' => 113,
			'ArrayDereference' => 115
		}
	},
	{#State 427
		ACTIONS => {
			'SELF' => 437
		}
	},
	{#State 428
		ACTIONS => {
			'WORD' => 438
		}
	},
	{#State 429
		DEFAULT => -168
	},
	{#State 430
		DEFAULT => -166
	},
	{#State 431
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 439
		}
	},
	{#State 432
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 191,
			'OP16_LOGICAL_OR' => 199,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			'OP18_TERNARY' => -104,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP17_LIST_RANGE' => undef,
			'OP04_MATH_POW' => 194,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP09_BITWISE_SHIFT' => 205,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => 440,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP07_STRING_REPEAT' => 197,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => -104
		}
	},
	{#State 433
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP18_TERNARY' => 202,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP23_LOGICAL_AND' => 207,
			'OP06_REGEX_MATCH' => 198,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => 441,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193
		}
	},
	{#State 434
		DEFAULT => -180
	},
	{#State 435
		ACTIONS => {
			";" => 442
		}
	},
	{#State 436
		DEFAULT => -69
	},
	{#State 437
		DEFAULT => -74,
		GOTOS => {
			'STAR-30' => 443
		}
	},
	{#State 438
		ACTIONS => {
			'OP02_ARRAY_THINARROW' => 445,
			'OP19_VARIABLE_ASSIGN' => 444
		}
	},
	{#State 439
		ACTIONS => {
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACKET' => 109,
			'SELF' => 106,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'OP01_CLOSE' => 135
		},
		GOTOS => {
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115,
			'Expression' => 148,
			'HashDereference' => 92,
			'Literal' => 107,
			'ArrayReference' => 91,
			'SubExpression' => 446,
			'Operator' => 110,
			'WordScoped' => 120
		}
	},
	{#State 440
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 447
		}
	},
	{#State 441
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 448
		}
	},
	{#State 442
		DEFAULT => -71
	},
	{#State 443
		ACTIONS => {
			'OP21_LIST_COMMA' => 449,
			")" => 450
		},
		GOTOS => {
			'PAREN-29' => 451
		}
	},
	{#State 444
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			"undef" => 90,
			'LITERAL_NUMBER' => 81,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			"%{" => 119,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_CLOSE' => 135,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LPAREN' => 132,
			'LBRACKET' => 109
		},
		GOTOS => {
			'Literal' => 107,
			'ArrayReference' => 91,
			'HashDereference' => 92,
			'Expression' => 148,
			'WordScoped' => 120,
			'Operator' => 110,
			'SubExpression' => 452,
			'VariableSymbolOrSelf' => 98,
			'HashReference' => 130,
			'Variable' => 149,
			'ArrayDereference' => 115
		}
	},
	{#State 445
		ACTIONS => {
			'VARIABLE_SYMBOL' => 112,
			'WORD_SCOPED' => 26,
			'WORD' => 25,
			"undef" => 90,
			'OP10_NAMED_UNARY' => 114,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP22_LOGICAL_NEG' => 117,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			"%{" => 119,
			'LITERAL_NUMBER' => 81,
			'OP05_MATH_NEG_LPAREN' => 97,
			'LITERAL_STRING' => 82,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'LPAREN' => 132,
			'SELF' => 106,
			'WORD_UPPERCASE' => 144,
			'LBRACKET' => 109,
			'OP01_CLOSE' => 135
		},
		GOTOS => {
			'SubExpression' => 453,
			'Operator' => 110,
			'WordScoped' => 120,
			'HashDereference' => 92,
			'Expression' => 148,
			'Literal' => 107,
			'ArrayReference' => 91,
			'Variable' => 149,
			'HashReference' => 130,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98
		}
	},
	{#State 446
		ACTIONS => {
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP18_TERNARY' => 202,
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193,
			";" => 454,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP11_COMPARE_LT_GT' => 204,
			'OP09_BITWISE_SHIFT' => 205,
			'OP08_STRING_CAT' => 206,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197
		}
	},
	{#State 447
		DEFAULT => -164
	},
	{#State 448
		DEFAULT => -154
	},
	{#State 449
		ACTIONS => {
			'MY' => 455
		}
	},
	{#State 450
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 456
		}
	},
	{#State 451
		DEFAULT => -73
	},
	{#State 452
		ACTIONS => {
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			"}" => -221,
			'OP18_TERNARY' => 202,
			'OP08_MATH_ADD_SUB' => 192,
			'OP13_BITWISE_AND' => 203,
			'OP21_LIST_COMMA' => -221,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP23_LOGICAL_AND' => 207,
			'OP06_REGEX_MATCH' => 198,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196
		}
	},
	{#State 453
		ACTIONS => {
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => 202,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP15_LOGICAL_AND' => 200,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP06_REGEX_MATCH' => 198,
			'OP23_LOGICAL_AND' => 207,
			'OP07_STRING_REPEAT' => 197,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			'OP08_STRING_CAT' => 206,
			'OP11_COMPARE_LT_GT' => 204,
			'OP09_BITWISE_SHIFT' => 205,
			"]" => 457,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193
		}
	},
	{#State 454
		ACTIONS => {
			'LITERAL_NUMBER' => 81,
			'OP03_MATH_INC_DEC' => 118,
			'OP05_LOGICAL_NEG' => 93,
			'OP22_LOGICAL_NEG' => 117,
			"%{" => 119,
			'CONSTANT_CALL_SCOPED' => 116,
			'OP10_NAMED_UNARY' => 114,
			"undef" => 90,
			'WORD_SCOPED' => 26,
			'VARIABLE_SYMBOL' => 112,
			'WORD' => 25,
			'OP01_CLOSE' => 135,
			'LBRACKET' => 109,
			'LPAREN' => 132,
			'WORD_UPPERCASE' => 144,
			'SELF' => 106,
			'LBRACE' => 104,
			'OP01_NAMED' => 150,
			'OP01_OPEN' => 100,
			"\@{" => 127,
			'LITERAL_STRING' => 82,
			'OP05_MATH_NEG_LPAREN' => 97
		},
		GOTOS => {
			'HashReference' => 130,
			'Variable' => 128,
			'ArrayDereference' => 115,
			'VariableSymbolOrSelf' => 98,
			'SubExpression' => 458,
			'SubExpressionOrVarMod' => 460,
			'Operator' => 110,
			'VariableModification' => 459,
			'WordScoped' => 120,
			'HashDereference' => 92,
			'Expression' => 148,
			'Literal' => 107,
			'ArrayReference' => 91
		}
	},
	{#State 455
		ACTIONS => {
			'TYPE_INTEGER' => 52,
			'WORD' => 55,
			'WORD_SCOPED' => 54
		},
		GOTOS => {
			'Type' => 461
		}
	},
	{#State 456
		ACTIONS => {
			"\@_;" => 462
		}
	},
	{#State 457
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 463
		}
	},
	{#State 458
		ACTIONS => {
			'OP13_BITWISE_AND' => 203,
			'OP08_MATH_ADD_SUB' => 192,
			'OP18_TERNARY' => 202,
			'OP15_LOGICAL_AND' => 200,
			'OP14_BITWISE_OR_XOR' => 201,
			'OP16_LOGICAL_OR' => 199,
			'OP12_COMPARE_EQ_NE' => 191,
			'OP23_LOGICAL_AND' => 207,
			'OP06_REGEX_MATCH' => 198,
			'OP24_LOGICAL_OR_XOR' => 196,
			'OP07_STRING_REPEAT' => 197,
			'OP07_MATH_MULT_DIV_MOD' => 195,
			")" => -144,
			'OP08_STRING_CAT' => 206,
			'OP09_BITWISE_SHIFT' => 205,
			'OP11_COMPARE_LT_GT' => 204,
			'OP04_MATH_POW' => 194,
			'OP17_LIST_RANGE' => 193
		}
	},
	{#State 459
		DEFAULT => -145
	},
	{#State 460
		ACTIONS => {
			")" => 464
		}
	},
	{#State 461
		ACTIONS => {
			'VARIABLE_SYMBOL' => 465
		}
	},
	{#State 462
		DEFAULT => -75
	},
	{#State 463
		ACTIONS => {
			"undef" => 466
		}
	},
	{#State 464
		ACTIONS => {
			'LBRACE' => 362
		},
		GOTOS => {
			'CodeBlock' => 467
		}
	},
	{#State 465
		DEFAULT => -72
	},
	{#State 466
		DEFAULT => -222
	},
	{#State 467
		DEFAULT => -165
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 6604 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6611 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6618 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 147 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6625 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6636 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6647 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6654 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6661 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6668 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6682 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6689 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6696 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6703 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6710 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6717 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6724 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 148 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6731 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6742 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6749 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6756 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 1,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-10', 0,
sub {
#line 149 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6770 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_23
		 'ModuleHeader', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6781 lib/RPerl/Grammar.pm
	],
	[#Rule Module_24
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6792 lib/RPerl/Grammar.pm
	],
	[#Rule Module_25
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6803 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6810 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6817 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6824 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6831 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6838 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-13', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6845 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6852 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6859 lib/RPerl/Grammar.pm
	],
	[#Rule Package_34
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6870 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 1,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6877 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-15', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6884 lib/RPerl/Grammar.pm
	],
	[#Rule Header_37
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6895 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6902 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-16', 1,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6909 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_40
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6920 lib/RPerl/Grammar.pm
	],
	[#Rule Include_41
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6931 lib/RPerl/Grammar.pm
	],
	[#Rule Include_42
		 'Include', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6942 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_43
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6953 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6960 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6967 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 2,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6974 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-18', 0,
sub {
#line 159 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6981 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_48
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6992 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-19', 4,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6999 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7006 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 160 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_52
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7031 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7038 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7045 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7052 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7059 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7066 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 2,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7073 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-24', 0,
sub {
#line 161 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7080 lib/RPerl/Grammar.pm
	],
	[#Rule Class_61
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7091 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-25', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7098 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 2,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7105 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-26', 0,
sub {
#line 162 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7112 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_65
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7123 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_66
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7134 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7141 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7148 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 2,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-28', 0,
sub {
#line 164 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7162 lib/RPerl/Grammar.pm
	],
	[#Rule Method_71
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7173 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-29', 4,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7180 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 2,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7187 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-30', 0,
sub {
#line 165 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_75
		 'MethodArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_76
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7216 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_77
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7227 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_78
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7238 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_79
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7249 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7260 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7271 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7282 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7293 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7304 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7315 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7326 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7337 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7348 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7359 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7370 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7381 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7392 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7403 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7414 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7425 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7436 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7447 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7480 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7513 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7524 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7535 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7546 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_107
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7557 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_108
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7568 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-31', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7575 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7582 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7589 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7596 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 182 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7603 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7614 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7625 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7636 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7647 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7658 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7669 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_120
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7680 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_121
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7691 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7698 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 184 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7705 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7712 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-35', 0,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7719 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7730 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7741 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7752 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_129
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7763 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_130
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7774 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_131
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7785 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7796 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7807 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7818 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7829 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7840 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7851 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_138
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7862 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_139
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7873 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_140
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7884 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_141
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7895 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_142
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7906 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrInput_143
		 'SubExpressionOrInput', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7917 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_144
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7928 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrVarMod_145
		 'SubExpressionOrVarMod', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7939 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-36', 2,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7946 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 1,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7953 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-37', 0,
sub {
#line 189 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7960 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_149
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7971 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_150
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7982 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_151
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7993 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_152
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8004 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_153
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8015 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-38', 5,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8022 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8029 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-39', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8036 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-40', 2,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8043 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 1,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8050 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-41', 0,
sub {
#line 190 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8057 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_160
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8068 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_161
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8079 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_162
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8090 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_163
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8101 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_164
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8112 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_165
		 'LoopFor', 14,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8123 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_166
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8134 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_167
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8145 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_168
		 'LoopWhile', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8156 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 2,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8163 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-42', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8170 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_171
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8181 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8188 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8195 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_174
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8206 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_175
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8217 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_176
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8228 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_177
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8239 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_178
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8250 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_179
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8261 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_180
		 'VariableDeclaration', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8272 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_181
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8283 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_182
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8294 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_183
		 'VariableModification', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8305 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-44', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8312 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 2,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8319 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-45', 0,
sub {
#line 203 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8326 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_187
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8337 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_188
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8348 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_189
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8359 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_190
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8370 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_191
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8381 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8388 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 205 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8395 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_194
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8406 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8413 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 206 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8420 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_197
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8431 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_198
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8442 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8449 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 207 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8456 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_201
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8467 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_202
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8478 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_203
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8489 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryProperties_204
		 'HashEntryProperties', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8500 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 8507 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 8514 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 209 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8521 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_208
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8532 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_209
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8543 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 8550 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 210 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 8557 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_212
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8568 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_213
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8579 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_214
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8590 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_215
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8601 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_216
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8612 lib/RPerl/Grammar.pm
	],
	[#Rule Type_217
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8623 lib/RPerl/Grammar.pm
	],
	[#Rule Type_218
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8634 lib/RPerl/Grammar.pm
	],
	[#Rule Type_219
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8645 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_220
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8656 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_221
		 'TypeInnerProperties', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8667 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerProperties_222
		 'TypeInnerProperties', 9,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8678 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_223
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8689 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_224
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8700 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_225
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8711 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_226
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8722 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_227
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8733 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_228
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8744 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_229
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8755 lib/RPerl/Grammar.pm
	],
	[#Rule VariableSymbolOrSelf_230
		 'VariableSymbolOrSelf', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8766 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_231
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8777 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_232
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 8788 lib/RPerl/Grammar.pm
	]
],
#line 8791 lib/RPerl/Grammar.pm
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
HashEntry_203 => 'RPerl::DataStructure::Hash::Entry',                                           # HashEntry -> ENV
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
Literal_232 => 'RPerl::Operation::Expression::SubExpression::Literal::String',                  # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 9203 lib/RPerl/Grammar.pm



1;
