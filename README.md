# Cursor Developer Configuration

A personal Cursor IDE configuration repository that enforces strict AI agent behavior policies through `.mdc` rule files and provides reusable workflow command templates for common development tasks. Features a git-only access policy to protect privacy, framework-agnostic development best practices, and self-maintaining documentation with automatic README synchronization.

**Note:** This project is located in the home directory at `~/.cursor`

## Available Commands

The [`commands/`](commands/) directory contains workflow templates for common development tasks:

| Command | Status | Description |
|---------|--------|-------------|
| [**add&#8209;test&#8209;coverage**](commands/add-test-coverage.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Analyze project for test coverage gaps, suggest testing frameworks if missing, identify missing tests by priority, and implement tests systematically |
| [**analyze&#8209;project&#8209;structure**](commands/analyze-project-structure.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Deep analysis of project structure, framework conventions, dependencies, configuration, and best practices with interactive fix recommendations |
| [**code&#8209;review**](commands/code-review.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Comprehensive code review process to ensure functionality, quality, security, performance, testing, and documentation meet project standards |
| [**create&#8209;pull&#8209;request**](commands/create-pull-request.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Create a well-structured pull request with comprehensive description, proper metadata, and review checklist to facilitate smooth code review |
| [**github&#8209;workflow&#8209;autofix**](commands/github-workflow-autofix.md) | ![Stable](https://img.shields.io/badge/status-stable-green) | Analyzes GitHub workflow runs, watches for failed runs, and automatically applies fixes until all workflows pass. If any workflow is currently running, it waits for the result before proceeding, then handles failures iteratively |
| [**init&#8209;cursor&#8209;rules**](commands/init-cursor-rules.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Analyze a project and generate tech-stack-specific Cursor rules as `.mdc` files in `.cursor/rules/` directory based on detected patterns, conventions, and architecture |
| [**onboard&#8209;new&#8209;developer**](commands/onboard-new-developer.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Comprehensive onboarding process to get a new developer up and running with proper environment setup, project understanding, and first contribution |
| [**refactor&#8209;cursor&#8209;rules**](commands/refactor-cursor-rules.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Analyze project tech stack and refactor `.cursor/rules/*.mdc` files to match the project by removing duplicates, irrelevant rules, and unnecessary examples. Update metadata for precise application |
| [**run&#8209;tests&#8209;and&#8209;fix&#8209;failures**](commands/run-tests-and-fix-failures.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Execute full test suite, analyze failures systematically, fix issues by priority, and ensure all tests pass with proper validation |
| [**security&#8209;audit**](commands/security-audit.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Comprehensive security review to identify and fix vulnerabilities in dependencies, code, authentication, data handling, and infrastructure configuration |
| [**setup&#8209;new&#8209;feature**](commands/setup-new-feature.md) | ![WIP](https://img.shields.io/badge/status-WIP-yellow) | Systematically set up a new feature from requirements gathering through implementation structure and testing strategy |

## Shared Rules

The [`rules/`](rules/) directory contains common shared developer rules that can be synced to any project using the `sync-shared-rules` command. These rules are project-independent, framework-agnostic, and cover universal development best practices.

---

*This workspace enforces a git-only policy for AI agent access to protect privacy and security.*
