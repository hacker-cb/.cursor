# Sync Shared Rules

## Overview
**One-way sync** of shared developer rules FROM `~/.cursor/rules/` TO a target project's `.cursor/rules/` directory. This command ONLY syncs from the shared rules repository to projects, never in reverse. Updates shared rules source before syncing and handles file conflicts interactively.

## Steps

**Note:** This is a one-way sync. Source is always `~/.cursor/rules/` (shared rules repository). Target is always the project's `.cursor/rules/` directory. Never syncs changes back to `~/.cursor/`.

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
- Verify directories created successfully
- Confirm write access to `.cursor/rules/`

### 4. Sync Rule Files (One-Way: Source → Target)
- List all `shared-*.mdc` files in `~/.cursor/rules/` (source)
- For each shared rule file:
  - Check if file exists in target project's `.cursor/rules/`
  - If file doesn't exist in target: copy from source to target
  - If file exists in target: compare with source
  - If different: ask user (overwrite/skip/show diff)
  - Track synced and skipped files
- **Never** copy files from target back to `~/.cursor/rules/`

### 5. Handle Conflicts
When target file exists and differs from source:
- **Show file name** and brief diff summary
- **Ask user:** `[O]verwrite`, `[S]kip`, or `[D]iff`
- If `Overwrite`: replace target with source file
- If `Skip`: leave target unchanged, note in report
- If `Diff`: show full diff, then ask overwrite/skip again
- Continue with next file

### 6. Generate Sync Report
- List successfully synced files (with count)
- List skipped files (with count)
- List any errors encountered
- Show total: X files synced, Y files skipped, Z errors
- Indicate sync completion status

## Checklist
- [ ] Shared rules source (`~/.cursor/rules/`) updated (git pull)
- [ ] Target project validated (git repo, write access)
- [ ] Target `.cursor/rules/` directory prepared
- [ ] All `shared-*.mdc` files synced from source to target
- [ ] Conflicts handled appropriately
- [ ] Sync report generated and displayed
- [ ] Confirmed: no files synced back to `~/.cursor/`

