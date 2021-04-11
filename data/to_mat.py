import glob
import numpy as np
from tqdm import tqdm
from scipy.io import savemat

data = []

for i, fpath in enumerate(tqdm(glob.glob("pointsets/*.txt"))):
    temp = np.loadtxt(
            fpath, 
            dtype = np.float32, 
            comments = "#", 
            usecols = (0, 2, 3, 4, 5, 6)
        )
    temp = temp.T # 5x58
    if temp.shape == (6, 58):
        temp[2, :] = -1*temp[2, :]
        data.append(temp)

data = np.array(data)
data = np.moveaxis(data, 0, -1)

mdic = {"shapes" : data}
savemat("../faces2D.mat", mdic)