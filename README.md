# Cursor Developer Configuration

A personal Cursor IDE configuration repository that enforces strict AI agent behavior policies through `.mdc` rule files and provides reusable workflow command templates for common development tasks. Features a git-only access policy to protect privacy, framework-agnostic development best practices, and self-maintaining documentation with automatic README synchronization.

**Note:** This project is located in the home directory at `~/.cursor`

## Quick Start

### For New Projects

1. Navigate to your project directory
2. Run `sync-shared-rules` command to get universal development rules
3. Run `setup-cursor-rules` command to generate project-specific rules
4. Review and customize generated rules in `.cursor/rules/`

### For Existing Projects

1. Navigate to your project directory
2. Run `sync-shared-rules` to get or update shared rules
3. Run `setup-cursor-rules` to validate and refactor existing rules
4. Review refactored rules and start new agent session

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

## System Commands

Workspace maintenance commands:

| Command | Status | Description |
|---------|--------|-------------|
| [**sync&#8209;shared&#8209;rules**](commands/sync-shared-rules.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | One-way sync of shared developer rules from this workspace (`~/.cursor/rules/`) to a target project's `.cursor/rules/` directory. |
| [**setup&#8209;cursor&#8209;rules**](commands/setup-cursor-rules.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Analyze project and setup cursor rules. For new projects: generates rules from scratch. For existing: validates and refactors against current codebase. |

## Development Commands

The [`commands/`](commands/) directory contains workflow templates for common development tasks:

| Command | Status | Description |
|---------|--------|-------------|
| [**add&#8209;test&#8209;coverage**](commands/add-test-coverage.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Analyze project for test coverage gaps, suggest testing frameworks if missing, identify missing tests by priority, and implement tests systematically |
| [**analyze&#8209;project&#8209;structure**](commands/analyze-project-structure.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Deep analysis of project structure, framework conventions, dependencies, configuration, and best practices with interactive fix recommendations |
| [**code&#8209;review**](commands/code-review.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Comprehensive code review process to ensure functionality, quality, security, performance, testing, and documentation meet project standards |
| [**create&#8209;pull&#8209;request**](commands/create-pull-request.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Create a well-structured pull request with comprehensive description, proper metadata, and review checklist to facilitate smooth code review |
| [**github&#8209;workflow&#8209;autofix**](commands/github-workflow-autofix.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Analyzes GitHub workflow runs, watches for failed runs, and automatically applies fixes until all workflows pass. If any workflow is currently running, it waits for the result before proceeding, then handles failures iteratively |
| [**onboard&#8209;new&#8209;developer**](commands/onboard-new-developer.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Comprehensive onboarding process to get a new developer up and running with proper environment setup, project understanding, and first contribution |
| [**run&#8209;tests&#8209;and&#8209;fix&#8209;failures**](commands/run-tests-and-fix-failures.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Execute full test suite, analyze failures systematically, fix issues by priority, and ensure all tests pass with proper validation |
| [**security&#8209;audit**](commands/security-audit.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Comprehensive security review to identify and fix vulnerabilities in dependencies, code, authentication, data handling, and infrastructure configuration |
| [**setup&#8209;new&#8209;feature**](commands/setup-new-feature.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Systematically set up a new feature from requirements gathering through implementation structure and testing strategy |

---

*This workspace enforces a git-only policy for AI agent access to protect privacy and security.*
