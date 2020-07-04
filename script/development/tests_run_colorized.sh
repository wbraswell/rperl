#!/bin/bash
# Copyright © 2020, William N. Braswell, Jr.. All Rights Reserved. This work is Free \& Open Source; you can redistribute it and/or modify it under the same terms as Perl 7.0 or newer.

reset
inline_clean.sh

for argument in "$@"
do
    # assume argument is one word, only the test file path
    argument_test_file_path=$argument

    # if argument contains space, then it is more than one word, presumably a test file path plus some arguments
    regex_contains_space=" |'"
    if [[ $argument =~ $regex_contains_space ]]; then
        for argument_word in $argument
        do
            argument_test_file_path=$argument_word
            break  # only utilize the first $argument_word, which presumably is the test file path
        done
    fi

    # remove file path prefix
    argument_test_file=${argument_test_file_path##*/}  

    # remove file extension suffix
    argument_test_file_base=${argument_test_file%.*}

    log_file=/tmp/$argument_test_file_base.out

    echo "[[[=== BEGIN TEST FILE COMMAND $argument ; OUTPUT LOGGED TO $log_file ===]]]"
    echo

    # use `script` command to preserve all color codes and write to log file
    script --flush --quiet --return $log_file --command "perl ${argument} | ./script/development/test_output_colorize.pl"

    echo
    echo "[[[===   END TEST FILE COMMAND $argument ; OUTPUT LOGGED TO $log_file ===]]]"
    echo
    echo
done

