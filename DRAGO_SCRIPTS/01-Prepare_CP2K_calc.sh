#!/bin/bash
WK=`pwd`
date

module load rama0.4  GCC/12.3.0  OpenMPI/4.1.5 OpenBabel/3.1.1

PDBDIR=("./00-PDBs") 

idx=0
for ipdbfile in `ls ${PDBDIR[@]}/*.pdb`; do

    tmp=`basename $ipdbfile`
    NAME_PATTERN=${tmp%.pdb}
    
    if [[ -d ${WK}/CP2K_${NAME_PATTERN} ]]; then
        echo "${WK}/CP2K_${NAME_PATTERN} already exist!!!!"
        idx=`echo $idx + 1|bc -l`
        continue
    fi 

    mkdir -p ${WK}/CP2K_${NAME_PATTERN}

    echo CP2K_${NAME_PATTERN}
    cp $ipdbfile CP2K_${NAME_PATTERN}
    cd CP2K_${NAME_PATTERN}

    # Transform PDB to XYZ using openbabel
    echo ${NAME_PATTERN}.pdb
    
    if command -v obabel >/dev/null 2>&1; then
        obabel ${NAME_PATTERN}.pdb -O ${NAME_PATTERN}.xyz
        tail -n +3 ${NAME_PATTERN}.xyz >${NAME_PATTERN}_cp2k.xyz
    else
        echo ""
        echo "=========== ERROR ========================"
        echo "Open babel is not installed in the system."
        echo "PDB cannot be converted to XYZ"
        echo "Try load or install openbabel"
        echo `date`
        echo "=========== ERROR ========================"
        echo ""
        exit
    fi

    # Extract PDB CRYST
    XCELL=`egrep CRYST ${NAME_PATTERN}.pdb|awk '{print $2}'`
    YCELL=`egrep CRYST ${NAME_PATTERN}.pdb|awk '{print $3}'`
    ZCELL=`egrep CRYST ${NAME_PATTERN}.pdb|awk '{print $4}'`
    ALPHA=`egrep CRYST ${NAME_PATTERN}.pdb|awk '{print $5}'`
    BETA=`egrep CRYST ${NAME_PATTERN}.pdb|awk '{print $6}'`
    GAMMA=`egrep CRYST ${NAME_PATTERN}.pdb|awk '{print $7}'`

    echo $ALPHA $BETA $GAMMA

    sed -e "s%#XYZFILE#%${NAME_PATTERN}_cp2k.xyz%g" \
        -e "s%#NAME#%${NAME_PATTERN}%g" \
        -e "s%#XCELL#%$XCELL%g" \
        -e "s%#YCELL#%$YCELL%g" \
        -e "s%#ZCELL#%$ZCELL%g" \
        -e "s%#ALPHA#%$ALPHA%g" \
        -e "s%#BETA#%$BETA%g" \
        -e "s%#GAMMA#%$GAMMA%g" ${WK}/input_optIonCellFull_400Ry_PBEDFDT2_template.dat >input.dat

    sed -e "s%#JOBNAME#%${NAME_PATTERN}%g" ${WK}/run_CP2K_048p01N_template.sh >run_CP2K_048p01N.sh

    sbatch run_CP2K_048p01N.sh

    idx=`echo $idx + 1|bc -l`
    cd ${WK}

done

echo "Job Done!!!!!"
date
