import prody
import numpy as np
import sys
a= prody.parsePDB('system.pdb')
a.getBetas()

f = np.loadtxt(sys.argv[1],skiprows=1)[:,0]
g = np.loadtxt(sys.argv[1],skiprows=1)[:,1]
#g1=np.where(g<0.23, g,0.23)
#g2=g1/0.23
#g2=np.where(g1>=0.11, g1,0.10)
#g2=g
indices = a.getResnums()
print(indices)
new_beta=[]
for i in f:
    for j in indices:
        if int(i)==j:
            new_beta.append(g[int(i)-1])
a.setBetas(new_beta)
a.getBetas()
prody.writePDB(sys.argv[2],a)
