#!/bin/bash
# Copyright © 2014, 2015, 2016, William N. Braswell, Jr.. All Rights Reserved. This work is Free \& Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.24.0.
# RPerl Installer Script
VERSION='0.077_000'

# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!
# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!
# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!

# PRE-INSTALL: download the latest version of this file and make it executable
# wget https://raw.githubusercontent.com/wbraswell/rperl/master/script/rperl_installer.sh; chmod a+x ./rperl_installer.sh

# enable extended pattern matching in case statements
shopt -s extglob

# global variables
USER_INPUT=''
CURRENT_SECTION=0

# block comment template
: <<'END_COMMENT'
    foo bar bat
END_COMMENT

CURRENT_SECTION_COMPLETE () {
    echo
    echo '[[[ SECTION' $CURRENT_SECTION 'COMPLETE ]]]'
    echo
    CURRENT_SECTION=$((CURRENT_SECTION+1))
    while true; do
        read -p "Continue to section $CURRENT_SECTION, yes or no?  [yes] " -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; exit;;
            y|Y ) echo; echo; break;;
#            ' ' ) echo;;  # NEED FIX: space ' ' should not trigger empty ''
            ''  ) echo; break;;
            *   ) echo;;
        esac
    done
}

SOURCE () {  # source (.) with error check & note
    echo '$ source' $1
    while true; do
        read -p 'Run above command, yes or no?  [yes] ' -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; return;;
            y|Y ) echo; break;;
            '' ) break;;
            * ) echo;;
        esac
    done

    if [ -f "$1" ]; then
        source $1
        echo '[ NOTE: When This Installer Exits, You Must Then Copy & Re-Run The Above Command, Or Log Out & Log Back In If The File Is ~/.bashrc ]'
    else
        echo 'Cannot source file ' $1 ' because such file does not exist'
    fi
}

CD () {  # _C_hange _D_irectory with error check
    CD_DIR="${1/#\~/$HOME}"  # replace ~/FOO with $HOME/FOO to avoid 'directory not found' error
    echo '$ cd' $CD_DIR
    while true; do
        read -p 'Run above command, yes or no?  [yes] ' -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; return;;
            y|Y ) echo; break;;
            '' ) break;;
            * ) echo;;
        esac
    done

    if [ -d "$CD_DIR" ]; then
        cd $CD_DIR
    else
        echo 'Cannot change directory to ' $CD_DIR ' because such directory does not exist'
    fi
}

C () {  # _C_onfirm user action
    echo $1
    while true; do
        read -p 'Did you do it, yes or no?  [yes] ' -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; echo $1;;
            y|Y ) echo; echo; break;;
#            ' ' ) echo;;  # NEED FIX: space ' ' should not trigger empty ''
            ''  ) echo; break;;
            *   ) echo;;
        esac
    done
}

P () {  # _P_rompt user for input
    if [[ $1 != '__EMPTY__' ]]; then
        USER_INPUT=$1
        return
    fi
    while true; do
            read -p "Please type the $2... " USER_INPUT
        case $USER_INPUT in
            # do not force input to start with lowercase letter or forward slash; do not limit any keyboard characters because of passwords
#            [abcdefghijklmnopqrstuvwxyz/]+([abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_./]) ) echo; break;;
            +([abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\~\!\@\#\$\%\^\&\*\(\)\-\_\=\+\[\]\{\}\\\|\/\?\,\.\<\>]) ) echo; break;;
            * ) echo "Please type the $2! "; echo;;
        esac
    done
}

N () {  # prompt user for _N_umeric input
    if [[ $1 != '__EMPTY__' ]]; then
        USER_INPUT=$1
        return
    fi
    while true; do
            read -p "Please type the $2... " USER_INPUT
        case $USER_INPUT in
            [0123456789]+([0123456789.]) ) echo; break;;
            * ) echo "Please type the $2! "; echo;;
        esac
    done
}

D () {  # prompt user for input w/ _D_efault value
    if [[ $1 != '__EMPTY__' ]]; then
        USER_INPUT=$1
        return
    fi
    while true; do
            read -p "Please type the $2, or press <ENTER> for $3... " USER_INPUT
        case $USER_INPUT in
            +([abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\~\!\@\#\$\%\^\&\*\(\)\-\_\=\+\[\]\{\}\\\|\/\?\,\.\<\>]) ) echo; break;;
            '' ) echo; USER_INPUT=$3; break;;
            * ) echo "Please type the $2, or press <ENTER> for $3! "; echo;;
        esac
    done
}

S () {  # _S_udo command
    B sudo $@
}

B () {  # _B_ash command
    COMMAND="       ${02} ${03} ${04} ${05} ${06} ${07} ${08} ${09} ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} \
        ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} ${28} ${29} ${30} ${31} ${32} ${33} ${34} ${35} ${36} ${37} ${38} ${39} \
        ${40} ${41} ${42} ${43} ${44} ${45} ${46} ${47} ${48} ${49} ${50} ${51} ${52} ${53} ${54} ${55} ${56} ${57} ${58} ${59} \
        ${60} ${61} ${62} ${63} ${64} ${65} ${66} ${67} ${68} ${69} ${70} ${71} ${72} ${73} ${74} ${75} ${76} ${77} ${78} ${79} \
        ${80} ${81} ${82} ${83} ${84} ${85} ${86} ${87} ${88} ${89} ${90} ${91} ${92} ${93} ${94} ${95} ${96} ${97} ${98} ${99} "
    if [[ $1 = 'sudo' ]]; then
        COMMAND_FULL="sudo bash -c ' $COMMAND '"
        PROMPT='Run above command AS ROOT, yes or no?  [yes] '
    else
        COMMAND="$1 $COMMAND"
        COMMAND_FULL="bash -c ' $COMMAND '"
        PROMPT='Run above command, yes or no?  [yes] '
    fi
    echo '$' $COMMAND

    while true; do
        read -p "$PROMPT" -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; return;;
            y|Y ) echo; break;;
            '' ) break;;
            * ) echo;;
        esac
    done

