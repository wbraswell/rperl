#!/bin/bash
# Copyright © 2014, 2015, 2016, 2017, 2018, William N. Braswell, Jr.. All Rights Reserved. This work is Free \& Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.24.0.
# RPerl Installer Script (directly copied from LAMP Installer Script)
VERSION='0.224_000'

# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!
# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!
# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!

# PRE-PRE-INSTALL: install wget
# sudo apt-get install wget
# OR
# sudo yum install wget

# PRE-INSTALL: download the latest version of this file and make it executable
# wget https://raw.githubusercontent.com/wbraswell/rperl/master/script/rperl_installer.sh; chmod a+x ./rperl_installer.sh
# OR
# wget tinyurl.com/NEED_NEW_TINYURL; chmod a+x NEED_NEW_TINYURL

# enable extended pattern matching in case statements
shopt -s extglob

# global variables
USER_INPUT=''
CURRENT_SECTION=0
OS_CHOICE="UNKNOWN"

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

VERIFY_OS_CHOICE() {
    local OS_REQ="$1"
    local CHOICE="$OS_CHOICE"

    local GUESS='UNKNOWN'
    if [[ -f "/etc/redhat-release" ]]; then
        GUESS='CENTOS'
    elif [[ -f "/etc/debian_version" ]]; then
        GUESS='UBUNTU'
    fi

    if [[ "$GUESS" != "$CHOICE" ]]; then
        PROMPT="NOT OK: OS_CHOICE is $CHOICE but I think you are running $GUESS ! Proceed? "
        while true; do
            read -p "$PROMPT" -n 1 PROMPT_INPUT
            case $PROMPT_INPUT in
                n|N ) echo; echo; exit 1;;
                y|Y ) echo; break;;
                * ) echo;;
            esac
        done
    fi

    if [[ "$OS_REQ" != "$CHOICE" ]]; then
        PROMPT="NOT OK: OS must be $OS_REQ but you chose $OS_CHOICE! Proceed Anyway? "
        while true; do
            read -p "$PROMPT" -n 1 PROMPT_INPUT
            case $PROMPT_INPUT in
                n|N ) echo; echo; exit 1;;
                y|Y ) echo; break;;
                * ) echo;;
            esac
        done
        echo
    fi
}

VERIFY_CENTOS() {
    VERIFY_OS_CHOICE 'CENTOS'
}

VERIFY_UBUNTU() {
    VERIFY_OS_CHOICE 'UBUNTU'
}

echo "[[[<<< LAMP Installer Script v$VERSION >>>]]]"
echo
echo '  [[[<<< Tested Using Fresh Installs >>>]]]'
echo
echo 'Xubuntu v14.04.2 (Trusty Tahr)'
echo 'Xubuntu v16.04.4 (Xenial Xerus)'
echo
echo  '          [[[<<< Main Menu >>>]]]'
echo
echo  '         <<< PERL & RPERL SECTIONS >>>'
echo  '20. [[[        LINUX,   INSTALL  PERL DEPENDENCIES ]]]'
echo  '21. [[[        LINUX,   INSTALL SINGLE-USER PERL LOCAL::LIB  & CPANM ]]]'
echo  '22. [[[        LINUX,   INSTALL SINGLE-USER PERLBREW         & CPANM ]]]'
echo  '23. [[[        LINUX,   INSTALL SYSTEM-WIDE PERL FROM SOURCE & CPANM ]]]'
echo  '24. [[[        LINUX,   INSTALL SYSTEM-WIDE SYSTEM PERL      & CPANM ]]]'
echo  '25. [[[        LINUX,   INSTALL RPERL DEPENDENCIES ]]]'
echo  '26. [[[  PERL,          INSTALL RPERL, LATEST   STABLE VIA CPAN ]]]'
echo  '27. [[[  PERL,          INSTALL RPERL, LATEST UNSTABLE VIA GITHUB ]]]'
echo  '28. [[[ RPERL,          RUN COMPILER TESTS ]]]'
echo  '29. [[[ RPERL,          INSTALL RPERL FAMILY & RUN DEMOS ]]]'
echo

while true; do
    read -p 'Please type your chosen main menu section number, or press <ENTER> for 0... ' MENU_CHOICE
    case $MENU_CHOICE in
        [0123456789]|[1234][0123456789]|5[01]|60 ) echo; break;;
        '' ) echo; MENU_CHOICE=0; break;;
        * ) echo 'Please choose a section number from the menu!'; echo;;
    esac
done

CURRENT_SECTION=$MENU_CHOICE

echo  '          [[[<<< Machine Menu >>>]]]'
echo
echo \ '0. [[[      NEW MACHINE; SERVER; REMOTE CLOUD HOST ]]]'
echo \ '1. [[[ EXISTING MACHINE; CLIENT; LOCAL USER SYSTEM ]]]'
echo

while true; do
    read -p 'Please type your machine menu choice number, or press <ENTER> for 0... ' MACHINE_CHOICE
    case $MACHINE_CHOICE in
        [01] ) echo; break;;
        '' ) echo; MACHINE_CHOICE=0; break;;
        * ) echo 'Please choose a number from the menu!'; echo;;
    esac
done

echo  '          [[[<<< OS Menu >>>]]]'
echo
echo \ '0. [[[           UBUNTU       ]]]'
echo \ '1. [[[           CENTOS       ]]]'
echo

while true; do
   read -p 'Please type your OS menu choice number, or press <ENTER> for 0... ' OS_CHOICE
   case $OS_CHOICE in
       0 ) echo; OS_CHOICE='UBUNTU'; break;;
       1 ) echo; OS_CHOICE='CENTOS'; break;;
       '' ) echo; OS_CHOICE='UBUNTU'; break;;
       * ) echo 'Please choose a number from the menu!'; echo;;
   esac
done

# SECTION X VARIABLES
EDITOR='__EMPTY__'
USERNAME='__EMPTY__'
IP_ADDRESS='__EMPTY__'
DOMAIN_NAME='__EMPTY__'

