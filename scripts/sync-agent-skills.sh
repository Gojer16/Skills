#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

SOURCE_DIR="${ROOT_DIR}/.agents/skills"
TARGET_DIRS=(
  "${ROOT_DIR}/.codex/skills"
  "${ROOT_DIR}/.opencode/skills"
  "${ROOT_DIR}/.pi/skills"
)

usage() {
  cat <<'EOF'
Usage: scripts/sync-agent-skills.sh [--dry-run]

Mirrors .agents/skills into:
  - .codex/skills
  - .opencode/skills
  - .pi/skills

Options:
  --dry-run  Show what would change without modifying files.
EOF
}

DRY_RUN=0

case "${1:-}" in
  "")
    ;;
  --dry-run)
    DRY_RUN=1
    ;;
  -h|--help)
    usage
    exit 0
    ;;
  *)
    usage >&2
    exit 1
    ;;
esac

if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "Source directory not found: ${SOURCE_DIR}" >&2
  exit 1
fi

RSYNC_ARGS=(
  -a
  --delete
  --delete-excluded
  --exclude=.DS_Store
  --exclude=.git
)

if [[ "${DRY_RUN}" -eq 1 ]]; then
  RSYNC_ARGS+=(--dry-run --itemize-changes)
fi

for target_dir in "${TARGET_DIRS[@]}"; do
  mkdir -p "${target_dir}"
  echo "Syncing ${SOURCE_DIR} -> ${target_dir}"
  rsync "${RSYNC_ARGS[@]}" "${SOURCE_DIR}/" "${target_dir}/"
done

echo "Skill sync complete."
