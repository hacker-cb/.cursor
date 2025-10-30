# Analyze Project Structure

## Overview
Deep analysis of project structure, framework conventions, dependencies, configuration, and best practices with interactive fix recommendations.

## Steps

### 1. Detect Project Composition
- Identify single-component or multi-component project
- Check for monorepo indicators (workspaces, multiple manifests)
- Detect microservices architecture patterns
- List components with root directories
- Identify language, framework, and build tools per component

### 2. Analyze Structure & Organization
- Verify folder structure matches framework conventions
- Check source, test, and documentation directories
- Validate file naming conventions
- Review module/package organization hierarchy
- Verify separation of concerns
- Check for circular dependencies
- Review inter-component communication patterns

### 3. Audit Dependencies
- List dependencies with version specifications per component
- Verify versions are pinned across components
- Scan for security vulnerabilities
- Identify outdated packages
- Review dev vs production dependency separation
- Check for unused dependencies
- Verify shared dependency consistency

### 4. Review Configuration
- Verify environment variable usage and templates
- Check linting and formatting configuration
- Review CI/CD pipeline configuration
- Verify containerization configuration if present
- Check gitignore coverage for sensitive files
- Review editor configuration consistency
- Validate monorepo workspace configuration

### 5. Evaluate Code Quality Tools
- Check linting tool setup per component
- Verify code formatting tool integration
- Review static type checking if supported
- Check pre-commit hook configuration
- Verify test framework integration
- Check code coverage reporting aggregation

### 6. Assess Testing Infrastructure
- Identify test framework and runner per component
- Check test directory structure
- Review coverage configuration and thresholds
- Verify integration tests within components
- Check end-to-end tests across components
- Verify test execution scripts

### 7. Review Documentation
- Check README completeness (setup, usage, contributing)
- Verify API documentation exists and is current
- Check changelog or release notes
- Review inline comments for complex logic
- Verify license file present
- Check contribution guidelines

### 8. Security & Privacy Audit
- Scan for hardcoded secrets and credentials
- Review gitignore for sensitive patterns
- Check authentication and authorization
- Verify input validation across entry points
- Review error handling for information leakage
- Check cross-origin resource configuration
- Verify secure dependency sources

### 9. Build & Deployment
- Check build scripts execute successfully
- Verify deployment configuration completeness
- Review containerization setup
- Check environment-specific configuration
- Verify production optimization settings

### 10. Generate Report & Offer Fixes
- Compile findings by severity level
- List issues with affected file paths
- Provide actionable recommendations
- Offer to fix issues interactively
- Prioritize by impact and effort

## Checklist
- [ ] Project composition identified
- [ ] Components and technologies detected
- [ ] Folder structure analyzed
- [ ] Dependencies audited
- [ ] Configuration reviewed
- [ ] Code quality tools verified
- [ ] Testing infrastructure assessed
- [ ] Documentation checked
- [ ] Security audit completed
- [ ] Build and deployment reviewed
- [ ] Comprehensive report generated
- [ ] Fixes offered interactively