if [ $MENU_CHOICE -le 20 ]; then
    echo '20. [[[ LINUX, INSTALL PERL DEPENDENCIES ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ Overview Of Perl Dependencies In This Section ]'
        echo '[ CPAN: The Comprehensive Perl Archive Network, Required For Installing Perl Software ]'
        echo '[ Perl Debug: Symbols For The Perl Interpreter, Optional For Perl Core & XS & RPerl Debugging ]'
        echo '[ Git: Source Code Version Control, Required To Install Latest Development & Unstable Software ]'
        echo '[ Make: Program Builder, Required To Build ExtUtils::MakeMaker ]'
        echo '[ cURL: Downloader, Required To Install cpanminus & Perlbrew & Perl-Build ]'
        echo '[ ExtUtils::MakeMaker: Source Code Builder, Required To Build Many Perl Software Suites ]'
        echo

        if [[ "$OS_CHOICE" == "UBUNTU" ]]; then
            VERIFY_UBUNTU
            echo '[ UBUNTU ONLY: Install Perl Debugging Symbols System-Wide ]'
            S apt-get install perl-debug
            echo '[ UBUNTU ONLY: Install git ]'
            S apt-get install git
            echo '[ UBUNTU ONLY: Install make ]'
            S apt-get install make
            echo '[ UBUNTU ONLY: Install cURL ]'
            S apt-get install curl
            echo '[ UBUNTU ONLY: Check Install, Confirm No Errors ]'
            S apt-get -f install
        # OR
        elif [[ "$OS_CHOICE" == "CENTOS" ]]; then
            VERIFY_CENTOS
            echo '[ CENTOS ONLY: Install CPAN ]'
            S yum install perl-core perl-CPAN
            echo '[ CENTOS ONLY: Install Perl Debugging Symbols System-Wide ]'
            echo '[ NOT CURRENTLY AVAILABLE FOR CENTOS ]'
            echo '[ CENTOS ONLY: Install git ]'
            S yum install git
            echo '[ CENTOS ONLY: Install make ]'
            S yum install make
            echo '[ CENTOS ONLY: Install cURL ]'
            S yum install curl
            echo '[ CENTOS ONLY: Check Install, Confirm No Errors; WARNING! MAKE TAKE HOURS TO RUN! ]'
            S yum check
        fi

        echo '[ Check cURL Installation ]'
        B 'curl -L cpanmin.us > /dev/null'
        echo
        echo '[ Look For Any Errors In The Output From The curl Command Above ]'
        echo '[ WARNING: IF AND ONLY IF The Above curl Command Gives The Error On The Following Line, THEN Execute The echo Command In The Next Step ]'
        echo 'curl: (77) error setting certificate verify locations'
        echo
        C 'Please read the warning above.  Seriously.'
        echo
        B "echo 'cacert=/etc/ssl/certs/ca-certificates.crt' >> ~/.curlrc"

        echo '[ Optionally Disable Previous local::lib Or Perlbrew Installations ]'
        echo '[ NOTE: You SHOULD Disable Any Previous Perl Installations, Unless You Know What You Are Doing ]'
        B mv ~/perl5 ~/perl5.old

        echo '[ Install ExtUtils::MakeMaker System-Wide, Check Current System-Wide Version, Must Be v7.04 Or Newer ]'
        S 'perl -MExtUtils::MakeMaker\ 999'  # system-wide v7.04 or newer required by Inline::C & possibly others
        echo '[ Install ExtUtils::MakeMaker System-Wide ]'
        echo '[ NOTE: You MUST Have v7.04 Or Newer Installed System-Wide (And Also Single-User) For RPerl ]'
        # DEV NOTE: create Perl lib dirs due to CentOS bug, dirs should already exist but do not, checked by CPAN::FirstTime::_can_write_to_libdirs()
        echo '[ Ensure Perl Library Directories Exist ]'
        S "perl -e 'use Config; use File::Path qw(make_path); foreach my \$dir_key (qw(installprivlib installarchlib installsitelib installsitearch)) { if (not -e \$Config{\$dir_key}) { my \$success = make_path(\$Config{\$dir_key}); if (\$success) { print q{Created directory: }, \$Config{\$dir_key}, qq{\\n}; } else { print q{Error, could not create directory: }, \$Config{\$dir_key}, qq{\\n}, \$!, qq{\\n}; } } else { print q{Directory already exists: }, \$Config{\$dir_key}, qq{\\n}; } }'"
        echo '[ Choose "yes" For Automatic Configuration & Also "yes" For Automatic CPAN Mirror Selection ]'
        echo '[ Choose "sudo" For Installation Approach If Previous Command Does Not Solve "Warning: You do not have write permission for Perl library directories." ]'
        S cpan ExtUtils::MakeMaker
        echo '[ Install ExtUtils::MakeMaker System-Wide, Check Updated Version, Must Be v7.04 Or Newer ]'
        S 'perl -MExtUtils::MakeMaker\ 999'

        echo '[ Check Perl Version To Determine Which Of The Following Sections To Choose ]'
        B perl -v

    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 21 ]; then
    echo '21. [[[ LINUX, INSTALL SINGLE-USER PERL LOCAL::LIB & CPANM ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD Use This Instead Of Perlbrew Or Perl From Source Or System Perl In Sections 22 & 23 & 24, Unless You Have No Choice ]'
        echo '[ This Option Will Contain All Perl Code In Your Home Directory Under The ~/perl5 Subdirectory ]'
        echo '[ This Option May  Not Work With Older Versions Of Debian GNU/Linux Which Include A Broken Perl v5.14, Use Perlbrew in Section 22 Instead ]'
        echo '[ This Option Will Not Work With Older Versions Of Perl Which Are Not At Least v5.10 Or Newer, Use Perlbrew in Section 22 Instead ]'
        echo '[ WARNING: Do NOT Mix With Perlbrew In Section 22! ]'
        echo '[ WARNING: Do NOT Mix With Perl From Source In Section 23! ]'
        echo '[ WARNING: Do NOT Mix With System Perl In Section 24! ]'
        C 'Please read the warnings above.  Seriously.'
        echo
        echo '[ Install local::lib & CPANM in ~/perl5 ]'
        B 'curl -L cpanmin.us | perl - -l $HOME/perl5 App::cpanminus local::lib'
        echo '[ Enable local::lib In .bashrc Run Commands Startup File ]'
        echo '[ NOTE: Do Not Run The Following Step If You Already Copied Your Own Pre-Existing LAMP University .bashrc File In Section 0 ]'
        # DEV NOTE: pre-munged command for comparison
#       if [ -d $HOME/perl5/lib/perl5 ]; then
#           eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

# START HERE: need add following 6 lines to munged echo statement below...
# START HERE: need add following 6 lines to munged echo statement below...
# START HERE: need add following   lines to munged echo statement below...

#           if ! [[ ":$PERL5LIB:" == *":$HOME/perl5/lib/perl5:"* ]]; then
#               export PERL5LIB=$HOME/perl5/lib/perl5:$PERL5LIB
#           fi
#           if ! [[ ":$PERL5LIB:" == *":$HOME/perl5/lib/perl5/x86_64-linux:"* ]]; then
#               export PERL5LIB=$HOME/perl5/lib/perl5/x86_64-linux:$PERL5LIB
#           fi


