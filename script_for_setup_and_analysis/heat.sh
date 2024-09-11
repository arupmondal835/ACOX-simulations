#!/bin/bash
#SBATCH --job-name=7kj2_md
#SBATCH --output=7kjr_md.out
#SBATCH --error=7kjr_md.err
#SBATCH --mail-type=ALL
#SBATCH --time=5:00:00
#SBATCH --ntasks=1
#SBATCH --distribution=cyclic:cyclic
#SBATCH --mem-per-cpu=10000mb
#SBATCH --account=alberto.perezant
#SBATCH --cpus-per-gpu=1
#SBATCH --gpus-per-task=1
#SBATCH --partition=gpu

module purge
module load cuda/11.1.0  nvhpc/20.11  openmpi/4.0.5 amber/20


pmemd.cuda -O -i ../../script/mdt.in -o heat.out -p system_water.top -c min6.rst -r heat.rst -x heat.nc -inf heat.mdinfo -ref min6.rst
