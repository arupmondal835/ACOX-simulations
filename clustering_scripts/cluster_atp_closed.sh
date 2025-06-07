#! /bin/bash
#ASK FOR 1 node with 8 CPUs
#SBATCH --job-name=cluster      # Job name
#SBATCH --ntasks=1                # Number of MPI ranks
#SBATCH --cpus-per-task=1            # Number of cores per MPI rank 
#SBATCH --nodes=1                    # Number of nodes
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks-per-socket=1
#SBATCH --mem-per-cpu=100gb          # Memory per processor
#SBATCH --time=4:00:00              # Time limit hrs:min:sec
#SBATCH --output=cluster%j.log     # Standard output and error log
#SBATCH  --account=alberto.perezant
#SBATCH  --qos=alberto.perezant-b
pwd; hostname; date
 





for r in 1.5
do


#generate topology

mkdir 5_Cpptraj_linkage_sieve_eps_atp_closed_all_$r
cd 5_Cpptraj_linkage_sieve_eps_atp_closed_all_$r

cpptraj ../production_1/protein.top<<EOF>&ptraj_err
trajin  ../production_1/atp_closed_5.xtc 1 1 
go
EOF


# cluster
cat<<EFO>cpptraj.in
trajin ../production_1/atp_closed_5.xtc
trajin ../production_2/atp_closed_5.xtc
trajin ../production_3/atp_closed_5.xtc
trajin ../production_4/atp_closed_5.xtc
trajin ../production_5/atp_closed_5.xtc
trajin ../production_6/atp_closed_5.xtc
trajin ../production_7/atp_closed_5.xtc
trajin ../production_8/atp_closed_5.xtc
trajin ../production_9/atp_closed_5.xtc
trajin ../production_10/atp_closed_5.xtc
trajin ../production_11/atp_closed_5.xtc
trajin ../production_12/atp_closed_5.xtc
trajin ../production_13/atp_closed_5.xtc
trajin ../production_14/atp_closed_5.xtc
trajin ../production_15/atp_closed_5.xtc
trajin ../production_16/atp_closed_5.xtc
trajin ../production_17/atp_closed_5.xtc
trajin ../production_18/atp_closed_5.xtc
trajin ../production_19/atp_closed_5.xtc
trajin ../production_20/atp_closed_5.xtc

rms PredSSE first @CA,C,N out trajrmsd.dat 
cluster hieragglo epsilon $r linkage rms :499-535,1239-1275,1004-1007 sieve 10 summary summary singlerepout representative repout unique repfmt pdb clusterout clusttraj avgout avg avgfmt pdb out frame_vs_cluster.txt
go
EFO
go
EFO

for j in 0 1 2 3 4 5 6 7 8 9 
do
    cat<<EOF>>cpptraj.in
   clear trajin
   trajin  clusttraj.c$j
   trajout clusttraj.c$j.pdb model
   average average.c$j.pdb pdb
   reference unique.c$j.pdb [uniq$j]
   rms centr$j ref [uniq$j] @CA 
   atomicfluct out back.$j.apf @C,CA,N,O byres
   go
EOF
done


cpptraj -p ../production_1/protein.top -i cpptraj.in
cd ..
done


