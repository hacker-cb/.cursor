# Add Test Coverage

## Overview
Analyze project components for test coverage gaps, suggest testing frameworks if missing, identify missing tests by priority level, and guide systematic test implementation.

## Steps

### 1. Analyze testing infrastructure
   - Scan dependency files for test frameworks
   - Check for test runner configurations
   - Identify test directories and naming conventions
   - List components without testing setup

### 2. Suggest missing frameworks (if needed)
   - For each component type without tests, suggest appropriate frameworks
   - Present multiple options with pros/cons (speed, features, community support)
   - Let user choose frameworks before proceeding
   - Skip if all frameworks already configured

### 3. Discover project components
   - Scan by tech stack layers (frontend, backend, API, database)
   - Map directory and module structure
   - Identify files by type (controllers, services, models, utilities, components)
   - Create component inventory grouped by category

### 4. Analyze existing test coverage
   - Map test files to source components
   - Calculate coverage by component type
   - Identify untested code paths
   - Categorize test types present (unit, integration, e2e, security, performance)

### 5. Identify missing tests by priority
   - **Critical**: Authentication/authorization, data validation, security-sensitive code, payment/financial operations, core business logic
   - **Suggested**: API endpoints, database operations, error handling, state management, integration points
   - **Nice-to-have**: Utility functions, helpers, simple UI components, formatting functions
   - **Non-required**: Trivial getters/setters, generated code, external library wrappers

### 6. Present analysis and get user selection
   - Show test framework status per component
   - Display coverage summary by category
   - List missing tests by priority with file paths
   - Let user decide which priority levels to implement

### 7. Implement selected tests
   - Generate test files following project conventions
   - Use appropriate test structure from existing patterns
   - Include setup/teardown if needed
   - Add test data and fixtures
   - Run tests and fix failures

## Implementation Guidelines

### Framework Detection
- Check dependency files for test libraries
- Look for test config files in project root
- Scan for test directories using common patterns
- Identify test file naming conventions

### Component Discovery
- Use `git ls-files` as source of truth
- Parse imports to understand dependencies
- Identify entry points and critical paths
- Consider project architectural patterns

### Priority Classification
- **Critical**: Files with auth, payment, security keywords; external API calls
- **Suggested**: Business logic layers, controllers, models, services
- **Nice-to-have**: Utilities, formatters, presentational components
- **Non-required**: Generated files, type definitions, configuration files

### Test Generation
- Follow detected project naming conventions
- Match existing test patterns for consistency
- Use meaningful test descriptions
- Include assertions for expected behavior and edge cases
- Add comments for complex test scenarios

## Test Coverage Checklist

### Prerequisites
- [ ] Git repository verified
- [ ] Source files identified

### Infrastructure Analysis
- [ ] Test frameworks detected per component
- [ ] Missing frameworks identified
- [ ] User selected frameworks (if needed)

### Component Analysis
- [ ] Components discovered by layer
- [ ] Components mapped by module
- [ ] Components grouped by type
- [ ] Existing coverage calculated

### Gap Analysis
- [ ] Critical missing tests identified
- [ ] Suggested missing tests listed
- [ ] Nice-to-have tests noted
- [ ] Non-required tests cataloged
- [ ] User selected priority levels

### Implementation
- [ ] Test files created following conventions
- [ ] Tests implemented with proper structure
- [ ] All tests executed successfully
- [ ] Coverage report generated

