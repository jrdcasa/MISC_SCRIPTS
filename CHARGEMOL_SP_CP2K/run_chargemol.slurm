#!/bin/bash
#SBATCH --job-name="CHARGEMOL_SP_CP2K_MFI_Al00_111"
#SBATCH --partition=generic
#SBATCH --nodes 1
#SBATCH --ntasks-per-node=12
#SBATCH --reservation=curso

export OMP_NUM_THREADS=12
module load rama0.4 GCC/13.3.0
/lustre/home/iem/jramos/CODES/chargemol_09_26_2017/chargemol_FORTRAN_09_26_2017/compiled_binaries/linux/Chargemol_09_26_2017_linux_parallel
echo "run complete on `hostname`: `date`" 1>&2
