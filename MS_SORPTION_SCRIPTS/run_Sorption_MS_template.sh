#!/bin/bash
#SBATCH --partition=generic
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --job-name=#JOBNAME#
#SBATCH --reservation=curso

PATH=$PATH:/lustre/opt/restricted/0.4/software/BIOVIA/MaterialsStudio/MaterialsStudio25.1
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lustre/opt/restricted/0.4/software/BIOVIA/MaterialsStudio/MaterialsStudio25.1/lib

/lustre/opt/restricted/0.4/software/BIOVIA/MaterialsStudio/MaterialsStudio25.1/etc/Scripting/bin/RunMatScript.sh  Perl_Script
