#!/bin/bash

if [ ! -x "./topo_boom" ]; then
  echo "Oops! Build first 'topo_boom' and try again"
  echo "E.g. gcc -o topo_boom topo_boom.c"
  echo
  exit 1
fi

# Each "topo_boom -j8 -l6" command does 150000+ tasks.
# Anything above your NCPUs are skipped.

ncpus=$(nproc)
if [ "$ncpus" -ge 4 ]; then
  taskset -c 0-3 ./topo_boom -j8 -l6 &
else
  ./topo_boom -j8 -l6 &
fi

 [ "$ncpus" -ge  8 ] && taskset -c   4-7 ./topo_boom -j8 -l6 &
 [ "$ncpus" -ge 12 ] && taskset -c  8-11 ./topo_boom -j8 -l6 &
 [ "$ncpus" -ge 16 ] && taskset -c 12-15 ./topo_boom -j8 -l6 &
 [ "$ncpus" -ge 20 ] && taskset -c 16-19 ./topo_boom -j8 -l6 &
 [ "$ncpus" -ge 24 ] && taskset -c 20-23 ./topo_boom -j8 -l6 &
 [ "$ncpus" -ge 28 ] && taskset -c 24-27 ./topo_boom -j8 -l6 &
 [ "$ncpus" -ge 32 ] && taskset -c 28-31 ./topo_boom -j8 -l6 &
#[ "$ncpus" -ge 36 ] && taskset -c 32-35 ./topo_boom -j8 -l6 &
#[ "$ncpus" -ge 40 ] && taskset -c 36-39 ./topo_boom -j8 -l6 &
#[ "$ncpus" -ge 44 ] && taskset -c 40-43 ./topo_boom -j8 -l6 &
#[ "$ncpus" -ge 48 ] && taskset -c 44-47 ./topo_boom -j8 -l6 &
#[ "$ncpus" -ge 52 ] && taskset -c 48-51 ./topo_boom -j8 -l6 &
#[ "$ncpus" -ge 56 ] && taskset -c 52-55 ./topo_boom -j8 -l6 &
#[ "$ncpus" -ge 60 ] && taskset -c 56-59 ./topo_boom -j8 -l6 &
#[ "$ncpus" -ge 64 ] && taskset -c 60-63 ./topo_boom -j8 -l6 &

wait

