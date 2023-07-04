
#!/usr/bin/bash


echo "client sends 100 message and wait for 1 second"
ab -n1 -c1 http://localhost:3000/apps
sleep 1
ab -n1 -c1 http://localhost:3000/apps
sleep 1
ab -n1 -c1 http://localhost:3000/apps
sleep 3

echo "client sends 100 message and wait for 1 second"
ab -n10 -c10 http://localhost:3000/apps
sleep 1
ab -n10 -c10 http://localhost:3000/apps
sleep 1
#ab -n10 -c10 http://localhost:3000/apps
#sleep 3

# echo "client sends 100 message and wait for 1 second"
# ab -n10 -c10 http://localhost:3000/apps
# sleep 1
# ab -n10 -c10 http://localhost:3000/apps
# sleep 1
# ab -n10 -c10 http://localhost:3000/apps
# sleep 3

