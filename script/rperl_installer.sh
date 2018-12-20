#!/bin/bash
# Copyright © 2014, 2015, 2016, 2017, 2018, William N. Braswell, Jr.. All Rights Reserved. This work is Free \& Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.24.0.
# RPerl Installer Script (directly copied from LAMP Installer Script)
VERSION='0.430_000'

# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!
# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!
# IMPORTANT DEV NOTE: do not edit anything in this file without making the exact same changes to LAMP_installer.sh!!!

# PRE-PRE-INSTALL: install wget
# sudo apt-get install wget
# OR
# sudo yum install wget

# PRE-INSTALL: download the latest version of this file and make it executable
# rm ./rperl_installer.sh; wget https://raw.githubusercontent.com/wbraswell/rperl/master/script/rperl_installer.sh; chmod a+x ./rperl_installer.sh
# OR
# rm ./NEED_FILENAME; wget tinyurl.com/NEED_NEW_TINYURL; chmod a+x NEED_NEW_TINYURL

# enable extended pattern matching in case statements
shopt -s extglob


# global variables
USER_INPUT=''
CURRENT_SECTION=0

# command-line arguments
HELP_CHOICE="no"       # DEFAULT NO
DEVELOPER_CHOICE="no"  # DEFAULT NO
SECTION_CHOICE="__EMPTY__"
MACHINE_CHOICE="__EMPTY__"
OS_CHOICE="__EMPTY__"
PERL_INSTALL_CHOICE="__EMPTY__"
RPERL_INSTALL_CHOICE="__EMPTY__"

# block comment template
: <<'END_COMMENT'
    foo bar bat
END_COMMENT

# command-line arguments AKA options
for i in "$@"
do
case $i in
    -?|-h|--help)
    HELP_CHOICE="yes"
    shift
    ;;
    -d=*|--developer=*)
    DEVELOPER_CHOICE="${i#*=}"
    shift
    ;;
    -s=*|--section=*)
    SECTION_CHOICE="${i#*=}"
    shift
    ;;
    -m=*|--machine=*)
    MACHINE_CHOICE="${i#*=}"
    shift
    ;;
    -os=*|--operating-system=*)
    OS_CHOICE="${i#*=}"
    shift
    ;;
    -pi=*|--perl-install=*)
    PERL_INSTALL_CHOICE="${i#*=}"
    shift
    ;;
    -ri=*|--rperl-install=*)
    RPERL_INSTALL_CHOICE="${i#*=}"
    shift
    ;;
    *)
          # unknown argument, ignore
    ;;
esac
done

echo 'Received the following command-line arguments AKA options:'
echo "HELP_CHOICE               = ${HELP_CHOICE}"
echo "DEVELOPER_CHOICE          = ${DEVELOPER_CHOICE}"
echo "SECTION_CHOICE            = ${SECTION_CHOICE}"
echo "MACHINE_CHOICE            = ${MACHINE_CHOICE}"
echo "OS_CHOICE                 = ${OS_CHOICE}"
echo " PERL_INSTALL_CHOICE      = ${PERL_INSTALL_CHOICE}"
echo "RPERL_INSTALL_CHOICE      = ${RPERL_INSTALL_CHOICE}"
echo

if [ $HELP_CHOICE == 'yes' ]; then
    echo 'LAMP Installer Script'
    echo 'Usage:'
    echo '        LAMP_installer.sh [ARGUMENTS]'
    echo
    echo 'Arguments:'
    echo '    -? ...OR... -h ...OR... --help'
    echo '        Print this (relatively) brief help message for command-line usage.'
    echo
    echo '    -d=[yes|no] ...OR... --developer=[yes|no]'
    echo '        Execute commands for developer sections, or not.'
    echo
    echo '    -s=INTEGER ...OR... --section=INTEGER'
    echo '        Execute commands starting at specified section number.'
    echo
    echo '    -m=[new|existing] ...OR... --machine=[new|existing]'
    echo '        Execute commands for new or existing machine.'
    echo
    echo '    -os=[ubuntu|centos] ...OR... --operating-system=[ubuntu|centos]'
    echo '        Execute commands for specified operating system.'
    echo
    echo '    -pi=[locallib|perlbrew|source|system] ...OR... --perl-install=[locallib|perlbrew|source|system]'
    echo '        Execute commands for specified Perl installation option.'
    echo
    echo '    -ri=[packages|cpanm-single|cpanm-system|cpan-single|cpan-system|github-secure-git|github-public-git|github-public-zip] ...OR...'
    echo '    -rperl-install=[packages|cpanm-single|cpanm-system|cpan-single|cpan-system|github-secure-git|github-public-git|github-public-zip]'
    echo '        Execute commands for specified RPerl installation option.'
    echo
    exit
fi

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
# DEV NOTE: attempting to use S() as a shortcut to B() does not work, adds unnecessary logic to B() and incorrectly strips newline characters from commands
# B sudo $@  # WRONG

# DEV NOTE: using just plain $@ works for commands wrapped all in double-quotes such as redirected echo commands (presumably all stored as a single word in only ${01});
# but $@ does NOT work for normal multi-word commands (not just stored in ${01}), must use $COMMAND to handle both cases
    COMMAND=" ${01} ${02} ${03} ${04} ${05} ${06} ${07} ${08} ${09} ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} \
        ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} ${28} ${29} ${30} ${31} ${32} ${33} ${34} ${35} ${36} ${37} ${38} ${39} \
        ${40} ${41} ${42} ${43} ${44} ${45} ${46} ${47} ${48} ${49} ${50} ${51} ${52} ${53} ${54} ${55} ${56} ${57} ${58} ${59} \
        ${60} ${61} ${62} ${63} ${64} ${65} ${66} ${67} ${68} ${69} ${70} ${71} ${72} ${73} ${74} ${75} ${76} ${77} ${78} ${79} \
        ${80} ${81} ${82} ${83} ${84} ${85} ${86} ${87} ${88} ${89} ${90} ${91} ${92} ${93} ${94} ${95} ${96} ${97} ${98} ${99} "

#    echo '$' $@  # WRONG
    echo '$' $COMMAND

    while true; do
        read -p 'Run above command AS ROOT, yes or no?  [yes] ' -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; return;;
            y|Y ) echo; break;;
            '' ) break;;
            * ) echo;;
        esac
    done

#    sudo bash -c " $@ "  # WRONG
    sudo bash -c " $COMMAND "
    echo
}

B () {  # _B_ash command
    COMMAND=" ${01} ${02} ${03} ${04} ${05} ${06} ${07} ${08} ${09} ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} \
        ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} ${28} ${29} ${30} ${31} ${32} ${33} ${34} ${35} ${36} ${37} ${38} ${39} \
        ${40} ${41} ${42} ${43} ${44} ${45} ${46} ${47} ${48} ${49} ${50} ${51} ${52} ${53} ${54} ${55} ${56} ${57} ${58} ${59} \
        ${60} ${61} ${62} ${63} ${64} ${65} ${66} ${67} ${68} ${69} ${70} ${71} ${72} ${73} ${74} ${75} ${76} ${77} ${78} ${79} \
        ${80} ${81} ${82} ${83} ${84} ${85} ${86} ${87} ${88} ${89} ${90} ${91} ${92} ${93} ${94} ${95} ${96} ${97} ${98} ${99} "
    echo '$' $COMMAND

    while true; do
        read -p 'Run above command, yes or no?  [yes] ' -n 1 PROMPT_INPUT
        case $PROMPT_INPUT in
            n|N ) echo; echo; return;;
            y|Y ) echo; break;;
            '' ) break;;
            * ) echo;;
        esac
    done

    bash -c " $COMMAND "
    echo
}

VERIFY_OS_CHOICE() {
    local OS_REQ="$1"
    local CHOICE="$OS_CHOICE"

    local GUESS='UNKNOWN'
    if [[ -f "/etc/redhat-release" ]]; then
        GUESS='centos'
    elif [[ -f "/etc/debian_version" ]]; then
        GUESS='ubuntu'
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
    VERIFY_OS_CHOICE 'centos'
}

VERIFY_UBUNTU() {
    VERIFY_OS_CHOICE 'ubuntu'
}

# do not provide menu prompt if already provided as command-line argument
if [ $SECTION_CHOICE == '__EMPTY__' ]; then
    echo "[[[<<< LAMP Installer Script v$VERSION >>>]]]"
    echo
    echo '  [[[<<< Tested Using Fresh Installs >>>]]]'
    echo
    echo 'Xubuntu v14.04.2 (Trusty Tahr)'
    echo 'Xubuntu v16.04.4 (Xenial Xerus)'
    echo 'CentOS  v7.4-1708'
    echo
    echo  '          [[[<<< Main Menu >>>]]]'
    echo
    echo  '         <<< PERL & RPERL SECTIONS >>>'
    echo  '20. [[[        LINUX,   INSTALL  PERL DEPENDENCIES ]]]'
    echo  '21. [[[        LINUX,   INSTALL  PERL & CPANM ]]]'
    echo  '22. [[[        LINUX,   PACKAGE RPERL DEPENDENCIES, DEVELOPERS ONLY ]]]'
    echo  '23. [[[        LINUX,   INSTALL RPERL DEPENDENCIES ]]]'
    echo  '24. [[[  PERL,          INSTALL RPERL ]]]'
    echo  '25. [[[ RPERL,          RUN COMPILER TESTS ]]]'
    echo  '26. [[[ RPERL,          INSTALL RPERL APPS & RUN DEMOS ]]]'
    echo

    while true; do
        read -p 'Please type your chosen main menu section number, or press <ENTER> for 0... ' SECTION_CHOICE
        case $SECTION_CHOICE in
            [0123456789]|[1234][0123456789]|5[01]|60 ) echo; break;;
            '' ) echo; SECTION_CHOICE=0; break;;
            * ) echo 'Please choose a section number from the menu!'; echo;;
        esac
    done

fi
CURRENT_SECTION=$SECTION_CHOICE

# do not provide menu prompt if already provided as command-line argument
if [ $MACHINE_CHOICE == '__EMPTY__' ]; then
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
fi

# do not provide menu prompt if already provided as command-line argument
if [ $OS_CHOICE == '__EMPTY__' ]; then
    echo  '          [[[<<< OS Menu >>>]]]'
    echo
    echo \ '0. [[[           UBUNTU       ]]]'
    echo \ '1. [[[           CENTOS       ]]]'
    echo \ '9. [[[           OTHER        ]]]'
    echo

    while true; do
        read -p 'Please type your OS menu choice number, or press <ENTER> for 0... ' OS_CHOICE
        case $OS_CHOICE in
            0 ) echo; OS_CHOICE='ubuntu'; break;;
            1 ) echo; OS_CHOICE='centos'; break;;
            9 ) echo; OS_CHOICE='OTHER'; break;;
            '' ) echo; OS_CHOICE='ubuntu'; break;;
            * ) echo 'Please choose a number from the menu!'; echo;;
        esac
    done
fi


