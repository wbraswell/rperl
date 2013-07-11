use strict;  use warnings;

#$CPAN::INC_prefix = '';
$CPAN::INC_prefix = '/home/wbraswell/RPerl/3rd_party/CPAN/';
$CPAN::INC_elements_extra = 
[
	'/lib/perl5'  # from Parse::RecDescent
];
$CPAN::Config = undef;  # defined below, suppress warning about only-used-once-possible-typo

# duplicate @INC entries to include custom INC_prefix directories
sub CPAN::INC_update
{
	eval("use Data::Dumper;");  ## no critic

#print "inside CPAN::INC_update(), have \@INC = \n" . Dumper(\@INC) . "\n\n";

	# optionally append extra directories before modifying with prefix
	for (my $i = 0;  $i < @{$CPAN::INC_elements_extra};  $i++)
	{
		if (not(CPAN::INC_element_exists($CPAN::INC_elements_extra->[$i])))
			{ push(@INC, $CPAN::INC_elements_extra->[$i]); }
	}

	my $INC_length = scalar(@INC);

#print "inside CPAN::INC_update(), have \$INC_length = " . $INC_length . "\n";

	# modify absolute, root-relative directories with prefix and append as new directories
	for (my $i = 0;  $i < $INC_length;  $i++)
	{
#print "inside CPAN::INC_update(), have \@INC[$i] = " . @INC[$i] . "\n";

#		next if (@INC[$i] =~ '/home');
		next if ($INC[$i] =~ '/home');
#		next if ((length($CPAN::INC_prefix) > 0) and (@INC[$i] =~ $CPAN::INC_prefix));
		next if ((length($CPAN::INC_prefix) > 0) and ($INC[$i] =~ $CPAN::INC_prefix));
#		my $INC_element_new = @INC[$i];
		my $INC_element_new = $INC[$i];
		if (substr($INC_element_new, 0, 1) eq '/')
			{ $INC_element_new = substr($INC_element_new, 1, length($INC_element_new) - 1); }
		$INC_element_new = $CPAN::INC_prefix . $INC_element_new;
		if (not(CPAN::INC_element_exists($INC_element_new)))
			{ push(@INC, $INC_element_new); }

#print "inside CPAN::INC_update(), have \$INC_element_new = " . $INC_element_new . "\n";
	}

#print "inside CPAN::INC_update(), have modified \@INC = \n" . Dumper(\@INC) . "\n\n";
}


sub CPAN::INC_element_exists
{
	my $element = shift;

	for (my $i = 0;  $i < scalar(@INC);  $i++)
	{
#		return(1) if (@INC[$i] eq $element);
		return(1) if ($INC[$i] eq $element);
	}

	return(0);
}


$CPAN::Config = {  
  'applypatch' => q[],
  'auto_commit' => q[0],
  'build_cache' => q[100],
  'build_dir' => q[/home/wbraswell/.cpan/build],
  'build_dir_reuse' => q[0],
  'build_requires_install_policy' => q[ask/yes],
  'bzip2' => q[/bin/bzip2],
  'cache_metadata' => q[1],
  'check_sigs' => q[0],
  'commandnumber_in_prompt' => q[1],
  'connect_to_internet_ok' => q[1],
  'cpan_home' => q[/home/wbraswell/.cpan],
  'curl' => q[],
  'ftp' => q[/usr/bin/ftp],
  'ftp_passive' => q[1],
  'ftp_proxy' => q[],
  'getcwd' => q[cwd],
  'gpg' => q[/usr/bin/gpg],
  'gzip' => q[/bin/gzip],
  'halt_on_failure' => q[0],
  'histfile' => q[/home/wbraswell/.cpan/histfile],
  'histsize' => q[100],
  'http_proxy' => q[],
  'inactivity_timeout' => q[0],
  'index_expire' => q[1],
  'inhibit_startup_message' => q[0],
  'keep_source_where' => q[/home/wbraswell/.cpan/sources],
  'load_module_verbosity' => q[v],
  'lynx' => q[],
  'make' => q[/usr/bin/make],
  'make_arg' => q[],
  'make_install_arg' => q[],
  'make_install_make_command' => q[/usr/bin/make],
  'makepl_arg' => q[INSTALLDIRS=site DESTDIR=/home/wbraswell/RPerl/3rd_party/CPAN/],
  'mbuild_arg' => q[],
  'mbuild_install_arg' => q[],
  'mbuild_install_build_command' => q[./Build],
  'mbuildpl_arg' => q[--installdirs site --install_base /home/wbraswell/RPerl/3rd_party/CPAN],
  'ncftp' => q[],
  'ncftpget' => q[],
  'no_proxy' => q[],
  'pager' => q[/usr/bin/less],
  'patch' => q[/usr/bin/patch],
  'perl5lib_verbosity' => q[v],
  'prefer_installer' => q[MB],
  'prefs_dir' => q[/home/wbraswell/.cpan/prefs],
  'prerequisites_policy' => q[ask],
  'scan_cache' => q[atstart],
  'shell' => q[/bin/bash],
  'show_unparsable_versions' => q[0],
  'show_upload_date' => q[0],
  'show_zero_versions' => q[0],
  'tar' => q[/bin/tar],
  'tar_verbosity' => q[v],
  'term_is_latin' => q[1],
  'term_ornaments' => q[1],
  'test_report' => q[0],
  'trust_test_report_history' => q[0],
  'unzip' => q[/usr/bin/unzip],
  'urllist' => [q[ftp://cpan.uchicago.edu/pub/CPAN/], q[ftp://ftp.cise.ufl.edu/pub/mirrors/CPAN/], q[ftp://ftp.ncsu.edu/pub/mirror/CPAN/]],
  'use_sqlite' => q[0],
  'wget' => q[/usr/bin/wget],
  'yaml_load_code' => q[0],
  'yaml_module' => q[YAML],
};

# actually update INC when /usr/bin/cpan starts up and loads this RPerl-specific MyConfig.pm file
CPAN::INC_update();

1;
__END__
