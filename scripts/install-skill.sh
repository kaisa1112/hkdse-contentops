#!/usr/bin/env sh
set -eu

target="both"
force="false"
codex_skills_root="${CODEX_SKILLS_ROOT:-}"
claude_skills_root="${CLAUDE_SKILLS_ROOT:-}"

usage() {
  printf '%s\n' \
    "Usage: ./scripts/install-skill.sh [--target codex|claude|both] [--force]" \
    "       [--codex-root PATH] [--claude-root PATH]"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --target)
      [ "$#" -ge 2 ] || { usage; exit 2; }
      target="$2"
      shift 2
      ;;
    --codex-root)
      [ "$#" -ge 2 ] || { usage; exit 2; }
      codex_skills_root="$2"
      shift 2
      ;;
    --claude-root)
      [ "$#" -ge 2 ] || { usage; exit 2; }
      claude_skills_root="$2"
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

case "$target" in
  codex|claude|both) ;;
  *) printf 'Invalid target: %s\n' "$target" >&2; exit 2 ;;
esac

require_default_root() {
  label="$1"
  if [ -z "${HOME:-}" ]; then
    printf 'HOME is unset; pass --%s-root PATH.\n' "$label" >&2
    exit 2
  fi
}

case "$target" in
  codex|both)
    if [ -z "$codex_skills_root" ]; then
      require_default_root "codex"
      codex_skills_root="${HOME}/.codex/skills"
    fi
    ;;
esac

case "$target" in
  claude|both)
    if [ -z "$claude_skills_root" ]; then
      require_default_root "claude"
      claude_skills_root="${HOME}/.claude/skills"
    fi
    ;;
esac

canonicalize_root() {
  root="$1"
  mkdir -p "$root"
  CDPATH= cd -- "$root" && pwd -P
}

case "$target" in
  codex|both) codex_compare=$(canonicalize_root "$codex_skills_root") ;;
esac
case "$target" in
  claude|both) claude_compare=$(canonicalize_root "$claude_skills_root") ;;
esac

case "$target" in
  codex|both)
    [ "$codex_compare" != "/" ] || { printf 'Refusing Codex root: %s\n' "$codex_skills_root" >&2; exit 2; }
    ;;
esac
case "$target" in
  claude|both)
    [ "$claude_compare" != "/" ] || { printf 'Refusing Claude root: %s\n' "$claude_skills_root" >&2; exit 2; }
    ;;
esac

if [ "$target" = "both" ]; then
  if [ "$codex_compare" = "$claude_compare" ]; then
    printf '%s\n' 'Codex and Claude roots must be different when --target both is used.' >&2
    exit 2
  fi

  is_at_or_below() {
    candidate="$1"
    parent="$2"
    case "${candidate}/" in
      "${parent}/"*) return 0 ;;
      *) return 1 ;;
    esac
  }

  if is_at_or_below "$claude_compare" "${codex_compare}/hkdse-contentops" ||
     is_at_or_below "$codex_compare" "${claude_compare}/hkdse-contentops"; then
    printf '%s\n' 'Codex and Claude roots must not overlap either skill destination.' >&2
    exit 2
  fi
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
source_dir=$(CDPATH= cd -- "${script_dir}/../plugins/hkdse-contentops/skills/hkdse-contentops" && pwd -P)

[ -f "${source_dir}/SKILL.md" ] || {
  printf 'Skill source is incomplete: %s\n' "$source_dir" >&2
  exit 1
}

preflight() {
  root="$1"
  destination="${root}/hkdse-contentops"
  root_absolute=$(CDPATH= cd -- "$root" && pwd -P)
  if [ "${root_absolute}/hkdse-contentops" = "$source_dir" ]; then
    printf 'Refusing to install the skill onto its source directory: %s\n' "$source_dir" >&2
    exit 2
  fi
  if [ -e "$destination" ] && [ "$force" != "true" ]; then
    printf 'Already exists: %s\nRe-run with --force to back it up and replace it.\n' "$destination" >&2
    exit 1
  fi
}

install_one() {
  root="$1"
  label="$2"
  destination="${root}/hkdse-contentops"

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
    printf '%s backup: %s\n' "$label" "$backup"
  fi

  cp -R "$source_dir" "$destination"
  printf '%s installed: %s\n' "$label" "$destination"
}

case "$target" in
  codex) preflight "$codex_skills_root" ;;
  claude) preflight "$claude_skills_root" ;;
  both)
    preflight "$codex_skills_root"
    preflight "$claude_skills_root"
    ;;
esac

case "$target" in
  codex) install_one "$codex_skills_root" "Codex" ;;
  claude) install_one "$claude_skills_root" "Claude" ;;
  both)
    install_one "$codex_skills_root" "Codex"
    install_one "$claude_skills_root" "Claude"
    ;;
esac

printf '%s\n' 'Start a new Codex task or Claude session before testing the updated skill.'
