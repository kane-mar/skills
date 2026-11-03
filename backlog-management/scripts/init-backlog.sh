#!/usr/bin/env bash
# init-backlog.sh
# Initialize the backlog management structure.
# Usage: ./scripts/init-backlog.sh

set -euo pipefail

DATE=$(date -Iseconds)

echo "Initializing backlog management structure..."

mkdir -p .backlog/ITEMS .backlog/ARCHIVED

# BACKLOG.md
if [ ! -f BACKLOG.md ]; then
 cat > BACKLOG.md << 'EOF'
# Product Backlog

A single-ranked ordered list of work items. This is ONE flat table — no grouped sections
(active / gated / delivered). Top items are ready to be pulled; delivered rows keep their rank.
See `.backlog/CONFIG.md` for workflow states and item types.

| Rank | ID | Title | Type | Status | Notes |
|------|----|-------|------|--------|-------|
| 1    | (add items here) | | | | |

_Last updated:_
EOF
 echo "Created BACKLOG.md"
fi

# .backlog/CONFIG.md
cat > .backlog/CONFIG.md << 'CONFIG_EOF'
# Backlog Configuration

## Item Types
# feature, bug, tech-debt, improvement, chore, spike

## Status (per-row attribute — NOT a grouping section)
# Status is recorded as a column value on each row; it never splits the table
# into sections. The list stays one flat single-ranked table.
# Suggested status values: captured -> ready -> in-progress -> done
# Delivered rows keep their rank position; only their status value changes.
CONFIG_EOF
echo "Created .backlog/CONFIG.md"

# .backlog/EPICS.md
if [ ! -f .backlog/EPICS.md ]; then
 cat > .backlog/EPICS.md << 'EPICS_EOF'
# Epics

Large initiatives broken into multiple backlog items.

| ID | Title | Items | Status |
|----|-------|-------|--------|
| (add epics here) | | | |

_An epic is complete when all its child items are done._
EPICS_EOF
 echo "Created .backlog/EPICS.md"
fi

# .backlog/ARCHIVED/
# Item files (IN .backlog/ITEMS/) are moved here once the item is marked done.
# The BACKLOG.md table row keeps its rank and status=done; only the detail file is archived.
echo "(item files are moved here once marked done)" > .backlog/ARCHIVED/README.md 2>/dev/null || true

# .backlog/REFINEMENT_LOG.md
echo "# Refinement Log" > .backlog/REFINEMENT_LOG.md
echo "" >> .backlog/REFINEMENT_LOG.md
echo "- $DATE: Backlog initialized" >> .backlog/REFINEMENT_LOG.md
echo "Created .backlog/REFINEMENT_LOG.md"



echo ""
echo "Backlog structure initialized!"
echo ""
echo "Next steps:"
echo " 1. Edit .backlog/CONFIG.md — customize item types and status values"
echo " 2. Start capturing items in BACKLOG.md or use ./scripts/capture-item.sh"
echo " 3. Refine top items with stories and AC before starting work"
