# Installation Guide

Complete installation guide for the Cursor Shared Workspace configuration.

## Prerequisites

Before installing, ensure you have:

1. **Cursor IDE** - Download and install from [cursor.sh](https://cursor.sh)
2. **Git 2.0+** - Required for repository management
3. **Bash 4.0+** - Included with macOS and Linux
4. **Write permissions** - Access to your home directory

**Supported Platforms:**
- macOS (Apple Silicon and Intel)
- Linux (any distribution)

## Quick Install

**One-line installation using curl:**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/hacker-cb/.cursor/master/install.sh)
```

**Or using wget:**

```bash
bash <(wget -qO- https://raw.githubusercontent.com/hacker-cb/.cursor/master/install.sh)
```

The script will guide you through the installation process with colorized output and clear status messages.

## What the Script Does

The installation script performs the following steps:

### 1. Detects Installation State

The script intelligently detects three possible states:

- **Cursor not installed** - Prompts you to install Cursor IDE first
- **Already installed** - Provides instructions to update via git
- **Ready to install** - Proceeds with full installation

### 2. Creates Backup

Before making any changes, the script creates a timestamped backup of your existing `.cursor` directory:

```
~/.cursor.backup.2025-11-01-143022
```

Your data is always safe and can be restored if needed.

### 3. Clones Repository

The script clones the GitHub repository to `~/.cursor/`:

```bash
git clone https://github.com/hacker-cb/.cursor.git ~/.cursor
```

This installs:
- Workspace rules (`.cursor/rules/`)
- Shared rules (`rules/`)
- Command templates (`commands/`)
- Documentation and configuration

### 4. Restores Your Personal Settings

**Automatically and intelligently**, the script restores your personal Cursor settings from the backup:

**What gets restored:**
- IDE configuration (`ide_state.json`, `mcp.json`)
- Extensions directory (`extensions/`)
- Projects metadata (`projects/`)
- Any other personal files

**What gets replaced:**
- Workspace rules from shared workspace
- Shared rules templates
- Command templates
- Repository documentation

### 5. Validates Installation

The script verifies:
- Marker file exists (`.cursor-shared-workspace`)
- All required directories present
- Expected number of rules and commands installed
- Git repository properly configured

### 6. Provides Next Steps

Clear instructions on how to start using the shared workspace in your projects.

## Installation Scenarios

### Scenario 1: Cursor Not Installed

```
$ bash <(curl -fsSL https://raw.githubusercontent.com/hacker-cb/.cursor/master/install.sh)

Cursor Shared Workspace Installer

Cursor IDE Not Detected
✗ Cursor IDE not found at ~/.cursor

ℹ Please install Cursor IDE first:
ℹ   https://cursor.sh

ℹ After installation, run this script again
```

**Action:** Install Cursor IDE, then run the script again.

### Scenario 2: Already Installed

```
$ bash <(curl -fsSL https://raw.githubusercontent.com/hacker-cb/.cursor/master/install.sh)

Cursor Shared Workspace Installer

Shared Workspace Already Installed
✓ Installation found at ~/.cursor

ℹ To update to the latest version:
ℹ   cd ~/.cursor
ℹ   git pull
```

**Action:** Use `git pull` to update to the latest version.

### Scenario 3: Ready to Install

```
$ bash <(curl -fsSL https://raw.githubusercontent.com/hacker-cb/.cursor/master/install.sh)

Cursor Shared Workspace Installer

Cursor IDE Detected

ℹ This will:
ℹ   1. Backup your existing .cursor directory
ℹ   2. Install shared workspace configuration
ℹ   3. Restore your personal Cursor settings

Continue with installation? [Y/n] y

Creating Backup
ℹ Backing up ~/.cursor to ~/.cursor.backup.2025-11-01-143022
✓ Backup created: ~/.cursor.backup.2025-11-01-143022

Installing Shared Workspace
ℹ Cloning repository from GitHub...
✓ Repository cloned

Restoring Your Personal Settings
ℹ Analyzing backup for personal files...
ℹ   Restored: extensions/...
ℹ   Restored: projects/...
ℹ   Restored: ide_state.json
✓ Restored 15 personal file(s)/directory(ies)

Validating Installation
✓ Marker file present
✓ Workspace rules present (7 files)
✓ Shared rules present (10 files)
✓ Commands present (7 files)
✓ Git repository valid

Installation Complete!

✓ Shared workspace installed at ~/.cursor
✓ Personal settings restored
ℹ Backup saved: ~/.cursor.backup.2025-11-01-143022

ℹ Next steps:
ℹ   1. Open Cursor IDE in your project directory
ℹ   2. Run 'sync-shared-rules' command
ℹ   3. Run 'manage-cursor-rules' command
ℹ   4. Start developing with enhanced AI rules
```

**Action:** Follow the next steps to use the shared workspace in your projects.

## Manual Installation

If you prefer to install manually without the script:

### Step 1: Close Cursor IDE

Close all Cursor IDE windows and ensure no Cursor processes are running:

```bash
# Check for running Cursor processes
ps aux | grep Cursor

# Kill if needed
killall Cursor
```

### Step 2: Backup Existing Installation

Create a timestamped backup of your current `.cursor` directory:

```bash
mv ~/.cursor ~/.cursor.backup.$(date +%Y-%m-%d-%H%M%S)
```

### Step 3: Clone Repository

Clone the shared workspace repository:

```bash
git clone https://github.com/hacker-cb/.cursor.git ~/.cursor
```

### Step 4: Verify Installation

Check that the marker file exists:

```bash
ls ~/.cursor/.cursor-shared-workspace
```

### Step 5: Restore Personal Settings (Optional)

If you want to restore your personal settings from the backup:

```bash
# Find your backup
BACKUP=$(ls -td ~/.cursor.backup.* | head -1)

# Copy personal files (adjust paths as needed)
cp -r "$BACKUP/extensions" ~/.cursor/
cp -r "$BACKUP/projects" ~/.cursor/
cp "$BACKUP/ide_state.json" ~/.cursor/
cp "$BACKUP/mcp.json" ~/.cursor/
```

## Updating Existing Installation

Once the shared workspace is installed, you can update to the latest version using git:

```bash
cd ~/.cursor
git pull
```

This will fetch and apply the latest changes from the repository:
- Updated workspace rules
- New shared rules
- New command templates
- Documentation updates

Your personal settings (extensions, projects, IDE state) are not affected by updates.

## Script Options

The installation script supports several command-line options:

### Show Help

```bash
./install.sh --help
```

Displays usage information and available options.

### Force Installation

```bash
./install.sh --force
```

Skips the Cursor running check. **Use with caution** - installing while Cursor is running may cause issues.

### Uninstall

```bash
./install.sh --uninstall
```

Removes the shared workspace installation and restores the most recent backup.

## Troubleshooting

### "Cursor IDE not detected"

**Problem:** The script cannot find Cursor IDE at `~/.cursor`

**Solution:**
1. Install Cursor IDE from [cursor.sh](https://cursor.sh)
2. Launch Cursor at least once to create the `.cursor` directory
3. Verify installation: `ls ~/.cursor`
4. Run the install script again

### "Cursor is running. Please close all instances"

**Problem:** Cursor IDE is currently running

**Solution:**
1. Close all Cursor windows
2. Check for background processes: `ps aux | grep Cursor`
3. Kill if needed: `killall Cursor`
4. Run the install script again

Or use `--force` flag to skip this check (not recommended).

### "Git not found"

**Problem:** Git is not installed on your system

**Solution:**

**macOS:**
```bash
xcode-select --install
```

**Debian/Ubuntu:**
```bash
sudo apt update
sudo apt install git
```

**RHEL/CentOS/Fedora:**
```bash
sudo yum install git
# or
sudo dnf install git
```

### "Permission denied"

**Problem:** Insufficient permissions to write to home directory

**Solution:**
1. Check home directory permissions: `ls -la ~ | grep cursor`
2. **Do not run the script with sudo** (installs to user home directory)
3. Ensure you have write permissions: `touch ~/.cursor-test && rm ~/.cursor-test`

### "Already installed" but files are missing

**Problem:** Marker file exists but installation appears incomplete

**Solution:**
1. Check for corruption: `cd ~/.cursor && git status`
2. If corrupted, remove marker file: `rm ~/.cursor/.cursor-shared-workspace`
3. Run install script again (it will detect as "ready to install")

### Restore from Backup

If something goes wrong, you can restore from backup:

```bash
# List available backups
ls -la ~ | grep cursor.backup

# Choose backup to restore
BACKUP_DATE="2025-11-01-143022"

# Remove current installation
rm -rf ~/.cursor

# Restore backup
mv ~/.cursor.backup.$BACKUP_DATE ~/.cursor
```

### Clone Failed

**Problem:** Git clone fails or times out

**Solution:**
1. Check internet connection
2. Verify GitHub access: `ping github.com`
3. Try manual clone: `git clone https://github.com/hacker-cb/.cursor.git`
4. Check firewall/proxy settings
5. If you have SSH key configured, try SSH URL: `git clone git@github.com:hacker-cb/.cursor.git`

## What Gets Installed

The shared workspace installation includes:

```
~/.cursor/
├── .cursor-shared-workspace          # Marker file (empty)
│
├── .cursor/rules/                    # Workspace-specific rules (7 files)
│   ├── ai-agent-behavior.mdc        # AI agent behavior policies
│   ├── command-files.mdc            # Command file guidelines
│   ├── git-only-policy.mdc          # Git-tracked files policy
│   ├── git-workflow.mdc             # Git workflow and branching
│   ├── readme-sync.mdc              # README synchronization
│   ├── rules-files.mdc              # Shared rules file guidelines
│   └── workspace-documentation.mdc  # Documentation structure
│
├── rules/                            # Shared rules (10 files)
│   ├── shared-code-quality.mdc
│   ├── shared-commands-management.mdc
│   ├── shared-development-workflow.mdc
│   ├── shared-documentation-standards.mdc
│   ├── shared-environment-setup.mdc
│   ├── shared-release-management.mdc
│   ├── shared-rules-management.mdc
│   ├── shared-security-practices.mdc
│   ├── shared-testing-standards.mdc
│   └── shared-version-control.mdc
│
├── commands/                         # Workflow commands (7 files)
│   ├── add-test-coverage.md
│   ├── analyze-project-structure.md
│   ├── code-review.md
│   ├── github-workflow-autofix.md
│   ├── manage-cursor-rules.md
│   ├── security-audit.md
│   └── sync-shared-rules.md
│
├── README.md                         # Project documentation
├── .gitignore                        # Git configuration
└── install.sh                        # This installation script
```

**Plus your personal files (automatically restored):**
- `extensions/` - Your installed extensions
- `projects/` - Project metadata
- `ide_state.json` - IDE configuration
- `mcp.json` - MCP configuration
- Any other personal files

## After Installation

Once installation is complete, follow these steps:

### 1. Review Installed Files

Browse the `.cursor` directory to familiarize yourself with the structure:

```bash
cd ~/.cursor
ls -la
```

### 2. Check Your Backup

Verify your backup exists and contains your data:

```bash
ls -la ~ | grep cursor.backup
```

### 3. Start Using in Projects

Navigate to any development project and open Cursor IDE:

```bash
cd ~/my-project
cursor .
```

### 4. Sync Shared Rules

In Cursor, run the `sync-shared-rules` command to copy shared rules to your project:

1. Open Command Palette (Cmd/Ctrl+Shift+P)
2. Type: `sync-shared-rules`
3. Follow the prompts

### 5. Setup Project Rules

Run the `manage-cursor-rules` command to generate project-specific rules:

1. Open Command Palette (Cmd/Ctrl+Shift+P)
2. Type: `manage-cursor-rules`
3. Follow the analysis and generation process

### 6. Start Developing

You're now ready to use Cursor with enhanced AI rules and workflow commands!

## Uninstalling

### Using the Script

The easiest way to uninstall:

```bash
cd ~/.cursor
./install.sh --uninstall
```

The script will:
1. Find your most recent backup
2. Ask for confirmation
3. Remove the shared workspace installation
4. Restore your backup

### Manual Uninstall

If you prefer to uninstall manually:

```bash
# Find your most recent backup
ls -la ~ | grep cursor.backup | tail -1

# Note the timestamp, then:
BACKUP_DATE="2025-11-01-143022"  # Replace with your actual backup date

# Remove installation
rm -rf ~/.cursor

# Restore backup
mv ~/.cursor.backup.$BACKUP_DATE ~/.cursor
```

## Getting Help

If you encounter issues not covered in this guide:

1. Check the [README.md](README.md) for project overview
2. Review the [workspace rules](.cursor/rules/) for detailed guidelines
3. Check [GitHub Issues](https://github.com/hacker-cb/.cursor/issues) for known problems
4. Create a new issue with:
   - Your operating system and version
   - Error messages (if any)
   - Steps to reproduce the problem

## Summary

The Cursor Shared Workspace installer provides a safe, automated way to:

- ✓ Install workspace configuration by cloning the repository
- ✓ Preserve your personal Cursor settings automatically
- ✓ Validate installation integrity
- ✓ Update easily with git pull
- ✓ Rollback to backups if needed

Start enhancing your Cursor IDE experience today!

