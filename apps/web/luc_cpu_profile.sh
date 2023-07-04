#!/usr/bin/bash

# Clean before profiling
#rm -rf *.log *.dump perf.data* *.txt *.so

/root/report/node/out/Release/nodetest --cpu-prof --cpu-prof-interval=1 ../../node_modules/.bin/next start &

# echo "sleep 3s"
sleep 2

# echo "client sends 1 message and wait for 1 second"
# ab -n1 -c1 http://localhost:3000/apps
# sleep 3

echo "client sends 100 message and wait for 1 second"
ab -k -n1 -c1 http://localhost:3000/apps
sleep 1
ab -k -n1 -c1 http://localhost:3000/apps
sleep 1
ab -k -n1 -c1 http://localhost:3000/apps
sleep 2

echo "client sends 100 message and wait for 1 second"
ab -k -n10 -c10 http://localhost:3000/apps
sleep 1
ab -k -n10 -c10 http://localhost:3000/apps
sleep 1
ab -k -n10 -c10 http://localhost:3000/apps
sleep 2

# echo "client sends 100 message and wait for 1 second"
# ab -n10 -c10 http://localhost:3000/apps
# sleep 1
# ab -n10 -c10 http://localhost:3000/apps
# sleep 1
# ab -n10 -c10 http://localhost:3000/apps
# sleep 3

killall nodetest
