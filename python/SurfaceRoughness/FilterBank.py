"""Produce custom labelling for a colorbar.

Contributed by Scott Sinclair
"""

import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm
from numpy.random import randn
from Tools import LoadMel

numFeatures=12
Mel = LoadMel('data/vc_186_f_015_ap_015-1.mel', numFeatures)
Mel_max = np.max(Mel)
Mel_min = np.min(Mel)

# Make plot with vertical (default) colorbar
fig, ax = plt.subplots()

# data = np.clip(randn(250, 250), -1, 1)
# print(len(data))

data = np.clip(Mel.transpose(), Mel_min, Mel_max)
print(len(data))
cax = ax.imshow(data, interpolation='nearest')
ax.set_title('Gaussian noise with vertical colorbar')

# Add colorbar, make sure to specify tick locations to match desired ticklabels
# cbar = fig.colorbar(cax, ticks=[-1, 0, 1])
# cbar.ax.set_yticklabels(['< -1', '0', '> 1'])  # vertically oriented colorbar

# Make plot with horizontal colorbar
# fig, ax = plt.subplots()
# 
# data = np.clip(randn(250, 250), -1, 1)
# 
# cax = ax.imshow(data, interpolation='nearest')
# ax.set_title('Gaussian noise with horizontal colorbar')
# 
# cbar = fig.colorbar(cax, ticks=[-1, 0, 1], orientation='horizontal')
# cbar.ax.set_xticklabels(['Low', 'Medium', 'High'])  # horizontal colorbar

plt.show()