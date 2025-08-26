#!/bin/bash


# ================= MAIN =====================
WK=`pwd`
date

idx=0
for spdir in `ls -d SP_CP2K_*`; do

    echo "====== ${spdir} =========="
    cd ${spdir}

    rm *.cube
    rm *.wfx
    rm *.wfn
    rm slurm*

    idx=`echo $idx + 1|bc -l`
    cd ${WK}

done

echo "Job Done!!!!!"
date