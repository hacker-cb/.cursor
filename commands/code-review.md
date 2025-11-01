# Code Review

## Overview
Comprehensive code review workflow covering functionality, quality, security, performance, testing, and documentation to ensure changes meet project standards before merge.

## Steps

### 1. Understand Context
- Read PR/MR description and linked issues
- Understand the problem being solved
- Review user stories, requirements, or acceptance criteria
- Verify approach aligns with project architecture
- Identify affected areas and potential impact
- Check change scope is appropriate (not too large)

### 2. Review Functionality
- Verify code implements stated requirements correctly
- Check logic correctness and algorithm soundness
- Test edge cases and boundary conditions
- Verify error handling is appropriate and comprehensive
- Check for potential bugs, race conditions, or logic errors
- Ensure no unintended side effects or breaking changes

### 3. Assess Code Quality
- Check code readability, clarity, and maintainability
- Verify functions are small, focused, and single-purpose
- Ensure descriptive variable, function, and class names
- Check for code duplication (DRY principle violations)
- Verify proper separation of concerns and layering
- Ensure code follows project conventions and style guide
- Check for appropriate abstraction levels

### 4. Review Security
- Check for common security vulnerabilities (OWASP Top 10)
- Verify input validation and sanitization is present
- Ensure sensitive data handled properly (encryption, secure storage)
- Check for SQL injection risks in queries
- Verify XSS protection in output rendering
- Ensure no hardcoded secrets, credentials, or API keys
- Check authorization and authentication implementation
- Review error messages for information leakage

### 5. Evaluate Performance
- Check for obvious performance issues or inefficiencies
- Review database query efficiency and indexing
- Check for N+1 query problems in ORMs
- Verify proper use of caching where appropriate
- Check memory usage patterns and potential leaks
- Review algorithm complexity (time and space)
- Ensure no unnecessary computations or redundant operations

### 6. Review Testing
- Verify tests cover new functionality adequately
- Check test quality, clarity, and maintainability
- Ensure tests cover edge cases and error conditions
- Verify tests are isolated, independent, and deterministic
- Check for proper test data setup and teardown
- Ensure tests follow project testing patterns
- Verify meaningful test descriptions and assertions

### 7. Check Documentation
- Verify complex logic has explanatory comments
- Check API documentation updated if public interfaces changed
- Ensure README updated if setup or usage changed
- Verify docstrings/comments for public APIs and complex functions
- Check changelog updated with user-facing changes
- Ensure migration guides provided if breaking changes introduced

### 8. Review Dependencies
- Check if new dependencies are truly necessary
- Verify dependency versions are pinned (not using ranges)
- Review licenses of new dependencies for compatibility
- Check for known security advisories on dependencies
- Ensure dependencies are actively maintained
- Verify dependencies don't introduce bloat or conflicts

### 9. Verify Configuration
- Check environment variable usage follows project patterns
- Verify configuration changes maintain backward compatibility
- Ensure proper defaults provided for all configuration
- Check deployment configurations updated if needed
- Verify environment variables documented

### 10. Provide Constructive Feedback
- Be specific and actionable in comments
- Explain reasoning behind suggestions and concerns
- Distinguish between blocking and non-blocking issues
- Acknowledge good practices and well-written code
- Ask clarifying questions instead of making demands
- Provide examples or alternatives when suggesting changes
- Balance constructive criticism with positive feedback
- Focus on improving code, not criticizing the author

## Checklist
- [ ] Context and requirements understood
- [ ] Functionality correct and complete
- [ ] Code quality meets standards
- [ ] Security vulnerabilities addressed
- [ ] Performance acceptable
- [ ] Tests adequate and passing
- [ ] Documentation updated
- [ ] Dependencies justified and secure
- [ ] Configuration properly handled
- [ ] Constructive feedback provided
- [ ] CI/CD checks passing
- [ ] Approval or change requests given
