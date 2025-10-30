# Run Tests and Fix Failures

## Overview
Execute full test suite, analyze failures systematically, fix issues by priority, and ensure all tests pass with proper validation.

## Steps

### 1. Prepare Test Environment
- Verify development environment is set up
- Ensure test dependencies installed
- Check test database is configured
- Clear previous test artifacts
- Verify test configuration is correct

### 2. Run Full Test Suite
- Execute all unit tests
- Run integration tests
- Execute end-to-end tests if present
- Capture complete output and logs
- Note execution time and performance

### 3. Analyze Test Results
- Identify all failing tests
- Categorize by type (unit, integration, e2e)
- Determine if flaky, broken, or new failures
- Check if related to recent code changes
- Identify patterns in failures
- Prioritize by impact and severity

### 4. Investigate Root Causes
- Read failure messages and stack traces
- Check test code for issues
- Review related source code changes
- Verify test data and fixtures
- Check for environment-specific issues
- Identify dependencies between failing tests

### 5. Fix Issues Systematically
- Start with critical failures
- Fix one issue at a time
- Update source code if logic broken
- Update tests if expectations changed
- Fix test data or fixtures if needed
- Add comments explaining complex fixes

### 6. Verify Fixes
- Re-run specific fixed tests
- Ensure fix doesn't break other tests
- Check test execution time remains reasonable
- Verify no new warnings introduced
- Run full suite after each major fix

### 7. Handle Flaky Tests
- Identify intermittent failures
- Add proper waits or synchronization
- Improve test isolation
- Fix race conditions
- Consider marking or quarantining if needed

### 8. Update and Document
- Update test documentation if needed
- Add comments for non-obvious fixes
- Update changelog if fixing regressions
- Commit fixes with descriptive messages
- Update CI configuration if needed

## Best Practices

### Debugging
- Run failing test in isolation first
- Use debugger for complex failures
- Add temporary logging if needed
- Check for timing or race conditions
- Verify test assumptions are valid

### Fixing
- Preserve test intent when updating
- Don't remove failing assertions without understanding
- Ensure fixes address root cause, not symptoms
- Keep tests fast and focused
- Maintain test independence

## Checklist

### Preparation
- [ ] Test environment verified
- [ ] Test dependencies installed
- [ ] Test configuration correct

### Execution
- [ ] Unit tests executed
- [ ] Integration tests run
- [ ] E2E tests completed
- [ ] Results captured

### Analysis
- [ ] All failures identified
- [ ] Failures categorized by type
- [ ] Root causes investigated
- [ ] Failures prioritized

### Fixing
- [ ] Critical issues fixed
- [ ] Flaky tests handled
- [ ] All tests passing
- [ ] No new warnings

### Validation
- [ ] Full suite passes
- [ ] Performance acceptable
- [ ] Changes documented
- [ ] Fixes committed