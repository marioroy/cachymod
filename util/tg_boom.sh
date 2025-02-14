#!/bin/bash

if [ ! -x "./tg_boom" ]; then
  echo "Oops! Build first 'tg_boom' and try again"
  echo "E.g. gcc -o tg_boom -pthread tg_boom.c"
  echo
  exit 1
fi

# Each "tg_boom -j8 -l6" command does 150000+ tasks.
# Anything above your NCPUs are skipped.

ncpus=$(nproc)
if [ "$ncpus" -ge 4 ]; then
  taskset -c 0-3 ./tg_boom -j8 -l6 &
else
  ./tg_boom -j8 -l6 &
fi

 [ "$ncpus" -ge  8 ] && taskset -c   4-7 ./tg_boom -j8 -l6 &
 [ "$ncpus" -ge 12 ] && taskset -c  8-11 ./tg_boom -j8 -l6 &
 [ "$ncpus" -ge 16 ] && taskset -c 12-15 ./tg_boom -j8 -l6 &
 [ "$ncpus" -ge 20 ] && taskset -c 16-19 ./tg_boom -j8 -l6 &
 [ "$ncpus" -ge 24 ] && taskset -c 20-23 ./tg_boom -j8 -l6 &
 [ "$ncpus" -ge 28 ] && taskset -c 24-27 ./tg_boom -j8 -l6 &
 [ "$ncpus" -ge 32 ] && taskset -c 28-31 ./tg_boom -j8 -l6 &
#[ "$ncpus" -ge 36 ] && taskset -c 32-35 ./tg_boom -j8 -l6 &
#[ "$ncpus" -ge 40 ] && taskset -c 36-39 ./tg_boom -j8 -l6 &
#[ "$ncpus" -ge 44 ] && taskset -c 40-43 ./tg_boom -j8 -l6 &
#[ "$ncpus" -ge 48 ] && taskset -c 44-47 ./tg_boom -j8 -l6 &
#[ "$ncpus" -ge 52 ] && taskset -c 48-51 ./tg_boom -j8 -l6 &
#[ "$ncpus" -ge 56 ] && taskset -c 52-55 ./tg_boom -j8 -l6 &
#[ "$ncpus" -ge 60 ] && taskset -c 56-59 ./tg_boom -j8 -l6 &
#[ "$ncpus" -ge 64 ] && taskset -c 60-63 ./tg_boom -j8 -l6 &

wait