#       fi
        B echo -e '"# enable local::lib, do NOT mix with Perlbrew\nif [ -d"' '\$HOME/perl5/lib/perl5 ]\; then' '"\n  "' "'" eval '$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)' "'" '"\nfi\n"' '>> ~/.bashrc'
        SOURCE ~/.bashrc
        echo '[ Ensure The Following 4 Environmental Variables Now Include ~/perl5: PERL_MM_OPT, PERL_MB_OPT, PERL5LIB, PATH ]'
        echo '[ If Not, Please Log Out & Log Back In, Then Return To This Point & Check Again ]'
        B 'set | grep perl5'
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 22 ]; then
    echo '22. [[[ LINUX, INSTALL SINGLE-USER PERLBREW & CPANM ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD NOT Use This Instead Of local::lib In Section 21, Unless You Have No Choice ]'
        echo '[ This Option WILL Work With Older Versions Of Debian GNU/Linux Which Include A Broken Perl v5.14 ]'
        echo '[ This Option WILL Work With Older Versions Of Perl Which Are Not At Least v5.10 Or Newer ]'
        echo '[ WARNING: Do NOT Mix With local::lib In Section 21! ]'
        echo '[ WARNING: Do NOT Mix With Perl From Source In Section 23! ]'
        echo '[ WARNING: Do NOT Mix With System Perl In Section 24! ]'
        C 'Please read the warnings above.  Seriously.'

        echo '[ You Should Use Ubuntu Or CentOS Instead Of curl Below, Unless You Are Not In Ubuntu Or CentOS, Or You Have No Choice ]'
        echo '[ WARNING: Use Only ONE Of The Following Three Options, EITHER Ubuntu OR CentOS OR curl, But NOT More Than One! ]'
        C 'Please read the warning above.  Seriously.'

        if [[ "$OS_CHOICE" == "UBUNTU" ]]; then
            VERIFY_UBUNTU

            echo '[ UBUNTU ONLY: Install Perlbrew ]'
            S apt-get install perlbrew

            echo '[ UBUNTU ONLY: Check Install, Confirm No Errors ]'
            S apt-get -f install
        # OR
        elif [[ "$OS_CHOICE" == "CENTOS" ]]; then
            VERIFY_CENTOS
            echo '[ WARNING: Use Only ONE Of The Following Two CentOS Options, EITHER CPAN OR perlbrew_install.sh, But NOT More Than One! ]'
            C 'Please read the warning above.  Seriously.'

            echo '[ CENTOS & CPAN ONLY: Install Perl & CPAN ]'
            S yum install perl perl-core perl-CPAN perl-CPAN-Meta
            # DEV NOTE: create Perl lib dirs due to CentOS bug, dirs should already exist but do not, checked by CPAN::FirstTime::_can_write_to_libdirs()
            echo '[ CENTOS & CPAN ONLY: Ensure Perl Library Directories Exist ]'
            S "perl -e 'use Config; use File::Path qw(make_path); foreach my \$dir_key (qw(installprivlib installarchlib installsitelib installsitearch)) { if (not -e \$Config{\$dir_key}) { my \$success = make_path(\$Config{\$dir_key}); if (\$success) { print q{Created directory: }, \$Config{\$dir_key}, qq{\\n}; } else { print q{Error, could not create directory: }, \$Config{\$dir_key}, qq{\\n}, \$!, qq{\\n}; } } else { print q{Directory already exists: }, \$Config{\$dir_key}, qq{\\n}; } }'"
            echo '[ CENTOS & CPAN ONLY: Install CPANM ]'
            S cpan App::cpanminus
            echo '[ CENTOS & CPAN ONLY: Install Perlbrew ]'
            S cpanm install App::perlbrew

            # OR

            echo '[ CENTOS & perlbrew_install.sh ONLY: Install GCC Compiler & Other Requirements ]'
            S yum install gcc bzip2 patch 
            echo '[ CENTOS & perlbrew_install.sh ONLY: Download perlbrew_install.sh Script ]'
            B curl -L https://install.perlbrew.pl -o perlbrew_install.sh
            echo '[ CENTOS & perlbrew_install.sh ONLY: Run perlbrew_install.sh Script  ]'
            B chmod a+x ./perlbrew_install.sh && ./perlbrew_install.sh

            echo '[ CENTOS ONLY: Check Install, Confirm No Errors; WARNING! MAKE TAKE HOURS TO RUN! ]'
            S yum check
        fi

        # OR
        echo '[ CURL ONLY: Install Perlbrew; DO NOT USE IF apt-get OR yum WAS SUCCESSFUL! ]'
        S 'curl -L http://install.perlbrew.pl | bash'

        echo '[ Configure Perlbrew ]'
        B perlbrew init
        echo '[ In Texas, The Following Perlbrew Mirror Is Recommended: Arlington, TX #222 http://mirror.uta.edu/CPAN/ ]'
        B perlbrew mirror
        B 'echo "source ~/perl5/perlbrew/etc/bashrc" >> ~/.bashrc'
        SOURCE ~/.bashrc
        echo '[ Ensure The Following 3 Environmental Variables Now Include ~/perl5: PERLBREW_MANPATH, PERLBREW_PATH, PERLBREW_ROOT ]'
        B 'set | grep perl5'
        
        echo '[ Build Perlbrew Perl v5.24.0 ]'
        B perlbrew install perl-5.24.0
        echo '[ Temporaily Enable Perlbrew Perl v5.24.0 ]'
        B perlbrew use perl-5.24.0
        echo '[ Permanently Enable Perlbrew Perl v5.24.0 ]'
        B perlbrew switch perl-5.24.0
        echo '[ Install Perlbrew CPANM ]'
        B perlbrew install-cpanm

        echo '[ ExtUtils::MakeMaker v7.04 Or Newer Is Required By Inline::C, May Need To Re-Install In Single-User Mode ]'
        echo '[ Check Version Of ExtUtils::MakeMaker, Re-Install If Older Than v7.04 ]'
        B 'perl -MExtUtils::MakeMaker\ 999'
        echo '[ Re-Install ExtUtils::MakeMaker Via CPAN, Because Perlbrew Acts As System-Wide Perl In Single-User Mode ]'
        echo '[ NOTE: You MUST Have v7.04 Or Newer Installed System-Wide (And Also Single-User) For RPerl ]'
        B cpanm ExtUtils::MakeMaker
        echo '[ Re-Check Version Of ExtUtils::MakeMaker, Must Be v7.04 Or Newer ]'
        B 'perl -MExtUtils::MakeMaker\ 999'
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 23 ]; then
    echo '23. [[[ LINUX, INSTALL SYSTEM-WIDE PERL FROM SOURCE & CPANM ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD NOT Use This Instead Of local::lib In Section 21, Unless You Have No Choice ]'
        echo '[ WARNING: Do NOT Mix With local::lib In Section 21! ]'
        echo '[ WARNING: Do NOT Mix With Perlbrew In Section 22! ]'
        echo '[ WARNING: Do NOT Mix With System Perl In Section 24! ]'
        C 'Please read the warnings above.  Seriously.'
        echo '[ WARNING: Choose ONLY ONE Of The Following Two Methods: Manual Build, Or Tokuhirom Perl-Build ]'
        C 'Please read the warning above.  Seriously.'
        # NEED ANSWER: does this actually work?
        echo '[ MANUAL BUILD ONLY: Download Perl Source Code ]'
        B 'wget http://www.cpan.org/src/5.0/perl-5.24.0.tar.bz2; tar -xjvf perl-5.24.0.tar.bz2'
        echo '[ MANUAL BUILD ONLY: Build Perl Source Code ]'
        B 'cd perl-5.24.0; ./Configure -des; make; make test'
        echo '[ MANUAL BUILD ONLY: Install Perl Build ]'
        S 'cd perl-5.24.0; make install'
        # OR
        echo '[ TOKUHIROM PERL-BUILD ONLY: Download, Build, Install Perl ]'
        # NEED ANSWER: does this actually work?
        S 'curl https://raw.githubusercontent.com/tokuhirom/Perl-Build/master/perl-build | perl - 5.24.0 /usr/local/bin/perl-5.24.0/'
        echo '[ EITHER OPTION: Install cpanminus ]'
        S perl -MCPAN -e 'install App::cpanminus'
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 24 ]; then
    echo '24. [[[ LINUX, INSTALL SYSTEM-WIDE SYSTEM PERL & CPANM ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You SHOULD NOT Use This Instead Of local::lib In Section 21, Unless You Have No Choice ]'
        echo '[ This Option Will Install Both Perl & cpanminus System-Wide ]'
        echo '[ Also, All Future CPAN Distributions Will Install System-Wide In A Hard-To Control Manner ]'
        echo '[ WARNING: Do NOT Mix With local::lib In Section 21! ]'
        echo '[ WARNING: Do NOT Mix With Perlbrew In Section 22! ]'
        echo '[ WARNING: Do NOT Mix With Perl From Source In Section 23! ]'
        C 'Please read the warnings above.  Seriously.'

        if [[ "$OS_CHOICE" == "UBUNTU" ]]; then
            VERIFY_UBUNTU
            echo '[ UBUNTU ONLY: Install Perl & CPANM ]'
            S apt-get install perl cpanminus
            echo '[ UBUNTU ONLY: Check Install, Confirm No Errors ]'
            S apt-get -f install
        # OR
        elif [[ "$OS_CHOICE" == "CENTOS" ]]; then
            VERIFY_CENTOS 
            echo '[ CENTOS ONLY: Install Perl & CPANM Dependencies ]'
            S yum install perl-core perl-libs perl-devel perl-CPAN curl
            echo '[ CENTOS ONLY: Install CPANM System-Wide ]'
            S 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus'
            echo '[ CENTOS ONLY: Check Install, Confirm No Errors; WARNING! MAKE TAKE HOURS TO RUN! ]'
            S yum check
        fi

    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 25 ]; then
    echo '25. [[[ LINUX, INSTALL RPERL DEPENDENCIES ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ Overview Of RPerl Dependencies In This Section ]'
        echo '[ GCC: gcc & g++ Required For Compiling ]'
        echo '[ libc: libcrypt.(a|so) Required For Compiling ]'
        echo '[ libperl: libperl.(a|so) & perl.h etc, Required For Compiling ]'
        echo '[ openssl: err.h Required By RPerl Subdependency Net::SSLeay From IO::Socket::SSL ]'
        echo '[ zlib: zlib.h Required By SDL.pm, Which Is Required For Graphics ]'
        echo '[ GMP: GNU Multiple-Precision Arithmetic Library Required For Math ]'
        echo '[ GSL: GNU Scientific Library Required For Math ]'
        echo '[ Pluto polyCC: polycc Required For Parallel Compiling, Depends On texinfo flex bison ]'
        echo '[ AStyle: Artistic Style C++ Formatter, Required By RPerl Test Suite ]'
        echo '[ pkg-config: Compilation Library Detection Tool, Required By RPerl Support For MongoDB ]'
        echo '[ MongoDB Drivers: Both C & C++, Required By RPerl Support For MongoDB ]'
        echo

        # DEV NOTE: libperl packages in Ubuntu vs CentOS
        # Ubuntu, libperl-dev,  /usr/lib/x86_64-linux-gnu/libperl.so SYMLINK    /usr/lib/x86_64-linux-gnu/libperl.a REAL FILE
        # Ubuntu, libperl5.XX,  /usr/lib/x86_64-linux-gnu/libperl.so.5.XX.Y REAL FILE    /usr/lib/x86_64-linux-gnu/perl/5.26.0/CORE/perl.h  and other *.h *.so *.pm *.ph files
        # CentOS 7, perl-libs,  /usr/lib64/perl5/CORE/libperl.so
        # CentOS 7, perl-devel, /usr/lib64/perl5/CORE/perl.h     /usr/bin/h2xs  and other *.h files

        if [[ "$OS_CHOICE" == "UBUNTU" ]]; then
            VERIFY_UBUNTU
            echo '[ UBUNTU ONLY: Add Non-Base APT Repositories ]'
            S add-apt-repository \"deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse\"
            echo '[ UBUNTU ONLY: Update APT Repositories ]'
            S apt-get update
            echo '[ UBUNTU ONLY: Install RPerl Dependencies ]'
            S apt-get install g++ libc6-dev libperl-dev libssl-dev zlib1g-dev libgmp-dev libgsl0-dev texinfo flex bison astyle pkg-config

            echo "[ UBUNTU ONLY: Install RPerl Dependencies, MongoDB C & C++ Drivers; Must Use Latest libbson & libmongoc From Bionic v18.04 Repositories ]"
            echo "[ UBUNTU ONLY: Install RPerl Dependencies, MongoDB C & C++ Drivers; In Xenial v16.04, Temporarily Replace All Occurrences Of 'xenial' With 'bionic' (Same For Other Non-Bionic Releases), Skip If Already Using Bionic Or Newer ]"
            S $EDITOR /etc/apt/sources.list
            echo "[ UBUNTU ONLY: Install RPerl Dependencies, MongoDB C & C++ Drivers; Update To Bionic v18.04 Repositories, Skip If Already Using Bionic Or Newer ]"
            S apt-get update
            echo "[ UBUNTU ONLY: Install RPerl Dependencies, MongoDB C & C++ Drivers; Install libbson & libmongoc From Bionic v18.04 Repositories ]"
            S apt-get install libbson-1.0-0 libbson-dev libmongoc-1.0-0 libmongoc-dev
            echo "[ UBUNTU ONLY: Install RPerl Dependencies, MongoDB C & C++ Drivers; In Xenial v16.04, Replace All Occurrences Of 'bionic' With Original 'xenial' (Same For Other Non-Bionic Releases), Skip If Already Using Bionic Or Newer ]"
            S $EDITOR /etc/apt/sources.list
            echo "[ UBUNTU ONLY: Install RPerl Dependencies, MongoDB C & C++ Drivers; Update To Original Non-Bionic Repositories, Skip If Already Using Bionic Or Newer ]"
            S apt-get update

            echo '[ UBUNTU ONLY: Check Install, Confirm No Errors ]'
            S apt-get -f install
        # OR
        elif [[ "$OS_CHOICE" == "CENTOS" ]]; then
            VERIFY_CENTOS

            echo '[ CENTOS ONLY: Install RPerl Dependencies ]'
            S yum install gcc-c++ make glibc-devel perl-core perl-libs perl-devel openssl-devel zlib zlib-static zlib-devel gmp gmp-static gmp-devel gsl gsl-devel texinfo flex bison
            echo '[ CENTOS ONLY: Install RPerl Dependencies, GCC/G++ GDB Debugging Symbols ]'
