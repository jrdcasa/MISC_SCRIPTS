#!/bin/bash
WK=`pwd`

for idir in `ls -d MFI*/`; do
    
    echo ${idir}
    bash ./003-extract_isotherm.sh ${idir}

done

mkdir -p 99-ANALYSIS
mkdir -p 99-ANALYSIS/01-Isotherms
mv MFI*dat 99-ANALYSIS/01-Isotherms

echo "Job Done!!!"
