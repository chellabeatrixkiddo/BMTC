import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.dates as mdates
import datetime as dt
from mpl_toolkits.mplot3d import Axes3D
from functools import partial

np.seterr(invalid='ignore')
        
df = pd.read_excel("/Users/Admin/Documents/M.Tech/BMTC/data/all_distances_text.xlsx","Sheet1")

label_names = ['150219795', '150220000', '150220187', '150220249']
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

for i in range(1, 5):
    xname = label_names[i-1] + '_LAT'
    yname = label_names[i-1] + '_LONG'
    zname = label_names[i-1] + '_TIME_SECS'
    ax.scatter(df[xname], df[yname], df[zname], label = label_names[i-1], c=np.random.rand(3,1))
    

plt.legend(loc='upper right');
plt.title('Lat-Long-Time Plot')
ax.set_xlabel('Latitude')
ax.set_ylabel('Longitude')
ax.set_zlabel('Time')
plt.show()
