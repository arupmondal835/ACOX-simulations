#!/bin/bash

script=../../script/heat.sh

PID=$(sbatch $script|awk '{print $NF}')
echo $PID

script=../../script/npt_cpu.sh

PID_3=$(sbatch --dependency=afterany:$PID  $script| awk '{print $NF}')
echo $PID_3

script=../../script/md2.sh

PID_4=$(sbatch --dependency=afterany:$PID_3  $script| awk '{print $NF}')
echo $PID_4



