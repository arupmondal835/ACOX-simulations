import mdtraj as md
traj=md.load('protein.xtc', top='protein.prmtop')
if len(traj)>20000:
    traj=traj[:20000]
else:
    traj=traj

pair=[]
for i in range(499,535):
    for j in list(range(1239,1248))+list(range(1256,1275))+list(range(1004,1007)):
        pair.append([i,j])
dist=md.compute_contacts(traj,contacts=pair,scheme='closest')[0]
dist_min=dist.min(axis=1)
f=open('atp_A_min_dist.dat','w')
for i in range(len(dist_min)):
    f.write('{} {}\n'.format(i+1, dist_min[i]*10))
f.close()

pair=[]
#resid 1168 to 1203 572 to 580 589 to 607 337 to 339 
for i in range(1167,1203):
    for j in list(range(571,580))+list(range(588,607))+list(range(336,339)):
        pair.append([i,j])
dist=md.compute_contacts(traj,contacts=pair,scheme='closest')[0]
dist_min=dist.min(axis=1)
f=open('atp_B_min_dist.dat','w')
for i in range(len(dist_min)):
    f.write('{} {}\n'.format(i+1, dist_min[i]*10))
f.close()


pair=[]
#resid 1168 to 1203 572 to 580 589 to 607 337 to 339 
for i in range(155,159):
    for j in range(431,435):
        pair.append([i,j])
dist=md.compute_contacts(traj,contacts=pair,scheme='closest')[0]
dist_min=dist.min(axis=1)
f=open('fad_A_min_dist.dat','w')
for i in range(len(dist_min)):
    f.write('{} {}\n'.format(i+1, dist_min[i]*10))
f.close()

pair=[]
#resid 1168 to 1203 572 to 580 589 to 607 337 to 339 
for i in range(823,827):
    for j in range(1099,1103):
        pair.append([i,j])
dist=md.compute_contacts(traj,contacts=pair,scheme='closest')[0]
dist_min=dist.min(axis=1)
f=open('fad_B_min_dist.dat','w')
for i in range(len(dist_min)):
    f.write('{} {}\n'.format(i+1, dist_min[i]*10))
f.close()


