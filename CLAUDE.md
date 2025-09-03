# CLAUDE.md - n8n Automation Project Guide

## 🎯 Project Overview

**Automate_ai** es un sistema de automatización con LLM central para agentes de IA, despliegues en VPS y orquestación de stacks usando n8n como plataforma principal de workflows.

### Objetivos del Proyecto
- Automatizar procesos empresariales complejos con IA
- Orquestar despliegues y configuraciones de VPS
- Integrar múltiples servicios y APIs de forma inteligente
- Mantener workflows escalables y mantenibles
- Implementar monitoreo y alertas proactivas

## 📁 Estructura del Proyecto

```
Automate_ai/
├── .github/workflows/          # GitHub Actions
│   ├── claude.yml             # Claude Code integration
│   ├── n8n-deploy.yml         # n8n deployment pipeline
│   └── n8n-validate.yml       # Workflow validation
├── workflows/                  # n8n Workflows JSON
│   ├── production/            # Production workflows
│   ├── staging/               # Staging workflows
│   └── development/           # Development workflows
├── scripts/                   # Automation scripts
│   ├── deploy-to-n8n.sh      # Deployment script
│   ├── backup-workflows.sh    # Backup automation
│   └── sync-from-n8n.sh       # Sync from n8n instance
├── docs/                      # Documentation
├── monitoring/                # Monitoring configs
└── CLAUDE.md                 # This file
```

## 🏗️ n8n Workflow Standards and Conventions

### Naming Conventions
- **Workflows**: `kebab-case` (e.g., `customer-onboarding-flow`)
- **Nodes**: Descriptive names with purpose (e.g., `Get Customer Data`, `Send Welcome Email`)
- **Variables**: `camelCase` for expressions (e.g., `customerEmail`, `orderTotal`)

### File Organization
- **Production**: Only stable, tested workflows
- **Staging**: Testing new features or modifications
- **Development**: Experimental workflows

### Workflow Structure Standards
```json
{
  "name": "workflow-name",
  "version": "1.0.0",
  "description": "Clear description of workflow purpose",
  "tags": ["category", "priority"],
  "settings": {
    "executionOrder": "v1",
    "saveManualExecutions": true,
    "callerPolicy": "workflowsFromSameOwner"
  }
}
```

### Node Configuration Best Practices
1. **Error Handling**: Always include error handling paths
2. **Retry Logic**: Configure appropriate retry settings
3. **Timeouts**: Set reasonable timeout values
4. **Logging**: Use `Set` nodes for logging important data
5. **Documentation**: Add notes to complex nodes

### Expression Guidelines
- Use `$json` for current item data
- Use `$node["Node Name"].json` for specific node data
- Validate data before processing: `$json.field !== undefined`
- Use template literals for complex strings: `` `Hello ${$json.name}` ``

## 🚀 Deployment Procedures

### Deployment Pipeline
1. **Development** → **Staging** → **Production**
2. Automatic validation on every commit
3. Manual approval required for production deployments
4. Automatic rollback on failure

### Pre-deployment Checklist
- [ ] Workflow passes validation tests
- [ ] All required credentials are configured
- [ ] Error handling paths tested
- [ ] Performance impact assessed
- [ ] Documentation updated
- [ ] Monitoring alerts configured

### Deployment Commands
```bash
# Deploy to staging
git push origin develop

# Deploy to production  
git push origin main

# Manual deployment
./scripts/deploy-to-n8n.sh --environment production --workflow workflow-name
```

## 🧪 Testing Requirements

### Workflow Testing Standards
1. **Unit Testing**: Test individual nodes and logic
2. **Integration Testing**: Test workflow end-to-end
3. **Performance Testing**: Verify execution times and resource usage
4. **Error Testing**: Test error scenarios and recovery

### Testing Checklist
- [ ] All possible execution paths tested
- [ ] Error conditions handled gracefully
- [ ] Data validation works correctly
- [ ] External API calls have proper error handling
- [ ] Webhook endpoints respond correctly
- [ ] Performance meets requirements (<30s for most workflows)

### Test Data Management
- Use test data that doesn't affect production systems
- Sanitize sensitive data in test environments
- Document test scenarios and expected outcomes

## 👥 Code Review Guidelines

### Review Checklist for Workflows
- [ ] **Security**: No hardcoded credentials or sensitive data
- [ ] **Performance**: Efficient use of nodes and expressions
- [ ] **Error Handling**: Proper error paths and logging
- [ ] **Documentation**: Clear node names and descriptions
- [ ] **Standards Compliance**: Follows naming and structure conventions
- [ ] **Testing**: Adequate test coverage
- [ ] **Dependencies**: All required credentials and connections available

