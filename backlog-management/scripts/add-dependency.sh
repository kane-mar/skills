#!/usr/bin/env bash
# add-dependency.sh
# Add a dependency link between backlog items.
# Usage: ./scripts/add-dependency.sh ITEM-003 depends-on ITEM-001

set -euo pipefail

ITEM="${1:?"Usage: $0 <item> <relation> <target>"}"
RELATION="${2:?"Usage: $0 <item> <relation> <target>"}"
TARGET="${3:?"Usage: $0 <item> <relation> <target>"}"

if [ "$RELATION" != "depends-on" ] && [ "$RELATION" != "blocks" ]; then
 echo "Error: relation must be 'depends-on' or 'blocks'"
 exit 1
fi

DATE=$(date -Iseconds)

{
 echo ""
 echo "- $DATE: $ITEM $RELATION $TARGET"
} >> .backlog/DEPENDENCIES.md

echo "Recorded: $ITEM $RELATION $TARGET"
echo " Check .backlog/DEPENDENCIES.md for the full map."
