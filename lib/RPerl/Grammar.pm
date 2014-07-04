########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'Grammar.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package Grammar;
use strict;

push @Grammar::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }

#line 1 "Grammar.eyp"

#    package RPerl::Grammar; NEED FIX: what package name?
    use strict;
    use warnings;
    our $VERSION = 0.000_200;
    use Carp;
    
    use rperlrules;  # affirmative, it totally does


# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(use\ constant|\%properties|use\ parent|\$VERSION|warnings|foreach|package|integer|strict|elsif|RPerl|while|else|Carp|sub|use|our|qw\(|for|if|my|\%\{|\@\{|\.\.|\)\;|\:|\}|\=|\[|\]|\;|1|\)|\{|\(|\/)}gc and return ($1, $1);

      /\G(^(\#\!\/[\w\/]*\/perl)$)/gc and return ('SHEBANG', $1);
      /\G([a-zA-Z]\w*)/gc and return ('WORD', $1);
      /\G([a-zA-Z][\w(::)]*)/gc and return ('WORD_SCOPED', $1);
      /\G(\d+\.\d{3}\_\d{3})/gc and return ('VERSION_NUMBER', $1);
      /\G((-?\d+(\.\d+)?)|('[^']*'))/gc and return ('LITERAL', $1);
      /\G(\$[a-zA-Z][\w(::)]*)/gc and return ('VARIABLE_SYMBOL', $1);
      /\G([a-z][a-z_]*[a-z])/gc and return ('TYPE', $1);
      /\G([A-Z][A-Z0-9_]*)/gc and return ('LOOP_LABEL', $1);
      /\G(keys|values)/gc and return ('KEYS_OR_VALUES', $1);
      /\G(string\s+\$class|object\s+\$self)/gc and return ('TYPE_CLASS_OR_SELF', $1);
      /\G(\(\s*my)/gc and return ('ARGUMENTS_BEGIN', $1);
      /\G(\)\s*=\s*\@_\s*;)/gc and return ('ARGUMENTS_END', $1);
      /\G(or|xor)/gc and return ('OP24_LOGICAL_OR_XOR', $1);
      /\G(and)/gc and return ('OP23_LOGICAL_AND', $1);
      /\G(not)/gc and return ('OP22_LOGICAL_NOT', $1);
      /\G(,)/gc and return ('OP21_LIST_COMMA', $1);
      /\G(=>)/gc and return ('OP20_HASH_FATARROW', $1);
      /\G(next|last)/gc and return ('OP19_LOOP_CONTROL', $1);
      /\G(=|\+=|-=|\*=|\/=)/gc and return ('OP19_VARIABLE_ASSIGN', $1);
      /\G(\?)/gc and return ('OP18_TERNARY', $1);
      /\G(\.\.)/gc and return ('OP17_LIST_RANGE', $1);
      /\G(\|\|)/gc and return ('OP16_LOGICAL_OR', $1);
      /\G(&&)/gc and return ('OP15_LOGICAL_AND', $1);
      /\G(\||\^)/gc and return ('OP14_BITWISE_OR_XOR', $1);
      /\G(&)/gc and return ('OP13_BITWISE_AND', $1);
      /\G(==|!=|eq|ne)/gc and return ('OP12_COMPARE_EQ_NEQ', $1);
      /\G(<|>|<=|>=|lt|gt|le|ge)/gc and return ('OP11_COMPARE_LT_GT', $1);
      /\G([a-z]+)/gc and return ('OP10_NAMED_UNARY', $1);
      /\G(<<|>>)/gc and return ('OP09_BITWISE_SHIFT', $1);
      /\G(\.)/gc and return ('OP08_STRING_CAT', $1);
      /\G(\+|-)/gc and return ('OP08_MATH_ADD_SUB', $1);
      /\G(\*|\/|\%)/gc and return ('OP07_MATH_MULT_DIV_MOD', $1);
      /\G(.+)/gc and return ('OP06_REGEX_PATTERN', $1);
      /\G(=\~|!\~)/gc and return ('OP06_REGEX_MATCH', $1);
      /\G(-)/gc and return ('OP05_MATH_NEG', $1);
      /\G(!)/gc and return ('OP05_LOGICAL_NEG', $1);
      /\G(\*\*)/gc and return ('OP04_MATH_POW', $1);
      /\G(\+\+|--)/gc and return ('OP03_MATH_INC_DEC', $1);
      /\G(->\{)/gc and return ('OP02_HASH_THINARROW', $1);
      /\G(->\[)/gc and return ('OP02_ARRAY_THINARROW', $1);
      /\G(->)/gc and return ('OP02_METHOD_THINARROW', $1);
      /\G(\()/gc and return ('OP01_PARENTHESIS', $1);
      /\G(print|croak|return|exit)/gc and return ('OP01_NAMED_VOID', $1);
      /\G([a-zA-Z]\w*)/gc and return ('OP01_NAMED', $1);


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


#line 114 ./Grammar.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@Grammar::ISA variable inside the header section of the eyapp program?
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
  [ '_PLUS_LIST' => 'PLUS-1', [ 'PLUS-1', 'Module' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-1', [ 'Module' ], 0 ],
  [ 'CompileUnit_3' => 'CompileUnit', [ 'Program' ], 0 ],
  [ 'CompileUnit_4' => 'CompileUnit', [ 'PLUS-1' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [ 'STAR-2', 'Subroutine' ], 0 ],
  [ '_STAR_LIST' => 'STAR-2', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-3', [ 'PLUS-3', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-3', [ 'Operation' ], 0 ],
  [ 'Program_9' => 'Program', [ 'SHEBANG', 'Header', 'STAR-2', 'PLUS-3' ], 0 ],
  [ 'Module_10' => 'Module', [ 'Package' ], 0 ],
  [ 'Module_11' => 'Module', [ 'Class' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-4', [ 'PLUS-4', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-4', [ 'Subroutine' ], 0 ],
  [ 'Package_14' => 'Package', [ 'package', 'WORD_SCOPED', ';', 'Header', 'PLUS-4', '1', ';' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [ 'STAR-5', 'Include' ], 0 ],
  [ '_STAR_LIST' => 'STAR-5', [  ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [ 'STAR-6', 'Constant' ], 0 ],
  [ '_STAR_LIST' => 'STAR-6', [  ], 0 ],
  [ 'Header_19' => 'Header', [ 'use', 'strict', ';', 'use', 'warnings', ';', 'our', '$VERSION', '=', 'VERSION_NUMBER', ';', 'use', 'Carp', ';', 'use', 'RPerl', ';', 'STAR-5', 'STAR-6' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-7', [ 'PLUS-7', 'WORD' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-7', [ 'WORD' ], 0 ],
  [ 'Include_22' => 'Include', [ 'use', 'WORD_SCOPED', ';' ], 0 ],
  [ 'Include_23' => 'Include', [ 'use', 'WORD_SCOPED', 'qw(', 'PLUS-7', ');' ], 0 ],
  [ 'Constant_24' => 'Constant', [ 'use constant', 'WORD', 'OP20_HASH_FATARROW', 'Constant_Value', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-8', [ 'OP21_LIST_COMMA', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-9', [ 'STAR-9', 'PAREN-8' ], 0 ],
  [ '_STAR_LIST' => 'STAR-9', [  ], 0 ],
  [ '_PAREN' => 'PAREN-10', [ 'OP21_LIST_COMMA', 'WORD', 'OP20_HASH_FATARROW', 'LITERAL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [ 'STAR-11', 'PAREN-10' ], 0 ],
  [ '_STAR_LIST' => 'STAR-11', [  ], 0 ],
  [ 'Constant_Value_31' => 'Constant_Value', [ 'LITERAL' ], 0 ],
  [ 'Constant_Value_32' => 'Constant_Value', [ '[', 'LITERAL', 'STAR-9', ']' ], 0 ],
  [ 'Constant_Value_33' => 'Constant_Value', [ '{', 'WORD', 'OP20_HASH_FATARROW', 'LITERAL', 'STAR-11', '}' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [ 'SubroutineArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-12', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'PLUS-13', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-13', [ 'Operation' ], 0 ],
  [ 'Subroutine_38' => 'Subroutine', [ 'our', 'TYPE', 'VARIABLE_SYMBOL', '=', 'sub', '{', 'OPTIONAL-12', 'PLUS-13', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-14', [ 'OP21_LIST_COMMA', 'my', 'TYPE', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-15', [ 'STAR-15', 'PAREN-14' ], 0 ],
  [ '_STAR_LIST' => 'STAR-15', [  ], 0 ],
  [ 'SubroutineArguments_42' => 'SubroutineArguments', [ 'ARGUMENTS_BEGIN', 'TYPE', 'VARIABLE_SYMBOL', 'STAR-15', 'ARGUMENTS_END' ], 0 ],
  [ 'Operation_43' => 'Operation', [ 'Expression', ';' ], 0 ],
  [ 'Operation_44' => 'Operation', [ 'Statement' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-16', [  ], 0 ],
  [ 'Operator_47' => 'Operator', [ 'OP01_NAMED', '(', 'OPTIONAL-16', ')' ], 0 ],
  [ 'Operator_48' => 'Operator', [ 'OP03_MATH_INC_DEC', 'Variable' ], 0 ],
  [ 'Operator_49' => 'Operator', [ 'Variable', 'OP03_MATH_INC_DEC' ], 0 ],
  [ 'Operator_50' => 'Operator', [ 'Expression', 'OP04_MATH_POW', 'Expression' ], 0 ],
  [ 'Operator_51' => 'Operator', [ 'OP05_LOGICAL_NEG', 'Expression' ], 0 ],
  [ 'Operator_52' => 'Operator', [ 'OP05_MATH_NEG', 'Expression' ], 0 ],
  [ 'Operator_53' => 'Operator', [ 'Expression', 'OP06_REGEX_MATCH', '/', 'OP06_REGEX_PATTERN', '/' ], 0 ],
  [ 'Operator_54' => 'Operator', [ 'Expression', 'OP07_MATH_MULT_DIV_MOD', 'Expression' ], 0 ],
  [ 'Operator_55' => 'Operator', [ 'Expression', 'OP08_MATH_ADD_SUB', 'Expression' ], 0 ],
  [ 'Operator_56' => 'Operator', [ 'Expression', 'OP08_STRING_CAT', 'Expression' ], 0 ],
  [ 'Operator_57' => 'Operator', [ 'Expression', 'OP09_BITWISE_SHIFT', 'Expression' ], 0 ],
  [ 'Operator_58' => 'Operator', [ 'OP10_NAMED_UNARY', 'Expression' ], 0 ],
  [ 'Operator_59' => 'Operator', [ 'Expression', 'OP11_COMPARE_LT_GT', 'Expression' ], 0 ],
  [ 'Operator_60' => 'Operator', [ 'Expression', 'OP12_COMPARE_EQ_NEQ', 'Expression' ], 0 ],
  [ 'Operator_61' => 'Operator', [ 'Expression', 'OP13_BITWISE_AND', 'Expression' ], 0 ],
  [ 'Operator_62' => 'Operator', [ 'Expression', 'OP14_BITWISE_OR_XOR', 'Expression' ], 0 ],
  [ 'Operator_63' => 'Operator', [ 'Expression', 'OP15_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_64' => 'Operator', [ 'Expression', 'OP16_LOGICAL_OR', 'Expression' ], 0 ],
  [ 'Operator_65' => 'Operator', [ 'Expression', 'OP17_LIST_RANGE', 'Expression' ], 0 ],
  [ 'Operator_66' => 'Operator', [ 'Expression', 'OP18_TERNARY', 'Variable', ':', 'Variable' ], 0 ],
  [ 'Operator_67' => 'Operator', [ 'OP22_LOGICAL_NOT', 'Expression' ], 0 ],
  [ 'Operator_68' => 'Operator', [ 'Expression', 'OP23_LOGICAL_AND', 'Expression' ], 0 ],
  [ 'Operator_69' => 'Operator', [ 'Expression', 'OP24_LOGICAL_OR_XOR', 'Expression' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-17', [  ], 0 ],
  [ 'OperatorVoid_72' => 'OperatorVoid', [ 'OP19_LOOP_CONTROL', 'LOOP_LABEL', ';' ], 0 ],
  [ 'OperatorVoid_73' => 'OperatorVoid', [ 'OP01_NAMED_VOID', '(', 'OPTIONAL-17', ')', ';' ], 0 ],
  [ 'OperatorVoid_74' => 'OperatorVoid', [ 'OP01_NAMED_VOID', 'Expression', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-18', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [ 'HashEntries' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-19', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-20', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-20', [  ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [ 'ListElements' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-21', [  ], 0 ],
  [ 'Expression_83' => 'Expression', [ 'LITERAL' ], 0 ],
  [ 'Expression_84' => 'Expression', [ 'Variable' ], 0 ],
  [ 'Expression_85' => 'Expression', [ '[', 'OPTIONAL-18', ']' ], 0 ],
  [ 'Expression_86' => 'Expression', [ '{', 'OPTIONAL-19', '}' ], 0 ],
  [ 'Expression_87' => 'Expression', [ 'Operator' ], 0 ],
  [ 'Expression_88' => 'Expression', [ 'WORD_SCOPED', '(', 'OPTIONAL-20', ')' ], 0 ],
  [ 'Expression_89' => 'Expression', [ 'Variable', 'OP02_METHOD_THINARROW', 'WORD', '(', 'OPTIONAL-21', ')' ], 0 ],
  [ 'Expression_90' => 'Expression', [ 'OP01_PARENTHESIS', 'Expression', ')' ], 0 ],
  [ '_PAREN' => 'PAREN-22', [ 'LOOP_LABEL', ':' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [ 'PAREN-22' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-23', [  ], 0 ],
  [ 'Statement_94' => 'Statement', [ 'Conditional' ], 0 ],
  [ 'Statement_95' => 'Statement', [ 'OPTIONAL-23', 'Loop' ], 0 ],
  [ 'Statement_96' => 'Statement', [ 'OperatorVoid' ], 0 ],
  [ 'Statement_97' => 'Statement', [ 'VariableDeclaration' ], 0 ],
  [ 'Statement_98' => 'Statement', [ 'VariableModification' ], 0 ],
  [ '_PAREN' => 'PAREN-24', [ 'elsif', '(', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [ 'STAR-25', 'PAREN-24' ], 0 ],
  [ '_STAR_LIST' => 'STAR-25', [  ], 0 ],
  [ '_PAREN' => 'PAREN-26', [ 'else', 'CodeBlock' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [ 'PAREN-26' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-27', [  ], 0 ],
  [ 'Conditional_105' => 'Conditional', [ 'if', '(', 'Expression', ')', 'CodeBlock', 'STAR-25', 'OPTIONAL-27' ], 0 ],
  [ 'Loop_106' => 'Loop', [ 'LoopFor' ], 0 ],
  [ 'Loop_107' => 'Loop', [ 'LoopForEach' ], 0 ],
  [ 'Loop_108' => 'Loop', [ 'LoopWhile' ], 0 ],
  [ 'LoopFor_109' => 'LoopFor', [ 'for', 'my', 'integer', 'VARIABLE_SYMBOL', '(', 'Expression', '..', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ 'LoopForEach_110' => 'LoopForEach', [ 'foreach', 'my', 'TYPE', 'VARIABLE_SYMBOL', '(', 'ListElements', ')', 'CodeBlock' ], 0 ],
  [ 'LoopWhile_111' => 'LoopWhile', [ 'while', '(', 'Expression', ')', 'CodeBlock' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-28', [ 'PLUS-28', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-28', [ 'Operation' ], 0 ],
  [ 'CodeBlock_114' => 'CodeBlock', [ '{', 'PLUS-28', '}' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [ 'STAR-29', 'VariableRetrieval' ], 0 ],
  [ '_STAR_LIST' => 'STAR-29', [  ], 0 ],
  [ 'Variable_117' => 'Variable', [ 'VARIABLE_SYMBOL', 'STAR-29' ], 0 ],
  [ 'VariableRetrieval_118' => 'VariableRetrieval', [ 'OP02_ARRAY_THINARROW', 'Expression', ']' ], 0 ],
  [ 'VariableRetrieval_119' => 'VariableRetrieval', [ 'OP02_HASH_THINARROW', 'Expression', '}' ], 0 ],
  [ 'VariableDeclaration_120' => 'VariableDeclaration', [ 'my', 'TYPE', 'VARIABLE_SYMBOL', ';' ], 0 ],
  [ 'VariableDeclaration_121' => 'VariableDeclaration', [ 'my', 'TYPE', 'VARIABLE_SYMBOL', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ 'VariableModification_122' => 'VariableModification', [ 'Variable', 'OP19_VARIABLE_ASSIGN', 'Expression', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-30', [ 'OP21_LIST_COMMA', 'ListElementValue' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [ 'STAR-31', 'PAREN-30' ], 0 ],
  [ '_STAR_LIST' => 'STAR-31', [  ], 0 ],
  [ 'ListElements_126' => 'ListElements', [ 'ListElementValue', 'STAR-31' ], 0 ],
  [ 'ListElementValue_127' => 'ListElementValue', [ 'Expression' ], 0 ],
  [ 'ListElementValue_128' => 'ListElementValue', [ '@{', 'Variable', '}' ], 0 ],
  [ 'ListElementValue_129' => 'ListElementValue', [ 'KEYS_OR_VALUES', '%{', 'Variable', '}' ], 0 ],
  [ '_PAREN' => 'PAREN-32', [ 'OP21_LIST_COMMA', 'WORD', 'OP20_HASH_FATARROW', 'HashEntryValue' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [ 'STAR-33', 'PAREN-32' ], 0 ],
  [ '_STAR_LIST' => 'STAR-33', [  ], 0 ],
  [ 'HashEntries_133' => 'HashEntries', [ 'WORD', 'OP20_HASH_FATARROW', 'HashEntryValue', 'STAR-33' ], 0 ],
  [ 'HashEntryValue_134' => 'HashEntryValue', [ 'Expression' ], 0 ],
  [ 'HashEntryValue_135' => 'HashEntryValue', [ '%{', 'Variable', '}' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-34', [ 'PLUS-34', 'WORD_SCOPED' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-34', [ 'WORD_SCOPED' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [ 'STAR-35', 'Method' ], 0 ],
  [ '_STAR_LIST' => 'STAR-35', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-36', [ 'PLUS-36', 'Subroutine' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-36', [ 'Subroutine' ], 0 ],
  [ '_PAREN' => 'PAREN-37', [ 'PLUS-36', '1', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [ 'PAREN-37' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-38', [  ], 0 ],
  [ 'Class_145' => 'Class', [ 'package', 'WORD_SCOPED', ';', 'Header', 'use parent', 'qw(', 'PLUS-34', ')', ';', 'Properties', 'STAR-35', '1', ';', 'OPTIONAL-38' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [ 'HashEntries' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-39', [  ], 0 ],
  [ 'Properties_148' => 'Properties', [ 'our', '%properties', '=', '(', 'OPTIONAL-39', ')', ';' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [ 'MethodArguments' ], 0 ],
  [ '_OPTIONAL' => 'OPTIONAL-40', [  ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-41', [ 'PLUS-41', 'Operation' ], 0 ],
  [ '_PLUS_LIST' => 'PLUS-41', [ 'Operation' ], 0 ],
  [ 'Method_153' => 'Method', [ 'our', 'TYPE', 'VARIABLE_SYMBOL', '=', 'sub', '{', 'OPTIONAL-40', 'PLUS-41', '}', ';' ], 0 ],
  [ '_PAREN' => 'PAREN-42', [ 'OP21_LIST_COMMA', 'my', 'TYPE', 'VARIABLE_SYMBOL' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [ 'STAR-43', 'PAREN-42' ], 0 ],
  [ '_STAR_LIST' => 'STAR-43', [  ], 0 ],
  [ 'MethodArguments_157' => 'MethodArguments', [ 'ARGUMENTS_BEGIN', 'TYPE_CLASS_OR_SELF', 'STAR-43', 'ARGUMENTS_END' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  '_PLUS_LIST' => 1,
  '_PLUS_LIST' => 2,
  'CompileUnit_3' => 3,
  'CompileUnit_4' => 4,
  '_STAR_LIST' => 5,
  '_STAR_LIST' => 6,
  '_PLUS_LIST' => 7,
  '_PLUS_LIST' => 8,
  'Program_9' => 9,
  'Module_10' => 10,
  'Module_11' => 11,
  '_PLUS_LIST' => 12,
  '_PLUS_LIST' => 13,
  'Package_14' => 14,
  '_STAR_LIST' => 15,
  '_STAR_LIST' => 16,
  '_STAR_LIST' => 17,
  '_STAR_LIST' => 18,
  'Header_19' => 19,
  '_PLUS_LIST' => 20,
  '_PLUS_LIST' => 21,
  'Include_22' => 22,
  'Include_23' => 23,
  'Constant_24' => 24,
  '_PAREN' => 25,
  '_STAR_LIST' => 26,
  '_STAR_LIST' => 27,
  '_PAREN' => 28,
  '_STAR_LIST' => 29,
  '_STAR_LIST' => 30,
  'Constant_Value_31' => 31,
  'Constant_Value_32' => 32,
  'Constant_Value_33' => 33,
  '_OPTIONAL' => 34,
  '_OPTIONAL' => 35,
  '_PLUS_LIST' => 36,
  '_PLUS_LIST' => 37,
  'Subroutine_38' => 38,
  '_PAREN' => 39,
  '_STAR_LIST' => 40,
  '_STAR_LIST' => 41,
  'SubroutineArguments_42' => 42,
  'Operation_43' => 43,
  'Operation_44' => 44,
  '_OPTIONAL' => 45,
  '_OPTIONAL' => 46,
  'Operator_47' => 47,
  'Operator_48' => 48,
  'Operator_49' => 49,
  'Operator_50' => 50,
  'Operator_51' => 51,
  'Operator_52' => 52,
  'Operator_53' => 53,
  'Operator_54' => 54,
  'Operator_55' => 55,
  'Operator_56' => 56,
  'Operator_57' => 57,
  'Operator_58' => 58,
  'Operator_59' => 59,
  'Operator_60' => 60,
  'Operator_61' => 61,
  'Operator_62' => 62,
  'Operator_63' => 63,
  'Operator_64' => 64,
  'Operator_65' => 65,
  'Operator_66' => 66,
  'Operator_67' => 67,
  'Operator_68' => 68,
  'Operator_69' => 69,
  '_OPTIONAL' => 70,
  '_OPTIONAL' => 71,
  'OperatorVoid_72' => 72,
  'OperatorVoid_73' => 73,
  'OperatorVoid_74' => 74,
  '_OPTIONAL' => 75,
  '_OPTIONAL' => 76,
  '_OPTIONAL' => 77,
  '_OPTIONAL' => 78,
  '_OPTIONAL' => 79,
  '_OPTIONAL' => 80,
  '_OPTIONAL' => 81,
  '_OPTIONAL' => 82,
  'Expression_83' => 83,
  'Expression_84' => 84,
  'Expression_85' => 85,
  'Expression_86' => 86,
  'Expression_87' => 87,
  'Expression_88' => 88,
  'Expression_89' => 89,
  'Expression_90' => 90,
  '_PAREN' => 91,
  '_OPTIONAL' => 92,
  '_OPTIONAL' => 93,
  'Statement_94' => 94,
  'Statement_95' => 95,
  'Statement_96' => 96,
  'Statement_97' => 97,
  'Statement_98' => 98,
  '_PAREN' => 99,
  '_STAR_LIST' => 100,
  '_STAR_LIST' => 101,
  '_PAREN' => 102,
  '_OPTIONAL' => 103,
  '_OPTIONAL' => 104,
  'Conditional_105' => 105,
  'Loop_106' => 106,
  'Loop_107' => 107,
  'Loop_108' => 108,
  'LoopFor_109' => 109,
  'LoopForEach_110' => 110,
  'LoopWhile_111' => 111,
  '_PLUS_LIST' => 112,
  '_PLUS_LIST' => 113,
  'CodeBlock_114' => 114,
  '_STAR_LIST' => 115,
  '_STAR_LIST' => 116,
  'Variable_117' => 117,
  'VariableRetrieval_118' => 118,
  'VariableRetrieval_119' => 119,
  'VariableDeclaration_120' => 120,
  'VariableDeclaration_121' => 121,
  'VariableModification_122' => 122,
  '_PAREN' => 123,
  '_STAR_LIST' => 124,
  '_STAR_LIST' => 125,
  'ListElements_126' => 126,
  'ListElementValue_127' => 127,
  'ListElementValue_128' => 128,
  'ListElementValue_129' => 129,
  '_PAREN' => 130,
  '_STAR_LIST' => 131,
  '_STAR_LIST' => 132,
  'HashEntries_133' => 133,
  'HashEntryValue_134' => 134,
  'HashEntryValue_135' => 135,
  '_PLUS_LIST' => 136,
  '_PLUS_LIST' => 137,
  '_STAR_LIST' => 138,
  '_STAR_LIST' => 139,
  '_PLUS_LIST' => 140,
  '_PLUS_LIST' => 141,
  '_PAREN' => 142,
  '_OPTIONAL' => 143,
  '_OPTIONAL' => 144,
  'Class_145' => 145,
  '_OPTIONAL' => 146,
  '_OPTIONAL' => 147,
  'Properties_148' => 148,
  '_OPTIONAL' => 149,
  '_OPTIONAL' => 150,
  '_PLUS_LIST' => 151,
  '_PLUS_LIST' => 152,
  'Method_153' => 153,
  '_PAREN' => 154,
  '_STAR_LIST' => 155,
  '_STAR_LIST' => 156,
  'MethodArguments_157' => 157,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'$VERSION' => { ISSEMANTIC => 0 },
	'%properties' => { ISSEMANTIC => 0 },
	'%{' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	');' => { ISSEMANTIC => 0 },
	'..' => { ISSEMANTIC => 0 },
	'/' => { ISSEMANTIC => 0 },
	'1' => { ISSEMANTIC => 0 },
	':' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'=' => { ISSEMANTIC => 0 },
	'@{' => { ISSEMANTIC => 0 },
	'Carp' => { ISSEMANTIC => 0 },
	'RPerl' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'else' => { ISSEMANTIC => 0 },
	'elsif' => { ISSEMANTIC => 0 },
	'for' => { ISSEMANTIC => 0 },
	'foreach' => { ISSEMANTIC => 0 },
	'if' => { ISSEMANTIC => 0 },
	'integer' => { ISSEMANTIC => 0 },
	'my' => { ISSEMANTIC => 0 },
	'our' => { ISSEMANTIC => 0 },
	'package' => { ISSEMANTIC => 0 },
	'qw(' => { ISSEMANTIC => 0 },
	'strict' => { ISSEMANTIC => 0 },
	'sub' => { ISSEMANTIC => 0 },
	'use constant' => { ISSEMANTIC => 0 },
	'use parent' => { ISSEMANTIC => 0 },
	'use' => { ISSEMANTIC => 0 },
	'warnings' => { ISSEMANTIC => 0 },
	'while' => { ISSEMANTIC => 0 },
	'{' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	ARGUMENTS_BEGIN => { ISSEMANTIC => 1 },
	ARGUMENTS_END => { ISSEMANTIC => 1 },
	KEYS_OR_VALUES => { ISSEMANTIC => 1 },
	LITERAL => { ISSEMANTIC => 1 },
	LOOP_LABEL => { ISSEMANTIC => 1 },
	OP01_NAMED => { ISSEMANTIC => 1 },
	OP01_NAMED_VOID => { ISSEMANTIC => 1 },
	OP01_PARENTHESIS => { ISSEMANTIC => 1 },
	OP02_ARRAY_THINARROW => { ISSEMANTIC => 1 },
	OP02_HASH_THINARROW => { ISSEMANTIC => 1 },
	OP02_METHOD_THINARROW => { ISSEMANTIC => 1 },
	OP03_MATH_INC_DEC => { ISSEMANTIC => 1 },
	OP04_MATH_POW => { ISSEMANTIC => 1 },
	OP05_LOGICAL_NEG => { ISSEMANTIC => 1 },
	OP05_MATH_NEG => { ISSEMANTIC => 1 },
	OP06_REGEX_MATCH => { ISSEMANTIC => 1 },
	OP06_REGEX_PATTERN => { ISSEMANTIC => 1 },
	OP07_MATH_MULT_DIV_MOD => { ISSEMANTIC => 1 },
	OP08_MATH_ADD_SUB => { ISSEMANTIC => 1 },
	OP08_STRING_CAT => { ISSEMANTIC => 1 },
	OP09_BITWISE_SHIFT => { ISSEMANTIC => 1 },
	OP10_NAMED_UNARY => { ISSEMANTIC => 1 },
	OP11_COMPARE_LT_GT => { ISSEMANTIC => 1 },
	OP12_COMPARE_EQ_NEQ => { ISSEMANTIC => 1 },
	OP13_BITWISE_AND => { ISSEMANTIC => 1 },
	OP14_BITWISE_OR_XOR => { ISSEMANTIC => 1 },
	OP15_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP16_LOGICAL_OR => { ISSEMANTIC => 1 },
	OP17_LIST_RANGE => { ISSEMANTIC => 1 },
	OP18_TERNARY => { ISSEMANTIC => 1 },
	OP19_LOOP_CONTROL => { ISSEMANTIC => 1 },
	OP19_VARIABLE_ASSIGN => { ISSEMANTIC => 1 },
	OP20_HASH_FATARROW => { ISSEMANTIC => 1 },
	OP21_LIST_COMMA => { ISSEMANTIC => 1 },
	OP22_LOGICAL_NOT => { ISSEMANTIC => 1 },
	OP23_LOGICAL_AND => { ISSEMANTIC => 1 },
	OP24_LOGICAL_OR_XOR => { ISSEMANTIC => 1 },
	SHEBANG => { ISSEMANTIC => 1 },
	TYPE => { ISSEMANTIC => 1 },
	TYPE_CLASS_OR_SELF => { ISSEMANTIC => 1 },
	VARIABLE_SYMBOL => { ISSEMANTIC => 1 },
	VERSION_NUMBER => { ISSEMANTIC => 1 },
	WORD => { ISSEMANTIC => 1 },
	WORD_SCOPED => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'Grammar.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			"package" => 3,
			'SHEBANG' => 4
		},
		GOTOS => {
			'Class' => 6,
			'Module' => 1,
			'Package' => 5,
			'CompileUnit' => 7,
			'PLUS-1' => 2,
			'Program' => 8
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		ACTIONS => {
			"package" => 3,
			'' => -4
		},
		GOTOS => {
			'Class' => 6,
			'Module' => 9,
			'Package' => 5
		}
	},
	{#State 3
		ACTIONS => {
			'WORD_SCOPED' => 10
		}
	},
	{#State 4
		ACTIONS => {
			"use" => 11
		},
		GOTOS => {
			'Header' => 12
		}
	},
	{#State 5
		DEFAULT => -10
	},
	{#State 6
		DEFAULT => -11
	},
	{#State 7
		ACTIONS => {
			'' => 13
		}
	},
	{#State 8
		DEFAULT => -3
	},
	{#State 9
		DEFAULT => -1
	},
	{#State 10
		ACTIONS => {
			";" => 14
		}
	},
	{#State 11
		ACTIONS => {
			"strict" => 15
		}
	},
	{#State 12
		DEFAULT => -6,
		GOTOS => {
			'STAR-2' => 16
		}
	},
	{#State 13
		DEFAULT => 0
	},
	{#State 14
		ACTIONS => {
			"use" => 11
		},
		GOTOS => {
			'Header' => 17
		}
	},
	{#State 15
		ACTIONS => {
			";" => 18
		}
	},
	{#State 16
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			"if" => 43,
			'LOOP_LABEL' => 41,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45,
			"our" => 46,
			'OP01_NAMED_VOID' => 33,
			'OP19_LOOP_CONTROL' => 37,
			'VARIABLE_SYMBOL' => 31,
			"for" => -93,
			"while" => -93,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP01_NAMED' => 29,
			"foreach" => -93,
			"my" => 22,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'PAREN-22' => 47,
			'Operator' => 48,
			'OPTIONAL-23' => 27,
			'Operation' => 26,
			'Variable' => 42,
			'PLUS-3' => 25,
			'Subroutine' => 24,
			'Statement' => 35,
			'VariableModification' => 36,
			'Expression' => 32,
			'VariableDeclaration' => 19,
			'Conditional' => 34,
			'OperatorVoid' => 20
		}
	},
	{#State 17
		ACTIONS => {
			"our" => 46,
			"use parent" => 52
		},
		GOTOS => {
			'PLUS-4' => 51,
			'Subroutine' => 50
		}
	},
	{#State 18
		ACTIONS => {
			"use" => 53
		}
	},
	{#State 19
		DEFAULT => -97
	},
	{#State 20
		DEFAULT => -96
	},
	{#State 21
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			"{" => 28,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 54,
			'Operator' => 48
		}
	},
	{#State 22
		ACTIONS => {
			'TYPE' => 56
		}
	},
	{#State 23
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'WORD_SCOPED' => 30,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP01_NAMED' => 29,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Expression' => 57,
			'Variable' => 55,
			'Operator' => 48
		}
	},
	{#State 24
		DEFAULT => -5
	},
	{#State 25
		ACTIONS => {
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45,
			"if" => 43,
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'LOOP_LABEL' => 41,
			'OP19_LOOP_CONTROL' => 37,
			'OP01_NAMED_VOID' => 33,
			'' => -9,
			"while" => -93,
			"for" => -93,
			'VARIABLE_SYMBOL' => 31,
			'OP01_NAMED' => 29,
			"{" => 28,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NOT' => 23,
			"my" => 22,
			'OP01_PARENTHESIS' => 21,
			"foreach" => -93
		},
		GOTOS => {
			'Statement' => 35,
			'VariableModification' => 36,
			'Expression' => 32,
			'VariableDeclaration' => 19,
			'Conditional' => 34,
			'OperatorVoid' => 20,
			'PAREN-22' => 47,
			'Operator' => 48,
			'OPTIONAL-23' => 27,
			'Operation' => 58,
			'Variable' => 42
		}
	},
	{#State 26
		DEFAULT => -8
	},
	{#State 27
		ACTIONS => {
			"while" => 59,
			"for" => 60,
			"foreach" => 62
		},
		GOTOS => {
			'Loop' => 64,
			'LoopForEach' => 63,
			'LoopFor' => 65,
			'LoopWhile' => 61
		}
	},
	{#State 28
		ACTIONS => {
			'WORD' => 68,
			"}" => -78
		},
		GOTOS => {
			'HashEntries' => 67,
			'OPTIONAL-19' => 66
		}
	},
	{#State 29
		ACTIONS => {
			"(" => 69
		}
	},
	{#State 30
		ACTIONS => {
			"(" => 70
		}
	},
	{#State 31
		DEFAULT => -116,
		GOTOS => {
			'STAR-29' => 71
		}
	},
	{#State 32
		ACTIONS => {
			'OP08_STRING_CAT' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => 78,
			'OP15_LOGICAL_AND' => 76,
			";" => 80,
			'OP08_MATH_ADD_SUB' => 79,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			'OP18_TERNARY' => 75
		}
	},
	{#State 33
		ACTIONS => {
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			"(" => 89,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP10_NAMED_UNARY' => 44
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 90,
			'Operator' => 48
		}
	},
	{#State 34
		DEFAULT => -94
	},
	{#State 35
		DEFAULT => -44
	},
	{#State 36
		DEFAULT => -98
	},
	{#State 37
		ACTIONS => {
			'LOOP_LABEL' => 91
		}
	},
	{#State 38
		DEFAULT => -83
	},
	{#State 39
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'OP01_NAMED' => 29,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Operator' => 48,
			'Expression' => 92,
			'Variable' => 55
		}
	},
	{#State 40
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Expression' => 93,
			'Variable' => 55,
			'Operator' => 48
		}
	},
	{#State 41
		ACTIONS => {
			":" => 94
		}
	},
	{#State 42
		ACTIONS => {
			'OP16_LOGICAL_OR' => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			'OP19_VARIABLE_ASSIGN' => 96,
			'OP15_LOGICAL_AND' => -84,
			";" => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP09_BITWISE_SHIFT' => -84,
			'OP18_TERNARY' => -84,
			'OP02_METHOD_THINARROW' => 97,
			'OP08_STRING_CAT' => -84,
			'OP03_MATH_INC_DEC' => 95,
			'OP24_LOGICAL_OR_XOR' => -84,
			'OP13_BITWISE_AND' => -84,
			'OP12_COMPARE_EQ_NEQ' => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP11_COMPARE_LT_GT' => -84,
			'OP04_MATH_POW' => -84
		}
	},
	{#State 43
		ACTIONS => {
			"(" => 98
		}
	},
	{#State 44
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'OP10_NAMED_UNARY' => 44,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Expression' => 99,
			'Variable' => 55,
			'Operator' => 48
		}
	},
	{#State 45
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31
		},
		GOTOS => {
			'Variable' => 100
		}
	},
	{#State 46
		ACTIONS => {
			'TYPE' => 101
		}
	},
	{#State 47
		DEFAULT => -92
	},
	{#State 48
		DEFAULT => -87
	},
	{#State 49
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31,
			'OP01_NAMED' => 29,
			"{" => 28,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21,
			"]" => -76,
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45,
			"\@{" => 103,
			'KEYS_OR_VALUES' => 102
		},
		GOTOS => {
			'ListElements' => 106,
			'Operator' => 48,
			'OPTIONAL-18' => 107,
			'Expression' => 104,
			'Variable' => 55,
			'ListElementValue' => 105
		}
	},
	{#State 50
		DEFAULT => -13
	},
	{#State 51
		ACTIONS => {
			"our" => 46,
			"1" => 109
		},
		GOTOS => {
			'Subroutine' => 108
		}
	},
	{#State 52
		ACTIONS => {
			"qw(" => 110
		}
	},
	{#State 53
		ACTIONS => {
			"warnings" => 111
		}
	},
	{#State 54
		ACTIONS => {
			'OP14_BITWISE_OR_XOR' => 74,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			'OP18_TERNARY' => 75,
			'OP16_LOGICAL_OR' => 78,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			")" => 112,
			'OP15_LOGICAL_AND' => 76,
			'OP08_MATH_ADD_SUB' => 79,
			'OP17_LIST_RANGE' => 81,
			'OP06_REGEX_MATCH' => 82,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP08_STRING_CAT' => 87,
			'OP24_LOGICAL_OR_XOR' => 88
		}
	},
	{#State 55
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -84,
			'OP04_MATH_POW' => -84,
			'OP21_LIST_COMMA' => -84,
			".." => -84,
			'OP12_COMPARE_EQ_NEQ' => -84,
			'OP13_BITWISE_AND' => -84,
			'OP17_LIST_RANGE' => -84,
			'OP06_REGEX_MATCH' => -84,
			'OP24_LOGICAL_OR_XOR' => -84,
			"}" => -84,
			'OP08_STRING_CAT' => -84,
			'OP03_MATH_INC_DEC' => 95,
			'OP18_TERNARY' => -84,
			'OP02_METHOD_THINARROW' => 97,
			"]" => -84,
			'OP14_BITWISE_OR_XOR' => -84,
			'OP23_LOGICAL_AND' => -84,
			'OP09_BITWISE_SHIFT' => -84,
			";" => -84,
			'OP08_MATH_ADD_SUB' => -84,
			'OP16_LOGICAL_OR' => -84,
			")" => -84,
			'OP07_MATH_MULT_DIV_MOD' => -84,
			'OP15_LOGICAL_AND' => -84
		}
	},
	{#State 56
		ACTIONS => {
			'VARIABLE_SYMBOL' => 113
		}
	},
	{#State 57
		ACTIONS => {
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			".." => -67,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -67,
			'OP08_STRING_CAT' => 87,
			'OP24_LOGICAL_OR_XOR' => -67,
			"}" => -67,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => -67,
			"]" => -67,
			'OP18_TERNARY' => 75,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			")" => -67,
			'OP16_LOGICAL_OR' => 78,
			'OP15_LOGICAL_AND' => 76,
			'OP08_MATH_ADD_SUB' => 79,
			";" => -67
		}
	},
	{#State 58
		DEFAULT => -7
	},
	{#State 59
		ACTIONS => {
			"(" => 114
		}
	},
	{#State 60
		ACTIONS => {
			"my" => 115
		}
	},
	{#State 61
		DEFAULT => -108
	},
	{#State 62
		ACTIONS => {
			"my" => 116
		}
	},
	{#State 63
		DEFAULT => -107
	},
	{#State 64
		DEFAULT => -95
	},
	{#State 65
		DEFAULT => -106
	},
	{#State 66
		ACTIONS => {
			"}" => 117
		}
	},
	{#State 67
		DEFAULT => -77
	},
	{#State 68
		ACTIONS => {
			'OP20_HASH_FATARROW' => 118
		}
	},
	{#State 69
		ACTIONS => {
			")" => -46,
			'OP01_NAMED' => 29,
			"{" => 28,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 31,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 45,
			"[" => 49,
			"\@{" => 103,
			'KEYS_OR_VALUES' => 102
		},
		GOTOS => {
			'OPTIONAL-16' => 120,
			'Expression' => 104,
			'ListElementValue' => 105,
			'Variable' => 55,
			'Operator' => 48,
			'ListElements' => 119
		}
	},
	{#State 70
		ACTIONS => {
			'OP03_MATH_INC_DEC' => 45,
			"[" => 49,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'OP10_NAMED_UNARY' => 44,
			'KEYS_OR_VALUES' => 102,
			"\@{" => 103,
			'OP01_NAMED' => 29,
			")" => -80,
			"{" => 28,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 31,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'ListElements' => 122,
			'Operator' => 48,
			'OPTIONAL-20' => 121,
			'Variable' => 55,
			'ListElementValue' => 105,
			'Expression' => 104
		}
	},
	{#State 71
		ACTIONS => {
			";" => -117,
			'OP08_MATH_ADD_SUB' => -117,
			'OP07_MATH_MULT_DIV_MOD' => -117,
			'OP19_VARIABLE_ASSIGN' => -117,
			'OP16_LOGICAL_OR' => -117,
			")" => -117,
			'OP15_LOGICAL_AND' => -117,
			'OP18_TERNARY' => -117,
			'OP02_METHOD_THINARROW' => -117,
			"]" => -117,
			'OP14_BITWISE_OR_XOR' => -117,
			'OP23_LOGICAL_AND' => -117,
			'OP09_BITWISE_SHIFT' => -117,
			'OP24_LOGICAL_OR_XOR' => -117,
			"}" => -117,
			'OP02_HASH_THINARROW' => 124,
			'OP03_MATH_INC_DEC' => -117,
			'OP08_STRING_CAT' => -117,
			'OP02_ARRAY_THINARROW' => 123,
			'OP11_COMPARE_LT_GT' => -117,
			'OP21_LIST_COMMA' => -117,
			'OP04_MATH_POW' => -117,
			".." => -117,
			'OP12_COMPARE_EQ_NEQ' => -117,
			'OP13_BITWISE_AND' => -117,
			'OP06_REGEX_MATCH' => -117,
			":" => -117,
			'OP17_LIST_RANGE' => -117
		},
		GOTOS => {
			'VariableRetrieval' => 125
		}
	},
	{#State 72
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 44,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 126,
			'Operator' => 48
		}
	},
	{#State 73
		ACTIONS => {
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Operator' => 48,
			'Variable' => 55,
			'Expression' => 127
		}
	},
	{#State 74
		ACTIONS => {
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP10_NAMED_UNARY' => 44,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 128,
			'Operator' => 48
		}
	},
	{#State 75
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31
		},
		GOTOS => {
			'Variable' => 129
		}
	},
	{#State 76
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Expression' => 130,
			'Variable' => 55,
			'Operator' => 48
		}
	},
	{#State 77
		ACTIONS => {
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP10_NAMED_UNARY' => 44,
			"{" => 28,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 131,
			'Operator' => 48
		}
	},
	{#State 78
		ACTIONS => {
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP10_NAMED_UNARY' => 44,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49
		},
		GOTOS => {
			'Operator' => 48,
			'Expression' => 132,
			'Variable' => 55
		}
	},
	{#State 79
		ACTIONS => {
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'OP10_NAMED_UNARY' => 44,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Operator' => 48,
			'Variable' => 55,
			'Expression' => 133
		}
	},
	{#State 80
		DEFAULT => -43
	},
	{#State 81
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40
		},
		GOTOS => {
			'Operator' => 48,
			'Variable' => 55,
			'Expression' => 134
		}
	},
	{#State 82
		ACTIONS => {
			"/" => 135
		}
	},
	{#State 83
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			"{" => 28,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Operator' => 48,
			'Expression' => 136,
			'Variable' => 55
		}
	},
	{#State 84
		ACTIONS => {
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'OP10_NAMED_UNARY' => 44,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'WORD_SCOPED' => 30,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Expression' => 137,
			'Variable' => 55,
			'Operator' => 48
		}
	},
	{#State 85
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38
		},
		GOTOS => {
			'Operator' => 48,
			'Expression' => 138,
			'Variable' => 55
		}
	},
	{#State 86
		ACTIONS => {
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'OP10_NAMED_UNARY' => 44,
			'OP01_NAMED' => 29,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 139,
			'Operator' => 48
		}
	},
	{#State 87
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 140,
			'Operator' => 48
		}
	},
	{#State 88
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 141,
			'Operator' => 48
		}
	},
	{#State 89
		ACTIONS => {
			'KEYS_OR_VALUES' => 102,
			"\@{" => 103,
			'OP03_MATH_INC_DEC' => 45,
			"[" => 49,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP10_NAMED_UNARY' => 44,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_NAMED' => 29,
			"{" => 28,
			")" => -71,
			'WORD_SCOPED' => 30,
			'VARIABLE_SYMBOL' => 31
		},
		GOTOS => {
			'Expression' => 104,
			'Variable' => 55,
			'OPTIONAL-17' => 142,
			'ListElementValue' => 105,
			'ListElements' => 143,
			'Operator' => 48
		}
	},
	{#State 90
		ACTIONS => {
			'OP15_LOGICAL_AND' => 76,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => 78,
			'OP08_MATH_ADD_SUB' => 79,
			";" => 144,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP18_TERNARY' => 75,
			'OP08_STRING_CAT' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP04_MATH_POW' => 85,
			'OP11_COMPARE_LT_GT' => 86
		}
	},
	{#State 91
		ACTIONS => {
			";" => 145
		}
	},
	{#State 92
		ACTIONS => {
			'OP08_STRING_CAT' => -51,
			"}" => -51,
			'OP24_LOGICAL_OR_XOR' => -51,
			'OP12_COMPARE_EQ_NEQ' => -51,
			'OP13_BITWISE_AND' => -51,
			".." => -51,
			'OP17_LIST_RANGE' => -51,
			'OP06_REGEX_MATCH' => -51,
			'OP21_LIST_COMMA' => -51,
			'OP04_MATH_POW' => 85,
			'OP11_COMPARE_LT_GT' => -51,
			'OP15_LOGICAL_AND' => -51,
			'OP16_LOGICAL_OR' => -51,
			")" => -51,
			'OP07_MATH_MULT_DIV_MOD' => -51,
			";" => -51,
			'OP08_MATH_ADD_SUB' => -51,
			"]" => -51,
			'OP09_BITWISE_SHIFT' => -51,
			'OP23_LOGICAL_AND' => -51,
			'OP14_BITWISE_OR_XOR' => -51,
			'OP18_TERNARY' => -51
		}
	},
	{#State 93
		ACTIONS => {
			'OP17_LIST_RANGE' => -52,
			'OP06_REGEX_MATCH' => -52,
			'OP13_BITWISE_AND' => -52,
			'OP12_COMPARE_EQ_NEQ' => -52,
			".." => -52,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -52,
			'OP11_COMPARE_LT_GT' => -52,
			'OP08_STRING_CAT' => -52,
			"}" => -52,
			'OP24_LOGICAL_OR_XOR' => -52,
			'OP09_BITWISE_SHIFT' => -52,
			'OP23_LOGICAL_AND' => -52,
			'OP14_BITWISE_OR_XOR' => -52,
			"]" => -52,
			'OP18_TERNARY' => -52,
			'OP15_LOGICAL_AND' => -52,
			")" => -52,
			'OP16_LOGICAL_OR' => -52,
			'OP07_MATH_MULT_DIV_MOD' => -52,
			'OP08_MATH_ADD_SUB' => -52,
			";" => -52
		}
	},
	{#State 94
		DEFAULT => -91
	},
	{#State 95
		DEFAULT => -49
	},
	{#State 96
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Operator' => 48,
			'Variable' => 55,
			'Expression' => 146
		}
	},
	{#State 97
		ACTIONS => {
			'WORD' => 147
		}
	},
	{#State 98
		ACTIONS => {
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP10_NAMED_UNARY' => 44,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49
		},
		GOTOS => {
			'Expression' => 148,
			'Variable' => 55,
			'Operator' => 48
		}
	},
	{#State 99
		ACTIONS => {
			'OP15_LOGICAL_AND' => -58,
			")" => -58,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => -58,
			'OP08_MATH_ADD_SUB' => 79,
			";" => -58,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => -58,
			'OP14_BITWISE_OR_XOR' => -58,
			"]" => -58,
			'OP18_TERNARY' => -58,
			'OP08_STRING_CAT' => 87,
			"}" => -58,
			'OP24_LOGICAL_OR_XOR' => -58,
			'OP17_LIST_RANGE' => -58,
			'OP06_REGEX_MATCH' => 82,
			'OP12_COMPARE_EQ_NEQ' => -58,
			'OP13_BITWISE_AND' => -58,
			".." => -58,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -58,
			'OP11_COMPARE_LT_GT' => -58
		}
	},
	{#State 100
		DEFAULT => -48
	},
	{#State 101
		ACTIONS => {
			'VARIABLE_SYMBOL' => 149
		}
	},
	{#State 102
		ACTIONS => {
			"%{" => 150
		}
	},
	{#State 103
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31
		},
		GOTOS => {
			'Variable' => 151
		}
	},
	{#State 104
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 79,
			'OP16_LOGICAL_OR' => 78,
			")" => -127,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP15_LOGICAL_AND' => 76,
			'OP18_TERNARY' => 75,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			"]" => -127,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP08_STRING_CAT' => 87,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -127,
			'OP17_LIST_RANGE' => 81,
			'OP06_REGEX_MATCH' => 82,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84
		}
	},
	{#State 105
		DEFAULT => -125,
		GOTOS => {
			'STAR-31' => 152
		}
	},
	{#State 106
		DEFAULT => -75
	},
	{#State 107
		ACTIONS => {
			"]" => 153
		}
	},
	{#State 108
		DEFAULT => -12
	},
	{#State 109
		ACTIONS => {
			";" => 154
		}
	},
	{#State 110
		ACTIONS => {
			'WORD_SCOPED' => 155
		},
		GOTOS => {
			'PLUS-34' => 156
		}
	},
	{#State 111
		ACTIONS => {
			";" => 157
		}
	},
	{#State 112
		DEFAULT => -90
	},
	{#State 113
		ACTIONS => {
			";" => 159,
			'OP19_VARIABLE_ASSIGN' => 158
		}
	},
	{#State 114
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Operator' => 48,
			'Variable' => 55,
			'Expression' => 160
		}
	},
	{#State 115
		ACTIONS => {
			"integer" => 161
		}
	},
	{#State 116
		ACTIONS => {
			'TYPE' => 162
		}
	},
	{#State 117
		DEFAULT => -86
	},
	{#State 118
		ACTIONS => {
			'OP01_NAMED' => 29,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'WORD_SCOPED' => 30,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'OP10_NAMED_UNARY' => 44,
			"%{" => 163,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 165,
			'HashEntryValue' => 164,
			'Operator' => 48
		}
	},
	{#State 119
		DEFAULT => -45
	},
	{#State 120
		ACTIONS => {
			")" => 166
		}
	},
	{#State 121
		ACTIONS => {
			")" => 167
		}
	},
	{#State 122
		DEFAULT => -79
	},
	{#State 123
		ACTIONS => {
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Operator' => 48,
			'Expression' => 168,
			'Variable' => 55
		}
	},
	{#State 124
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'OP10_NAMED_UNARY' => 44,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Variable' => 55,
			'Expression' => 169,
			'Operator' => 48
		}
	},
	{#State 125
		DEFAULT => -115
	},
	{#State 126
		ACTIONS => {
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -57,
			'OP11_COMPARE_LT_GT' => -57,
			'OP17_LIST_RANGE' => -57,
			'OP06_REGEX_MATCH' => 82,
			'OP13_BITWISE_AND' => -57,
			'OP12_COMPARE_EQ_NEQ' => -57,
			".." => -57,
			"}" => -57,
			'OP24_LOGICAL_OR_XOR' => -57,
			'OP08_STRING_CAT' => 87,
			'OP18_TERNARY' => -57,
			'OP23_LOGICAL_AND' => -57,
			'OP09_BITWISE_SHIFT' => -57,
			'OP14_BITWISE_OR_XOR' => -57,
			"]" => -57,
			'OP08_MATH_ADD_SUB' => 79,
			";" => -57,
			'OP15_LOGICAL_AND' => -57,
			")" => -57,
			'OP16_LOGICAL_OR' => -57,
			'OP07_MATH_MULT_DIV_MOD' => 77
		}
	},
	{#State 127
		ACTIONS => {
			'OP18_TERNARY' => 75,
			"]" => -68,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => -68,
			'OP14_BITWISE_OR_XOR' => 74,
			";" => -68,
			'OP08_MATH_ADD_SUB' => 79,
			'OP15_LOGICAL_AND' => 76,
			'OP16_LOGICAL_OR' => 78,
			")" => -68,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP21_LIST_COMMA' => -68,
			'OP04_MATH_POW' => 85,
			'OP11_COMPARE_LT_GT' => 86,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			".." => -68,
			'OP17_LIST_RANGE' => 81,
			'OP06_REGEX_MATCH' => 82,
			"}" => -68,
			'OP24_LOGICAL_OR_XOR' => -68,
			'OP08_STRING_CAT' => 87
		}
	},
	{#State 128
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -62,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => -62,
			".." => -62,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			'OP24_LOGICAL_OR_XOR' => -62,
			"}" => -62,
			'OP08_STRING_CAT' => 87,
			'OP18_TERNARY' => -62,
			'OP14_BITWISE_OR_XOR' => -62,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => -62,
			"]" => -62,
			'OP08_MATH_ADD_SUB' => 79,
			";" => -62,
			")" => -62,
			'OP16_LOGICAL_OR' => -62,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP15_LOGICAL_AND' => -62
		}
	},
	{#State 129
		ACTIONS => {
			":" => 170
		}
	},
	{#State 130
		ACTIONS => {
			'OP18_TERNARY' => -63,
			"]" => -63,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => -63,
			";" => -63,
			'OP08_MATH_ADD_SUB' => 79,
			")" => -63,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => -63,
			'OP15_LOGICAL_AND' => -63,
			'OP11_COMPARE_LT_GT' => 86,
			'OP21_LIST_COMMA' => -63,
			'OP04_MATH_POW' => 85,
			".." => -63,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => -63,
			'OP24_LOGICAL_OR_XOR' => -63,
			"}" => -63,
			'OP08_STRING_CAT' => 87
		}
	},
	{#State 131
		ACTIONS => {
			"}" => -54,
			'OP24_LOGICAL_OR_XOR' => -54,
			'OP08_STRING_CAT' => -54,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -54,
			'OP11_COMPARE_LT_GT' => -54,
			'OP17_LIST_RANGE' => -54,
			'OP06_REGEX_MATCH' => 82,
			'OP13_BITWISE_AND' => -54,
			'OP12_COMPARE_EQ_NEQ' => -54,
			".." => -54,
			'OP08_MATH_ADD_SUB' => -54,
			";" => -54,
			'OP15_LOGICAL_AND' => -54,
			")" => -54,
			'OP16_LOGICAL_OR' => -54,
			'OP07_MATH_MULT_DIV_MOD' => -54,
			'OP18_TERNARY' => -54,
			'OP09_BITWISE_SHIFT' => -54,
			'OP23_LOGICAL_AND' => -54,
			'OP14_BITWISE_OR_XOR' => -54,
			"]" => -54
		}
	},
	{#State 132
		ACTIONS => {
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => -64,
			'OP14_BITWISE_OR_XOR' => 74,
			"]" => -64,
			'OP18_TERNARY' => -64,
			'OP15_LOGICAL_AND' => 76,
			")" => -64,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => -64,
			'OP08_MATH_ADD_SUB' => 79,
			";" => -64,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => -64,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			".." => -64,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -64,
			'OP11_COMPARE_LT_GT' => 86,
			'OP08_STRING_CAT' => 87,
			"}" => -64,
			'OP24_LOGICAL_OR_XOR' => -64
		}
	},
	{#State 133
		ACTIONS => {
			".." => -55,
			'OP12_COMPARE_EQ_NEQ' => -55,
			'OP13_BITWISE_AND' => -55,
			'OP17_LIST_RANGE' => -55,
			'OP06_REGEX_MATCH' => 82,
			'OP11_COMPARE_LT_GT' => -55,
			'OP21_LIST_COMMA' => -55,
			'OP04_MATH_POW' => 85,
			'OP08_STRING_CAT' => -55,
			'OP24_LOGICAL_OR_XOR' => -55,
			"}" => -55,
			"]" => -55,
			'OP14_BITWISE_OR_XOR' => -55,
			'OP23_LOGICAL_AND' => -55,
			'OP09_BITWISE_SHIFT' => -55,
			'OP18_TERNARY' => -55,
			")" => -55,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => -55,
			'OP15_LOGICAL_AND' => -55,
			";" => -55,
			'OP08_MATH_ADD_SUB' => -55
		}
	},
	{#State 134
		ACTIONS => {
			"}" => -65,
			'OP24_LOGICAL_OR_XOR' => -65,
			'OP08_STRING_CAT' => 87,
			'OP21_LIST_COMMA' => -65,
			'OP04_MATH_POW' => 85,
			'OP11_COMPARE_LT_GT' => 86,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			".." => -65,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => undef,
			";" => -65,
			'OP08_MATH_ADD_SUB' => 79,
			'OP15_LOGICAL_AND' => 76,
			")" => -65,
			'OP16_LOGICAL_OR' => 78,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP18_TERNARY' => -65,
			"]" => -65,
			'OP23_LOGICAL_AND' => -65,
			'OP09_BITWISE_SHIFT' => 72,
			'OP14_BITWISE_OR_XOR' => 74
		}
	},
	{#State 135
		ACTIONS => {
			'OP06_REGEX_PATTERN' => 171
		}
	},
	{#State 136
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 86,
			'OP21_LIST_COMMA' => -60,
			'OP04_MATH_POW' => 85,
			".." => -60,
			'OP13_BITWISE_AND' => -60,
			'OP12_COMPARE_EQ_NEQ' => undef,
			'OP17_LIST_RANGE' => -60,
			'OP06_REGEX_MATCH' => 82,
			'OP24_LOGICAL_OR_XOR' => -60,
			"}" => -60,
			'OP08_STRING_CAT' => 87,
			'OP18_TERNARY' => -60,
			"]" => -60,
			'OP14_BITWISE_OR_XOR' => -60,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => -60,
			";" => -60,
			'OP08_MATH_ADD_SUB' => 79,
			")" => -60,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => -60,
			'OP15_LOGICAL_AND' => -60
		}
	},
	{#State 137
		ACTIONS => {
			'OP08_STRING_CAT' => 87,
			"}" => -61,
			'OP24_LOGICAL_OR_XOR' => -61,
			'OP17_LIST_RANGE' => -61,
			'OP06_REGEX_MATCH' => 82,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => -61,
			".." => -61,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -61,
			'OP11_COMPARE_LT_GT' => 86,
			'OP15_LOGICAL_AND' => -61,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			")" => -61,
			'OP16_LOGICAL_OR' => -61,
			'OP08_MATH_ADD_SUB' => 79,
			";" => -61,
			'OP23_LOGICAL_AND' => -61,
			'OP09_BITWISE_SHIFT' => 72,
			'OP14_BITWISE_OR_XOR' => -61,
			"]" => -61,
			'OP18_TERNARY' => -61
		}
	},
	{#State 138
		ACTIONS => {
			"]" => -50,
			'OP14_BITWISE_OR_XOR' => -50,
			'OP23_LOGICAL_AND' => -50,
			'OP09_BITWISE_SHIFT' => -50,
			'OP18_TERNARY' => -50,
			")" => -50,
			'OP07_MATH_MULT_DIV_MOD' => -50,
			'OP16_LOGICAL_OR' => -50,
			'OP15_LOGICAL_AND' => -50,
			";" => -50,
			'OP08_MATH_ADD_SUB' => -50,
			".." => -50,
			'OP13_BITWISE_AND' => -50,
			'OP12_COMPARE_EQ_NEQ' => -50,
			'OP06_REGEX_MATCH' => -50,
			'OP17_LIST_RANGE' => -50,
			'OP11_COMPARE_LT_GT' => -50,
			'OP21_LIST_COMMA' => -50,
			'OP04_MATH_POW' => 85,
			'OP08_STRING_CAT' => -50,
			'OP24_LOGICAL_OR_XOR' => -50,
			"}" => -50
		}
	},
	{#State 139
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => undef,
			'OP21_LIST_COMMA' => -59,
			'OP04_MATH_POW' => 85,
			".." => -59,
			'OP12_COMPARE_EQ_NEQ' => -59,
			'OP13_BITWISE_AND' => -59,
			'OP17_LIST_RANGE' => -59,
			'OP06_REGEX_MATCH' => 82,
			'OP24_LOGICAL_OR_XOR' => -59,
			"}" => -59,
			'OP08_STRING_CAT' => 87,
			'OP18_TERNARY' => -59,
			"]" => -59,
			'OP14_BITWISE_OR_XOR' => -59,
			'OP23_LOGICAL_AND' => -59,
			'OP09_BITWISE_SHIFT' => 72,
			";" => -59,
			'OP08_MATH_ADD_SUB' => 79,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			")" => -59,
			'OP16_LOGICAL_OR' => -59,
			'OP15_LOGICAL_AND' => -59
		}
	},
	{#State 140
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => -56,
			'OP21_LIST_COMMA' => -56,
			'OP04_MATH_POW' => 85,
			".." => -56,
			'OP12_COMPARE_EQ_NEQ' => -56,
			'OP13_BITWISE_AND' => -56,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => -56,
			'OP24_LOGICAL_OR_XOR' => -56,
			"}" => -56,
			'OP08_STRING_CAT' => -56,
			'OP18_TERNARY' => -56,
			"]" => -56,
			'OP14_BITWISE_OR_XOR' => -56,
			'OP23_LOGICAL_AND' => -56,
			'OP09_BITWISE_SHIFT' => -56,
			";" => -56,
			'OP08_MATH_ADD_SUB' => 79,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			")" => -56,
			'OP16_LOGICAL_OR' => -56,
			'OP15_LOGICAL_AND' => -56
		}
	},
	{#State 141
		ACTIONS => {
			"]" => -69,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => 73,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP18_TERNARY' => 75,
			'OP15_LOGICAL_AND' => 76,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			")" => -69,
			'OP16_LOGICAL_OR' => 78,
			";" => -69,
			'OP08_MATH_ADD_SUB' => 79,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			".." => -69,
			'OP17_LIST_RANGE' => 81,
			'OP06_REGEX_MATCH' => 82,
			'OP21_LIST_COMMA' => -69,
			'OP04_MATH_POW' => 85,
			'OP11_COMPARE_LT_GT' => 86,
			'OP08_STRING_CAT' => 87,
			"}" => -69,
			'OP24_LOGICAL_OR_XOR' => -69
		}
	},
	{#State 142
		ACTIONS => {
			")" => 172
		}
	},
	{#State 143
		DEFAULT => -70
	},
	{#State 144
		DEFAULT => -74
	},
	{#State 145
		DEFAULT => -72
	},
	{#State 146
		ACTIONS => {
			'OP18_TERNARY' => 75,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			";" => 173,
			'OP08_MATH_ADD_SUB' => 79,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => 78,
			'OP15_LOGICAL_AND' => 76,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			'OP17_LIST_RANGE' => 81,
			'OP06_REGEX_MATCH' => 82,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP08_STRING_CAT' => 87
		}
	},
	{#State 147
		ACTIONS => {
			"(" => 174
		}
	},
	{#State 148
		ACTIONS => {
			'OP08_STRING_CAT' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP04_MATH_POW' => 85,
			'OP11_COMPARE_LT_GT' => 86,
			'OP15_LOGICAL_AND' => 76,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			")" => 175,
			'OP16_LOGICAL_OR' => 78,
			'OP08_MATH_ADD_SUB' => 79,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP18_TERNARY' => 75
		}
	},
	{#State 149
		ACTIONS => {
			"=" => 176
		}
	},
	{#State 150
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31
		},
		GOTOS => {
			'Variable' => 177
		}
	},
	{#State 151
		ACTIONS => {
			"}" => 178
		}
	},
	{#State 152
		ACTIONS => {
			'OP21_LIST_COMMA' => 180,
			"]" => -126,
			")" => -126
		},
		GOTOS => {
			'PAREN-30' => 179
		}
	},
	{#State 153
		DEFAULT => -85
	},
	{#State 154
		DEFAULT => -14
	},
	{#State 155
		DEFAULT => -137
	},
	{#State 156
		ACTIONS => {
			'WORD_SCOPED' => 182,
			")" => 181
		}
	},
	{#State 157
		ACTIONS => {
			"our" => 183
		}
	},
	{#State 158
		ACTIONS => {
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Operator' => 48,
			'Variable' => 55,
			'Expression' => 184
		}
	},
	{#State 159
		DEFAULT => -120
	},
	{#State 160
		ACTIONS => {
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP08_STRING_CAT' => 87,
			'OP18_TERNARY' => 75,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			'OP08_MATH_ADD_SUB' => 79,
			")" => 185,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => 78,
			'OP15_LOGICAL_AND' => 76
		}
	},
	{#State 161
		ACTIONS => {
			'VARIABLE_SYMBOL' => 186
		}
	},
	{#State 162
		ACTIONS => {
			'VARIABLE_SYMBOL' => 187
		}
	},
	{#State 163
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31
		},
		GOTOS => {
			'Variable' => 188
		}
	},
	{#State 164
		DEFAULT => -132,
		GOTOS => {
			'STAR-33' => 189
		}
	},
	{#State 165
		ACTIONS => {
			'OP08_STRING_CAT' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			"}" => -134,
			'OP17_LIST_RANGE' => 81,
			'OP06_REGEX_MATCH' => 82,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP21_LIST_COMMA' => -134,
			'OP16_LOGICAL_OR' => 78,
			")" => -134,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP15_LOGICAL_AND' => 76,
			'OP08_MATH_ADD_SUB' => 79,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => 73,
			'OP18_TERNARY' => 75
		}
	},
	{#State 166
		DEFAULT => -47
	},
	{#State 167
		DEFAULT => -88
	},
	{#State 168
		ACTIONS => {
			'OP18_TERNARY' => 75,
			"]" => 190,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			'OP08_MATH_ADD_SUB' => 79,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => 78,
			'OP15_LOGICAL_AND' => 76,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP17_LIST_RANGE' => 81,
			'OP06_REGEX_MATCH' => 82,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP08_STRING_CAT' => 87
		}
	},
	{#State 169
		ACTIONS => {
			'OP16_LOGICAL_OR' => 78,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP15_LOGICAL_AND' => 76,
			'OP08_MATH_ADD_SUB' => 79,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => 73,
			'OP18_TERNARY' => 75,
			'OP08_STRING_CAT' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			"}" => 191,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85
		}
	},
	{#State 170
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31
		},
		GOTOS => {
			'Variable' => 192
		}
	},
	{#State 171
		ACTIONS => {
			"/" => 193
		}
	},
	{#State 172
		ACTIONS => {
			";" => 194
		}
	},
	{#State 173
		DEFAULT => -122
	},
	{#State 174
		ACTIONS => {
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			"{" => 28,
			")" => -82,
			'VARIABLE_SYMBOL' => 31,
			"\@{" => 103,
			'KEYS_OR_VALUES' => 102,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'OP10_NAMED_UNARY' => 44,
			'OP03_MATH_INC_DEC' => 45,
			"[" => 49
		},
		GOTOS => {
			'ListElementValue' => 105,
			'Variable' => 55,
			'Expression' => 104,
			'OPTIONAL-21' => 196,
			'Operator' => 48,
			'ListElements' => 195
		}
	},
	{#State 175
		ACTIONS => {
			"{" => 198
		},
		GOTOS => {
			'CodeBlock' => 197
		}
	},
	{#State 176
		ACTIONS => {
			"sub" => 199
		}
	},
	{#State 177
		ACTIONS => {
			"}" => 200
		}
	},
	{#State 178
		DEFAULT => -128
	},
	{#State 179
		DEFAULT => -124
	},
	{#State 180
		ACTIONS => {
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP10_NAMED_UNARY' => 44,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'KEYS_OR_VALUES' => 102,
			"\@{" => 103
		},
		GOTOS => {
			'Operator' => 48,
			'ListElementValue' => 201,
			'Variable' => 55,
			'Expression' => 104
		}
	},
	{#State 181
		ACTIONS => {
			";" => 202
		}
	},
	{#State 182
		DEFAULT => -136
	},
	{#State 183
		ACTIONS => {
			"\$VERSION" => 203
		}
	},
	{#State 184
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 79,
			";" => 204,
			'OP16_LOGICAL_OR' => 78,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP15_LOGICAL_AND' => 76,
			'OP18_TERNARY' => 75,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP09_BITWISE_SHIFT' => 72,
			'OP23_LOGICAL_AND' => 73,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP08_STRING_CAT' => 87,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84
		}
	},
	{#State 185
		ACTIONS => {
			"{" => 198
		},
		GOTOS => {
			'CodeBlock' => 205
		}
	},
	{#State 186
		ACTIONS => {
			"(" => 206
		}
	},
	{#State 187
		ACTIONS => {
			"(" => 207
		}
	},
	{#State 188
		ACTIONS => {
			"}" => 208
		}
	},
	{#State 189
		ACTIONS => {
			"}" => -133,
			'OP21_LIST_COMMA' => 209,
			")" => -133
		},
		GOTOS => {
			'PAREN-32' => 210
		}
	},
	{#State 190
		DEFAULT => -118
	},
	{#State 191
		DEFAULT => -119
	},
	{#State 192
		DEFAULT => -66
	},
	{#State 193
		DEFAULT => -53
	},
	{#State 194
		DEFAULT => -73
	},
	{#State 195
		DEFAULT => -81
	},
	{#State 196
		ACTIONS => {
			")" => 211
		}
	},
	{#State 197
		DEFAULT => -101,
		GOTOS => {
			'STAR-25' => 212
		}
	},
	{#State 198
		ACTIONS => {
			"foreach" => -93,
			"my" => 22,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21,
			"for" => -93,
			"while" => -93,
			'VARIABLE_SYMBOL' => 31,
			"{" => 28,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			'OP01_NAMED_VOID' => 33,
			'OP19_LOOP_CONTROL' => 37,
			"if" => 43,
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'LOOP_LABEL' => 41,
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45
		},
		GOTOS => {
			'PLUS-28' => 214,
			'Operator' => 48,
			'PAREN-22' => 47,
			'Variable' => 42,
			'OPTIONAL-23' => 27,
			'Operation' => 213,
			'Statement' => 35,
			'VariableModification' => 36,
			'OperatorVoid' => 20,
			'Conditional' => 34,
			'VariableDeclaration' => 19,
			'Expression' => 32
		}
	},
	{#State 199
		ACTIONS => {
			"{" => 215
		}
	},
	{#State 200
		DEFAULT => -129
	},
	{#State 201
		DEFAULT => -123
	},
	{#State 202
		ACTIONS => {
			"our" => 217
		},
		GOTOS => {
			'Properties' => 216
		}
	},
	{#State 203
		ACTIONS => {
			"=" => 218
		}
	},
	{#State 204
		DEFAULT => -121
	},
	{#State 205
		DEFAULT => -111
	},
	{#State 206
		ACTIONS => {
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38
		},
		GOTOS => {
			'Expression' => 219,
			'Variable' => 55,
			'Operator' => 48
		}
	},
	{#State 207
		ACTIONS => {
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'KEYS_OR_VALUES' => 102,
			"\@{" => 103,
			'WORD_SCOPED' => 30,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP01_NAMED' => 29,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP10_NAMED_UNARY' => 44
		},
		GOTOS => {
			'Expression' => 104,
			'Variable' => 55,
			'ListElementValue' => 105,
			'ListElements' => 220,
			'Operator' => 48
		}
	},
	{#State 208
		DEFAULT => -135
	},
	{#State 209
		ACTIONS => {
			'WORD' => 221
		}
	},
	{#State 210
		DEFAULT => -131
	},
	{#State 211
		DEFAULT => -89
	},
	{#State 212
		ACTIONS => {
			'OP19_LOOP_CONTROL' => -104,
			'OP01_NAMED_VOID' => -104,
			'' => -104,
			"[" => -104,
			'OP03_MATH_INC_DEC' => -104,
			"if" => -104,
			'OP10_NAMED_UNARY' => -104,
			"}" => -104,
			'OP05_LOGICAL_NEG' => -104,
			'LITERAL' => -104,
			'OP05_MATH_NEG' => -104,
			'LOOP_LABEL' => -104,
			"my" => -104,
			'OP22_LOGICAL_NOT' => -104,
			'OP01_PARENTHESIS' => -104,
			"else" => 222,
			"elsif" => 223,
			"foreach" => -104,
			"while" => -104,
			"for" => -104,
			'VARIABLE_SYMBOL' => -104,
			"{" => -104,
			'OP01_NAMED' => -104,
			'WORD_SCOPED' => -104
		},
		GOTOS => {
			'PAREN-26' => 226,
			'PAREN-24' => 225,
			'OPTIONAL-27' => 224
		}
	},
	{#State 213
		DEFAULT => -113
	},
	{#State 214
		ACTIONS => {
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45,
			'OP10_NAMED_UNARY' => 44,
			"}" => 228,
			"if" => 43,
			'LOOP_LABEL' => 41,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP19_LOOP_CONTROL' => 37,
			'OP01_NAMED_VOID' => 33,
			'VARIABLE_SYMBOL' => 31,
			"while" => -93,
			"for" => -93,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			"{" => 28,
			"my" => 22,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21,
			"foreach" => -93
		},
		GOTOS => {
			'Statement' => 35,
			'VariableModification' => 36,
			'VariableDeclaration' => 19,
			'Expression' => 32,
			'OperatorVoid' => 20,
			'Conditional' => 34,
			'PAREN-22' => 47,
			'Operator' => 48,
			'Variable' => 42,
			'OPTIONAL-23' => 27,
			'Operation' => 227
		}
	},
	{#State 215
		ACTIONS => {
			"if" => -35,
			'OP10_NAMED_UNARY' => -35,
			'LITERAL' => -35,
			'OP05_LOGICAL_NEG' => -35,
			'OP05_MATH_NEG' => -35,
			'LOOP_LABEL' => -35,
			"[" => -35,
			'OP03_MATH_INC_DEC' => -35,
			'OP01_NAMED_VOID' => -35,
			'OP19_LOOP_CONTROL' => -35,
			'ARGUMENTS_BEGIN' => 229,
			"while" => -35,
			"for" => -35,
			'VARIABLE_SYMBOL' => -35,
			"{" => -35,
			'OP01_NAMED' => -35,
			'WORD_SCOPED' => -35,
			"foreach" => -35,
			"my" => -35,
			'OP22_LOGICAL_NOT' => -35,
			'OP01_PARENTHESIS' => -35
		},
		GOTOS => {
			'OPTIONAL-12' => 230,
			'SubroutineArguments' => 231
		}
	},
	{#State 216
		DEFAULT => -139,
		GOTOS => {
			'STAR-35' => 232
		}
	},
	{#State 217
		ACTIONS => {
			"%properties" => 233
		}
	},
	{#State 218
		ACTIONS => {
			'VERSION_NUMBER' => 234
		}
	},
	{#State 219
		ACTIONS => {
			'OP08_MATH_ADD_SUB' => 79,
			'OP15_LOGICAL_AND' => 76,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => 78,
			'OP18_TERNARY' => 75,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP08_STRING_CAT' => 87,
			'OP04_MATH_POW' => 85,
			'OP11_COMPARE_LT_GT' => 86,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			".." => 235
		}
	},
	{#State 220
		ACTIONS => {
			")" => 236
		}
	},
	{#State 221
		ACTIONS => {
			'OP20_HASH_FATARROW' => 237
		}
	},
	{#State 222
		ACTIONS => {
			"{" => 198
		},
		GOTOS => {
			'CodeBlock' => 238
		}
	},
	{#State 223
		ACTIONS => {
			"(" => 239
		}
	},
	{#State 224
		DEFAULT => -105
	},
	{#State 225
		DEFAULT => -100
	},
	{#State 226
		DEFAULT => -103
	},
	{#State 227
		DEFAULT => -112
	},
	{#State 228
		DEFAULT => -114
	},
	{#State 229
		ACTIONS => {
			'TYPE' => 240
		}
	},
	{#State 230
		ACTIONS => {
			"if" => 43,
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'LOOP_LABEL' => 41,
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED_VOID' => 33,
			'OP19_LOOP_CONTROL' => 37,
			"for" => -93,
			"while" => -93,
			'VARIABLE_SYMBOL' => 31,
			"{" => 28,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30,
			"foreach" => -93,
			"my" => 22,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Conditional' => 34,
			'OperatorVoid' => 20,
			'Expression' => 32,
			'VariableDeclaration' => 19,
			'PLUS-13' => 242,
			'VariableModification' => 36,
			'Statement' => 35,
			'OPTIONAL-23' => 27,
			'Operation' => 241,
			'Variable' => 42,
			'Operator' => 48,
			'PAREN-22' => 47
		}
	},
	{#State 231
		DEFAULT => -34
	},
	{#State 232
		ACTIONS => {
			"1" => 244,
			"our" => 243
		},
		GOTOS => {
			'Method' => 245
		}
	},
	{#State 233
		ACTIONS => {
			"=" => 246
		}
	},
	{#State 234
		ACTIONS => {
			";" => 247
		}
	},
	{#State 235
		ACTIONS => {
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP10_NAMED_UNARY' => 44,
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23
		},
		GOTOS => {
			'Operator' => 48,
			'Expression' => 248,
			'Variable' => 55
		}
	},
	{#State 236
		ACTIONS => {
			"{" => 198
		},
		GOTOS => {
			'CodeBlock' => 249
		}
	},
	{#State 237
		ACTIONS => {
			'VARIABLE_SYMBOL' => 31,
			"[" => 49,
			'WORD_SCOPED' => 30,
			'OP03_MATH_INC_DEC' => 45,
			"{" => 28,
			'OP01_NAMED' => 29,
			"%{" => 163,
			'OP10_NAMED_UNARY' => 44,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP22_LOGICAL_NOT' => 23,
			'OP01_PARENTHESIS' => 21
		},
		GOTOS => {
			'Operator' => 48,
			'HashEntryValue' => 250,
			'Variable' => 55,
			'Expression' => 165
		}
	},
	{#State 238
		DEFAULT => -102
	},
	{#State 239
		ACTIONS => {
			'OP01_PARENTHESIS' => 21,
			'OP22_LOGICAL_NOT' => 23,
			'OP05_MATH_NEG' => 40,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP10_NAMED_UNARY' => 44,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP03_MATH_INC_DEC' => 45,
			'OP01_NAMED' => 29,
			"[" => 49,
			'VARIABLE_SYMBOL' => 31
		},
		GOTOS => {
			'Operator' => 48,
			'Variable' => 55,
			'Expression' => 251
		}
	},
	{#State 240
		ACTIONS => {
			'VARIABLE_SYMBOL' => 252
		}
	},
	{#State 241
		DEFAULT => -37
	},
	{#State 242
		ACTIONS => {
			'OP01_NAMED_VOID' => 33,
			'OP19_LOOP_CONTROL' => 37,
			'LOOP_LABEL' => 41,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			"}" => 253,
			'OP10_NAMED_UNARY' => 44,
			"if" => 43,
			'OP03_MATH_INC_DEC' => 45,
			"[" => 49,
			"foreach" => -93,
			'OP01_PARENTHESIS' => 21,
			"my" => 22,
			'OP22_LOGICAL_NOT' => 23,
			'WORD_SCOPED' => 30,
			'OP01_NAMED' => 29,
			"{" => 28,
			'VARIABLE_SYMBOL' => 31,
			"while" => -93,
			"for" => -93
		},
		GOTOS => {
			'VariableModification' => 36,
			'Statement' => 35,
			'VariableDeclaration' => 19,
			'Expression' => 32,
			'OperatorVoid' => 20,
			'Conditional' => 34,
			'PAREN-22' => 47,
			'Operator' => 48,
			'Variable' => 42,
			'Operation' => 254,
			'OPTIONAL-23' => 27
		}
	},
	{#State 243
		ACTIONS => {
			'TYPE' => 255
		}
	},
	{#State 244
		ACTIONS => {
			";" => 256
		}
	},
	{#State 245
		DEFAULT => -138
	},
	{#State 246
		ACTIONS => {
			"(" => 257
		}
	},
	{#State 247
		ACTIONS => {
			"use" => 258
		}
	},
	{#State 248
		ACTIONS => {
			'OP08_STRING_CAT' => 87,
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP13_BITWISE_AND' => 84,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP04_MATH_POW' => 85,
			'OP11_COMPARE_LT_GT' => 86,
			'OP15_LOGICAL_AND' => 76,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP16_LOGICAL_OR' => 78,
			")" => 259,
			'OP08_MATH_ADD_SUB' => 79,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP18_TERNARY' => 75
		}
	},
	{#State 249
		DEFAULT => -110
	},
	{#State 250
		DEFAULT => -130
	},
	{#State 251
		ACTIONS => {
			'OP24_LOGICAL_OR_XOR' => 88,
			'OP08_STRING_CAT' => 87,
			'OP11_COMPARE_LT_GT' => 86,
			'OP04_MATH_POW' => 85,
			'OP13_BITWISE_AND' => 84,
			'OP12_COMPARE_EQ_NEQ' => 83,
			'OP06_REGEX_MATCH' => 82,
			'OP17_LIST_RANGE' => 81,
			'OP08_MATH_ADD_SUB' => 79,
			")" => 260,
			'OP16_LOGICAL_OR' => 78,
			'OP07_MATH_MULT_DIV_MOD' => 77,
			'OP15_LOGICAL_AND' => 76,
			'OP18_TERNARY' => 75,
			'OP14_BITWISE_OR_XOR' => 74,
			'OP23_LOGICAL_AND' => 73,
			'OP09_BITWISE_SHIFT' => 72
		}
	},
	{#State 252
		DEFAULT => -41,
		GOTOS => {
			'STAR-15' => 261
		}
	},
	{#State 253
		ACTIONS => {
			";" => 262
		}
	},
	{#State 254
		DEFAULT => -36
	},
	{#State 255
		ACTIONS => {
			'VARIABLE_SYMBOL' => 263
		}
	},
	{#State 256
		ACTIONS => {
			'' => -144,
			"our" => 46,
			"package" => -144
		},
		GOTOS => {
			'OPTIONAL-38' => 265,
			'PAREN-37' => 266,
			'PLUS-36' => 267,
			'Subroutine' => 264
		}
	},
	{#State 257
		ACTIONS => {
			'WORD' => 68,
			")" => -147
		},
		GOTOS => {
			'HashEntries' => 269,
			'OPTIONAL-39' => 268
		}
	},
	{#State 258
		ACTIONS => {
			"Carp" => 270
		}
	},
	{#State 259
		ACTIONS => {
			"{" => 198
		},
		GOTOS => {
			'CodeBlock' => 271
		}
	},
	{#State 260
		ACTIONS => {
			"{" => 198
		},
		GOTOS => {
			'CodeBlock' => 272
		}
	},
	{#State 261
		ACTIONS => {
			'OP21_LIST_COMMA' => 273,
			'ARGUMENTS_END' => 275
		},
		GOTOS => {
			'PAREN-14' => 274
		}
	},
	{#State 262
		DEFAULT => -38
	},
	{#State 263
		ACTIONS => {
			"=" => 276
		}
	},
	{#State 264
		DEFAULT => -141
	},
	{#State 265
		DEFAULT => -145
	},
	{#State 266
		DEFAULT => -143
	},
	{#State 267
		ACTIONS => {
			"our" => 46,
			"1" => 277
		},
		GOTOS => {
			'Subroutine' => 278
		}
	},
	{#State 268
		ACTIONS => {
			")" => 279
		}
	},
	{#State 269
		DEFAULT => -146
	},
	{#State 270
		ACTIONS => {
			";" => 280
		}
	},
	{#State 271
		DEFAULT => -109
	},
	{#State 272
		DEFAULT => -99
	},
	{#State 273
		ACTIONS => {
			"my" => 281
		}
	},
	{#State 274
		DEFAULT => -40
	},
	{#State 275
		DEFAULT => -42
	},
	{#State 276
		ACTIONS => {
			"sub" => 282
		}
	},
	{#State 277
		ACTIONS => {
			";" => 283
		}
	},
	{#State 278
		DEFAULT => -140
	},
	{#State 279
		ACTIONS => {
			";" => 284
		}
	},
	{#State 280
		ACTIONS => {
			"use" => 285
		}
	},
	{#State 281
		ACTIONS => {
			'TYPE' => 286
		}
	},
	{#State 282
		ACTIONS => {
			"{" => 287
		}
	},
	{#State 283
		DEFAULT => -142
	},
	{#State 284
		DEFAULT => -148
	},
	{#State 285
		ACTIONS => {
			"RPerl" => 288
		}
	},
	{#State 286
		ACTIONS => {
			'VARIABLE_SYMBOL' => 289
		}
	},
	{#State 287
		ACTIONS => {
			'OP03_MATH_INC_DEC' => -150,
			"[" => -150,
			'OP05_LOGICAL_NEG' => -150,
			'OP05_MATH_NEG' => -150,
			'LITERAL' => -150,
			'LOOP_LABEL' => -150,
			"if" => -150,
			'OP10_NAMED_UNARY' => -150,
			'OP19_LOOP_CONTROL' => -150,
			'OP01_NAMED_VOID' => -150,
			"{" => -150,
			'OP01_NAMED' => -150,
			'WORD_SCOPED' => -150,
			"for" => -150,
			"while" => -150,
			'VARIABLE_SYMBOL' => -150,
			'ARGUMENTS_BEGIN' => 291,
			'OP01_PARENTHESIS' => -150,
			"my" => -150,
			'OP22_LOGICAL_NOT' => -150,
			"foreach" => -150
		},
		GOTOS => {
			'MethodArguments' => 292,
			'OPTIONAL-40' => 290
		}
	},
	{#State 288
		ACTIONS => {
			";" => 293
		}
	},
	{#State 289
		DEFAULT => -39
	},
	{#State 290
		ACTIONS => {
			'OP19_LOOP_CONTROL' => 37,
			'OP01_NAMED_VOID' => 33,
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45,
			"if" => 43,
			'OP10_NAMED_UNARY' => 44,
			'OP05_LOGICAL_NEG' => 39,
			'LITERAL' => 38,
			'OP05_MATH_NEG' => 40,
			'LOOP_LABEL' => 41,
			'OP22_LOGICAL_NOT' => 23,
			"my" => 22,
			'OP01_PARENTHESIS' => 21,
			"foreach" => -93,
			"while" => -93,
			"for" => -93,
			'VARIABLE_SYMBOL' => 31,
			"{" => 28,
			'OP01_NAMED' => 29,
			'WORD_SCOPED' => 30
		},
		GOTOS => {
			'VariableModification' => 36,
			'Statement' => 35,
			'Expression' => 32,
			'VariableDeclaration' => 19,
			'Conditional' => 34,
			'PLUS-41' => 294,
			'OperatorVoid' => 20,
			'PAREN-22' => 47,
			'Operator' => 48,
			'Operation' => 295,
			'OPTIONAL-23' => 27,
			'Variable' => 42
		}
	},
	{#State 291
		ACTIONS => {
			'TYPE_CLASS_OR_SELF' => 296
		}
	},
	{#State 292
		DEFAULT => -149
	},
	{#State 293
		DEFAULT => -16,
		GOTOS => {
			'STAR-5' => 297
		}
	},
	{#State 294
		ACTIONS => {
			"[" => 49,
			'OP03_MATH_INC_DEC' => 45,
			'OP10_NAMED_UNARY' => 44,
			"}" => 299,
			"if" => 43,
			'LOOP_LABEL' => 41,
			'OP05_MATH_NEG' => 40,
			'LITERAL' => 38,
			'OP05_LOGICAL_NEG' => 39,
			'OP19_LOOP_CONTROL' => 37,
			'OP01_NAMED_VOID' => 33,
			'VARIABLE_SYMBOL' => 31,
			"while" => -93,
			"for" => -93,
			'WORD_SCOPED' => 30,
			"{" => 28,
			'OP01_NAMED' => 29,
			'OP22_LOGICAL_NOT' => 23,
			"my" => 22,
			'OP01_PARENTHESIS' => 21,
			"foreach" => -93
		},
		GOTOS => {
			'PAREN-22' => 47,
			'Operator' => 48,
			'OPTIONAL-23' => 27,
			'Operation' => 298,
			'Variable' => 42,
			'Statement' => 35,
			'VariableModification' => 36,
			'Expression' => 32,
			'VariableDeclaration' => 19,
			'Conditional' => 34,
			'OperatorVoid' => 20
		}
	},
	{#State 295
		DEFAULT => -152
	},
	{#State 296
		DEFAULT => -156,
		GOTOS => {
			'STAR-43' => 300
		}
	},
	{#State 297
		ACTIONS => {
			"use constant" => -18,
			'VARIABLE_SYMBOL' => -18,
			"while" => -18,
			"for" => -18,
			'WORD_SCOPED' => -18,
			"{" => -18,
			'OP01_NAMED' => -18,
			"use parent" => -18,
			"foreach" => -18,
			"my" => -18,
			'OP22_LOGICAL_NOT' => -18,
			'OP01_PARENTHESIS' => -18,
			'OP10_NAMED_UNARY' => -18,
			"if" => -18,
			'LOOP_LABEL' => -18,
			'OP05_LOGICAL_NEG' => -18,
			'LITERAL' => -18,
			'OP05_MATH_NEG' => -18,
			"[" => -18,
			'OP03_MATH_INC_DEC' => -18,
			"our" => -18,
			"use" => 301,
			'OP01_NAMED_VOID' => -18,
			'OP19_LOOP_CONTROL' => -18
		},
		GOTOS => {
			'Include' => 302,
			'STAR-6' => 303
		}
	},
	{#State 298
		DEFAULT => -151
	},
	{#State 299
		ACTIONS => {
			";" => 304
		}
	},
	{#State 300
		ACTIONS => {
			'OP21_LIST_COMMA' => 307,
			'ARGUMENTS_END' => 305
		},
		GOTOS => {
			'PAREN-42' => 306
		}
	},
	{#State 301
		ACTIONS => {
			'WORD_SCOPED' => 308
		}
	},
	{#State 302
		DEFAULT => -15
	},
	{#State 303
		ACTIONS => {
			'OP01_PARENTHESIS' => -19,
			"my" => -19,
			'OP22_LOGICAL_NOT' => -19,
			"foreach" => -19,
			"use parent" => -19,
			'WORD_SCOPED' => -19,
			'OP01_NAMED' => -19,
			"{" => -19,
			'VARIABLE_SYMBOL' => -19,
			"for" => -19,
			"while" => -19,
			"use constant" => 310,
			'OP19_LOOP_CONTROL' => -19,
			'OP01_NAMED_VOID' => -19,
			"our" => -19,
			'OP03_MATH_INC_DEC' => -19,
			"[" => -19,
			'LOOP_LABEL' => -19,
			'OP05_LOGICAL_NEG' => -19,
			'LITERAL' => -19,
			'OP05_MATH_NEG' => -19,
			'OP10_NAMED_UNARY' => -19,
			"if" => -19
		},
		GOTOS => {
			'Constant' => 309
		}
	},
	{#State 304
		DEFAULT => -153
	},
	{#State 305
		DEFAULT => -157
	},
	{#State 306
		DEFAULT => -155
	},
	{#State 307
		ACTIONS => {
			"my" => 311
		}
	},
	{#State 308
		ACTIONS => {
			"qw(" => 313,
			";" => 312
		}
	},
	{#State 309
		DEFAULT => -17
	},
	{#State 310
		ACTIONS => {
			'WORD' => 314
		}
	},
	{#State 311
		ACTIONS => {
			'TYPE' => 315
		}
	},
	{#State 312
		DEFAULT => -22
	},
	{#State 313
		ACTIONS => {
			'WORD' => 317
		},
		GOTOS => {
			'PLUS-7' => 316
		}
	},
	{#State 314
		ACTIONS => {
			'OP20_HASH_FATARROW' => 318
		}
	},
	{#State 315
		ACTIONS => {
			'VARIABLE_SYMBOL' => 319
		}
	},
	{#State 316
		ACTIONS => {
			'WORD' => 320,
			");" => 321
		}
	},
	{#State 317
		DEFAULT => -21
	},
	{#State 318
		ACTIONS => {
			'LITERAL' => 324,
			"[" => 325,
			"{" => 322
		},
		GOTOS => {
			'Constant_Value' => 323
		}
	},
	{#State 319
		DEFAULT => -154
	},
	{#State 320
		DEFAULT => -20
	},
	{#State 321
		DEFAULT => -23
	},
	{#State 322
		ACTIONS => {
			'WORD' => 326
		}
	},
	{#State 323
		ACTIONS => {
			";" => 327
		}
	},
	{#State 324
		DEFAULT => -31
	},
	{#State 325
		ACTIONS => {
			'LITERAL' => 328
		}
	},
	{#State 326
		ACTIONS => {
			'OP20_HASH_FATARROW' => 329
		}
	},
	{#State 327
		DEFAULT => -24
	},
	{#State 328
		DEFAULT => -27,
		GOTOS => {
			'STAR-9' => 330
		}
	},
	{#State 329
		ACTIONS => {
			'LITERAL' => 331
		}
	},
	{#State 330
		ACTIONS => {
			"]" => 333,
			'OP21_LIST_COMMA' => 332
		},
		GOTOS => {
			'PAREN-8' => 334
		}
	},
	{#State 331
		DEFAULT => -30,
		GOTOS => {
			'STAR-11' => 335
		}
	},
	{#State 332
		ACTIONS => {
			'LITERAL' => 336
		}
	},
	{#State 333
		DEFAULT => -32
	},
	{#State 334
		DEFAULT => -26
	},
	{#State 335
		ACTIONS => {
			"}" => 338,
			'OP21_LIST_COMMA' => 337
		},
		GOTOS => {
			'PAREN-10' => 339
		}
	},
	{#State 336
		DEFAULT => -25
	},
	{#State 337
		ACTIONS => {
			'WORD' => 340
		}
	},
	{#State 338
		DEFAULT => -33
	},
	{#State 339
		DEFAULT => -29
	},
	{#State 340
		ACTIONS => {
			'OP20_HASH_FATARROW' => 341
		}
	},
	{#State 341
		ACTIONS => {
			'LITERAL' => 342
		}
	},
	{#State 342
		DEFAULT => -28
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 3919 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 2,
sub {
#line 98 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3926 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-1', 1,
sub {
#line 98 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3933 ./Grammar.pm
	],
	[#Rule CompileUnit_3
		 'CompileUnit', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3940 ./Grammar.pm
	],
	[#Rule CompileUnit_4
		 'CompileUnit', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3947 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 2,
sub {
#line 99 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3954 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-2', 0,
sub {
#line 99 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 3961 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-3', 2,
sub {
#line 99 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 3968 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-3', 1,
sub {
#line 99 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 3975 ./Grammar.pm
	],
	[#Rule Program_9
		 'Program', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3982 ./Grammar.pm
	],
	[#Rule Module_10
		 'Module', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3989 ./Grammar.pm
	],
	[#Rule Module_11
		 'Module', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 3996 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-4', 2,
sub {
#line 101 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4003 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-4', 1,
sub {
#line 101 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4010 ./Grammar.pm
	],
	[#Rule Package_14
		 'Package', 7,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4017 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 2,
sub {
#line 102 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4024 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-5', 0,
sub {
#line 102 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4031 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 2,
sub {
#line 102 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4038 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-6', 0,
sub {
#line 102 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4045 ./Grammar.pm
	],
	[#Rule Header_19
		 'Header', 19,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4052 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-7', 2,
sub {
#line 103 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4059 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-7', 1,
sub {
#line 103 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4066 ./Grammar.pm
	],
	[#Rule Include_22
		 'Include', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4073 ./Grammar.pm
	],
	[#Rule Include_23
		 'Include', 5,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4080 ./Grammar.pm
	],
	[#Rule Constant_24
		 'Constant', 5,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4087 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-8', 2,
sub {
#line 105 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4094 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 2,
sub {
#line 105 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4101 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-9', 0,
sub {
#line 105 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4108 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-10', 4,
sub {
#line 105 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4115 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 2,
sub {
#line 105 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4122 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-11', 0,
sub {
#line 105 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4129 ./Grammar.pm
	],
	[#Rule Constant_Value_31
		 'Constant_Value', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4136 ./Grammar.pm
	],
	[#Rule Constant_Value_32
		 'Constant_Value', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4143 ./Grammar.pm
	],
	[#Rule Constant_Value_33
		 'Constant_Value', 6,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4150 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 1,
sub {
#line 106 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4157 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-12', 0,
sub {
#line 106 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4164 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 2,
sub {
#line 106 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4171 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-13', 1,
sub {
#line 106 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4178 ./Grammar.pm
	],
	[#Rule Subroutine_38
		 'Subroutine', 10,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4185 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-14', 4,
sub {
#line 107 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4192 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-15', 2,
sub {
#line 107 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4199 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-15', 0,
sub {
#line 107 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4206 ./Grammar.pm
	],
	[#Rule SubroutineArguments_42
		 'SubroutineArguments', 5,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4213 ./Grammar.pm
	],
	[#Rule Operation_43
		 'Operation', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4220 ./Grammar.pm
	],
	[#Rule Operation_44
		 'Operation', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4227 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 1,
sub {
#line 110 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4234 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-16', 0,
sub {
#line 110 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4241 ./Grammar.pm
	],
	[#Rule Operator_47
		 'Operator', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4248 ./Grammar.pm
	],
	[#Rule Operator_48
		 'Operator', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4255 ./Grammar.pm
	],
	[#Rule Operator_49
		 'Operator', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4262 ./Grammar.pm
	],
	[#Rule Operator_50
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4269 ./Grammar.pm
	],
	[#Rule Operator_51
		 'Operator', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4276 ./Grammar.pm
	],
	[#Rule Operator_52
		 'Operator', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4283 ./Grammar.pm
	],
	[#Rule Operator_53
		 'Operator', 5,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4290 ./Grammar.pm
	],
	[#Rule Operator_54
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4297 ./Grammar.pm
	],
	[#Rule Operator_55
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4304 ./Grammar.pm
	],
	[#Rule Operator_56
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4311 ./Grammar.pm
	],
	[#Rule Operator_57
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4318 ./Grammar.pm
	],
	[#Rule Operator_58
		 'Operator', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4325 ./Grammar.pm
	],
	[#Rule Operator_59
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4332 ./Grammar.pm
	],
	[#Rule Operator_60
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4339 ./Grammar.pm
	],
	[#Rule Operator_61
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4346 ./Grammar.pm
	],
	[#Rule Operator_62
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4353 ./Grammar.pm
	],
	[#Rule Operator_63
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4360 ./Grammar.pm
	],
	[#Rule Operator_64
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4367 ./Grammar.pm
	],
	[#Rule Operator_65
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4374 ./Grammar.pm
	],
	[#Rule Operator_66
		 'Operator', 5,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4381 ./Grammar.pm
	],
	[#Rule Operator_67
		 'Operator', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4388 ./Grammar.pm
	],
	[#Rule Operator_68
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4395 ./Grammar.pm
	],
	[#Rule Operator_69
		 'Operator', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4402 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 1,
sub {
#line 118 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4409 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-17', 0,
sub {
#line 118 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4416 ./Grammar.pm
	],
	[#Rule OperatorVoid_72
		 'OperatorVoid', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4423 ./Grammar.pm
	],
	[#Rule OperatorVoid_73
		 'OperatorVoid', 5,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4430 ./Grammar.pm
	],
	[#Rule OperatorVoid_74
		 'OperatorVoid', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4437 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 1,
sub {
#line 119 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4444 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-18', 0,
sub {
#line 119 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4451 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 1,
sub {
#line 119 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4458 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-19', 0,
sub {
#line 119 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4465 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-20', 1,
sub {
#line 120 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4472 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-20', 0,
sub {
#line 120 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4479 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 1,
sub {
#line 120 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4486 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-21', 0,
sub {
#line 120 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4493 ./Grammar.pm
	],
	[#Rule Expression_83
		 'Expression', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4500 ./Grammar.pm
	],
	[#Rule Expression_84
		 'Expression', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4507 ./Grammar.pm
	],
	[#Rule Expression_85
		 'Expression', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4514 ./Grammar.pm
	],
	[#Rule Expression_86
		 'Expression', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4521 ./Grammar.pm
	],
	[#Rule Expression_87
		 'Expression', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4528 ./Grammar.pm
	],
	[#Rule Expression_88
		 'Expression', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4535 ./Grammar.pm
	],
	[#Rule Expression_89
		 'Expression', 6,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4542 ./Grammar.pm
	],
	[#Rule Expression_90
		 'Expression', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4549 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-22', 2,
sub {
#line 121 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4556 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 1,
sub {
#line 121 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4563 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-23', 0,
sub {
#line 121 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4570 ./Grammar.pm
	],
	[#Rule Statement_94
		 'Statement', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4577 ./Grammar.pm
	],
	[#Rule Statement_95
		 'Statement', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4584 ./Grammar.pm
	],
	[#Rule Statement_96
		 'Statement', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4591 ./Grammar.pm
	],
	[#Rule Statement_97
		 'Statement', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4598 ./Grammar.pm
	],
	[#Rule Statement_98
		 'Statement', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4605 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-24', 5,
sub {
#line 122 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4612 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 2,
sub {
#line 122 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4619 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-25', 0,
sub {
#line 122 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4626 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-26', 2,
sub {
#line 122 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4633 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 1,
sub {
#line 122 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4640 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-27', 0,
sub {
#line 122 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4647 ./Grammar.pm
	],
	[#Rule Conditional_105
		 'Conditional', 7,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4654 ./Grammar.pm
	],
	[#Rule Loop_106
		 'Loop', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4661 ./Grammar.pm
	],
	[#Rule Loop_107
		 'Loop', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4668 ./Grammar.pm
	],
	[#Rule Loop_108
		 'Loop', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4675 ./Grammar.pm
	],
	[#Rule LoopFor_109
		 'LoopFor', 10,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4682 ./Grammar.pm
	],
	[#Rule LoopForEach_110
		 'LoopForEach', 8,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4689 ./Grammar.pm
	],
	[#Rule LoopWhile_111
		 'LoopWhile', 5,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4696 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-28', 2,
sub {
#line 127 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4703 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-28', 1,
sub {
#line 127 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4710 ./Grammar.pm
	],
	[#Rule CodeBlock_114
		 'CodeBlock', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4717 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 2,
sub {
#line 129 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4724 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-29', 0,
sub {
#line 129 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4731 ./Grammar.pm
	],
	[#Rule Variable_117
		 'Variable', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4738 ./Grammar.pm
	],
	[#Rule VariableRetrieval_118
		 'VariableRetrieval', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4745 ./Grammar.pm
	],
	[#Rule VariableRetrieval_119
		 'VariableRetrieval', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4752 ./Grammar.pm
	],
	[#Rule VariableDeclaration_120
		 'VariableDeclaration', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4759 ./Grammar.pm
	],
	[#Rule VariableDeclaration_121
		 'VariableDeclaration', 6,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4766 ./Grammar.pm
	],
	[#Rule VariableModification_122
		 'VariableModification', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4773 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-30', 2,
sub {
#line 133 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4780 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 2,
sub {
#line 133 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4787 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-31', 0,
sub {
#line 133 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4794 ./Grammar.pm
	],
	[#Rule ListElements_126
		 'ListElements', 2,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4801 ./Grammar.pm
	],
	[#Rule ListElementValue_127
		 'ListElementValue', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4808 ./Grammar.pm
	],
	[#Rule ListElementValue_128
		 'ListElementValue', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4815 ./Grammar.pm
	],
	[#Rule ListElementValue_129
		 'ListElementValue', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4822 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-32', 4,
sub {
#line 135 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4829 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 2,
sub {
#line 135 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4836 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-33', 0,
sub {
#line 135 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4843 ./Grammar.pm
	],
	[#Rule HashEntries_133
		 'HashEntries', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4850 ./Grammar.pm
	],
	[#Rule HashEntryValue_134
		 'HashEntryValue', 1,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4857 ./Grammar.pm
	],
	[#Rule HashEntryValue_135
		 'HashEntryValue', 3,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4864 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-34', 2,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4871 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-34', 1,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4878 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 2,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4885 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-35', 0,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4892 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-36', 2,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4899 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-36', 1,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4906 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-37', 3,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4913 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 1,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4920 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-38', 0,
sub {
#line 138 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4927 ./Grammar.pm
	],
	[#Rule Class_145
		 'Class', 14,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4934 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 1,
sub {
#line 139 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4941 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-39', 0,
sub {
#line 139 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4948 ./Grammar.pm
	],
	[#Rule Properties_148
		 'Properties', 7,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4955 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 1,
sub {
#line 140 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4962 ./Grammar.pm
	],
	[#Rule _OPTIONAL
		 'OPTIONAL-40', 0,
sub {
#line 140 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 4969 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 2,
sub {
#line 140 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 4976 ./Grammar.pm
	],
	[#Rule _PLUS_LIST
		 'PLUS-41', 1,
sub {
#line 140 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 4983 ./Grammar.pm
	],
	[#Rule Method_153
		 'Method', 10,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4990 ./Grammar.pm
	],
	[#Rule _PAREN
		 'PAREN-42', 4,
sub {
#line 141 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforParenthesis}
#line 4997 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 2,
sub {
#line 141 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 5004 ./Grammar.pm
	],
	[#Rule _STAR_LIST
		 'STAR-43', 0,
sub {
#line 141 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_empty }
#line 5011 ./Grammar.pm
	],
	[#Rule MethodArguments_157
		 'MethodArguments', 4,
sub {
#line 12 "Grammar.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5018 ./Grammar.pm
	]
],
#line 5021 ./Grammar.pm
    yybypass       => 0,
    yybuildingtree => 1,
    yyprefix       => 'RPerl::',
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
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CompileUnit_3', 
         'CompileUnit_4', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Program_9', 
         'Module_10', 
         'Module_11', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Package_14', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Header_19', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Include_22', 
         'Include_23', 
         'Constant_24', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Constant_Value_31', 
         'Constant_Value_32', 
         'Constant_Value_33', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Subroutine_38', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'SubroutineArguments_42', 
         'Operation_43', 
         'Operation_44', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Operator_47', 
         'Operator_48', 
         'Operator_49', 
         'Operator_50', 
         'Operator_51', 
         'Operator_52', 
         'Operator_53', 
         'Operator_54', 
         'Operator_55', 
         'Operator_56', 
         'Operator_57', 
         'Operator_58', 
         'Operator_59', 
         'Operator_60', 
         'Operator_61', 
         'Operator_62', 
         'Operator_63', 
         'Operator_64', 
         'Operator_65', 
         'Operator_66', 
         'Operator_67', 
         'Operator_68', 
         'Operator_69', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'OperatorVoid_72', 
         'OperatorVoid_73', 
         'OperatorVoid_74', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Expression_83', 
         'Expression_84', 
         'Expression_85', 
         'Expression_86', 
         'Expression_87', 
         'Expression_88', 
         'Expression_89', 
         'Expression_90', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Statement_94', 
         'Statement_95', 
         'Statement_96', 
         'Statement_97', 
         'Statement_98', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Conditional_105', 
         'Loop_106', 
         'Loop_107', 
         'Loop_108', 
         'LoopFor_109', 
         'LoopForEach_110', 
         'LoopWhile_111', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'CodeBlock_114', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'Variable_117', 
         'VariableRetrieval_118', 
         'VariableRetrieval_119', 
         'VariableDeclaration_120', 
         'VariableDeclaration_121', 
         'VariableModification_122', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'ListElements_126', 
         'ListElementValue_127', 
         'ListElementValue_128', 
         'ListElementValue_129', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'HashEntries_133', 
         'HashEntryValue_134', 
         'HashEntryValue_135', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         '_PAREN', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Class_145', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         'Properties_148', 
         '_OPTIONAL', 
         '_OPTIONAL', 
         '_PLUS_LIST', 
         '_PLUS_LIST', 
         'Method_153', 
         '_PAREN', 
         '_STAR_LIST', 
         '_STAR_LIST', 
         'MethodArguments_157', );
  $self;
}

#line 143 "Grammar.eyp"


{
    1;
}

=for None

=cut


#line 5208 ./Grammar.pm



1;
