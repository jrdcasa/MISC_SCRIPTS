#!/bin/bash

# ================= FUNCTIONS =====================
check_paths() {

    CHARGEMOLS=$1
    CHARGEMOLP=$2
    ATOMICDIR=$3

    if [ ! -f $CHARGEMOLS ]; then
        echo "$CHARGEMOLS does not exist."
        exit
    fi

    if [ ! -f $CHARGEMOLP ]; then
        echo "$CHARGEMOLP does not exist."
        exit
    fi

    if [ ! -d $ATOMICDIR ]; then
        echo "$ATOMICDIR does not exist."
        exit
    fi

}

generate_job_control() {

    periodicity=$1
    atomic_dir=$2
    wfx_file=$3

    echo "<net charge>" >>job_control.txt
    echo "0.0" >>job_control.txt
    echo "</net charge>" >>job_control.txt
    echo "" >>job_control.txt

    echo "<periodicity along A, B, and C vectors>" >job_control.txt
    if [ $periodicity -eq 1 ]; then
        echo ".true." >>job_control.txt
        echo ".true." >>job_control.txt
        echo ".true." >>job_control.txt
    else
        echo ".false." >>job_control.txt
        echo ".false." >>job_control.txt
        echo ".false." >>job_control.txt
    fi
    echo "</periodicity along A, B, and C vectors>" >>job_control.txt
    echo "" >>job_control.txt

    echo "<atomic densities directory complete path>" >>job_control.txt
    echo "${atomic_dir}" >>job_control.txt
    echo "</atomic densities directory complete path>" >>job_control.txt
    echo "" >>job_control.txt

    # echo "<input filename>" >>job_control.txt
    # echo "${wfx_file}" >>job_control.txt
    # echo "</input filename>" >>job_control.txt
    # echo "" >>job_control.txt

    echo "<number of core electrons>" >>job_control.txt
    echo "14 10" >>job_control.txt
    echo "8 2" >>job_control.txt
    echo "1 0" >>job_control.txt
    echo "13 10" >>job_control.txt
    echo "</number of core electrons>" >>job_control.txt
    echo "" >>job_control.txt

    echo "<charge type>" >>job_control.txt
    echo "DDEC6" >>job_control.txt
    echo "</charge type>" >>job_control.txt
    echo "" >>job_control.txt

    echo "<compute BOs>" >>job_control.txt
    echo ".true." >>job_control.txt
    echo "</compute BOs>" >>job_control.txt


}

generate_slurm_file() {

    exe=$1
    nproc=$2
    jobname=$3

    echo "#!/bin/bash" >run_chargemol.slurm
    echo "#SBATCH --job-name=\"${jobname}\"" >>run_chargemol.slurm
    echo "#SBATCH --partition=generic" >>run_chargemol.slurm
    echo "#SBATCH --nodes 1" >>run_chargemol.slurm  
    echo "#SBATCH --ntasks-per-node=${nproc}" >>run_chargemol.slurm
    echo "#SBATCH --reservation=curso" >>run_chargemol.slurm
    echo "" >>run_chargemol.slurm
    echo "export OMP_NUM_THREADS=${nproc}" >>run_chargemol.slurm
    echo "module load rama0.4 GCC/13.3.0" >>run_chargemol.slurm
    echo "$1" >>run_chargemol.slurm
    echo 'echo "run complete on `hostname`: `date`" 1>&2' >>run_chargemol.slurm

}

# ================= MAIN =====================
WK=`pwd`
date

module load rama0.4  GCC/12.3.0  OpenMPI/4.1.5 OpenBabel/3.1.1

# PDBDIR=("./00-PDBs") 
CHARGEMOLS="/lustre/home/iem/jramos/CODES/chargemol_09_26_2017/chargemol_FORTRAN_09_26_2017/compiled_binaries/linux/Chargemol_09_26_2017_linux_serial"
CHARGEMOLP="/lustre/home/iem/jramos/CODES/chargemol_09_26_2017/chargemol_FORTRAN_09_26_2017/compiled_binaries/linux/Chargemol_09_26_2017_linux_parallel"
ATOMICDIR="/lustre/home/iem/jramos/CODES/chargemol_09_26_2017/atomic_densities/"

check_paths $CHARGEMOLS $CHARGEMOLP $ATOMICDIR

idx=0
for spdir in `ls -d SP_TZVP_CP2K_*`; do

    echo ${spdir}
    cd ${spdir}
    WFX_FILE=`ls *.wfx`
    WFX_FILE_FULLPATH=$(realpath $WFX_FILE)
    VALENCE_CUBE=`ls *valence_density*cube`
    VALENCE_CUBE_FULLPATH=$(realpath $VALENCE_CUBE)
    cd ${WK}

    NEW_DIR="CHARGEMOL_${spdir}"

    if [[ -d ${WK}/${NEW_DIR} ]]; then
        echo "${WK}/${NEW_DIR} already exist!!!!"
        idx=`echo $idx + 1|bc -l`
        continue
    fi 

    mkdir -p ${WK}/${NEW_DIR}
    cd ${WK}/${NEW_DIR}
    cp ${VALENCE_CUBE_FULLPATH} ./valence_density.cube

    generate_job_control 1 ${ATOMICDIR} ${WFX_FILE} 
    generate_slurm_file ${CHARGEMOLP} 12 ${NEW_DIR}

    sbatch run_chargemol.slurm

    idx=`echo $idx + 1|bc -l`
    cd ${WK}

done

echo "Job Done!!!!!"
date
