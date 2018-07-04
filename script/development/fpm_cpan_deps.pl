#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
#use RPerl::AfterSubclass;  # disable RPerl itself
our $VERSION = 0.006_000;

# disable RPerl itself
package void;
package number;
package string;
package string_arrayref;
package string_hashref;
package string_hashref_hashref;
package integer;
package filehandle;
package main;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(RequireBriefOpen)  # USER DEFAULT 5: allow open() in perltidy-expanded code

# [[[ INCLUDES ]]]
use English;
use IPC::Run3 qw(run3);
use Module::CoreList;
use CPAN;
use version 0.77;  # for comparing version strings

use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

# [[[ OPERATIONS ]]]

# CHECK INPUT ARGUMENTS & WORK DIRECTORY
# CHECK INPUT ARGUMENTS & WORK DIRECTORY
# CHECK INPUT ARGUMENTS & WORK DIRECTORY

if ( (not defined $ARGV[0]) or ( ($ARGV[0] ne q{-t}) and ($ARGV[0] ne q{--output-type}) ) ) {
    die 'ERROR, First argument must be output package format option tag "-t" or "--output-type", dying', "\n";
}
    
if ((not defined $ARGV[1]) or ($ARGV[1] eq q{})) {
    die 'ERROR, No output package format specified, dying', "\n";
}
my string $output_format = $ARGV[1];

if ((not defined $ARGV[2]) or ($ARGV[2] eq q{})) {
    die 'ERROR, No input Perl module specified, dying', "\n";
}
my string $input_module = $ARGV[2];

# NEED REMOVE HARD-CODED DIRECTORY
my string $work_dir = $ENV{'HOME'} . '/fpm_tmp';

if ((not -e $work_dir) or (not -d $work_dir)) {
    die 'ERROR, Work directory does not exist: ', $work_dir, "\n", 'dying', "\n";
}

# BEGIN RECURSIVE SUBROUTINE CALLS
# BEGIN RECURSIVE SUBROUTINE CALLS
# BEGIN RECURSIVE SUBROUTINE CALLS
my string_hashref $distributions_processed = {};
my string_hashref_hashref $dependencies = recurse($input_module, $output_format, $work_dir, $distributions_processed);
print {*STDERR} 'have outer-most $dependencies = ', "\n", Dumper($dependencies), "\n";
print {*STDERR} 'have outer-most $distributions_processed = ', "\n", Dumper($distributions_processed), "\n";
print {*STDERR} 'have outer-most scalar keys %{$distributions_processed} = ', scalar keys %{$distributions_processed}, "\n";

# save dependencies & distributions processed
my string $dependencies_file = $work_dir . '/' . $input_module . '.deps';
open(my filehandle $DEPENDENCIES_FH, '>', $dependencies_file)
    or die 'ERROR, Can Not Open Dependencies File For Writing: ', $dependencies_file, "\n", 'dying';
print $DEPENDENCIES_FH '$dependencies = ', "\n", Dumper($dependencies), "\n\n";
print $DEPENDENCIES_FH '$distributions_processed = ', "\n", Dumper($distributions_processed), "\n";
print $DEPENDENCIES_FH 'scalar keys %{$distributions_processed} = ', scalar keys %{$distributions_processed}, ';', "\n";
close $DEPENDENCIES_FH
    or die 'ERROR, Can Not Close Dependencies File After Writing: ', $dependencies_file, "\n", 'dying';


# [[[ SUBROUTINES ]]]

