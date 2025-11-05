#!/usr/bin/env bash
set -e  # Exit immediately on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

# Repository configuration
REPO_URL="https://github.com/hacker-cb/.cursor.git"
INSTALL_DIR="$HOME/.cursor"
MARKER_FILE=".cursor-shared-workspace"

# Color codes for nice output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Helper functions for colorized messages
info() { echo -e "${BLUE}ℹ${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warning() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1" >&2; }
heading() { echo -e "\n${CYAN}${BOLD}$1${NC}"; }

# Usage information
usage() {
    heading "Cursor Shared Workspace Installer"
    cat << 'EOF'

Usage: install.sh [OPTIONS]

Options:
  --help       Show this help message
  --force      Skip Cursor running check (use with caution)
  --uninstall  Remove installation and restore latest backup

Installation Modes:
EOF
    echo -e "  ${CYAN}1. Cursor not installed${NC} → Instructions to install Cursor IDE first"
    echo -e "  ${CYAN}2. Already installed${NC}    → Instructions to update (git pull)"
    echo -e "  ${CYAN}3. Ready to install${NC}     → Full installation with automatic backup"
    cat << 'EOF'

What the Script Does:
  • Detects your Cursor IDE installation state
  • Creates timestamped backup of existing .cursor directory
  • Clones repository to ~/.cursor
  • Automatically restores your personal settings
  • Validates installation integrity

Examples:
  install.sh                    # Normal installation
  install.sh --force            # Skip Cursor running check
  install.sh --uninstall        # Remove and restore backup

EOF
    echo -e "For detailed documentation, see: ${BLUE}INSTALL.md${NC}"
    echo ""
}

# Check if git is installed
check_git() {
    if ! command -v git &> /dev/null; then
        error "Git not found"
        info "Please install Git first:"
        info "  macOS: xcode-select --install"
        info "  Linux: sudo apt install git (or yum install git)"
        exit 1
    fi
}

# Detect installation state
detect_mode() {
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "no_cursor"
    elif [ -f "$INSTALL_DIR/$MARKER_FILE" ]; then
        echo "already_installed"
    else
        echo "ready_to_install"
    fi
}

# Mode 1: Cursor Not Installed
handle_no_cursor() {
    heading "Cursor IDE Not Detected"
    error "Cursor IDE not found at ~/.cursor"
    echo ""
    info "Please install Cursor IDE first:"
    info "  https://cursor.sh"
    echo ""
    info "After installation, run this script again"
    exit 1
}

# Mode 2: Already Installed
handle_already_installed() {
    heading "Shared Workspace Already Installed"
    success "Installation found at ~/.cursor"
    echo ""
    info "To update to the latest version:"
    info "  cd ~/.cursor"
    info "  git pull"
    exit 0
}

# Check if Cursor is running
check_cursor_running() {
    local force_mode=$1
    
    if [ "$force_mode" = false ]; then
        # Find all processes containing "Cursor" (case-insensitive)
        local cursor_processes
        cursor_processes=$(ps aux | grep -i "[C]ursor" || true)
        
        if [ -n "$cursor_processes" ]; then
            warning "Found processes containing 'Cursor':"
            echo ""
            # Show processes with basic formatting
            echo "$cursor_processes" | while IFS= read -r line; do
                echo "  $line"
            done
            echo ""
            info "These may include:"
            info "  • Cursor IDE application (should be closed)"
            info "  • System processes (safe to ignore)"
            echo ""
            read -p "Continue with installation anyway? [Y/n] " -n 1 -r < /dev/tty
            echo
            if [[ $REPLY =~ ^[Nn]$ ]]; then
                info "Installation cancelled"
                info "To skip this check in future, use: $0 --force"
                exit 0
            fi
        fi
    fi
}

# Create backup of existing installation (silent - only returns path)
create_backup() {
    local timestamp
    timestamp=$(date +%Y-%m-%d-%H%M%S)
    local backup_dir="$HOME/.cursor.backup.$timestamp"
    
    mv "$INSTALL_DIR" "$backup_dir"
    
    echo "$backup_dir"
}

