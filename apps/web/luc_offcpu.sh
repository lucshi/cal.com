#!/usr/bin/bash

# Clean before profiling
#rm -rf *.log *.dump perf.data* *.txt *.so

/root/report/node/out/Release/nodetest ../../node_modules/.bin/next start &

# echo "sleep 3s"
sleep 2

/usr/share/bcc/tools/offcputime -p `pidof nodetest` -df > offcpu.log

~/FlameGraph/flamegraph.pl --color=io --countername=us <offcpu.log >offcpu.svg


# killall nodetest