#18.6, 18.58, 9.18,9.07

import numpy as np
from matplotlib import pyplot as plt
from matplotlib import colors
import seaborn as sns
import glob

#legend=['wt_apo','wt_holo','cat_mut_holo','atp_mut_holo','fad_mut_holo']

#path=['wild_type/apo/','wild_type/holo/','mutant/holo/cat_site/','mutant/holo/atp_site/','mutant/holo/fad_site/']
path1=glob.glob('wild_type/apo*')
path2=glob.glob('wild_type/ATP*')
path3=glob.glob('wild_type/holo*')
path4=glob.glob('mutant/holo*/*site*')
path5=glob.glob('mutant/apo*/*site*')
all_path=(path1+path2+path3+path4+path5)
all_path.sort()
#path_gaff= [element for element in all_path if '_2' not in element]
#path_heather= [element for element in all_path if '_2' in element]

#print(path_gaff)
#print(path_heather)
print(all_path)
print(len(all_path))
def plot_all(path,filename1, filename2, native1, native2,yl, xl, xaxis, yaxis,x,output):
    #fig, axs = plt.subplots(4,8, sharex='col',sharey='row')
    #fig.set_figheight(15)
    #fig.set_figwidth(35)
    plt.figure()
    #plt.subplots_adjust(hspace=0.001,wspace=0.001)
    #for i in range(4):
     #   for j in range(8):
      #      k=8*i+j
       #     if k < 32:
    dist1=np.loadtxt(path+'/'+filename1)[:60000,1]
    dist2=np.loadtxt(path+'/'+filename2)[:60000,1]
    plt.hist2d(dist1,dist2,bins=(100,100),norm = colors.LogNorm(),cmap='coolwarm')
    plt.scatter(native1,native2, marker='o', color='c')
    plt.ylim(yl[0],yl[1])
    plt.xlim(xl[0],xl[1])
    plt.title(path)
    #axs[len(path)-1].set_xlabel('Distance ($Å$)')  
    #plt.xlim(0,30)
    plt.xlabel(xaxis)
    plt.ylabel(yaxis)
    #axs[0,2].set_title(x)
    plt.savefig(path +'/'+ '_'.join(path.split("/"))+'_'+output)   
    print(path)   
for i in all_path:
    plot_all(i,'atp_A_min_dist_2.dat', 'fad_A_min_dist_2.dat', 1.55, 3.16,[0,15],[0,8],'ATP Distance A ($Å$)', 'FAD Distance A ($Å$)','Distance ATP-A x FAD-A','ATP_FAD_A.pdf')
    plot_all(i,'atp_B_min_dist_2.dat','fad_B_min_dist_2.dat', 1.58,3.12, [0,15],[0,8],'ATP Distance B ($Å$)', 'FAD Distance B ($Å$)','Distance ATP-B x FAD-B','ATP_FAD_B.pdf')
    plot_all(i,'atp_A_min_dist_2.dat', 'atp_B_min_dist_2.dat', 1.55, 1.58,[0,8],[0,8],'ATP Distance A ($Å$)', 'ATP Distance B ($Å$)','Distance ATP-A x ATP-B','ATP_ATP.pdf')
    plot_all(i,'fad_A_min_dist_2.dat','fad_B_min_dist_2.dat', 3.16,3.12, [0,12],[0,12],'FAD Distance A ($Å$)', 'FAD Distance B ($Å$)','Distance FAD-A x FAD-B','FAD_FAD.pdf')

