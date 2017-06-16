#!/bin/bash
set -e

# do this only if we are root
if [ $EUID -eq 0 ]
then
    # to be able to use host docker daemon from container we need that docker group in the container to have the same id that docker group in host
    # to set the docker group id, use:
    # $ docker run -e "DOCKER_GROUP_ID=$(getent group docker | cut -d':' -f3)" -v /var/run/docker.sock:/var/run/docker.sock
    if [ ! "$DOCKER_GROUP_ID" ]
    then
        # set default value for my configuration if no environment variable found
        DOCKER_GROUP_ID=113
    fi
    
    echo "Changing docker group id to $DOCKER_GROUP_ID"
    groupmod --gid $DOCKER_GROUP_ID docker
fi

su jenkins <<EOF
/bin/tini -- /usr/local/bin/jenkins.sh
EOF

