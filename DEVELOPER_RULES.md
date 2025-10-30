# Developer Rules

## Planning & Architecture

- **Ask questions** about project architecture during planning phase
- **Suggest frameworks with benefits** - present multiple options with pros/cons, then ask user which to use
- **Suggest architectural patterns** - monolith, microservices, serverless with trade-offs for the specific use case
- **Ask about development/deployment technologies** - suggest options like containerization (Docker, Podman), orchestration (K8s, Docker Compose), CI/CD platforms, cloud providers with their benefits
- **Consider performance and scalability** - plan scalability requirements, caching strategy, and performance targets early
- **Propose clear project structure** - suggest folder/file organization following framework-specific best practices
- **Use latest stable** libraries and frameworks
- **Pin dependency versions** in package manifests (requirements.txt, package.json, Gemfile, etc.)

## Code Quality

- **Prefer typed code** when language supports it (TypeScript, Python with type hints, etc.)
- **Follow SOLID principles** and DRY (Don't Repeat Yourself)
- **Keep functions small** and focused on single responsibility
- **Use consistent naming** conventions across the codebase
- **Add docstrings/comments** for complex logic
- **Use linting and formatting** tools (eslint, prettier, ruff, black, etc.)

## Language & Communication Conventions

- **All generated files use English** - regardless of user's input language, all files (.mdc, .md, source code, documentation, etc.) must be written in English
- **Agent responses match user language** - conversational responses and comments can be provided in the language that matches the user's input
- **Maintain consistency** - keep codebase and documentation in English for international collaboration and tooling compatibility

## Environment & Dependencies

- **Use isolated environments** - venv for Python, nvm/fnm for Node.js, rbenv for Ruby, etc. - never use system installations
- **Use environment variables** for configuration

## Database & Data

- **Use migrations** for all schema changes
- **Never modify database directly** in production
- **Include seed data** for development and testing

## Testing

- **Add tests** for all code with high coverage
- **Include test scripts** for local execution
- **Add integration tests** for critical paths
- **Include performance/load tests** where needed
- **Security testing** - add comprehensive security tests (100% coverage for auth, input validation, authorization)

## Security

- **Never commit secrets** or credentials
- **Validate all user inputs**
- **Follow security best practices** - use environment variables, secure authentication, proper authorization
- **Add proper error handling** and logging
- **Use structured logging** for production code

## Version Control & CI/CD

- **Write clear commit messages** - descriptive and following conventional commits
- **Add CI/CD workflows** - GitHub Actions for GitHub projects, ask about workflow types for other platforms

## Cursor IDE Rules

- **Use `.cursor/rules/*.mdc` files** - when user asks to work with cursor rules, operate with `.cursor/rules/*.mdc` files in project root
- **Never use deprecated `.cursorrules` file** - the single `.cursorrules` file format is deprecated and should not be used

