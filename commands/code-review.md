# Code Review

## Overview
Comprehensive code review process to ensure functionality, quality, security, performance, testing, and documentation meet project standards.

## Steps

### 1. Understand Context
- Read PR description and linked issues
- Understand the problem being solved
- Review user stories or requirements
- Check if approach aligns with architecture
- Identify affected areas of codebase

### 2. Review Functionality
- Verify code implements stated requirements
- Check logic correctness
- Test edge cases and boundary conditions
- Verify error handling is appropriate
- Check for potential bugs or logic errors
- Ensure no unintended side effects

### 3. Assess Code Quality
- Check code readability and clarity
- Verify functions are small and focused
- Ensure descriptive variable and function names
- Check for code duplication (DRY principle)
- Verify proper separation of concerns
- Ensure code follows project conventions
- Check for proper abstraction levels

### 4. Review Security
- Check for security vulnerabilities
- Verify input validation is present
- Ensure sensitive data handled properly
- Check for SQL injection risks
- Verify XSS protection
- Ensure no hardcoded secrets
- Check authorization and authentication
- Review error messages for information leakage

### 5. Evaluate Performance
- Check for performance issues
- Review database query efficiency
- Check for N+1 query problems
- Verify proper use of caching
- Check memory usage patterns
- Review algorithm complexity
- Ensure no unnecessary computations

### 6. Review Testing
- Verify tests cover new functionality
- Check test quality and clarity
- Ensure tests cover edge cases
- Verify tests are isolated and independent
- Check for proper test data setup
- Ensure tests follow project patterns
- Verify meaningful test descriptions

### 7. Check Documentation
- Verify complex logic is commented
- Check for updated API documentation
- Ensure README updated if needed
- Verify docstrings for public APIs
- Check for updated changelog
- Ensure migration guides if breaking changes

### 8. Review Dependencies
- Check if new dependencies are necessary
- Verify dependency versions are pinned
- Review licenses of new dependencies
- Check for security advisories
- Ensure dependencies are actively maintained

### 9. Verify Configuration
- Check environment variable usage
- Verify configuration follows project patterns
- Ensure backward compatibility
- Check for proper defaults
- Verify deployment configurations updated

### 10. Provide Constructive Feedback
- Be specific and actionable
- Explain reasoning behind suggestions
- Distinguish between blocking and non-blocking issues
- Acknowledge good practices
- Ask questions instead of making demands
- Provide examples or alternatives
- Balance criticism with praise

## Review Checklist

### Context
- [ ] PR description clear
- [ ] Requirements understood
- [ ] Approach aligns with architecture
- [ ] Changes scope appropriate

### Functionality
- [ ] Implements stated requirements
- [ ] Logic is correct
- [ ] Edge cases handled
- [ ] Error handling appropriate
- [ ] No obvious bugs

### Code Quality
- [ ] Code readable and clear
- [ ] Functions small and focused
- [ ] Names descriptive
- [ ] No code duplication
- [ ] Follows project conventions
- [ ] Proper separation of concerns

### Security
- [ ] No security vulnerabilities
- [ ] Input validation present
- [ ] Sensitive data handled properly
- [ ] No hardcoded secrets
- [ ] Authorization checked
- [ ] SQL injection prevented
- [ ] XSS protection in place

### Performance
- [ ] No obvious performance issues
- [ ] Database queries efficient
- [ ] No N+1 problems
- [ ] Proper caching used
- [ ] Reasonable algorithm complexity

### Testing
- [ ] Tests cover new functionality
- [ ] Tests cover edge cases
- [ ] Tests are independent
- [ ] Test quality is good
- [ ] Meaningful test descriptions

### Documentation
- [ ] Complex logic commented
- [ ] API documentation updated
- [ ] README updated if needed
- [ ] Changelog updated
- [ ] Migration guide if needed

### Dependencies & Config
- [ ] New dependencies justified
- [ ] Dependency versions pinned
- [ ] Licenses reviewed
- [ ] Configuration properly updated
- [ ] Environment variables documented

### Final
- [ ] CI checks passing
- [ ] No merge conflicts
- [ ] Feedback provided
- [ ] Approval or change requests given