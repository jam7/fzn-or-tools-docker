#!/bin/sh -eu

CMD="/usr/local/bin/fzn-or-tools"
INIT="--init"
TTY=""

case $# in
0) ;;
*) case .$1 in
   .*sh|.*bash) CMD=""; INIT=""; TTY="-ti";;
   esac
   ;;
esac

exec docker run $TTY $INIT --rm \
    -v "$PWD":/work \
    -v /tmp:/tmp \
    -e FZNORTOOLS_UID="$( id -u )" \
    -e FZNORTOOLS_GID="$( id -g )" \
    -e FZNORTOOLS_USER="$( id -un )" \
    -e FZNORTOOLS_GROUP="$( id -gn )" \
    jam7/fzn-or-tools "$CMD" "$@"
