#!/bin/bash
#SBATCH --partition=generic
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --job-name=#JOBNAME#
#SBATCH --reservation=curso

# Print which node and date for debugging
echo "Running on host: $(hostname)"
echo "Job started at: $(date)"

# Load required modules
module load rama0.3 Mamba/23.1.0-4

# Initialize Conda for bash in a non-interactive shell
source $(conda info --base)/etc/profile.d/conda.sh

# Activate the Conda environment
conda activate CASSANDRA || { echo "Failed to activate CASSANDRA environment"; exit 1; }

# Set number of threads for OpenMP
export OMP_NUM_THREADS=8

# Optional: check environment and executable
echo "Conda environment: $(conda info --envs | grep '*')"
which cassandra.exe || { echo "cassandra.exe not found in PATH"; exit 1; }

# Measure start time
start_time=$(date +%s)

# Run the program
echo "Starting cassandra.exe..."
cassandra.exe gemc_CH3Cl.inp

# Measure end time
end_time=$(date +%s)
elapsed=$((end_time - start_time))

# Print elapsed time
echo "Elapsed time: $elapsed seconds"
echo "Job finished at: $(date)"


