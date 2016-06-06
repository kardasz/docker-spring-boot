#!/bin/bash
set -e

if [ "$1" = 'java' ]; then
    if [ -z "$(getent passwd $RUN_USER)" ]; then
      echo "Creating user $RUN_USER:$RUN_GROUP"

      groupadd --gid ${RUN_GROUP_GID} -r ${RUN_GROUP} && \
      useradd -r --uid ${RUN_USER_UID} -g ${RUN_GROUP} -d /home/${RUN_USER} ${RUN_USER}
    fi

	exec gosu "${RUN_USER}:${RUN_GROUP}" "$@"
fi

exec "$@"