#            S debuginfo-install cracklib-2.9.0-11.el7.x86_64 cyrus-sasl-lib-2.1.26-21.el7.x86_64 glibc-2.17-196.el7_4.2.x86_64 keyutils-libs-1.5.8-3.el7.x86_64 krb5-libs-1.15.1-8.el7.x86_64 libcom_err-1.42.9-10.el7.x86_64 libgcc-4.8.5-16.el7_4.2.x86_64 libselinux-2.5-11.el7.x86_64 libstdc++-4.8.5-16.el7_4.2.x86_64 nspr-4.13.1-1.0.el7_3.x86_64 nss-3.28.4-15.el7_4.x86_64 nss-softokn-freebl-3.28.3-8.el7_4.x86_64 nss-util-3.28.4-3.el7.x86_64 openldap-2.4.44-5.el7.x86_64 openssl-libs-1.0.2k-8.el7.x86_64 pcre-8.32-17.el7.x86_64 postgresql96-libs-9.6.8-1PGDG.rhel7.x86_64 zlib-1.2.7-17.el7.x86_64
            S debuginfo-install cracklib cyrus-sasl-lib glibc keyutils-libs krb5-libs libcom_err libgcc libselinux libstdc++ nspr nss nss-softokn-freebl nss-util openldap openssl-libs pcre postgresql96-libs zlib
            echo '[ CENTOS ONLY: Download & Install RPerl Dependency AStyle ]'
            B wget https://github.com/wbraswell/astyle-mirror/raw/master/backup/astyle-2.05.1-1.el7.centos.x86_64.rpm
            S rpm -v -i ./astyle-2.05.1-1.el7.centos.x86_64.rpm
            echo '[ CENTOS ONLY: Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, pkg-config ]'
            S yum install pkgconfig

            # OLD VERSIONS, DO NOT USE!  libbson v1.3.5-5.el7, mongo-c-driver-libs v1.3.6-1.el7, mongo-c-driver v1.3.6-1.el7
            # must have new versions for MongoDB C++ driver compatibility
            # "For mongocxx-3.2.x, libmongoc 1.8.2 or later is required."    https://mongodb.github.io/mongo-cxx-driver/mongocxx-v3/installation/
