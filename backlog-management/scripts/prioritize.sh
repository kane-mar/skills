#!/usr/bin/env bash
# prioritize.sh
# Score or re-prioritize a backlog item using a framework.
# Usage: ./scripts/prioritize.sh --method moscow --item ITEM-003 --category M
# Usage: ./scripts/prioritize.sh --method wsjf --item ITEM-003 --value 8 --criticality 5 --risk 3 --size 5

set -euo pipefail

METHOD=""
ITEM=""
CATEGORY=""
VALUE=""
CRITICALITY=""
RISK=""
SIZE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --method) METHOD="$2"; shift 2 ;;
    --item) ITEM="$2"; shift 2 ;;
    --category) CATEGORY="$2"; shift 2 ;;
    --value) VALUE="$2"; shift 2 ;;
    --criticality) CRITICALITY="$2"; shift 2 ;;
    --risk) RISK="$2"; shift 2 ;;
    --size) SIZE="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

if [ -z "$METHOD" ] || [ -z "$ITEM" ]; then
  echo "Usage: $0 --method <moscow|wsjf|eisenhower> --item <ITEM-ID> [options]"
  exit 1
fi

DATE=$(date -Iseconds)

case "$METHOD" in
  moscow)
    if [ -z "$CATEGORY" ]; then
      echo "Error: --category required for MoSCoW (M, S, C, W)"
      exit 1
    fi
    CATEGORY_LABEL=""
    case "$CATEGORY" in
      M|m) CATEGORY_LABEL="Must have" ;;
      S|s) CATEGORY_LABEL="Should have" ;;
      C|c) CATEGORY_LABEL="Could have" ;;
      W|w) CATEGORY_LABEL="Won't have" ;;
      *) echo "Invalid category: $CATEGORY (use M, S, C, or W)"; exit 1 ;;
    esac
    echo "📊 MoSCoW: $ITEM → $CATEGORY_LABEL ($CATEGORY)"
    ;;
  wsjf)
    if [ -z "$VALUE" ] || [ -z "$CRITICALITY" ] || [ -z "$RISK" ] || [ -z "$SIZE" ]; then
      echo "Error: --value, --criticality, --risk, and --size required for WSJF"
      exit 1
    fi
    SCORE=$(( (VALUE + CRITICALITY + RISK) / SIZE ))
    echo "📊 WSJF: $ITEM → Score = ($VALUE + $CRITICALITY + $RISK) / $SIZE = $SCORE"
    ;;
  eisenhower)
    if [ -z "$CATEGORY" ]; then
      echo "Error: --category required for Eisenhower (do, schedule, delegate, delete)"
      exit 1
    fi
    CATEGORY_LABEL=""
    case "$CATEGORY" in
      do) CATEGORY_LABEL="Do first (Important + Urgent)" ;;
      schedule) CATEGORY_LABEL="Schedule (Important + Not Urgent)" ;;
      delegate) CATEGORY_LABEL="Delegate (Not Important + Urgent)" ;;
      delete) CATEGORY_LABEL="Delete/Icebox (Not Important + Not Urgent)" ;;
      *) echo "Invalid category: $CATEGORY (use do, schedule, delegate, delete)"; exit 1 ;;
    esac
    echo "📊 Eisenhower: $ITEM → $CATEGORY_LABEL"
    ;;
  *)
    echo "Unknown method: $METHOD (use moscow, wsjf, or eisenhower)"
    exit 1
    ;;
esac

# Log to refinement log
{
  echo ""
  echo "- $DATE: Prioritized $ITEM using $METHOD ($([ -n "${CATEGORY_LABEL:-}" ] && echo "$CATEGORY_LABEL" || echo "WSJF score: ${SCORE:-N/A}"))"
} >> .backlog/REFINEMENT_LOG.md

echo "   Logged to .backlog/REFINEMENT_LOG.md"
