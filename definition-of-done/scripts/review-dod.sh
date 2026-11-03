#!/usr/bin/env bash
# review-dod.sh
# Log a DoD review or update.
# Usage: ./scripts/review-dod.sh "Added security review criterion. Removed outdated browser test."

set -euo pipefail

NOTES="${1:?"Usage: $0 <review-notes>"}"
DATE=$(date -Iseconds)

{
 echo ""
 echo "## Review — $DATE"
 echo ""
 echo "$NOTES"
} >> .dod/REVIEW_LOG.md

# Update the last reviewed date in DEFINITION_OF_DONE.md (portable: no sed -i dependency)
if [ -f DEFINITION_OF_DONE.md ]; then
  TMP=$(mktemp)
  while IFS= read -r line; do
    case "$line" in
      _Last\ reviewed:*) printf '_Last reviewed: %s_\n' "${DATE:0:10}" ;;
      *) printf '%s\n' "$line" ;;
    esac
  done < DEFINITION_OF_DONE.md > "$TMP"
  mv "$TMP" DEFINITION_OF_DONE.md
fi

echo "DoD review logged: $NOTES"
echo " Logged in .dod/REVIEW_LOG.md"
