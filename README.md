# Cursor Developer Configuration

[![Test Installation Script](https://github.com/hacker-cb/.cursor/actions/workflows/test-install.yml/badge.svg)](https://github.com/hacker-cb/.cursor/actions/workflows/test-install.yml)

A personal Cursor IDE configuration with strict AI agent policies and reusable development workflows.

## Features

- **Strict AI Boundaries** - Git-only access policy protects privacy and sensitive data
- **Universal Standards** - Framework-agnostic development rules for any tech stack
- **Workflow Automation** - Ready-to-use command templates for common tasks
- **Self-Maintaining** - Automatic documentation synchronization
- **Easy Distribution** - One-command sync to any project

**Note:** This project is located in the home directory at `~/.cursor`

## Installation

**Prerequisites:** Install [Cursor IDE](https://cursor.sh) first

**Quick Install:**

```bash
# Using curl
bash <(curl -fsSL https://raw.githubusercontent.com/hacker-cb/.cursor/master/install.sh)

# Using wget
bash <(wget -qO- https://raw.githubusercontent.com/hacker-cb/.cursor/master/install.sh)
```

The script will:
- Backup your existing `.cursor` directory
- Install shared workspace configuration  
- Automatically restore your personal settings

See [INSTALL.md](INSTALL.md) for detailed instructions and troubleshooting.

## Quick Start

### Setup Your Project

1. **Navigate to your project** directory
2. **Run `sync-shared-rules`** to get universal development rules
3. **Run `manage-cursor-rules`** to generate/validate project-specific rules
4. **Review and customize** rules in `.cursor/rules/`

The setup process works for both new and existing projects - the commands automatically detect and adapt.

### Shared Rules

The shared rules provide universal guidance:
- Rules and commands management
- Version control and collaboration
- Development workflow (planning, features, bugs, refactoring)
- Code quality and standards
- Testing conventions
- Security practices
- Documentation standards
- Environment setup
- Release management

See [`rules/`](rules/) directory for all shared rules.

## Commands

Workflow templates that guide development tasks. All commands are framework-agnostic and adapt to your project.

### System Commands

Workspace maintenance and setup:

| Command | Status | Description |
|---------|--------|-------------|
| [**sync&#8209;shared&#8209;rules**](commands/sync-shared-rules.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | One-way sync of shared developer rules from this workspace (`~/.cursor/rules/`) to a target project's `.cursor/rules/` directory. Handles conflicts interactively. |
| [**manage&#8209;cursor&#8209;rules**](commands/manage-cursor-rules.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Analyze project and manage cursor rules. For new projects: generates rules from scratch. For existing: validates and refactors against current codebase, or quickly cleans up outdated content. |
| [**display&#8209;rules&#8209;summary**](commands/display-rules-summary.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Scan and display all Cursor rules with their apply modes, descriptions, and metadata. Helps understand which rules are active and their configuration. |

### Git & CI/CD Commands

Version control and continuous integration workflows:

| Command | Status | Description |
|---------|--------|-------------|
| [**merge&#8209;squash&#8209;push**](commands/merge-squash-push.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Interactive squash merge workflow with automatic base branch detection, change summary, and confirmation prompts. Follows git workflow standards for clean commit history |
| [**github&#8209;workflow&#8209;autofix**](commands/github-workflow-autofix.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Analyzes GitHub workflow runs, watches for failed runs, and automatically applies fixes until all workflows pass. If any workflow is currently running, it waits for the result before proceeding, then handles failures iteratively |

### Code Quality Commands

Analysis and review workflows:

| Command | Status | Description |
|---------|--------|-------------|
| [**code&#8209;review**](commands/code-review.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Comprehensive code review workflow covering functionality, quality, security, performance, testing, and documentation to ensure changes meet project standards before merge |
| [**analyze&#8209;project&#8209;structure**](commands/analyze-project-structure.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Comprehensive analysis of project architecture, dependencies, configuration, code quality, testing, security, and deployment setup with prioritized fix recommendations |

### Testing & Security Commands

Testing coverage and security audit workflows:

| Command | Status | Description |
|---------|--------|-------------|
| [**add&#8209;test&#8209;coverage**](commands/add-test-coverage.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Analyze project for test coverage gaps, suggest testing frameworks if missing, identify missing tests by priority, and implement tests systematically with user-guided selection |
| [**security&#8209;audit**](commands/security-audit.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Comprehensive security review to identify and fix vulnerabilities in dependencies, code, authentication, authorization, data handling, and infrastructure configuration using industry best practices |