# RECURSIVELY BUILD PACKAGES
# RECURSIVELY BUILD PACKAGES
# RECURSIVELY BUILD PACKAGES
sub recurse {
    { my string_hashref_hashref $RETURN_TYPE };  # output return value copied from last nested subroutine, determine_dependencies()
    ( my string $input_module, my string $output_format, my string $work_dir, my string_hashref $distributions_processed ) = @ARG;  # input parameters copied from first nested subroutine, run_fpm()
 
print {*STDERR} "\n\n", '=' x 150, "\n\n";
print {*STDERR} 'in recurse(), received $input_module = ', $input_module, "\n";
print {*STDERR} 'in recurse(), received $distributions_processed = ', "\n", Dumper($distributions_processed);
print {*STDERR} 'in recurse(), have scalar keys %{$distributions_processed} = ', scalar keys %{$distributions_processed}, "\n\n";

    # skip dependencies already in the flattened hash, to avoid dependency loops
    if (exists $distributions_processed->{$input_module}) {
print {*STDERR} "\n", 'SKIPPING MODULE, ALREADY PROCESSED: ', $input_module, "\n\n";
        return {};  # return empty $dependencies
    }

    # DEV NOTE: process dependencies by distribution, not by module
    my string $distribution;

    # skip dependencies contained in the Perl core, to avoid FPM error:
    # /usr/local/share/gems/gems/fpm-1.10.0/lib/fpm/package/cpan.rb:341:in `download': undefined method `[]' for nil:NilClass (NoMethodError)

    # CPAN::Shell methodology
    # HARD-CODED EXAMPLE:
    # X/XS/XSAWYERX/perl-5.28.0.tar.gz
#    CPAN::Shell->m($input_module);  # useless, prints results, returns undef
#    my $distribution_cpan_file = CPAN::Shell->expand('Module', $input_module)->cpan_file();  # error on module 'Config', can't call cpan_file() on undefined reference
    my $module_object = CPAN::Shell->expand('Module', $input_module);
    if (defined $module_object) {
        my string $distribution_cpan_file = $module_object->cpan_file();

        # determine CPAN distribution name from module name (may be the same)
        # HARD-CODED EXAMPLE:
        # E/ET/ETHER/File-Temp-0.2306.tar.gz
        # M/MO/MONGODB/MongoDB-v2.0.0.tar.gz
        if ($distribution_cpan_file =~ m/^[A-Z]\/[A-Z][A-Z]\/[A-Z]+\/([-+\w]+)-[v.\d]+\.tar\.gz$/) {
            $distribution = $1;            
        }
        # HARD-CODED EXAMPLE:
        # M/MU/MUIR/modules/Text-Tabs+Wrap-2013.0523.tar.gz
        # F/FO/FOOBAR/modules/FooBar-v1.2.3.tar.gz
        elsif ($distribution_cpan_file =~ m/^[A-Z]\/[A-Z][A-Z]\/[A-Z]+\/modules\/([-+\w]+)-[v.\d]+\.tar\.gz$/) {
            $distribution = $1;            
        }
        # HARD-CODED EXAMPLE:
        # R/RS/RSAVAGE/Config-Tiny-2.23.tgz
        # F/FO/FOOBAR/FooBar-v1.2.3.tgz
        elsif ($distribution_cpan_file =~ m/^[A-Z]\/[A-Z][A-Z]\/[A-Z]+\/([-+\w]+)-[v.\d]+\.tgz$/) {
            $distribution = $1;            
        }
        # HARD-CODED EXAMPLE:
        # F/FO/FOOBAR/modules/FooBar-1.2.3.tgz
        # F/FO/FOOBAR/modules/FooBar-v1.2.3.tgz
        elsif ($distribution_cpan_file =~ m/^[A-Z]\/[A-Z][A-Z]\/[A-Z]+\/modules\/([-+\w]+)-[v.\d]+\.tgz$/) {
            $distribution = $1;            
        }
        else {
            die 'ERROR, CPAN Distribution Format Not Recognized: ', $distribution_cpan_file, "\n", 'dying';
        }
        $distribution =~ s/-/::/gxms;

print {*STDERR} 'in recurse(), have $distribution = ', $distribution, "\n";

        # skip dependencies already in the flattened hash, to avoid dependency loops
        if (exists $distributions_processed->{$distribution}) {
print {*STDERR} "\n", 'SKIPPING DISTRIBUTION, ALREADY PROCESSED: ', $distribution, "\n\n";
            return {};  # return empty $dependencies
        }

print {*STDERR} 'in recurse(), have $distribution_cpan_file = ', $distribution_cpan_file, "\n";

        # DEV NOTE: this identifies "dual life" (in Perl core and on CPAN) core modules, 
        # which SHOULD be processed in order to get the newest version from CPAN, as well as be present in the OS package management dependency system
        if ($distribution_cpan_file =~ m/^.*\/perl-[.\d]+\.tar\.gz$/) {
print {*STDERR} "\n", 'SKIPPING MODULE, ALREADY IN PERL CORE (via CPAN::Shell): ', $input_module, "\n\n";
            return {};  # return empty $dependencies
        }
    }
    else {
        # Module::CoreList methodology
        # DEV NOTE: only use as fall-back when CPAN::Shell returns undef; this identifies "single life" (in Perl core only, not on CPAN) core modules like 'Config',
        # which should NOT be processed because they do not exist on CPAN independent of the latest perl-X.X.X.tar.gz distribution
        if (Module::CoreList::is_core($input_module)) {
print {*STDERR} "\n", 'SKIPPING MODULE, ALREADY IN PERL CORE (via Module::CoreList): ', $input_module, "\n\n";
            return {};  # return empty $dependencies
        }
    }

print {*STDERR} 'in recurse(), about to call determine_dependencies(determine_spec_file(run_fpm()))...', "\n";

    my string_hashref_hashref $dependencies = determine_dependencies(determine_spec_file(run_fpm($input_module, $output_format, $work_dir)));

print {*STDERR} 'in recurse(), ret from call to determine_dependencies(determine_spec_file(run_fpm()))', "\n";
print {*STDERR} 'in recurse(), have $dependencies = ', "\n", Dumper($dependencies), "\n";

    # add just-processed dependency into flattened dependencies before recursing, to avoid dependency loops
    # DEV NOTE: process dependencies by distribution, not by module
#    if (not exists $dependencies_processed->{$input_module}) {
#        $dependencies_processed->{$input_module} = 0;
#    }
#    $dependencies_processed->{$input_module} += 1;
    if (not exists $distributions_processed->{$distribution}) {
        $distributions_processed->{$distribution} = 0;
    }
    $distributions_processed->{$distribution} += 1;

print {*STDERR} 'in recurse(), have updated $distributions_processed = ', "\n", Dumper($distributions_processed);
print {*STDERR} 'in recurse(), have updated scalar keys %{$distributions_processed} = ', scalar keys %{$distributions_processed}, "\n\n";

    # depth-first recurse for each dependency, in order to process subdependencies
    foreach my string $dependency_module (sort keys %{$dependencies}) {
        # skip dependencies already in the flattened hash, to avoid dependency loops
        if (exists $distributions_processed->{$dependency_module}) {
print {*STDERR} "\n", 'SKIPPING DEPENDENCY MODULE, ALREADY PROCESSED: ', $dependency_module, "\n\n";
            next;
        }
        if (exists $dependencies->{$dependency_module}->{_version}) {
            my $module_object = CPAN::Shell->expand('Module', $dependency_module);
            if (defined $module_object) {
                my number $cpan_version = $module_object->cpan_version();
                
                # NEED UPGRADE: handle check for the existence of a specific prior version of a module
#                if ($cpan_version != $dependencies->{$dependency_module}->{_version}) {  # possibly wrong, numeric comparison instead of version
                if (version->parse($cpan_version) != version->parse($dependencies->{$dependency_module}->{_version})) {
                    die 'ERROR, Exact Version Not Found: ', $dependency_module, ' ', $dependencies->{$dependency_module}->{_version},
                        ' required, but ', $cpan_version, ' found on CPAN, NEED UPGRADE TO HANDLE EXACT VERSIONS, dying';
                }
            }
            else {
                    die 'ERROR, Exact Version Not Found: ', $dependency_module, ' ', $dependencies->{$dependency_module}->{_version},
                        ' required, but no version found on CPAN, dying';
            }
        }
        elsif (exists $dependencies->{$dependency_module}->{_min_version}) {
            my $module_object = CPAN::Shell->expand('Module', $dependency_module);
            if (defined $module_object) {
                my number $cpan_version = $module_object->cpan_version();
                
#                if ($cpan_version < $dependencies->{$dependency_module}->{_min_version}) {  # possibly wrong, numeric comparison instead of version
                if (version->parse($cpan_version) < version->parse($dependencies->{$dependency_module}->{_min_version})) {
                    die 'ERROR, Minimum Version Not Found: ', $dependency_module, ' ', $dependencies->{$dependency_module}->{_min_version},
                        ' required, but ', $cpan_version, ' found on CPAN, dying';
                }
            }
            else {
                    die 'ERROR, Minimum Version Not Found: ', $dependency_module, ' ', $dependencies->{$dependency_module}->{_min_version},
                        ' required, but no version found on CPAN, dying';
            }
        }
        my string_hashref_hashref $subdependencies = recurse($dependency_module, $output_format, $work_dir, $distributions_processed);
        $dependencies->{$dependency_module} = {%{$dependencies->{$dependency_module}}, %{$subdependencies}};  # merge subdeps into existing deps
    }

    return $dependencies;
}

