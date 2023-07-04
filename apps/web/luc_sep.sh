
#!/usr/bin/bash
sep -start -d 0 -ec "INST_RETIRED.ANY,CPU_CLK_UNHALTED.THREAD" -app /root/report/node/out/Release/nodetest -args "../../node_modules/.bin/next start" &
# echo "sleep 3s"
sleep 2


echo "client sends 100 message and wait for 1 second"
ab -n1 -c1 http://localhost:3000/apps
sleep 1
ab -n1 -c1 http://localhost:3000/apps
sleep 1
ab -n1 -c1 http://localhost:3000/apps
sleep 2

echo "client sends 100 message and wait for 1 second"
ab -n10 -c10 http://localhost:3000/apps
sleep 1
ab -n10 -c10 http://localhost:3000/apps
sleep 1
ab -n10 -c10 http://localhost:3000/apps
sleep 2

# echo "client sends 100 message and wait for 1 second"
# ab -n10 -c10 http://localhost:3000/apps
# sleep 1
# ab -n10 -c10 http://localhost:3000/apps
# sleep 1
# ab -n10 -c10 http://localhost:3000/apps
# sleep 3

sep -stop
#killall nodetests