#            echo '[ CENTOS ONLY: Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, MongoDB C Driver ]'
#            S yum install pkgconfig mongo-c-driver

            echo '[ CENTOS ONLY: Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, libbson ]'

            # perl-interpreter is a dummy package for CentOS 7 compatibility with Fedora source packages libbson & mongo-c-driver
            S yum install rpm-build libtool cyrus-sasl-lib cyrus-sasl-devel snappy-devel perl-interpreter python-sphinx

#            # DEV NOTE: prefer pre-built RPMs below
##            B wget http://dl.fedoraproject.org/pub/fedora/linux/updates/27/SRPMS/Packages/l/libbson-1.9.3-1.fc27.src.rpm  # DEV NOTE: prefer GitHub mirror below
#            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.9.3-1.fc27.src.rpm  # DEV NOTE: prefer our own GitHub mirror for uniformity
#            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.9.3-1.el7.centos.src.rpm  # DEV NOTE: prefer our own re-built source RPMs for uniformity
#            S rpm -i -vv ./libbson-1.9.3-1.fc27.src.rpm
#            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson.spec
#            S mv ./libbson.spec /root/rpmbuild/SPECS/libbson.spec
#            S rpmbuild -ba /root/rpmbuild/SPECS/libbson.spec
#            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/libbson-1.9.3-1.el7.centos.x86_64.rpm
#            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/libbson-devel-1.9.3-1.el7.centos.x86_64.rpm  # provides pkgconfig(libbson-1.0) to satisfy mongodb-c-driver requirements
#            # OR
            # DEV NOTE: prefer our own pre-built RPMs from GitHub mirror, for speed & reliability & convenience
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.9.3-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-devel-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./libbson-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./libbson-devel-1.9.3-1.el7.centos.x86_64.rpm  # provides pkgconfig(libbson-1.0) to satisfy mongodb-c-driver requirements
            B rm ./libbson-1.9.3-1.el7.centos.x86_64.rpm
            B rm ./libbson-devel-1.9.3-1.el7.centos.x86_64.rpm  

            echo '[ CENTOS ONLY: Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, MongoDB C Driver ]'