# RUN FPM COMMAND
# RUN FPM COMMAND
# RUN FPM COMMAND
sub run_fpm {
    { my string $RETURN_TYPE };
    ( my string $input_module, my string $output_format, my string $work_dir ) = @ARG;

    my string $stdout_file = $work_dir . '/' . $input_module . '.stdout';
    my string $stdout_generated = q{};
    my string $stderr_generated = q{};

    # NEED UPGRADE: handle installation of a specific prior version of a module
    # HARD-CODED EXAMPLE:
    # fpm --verbose --debug-workspace --workdir /home/USERNAME/rpmbuild.fpm/ -t rpm -s cpan ExtUtils::MakeMaker
    # NEED RE-ENABLE TESTS
#    my string $execute_command = 'fpm --cpan-test --verbose --debug-workspace --workdir ' . $work_dir . ' -t ' . $output_format . ' -s cpan ' . $input_module;
#    my string $execute_command = 'fpm --no-cpan-test --verbose --debug-workspace --workdir ' . $work_dir . ' -t ' . $output_format . ' -s cpan ' . $input_module;
    my string $execute_command = 'unbuffer fpm --no-cpan-test --cpan-verbose --verbose --debug-workspace --workdir ' . $work_dir . ' -t ' . $output_format . ' -s cpan ' . $input_module . ' | tee ' . $stdout_file;  # yes simultaneous view & capture w/ tee; color w/ unbuffer

print {*STDERR} 'in run_fpm(), have $execute_command = ' . $execute_command . "\n";
print {*STDERR} 'in run_fpm(), about to call run3()...' . "\n";

#    run3( $execute_command, \undef, \$stdout_generated, \$stderr_generated );  # no simultaneous view & capture; child STDIN from /dev/null, child STDOUT & STDERR to variables
    run3( $execute_command, undef, undef, \$stderr_generated );  # yes simultaneous view & capture w/ tee; child STDIN from parent STDIN, child STDOUT to parent STDOUT, child STDERR to variable
#    run3( $execute_command, \undef, \&stdout_print, \&stderr_print );  # no simultaneous view & capture; child STDOUT & STDERR to subroutines

    #  yes simultaneous view & capture w/ tee; read STDOUT contents from file saved by `tee` command
    open(my filehandle $STDOUT_FILE_FH, '<', $stdout_file)
        or die 'ERROR, Could not open STDOUT file: ', q{'}, $stdout_file, q{'}, "\n", $OS_ERROR, "\n", 'dying';
    while (my string $stdout_file_line = <$STDOUT_FILE_FH>) {
        $stdout_generated .= $stdout_file_line;
    }
    close $STDOUT_FILE_FH
        or die 'ERROR, Could not close STDOUT file: ', q{'}, $stdout_file, q{'}, "\n", $OS_ERROR, "\n", 'dying';    

print {*STDERR} 'in run_fpm(), have $stdout_generated = ', "\n", '<<<=== BEGIN STDOUT ===>>>', $stdout_generated, '<<<=== END STDOUT ===>>>', "\n\n";
print {*STDERR} 'in run_fpm(), have $stderr_generated = ', "\n", '<<<=== BEGIN STDERR ===>>>', $stderr_generated, '<<<=== END STDERR ===>>>', "\n\n";

    my integer $test_exit_status = $CHILD_ERROR >> 8;

    if ( $test_exit_status == 0 ) {    # UNIX process return code 0, success
        print "\n", ('[[[[[=====  SUCCESS!  ', $input_module, '  =====]]]]]' . "\n") x 3, "\n";
    }
    else {    # UNIX process return code not 0, error
        die "\n", ('[[[[[==== ERROR!  ', $input_module, '  =====]]]]]' . "\n") x 3, 'dying', "\n";
    }
    return $stdout_generated;
}


