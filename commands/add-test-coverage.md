# Add Test Coverage

## Overview
Analyze project for test coverage gaps, suggest testing frameworks if missing, identify missing tests by priority, and implement tests systematically.

## Steps

### 1. Analyze Testing Infrastructure
- Scan dependency files for test frameworks
- Check test runner configurations
- Identify test directories and naming conventions
- List components without testing setup

### 2. Suggest Missing Frameworks
- For components without tests, suggest appropriate frameworks
- Present options with pros/cons (speed, features, community)
- Let user choose before proceeding
- Skip if frameworks already configured

### 3. Discover Project Components
- Scan by tech stack layers (frontend, backend, API, database)
- Map directory and module structure
- Identify file types (controllers, services, models, utilities)
- Create component inventory by category

### 4. Analyze Existing Coverage
- Map test files to source components
- Calculate coverage by component type
- Identify untested code paths
- Categorize test types (unit, integration, e2e, security, performance)

### 5. Identify Missing Tests by Priority
- **Critical**: Authentication/authorization, data validation, security-sensitive code, payment/financial operations, core business logic
- **Suggested**: API endpoints, database operations, error handling, state management, integration points
- **Nice-to-have**: Utility functions, helpers, simple components, formatting functions
- **Non-required**: Trivial getters/setters, generated code, external library wrappers

### 6. Present Analysis and Get Selection
- Show framework status per component
- Display coverage summary by category
- List missing tests by priority with file paths
- Let user decide which priority levels to implement

### 7. Implement Selected Tests
- Generate test files following project conventions
- Use appropriate test structure from existing patterns
- Include setup/teardown if needed
- Add test data and fixtures
- Run tests and fix failures

## Best Practices

### Framework Detection
- Check dependency files and config files
- Scan for test directories with common patterns
- Identify existing naming conventions

### Component Discovery
- Use `git ls-files` as source of truth
- Parse imports to understand dependencies
- Identify entry points and critical paths

### Priority Classification
- **Critical**: Auth, payment, security, external APIs
- **Suggested**: Business logic, controllers, models, services
- **Nice-to-have**: Utilities, formatters, presentational components
- **Non-required**: Generated files, type definitions, configs

### Test Generation
- Follow project naming conventions
- Match existing test patterns
- Use meaningful descriptions
- Include edge case assertions
- Add comments for complex scenarios

## Checklist

### Analysis
- [ ] Git repository verified
- [ ] Test frameworks detected
- [ ] Missing frameworks identified
- [ ] User selected frameworks
- [ ] Components discovered and mapped
- [ ] Existing coverage calculated

### Gap Identification
- [ ] Critical missing tests identified
- [ ] Suggested missing tests listed
- [ ] Nice-to-have tests noted
- [ ] User selected priority levels

### Implementation
- [ ] Test files created
- [ ] Tests implemented
- [ ] All tests executed successfully
- [ ] Coverage report generated
