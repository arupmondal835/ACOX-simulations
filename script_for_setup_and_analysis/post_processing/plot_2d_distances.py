import numpy as np
from matplotlib import pyplot as plt
from matplotlib import colors

data_dir = "/orange/alberto.perezant/arup.mondal/Collab_David/With_water/wild_type/"
all_path = ["apo_APO", "apo_water_2A", "apo_water_2B", 'holo_HOLO']
def plot_individual(path, filename2, filename1, native2, native1, yl, xl, yaxis, xaxis, title, output_prefix):
    for k in range(len(path)):
        print(path[k])
        
        # Load data
        dist1 = np.loadtxt(path[k] + '/' + filename1)[:, 1]
        dist2 = np.loadtxt(path[k] + '/' + filename2)[:, 1]
        
        # Filter data to remove the corrputed frames
        dist1[(dist1 == 0) | (dist1 > 15)] = 2
        dist2[(dist2 == 0) | (dist2 > 15)] = 2

        print(dist1.shape, dist2.shape)
        
        # Create figure
        plt.figure(figsize=(8, 8))
        plt.hist2d(dist1, dist2, bins=(100, 100), norm=colors.LogNorm(), cmap='coolwarm')
        plt.scatter(native1, native2, marker='o', color='c')
        plt.ylim(yl[0], yl[1])
        plt.xlim(xl[0], xl[1])
        plt.xlabel(xaxis, fontsize=14)
        plt.ylabel(yaxis, fontsize=14)
        plt.title(f"{title} - {path[k]}", fontsize=14)
        
        # Save the figure with a unique filename
        output_file = f"{output_prefix}_{path[k]}.pdf"
        plt.savefig(output_file)
        plt.close()  # Close figure to prevent memory issues

# Generate individual plots

plot_individual(all_path, 'fad_B_comb_4.dat', 'fad_A_comb_4.dat', 3.12, 3.16, [0, 12], [0, 12],
                'FAD Distance B (Å)', 'FAD Distance A (Å)', 'Distance FAD-B x FAD-A',
                'analysis_square_ind_4/ind_dist_2dhist_fad_fad_sel_4')

plot_individual(all_path, 'atp_B_comb_4.dat', 'atp_A_comb_4.dat', 1.58, 1.55, [0, 8], [0, 8],
                'ATP Distance B (Å)', 'ATP Distance A (Å)', 'Distance ATP-B x ATP-A',
                'analysis_square_ind_4/ind_dist_2dhist_atp_atp_sel_4')

