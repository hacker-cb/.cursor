# Sync Shared Rules

## Overview
**One-way sync** of shared developer rules FROM `~/.cursor/rules/` TO a target project's `.cursor/rules/` directory. This command ONLY syncs from the shared rules repository to projects, never in reverse. Updates shared rules source before syncing and handles file conflicts interactively. For project analysis and local rule management, use `setup-cursor-rules` command.

## Steps

### 1. Update Shared Rules Source
- Navigate to `~/.cursor/` directory
- Check git status for uncommitted changes
- If repository is dirty (uncommitted changes):
  - Warn user about uncommitted changes in `~/.cursor/`
  - Ask user: "Continue sync with existing rules? [Y/n]"
  - If user declines: exit sync process
  - If user agrees: skip git pull, continue with existing rules
- If repository is clean:
  - Run `git pull` to get latest shared rules
  - Verify pull successful
- Confirm shared rules are ready for sync

### 2. Validate Target Project
- Verify target project path provided
- Check target directory exists
- Verify target is a git repository (`.git` directory exists)
- Check write permissions to target directory
- Exit with error if validation fails

### 3. Prepare Target Directory
- Create `.cursor/` directory in target if missing
- Create `.cursor/rules/` directory in target if missing
- Verify directories ready for sync

### 4. Sync Shared Rule Files
- List all `shared-*.mdc` files in `~/.cursor/rules/` (source)
- Copy each shared rule file to target project's `.cursor/rules/`
- Track successfully synced files

### 5. Handle Conflicts
If any `shared-*.mdc` files already exist in target:
- Compare with source versions
- Show differences if any
- **Ask user:** `[O]verwrite with latest`, `[K]eep existing`, or `[D]iff`
- If `Overwrite`: replace with latest from source
- If `Keep`: leave existing version, note in report
- If `Diff`: show full diff, then ask overwrite/keep again

### 6. Handle Old Rules
If old rule files exist (without `shared-` or `local-` prefix, or `.cursorrules` file):
- Notify user that old rules were found
- Recommend running `setup-cursor-rules` to analyze and migrate them
- Continue with shared rules sync

### 7. Generate Sync Report
- Shared rules synced (with count and file names)
- Files kept/skipped (with count)
- Any errors encountered
- Display final `.cursor/rules/` directory structure
- If old rules found: remind to run `setup-cursor-rules`

## Checklist
- [ ] Shared rules source (`~/.cursor/rules/`) updated (git pull)
- [ ] Target project validated (git repo, write access)
- [ ] Target `.cursor/rules/` directory prepared
- [ ] All `shared-*.mdc` files synced from source to target
- [ ] Conflicts handled (overwrite/keep decisions made)
- [ ] Old rules detected and user notified
- [ ] Sync report generated
- [ ] User reminded to run `setup-cursor-rules` if needed

