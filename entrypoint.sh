#!/bin/sh -eu

# This is the entrypoint script for the dockerfile. Executed in the
# container at runtime.  Based on dockcross.

if [ $# -eq 0 ]; then
    # Presumably the image has been run directly, so help the user get
    # started by outputting the dockcross script
    cat /fzn-or-tools/fzn-or-tools.sh
    exit 0
fi

# If we are running docker natively, we want to create a user in the container
# with the same UID and GID as the user on the host machine, so that any files
# created are owned by that user. Without this they are all owned by root.
# The dockcross script sets the FZNORTOOLS_UID and FZNORTOOLS_GID vars.
FZNORTOOLS_USER=${FZNORTOOLS_USER:-""}
FZNORTOOLS_UID=${FZNORTOOLS_UID:-""}
FZNORTOOLS_GROUP=${FZNORTOOLS_GROUP:-""}
FZNORTOOLS_GID=${FZNORTOOLS_GID:-""}
if [ -n "$FZNORTOOLS_UID" ] && [ -n "$FZNORTOOLS_GID" ] && [ -n "$FZNORTOOLS_GROUP" ]; then

    addgroup -g "$FZNORTOOLS_GID" "$FZNORTOOLS_GROUP"
    adduser -g "" -D -G "$FZNORTOOLS_GROUP" -u "$FZNORTOOLS_UID" "$FZNORTOOLS_USER"
    export HOME=/home/"${FZNORTOOLS_USER}"
    chown -R "$FZNORTOOLS_UID:$FZNORTOOLS_GID" "$HOME"

    # Enable passwordless sudo capabilities for the user
    chown "root:$FZNORTOOLS_GID" "$(command -v su-exec)"
    chmod +s "$(command -v su-exec)"; sync

    # Run the command as the specified user/group.
    exec su-exec "$FZNORTOOLS_UID:$FZNORTOOLS_GID" "$@"
else
    # Just run the command as root.
    exec "$@"
fi
