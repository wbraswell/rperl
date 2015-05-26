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
    our $VERSION = 0.000_998;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:[#][^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|use\ constant|use\ strict\;|use\ RPerl\;|package|\$TYPED_|\=\ sub\ \{|foreach|undef|while|elsif|else|use|\@_\;|for|our|\%\{|if|\@\{|\)|\;|\}|\])}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FHREF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FHREF_SYMBOL', $1);
      /\G(integer\s+)/gc and return ('TYPE_INTEGER', $1);
      /\G(filehandleref\s+)/gc and return ('TYPE_FHREF', $1);
      /\G([a-zA-Z]\w*_method)/gc and return ('TYPE_METHOD', $1);
      /\G((?:[a-zA-Z]\w*)?(?:::[a-zA-Z]\w*)+)/gc and return ('WORD_SCOPED', $1);
      /\G(object\s+\$self)/gc and return ('TYPE_SELF', $1);
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
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(x)\s/gc and return ('OP07_STRING_REPEAT', $1);
      /\G([ms]\/.*(?:\/.*)?\/[a-z]*)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->new\()/gc and return ('OP02_METHOD_THINARROW_NEW', $1);
      /\G(->[a-zA-Z]\w*)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(-\()/gc and return ('OP05_MATH_NEG_LPAREN', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(<=|>=|<|>|lt|gt|le|ge)\s/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G(=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(print|printf)\s/gc and return ('OP01_PRINT', $1);
      /\G(croak;|return;|exit;)/gc and return ('OP01_NAMED_VOID_SCOLON', $1);
      /\G(return\()/gc and return ('OP01_NAMED_VOID_LPAREN', $1);
      /\G(croak|return|exit)\s/gc and return ('OP01_NAMED_VOID', $1);
      /\G(qw\()/gc and return ('OP01_QW', $1);
      /\G(open)\s/gc and return ('OP01_OPEN', $1);
      /\G(close)\s/gc and return ('OP01_CLOSE', $1);
      /\G(sin|cos|push|pop|keys|values|sort|length|ETC)\s/gc and return ('OP01_NAMED', $1);
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


#line 132 lib/RPerl/Grammar.pm

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
  [ 'Program_18' => 'Program', [ 'SHEBANG', 'OPTIONAL-3', 'Header', 'STAR-4', 'STAR-5', 'STAR-6', 'STAR-7', 'PLUS-8' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [ 'Critic' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-9', [  ], 0 ],
  [ 'ModuleHeader_21' => 'ModuleHeader', [ 'OPTIONAL-9', 'package', 'WordScoped', ';', 'Header' ], 0 ],
  [ 'Module_22' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_23' => 'Module', [ 'Class' ], 0 ],
  [ '_STAR_LIST' => 'STAR-10', [ 'STAR-10', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-10', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [ 'STAR-12', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-12', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'PLUS-13', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'Subroutine' ], 0 ],
  [ 'Package_32' => 'Package', [ 'STAR-10', 'STAR-11', 'STAR-12', 'PLUS-13', 'LITERAL_NUMBER', ';' ], 0 ],
  [ 'Header_33' => 'Header', [ 'use strict;', 'use warnings;', 'use RPerl;', 'our', 'VERSION_NUMBER_ASSIGN' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'PLUS-14', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-14', [ 'WORD' ], 0 ],
  [ 'Critic_36' => 'Critic', [ '## no critic qw(', 'PLUS-14', ')' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'PLUS-15', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-15', [ 'WORD' ], 0 ],
  [ 'Include_39' => 'Include', [ 'use', 'WordScoped', ';' ], 0 ],
  [ 'Include_40' => 'Include', [ 'use', 'WordScoped', 'OP01_QW', 'PLUS-15', ')', ';' ], 0 ],
  [ 'Constant_41' => 'Constant', [ 'use constant', 'WORD_UPPERCASE', 'OP20_HASH_FATARROW', 'TypeInnerConstant', 'Literal', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-17', [ 'STAR-17', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-17', [  ], 0 ],
  [ 'Subroutine_46' => 'Subroutine', [ 'our', 'Type', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-16', 'STAR-17', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-18', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [ 'STAR-19', 'PAREN-18' ], 0 ],
  [ '_STAR_LIST' => 'STAR-19', [  ], 0 ],
  [ 'SubroutineArguments_50' => 'SubroutineArguments', [ 'LPAREN_MY', 'Type', 'VARIABLE_SYMBOL', 'STAR-19', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [ 'STAR-20', 'Critic' ], 0 ],
  [ '_STAR_LIST' => 'STAR-20', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [ 'STAR-21', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-21', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [ 'STAR-22', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-22', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [ 'STAR-23', 'MethodOrSubroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-23', [  ], 0 ],
  [ 'Class_59' => 'Class', [ 'use parent qw(', 'WordScoped', ')', ';', 'Include', 'STAR-20', 'STAR-21', 'STAR-22', 'Properties', 'STAR-23', 'LITERAL_NUMBER', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-24', [ 'OP21_LIST_COMMA', 'HashEntryTyped' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'PAREN-24' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ 'Properties_63' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', 'HashEntryTyped', 'STAR-25', '}', ';' ], 0 ],
  [ 'Properties_64' => 'Properties', [ 'our hashref $properties', 'OP19_VARIABLE_ASSIGN', 'LBRACE', '}', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-26', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [ 'STAR-27', 'Operation' ], 0 ],
  [ '_STAR_LIST' => 'STAR-27', [  ], 0 ],
  [ 'Method_69' => 'Method', [ 'our', 'TYPE_METHOD', 'VARIABLE_SYMBOL', '= sub {', 'OPTIONAL-26', 'STAR-27', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-28', [ 'OP21_LIST_COMMA', 'MY', 'Type', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'PAREN-28' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ 'MethodArguments_73' => 'MethodArguments', [ 'LPAREN_MY', 'TYPE_SELF', 'STAR-29', ')', 'OP19_VARIABLE_ASSIGN', '@_;' ], 0 ],
  [ 'MethodOrSubroutine_74' => 'MethodOrSubroutine', [ 'Method' ], 0 ],
  [ 'MethodOrSubroutine_75' => 'MethodOrSubroutine', [ 'Subroutine' ], 0 ],
  [ 'Operation_76' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_77' => 'Operation', [ 'Statement' ], 0 ],
  [ 'Operator_78' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_79' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_80' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_81' => 'Operator', [ 'OP01_OPEN', 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'OP01_CLOSE', 'FHREF_SYMBOL' ], 0 ],
  [ 'Operator_83' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_84' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_85' => 'Operator', [ 'SubExpression', 'OP04_MATH_POW', 'SubExpression' ], 0 ],
  [ 'Operator_86' => 'Operator', [ 'OP05_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_87' => 'Operator', [ 'OP05_MATH_NEG_LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'Operator_88' => 'Operator', [ 'SubExpression', 'OP06_REGEX_MATCH', 'OP06_REGEX_PATTERN' ], 0 ],
  [ 'Operator_89' => 'Operator', [ 'SubExpression', 'OP07_STRING_REPEAT', 'SubExpression' ], 0 ],
  [ 'Operator_90' => 'Operator', [ 'SubExpression', 'OP07_MATH_MULT_DIV_MOD', 'SubExpression' ], 0 ],
  [ 'Operator_91' => 'Operator', [ 'SubExpression', 'OP08_MATH_ADD_SUB', 'SubExpression' ], 0 ],
  [ 'Operator_92' => 'Operator', [ 'SubExpression', 'OP08_STRING_CAT', 'SubExpression' ], 0 ],
  [ 'Operator_93' => 'Operator', [ 'SubExpression', 'OP09_BITWISE_SHIFT', 'SubExpression' ], 0 ],
  [ 'Operator_94' => 'Operator', [ 'OP10_NAMED_UNARY', 'SubExpression' ], 0 ],
  [ 'Operator_95' => 'Operator', [ 'OP10_NAMED_UNARY' ], 0 ],
  [ 'Operator_96' => 'Operator', [ 'SubExpression', 'OP11_COMPARE_LT_GT', 'SubExpression' ], 0 ],
  [ 'Operator_97' => 'Operator', [ 'SubExpression', 'OP12_COMPARE_EQ_NE', 'SubExpression' ], 0 ],
  [ 'Operator_98' => 'Operator', [ 'SubExpression', 'OP13_BITWISE_AND', 'SubExpression' ], 0 ],
  [ 'Operator_99' => 'Operator', [ 'SubExpression', 'OP14_BITWISE_OR_XOR', 'SubExpression' ], 0 ],
  [ 'Operator_100' => 'Operator', [ 'SubExpression', 'OP15_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_101' => 'Operator', [ 'SubExpression', 'OP16_LOGICAL_OR', 'SubExpression' ], 0 ],
  [ 'Operator_102' => 'Operator', [ 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression' ], 0 ],
  [ 'Operator_103' => 'Operator', [ 'SubExpression', 'OP18_TERNARY', 'VariableOrLiteral', 'COLON', 'VariableOrLiteral' ], 0 ],
  [ 'Operator_104' => 'Operator', [ 'OP22_LOGICAL_NEG', 'SubExpression' ], 0 ],
  [ 'Operator_105' => 'Operator', [ 'SubExpression', 'OP23_LOGICAL_AND', 'SubExpression' ], 0 ],
  [ 'Operator_106' => 'Operator', [ 'SubExpression', 'OP24_LOGICAL_OR_XOR', 'SubExpression' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'STDOUT_STDERR' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [ 'PAREN-30' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-31', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-32', [  ], 0 ],
  [ 'OperatorVoid_112' => 'OperatorVoid', [ 'OP01_PRINT', 'OPTIONAL-31', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_113' => 'OperatorVoid', [ 'OP01_PRINT', 'FHREF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_114' => 'OperatorVoid', [ 'OP01_NAMED_VOID_SCOLON' ], 0 ],
  [ 'OperatorVoid_115' => 'OperatorVoid', [ 'OP01_NAMED_VOID_LPAREN', 'OPTIONAL-32', ')', ';' ], 0 ],
  [ 'OperatorVoid_116' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_117' => 'OperatorVoid', [ 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ';' ], 0 ],
  [ 'OperatorVoid_118' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL_SCOLON' ], 0 ],
  [ 'OperatorVoid_119' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LoopLabel', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-33', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-34', [  ], 0 ],
  [ 'Expression_124' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_125' => 'Expression', [ 'WordScoped', 'LPAREN', 'OPTIONAL-33', ')' ], 0 ],
  [ 'Expression_126' => 'Expression', [ 'WORD_UPPERCASE', 'LPAREN', ')' ], 0 ],
  [ 'Expression_127' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'LPAREN', 'OPTIONAL-34', ')' ], 0 ],
  [ 'Expression_128' => 'Expression', [ 'WordScoped', 'OP02_METHOD_THINARROW_NEW', ')' ], 0 ],
  [ 'SubExpression_129' => 'SubExpression', [ 'Expression' ], 0 ],
  [ 'SubExpression_130' => 'SubExpression', [ 'undef' ], 0 ],
  [ 'SubExpression_131' => 'SubExpression', [ 'Literal' ], 0 ],
  [ 'SubExpression_132' => 'SubExpression', [ 'Variable' ], 0 ],
  [ 'SubExpression_133' => 'SubExpression', [ 'ArrayReference' ], 0 ],
  [ 'SubExpression_134' => 'SubExpression', [ 'ArrayDereference' ], 0 ],
  [ 'SubExpression_135' => 'SubExpression', [ 'HashReference' ], 0 ],
  [ 'SubExpression_136' => 'SubExpression', [ 'HashDereference' ], 0 ],
  [ 'SubExpression_137' => 'SubExpression', [ 'LPAREN', 'SubExpression', ')' ], 0 ],
  [ 'SubExpressionOrStdin_138' => 'SubExpressionOrStdin', [ 'SubExpression' ], 0 ],
  [ 'SubExpressionOrStdin_139' => 'SubExpressionOrStdin', [ 'STDIN' ], 0 ],
  [ '_PAREN' => 'PAREN-35', [ 'LoopLabel', 'COLON' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [ 'PAREN-35' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-36', [  ], 0 ],
  [ 'Statement_143' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_144' => 'Statement', [ 'OPTIONAL-36', 'Loop' ], 0 ],
  [ 'Statement_145' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_146' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_147' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'elsif', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [ 'STAR-38', 'PAREN-37' ], 0 ],
  [ '_STAR_LIST' => 'STAR-38', [  ], 0 ],
  [ '_PAREN' => 'PAREN-39', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'PAREN-39' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ 'Conditional_154' => 'Conditional', [ 'if', 'LPAREN', 'SubExpression', ')', 'CodeBlock', 'STAR-38', 'OPTIONAL-40' ], 0 ],
  [ 'Loop_155' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_156' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_157' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_158' => 'LoopFor', [ 'for', 'MY', 'TYPE_INTEGER', 'VARIABLE_SYMBOL', 'LPAREN', 'SubExpression', 'OP17_LIST_RANGE', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_159' => 'LoopForEach', [ 'foreach', 'MY', 'Type', 'VARIABLE_SYMBOL', 'LPAREN', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_160' => 'LoopWhile', [ 'while', 'LPAREN', 'SubExpression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-41', [ 'PLUS-41', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-41', [ 'Operation' ], 0 ],
  [ 'CodeBlock_163' => 'CodeBlock', [ 'LBRACE', 'PLUS-41', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [ 'STAR-42', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-42', [  ], 0 ],
  [ 'Variable_166' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-42' ], 0 ],
  [ 'VariableRetrieval_167' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'SubExpression', ']' ], 0 ],
  [ 'VariableRetrieval_168' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'SubExpression', '}' ], 0 ],
  [ 'VariableRetrieval_169' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'WORD', '}' ], 0 ],
  [ 'VariableDeclaration_170' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_171' => 'VariableDeclaration', [ 'MY', 'Type', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableDeclaration_172' => 'VariableDeclaration', [ 'MY', 'TYPE_FHREF', 'FHREF_SYMBOL', ';' ], 0 ],
  [ 'VariableModification_173' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_174' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'PAREN-43' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'ListElements_178' => 'ListElements', [ 'ListElement', 'STAR-44' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'PLUS-45', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'WORD' ], 0 ],
  [ 'ListElement_181' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_182' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_183' => 'ListElement', [ 'OP01_QW', 'PLUS-45', ')' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_186' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_189' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_190' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_193' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_194' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryTyped_195' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_196' => 'HashEntryTyped', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_200' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_201' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_204' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_205' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_206' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_207' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_208' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_209' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_210' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_211' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_212' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_213' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_214' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_215' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_216' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_217' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'Literal_218' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_219' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'ModuleHeader_21' => 21,
  'Module_22' => 22,
  'Module_23' => 23,
  '_STAR_LIST' => 24,
  '_STAR_LIST' => 25,
  '_STAR_LIST' => 26,
  '_STAR_LIST' => 27,
  '_STAR_LIST' => 28,
  '_STAR_LIST' => 29,
  '_PLUS_LIST' => 30,
  '_PLUS_LIST' => 31,
  'Package_32' => 32,
  'Header_33' => 33,
  '_PLUS_LIST' => 34,
  '_PLUS_LIST' => 35,
  'Critic_36' => 36,
  '_PLUS_LIST' => 37,
  '_PLUS_LIST' => 38,
  'Include_39' => 39,
  'Include_40' => 40,
  'Constant_41' => 41,
  '_OPTIONAL' => 42,
  '_OPTIONAL' => 43,
  '_STAR_LIST' => 44,
  '_STAR_LIST' => 45,
  'Subroutine_46' => 46,
  '_PAREN' => 47,
  '_STAR_LIST' => 48,
  '_STAR_LIST' => 49,
  'SubroutineArguments_50' => 50,
  '_STAR_LIST' => 51,
  '_STAR_LIST' => 52,
  '_STAR_LIST' => 53,
  '_STAR_LIST' => 54,
  '_STAR_LIST' => 55,
  '_STAR_LIST' => 56,
  '_STAR_LIST' => 57,
  '_STAR_LIST' => 58,
  'Class_59' => 59,
  '_PAREN' => 60,
  '_STAR_LIST' => 61,
  '_STAR_LIST' => 62,
  'Properties_63' => 63,
  'Properties_64' => 64,
  '_OPTIONAL' => 65,
  '_OPTIONAL' => 66,
  '_STAR_LIST' => 67,
  '_STAR_LIST' => 68,
  'Method_69' => 69,
  '_PAREN' => 70,
  '_STAR_LIST' => 71,
  '_STAR_LIST' => 72,
  'MethodArguments_73' => 73,
  'MethodOrSubroutine_74' => 74,
  'MethodOrSubroutine_75' => 75,
  'Operation_76' => 76,
  'Operation_77' => 77,
  'Operator_78' => 78,
  'Operator_79' => 79,
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
  '_PAREN' => 107,
  '_OPTIONAL' => 108,
  '_OPTIONAL' => 109,
  '_OPTIONAL' => 110,
  '_OPTIONAL' => 111,
  'OperatorVoid_112' => 112,
  'OperatorVoid_113' => 113,
  'OperatorVoid_114' => 114,
  'OperatorVoid_115' => 115,
  'OperatorVoid_116' => 116,
  'OperatorVoid_117' => 117,
  'OperatorVoid_118' => 118,
  'OperatorVoid_119' => 119,
  '_OPTIONAL' => 120,
  '_OPTIONAL' => 121,
  '_OPTIONAL' => 122,
  '_OPTIONAL' => 123,
  'Expression_124' => 124,
  'Expression_125' => 125,
  'Expression_126' => 126,
  'Expression_127' => 127,
  'Expression_128' => 128,
  'SubExpression_129' => 129,
  'SubExpression_130' => 130,
  'SubExpression_131' => 131,
  'SubExpression_132' => 132,
  'SubExpression_133' => 133,
  'SubExpression_134' => 134,
  'SubExpression_135' => 135,
  'SubExpression_136' => 136,
  'SubExpression_137' => 137,
  'SubExpressionOrStdin_138' => 138,
  'SubExpressionOrStdin_139' => 139,
  '_PAREN' => 140,
  '_OPTIONAL' => 141,
  '_OPTIONAL' => 142,
  'Statement_143' => 143,
  'Statement_144' => 144,
  'Statement_145' => 145,
  'Statement_146' => 146,
  'Statement_147' => 147,
  '_PAREN' => 148,
  '_STAR_LIST' => 149,
  '_STAR_LIST' => 150,
  '_PAREN' => 151,
  '_OPTIONAL' => 152,
  '_OPTIONAL' => 153,
  'Conditional_154' => 154,
  'Loop_155' => 155,
  'Loop_156' => 156,
  'Loop_157' => 157,
  'LoopFor_158' => 158,
  'LoopForEach_159' => 159,
  'LoopWhile_160' => 160,
  '_PLUS_LIST' => 161,
  '_PLUS_LIST' => 162,
  'CodeBlock_163' => 163,
  '_STAR_LIST' => 164,
  '_STAR_LIST' => 165,
  'Variable_166' => 166,
  'VariableRetrieval_167' => 167,
  'VariableRetrieval_168' => 168,
  'VariableRetrieval_169' => 169,
  'VariableDeclaration_170' => 170,
  'VariableDeclaration_171' => 171,
  'VariableDeclaration_172' => 172,
  'VariableModification_173' => 173,
  'VariableModification_174' => 174,
  '_PAREN' => 175,
  '_STAR_LIST' => 176,
  '_STAR_LIST' => 177,
  'ListElements_178' => 178,
  '_PLUS_LIST' => 179,
  '_PLUS_LIST' => 180,
  'ListElement_181' => 181,
  'ListElement_182' => 182,
  'ListElement_183' => 183,
  '_OPTIONAL' => 184,
  '_OPTIONAL' => 185,
  'ArrayReference_186' => 186,
  '_OPTIONAL' => 187,
  '_OPTIONAL' => 188,
  'ArrayDereference_189' => 189,
  'ArrayDereference_190' => 190,
  '_OPTIONAL' => 191,
  '_OPTIONAL' => 192,
  'HashEntry_193' => 193,
  'HashEntry_194' => 194,
  'HashEntryTyped_195' => 195,
  'HashEntryTyped_196' => 196,
  '_PAREN' => 197,
  '_STAR_LIST' => 198,
  '_STAR_LIST' => 199,
  'HashReference_200' => 200,
  'HashReference_201' => 201,
  '_OPTIONAL' => 202,
  '_OPTIONAL' => 203,
  'HashDereference_204' => 204,
  'HashDereference_205' => 205,
  'WordScoped_206' => 206,
  'WordScoped_207' => 207,
  'LoopLabel_208' => 208,
  'Type_209' => 209,
  'Type_210' => 210,
  'TypeInner_211' => 211,
  'TypeInnerConstant_212' => 212,
  'VariableOrLiteral_213' => 213,
  'VariableOrLiteral_214' => 214,
  'VariableOrLiteralOrWord_215' => 215,
  'VariableOrLiteralOrWord_216' => 216,
  'VariableOrLiteralOrWord_217' => 217,
  'Literal_218' => 218,
  'Literal_219' => 219,
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
	'use RPerl;' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent qw(' => { ISSEMANTIC => 0 },
	'use strict;' => { ISSEMANTIC => 0 },
	'use warnings;' => { ISSEMANTIC => 0 },
	'use' => { ISSEMANTIC => 0 },
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
	SHEBANG => { ISSEMANTIC => 1 },
	STDIN => { ISSEMANTIC => 1 },
	STDOUT_STDERR => { ISSEMANTIC => 1 },
	TYPE_FHREF => { ISSEMANTIC => 1 },
	TYPE_INTEGER => { ISSEMANTIC => 1 },
	TYPE_METHOD => { ISSEMANTIC => 1 },
	TYPE_SELF => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 2,
			"package" => -20
		},
		GOTOS => {
			'PAREN-1' => 1,
			'OPTIONAL-9' => 9,
			'ModuleHeader' => 7,
			'PLUS-2' => 6,
			'Critic' => 3,
			'Program' => 4,
			'CompileUnit' => 5
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		ACTIONS => {
			'WORD' => 10
		},
		GOTOS => {
			'PLUS-14' => 11
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
			'' => 12
		}
	},
	{#State 6
		ACTIONS => {
			"## no critic qw(" => 2,
			'' => -5,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 9,
			'PAREN-1' => 13,
			'ModuleHeader' => 7,
			'Critic' => 3
		}
	},
	{#State 7
		ACTIONS => {
			"use parent qw(" => 16,
			"our" => -25,
			"use" => -25,
			"use constant" => -25,
			"## no critic qw(" => -25
		},
		GOTOS => {
			'STAR-10' => 17,
			'Class' => 15,
			'Package' => 18,
			'Module' => 14
		}
	},
	{#State 8
		ACTIONS => {
			"## no critic qw(" => 2,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 19,
			'Critic' => 20
		}
	},
	{#State 9
		ACTIONS => {
			"package" => 21
		}
	},
	{#State 10
		DEFAULT => -35
	},
	{#State 11
		ACTIONS => {
			")" => 23,
			'WORD' => 22
		}
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		DEFAULT => -1
	},
	{#State 15
		DEFAULT => -23
	},
	{#State 16
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 24
		}
	},
	{#State 17
		ACTIONS => {
			"use constant" => -27,
			"## no critic qw(" => 2,
			"our" => -27,
			"use" => -27
		},
		GOTOS => {
			'Critic' => 28,
			'STAR-11' => 27
		}
	},
	{#State 18
		DEFAULT => -22
	},
	{#State 19
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 30
		}
	},
	{#State 20
		DEFAULT => -6
	},
	{#State 21
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'WORD' => 25
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 22
		DEFAULT => -34
	},
	{#State 23
		DEFAULT => -36
	},
	{#State 24
		ACTIONS => {
			")" => 32
		}
	},
	{#State 25
		DEFAULT => -206
	},
	{#State 26
		DEFAULT => -207
	},
	{#State 27
		ACTIONS => {
			"our" => -29,
			"use" => 34,
			"use constant" => -29
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 33
		}
	},
	{#State 28
		DEFAULT => -24
	},
	{#State 29
		ACTIONS => {
			"use warnings;" => 36
		}
	},
	{#State 30
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 37
		}
	},
	{#State 31
		ACTIONS => {
			";" => 38
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
			"use constant" => 41
		},
		GOTOS => {
			'Constant' => 40,
			'Subroutine' => 42,
			'PLUS-13' => 43
		}
	},
	{#State 34
		ACTIONS => {
			'WORD' => 25,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 45
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			"use RPerl;" => 46
		}
	},
	{#State 37
		ACTIONS => {
			'OP01_OPEN' => -11,
			'OP01_CLOSE' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'MY' => -11,
			"%{" => -11,
			"for" => -11,
			'WORD' => -11,
			"if" => -11,
			"use" => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			"undef" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'LITERAL_NUMBER' => -11,
			"## no critic qw(" => 2,
			'OP01_NAMED' => -11,
			'LBRACKET' => -11,
			"use constant" => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_NAMED_VOID' => -11,
			"our" => -11,
			'LPAREN' => -11,
			'OP10_NAMED_UNARY' => -11,
			'OP19_LOOP_CONTROL' => -11,
			"\@{" => -11,
			"foreach" => -11,
			'WORD_UPPERCASE' => -11,
			'LITERAL_STRING' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP05_LOGICAL_NEG' => -11,
			'WORD_SCOPED' => -11,
			'LBRACE' => -11,
			'OP01_PRINT' => -11,
			'VARIABLE_SYMBOL' => -11,
			"while" => -11,
			'OP01_NAMED_VOID_LPAREN' => -11
		},
		GOTOS => {
			'Critic' => 47,
			'STAR-5' => 48
		}
	},
	{#State 38
		ACTIONS => {
			"use strict;" => 29
		},
		GOTOS => {
			'Header' => 49
		}
	},
	{#State 39
		ACTIONS => {
			"use" => 34
		},
		GOTOS => {
			'Include' => 50
		}
	},
	{#State 40
		DEFAULT => -28
	},
	{#State 41
		ACTIONS => {
			'WORD_UPPERCASE' => 51
		}
	},
	{#State 42
		DEFAULT => -31
	},
	{#State 43
		ACTIONS => {
			"our" => 44,
			'LITERAL_NUMBER' => 53
		},
		GOTOS => {
			'Subroutine' => 52
		}
	},
	{#State 44
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 54
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
			"our" => 59
		}
	},
	{#State 47
		DEFAULT => -8
	},
	{#State 48
		ACTIONS => {
			'LITERAL_NUMBER' => -13,
			'OP01_NAMED' => -13,
			"if" => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			"use" => 34,
			"undef" => -13,
			'OP03_MATH_INC_DEC' => -13,
			'OP22_LOGICAL_NEG' => -13,
			"use constant" => -13,
			'LBRACKET' => -13,
			"%{" => -13,
			'OP01_OPEN' => -13,
			'OP01_CLOSE' => -13,
			'MY' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'WORD' => -13,
			"for" => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'LITERAL_STRING' => -13,
			'OP05_LOGICAL_NEG' => -13,
			"foreach" => -13,
			'WORD_UPPERCASE' => -13,
			'VARIABLE_SYMBOL' => -13,
			"while" => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'LBRACE' => -13,
			'WORD_SCOPED' => -13,
			'OP01_PRINT' => -13,
			'OP01_NAMED_VOID' => -13,
			"our" => -13,
			'LPAREN' => -13,
			"\@{" => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP19_LOOP_CONTROL' => -13
		},
		GOTOS => {
			'STAR-6' => 60,
			'Include' => 61
		}
	},
	{#State 49
		DEFAULT => -21
	},
	{#State 50
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 62
		}
	},
	{#State 51
		ACTIONS => {
			'OP20_HASH_FATARROW' => 63
		}
	},
	{#State 52
		DEFAULT => -30
	},
	{#State 53
		ACTIONS => {
			";" => 64
		}
	},
	{#State 54
		ACTIONS => {
			'VARIABLE_SYMBOL' => 65
		}
	},
	{#State 55
		DEFAULT => -210
	},
	{#State 56
		DEFAULT => -209
	},
	{#State 57
		DEFAULT => -39
	},
	{#State 58
		ACTIONS => {
			'WORD' => 66
		},
		GOTOS => {
			'PLUS-15' => 67
		}
	},
	{#State 59
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 68
		}
	},
	{#State 60
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -15,
			"use constant" => 41,
			'LBRACKET' => -15,
			'LITERAL_NUMBER' => -15,
			'OP01_NAMED' => -15,
			"if" => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			"undef" => -15,
			'OP03_MATH_INC_DEC' => -15,
			'WORD' => -15,
			"for" => -15,
			"%{" => -15,
			'OP01_OPEN' => -15,
			'OP01_CLOSE' => -15,
			'MY' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'VARIABLE_SYMBOL' => -15,
			"while" => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'LBRACE' => -15,
			'WORD_SCOPED' => -15,
			'OP01_PRINT' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'LITERAL_STRING' => -15,
			'OP05_LOGICAL_NEG' => -15,
			"foreach" => -15,
			'WORD_UPPERCASE' => -15,
			"\@{" => -15,
			'OP10_NAMED_UNARY' => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_NAMED_VOID' => -15,
			"our" => -15,
			'LPAREN' => -15
		},
		GOTOS => {
			'Constant' => 69,
			'STAR-7' => 70
		}
	},
	{#State 61
		DEFAULT => -10
	},
	{#State 62
		ACTIONS => {
			"use" => -54,
			"our hashref \$properties" => -54,
			"use constant" => -54,
			"## no critic qw(" => 2
		},
		GOTOS => {
			'Critic' => 71,
			'STAR-21' => 72
		}
	},
	{#State 63
		ACTIONS => {
			'MY' => 74
		},
		GOTOS => {
			'TypeInnerConstant' => 73
		}
	},
	{#State 64
		DEFAULT => -32
	},
	{#State 65
		ACTIONS => {
			"= sub {" => 75
		}
	},
	{#State 66
		DEFAULT => -38
	},
	{#State 67
		ACTIONS => {
			'WORD' => 77,
			")" => 76
		}
	},
	{#State 68
		DEFAULT => -33
	},
	{#State 69
		DEFAULT => -12
	},
	{#State 70
		ACTIONS => {
			"our" => 44,
			'LPAREN' => 121,
			'OP01_NAMED_VOID' => 118,
			"\@{" => 122,
			'OP19_LOOP_CONTROL' => 124,
			'OP10_NAMED_UNARY' => 123,
			'OP05_LOGICAL_NEG' => 106,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'LITERAL_STRING' => 104,
			'WORD_UPPERCASE' => 107,
			"foreach" => -142,
			'OP01_NAMED_VOID_LPAREN' => 111,
			"while" => -142,
			'VARIABLE_SYMBOL' => 109,
			'OP01_PRINT' => 114,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			"%{" => 93,
			'MY' => 98,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			'WORD' => 25,
			"for" => -142,
			'OP01_NAMED' => 80,
			'LITERAL_NUMBER' => 78,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 85,
			"if" => 83,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACKET' => 91
		},
		GOTOS => {
			'Expression' => 99,
			'Literal' => 101,
			'LoopLabel' => 100,
			'VariableDeclaration' => 103,
			'OPTIONAL-36' => 102,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'VariableModification' => 92,
			'Operation' => 117,
			'HashReference' => 120,
			'Conditional' => 119,
			'HashDereference' => 95,
			'Statement' => 112,
			'Variable' => 110,
			'Operator' => 89,
			'PLUS-8' => 90,
			'OperatorVoid' => 81,
			'ArrayDereference' => 79,
			'PAREN-35' => 82,
			'Subroutine' => 84,
			'SubExpression' => 108
		}
	},
	{#State 71
		DEFAULT => -51
	},
	{#State 72
		ACTIONS => {
			"use" => 34,
			"use constant" => -56,
			"our hashref \$properties" => -56
		},
		GOTOS => {
			'STAR-22' => 125,
			'Include' => 126
		}
	},
	{#State 73
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104
		},
		GOTOS => {
			'Literal' => 127
		}
	},
	{#State 74
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 128
		}
	},
	{#State 75
		ACTIONS => {
			'OP01_NAMED_VOID' => -43,
			'LPAREN' => -43,
			'OP10_NAMED_UNARY' => -43,
			'OP19_LOOP_CONTROL' => -43,
			"\@{" => -43,
			"foreach" => -43,
			'WORD_UPPERCASE' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'LITERAL_STRING' => -43,
			'OP05_LOGICAL_NEG' => -43,
			'OP01_PRINT' => -43,
			'WORD_SCOPED' => -43,
			'LBRACE' => -43,
			'VARIABLE_SYMBOL' => -43,
			'LPAREN_MY' => 129,
			'OP01_NAMED_VOID_LPAREN' => -43,
			"while" => -43,
			'OP01_OPEN' => -43,
			'MY' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP01_CLOSE' => -43,
			"%{" => -43,
			"for" => -43,
			'WORD' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			"if" => -43,
			'OP03_MATH_INC_DEC' => -43,
			"undef" => -43,
			'OP01_NAMED' => -43,
			'LITERAL_NUMBER' => -43,
			'LBRACKET' => -43,
			"}" => -43,
			'OP22_LOGICAL_NEG' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 131,
			'SubroutineArguments' => 130
		}
	},
	{#State 76
		ACTIONS => {
			";" => 132
		}
	},
	{#State 77
		DEFAULT => -37
	},
	{#State 78
		DEFAULT => -218
	},
	{#State 79
		DEFAULT => -134
	},
	{#State 80
		ACTIONS => {
			"%{" => 93,
			'OP01_QW' => 136,
			'MY' => 134,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113
		},
		GOTOS => {
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79,
			'ListElement' => 137,
			'SubExpression' => 140,
			'HashReference' => 120,
			'HashDereference' => 95,
			'Expression' => 133,
			'TypeInner' => 138,
			'Variable' => 139,
			'Operator' => 89,
			'Literal' => 101
		}
	},
	{#State 81
		DEFAULT => -145
	},
	{#State 82
		DEFAULT => -141
	},
	{#State 83
		ACTIONS => {
			'LPAREN' => 142
		}
	},
	{#State 84
		DEFAULT => -14
	},
	{#State 85
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			"%{" => 93,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'OP01_OPEN' => 94,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123
		},
		GOTOS => {
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 143,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'Operator' => 89,
			'Literal' => 101,
			'Variable' => 139,
			'Expression' => 133
		}
	},
	{#State 86
		DEFAULT => -130
	},
	{#State 87
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Variable' => 144
		}
	},
	{#State 88
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'Expression' => 133,
			'Variable' => 139,
			'HashReference' => 120,
			'HashDereference' => 95,
			'SubExpression' => 145,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79
		}
	},
	{#State 89
		DEFAULT => -124
	},
	{#State 90
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 80,
			"if" => 83,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			'OP22_LOGICAL_NEG' => 88,
			'' => -18,
			'LBRACKET' => 91,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'MY' => 98,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'WORD' => 25,
			"for" => -142,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'LITERAL_STRING' => 104,
			'OP05_LOGICAL_NEG' => 106,
			"foreach" => -142,
			'WORD_UPPERCASE' => 107,
			'VARIABLE_SYMBOL' => 109,
			"while" => -142,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP01_PRINT' => 114,
			'OP01_NAMED_VOID' => 118,
			'LPAREN' => 121,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			'OP19_LOOP_CONTROL' => 124
		},
		GOTOS => {
			'HashDereference' => 95,
			'Conditional' => 119,
			'HashReference' => 120,
			'Operation' => 146,
			'VariableModification' => 92,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'VariableDeclaration' => 103,
			'OPTIONAL-36' => 102,
			'LoopLabel' => 100,
			'Literal' => 101,
			'Expression' => 99,
			'SubExpression' => 108,
			'PAREN-35' => 82,
			'ArrayDereference' => 79,
			'OperatorVoid' => 81,
			'Operator' => 89,
			'Variable' => 110,
			'Statement' => 112
		}
	},
	{#State 91
		ACTIONS => {
			'MY' => 134,
			'OP01_QW' => 136,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'OP01_OPEN' => 94,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"]" => -185,
			"\@{" => 122,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'OPTIONAL-46' => 149,
			'Variable' => 139,
			'Expression' => 133,
			'TypeInner' => 138,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 148,
			'ArrayDereference' => 79,
			'ListElement' => 147,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ListElements' => 150
		}
	},
	{#State 92
		DEFAULT => -147
	},
	{#State 93
		ACTIONS => {
			'MY' => 134,
			'LBRACE' => -203,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'TypeInner' => 152,
			'Variable' => 151,
			'OPTIONAL-51' => 153
		}
	},
	{#State 94
		ACTIONS => {
			'MY' => 154
		}
	},
	{#State 95
		DEFAULT => -136
	},
	{#State 96
		ACTIONS => {
			'FHREF_SYMBOL' => 155
		}
	},
	{#State 97
		DEFAULT => -114
	},
	{#State 98
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56,
			'TYPE_FHREF' => 157
		},
		GOTOS => {
			'Type' => 156
		}
	},
	{#State 99
		ACTIONS => {
			'OP04_MATH_POW' => -129,
			'OP08_MATH_ADD_SUB' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP18_TERNARY' => -129,
			'OP23_LOGICAL_AND' => -129,
			";" => 158,
			'OP14_BITWISE_OR_XOR' => -129,
			'OP17_LIST_RANGE' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP08_STRING_CAT' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP06_REGEX_MATCH' => -129
		}
	},
	{#State 100
		ACTIONS => {
			'COLON' => 159
		}
	},
	{#State 101
		DEFAULT => -131
	},
	{#State 102
		ACTIONS => {
			"while" => 162,
			"foreach" => 161,
			"for" => 166
		},
		GOTOS => {
			'LoopWhile' => 160,
			'LoopForEach' => 165,
			'LoopFor' => 163,
			'Loop' => 164
		}
	},
	{#State 103
		DEFAULT => -146
	},
	{#State 104
		DEFAULT => -219
	},
	{#State 105
		DEFAULT => -118
	},
	{#State 106
		ACTIONS => {
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87
		},
		GOTOS => {
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'SubExpression' => 167,
			'HashDereference' => 95,
			'HashReference' => 120,
			'Variable' => 139,
			'Expression' => 133,
			'Literal' => 101,
			'Operator' => 89
		}
	},
	{#State 107
		ACTIONS => {
			'LPAREN' => 168,
			'COLON' => -208
		}
	},
	{#State 108
		ACTIONS => {
			'OP04_MATH_POW' => 177,
			'OP23_LOGICAL_AND' => 173,
			'OP18_TERNARY' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP16_LOGICAL_OR' => 172,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP17_LIST_RANGE' => 185,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => 180
		}
	},
	{#State 109
		DEFAULT => -165,
		GOTOS => {
			'STAR-42' => 186
		}
	},
	{#State 110
		ACTIONS => {
			'OP16_LOGICAL_OR' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP19_VARIABLE_ASSIGN_BY' => 190,
			'OP18_TERNARY' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP02_METHOD_THINARROW' => 188,
			'OP03_MATH_INC_DEC' => 187,
			'OP04_MATH_POW' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP19_VARIABLE_ASSIGN' => 189,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP08_STRING_CAT' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP17_LIST_RANGE' => -132
		}
	},
	{#State 111
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 85,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'OP05_LOGICAL_NEG' => 106,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_QW' => 136,
			'MY' => 134,
			"%{" => 93,
			")" => -111,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25
		},
		GOTOS => {
			'HashReference' => 120,
			'HashDereference' => 95,
			'OPTIONAL-32' => 191,
			'SubExpression' => 148,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ListElement' => 147,
			'ArrayDereference' => 79,
			'ListElements' => 192,
			'Literal' => 101,
			'Operator' => 89,
			'Expression' => 133,
			'TypeInner' => 138,
			'Variable' => 139
		}
	},
	{#State 112
		DEFAULT => -77
	},
	{#State 113
		ACTIONS => {
			'LITERAL_STRING' => 104,
			'VARIABLE_SYMBOL' => 109,
			'LITERAL_NUMBER' => 78,
			'WORD' => 197,
			"%{" => 93,
			"}" => 195
		},
		GOTOS => {
			'HashDereference' => 196,
			'HashEntry' => 199,
			'Literal' => 198,
			'Variable' => 193,
			'VariableOrLiteralOrWord' => 194
		}
	},
	{#State 114
		ACTIONS => {
			"\@{" => -109,
			'WORD' => -109,
			'OP10_NAMED_UNARY' => -109,
			'FHREF_SYMBOL_BRACES' => 202,
			'STDOUT_STDERR' => 200,
			"%{" => -109,
			'OP01_OPEN' => -109,
			'OP01_QW' => -109,
			'MY' => -109,
			'OP01_CLOSE' => -109,
			'LPAREN' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP22_LOGICAL_NEG' => -109,
			'LBRACE' => -109,
			'WORD_SCOPED' => -109,
			'LBRACKET' => -109,
			'OP01_NAMED' => -109,
			'LITERAL_STRING' => -109,
			'LITERAL_NUMBER' => -109,
			'OP05_LOGICAL_NEG' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'OP03_MATH_INC_DEC' => -109,
			'WORD_UPPERCASE' => -109,
			"undef" => -109
		},
		GOTOS => {
			'OPTIONAL-31' => 203,
			'PAREN-30' => 201
		}
	},
	{#State 115
		ACTIONS => {
			'OP02_METHOD_THINARROW_NEW' => 205,
			'LPAREN' => 204
		}
	},
	{#State 116
		DEFAULT => -133
	},
	{#State 117
		DEFAULT => -17
	},
	{#State 118
		ACTIONS => {
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'MY' => 134,
			'OP01_QW' => 136,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86
		},
		GOTOS => {
			'ListElement' => 147,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ListElements' => 206,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 148,
			'Variable' => 139,
			'TypeInner' => 138,
			'Expression' => 133,
			'Literal' => 101,
			'Operator' => 89
		}
	},
	{#State 119
		DEFAULT => -143
	},
	{#State 120
		DEFAULT => -135
	},
	{#State 121
		ACTIONS => {
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			"%{" => 93,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP01_PRINT' => 209,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 207,
			'LITERAL_STRING' => 104,
			'OP05_LOGICAL_NEG' => 106
		},
		GOTOS => {
			'Variable' => 139,
			'Expression' => 133,
			'Operator' => 89,
			'Literal' => 101,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 208
		}
	},
	{#State 122
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'MY' => 134,
			'LBRACKET' => -188
		},
		GOTOS => {
			'OPTIONAL-47' => 212,
			'TypeInner' => 211,
			'Variable' => 210
		}
	},
	{#State 123
		ACTIONS => {
			"}" => -95,
			'LBRACKET' => 91,
			'OP08_MATH_ADD_SUB' => -95,
			'OP22_LOGICAL_NEG' => 88,
			'OP21_LIST_COMMA' => -95,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			'OP04_MATH_POW' => -95,
			'OP05_MATH_NEG_LPAREN' => 85,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'OP13_BITWISE_AND' => -95,
			'OP08_STRING_CAT' => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'WORD' => 25,
			'OP09_BITWISE_SHIFT' => -95,
			'OP15_LOGICAL_AND' => -95,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'OP01_CLOSE' => 96,
			'OP17_LIST_RANGE' => -95,
			'OP01_OPEN' => 94,
			"%{" => 93,
			")" => -95,
			'OP23_LOGICAL_AND' => -95,
			";" => -95,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP07_STRING_REPEAT' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'VARIABLE_SYMBOL' => 109,
			'OP18_TERNARY' => -95,
			'WORD_UPPERCASE' => 141,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP10_NAMED_UNARY' => 123,
			"]" => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			"\@{" => 122,
			'LPAREN' => 121,
			'OP14_BITWISE_OR_XOR' => -95
		},
		GOTOS => {
			'Variable' => 139,
			'Expression' => 133,
			'Operator' => 89,
			'Literal' => 101,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 213
		}
	},
	{#State 124
		ACTIONS => {
			'WORD_UPPERCASE' => 214
		},
		GOTOS => {
			'LoopLabel' => 215
		}
	},
	{#State 125
		ACTIONS => {
			"our hashref \$properties" => 218,
			"use constant" => 41
		},
		GOTOS => {
			'Properties' => 216,
			'Constant' => 217
		}
	},
	{#State 126
		DEFAULT => -53
	},
	{#State 127
		ACTIONS => {
			";" => 219
		}
	},
	{#State 128
		ACTIONS => {
			"\$TYPED_" => 220
		}
	},
	{#State 129
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 221
		}
	},
	{#State 130
		DEFAULT => -42
	},
	{#State 131
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 222
		}
	},
	{#State 132
		DEFAULT => -40
	},
	{#State 133
		DEFAULT => -129
	},
	{#State 134
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 223
		}
	},
	{#State 135
		ACTIONS => {
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"\@{" => 122,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			"%{" => 93
		},
		GOTOS => {
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 224,
			'Variable' => 139,
			'Expression' => 133,
			'Operator' => 89,
			'Literal' => 101
		}
	},
	{#State 136
		ACTIONS => {
			'WORD' => 226
		},
		GOTOS => {
			'PLUS-45' => 225
		}
	},
	{#State 137
		ACTIONS => {
			'OP21_LIST_COMMA' => 227
		}
	},
	{#State 138
		ACTIONS => {
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"\@{" => 122,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'OP01_OPEN' => 94,
			"%{" => 93,
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 101,
			'Expression' => 133,
			'Variable' => 139,
			'HashReference' => 120,
			'HashDereference' => 95,
			'SubExpression' => 228,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79
		}
	},
	{#State 139
		ACTIONS => {
			'OP08_STRING_CAT' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			"]" => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP17_LIST_RANGE' => -132,
			")" => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			"}" => -132,
			'OP23_LOGICAL_AND' => -132,
			";" => -132,
			'OP08_MATH_ADD_SUB' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP21_LIST_COMMA' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP11_COMPARE_LT_GT' => -132,
			'OP18_TERNARY' => -132,
			'OP03_MATH_INC_DEC' => 187,
			'OP04_MATH_POW' => -132,
			'OP02_METHOD_THINARROW' => 188
		}
	},
	{#State 140
		ACTIONS => {
			'OP23_LOGICAL_AND' => -79,
			";" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP21_LIST_COMMA' => -181,
			'OP11_COMPARE_LT_GT' => -79,
			'OP18_TERNARY' => -79,
			'OP04_MATH_POW' => -79,
			'OP08_STRING_CAT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP17_LIST_RANGE' => -79,
			")" => -79,
			'OP14_BITWISE_OR_XOR' => -79
		}
	},
	{#State 141
		ACTIONS => {
			'LPAREN' => 168
		}
	},
	{#State 142
		ACTIONS => {
			"%{" => 93,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'Variable' => 139,
			'Expression' => 133,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 229,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116
		}
	},
	{#State 143
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP23_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 177,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			")" => 230,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185
		}
	},
	{#State 144
		DEFAULT => -83
	},
	{#State 145
		ACTIONS => {
			")" => -104,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -104,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 177,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP21_LIST_COMMA' => -104,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			"}" => -104,
			'OP23_LOGICAL_AND' => -104,
			";" => -104
		}
	},
	{#State 146
		DEFAULT => -16
	},
	{#State 147
		DEFAULT => -177,
		GOTOS => {
			'STAR-44' => 231
		}
	},
	{#State 148
		ACTIONS => {
			")" => -181,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -181,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 177,
			'OP21_LIST_COMMA' => -181,
			'OP16_LOGICAL_OR' => 172,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP18_TERNARY' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			";" => -181,
			'OP23_LOGICAL_AND' => 173
		}
	},
	{#State 149
		ACTIONS => {
			"]" => 232
		}
	},
	{#State 150
		DEFAULT => -184
	},
	{#State 151
		ACTIONS => {
			"}" => 233
		}
	},
	{#State 152
		DEFAULT => -202
	},
	{#State 153
		ACTIONS => {
			'LBRACE' => 113
		},
		GOTOS => {
			'HashReference' => 234
		}
	},
	{#State 154
		ACTIONS => {
			'TYPE_FHREF' => 235
		}
	},
	{#State 155
		DEFAULT => -82
	},
	{#State 156
		ACTIONS => {
			'VARIABLE_SYMBOL' => 236
		}
	},
	{#State 157
		ACTIONS => {
			'FHREF_SYMBOL' => 237
		}
	},
	{#State 158
		DEFAULT => -76
	},
	{#State 159
		DEFAULT => -140
	},
	{#State 160
		DEFAULT => -157
	},
	{#State 161
		ACTIONS => {
			'MY' => 238
		}
	},
	{#State 162
		ACTIONS => {
			'LPAREN' => 239
		}
	},
	{#State 163
		DEFAULT => -155
	},
	{#State 164
		DEFAULT => -144
	},
	{#State 165
		DEFAULT => -156
	},
	{#State 166
		ACTIONS => {
			'MY' => 240
		}
	},
	{#State 167
		ACTIONS => {
			"}" => -86,
			'OP23_LOGICAL_AND' => -86,
			";" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			'OP18_TERNARY' => -86,
			'OP07_STRING_REPEAT' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP04_MATH_POW' => 177,
			'OP06_REGEX_MATCH' => -86,
			'OP08_STRING_CAT' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			"]" => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP17_LIST_RANGE' => -86,
			'OP14_BITWISE_OR_XOR' => -86,
			")" => -86
		}
	},
	{#State 168
		ACTIONS => {
			")" => 241
		}
	},
	{#State 169
		ACTIONS => {
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'Variable' => 139,
			'Expression' => 133,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 242,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 170
		ACTIONS => {
			'LITERAL_NUMBER' => 78,
			'VARIABLE_SYMBOL' => 109,
			'LITERAL_STRING' => 104
		},
		GOTOS => {
			'Literal' => 243,
			'VariableOrLiteral' => 244,
			'Variable' => 245
		}
	},
	{#State 171
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'OP01_OPEN' => 94,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"\@{" => 122
		},
		GOTOS => {
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 246,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'Literal' => 101,
			'Operator' => 89,
			'Variable' => 139,
			'Expression' => 133
		}
	},
	{#State 172
		ACTIONS => {
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'Variable' => 139,
			'Expression' => 133,
			'SubExpression' => 247,
			'HashDereference' => 95,
			'HashReference' => 120,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 173
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			"%{" => 93,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123
		},
		GOTOS => {
			'Expression' => 133,
			'Variable' => 139,
			'Operator' => 89,
			'Literal' => 101,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79,
			'SubExpression' => 248,
			'HashReference' => 120,
			'HashDereference' => 95
		}
	},
	{#State 174
		ACTIONS => {
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121
		},
		GOTOS => {
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79,
			'SubExpression' => 249,
			'HashReference' => 120,
			'HashDereference' => 95,
			'Expression' => 133,
			'Variable' => 139,
			'Literal' => 101,
			'Operator' => 89
		}
	},
	{#State 175
		ACTIONS => {
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"\@{" => 122,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			"%{" => 93
		},
		GOTOS => {
			'Expression' => 133,
			'Variable' => 139,
			'Operator' => 89,
			'Literal' => 101,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79,
			'SubExpression' => 250,
			'HashReference' => 120,
			'HashDereference' => 95
		}
	},
	{#State 176
		ACTIONS => {
			"%{" => 93,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91
		},
		GOTOS => {
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79,
			'SubExpression' => 251,
			'HashReference' => 120,
			'HashDereference' => 95,
			'Expression' => 133,
			'Variable' => 139,
			'Literal' => 101,
			'Operator' => 89
		}
	},
	{#State 177
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"\@{" => 122
		},
		GOTOS => {
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79,
			'HashReference' => 120,
			'HashDereference' => 95,
			'SubExpression' => 252,
			'Expression' => 133,
			'Variable' => 139,
			'Literal' => 101,
			'Operator' => 89
		}
	},
	{#State 178
		ACTIONS => {
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"\@{" => 122
		},
		GOTOS => {
			'Variable' => 139,
			'Expression' => 133,
			'Literal' => 101,
			'Operator' => 89,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'SubExpression' => 253,
			'HashDereference' => 95,
			'HashReference' => 120
		}
	},
	{#State 179
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 101,
			'Expression' => 133,
			'Variable' => 139,
			'SubExpression' => 254,
			'HashReference' => 120,
			'HashDereference' => 95,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79
		}
	},
	{#State 180
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 106,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			"%{" => 93,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 101,
			'Variable' => 139,
			'Expression' => 133,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 255,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116
		}
	},
	{#State 181
		ACTIONS => {
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86
		},
		GOTOS => {
			'Variable' => 139,
			'Expression' => 133,
			'Literal' => 101,
			'Operator' => 89,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'SubExpression' => 256,
			'HashDereference' => 95,
			'HashReference' => 120
		}
	},
	{#State 182
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 257
		}
	},
	{#State 183
		ACTIONS => {
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'Variable' => 139,
			'Expression' => 133,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 258,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 184
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 85,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94
		},
		GOTOS => {
			'Variable' => 139,
			'Expression' => 133,
			'Literal' => 101,
			'Operator' => 89,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'SubExpression' => 259,
			'HashDereference' => 95,
			'HashReference' => 120
		}
	},
	{#State 185
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25
		},
		GOTOS => {
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 260,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'Operator' => 89,
			'Literal' => 101,
			'Variable' => 139,
			'Expression' => 133
		}
	},
	{#State 186
		ACTIONS => {
			'OP02_METHOD_THINARROW' => -166,
			'OP03_MATH_INC_DEC' => -166,
			'OP02_ARRAY_THINARROW' => 262,
			'OP04_MATH_POW' => -166,
			'OP16_LOGICAL_OR' => -166,
			'OP21_LIST_COMMA' => -166,
			'OP08_MATH_ADD_SUB' => -166,
			'OP07_STRING_REPEAT' => -166,
			'OP18_TERNARY' => -166,
			'OP19_VARIABLE_ASSIGN_BY' => -166,
			'OP11_COMPARE_LT_GT' => -166,
			'OP20_HASH_FATARROW' => -166,
			";" => -166,
			"}" => -166,
			'OP23_LOGICAL_AND' => -166,
			")" => -166,
			'OP14_BITWISE_OR_XOR' => -166,
			'OP17_LIST_RANGE' => -166,
			'COLON' => -166,
			'OP02_HASH_THINARROW' => 261,
			'OP09_BITWISE_SHIFT' => -166,
			"]" => -166,
			'OP19_VARIABLE_ASSIGN' => -166,
			'OP24_LOGICAL_OR_XOR' => -166,
			'OP07_MATH_MULT_DIV_MOD' => -166,
			'OP15_LOGICAL_AND' => -166,
			'OP12_COMPARE_EQ_NE' => -166,
			'OP08_STRING_CAT' => -166,
			'OP13_BITWISE_AND' => -166,
			'OP06_REGEX_MATCH' => -166
		},
		GOTOS => {
			'VariableRetrieval' => 263
		}
	},
	{#State 187
		DEFAULT => -84
	},
	{#State 188
		ACTIONS => {
			'LPAREN' => 264
		}
	},
	{#State 189
		ACTIONS => {
			"%{" => 93,
			'OP01_OPEN' => 94,
			'STDIN' => 267,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91
		},
		GOTOS => {
			'Expression' => 133,
			'Variable' => 139,
			'Operator' => 89,
			'Literal' => 101,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79,
			'SubExpressionOrStdin' => 266,
			'SubExpression' => 265,
			'HashReference' => 120,
			'HashDereference' => 95
		}
	},
	{#State 190
		ACTIONS => {
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 85
		},
		GOTOS => {
			'Expression' => 133,
			'Variable' => 139,
			'Literal' => 101,
			'Operator' => 89,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79,
			'HashReference' => 120,
			'HashDereference' => 95,
			'SubExpression' => 268
		}
	},
	{#State 191
		ACTIONS => {
			")" => 269
		}
	},
	{#State 192
		DEFAULT => -110
	},
	{#State 193
		DEFAULT => -215
	},
	{#State 194
		ACTIONS => {
			'OP20_HASH_FATARROW' => 270
		}
	},
	{#State 195
		DEFAULT => -201
	},
	{#State 196
		DEFAULT => -194
	},
	{#State 197
		DEFAULT => -217
	},
	{#State 198
		DEFAULT => -216
	},
	{#State 199
		DEFAULT => -199,
		GOTOS => {
			'STAR-50' => 271
		}
	},
	{#State 200
		DEFAULT => -107
	},
	{#State 201
		DEFAULT => -108
	},
	{#State 202
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP05_MATH_NEG_LPAREN' => 85,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'OP05_LOGICAL_NEG' => 106,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'MY' => 134,
			'OP01_QW' => 136,
			"%{" => 93
		},
		GOTOS => {
			'TypeInner' => 138,
			'Expression' => 133,
			'Variable' => 139,
			'Operator' => 89,
			'Literal' => 101,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ListElement' => 147,
			'ArrayDereference' => 79,
			'ListElements' => 272,
			'HashReference' => 120,
			'HashDereference' => 95,
			'SubExpression' => 148
		}
	},
	{#State 203
		ACTIONS => {
			"%{" => 93,
			'OP01_OPEN' => 94,
			'OP01_QW' => 136,
			'MY' => 134,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91
		},
		GOTOS => {
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 148,
			'ListElement' => 147,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ListElements' => 273,
			'Literal' => 101,
			'Operator' => 89,
			'Variable' => 139,
			'Expression' => 133,
			'TypeInner' => 138
		}
	},
	{#State 204
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25,
			'OP01_OPEN' => 94,
			'MY' => 134,
			'OP01_QW' => 136,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			")" => -121,
			"%{" => 93
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 101,
			'TypeInner' => 138,
			'Expression' => 133,
			'Variable' => 139,
			'OPTIONAL-33' => 274,
			'SubExpression' => 148,
			'HashReference' => 120,
			'HashDereference' => 95,
			'ListElements' => 275,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79,
			'ListElement' => 147
		}
	},
	{#State 205
		ACTIONS => {
			")" => 276
		}
	},
	{#State 206
		ACTIONS => {
			";" => 277
		}
	},
	{#State 207
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'OP05_MATH_NEG_LPAREN' => 85,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_QW' => 136,
			'MY' => 134,
			'OP01_OPEN' => 94
		},
		GOTOS => {
			'ArrayDereference' => 79,
			'ListElement' => 278,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 140,
			'Variable' => 139,
			'TypeInner' => 138,
			'Expression' => 133,
			'Operator' => 89,
			'Literal' => 101
		}
	},
	{#State 208
		ACTIONS => {
			")" => 279,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 177,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP23_LOGICAL_AND' => 173
		}
	},
	{#State 209
		ACTIONS => {
			'FHREF_SYMBOL_BRACES' => 280
		}
	},
	{#State 210
		ACTIONS => {
			"}" => 281
		}
	},
	{#State 211
		DEFAULT => -187
	},
	{#State 212
		ACTIONS => {
			'LBRACKET' => 91
		},
		GOTOS => {
			'ArrayReference' => 282
		}
	},
	{#State 213
		ACTIONS => {
			'OP23_LOGICAL_AND' => -94,
			"}" => -94,
			";" => -94,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP16_LOGICAL_OR' => -94,
			'OP21_LIST_COMMA' => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP18_TERNARY' => -94,
			'OP04_MATH_POW' => 177,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => -94,
			'OP06_REGEX_MATCH' => 182,
			'OP24_LOGICAL_OR_XOR' => -94,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP17_LIST_RANGE' => -94,
			")" => -94,
			'OP14_BITWISE_OR_XOR' => -94
		}
	},
	{#State 214
		DEFAULT => -208
	},
	{#State 215
		ACTIONS => {
			";" => 283
		}
	},
	{#State 216
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 284
		}
	},
	{#State 217
		DEFAULT => -55
	},
	{#State 218
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 285
		}
	},
	{#State 219
		DEFAULT => -41
	},
	{#State 220
		ACTIONS => {
			'WORD_UPPERCASE' => 286
		}
	},
	{#State 221
		ACTIONS => {
			'VARIABLE_SYMBOL' => 287
		}
	},
	{#State 222
		ACTIONS => {
			"%{" => 93,
			'MY' => 98,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			'WORD' => 25,
			"for" => -142,
			'OP01_NAMED' => 80,
			'LITERAL_NUMBER' => 78,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 85,
			"if" => 83,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACKET' => 91,
			"}" => 288,
			'LPAREN' => 121,
			'OP01_NAMED_VOID' => 118,
			"\@{" => 122,
			'OP19_LOOP_CONTROL' => 124,
			'OP10_NAMED_UNARY' => 123,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'WORD_UPPERCASE' => 107,
			"foreach" => -142,
			'OP01_NAMED_VOID_LPAREN' => 111,
			"while" => -142,
			'VARIABLE_SYMBOL' => 109,
			'OP01_PRINT' => 114,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113
		},
		GOTOS => {
			'HashReference' => 120,
			'Conditional' => 119,
			'HashDereference' => 95,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'VariableModification' => 92,
			'Operation' => 289,
			'Literal' => 101,
			'LoopLabel' => 100,
			'OPTIONAL-36' => 102,
			'VariableDeclaration' => 103,
			'Expression' => 99,
			'SubExpression' => 108,
			'OperatorVoid' => 81,
			'ArrayDereference' => 79,
			'PAREN-35' => 82,
			'Operator' => 89,
			'Statement' => 112,
			'Variable' => 110
		}
	},
	{#State 223
		ACTIONS => {
			"\$TYPED_" => 290
		}
	},
	{#State 224
		ACTIONS => {
			'OP04_MATH_POW' => -79,
			";" => -79,
			'OP23_LOGICAL_AND' => -79,
			"}" => -79,
			'OP18_TERNARY' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP17_LIST_RANGE' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			")" => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP08_STRING_CAT' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP15_LOGICAL_AND' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			"]" => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP24_LOGICAL_OR_XOR' => -79
		}
	},
	{#State 225
		ACTIONS => {
			'WORD' => 292,
			")" => 291
		}
	},
	{#State 226
		DEFAULT => -180
	},
	{#State 227
		ACTIONS => {
			"%{" => 93,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_QW' => 136,
			'MY' => 134,
			'OP01_OPEN' => 94,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26
		},
		GOTOS => {
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ListElement' => 147,
			'ArrayDereference' => 79,
			'ListElements' => 293,
			'HashReference' => 120,
			'HashDereference' => 95,
			'SubExpression' => 148,
			'Expression' => 133,
			'TypeInner' => 138,
			'Variable' => 139,
			'Literal' => 101,
			'Operator' => 89
		}
	},
	{#State 228
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP21_LIST_COMMA' => -182,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP23_LOGICAL_AND' => 173,
			";" => -182,
			'OP04_MATH_POW' => 177,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -182,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP06_REGEX_MATCH' => 182,
			")" => -182,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185
		}
	},
	{#State 229
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP23_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 177,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP14_BITWISE_OR_XOR' => 175,
			")" => 294,
			'OP17_LIST_RANGE' => 185
		}
	},
	{#State 230
		DEFAULT => -87
	},
	{#State 231
		ACTIONS => {
			";" => -178,
			")" => -178,
			"]" => -178,
			'OP21_LIST_COMMA' => 296
		},
		GOTOS => {
			'PAREN-43' => 295
		}
	},
	{#State 232
		DEFAULT => -186
	},
	{#State 233
		DEFAULT => -204
	},
	{#State 234
		ACTIONS => {
			"}" => 297
		}
	},
	{#State 235
		ACTIONS => {
			'FHREF_SYMBOL' => 298
		}
	},
	{#State 236
		ACTIONS => {
			";" => 300,
			'OP19_VARIABLE_ASSIGN' => 299
		}
	},
	{#State 237
		ACTIONS => {
			";" => 301
		}
	},
	{#State 238
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 302
		}
	},
	{#State 239
		ACTIONS => {
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"%{" => 93,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 106
		},
		GOTOS => {
			'Variable' => 139,
			'Expression' => 133,
			'Literal' => 101,
			'Operator' => 89,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'SubExpression' => 303,
			'HashDereference' => 95,
			'HashReference' => 120
		}
	},
	{#State 240
		ACTIONS => {
			'TYPE_INTEGER' => 304
		}
	},
	{#State 241
		DEFAULT => -126
	},
	{#State 242
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -96,
			")" => -96,
			'OP17_LIST_RANGE' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => -96,
			"]" => -96,
			'OP09_BITWISE_SHIFT' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => -96,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 177,
			'OP11_COMPARE_LT_GT' => undef,
			'OP18_TERNARY' => -96,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP16_LOGICAL_OR' => -96,
			'OP21_LIST_COMMA' => -96,
			"}" => -96,
			'OP23_LOGICAL_AND' => -96,
			";" => -96
		}
	},
	{#State 243
		DEFAULT => -214
	},
	{#State 244
		ACTIONS => {
			'COLON' => 305
		}
	},
	{#State 245
		DEFAULT => -213
	},
	{#State 246
		ACTIONS => {
			'OP21_LIST_COMMA' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP07_STRING_REPEAT' => -89,
			'OP18_TERNARY' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			";" => -89,
			'OP23_LOGICAL_AND' => -89,
			"}" => -89,
			'OP04_MATH_POW' => 177,
			'OP09_BITWISE_SHIFT' => -89,
			"]" => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP08_STRING_CAT' => -89,
			'OP06_REGEX_MATCH' => 182,
			")" => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP17_LIST_RANGE' => -89
		}
	},
	{#State 247
		ACTIONS => {
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -101,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP17_LIST_RANGE' => -101,
			")" => -101,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP23_LOGICAL_AND' => -101,
			"}" => -101,
			";" => -101,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => -101,
			'OP21_LIST_COMMA' => -101,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => -101,
			'OP04_MATH_POW' => 177
		}
	},
	{#State 248
		ACTIONS => {
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP24_LOGICAL_OR_XOR' => -105,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -105,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP17_LIST_RANGE' => 185,
			")" => -105,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP23_LOGICAL_AND' => -105,
			"}" => -105,
			";" => -105,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP16_LOGICAL_OR' => 172,
			'OP21_LIST_COMMA' => -105,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP04_MATH_POW' => 177
		}
	},
	{#State 249
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => -97,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP21_LIST_COMMA' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP23_LOGICAL_AND' => -97,
			"}" => -97,
			";" => -97,
			'OP04_MATH_POW' => 177,
			'OP15_LOGICAL_AND' => -97,
			'OP12_COMPARE_EQ_NE' => undef,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => -97,
			"]" => -97,
			'OP09_BITWISE_SHIFT' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => -97,
			'OP14_BITWISE_OR_XOR' => -97,
			")" => -97,
			'OP17_LIST_RANGE' => -97
		}
	},
	{#State 250
		ACTIONS => {
			'OP17_LIST_RANGE' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			")" => -99,
			'OP06_REGEX_MATCH' => 182,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => -99,
			"]" => -99,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => -99,
			'OP04_MATH_POW' => 177,
			";" => -99,
			'OP23_LOGICAL_AND' => -99,
			"}" => -99,
			'OP18_TERNARY' => -99,
			'OP11_COMPARE_LT_GT' => 169,
			'OP16_LOGICAL_OR' => -99,
			'OP21_LIST_COMMA' => -99,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171
		}
	},
	{#State 251
		ACTIONS => {
			'OP16_LOGICAL_OR' => -91,
			'OP21_LIST_COMMA' => -91,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => -91,
			'OP18_TERNARY' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			";" => -91,
			'OP23_LOGICAL_AND' => -91,
			"}" => -91,
			'OP04_MATH_POW' => 177,
			'OP09_BITWISE_SHIFT' => -91,
			"]" => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP08_STRING_CAT' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP06_REGEX_MATCH' => 182,
			")" => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP17_LIST_RANGE' => -91
		}
	},
	{#State 252
		ACTIONS => {
			'OP08_STRING_CAT' => -85,
			'OP13_BITWISE_AND' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP09_BITWISE_SHIFT' => -85,
			"]" => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP17_LIST_RANGE' => -85,
			")" => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			";" => -85,
			'OP23_LOGICAL_AND' => -85,
			"}" => -85,
			'OP21_LIST_COMMA' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP07_STRING_REPEAT' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			'OP18_TERNARY' => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP04_MATH_POW' => 177
		}
	},
	{#State 253
		ACTIONS => {
			'OP04_MATH_POW' => 177,
			'OP21_LIST_COMMA' => -100,
			'OP16_LOGICAL_OR' => -100,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP18_TERNARY' => -100,
			'OP11_COMPARE_LT_GT' => 169,
			";" => -100,
			"}" => -100,
			'OP23_LOGICAL_AND' => -100,
			")" => -100,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => -100,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -100,
			'OP24_LOGICAL_OR_XOR' => -100,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP15_LOGICAL_AND' => -100,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP06_REGEX_MATCH' => 182
		}
	},
	{#State 254
		ACTIONS => {
			'OP04_MATH_POW' => 177,
			'OP23_LOGICAL_AND' => -90,
			"}" => -90,
			";" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			'OP18_TERNARY' => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP07_STRING_REPEAT' => 171,
			'OP21_LIST_COMMA' => -90,
			'OP16_LOGICAL_OR' => -90,
			'OP17_LIST_RANGE' => -90,
			'OP14_BITWISE_OR_XOR' => -90,
			")" => -90,
			'OP06_REGEX_MATCH' => 182,
			'OP08_STRING_CAT' => -90,
			'OP13_BITWISE_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			"]" => -90,
			'OP09_BITWISE_SHIFT' => -90
		}
	},
	{#State 255
		ACTIONS => {
			"}" => -106,
			'OP23_LOGICAL_AND' => 173,
			";" => -106,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP21_LIST_COMMA' => -106,
			'OP04_MATH_POW' => 177,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => -106,
			"]" => -106,
			'OP09_BITWISE_SHIFT' => 181,
			'OP17_LIST_RANGE' => 185,
			'OP14_BITWISE_OR_XOR' => 175,
			")" => -106
		}
	},
	{#State 256
		ACTIONS => {
			"}" => -93,
			'OP23_LOGICAL_AND' => -93,
			";" => -93,
			'OP11_COMPARE_LT_GT' => -93,
			'OP18_TERNARY' => -93,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP21_LIST_COMMA' => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP04_MATH_POW' => 177,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => -93,
			'OP08_STRING_CAT' => 183,
			'OP15_LOGICAL_AND' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => -93,
			"]" => -93,
			'OP09_BITWISE_SHIFT' => -93,
			'OP17_LIST_RANGE' => -93,
			'OP14_BITWISE_OR_XOR' => -93,
			")" => -93
		}
	},
	{#State 257
		DEFAULT => -88
	},
	{#State 258
		ACTIONS => {
			'OP04_MATH_POW' => 177,
			'OP11_COMPARE_LT_GT' => -92,
			'OP18_TERNARY' => -92,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP21_LIST_COMMA' => -92,
			'OP16_LOGICAL_OR' => -92,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			";" => -92,
			'OP14_BITWISE_OR_XOR' => -92,
			")" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => -92,
			"]" => -92,
			'OP09_BITWISE_SHIFT' => -92,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => -92,
			'OP08_STRING_CAT' => -92
		}
	},
	{#State 259
		ACTIONS => {
			'OP04_MATH_POW' => 177,
			"}" => -98,
			'OP23_LOGICAL_AND' => -98,
			";" => -98,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => -98,
			'OP21_LIST_COMMA' => -98,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => -98,
			'OP17_LIST_RANGE' => -98,
			")" => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => -98,
			'OP06_REGEX_MATCH' => 182,
			'OP24_LOGICAL_OR_XOR' => -98,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -98,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => -98,
			'OP07_MATH_MULT_DIV_MOD' => 179
		}
	},
	{#State 260
		ACTIONS => {
			'OP04_MATH_POW' => 177,
			'OP23_LOGICAL_AND' => -102,
			"}" => -102,
			";" => -102,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => -102,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP21_LIST_COMMA' => -102,
			'OP16_LOGICAL_OR' => 172,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 175,
			")" => -102,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => -102,
			"]" => -102,
			'OP09_BITWISE_SHIFT' => 181
		}
	},
	{#State 261
		ACTIONS => {
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 306,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'LITERAL_NUMBER' => 78,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'OP05_LOGICAL_NEG' => 106,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 101,
			'Variable' => 139,
			'Expression' => 133,
			'SubExpression' => 307,
			'HashDereference' => 95,
			'HashReference' => 120,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116
		}
	},
	{#State 262
		ACTIONS => {
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123
		},
		GOTOS => {
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79,
			'SubExpression' => 308,
			'HashReference' => 120,
			'HashDereference' => 95,
			'Expression' => 133,
			'Variable' => 139,
			'Literal' => 101,
			'Operator' => 89
		}
	},
	{#State 263
		DEFAULT => -164
	},
	{#State 264
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'OP01_QW' => 136,
			'MY' => 134,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'OP01_OPEN' => 94,
			")" => -123,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"\@{" => 122
		},
		GOTOS => {
			'Variable' => 139,
			'Expression' => 133,
			'TypeInner' => 138,
			'OPTIONAL-34' => 309,
			'Literal' => 101,
			'Operator' => 89,
			'ListElements' => 310,
			'ListElement' => 147,
			'ArrayDereference' => 79,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'SubExpression' => 148,
			'HashDereference' => 95,
			'HashReference' => 120
		}
	},
	{#State 265
		ACTIONS => {
			'OP17_LIST_RANGE' => 185,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP04_MATH_POW' => 177,
			";" => -138,
			'OP23_LOGICAL_AND' => 173,
			'OP18_TERNARY' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP16_LOGICAL_OR' => 172,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176
		}
	},
	{#State 266
		ACTIONS => {
			";" => 311
		}
	},
	{#State 267
		DEFAULT => -139
	},
	{#State 268
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 177,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP23_LOGICAL_AND' => 173,
			";" => 312
		}
	},
	{#State 269
		ACTIONS => {
			";" => 313
		}
	},
	{#State 270
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -192,
			"undef" => -192,
			'WORD_UPPERCASE' => -192,
			'OP05_MATH_NEG_LPAREN' => -192,
			'OP05_LOGICAL_NEG' => -192,
			'LITERAL_STRING' => -192,
			'OP01_NAMED' => -192,
			'LITERAL_NUMBER' => -192,
			'LBRACKET' => -192,
			'WORD_SCOPED' => -192,
			'LBRACE' => -192,
			'OP22_LOGICAL_NEG' => -192,
			'VARIABLE_SYMBOL' => -192,
			'MY' => 134,
			'OP01_CLOSE' => -192,
			'LPAREN' => -192,
			'OP01_OPEN' => -192,
			"%{" => -192,
			'OP10_NAMED_UNARY' => -192,
			'WORD' => -192,
			"\@{" => -192
		},
		GOTOS => {
			'OPTIONAL-48' => 314,
			'TypeInner' => 315
		}
	},
	{#State 271
		ACTIONS => {
			'OP21_LIST_COMMA' => 316,
			"}" => 317
		},
		GOTOS => {
			'PAREN-49' => 318
		}
	},
	{#State 272
		ACTIONS => {
			";" => 319
		}
	},
	{#State 273
		ACTIONS => {
			";" => 320
		}
	},
	{#State 274
		ACTIONS => {
			")" => 321
		}
	},
	{#State 275
		DEFAULT => -120
	},
	{#State 276
		DEFAULT => -128
	},
	{#State 277
		DEFAULT => -116
	},
	{#State 278
		ACTIONS => {
			'OP21_LIST_COMMA' => 322
		}
	},
	{#State 279
		DEFAULT => -137
	},
	{#State 280
		ACTIONS => {
			'MY' => 134,
			'OP01_QW' => 136,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'OP01_OPEN' => 94,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			'WORD' => 25,
			"\@{" => 122,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109
		},
		GOTOS => {
			'Variable' => 139,
			'TypeInner' => 138,
			'Expression' => 133,
			'Literal' => 101,
			'Operator' => 89,
			'ArrayDereference' => 79,
			'ListElement' => 147,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ListElements' => 323,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 148
		}
	},
	{#State 281
		DEFAULT => -189
	},
	{#State 282
		ACTIONS => {
			"}" => 324
		}
	},
	{#State 283
		DEFAULT => -119
	},
	{#State 284
		ACTIONS => {
			'LITERAL_NUMBER' => 325,
			"our" => 327
		},
		GOTOS => {
			'Subroutine' => 326,
			'Method' => 328,
			'MethodOrSubroutine' => 329
		}
	},
	{#State 285
		ACTIONS => {
			'LBRACE' => 330
		}
	},
	{#State 286
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 331
		}
	},
	{#State 287
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 332
		}
	},
	{#State 288
		ACTIONS => {
			";" => 333
		}
	},
	{#State 289
		DEFAULT => -44
	},
	{#State 290
		ACTIONS => {
			'WORD' => 334
		}
	},
	{#State 291
		DEFAULT => -183
	},
	{#State 292
		DEFAULT => -179
	},
	{#State 293
		ACTIONS => {
			";" => 335
		}
	},
	{#State 294
		ACTIONS => {
			'LBRACE' => 337
		},
		GOTOS => {
			'CodeBlock' => 336
		}
	},
	{#State 295
		DEFAULT => -176
	},
	{#State 296
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP01_OPEN' => 94,
			'MY' => 134,
			'OP01_QW' => 136,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25
		},
		GOTOS => {
			'Variable' => 139,
			'Expression' => 133,
			'TypeInner' => 138,
			'Literal' => 101,
			'Operator' => 89,
			'ArrayDereference' => 79,
			'ListElement' => 338,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'SubExpression' => 148,
			'HashDereference' => 95,
			'HashReference' => 120
		}
	},
	{#State 297
		DEFAULT => -205
	},
	{#State 298
		ACTIONS => {
			'OP21_LIST_COMMA' => 339
		}
	},
	{#State 299
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP03_MATH_INC_DEC' => 87,
			'OP05_MATH_NEG_LPAREN' => 85,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'LPAREN' => 121,
			'STDIN' => 267,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94
		},
		GOTOS => {
			'ArrayDereference' => 79,
			'SubExpressionOrStdin' => 340,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'SubExpression' => 265,
			'HashDereference' => 95,
			'HashReference' => 120,
			'Variable' => 139,
			'Expression' => 133,
			'Operator' => 89,
			'Literal' => 101
		}
	},
	{#State 300
		DEFAULT => -170
	},
	{#State 301
		DEFAULT => -172
	},
	{#State 302
		ACTIONS => {
			'VARIABLE_SYMBOL' => 341
		}
	},
	{#State 303
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP06_REGEX_MATCH' => 182,
			")" => 342,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP23_LOGICAL_AND' => 173,
			'OP04_MATH_POW' => 177
		}
	},
	{#State 304
		ACTIONS => {
			'VARIABLE_SYMBOL' => 343
		}
	},
	{#State 305
		ACTIONS => {
			'LITERAL_STRING' => 104,
			'VARIABLE_SYMBOL' => 109,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'Variable' => 245,
			'VariableOrLiteral' => 344,
			'Literal' => 243
		}
	},
	{#State 306
		ACTIONS => {
			"}" => 345,
			'LPAREN' => -206,
			'OP02_METHOD_THINARROW_NEW' => -206
		}
	},
	{#State 307
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => 178,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP04_MATH_POW' => 177,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP16_LOGICAL_OR' => 172,
			'OP23_LOGICAL_AND' => 173,
			"}" => 346
		}
	},
	{#State 308
		ACTIONS => {
			'OP04_MATH_POW' => 177,
			'OP18_TERNARY' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP16_LOGICAL_OR' => 172,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP23_LOGICAL_AND' => 173,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => 178,
			"]" => 347,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183
		}
	},
	{#State 309
		ACTIONS => {
			")" => 348
		}
	},
	{#State 310
		DEFAULT => -122
	},
	{#State 311
		DEFAULT => -173
	},
	{#State 312
		DEFAULT => -174
	},
	{#State 313
		DEFAULT => -115
	},
	{#State 314
		ACTIONS => {
			"%{" => 93,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			'OP01_OPEN' => 94,
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113
		},
		GOTOS => {
			'HashReference' => 120,
			'HashDereference' => 95,
			'SubExpression' => 349,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79,
			'Operator' => 89,
			'Literal' => 101,
			'Expression' => 133,
			'Variable' => 139
		}
	},
	{#State 315
		DEFAULT => -191
	},
	{#State 316
		ACTIONS => {
			'WORD' => 197,
			"%{" => 93,
			'LITERAL_STRING' => 104,
			'VARIABLE_SYMBOL' => 109,
			'LITERAL_NUMBER' => 78
		},
		GOTOS => {
			'VariableOrLiteralOrWord' => 194,
			'Variable' => 193,
			'HashDereference' => 196,
			'HashEntry' => 350,
			'Literal' => 198
		}
	},
	{#State 317
		DEFAULT => -200
	},
	{#State 318
		DEFAULT => -198
	},
	{#State 319
		DEFAULT => -113
	},
	{#State 320
		DEFAULT => -112
	},
	{#State 321
		DEFAULT => -125
	},
	{#State 322
		ACTIONS => {
			"%{" => 93,
			'OP01_OPEN' => 94,
			'OP01_QW' => 136,
			'MY' => 134,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'Expression' => 133,
			'TypeInner' => 138,
			'Variable' => 139,
			'SubExpression' => 148,
			'HashReference' => 120,
			'HashDereference' => 95,
			'ListElements' => 351,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79,
			'ListElement' => 147
		}
	},
	{#State 323
		ACTIONS => {
			")" => 352
		}
	},
	{#State 324
		DEFAULT => -190
	},
	{#State 325
		ACTIONS => {
			";" => 353
		}
	},
	{#State 326
		DEFAULT => -75
	},
	{#State 327
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56,
			'TYPE_METHOD' => 354
		},
		GOTOS => {
			'Type' => 54
		}
	},
	{#State 328
		DEFAULT => -74
	},
	{#State 329
		DEFAULT => -57
	},
	{#State 330
		ACTIONS => {
			"}" => 355,
			'WORD' => 357,
			"%{" => 93
		},
		GOTOS => {
			'HashEntryTyped' => 356,
			'HashDereference' => 358
		}
	},
	{#State 331
		DEFAULT => -212
	},
	{#State 332
		ACTIONS => {
			")" => 360,
			'OP21_LIST_COMMA' => 359
		},
		GOTOS => {
			'PAREN-18' => 361
		}
	},
	{#State 333
		DEFAULT => -46
	},
	{#State 334
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 362
		}
	},
	{#State 335
		DEFAULT => -117
	},
	{#State 336
		DEFAULT => -150,
		GOTOS => {
			'STAR-38' => 363
		}
	},
	{#State 337
		ACTIONS => {
			"while" => -142,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'VARIABLE_SYMBOL' => 109,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP01_PRINT' => 114,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'WORD_UPPERCASE' => 107,
			"foreach" => -142,
			"\@{" => 122,
			'OP19_LOOP_CONTROL' => 124,
			'OP10_NAMED_UNARY' => 123,
			'LPAREN' => 121,
			'OP01_NAMED_VOID' => 118,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACKET' => 91,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 80,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			"if" => 83,
			'OP05_MATH_NEG_LPAREN' => 85,
			'WORD' => 25,
			"for" => -142,
			"%{" => 93,
			'OP01_CLOSE' => 96,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'MY' => 98,
			'OP01_OPEN' => 94
		},
		GOTOS => {
			'VariableModification' => 92,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'Operation' => 364,
			'HashDereference' => 95,
			'Conditional' => 119,
			'HashReference' => 120,
			'PLUS-41' => 365,
			'Expression' => 99,
			'LoopLabel' => 100,
			'Literal' => 101,
			'OPTIONAL-36' => 102,
			'VariableDeclaration' => 103,
			'ArrayDereference' => 79,
			'OperatorVoid' => 81,
			'PAREN-35' => 82,
			'SubExpression' => 108,
			'Variable' => 110,
			'Statement' => 112,
			'Operator' => 89
		}
	},
	{#State 338
		DEFAULT => -175
	},
	{#State 339
		ACTIONS => {
			'LITERAL_STRING' => 366
		}
	},
	{#State 340
		ACTIONS => {
			";" => 367
		}
	},
	{#State 341
		ACTIONS => {
			'LPAREN' => 368
		}
	},
	{#State 342
		ACTIONS => {
			'LBRACE' => 337
		},
		GOTOS => {
			'CodeBlock' => 369
		}
	},
	{#State 343
		ACTIONS => {
			'LPAREN' => 370
		}
	},
	{#State 344
		DEFAULT => -103
	},
	{#State 345
		DEFAULT => -169
	},
	{#State 346
		DEFAULT => -168
	},
	{#State 347
		DEFAULT => -167
	},
	{#State 348
		DEFAULT => -127
	},
	{#State 349
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP04_MATH_POW' => 177,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP21_LIST_COMMA' => -193,
			'OP16_LOGICAL_OR' => 172,
			"}" => -193,
			'OP23_LOGICAL_AND' => 173
		}
	},
	{#State 350
		DEFAULT => -197
	},
	{#State 351
		ACTIONS => {
			")" => 371
		}
	},
	{#State 352
		DEFAULT => -78
	},
	{#State 353
		DEFAULT => -59
	},
	{#State 354
		ACTIONS => {
			'VARIABLE_SYMBOL' => 372
		}
	},
	{#State 355
		ACTIONS => {
			";" => 373
		}
	},
	{#State 356
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 374
		}
	},
	{#State 357
		ACTIONS => {
			'OP20_HASH_FATARROW' => 375
		}
	},
	{#State 358
		DEFAULT => -196
	},
	{#State 359
		ACTIONS => {
			'MY' => 376
		}
	},
	{#State 360
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 377
		}
	},
	{#State 361
		DEFAULT => -48
	},
	{#State 362
		DEFAULT => -211
	},
	{#State 363
		ACTIONS => {
			'OP01_NAMED_VOID_LPAREN' => -153,
			"while" => -153,
			'VARIABLE_SYMBOL' => -153,
			'LBRACE' => -153,
			'WORD_SCOPED' => -153,
			'OP01_PRINT' => -153,
			'OP05_LOGICAL_NEG' => -153,
			'LITERAL_STRING' => -153,
			'OP19_LOOP_CONTROL_SCOLON' => -153,
			"else" => 378,
			'WORD_UPPERCASE' => -153,
			"foreach" => -153,
			"\@{" => -153,
			'OP19_LOOP_CONTROL' => -153,
			'OP10_NAMED_UNARY' => -153,
			'LPAREN' => -153,
			'OP01_NAMED_VOID' => -153,
			'' => -153,
			'OP22_LOGICAL_NEG' => -153,
			"}" => -153,
			'LBRACKET' => -153,
			'LITERAL_NUMBER' => -153,
			'OP01_NAMED' => -153,
			"undef" => -153,
			'OP03_MATH_INC_DEC' => -153,
			"if" => -153,
			'OP05_MATH_NEG_LPAREN' => -153,
			'WORD' => -153,
			"for" => -153,
			"%{" => -153,
			"elsif" => 379,
			'OP01_CLOSE' => -153,
			'MY' => -153,
			'OP01_NAMED_VOID_SCOLON' => -153,
			'OP01_OPEN' => -153
		},
		GOTOS => {
			'PAREN-39' => 382,
			'PAREN-37' => 381,
			'OPTIONAL-40' => 380
		}
	},
	{#State 364
		DEFAULT => -162
	},
	{#State 365
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'MY' => 98,
			'OP01_NAMED_VOID_SCOLON' => 97,
			"%{" => 93,
			"for" => -142,
			'WORD' => 25,
			"if" => 83,
			'OP05_MATH_NEG_LPAREN' => 85,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 80,
			"}" => 383,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 88,
			'OP01_NAMED_VOID' => 118,
			'LPAREN' => 121,
			'OP10_NAMED_UNARY' => 123,
			'OP19_LOOP_CONTROL' => 124,
			"\@{" => 122,
			"foreach" => -142,
			'WORD_UPPERCASE' => 107,
			'OP19_LOOP_CONTROL_SCOLON' => 105,
			'LITERAL_STRING' => 104,
			'OP05_LOGICAL_NEG' => 106,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP01_PRINT' => 114,
			'VARIABLE_SYMBOL' => 109,
			'OP01_NAMED_VOID_LPAREN' => 111,
			"while" => -142
		},
		GOTOS => {
			'SubExpression' => 108,
			'PAREN-35' => 82,
			'OperatorVoid' => 81,
			'ArrayDereference' => 79,
			'Operator' => 89,
			'Statement' => 112,
			'Variable' => 110,
			'HashReference' => 120,
			'Conditional' => 119,
			'HashDereference' => 95,
			'Operation' => 384,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'VariableModification' => 92,
			'OPTIONAL-36' => 102,
			'VariableDeclaration' => 103,
			'Literal' => 101,
			'LoopLabel' => 100,
			'Expression' => 99
		}
	},
	{#State 366
		ACTIONS => {
			'OP21_LIST_COMMA' => 385
		}
	},
	{#State 367
		DEFAULT => -171
	},
	{#State 368
		ACTIONS => {
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25,
			'OP01_OPEN' => 94,
			'OP01_QW' => 136,
			'MY' => 134,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			"%{" => 93
		},
		GOTOS => {
			'Operator' => 89,
			'Literal' => 101,
			'TypeInner' => 138,
			'Expression' => 133,
			'Variable' => 139,
			'SubExpression' => 148,
			'HashReference' => 120,
			'HashDereference' => 95,
			'ListElements' => 386,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'ArrayDereference' => 79,
			'ListElement' => 147
		}
	},
	{#State 369
		DEFAULT => -160
	},
	{#State 370
		ACTIONS => {
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"%{" => 93,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106
		},
		GOTOS => {
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'SubExpression' => 387,
			'HashDereference' => 95,
			'HashReference' => 120,
			'Variable' => 139,
			'Expression' => 133,
			'Operator' => 89,
			'Literal' => 101
		}
	},
	{#State 371
		DEFAULT => -80
	},
	{#State 372
		ACTIONS => {
			"= sub {" => 388
		}
	},
	{#State 373
		DEFAULT => -64
	},
	{#State 374
		ACTIONS => {
			"}" => 390,
			'OP21_LIST_COMMA' => 391
		},
		GOTOS => {
			'PAREN-24' => 389
		}
	},
	{#State 375
		ACTIONS => {
			'MY' => 134
		},
		GOTOS => {
			'TypeInner' => 392
		}
	},
	{#State 376
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 393
		}
	},
	{#State 377
		ACTIONS => {
			"\@_;" => 394
		}
	},
	{#State 378
		ACTIONS => {
			'LBRACE' => 337
		},
		GOTOS => {
			'CodeBlock' => 395
		}
	},
	{#State 379
		ACTIONS => {
			'LPAREN' => 396
		}
	},
	{#State 380
		DEFAULT => -154
	},
	{#State 381
		DEFAULT => -149
	},
	{#State 382
		DEFAULT => -152
	},
	{#State 383
		DEFAULT => -163
	},
	{#State 384
		DEFAULT => -161
	},
	{#State 385
		ACTIONS => {
			'WORD' => 25,
			"\@{" => 122,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'OP01_OPEN' => 94,
			'OP22_LOGICAL_NEG' => 88,
			'VARIABLE_SYMBOL' => 109,
			'LBRACKET' => 91,
			'WORD_SCOPED' => 26,
			'LBRACE' => 113,
			'OP05_LOGICAL_NEG' => 106,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP05_MATH_NEG_LPAREN' => 85
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'Variable' => 139,
			'Expression' => 133,
			'SubExpression' => 397,
			'HashDereference' => 95,
			'HashReference' => 120,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 386
		ACTIONS => {
			")" => 398
		}
	},
	{#State 387
		ACTIONS => {
			'OP06_REGEX_MATCH' => 182,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP17_LIST_RANGE' => 399,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP23_LOGICAL_AND' => 173,
			'OP18_TERNARY' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP16_LOGICAL_OR' => 172,
			'OP07_STRING_REPEAT' => 171,
			'OP08_MATH_ADD_SUB' => 176,
			'OP04_MATH_POW' => 177
		}
	},
	{#State 388
		ACTIONS => {
			'OP22_LOGICAL_NEG' => -66,
			"}" => -66,
			'LBRACKET' => -66,
			'LITERAL_NUMBER' => -66,
			'OP01_NAMED' => -66,
			"if" => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			"undef" => -66,
			'OP03_MATH_INC_DEC' => -66,
			'WORD' => -66,
			"for" => -66,
			"%{" => -66,
			'OP01_OPEN' => -66,
			'OP01_CLOSE' => -66,
			'MY' => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LPAREN_MY' => 400,
			'VARIABLE_SYMBOL' => -66,
			'OP01_NAMED_VOID_LPAREN' => -66,
			"while" => -66,
			'WORD_SCOPED' => -66,
			'LBRACE' => -66,
			'OP01_PRINT' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'LITERAL_STRING' => -66,
			'OP05_LOGICAL_NEG' => -66,
			"foreach" => -66,
			'WORD_UPPERCASE' => -66,
			"\@{" => -66,
			'OP10_NAMED_UNARY' => -66,
			'OP19_LOOP_CONTROL' => -66,
			'OP01_NAMED_VOID' => -66,
			'LPAREN' => -66
		},
		GOTOS => {
			'MethodArguments' => 402,
			'OPTIONAL-26' => 401
		}
	},
	{#State 389
		DEFAULT => -61
	},
	{#State 390
		ACTIONS => {
			";" => 403
		}
	},
	{#State 391
		ACTIONS => {
			"%{" => 93,
			'WORD' => 357
		},
		GOTOS => {
			'HashEntryTyped' => 404,
			'HashDereference' => 358
		}
	},
	{#State 392
		ACTIONS => {
			"\@{" => 122,
			'WORD' => 25,
			'OP10_NAMED_UNARY' => 123,
			"%{" => 93,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			'WORD_UPPERCASE' => 141,
			"undef" => 86
		},
		GOTOS => {
			'HashReference' => 120,
			'HashDereference' => 95,
			'SubExpression' => 405,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79,
			'Literal' => 101,
			'Operator' => 89,
			'Expression' => 133,
			'Variable' => 139
		}
	},
	{#State 393
		ACTIONS => {
			'VARIABLE_SYMBOL' => 406
		}
	},
	{#State 394
		DEFAULT => -50
	},
	{#State 395
		DEFAULT => -151
	},
	{#State 396
		ACTIONS => {
			'OP01_OPEN' => 94,
			'OP01_CLOSE' => 96,
			'LPAREN' => 121,
			"%{" => 93,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'LITERAL_STRING' => 104,
			'OP01_NAMED' => 135,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88
		},
		GOTOS => {
			'Literal' => 101,
			'Operator' => 89,
			'Variable' => 139,
			'Expression' => 133,
			'HashDereference' => 95,
			'HashReference' => 120,
			'SubExpression' => 407,
			'ArrayDereference' => 79,
			'ArrayReference' => 116,
			'WordScoped' => 115
		}
	},
	{#State 397
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP21_LIST_COMMA' => -81,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP23_LOGICAL_AND' => -81,
			"}" => -81,
			";" => -81,
			'OP04_MATH_POW' => 177,
			'OP24_LOGICAL_OR_XOR' => -81,
			'OP09_BITWISE_SHIFT' => 181,
			"]" => -81,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP13_BITWISE_AND' => 184,
			'OP08_STRING_CAT' => 183,
			'OP06_REGEX_MATCH' => 182,
			")" => -81,
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185
		}
	},
	{#State 398
		ACTIONS => {
			'LBRACE' => 337
		},
		GOTOS => {
			'CodeBlock' => 408
		}
	},
	{#State 399
		ACTIONS => {
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'WORD' => 25,
			'OP01_OPEN' => 94,
			'LPAREN' => 121,
			'OP01_CLOSE' => 96,
			"%{" => 93,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'LBRACKET' => 91,
			'VARIABLE_SYMBOL' => 109,
			'OP22_LOGICAL_NEG' => 88,
			'OP05_MATH_NEG_LPAREN' => 85,
			'OP03_MATH_INC_DEC' => 87,
			"undef" => 86,
			'WORD_UPPERCASE' => 141,
			'OP01_NAMED' => 135,
			'LITERAL_STRING' => 104,
			'LITERAL_NUMBER' => 78,
			'OP05_LOGICAL_NEG' => 106
		},
		GOTOS => {
			'SubExpression' => 409,
			'HashReference' => 120,
			'HashDereference' => 95,
			'WordScoped' => 115,
			'ArrayReference' => 116,
			'ArrayDereference' => 79,
			'Operator' => 89,
			'Literal' => 101,
			'Expression' => 133,
			'Variable' => 139
		}
	},
	{#State 400
		ACTIONS => {
			'TYPE_SELF' => 410
		}
	},
	{#State 401
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 411
		}
	},
	{#State 402
		DEFAULT => -65
	},
	{#State 403
		DEFAULT => -63
	},
	{#State 404
		DEFAULT => -60
	},
	{#State 405
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 175,
			'OP17_LIST_RANGE' => 185,
			'OP24_LOGICAL_OR_XOR' => 180,
			'OP09_BITWISE_SHIFT' => 181,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP04_MATH_POW' => 177,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP21_LIST_COMMA' => -195,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => 170,
			'OP23_LOGICAL_AND' => 173,
			"}" => -195
		}
	},
	{#State 406
		DEFAULT => -47
	},
	{#State 407
		ACTIONS => {
			'OP04_MATH_POW' => 177,
			'OP23_LOGICAL_AND' => 173,
			'OP18_TERNARY' => 170,
			'OP11_COMPARE_LT_GT' => 169,
			'OP16_LOGICAL_OR' => 172,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP17_LIST_RANGE' => 185,
			'OP14_BITWISE_OR_XOR' => 175,
			")" => 412,
			'OP06_REGEX_MATCH' => 182,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP15_LOGICAL_AND' => 178,
			'OP09_BITWISE_SHIFT' => 181,
			'OP24_LOGICAL_OR_XOR' => 180
		}
	},
	{#State 408
		DEFAULT => -159
	},
	{#State 409
		ACTIONS => {
			'OP23_LOGICAL_AND' => -102,
			'OP08_MATH_ADD_SUB' => 176,
			'OP07_STRING_REPEAT' => 171,
			'OP16_LOGICAL_OR' => 172,
			'OP11_COMPARE_LT_GT' => 169,
			'OP18_TERNARY' => -102,
			'OP04_MATH_POW' => 177,
			'OP08_STRING_CAT' => 183,
			'OP13_BITWISE_AND' => 184,
			'OP06_REGEX_MATCH' => 182,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP09_BITWISE_SHIFT' => 181,
			'OP15_LOGICAL_AND' => 178,
			'OP12_COMPARE_EQ_NE' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 179,
			'OP17_LIST_RANGE' => undef,
			")" => 413,
			'OP14_BITWISE_OR_XOR' => 175
		}
	},
	{#State 410
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 414
		}
	},
	{#State 411
		ACTIONS => {
			"for" => -142,
			'WORD' => 25,
			'OP01_CLOSE' => 96,
			'MY' => 98,
			'OP01_NAMED_VOID_SCOLON' => 97,
			'OP01_OPEN' => 94,
			"%{" => 93,
			"}" => 415,
			'LBRACKET' => 91,
			'OP22_LOGICAL_NEG' => 88,
			"undef" => 86,
			'OP03_MATH_INC_DEC' => 87,
			"if" => 83,
			'OP05_MATH_NEG_LPAREN' => 85,
			'LITERAL_NUMBER' => 78,
			'OP01_NAMED' => 80,
			'OP19_LOOP_CONTROL' => 124,
			'OP10_NAMED_UNARY' => 123,
			"\@{" => 122,
			'LPAREN' => 121,
			'OP01_NAMED_VOID' => 118,
			'LBRACE' => 113,
			'WORD_SCOPED' => 26,
			'OP01_PRINT' => 114,
			"while" => -142,
			'OP01_NAMED_VOID_LPAREN' => 111,
			'VARIABLE_SYMBOL' => 109,
			'WORD_UPPERCASE' => 107,
			"foreach" => -142,
			'OP05_LOGICAL_NEG' => 106,
			'LITERAL_STRING' => 104,
			'OP19_LOOP_CONTROL_SCOLON' => 105
		},
		GOTOS => {
			'Operator' => 89,
			'Statement' => 112,
			'Variable' => 110,
			'SubExpression' => 108,
			'PAREN-35' => 82,
			'OperatorVoid' => 81,
			'ArrayDereference' => 79,
			'VariableDeclaration' => 103,
			'OPTIONAL-36' => 102,
			'Literal' => 101,
			'LoopLabel' => 100,
			'Expression' => 99,
			'HashReference' => 120,
			'Conditional' => 119,
			'HashDereference' => 95,
			'Operation' => 416,
			'ArrayReference' => 116,
			'WordScoped' => 115,
			'VariableModification' => 92
		}
	},
	{#State 412
		ACTIONS => {
			'LBRACE' => 337
		},
		GOTOS => {
			'CodeBlock' => 417
		}
	},
	{#State 413
		ACTIONS => {
			'LBRACE' => 337
		},
		GOTOS => {
			'CodeBlock' => 418
		}
	},
	{#State 414
		ACTIONS => {
			'OP21_LIST_COMMA' => 420,
			")" => 421
		},
		GOTOS => {
			'PAREN-28' => 419
		}
	},
	{#State 415
		ACTIONS => {
			";" => 422
		}
	},
	{#State 416
		DEFAULT => -67
	},
	{#State 417
		DEFAULT => -148
	},
	{#State 418
		DEFAULT => -158
	},
	{#State 419
		DEFAULT => -71
	},
	{#State 420
		ACTIONS => {
			'MY' => 423
		}
	},
	{#State 421
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 424
		}
	},
	{#State 422
		DEFAULT => -69
	},
	{#State 423
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 425
		}
	},
	{#State 424
		ACTIONS => {
			"\@_;" => 426
		}
	},
	{#State 425
		ACTIONS => {
			'VARIABLE_SYMBOL' => 427
		}
	},
	{#State 426
		DEFAULT => -73
	},
	{#State 427
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5841 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5848 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5855 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5862 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5873 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5884 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5891 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5898 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5905 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5912 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5919 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5926 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5933 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5940 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5947 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5954 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5961 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5968 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5979 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5986 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 141 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5993 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6004 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6015 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6026 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6033 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6040 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6047 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6054 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6061 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6068 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6075 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 143 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6082 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6093 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6104 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6111 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6118 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6129 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6136 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 146 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6143 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6154 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6165 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6176 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6183 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6190 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6197 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6204 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6215 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6222 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6229 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6236 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6247 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6254 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6261 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6268 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6275 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6282 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6289 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6296 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6303 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6314 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6321 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6328 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 154 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6335 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6346 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6357 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6364 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6371 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6378 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6385 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6396 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6403 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6410 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 157 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6417 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6428 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6439 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6450 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6461 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6472 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6483 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6494 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6505 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6516 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6527 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6538 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6549 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6560 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6571 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6582 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6593 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6604 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6615 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6626 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6637 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6648 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6659 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6670 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6681 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6692 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6703 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6714 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6725 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6736 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6747 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6758 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6769 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6780 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6791 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6798 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6805 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6812 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6819 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 174 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6826 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6837 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6848 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6859 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6870 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6881 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6892 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6903 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6914 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6921 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6928 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6935 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 176 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6942 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6953 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6964 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6975 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6986 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6997 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7008 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7019 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7030 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7041 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7052 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7063 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7074 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7085 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7096 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_138
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7107 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_139
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7118 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7125 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7132 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7139 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7150 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7161 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7172 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7183 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7194 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 5,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7201 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7208 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7215 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 2,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7222 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7229 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 181 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7236 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_154
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7247 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_155
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7258 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7269 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7280 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_158
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7291 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_159
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7302 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_160
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7313 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 2,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7320 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 1,
sub {
#line 186 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7327 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_163
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7338 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7345 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 188 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7352 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_166
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7363 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_167
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7374 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7385 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7396 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_170
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7407 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_171
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7418 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_172
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7429 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_173
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7440 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_174
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7451 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7458 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7465 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7472 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_178
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7483 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 2,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7490 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7497 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_181
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7508 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7519 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_183
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7530 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7537 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7544 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_186
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7555 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7562 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7569 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_189
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7580 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_190
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7591 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7598 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 196 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7605 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_193
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7616 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_194
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7627 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_195
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7638 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_196
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7649 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7656 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7663 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7670 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_200
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7681 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_201
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7692 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7699 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 199 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7706 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_204
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7717 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_205
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7728 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_206
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7739 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_207
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7750 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_208
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7761 lib/RPerl/Grammar.pm
	],
	[#Rule Type_209
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7772 lib/RPerl/Grammar.pm
	],
	[#Rule Type_210
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7783 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_211
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7794 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_212
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7805 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_213
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7816 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_214
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7827 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_215
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7838 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_216
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7849 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_217
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7860 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_218
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7871 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_219
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7882 lib/RPerl/Grammar.pm
	]
],
#line 7885 lib/RPerl/Grammar.pm
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
         'ModuleHeader_21', 
         'Module_22', 
         'Module_23', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_32', 
         'Header_33', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Critic_36', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_39', 
         'Include_40', 
         'Constant_41', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Subroutine_46', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_50', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Class_59', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Properties_63', 
         'Properties_64', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Method_69', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_73', 
         'MethodOrSubroutine_74', 
         'MethodOrSubroutine_75', 
         'Operation_76', 
         'Operation_77', 
         'Operator_78', 
         'Operator_79', 
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
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_112', 
         'OperatorVoid_113', 
         'OperatorVoid_114', 
         'OperatorVoid_115', 
         'OperatorVoid_116', 
         'OperatorVoid_117', 
         'OperatorVoid_118', 
         'OperatorVoid_119', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_124', 
         'Expression_125', 
         'Expression_126', 
         'Expression_127', 
         'Expression_128', 
         'SubExpression_129', 
         'SubExpression_130', 
         'SubExpression_131', 
         'SubExpression_132', 
         'SubExpression_133', 
         'SubExpression_134', 
         'SubExpression_135', 
         'SubExpression_136', 
         'SubExpression_137', 
         'SubExpressionOrStdin_138', 
         'SubExpressionOrStdin_139', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_143', 
         'Statement_144', 
         'Statement_145', 
         'Statement_146', 
         'Statement_147', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_154', 
         'Loop_155', 
         'Loop_156', 
         'Loop_157', 
         'LoopFor_158', 
         'LoopForEach_159', 
         'LoopWhile_160', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_163', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_166', 
         'VariableRetrieval_167', 
         'VariableRetrieval_168', 
         'VariableRetrieval_169', 
         'VariableDeclaration_170', 
         'VariableDeclaration_171', 
         'VariableDeclaration_172', 
         'VariableModification_173', 
         'VariableModification_174', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_178', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElement_181', 
         'ListElement_182', 
         'ListElement_183', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_186', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_189', 
         'ArrayDereference_190', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_193', 
         'HashEntry_194', 
         'HashEntryTyped_195', 
         'HashEntryTyped_196', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_200', 
         'HashReference_201', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_204', 
         'HashDereference_205', 
         'WordScoped_206', 
         'WordScoped_207', 
         'LoopLabel_208', 
         'Type_209', 
         'Type_210', 
         'TypeInner_211', 
         'TypeInnerConstant_212', 
         'VariableOrLiteral_213', 
         'VariableOrLiteral_214', 
         'VariableOrLiteralOrWord_215', 
         'VariableOrLiteralOrWord_216', 
         'VariableOrLiteralOrWord_217', 
         'Literal_218', 
         'Literal_219', );
  $self;
}

