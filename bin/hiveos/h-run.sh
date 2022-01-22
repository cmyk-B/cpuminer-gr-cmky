#!/usr/bin/env bash

while true; do
	for con in `netstat -anp | grep TIME_WAIT | grep 4048 | awk '{print $5}'`; do
		killcx $con lo
	done
	netstat -anp | grep TIME_WAIT | grep 4048 &&
		continue ||
		break
done


cd /hive/miners/custom/cpuminer-gr-cmky/
./cpuminer.sh
