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
    our $VERSION = 0.000_996;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      /\G((?:\s*(?:#[^#!].*)?\s*)*)/gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(our\ hashref\ \$properties|\#\#\ no\ critic\ qw\(|use\ parent\ qw\(|use\ warnings\;|filehandleref|use\ constant|use\ strict\;|use\ RPerl\;|package|\$TYPED_|foreach|\=\ sub\ \{|elsif|undef|while|else|our|\@_\;|for|use|if|\@\{|\%\{|\;|\]|\)|\})}gc and return ($1, $1);

      /\G(^#!\/(?:\w+\/)*perl)/gc and return ('SHEBANG', $1);
      /\G\$VERSION\ =\ (\d\d?\.\d{3}\_\d{3});/gc and return ('VERSION_NUMBER_ASSIGN', $1);
      /\G(my)/gc and return ('MY', $1);
      /\G(-?(((\d{1,2}_)?(\d{3}_)*\d{3})|\d{1,2})(\.((\d{3}(_\d{3})*(_\d{1,2})?)|\d{1,2}))?)/gc and return ('LITERAL_NUMBER', $1);
      /\G(('[^']+')|("[^"\@\$]*((\\n)|(\\t))+[^"\@\$]*")|(q{[^}]*}))/gc and return ('LITERAL_STRING', $1);
      /\G(\$(?:[a-zA-Z]\w*)?[a-z]\w*(::[a-zA-Z]\w*)*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G(\{\$[A-Z][A-Z0-9_]*\})/gc and return ('FH_REF_SYMBOL_BRACES', $1);
      /\G(\$[A-Z][A-Z0-9_]*)/gc and return ('FH_REF_SYMBOL', $1);
      /\G(integer\s+)/gc and return ('TYPE_INTEGER', $1);
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


#line 131 lib/RPerl/Grammar.pm

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
  [ 'Operator_78' => 'Operator', [ 'LPAREN', 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ')' ], 0 ],
  [ 'Operator_79' => 'Operator', [ 'OP01_NAMED', 'SubExpression' ], 0 ],
  [ 'Operator_80' => 'Operator', [ 'LPAREN', 'OP01_NAMED', 'ListElement', 'OP21_LIST_COMMA', 'ListElements', ')' ], 0 ],
  [ 'Operator_81' => 'Operator', [ 'OP01_OPEN', 'MY', 'filehandleref', 'FH_REF_SYMBOL', 'OP21_LIST_COMMA', 'LITERAL_STRING', 'OP21_LIST_COMMA', 'SubExpression' ], 0 ],
  [ 'Operator_82' => 'Operator', [ 'OP01_CLOSE', 'FH_REF_SYMBOL' ], 0 ],
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
  [ 'OperatorVoid_113' => 'OperatorVoid', [ 'OP01_PRINT', 'FH_REF_SYMBOL_BRACES', 'ListElements', ';' ], 0 ],
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
  [ 'VariableModification_172' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'SubExpressionOrStdin', ';' ], 0 ],
  [ 'VariableModification_173' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN_BY', 'SubExpression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-43', [ 'OP21_LIST_COMMA', 'ListElement' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [ 'STAR-44', 'PAREN-43' ], 0 ],
  [ '_STAR_LIST' => 'STAR-44', [  ], 0 ],
  [ 'ListElements_177' => 'ListElements', [ 'ListElement', 'STAR-44' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'PLUS-45', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-45', [ 'WORD' ], 0 ],
  [ 'ListElement_180' => 'ListElement', [ 'SubExpression' ], 0 ],
  [ 'ListElement_181' => 'ListElement', [ 'TypeInner', 'SubExpression' ], 0 ],
  [ 'ListElement_182' => 'ListElement', [ 'OP01_QW', 'PLUS-45', ')' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-46', [  ], 0 ],
  [ 'ArrayReference_185' => 'ArrayReference', [ 'LBRACKET', 'OPTIONAL-46', ']' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-47', [  ], 0 ],
  [ 'ArrayDereference_188' => 'ArrayDereference', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ArrayDereference_189' => 'ArrayDereference', [ '@{', 'OPTIONAL-47', 'ArrayReference', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-48', [  ], 0 ],
  [ 'HashEntry_192' => 'HashEntry', [ 'VariableOrLiteralOrWord', 'OP20_HASH_FATARROW', 'OPTIONAL-48', 'SubExpression' ], 0 ],
  [ 'HashEntry_193' => 'HashEntry', [ 'HashDereference' ], 0 ],
  [ 'HashEntryTyped_194' => 'HashEntryTyped', [ 'WORD', 'OP20_HASH_FATARROW', 'TypeInner', 'SubExpression' ], 0 ],
  [ 'HashEntryTyped_195' => 'HashEntryTyped', [ 'HashDereference' ], 0 ],
  [ '_PAREN' => 'PAREN-49', [ 'OP21_LIST_COMMA', 'HashEntry' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [ 'STAR-50', 'PAREN-49' ], 0 ],
  [ '_STAR_LIST' => 'STAR-50', [  ], 0 ],
  [ 'HashReference_199' => 'HashReference', [ 'LBRACE', 'HashEntry', 'STAR-50', '}' ], 0 ],
  [ 'HashReference_200' => 'HashReference', [ 'LBRACE', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [ 'TypeInner' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-51', [  ], 0 ],
  [ 'HashDereference_203' => 'HashDereference', [ '%{', 'Variable', '}' ], 0 ],
  [ 'HashDereference_204' => 'HashDereference', [ '%{', 'OPTIONAL-51', 'HashReference', '}' ], 0 ],
  [ 'WordScoped_205' => 'WordScoped', [ 'WORD' ], 0 ],
  [ 'WordScoped_206' => 'WordScoped', [ 'WORD_SCOPED' ], 0 ],
  [ 'LoopLabel_207' => 'LoopLabel', [ 'WORD_UPPERCASE' ], 0 ],
  [ 'Type_208' => 'Type', [ 'WORD' ], 0 ],
  [ 'Type_209' => 'Type', [ 'TYPE_INTEGER' ], 0 ],
  [ 'TypeInner_210' => 'TypeInner', [ 'MY', 'Type', '$TYPED_', 'WORD', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'TypeInnerConstant_211' => 'TypeInnerConstant', [ 'MY', 'Type', '$TYPED_', 'WORD_UPPERCASE', 'OP19_VARIABLE_ASSIGN' ], 0 ],
  [ 'VariableOrLiteral_212' => 'VariableOrLiteral', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteral_213' => 'VariableOrLiteral', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_214' => 'VariableOrLiteralOrWord', [ 'Variable' ], 0 ],
  [ 'VariableOrLiteralOrWord_215' => 'VariableOrLiteralOrWord', [ 'Literal' ], 0 ],
  [ 'VariableOrLiteralOrWord_216' => 'VariableOrLiteralOrWord', [ 'WORD' ], 0 ],
  [ 'Literal_217' => 'Literal', [ 'LITERAL_NUMBER' ], 0 ],
  [ 'Literal_218' => 'Literal', [ 'LITERAL_STRING' ], 0 ],
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
  'VariableModification_172' => 172,
  'VariableModification_173' => 173,
  '_PAREN' => 174,
  '_STAR_LIST' => 175,
  '_STAR_LIST' => 176,
  'ListElements_177' => 177,
  '_PLUS_LIST' => 178,
  '_PLUS_LIST' => 179,
  'ListElement_180' => 180,
  'ListElement_181' => 181,
  'ListElement_182' => 182,
  '_OPTIONAL' => 183,
  '_OPTIONAL' => 184,
  'ArrayReference_185' => 185,
  '_OPTIONAL' => 186,
  '_OPTIONAL' => 187,
  'ArrayDereference_188' => 188,
  'ArrayDereference_189' => 189,
  '_OPTIONAL' => 190,
  '_OPTIONAL' => 191,
  'HashEntry_192' => 192,
  'HashEntry_193' => 193,
  'HashEntryTyped_194' => 194,
  'HashEntryTyped_195' => 195,
  '_PAREN' => 196,
  '_STAR_LIST' => 197,
  '_STAR_LIST' => 198,
  'HashReference_199' => 199,
  'HashReference_200' => 200,
  '_OPTIONAL' => 201,
  '_OPTIONAL' => 202,
  'HashDereference_203' => 203,
  'HashDereference_204' => 204,
  'WordScoped_205' => 205,
  'WordScoped_206' => 206,
  'LoopLabel_207' => 207,
  'Type_208' => 208,
  'Type_209' => 209,
  'TypeInner_210' => 210,
  'TypeInnerConstant_211' => 211,
  'VariableOrLiteral_212' => 212,
  'VariableOrLiteral_213' => 213,
  'VariableOrLiteralOrWord_214' => 214,
  'VariableOrLiteralOrWord_215' => 215,
  'VariableOrLiteralOrWord_216' => 216,
  'Literal_217' => 217,
  'Literal_218' => 218,
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
	'filehandleref' => { ISSEMANTIC => 0 },
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
	FH_REF_SYMBOL => { ISSEMANTIC => 1 },
	FH_REF_SYMBOL_BRACES => { ISSEMANTIC => 1 },
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
			"## no critic qw(" => 7,
			"package" => -20,
			'SHEBANG' => 4
		},
		GOTOS => {
			'Critic' => 3,
			'PLUS-2' => 8,
			'ModuleHeader' => 9,
			'CompileUnit' => 5,
			'OPTIONAL-9' => 6,
			'Program' => 2,
			'PAREN-1' => 1
		}
	},
	{#State 1
		DEFAULT => -3
	},
	{#State 2
		DEFAULT => -4
	},
	{#State 3
		DEFAULT => -19
	},
	{#State 4
		ACTIONS => {
			"## no critic qw(" => 7,
			"use strict;" => -7
		},
		GOTOS => {
			'OPTIONAL-3' => 10,
			'Critic' => 11
		}
	},
	{#State 5
		ACTIONS => {
			'' => 12
		}
	},
	{#State 6
		ACTIONS => {
			"package" => 13
		}
	},
	{#State 7
		ACTIONS => {
			'WORD' => 15
		},
		GOTOS => {
			'PLUS-14' => 14
		}
	},
	{#State 8
		ACTIONS => {
			'' => -5,
			"## no critic qw(" => 7,
			"package" => -20
		},
		GOTOS => {
			'OPTIONAL-9' => 6,
			'PAREN-1' => 16,
			'ModuleHeader' => 9,
			'Critic' => 3
		}
	},
	{#State 9
		ACTIONS => {
			"## no critic qw(" => -25,
			"our" => -25,
			"use parent qw(" => 20,
			"use constant" => -25,
			"use" => -25
		},
		GOTOS => {
			'Class' => 19,
			'Package' => 18,
			'Module' => 21,
			'STAR-10' => 17
		}
	},
	{#State 10
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 23
		}
	},
	{#State 11
		DEFAULT => -6
	},
	{#State 12
		DEFAULT => 0
	},
	{#State 13
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 25
		}
	},
	{#State 14
		ACTIONS => {
			'WORD' => 27,
			")" => 28
		}
	},
	{#State 15
		DEFAULT => -35
	},
	{#State 16
		DEFAULT => -2
	},
	{#State 17
		ACTIONS => {
			"our" => -27,
			"## no critic qw(" => 7,
			"use" => -27,
			"use constant" => -27
		},
		GOTOS => {
			'STAR-11' => 29,
			'Critic' => 30
		}
	},
	{#State 18
		DEFAULT => -22
	},
	{#State 19
		DEFAULT => -23
	},
	{#State 20
		ACTIONS => {
			'WORD' => 26,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'WordScoped' => 31
		}
	},
	{#State 21
		DEFAULT => -1
	},
	{#State 22
		ACTIONS => {
			"use warnings;" => 32
		}
	},
	{#State 23
		DEFAULT => -9,
		GOTOS => {
			'STAR-4' => 33
		}
	},
	{#State 24
		DEFAULT => -206
	},
	{#State 25
		ACTIONS => {
			";" => 34
		}
	},
	{#State 26
		DEFAULT => -205
	},
	{#State 27
		DEFAULT => -34
	},
	{#State 28
		DEFAULT => -36
	},
	{#State 29
		ACTIONS => {
			"our" => -29,
			"use constant" => -29,
			"use" => 36
		},
		GOTOS => {
			'Include' => 35,
			'STAR-12' => 37
		}
	},
	{#State 30
		DEFAULT => -24
	},
	{#State 31
		ACTIONS => {
			")" => 38
		}
	},
	{#State 32
		ACTIONS => {
			"use RPerl;" => 39
		}
	},
	{#State 33
		ACTIONS => {
			"use" => -11,
			"foreach" => -11,
			'OP01_NAMED_VOID' => -11,
			'LPAREN' => -11,
			'OP01_NAMED_VOID_SCOLON' => -11,
			'MY' => -11,
			'LBRACE' => -11,
			'WORD' => -11,
			'OP19_LOOP_CONTROL_SCOLON' => -11,
			'OP01_NAMED_VOID_LPAREN' => -11,
			'WORD_UPPERCASE' => -11,
			"undef" => -11,
			"%{" => -11,
			'OP05_LOGICAL_NEG' => -11,
			'LITERAL_STRING' => -11,
			'LITERAL_NUMBER' => -11,
			'LBRACKET' => -11,
			"\@{" => -11,
			"for" => -11,
			'OP19_LOOP_CONTROL' => -11,
			'VARIABLE_SYMBOL' => -11,
			'OP10_NAMED_UNARY' => -11,
			"if" => -11,
			'OP03_MATH_INC_DEC' => -11,
			'WORD_SCOPED' => -11,
			"while" => -11,
			"our" => -11,
			'OP01_PRINT' => -11,
			'OP05_MATH_NEG_LPAREN' => -11,
			'OP22_LOGICAL_NEG' => -11,
			'OP01_OPEN' => -11,
			"## no critic qw(" => 7,
			'OP01_CLOSE' => -11,
			"use constant" => -11,
			'OP01_NAMED' => -11
		},
		GOTOS => {
			'STAR-5' => 40,
			'Critic' => 41
		}
	},
	{#State 34
		ACTIONS => {
			"use strict;" => 22
		},
		GOTOS => {
			'Header' => 42
		}
	},
	{#State 35
		DEFAULT => -26
	},
	{#State 36
		ACTIONS => {
			'WORD_SCOPED' => 24,
			'WORD' => 26
		},
		GOTOS => {
			'WordScoped' => 43
		}
	},
	{#State 37
		ACTIONS => {
			"our" => 46,
			"use constant" => 48
		},
		GOTOS => {
			'Constant' => 45,
			'PLUS-13' => 47,
			'Subroutine' => 44
		}
	},
	{#State 38
		ACTIONS => {
			";" => 49
		}
	},
	{#State 39
		ACTIONS => {
			"our" => 50
		}
	},
	{#State 40
		ACTIONS => {
			'WORD_UPPERCASE' => -13,
			"undef" => -13,
			'OP05_LOGICAL_NEG' => -13,
			"%{" => -13,
			"\@{" => -13,
			'LBRACKET' => -13,
			'LITERAL_NUMBER' => -13,
			'LITERAL_STRING' => -13,
			"foreach" => -13,
			"use" => 36,
			'LPAREN' => -13,
			'OP01_NAMED_VOID' => -13,
			'OP01_NAMED_VOID_LPAREN' => -13,
			'OP19_LOOP_CONTROL_SCOLON' => -13,
			'WORD' => -13,
			'LBRACE' => -13,
			'MY' => -13,
			'OP01_NAMED_VOID_SCOLON' => -13,
			'OP22_LOGICAL_NEG' => -13,
			'OP05_MATH_NEG_LPAREN' => -13,
			'OP01_CLOSE' => -13,
			'OP01_OPEN' => -13,
			"use constant" => -13,
			'OP01_NAMED' => -13,
			'OP19_LOOP_CONTROL' => -13,
			"for" => -13,
			"while" => -13,
			'WORD_SCOPED' => -13,
			'OP03_MATH_INC_DEC' => -13,
			"if" => -13,
			'VARIABLE_SYMBOL' => -13,
			'OP10_NAMED_UNARY' => -13,
			'OP01_PRINT' => -13,
			"our" => -13
		},
		GOTOS => {
			'STAR-6' => 52,
			'Include' => 51
		}
	},
	{#State 41
		DEFAULT => -8
	},
	{#State 42
		DEFAULT => -21
	},
	{#State 43
		ACTIONS => {
			";" => 53,
			'OP01_QW' => 54
		}
	},
	{#State 44
		DEFAULT => -31
	},
	{#State 45
		DEFAULT => -28
	},
	{#State 46
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 47
		ACTIONS => {
			"our" => 46,
			'LITERAL_NUMBER' => 59
		},
		GOTOS => {
			'Subroutine' => 58
		}
	},
	{#State 48
		ACTIONS => {
			'WORD_UPPERCASE' => 60
		}
	},
	{#State 49
		ACTIONS => {
			"use" => 36
		},
		GOTOS => {
			'Include' => 61
		}
	},
	{#State 50
		ACTIONS => {
			'VERSION_NUMBER_ASSIGN' => 62
		}
	},
	{#State 51
		DEFAULT => -10
	},
	{#State 52
		ACTIONS => {
			'OP01_CLOSE' => -15,
			'OP01_OPEN' => -15,
			'OP05_MATH_NEG_LPAREN' => -15,
			'OP22_LOGICAL_NEG' => -15,
			'OP01_NAMED' => -15,
			"use constant" => 48,
			'WORD_SCOPED' => -15,
			'OP03_MATH_INC_DEC' => -15,
			"while" => -15,
			'OP10_NAMED_UNARY' => -15,
			'VARIABLE_SYMBOL' => -15,
			"if" => -15,
			"for" => -15,
			'OP19_LOOP_CONTROL' => -15,
			'OP01_PRINT' => -15,
			"our" => -15,
			"undef" => -15,
			'WORD_UPPERCASE' => -15,
			'LBRACKET' => -15,
			"\@{" => -15,
			'LITERAL_NUMBER' => -15,
			'LITERAL_STRING' => -15,
			"%{" => -15,
			'OP05_LOGICAL_NEG' => -15,
			"foreach" => -15,
			'WORD' => -15,
			'OP19_LOOP_CONTROL_SCOLON' => -15,
			'OP01_NAMED_VOID_LPAREN' => -15,
			'OP01_NAMED_VOID_SCOLON' => -15,
			'LBRACE' => -15,
			'MY' => -15,
			'LPAREN' => -15,
			'OP01_NAMED_VOID' => -15
		},
		GOTOS => {
			'Constant' => 63,
			'STAR-7' => 64
		}
	},
	{#State 53
		DEFAULT => -39
	},
	{#State 54
		ACTIONS => {
			'WORD' => 65
		},
		GOTOS => {
			'PLUS-15' => 66
		}
	},
	{#State 55
		DEFAULT => -209
	},
	{#State 56
		DEFAULT => -208
	},
	{#State 57
		ACTIONS => {
			'VARIABLE_SYMBOL' => 67
		}
	},
	{#State 58
		DEFAULT => -30
	},
	{#State 59
		ACTIONS => {
			";" => 68
		}
	},
	{#State 60
		ACTIONS => {
			'OP20_HASH_FATARROW' => 69
		}
	},
	{#State 61
		DEFAULT => -52,
		GOTOS => {
			'STAR-20' => 70
		}
	},
	{#State 62
		DEFAULT => -33
	},
	{#State 63
		DEFAULT => -12
	},
	{#State 64
		ACTIONS => {
			"our" => 46,
			'OP01_PRINT' => 105,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			"if" => 111,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			"while" => -142,
			"for" => -142,
			'OP19_LOOP_CONTROL' => 117,
			'OP01_NAMED' => 99,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'MY' => 90,
			'LBRACE' => 89,
			'WORD' => 26,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_NAMED_VOID' => 96,
			'LPAREN' => 94,
			"foreach" => -142,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'LBRACKET' => 73,
			"\@{" => 71,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			"undef" => 81,
			'WORD_UPPERCASE' => 84
		},
		GOTOS => {
			'Operator' => 83,
			'Expression' => 82,
			'Subroutine' => 80,
			'Variable' => 86,
			'VariableDeclaration' => 85,
			'PLUS-8' => 104,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'OperatorVoid' => 76,
			'LoopLabel' => 77,
			'HashReference' => 110,
			'VariableModification' => 109,
			'Operation' => 97,
			'ArrayReference' => 112,
			'Literal' => 113,
			'PAREN-35' => 116,
			'Conditional' => 93,
			'Statement' => 91,
			'ArrayDereference' => 106,
			'OPTIONAL-36' => 107,
			'SubExpression' => 95
		}
	},
	{#State 65
		DEFAULT => -38
	},
	{#State 66
		ACTIONS => {
			'WORD' => 118,
			")" => 119
		}
	},
	{#State 67
		ACTIONS => {
			"= sub {" => 120
		}
	},
	{#State 68
		DEFAULT => -32
	},
	{#State 69
		ACTIONS => {
			'MY' => 122
		},
		GOTOS => {
			'TypeInnerConstant' => 121
		}
	},
	{#State 70
		ACTIONS => {
			"## no critic qw(" => 7,
			"use constant" => -54,
			"use" => -54,
			"our hashref \$properties" => -54
		},
		GOTOS => {
			'STAR-21' => 123,
			'Critic' => 124
		}
	},
	{#State 71
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'MY' => 126,
			'LBRACKET' => -187
		},
		GOTOS => {
			'TypeInner' => 127,
			'Variable' => 125,
			'OPTIONAL-47' => 128
		}
	},
	{#State 72
		ACTIONS => {
			'LPAREN' => 130,
			'OP02_METHOD_THINARROW_NEW' => 129
		}
	},
	{#State 73
		ACTIONS => {
			'LPAREN' => 94,
			"]" => -184,
			'WORD' => 26,
			'LBRACE' => 89,
			'MY' => 126,
			'OP01_QW' => 138,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81
		},
		GOTOS => {
			'HashDereference' => 98,
			'WordScoped' => 72,
			'ListElement' => 135,
			'ArrayDereference' => 106,
			'SubExpression' => 137,
			'TypeInner' => 136,
			'OPTIONAL-46' => 140,
			'HashReference' => 110,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Operator' => 83,
			'Expression' => 131,
			'ListElements' => 133,
			'Variable' => 134
		}
	},
	{#State 74
		DEFAULT => -218
	},
	{#State 75
		DEFAULT => -217
	},
	{#State 76
		DEFAULT => -145
	},
	{#State 77
		ACTIONS => {
			'COLON' => 141
		}
	},
	{#State 78
		ACTIONS => {
			'WORD' => 26,
			'LBRACE' => 89,
			'LPAREN' => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 83,
			'Expression' => 131,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'SubExpression' => 142,
			'ArrayDereference' => 106,
			'HashDereference' => 98,
			'WordScoped' => 72
		}
	},
	{#State 79
		ACTIONS => {
			'MY' => 126,
			'LBRACE' => -202,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'OPTIONAL-51' => 144,
			'Variable' => 145,
			'TypeInner' => 143
		}
	},
	{#State 80
		DEFAULT => -14
	},
	{#State 81
		DEFAULT => -130
	},
	{#State 82
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -129,
			'OP12_COMPARE_EQ_NE' => -129,
			'OP15_LOGICAL_AND' => -129,
			'OP04_MATH_POW' => -129,
			'OP07_STRING_REPEAT' => -129,
			'OP23_LOGICAL_AND' => -129,
			'OP16_LOGICAL_OR' => -129,
			'OP13_BITWISE_AND' => -129,
			'OP06_REGEX_MATCH' => -129,
			'OP08_STRING_CAT' => -129,
			'OP09_BITWISE_SHIFT' => -129,
			'OP18_TERNARY' => -129,
			";" => 146,
			'OP08_MATH_ADD_SUB' => -129,
			'OP07_MATH_MULT_DIV_MOD' => -129,
			'OP24_LOGICAL_OR_XOR' => -129,
			'OP11_COMPARE_LT_GT' => -129,
			'OP17_LIST_RANGE' => -129
		}
	},
	{#State 83
		DEFAULT => -124
	},
	{#State 84
		ACTIONS => {
			'LPAREN' => 147,
			'COLON' => -207
		}
	},
	{#State 85
		DEFAULT => -146
	},
	{#State 86
		ACTIONS => {
			'OP23_LOGICAL_AND' => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP07_STRING_REPEAT' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP04_MATH_POW' => -132,
			'OP02_METHOD_THINARROW' => 149,
			'OP24_LOGICAL_OR_XOR' => -132,
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP17_LIST_RANGE' => -132,
			'OP19_VARIABLE_ASSIGN_BY' => 148,
			'OP11_COMPARE_LT_GT' => -132,
			'OP08_STRING_CAT' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP18_TERNARY' => -132,
			'OP19_VARIABLE_ASSIGN' => 150,
			'OP03_MATH_INC_DEC' => 151,
			'OP08_MATH_ADD_SUB' => -132
		}
	},
	{#State 87
		DEFAULT => -118
	},
	{#State 88
		ACTIONS => {
			'MY' => 126,
			")" => -111,
			'LBRACE' => 89,
			'WORD' => 26,
			'LPAREN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 138,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103
		},
		GOTOS => {
			'Variable' => 134,
			'ListElements' => 152,
			'OPTIONAL-32' => 153,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Operator' => 83,
			'Expression' => 131,
			'HashReference' => 110,
			'TypeInner' => 136,
			'SubExpression' => 137,
			'ArrayDereference' => 106,
			'ListElement' => 135,
			'WordScoped' => 72,
			'HashDereference' => 98
		}
	},
	{#State 89
		ACTIONS => {
			"%{" => 79,
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"}" => 159,
			'WORD' => 158
		},
		GOTOS => {
			'Variable' => 160,
			'HashEntry' => 156,
			'Literal' => 154,
			'VariableOrLiteralOrWord' => 155,
			'HashDereference' => 157
		}
	},
	{#State 90
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 161
		}
	},
	{#State 91
		DEFAULT => -77
	},
	{#State 92
		DEFAULT => -114
	},
	{#State 93
		DEFAULT => -143
	},
	{#State 94
		ACTIONS => {
			'LPAREN' => 94,
			'OP01_PRINT' => 163,
			'WORD' => 26,
			'LBRACE' => 89,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_NAMED' => 162,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81
		},
		GOTOS => {
			'Literal' => 113,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Operator' => 83,
			'HashReference' => 110,
			'Variable' => 134,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpression' => 164,
			'ArrayDereference' => 106
		}
	},
	{#State 95
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP15_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => 169,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165
		}
	},
	{#State 96
		ACTIONS => {
			'WORD' => 26,
			'MY' => 126,
			'LBRACE' => 89,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP01_QW' => 138,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'ListElements' => 182,
			'Variable' => 134,
			'HashReference' => 110,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayReference' => 112,
			'Literal' => 113,
			'ArrayDereference' => 106,
			'SubExpression' => 137,
			'TypeInner' => 136,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'ListElement' => 135
		}
	},
	{#State 97
		DEFAULT => -17
	},
	{#State 98
		DEFAULT => -136
	},
	{#State 99
		ACTIONS => {
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP01_QW' => 138,
			'WORD' => 26,
			'MY' => 126,
			'LBRACE' => 89,
			'LPAREN' => 94
		},
		GOTOS => {
			'ArrayDereference' => 106,
			'SubExpression' => 184,
			'TypeInner' => 136,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'ListElement' => 183,
			'Variable' => 134,
			'HashReference' => 110,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Expression' => 131,
			'Operator' => 83
		}
	},
	{#State 100
		ACTIONS => {
			'FH_REF_SYMBOL' => 185
		}
	},
	{#State 101
		ACTIONS => {
			'MY' => 186
		}
	},
	{#State 102
		ACTIONS => {
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'WORD' => 26,
			'LBRACE' => 89,
			'LPAREN' => 94
		},
		GOTOS => {
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpression' => 187,
			'ArrayDereference' => 106,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Operator' => 83,
			'Expression' => 131,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 103
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'LBRACE' => 89,
			'WORD' => 26,
			'LPAREN' => 94,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashDereference' => 98,
			'WordScoped' => 72,
			'SubExpression' => 188,
			'ArrayDereference' => 106,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Operator' => 83,
			'Expression' => 131,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 104
		ACTIONS => {
			'OP01_NAMED' => 99,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_PRINT' => 105,
			"while" => -142,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			"if" => 111,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP19_LOOP_CONTROL' => 117,
			"for" => -142,
			'' => -18,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			"undef" => 81,
			'WORD_UPPERCASE' => 84,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'WORD' => 26,
			'LBRACE' => 89,
			'MY' => 90,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'LPAREN' => 94,
			'OP01_NAMED_VOID' => 96,
			"foreach" => -142
		},
		GOTOS => {
			'OperatorVoid' => 76,
			'LoopLabel' => 77,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'Variable' => 86,
			'VariableDeclaration' => 85,
			'Operator' => 83,
			'Expression' => 82,
			'ArrayDereference' => 106,
			'SubExpression' => 95,
			'OPTIONAL-36' => 107,
			'Conditional' => 93,
			'Statement' => 91,
			'PAREN-35' => 116,
			'Operation' => 189,
			'HashReference' => 110,
			'VariableModification' => 109,
			'ArrayReference' => 112,
			'Literal' => 113
		}
	},
	{#State 105
		ACTIONS => {
			'OP01_CLOSE' => -109,
			'OP01_OPEN' => -109,
			"undef" => -109,
			'OP22_LOGICAL_NEG' => -109,
			'WORD_UPPERCASE' => -109,
			'OP05_MATH_NEG_LPAREN' => -109,
			'FH_REF_SYMBOL_BRACES' => 193,
			"\@{" => -109,
			'OP01_NAMED' => -109,
			'LBRACKET' => -109,
			'LITERAL_NUMBER' => -109,
			'LITERAL_STRING' => -109,
			'OP05_LOGICAL_NEG' => -109,
			"%{" => -109,
			'OP03_MATH_INC_DEC' => -109,
			'WORD_SCOPED' => -109,
			'VARIABLE_SYMBOL' => -109,
			'OP10_NAMED_UNARY' => -109,
			'OP01_QW' => -109,
			'STDOUT_STDERR' => 190,
			'WORD' => -109,
			'MY' => -109,
			'LBRACE' => -109,
			'LPAREN' => -109
		},
		GOTOS => {
			'PAREN-30' => 192,
			'OPTIONAL-31' => 191
		}
	},
	{#State 106
		DEFAULT => -134
	},
	{#State 107
		ACTIONS => {
			"while" => 197,
			"for" => 196,
			"foreach" => 200
		},
		GOTOS => {
			'Loop' => 194,
			'LoopFor' => 195,
			'LoopForEach' => 199,
			'LoopWhile' => 198
		}
	},
	{#State 108
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 201
		}
	},
	{#State 109
		DEFAULT => -147
	},
	{#State 110
		DEFAULT => -135
	},
	{#State 111
		ACTIONS => {
			'LPAREN' => 202
		}
	},
	{#State 112
		DEFAULT => -133
	},
	{#State 113
		DEFAULT => -131
	},
	{#State 114
		ACTIONS => {
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			"}" => -95,
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP13_BITWISE_AND' => -95,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP23_LOGICAL_AND' => -95,
			'WORD_UPPERCASE' => 132,
			'OP15_LOGICAL_AND' => -95,
			'OP21_LIST_COMMA' => -95,
			"undef" => 81,
			'OP07_MATH_MULT_DIV_MOD' => -95,
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89,
			'OP09_BITWISE_SHIFT' => -95,
			'OP08_STRING_CAT' => -95,
			'OP18_TERNARY' => -95,
			'OP01_NAMED' => 139,
			'OP07_STRING_REPEAT' => -95,
			'OP16_LOGICAL_OR' => -95,
			'OP12_COMPARE_EQ_NE' => -95,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP14_BITWISE_OR_XOR' => -95,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			'OP04_MATH_POW' => -95,
			"]" => -95,
			'OP24_LOGICAL_OR_XOR' => -95,
			'OP11_COMPARE_LT_GT' => -95,
			'OP17_LIST_RANGE' => -95,
			")" => -95,
			'OP06_REGEX_MATCH' => -95,
			'OP08_MATH_ADD_SUB' => -95,
			'OP03_MATH_INC_DEC' => 108,
			";" => -95,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Variable' => 134,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Operator' => 83,
			'HashReference' => 110,
			'SubExpression' => 203,
			'ArrayDereference' => 106,
			'HashDereference' => 98,
			'WordScoped' => 72
		}
	},
	{#State 115
		DEFAULT => -165,
		GOTOS => {
			'STAR-42' => 204
		}
	},
	{#State 116
		DEFAULT => -141
	},
	{#State 117
		ACTIONS => {
			'WORD_UPPERCASE' => 205
		},
		GOTOS => {
			'LoopLabel' => 206
		}
	},
	{#State 118
		DEFAULT => -37
	},
	{#State 119
		ACTIONS => {
			";" => 207
		}
	},
	{#State 120
		ACTIONS => {
			"foreach" => -43,
			'OP01_NAMED_VOID' => -43,
			'LPAREN' => -43,
			'LBRACE' => -43,
			'MY' => -43,
			'OP01_NAMED_VOID_SCOLON' => -43,
			'OP01_NAMED_VOID_LPAREN' => -43,
			'OP19_LOOP_CONTROL_SCOLON' => -43,
			'WORD' => -43,
			'WORD_UPPERCASE' => -43,
			"undef" => -43,
			'OP05_LOGICAL_NEG' => -43,
			"%{" => -43,
			'LITERAL_NUMBER' => -43,
			'LITERAL_STRING' => -43,
			"\@{" => -43,
			'LBRACKET' => -43,
			"}" => -43,
			'OP19_LOOP_CONTROL' => -43,
			"for" => -43,
			"if" => -43,
			'VARIABLE_SYMBOL' => -43,
			'OP10_NAMED_UNARY' => -43,
			"while" => -43,
			'WORD_SCOPED' => -43,
			'OP03_MATH_INC_DEC' => -43,
			'LPAREN_MY' => 209,
			'OP01_PRINT' => -43,
			'OP22_LOGICAL_NEG' => -43,
			'OP05_MATH_NEG_LPAREN' => -43,
			'OP01_OPEN' => -43,
			'OP01_CLOSE' => -43,
			'OP01_NAMED' => -43
		},
		GOTOS => {
			'OPTIONAL-16' => 208,
			'SubroutineArguments' => 210
		}
	},
	{#State 121
		ACTIONS => {
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'Literal' => 211
		}
	},
	{#State 122
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 212
		}
	},
	{#State 123
		ACTIONS => {
			"use constant" => -56,
			"use" => 36,
			"our hashref \$properties" => -56
		},
		GOTOS => {
			'Include' => 214,
			'STAR-22' => 213
		}
	},
	{#State 124
		DEFAULT => -51
	},
	{#State 125
		ACTIONS => {
			"}" => 215
		}
	},
	{#State 126
		ACTIONS => {
			'WORD' => 56,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 216
		}
	},
	{#State 127
		DEFAULT => -186
	},
	{#State 128
		ACTIONS => {
			'LBRACKET' => 73
		},
		GOTOS => {
			'ArrayReference' => 217
		}
	},
	{#State 129
		ACTIONS => {
			")" => 218
		}
	},
	{#State 130
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'LPAREN' => 94,
			'LBRACE' => 89,
			")" => -121,
			'MY' => 126,
			'WORD' => 26,
			'OP01_QW' => 138,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'HashReference' => 110,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Expression' => 131,
			'Operator' => 83,
			'ListElements' => 219,
			'Variable' => 134,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'ListElement' => 135,
			'ArrayDereference' => 106,
			'TypeInner' => 136,
			'OPTIONAL-33' => 220,
			'SubExpression' => 137
		}
	},
	{#State 131
		DEFAULT => -129
	},
	{#State 132
		ACTIONS => {
			'LPAREN' => 147
		}
	},
	{#State 133
		DEFAULT => -183
	},
	{#State 134
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => -132,
			'OP02_METHOD_THINARROW' => 149,
			'OP24_LOGICAL_OR_XOR' => -132,
			"]" => -132,
			'OP11_COMPARE_LT_GT' => -132,
			")" => -132,
			'OP17_LIST_RANGE' => -132,
			'OP06_REGEX_MATCH' => -132,
			'OP08_STRING_CAT' => -132,
			'OP09_BITWISE_SHIFT' => -132,
			'OP18_TERNARY' => -132,
			'OP08_MATH_ADD_SUB' => -132,
			";" => -132,
			'OP03_MATH_INC_DEC' => 151,
			'OP07_STRING_REPEAT' => -132,
			"}" => -132,
			'OP16_LOGICAL_OR' => -132,
			'OP23_LOGICAL_AND' => -132,
			'OP13_BITWISE_AND' => -132,
			'OP14_BITWISE_OR_XOR' => -132,
			'OP12_COMPARE_EQ_NE' => -132,
			'OP15_LOGICAL_AND' => -132,
			'OP21_LIST_COMMA' => -132,
			'OP04_MATH_POW' => -132
		}
	},
	{#State 135
		DEFAULT => -176,
		GOTOS => {
			'STAR-44' => 221
		}
	},
	{#State 136
		ACTIONS => {
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Literal' => 113,
			'Expression' => 131,
			'Operator' => 83,
			'HashReference' => 110,
			'Variable' => 134,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpression' => 222,
			'ArrayDereference' => 106
		}
	},
	{#State 137
		ACTIONS => {
			'OP13_BITWISE_AND' => 170,
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => 169,
			'OP07_STRING_REPEAT' => 177,
			'OP15_LOGICAL_AND' => 171,
			'OP21_LIST_COMMA' => -180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP24_LOGICAL_OR_XOR' => 174,
			"]" => -180,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP17_LIST_RANGE' => 173,
			")" => -180,
			'OP11_COMPARE_LT_GT' => 172,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP06_REGEX_MATCH' => 176,
			";" => -180,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => 166
		}
	},
	{#State 138
		ACTIONS => {
			'WORD' => 224
		},
		GOTOS => {
			'PLUS-45' => 223
		}
	},
	{#State 139
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89
		},
		GOTOS => {
			'HashDereference' => 98,
			'WordScoped' => 72,
			'SubExpression' => 225,
			'ArrayDereference' => 106,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Expression' => 131,
			'Operator' => 83,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 140
		ACTIONS => {
			"]" => 226
		}
	},
	{#State 141
		DEFAULT => -140
	},
	{#State 142
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => -86,
			'OP12_COMPARE_EQ_NE' => -86,
			'OP21_LIST_COMMA' => -86,
			'OP15_LOGICAL_AND' => -86,
			'OP04_MATH_POW' => 179,
			'OP07_STRING_REPEAT' => -86,
			"}" => -86,
			'OP23_LOGICAL_AND' => -86,
			'OP16_LOGICAL_OR' => -86,
			'OP13_BITWISE_AND' => -86,
			'OP06_REGEX_MATCH' => -86,
			'OP08_STRING_CAT' => -86,
			'OP09_BITWISE_SHIFT' => -86,
			'OP18_TERNARY' => -86,
			'OP08_MATH_ADD_SUB' => -86,
			";" => -86,
			'OP07_MATH_MULT_DIV_MOD' => -86,
			'OP24_LOGICAL_OR_XOR' => -86,
			"]" => -86,
			'OP11_COMPARE_LT_GT' => -86,
			")" => -86,
			'OP17_LIST_RANGE' => -86
		}
	},
	{#State 143
		DEFAULT => -201
	},
	{#State 144
		ACTIONS => {
			'LBRACE' => 89
		},
		GOTOS => {
			'HashReference' => 227
		}
	},
	{#State 145
		ACTIONS => {
			"}" => 228
		}
	},
	{#State 146
		DEFAULT => -76
	},
	{#State 147
		ACTIONS => {
			")" => 229
		}
	},
	{#State 148
		ACTIONS => {
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100
		},
		GOTOS => {
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpression' => 230,
			'ArrayDereference' => 106,
			'Operator' => 83,
			'Expression' => 131,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 149
		ACTIONS => {
			'LPAREN' => 231
		}
	},
	{#State 150
		ACTIONS => {
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'STDIN' => 233,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 110,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayDereference' => 106,
			'SubExpression' => 232,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpressionOrStdin' => 234
		}
	},
	{#State 151
		DEFAULT => -84
	},
	{#State 152
		DEFAULT => -110
	},
	{#State 153
		ACTIONS => {
			")" => 235
		}
	},
	{#State 154
		DEFAULT => -215
	},
	{#State 155
		ACTIONS => {
			'OP20_HASH_FATARROW' => 236
		}
	},
	{#State 156
		DEFAULT => -198,
		GOTOS => {
			'STAR-50' => 237
		}
	},
	{#State 157
		DEFAULT => -193
	},
	{#State 158
		DEFAULT => -216
	},
	{#State 159
		DEFAULT => -200
	},
	{#State 160
		DEFAULT => -214
	},
	{#State 161
		ACTIONS => {
			'VARIABLE_SYMBOL' => 238
		}
	},
	{#State 162
		ACTIONS => {
			'OP01_QW' => 138,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'LPAREN' => 94,
			'LBRACE' => 89,
			'MY' => 126,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71
		},
		GOTOS => {
			'Expression' => 131,
			'Operator' => 83,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'Variable' => 134,
			'ListElement' => 239,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpression' => 184,
			'TypeInner' => 136,
			'ArrayDereference' => 106
		}
	},
	{#State 163
		ACTIONS => {
			'FH_REF_SYMBOL_BRACES' => 240
		}
	},
	{#State 164
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP15_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => 169,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176,
			")" => 241,
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165
		}
	},
	{#State 165
		ACTIONS => {
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81
		},
		GOTOS => {
			'Variable' => 134,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Operator' => 83,
			'Expression' => 131,
			'HashReference' => 110,
			'SubExpression' => 242,
			'ArrayDereference' => 106,
			'HashDereference' => 98,
			'WordScoped' => 72
		}
	},
	{#State 166
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'Literal' => 244,
			'VariableOrLiteral' => 243,
			'Variable' => 245
		}
	},
	{#State 167
		ACTIONS => {
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81
		},
		GOTOS => {
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpression' => 246,
			'ArrayDereference' => 106,
			'Expression' => 131,
			'Operator' => 83,
			'Literal' => 113,
			'ArrayReference' => 112,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 168
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108
		},
		GOTOS => {
			'ArrayDereference' => 106,
			'SubExpression' => 247,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'Variable' => 134,
			'HashReference' => 110,
			'Operator' => 83,
			'Expression' => 131,
			'Literal' => 113,
			'ArrayReference' => 112
		}
	},
	{#State 169
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'LBRACE' => 89,
			'WORD' => 26,
			'LPAREN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108
		},
		GOTOS => {
			'SubExpression' => 248,
			'ArrayDereference' => 106,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'Variable' => 134,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Expression' => 131,
			'Operator' => 83,
			'HashReference' => 110
		}
	},
	{#State 170
		ACTIONS => {
			'LBRACE' => 89,
			'WORD' => 26,
			'LPAREN' => 94,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132
		},
		GOTOS => {
			'HashDereference' => 98,
			'WordScoped' => 72,
			'SubExpression' => 249,
			'ArrayDereference' => 106,
			'Expression' => 131,
			'Operator' => 83,
			'Literal' => 113,
			'ArrayReference' => 112,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 171
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73
		},
		GOTOS => {
			'HashDereference' => 98,
			'WordScoped' => 72,
			'SubExpression' => 250,
			'ArrayDereference' => 106,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 172
		ACTIONS => {
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD' => 26,
			'LBRACE' => 89,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114
		},
		GOTOS => {
			'SubExpression' => 251,
			'ArrayDereference' => 106,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'Variable' => 134,
			'Operator' => 83,
			'Expression' => 131,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110
		}
	},
	{#State 173
		ACTIONS => {
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'WORD' => 26,
			'LBRACE' => 89,
			'LPAREN' => 94
		},
		GOTOS => {
			'HashReference' => 110,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Operator' => 83,
			'Variable' => 134,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'ArrayDereference' => 106,
			'SubExpression' => 252
		}
	},
	{#State 174
		ACTIONS => {
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 83,
			'Expression' => 131,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'SubExpression' => 253,
			'ArrayDereference' => 106,
			'HashDereference' => 98,
			'WordScoped' => 72
		}
	},
	{#State 175
		ACTIONS => {
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'LBRACE' => 89,
			'WORD' => 26,
			'LPAREN' => 94
		},
		GOTOS => {
			'WordScoped' => 72,
			'HashDereference' => 98,
			'ArrayDereference' => 106,
			'SubExpression' => 254,
			'HashReference' => 110,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Operator' => 83,
			'Expression' => 131,
			'Variable' => 134
		}
	},
	{#State 176
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 255
		}
	},
	{#State 177
		ACTIONS => {
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26
		},
		GOTOS => {
			'HashReference' => 110,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Operator' => 83,
			'Expression' => 131,
			'Variable' => 134,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'ArrayDereference' => 106,
			'SubExpression' => 256
		}
	},
	{#State 178
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'WORD' => 26,
			'LBRACE' => 89,
			'LPAREN' => 94,
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpression' => 257,
			'ArrayDereference' => 106,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Operator' => 83,
			'Expression' => 131,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 179
		ACTIONS => {
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115
		},
		GOTOS => {
			'HashDereference' => 98,
			'WordScoped' => 72,
			'SubExpression' => 258,
			'ArrayDereference' => 106,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Operator' => 83,
			'HashReference' => 110,
			'Variable' => 134
		}
	},
	{#State 180
		ACTIONS => {
			'LBRACE' => 89,
			'WORD' => 26,
			'LPAREN' => 94,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 83,
			'Expression' => 131,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'SubExpression' => 259,
			'ArrayDereference' => 106,
			'WordScoped' => 72,
			'HashDereference' => 98
		}
	},
	{#State 181
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'Variable' => 134,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'SubExpression' => 260,
			'ArrayDereference' => 106,
			'WordScoped' => 72,
			'HashDereference' => 98
		}
	},
	{#State 182
		ACTIONS => {
			";" => 261
		}
	},
	{#State 183
		ACTIONS => {
			'OP21_LIST_COMMA' => 262
		}
	},
	{#State 184
		ACTIONS => {
			'OP07_STRING_REPEAT' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			'OP04_MATH_POW' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP21_LIST_COMMA' => -180,
			'OP15_LOGICAL_AND' => -79,
			'OP11_COMPARE_LT_GT' => -79,
			'OP17_LIST_RANGE' => -79,
			")" => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			";" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP18_TERNARY' => -79,
			'OP06_REGEX_MATCH' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP08_STRING_CAT' => -79
		}
	},
	{#State 185
		DEFAULT => -82
	},
	{#State 186
		ACTIONS => {
			"filehandleref" => 263
		}
	},
	{#State 187
		ACTIONS => {
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => -104,
			'OP16_LOGICAL_OR' => 178,
			"}" => -104,
			'OP07_STRING_REPEAT' => 177,
			'OP21_LIST_COMMA' => -104,
			'OP15_LOGICAL_AND' => 171,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			"]" => -104,
			'OP24_LOGICAL_OR_XOR' => -104,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP17_LIST_RANGE' => 173,
			")" => -104,
			'OP11_COMPARE_LT_GT' => 172,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP06_REGEX_MATCH' => 176,
			";" => -104,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => 166
		}
	},
	{#State 188
		ACTIONS => {
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => 169,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177,
			'OP04_MATH_POW' => 179,
			'OP15_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			")" => 264,
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176
		}
	},
	{#State 189
		DEFAULT => -16
	},
	{#State 190
		DEFAULT => -107
	},
	{#State 191
		ACTIONS => {
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'LPAREN' => 94,
			'MY' => 126,
			'LBRACE' => 89,
			'WORD' => 26,
			'OP01_QW' => 138,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24
		},
		GOTOS => {
			'ArrayReference' => 112,
			'Literal' => 113,
			'Operator' => 83,
			'Expression' => 131,
			'HashReference' => 110,
			'Variable' => 134,
			'ListElements' => 265,
			'ListElement' => 135,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'TypeInner' => 136,
			'SubExpression' => 137,
			'ArrayDereference' => 106
		}
	},
	{#State 192
		DEFAULT => -108
	},
	{#State 193
		ACTIONS => {
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'WORD' => 26,
			'MY' => 126,
			'LBRACE' => 89,
			'LPAREN' => 94,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP01_QW' => 138
		},
		GOTOS => {
			'ListElement' => 135,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'SubExpression' => 137,
			'TypeInner' => 136,
			'ArrayDereference' => 106,
			'Operator' => 83,
			'Expression' => 131,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'Variable' => 134,
			'ListElements' => 266
		}
	},
	{#State 194
		DEFAULT => -144
	},
	{#State 195
		DEFAULT => -155
	},
	{#State 196
		ACTIONS => {
			'MY' => 267
		}
	},
	{#State 197
		ACTIONS => {
			'LPAREN' => 268
		}
	},
	{#State 198
		DEFAULT => -157
	},
	{#State 199
		DEFAULT => -156
	},
	{#State 200
		ACTIONS => {
			'MY' => 269
		}
	},
	{#State 201
		DEFAULT => -83
	},
	{#State 202
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71
		},
		GOTOS => {
			'Variable' => 134,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Operator' => 83,
			'Expression' => 131,
			'HashReference' => 110,
			'SubExpression' => 270,
			'ArrayDereference' => 106,
			'HashDereference' => 98,
			'WordScoped' => 72
		}
	},
	{#State 203
		ACTIONS => {
			'OP13_BITWISE_AND' => -94,
			'OP23_LOGICAL_AND' => -94,
			'OP16_LOGICAL_OR' => -94,
			"}" => -94,
			'OP07_STRING_REPEAT' => 177,
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -94,
			'OP15_LOGICAL_AND' => -94,
			'OP12_COMPARE_EQ_NE' => -94,
			'OP14_BITWISE_OR_XOR' => -94,
			'OP17_LIST_RANGE' => -94,
			")" => -94,
			'OP11_COMPARE_LT_GT' => -94,
			'OP24_LOGICAL_OR_XOR' => -94,
			"]" => -94,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			";" => -94,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => -94,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP06_REGEX_MATCH' => 176
		}
	},
	{#State 204
		ACTIONS => {
			'OP04_MATH_POW' => -166,
			'OP15_LOGICAL_AND' => -166,
			'OP21_LIST_COMMA' => -166,
			'OP12_COMPARE_EQ_NE' => -166,
			'OP14_BITWISE_OR_XOR' => -166,
			'OP13_BITWISE_AND' => -166,
			'OP23_LOGICAL_AND' => -166,
			'OP16_LOGICAL_OR' => -166,
			"}" => -166,
			'OP07_STRING_REPEAT' => -166,
			";" => -166,
			'OP08_MATH_ADD_SUB' => -166,
			'OP03_MATH_INC_DEC' => -166,
			'OP19_VARIABLE_ASSIGN' => -166,
			'OP18_TERNARY' => -166,
			'COLON' => -166,
			'OP09_BITWISE_SHIFT' => -166,
			'OP08_STRING_CAT' => -166,
			'OP06_REGEX_MATCH' => -166,
			'OP17_LIST_RANGE' => -166,
			")" => -166,
			'OP19_VARIABLE_ASSIGN_BY' => -166,
			'OP11_COMPARE_LT_GT' => -166,
			'OP02_HASH_THINARROW' => 272,
			"]" => -166,
			'OP02_ARRAY_THINARROW' => 273,
			'OP24_LOGICAL_OR_XOR' => -166,
			'OP20_HASH_FATARROW' => -166,
			'OP02_METHOD_THINARROW' => -166,
			'OP07_MATH_MULT_DIV_MOD' => -166
		},
		GOTOS => {
			'VariableRetrieval' => 271
		}
	},
	{#State 205
		DEFAULT => -207
	},
	{#State 206
		ACTIONS => {
			";" => 274
		}
	},
	{#State 207
		DEFAULT => -40
	},
	{#State 208
		DEFAULT => -45,
		GOTOS => {
			'STAR-17' => 275
		}
	},
	{#State 209
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 276
		}
	},
	{#State 210
		DEFAULT => -42
	},
	{#State 211
		ACTIONS => {
			";" => 277
		}
	},
	{#State 212
		ACTIONS => {
			"\$TYPED_" => 278
		}
	},
	{#State 213
		ACTIONS => {
			"use constant" => 48,
			"our hashref \$properties" => 280
		},
		GOTOS => {
			'Properties' => 279,
			'Constant' => 281
		}
	},
	{#State 214
		DEFAULT => -53
	},
	{#State 215
		DEFAULT => -188
	},
	{#State 216
		ACTIONS => {
			"\$TYPED_" => 282
		}
	},
	{#State 217
		ACTIONS => {
			"}" => 283
		}
	},
	{#State 218
		DEFAULT => -128
	},
	{#State 219
		DEFAULT => -120
	},
	{#State 220
		ACTIONS => {
			")" => 284
		}
	},
	{#State 221
		ACTIONS => {
			"]" => -177,
			'OP21_LIST_COMMA' => 285,
			";" => -177,
			")" => -177
		},
		GOTOS => {
			'PAREN-43' => 286
		}
	},
	{#State 222
		ACTIONS => {
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			";" => -181,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176,
			")" => -181,
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			"]" => -181,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP04_MATH_POW' => 179,
			'OP15_LOGICAL_AND' => 171,
			'OP21_LIST_COMMA' => -181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177
		}
	},
	{#State 223
		ACTIONS => {
			'WORD' => 288,
			")" => 287
		}
	},
	{#State 224
		DEFAULT => -179
	},
	{#State 225
		ACTIONS => {
			'OP15_LOGICAL_AND' => -79,
			'OP21_LIST_COMMA' => -79,
			'OP12_COMPARE_EQ_NE' => -79,
			'OP14_BITWISE_OR_XOR' => -79,
			'OP04_MATH_POW' => -79,
			'OP13_BITWISE_AND' => -79,
			'OP23_LOGICAL_AND' => -79,
			'OP16_LOGICAL_OR' => -79,
			"}" => -79,
			'OP07_STRING_REPEAT' => -79,
			'OP09_BITWISE_SHIFT' => -79,
			'OP08_STRING_CAT' => -79,
			'OP06_REGEX_MATCH' => -79,
			";" => -79,
			'OP08_MATH_ADD_SUB' => -79,
			'OP18_TERNARY' => -79,
			"]" => -79,
			'OP24_LOGICAL_OR_XOR' => -79,
			'OP07_MATH_MULT_DIV_MOD' => -79,
			'OP17_LIST_RANGE' => -79,
			")" => -79,
			'OP11_COMPARE_LT_GT' => -79
		}
	},
	{#State 226
		DEFAULT => -185
	},
	{#State 227
		ACTIONS => {
			"}" => 289
		}
	},
	{#State 228
		DEFAULT => -203
	},
	{#State 229
		DEFAULT => -126
	},
	{#State 230
		ACTIONS => {
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP15_LOGICAL_AND' => 171,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP06_REGEX_MATCH' => 176,
			'OP08_MATH_ADD_SUB' => 175,
			";" => 290,
			'OP18_TERNARY' => 166
		}
	},
	{#State 231
		ACTIONS => {
			'MY' => 126,
			")" => -123,
			'LBRACE' => 89,
			'WORD' => 26,
			'LPAREN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 138,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103
		},
		GOTOS => {
			'HashDereference' => 98,
			'WordScoped' => 72,
			'ListElement' => 135,
			'ArrayDereference' => 106,
			'OPTIONAL-34' => 291,
			'SubExpression' => 137,
			'TypeInner' => 136,
			'HashReference' => 110,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayReference' => 112,
			'Literal' => 113,
			'ListElements' => 292,
			'Variable' => 134
		}
	},
	{#State 232
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP15_LOGICAL_AND' => 171,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178,
			";" => -138,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => 166,
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP11_COMPARE_LT_GT' => 172,
			'OP17_LIST_RANGE' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => 174
		}
	},
	{#State 233
		DEFAULT => -139
	},
	{#State 234
		ACTIONS => {
			";" => 293
		}
	},
	{#State 235
		ACTIONS => {
			";" => 294
		}
	},
	{#State 236
		ACTIONS => {
			'LPAREN' => -191,
			'MY' => 126,
			'LBRACE' => -191,
			'WORD' => -191,
			'VARIABLE_SYMBOL' => -191,
			'OP10_NAMED_UNARY' => -191,
			'WORD_SCOPED' => -191,
			'OP03_MATH_INC_DEC' => -191,
			"%{" => -191,
			'OP05_LOGICAL_NEG' => -191,
			'LITERAL_NUMBER' => -191,
			'LITERAL_STRING' => -191,
			'LBRACKET' => -191,
			"\@{" => -191,
			'OP01_NAMED' => -191,
			'OP05_MATH_NEG_LPAREN' => -191,
			'OP22_LOGICAL_NEG' => -191,
			'WORD_UPPERCASE' => -191,
			"undef" => -191,
			'OP01_OPEN' => -191,
			'OP01_CLOSE' => -191
		},
		GOTOS => {
			'OPTIONAL-48' => 296,
			'TypeInner' => 295
		}
	},
	{#State 237
		ACTIONS => {
			'OP21_LIST_COMMA' => 298,
			"}" => 299
		},
		GOTOS => {
			'PAREN-49' => 297
		}
	},
	{#State 238
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 301,
			";" => 300
		}
	},
	{#State 239
		ACTIONS => {
			'OP21_LIST_COMMA' => 302
		}
	},
	{#State 240
		ACTIONS => {
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 138,
			'LBRACE' => 89,
			'MY' => 126,
			'WORD' => 26,
			'LPAREN' => 94,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78
		},
		GOTOS => {
			'Expression' => 131,
			'Operator' => 83,
			'Literal' => 113,
			'ArrayReference' => 112,
			'HashReference' => 110,
			'Variable' => 134,
			'ListElements' => 303,
			'ListElement' => 135,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'SubExpression' => 137,
			'TypeInner' => 136,
			'ArrayDereference' => 106
		}
	},
	{#State 241
		DEFAULT => -137
	},
	{#State 242
		ACTIONS => {
			'OP17_LIST_RANGE' => -90,
			")" => -90,
			'OP11_COMPARE_LT_GT' => -90,
			"]" => -90,
			'OP24_LOGICAL_OR_XOR' => -90,
			'OP07_MATH_MULT_DIV_MOD' => -90,
			";" => -90,
			'OP08_MATH_ADD_SUB' => -90,
			'OP18_TERNARY' => -90,
			'OP09_BITWISE_SHIFT' => -90,
			'OP08_STRING_CAT' => -90,
			'OP06_REGEX_MATCH' => 176,
			'OP13_BITWISE_AND' => -90,
			'OP23_LOGICAL_AND' => -90,
			'OP16_LOGICAL_OR' => -90,
			"}" => -90,
			'OP07_STRING_REPEAT' => 177,
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -90,
			'OP15_LOGICAL_AND' => -90,
			'OP12_COMPARE_EQ_NE' => -90,
			'OP14_BITWISE_OR_XOR' => -90
		}
	},
	{#State 243
		ACTIONS => {
			'COLON' => 304
		}
	},
	{#State 244
		DEFAULT => -213
	},
	{#State 245
		DEFAULT => -212
	},
	{#State 246
		ACTIONS => {
			'OP07_STRING_REPEAT' => 177,
			"}" => -92,
			'OP23_LOGICAL_AND' => -92,
			'OP16_LOGICAL_OR' => -92,
			'OP13_BITWISE_AND' => -92,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => -92,
			'OP12_COMPARE_EQ_NE' => -92,
			'OP21_LIST_COMMA' => -92,
			'OP15_LOGICAL_AND' => -92,
			'OP11_COMPARE_LT_GT' => -92,
			")" => -92,
			'OP17_LIST_RANGE' => -92,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"]" => -92,
			'OP24_LOGICAL_OR_XOR' => -92,
			'OP18_TERNARY' => -92,
			'OP08_MATH_ADD_SUB' => 175,
			";" => -92,
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => -92,
			'OP09_BITWISE_SHIFT' => -92
		}
	},
	{#State 247
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -93,
			")" => -93,
			'OP17_LIST_RANGE' => -93,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => -93,
			"]" => -93,
			'OP18_TERNARY' => -93,
			'OP08_MATH_ADD_SUB' => 175,
			";" => -93,
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => -93,
			'OP07_STRING_REPEAT' => 177,
			"}" => -93,
			'OP16_LOGICAL_OR' => -93,
			'OP23_LOGICAL_AND' => -93,
			'OP13_BITWISE_AND' => -93,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => -93,
			'OP12_COMPARE_EQ_NE' => -93,
			'OP21_LIST_COMMA' => -93,
			'OP15_LOGICAL_AND' => -93
		}
	},
	{#State 248
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP15_LOGICAL_AND' => 171,
			'OP21_LIST_COMMA' => -105,
			"}" => -105,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 170,
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => -105,
			";" => -105,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => 166,
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP11_COMPARE_LT_GT' => 172,
			'OP17_LIST_RANGE' => 173,
			")" => -105,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => -105,
			"]" => -105
		}
	},
	{#State 249
		ACTIONS => {
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => -98,
			"]" => -98,
			'OP11_COMPARE_LT_GT' => 172,
			")" => -98,
			'OP17_LIST_RANGE' => -98,
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP18_TERNARY' => -98,
			";" => -98,
			'OP08_MATH_ADD_SUB' => 175,
			'OP07_STRING_REPEAT' => 177,
			"}" => -98,
			'OP16_LOGICAL_OR' => -98,
			'OP23_LOGICAL_AND' => -98,
			'OP13_BITWISE_AND' => -98,
			'OP14_BITWISE_OR_XOR' => -98,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP21_LIST_COMMA' => -98,
			'OP15_LOGICAL_AND' => -98,
			'OP04_MATH_POW' => 179
		}
	},
	{#State 250
		ACTIONS => {
			'OP16_LOGICAL_OR' => -100,
			'OP23_LOGICAL_AND' => -100,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177,
			"}" => -100,
			'OP21_LIST_COMMA' => -100,
			'OP15_LOGICAL_AND' => -100,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP04_MATH_POW' => 179,
			'OP24_LOGICAL_OR_XOR' => -100,
			"]" => -100,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			")" => -100,
			'OP17_LIST_RANGE' => -100,
			'OP11_COMPARE_LT_GT' => 172,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176,
			'OP18_TERNARY' => -100,
			'OP08_MATH_ADD_SUB' => 175,
			";" => -100
		}
	},
	{#State 251
		ACTIONS => {
			";" => -96,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => -96,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => -96,
			")" => -96,
			'OP11_COMPARE_LT_GT' => undef,
			'OP24_LOGICAL_OR_XOR' => -96,
			"]" => -96,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -96,
			'OP15_LOGICAL_AND' => -96,
			'OP12_COMPARE_EQ_NE' => -96,
			'OP14_BITWISE_OR_XOR' => -96,
			'OP13_BITWISE_AND' => -96,
			'OP23_LOGICAL_AND' => -96,
			'OP16_LOGICAL_OR' => -96,
			"}" => -96,
			'OP07_STRING_REPEAT' => 177
		}
	},
	{#State 252
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP21_LIST_COMMA' => -102,
			'OP15_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 179,
			"}" => -102,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 170,
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => -102,
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			";" => -102,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => -102,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"]" => -102,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => 172,
			'OP17_LIST_RANGE' => undef,
			")" => -102
		}
	},
	{#State 253
		ACTIONS => {
			"}" => -106,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 170,
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => 169,
			'OP04_MATH_POW' => 179,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP21_LIST_COMMA' => -106,
			'OP15_LOGICAL_AND' => 171,
			'OP11_COMPARE_LT_GT' => 172,
			'OP17_LIST_RANGE' => 173,
			")" => -106,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"]" => -106,
			'OP24_LOGICAL_OR_XOR' => -106,
			";" => -106,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => 166,
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167
		}
	},
	{#State 254
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -91,
			'OP15_LOGICAL_AND' => -91,
			'OP14_BITWISE_OR_XOR' => -91,
			'OP12_COMPARE_EQ_NE' => -91,
			'OP16_LOGICAL_OR' => -91,
			'OP23_LOGICAL_AND' => -91,
			'OP13_BITWISE_AND' => -91,
			'OP07_STRING_REPEAT' => 177,
			"}" => -91,
			'OP18_TERNARY' => -91,
			'OP08_MATH_ADD_SUB' => -91,
			";" => -91,
			'OP08_STRING_CAT' => -91,
			'OP09_BITWISE_SHIFT' => -91,
			'OP06_REGEX_MATCH' => 176,
			")" => -91,
			'OP17_LIST_RANGE' => -91,
			'OP11_COMPARE_LT_GT' => -91,
			'OP24_LOGICAL_OR_XOR' => -91,
			"]" => -91,
			'OP07_MATH_MULT_DIV_MOD' => 165
		}
	},
	{#State 255
		DEFAULT => -88
	},
	{#State 256
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -89,
			'OP15_LOGICAL_AND' => -89,
			'OP14_BITWISE_OR_XOR' => -89,
			'OP12_COMPARE_EQ_NE' => -89,
			'OP16_LOGICAL_OR' => -89,
			'OP23_LOGICAL_AND' => -89,
			'OP13_BITWISE_AND' => -89,
			'OP07_STRING_REPEAT' => -89,
			"}" => -89,
			'OP18_TERNARY' => -89,
			";" => -89,
			'OP08_MATH_ADD_SUB' => -89,
			'OP08_STRING_CAT' => -89,
			'OP09_BITWISE_SHIFT' => -89,
			'OP06_REGEX_MATCH' => 176,
			")" => -89,
			'OP17_LIST_RANGE' => -89,
			'OP11_COMPARE_LT_GT' => -89,
			'OP24_LOGICAL_OR_XOR' => -89,
			"]" => -89,
			'OP07_MATH_MULT_DIV_MOD' => -89
		}
	},
	{#State 257
		ACTIONS => {
			"}" => -101,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 170,
			'OP16_LOGICAL_OR' => -101,
			'OP23_LOGICAL_AND' => -101,
			'OP04_MATH_POW' => 179,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP15_LOGICAL_AND' => 171,
			'OP21_LIST_COMMA' => -101,
			'OP11_COMPARE_LT_GT' => 172,
			'OP17_LIST_RANGE' => -101,
			")" => -101,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"]" => -101,
			'OP24_LOGICAL_OR_XOR' => -101,
			'OP08_MATH_ADD_SUB' => 175,
			";" => -101,
			'OP18_TERNARY' => -101,
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167
		}
	},
	{#State 258
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => -85,
			'OP08_STRING_CAT' => -85,
			'OP06_REGEX_MATCH' => -85,
			'OP08_MATH_ADD_SUB' => -85,
			";" => -85,
			'OP18_TERNARY' => -85,
			'OP24_LOGICAL_OR_XOR' => -85,
			"]" => -85,
			'OP07_MATH_MULT_DIV_MOD' => -85,
			'OP17_LIST_RANGE' => -85,
			")" => -85,
			'OP11_COMPARE_LT_GT' => -85,
			'OP15_LOGICAL_AND' => -85,
			'OP21_LIST_COMMA' => -85,
			'OP12_COMPARE_EQ_NE' => -85,
			'OP14_BITWISE_OR_XOR' => -85,
			'OP04_MATH_POW' => 179,
			'OP13_BITWISE_AND' => -85,
			'OP16_LOGICAL_OR' => -85,
			'OP23_LOGICAL_AND' => -85,
			"}" => -85,
			'OP07_STRING_REPEAT' => -85
		}
	},
	{#State 259
		ACTIONS => {
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -99,
			'OP15_LOGICAL_AND' => -99,
			'OP14_BITWISE_OR_XOR' => -99,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP23_LOGICAL_AND' => -99,
			'OP16_LOGICAL_OR' => -99,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177,
			"}" => -99,
			'OP18_TERNARY' => -99,
			";" => -99,
			'OP08_MATH_ADD_SUB' => 175,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176,
			")" => -99,
			'OP17_LIST_RANGE' => -99,
			'OP11_COMPARE_LT_GT' => 172,
			'OP24_LOGICAL_OR_XOR' => -99,
			"]" => -99,
			'OP07_MATH_MULT_DIV_MOD' => 165
		}
	},
	{#State 260
		ACTIONS => {
			'OP12_COMPARE_EQ_NE' => undef,
			'OP14_BITWISE_OR_XOR' => -97,
			'OP21_LIST_COMMA' => -97,
			'OP15_LOGICAL_AND' => -97,
			'OP04_MATH_POW' => 179,
			"}" => -97,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => -97,
			'OP23_LOGICAL_AND' => -97,
			'OP16_LOGICAL_OR' => -97,
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			";" => -97,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => -97,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			"]" => -97,
			'OP24_LOGICAL_OR_XOR' => -97,
			'OP11_COMPARE_LT_GT' => 172,
			'OP17_LIST_RANGE' => -97,
			")" => -97
		}
	},
	{#State 261
		DEFAULT => -116
	},
	{#State 262
		ACTIONS => {
			'LBRACE' => 89,
			'MY' => 126,
			'WORD' => 26,
			'LPAREN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 138,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP05_MATH_NEG_LPAREN' => 103
		},
		GOTOS => {
			'ArrayDereference' => 106,
			'TypeInner' => 136,
			'SubExpression' => 137,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'ListElement' => 135,
			'ListElements' => 305,
			'Variable' => 134,
			'HashReference' => 110,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Expression' => 131,
			'Operator' => 83
		}
	},
	{#State 263
		ACTIONS => {
			'FH_REF_SYMBOL' => 306
		}
	},
	{#State 264
		DEFAULT => -87
	},
	{#State 265
		ACTIONS => {
			";" => 307
		}
	},
	{#State 266
		ACTIONS => {
			";" => 308
		}
	},
	{#State 267
		ACTIONS => {
			'TYPE_INTEGER' => 309
		}
	},
	{#State 268
		ACTIONS => {
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'WORD' => 26,
			'LBRACE' => 89,
			'LPAREN' => 94
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 110,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayReference' => 112,
			'Literal' => 113,
			'ArrayDereference' => 106,
			'SubExpression' => 310,
			'WordScoped' => 72,
			'HashDereference' => 98
		}
	},
	{#State 269
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 311
		}
	},
	{#State 270
		ACTIONS => {
			'OP06_REGEX_MATCH' => 176,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => 166,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP11_COMPARE_LT_GT' => 172,
			'OP17_LIST_RANGE' => 173,
			")" => 312,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP15_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 179,
			'OP07_STRING_REPEAT' => 177,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178
		}
	},
	{#State 271
		DEFAULT => -164
	},
	{#State 272
		ACTIONS => {
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'WORD' => 313,
			'LBRACE' => 89,
			'LPAREN' => 94
		},
		GOTOS => {
			'Variable' => 134,
			'Operator' => 83,
			'Expression' => 131,
			'ArrayReference' => 112,
			'Literal' => 113,
			'HashReference' => 110,
			'SubExpression' => 314,
			'ArrayDereference' => 106,
			'WordScoped' => 72,
			'HashDereference' => 98
		}
	},
	{#State 273
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LBRACKET' => 73,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89
		},
		GOTOS => {
			'WordScoped' => 72,
			'HashDereference' => 98,
			'ArrayDereference' => 106,
			'SubExpression' => 315,
			'HashReference' => 110,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Operator' => 83,
			'Variable' => 134
		}
	},
	{#State 274
		DEFAULT => -119
	},
	{#State 275
		ACTIONS => {
			"foreach" => -142,
			'OP01_NAMED_VOID' => 96,
			'LPAREN' => 94,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'LBRACE' => 89,
			'MY' => 90,
			'WORD' => 26,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'WORD_UPPERCASE' => 84,
			"undef" => 81,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"}" => 316,
			'LBRACKET' => 73,
			"\@{" => 71,
			"for" => -142,
			'OP19_LOOP_CONTROL' => 117,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			"if" => 111,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			"while" => -142,
			'OP01_PRINT' => 105,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			'OP01_NAMED' => 99
		},
		GOTOS => {
			'PAREN-35' => 116,
			'Literal' => 113,
			'ArrayReference' => 112,
			'HashReference' => 110,
			'Operation' => 317,
			'VariableModification' => 109,
			'SubExpression' => 95,
			'OPTIONAL-36' => 107,
			'ArrayDereference' => 106,
			'Statement' => 91,
			'Conditional' => 93,
			'VariableDeclaration' => 85,
			'Variable' => 86,
			'Expression' => 82,
			'Operator' => 83,
			'OperatorVoid' => 76,
			'LoopLabel' => 77,
			'HashDereference' => 98,
			'WordScoped' => 72
		}
	},
	{#State 276
		ACTIONS => {
			'VARIABLE_SYMBOL' => 318
		}
	},
	{#State 277
		DEFAULT => -41
	},
	{#State 278
		ACTIONS => {
			'WORD_UPPERCASE' => 319
		}
	},
	{#State 279
		DEFAULT => -58,
		GOTOS => {
			'STAR-23' => 320
		}
	},
	{#State 280
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 321
		}
	},
	{#State 281
		DEFAULT => -55
	},
	{#State 282
		ACTIONS => {
			'WORD' => 322
		}
	},
	{#State 283
		DEFAULT => -189
	},
	{#State 284
		DEFAULT => -125
	},
	{#State 285
		ACTIONS => {
			'OP01_QW' => 138,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'LPAREN' => 94,
			'MY' => 126,
			'LBRACE' => 89,
			'WORD' => 26,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71
		},
		GOTOS => {
			'ArrayDereference' => 106,
			'TypeInner' => 136,
			'SubExpression' => 137,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'ListElement' => 323,
			'Variable' => 134,
			'HashReference' => 110,
			'Expression' => 131,
			'Operator' => 83,
			'Literal' => 113,
			'ArrayReference' => 112
		}
	},
	{#State 286
		DEFAULT => -175
	},
	{#State 287
		DEFAULT => -182
	},
	{#State 288
		DEFAULT => -178
	},
	{#State 289
		DEFAULT => -204
	},
	{#State 290
		DEFAULT => -173
	},
	{#State 291
		ACTIONS => {
			")" => 324
		}
	},
	{#State 292
		DEFAULT => -122
	},
	{#State 293
		DEFAULT => -172
	},
	{#State 294
		DEFAULT => -115
	},
	{#State 295
		DEFAULT => -190
	},
	{#State 296
		ACTIONS => {
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'WORD' => 26,
			'LBRACE' => 89,
			'LPAREN' => 94
		},
		GOTOS => {
			'ArrayDereference' => 106,
			'SubExpression' => 325,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'Variable' => 134,
			'HashReference' => 110,
			'Operator' => 83,
			'Expression' => 131,
			'Literal' => 113,
			'ArrayReference' => 112
		}
	},
	{#State 297
		DEFAULT => -197
	},
	{#State 298
		ACTIONS => {
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'VARIABLE_SYMBOL' => 115,
			'WORD' => 158,
			"%{" => 79
		},
		GOTOS => {
			'HashDereference' => 157,
			'VariableOrLiteralOrWord' => 155,
			'Literal' => 154,
			'HashEntry' => 326,
			'Variable' => 160
		}
	},
	{#State 299
		DEFAULT => -199
	},
	{#State 300
		DEFAULT => -170
	},
	{#State 301
		ACTIONS => {
			'WORD' => 26,
			'LBRACE' => 89,
			'LPAREN' => 94,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'STDIN' => 233,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103
		},
		GOTOS => {
			'Variable' => 134,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Operator' => 83,
			'HashReference' => 110,
			'SubExpression' => 232,
			'ArrayDereference' => 106,
			'SubExpressionOrStdin' => 327,
			'HashDereference' => 98,
			'WordScoped' => 72
		}
	},
	{#State 302
		ACTIONS => {
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'OP01_QW' => 138,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'LPAREN' => 94,
			'WORD' => 26,
			'MY' => 126,
			'LBRACE' => 89
		},
		GOTOS => {
			'Operator' => 83,
			'Expression' => 131,
			'Literal' => 113,
			'ArrayReference' => 112,
			'HashReference' => 110,
			'Variable' => 134,
			'ListElements' => 328,
			'ListElement' => 135,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'TypeInner' => 136,
			'SubExpression' => 137,
			'ArrayDereference' => 106
		}
	},
	{#State 303
		ACTIONS => {
			")" => 329
		}
	},
	{#State 304
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75
		},
		GOTOS => {
			'Variable' => 245,
			'VariableOrLiteral' => 330,
			'Literal' => 244
		}
	},
	{#State 305
		ACTIONS => {
			";" => 331
		}
	},
	{#State 306
		ACTIONS => {
			'OP21_LIST_COMMA' => 332
		}
	},
	{#State 307
		DEFAULT => -112
	},
	{#State 308
		DEFAULT => -113
	},
	{#State 309
		ACTIONS => {
			'VARIABLE_SYMBOL' => 333
		}
	},
	{#State 310
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 179,
			'OP07_STRING_REPEAT' => 177,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178,
			'OP13_BITWISE_AND' => 170,
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP11_COMPARE_LT_GT' => 172,
			")" => 334,
			'OP17_LIST_RANGE' => 173
		}
	},
	{#State 311
		ACTIONS => {
			'VARIABLE_SYMBOL' => 335
		}
	},
	{#State 312
		ACTIONS => {
			'LBRACE' => 336
		},
		GOTOS => {
			'CodeBlock' => 337
		}
	},
	{#State 313
		ACTIONS => {
			"}" => 338,
			'OP02_METHOD_THINARROW_NEW' => -205,
			'LPAREN' => -205
		}
	},
	{#State 314
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 172,
			'OP17_LIST_RANGE' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_STRING_REPEAT' => 177,
			"}" => 339,
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => 169,
			'OP13_BITWISE_AND' => 170,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 171
		}
	},
	{#State 315
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 174,
			"]" => 340,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP06_REGEX_MATCH' => 176,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => 166,
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP15_LOGICAL_AND' => 171,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP04_MATH_POW' => 179
		}
	},
	{#State 316
		ACTIONS => {
			";" => 341
		}
	},
	{#State 317
		DEFAULT => -44
	},
	{#State 318
		DEFAULT => -49,
		GOTOS => {
			'STAR-19' => 342
		}
	},
	{#State 319
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 343
		}
	},
	{#State 320
		ACTIONS => {
			'LITERAL_NUMBER' => 348,
			"our" => 344
		},
		GOTOS => {
			'Subroutine' => 347,
			'Method' => 346,
			'MethodOrSubroutine' => 345
		}
	},
	{#State 321
		ACTIONS => {
			'LBRACE' => 349
		}
	},
	{#State 322
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 350
		}
	},
	{#State 323
		DEFAULT => -174
	},
	{#State 324
		DEFAULT => -127
	},
	{#State 325
		ACTIONS => {
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176,
			'OP16_LOGICAL_OR' => 178,
			'OP23_LOGICAL_AND' => 169,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177,
			"}" => -192,
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -192,
			'OP15_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181
		}
	},
	{#State 326
		DEFAULT => -196
	},
	{#State 327
		ACTIONS => {
			";" => 351
		}
	},
	{#State 328
		ACTIONS => {
			")" => 352
		}
	},
	{#State 329
		DEFAULT => -78
	},
	{#State 330
		DEFAULT => -103
	},
	{#State 331
		DEFAULT => -117
	},
	{#State 332
		ACTIONS => {
			'LITERAL_STRING' => 353
		}
	},
	{#State 333
		ACTIONS => {
			'LPAREN' => 354
		}
	},
	{#State 334
		ACTIONS => {
			'LBRACE' => 336
		},
		GOTOS => {
			'CodeBlock' => 355
		}
	},
	{#State 335
		ACTIONS => {
			'LPAREN' => 356
		}
	},
	{#State 336
		ACTIONS => {
			'OP01_NAMED' => 99,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_PRINT' => 105,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			"while" => -142,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			"if" => 111,
			"for" => -142,
			'OP19_LOOP_CONTROL' => 117,
			'LBRACKET' => 73,
			"\@{" => 71,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			"undef" => 81,
			'WORD_UPPERCASE' => 84,
			'WORD' => 26,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'MY' => 90,
			'LBRACE' => 89,
			'LPAREN' => 94,
			'OP01_NAMED_VOID' => 96,
			"foreach" => -142
		},
		GOTOS => {
			'Statement' => 91,
			'Conditional' => 93,
			'SubExpression' => 95,
			'OPTIONAL-36' => 107,
			'ArrayDereference' => 106,
			'Literal' => 113,
			'ArrayReference' => 112,
			'HashReference' => 110,
			'Operation' => 358,
			'VariableModification' => 109,
			'PAREN-35' => 116,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'PLUS-41' => 357,
			'LoopLabel' => 77,
			'OperatorVoid' => 76,
			'Expression' => 82,
			'Operator' => 83,
			'VariableDeclaration' => 85,
			'Variable' => 86
		}
	},
	{#State 337
		DEFAULT => -150,
		GOTOS => {
			'STAR-38' => 359
		}
	},
	{#State 338
		DEFAULT => -169
	},
	{#State 339
		DEFAULT => -168
	},
	{#State 340
		DEFAULT => -167
	},
	{#State 341
		DEFAULT => -46
	},
	{#State 342
		ACTIONS => {
			'OP21_LIST_COMMA' => 360,
			")" => 362
		},
		GOTOS => {
			'PAREN-18' => 361
		}
	},
	{#State 343
		DEFAULT => -211
	},
	{#State 344
		ACTIONS => {
			'WORD' => 56,
			'TYPE_METHOD' => 363,
			'TYPE_INTEGER' => 55
		},
		GOTOS => {
			'Type' => 57
		}
	},
	{#State 345
		DEFAULT => -57
	},
	{#State 346
		DEFAULT => -74
	},
	{#State 347
		DEFAULT => -75
	},
	{#State 348
		ACTIONS => {
			";" => 364
		}
	},
	{#State 349
		ACTIONS => {
			"%{" => 79,
			"}" => 367,
			'WORD' => 365
		},
		GOTOS => {
			'HashEntryTyped' => 366,
			'HashDereference' => 368
		}
	},
	{#State 350
		DEFAULT => -210
	},
	{#State 351
		DEFAULT => -171
	},
	{#State 352
		DEFAULT => -80
	},
	{#State 353
		ACTIONS => {
			'OP21_LIST_COMMA' => 369
		}
	},
	{#State 354
		ACTIONS => {
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73
		},
		GOTOS => {
			'ArrayDereference' => 106,
			'SubExpression' => 370,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'Variable' => 134,
			'HashReference' => 110,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayReference' => 112,
			'Literal' => 113
		}
	},
	{#State 355
		DEFAULT => -160
	},
	{#State 356
		ACTIONS => {
			'LBRACE' => 89,
			'MY' => 126,
			'WORD' => 26,
			'LPAREN' => 94,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP01_QW' => 138,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102
		},
		GOTOS => {
			'ListElement' => 135,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'TypeInner' => 136,
			'SubExpression' => 137,
			'ArrayDereference' => 106,
			'Literal' => 113,
			'ArrayReference' => 112,
			'Expression' => 131,
			'Operator' => 83,
			'HashReference' => 110,
			'Variable' => 134,
			'ListElements' => 371
		}
	},
	{#State 357
		ACTIONS => {
			'OP01_NAMED' => 99,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_PRINT' => 105,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			"while" => -142,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			"if" => 111,
			"for" => -142,
			'OP19_LOOP_CONTROL' => 117,
			"}" => 372,
			'LBRACKET' => 73,
			"\@{" => 71,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			"undef" => 81,
			'WORD_UPPERCASE' => 84,
			'WORD' => 26,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'MY' => 90,
			'LBRACE' => 89,
			'LPAREN' => 94,
			'OP01_NAMED_VOID' => 96,
			"foreach" => -142
		},
		GOTOS => {
			'OPTIONAL-36' => 107,
			'SubExpression' => 95,
			'ArrayDereference' => 106,
			'Statement' => 91,
			'Conditional' => 93,
			'PAREN-35' => 116,
			'Literal' => 113,
			'ArrayReference' => 112,
			'HashReference' => 110,
			'VariableModification' => 109,
			'Operation' => 373,
			'LoopLabel' => 77,
			'OperatorVoid' => 76,
			'HashDereference' => 98,
			'WordScoped' => 72,
			'VariableDeclaration' => 85,
			'Variable' => 86,
			'Operator' => 83,
			'Expression' => 82
		}
	},
	{#State 358
		DEFAULT => -162
	},
	{#State 359
		ACTIONS => {
			"%{" => -153,
			'OP05_LOGICAL_NEG' => -153,
			'LBRACKET' => -153,
			"}" => -153,
			"\@{" => -153,
			'LITERAL_STRING' => -153,
			'LITERAL_NUMBER' => -153,
			'WORD_UPPERCASE' => -153,
			"undef" => -153,
			'LPAREN' => -153,
			'OP01_NAMED_VOID' => -153,
			'WORD' => -153,
			'OP01_NAMED_VOID_LPAREN' => -153,
			'OP19_LOOP_CONTROL_SCOLON' => -153,
			'OP01_NAMED_VOID_SCOLON' => -153,
			'MY' => -153,
			'LBRACE' => -153,
			"foreach" => -153,
			"elsif" => 378,
			'OP01_NAMED' => -153,
			'OP05_MATH_NEG_LPAREN' => -153,
			'OP22_LOGICAL_NEG' => -153,
			"else" => 375,
			'OP01_CLOSE' => -153,
			'OP01_OPEN' => -153,
			'OP01_PRINT' => -153,
			'' => -153,
			"for" => -153,
			'OP19_LOOP_CONTROL' => -153,
			'WORD_SCOPED' => -153,
			'OP03_MATH_INC_DEC' => -153,
			"while" => -153,
			'OP10_NAMED_UNARY' => -153,
			'VARIABLE_SYMBOL' => -153,
			"if" => -153
		},
		GOTOS => {
			'PAREN-39' => 374,
			'OPTIONAL-40' => 376,
			'PAREN-37' => 377
		}
	},
	{#State 360
		ACTIONS => {
			'MY' => 379
		}
	},
	{#State 361
		DEFAULT => -48
	},
	{#State 362
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 380
		}
	},
	{#State 363
		ACTIONS => {
			'VARIABLE_SYMBOL' => 381
		}
	},
	{#State 364
		DEFAULT => -59
	},
	{#State 365
		ACTIONS => {
			'OP20_HASH_FATARROW' => 382
		}
	},
	{#State 366
		DEFAULT => -62,
		GOTOS => {
			'STAR-25' => 383
		}
	},
	{#State 367
		ACTIONS => {
			";" => 384
		}
	},
	{#State 368
		DEFAULT => -195
	},
	{#State 369
		ACTIONS => {
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP01_CLOSE' => 100
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 110,
			'Operator' => 83,
			'Expression' => 131,
			'ArrayReference' => 112,
			'Literal' => 113,
			'ArrayDereference' => 106,
			'SubExpression' => 385,
			'WordScoped' => 72,
			'HashDereference' => 98
		}
	},
	{#State 370
		ACTIONS => {
			'OP13_BITWISE_AND' => 170,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178,
			'OP07_STRING_REPEAT' => 177,
			'OP04_MATH_POW' => 179,
			'OP15_LOGICAL_AND' => 171,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP17_LIST_RANGE' => 386,
			'OP11_COMPARE_LT_GT' => 172,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP08_MATH_ADD_SUB' => 175,
			'OP18_TERNARY' => 166,
			'OP09_BITWISE_SHIFT' => 168,
			'OP08_STRING_CAT' => 167,
			'OP06_REGEX_MATCH' => 176
		}
	},
	{#State 371
		ACTIONS => {
			")" => 387
		}
	},
	{#State 372
		DEFAULT => -163
	},
	{#State 373
		DEFAULT => -161
	},
	{#State 374
		DEFAULT => -152
	},
	{#State 375
		ACTIONS => {
			'LBRACE' => 336
		},
		GOTOS => {
			'CodeBlock' => 388
		}
	},
	{#State 376
		DEFAULT => -154
	},
	{#State 377
		DEFAULT => -149
	},
	{#State 378
		ACTIONS => {
			'LPAREN' => 389
		}
	},
	{#State 379
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 390
		}
	},
	{#State 380
		ACTIONS => {
			"\@_;" => 391
		}
	},
	{#State 381
		ACTIONS => {
			"= sub {" => 392
		}
	},
	{#State 382
		ACTIONS => {
			'MY' => 126
		},
		GOTOS => {
			'TypeInner' => 393
		}
	},
	{#State 383
		ACTIONS => {
			'OP21_LIST_COMMA' => 395,
			"}" => 394
		},
		GOTOS => {
			'PAREN-24' => 396
		}
	},
	{#State 384
		DEFAULT => -64
	},
	{#State 385
		ACTIONS => {
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176,
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			";" => -81,
			'OP24_LOGICAL_OR_XOR' => -81,
			"]" => -81,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			")" => -81,
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP15_LOGICAL_AND' => 171,
			'OP21_LIST_COMMA' => -81,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP04_MATH_POW' => 179,
			'OP23_LOGICAL_AND' => -81,
			'OP16_LOGICAL_OR' => 178,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177,
			"}" => -81
		}
	},
	{#State 386
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP01_CLOSE' => 100,
			'OP01_OPEN' => 101,
			"undef" => 81,
			'OP05_LOGICAL_NEG' => 78,
			"%{" => 79,
			"\@{" => 71,
			'OP01_NAMED' => 139,
			'LBRACKET' => 73,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 110,
			'ArrayReference' => 112,
			'Literal' => 113,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayDereference' => 106,
			'SubExpression' => 397,
			'HashDereference' => 98,
			'WordScoped' => 72
		}
	},
	{#State 387
		ACTIONS => {
			'LBRACE' => 336
		},
		GOTOS => {
			'CodeBlock' => 398
		}
	},
	{#State 388
		DEFAULT => -151
	},
	{#State 389
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 103,
			'WORD_UPPERCASE' => 132,
			'OP22_LOGICAL_NEG' => 102,
			"undef" => 81,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			'OP03_MATH_INC_DEC' => 108,
			'WORD_SCOPED' => 24,
			'LPAREN' => 94,
			'LBRACE' => 89,
			'WORD' => 26
		},
		GOTOS => {
			'Variable' => 134,
			'HashReference' => 110,
			'Expression' => 131,
			'Operator' => 83,
			'ArrayReference' => 112,
			'Literal' => 113,
			'ArrayDereference' => 106,
			'SubExpression' => 399,
			'WordScoped' => 72,
			'HashDereference' => 98
		}
	},
	{#State 390
		ACTIONS => {
			'VARIABLE_SYMBOL' => 400
		}
	},
	{#State 391
		DEFAULT => -50
	},
	{#State 392
		ACTIONS => {
			"foreach" => -66,
			'OP01_NAMED_VOID_SCOLON' => -66,
			'LBRACE' => -66,
			'MY' => -66,
			'WORD' => -66,
			'OP19_LOOP_CONTROL_SCOLON' => -66,
			'OP01_NAMED_VOID_LPAREN' => -66,
			'OP01_NAMED_VOID' => -66,
			'LPAREN' => -66,
			"undef" => -66,
			'WORD_UPPERCASE' => -66,
			'LITERAL_STRING' => -66,
			'LITERAL_NUMBER' => -66,
			"}" => -66,
			'LBRACKET' => -66,
			"\@{" => -66,
			"%{" => -66,
			'OP05_LOGICAL_NEG' => -66,
			'OP10_NAMED_UNARY' => -66,
			'VARIABLE_SYMBOL' => -66,
			"if" => -66,
			'OP03_MATH_INC_DEC' => -66,
			'WORD_SCOPED' => -66,
			"while" => -66,
			"for" => -66,
			'OP19_LOOP_CONTROL' => -66,
			'LPAREN_MY' => 401,
			'OP01_PRINT' => -66,
			'OP01_OPEN' => -66,
			'OP01_CLOSE' => -66,
			'OP05_MATH_NEG_LPAREN' => -66,
			'OP22_LOGICAL_NEG' => -66,
			'OP01_NAMED' => -66
		},
		GOTOS => {
			'MethodArguments' => 402,
			'OPTIONAL-26' => 403
		}
	},
	{#State 393
		ACTIONS => {
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'WORD_UPPERCASE' => 132,
			'OP01_CLOSE' => 100,
			"undef" => 81,
			'OP01_OPEN' => 101,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			'LBRACKET' => 73,
			'OP01_NAMED' => 139,
			"\@{" => 71,
			'LITERAL_STRING' => 74,
			'LITERAL_NUMBER' => 75,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			'VARIABLE_SYMBOL' => 115,
			'OP10_NAMED_UNARY' => 114,
			'LPAREN' => 94,
			'WORD' => 26,
			'LBRACE' => 89
		},
		GOTOS => {
			'Literal' => 113,
			'ArrayReference' => 112,
			'Operator' => 83,
			'Expression' => 131,
			'HashReference' => 110,
			'Variable' => 134,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'SubExpression' => 404,
			'ArrayDereference' => 106
		}
	},
	{#State 394
		ACTIONS => {
			";" => 405
		}
	},
	{#State 395
		ACTIONS => {
			'WORD' => 365,
			"%{" => 79
		},
		GOTOS => {
			'HashEntryTyped' => 406,
			'HashDereference' => 368
		}
	},
	{#State 396
		DEFAULT => -61
	},
	{#State 397
		ACTIONS => {
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP18_TERNARY' => -102,
			'OP08_MATH_ADD_SUB' => 175,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => -102,
			'OP11_COMPARE_LT_GT' => 172,
			")" => 407,
			'OP17_LIST_RANGE' => undef,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 171,
			'OP04_MATH_POW' => 179,
			'OP07_STRING_REPEAT' => 177,
			'OP23_LOGICAL_AND' => -102,
			'OP16_LOGICAL_OR' => 178,
			'OP13_BITWISE_AND' => 170
		}
	},
	{#State 398
		DEFAULT => -159
	},
	{#State 399
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 172,
			")" => 408,
			'OP17_LIST_RANGE' => 173,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			'OP06_REGEX_MATCH' => 176,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP07_STRING_REPEAT' => 177,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178,
			'OP13_BITWISE_AND' => 170,
			'OP04_MATH_POW' => 179,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP15_LOGICAL_AND' => 171
		}
	},
	{#State 400
		DEFAULT => -47
	},
	{#State 401
		ACTIONS => {
			'TYPE_SELF' => 409
		}
	},
	{#State 402
		DEFAULT => -65
	},
	{#State 403
		DEFAULT => -68,
		GOTOS => {
			'STAR-27' => 410
		}
	},
	{#State 404
		ACTIONS => {
			'OP18_TERNARY' => 166,
			'OP08_MATH_ADD_SUB' => 175,
			'OP08_STRING_CAT' => 167,
			'OP09_BITWISE_SHIFT' => 168,
			'OP06_REGEX_MATCH' => 176,
			'OP17_LIST_RANGE' => 173,
			'OP11_COMPARE_LT_GT' => 172,
			'OP24_LOGICAL_OR_XOR' => 174,
			'OP07_MATH_MULT_DIV_MOD' => 165,
			'OP04_MATH_POW' => 179,
			'OP21_LIST_COMMA' => -194,
			'OP15_LOGICAL_AND' => 171,
			'OP14_BITWISE_OR_XOR' => 180,
			'OP12_COMPARE_EQ_NE' => 181,
			'OP23_LOGICAL_AND' => 169,
			'OP16_LOGICAL_OR' => 178,
			'OP13_BITWISE_AND' => 170,
			'OP07_STRING_REPEAT' => 177,
			"}" => -194
		}
	},
	{#State 405
		DEFAULT => -63
	},
	{#State 406
		DEFAULT => -60
	},
	{#State 407
		ACTIONS => {
			'LBRACE' => 336
		},
		GOTOS => {
			'CodeBlock' => 411
		}
	},
	{#State 408
		ACTIONS => {
			'LBRACE' => 336
		},
		GOTOS => {
			'CodeBlock' => 412
		}
	},
	{#State 409
		DEFAULT => -72,
		GOTOS => {
			'STAR-29' => 413
		}
	},
	{#State 410
		ACTIONS => {
			'OP01_NAMED' => 99,
			'OP01_OPEN' => 101,
			'OP01_CLOSE' => 100,
			'OP05_MATH_NEG_LPAREN' => 103,
			'OP22_LOGICAL_NEG' => 102,
			'OP01_PRINT' => 105,
			'OP10_NAMED_UNARY' => 114,
			'VARIABLE_SYMBOL' => 115,
			"if" => 111,
			'WORD_SCOPED' => 24,
			'OP03_MATH_INC_DEC' => 108,
			"while" => -142,
			"for" => -142,
			'OP19_LOOP_CONTROL' => 117,
			'LITERAL_NUMBER' => 75,
			'LITERAL_STRING' => 74,
			'LBRACKET' => 73,
			"}" => 414,
			"\@{" => 71,
			"%{" => 79,
			'OP05_LOGICAL_NEG' => 78,
			"undef" => 81,
			'WORD_UPPERCASE' => 84,
			'OP01_NAMED_VOID_SCOLON' => 92,
			'LBRACE' => 89,
			'MY' => 90,
			'WORD' => 26,
			'OP19_LOOP_CONTROL_SCOLON' => 87,
			'OP01_NAMED_VOID_LPAREN' => 88,
			'OP01_NAMED_VOID' => 96,
			'LPAREN' => 94,
			"foreach" => -142
		},
		GOTOS => {
			'LoopLabel' => 77,
			'OperatorVoid' => 76,
			'WordScoped' => 72,
			'HashDereference' => 98,
			'VariableDeclaration' => 85,
			'Variable' => 86,
			'Expression' => 82,
			'Operator' => 83,
			'OPTIONAL-36' => 107,
			'SubExpression' => 95,
			'ArrayDereference' => 106,
			'Statement' => 91,
			'Conditional' => 93,
			'PAREN-35' => 116,
			'Literal' => 113,
			'ArrayReference' => 112,
			'VariableModification' => 109,
			'HashReference' => 110,
			'Operation' => 415
		}
	},
	{#State 411
		DEFAULT => -158
	},
	{#State 412
		DEFAULT => -148
	},
	{#State 413
		ACTIONS => {
			'OP21_LIST_COMMA' => 416,
			")" => 417
		},
		GOTOS => {
			'PAREN-28' => 418
		}
	},
	{#State 414
		ACTIONS => {
			";" => 419
		}
	},
	{#State 415
		DEFAULT => -67
	},
	{#State 416
		ACTIONS => {
			'MY' => 420
		}
	},
	{#State 417
		ACTIONS => {
			'OP19_VARIABLE_ASSIGN' => 421
		}
	},
	{#State 418
		DEFAULT => -71
	},
	{#State 419
		DEFAULT => -69
	},
	{#State 420
		ACTIONS => {
			'TYPE_INTEGER' => 55,
			'WORD' => 56
		},
		GOTOS => {
			'Type' => 422
		}
	},
	{#State 421
		ACTIONS => {
			"\@_;" => 423
		}
	},
	{#State 422
		ACTIONS => {
			'VARIABLE_SYMBOL' => 424
		}
	},
	{#State 423
		DEFAULT => -73
	},
	{#State 424
		DEFAULT => -70
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 5824 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-1', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 5831 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 2,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5838 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-2', 1,
sub {
#line 138 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5845 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5856 lib/RPerl/Grammar.pm
	],
	[#Rule CompileUnit_5
		 'CompileUnit', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5867 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5874 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-3', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5881 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5888 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-4', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5895 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5902 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5909 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5916 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5923 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5930 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-7', 0,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5937 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 2,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5944 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-8', 1,
sub {
#line 139 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5951 lib/RPerl/Grammar.pm
	],
	[#Rule Program_18
		 'Program', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5962 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 1,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 5969 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-9', 0,
sub {
#line 140 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5976 lib/RPerl/Grammar.pm
	],
	[#Rule ModuleHeader_21
		 'ModuleHeader', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5987 lib/RPerl/Grammar.pm
	],
	[#Rule Module_22
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 5998 lib/RPerl/Grammar.pm
	],
	[#Rule Module_23
		 'Module', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6009 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6016 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-10', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6023 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6030 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6037 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6044 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-12', 0,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6051 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6058 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 142 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6065 lib/RPerl/Grammar.pm
	],
	[#Rule Package_32
		 'Package', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6076 lib/RPerl/Grammar.pm
	],
	[#Rule Header_33
		 'Header', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6087 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 2,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6094 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-14', 1,
sub {
#line 144 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6101 lib/RPerl/Grammar.pm
	],
	[#Rule Critic_36
		 'Critic', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6112 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 2,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6119 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-15', 1,
sub {
#line 145 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6126 lib/RPerl/Grammar.pm
	],
	[#Rule Include_39
		 'Include', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6137 lib/RPerl/Grammar.pm
	],
	[#Rule Include_40
		 'Include', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6148 lib/RPerl/Grammar.pm
	],
	[#Rule Constant_41
		 'Constant', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6159 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6166 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6173 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 2,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6180 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-17', 0,
sub {
#line 150 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6187 lib/RPerl/Grammar.pm
	],
	[#Rule Subroutine_46
		 'Subroutine', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6198 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-18', 4,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6205 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 2,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6212 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-19', 0,
sub {
#line 151 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6219 lib/RPerl/Grammar.pm
	],
	[#Rule SubroutineArguments_50
		 'SubroutineArguments', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6230 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6237 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-20', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6244 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6251 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-21', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6258 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6265 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-22', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6272 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 2,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6279 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-23', 0,
sub {
#line 152 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6286 lib/RPerl/Grammar.pm
	],
	[#Rule Class_59
		 'Class', 12,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6297 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6304 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6311 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 153 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6318 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_63
		 'Properties', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6329 lib/RPerl/Grammar.pm
	],
	[#Rule Properties_64
		 'Properties', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6340 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 1,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6347 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-26', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6354 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 2,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6361 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-27', 0,
sub {
#line 155 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6368 lib/RPerl/Grammar.pm
	],
	[#Rule Method_69
		 'Method', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6379 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-28', 4,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6386 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 6393 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 156 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6400 lib/RPerl/Grammar.pm
	],
	[#Rule MethodArguments_73
		 'MethodArguments', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6411 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_74
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6422 lib/RPerl/Grammar.pm
	],
	[#Rule MethodOrSubroutine_75
		 'MethodOrSubroutine', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6433 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_76
		 'Operation', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6444 lib/RPerl/Grammar.pm
	],
	[#Rule Operation_77
		 'Operation', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6455 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_78
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6466 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_79
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6477 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_80
		 'Operator', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6488 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_81
		 'Operator', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6499 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_82
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6510 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_83
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6521 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_84
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6532 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_85
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6543 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_86
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6554 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_87
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6565 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_88
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6576 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_89
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6587 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_90
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6598 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_91
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6609 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_92
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6620 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_93
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6631 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_94
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6642 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_95
		 'Operator', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6653 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_96
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6664 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_97
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6675 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_98
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6686 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_99
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6697 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_100
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6708 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_101
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6719 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_102
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6730 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_103
		 'Operator', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6741 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_104
		 'Operator', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6752 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_105
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6763 lib/RPerl/Grammar.pm
	],
	[#Rule Operator_106
		 'Operator', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6774 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 6781 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 1,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6788 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-31', 0,
sub {
#line 172 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6795 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 1,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6802 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-32', 0,
sub {
#line 173 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6809 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_112
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6820 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_113
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6831 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_114
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6842 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_115
		 'OperatorVoid', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6853 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_116
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6864 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_117
		 'OperatorVoid', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6875 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_118
		 'OperatorVoid', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6886 lib/RPerl/Grammar.pm
	],
	[#Rule OperatorVoid_119
		 'OperatorVoid', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6897 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6904 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-33', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6911 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 1,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 6918 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-34', 0,
sub {
#line 175 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 6925 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_124
		 'Expression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6936 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_125
		 'Expression', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6947 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_126
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6958 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_127
		 'Expression', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6969 lib/RPerl/Grammar.pm
	],
	[#Rule Expression_128
		 'Expression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6980 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_129
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 6991 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_130
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7002 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_131
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7013 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_132
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7024 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_133
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7035 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_134
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7046 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_135
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7057 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_136
		 'SubExpression', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7068 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpression_137
		 'SubExpression', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7079 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_138
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7090 lib/RPerl/Grammar.pm
	],
	[#Rule SubExpressionOrStdin_139
		 'SubExpressionOrStdin', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7101 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-35', 2,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7108 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 1,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7115 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-36', 0,
sub {
#line 179 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7122 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_143
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7133 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_144
		 'Statement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7144 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_145
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7155 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_146
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7166 lib/RPerl/Grammar.pm
	],
	[#Rule Statement_147
		 'Statement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7177 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 5,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7184 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7191 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-38', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7198 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-39', 2,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7205 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7212 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 180 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7219 lib/RPerl/Grammar.pm
	],
	[#Rule Conditional_154
		 'Conditional', 7,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7230 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_155
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7241 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_156
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7252 lib/RPerl/Grammar.pm
	],
	[#Rule Loop_157
		 'Loop', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7263 lib/RPerl/Grammar.pm
	],
	[#Rule LoopFor_158
		 'LoopFor', 10,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7274 lib/RPerl/Grammar.pm
	],
	[#Rule LoopForEach_159
		 'LoopForEach', 8,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7285 lib/RPerl/Grammar.pm
	],
	[#Rule LoopWhile_160
		 'LoopWhile', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7296 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 2,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7303 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 1,
sub {
#line 185 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7310 lib/RPerl/Grammar.pm
	],
	[#Rule CodeBlock_163
		 'CodeBlock', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7321 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 2,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7328 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-42', 0,
sub {
#line 187 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7335 lib/RPerl/Grammar.pm
	],
	[#Rule Variable_166
		 'Variable', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7346 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_167
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7357 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_168
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7368 lib/RPerl/Grammar.pm
	],
	[#Rule VariableRetrieval_169
		 'VariableRetrieval', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7379 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_170
		 'VariableDeclaration', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7390 lib/RPerl/Grammar.pm
	],
	[#Rule VariableDeclaration_171
		 'VariableDeclaration', 6,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7401 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_172
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7412 lib/RPerl/Grammar.pm
	],
	[#Rule VariableModification_173
		 'VariableModification', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7423 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-43', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7430 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 2,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7437 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-44', 0,
sub {
#line 191 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7444 lib/RPerl/Grammar.pm
	],
	[#Rule ListElements_177
		 'ListElements', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7455 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 2,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7462 lib/RPerl/Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-45', 1,
sub {
#line 192 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7469 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_180
		 'ListElement', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7480 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_181
		 'ListElement', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7491 lib/RPerl/Grammar.pm
	],
	[#Rule ListElement_182
		 'ListElement', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7502 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 1,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7509 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-46', 0,
sub {
#line 193 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7516 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayReference_185
		 'ArrayReference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7527 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 1,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7534 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-47', 0,
sub {
#line 194 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7541 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_188
		 'ArrayDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7552 lib/RPerl/Grammar.pm
	],
	[#Rule ArrayDereference_189
		 'ArrayDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7563 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 1,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7570 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-48', 0,
sub {
#line 195 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7577 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_192
		 'HashEntry', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7588 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntry_193
		 'HashEntry', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7599 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_194
		 'HashEntryTyped', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7610 lib/RPerl/Grammar.pm
	],
	[#Rule HashEntryTyped_195
		 'HashEntryTyped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7621 lib/RPerl/Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-49', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 7628 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 2,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 7635 lib/RPerl/Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-50', 0,
sub {
#line 197 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7642 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_199
		 'HashReference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7653 lib/RPerl/Grammar.pm
	],
	[#Rule HashReference_200
		 'HashReference', 2,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7664 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 1,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 7671 lib/RPerl/Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-51', 0,
sub {
#line 198 "lib/RPerl/Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 7678 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_203
		 'HashDereference', 3,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7689 lib/RPerl/Grammar.pm
	],
	[#Rule HashDereference_204
		 'HashDereference', 4,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7700 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_205
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7711 lib/RPerl/Grammar.pm
	],
	[#Rule WordScoped_206
		 'WordScoped', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7722 lib/RPerl/Grammar.pm
	],
	[#Rule LoopLabel_207
		 'LoopLabel', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7733 lib/RPerl/Grammar.pm
	],
	[#Rule Type_208
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7744 lib/RPerl/Grammar.pm
	],
	[#Rule Type_209
		 'Type', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7755 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInner_210
		 'TypeInner', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7766 lib/RPerl/Grammar.pm
	],
	[#Rule TypeInnerConstant_211
		 'TypeInnerConstant', 5,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7777 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_212
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7788 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteral_213
		 'VariableOrLiteral', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7799 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_214
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7810 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_215
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7821 lib/RPerl/Grammar.pm
	],
	[#Rule VariableOrLiteralOrWord_216
		 'VariableOrLiteralOrWord', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7832 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_217
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7843 lib/RPerl/Grammar.pm
	],
	[#Rule Literal_218
		 'Literal', 1,
sub {
#line 15 "lib/RPerl/Grammar.eyp"

    my $self = shift;
    my $name = $self->YYName();
    bless { children => [ @_ ] }, $name;
}
#line 7854 lib/RPerl/Grammar.pm
	]
],
#line 7857 lib/RPerl/Grammar.pm
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
         'VariableModification_172', 
         'VariableModification_173', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_177', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'ListElement_180', 
         'ListElement_181', 
         'ListElement_182', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayReference_185', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'ArrayDereference_188', 
         'ArrayDereference_189', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashEntry_192', 
         'HashEntry_193', 
         'HashEntryTyped_194', 
         'HashEntryTyped_195', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashReference_199', 
         'HashReference_200', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'HashDereference_203', 
         'HashDereference_204', 
         'WordScoped_205', 
         'WordScoped_206', 
         'LoopLabel_207', 
         'Type_208', 
         'Type_209', 
         'TypeInner_210', 
         'TypeInnerConstant_211', 
         'VariableOrLiteral_212', 
         'VariableOrLiteral_213', 
         'VariableOrLiteralOrWord_214', 
         'VariableOrLiteralOrWord_215', 
         'VariableOrLiteralOrWord_216', 
         'Literal_217', 
         'Literal_218', );
  $self;
}

#line 209 "lib/RPerl/Grammar.eyp"


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
OperatorVoid_113 => 'RPerl::Operation::Statement::OperatorVoid::Print',        # OperatorVoid -> OP01_PRINT FH_REF_SYMBOL_BRACES ListElements ';'
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
VariableModification_172 => 'RPerl::Operation::Statement::VariableModification',
VariableModification_173 => 'RPerl::Operation::Statement::VariableModification',
ListElements_177 => 'RPerl::DataStructure::Array::ListElements',    # ListElements -> ListElement STAR-43
ListElement_180 => 'RPerl::Operation::Expression::SubExpression',   # ListElement -> SubExpression
ListElement_181 => 'RPerl::Operation::Expression::SubExpression',   # ListElement -> TypeInner SubExpression
ListElement_182 => 'RPerl::DataStructure::Array::ListElement',      # ListElement -> OP01_QW PLUS-44 ')'
ArrayReference_185 => 'RPerl::DataStructure::Array::Reference',     # ArrayReference -> LBRACKET OPTIONAL-45 ']'
ArrayDereference_188 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
ArrayDereference_189 => 'RPerl::Operation::Expression::SubExpression::ArrayDereference',
HashEntry_192 => 'RPerl::DataStructure::Hash::Entry',                                   # HashEntry -> VariableOrLiteralOrWord OP20_HASH_FATARROW OPTIONAL-47 SubExpression
HashEntry_193 => 'RPerl::Operation::Expression::SubExpression::HashDereference',        # HashEntry -> HashDereference
HashEntryTyped_194 => 'RPerl::DataStructure::Hash::EntryTyped',                         # HashEntryTyped -> WORD OP20_HASH_FATARROW TypeInner SubExpression
HashEntryTyped_195 => 'RPerl::Operation::Expression::SubExpression::HashDereference',   # HashEntryTyped -> HashDereference
HashReference_199 => 'RPerl::DataStructure::Hash::Reference',
HashReference_200 => 'RPerl::DataStructure::Hash::Reference',
HashDereference_203 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
HashDereference_204 => 'RPerl::Operation::Expression::SubExpression::HashDereference',
WordScoped_205 => 'RPerl::NonGenerator',
WordScoped_206 => 'RPerl::NonGenerator',
LoopLabel_207 => 'RPerl::NonGenerator',
Type_208 => 'RPerl::NonGenerator',                  # Type -> WORD
Type_209 => 'RPerl::NonGenerator',                  # Type -> TYPE_INTEGER
TypeInner_210 => 'RPerl::NonGenerator',             # TypeInner -> MY Type '$TYPED_' WORD OP19_VARIABLE_ASSIGN
TypeInnerConstant_211 => 'RPerl::NonGenerator',     # TypeInnerConstant -> MY Type '$TYPED_' WORD_UPPERCASE OP19_VARIABLE_ASSIGN
VariableOrLiteral_212 => 'RPerl::Operation::Expression::SubExpression::Variable',
VariableOrLiteral_213 => 'RPerl::Operation::Expression::SubExpression::Literal',
VariableOrLiteralOrWord_214 => 'RPerl::Operation::Expression::SubExpression::Variable',  # VariableOrLiteralOrWord -> Variable
VariableOrLiteralOrWord_215 => 'RPerl::Operation::Expression::SubExpression::Literal',   # VariableOrLiteralOrWord -> Literal
VariableOrLiteralOrWord_216 => 'RPerl::NonGenerator',                                    # VariableOrLiteralOrWord -> WORD
Literal_217 => 'RPerl::Operation::Expression::SubExpression::Literal::Number',  # Literal -> LITERAL_NUMBER
Literal_218 => 'RPerl::Operation::Expression::SubExpression::Literal::String'   # Literal -> LITERAL_STRING
};

    1;
}

=for None

=cut


#line 8241 lib/RPerl/Grammar.pm



1;