#            # DEV NOTE: prefer pre-built RPMs below
##            B wget http://dl.fedoraproject.org/pub/fedora/linux/updates/27/SRPMS/Packages/m/mongo-c-driver-1.9.3-1.fc27.src.rpm  # DEV NOTE: prefer GitHub mirror below
##            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-1.9.3-1.fc27.src.rpm  # DEV NOTE: prefer our own GitHub mirror for uniformity
#            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-1.9.3-1.el7.centos.src.rpm  # DEV NOTE: prefer our own re-built source RPMs for uniformity
#            S rpm -i -vv mongo-c-driver-1.9.3-1.fc27.src.rpm
#            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver.spec
#            S mv ./mongo-c-driver.spec /root/rpmbuild/SPECS/mongo-c-driver.spec
#            S systemctl stop mongodb.service
#            S rpmbuild -ba /root/rpmbuild/SPECS/mongo-c-driver.spec
#            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-c-driver-libs-1.9.3-1.el7.centos.x86_64.rpm
#            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-c-driver-1.9.3-1.el7.centos.x86_64.rpm
#            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-c-driver-devel-1.9.3-1.el7.centos.x86_64.rpm
#            S systemctl start mongodb.service
#            # OR
            # DEV NOTE: prefer our own pre-built RPMs from GitHub mirror, for speed & reliability & convenience
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-libs-1.9.3-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-1.9.3-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-devel-1.9.3-1.el7.centos.x86_64.rpm
            S systemctl stop mongodb.service
            S rpm -i -vv ./mongo-c-driver-libs-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./mongo-c-driver-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./mongo-c-driver-devel-1.9.3-1.el7.centos.x86_64.rpm
            S systemctl start mongodb.service
            B rm ./mongo-c-driver-libs-1.9.3-1.el7.centos.x86_64.rpm
            B rm ./mongo-c-driver-1.9.3-1.el7.centos.x86_64.rpm
            B rm ./mongo-c-driver-devel-1.9.3-1.el7.centos.x86_64.rpm

#            # DEV NOTE: prefer pre-built RPMs below
#            echo '[ CENTOS ONLY: Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, Fix Broken CMake Files ]'
#            # NEED ANSWER: can we fix this CMake error permanently by including --enable-static in configure for both libbson & mongo-c-driver above???
#            # CMake Error at /lib64/cmake/libbson-1.0/libbson-1.0-config.cmake:28 (message): File or directory //include/libbson-1.0 referenced by variable BSON_INCLUDE_DIRS does not exist !
#            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.0-config.cmake
#            S mv ./libbson-1.0-config.cmake /lib64/cmake/libbson-1.0/libbson-1.0-config.cmake
#            # CMake Error at /lib64/cmake/libmongoc-1.0/libmongoc-1.0-config.cmake:30 (message): File or directory //include/libmongoc-1.0 referenced by variable MONGOC_INCLUDE_DIRS does not exist !
#            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/libmongoc-1.0-config.cmake
#            S mv ./libmongoc-1.0-config.cmake /lib64/cmake/libmongoc-1.0/libmongoc-1.0-config.cmake

            echo '[ CENTOS ONLY: Install RPerl Dependencies, MongoDB C++ Driver ]'

            S yum install cmake3

#            # DEV NOTE: prefer pre-built RPMs below
##            # DEV NOTE: prefer already-fixed tarball below
##            B wget https://github.com/mongodb/mongo-cxx-driver/archive/r3.2.0.tar.gz
##            S mv ./r3.2.0.tar.gz /root/rpmbuild/SOURCES/mongo-cxx-driver-3.2.0.tar.gz
##            CD /root/rpmbuild/SOURCES
##            S tar -xzvf mongo-cxx-driver-3.2.0.tar.gz
##            S mv mongo-cxx-driver-r3.2.0 mongo-cxx-driver-3.2.0
##            S rm mongo-cxx-driver-3.2.0.tar.gz
##            S tar -czvf mongo-cxx-driver-3.2.0.tar.gz ./mongo-cxx-driver-3.2.0
#            # DEV NOTE: prefer our own already-fixed tarball below, for convenience
#            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-3.2.0.tar.gz
#            S mv ./mongo-cxx-driver-3.2.0.tar.gz /root/rpmbuild/SOURCES/mongo-cxx-driver-3.2.0.tar.gz
#            CD /root/rpmbuild/SPECS
#            S wget https://raw.githubusercontent.com/wbraswell/mongo-cxx-driver-mirror/master/mongo-cxx-driver.spec
#            S rpmbuild -ba /root/rpmbuild/SPECS/mongo-cxx-driver.spec
#            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-cxx-driver-libs-3.2.0-1.el7.centos.x86_64.rpm
#            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-cxx-driver-3.2.0-1.el7.centos.x86_64.rpm
#            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-cxx-driver-devel-3.2.0-1.el7.centos.x86_64.rpm
#            # OR
            # DEV NOTE: prefer our own pre-built RPMs from GitHub mirror, for speed & reliability & convenience
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-libs-3.2.0-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-3.2.0-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-devel-3.2.0-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./mongo-cxx-driver-libs-3.2.0-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./mongo-cxx-driver-3.2.0-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./mongo-cxx-driver-devel-3.2.0-1.el7.centos.x86_64.rpm
            B rm ./mongo-cxx-driver-libs-3.2.0-1.el7.centos.x86_64.rpm
            B rm ./mongo-cxx-driver-3.2.0-1.el7.centos.x86_64.rpm
            B rm ./mongo-cxx-driver-devel-3.2.0-1.el7.centos.x86_64.rpm

            echo '[ CENTOS ONLY: Check Install, Confirm No Errors; WARNING! MAKE TAKE HOURS TO RUN! ]'
            S yum check
        fi

        echo '[ Check GCC Version, Must Be v4.7 Or Newer, Use Manual Build Option If Automatic Install Options Fail Or Are Too Old ]'
        B g++ --version

        echo '[ Check AStyle Version, Must Be v2.05.1 Or Newer, Use Manual Build Option If Automatic Install Options Fail Or Are Too Old ]'
        B astyle -V

        # OR
        echo '[ WARNING: Do NOT Use Manual Build Options Below, Unless You Are Not In Ubuntu Or CentOS, Or You Have No Choice! ]'
        C 'Please read the warnings above.  Seriously.'
        echo '[ MANUAL BUILD ONLY: Install RPerl Dependency GCC, Download ]'
        B 'wget http://www.netgull.com/gcc/releases/gcc-5.2.0/gcc-5.2.0.tar.bz2; tar -xjvf gcc-5.2.0.tar.bz2'
        echo '[ MANUAL BUILD ONLY: Install RPerl Dependency GCC, Build ]'
        B 'cd gcc-5.2.0; ./configure; make; make test'
        echo '[ MANUAL BUILD ONLY: Install RPerl Dependency GCC, Install ]'
        S 'cd gcc-5.2.0; make install'
        echo '[ MANUAL BUILD ONLY: Install RPerl Dependency GMP, Visit The Following URL For Installation Instructions ]'
        echo 'https://gmplib.org'
        echo
        echo '[ MANUAL BUILD ONLY: Install RPerl Dependency AStyle, Visit The Following URL For Installation Instructions ]'
        echo 'http://astyle.sourceforge.net'
        echo

        # BEGIN UBUNTU MANUAL BUILD, MONGOCXX C++ DRIVER

        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Download & Uncompress ]'
        B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-3.2.0.tar.gz
        B tar -xzvf mongo-cxx-driver-3.2.0.tar.gz && cd mongo-cxx-driver-3.2.0/build 

        # CMake Error at /usr/lib/x86_64-linux-gnu/cmake/libbson-1.0/libbson-1.0-config.cmake:28 (message): File or directory /usr/lib/include/libbson-1.0 referenced by variable BSON_INCLUDE_DIRS does not exist !
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Copy The Following Line ]'
        echo "set (PACKAGE_PREFIX_DIR /usr)  # WBRASWELL 20180615 2018.166: manually set PACKAGE_PREFIX_DIR due to CMake 'does not exist' failures"
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Paste The Now-Copied Line Immediately BEFORE The Following Line ]'
        echo "set_and_check (BSON_INCLUDE_DIRS \"${PACKAGE_PREFIX_DIR}/include/libbson-1.0\")"
        S $EDITOR /usr/lib/x86_64-linux-gnu/cmake/libbson-1.0/libbson-1.0-config.cmake
        # CMake Error at /usr/lib/x86_64-linux-gnu/cmake/libmongoc-1.0/libmongoc-1.0-config.cmake:31 (message): File or directory /usr/lib/include/libmongoc-1.0 referenced by variable MONGOC_INCLUDE_DIRS does not exist !
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Paste The Now-Copied Line AGAIN Immediately BEFORE The Following Line ]'
        echo "set_and_check (MONGOC_INCLUDE_DIRS \"${PACKAGE_PREFIX_DIR}/include/libmongoc-1.0\")"
        S $EDITOR /usr/lib/x86_64-linux-gnu/cmake/libmongoc-1.0/libmongoc-1.0-config.cmake

        # CMake Error: The following variables are used in this project, but they are set to NOTFOUND.  Please set them or make sure they are set and tested correctly in the CMake files: BSON_LIBRARY MONGOC_LIBRARY
