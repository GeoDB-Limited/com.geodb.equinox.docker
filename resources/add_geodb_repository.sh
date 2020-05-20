#/bin/sh

echo "Repository configuration requires 30 seconds"

LOG=false
DEBUG=false
nohup bash -c "/opt/equinox/start.sh &"
sleep 5
(
	echo "open localhost 5000"
	sleep 2
	echo "start 7"
	sleep 2
	echo "provaddrepo http://localhost:10000/repository"
	sleep 20
	echo "shutdown"
	sleep 5
) | telnet
exit 0