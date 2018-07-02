#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
#use RPerl::AfterSubclass;  # disable RPerl itself
our $VERSION = 0.001_000;

# disable RPerl itself
package string;
package string_arrayref;
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
use Data::Dumper;
use IPC::Run3 qw(run3);

# [[[ OPERATIONS ]]]

# CHECK INPUT ARGUMENTS & WORK DIRECTORY
# CHECK INPUT ARGUMENTS & WORK DIRECTORY
# CHECK INPUT ARGUMENTS & WORK DIRECTORY

if ((not defined $ARGV[0]) or ($ARGV[0] eq q{})) {
    die 'No input Perl module specified, dying', "\n";
}
my string $input_module = $ARGV[0];

if ((not defined $ARGV[1]) or ($ARGV[1] eq q{})) {
    die 'No output package format specified, dying', "\n";
}
my string $output_format = $ARGV[1];

# NEED REMOVE HARD-CODED DIRECTORY
my string $work_dir = $ENV{'HOME'} . '/rperl_build_tmp';

if ((not -e $work_dir) or (not -d $work_dir)) {
    die 'Work directory does not exist: ', $work_dir, "\n", 'dying', "\n";
}

# BEGIN RECURSIVE SUBROUTINE CALLS
# BEGIN RECURSIVE SUBROUTINE CALLS
# BEGIN RECURSIVE SUBROUTINE CALLS
my string_hashref_hashref $dependencies = recurse($input_module, $output_format, $work_dir);
print {*STDERR} 'have outer-most $dependencies = ', "\n", Dumper($dependencies), "\n";


# [[[ SUBROUTINES ]]]

# RECURSIVELY BUILD PACKAGES
# RECURSIVELY BUILD PACKAGES
# RECURSIVELY BUILD PACKAGES
sub recurse {
    { my string_hashref_hashref $RETURN_TYPE };  # output return value copied from last nested subroutine, determine_dependencies()
    ( my string $input_module, my string $output_format, my string $work_dir ) = @ARG;  # input parameters copied from first nested subroutine, run_fpm()
    
    my string_hashref_hashref $dependencies = determine_dependencies(determine_spec_file(run_fpm($input_module, $output_format, $work_dir)));
    
# START HERE: add global flat hash of all searched modules to avoid dependency loops
# START HERE: add global flat hash of all searched modules to avoid dependency loops
# START HERE: add global flat hash of all searched modules to avoid dependency loops
    
    foreach my string $dependency_module (keys %{$dependencies}) {
        if (not exists $dependencies->{$dependency_module}->{_min_version}) {
            my string_hashref_hashref $subdependencies = recurse($dependency_module, $output_format, $work_dir);
            $dependencies->{$dependency_module} = {%{$dependencies->{$dependency_module}}, %{$subdependencies}};  # merge subdeps into existing deps
        }
        else {
            # THEN START HERE: NEED ADD MIN VERSION HANDLING
            # THEN START HERE: NEED ADD MIN VERSION HANDLING
            # THEN START HERE: NEED ADD MIN VERSION HANDLING
print {*STDERR} 'SKIPPING MIN VERSION, NEED ADD MIN VERSION HANDLING', "\n";
        }
    }

    return $dependencies;
}

