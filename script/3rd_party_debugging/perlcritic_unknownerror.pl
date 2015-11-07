#!/usr/bin/perl
use Perl::Critic;
use Data::Dumper;

my $source__file_name = '/tmp/rperl/unknown_critic.pl';

my $source__critic = Perl::Critic->new(
    '-exclude'  => ['RequireTidyCode', 'PodSpelling', 'RequireExplicitPackage'],
    '-severity' => 'brutal'
);
my @source__critic_violations
    = $source__critic->critique($source__file_name);

print Dumper(\@source__critic_violations);

my $violation_pretty = q{};
   foreach my $violation (@source__critic_violations) {
            $violation_pretty .= '    File Name:    ' . $source__file_name . "\n";
            $violation_pretty .= '    Line number:  ' . $violation->{_location}->[0] . "\n";
            $violation_pretty .= '    Policy:       ' . $violation->{_policy} . "\n";
            $violation_pretty .= '    Description:  ' . $violation->{_description} . "\n";
            if ( ref( $violation->{_explanation} ) eq 'ARRAY' ) {
                $violation_pretty .= '    Explanation:  See Perl Best Practices page(s) ' . join( ', ', @{ $violation->{_explanation} } ) . "\n\n";
            }
            else {
                $violation_pretty .= '    Explanation:  ' . $violation->{_explanation} . "\n\n";
            }
    }
if ($violation_pretty eq '') { $violation_pretty = '[ NONE ]'; }
die "\n" . 'ERROR ECVPAPC02, RPERL PARSER, PERL CRITIC VIOLATION' . "\n" . 
    'Failed Perl::Critic brutal review with the following information:' . "\n\n" . $violation_pretty;