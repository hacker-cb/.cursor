#!/usr/bin/env bash
set -e  # Exit immediately on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

# Color codes for nice output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Directories to keep even if empty
KEEP_DIRS=("./rules" "./commands")

# Helper functions for colorized messages
info() { echo -e "${BLUE}ℹ${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warning() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1" >&2; }
heading() { echo -e "\n${CYAN}${BOLD}$1${NC}"; }

# Usage information
usage() {
    heading "Git Repository Uninstall Script"
    cat << 'EOF'

Usage: uninstall.sh [OPTIONS]

Options:
  --help       Show this help message
  --dry-run    Preview what would be deleted without actually deleting
  --force      Skip confirmation prompt and proceed with deletion

What the Script Does:
  • Verifies current directory is a git repository
  • Lists all git-tracked files
  • Deletes all git-tracked files
  • Removes empty directories (except root rules/ and commands/)
  • Deletes .git directory
  • Works in any directory with a git repository

Safety Features:
  • Interactive confirmation by default
  • Dry-run mode to preview changes
  • Clear reporting of all actions

Examples:
  uninstall.sh                    # Interactive deletion with confirmation
  uninstall.sh --dry-run          # Preview what would be deleted
  uninstall.sh --force            # Delete without confirmation

WARNING: This operation cannot be undone! Make sure you have backups.

EOF
}

# Check if current directory is a git repository
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        error "Not a git repository"
        info "This script must be run from within a git repository"
        exit 1
    fi
}

# Get list of all git-tracked files
get_tracked_files() {
    git ls-files
}

# Check if directory should be kept
should_keep_dir() {
    local dir="$1"
    local keep_dir
    
    for keep_dir in "${KEEP_DIRS[@]}"; do
        if [ "$dir" = "$keep_dir" ]; then
            return 0
        fi
    done
    return 1
}

# Count files and directories
count_items() {
    local file_count=0
    local dir_set=()
    
    while IFS= read -r file; do
        if [ -n "$file" ]; then
            file_count=$((file_count + 1))
            # Extract directory path
            local dir=$(dirname "$file")
            if [ "$dir" != "." ]; then
                # Skip directories that will be kept
                if ! should_keep_dir "./$dir"; then
                    dir_set+=("$dir")
                fi
            fi
        fi
    done < <(get_tracked_files)
    
    # Count unique directories
    local dir_count=$(printf '%s\n' "${dir_set[@]}" | sort -u | wc -l | tr -d ' ')
    
    echo "$file_count $dir_count"
}

