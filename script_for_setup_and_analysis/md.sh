#!/bin/bash
#SBATCH --job-name=7kj2_md
#SBATCH --output=7kjr_md.out
#SBATCH --error=7kjr_md.err
#SBATCH --mail-type=ALL
#SBATCH --time=7-00:00:00
#SBATCH --ntasks=1
#SBATCH --distribution=cyclic:cyclic
#SBATCH --mem-per-cpu=10000mb
#SBATCH --account=alberto.perezant
#SBATCH --cpus-per-gpu=1
#SBATCH --gpus-per-task=1
#SBATCH --partition=gpu
#SBATCH --constraint=a100
module purge
#module load cuda/10.0.130
#module load intel/2018.1.163
#module load openmpi/4.0.3
#module load amber/20
module load cuda/11.1.0  nvhpc/20.11  openmpi/4.0.5 amber/20


#pmemd.cuda -O -i ../../script/npt1.in -o npt1.out -p system_water.top -c npt1_cpu.rst -r npt1.rst -x npt1.nc -inf npt1.mdinfo -ref npt1_cpu.rst
#pmemd.cuda -O -i ../../script/npt2.in -o npt2.out -p system_water.top -c npt1.rst -r npt2.rst -x npt2.nc -inf npt2.mdinfo -ref npt1.rst
pmemd.cuda -O -i ../../script/md.in -o md.out -p system_hmass.top -c npt2.rst -r md.rst -x md.nc -inf md.mdinfo -ref npt2.rst
