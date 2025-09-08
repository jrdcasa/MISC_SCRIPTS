#!/bin/bash
WK=`pwd`

# Check that exactly one argument was provided
[ $# -ne 1 ] && echo "Usage: $0 <directory>" && exit 1

# Check that the argument is an existing directory
[ ! -d "$1" ] && echo "Error: '$1' is not a directory." && exit 1

CDIR=${1%/}
echo ${CDIR}

cd $CDIR

for idir in `ls -d *P*`; do

    echo "Pressure: $idir"
    egrep Step ${idir}/Status.txt

done

cd $WK
echo "Job Done!!!!!"