# Display what will be deleted
show_deletion_preview() {
    local dry_run=$1
    
    if [ "$dry_run" = true ]; then
        heading "Dry Run - Preview of Deletion"
    else
        heading "Files and Directories to Delete"
    fi
    
    local counts
    counts=$(count_items)
    local file_count=$(echo "$counts" | awk '{print $1}')
    local dir_count=$(echo "$counts" | awk '{print $2}')
    
    # Summary
    echo ""
    info "Summary:"
    echo "  • Files to delete: $file_count (all git-tracked files)"
    echo "  • Directories to remove (if empty): $dir_count"
    echo "  • Directories to keep (empty): ${#KEEP_DIRS[@]} (rules/, commands/)"
    echo "  • Git repository: .git/ (will be deleted)"
    echo ""
    warning "Note: ALL files will be deleted, including files inside rules/ and commands/"
    warning "Only the empty directory structure of rules/ and commands/ will remain"
    
    # Files to delete
    echo ""
    heading "Files to Delete"
    while IFS= read -r file; do
        if [ -n "$file" ]; then
            echo "  $file"
        fi
    done < <(get_tracked_files)
    
    # Directories to delete (if empty)
    echo ""
    heading "Directories to Remove (if empty)"
    local dir_set=()
    while IFS= read -r file; do
        if [ -n "$file" ]; then
            local dir=$(dirname "$file")
            if [ "$dir" != "." ]; then
                if ! should_keep_dir "./$dir"; then
                    dir_set+=("$dir")
                fi
            fi
        fi
    done < <(get_tracked_files)
    
    # Show unique directories
    if [ ${#dir_set[@]} -gt 0 ]; then
        printf '%s\n' "${dir_set[@]}" | sort -u | while IFS= read -r dir; do
            echo "  $dir/"
        done
    else
        echo "  (none)"
    fi
    
    # Directories to keep (empty structure only)
    echo ""
    heading "Directories to Keep (Empty Structure Only)"
    info "These directories will be preserved even after all files are deleted:"
    echo ""
    local kept_dirs=()
    local keep_dir
    for keep_dir in "${KEEP_DIRS[@]}"; do
        kept_dirs+=("${keep_dir#./}")
    done
    
    if [ ${#kept_dirs[@]} -gt 0 ]; then
        for dir in "${kept_dirs[@]}"; do
            echo "  $dir/ (empty directory)"
        done
    else
        echo "  (none)"
    fi
    
    # Git directory
    echo ""
    heading "Git Repository"
    echo "  .git/ (will be deleted)"
    echo ""
}

# Delete all tracked files
delete_tracked_files() {
    local deleted_count=0
    local failed_count=0
    
    info "Deleting tracked files..."
    
    while IFS= read -r file; do
        if [ -n "$file" ]; then
            if [ -f "$file" ] || [ -L "$file" ]; then
                if rm "$file" 2>/dev/null; then
                    deleted_count=$((deleted_count + 1))
                else
                    warning "Failed to delete: $file"
                    failed_count=$((failed_count + 1))
                fi
            fi
        fi
    done < <(get_tracked_files)
    
    success "Deleted $deleted_count file(s)"
    
    if [ $failed_count -gt 0 ]; then
        warning "$failed_count file(s) could not be deleted"
    fi
}

# Remove empty directories
remove_empty_dirs() {
    local removed_count=0
    
    info "Removing empty directories..."
    
    # Find and remove empty directories (bottom-up)
    # We need to do this multiple times to handle nested empty directories
    # Skip directories listed in KEEP_DIRS
    local found_empty=true
    while [ "$found_empty" = true ]; do
        found_empty=false
        while IFS= read -r dir; do
            # Skip directories that should be kept
            if should_keep_dir "$dir"; then
                continue
            fi
            
            if [ -d "$dir" ] && [ -z "$(ls -A "$dir" 2>/dev/null)" ]; then
                if rmdir "$dir" 2>/dev/null; then
                    removed_count=$((removed_count + 1))
                    found_empty=true
                fi
            fi
        done < <(find . -type d -not -path "./.git/*" -not -path "./.git" | sort -r)
    done
    
    if [ $removed_count -gt 0 ]; then
        success "Removed $removed_count empty director(ies)"
    else
        info "No empty directories to remove"
    fi
    
    # Report on kept directories
    local kept_dirs=()
    local keep_dir
    for keep_dir in "${KEEP_DIRS[@]}"; do
        if [ -d "$keep_dir" ]; then
            kept_dirs+=("${keep_dir#./}")
        fi
    done
    
    if [ ${#kept_dirs[@]} -gt 0 ]; then
        local dirs_list=$(printf ", %s/" "${kept_dirs[@]}")
        dirs_list="${dirs_list:2}"  # Remove leading ", "
        info "Kept directories: $dirs_list (preserved even if empty)"
    fi
}

# Delete .git directory
delete_git_dir() {
    info "Removing .git directory..."
    
    if [ -d ".git" ]; then
        if rm -rf ".git"; then
            success "Removed .git directory"
        else
            error "Failed to remove .git directory"
            return 1
        fi
    else
        warning ".git directory not found"
    fi
}

# Confirm deletion
confirm_deletion() {
    warning "This will permanently delete all git-tracked files and the .git directory!"
    warning "This operation CANNOT be undone!"
    echo ""
    read -p "Are you sure you want to proceed? Type 'yes' to confirm: " -r
    echo
    
    if [ "$REPLY" != "yes" ]; then
        info "Deletion cancelled"
        exit 0
    fi
}

# Main execution flow
main() {
    # Parse command line arguments
    local dry_run=false
    local force_mode=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --help)
                usage
                exit 0
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            --force)
                force_mode=true
                shift
                ;;
            *)
                error "Unknown option: $1"
                info "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    heading "Git Repository Uninstall"
    
    # Check prerequisites
    check_git_repo
    
    # Show current directory
    info "Working directory: $(pwd)"
    echo ""
    
    # Show what will be deleted
    show_deletion_preview "$dry_run"
    
    # Handle dry-run mode
    if [ "$dry_run" = true ]; then
        heading "Dry Run Complete"
        info "No files were deleted (dry-run mode)"
        info "Run without --dry-run to perform actual deletion"
        exit 0
    fi
    
    # Confirm deletion (unless force mode)
    if [ "$force_mode" = false ]; then
        confirm_deletion
    fi
    
    # Perform deletion
    heading "Deleting Repository Contents"
    echo ""
    
    delete_tracked_files
    remove_empty_dirs
    delete_git_dir
    
    # Show completion
    heading "Uninstall Complete!"
    echo ""
    success "All git-tracked files deleted"
    success "Git repository removed"
    echo ""
}

# Run main function with all arguments
main "$@"