#        B cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/lib ..
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Configure The C++ Build Process ]'
        B cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DMONGOC_LIBRARY=/usr/lib/x86_64-linux-gnu/libmongoc-1.0.so -DBSON_LIBRARY=/usr/lib/x86_64-linux-gnu/libbson-1.0.so ..
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Build & Install The Minimalistic Polyfill ]'
        S make EP_mnmlstc_core
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Build ]'
        B make
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Install ]'
        S make install
#        S ln -sf /usr/lib/pkgconfig/libmongocxx.pc /usr/share/pkgconfig/libmongocxx.pc  # NOT NECESSARY IN UBUNTU???
#        S ln -sf /usr/lib/pkgconfig/libbsoncxx.pc /usr/share/pkgconfig/libbsoncxx.pc    # NOT NECESSARY IN UBUNTU???
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Before Running Optional Test Program, Please Install MongoDB Server Via LAMP Installer SECTION 60 [[[ UBUNTU LINUX, INSTALL MONGODB ]]] ]'
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Save Test Program ]'
        B printf "#include <iostream>\n#include <bsoncxx/builder/stream/document.hpp>\n#include <bsoncxx/json.hpp>\n#include <mongocxx/client.hpp>\n#include <mongocxx/instance.hpp>\nint main(int, char**) {\n    mongocxx::instance inst{};\n    mongocxx::client conn{mongocxx::uri{}};\n    bsoncxx::builder::stream::document document{};\n    auto collection = conn[\"testdb\"][\"testcollection\"];\n    document << \"hello\" << \"world\";\n    collection.insert_one(document.view());\n    auto cursor = collection.find({});\n    for (auto&& doc : cursor) {\n        std::cout << bsoncxx::to_json(doc) << std::endl;\n    }\n}" > ./mongocxx_test.cpp
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Compile Test Program ]'
        B c++ --std=c++11 mongocxx_test.cpp -o mongocxx_test -I/usr/include/mongocxx/v_noabi -I/usr/include/bsoncxx/v_noabi/ -L/usr/lib -Wl,-rpath,/usr/lib -lmongocxx -lbsoncxx
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Run Test Program ]'
        B ./mongocxx_test
        echo '[ UBUNTU MANUAL BUILD ONLY: Install RPerl Dependency MongoDB C++ Driver; Delete Test Program ]'
        B rm -Rf ./mongocxx_test*

        # END UBUNTU MANUAL BUILD, MONGOCXX C++ DRIVER

        echo '[ Install RPerl Dependency Pluto PolyCC, Download ]'
        # B 'wget https://github.com/wbraswell/pluto-mirror/raw/master/backup/pluto-0.11.4.tar.gz; tar -xzvf pluto-0.11.4.tar.gz'  # prefer official repo below
        B 'wget https://github.com/bondhugula/pluto/files/737550/pluto-0.11.4.tar.gz; tar -xzvf pluto-0.11.4.tar.gz'
        echo '[ Install RPerl Dependency Pluto PolyCC, Build ]'
        B 'cd pluto-0.11.4; ./configure; make; make test'
        echo '[ Install RPerl Dependency Pluto PolyCC, Install ]'
        S 'cd pluto-0.11.4; make install'

    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $MENU_CHOICE -le 26 ]; then
    echo '26. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPAN ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
        echo '[ You Should Use This Instead Of Unstable Via GitHub In Section 27, Unless You Are An RPerl System Developer ]'
        echo '[ This Option Will Install The Latest Stable Public Release Of RPerl ]'
        echo '[ WARNING: Do NOT Mix With Unstable Via GitHub In Section 27! ]'
        C 'Please read the warning above.  Seriously.'
        echo
        echo '[ You Should Use Single-User Instead Of System-Wide Below, Unless local::lib Or Perlbrew Is Not Installed Or You Have No Choice ]'
        echo '[ WARNING: Use Only ONE Of The Following Two Options, EITHER Single-User OR System-Wide, But NOT Both! ]'
        C 'Please read the warning above.  Seriously.'
        echo '[ SINGLE-USER ONLY: Install Problematic RPerl Dependency IO::Socket::SSL, Skip Tests ]'
        B cpanm -v --notest IO::Socket::SSL
        echo '[ SINGLE-USER ONLY: Install RPerl ]'
        B cpanm -v RPerl
        # OR
        echo '[ SYSTEM-WIDE ONLY: Install Problematic RPerl Dependency IO::Socket::SSL, Skip Tests ]'
        S cpanm -v --notest IO::Socket::SSL
        echo '[ SYSTEM-WIDE ONLY: Install RPerl ]'
        S cpanm -v RPerl

        echo '[ EITHER OPTION: If cpanm Is Not Installed, Exit This Installer & Manually Try cpan Instead ]'
        echo '[ Copy The Command From The Following Line For Single-User Option ]'
        echo '$ cpan RPerl'
        echo
        echo '[ Copy The Command From The Following Line For System-Wide Option ]'
        echo '$ sudo cpan RPerl'
        echo
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
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
    if [ $MACHINE_CHOICE -eq 0 ]; then
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
            echo '[ SECURE GIT ONLY: Generate SSH Keys, Do Create Secure Key Passphrase When Prompted ]'
            echo '[ WARNING: Be Sure To Record Your Secure Key Passphrase & Store It In A Safe Place ]'
            C 'Please read the warning above.  Seriously.'
            B "ssh-keygen -t rsa -C '$GITHUB_EMAIL'; eval `ssh-agent -s` ssh-add ~/.ssh/id_rsa; ssh-agent -k"
        else
            echo '[ SECURE GIT ONLY: SSH Key File(s) Already Exist, Skipping Key Generation ]'
        fi

        if [[ "$OS_CHOICE" == "UBUNTU" ]]; then
            VERIFY_UBUNTU
            echo '[ SECURE GIT ON UBUNTU ONLY: Install Keychain Key Manager For OpenSSH ]'
            S apt-get install keychain
            echo '[ UBUNTU ONLY: Check Install, Confirm No Errors ]'
            S apt-get -f install
        # OR
        elif [[ "$OS_CHOICE" == "CENTOS" ]]; then
            VERIFY_CENTOS 
            C '[ SECURE GIT ON NON-CENTOS ONLY: Not Currently Supported ]'
