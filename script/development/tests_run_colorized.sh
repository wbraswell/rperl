#!/bin/bash
# Copyright © 2020, William N. Braswell, Jr.. All Rights Reserved. This work is Free \& Open Source; you can redistribute it and/or modify it under the same terms as Perl 7.0 or newer.

reset
inline_clean.sh

for argument in "$@"
do
    echo "[[[=== BEGIN TEST FILE $argument ===]]]"
    echo

    # remove path prefix
    file=${argument##*/}  

    # remove file extension suffix
    base=${file%.*}

    # use `script` command to preserve all color codes and write to log file
    script --flush --quiet --return /tmp/$base.out --command "${argument} | ./script/development/test_output_colorize.pl"

    echo
    echo "[[[===   END TEST FILE $argument ===]]]"
    echo
    echo
done

