#! /bin/bash -e

# start OVS
service openvswitch-switch start

# this cannot be done from the Dockerfile since we have the socket not mounted during build
set +e
echo 'Pulling the "ubuntu:trusty" and "ubuntu:xenial" image for later use...'
docker pull 'ubuntu:trusty'
docker pull 'ubuntu:xenial'
set -e

echo "Welcome to Containernet running within a Docker container ..."

if [[ $# -eq 0 ]]; then
    exec /bin/bash
else
    exec $*
fi