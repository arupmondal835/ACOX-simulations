#!/bin/bash
#SBATCH --job-name=7kjr-cpu
#SBATCH --output=7kjr-cpu.out
#SBATCH --error=7kjr-cpu.err
#SBATCH --mail-type=ALL
#SBATCH --time=5:00:00
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
srun --mpi=pmix_v3 -n 16 pmemd.MPI -O -i ../../script/min1.in -o min1.out -p system_water.top -c system_water.mdcrd -r min1.rst -inf min1.mdinfo -ref system_water.mdcrd
srun --mpi=pmix_v3 -n 16 pmemd.MPI -O -i ../../script/min2.in -o min2.out -p system_water.top -c min1.rst -r min2.rst -inf min2.mdinfo -ref min1.rst
srun --mpi=pmix_v3 -n 16 pmemd.MPI -O -i ../../script/min3.in -o min3.out -p system_water.top -c min2.rst -r min3.rst -inf min3.mdinfo -ref min2.rst
srun --mpi=pmix_v3 -n 16 pmemd.MPI -O -i ../../script/min4.in -o min4.out -p system_water.top -c min3.rst -r min4.rst -inf min4.mdinfo -ref min3.rst
srun --mpi=pmix_v3 -n 16 pmemd.MPI -O -i ../../script/min5.in -o min5.out -p system_water.top -c min4.rst -r min5.rst -inf min5.mdinfo -ref min4.rst
srun --mpi=pmix_v3 -n 16 pmemd.MPI -O -i ../../script/min6.in -o min6.out -p system_water.top -c min5.rst -r min6.rst -inf min6.mdinfo
