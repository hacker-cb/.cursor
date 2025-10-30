# Analyze Project Structure

## Overview
Deep analysis of project structure, framework conventions, dependencies, configuration, and best practices with interactive fix recommendations.

## Steps

### 1. Detect Project Composition
- Identify if single-component or multi-component project
- Check for monorepo indicators (workspaces, multiple manifests)
- Detect microservices architecture patterns
- List all components with their root directories
- For each component: identify language, framework, and build tools

### 2. Analyze Structure & Organization
- For each component: verify folder structure matches framework conventions
- Check source, test, and documentation directories per component
- Validate file naming conventions align with language standards
- Review module/package organization hierarchy
- Verify separation of concerns across layers
- Check for circular dependencies within and across components
- Review inter-component communication patterns if applicable

### 3. Audit Dependencies
- For each component: list dependencies with version specifications
- Verify versions are properly pinned across all components
- Scan for known security vulnerabilities
- Identify outdated packages requiring updates
- Review separation of development vs production dependencies
- Check for unused dependencies
- Verify consistency of shared dependencies in multi-component projects

### 4. Review Configuration
- Verify environment variable usage and templates per component
- Check linting and formatting configuration exists for each language
- Review CI/CD pipeline configuration and multi-component build orchestration
- Verify containerization configuration if present
- Check gitignore coverage for sensitive files
- Review editor configuration consistency across components
- Validate monorepo workspace configuration if applicable

### 5. Evaluate Code Quality Tools
- For each component: check linting tool setup and configuration
- Verify code formatting tool integration per language
- Review static type checking if supported
- Check pre-commit hook configuration covers all components
- Verify test framework integration for each component
- Check code coverage reporting aggregation for multi-component projects

### 6. Assess Testing Infrastructure
- For each component: identify test framework and runner
- Check test directory structure organization per component
- Review test coverage configuration and thresholds
- Verify integration tests within components
- Check end-to-end tests across components if applicable
- Verify test execution scripts handle all components

### 7. Review Documentation
- Check README completeness (setup, usage, contributing)
- Verify API documentation exists and is current
- Check for changelog or release notes
- Review inline code comments for complex logic
- Verify license file present
- Check contribution guidelines exist

### 8. Security & Privacy Audit
- Scan for hardcoded secrets and credentials
- Review gitignore for sensitive file patterns
- Check authentication and authorization implementation
- Verify input validation across entry points
- Review error handling for information leakage
- Check cross-origin resource configuration
- Verify secure dependency sources

### 9. Build & Deployment
- Check build scripts exist and execute successfully
- Verify deployment configuration completeness
- Review containerization setup if used
- Check environment-specific configuration handling
- Verify production optimization settings

### 10. Generate Report & Offer Fixes
- Compile findings categorized by severity level
- List specific issues with affected file paths
- Provide actionable recommendations for each issue
- Offer to fix issues interactively with user confirmation
- Prioritize fixes by impact and effort required

## Checklist
- [ ] Project composition identified (single/multi-component)
- [ ] All components and their technologies detected
- [ ] Folder structure analyzed for each component
- [ ] Dependencies audited across all components
- [ ] Configuration reviewed for consistency
- [ ] Code quality tools verified per component
- [ ] Testing infrastructure assessed comprehensively
- [ ] Documentation completeness checked
- [ ] Security audit completed
- [ ] Build and deployment reviewed
- [ ] Cross-component concerns evaluated
- [ ] Comprehensive report generated
- [ ] Fixes offered and applied interactively

