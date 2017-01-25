import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from datetime import datetime

np.seterr(invalid='ignore')

df = pd.read_excel("/Users/Admin/Documents/M.Tech/BMTC/Data/356cw_all_buses_data/all_distances_text.xlsx","Sheet2")

label_names = ['150218505', '150218641', '150218990', '150219795', '150220000', '150220082', '150220187', '150220249', '150220285', '150220937', '150221135', '150218093', '150813511', '150814233', '150814324']
fig = plt.figure()
ax = fig.add_subplot(1,1,1)

for i in range(1, 16):
    col_name = 'GMT_TIME' + str(i)
    df[col_name] = (pd.to_datetime(df[col_name], infer_datetime_format='True')).astype(datetime)

for i in range(1, 2):
    xname = 'DISTANCE' + str(i)
    yname = 'GMT_TIME' + str(i)
    ax.plot(df[xname], df[yname], label=label_names[i-1], c=np.random.rand(3,1), linewidth=2)

plt.legend(loc='upper right');
plt.title('Distance-Time Plot')
plt.xlabel('Distance')
plt.ylabel('Time')
plt.show()