#line 210 "lib/RPerl/Grammar.eyp"


{
# Map from abstract syntax tree to classes
# DEV NOTE: derived from grammar rules in Grammar.output file, process for grammar updates...
# 1. Update grammar code in this file, above this line only
# 2. Run scripts/grammar_recompile.sh
# 3. Run new & existing grammar tests
# 4. Copy updates from Grammar.output file into this file, below this line only
# 5. Run scripts/grammar_recompile.sh again
our string_hashref $RULES = {
CompileUnit_4 => 'RPerl::CompileUnit::Program',  # CompileUnit -> Program
CompileUnit_5 => 'RPerl::CompileUnit::Module',  # CompileUnit -> PLUS-2
Program_18 => 'RPerl::CompileUnit::Program',  # Program -> SHEBANG OPTIONAL-3 Header STAR-4 STAR-5 STAR-6 STAR-7 PLUS-8
ModuleHeader_21 => 'RPerl::CompileUnit::Module::Header',  # ModuleHeader -> OPTIONAL-9 'package' WordScoped ';' Header
Module_22 => 'RPerl::CompileUnit::Module::Package',  # Module -> Package
Module_23 => 'RPerl::CompileUnit::Module::Class::Generator',  # Module -> Class
Package_32 => 'RPerl::CompileUnit::Module::Package',  # Package -> STAR-10 STAR-11 STAR-12 PLUS-13 LITERAL_NUMBER ';'
Header_33 => 'RPerl::NonGenerator',  # Header -> 'use strict;' 'use warnings;' 'use RPerl;' 'our' VERSION_NUMBER_ASSIGN
Critic_36 => 'RPerl::CompileUnit::Critic',  # Critic -> '## no critic qw(' PLUS-14 ')'
Include_39 => 'RPerl::CompileUnit::Include',  # Include -> 'use' WordScoped ';'
Include_40 => 'RPerl::CompileUnit::Include',  # Include -> 'use' WordScoped OP01_QW PLUS-15 ')' ';'
Constant_41 => 'RPerl::CompileUnit::Constant',  # Constant -> 'use constant' WORD_UPPERCASE OP20_HASH_FATARROW TypeInnerConstant Literal ';'
Subroutine_46 => 'RPerl::CodeBlock::Subroutine',  # Subroutine -> 'our' Type VARIABLE_SYMBOL '= sub {' OPTIONAL-16 STAR-17 '}' ';'
SubroutineArguments_50 => 'RPerl::CodeBlock::Subroutine::Arguments',  # SubroutineArguments -> LPAREN_MY Type VARIABLE_SYMBOL STAR-19 ')' OP19_VARIABLE_ASSIGN '@_;'
Class_59 => 'RPerl::NonGenerator',  # Class -> 'use parent qw(' WordScoped ')' ';' Include STAR-20 STAR-21 STAR-22 Properties STAR-23 LITERAL_NUMBER ';'
Properties_63 => 'RPerl::DataStructure::Hash::Properties',  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE HashEntryTyped STAR-25 '}' ';'
Properties_64 => 'RPerl::DataStructure::Hash::Properties',  # Properties -> 'our hashref $properties' OP19_VARIABLE_ASSIGN LBRACE '}' ';'
Method_69 => 'RPerl::CodeBlock::Subroutine::Method',  # Method -> 'our' TYPE_METHOD VARIABLE_SYMBOL '= sub {' OPTIONAL-26 STAR-27 '}' ';'
MethodArguments_73 => 'RPerl::CodeBlock::Subroutine::Method::Arguments',  # MethodArguments -> LPAREN_MY TYPE_SELF STAR-29 ')' OP19_VARIABLE_ASSIGN '@_;'
MethodOrSubroutine_74 => 'RPerl::CodeBlock::Subroutine::Method',  # MethodOrSubroutine -> Method
MethodOrSubroutine_75 => 'RPerl::CodeBlock::Subroutine',  # MethodOrSubroutine -> Subroutine
Operation_76 => 'RPerl::Operation::Expression',
Operation_77 => 'RPerl::Operation::Statement',  # Operation -> Statement
Operator_78 => 'RPerl::Operation::Expression::Operator::Print',
Operator_79 => 'RPerl::Operation::Expression::Operator::Named',
Operator_80 => 'RPerl::Operation::Expression::Operator::Named',
Operator_81 => 'RPerl::Operation::Expression::Operator::Open',
Operator_82 => 'RPerl::Operation::Expression::Operator::Close',
Operator_83 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',
Operator_84 => 'RPerl::Operation::Expression::Operator::Math::IncrementDecrement',
Operator_85 => 'RPerl::Operation::Expression::Operator::Math::Power',
Operator_86 => 'RPerl::Operation::Expression::Operator::Logical::Negation',
Operator_87 => 'RPerl::Operation::Expression::Operator::Math::Negative',
Operator_88 => 'RPerl::Operation::Expression::Operator::RegularExpression',
Operator_89 => 'RPerl::Operation::Expression::Operator::String::Repeat',
Operator_90 => 'RPerl::Operation::Expression::Operator::Math::MultiplyDivideModulo',
Operator_91 => 'RPerl::Operation::Expression::Operator::Math::AddSubtract',
Operator_92 => 'RPerl::Operation::Expression::Operator::String::Concatenate',
Operator_93 => 'RPerl::Operation::Expression::Operator::Bitwise::Shift',
Operator_94 => 'RPerl::Operation::Expression::Operator::NamedUnary',
Operator_95 => 'RPerl::Operation::Expression::Operator::NamedUnary',
Operator_96 => 'RPerl::Operation::Expression::Operator::Compare::LessThanGreaterThan',
Operator_97 => 'RPerl::Operation::Expression::Operator::Compare::EqualNotEqual',
Operator_98 => 'RPerl::Operation::Expression::Operator::Bitwise::And',
Operator_99 => 'RPerl::Operation::Expression::Operator::Bitwise::OrXor',
Operator_100 => 'RPerl::Operation::Expression::Operator::Logical::And',
Operator_101 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',
Operator_102 => 'RPerl::Operation::Expression::Operator::List::Range',
Operator_103 => 'RPerl::Operation::Expression::Operator::Ternary',
Operator_104 => 'RPerl::Operation::Expression::Operator::Logical::Negation',
Operator_105 => 'RPerl::Operation::Expression::Operator::Logical::And',
Operator_106 => 'RPerl::Operation::Expression::Operator::Logical::OrXor',
OperatorVoid_112 => 'RPerl::Operation::Statement::OperatorVoid::Print',        # OperatorVoid -> OP01_PRINT OPTIONAL-31 ListElements ';'
OperatorVoid_113 => 'RPerl::Operation::Statement::OperatorVoid::Print',        # OperatorVoid -> OP01_PRINT FHREF_SYMBOL_BRACES ListElements ';'
OperatorVoid_114 => 'RPerl::Operation::Statement::OperatorVoid::Named',        # OperatorVoid -> OP01_NAMED_VOID_SCOLON
OperatorVoid_115 => 'RPerl::Operation::Statement::OperatorVoid::Named',        # OperatorVoid -> OP01_NAMED_VOID_LPAREN OPTIONAL-32 ')' ';'
OperatorVoid_116 => 'RPerl::Operation::Statement::OperatorVoid::Named',        # OperatorVoid -> OP01_NAMED_VOID ListElements ';'
OperatorVoid_117 => 'RPerl::Operation::Expression::Operator::Named',           # OperatorVoid -> OP01_NAMED ListElement OP21_LIST_COMMA ListElements ';'
OperatorVoid_118 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',  # OperatorVoid -> OP19_LOOP_CONTROL_SCOLON
OperatorVoid_119 => 'RPerl::Operation::Statement::OperatorVoid::LoopControl',  # OperatorVoid -> OP19_LOOP_CONTROL LoopLabel ';'
Expression_124 => 'RPerl::Operation::Expression::Operator',
Expression_125 => 'RPerl::Operation::Expression::SubroutineCall',
Expression_126 => 'RPerl::Operation::Expression::ConstantCall',
Expression_127 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall',
Expression_128 => 'RPerl::Operation::Expression::SubroutineCall::MethodCall::ConstructorCall',
SubExpression_129 => 'RPerl::Operation::Expression',
SubExpression_130 => 'RPerl::Operation::Expression::SubExpression::Literal::Undefined',
SubExpression_131 => 'RPerl::Operation::Expression::SubExpression::Literal',      # SubExpression -> Literal
SubExpression_132 => 'RPerl::Operation::Expression::SubExpression::Variable',
SubExpression_133 => 'RPerl::DataStructure::Array::Reference',                    # SubExpression -> ArrayReference
SubExpression_134 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
SubExpression_135 => 'RPerl::DataStructure::Hash::Reference',                     # SubExpression -> HashReference
SubExpression_136 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
SubExpression_137 => 'RPerl::Operation::Expression::SubExpression::Parenthesis',  # SubExpression -> LPAREN SubExpression ')'
SubExpressionOrStdin_138 => 'RPerl::Operation::Expression::SubExpression',        # SubExpressionOrStdin -> SubExpression
SubExpressionOrStdin_139 => 'RPerl::InputOutput::Stdin',
Statement_143 => 'RPerl::Operation::Statement::Conditional',
Statement_144 => 'RPerl::Operation::Statement::Loop',
Statement_145 => 'RPerl::Operation::Statement::OperatorVoid',  # Statement -> OperatorVoid
Statement_146 => 'RPerl::Operation::Statement::VariableDeclaration',
Statement_147 => 'RPerl::Operation::Statement::VariableModification',
Conditional_154 => 'RPerl::Operation::Statement::Conditional',
Loop_155 => 'RPerl::Operation::Statement::Loop::For',
Loop_156 => 'RPerl::Operation::Statement::Loop::ForEach',
Loop_157 => 'RPerl::Operation::Statement::Loop::While',
LoopFor_158 => 'RPerl::Operation::Statement::Loop::For',
LoopForEach_159 => 'RPerl::Operation::Statement::Loop::ForEach',
LoopWhile_160 => 'RPerl::Operation::Statement::Loop::While',
CodeBlock_163 => 'RPerl::CodeBlock',
Variable_166 => 'RPerl::Operation::Expression::SubExpression::Variable',
VariableRetrieval_167 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',
VariableRetrieval_168 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',
VariableRetrieval_169 => 'RPerl::Operation::Expression::SubExpression::Variable::Retrieval',
VariableDeclaration_170 => 'RPerl::Operation::Statement::VariableDeclaration',
VariableDeclaration_171 => 'RPerl::Operation::Statement::VariableDeclaration',
VariableDeclaration_172 => 'RPerl::Operation::Statement::VariableDeclaration',  # VariableDeclaration -> MY TYPE_FHREF FHREF_SYMBOL ';'
VariableModification_173 => 'RPerl::Operation::Statement::VariableModification',
VariableModification_174 => 'RPerl::Operation::Statement::VariableModification',
ListElements_178 => 'RPerl::DataStructure::Array::ListElements',    # ListElements -> ListElement STAR-43
ListElement_181 => 'RPerl::Operation::Expression::SubExpression',   # ListElement -> SubExpression
ListElement_182 => 'RPerl::Operation::Expression::SubExpression',   # ListElement -> TypeInner SubExpression
ListElement_183 => 'RPerl::DataStructure::Array::ListElement',      # ListElement -> OP01_QW PLUS-44 ')'
ArrayReference_186 => 'RPerl::DataStructure::Array::Reference',     # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_189 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
ArrayDereference_190 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
HashEntry_193 => 'RPerl::DataStructure::Hash::Entry',                                   # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_194 => 'RPerl::Operation::Expression::SubExpression::HashDereference',        # HashEntry -> HashDereference
HashEntryTyped_195 => 'RPerl::DataStructure::Hash::EntryTyped',                         # HashEntryTyped -> WORD OP20_HASH_FATARROW TypeInner SubExpression
HashEntryTyped_196 => 'RPerl::Operation::Expression::SubExpression::HashDereference',   # HashEntryTyped -> HashDereference
HashReference_200 => 'RPerl::DataStructure::Hash::Reference',
HashReference_201 => 'RPerl::DataStructure::Hash::Reference',
HashDereference_204 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
HashDereference_205 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
WordScoped_206 => 'RPerl::NonGenerator',
WordScoped_207 => 'RPerl::NonGenerator',
LoopLabel_208 => 'RPerl::NonGenerator',
Type_209 => 'RPerl::NonGenerator',                  # Type -> WORD
Type_210 => 'RPerl::NonGenerator',                  # Type -> TYPE_INTEGER
TypeInner_211 => 'RPerl::NonGenerator',             # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_212 => 'RPerl::NonGenerator',     # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_213 => 'RPerl::Operation::Expression::SubExpression::Variable',
VariableOrLiteral_214 => 'RPerl::Operation::Expression::SubExpression::Literal',
VariableOrLiteralOrWord_215 => 'RPerl::Operation::Expression::SubExpression::Variable',  # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_216 => 'RPerl::Operation::Expression::SubExpression::Literal',   # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_217 => 'RPerl::NonGenerator',                                    # VariableOrLiteralOrWord -> WORD
Literal_218 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',  # Literal -> LITERAL_NUMBER
Literal_219 => 'RPerl::Operation::Expression::SubExpression::Literal::String'   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8271 lib/RPerl/Grammar.pm



1;
