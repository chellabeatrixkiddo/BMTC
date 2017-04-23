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
x_s1 = []
x_s2 = []
y_d1 = []
y_d2 = []
for i in range(1, 2):
    xname = 'GMT_TIME' + str(i)
    yname = 'DISTANCE' + str(i)
    index = 0
    xdates = []
    ydist = []
    temp = []
    for element in df[xname]:
        if element == element:
            b = dt.datetime.strptime(str(element), '%H:%M:%S')
            seconds = b.hour * 3600 + b.minute * 60 + b.second
            temp.append(seconds)
            xdates.append(b)
            ydist.append(df[yname][index])
            index = index + 1
        else:
            index = index + 1
    if 1 == 1:
        x_s1 = temp
        y_d1 = ydist
    else:
        x_s2 = temp
        y_d2 = ydist
    
    yd = np.array(ydist)
    xd = np.array(xdates)     
  
    xd = mdates.date2num(xd)

    ax.set_xticks(xd)
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%H:%M:%S'))
    ax.plot_date(xd, yd, label=label_names[i-1], c=np.random.rand(3,1), linewidth=2)

plt.legend(loc='upper right');
plt.title('Distance-Time Plot')
plt.ylabel('Distance')
plt.xlabel('Time')
plt.show()

print (np.where(np.isclose(x_s1, x_s2, atol = 100) and np.isclose(y_d1, y_d2, atol = 0.03)))