#    $COMMAND_FULL  # ERROR: -c: line 0: unexpected EOF while looking for matching `''
    if [[ $1 = 'sudo' ]]; then
        sudo bash -c " $COMMAND "
    else
        bash -c " $COMMAND "
    fi
    echo
}

echo "[[[<<< RPerl Installer Script v$VERSION >>>]]]"
echo
echo '  [[[<<< Tested Using Fresh Installs >>>]]]'
echo
echo ' Ubuntu v14.04   (Trusty Tahr) in Virtual Box'
echo ' Ubuntu v14.04.1 (Trusty Tahr) on CloudAtCost.com'
echo 'Xubuntu v14.04.2 (Trusty Tahr)'
echo 'Xubuntu v16.04.1 (Xenial Xerus)'
echo
echo  '          [[[<<< Main Menu >>>]]]'
echo
echo  '         <<< PERL & RPERL SECTIONS >>>'
echo  '20. [[[ UBUNTU LINUX,   INSTALL  PERL DEPENDENCIES ]]]'
echo  '21. [[[ UBUNTU LINUX,   INSTALL SINGLE-USER PERL LOCAL::LIB  & CPANM ]]]'
echo  '22. [[[ UBUNTU LINUX,   INSTALL SINGLE-USER PERLBREW         & CPANM ]]]'
echo  '23. [[[ UBUNTU LINUX,   INSTALL SYSTEM-WIDE PERL FROM SOURCE & CPANM ]]]'
echo  '24. [[[ UBUNTU LINUX,   INSTALL SYSTEM-WIDE SYSTEM PERL      & CPANM ]]]'
echo  '25. [[[        LINUX,   INSTALL RPERL DEPENDENCIES ]]]'
echo  '26. [[[  PERL,          INSTALL RPERL, LATEST   STABLE VIA CPAN ]]]'
echo  '27. [[[  PERL,          INSTALL RPERL, LATEST UNSTABLE VIA GITHUB ]]]'
echo  '28. [[[ RPERL,          RUN COMPILER TESTS ]]]'
echo  '29. [[[ RPERL,          INSTALL RPERL FAMILY & RUN DEMOS ]]]'
echo

while true; do
    read -p 'Please type your chosen main menu section number, or press <ENTER> for 20... ' MENU_CHOICE
    case $MENU_CHOICE in
        [0123456789]|[123][0123456789]|4[0123] ) echo; break;;
        '' ) echo; MENU_CHOICE=20; break;;
        * ) echo 'Please choose a section number from the menu!'; echo;;
    esac
done

CURRENT_SECTION=$MENU_CHOICE

echo  '          [[[<<< Machine Menu >>>]]]'
echo
echo \ '0. [[[      NEW MACHINE; SERVER; REMOTE CLOUD HOST ]]]'
echo \ '1. [[[ EXISTING MACHINE; CLIENT; LOCAL USER SYSTEM ]]]'
echo

#while true; do
#    read -p 'Please type your machine menu choice number, or press <ENTER> for 0... ' MACHINE_CHOICE
#    case $MACHINE_CHOICE in
#        [01] ) echo; break;;
#        '' ) echo; MACHINE_CHOICE=0; break;;
#        * ) echo 'Please choose a number from the menu!'; echo;;
#    esac
#done

# SECTION 0 VARIABLES
EDITOR='__EMPTY__'
USERNAME='__EMPTY__'

