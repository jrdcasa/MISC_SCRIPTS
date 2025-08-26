#!/bin/bash
#SBATCH --partition=generic
#SBATCH --nodes=1
#SBATCH --tasks-per-node=48
#SBATCH --job-name=SP_CP2K_MFI_Al00_111
##SBATCH --exclude=drago[31040141-31040142]
#SBATCH --reservation=curso

WD=`pwd`

# ============== LOAD MODULES ================
module purge
#module load rama0.2 GCC/11.2.0  OpenMPI/4.1.1 CP2K/2023.1
module load rama0.3 GCC/12.2.0  OpenMPI/4.1.4 CP2K/2023.1

# ============== CP2K ================
mpirun -n 48 cp2k.popt input.dat >output_opt.dat