if [ $SECTION_CHOICE -le 20 ]; then
    echo '20. [[[ LINUX, INSTALL PERL DEPENDENCIES ]]]'
    echo
    if [ $MACHINE_CHOICE == '0' ] || [ $MACHINE_CHOICE == 'new' ]; then
        echo '[ Overview Of Perl Dependencies In This Section ]'
        echo '[ CPAN: The Comprehensive Perl Archive Network, Required For Installing Perl Software ]'
        echo '[ Perl Debug: Symbols For The Perl Interpreter, Optional For Perl Core & XS & RPerl Debugging ]'
        echo '[ Git: Source Code Version Control, Required To Install Latest Development & Unstable Software ]'
        echo '[ Make: Program Builder, Required To Build ExtUtils::MakeMaker ]'
        echo '[ cURL: Downloader, Required To Install cpanminus & Perlbrew & Perl-Build ]'
        echo '[ ExtUtils::MakeMaker: Source Code Builder, Required To Build Many Perl Software Suites ]'
        echo

        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            VERIFY_UBUNTU
            echo '[ Install Perl Debugging Symbols System-Wide ]'
            S apt-get install perl-debug
            echo '[ Install git ]'
            S apt-get install git
            echo '[ Install make ]'
            S apt-get install make
            echo '[ Install cURL ]'
            S apt-get install curl
            echo '[ Check Install, Confirm No Errors ]'
            S apt-get -f install
        # OR
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            VERIFY_CENTOS
            echo '[ Install CPAN ]'
            S yum install perl-core perl-CPAN
            echo '[ Install Perl Debugging Symbols System-Wide ]'
            echo '[ NOT CURRENTLY AVAILABLE FOR CENTOS ]'
            echo '[ Install git ]'
            S yum install git
            echo '[ Install make ]'
            S yum install make
            echo '[ Install cURL ]'
            S yum install curl
            if [ $DEVELOPER_CHOICE == 'yes' ]; then
                echo '[ Check Install, Confirm No Errors; WARNING! MAY TAKE HOURS TO RUN! ]'
                S yum check
            fi
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

    elif [ $MACHINE_CHOICE == '1' ] || [ $MACHINE_CHOICE == 'existing' ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 21 VARIABLES
#PERL_INSTALL_CHOICE='__EMPTY__'  # this is now a global variable for command-line args, see top of file

if [ $SECTION_CHOICE -le 21 ]; then
    echo '21. [[[ LINUX, INSTALL PERL & CPANM ]]]'

    if [ $MACHINE_CHOICE == '0' ] || [ $MACHINE_CHOICE == 'new' ]; then
        if [ $PERL_INSTALL_CHOICE == '__EMPTY__' ]; then
            echo 'Please carefully read the following instructions, in order to choose a Perl installation option...'
            echo
            echo '21a. [[[ LINUX, INSTALL SINGLE-USER PERL LOCAL::LIB & CPANM ]]]'
            echo '    [ You SHOULD Use This Instead Of Perlbrew Or Perl From Source Or System Perl In Sections 21b & 21c & 21d, Unless You Have No Choice ]'
            echo '    [ This Option Will Contain All Perl Code In Your Home Directory Under The ~/perl5 Subdirectory ]'
            echo '    [ This Option May  Not Work With Older Versions Of Debian GNU/Linux Which Include A Broken Perl v5.14, Use Perlbrew in Section 21b Instead ]'
            echo '    [ This Option Will Not Work With Older Versions Of Perl Which Are Not At Least v5.10 Or Newer, Use Perlbrew in Section 21b Instead ]'
            echo
            echo '__OR__ '
            echo
            echo '21b. [[[ LINUX, INSTALL SINGLE-USER PERLBREW & CPANM ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of local::lib In Section 21a, Unless You Have No Choice ]'
            echo '    [ This Option WILL Work With Older Versions Of Debian GNU/Linux Which Include A Broken Perl v5.14 ]'
            echo '    [ This Option WILL Work With Older Versions Of Perl Which Are Not At Least v5.10 Or Newer ]'
            echo
            echo '__OR__ '
            echo
            echo '21c. [[[ LINUX, INSTALL SYSTEM-WIDE PERL FROM SOURCE & CPANM ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of local::lib In Section 21a, Unless You Have No Choice ]'
            echo
            echo '__OR__ '
            echo
            echo '21d. [[[ LINUX, INSTALL SYSTEM-WIDE SYSTEM PERL & CPANM ]]]'
            echo '[ You SHOULD NOT Use This Instead Of local::lib In Section 21a, Unless You Have No Choice ]'
            echo '[ This Option Will Install Both Perl & cpanminus System-Wide ]'
            echo '[ Also, All Future CPAN Distributions Will Install System-Wide In A Hard-To Control Manner ]'
            echo
            C 'Please read the warnings above.  Seriously.'
            echo

            P $PERL_INSTALL_CHOICE $'letter or word for a Perl installation option:\n[a] locallib\n[b] perlbrew\n[c] source\n[d] system\n'
            PERL_INSTALL_CHOICE=$USER_INPUT
        fi

        if [ $PERL_INSTALL_CHOICE == 'a' ] || [ $PERL_INSTALL_CHOICE == 'locallib' ]; then

            echo '21a. [[[ LINUX, INSTALL SINGLE-USER PERL LOCAL::LIB & CPANM ]]]'
            echo '[ Install local::lib & CPANM in ~/perl5 ]'
            B 'curl -L cpanmin.us | perl - -l $HOME/perl5 App::cpanminus local::lib'
            echo '[ Enable local::lib In .bashrc Run Commands Startup File ]'
            echo '[ NOTE: Do Not Run The Following Step If You Already Copied Your Own Pre-Existing LAMP University .bashrc File In Section 0 ]'
        # DEV NOTE: pre-munged command for comparison
#       if [ -d $HOME/perl5/lib/perl5 ]; then
#           eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
#       fi

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

        elif [ $PERL_INSTALL_CHOICE == 'b' ] || [ $PERL_INSTALL_CHOICE == 'perlbrew' ]; then

            echo '21b. [[[ LINUX, INSTALL SINGLE-USER PERLBREW & CPANM ]]]'
            echo '[ You Should Use Ubuntu Or CentOS Instead Of curl Below, Unless You Are Not In Ubuntu Or CentOS, Or You Have No Choice ]'
            echo '[ WARNING: Use Only ONE Of The Following Three Options, EITHER Ubuntu OR CentOS OR curl, But NOT More Than One! ]'
            C 'Please read the warning above.  Seriously.'

            if [[ "$OS_CHOICE" == "ubuntu" ]]; then
                VERIFY_UBUNTU

                echo '[ Install Perlbrew ]'
                S apt-get install perlbrew

                echo '[ Check Install, Confirm No Errors ]'
                S apt-get -f install
            # OR
            elif [[ "$OS_CHOICE" == "centos" ]]; then
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
                S cpanm -v --notest App::perlbrew

                # OR

                echo '[ CENTOS & perlbrew_install.sh ONLY: Install GCC Compiler & Other Requirements ]'
                S yum install gcc bzip2 patch 
                echo '[ CENTOS & perlbrew_install.sh ONLY: Download perlbrew_install.sh Script ]'
                B curl -L https://install.perlbrew.pl -o perlbrew_install.sh
                echo '[ CENTOS & perlbrew_install.sh ONLY: Run perlbrew_install.sh Script  ]'
                B chmod a+x ./perlbrew_install.sh && ./perlbrew_install.sh
    
                if [ $DEVELOPER_CHOICE == 'yes' ]; then
                    echo '[ Check Install, Confirm No Errors; WARNING! MAY TAKE HOURS TO RUN! ]'
                    S yum check
                fi
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
            B cpanm -v --notest ExtUtils::MakeMaker
            echo '[ Re-Check Version Of ExtUtils::MakeMaker, Must Be v7.04 Or Newer ]'
            B 'perl -MExtUtils::MakeMaker\ 999'

        elif [ $PERL_INSTALL_CHOICE == 'c' ] || [ $PERL_INSTALL_CHOICE == 'source' ]; then

            echo '21c. [[[ LINUX, INSTALL SYSTEM-WIDE PERL FROM SOURCE & CPANM ]]]'
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

        elif [ $PERL_INSTALL_CHOICE == 'd' ] || [ $PERL_INSTALL_CHOICE == 'system' ]; then

            echo '21d. [[[ LINUX, INSTALL SYSTEM-WIDE SYSTEM PERL & CPANM ]]]'
            if [[ "$OS_CHOICE" == "ubuntu" ]]; then
                VERIFY_UBUNTU
                echo '[ Install Perl & CPANM ]'
                S apt-get install perl cpanminus
                echo '[ Check Install, Confirm No Errors ]'
                S apt-get -f install
            # OR
            elif [[ "$OS_CHOICE" == "centos" ]]; then
                VERIFY_CENTOS 
                echo '[ Install Perl & CPANM Dependencies ]'
                S yum install perl-core perl-libs perl-devel perl-CPAN curl
                echo '[ Install CPANM System-Wide ]'
                S 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus'
                if [ $DEVELOPER_CHOICE == 'yes' ]; then
                    echo '[ Check Install, Confirm No Errors; WARNING! MAY TAKE HOURS TO RUN! ]'
                    S yum check
                fi
            fi
        else
            echo "ERROR: Unrecognized value for PERL_INSTALL_CHOICE, '${PERL_INSTALL_CHOICE}', please see '--help' option for valid values"
        fi
    elif [ $MACHINE_CHOICE == '1' ] || [ $MACHINE_CHOICE == 'existing' ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 22 VARIABLES
# overwrites previous settings, makes it easier to copy-and-paste from LAMP_installer.sh to rperl_installer.sh
EDITOR='__EMPTY__'
USERNAME='__EMPTY__'

if [ $SECTION_CHOICE -le 22 ] && [ $DEVELOPER_CHOICE != 'yes' ]; then
    echo  '22. [[[ LINUX, PACKAGE RPERL DEPENDENCIES ]]]'
    echo
    echo 'SKIPPING!  Developer Sections Disabled'
    echo
    CURRENT_SECTION_COMPLETE
elif [ $SECTION_CHOICE -le 22 ]; then
    echo  '22. [[[ LINUX, PACKAGE RPERL DEPENDENCIES ]]]'
    echo
    if [ $MACHINE_CHOICE == '0' ] || [ $MACHINE_CHOICE == 'new' ]; then

        # [[[ FPM ]]]
        # [[[ FPM ]]]
        # [[[ FPM ]]]
        # fpm, install deps
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            VERIFY_UBUNTU
            S apt-get install ruby ruby-dev rubygems build-essential
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            VERIFY_CENTOS
            S yum install ruby-devel gcc make rpm-build rubygems perl-generators
        fi

        S gem update --system  # must have RubyGems >= v2.7.5 to avoid "Errno::EPERM: Operation not permitted @ chown_internal" on `bundle install` for fpm dev version
        S cpan App::cpanminus

        # fpm, install release version
        S gem install --no-ri --no-rdoc fpm
        B which fpm
        B fpm --version
        B fpm --verbose -s cpan -t rpm ExtUtils::MakeMaker

# SRPM START HERE: to build source packages, figure out which parts to insert into spec file via --edit, BuildRequires & Obsoletes %build & %install & %check   https://src.fedoraproject.org/cgit/rpms/perl-IO-Compress.git/tree/perl-IO-Compress.spec
# SRPM START HERE: to build source packages, figure out which parts to insert into spec file via --edit, BuildRequires & Obsoletes %build & %install & %check   https://src.fedoraproject.org/cgit/rpms/perl-IO-Compress.git/tree/perl-IO-Compress.spec
# SRPM START HERE: to build source packages, figure out which parts to insert into spec file via --edit, BuildRequires & Obsoletes %build & %install & %check   https://src.fedoraproject.org/cgit/rpms/perl-IO-Compress.git/tree/perl-IO-Compress.spec

        B fpm --verbose --debug-workspace --edit --no-cpan-test -s cpan -t rpm IO::Compress::Gzip
        B rpm -qp --whatprovides ./perl-IO-Compress-2.081-1.noarch.rpm  # package not installed
        B rpm -q --whatprovides  perl-IO-Compress  # package installed
        B repoquery --provides perl-IO-Compress  # package installed or not

        # fpm, install dev version
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            S apt-get install bsdtar
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            S yum install bsdtar
        elif [[ "$OS_CHOICE" == "macosx" ]]; then
            VERIFY_MACOSX
            S xcode-select --install  # Mac OS 10.9 (Mavericks)
        fi

        S gem install bundler
        B mkdir -p ~/repos_github
#        B git clone git@github.com:jordansissel/fpm.git ~/repos_github/fpm-latest
        B git clone https://github.com/wbraswell/fpm.git ~/repos_github/fpm-fork-latest
        CD ~/repos_github/fpm-fork-latest
        S bundle install
            # OUTPUT: ... Using FOO (X.Y.Z)    Using fpm (X.Y.Z) from source at `.`    Using BAR (X.Y.Z) ...
        B make
        # ERRORS MAY OCCUR, it should work anyway
        B export PATH=~/repos_github/fpm-fork-latest/bin:$PATH
        B which fpm
        B fpm --version

        # fpm, build RPerl package w/out deps
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            B reset; rm -Rf ~/cpantofpm_tmp/* ~/cpantofpm_packages/*; cd ~/cpantofpm_packages/; time fpm --no-cpan-test --cpan-verbose --verbose --debug-workspace --maintainer 'William N. Braswell, Jr. <william.braswell@NOSPAM.autoparallel.com>' --workdir ~/cpantofpm_tmp/ -s cpan -t deb --deb-?? RPerl
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            B reset; rm -Rf ~/cpantofpm_tmp/* ~/cpantofpm_packages/*; cd ~/cpantofpm_packages/; time fpm --no-cpan-test --cpan-verbose --verbose --debug-workspace --maintainer 'William N. Braswell, Jr. <william.braswell@NOSPAM.autoparallel.com>' --workdir ~/cpantofpm_tmp/ -s cpan -t rpm --rpm-ba RPerl
        fi

        # [[[ FPM-Cookery ]]]
        # [[[ FPM-Cookery ]]]
        # [[[ FPM-Cookery ]]]
        S gem install bundler
        B mkdir -p ~/repos_github
        B git clone https://github.com/bernd/fpm-cookery.git ~/repos_github/fpm-cookery-latest
        CD ~/repos_github/fpm-cookery-latest
        S bundle install  # ignore warning about not running as root, must run as root for `sudo fpm-cook install-deps` to find facter.rb & other fpm-cookery runtime deps
        B rake spec --trace  # run tests, may seem frozen for 5 - 10 minutes
        B export PATH=~/repos_github/fpm-cookery-latest/bin:$PATH
        B which fpm-cook
        B fpm-cook --version

        B mkdir -p ~/fpm_cookery_tmp
        CD ~/fpm_cookery_tmp
        B vi recipe.rb
            #class Tmux < FPM::Cookery::Recipe
            #  description 'terminal multiplexer'
            #  name     'tmux'
            #  version  '1.9a'
            #  homepage 'http://tmux.github.io'
            #  source   'https://github.com/tmux/tmux/releases/download/1.9a/tmux-1.9a.tar.gz'
            #  build_depends 'libevent-devel', 'ncurses-devel'
            #  depends       'libevent-2.0*'
            #  def build
            #    configure :prefix => prefix
            #    make
            #  end
            #  def install
            #    make :install, 'DESTDIR' => destdir
            #  end
            #end
        S ~/repos_github/fpm-cookery-latest/bin/fpm-cook install-deps
        B fpm-cook

        # [[[ CPANtoFPM ]]]
        # [[[ CPANtoFPM ]]]
        # [[[ CPANtoFPM ]]]
        # cpantofpm, install deps
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            S apt-get install expect  # for unbuffer
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            S yum install expect  # for unbuffer
        fi

        S cpan Module::CoreList
        S cpan Alien::Build
        B cpanm -v --notest MetaCPAN::Client



# FPM THEN START HERE: FPM CPAN pull request pacman test failures; DEB support; RPM mock support
# FPM THEN START HERE: FPM CPAN pull request pacman test failures; DEB support; RPM mock support
# FPM THEN START HERE: FPM CPAN pull request pacman test failures; DEB support; RPM mock support

# FPM THEN START HERE: merge FPM & FPM-Cookery to enable SPEC/SRPM output;; __OR__;; get fpm to accept SPEC file as input; rebuild libbson & mongo-c-driver & mongo-cxx-driver using SPEC files & fpm; manually build SPEC files for PCRE2 & JPCRE2 & PLUTO 
# FPM THEN START HERE: merge FPM & FPM-Cookery to enable SPEC/SRPM output;; __OR__;; get fpm to accept SPEC file as input; rebuild libbson & mongo-c-driver & mongo-cxx-driver using SPEC files & fpm; manually build SPEC files for PCRE2 & JPCRE2 & PLUTO 
# FPM THEN START HERE: merge FPM & FPM-Cookery to enable SPEC/SRPM output;; __OR__;; get fpm to accept SPEC file as input; rebuild libbson & mongo-c-driver & mongo-cxx-driver using SPEC files & fpm; manually build SPEC files for PCRE2 & JPCRE2 & PLUTO 

# FPM THEN START HERE: remove comments in lib/fpm/package/cpan.rb; save all deps files in correct DEPS folder;  skip processing if rpm/srpm/spec/dep files already present, else run fpm w/ force option to overwrite existing file(s); save file names in $distributions_processed & use to make tarball
# FPM THEN START HERE: remove comments in lib/fpm/package/cpan.rb; save all deps files in correct DEPS folder;  skip processing if rpm/srpm/spec/dep files already present, else run fpm w/ force option to overwrite existing file(s); save file names in $distributions_processed & use to make tarball
# FPM THEN START HERE: remove comments in lib/fpm/package/cpan.rb; save all deps files in correct DEPS folder;  skip processing if rpm/srpm/spec/dep files already present, else run fpm w/ force option to overwrite existing file(s); save file names in $distributions_processed & use to make tarball

        # cpantofpm, set hostname to be embedded in packages
        S vi /etc/hostname && hostname -F /etc/hostname && hostname  # packages.rperl.org

        # cpantofpm, set path to executable
        B export PATH=~/repos_gitlab/app-cpantofpm-latest/bin/:$PATH  # NEED FIX, HARD-CODED SHORTCUTS TO ~/cpantofpm BELOW
            # __OR__
        B cd; rm ./cpantofpm ; vi ./cpantofpm ; chmod a+x ./cpantofpm

        # cpantofpm, build RPerl package w/ deps
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            B reset; rm -Rf ~/cpantofpm_tmp/* ~/cpantofpm_packages/*; cd ~/cpantofpm_packages/; time ~/cpantofpm -t deb RPerl
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            B reset; rm -Rf ~/cpantofpm_tmp/* ~/cpantofpm_packages/*; cd ~/cpantofpm_packages/; time ~/cpantofpm -t rpm RPerl
        fi

        # [[[ AStyle ]]]
        # [[[ AStyle ]]]
        # [[[ AStyle ]]]
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            echo 'NEED DEB COMMANDS HERE'
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            CD ~/cpantofpm_packages/x86_64/
            B wget https://github.com/wbraswell/astyle-mirror/raw/master/backup/astyle-2.05.1-1.el7.centos.x86_64.rpm
            CD ~/cpantofpm_packages/SRPMS/
            B wget https://github.com/wbraswell/astyle-mirror/raw/master/backup/astyle-2.05.1-1.el7.centos.src.rpm
            # NEED UPGRADE: copy spec file out of srpm into SPECS/ directory
        fi

        # [[[ PCRE2 ]]]
        # [[[ PCRE2 ]]]
        # [[[ PCRE2 ]]]
        CD ~/
        B wget https://ftp.pcre.org/pub/pcre/pcre2-10.31.tar.gz
        B tar -xzvf pcre2-10.31.tar.gz
        CD pcre2-10.31
        B ./configure --enable-pcre2-16 --enable-pcre2-32 --disable-shared --enable-jit
        B make
        B make check
        B mkdir -p ~/fpm_tmp_install && rm -Rf ~/fpm_tmp_install/*
        B make install DESTDIR=~/fpm_tmp_install
        CD ~/
        B mkdir -p ~/fpm_tmp_work && rm -Rf ~/fpm_tmp_work/*

        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            echo 'NEED DEB COMMANDS HERE'
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            B reset; time fpm --verbose --debug-workspace --maintainer 'William N. Braswell, Jr. <william.braswell@NOSPAM.autoparallel.com>' --workdir ~/fpm_tmp_work/ -s dir -t rpm --rpm-ba -p libpcre2-VERSION_ARCH.rpm     -n libpcre2     -v 10.31 -C ~/fpm_tmp_install usr/local/lib usr/local/bin usr/local/share
            B rm libpcre2-10.31_x86_64.rpm  # prefer file naming uniformity with '-1' in all file names
            B cp ~/fpm_tmp_work/package-rpm-build-*/RPMS/x86_64/libpcre2-10.31-1.x86_64.rpm ~/cpantofpm_packages/x86_64/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SRPMS/libpcre2-10.31-1.src.rpm ~/cpantofpm_packages/SRPMS/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SPECS/libpcre2.spec ~/cpantofpm_packages/SPECS/
            B mkdir -p ~/fpm_tmp_work && rm -Rf ~/fpm_tmp_work/*
            B reset; time fpm --verbose --debug-workspace --maintainer 'William N. Braswell, Jr. <william.braswell@NOSPAM.autoparallel.com>' --workdir ~/fpm_tmp_work/ -s dir -t rpm --rpm-ba -p libpcre2-dev_VERSION_ARCH.rpm -n libpcre2-dev -v 10.31 -C ~/fpm_tmp_install usr/local/include
            B rm libpcre2-dev_10.31_x86_64.rpm  # prefer file naming uniformity with '-1' in all file names
            B cp ~/fpm_tmp_work/package-rpm-build-*/RPMS/x86_64/libpcre2-dev-10.31-1.x86_64.rpm ~/cpantofpm_packages/x86_64/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SRPMS/libpcre2-dev-10.31-1.src.rpm ~/cpantofpm_packages/SRPMS/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SPECS/libpcre2-dev.spec ~/cpantofpm_packages/SPECS/
        fi

        B rm -Rf pcre2-10.31.tar.gz pcre2-10.31 ~/fpm_tmp_work ~/fpm_tmp_install

        # [[[ JPCRE2 ]]]
        # [[[ JPCRE2 ]]]
        # [[[ JPCRE2 ]]]
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            echo 'NEED DEB COMMANDS HERE'
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            S rpm -i ~/cpantofpm_packages/x86_64/libpcre2-10.31-1.x86_64.rpm
            S rpm -i ~/cpantofpm_packages/x86_64/libpcre2-dev-10.31-1.x86_64.rpm
        fi

        CD ~/
        B wget https://github.com/jpcre2/jpcre2/archive/10.31.02-2.tar.gz -O jpcre2-10.31.02-2.tar.gz
        B tar -xzvf jpcre2-10.31.02-2.tar.gz
        CD jpcre2-10.31.02-2
        B ./configure --disable-cpp11 --enable-test
        B make
        B make check
        B mkdir -p ~/fpm_tmp_install && rm -Rf ~/fpm_tmp_install/*
        B make install DESTDIR=~/fpm_tmp_install
        CD ~/
        B mkdir -p ~/fpm_tmp_work && rm -Rf ~/fpm_tmp_work/*

        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            echo 'NEED DEB COMMANDS HERE'
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            B reset; time fpm --verbose --debug-workspace --maintainer 'William N. Braswell, Jr. <william.braswell@NOSPAM.autoparallel.com>' --workdir ~/fpm_tmp_work/ -s dir -t rpm --rpm-ba -p libjpcre2-dev_VERSION_ARCH.rpm -n libjpcre2-dev -v 10.31.02-2 -d "libpcre2 >= 10.31" -d "libpcre2-dev >= 10.31" -C ~/fpm_tmp_install usr/local/include usr/local/share/doc
            B rm libjpcre2-dev_10.31.02_2_x86_64.rpm  # prefer file naming uniformity with '-1' in all file names
            B cp ~/fpm_tmp_work/package-rpm-build-*/RPMS/x86_64/libjpcre2-dev-10.31.02_2-1.x86_64.rpm ~/cpantofpm_packages/x86_64/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SRPMS/libjpcre2-dev-10.31.02_2-1.src.rpm ~/cpantofpm_packages/SRPMS/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SPECS/libjpcre2-dev.spec ~/cpantofpm_packages/SPECS/
            S rpm -e libpcre2 libpcre2-dev
        fi
 
        B rm -Rf jpcre2-10.31.02-2.tar.gz jpcre2-10.31.02-2 ~/fpm_tmp_work/ ~/fpm_tmp_install/

        # [[[ Pluto ]]]
        # [[[ Pluto ]]]
        # [[[ Pluto ]]]
        CD ~/
        B wget https://github.com/bondhugula/pluto/files/737550/pluto-0.11.4.tar.gz
        B tar -xzvf pluto-0.11.4.tar.gz
        CD pluto-0.11.4
        B ./configure
        B make
        B make test
        B mkdir -p ~/fpm_tmp_install && rm -Rf ~/fpm_tmp_install/*
        B make install DESTDIR=~/fpm_tmp_install
        CD ~/
        B mkdir -p ~/fpm_tmp_work && rm -Rf ~/fpm_tmp_work/*

        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            echo 'NEED DEB COMMANDS HERE'
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            B reset; time fpm --verbose --debug-workspace --maintainer 'William N. Braswell, Jr. <william.braswell@NOSPAM.autoparallel.com>' --workdir ~/fpm_tmp_work/ -s dir -t rpm --rpm-ba -p pluto-polycc-VERSION_ARCH.rpm     -n pluto-polycc     -v 0.11.4 -C ~/fpm_tmp_install usr/local/lib usr/local/bin usr/local/share
            B rm pluto-polycc-0.11.4_x86_64.rpm  # prefer file naming uniformity with '-1' in all file names
            B cp ~/fpm_tmp_work/package-rpm-build-*/RPMS/x86_64/pluto-polycc-0.11.4-1.x86_64.rpm ~/cpantofpm_packages/x86_64/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SRPMS/pluto-polycc-0.11.4-1.src.rpm ~/cpantofpm_packages/SRPMS/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SPECS/pluto-polycc.spec ~/cpantofpm_packages/SPECS/
            B mkdir -p ~/fpm_tmp_work && rm -Rf ~/fpm_tmp_work/*
            B reset; time fpm --verbose --debug-workspace --maintainer 'William N. Braswell, Jr. <william.braswell@NOSPAM.autoparallel.com>' --workdir ~/fpm_tmp_work/ -s dir -t rpm --rpm-ba -p pluto-polycc-dev-VERSION_ARCH.rpm -n pluto-polycc-dev -v 0.11.4 -C ~/fpm_tmp_install usr/local/include
            B rm pluto-polycc-dev-0.11.4_x86_64.rpm  # prefer file naming uniformity with '-1' in all file names
            B cp ~/fpm_tmp_work/package-rpm-build-*/RPMS/x86_64/pluto-polycc-dev-0.11.4-1.x86_64.rpm ~/cpantofpm_packages/x86_64/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SRPMS/pluto-polycc-dev-0.11.4-1.src.rpm ~/cpantofpm_packages/SRPMS/
            B cp ~/fpm_tmp_work/package-rpm-build-*/SPECS/pluto-polycc-dev.spec ~/cpantofpm_packages/SPECS/
        fi

        B rm -Rf pluto-0.11.4.tar.gz pluto-0.11.4 ~/fpm_tmp_work/ ~/fpm_tmp_install/

        # [[[ BSON ]]]
        # [[[ BSON ]]]
        # [[[ BSON ]]]

        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            echo 'NEED DEB COMMANDS HERE'
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            echo '[ Build RPerl Dependencies, MongoDB C++ Driver Prerequisites, BSON libbson ]'
            # perl-interpreter is a dummy package for CentOS 7 compatibility with Fedora source packages libbson & mongo-c-driver
            S yum install rpm-build libtool cyrus-sasl-lib cyrus-sasl-devel snappy-devel perl-interpreter python-sphinx

#            B wget http://dl.fedoraproject.org/pub/fedora/linux/updates/27/SRPMS/Packages/l/libbson-1.9.3-1.fc27.src.rpm  # DEV NOTE: prefer GitHub mirror below
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.9.3-1.fc27.src.rpm  # DEV NOTE: prefer our own GitHub mirror for uniformity
            S rpm -i -vv ./libbson-1.9.3-1.fc27.src.rpm
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson.spec
            S mv ./libbson.spec /root/rpmbuild/SPECS/libbson.spec
            S rpmbuild -ba /root/rpmbuild/SPECS/libbson.spec
            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/libbson-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/libbson-devel-1.9.3-1.el7.centos.x86_64.rpm  # provides pkgconfig(libbson-1.0) to satisfy mongodb-c-driver requirements
            
            # DEV NOTE: check if SRPM can be rebuilt
#            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.9.3-1.el7.centos.src.rpm
#            B rpm -ivh ./libbson-1.9.3-1.el7.centos.src.rpm
#            S yum-builddep libbson
#            B rpmbuild -v -ba ~/rpmbuild/SPECS/libbson.spec

            # DEV NOTE: copy our own pre-built packages into CPANtoFPM directory structure
            CD ~/cpantofpm_packages/SPECS/
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson.spec 
            CD ~/cpantofpm_packages/SRPMS/
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.9.3-1.el7.centos.src.rpm 
            CD ~/cpantofpm_packages/x86_64/
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.9.3-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-devel-1.9.3-1.el7.centos.x86_64.rpm
        fi

        # [[[ MongoDB C Driver ]]]
        # [[[ MongoDB C Driver ]]]
        # [[[ MongoDB C Driver ]]]
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            echo 'NEED DEB COMMANDS HERE'
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            echo '[ Build RPerl Dependencies, MongoDB C++ Driver Prerequisites, MongoDB C Driver ]'
#            B wget http://dl.fedoraproject.org/pub/fedora/linux/updates/27/SRPMS/Packages/m/mongo-c-driver-1.9.3-1.fc27.src.rpm  # DEV NOTE: prefer GitHub mirror below
#            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-1.9.3-1.fc27.src.rpm  # DEV NOTE: prefer our own GitHub mirror for uniformity
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-1.9.3-1.el7.centos.src.rpm  # DEV NOTE: prefer our own re-built source RPMs for uniformity
            S rpm -i -vv mongo-c-driver-1.9.3-1.fc27.src.rpm
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver.spec
            S mv ./mongo-c-driver.spec /root/rpmbuild/SPECS/mongo-c-driver.spec
            S systemctl stop mongodb.service
            S rpmbuild -ba /root/rpmbuild/SPECS/mongo-c-driver.spec
            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-c-driver-libs-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-c-driver-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-c-driver-devel-1.9.3-1.el7.centos.x86_64.rpm
            S systemctl start mongodb.service

            # DEV NOTE: copy our own pre-built packages into CPANtoFPM directory structure
            CD ~/cpantofpm_packages/SPECS/
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver.spec
            CD ~/cpantofpm_packages/SRPMS/
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-1.9.3-1.el7.centos.src.rpm
            CD ~/cpantofpm_packages/x86_64/
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-libs-1.9.3-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-1.9.3-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/mongo-c-driver-devel-1.9.3-1.el7.centos.x86_64.rpm
        fi

        # [[[ MongoDB C++ Driver ]]]
        # [[[ MongoDB C++ Driver ]]]
        # [[[ MongoDB C++ Driver ]]]
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            # DEB START HERE: create packages
            # DEB START HERE: create packages
            # DEB START HERE: create packages

            # BEGIN UBUNTU MANUAL BUILD, MONGOCXX C++ DRIVER

            D $EDITOR 'preferred text editor' 'vi'
            EDITOR=$USER_INPUT
            D $USERNAME "new machine's username" `whoami`
            USERNAME=$USER_INPUT

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

        elif [[ "$OS_CHOICE" == "centos" ]]; then
#            # DEV NOTE: prefer pre-built RPMs below
#            echo '[ Build RPerl Dependencies, MongoDB C++ Driver Prerequisites, Fix Broken CMake Files ]'
#            # NEED ANSWER: can we fix this CMake error permanently by including --enable-static in configure for both libbson & mongo-c-driver above???
#            # CMake Error at /lib64/cmake/libbson-1.0/libbson-1.0-config.cmake:28 (message): File or directory //include/libbson-1.0 referenced by variable BSON_INCLUDE_DIRS does not exist !
#            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.0-config.cmake
#            S mv ./libbson-1.0-config.cmake /lib64/cmake/libbson-1.0/libbson-1.0-config.cmake
#            # CMake Error at /lib64/cmake/libmongoc-1.0/libmongoc-1.0-config.cmake:30 (message): File or directory //include/libmongoc-1.0 referenced by variable MONGOC_INCLUDE_DIRS does not exist !
#            B wget https://github.com/wbraswell/mongo-c-driver-mirror/raw/master/libmongoc-1.0-config.cmake
#            S mv ./libmongoc-1.0-config.cmake /lib64/cmake/libmongoc-1.0/libmongoc-1.0-config.cmake

            echo '[ Build RPerl Dependencies, MongoDB C++ Driver ]'
            S yum install cmake3

#            # DEV NOTE: prefer already-fixed tarball below
#            B wget https://github.com/mongodb/mongo-cxx-driver/archive/r3.2.0.tar.gz
#            S mv ./r3.2.0.tar.gz /root/rpmbuild/SOURCES/mongo-cxx-driver-3.2.0.tar.gz
#            CD /root/rpmbuild/SOURCES
#            S tar -xzvf mongo-cxx-driver-3.2.0.tar.gz
#            S mv mongo-cxx-driver-r3.2.0 mongo-cxx-driver-3.2.0
#            S rm mongo-cxx-driver-3.2.0.tar.gz
#            S tar -czvf mongo-cxx-driver-3.2.0.tar.gz ./mongo-cxx-driver-3.2.0
            # DEV NOTE: prefer our own already-fixed tarball below, for convenience
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-3.2.0.tar.gz
            S mv ./mongo-cxx-driver-3.2.0.tar.gz /root/rpmbuild/SOURCES/mongo-cxx-driver-3.2.0.tar.gz
            CD /root/rpmbuild/SPECS
            S wget https://raw.githubusercontent.com/wbraswell/mongo-cxx-driver-mirror/master/mongo-cxx-driver.spec
            S rpmbuild -ba /root/rpmbuild/SPECS/mongo-cxx-driver.spec
            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-cxx-driver-libs-3.2.0-1.el7.centos.x86_64.rpm
            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-cxx-driver-3.2.0-1.el7.centos.x86_64.rpm
            S rpm -i -vv /root/rpmbuild/RPMS/x86_64/mongo-cxx-driver-devel-3.2.0-1.el7.centos.x86_64.rpm

            # DEV NOTE: copy our own pre-built packages into CPANtoFPM directory structure
            CD ~/cpantofpm_packages/SPECS/
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver.spec    
            CD ~/cpantofpm_packages/SRPMS/
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-3.2.0-1.el7.centos.src.rpm
            CD ~/cpantofpm_packages/x86_64/
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-libs-3.2.0-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-3.2.0-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/mongo-cxx-driver-mirror/raw/master/mongo-cxx-driver-devel-3.2.0-1.el7.centos.x86_64.rpm
        fi

        # [[[ RPM, YUM REPOSITORY ]]]
        # [[[ RPM, YUM REPOSITORY ]]]
        # [[[ RPM, YUM REPOSITORY ]]]

        # server, install deps, RUN ONCE ONLY
        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            S apt-get install createrepo yum-utils gnupg2 gnupg-agent rng-tools
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            S yum install createrepo yum-utils gnupg2 rng-tools
        fi

        # server, prepare to receive RPMs tarball
        S mkdir -p /srv/www/packages.rperl.org/public_html/centos/7/rperl
        CD /srv/www/packages.rperl.org/public_html/centos/7/rperl
        S rm -Rf DEPS SPECS SRPMS x86_64 *.tar.gz
        
        # packager machine, create & transfer RPMs tarball
        B ~/manual_packages_copy.sh
        CD ~/cpantofpm_packages
        B tar -czvf ./perl-RPerl-VERSION-1-RPM_ALL_DEPS.tar.gz ./*
        B scp ./perl-RPerl-VERSION-1-RPM_ALL_DEPS.tar.gz packages.rperl.org:/srv/www/packages.rperl.org/public_html/centos/7/rperl/

        # server, unpack RPMs tarball & set initial permissions
        CD /srv/www/packages.rperl.org/public_html/centos/7/rperl
        B tar -xzvf perl-RPerl-VERSION-1-RPM_ALL_DEPS.tar.gz
        S chown -R www-data.www-data /srv/www/packages.rperl.org/
        S chmod -R g+rwX,o-w /srv/www/packages.rperl.org/

        # server, generate & export & import GPG keys, RUN ONCE ONLY
        S rngd -r /dev/urandom
        B gpg2 --full-gen-key
            # William N. Braswell, Jr. (packages.rperl.org) <william.braswell@autoparallel.com>
        B gpg2 --list-keys
        B gpg2 --export --armor "William N. Braswell, Jr. (packages.rperl.org) <william.braswell@autoparallel.com>" > /srv/www/packages.rperl.org/public_html/centos/RPM-GPG-KEY-RPerl-7
        B less /srv/www/packages.rperl.org/public_html/centos/RPM-GPG-KEY-RPerl-7  # confirm key has been exported
        B rpmkeys --import /srv/www/packages.rperl.org/public_html/centos/RPM-GPG-KEY-RPerl-7
        B rpm -q gpg-pubkey --qf '%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n'  # confirm key has been imported

        # server, prepare to sign RPMs, RUN ONCE ONLY
        B vi ~/.rpmmacros
            # %_signature gpg
            # %_gpg_name William N. Braswell, Jr. (packages.rperl.org) <william.braswell@autoparallel.com>
            # %_gpg_bin /usr/bin
            # %__gpg /usr/bin/gpg2

        # server, sign RPMs & confirm signed
        CD /srv/www/packages.rperl.org/public_html/centos/7/rperl
        B export GPG_TTY=$(tty)
        B rpmsign --addsign SRPMS/*.rpm x86_64/*.rpm
        B rpm -qpi SRPMS/*.rpm x86_64/*.rpm | grep Signature

        # server, create repo & sign repo metadata & confirm signed
        CD /srv/www/packages.rperl.org/public_html/centos/7/rperl/x86_64
        B rm -Rf ./repodata/
        B createrepo --verbose .
        B gpg2 --detach-sign --armor repodata/repomd.xml
        B less repodata/repomd.xml.asc

        # server, generate repo file, RUN ONCE ONLY
        B vi /srv/www/packages.rperl.org/public_html/centos7-perl-cpan.repo
            [centos7-perl-cpan]
            name=CentOS 7 Perl CPAN Repository
            baseurl=https://packages.rperl.org/centos/7/rperl/x86_64/
            enabled=1
            gpgcheck=1
            repo_gpgcheck=1
            gpgkey=https://packages.rperl.org/centos/RPM-GPG-KEY-RPerl-7

        # server, set final permissions
        S chown -R www-data.www-data /srv/www/packages.rperl.org/
        S chmod -R g+rwX,o-w /srv/www/packages.rperl.org/

        # [[[ DEB, APT REPOSITORY ]]]
        # [[[ DEB, APT REPOSITORY ]]]
        # [[[ DEB, APT REPOSITORY ]]]

# DEB START HERE: set up server, set up client, install
# DEB START HERE: set up server, set up client, install
# DEB START HERE: set up server, set up client, install

    elif [ $MACHINE_CHOICE == '1' ] || [ $MACHINE_CHOICE == 'existing' ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

if [ $SECTION_CHOICE -le 23 ]; then
    echo '23. [[[ LINUX, INSTALL RPERL DEPENDENCIES ]]]'
    echo
    if [ $MACHINE_CHOICE == '0' ] || [ $MACHINE_CHOICE == 'new' ]; then
        echo '[ Overview Of RPerl Dependencies In This Section ]'
        echo '[ GCC: gcc & g++ Required For Compiling ]'
        echo '[ libc: libcrypt.(a|so) Required For Compiling ]'
        echo '[ libperl: libperl.(a|so) & perl.h etc, Required For Compiling ]'
        echo '[ openssl: err.h Required By RPerl Subdependency Net::SSLeay From IO::Socket::SSL From ... From Alien::* ]'
        echo '[ zlib: zlib.h Required By SDL.pm, Itself Required For Graphics In RPerl Applications ]'
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

        if [[ "$OS_CHOICE" == "ubuntu" ]]; then
            VERIFY_UBUNTU
            echo '[ Add Non-Base APT Repositories ]'
            S add-apt-repository \"deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse\"
            echo '[ Update APT Repositories ]'
            S apt-get update
            echo '[ Install RPerl Dependencies ]'
            S apt-get install g++ make libc6-dev perl libperl-dev libssl-dev zlib1g zlib1g-dev libgmp10 libgmpxx4ldbl libgmp-dev libgsl0-dev texinfo flex bison astyle

            echo '[ Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, pkg-config ]'
            S apt-get install pkg-config

# DEB START HERE: build & use our own libbson & libmongoc & libmongocxx packages, remove use of Bionic repo below
# DEB START HERE: build & use our own libbson & libmongoc & libmongocxx packages, remove use of Bionic repo below
# DEB START HERE: build & use our own libbson & libmongoc & libmongocxx packages, remove use of Bionic repo below

            echo "[ Install RPerl Dependencies, MongoDB C & C++ Drivers; Must Use Latest libbson & libmongoc From Bionic v18.04 Repositories ]"
            echo "[ Install RPerl Dependencies, MongoDB C & C++ Drivers; In Xenial v16.04, Temporarily Replace All Occurrences Of 'xenial' With 'bionic' (Same For Other Non-Bionic Releases), Skip If Already Using Bionic Or Newer ]"
            S $EDITOR /etc/apt/sources.list
            echo "[ Install RPerl Dependencies, MongoDB C & C++ Drivers; Update To Bionic v18.04 Repositories, Skip If Already Using Bionic Or Newer ]"
            S apt-get update
            echo "[ Install RPerl Dependencies, MongoDB C & C++ Drivers; Install libbson & libmongoc From Bionic v18.04 Repositories ]"
            S apt-get install libbson-1.0-0 libbson-dev libmongoc-1.0-0 libmongoc-dev
            echo "[ Install RPerl Dependencies, MongoDB C & C++ Drivers; In Xenial v16.04, Replace All Occurrences Of 'bionic' With Original 'xenial' (Same For Other Non-Bionic Releases), Skip If Already Using Bionic Or Newer ]"
            S $EDITOR /etc/apt/sources.list
            echo "[ Install RPerl Dependencies, MongoDB C & C++ Drivers; Update To Original Non-Bionic Repositories, Skip If Already Using Bionic Or Newer ]"
            S apt-get update

            echo '[ Check Install, Confirm No Errors ]'
            S apt-get -f install
        # OR
        elif [[ "$OS_CHOICE" == "centos" ]]; then
            VERIFY_CENTOS


# RPM START HERE: remove wget & rpm below w/ yum via packages.rperl.org, astyle & libbson & libmongoc & libmongocxx & pluto
# RPM START HERE: remove wget & rpm below w/ yum via packages.rperl.org
# RPM START HERE: remove wget & rpm below w/ yum via packages.rperl.org


            echo '[ Install RPerl Dependencies ]'
            S yum install gcc-c++ make glibc-devel perl-core perl-libs perl-devel openssl-devel zlib zlib-static zlib-devel gmp gmp-static gmp-devel gsl gsl-devel texinfo flex bison
            echo '[ Install RPerl Dependencies, GCC/G++ GDB Debugging Symbols ]'
#            S debuginfo-install cracklib-2.9.0-11.el7.x86_64 cyrus-sasl-lib-2.1.26-21.el7.x86_64 glibc-2.17-196.el7_4.2.x86_64 keyutils-libs-1.5.8-3.el7.x86_64 krb5-libs-1.15.1-8.el7.x86_64 libcom_err-1.42.9-10.el7.x86_64 libgcc-4.8.5-16.el7_4.2.x86_64 libselinux-2.5-11.el7.x86_64 libstdc++-4.8.5-16.el7_4.2.x86_64 nspr-4.13.1-1.0.el7_3.x86_64 nss-3.28.4-15.el7_4.x86_64 nss-softokn-freebl-3.28.3-8.el7_4.x86_64 nss-util-3.28.4-3.el7.x86_64 openldap-2.4.44-5.el7.x86_64 openssl-libs-1.0.2k-8.el7.x86_64 pcre-8.32-17.el7.x86_64 postgresql96-libs-9.6.8-1PGDG.rhel7.x86_64 zlib-1.2.7-17.el7.x86_64
            S debuginfo-install cracklib cyrus-sasl-lib glibc keyutils-libs krb5-libs libcom_err libgcc libselinux libstdc++ nspr nss nss-softokn-freebl nss-util openldap openssl-libs pcre postgresql96-libs zlib

            echo '[ Download & Install RPerl Dependency AStyle ]'
            B wget https://github.com/wbraswell/astyle-mirror/raw/master/backup/astyle-2.05.1-1.el7.centos.x86_64.rpm
            S rpm -v -i ./astyle-2.05.1-1.el7.centos.x86_64.rpm
            echo '[ Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, pkg-config ]'
            S yum install pkgconfig

            # OLD VERSIONS, DO NOT USE!  libbson v1.3.5-5.el7, mongo-c-driver-libs v1.3.6-1.el7, mongo-c-driver v1.3.6-1.el7
            # must have new versions for MongoDB C++ driver compatibility
            # "For mongocxx-3.2.x, libmongoc 1.8.2 or later is required."    https://mongodb.github.io/mongo-cxx-driver/mongocxx-v3/installation/
#            echo '[ Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, MongoDB C Driver ]'
#            S yum install pkgconfig mongo-c-driver

            echo '[ Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, BSON libbson ]'

            # DEV NOTE: use our own pre-built RPMs from GitHub mirror, for speed & reliability & convenience
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-1.9.3-1.el7.centos.x86_64.rpm
            B wget https://github.com/wbraswell/libbson-mirror/raw/master/libbson-devel-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./libbson-1.9.3-1.el7.centos.x86_64.rpm
            S rpm -i -vv ./libbson-devel-1.9.3-1.el7.centos.x86_64.rpm  # provides pkgconfig(libbson-1.0) to satisfy mongodb-c-driver requirements
            B rm ./libbson-1.9.3-1.el7.centos.x86_64.rpm
            B rm ./libbson-devel-1.9.3-1.el7.centos.x86_64.rpm

            echo '[ Install RPerl Dependencies, MongoDB C++ Driver Prerequisites, MongoDB C Driver ]'

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

            echo '[ Install RPerl Dependencies, MongoDB C++ Driver ]'

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

            if [ $DEVELOPER_CHOICE == 'yes' ]; then
                echo '[ Check Install, Confirm No Errors; WARNING! MAY TAKE HOURS TO RUN! ]'
                S yum check
            fi
        # OR
        elif [[ "$OS_CHOICE" == "OTHER" ]]; then
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

            echo '[ MANUAL BUILD ONLY: Install RPerl Dependency Pluto PolyCC, Download ]'
            # B 'wget https://github.com/wbraswell/pluto-mirror/raw/master/backup/pluto-0.11.4.tar.gz; tar -xzvf pluto-0.11.4.tar.gz'  # prefer official repo below
            B 'wget https://github.com/bondhugula/pluto/files/737550/pluto-0.11.4.tar.gz; tar -xzvf pluto-0.11.4.tar.gz'
            echo '[ MANUAL BUILD ONLY: Install RPerl Dependency Pluto PolyCC, Build ]'
            B 'cd pluto-0.11.4; ./configure; make; make test'
            echo '[ Install RPerl Dependency Pluto PolyCC, Install ]'
            S 'cd pluto-0.11.4; make install'
        fi

        echo '[ Check GCC Version, Must Be v4.7 Or Newer; If Automatic Install Options Fail Or Are Too Old, Then Restart Installer & Select OTHER Operating System For Manual Build Option ]'
        B g++ --version

        echo '[ Check AStyle Version, Must Be v2.05.1 Or Newer; If Automatic Install Options Fail Or Are Too Old, Then Restart Installer & Select OTHER Operating System For Manual Build Option ]'
        B astyle -V

    elif [ $MACHINE_CHOICE == '1' ] || [ $MACHINE_CHOICE == 'existing' ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 24 VARIABLES
#RPERL_INSTALL_CHOICE='__EMPTY__'  # this is now a global variable for command-line args, see top of file

# SECTION 24b VARIABLES
GITHUB_EMAIL='__EMPTY__'
GITHUB_FIRST_NAME='__EMPTY__'
GITHUB_LAST_NAME='__EMPTY__'
RPERL_REPO_DIRECTORY='__EMPTY__'

if [ $SECTION_CHOICE -le 24 ]; then
    echo '24. [[[ PERL, INSTALL RPERL ]]]'
    echo
    if [ $MACHINE_CHOICE == '0' ] || [ $MACHINE_CHOICE == 'new' ]; then
        if [ $RPERL_INSTALL_CHOICE == '__EMPTY__' ]; then
            echo 'Please carefully read the following instructions, in order to choose an RPerl installation option...'
            echo
            echo '24a. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA PACKAGES.RPERL.ORG ]]]'
            echo '    [ You Should Use This Instead Of Stable Via CPAN Or Unstable Via GitHub In The Following Sub-Sections, Unless You Are An RPerl System Developer ]'
            echo '    [ This Option Will Install The Latest Stable Public Release Of RPerl, Pre-Built & Pre-Compiled ]'
            echo
            echo '__OR__ '
            echo
            echo '24b. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPANM, SINGLE-USER ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of Stable Via Packages In Section 24a, Unless You Are An RPerl System Developer ]'
            echo '    [ This Option Will Install The Latest Stable Public Release Of RPerl, Built & Compiled On Your System, Using `cpanm` For Your Single User Only ]'
            echo
            echo '__OR__ '
            echo
            echo '24c. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPANM, SYSTEM-WIDE ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of Stable Via Packages In Section 24a, Unless You Are An RPerl System Developer ]'
            echo '    [ This Option Will Install The Latest Stable Public Release Of RPerl, Built & Compiled On Your System, Using `cpanm` For The Entire System ]'
            echo
            echo '__OR__ '
            echo
            echo '24d. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPAN, SINGLE-USER ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of Stable Via Packages In Section 24a, Unless You Are An RPerl System Developer ]'
            echo '    [ This Option Will Install The Latest Stable Public Release Of RPerl, Built & Compiled On Your System, Using `cpan` For Your Single User Only ]'
            echo
            echo '__OR__ '
            echo
            echo '24e. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPAN, SYSTEM-WIDE ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of Stable Via Packages In Section 24a, Unless You Are An RPerl System Developer ]'
            echo '    [ This Option Will Install The Latest Stable Public Release Of RPerl, Built & Compiled On Your System, Using `cpan` For The Entire System ]'
            echo
            echo '__OR__ '
            echo
            echo '24f. [[[ PERL, INSTALL RPERL, LATEST UNSTABLE VIA GITHUB, SINGLE-USER, SECURE GIT ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of Stable Via Packages In Section 24a, Unless You Are An RPerl System Developer ]'
            echo '    [ This Option Will Install The Latest Unstable Development Release Of RPerl, Built & Compiled On Your System, Using Secure Github For Your Single User Only ]'
            echo
            echo '__OR__ '
            echo
            echo '24g. [[[ PERL, INSTALL RPERL, LATEST UNSTABLE VIA GITHUB, SINGLE-USER, PUBLIC GIT ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of Stable Via Packages In Section 24a, Unless You Are An RPerl System Developer ]'
            echo '    [ This Option Will Install The Latest Unstable Development Release Of RPerl, Built & Compiled On Your System, Using Public Github For Your Single User Only ]'
            echo
            echo '__OR__ '
            echo
            echo '24h. [[[ PERL, INSTALL RPERL, LATEST UNSTABLE VIA GITHUB, SINGLE-USER, PUBLIC ZIP ]]]'
            echo '    [ You SHOULD NOT Use This Instead Of Stable Via Packages In Section 24a, Unless You Are An RPerl System Developer ]'
            echo '    [ This Option Will Install The Latest Unstable Development Release Of RPerl, Built & Compiled On Your System, Using Public Github For Your Single User Only ]'

            C 'Please read the warnings above.  Seriously.'
            echo

            P $RPERL_INSTALL_CHOICE $'letter or word for an RPerl installation option:\n[a] packages\n[b] cpanm-single\n[c] cpanm-system\n[d] cpan-single\n[e] cpan-system\n[f] github-secure-git\n[g] github-public-git\n[h] github-public-zip\n'
            RPERL_INSTALL_CHOICE=$USER_INPUT
        fi

        if [ $RPERL_INSTALL_CHOICE == 'a' ] || [ $RPERL_INSTALL_CHOICE == 'packages' ]; then

            echo '24a. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA PACKAGES.RPERL.ORG ]]]'
            echo

            if [[ "$OS_CHOICE" == "ubuntu" ]]; then
                # DEB START HERE: create packages
                # DEB START HERE: create packages
                # DEB START HERE: create packages
                echo 'NEED DEB COMMANDS HERE'
            elif [[ "$OS_CHOICE" == "centos" ]]; then
                S yum install pygpgme  # check GPG signatures of repo metadata & packages
                S yum-config-manager --add-repo https://packages.rperl.org/centos7-perl-cpan.repo
                S yum-config-manager --enable centos7-perl-cpan
                S yum repolist all    # confirm repo is in list
                S yum clean metadata  # clean metadata from other repos, or after updating our repo
                S yum install perl-RPerl

                echo '[ CHECK RPERL INSTALL ]'
                B which rperl
                B rpm -qf /usr/bin/rperl

                echo '[ UNINSTALL RPERL, IF LAST TRANSACTION ]'
                S yum history
                S yum history undo last
            fi

        elif [ $RPERL_INSTALL_CHOICE == 'b' ] || [ $RPERL_INSTALL_CHOICE == 'cpanm-single' ]; then

            echo '24b. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPANM, SINGLE-USER ]]]'
            echo '[ You Should Only Use This Option 24b If local::lib Or Perlbrew Is Installed For Your User ]'
            echo
            echo '[ Install Problematic RPerl Dependency IO::Socket::SSL, Skip Tests ]'
            B cpanm -v --notest IO::Socket::SSL
            echo '[ Install Missing Alien::GMP Dependencies ]'
            B cpanm -v --notest File::Which FFI::CheckLib Path::Tiny File::chdir Capture::Tiny Alien::GMP
            echo '[ Install RPerl ]'
            B cpanm -v --notest RPerl

        elif [ $RPERL_INSTALL_CHOICE == 'c' ] || [ $RPERL_INSTALL_CHOICE == 'cpanm-system' ]; then

            echo '24c. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPANM, SYSTEM-WIDE ]]]'
            echo '[ You Should Only Use This Option 24c If local::lib Or Perlbrew Is NOT Installed For Your User ]'
            echo
            echo '[ Install Problematic RPerl Dependency IO::Socket::SSL, Skip Tests ]'
            S cpanm -v --notest IO::Socket::SSL
            echo '[ Install Missing Alien::GMP Dependencies ]'
            S cpanm -v --notest File::Which FFI::CheckLib Path::Tiny File::chdir Capture::Tiny Alien::GMP
            echo '[ Install RPerl ]'
            S cpanm -v --notest RPerl

        elif [ $RPERL_INSTALL_CHOICE == 'd' ] || [ $RPERL_INSTALL_CHOICE == 'cpan-single' ]; then

            echo '24d. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPAN, SINGLE-USER ]]]'
            echo '[ You Should Only Use This Option 24d If local::lib Or Perlbrew Is Installed For Your User, And You Do NOT Have CPANM Installed ]'
            echo
            echo '[ Install Problematic RPerl Dependency IO::Socket::SSL ]'
            B cpan -T IO::Socket::SSL
            echo '[ Install Missing Alien::GMP Dependencies ]'
            B cpan -T --notest File::Which FFI::CheckLib Path::Tiny File::chdir Capture::Tiny Alien::GMP
            echo '[ Install RPerl ]'
            B cpan -T RPerl

        elif [ $RPERL_INSTALL_CHOICE == 'e' ] || [ $RPERL_INSTALL_CHOICE == 'cpan-system' ]; then

            echo '24e. [[[ PERL, INSTALL RPERL, LATEST STABLE VIA CPAN, SYSTEM-WIDE ]]]'
            echo '[ You Should Only Use This Option 24e If local::lib Or Perlbrew Is NOT Installed For Your User, And You Do NOT Have CPANM Installed ]'
            echo
            echo '[ Install Problematic RPerl Dependency IO::Socket::SSL ]'
            S cpan -T IO::Socket::SSL
            echo '[ Install Missing Alien::GMP Dependencies ]'
            S cpan -T --notest File::Which FFI::CheckLib Path::Tiny File::chdir Capture::Tiny Alien::GMP
            echo '[ Install RPerl ]'
            S cpan -T RPerl

        elif [ $RPERL_INSTALL_CHOICE == 'f' ] || [ $RPERL_INSTALL_CHOICE == 'github-secure-git' ]; then

            echo '24f. [[[ PERL, INSTALL RPERL, LATEST UNSTABLE VIA GITHUB, SINGLE-USER, SECURE GIT ]]]'
            echo
            echo '[ If You Want To Upload Code To GitHub, Then You Must Use Secure Git Instead Of Public Git Or Public Zip ]'

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
            D $RPERL_REPO_DIRECTORY 'directory where RPerl should be downloaded (different than final RPerl installation directory)' "~/rperl-latest"
            RPERL_REPO_DIRECTORY=$USER_INPUT

            # DEV NOTE: for more info, see  https://help.github.com/articles/generating-ssh-keys
            #if [ ! -f ~/.ssh/id_rsa.pub ] && [ ! -f ~/.ssh/id_dsa.pub ]; then  # NEED ANSWER: do we need id_dsa.pub???
            if [ ! -f ~/.ssh/id_rsa.pub ]; then
                echo '[ Generate SSH Keys, Do Create Secure Key Passphrase When Prompted ]'
                echo '[ WARNING: Be Sure To Record Your Secure Key Passphrase & Store It In A Safe Place ]'
                C 'Please read the warning above.  Seriously.'
                B "ssh-keygen -t rsa -C '$GITHUB_EMAIL'; eval `ssh-agent -s` ssh-add ~/.ssh/id_rsa; ssh-agent -k"
            else
                echo '[ SSH Key File(s) Already Exist, Skipping Key Generation ]'
            fi

            if [[ "$OS_CHOICE" == "ubuntu" ]]; then
                VERIFY_UBUNTU
                echo '[ Install Keychain Key Manager For OpenSSH ]'
                S apt-get install keychain
                echo '[ Check Install, Confirm No Errors ]'
                S apt-get -f install
            # OR
            elif [[ "$OS_CHOICE" == "centos" ]]; then
                VERIFY_CENTOS 

# RPM START HERE: why doesn't the below command set work?
# RPM START HERE: why doesn't the below command set work?
# RPM START HERE: why doesn't the below command set work?

                C '[ SECURE GIT ON CENTOS: Not Currently Supported ]'
#                echo '[ Install Keychain Key Manager For OpenSSH ]'
#                S rpm --import http://mirror.ghettoforge.org/distributions/gf/RPM-GPG-KEY-gf.el7
#                S rpm -Uvh http://mirror.ghettoforge.org/distributions/gf/gf-release-latest.gf.el7.noarch.rpm 
#                S yum clean all
#                S yum install keychain
#                if [ $DEVELOPER_CHOICE == 'yes' ]; then
#                    echo '[ Check Install, Confirm No Errors; WARNING! MAY TAKE HOURS TO RUN! ]'
#                    S yum check
#                fi
            else
                C '[ SECURE GIT ON NON-UBUNTU AND NON-CENTOS: Please See Your Operating System Documentation To Install Keychain Key Manager For OpenSSH ]'
            fi

            echo '[ Enable Keychain ]'
            echo '[ NOTE: Do Not Run The Following Step If You Already Copied Your Own Pre-Existing LAMP University .bashrc File In Section 0 ]'
            B 'echo -e "\n# SSH Keys; for GitHub, etc.\nif [ -f /usr/bin/keychain ] && [ -f \$HOME/.ssh/id_rsa ]; then\n    /usr/bin/keychain \$HOME/.ssh/id_rsa\n    source \$HOME/.keychain/\$HOSTNAME-sh\nfi\n" >> ~/.bashrc;'
            SOURCE ~/.bashrc
            echo '[ How To Enable SSH Key On GitHub... ]'
            echo '[ Copy Data Produced By The Next Command ]'
            echo '[ Then Browse To https://github.com/settings/ssh ]'
            echo "[ Then Click 'Add SSH Key', Paste Copied Key Data, Title '$USERNAME@$HOSTNAME', Click 'Save' ]"
            echo
            B 'cat ~/.ssh/id_rsa.pub'
            echo
            C '[ Please Follow The Instructions Above ]'
            echo '[ Test SSH Key On GitHub, Enter Passphrase When Prompted, Confirm Automatic Reply Greeting From GitHub Server ]'
            B ssh -T git@github.com
            echo '[ Configure GitHub Account Setting On Local Machine ]'
            echo '[ NOTE: Do Not Repeat The 3 Following git config Steps If You Already Copied Your Own Pre-Existing .gitconfig File In Section 0 ]'
            B git config --global user.email "$GITHUB_EMAIL"
            B git config --global user.name "$GITHUB_FIRST_NAME $GITHUB_LAST_NAME"
            B git config --global core.editor "$EDITOR"
            echo '[ Clone (Download) RPerl Repository Onto New Machine ]'
            B git clone git@github.com:wbraswell/rperl.git $RPERL_REPO_DIRECTORY

        elif [ $RPERL_INSTALL_CHOICE == 'g' ] || [ $RPERL_INSTALL_CHOICE == 'github-public-git' ]; then

            echo '24g. [[[ PERL, INSTALL RPERL, LATEST UNSTABLE VIA GITHUB, SINGLE-USER, PUBLIC GIT ]]]'
            echo
            echo '[ If You Want To Upload Code To GitHub, Then You Must Use Secure Git Instead Of Public Git Or Public Zip ]'

            D $RPERL_REPO_DIRECTORY 'directory where RPerl should be downloaded (different than final RPerl installation directory)' "~/rperl-latest"
            RPERL_REPO_DIRECTORY=$USER_INPUT

            echo '[ Clone (Download) RPerl Repository Onto New Machine ]'
            B git clone https://github.com/wbraswell/rperl.git $RPERL_REPO_DIRECTORY

        elif [ $RPERL_INSTALL_CHOICE == 'h' ] || [ $RPERL_INSTALL_CHOICE == 'github-public-zip' ]; then

            echo '24h. [[[ PERL, INSTALL RPERL, LATEST UNSTABLE VIA GITHUB, SINGLE-USER, PUBLIC ZIP ]]]'
            echo
            echo '[ If You Want To Upload Code To GitHub, Then You Must Use Secure Git Instead Of Public Git Or Public Zip ]'

            D $RPERL_REPO_DIRECTORY 'directory where RPerl should be downloaded (different than final RPerl installation directory)' "~/rperl-latest"
            RPERL_REPO_DIRECTORY=$USER_INPUT

            echo '[ Download RPerl Repository Onto New Machine ]'
            B "wget https://github.com/wbraswell/rperl/archive/master.zip; unzip master.zip; mv rperl-master $RPERL_REPO_DIRECTORY; rm master.zip"

        else
            echo "ERROR: Unrecognized value for RPERL_INSTALL_CHOICE, '${RPERL_INSTALL_CHOICE}', please see '--help' option for valid values"
        fi
 
        # avoid duplication of code for building Git options
        if [ $RPERL_INSTALL_CHOICE == 'f' ] || [ $RPERL_INSTALL_CHOICE == 'github-secure-git' ] ||
           [ $RPERL_INSTALL_CHOICE == 'g' ] || [ $RPERL_INSTALL_CHOICE == 'github-public-git' ] ||
           [ $RPERL_INSTALL_CHOICE == 'h' ] || [ $RPERL_INSTALL_CHOICE == 'github-public-zip' ]; then
            echo '[ ALL GIT OPTIONS: Install Problematic RPerl Dependency IO::Socket::SSL, Skip Tests ]'
            B cpanm -v --notest IO::Socket::SSL
            echo '[ ALL GIT OPTIONS: Install Missing Alien::GMP Dependencies ]'
            B cpanm -v --notest File::Which FFI::CheckLib Path::Tiny File::chdir Capture::Tiny Alien::GMP
            echo '[ ALL GIT OPTIONS: Install RPerl Dependencies Via CPAN ]'
            CD $RPERL_REPO_DIRECTORY
            B 'perl Makefile.PL; cpanm -v --notest --installdeps .'
            echo '[ ALL GIT OPTIONS: Build & Test RPerl ]'
            B 'make; make test'
            echo '[ ALL GIT OPTIONS: Build & Test RPerl, Optional Verbose Output ]'
            B 'make; make test TEST_VERBOSE=1'
            echo '[ ALL GIT OPTIONS: Install RPerl ]'
            B 'make install'
        fi

    elif [ $MACHINE_CHOICE == '1' ] || [ $MACHINE_CHOICE == 'existing' ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 25 VARIABLES
RPERL_VERBOSE='__EMPTY__'
RPERL_DEBUG='__EMPTY__'
RPERL_WARNINGS='__EMPTY__'
RPERL_INSTALL_DIRECTORY='__EMPTY__'

if [ $SECTION_CHOICE -le 25 ]; then
    echo '25. [[[ RPERL, RUN COMPILER TESTS ]]]'
    echo
    if [ $MACHINE_CHOICE == '0' ] || [ $MACHINE_CHOICE == 'new' ]; then
        D $RPERL_VERBOSE 'RPERL_VERBOSE additional user output, 0 for off, 1 for on' '1'
        export RPERL_VERBOSE=$USER_INPUT
        D $RPERL_DEBUG 'RPERL_DEBUG additional system output, 0 for off, 1 for on' '1'
        export RPERL_DEBUG=$USER_INPUT
        D $RPERL_WARNINGS 'RPERL_WARNINGS additional user & system warnings, 0 for off, 1 for on' '0'
        export RPERL_WARNINGS=$USER_INPUT
        D $RPERL_INSTALL_DIRECTORY 'directory where RPerl is currently installed (include trailing "/lib" directory if present)' "~/perl5/lib/perl5" "~/repos_github/rperl-latest/lib"
        RPERL_INSTALL_DIRECTORY=$USER_INPUT

        echo '[ These RPerl Test Commands Must Be Executed From Within The RPerl Installation Directory ]'
        CD $RPERL_INSTALL_DIRECTORY

        echo '[ Display RPerl Command Usage, Ensure RPerl Command Is Properly Functioning ]'
        B rperl -?

        echo '[ Test Command Sequence #1, OO Inheritance Test: Clean Pre-Existing Compiled Files ]'
        B rperl -uu RPerl/Algorithm/Sort/Bubble.pm
#        B rm -Rf _Inline lib/RPerl/Algorithm.pmc lib/RPerl/Algorithm.h lib/RPerl/Algorithm.cpp lib/RPerl/Algorithm/Sort.pmc lib/RPerl/Algorithm/Sort.h lib/RPerl/Algorithm/Sort.cpp lib/RPerl/Algorithm/Sort/Bubble.pmc lib/RPerl/Algorithm/Sort/Bubble.h lib/RPerl/Algorithm/Sort/Bubble.cpp

        RPERL_CODE='use RPerl::Algorithm::Sort::Bubble; my $o = RPerl::Algorithm::Sort::Bubble->new(); $o->inherited_Bubble("logan"); $o->inherited_Sort("wolvie"); $o->inherited_Algorithm("claws");'

        echo '[ Test Command Sequence #1, OO Inheritance Test: Zero Of Three Files Are Compiled, Output Should Be PERLOPS_PERLTYPES, PERLOPS_PERLTYPES, PERLOPS_PERLTYPES ]'
        B "perl -e '$RPERL_CODE'"
    
        echo '[ Test Command Sequence #1, OO Inheritance Test: Compile First Of Three Files ]'
        B rperl RPerl/Algorithm.pm
        echo '[ Test Command Sequence #1, OO Inheritance Test: One Of Three Files Are Compiled, Output Should Be PERLOPS_PERLTYPES, PERLOPS_PERLTYPES, CPPOPS_CPPTYPES ]'
        B "perl -e '$RPERL_CODE'"
        echo '[ Test Command Sequence #1, OO Inheritance Test: Uncompile First Of Three Files ]'
        B rperl -u RPerl/Algorithm.pm

        echo '[ Test Command Sequence #1, OO Inheritance Test: Compile Second Of Three Files ]'
        B rperl RPerl/Algorithm/Sort.pm
        echo '[ Test Command Sequence #1, OO Inheritance Test: Two Of Three Files Are Compiled, Output Should Be PERLOPS_PERLTYPES, CPPOPS_CPPTYPES, CPPOPS_CPPTYPES ]'
        B "perl -e '$RPERL_CODE'"
        echo '[ Test Command Sequence #1, OO Inheritance Test: Uncompile Second Of Three Files ]'
        B rperl -u RPerl/Algorithm/Sort.pm

        echo '[ Test Command Sequence #1, OO Inheritance Test: Compile Third Of Three Files ]'
        B rperl RPerl/Algorithm/Sort/Bubble.pm
        echo '[ Test Command Sequence #1, OO Inheritance Test: All Three Files Are Compiled, Output Should Be CPPOPS_CPPTYPES, CPPOPS_CPPTYPES, CPPOPS_CPPTYPES ]'
        B "perl -e '$RPERL_CODE'"
        echo '[ Test Command Sequence #1, OO Inheritance Test: Uncompile Third Of Three Files ]'
        B rperl -u RPerl/Algorithm/Sort/Bubble.pm


        echo '[ Test Command Sequence #2, OO Bubble Sort Timing Test: Clean New or Pre-Existing Compiled Files ]'
        B rperl -uu RPerl/Algorithm/Sort/Bubble.pm
#        B rm -Rf _Inline lib/RPerl/Algorithm.pmc lib/RPerl/Algorithm.h lib/RPerl/Algorithm.cpp lib/RPerl/Algorithm/Sort.pmc lib/RPerl/Algorithm/Sort.h lib/RPerl/Algorithm/Sort.cpp lib/RPerl/Algorithm/Sort/Bubble.pmc lib/RPerl/Algorithm/Sort/Bubble.h lib/RPerl/Algorithm/Sort/Bubble.cpp
#        B ./script/demo/unlink_bubble.sh

        RPERL_CODE='use RPerl::Algorithm::Sort::Bubble; my $a = [reverse 0 .. 5000]; use Time::HiRes qw(time); my $start = time; my $s = RPerl::Algorithm::Sort::Bubble::integer_bubblesort($a); my $elapsed = time - $start; print Dumper($s); print "elapsed: " . $elapsed . "\n";'

        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Slow Uncompiled PERLOPS_PERLTYPES Mode, 13 Seconds For 5_000 Elements ]'
        B "perl -e '$RPERL_CODE'"

# NEED FIX: re-enable CPPOS_PERLTYPES manually-compiled files, crashing w/ GCC compiler errors
# NEED FIX: re-enable CPPOS_PERLTYPES manually-compiled files, crashing w/ GCC compiler errors
# NEED FIX: re-enable CPPOS_PERLTYPES manually-compiled files, crashing w/ GCC compiler errors

#        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Fast Manually Compiled CPPOPS_PERLTYPES Mode, Link Files IF GITHUB REPO ONLY ]'
#        B ../script/demo/link_bubble_CPPOPS_PERLTYPES.sh
#        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Fast Manually Compiled CPPOPS_PERLTYPES Mode, 1.5 Seconds For 5_000 Elements ]'
#        B "perl -e '$RPERL_CODE'"

        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Clean New Compiled Files ]'
        B rperl -u RPerl/Algorithm/Sort/Bubble.pm
#        B ./script/demo/unlink_bubble.sh

        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Super Fast Automatically Compiled CPPOPS_CPPTYPES Mode, Compile Files ]'
        B rperl RPerl/Algorithm/Sort/Bubble.pm
        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Super Fast Automatically Compiled CPPOPS_CPPTYPES Mode, 0.05 Seconds For 5_000 Elements ]'
        B "perl -e '$RPERL_CODE'"
        echo '[ Test Command Sequence #2, Bubble Sort Timing Test: Super Fast Automatically Compiled CPPOPS_CPPTYPES Mode, Uncompile Files ]'
        B rperl -u RPerl/Algorithm/Sort/Bubble.pm

    elif [ $MACHINE_CHOICE == '1' ] || [ $MACHINE_CHOICE == 'existing' ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

# SECTION 26 VARIABLES
PHYSICSPERL_DOWNLOAD_DIRECTORY='__EMPTY__'
#PHYSICSPERL_INSTALL_DIRECTORY='__EMPTY__'
PHYSICSPERL_NBODY_STEPS='__EMPTY__'
PHYSICSPERL_ENABLE_GRAPHICS='__EMPTY__'

if [ $SECTION_CHOICE -le 26 ]; then
    echo '26. [[[ RPERL, INSTALL RPERL APPS & RUN DEMOS ]]]'
    echo
    if [ $MACHINE_CHOICE == '0' ] || [ $MACHINE_CHOICE == 'new' ]; then
        D $RPERL_VERBOSE 'RPERL_VERBOSE additional user output, 0 for off, 1 for on' '1'
        export RPERL_VERBOSE=$USER_INPUT
        D $RPERL_DEBUG 'RPERL_DEBUG additional system output, 0 for off, 1 for on' '1'
        export RPERL_DEBUG=$USER_INPUT
        D $RPERL_WARNINGS 'RPERL_WARNINGS additional user & system warnings, 0 for off, 1 for on' '0'
        export RPERL_WARNINGS=$USER_INPUT
        D $PHYSICSPERL_DOWNLOAD_DIRECTORY 'directory where PhysicsPerl is to be downloaded (different than final PhysicsPerl installation directory; do NOT include trailing "/lib" directory)' "~/physicsperl-latest" "~/repos_github/physicsperl-latest"
        PHYSICSPERL_DOWNLOAD_DIRECTORY=$USER_INPUT
        # NEED UPGRADE: support installation of PhysicsPerl, not just download; must be able to find & run `script/demo/n_body.pl`
#        D $PHYSICSPERL_INSTALL_DIRECTORY 'directory where PhysicsPerl is to be installed or is already installed (DO include trailing "/lib" directory if present)' "~/physicsperl-latest/lib" "~/perl5/lib/perl5" "~/repos_github/physicsperl-latest/lib"
#        PHYSICSPERL_INSTALL_DIRECTORY=$USER_INPUT
        D $PHYSICSPERL_NBODY_STEPS 'number of PhysicsPerl N-Body steps to complete (more steps is longer runtime)' '100_000'
        PHYSICSPERL_NBODY_STEPS=$USER_INPUT
        D $PHYSICSPERL_ENABLE_GRAPHICS 'enabling of PhysicsPerl graphics, 0 for off, 1 for on' '0'
        PHYSICSPERL_ENABLE_GRAPHICS=$USER_INPUT
        PHYSICSPERL_ENABLE_SSE='__EMPTY__'

        # DEV NOTE: PATH & PERL5LIB may already be set via LAMP University Run Commands .bashrc, but temporarily modify anyway just in case
        PATH=script:$PATH
        PERL5LIB=lib:$PERL5LIB

        # NEED UPDATE: add option to install PhysicsPerl via CPAN
        echo '[ Install Latest Unstable PhysicsPerl Via Public Github ]'
        B "wget https://github.com/wbraswell/physicsperl/archive/master.zip; unzip master.zip; mv physicsperl-master ${PHYSICSPERL_DOWNLOAD_DIRECTORY}; rm -rf master.zip"
        CD $PHYSICSPERL_DOWNLOAD_DIRECTORY
        echo
        echo '[ Install PhysicsPerl Dependencies Via CPAN ]'
        B cpanm -v --notest --installdeps .
#        echo '[ Build & Install PhysicsPerl ]'
#        B 'perl Makefile.PL; make; make test; make install'
#        CD $PHYSICSPERL_INSTALL_DIRECTORY

        PHYSICSPERL_ENABLE_SSE=1
        echo '[ Test Command Sequence #0a, PhysicsPerl N-Body Timing Test: Clean Pre-Existing Compiled Files ]'
        B rperl -uu lib/PhysicsPerl/Astro/SystemSSE.pm
#        B script/demo/unlink_astro.sh  # prefer functionally equivalent `rperl -u` for uniformity & professionalism
        echo '[ Test Command Sequence #0a, PhysicsPerl N-Body Timing Test: Super Slow Uncompiled PERLOPS_PERLTYPES_SSE Mode, 345 Seconds For 100K Steps & 4109 Seconds (68 Minutes) For 1M Steps Without Graphics ]'
        echo '[ NOTE: This Test Could Take SEVERAL HOURS OR DAYS To Run!!! ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS $PHYSICSPERL_ENABLE_SSE

        PHYSICSPERL_ENABLE_SSE=0
        echo '[ Test Command Sequence #0b, PhysicsPerl N-Body Timing Test: Clean Pre-Existing Compiled Files ]'
        B rperl -u lib/PhysicsPerl/Astro/System.pm
        echo '[ Test Command Sequence #0b, PhysicsPerl N-Body Timing Test: Slow Uncompiled PERLOPS_PERLTYPES Mode, 20 Seconds For 100K Steps & 200 Seconds For 1M Steps Without Graphics ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS $PHYSICSPERL_ENABLE_SSE

        PHYSICSPERL_ENABLE_SSE=0
        echo '[ Test Command Sequence #0c, PhysicsPerl N-Body Timing Test: Clean New Compiled Files ]'
        B rperl -u lib/PhysicsPerl/Astro/System.pm
        echo '[ Test Command Sequence #0c, PhysicsPerl N-Body Timing Test: Super Fast Manually Compiled CPPOPS_CPPTYPES Mode, Link Files ]'
        B script/demo/link_astro_CPPOPS_CPPTYPES.sh
        echo '[ Test Command Sequence #0c, PhysicsPerl N-Body Timing Test: Super Fast Manually Compiled CPPOPS_CPPTYPES Mode, 0.7 Seconds For 100K Steps & 7 Seconds For 1M Steps Without Graphics ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS $PHYSICSPERL_ENABLE_SSE

        PHYSICSPERL_ENABLE_SSE=1
        echo '[ Test Command Sequence #0d, PhysicsPerl N-Body Timing Test: Clean New Compiled Files ]'
        B rperl -u lib/PhysicsPerl/Astro/SystemSSE.pm
        echo '[ Test Command Sequence #0d, PhysicsPerl N-Body Timing Test: Ultra Fast Manually Compiled CPPOPS_CPPTYPES_SSE Mode, Link Files ]'
        B script/demo/link_astro_CPPOPS_CPPTYPES_SSE.sh
        echo '[ Test Command Sequence #0d, PhysicsPerl N-Body Timing Test: Ultra Fast Manually Compiled CPPOPS_CPPTYPES_SSE Mode, 0.12 Seconds For 100K Steps & 1.2 Seconds For 1M Steps Without Graphics ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS $PHYSICSPERL_ENABLE_SSE

        PHYSICSPERL_ENABLE_SSE=0
        echo '[ Test Command Sequence #0e, PhysicsPerl N-Body Timing Test: Clean New Compiled Files ]'
        B rperl -uu lib/PhysicsPerl/Astro/System.pm
        echo '[ Test Command Sequence #0e, PhysicsPerl N-Body Timing Test: Super Fast Automatically Compiled CPPOPS_CPPTYPES Mode, Compile Files ]'
        B rperl lib/PhysicsPerl/Astro/System.pm
        echo '[ Test Command Sequence #0e, PhysicsPerl N-Body Timing Test: Super Fast Automatically Compiled CPPOPS_CPPTYPES Mode, 0.7 Seconds For 100K Steps & 7 Seconds For 1M Steps Without Graphics ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS $PHYSICSPERL_ENABLE_SSE

        PHYSICSPERL_ENABLE_SSE=1
        echo '[ Test Command Sequence #0f, PhysicsPerl N-Body Timing Test: Clean New Compiled Files ]'
        B rperl -u lib/PhysicsPerl/Astro/SystemSSE.pm
        echo '[ Test Command Sequence #0f, PhysicsPerl N-Body Timing Test: Ultra Fast Automatically Compiled CPPOPS_CPPTYPES_SSE Mode, Compile Files ]'
        B rperl lib/PhysicsPerl/Astro/SystemSSE.pm
        echo '[ Test Command Sequence #0f, PhysicsPerl N-Body Timing Test: Ultra Fast Automatically Compiled CPPOPS_CPPTYPES_SSE Mode, 0.12 Seconds for 100K Steps & 1.2 Seconds For 1M Steps Without Graphics ]'
        B script/demo/n_body.pl $PHYSICSPERL_NBODY_STEPS $PHYSICSPERL_ENABLE_GRAPHICS $PHYSICSPERL_ENABLE_SSE

    elif [ $MACHINE_CHOICE == '1' ] || [ $MACHINE_CHOICE == 'existing' ]; then
        echo "Nothing To Do On Existing Machine!"
    fi
    CURRENT_SECTION_COMPLETE
fi

echo
echo '[[[ ALL DONE!!! ]]]'
echo