if [ $MENU_CHOICE -le 20 ]; then
    echo '20. [[[ UBUNTU LINUX, INSTALL PERL DEPENDENCIES ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ Overview Of Perl Dependencies In This Section ]'
        echo '[ Git: Source Code Version Control, Required To Install Latest Development & Unstable Software ]'
        echo '[ cURL: Downloader, Required To Install cpanminus & Perlbrew & Perl-Build ]'
        echo '[ ExtUtils::MakeMaker: Source Code Builder, Required To Build Many Perl Software Suites ]'
        echo
        echo '[ Install git ]'
        S apt-get install git
        
        echo '[ Install cURL ]'
        S apt-get install curl
        echo '[ Check cURL Installation ]'
        B 'curl -L cpanmin.us > /dev/null'
        echo
        echo '[ Look For Any Errors In The Output From The curl Command Above ]'
        echo '[ WARNING: IF AND ONLY IF The Above curl Command Gives The Error On The Following Line, THEN Execute The echo Command In The Next Step ]'
        C 'Please read the warning above.  Seriously.'
        echo 'curl: (77) error setting certificate verify locations'
        echo
        B "echo 'cacert=/etc/ssl/certs/ca-certificates.crt' >> ~/.curlrc"

        echo '[ Optionally Disable Previous local::lib Or Perlbrew Installations ]'
        echo '[ NOTE: You SHOULD Disable Any Previous Perl Installations, Unless You Know What You Are Doing ]'
        B mv ~/perl5 ~/perl5.old

        echo '[ Install ExtUtils::MakeMaker System-Wide, Check Current System-Wide Version, Must Be v7.04 Or Newer ]'
        S 'perl -MExtUtils::MakeMaker\ 999'  # system-wide v7.04 or newer required by Inline::C & possibly others
        echo '[ Install ExtUtils::MakeMaker System-Wide ]'
        echo '[ NOTE: You MUST Have v7.04 Or Newer Installed System-Wide (And Also Single-User) For RPerl ]'
        echo '[ Choose Yes For Automatic Configuration & Also Yes For Automatic CPAN Mirror Selection ]'
        S cpan ExtUtils::MakeMaker
        echo '[ Install ExtUtils::MakeMaker System-Wide, Check Updated Version, Must Be v7.04 Or Newer ]'
        S 'perl -MExtUtils::MakeMaker\ 999'

        echo '[ Install ExtUtils::MakeMaker, Check Perl Version To Determine Which Of The Following Sections To Choose ]'
        B perl -v
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 21 ]; then
    echo '21. [[[ UBUNTU LINUX, INSTALL SINGLE-USER PERL LOCAL::LIB & CPANM ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD Use This Instead Of Perlbrew Or Perl From Source Or System Perl In Sections 22 & 23 & 24, Unless You Have No Choice ]'
        echo '[ This Option Will Contain All Perl Code In Your Home Directory Under The ~/perl5 Subdirectory ]'
        echo '[ This Option May  Not Work With Older Versions Of Debian GNU/Linux Which Include A Broken Perl v5.14, Use Perlbrew in Section 22 Instead ]'
        echo '[ This Option Will Not Work With Older Versions Of Perl Which Are Not At Least v5.10 Or Newer, Use Perlbrew in Section 22 Instead ]'
        echo '[ WARNING: Do NOT Mix With Perlbrew In Section 22! ]'
        echo '[ WARNING: Do NOT Mix With Perl From Source In Section 23! ]'
        echo '[ WARNING: Do NOT Mix With System Perl In Section 24! ]'
        C 'Please read the warnings above.  Seriously.'
        B 'curl -L cpanmin.us | perl - -l $HOME/perl5 App::cpanminus local::lib'
        # echo 'eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' >> ~/.bashrc  # DEV NOTE: pre-munged command for comparison
        B echo "'" eval '$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' "'" '>> ~/.bashrc'
        SOURCE ~/.bashrc
        echo '[ Ensure The Following 4 Environmental Variables Now Include ~/perl5: PERL_MM_OPT, PERL_MB_OPT, PERL5LIB, PATH ]'
        B 'set | grep perl5'
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 22 ]; then
    echo '22. [[[ UBUNTU LINUX, INSTALL SINGLE-USER PERLBREW & CPANM ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD NOT Use This Instead Of local::lib In Section 21, Unless You Have No Choice ]'
        echo '[ This Option WILL Work With Older Versions Of Debian GNU/Linux Which Include A Broken Perl v5.14 ]'
        echo '[ This Option WILL Work With Older Versions Of Perl Which Are Not At Least v5.10 Or Newer ]'
        echo '[ WARNING: Do NOT Mix With local::lib In Section 21! ]'
        echo '[ WARNING: Do NOT Mix With Perl From Source In Section 23! ]'
        echo '[ WARNING: Do NOT Mix With System Perl In Section 24! ]'
        C 'Please read the warnings above.  Seriously.'

        echo '[ You Should Use apt-get Instead Of curl Below, Unless You Are Not In Ubuntu Or Have No Choice ]'
        echo '[ WARNING: Use Only ONE Of The Following Two Commands, EITHER apt-get OR curl, But NOT Both! ]'
        C 'Please read the warning above.  Seriously.'
        echo '[ APT-GET OPTION ONLY: Install Perlbrew ]'
        S sudo apt-get install perlbrew
        # OR
        echo '[ CURL OPTION ONLY: Install Perlbrew ]'
        S 'curl -L http://install.perlbrew.pl | bash'

        echo '[ EITHER OPTION: Configure Perlbrew ]'
        B perlbrew init
        echo '[ EITHER OPTION: In Texas, The Following Perlbrew Mirror Is Recommended: Arlington, TX #222 http://mirror.uta.edu/CPAN/ ]'
        B perlbrew mirror
        B 'echo "source ~/perl5/perlbrew/etc/bashrc" >> ~/.bashrc'
        SOURCE ~/.bashrc
        echo '[ EITHER OPTION: Ensure The Following 3 Environmental Variables Now Include ~/perl5: PERLBREW_MANPATH, PERLBREW_PATH, PERLBREW_ROOT ]'
        B 'set | grep perl5'
        
        echo '[ EITHER OPTION: Build Perlbrew Perl v5.24.0 ]'
        B perlbrew install perl-5.24.0
        echo '[ EITHER OPTION: Temporaily Enable Perlbrew Perl v5.24.0 ]'
        B perlbrew use perl-5.24.0
        echo '[ EITHER OPTION: Permanently Enable Perlbrew Perl v5.24.0 ]'
        B perlbrew switch perl-5.24.0
        echo '[ EITHER OPTION: Install Perlbrew CPANM ]'
        B perlbrew install-cpanm

        echo '[ EITHER OPTION: ExtUtils::MakeMaker v7.04 Or Newer Is Required By Inline::C, May Need To Re-Install In Single-User Mode ]'
        echo '[ EITHER OPTION: Check Version Of ExtUtils::MakeMaker, Re-Install If Older Than v7.04 ]'
        B 'perl -MExtUtils::MakeMaker\ 999'
        echo '[ EITHER OPTION: Re-Install ExtUtils::MakeMaker Via CPAN, Because Perlbrew Acts As System-Wide Perl In Single-User Mode ]'
        echo '[ NOTE: You MUST Have v7.04 Or Newer Installed System-Wide (And Also Single-User) For RPerl ]'
        B cpanm ExtUtils::MakeMaker
        echo '[ EITHER OPTION: Re-Check Version Of ExtUtils::MakeMaker, Must Be v7.04 Or Newer ]'
        B 'perl -MExtUtils::MakeMaker\ 999'
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 23 ]; then
    echo '23. [[[ UBUNTU LINUX, INSTALL SYSTEM-WIDE PERL FROM SOURCE & CPANM ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD NOT Use This Instead Of local::lib In Section 21, Unless You Have No Choice ]'
        echo '[ WARNING: Do NOT Mix With local::lib In Section 21! ]'
        echo '[ WARNING: Do NOT Mix With Perlbrew In Section 22! ]'
        echo '[ WARNING: Do NOT Mix With System Perl In Section 24! ]'
        C 'Please read the warnings above.  Seriously.'
        echo '[ WARNING: Choose ONLY ONE Of The Following Two Methods: Manual Build, Or Tokuhirom Perl-Build ]'
        C 'Please read the warning above.  Seriously.'
        # NEED ANSWER: does this actually work?
        echo '[ MANUAL BUILD OPTION ONLY: Download Perl Source Code ]'
        B 'wget http://www.cpan.org/src/5.0/perl-5.24.0.tar.bz2; tar -xjvf perl-5.24.0.tar.bz2'
        echo '[ MANUAL BUILD OPTION ONLY: Build Perl Source Code ]'
        B 'cd perl-5.24.0; ./Configure -des; make; make test'
        echo '[ MANUAL BUILD OPTION ONLY: Install Perl Build ]'
        S 'cd perl-5.24.0; make install'
        # OR
        echo '[ TOKUHIROM PERL-BUILD ONLY: Download, Build, Install Perl ]'
        # NEED ANSWER: does this actually work?
        S 'curl https://raw.githubusercontent.com/tokuhirom/Perl-Build/master/perl-build | perl - 5.24.0 /usr/local/bin/perl-5.24.0/'
        echo '[ EITHER OPTION: Install cpanminus ]'
        S perl -MCPAN -e 'install App::cpanminus'
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 24 ]; then
    echo '24. [[[ UBUNTU LINUX, INSTALL SYSTEM-WIDE SYSTEM PERL & CPANM ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD NOT Use This Instead Of local::lib In Section 21, Unless You Have No Choice ]'
        echo '[ This Option Will Install Both Perl & cpanminus System-Wide ]'
        echo '[ Also, All Future CPAN Distributions Will Install System-Wide In A Hard-To Control Manner ]'
        echo '[ WARNING: Do NOT Mix With local::lib In Section 21! ]'
        echo '[ WARNING: Do NOT Mix With Perlbrew In Section 22! ]'
        echo '[ WARNING: Do NOT Mix With Perl From Source In Section 23! ]'
        C 'Please read the warnings above.  Seriously.'
        S apt-get install perl cpanminus
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 25 ]; then
    echo '25. [[[ LINUX, INSTALL RPERL DEPENDENCIES ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ Overview Of RPerl Dependencies In This Section ]'
        echo '[ GCC: gcc & g++ Required For Compiling ]'
        echo '[ libc: libcrypt.(a|so) Required For Compiling ]'
        echo '[ libperl: libperl.(a|so) Required For Compiling ]'
        echo '[ zlib: zlib.h Required By SDL.pm, Which Is Required For Graphics ]'
        echo '[ GMP: GNU Multiple-Precision Arithmetic Library Required For Math ]'
        echo '[ Pluto polyCC: polycc Required For Parallel Compiling, Depends On texinfo flex bison ]'
        echo '[ AStyle: Artistic Style C++ Formatter, Required By RPerl Test Suite ]'
        echo
        echo '[ UBUNTU OPTION ONLY: Install RPerl Dependencies ]'
        S apt-get install g++ libc6-dev libperl-dev zlib1g-dev libgmp-dev texinfo flex bison astyle

        echo '[ ANY OPTION: Check GCC Version, Must Be v4.7 Or Newer, Use Manual Build Option If Automatic Install Options Fail Or Are Too Old ]'
        B g++ --version

        echo '[ ANY OPTION: Install RPerl Dependency Pluto PolyCC, Download ]'
        B 'wget https://github.com/wbraswell/pluto-mirror/raw/master/backup/pluto-0.11.4.tar.gz; tar -xzvf pluto-0.11.4.tar.gz'
        echo '[ ANY OPTION: Install RPerl Dependency Pluto PolyCC, Build ]'
        B 'cd pluto-0.11.4; ./configure; make; make test'
        echo '[ ANY OPTION: Install RPerl Dependency Pluto PolyCC, Install ]'
        S 'cd pluto-0.11.4; make install'

        # OR

        echo '[ REDHAT OR CENTOS OPTION ONLY: Install RPerl Dependency GCC, Download Yum Repo ]'
        S wget http://people.centos.org/tru/devtools-1.1/devtools-1.1.repo -P /etc/yum.repos.d
        echo '[ REDHAT OR CENTOS OPTION ONLY: Install RPerl Dependency GCC, Enable Yum Repo ]'
        S 'echo "enabled=1" >> /etc/yum.repos.d/devtools-1.1.repo'
        echo '[ REDHAT OR CENTOS OPTION ONLY: Install RPerl Dependency GCC, Install Via Yum ]'
        S yum install devtoolset-1.1
        echo '[ REDHAT OR CENTOS OPTION ONLY: Install RPerl Dependency GCC, Enable Via .bashrc ]'
        B 'echo -e "\n# utilize upgraded GCC\nexport CC=/opt/centos/devtoolset-1.1/root/usr/bin/gcc\nexport CPP=/opt/centos/devtoolset-1.1/root/usr/bin/cpp\nexport CXX=/opt/centos/devtoolset-1.1/root/usr/bin/c++" >> ~/.bashrc'  # DEV NOTE: must wrap redirects in quotes
        echo '[ REDHAT OR CENTOS OPTION ONLY: Install RPerl Dependency GMP, Install GMP Via urmpi ]'
        S urpmi gmpxx-devel

        # OR

        echo '[ MANUAL BUILD OPTION ONLY: Install RPerl Dependency GCC, Download ]'
        B 'wget http://www.netgull.com/gcc/releases/gcc-5.2.0/gcc-5.2.0.tar.bz2; tar -xjvf gcc-5.2.0.tar.bz2'
        echo '[ MANUAL BUILD OPTION ONLY: Install RPerl Dependency GCC, Build ]'
        B 'cd gcc-5.2.0; ./configure; make; make test'
        echo '[ MANUAL BUILD OPTION ONLY: Install RPerl Dependency GCC, Install ]'
        S 'cd gcc-5.2.0; make install'
        echo '[ MANUAL BUILD OPTION ONLY: Install RPerl Dependency GMP, Visit The Following URL For Installation Instructions ]'
        echo 'https://gmplib.org'
        echo '[ MANUAL BUILD OPTION ONLY: Install RPerl Dependency AStyle, Visit The Following URL For Installation Instructions ]'
        echo 'http://astyle.sourceforge.net'
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 26 ]; then
    echo '26. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPAN ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You Should Use This Instead Of Unstable Via GitHub In Section 27, Unless You Are An RPerl System Developer ]'
        echo '[ This Option Will Install The Latest Stable Public Release Of RPerl ]'
        echo '[ WARNING: Do NOT Mix With Unstable Via GitHub In Section 27! ]'
        C 'Please read the warning above.  Seriously.'
        echo
        echo '[ You Should Use Single-User Instead Of System-Wide Below, Unless local::lib Or Perlbrew Is Not Installed Or You Have No Choice ]'
        echo '[ WARNING: Use Only ONE Of The Following Two Options, EITHER Single-User OR System-Wide, But NOT Both! ]'
        C 'Please read the warning above.  Seriously.'
        echo '[ SINGLE-USER OPTION ONLY: Install RPerl ]'
        B cpanm -v RPerl
        # OR
        echo '[ SYSTEM-WIDE OPTION ONLY: Install RPerl ]'
        S cpanm -v RPerl

        echo '[ EITHER OPTION: If cpanm Is Not Installed, Exit This Installer & Manually Try cpan Instead ]'
        echo '[ Copy The Command From The Following Line For Single-User Option ]'
        echo '$ cpan RPerl'
        echo
        echo '[ Copy The Command From The Following Line For System-Wide Option ]'
        echo '$ sudo cpan RPerl'
        echo
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 27 VARIABLES
GITHUB_EMAIL='__EMPTY__'
GITHUB_FIRST_NAME='__EMPTY__'
GITHUB_LAST_NAME='__EMPTY__'
RPERL_REPO_DIRECTORY='__EMPTY__'

