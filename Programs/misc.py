import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from functools import partial

to_datetime_fmt = partial(pd.to_datetime, format='%H:%M:%S')

df = pd.read_excel("/Users/Admin/Documents/M.Tech/BMTC/Data/356cw_all_buses_data/all_distances_text.xlsx","Sheet2")


fig = plt.figure()
ax = fig.add_subplot(1,1,1)


df.GMT_TIME1 = df.GMT_TIME1.apply(to_datetime_fmt)

print (df.GMT_TIME1.dtype)
ax.plot_date(df['DISTANCE1'], df['GMT_TIME1'], label='150218505', c=np.random.rand(3,1))

plt.legend(loc='upper right');

plt.title('Distance-Time Plot')
plt.xlabel('Distance')
plt.ylabel('Time')
plt.show()
