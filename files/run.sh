#!/bin/sh

if [ -z "$DOCKER_HOST_IP" ]
then
	DOCKER_HOST_IP_LINUX=$(ip route|awk '/default/ { print $3 }')
	DOCKER_HOST_IP_MAC=$(dig +short host.docker.internal)
	DOCKER_HOST_IP=${DOCKER_HOST_IP_MAC:-$DOCKER_HOST_IP_LINUX}
fi

echo "Host IP: ${DOCKER_HOST_IP}"
/usr/local/bin/dronekit-sitl copter-3.3 &
mavproxy.py --master tcp:127.0.0.1:5760 --sitl 127.0.0.1:5501 --out ${DOCKER_HOST_IP}:14550 --out vehicle-mavlink:14590