# DETERMINE SPEC FILE NAME
# DETERMINE SPEC FILE NAME
# DETERMINE SPEC FILE NAME
sub determine_spec_file {
    { my string $RETURN_TYPE };
    ( my string $stdout_generated ) = @ARG;

    my @stdout_generated_lines_array = split( "\n", $stdout_generated );
    my string_arrayref $stdout_generated_lines = \@stdout_generated_lines_array;

    # HARD-CODED EXAMPLE:
    # {:timestamp=>"2018-07-02T14:36:03.898974-0700", :message=>"Running rpmbuild", :args=>["rpmbuild", "-bb", "--target", "noarch",
    #    "--define", "buildroot /home/USERNAME/fpm_tmp/package-rpm-build-SERIALNUMBER/BUILD",
    #    "--define", "_topdir /home/USERNAME/fpm_tmp/package-rpm-build-SERIALNUMBER",
    #    "--define", "_sourcedir /home/USERNAME/fpm_tmp/package-rpm-build-SERIALNUMBER",
    #    "--define", "_rpmdir /home/USERNAME/fpm_tmp/package-rpm-build-SERIALNUMBER/RPMS",
    #    "--define", "_tmppath /home/USERNAME/fpm_tmp",
    #    "/home/USERNAME/fpm_tmp/package-rpm-build-SERIALNUMBER/SPECS/perl-ExtUtils-MakeMaker.spec"],
    #    :level=>:info}
    my string $spec_file = q{};
    foreach my string $stdout_generated_line (@{$stdout_generated_lines}) {
        if ($stdout_generated_line =~ m/^.*\"($work_dir.*\.spec)\"],.*$/) {
            $spec_file = $1;
            last;
        }
    }

    if ($spec_file eq q{}) {
        die 'ERROR, Could not determine spec file, dying';
    }

print {*STDERR} 'in determine_spec_file(), have $spec_file = ', q{'}, $spec_file, q{'}, "\n";

    return $spec_file;
}


