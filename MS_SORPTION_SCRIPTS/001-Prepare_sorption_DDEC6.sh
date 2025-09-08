#!/bin/bash
# Automates sorption simulations: creates directories, sets pressures, 
# and submits jobs for multiple adsorbates on a given framework.
WK=`pwd`

FRAMEWORK=01-FRAMEWORKS_PCFF/MFI_Al00_222_opt_DDEC6.xsd

ADSORBATES=(02-ADSORBATES_PCFF/C2Cl4_ES.xsd 
            02-ADSORBATES_PCFF/C2H4Cl2_ES.xsd 
            02-ADSORBATES_PCFF/C2H4_ES.xsd 
            02-ADSORBATES_PCFF/C2H6_ES.xsd 
            02-ADSORBATES_PCFF/C2HCl3_ES.xsd 
            02-ADSORBATES_PCFF/CCl4_ES.xsd 
            02-ADSORBATES_PCFF/CH2Cl2_ES.xsd 
            02-ADSORBATES_PCFF/CH3Cl_ES.xsd 
            02-ADSORBATES_PCFF/CH4_ES.xsd 
            02-ADSORBATES_PCFF/CHCl3_ES.xsd 
            02-ADSORBATES_PCFF/Cl2_ES.xsd 
            02-ADSORBATES_PCFF/HCl_ES.xsd 
            )


PERL_SCRIPT=FixedPresureTemplate_current.pl
TEMPERATURE=298
NPOINTS=30
PINI=1e-06
PEND=2e03
PRESSURE=($(python3 - <<END
import math

start = $PINI
end = $PEND
points = $NPOINTS

for i in range(points):
    # Logarithmic interpolation
    val = start * (end/start)**(i/(points-1))
    print(float(val))
END
))

echo "${PRESSURE[@]}"

for iads in ${ADSORBATES[@]}; do

     # Setup patterns 
     FRAMEWORK_PATTERN=`basename ${FRAMEWORK}`
     FRAMEWORK_PATTERN=${FRAMEWORK_PATTERN%.*}
     IADS_PATTERN=`basename ${iads}`
     IADS_PATTERN=${IADS_PATTERN%.*}
     CDIR=${FRAMEWORK_PATTERN}-${IADS_PATTERN}

     # Check if the dir exists
     if [[ -d $CDIR ]]; then
         echo "$CDIR dir exists"
         echo ""
         continue
     else
         mkdir $CDIR
         echo "Preparing $CDIR dir..." 
     fi

     # Prepare dir for pressures
     idxpress=0
     for ipress in ${PRESSURE[@]}; do
         idxpress_f=`printf "%03d" $idxpress`
         ipress_f=`printf "%.2e" $ipress`
         echo $idxpress, $ipress, $ipress_f, $FRAMEWORK_PATTERN, $IADS_PATTERN
         PDIR_PATTERN=${idxpress_f}_P_${ipress_f}_kPa
         cd ${CDIR}
         mkdir ${PDIR_PATTERN}

         cp ${WK}/${FRAMEWORK} ${PDIR_PATTERN}
         cp ${WK}/${iads} ${PDIR_PATTERN}

         sed -e "s/#FRAMEWORK#/${FRAMEWORK_PATTERN}.xsd/g" \
             -e "s/#ADSORBATE#/${IADS_PATTERN}.xsd/g" \
             -e "s/#TEMP#/${TEMPERATURE}/g" \
             -e "s/#PRESS#/${ipress}/g" ${WK}/${PERL_SCRIPT} >${PDIR_PATTERN}/Perl_Script.pl

         sed -e "s/#JOBNAME#/${CDIR}_${PDIR_PATTERN}/g" ${WK}/run_Sorption_MS_template.sh >${PDIR_PATTERN}/run_slurm.sh

         cd ${PDIR_PATTERN}
         sbatch run_slurm.sh
         cd ..

         cd ..

         idxpress=`echo ${idxpress} + 1 |bc -l`
         sleep 0.5
     done

done
