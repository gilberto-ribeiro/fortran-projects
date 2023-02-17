import numpy as np

with open('tsunami_output.dat', 'r') as file:
    data = [row.strip().split()[1:] for row in file]
    file.close()

data = np.array(data)
data = np.transpose(data)
# data = list(data)

x = list(range(1, 100+1))

with open('tsunami_output_gnuplot.dat', 'w') as file:
    for i, row in zip(x, data):
        # row = list(row)
        row = str(i)+' '+' '.join(row)+'\n'
        file.write(row)
    file.close()