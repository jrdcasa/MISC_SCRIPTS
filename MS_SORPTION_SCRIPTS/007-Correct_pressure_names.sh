#!/bin/bash
WK=`pwd`


for idir in `ls -d MFI*/`; do
    cd ${idir}
    for old in `ls -d */`; do


        # Extract prefix, number, and suffix
        prefix="${old%%_P_*}_P_"          # everything up to and including "_P_"
        suffix="_kPa"                     # constant suffix
        number="${old#${prefix}}"         # remove prefix -> number+suffix
        number="${number%_kPa/}"           # remove suffix -> just the number

        #echo $old : $prefix
        #echo $old : $suffix
        #echo $old : $number
        # Convert number to scientific notation (2 decimals)
        #sci=$(printf "%.2e" "$number" | sed 's/e-0*/e-/; s/e+0*/e+/')
        sci=$(printf "%.2e" "$number")
        #echo $old : $sci
        #exit

        # Build new name using same pattern
        new="${prefix}${sci}${suffix}/"

        mv "$old" "$new"
        echo "Renamed: $old to $new"

    done

    cd ${WK}

done