if [ $MENU_CHOICE -le 27 ]; then
    echo '27. [[[ PERL, INSTALL RPERL, LATEST UNSTABLE VIA GITHUB ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD NOT Use This Instead Of Stable Via CPAN In Section 26, Unless You Are An RPerl System Developer ]'
        echo '[ This Option Will Install The Latest Unstable Development Release Of RPerl ]'
        echo '[ WARNING: Do NOT Mix With Stable Via CPAN In Section 26! ]'
        C 'Please read the warning above.  Seriously.'
        echo
        echo '[ If You Want To Upload Code To GitHub, Then You Must Use Secure Git Instead Of Public Git Or Public Zip Below ]'
        echo '[ WARNING: Use Only ONE Of The Following Three Options, EITHER Secure OR Public Git OR Public Zip, But NOT More Than One! ]'
        C 'Please read the warning above.  Seriously.'

        D $EDITOR 'preferred text editor' 'vi'
        EDITOR=$USER_INPUT
        D $USERNAME "new machine's username" `whoami`
        USERNAME=$USER_INPUT
        P $GITHUB_EMAIL "e-mail address used for GitHub account (any value if not using Secure Git option)"
        GITHUB_EMAIL=$USER_INPUT
        P $GITHUB_FIRST_NAME "first name used for GitHub account (any value if not using Secure Git option)"
        GITHUB_FIRST_NAME=$USER_INPUT
        P $GITHUB_LAST_NAME "last name used for GitHub account (any value if not using Secure Git option)"
        GITHUB_LAST_NAME=$USER_INPUT
        D $RPERL_REPO_DIRECTORY 'directory where the RPerl repository should be downloaded (different than final RPerl installation directory)' "~/rperl-latest"
        RPERL_REPO_DIRECTORY=$USER_INPUT

        # DEV NOTE: for more info, see  https://help.github.com/articles/generating-ssh-keys
        #if [ ! -f ~/.ssh/id_rsa.pub ] && [ ! -f ~/.ssh/id_dsa.pub ]; then  # NEED ANSWER: do we need id_dsa.pub???
        if [ ! -f ~/.ssh/id_rsa.pub ]; then
            echo '[ SECURE GIT OPTION ONLY: Generate SSH Keys, Do Create Secure Key Passphrase When Prompted ]'
            echo '[ WARNING: Be Sure To Record Your Secure Key Passphrase & Store It In A Safe Place ]'
            C 'Please read the warning above.  Seriously.'
            B "ssh-keygen -t rsa -C '$GITHUB_EMAIL'; eval `ssh-agent -s` ssh-add ~/.ssh/id_rsa; ssh-agent -k"
        else
            echo '[ SECURE GIT OPTION ONLY: SSH Key File(s) Already Exist, Skipping Key Generation ]'
        fi

        echo '[ SECURE GIT OPTION ON UBUNTU ONLY: Install Keychain Key Manager For OpenSSH ]'
        S apt-get install keychain
        C '[ SECURE GIT OPTION ON NON-UBUNTU ONLY: Please See Your Operating System Documentation To Install Keychain Key Manager For OpenSSH ]'
        echo '[ SECURE GIT OPTION ONLY: Enable Keychain ]'
        echo '[ NOTE: Do Not Run The Following Step If You Already Copied Your Own Pre-Existing LAMP University .bashrc File In Section 0 ]'
        B 'echo -e "\n# SSH Keys; for GitHub, etc.\nif [ -f /usr/bin/keychain ] && [ -f \$HOME/.ssh/id_rsa ]; then\n    /usr/bin/keychain \$HOME/.ssh/id_rsa\n    source \$HOME/.keychain/\$HOSTNAME-sh\nfi" >> ~/.bashrc;'
        SOURCE ~/.bashrc
        echo '[ SECURE GIT OPTION ONLY: How To Enable SSH Key On GitHub... ]'
        echo '[ SECURE GIT OPTION ONLY: Copy Data Produced By The Next Command ]'
        echo '[ SECURE GIT OPTION ONLY: Then Browse To https://github.com/settings/ssh ]'
        echo "[ SECURE GIT OPTION ONLY: Then Click 'Add SSH Key', Paste Copied Key Data, Title '$USERNAME@$HOSTNAME', Click 'Save' ]"
        echo
        B 'cat ~/.ssh/id_rsa.pub'
        echo
        C '[ SECURE GIT OPTION ONLY: Please Follow The Instructions Above ]'
        echo '[ SECURE GIT OPTION ONLY: Test SSH Key On GitHub, Enter Passphrase When Prompted, Confirm Automatic Reply Greeting From GitHub Server ]'
        B ssh -T git@github.com
        echo '[ SECURE GIT OPTION ONLY: Configure GitHub Account Setting On Local Machine ]'
        echo '[ NOTE: Do Not Repeat The 3 Following git config Steps If You Already Copied Your Own Pre-Existing .gitconfig File In Section 0 ]'
        B git config --global user.email "$GITHUB_EMAIL"
        B git config --global user.name "$GITHUB_FIRST_NAME $GITHUB_LAST_NAME"
        B git config --global core.editor "$EDITOR"
        echo '[ SECURE GIT OPTION ONLY: Clone (Download) RPerl Repository Onto New Machine ]'
        B git clone git@github.com:wbraswell/rperl.git $RPERL_REPO_DIRECTORY
        # OR
        echo '[ PUBLIC GIT OPTION ONLY: Clone (Download) RPerl Repository Onto New Machine ]'
        B git clone https://github.com/wbraswell/rperl.git $RPERL_REPO_DIRECTORY
        # OR
        echo '[ PUBLIC ZIP OPTION ONLY: Download RPerl Repository Onto New Machine ]'
        B 'wget https://github.com/wbraswell/rperl/archive/master.zip; unzip master.zip; mv rperl-master $RPERL_REPO_DIRECTORY; rm master.zip'

        echo '[ ALL OPTIONS: Install RPerl Dependencies Via CPAN ]'
        CD $RPERL_REPO_DIRECTORY
        B 'perl Makefile.PL; cpanm --installdeps .'
        echo '[ ALL OPTIONS: Build & Test RPerl ]'
        B 'make; make test'
        echo '[ ALL OPTIONS: Build & Test RPerl, Optional Verbose Output ]'
        B 'make; make test TEST_VERBOSE=1'
        echo '[ ALL OPTIONS: Install RPerl ]'
        B 'make install'
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 28 VARIABLES
RPERL_VERBOSE='__EMPTY__'
RPERL_DEBUG='__EMPTY__'
RPERL_WARNINGS='__EMPTY__'
RPERL_INSTALL_DIRECTORY='__EMPTY__'

