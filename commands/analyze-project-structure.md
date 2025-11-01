# Analyze Project Structure

## Overview
Comprehensive analysis of project architecture, dependencies, configuration, code quality, testing, security, and deployment setup with prioritized fix recommendations.

## Steps

### 1. Detect Project Composition
- Use `git ls-files` to identify tracked project structure
- Identify architecture type: single-component, multi-component, monorepo
- Check for monorepo indicators: workspaces, multiple package manifests
- Detect microservices patterns and component boundaries
- List components with root directories
- Identify language, framework, and build tools per component

### 2. Analyze Structure and Organization
- Verify folder structure matches framework conventions
- Check source, test, config, and documentation directory organization
- Validate file naming conventions across project
- Review module/package hierarchy and organization
- Verify separation of concerns (layers, features, modules)
- Check for circular dependencies between modules
- Review inter-component communication patterns if multi-component

### 3. Audit Dependencies
- List all dependencies with version specifications per component
- Verify dependency versions are pinned (not using ranges)
- Scan for known security vulnerabilities in dependencies
- Identify outdated packages with available updates
- Review dev vs production dependency separation
- Check for unused or unnecessary dependencies
- Verify shared dependency version consistency across components
- Check dependency sources are trustworthy

### 4. Review Configuration
- Verify environment variables used properly (check for .env templates)
- Check linting and formatting tool configuration
- Review CI/CD pipeline configuration and workflows
- Verify containerization setup if present (Dockerfile, compose files)
- Check gitignore coverage for sensitive files and artifacts
- Review editor configuration for team consistency
- Validate monorepo workspace configuration if applicable

### 5. Evaluate Code Quality Setup
- Check linting tools configured and working
- Verify code formatting tools integrated
- Review static type checking setup if language supports it
- Check pre-commit hooks configured
- Verify test framework integration
- Check code coverage reporting and thresholds

### 6. Assess Testing Infrastructure
- Identify test frameworks and runners per component
- Check test directory structure and organization
- Review coverage configuration, thresholds, and reporting
- Verify unit tests present and organized
- Check integration tests within components
- Check end-to-end tests across components
- Verify test execution scripts in package manifest
- **Note:** To add missing tests systematically, see `add-test-coverage`

### 7. Review Documentation
- Check README completeness: setup, usage, architecture, contributing
- Verify API documentation exists and is current
- Check changelog or release notes maintained
- Review inline code comments for complex logic
- Verify license file present
- Check contribution guidelines if open source or team project

### 8. Security and Privacy Audit
- Scan for hardcoded secrets, credentials, API keys
- Review gitignore for sensitive file patterns
- Check authentication and authorization implementation
- Verify input validation across all entry points
- Review error handling for information leakage
- Check CORS and cross-origin policies
- Verify dependency sources are secure and official
- **Note:** For comprehensive security review, see `security-audit`

### 9. Build and Deployment
- Verify build scripts execute successfully
- Check deployment configuration completeness
- Review containerization and orchestration setup
- Check environment-specific configuration handling
- Verify production optimization settings (minification, bundling, etc.)
- Review deployment automation and CI/CD integration

### 10. Generate Report and Offer Fixes
- Compile findings by severity: Critical, High, Medium, Low, Info
- List issues with affected file paths and line numbers
- Provide actionable recommendations for each issue
- Prioritize fixes by impact and implementation effort
- Offer to fix issues interactively with user confirmation
- Generate summary with counts by severity and category
- **Note:** After analysis, consider running `manage-cursor-rules` to update project rules based on findings

## Checklist
- [ ] Project composition and architecture identified
- [ ] Structure and organization analyzed
- [ ] Dependencies audited for security and versions
- [ ] Configuration files reviewed
- [ ] Code quality tools verified
- [ ] Testing infrastructure assessed
- [ ] Documentation completeness checked
- [ ] Security and privacy audit completed
- [ ] Build and deployment configuration reviewed
- [ ] Report generated with prioritized recommendations
- [ ] Interactive fixes offered to user
