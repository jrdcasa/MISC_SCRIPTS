#!/bin/bash
WK=`pwd`
date

#module load rama0.4  GCC/12.3.0  OpenMPI/4.1.5 OpenBabel/3.1.1

PDBDIR=("./00-PDBs") 

idx=0
for ioptdir in `ls -d CP2K_*`; do

    cd ${ioptdir}
    end_flag=`egrep -i "PROGRAM ENDED" output*`
    
    if [ -z "${end_flag}" ]; then
        idx=`echo $idx + 1|bc -l`
        cd ${WK}
        continue
    else
        echo ${ioptdir}
        REST_FILE=`ls *.restart`
        REST_FILE_FULLPATH=$(realpath ${REST_FILE})
        cd ${WK}
    fi
    
    NEW_DIR=SP_TZVP_${ioptdir}    
    
    if [[ -d ${WK}/${NEW_DIR} ]]; then
        echo "${WK}/${NEW_DIR} already exist!!!!"
        idx=`echo $idx + 1|bc -l`
        continue
    fi 

    mkdir -p ${WK}/${NEW_DIR}
    cd ${WK}/${NEW_DIR}

    sed -e "s%#NAME#%${NEW_DIR}%g" \
        -e "s%#RESTART_FILE#%${REST_FILE_FULLPATH}%g" ${WK}/input_SP_400Ry_PBEDFDT2_TZ_template.dat >input.dat


    sed -e "s%#JOBNAME#%${NEW_DIR}%g" ${WK}/run_CP2K_048p01N_template.sh >run_CP2K_048p01N.sh


    pwd
    ls -l

    sbatch run_CP2K_048p01N.sh

    idx=`echo $idx + 1|bc -l`
    cd ${WK}

done

echo "Job Done!!!!!"
date
