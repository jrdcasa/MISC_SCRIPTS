#/bin/bash
WK=`pwd`


TEMP=(265 )
#BOXL=(35.7  36.0  34.3  34.6  34.9  35.2  34.0  32.0  31.0  30.0  30.2)
#BOXG=(95.0  99.0  111.0  118.0  131.0  112.0  100.5  75.3  68.6  63.0  59.2)
BOXL=( 40.0       )    
BOXG=( 60.0        )    
NMOLL=( 350     )
NMOLG=( 350     )

idx=0
for itemp in ${TEMP[@]}; do
    echo "Temperature: ${itemp} K"
    NEWDIR=T_${itemp}_K_02

    if [[ -e ${NEWDIR} ]]; then
        echo "=============== WARNING ================="
        echo "Directory ${NEWDIR} exists in"
        echo `pwd`
        echo "{$itemp} K step is not performed"
        echo "========================================="
    else

        mkdir ${NEWDIR}
        cp 00-COMMON/* ${NEWDIR}
        cd ${NEWDIR}

        natoms=`echo ${NMOLL[$idx]}+${NMOLG[$idx]}|bc -l`
        sed -e "s/#TEMP#/${itemp}/g" \
            -e "s/#BOXL#/${BOXL[$idx]}/g" \
            -e "s/#BOXG#/${BOXG[$idx]}/g" \
            -e "s/#NMOLL#/${NMOLL[$idx]}/g" \
            -e "s/#NATOMS#/${natoms}/g" \
            -e "s/#NMOLG#/${NMOLG[$idx]}/g" gemc_CH3Cl_template_full.inp >gemc_CH3Cl.inp

        rm gemc_CH3Cl_template*.inp 

        JOBNAME="4T_${itemp}_K_CASSANDRA_02"
        sed -e "s/#JOBNAME#/${JOBNAME}/g" run_cassandra.slurm >tmp
        mv tmp run_cassandra.slurm

        sbatch run_cassandra.slurm

        cd ${WK}
    fi

    idx=`echo $idx+1|bc -l`


done