# Clone repository
clone_repository() {
    heading "Installing Shared Workspace"
    info "Cloning repository from GitHub..."
    
    if git clone "$REPO_URL" "$INSTALL_DIR" 2>&1 | grep -v "Cloning into"; then
        success "Repository cloned"
    else
        success "Repository cloned"
    fi
}

# Build list of git-tracked files from installation
build_skip_list() {
    local skip_list_file="/tmp/.cursor-install-skip-$$"
    
    # Get all git-tracked files from the new installation
    (cd "$INSTALL_DIR" && git ls-files) > "$skip_list_file"
    
    echo "$skip_list_file"
}

# Function to check if path should be skipped
should_skip() {
    local path="$1"
    local skip_list_file="$2"
    local tracked_file
    
    # Always skip .git directory
    if [[ "$path" == ".git"* ]]; then
        return 0
    fi
    
    # Check if path matches any git-tracked file or directory
    while IFS= read -r tracked_file; do
        # Skip if path matches tracked file exactly
        if [[ "$path" == "$tracked_file" ]]; then
            return 0
        fi
        # Skip if path is a directory that contains tracked files
        if [[ "$tracked_file" == "$path"/* ]]; then
            return 0
        fi
    done < "$skip_list_file"
    
    return 1
}

# Cleanup skip list file
cleanup_skip_list() {
    local skip_list_file="$1"
    rm -f "$skip_list_file"
}

# Restore user settings from backup
restore_user_settings() {
    local backup_dir=$1
    
    heading "Restoring Your Personal Settings"
    info "Analyzing backup for personal files..."
    
    # Build list of files to skip (git-tracked files from new installation)
    local skip_list_file
    skip_list_file=$(build_skip_list)
    
    local restored_count=0
    local relative_path
    local parent_dir
    
    # Restore files from backup
    cd "$backup_dir"
    while IFS= read -r -d '' item; do
        relative_path="${item#./}"
        
        # Skip if it's a repo-managed path
        if should_skip "$relative_path" "$skip_list_file"; then
            continue
        fi
        
        # Skip if already exists in new installation
        if [ -e "$INSTALL_DIR/$relative_path" ]; then
            continue
        fi
        
        # Restore the file/directory
        parent_dir=$(dirname "$INSTALL_DIR/$relative_path")
        mkdir -p "$parent_dir"
        cp -r "$item" "$INSTALL_DIR/$relative_path"
        info "  Restored: $relative_path"
        restored_count=$((restored_count + 1))
    done < <(find . -mindepth 1 \( -type f -o -type d \) -print0)
    
    # Cleanup
    cleanup_skip_list "$skip_list_file"
    
    if [ $restored_count -eq 0 ]; then
        info "No additional personal files to restore"
    else
        success "Restored $restored_count personal file(s)/directory(ies)"
    fi
}

# Validate installation
validate_installation() {
    heading "Validating Installation"
    
    local validation_failed=false
    local workspace_rules
    local shared_rules
    local commands
    
    # Check marker file
    if [ ! -f "$INSTALL_DIR/$MARKER_FILE" ]; then
        error "Marker file missing"
        validation_failed=true
    else
        success "Marker file present"
    fi
    
    # Check workspace rules
    workspace_rules=$(find "$INSTALL_DIR/.cursor/rules" -name "*.mdc" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$workspace_rules" -lt 5 ]; then
        error "Workspace rules incomplete ($workspace_rules files, expected ≥5)"
        validation_failed=true
    else
        success "Workspace rules present ($workspace_rules files)"
    fi
    
    # Check shared rules
    shared_rules=$(find "$INSTALL_DIR/rules" -name "shared-*.mdc" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$shared_rules" -lt 10 ]; then
        error "Shared rules incomplete ($shared_rules files, expected ≥10)"
        validation_failed=true
    else
        success "Shared rules present ($shared_rules files)"
    fi
    
    # Check commands
    commands=$(find "$INSTALL_DIR/commands" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    if [ "$commands" -lt 5 ]; then
        error "Commands incomplete ($commands files, expected ≥5)"
        validation_failed=true
    else
        success "Commands present ($commands files)"
    fi
    
    # Check git repository
    if ! (cd "$INSTALL_DIR" && git status > /dev/null 2>&1); then
        error "Git repository invalid"
        validation_failed=true
    else
        success "Git repository valid"
    fi
    
    if [ "$validation_failed" = true ]; then
        return 1
    fi
    return 0
}

# Show success summary
show_success_summary() {
    local backup_dir=$1
    
    heading "Installation Complete!"
    echo ""
    success "Shared workspace installed at ~/.cursor"
    success "Personal settings restored"
    info "Backup saved: $backup_dir"
    echo ""
    info "Next steps:"
    info "  1. Open Cursor IDE in your project directory"
    info "  2. Run 'sync-shared-rules' command"
    info "  3. Run 'manage-cursor-rules' command"
    info "  4. Start developing with enhanced AI rules"
    echo ""
}

# Handle installation process
handle_install() {
    local force_mode=$1
    
    heading "Cursor IDE Detected"
    echo ""
    info "This will:"
    info "  1. Backup your existing .cursor directory"
    info "  2. Install shared workspace configuration"
    info "  3. Restore your personal Cursor settings"
    echo ""
    
    # Confirm installation
    read -p "Continue with installation? [Y/n] " -n 1 -r < /dev/tty
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        info "Installation cancelled"
        exit 0
    fi
    
    # Check if Cursor is running
    check_cursor_running "$force_mode"
    
    # Create backup
    heading "Creating Backup"
    local backup_dir
    backup_dir=$(create_backup)
    info "Backing up ~/.cursor to $backup_dir"
    success "Backup created: $backup_dir"
    
    # Clone repository
    clone_repository
    
    # Restore user settings
    restore_user_settings "$backup_dir"
    
    # Validate installation
    if ! validate_installation; then
        echo ""
        warning "Installation completed with validation warnings"
        warning "Some files may be missing or incomplete"
        echo ""
        info "Backup available at: $backup_dir"
        exit 1
    fi
    
    # Show success summary
    show_success_summary "$backup_dir"
}

# Uninstall mode
uninstall() {
    heading "Uninstalling Shared Workspace"
    
    if [ ! -d "$INSTALL_DIR" ]; then
        error "Installation not found at $INSTALL_DIR"
        exit 1
    fi
    
    if [ ! -f "$INSTALL_DIR/$MARKER_FILE" ]; then
        error "Not a shared workspace installation (marker file missing)"
        exit 1
    fi
    
    # Find latest backup
    local latest_backup
    latest_backup=$(ls -td "$HOME"/.cursor.backup.* 2>/dev/null | head -1)
    
    if [ -z "$latest_backup" ]; then
        warning "No backup found to restore"
        read -p "Remove installation anyway? [y/N] " -n 1 -r < /dev/tty
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            info "Uninstall cancelled"
            exit 0
        fi
        rm -rf "$INSTALL_DIR"
        success "Installation removed"
    else
        info "Found backup: $latest_backup"
        read -p "Remove installation and restore backup? [Y/n] " -n 1 -r < /dev/tty
        echo
        if [[ $REPLY =~ ^[Nn]$ ]]; then
            info "Uninstall cancelled"
            exit 0
        fi
        rm -rf "$INSTALL_DIR"
        mv "$latest_backup" "$INSTALL_DIR"
        success "Installation removed"
        success "Backup restored: $latest_backup"
    fi
    
    exit 0
}

# Main execution flow
main() {
    # Parse command line arguments
    local force_mode=false
    local uninstall_mode=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help)
                usage
                exit 0
                ;;
            --force)
                force_mode=true
                shift
                ;;
            --uninstall)
                uninstall_mode=true
                shift
                ;;
            *)
                error "Unknown option: $1"
                info "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    # Handle uninstall mode
    if [ "$uninstall_mode" = true ]; then
        uninstall
    fi
    
    # Start installation process
    heading "Cursor Shared Workspace Installer"
    
    # Check prerequisites
    check_git
    
    # Detect installation state
    local mode
    mode=$(detect_mode)
    
    # Handle based on detected mode
    case $mode in
        no_cursor)
            handle_no_cursor
            ;;
        already_installed)
            handle_already_installed
            ;;
        ready_to_install)
            handle_install "$force_mode"
            ;;
        *)
            error "Unknown installation state"
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
