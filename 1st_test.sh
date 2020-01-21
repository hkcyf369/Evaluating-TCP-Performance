#!/bin/bash
for i in {0..100000..5000}
do
  bash ~/cs925/A5/set-net-storm-a5.sh 2000 $i 1000000 > /dev/null

  iperf -y c -c 10.4.0.2 -n 10M >> ~/cs925/A5/100DHL_Cubic.txt

done