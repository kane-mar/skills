#!/usr/bin/env bash
# estimate.sh
# Assign or update an estimate for a backlog item.
# Usage: ./scripts/estimate.sh ITEM-003 5

set -euo pipefail

ITEM="${1:?"Usage: $0 <item-id> <estimate>"}"
ESTIMATE="${2:?"Usage: $0 <item-id> <estimate>"}"
DATE=$(date -Iseconds)

echo "Estimated $ITEM: $ESTIMATE"
echo " Logged to .backlog/REFINEMENT_LOG.md"

{
 echo ""
 echo "- $DATE: Estimated $ITEM → $ESTIMATE"
} >> .backlog/REFINEMENT_LOG.md
