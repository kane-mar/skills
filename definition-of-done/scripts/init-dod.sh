#!/usr/bin/env bash
# init-dod.sh
# Initialize the Definition of Done structure.
# Usage: ./scripts/init-dod.sh

set -euo pipefail

DATE=$(date -Iseconds)

echo "📋 Initializing Definition of Done..."

mkdir -p .dod

# DEFINITION_OF_DONE.md
if [ ! -f DEFINITION_OF_DONE.md ]; then
  cat > DEFINITION_OF_DONE.md << 'DOD_EOF'
# Definition of Done

> Every item must meet ALL of these criteria before it can be marked as Done.
> See `.dod/CHECKLIST.md` for the machine-readable checklist.

## Code Quality
- [ ] Code reviewed
- [ ] No known defects
- [ ] Coding standards met
- [ ] Error handling complete

## Testing
- [ ] Unit tests pass
- [ ] New unit tests added (≥ 80% coverage)
- [ ] Integration tests pass
- [ ] Edge cases tested

## Documentation
- [ ] Code documented (APIs, complex logic)
- [ ] Decision rationale logged

## Operations
- [ ] No regressions
- [ ] Performance verified
- [ ] Logging added

## Collaboration
- [ ] Peer verified (another agent or human)
- [ ] Stakeholder sign-off (PO or end user)

---
_Last reviewed: —_
DOD_EOF
  echo "📄 Created DEFINITION_OF_DONE.md"
fi

# .dod/CONFIG.md
cat > .dod/CONFIG.md << 'CONFIG_EOF'
# DoD Configuration

## Scope
# Does the DoD apply to all items, or are there exceptions?
scope: all

## Exceptions
# List item types that may have a different DoD (e.g., "spike", "chore")
# If none, leave empty.
exceptions:

## Review Cadence
# How often is the DoD reviewed?
review_cadence: quarterly

## Override Policy
# Can DoD items be overridden? If so, who decides?
override_policy: "Team decision — logged in VERIFICATION_LOG.md"
CONFIG_EOF
echo "📄 Created .dod/CONFIG.md"

# .dod/CHECKLIST.md
cat > .dod/CHECKLIST.md << 'CHECK_EOF'
# DoD Checklist

# Format: [enabled|disabled] category: criterion
# Disabled items are skipped during verification.

## Code Quality
enabled: Code reviewed
enabled: No known defects
enabled: Coding standards met
enabled: Error handling complete
disabled: No dead code
disabled: Security reviewed

## Testing
enabled: Unit tests pass
enabled: New unit tests added
enabled: Integration tests pass
enabled: Edge cases tested
disabled: Accessibility checked

## Documentation
enabled: Code documented
enabled: Decision rationale logged
disabled: README updated

## Operations
enabled: No regressions
enabled: Performance verified
disabled: Security reviewed
enabled: Logging added

## Collaboration
enabled: Peer verified
enabled: Stakeholder sign-off
CHECK_EOF
echo "📄 Created .dod/CHECKLIST.md"

# .dod/VERIFICATION_LOG.md
echo "# Verification Log" > .dod/VERIFICATION_LOG.md
echo "" >> .dod/VERIFICATION_LOG.md
echo "- $DATE: DoD initialized" >> .dod/VERIFICATION_LOG.md
echo "📄 Created .dod/VERIFICATION_LOG.md"

# .dod/REVIEW_LOG.md
echo "# DoD Review Log" > .dod/REVIEW_LOG.md
echo "" >> .dod/REVIEW_LOG.md
echo "- $DATE: Initial DoD created" >> .dod/REVIEW_LOG.md
echo "📄 Created .dod/REVIEW_LOG.md"

echo ""
echo "✅ Definition of Done initialized!"
echo ""
echo "Next steps:"
echo "  1. Review DEFINITION_OF_DONE.md and customize the criteria"
echo "  2. Enable/disable checklist items in .dod/CHECKLIST.md"
echo "  3. Before marking work as Done, run ./scripts/verify-dod.sh <item-id>"
