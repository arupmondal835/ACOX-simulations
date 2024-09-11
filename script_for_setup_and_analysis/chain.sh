#!/bin/bash

script=../../script/cpu.sh

PID=$(sbatch $script|awk '{print $NF}')
echo $PID

script=../../script/heat.sh

PID_3=$(sbatch --dependency=afterany:$PID  $script| awk '{print $NF}')
echo $PID_3

script=../../script/npt_cpu.sh

PID_4=$(sbatch --dependency=afterany:$PID_3  $script| awk '{print $NF}')
echo $PID_4



script=../../script/md.sh

PID_5=$(sbatch --dependency=afterany:$PID_4  $script| awk '{print $NF}')
echo $PID_5