if [ $MENU_CHOICE -le 28 ]; then
    echo '28. [[[ RPERL, RUN COMPILER TESTS ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        D $RPERL_VERBOSE 'RPERL_VERBOSE additional user output, 0 for off, 1 for on' '1'
        export RPERL_VERBOSE=$USER_INPUT
        D $RPERL_DEBUG 'RPERL_DEBUG additional system output, 0 for off, 1 for on' '1'
        export RPERL_DEBUG=$USER_INPUT
        D $RPERL_WARNINGS 'RPERL_WARNINGS additional user & system warnings, 0 for off, 1 for on' '0'
        export RPERL_WARNINGS=$USER_INPUT
        D $RPERL_INSTALL_DIRECTORY 'directory where RPerl is currently installed' "~/perl5/lib/perl5"
        RPERL_INSTALL_DIRECTORY=$USER_INPUT

        echo '[ These RPerl Test Commands Must Be Executed From Within The RPerl Installation Directory ]'
        CD $RPERL_INSTALL_DIRECTORY

        echo '[ Display RPerl Command Usage, Ensure RPerl Command Is Properly Functioning ]'
        B rperl -?

        echo '[ Test Command Sequence #1, OO Inheritance Test: Clean Pre-Existing Compiled Files ]'
        B rm -Rf _Inline RPerl/Algorithm.pmc RPerl/Algorithm.h RPerl/Algorithm.cpp RPerl/Algorithm/Sort.pmc RPerl/Algorithm/Sort.h RPerl/Algorithm/Sort.cpp RPerl/Algorithm/Sort/Bubble.pmc RPerl/Algorithm/Sort/Bubble.h RPerl/Algorithm/Sort/Bubble.cpp

        RPERL_CODE='use RPerl::Algorithm::Sort::Bubble; my $o = RPerl::Algorithm::Sort::Bubble->new(); $o->inherited__Bubble("logan"); $o->inherited__Sort("wolvie"); $o->inherited__Algorithm("claws");'

        echo '[ Test Command Sequence #1, OO Inheritance Test: Zero Of Three Files Are Compiled, Output Should Be PERLOPS_PERLTYPES, PERLOPS_PERLTYPES, PERLOPS_PERLTYPES ]'
        B "perl -e '$RPERL_CODE'"
    
        echo '[ Test Command Sequence #1, OO Inheritance Test: Compile First Of Three Files ]'
        B rperl -V -nop RPerl/Algorithm.pm
        echo '[ Test Command Sequence #1, OO Inheritance Test: One Of Three Files Are Compiled, Output Should Be PERLOPS_PERLTYPES, PERLOPS_PERLTYPES, CPPOPS_CPPTYPES ]'
        B "perl -e '$RPERL_CODE'"

        echo '[ Test Command Sequence #1, OO Inheritance Test: Compile Second Of Three Files ]'
        B rperl -V -nop RPerl/Algorithm/Sort.pm
        echo '[ Test Command Sequence #1, OO Inheritance Test: Two Of Three Files Are Compiled, Output Should Be PERLOPS_PERLTYPES, CPPOPS_CPPTYPES, CPPOPS_CPPTYPES ]'
        B "perl -e '$RPERL_CODE'"

        echo '[ Test Command Sequence #1, OO Inheritance Test: Compile Third Of Three Files ]'
        B rperl -V -nop RPerl/Algorithm/Sort/Bubble.pm
        echo '[ Test Command Sequence #1, OO Inheritance Test: All Three Files Are Compiled, Output Should Be CPPOPS_CPPTYPES, CPPOPS_CPPTYPES, CPPOPS_CPPTYPES ]'
        B "perl -e '$RPERL_CODE'"

        echo '[ Test Command Sequence #1, OO Inheritance Test: Clean New Compiled Files ]'
        B rm -Rf _Inline RPerl/Algorithm.pmc RPerl/Algorithm.h RPerl/Algorithm.cpp RPerl/Algorithm/Sort.pmc RPerl/Algorithm/Sort.h RPerl/Algorithm/Sort.cpp RPerl/Algorithm/Sort/Bubble.pmc RPerl/Algorithm/Sort/Bubble.h RPerl/Algorithm/Sort/Bubble.cpp

        # NEED FIX: sequence 1 & sequence 2 directories don't match, also installed vs uninstalled directories don't match

        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Clean Pre-Existing Compiled Files ]'
        B ../script/demo/unlink_bubble.sh

        RPERL_CODE='use RPerl::Algorithm::Sort::Bubble; my $a = [reverse 0 .. 5000]; use Time::HiRes qw(time); my $start = time; my $s = RPerl::Algorithm::Sort::Bubble::integer_bubblesort($a); my $elapsed = time - $start; print Dumper($s); print "elapsed: " . $elapsed . "\n";'

        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Slow Uncompiled PERLOPS_PERLTYPES Mode, ~15 Seconds For 5_000 Elements, ~60 Seconds For 10_000 Elements ]'
        B "perl -e '$RPERL_CODE'"

        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Fast Manually Compiled CPPOPS_PERLTYPES Mode, Link Files ]'
        B ../script/demo/link_bubble_CPPOPS_PERLTYPES.sh
        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Fast Manually Compiled CPPOPS_PERLTYPES Mode, ~2.36 Seconds For 5_000 Elements, ~9.4 Seconds For 10_000 Elements ]'
        B "perl -e '$RPERL_CODE'"

        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Clean New Compiled Files ]'
        B ../script/demo/unlink_bubble.sh
        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Super Fast Automatically Compiled CPPOPS_CPPTYPES Mode, Compile Files ]'


