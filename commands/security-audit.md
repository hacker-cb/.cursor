# Security Audit

## Overview
Comprehensive security review to identify and fix vulnerabilities in dependencies, code, authentication, authorization, data handling, and infrastructure configuration using industry best practices.

**Note:** For comprehensive code review including functionality and quality, see `code-review`.

## Steps

### 1. Dependency Security Audit
- Use automated tools to scan dependencies for known vulnerabilities (CVEs)
- Check for outdated packages with available security patches
- Review third-party dependency licenses for legal compliance
- Identify unused or unnecessary dependencies that increase attack surface
- Verify dependency sources are official and trustworthy
- Check for dependency confusion and typosquatting vulnerabilities
- Check dependency advisories (GitHub Security Advisories, Snyk, npm audit)
- Update vulnerable packages and test for breaking changes

### 2. Secrets and Credentials Scan
- Scan codebase for hardcoded secrets (API keys, passwords, tokens, certificates)
- Use tools to detect secrets patterns in tracked files
- Review environment variable usage and .env.example templates
- Verify secrets not in version control history (check git log)
- Check configuration files for accidentally committed credentials
- Ensure proper gitignore coverage for sensitive files
- Scan CI/CD configuration for exposed secrets
- Verify secrets rotation policy exists

### 3. Authentication Security Review
- Review authentication implementation against OWASP guidelines
- Check password hashing uses strong algorithms (bcrypt, Argon2, PBKDF2)
- Verify session management security (secure tokens, timeout, regeneration)
- Check secure cookie flags (HttpOnly, Secure, SameSite)
- Review token generation uses cryptographically secure randomness
- Verify multi-factor authentication implementation if present
- Check account lockout and rate limiting on login attempts
- Review password reset flow for security flaws (token expiration, single use)

### 4. Authorization Security Review
- Audit authorization logic for completeness and correctness
- Check for privilege escalation vulnerabilities (horizontal and vertical)
- Verify role-based access control (RBAC) properly enforced
- Review API endpoint permissions and authentication requirements
- Check for insecure direct object references (IDOR)
- Verify users can only access their own data
- Review admin functionality has proper protection
- Test authorization boundaries with different user roles

### 5. Input Validation and Injection Prevention
- Check all user input validation at entry points
- Review SQL injection prevention (parameterized queries, ORMs)
- Verify XSS protection (output encoding, Content-Security-Policy)
- Check for command injection vulnerabilities in system calls
- Review file upload validation (type, size, content verification)
- Check path traversal prevention in file operations
- Verify data sanitization before output rendering
- Check for LDAP, XML, and NoSQL injection vulnerabilities

### 6. Data Protection and Privacy
- Review sensitive data storage and encryption at rest
- Verify encryption in transit (TLS configuration, certificate validity)
- Review PII handling practices and data minimization
- Check data retention and deletion policies compliance
- Verify secure data deletion (not just marking as deleted)
- Review logging practices to avoid logging sensitive data
- Check backup security and encryption
- Verify compliance with privacy regulations (GDPR, CCPA, etc.)

### 7. API Security Audit
- Review API authentication mechanisms (OAuth, JWT, API keys)
- Check rate limiting implementation to prevent abuse
- Verify CORS configuration is not overly permissive
- Review API input validation and request size limits
- Check for mass assignment vulnerabilities in data binding
- Verify proper error responses (no sensitive information leakage)
- Review API versioning and deprecation security
- Check GraphQL security if applicable (query depth, complexity limits)

### 8. Infrastructure and Configuration Security
- Review environment configuration for security misconfigurations
- Check access control lists and firewall rules
- Audit network security (ports, protocols, segmentation)
- Verify secure defaults throughout the application
- Check for exposed debug endpoints and verbose error pages
- Review deployment security (container security, orchestration)
- Verify secure communication channels (TLS versions, cipher suites)
- Check for security headers (HSTS, X-Frame-Options, CSP)

### 9. Code Security Patterns
- Check error handling doesn't leak sensitive information
- Review random number generation uses cryptographically secure functions
- Verify cryptographic practices (key management, algorithms, modes)
- Check for timing attack vulnerabilities in comparisons
- Review deserialization security (avoid unsafe deserialization)
- Check for race conditions in concurrent operations
- Verify secure defaults throughout codebase
- Review use of security-sensitive APIs

### 10. Generate Security Report
- Compile findings by severity using CVSS or similar: Critical, High, Medium, Low, Info
- List vulnerabilities with affected code locations and line numbers
- Provide specific remediation steps for each issue
- Include references to OWASP Top 10 or CWE where applicable
- Prioritize fixes by risk level (likelihood × impact)
- Offer to fix issues interactively with user confirmation
- Document security improvements made
- Recommend ongoing security practices and tools

## Checklist
- [ ] Dependencies scanned and vulnerable packages updated
- [ ] Secrets scan completed, no hardcoded credentials
- [ ] Authentication implementation reviewed and secure
- [ ] Authorization logic audited and enforced
- [ ] Input validation and injection prevention verified
- [ ] Data protection and encryption confirmed
- [ ] API security reviewed and rate limiting implemented
- [ ] Infrastructure configuration secured
- [ ] Code security patterns verified
- [ ] Security report generated with prioritized findings
- [ ] Remediation steps provided and fixes offered
- [ ] Compliance requirements addressed