### Review Process
1. Create PR from feature branch
2. Automated validation runs
3. Manual review by team member
4. Address feedback and update
5. Approval and merge
6. Automatic deployment to staging

## 🔒 Security Considerations

### API Key Management
- **Never** hardcode API keys in workflows
- Use n8n credential system exclusively
- Rotate credentials regularly
- Limit credential scope to minimum required permissions
- Monitor credential usage and access

### Data Protection
- Encrypt sensitive data in transit and at rest
- Implement data retention policies
- Sanitize logs to remove sensitive information
- Use HTTPS for all external communications
- Validate and sanitize all inputs

### Access Control
- Principle of least privilege for all integrations
- Regular access reviews and cleanup
- Strong authentication for n8n instance
- Network isolation where possible
- Audit logs for all workflow executions

### Security Checklist
- [ ] All credentials properly configured in n8n
- [ ] No sensitive data in workflow JSON files
- [ ] External APIs use secure authentication
- [ ] Input validation implemented
- [ ] Error messages don't leak sensitive information
- [ ] Webhook endpoints secured with authentication

## 📚 Documentation Standards

### Workflow Documentation
Each workflow should include:
- **Purpose**: Clear description of what the workflow does
- **Triggers**: How and when the workflow executes
- **Dependencies**: External services, credentials, and data sources
- **Outputs**: What the workflow produces or affects
- **Error Handling**: How errors are managed and reported
- **Monitoring**: Key metrics and alerts

### Code Comments
- Document complex expressions and logic
- Explain business rules and requirements
- Note any temporary workarounds or limitations
- Include links to relevant external documentation

### Change Documentation
- Maintain changelog for major workflow updates
- Document breaking changes and migration steps
- Include performance impact of changes
- Update API documentation when endpoints change

## 🔧 Claude Code Integration Guidelines

### Using @claude in GitHub
- **Issues**: Create detailed issue descriptions for new workflows
- **PRs**: Use @claude for code review and optimization suggestions
- **Debugging**: Tag @claude when workflows fail or need troubleshooting

### Effective Prompts for @claude
```
Good: "@claude Create a workflow that processes Shopify orders and updates our CRM with customer data, including error handling and retry logic"

Bad: "@claude fix this workflow"
```

### Claude Code Commands
- `@claude analyze workflow performance in /workflows/production`
- `@claude create integration between Slack and our database`
- `@claude optimize the customer-onboarding workflow for better performance`
- `@claude add monitoring and alerting to all production workflows`

## 🚨 Monitoring and Alerting

### Key Metrics to Monitor
- Workflow execution success/failure rates
- Execution duration and performance
- API rate limiting and quota usage
- Error patterns and frequency
- Resource utilization

### Alert Configurations
- **Critical**: Production workflow failures
- **Warning**: Performance degradation or high error rates
- **Info**: Successful deployments and major events

### Monitoring Setup
```bash
# Set up monitoring for all workflows
./scripts/setup-monitoring.sh --environment production
```

## 🆘 Troubleshooting Guide

### Common Issues
1. **Credential Errors**: Check n8n credential configuration
2. **Timeout Issues**: Review node timeout settings and API response times
3. **Rate Limiting**: Implement proper delays and retry logic
4. **Data Format Issues**: Validate data structure and types
5. **Webhook Failures**: Verify endpoint URLs and authentication

### Debug Mode
Enable debug mode for detailed execution logs:
```json
{
  "settings": {
    "saveManualExecutions": true,
    "saveExecutionProgress": true
  }
}
```

## 📞 Support and Escalation

### Getting Help
1. Check this documentation first
2. Search existing GitHub issues
3. Create detailed issue with @claude tag
4. For urgent production issues, escalate immediately

### Issue Template
```
**Workflow**: [workflow name]
**Environment**: [production/staging/development]  
**Error**: [specific error message]
**Expected**: [what should happen]
**Actual**: [what actually happened]
**Steps to Reproduce**: [detailed steps]
```

---

## 🎯 Quick Start Commands

```bash
# Create new workflow
@claude Create a workflow that [describe functionality]

# Deploy workflow  
git add . && git commit -m "Add: new workflow" && git push

# Monitor workflow
@claude Check the performance of [workflow-name] in production

# Troubleshoot issues
@claude Debug why [workflow-name] is failing with [error-description]
```

---
**Last Updated**: September 2025
**Version**: 1.0.0