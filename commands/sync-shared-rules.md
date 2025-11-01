# Sync Shared Rules

## Overview
Sync common shared developer rules from this workspace (`~/.cursor/rules/`) to a target project's `.cursor/rules/` directory. Updates shared rules source before syncing and handles file conflicts interactively.

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
- Verify directories created successfully
- Confirm write access to `.cursor/rules/`

### 4. Sync Rule Files
- List all `shared-*.mdc` files in `~/.cursor/rules/`
- For each shared rule file:
  - Check if file exists in target `.cursor/rules/`
  - If file doesn't exist: copy file to target
  - If file exists: check if identical
  - If different: ask user (overwrite/skip/show diff)
  - Track synced and skipped files

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
- [ ] Shared rules source updated (git pull)
- [ ] Target project validated (git repo, write access)
- [ ] Target `.cursor/rules/` directory prepared
- [ ] All shared rule files processed
- [ ] Conflicts handled appropriately
- [ ] Sync report generated and displayed

