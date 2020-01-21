import sys
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

XQ = []                              # the x axis
x=0
'''for i in range (52):
    XQ.append(x)
    x+=0.02'''
'''for i in range (10):
    XQ.append(x)
    x+=1'''
for i in range (20):
    XQ.append(x)
    x+=0.5

y = np.genfromtxt(sys.argv[1])
z = np.genfromtxt(sys.argv[2])
k = np.genfromtxt(sys.argv[3])
i = np.genfromtxt(sys.argv[4])
j = np.genfromtxt(sys.argv[5])
#eighty = np.genfromtxt(sys.argv[6])
#full = np.genfromtxt(sys.argv[7])



y = (y/1000000000)*100  #make it to %
z = (z/1000000000)*100  #make it to %
k = (k/1000000000)*100  #make it to %
i = (i/1000000000)*100  #make it to %
j = (j/1000000000)*100  #make it to %
#eighty = (eighty/1000000000)*100  #make it to %
#full = (full/1000000000)*100  #make it to %



#YQ = y[0:52]
#ZQ = z[0:52]
#KQ = k[0:52]
YQ=y[0:20]
ZQ=z[0:20]
KQ=k[0:20]
IQ=i[0:20]
JQ=j[0:20]
#EQ=eighty[0:20]
#FQ=full[0:20]



figure = plt.figure()
bottom, top = plt.ylim()
plt.ylim(bottom, top)
plt.ylim(top=100)
plt.ylim(bottom=0)

axes = figure.gca()
axes.plot(XQ ,YQ) #line with no latency/ 1M bandwidth
axes.plot(XQ ,ZQ) #line with 0.1ms latency/ 10M bandwidth
axes.plot(XQ ,KQ) #line with 1ms latency / 100M bandwidth
axes.plot(XQ ,IQ) #line with 1ms latency / 100M bandwidth
axes.plot(XQ ,JQ) #line with 1ms latency / 100M bandwidth
#axes.plot(XQ ,EQ) #line with 1ms latency / 100M bandwidth
#axes.plot(XQ ,FQ) #line with 1ms latency / 100M bandwidth


axes.set_xlabel('Loss(%)')
axes.set_ylabel('Throughput rate(%)')
plt.legend (['0%','25%', '50%', '75%',"100%"])
#plt.title('Test with different bandwidth numbers and 0.01ms latency')
plt.savefig("Cubic3rd.png")
    