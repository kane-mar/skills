#!/usr/bin/env bash
# init-backlog.sh
# Initialize the backlog management structure.
# Usage: ./scripts/init-backlog.sh

set -euo pipefail

DATE=$(date -Iseconds)

echo "📋 Initializing backlog management structure..."

mkdir -p .backlog/ITEMS

# BACKLOG.md
if [ ! -f BACKLOG.md ]; then
  cat > BACKLOG.md << 'EOF'
# Product Backlog

Prioritized list of work items. Top items are ready for sprint planning.
See `.backlog/CONFIG.md` for prioritization framework and estimation scale.

| ID | Title | Type | Priority | Estimate | Status |
|----|-------|------|----------|----------|--------|
| (add items here) | | | | | |

_Last updated:_
EOF
  echo "📄 Created BACKLOG.md"
fi

# .backlog/CONFIG.md
cat > .backlog/CONFIG.md << 'CONFIG_EOF'
# Backlog Configuration

## Prioritization Framework
# Options: moscow, wsjf, eisenhower
framework: moscow

## Estimation Scale
# Options: fibonacci, tshirt, time, complexity
scale: fibonacci
# Fibonacci values: 1, 2, 3, 5, 8, 13, 21
# T-Shirt values: XS, S, M, L, XL, XXL

## Item Types
# feature, bug, tech-debt, improvement, chore, spike

## Workflow States
# captured → backlog → refined → ready → in-progress → done
CONFIG_EOF
echo "📄 Created .backlog/CONFIG.md"

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
  echo "📄 Created .backlog/EPICS.md"
fi

# .backlog/DEPENDENCIES.md
cat > .backlog/DEPENDENCIES.md << 'DEPS_EOF'
# Dependency Map

| Item | Depends On | Blocks | Notes |
|------|-----------|--------|-------|
| (add dependencies here) | | | |
DEPS_EOF
echo "📄 Created .backlog/DEPENDENCIES.md"

# .backlog/REFINEMENT_LOG.md
echo "# Refinement Log" > .backlog/REFINEMENT_LOG.md
echo "" >> .backlog/REFINEMENT_LOG.md
echo "- $DATE: Backlog initialized" >> .backlog/REFINEMENT_LOG.md
echo "📄 Created .backlog/REFINEMENT_LOG.md"



echo ""
echo "✅ Backlog structure initialized!"
echo ""
echo "Next steps:"
echo "  1. Edit .backlog/CONFIG.md — choose prioritization framework and estimation scale"
echo "  2. Start capturing items in BACKLOG.md or use ./scripts/capture-item.sh"
echo "  3. Refine top items with stories, AC, and estimates before sprint planning"