#            echo '[ SECURE GIT ON CENTOS ONLY: Install Keychain Key Manager For OpenSSH ]'
#            S rpm --import http://mirror.ghettoforge.org/distributions/gf/RPM-GPG-KEY-gf.el7
#            S rpm -Uvh http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm 
#            S yum clean all
#            S yum install keychain
#            echo '[ CENTOS ONLY: Check Install, Confirm No Errors; WARNING! MAKE TAKE HOURS TO RUN! ]'
#            S yum check
        else
            C '[ SECURE GIT ON NON-UBUNTU AND NON-CENTOS ONLY: Please See Your Operating System Documentation To Install Keychain Key Manager For OpenSSH ]'
        fi

        echo '[ SECURE GIT ONLY: Enable Keychain ]'
        echo '[ NOTE: Do Not Run The Following Step If You Already Copied Your Own Pre-Existing LAMP University .bashrc File In Section 0 ]'
        B 'echo -e "\n# SSH Keys; for GitHub, etc.\nif [ -f /usr/bin/keychain ] && [ -f \$HOME/.ssh/id_rsa ]; then\n    /usr/bin/keychain \$HOME/.ssh/id_rsa\n    source \$HOME/.keychain/\$HOSTNAME-sh\nfi\n" >> ~/.bashrc;'
        SOURCE ~/.bashrc
        echo '[ SECURE GIT ONLY: How To Enable SSH Key On GitHub... ]'
        echo '[ SECURE GIT ONLY: Copy Data Produced By The Next Command ]'
        echo '[ SECURE GIT ONLY: Then Browse To https://github.com/settings/ssh ]'
        echo "[ SECURE GIT ONLY: Then Click 'Add SSH Key', Paste Copied Key Data, Title '$USERNAME@$HOSTNAME', Click 'Save' ]"
        echo
        B 'cat ~/.ssh/id_rsa.pub'
        echo
        C '[ SECURE GIT ONLY: Please Follow The Instructions Above ]'
        echo '[ SECURE GIT ONLY: Test SSH Key On GitHub, Enter Passphrase When Prompted, Confirm Automatic Reply Greeting From GitHub Server ]'
        B ssh -T git@github.com
        echo '[ SECURE GIT ONLY: Configure GitHub Account Setting On Local Machine ]'
        echo '[ NOTE: Do Not Repeat The 3 Following git config Steps If You Already Copied Your Own Pre-Existing .gitconfig File In Section 0 ]'
        B git config --global user.email "$GITHUB_EMAIL"
        B git config --global user.name "$GITHUB_FIRST_NAME $GITHUB_LAST_NAME"
        B git config --global core.editor "$EDITOR"
        echo '[ SECURE GIT ONLY: Clone (Download) RPerl Repository Onto New Machine ]'
        B git clone git@github.com:wbraswell/rperl.git $RPERL_REPO_DIRECTORY
        # OR
        echo '[ PUBLIC GIT ONLY: Clone (Download) RPerl Repository Onto New Machine ]'
        B git clone https://github.com/wbraswell/rperl.git $RPERL_REPO_DIRECTORY
        # OR
        echo '[ PUBLIC ZIP ONLY: Download RPerl Repository Onto New Machine ]'
        B "wget https://github.com/wbraswell/rperl/archive/master.zip; unzip master.zip; mv rperl-master $RPERL_REPO_DIRECTORY; rm master.zip"

        echo '[ ALL OPTIONS: Install Problematic RPerl Dependency IO::Socket::SSL, Skip Tests ]'
        B cpanm -v --notest IO::Socket::SSL
        echo '[ ALL OPTIONS: Install RPerl Dependencies Via CPAN ]'
        CD $RPERL_REPO_DIRECTORY
        B 'perl Makefile.PL; cpanm --installdeps .'
        echo '[ ALL OPTIONS: Build & Test RPerl ]'
        B 'make; make test'
        echo '[ ALL OPTIONS: Build & Test RPerl, Optional Verbose Output ]'
        B 'make; make test TEST_VERBOSE=1'
        echo '[ ALL OPTIONS: Install RPerl ]'
        B 'make install'
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
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
    if [ $MACHINE_CHOICE -eq 0 ]; then
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

        RPERL_CODE='use RPerl::Algorithm::Sort::Bubble; my $o = RPerl::Algorithm::Sort::Bubble->new(); $o->inherited_Bubble("logan"); $o->inherited_Sort("wolvie"); $o->inherited_Algorithm("claws");'

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
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 29 VARIABLES
PHYSICSPERL_ENABLE_GRAPHICS='__EMPTY__'
PHYSICSPERL_NBODY_STEPS='__EMPTY__'

if [ $MENU_CHOICE -le 29 ]; then
    echo '29. [[[ RPERL, INSTALL RPERL FAMILY & RUN DEMOS ]]]'
    echo
    if [ $MACHINE_CHOICE -eq 0 ]; then
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
    elif [ $MACHINE_CHOICE -eq 1 ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi
