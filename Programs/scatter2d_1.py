import matplotlib
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.dates as mdates
import datetime as dt
from functools import partial

np.seterr(invalid='ignore')
        
df = pd.read_excel("/Users/Admin/Documents/M.Tech/BMTC/Data/356cw_all_buses_data/all_distances_text.xlsx","Sheet2")

label_names = ['150218505', '150218641', '150218990', '150219795', '150220000', '150220082', '150220187', '150220249', '150220285', '150220937', '150221135', '150218093', '150813511', '150814233', '150814324']
fig = plt.figure()
ax = fig.add_subplot(1,1,1)

#df.GMT_TIME1 = df.GMT_TIME1.apply(lambda e: if e == e: dt.datetime.strptime(str(e), '%H:%M:%S'))
#dt.datetime.fromordinal(733828)
index = 0
ydates = []
xdist = []
for element in df.GMT_TIME1:
    if element == element:
        b = dt.datetime.strptime(str(element), '%H:%M:%S')
        ydates.append(b)
        xdist.append(df.DISTANCE1[index])
        index = index + 1
    else:
        index = index + 1

xd = np.array(xdist)
yd = np.array(ydates)     

print (yd[0:5]) 
yd = mdates.date2num(yd)

print (yd[0:5])

ax.set_xticks(yd)
ax.xaxis.set_major_formatter(mdates.DateFormatter('%H:%M:%S'))
ax.plot_date(yd, xd, label='150218505', c=np.random.rand(3,1), linewidth=2)

plt.legend(loc='upper right');
plt.title('Distance-Time Plot')
plt.xlabel('Distance')
plt.ylabel('Time')
plt.show()





