#!/usr/bin/env bash
# init-collab.sh
# Initialize the cross-functional collaboration structure (continuous-flow model).
# Usage: ./scripts/init-collab.sh

set -euo pipefail

DATE=$(date -Iseconds)

echo "Initializing collaboration structure..."

mkdir -p .collaboration/PAIRS

# Note: the single canonical backlog — BACKLOG.md + .backlog/ — is created and owned by
# the backlog-management skill (init-backlog.sh). This script does not create a backlog;
# it expects one to already exist. If none exists, run init-backlog.sh first.
if [ ! -f BACKLOG.md ]; then
  echo "Warning: BACKLOG.md not found. Run backlog-management's init-backlog.sh first." >&2
fi

# WORKING_AGREEMENT.md
if [ ! -f .collaboration/WORKING_AGREEMENT.md ]; then
 cat > .collaboration/WORKING_AGREEMENT.md << 'WA_EOF'
# Team Working Agreement

> A living document that formalizes the structural guardrails for agent collaboration.
> Review and update continuously as you learn.

## WIP Limits
- Maximum active items (Status = in-progress) in BACKLOG.md at any time: 3
- If at limit, swarm before pulling new work.

## Definition of Done
- The authoritative DoD is in `DEFINITION_OF_DONE.md` (owned by the definition-of-done skill).
- No duplicate here — read and enforce `DEFINITION_OF_DONE.md`.

## Three Amigos
- Every story requires a Three Amigos review before moving to "In Progress"
- Log the session in DAILY_LOG.md

## 15-Minute Rule
- If stuck for 15+ minutes on a problem, ask a teammate for help
- Log what you tried

## Communication
- Design feedback: in shared documents / comments
- Architectural decisions: in DECISIONS.md
- Status: in BACKLOG.md
- Blockers & activity: in DAILY_LOG.md
WA_EOF
 echo "Created WORKING_AGREEMENT.md"
fi

# DAILY_LOG.md
echo "# Activity Log" > .collaboration/DAILY_LOG.md
echo "" >> .collaboration/DAILY_LOG.md
echo "- $DATE: Collaboration structure initialized" >> .collaboration/DAILY_LOG.md

# DECISIONS.md
echo "# Key Decisions" > .collaboration/DECISIONS.md
echo "" >> .collaboration/DECISIONS.md
echo "- $DATE: Collaboration structure initialized" >> .collaboration/DECISIONS.md
echo "Created DAILY_LOG.md and DECISIONS.md"

echo ""
echo "Collaboration structure initialized!"
echo ""
echo "Next steps:"
echo " 1. Review WORKING_AGREEMENT.md — customize WIP limits and guardrails (DoD lives in DEFINITION_OF_DONE.md)"
echo " 2. Pull work from BACKLOG.md — Three Amigos every story before coding"
echo " 3. Start collaborating — remember: swarm before you wait, pair on high-risk work"