# START HERE: call to rperl command below fails to find dependencies
# START HERE: call to rperl command below fails to find dependencies
# START HERE: call to rperl command below fails to find dependencies


        B rperl -V -nop RPerl/Algorithm/Sort/Bubble.pm
        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Super Fast Automatically Compiled CPPOPS_CPPTYPES Mode, ~0.04 Seconds For 5_000 Elements, ~0.18 Seconds For 10_000 Elements ]'
        B "perl -e '$RPERL_CODE'"

        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Clean New Compiled Files ]'
        B ../script/demo/unlink_bubble.sh
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 29 VARIABLES
PHYSICSPERL_ENABLE_GRAPHICS='__EMPTY__'
PHYSICSPERL_NBODY_STEPS='__EMPTY__'

if [ $MENU_CHOICE -le 29 ]; then
    echo '29. [[[ RPERL, INSTALL RPERL FAMILY & RUN DEMOS ]]]'
    echo
#    if [ $MACHINE_CHOICE -eq 0 ]; then
        D $RPERL_VERBOSE 'RPERL_VERBOSE additional user output, 0 for off, 1 for on' '1'
        export RPERL_VERBOSE=$USER_INPUT
        D $RPERL_DEBUG 'RPERL_DEBUG additional system output, 0 for off, 1 for on' '1'
        export RPERL_DEBUG=$USER_INPUT
        D $RPERL_WARNINGS 'RPERL_WARNINGS additional user & system warnings, 0 for off, 1 for on' '0'
        export RPERL_WARNINGS=$USER_INPUT
        D $PHYSICSPERL_ENABLE_GRAPHICS 'enabling of PhysicsPerl graphics, 0 for off, 1 for on' '0'
        PHYSICSPERL_ENABLE_GRAPHICS=$USER_INPUT
        D $PHYSICSPERL_NBODY_STEPS 'number of PhysicsPerl N-Body steps to complete (more steps is longer runtime)' '1_000_000'
        PHYSICSPERL_NBODY_STEPS=$USER_INPUT

        # DEV NOTE: PATH & PERL5LIB may already be set via LAMP University Run Commands .bashrc, but temporarily modify anyway just in case
        PATH=script:$PATH
        PERL5LIB=lib:$PATH

        # NEED UPDATE: add option to install PhysicsPerl via CPAN
        echo '[ Install Latest Unstable PhysicsPerl Via Public Github ]'
        B 'wget https://github.com/wbraswell/physicsperl/archive/master.zip; unzip master.zip; my physicsperl-master ~/physicsperl-latest; rm -rf master.zip'
        CD ~/physicsperl-latest
        echo '[ Install PhysicsPerl Dependencies Via CPAN ]'
        B cpanm --installdeps .

        # NEED UPDATE: add timings for all modes at 1M steps instead of only 50M steps

        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Clean Pre-Existing Compiled Files ]'
        B script/demo/unlink_astro.sh
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Super Slow Uncompiled PERLOPS_PERLTYPES_SSE Mode, Link Files ]'
        B script/demo/link_astro_PERLOPS_PERLTYPES_SSE.sh
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Super Slow Uncompiled PERLOPS_PERLTYPES_SSE Mode, Several Days For 50M Steps Without Graphics ]'
        echo '[ NOTE: This Test Could Take SEVERAL HOURS OR DAYS To Run!!! ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS

        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Clean Pre-Existing Compiled Files ]'
        B script/demo/unlink_astro.sh
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Slow Uncompiled PERLOPS_PERLTYPES Mode, Link Files ]'
        B script/demo/link_astro_PERLOPS_PERLTYPES.sh
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Slow Uncompiled PERLOPS_PERLTYPES Mode, Over 9 Hours For 50M Steps Without Graphics ]'
        echo '[ NOTE: This Test Could Take SEVERAL MINUTES OR HOURS To Run!!! ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS

        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Clean New Compiled Files ]'
        B script/demo/unlink_astro.sh
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Super Fast Manually Compiled CPPOPS_CPPTYPES Mode, Link Files ]'
        B script/demo/link_astro_CPPOPS_CPPTYPES.sh
        # NEED UPDATE: add 50M steps timing value for CPPOPS_CPPTYPES (non-SSE)
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Super Fast Manually Compiled CPPOPS_CPPTYPES Mode, ~XYZ Seconds For 50M Steps Without Graphics ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS

        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Clean New Compiled Files ]'
        B script/demo/unlink_astro.sh
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Ultra Fast Manually Compiled CPPOPS_CPPTYPES_SSE Mode, Link Files ]'
        B script/demo/link_astro_CPPOPS_CPPTYPES_SSE.sh
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Ultra Fast Manually Compiled CPPOPS_CPPTYPES_SSE Mode, ~13 Seconds For 50M Steps Without Graphics ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS

        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Clean New Compiled Files ]'
        B script/demo/unlink_astro.sh
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Ultra Fast Automatically Compiled CPPOPS_CPPTYPES_SSE Mode, Compile Files ]'
        B rperl -V -nop lib/PhysicsPerl/Astro/System.pm
        echo '[ Test Command Sequence #0, PhysicsPerl N-Body Timing Test: Ultra Fast Automatically Compiled CPPOPS_CPPTYPES_SSE Mode, ~13 Seconds For 50M Steps Without Graphics ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS
#    elif [ $MACHINE_CHOICE -eq 1 ]; then
#        echo "Nothing To Do On Existing Machine!"
#    fi
#    CURRENT_SECTION_COMPLETE  # final section!
fi

echo
echo '[[[ ALL DONE!!! ]]]'
echo
