# ACOX-simulations
Setup and analysis scripts for ACOX simulations
-----------------------------------------------
*Initial_models/* directory has modeled starting conformations for 4 systems - apo, holo, apo 2A, and apo 2B.

*parameter/* directory contains the custom parameters for FAD and ATP (obtained from the AMBER parameter database).

*script_for_setup_and_analysis/* directory has the AMBER simulation scripts with a chain.sh file to submit the stepwise jobs as dependent jobs. Under this folder *post_processing/* directory has the post processing scripts for stripping and autoimaging the trajectory, calculating binding sitde distance for each frames using MDTraj, and plotting the 2D distance plots. 

*clustering_scripts/* directory has the clustering scripts used to cluster difference subsets of the frames to select the most representative conformation representing open/closed state for ATP/FAD sites. 

*open_state/* and *closed_states/* directories have the centroid of the top populated clusters from the clustering analysis. These are the representative structures used in the manuscript.

*allostery_from_sensenet/* has scripts necessary for building the allosteric networks as well as the allosteric correlation values (csv) and the pdbs with correlation values as the beta values. 
