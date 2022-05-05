#!/bin/bash -eu

CMD="/usr/local/bin/fzn-or-tools"
INIT="--init"
TTY=""
ENVS=()

case $# in
0) ;;
*) case .$1 in
   .*sh|.*bash) CMD="$1"; shift; INIT=""; TTY="-ti";;
   esac
   ;;
esac

case "$CMD" in
/bin/sh) ;; # Run /bin/sh as an administrator
*) ENVS+=("-e" FZNORTOOLS_UID="$( id -u )")
   ENVS+=("-e" FZNORTOOLS_GID="$( id -g )")
   ENVS+=("-e" FZNORTOOLS_USER="$( id -un )")
   ENVS+=("-e" FZNORTOOLS_GROUP="$( id -gn )")
   ;;
esac

exec docker run $TTY $INIT --rm \
    -v "$PWD":/work \
    -v /tmp:/tmp \
    "${ENVS[@]}" \
    jam7/fzn-or-tools "$CMD" "$@"
