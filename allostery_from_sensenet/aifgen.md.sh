#!/bin/bash
#SBATCH --job-name=min      # Job name
#SBATCH --mail-type=END,FAIL         # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=arup.mondal@chem.ufl.edu    # Where to send mail
#SBATCH --ntasks=1                  # Number of MPI ranks
#SBATCH --cpus-per-task=1            # Number of cores per MPI rank 
#SBATCH --partition=hpg2-compute   #For intel nodes
#SBATCH --nodes=1                    # Number of nodes
#SBATCH --ntasks-per-node=1       # How many tasks on each node
#SBATCH --ntasks-per-socket=1        # How many tasks on each CPU or socket
#SBATCH --distribution=cyclic:cyclic # Distribute tasks cyclically on nodes and sockets
#SBATCH --mem-per-cpu=100gb          # Memory per processor
#SBATCH --time=1:00:00              # Time limit hrs:min:sec
#SBATCH --output=min%j.log     # Standard output and error log
#SBATCH  --qos=alberto.perezant
pwd; hostname; date



# Requires Java JRE 8 or later to be installed
# Invoke java -jar aifgen.jar -h or java -jar aifgen.jar <MODE> -h for full list of command line options
# import_cpptraj_hbonds
## hbonds.out: Path to cpptraj hbond 'avgout' file
## hbonds.series: Path to cpptraj hbond 'series uuseries' file
# import_cpptraj_contacts
## contacts.out: Path to cpptraj nativecontacts 'writecontacts' file
## contacts.native.series: Path to cpptraj nativecontacts 'series seriesout' file
## contacts.nonnative.series: Path to cpptraj nativecontacts 'savenonnative seriesnnout' file
## contacts.pdb: Path to cpptraj nativecontacts 'contactpdb' file
## --ignoreIntraResidue: Ignore interactions within the same residue
# network.md.zaif: Output zipped .aif file
module purge
module load java

java -jar /orange/alberto.perezant/arup.mondal/Collab_David/Allosteric_network/SenseNet/AIFgen/aifgen-1.0.9.jar import_cpptraj_hbonds --out hbonds.out --series hbonds.series import_cpptraj_contacts --out contacts.out --nativeSeries contacts.series --nonNativeSeries contacts.nonnative.series --pdb contacts.pdb --ignoreIntraResidue export_zaif -o network.md.zaif
