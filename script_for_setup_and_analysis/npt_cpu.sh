#!/bin/bash
#SBATCH --job-name=7kjr-cpu
#SBATCH --output=7kjr-cpu.out
#SBATCH --error=7kjr-cpu.err
#SBATCH --mail-type=ALL
#SBATCH --time=24:00:00
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=8
#SBATCH --distribution=cyclic:cyclic
#SBATCH --mem-per-cpu=10000mb
#SBATCH --qos=alberto.perezant-b


cd $SLURM_SUBMIT_DIR

export OMP_NUM_THREADS=16
module purge
module load cuda/11.1.0  nvhpc/20.11  openmpi/4.0.5 amber/20

srun --mpi=pmix_v3 -n 16 pmemd.MPI -O -i ../../script/npt1_cpu.in -o npt1_cpu.out -p system_water.top -c heat.rst -r npt1_cpu.rst -inf npt1_cpu.mdinfo -ref heat.rst

