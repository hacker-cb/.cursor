# Add Test Coverage

## Overview
Analyze project for test coverage gaps, suggest testing frameworks if missing, identify missing tests by priority, and implement tests systematically with user-guided selection.

## Steps

### 1. Analyze Testing Infrastructure
- Scan dependency files for test frameworks
- Check test runner configurations
- Identify test directories and naming conventions
- Verify `git ls-files` for test file patterns
- List components without testing setup
- Note: If no frameworks found, proceed to step 2

### 2. Suggest Testing Frameworks (if missing)
- Identify components without test frameworks
- Suggest appropriate frameworks with trade-offs:
  - Speed and performance characteristics
  - Feature set and ecosystem
  - Community support and documentation
- Present options and let user choose
- Skip if frameworks already configured

### 3. Discover and Map Components
- Use `git ls-files` as source of truth for tracked files
- Scan by tech stack layers: frontend, backend, API, database
- Identify file types: controllers, services, models, utilities, components
- Parse imports to understand dependencies
- Identify entry points and critical paths
- Create component inventory by category

### 4. Analyze Existing Coverage
- Map test files to source components
- Calculate coverage by component type
- Identify untested code paths and files
- Categorize existing tests: unit, integration, e2e, security, performance
- Generate coverage gaps summary

### 5. Identify Missing Tests by Priority
Classify untested components by risk and importance:

**Critical** (must test):
- Authentication and authorization flows
- Data validation and sanitization
- Security-sensitive operations
- Payment and financial transactions
- Core business logic and algorithms

**Suggested** (should test):
- API endpoints and routes
- Database operations and queries
- Error handling and recovery
- State management logic
- Integration points between modules

**Nice-to-have** (optional):
- Utility functions and helpers
- Simple presentational components
- Formatting and display functions
- Configuration helpers

**Non-required** (skip):
- Trivial getters and setters
- Generated or scaffolded code
- External library wrappers
- Type definitions

### 6. Present Analysis and Get Selection
- Show framework status per component
- Display coverage summary by category and priority
- List missing tests with file paths
- Present estimated effort per priority level
- Ask user: "Which priority levels should I implement? (Critical/Suggested/Nice-to-have)"
- Confirm selection before proceeding

### 7. Implement Selected Tests
- Generate test files following project naming conventions
- Match existing test patterns and structure
- Include setup/teardown hooks if needed
- Add test data, fixtures, and mocks
- Write tests with meaningful descriptions
- Include edge case assertions
- Add comments for complex test scenarios
- Run tests and fix any failures
- Generate final coverage report

## Checklist
- [ ] Testing infrastructure analyzed
- [ ] Missing frameworks suggested and user selected
- [ ] Components discovered and mapped
- [ ] Existing coverage calculated
- [ ] Missing tests identified by priority
- [ ] User selected priority levels to implement
- [ ] Test files created following conventions
- [ ] Tests implemented and passing
- [ ] Coverage report generated