# RUN FPM COMMAND
# RUN FPM COMMAND
# RUN FPM COMMAND
sub run_fpm {
    { my string $RETURN_TYPE };
    ( my string $input_module, my string $output_format, my string $work_dir ) = @ARG;

    my string $stdout_generated = q{};
    my string $stderr_generated = q{};

    # HARD-CODED EXAMPLE:
    # fpm --verbose --debug-workspace --workdir /home/USERNAME/rpmbuild.fpm/ -t rpm -s cpan ExtUtils::MakeMaker
    # NEED RE-ENABLE TESTS
    #my string $execute_command = 'fpm --cpan-test --verbose --debug-workspace --workdir ' . $work_dir . ' -t ' . $output_format . ' -s cpan ' . $input_module;
    my string $execute_command = 'fpm --no-cpan-test --verbose --debug-workspace --workdir ' . $work_dir . ' -t ' . $output_format . ' -s cpan ' . $input_module;

print {*STDERR} 'in run_fpm(), have $execute_command = ' . $execute_command . "\n";
print {*STDERR} 'in run_fpm(), about to call open3()...' . "\n";

    run3( $execute_command, \undef, \$stdout_generated, \$stderr_generated );

print {*STDERR} 'in run_fpm(), have $stdout_generated = ', "\n", '<<<=== BEGIN STDOUT ===>>>', $stdout_generated, '<<<=== END STDOUT ===>>>', "\n\n";
print {*STDERR} 'in run_fpm(), have $stderr_generated = ', "\n", '<<<=== BEGIN STDERR ===>>>', $stderr_generated, '<<<=== END STDERR ===>>>', "\n\n";

    my integer $test_exit_status = $CHILD_ERROR >> 8;

    if ( $test_exit_status == 0 ) {    # UNIX process return code 0, success
        print 'Success!', "\n";
    }
    else {    # UNIX process return code not 0, error
        die 'Error: ', $OS_ERROR, "\n", 'dying';
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
    #    "--define", "buildroot /home/USERNAME/rperl_build_tmp/package-rpm-build-SERIALNUMBER/BUILD",
    #    "--define", "_topdir /home/USERNAME/rperl_build_tmp/package-rpm-build-SERIALNUMBER",
    #    "--define", "_sourcedir /home/USERNAME/rperl_build_tmp/package-rpm-build-SERIALNUMBER",
    #    "--define", "_rpmdir /home/USERNAME/rperl_build_tmp/package-rpm-build-SERIALNUMBER/RPMS",
    #    "--define", "_tmppath /home/USERNAME/rperl_build_tmp",
    #    "/home/USERNAME/rperl_build_tmp/package-rpm-build-SERIALNUMBER/SPECS/perl-ExtUtils-MakeMaker.spec"],
    #    :level=>:info}
    my string $spec_file = q{};
    foreach my string $stdout_generated_line (@{$stdout_generated_lines}) {
        if ($stdout_generated_line =~ m/^.*\"($work_dir.*\.spec)\"],.*$/) {
            $spec_file = $1;
            last;
        }
    }

    if ($spec_file eq q{}) {
        die 'Could not determine spec file, dying';
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
        or die 'Could not open spec file: ', q{'}, $spec_file, q{'}, "\n", $OS_ERROR, "\n", 'dying';
    # HARD-CODED EXAMPLE:
    # Requires: perl(Data::Dumper)
    # Requires: perl(Encode)
    # Requires: perl(File::Basename)
    # Requires: perl(File::Spec) >= 0.8
    # Requires: perl(Pod::Man)
    my string_hashref_hashref $dependencies = {};
    while (my string $spec_file_line = <$SPEC_FILE_FH>) {
        chomp $spec_file_line;
        if ($spec_file_line =~ m/^Requires:\ perl\(/) {
            if ($spec_file_line =~ m/^Requires:\ perl\((.*)\)$/) {
                $dependencies->{$1} = {};
            }
            elsif ($spec_file_line =~ m/^Requires:\ perl\((.*)\)\s+>=\s+([.\d]+)$/) {
                $dependencies->{$1} = { _min_version => $2 };
            }
            else {
                die 'Spec file contains unrecognized Perl dependency line: ', q{'}, $spec_file_line, q{'}, "\n", 'dying';
            }
        }
    }
    close $SPEC_FILE_FH
        or die 'Could not close spec file: ', q{'}, $spec_file, q{'}, "\n", $OS_ERROR, "\n", 'dying';

print {*STDERR} 'in determine_dependencies(), have $dependencies = ', "\n", Dumper($dependencies), "\n";

    return $dependencies;
}

