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

label_names = ['150219795', '150220000', '150220187', '150220249', '150218505', '150218641', '150218990', '150220082', '150220285', '150220937', '150221135', '150218093', '150813511', '150814233', '150814324']
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

xvalues = []
yvalues = []
zvalues = []

for i in range(1, 16):
    xname = label_names[i-1] + '_LAT'
    yname = label_names[i-1] + '_LONG'
    zname = label_names[i-1] + '_TIME'
    xvalues.clear()
    yvalues.clear()
    zvalues.clear()
    index = 0
    for element in df[zname]:
        if element == element:
            b = dt.datetime.strptime(str(element), '%H:%M:%S')
            zvalues.append(b)
            xvalues.append(df[xname][index])
            yvalues.append(df[yname][index])
            index = index + 1
        else:
            index = index + 1
    
    xarray = np.array(xvalues)  
    yarray = np.array(yvalues)   
    zarray = np.array(zvalues)
    
    zarray = mdates.date2num(zarray)

    ax.set_zticks(zarray)
    ax.zaxis.set_major_formatter(mdates.DateFormatter('%H:%M:%S'))
    ax.scatter(xarray, yarray, zarray, label = label_names[i-1], c=np.random.rand(3,1))
    

plt.legend(loc='upper right');
plt.title('Lat-Long-Time Plot')
ax.set_xlabel('Latitude')
ax.set_ylabel('Longitude')
ax.set_zlabel('Time')
plt.show()