# OPEN SPEC FILE & DETERMINE DEPENDENCIES
# OPEN SPEC FILE & DETERMINE DEPENDENCIES
# OPEN SPEC FILE & DETERMINE DEPENDENCIES
sub determine_dependencies {
    { my string_hashref_hashref $RETURN_TYPE };
    ( my string $spec_file ) = @ARG;

    open(my filehandle $SPEC_FILE_FH, '<', $spec_file) 
        or die 'ERROR, Could not open spec file: ', q{'}, $spec_file, q{'}, "\n", $OS_ERROR, "\n", 'dying';
    my string_hashref_hashref $dependencies = {};
    while (my string $spec_file_line = <$SPEC_FILE_FH>) {
        chomp $spec_file_line;
        if ($spec_file_line =~ m/^Requires:\ perl\(/) {
            # HARD-CODED EXAMPLES:
            # Requires: perl(Encode)
            # Requires: perl(Data::Dumper)
            if ($spec_file_line =~ m/^Requires:\ perl\((.*)\)$/) {
                $dependencies->{$1} = {};
            }
            # NEED ANSWER: is single equal sign correct here?
            # HARD-CODED EXAMPLES:
            # Requires: perl(Foo) =  2.3.1
            # Requires: perl(Bar) = v4.2.0
            elsif ($spec_file_line =~ m/^Requires:\ perl\((.*)\)\s+=\s+([v.\d]+)$/) {
                $dependencies->{$1} = { _version => $2 };
            }
            # HARD-CODED EXAMPLES:
            # Requires: perl(File::Spec) >= 0.8
            # Requires: perl(MongoDB) >= v1.8.0
            elsif ($spec_file_line =~ m/^Requires:\ perl\((.*)\)\s+>=\s+([v.\d]+)$/) {
                $dependencies->{$1} = { _min_version => $2 };
            }
            else {
                die 'ERROR, Spec file contains unrecognized Perl dependency line: ', q{'}, $spec_file_line, q{'}, "\n", 'dying';
            }
        }
    }
    close $SPEC_FILE_FH
        or die 'ERROR, Could not close spec file: ', q{'}, $spec_file, q{'}, "\n", $OS_ERROR, "\n", 'dying';

print {*STDERR} 'in determine_dependencies(), have $dependencies = ', "\n", Dumper($dependencies), "\n";

    return $dependencies;
}

# does not allow simultaneous viewing & capturing
#sub stdout_print { { my void $RETURN_TYPE }; ( my string $input_string ) = @ARG; print $input_string; }
#sub stderr_print { { my void $RETURN_TYPE }; ( my string $input_string ) = @ARG; print {*STDERR} $input_string; }