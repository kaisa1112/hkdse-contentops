#!/usr/bin/env sh
set -eu

force="false"
codex_skills_root="${CODEX_SKILLS_ROOT:-}"

usage() {
  printf '%s\n' \
    "Usage: ./scripts/install-skill.sh [--force] [--codex-root PATH]"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --codex-root)
      [ "$#" -ge 2 ] || { usage; exit 2; }
      codex_skills_root="$2"
      shift 2
      ;;
    --force)
      force="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage
      exit 2
      ;;
  esac
done

if [ -z "$codex_skills_root" ]; then
  if [ -z "${HOME:-}" ]; then
    printf '%s\n' 'HOME is unset; pass --codex-root PATH.' >&2
    exit 2
  fi
  codex_skills_root="${HOME}/.codex/skills"
fi

canonicalize_root() {
  root="$1"
  mkdir -p "$root"
  CDPATH= cd -- "$root" && pwd -P
}

codex_compare=$(canonicalize_root "$codex_skills_root")
[ "$codex_compare" != "/" ] || {
  printf 'Refusing Codex root: %s\n' "$codex_skills_root" >&2
  exit 2
}

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
source_dir=$(CDPATH= cd -- "${script_dir}/../plugins/hkdse-contentops/skills/hkdse-contentops" && pwd -P)

[ -f "${source_dir}/SKILL.md" ] || {
  printf 'Skill source is incomplete: %s\n' "$source_dir" >&2
  exit 1
}

destination="${codex_skills_root}/hkdse-contentops"
if [ "${codex_compare}/hkdse-contentops" = "$source_dir" ]; then
  printf 'Refusing to install the skill onto its source directory: %s\n' "$source_dir" >&2
  exit 2
fi
if [ -e "$destination" ] && [ "$force" != "true" ]; then
  printf 'Already exists: %s\nRe-run with --force to back it up and replace it.\n' "$destination" >&2
  exit 1
fi

if [ -e "$destination" ]; then
  timestamp=$(date -u +%Y%m%dT%H%M%SZ)
  backup_base="${destination}.backup-${timestamp}"
  backup="$backup_base"
  suffix=2
  while [ -e "$backup" ]; do
    backup="${backup_base}-${suffix}"
    suffix=$((suffix + 1))
  done
  mv "$destination" "$backup"
  printf 'Codex backup: %s\n' "$backup"
fi

cp -R "$source_dir" "$destination"
printf 'Codex installed: %s\n' "$destination"
printf '%s\n' 'Start a new Codex task before testing the updated skill.'
