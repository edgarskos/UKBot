#!/bin/sh

rm plots/$UKLANG.mem.png
rm logs/$UKLANG.mem.log

echo "Plotting $UKLANG..." | tee mem_plotter.log
while true; do  
  procid=`id -u | xargs ps -u | grep python | awk '{print $1}'`
  test -n "$procid" && {
  	#echo "python process found"
  	ps -p $procid -o vsz -o pmem | grep -v VSZ >> logs/$UKLANG.mem.log
  }
  test -z "$procid" && {
  	#echo "python process ended"
  	break
  }
  gnuplot mem_plotter.gnuplot 2>&1 | tee -a mem_plotter.log
  sleep 1
done &
