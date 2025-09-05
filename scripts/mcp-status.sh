#!/bin/bash

# 🚀 MCP Services Quick Status Check
# Usage: ./scripts/mcp-status.sh [--verbose]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

VERBOSE=false
if [[ "$1" == "--verbose" ]]; then
    VERBOSE=true
fi

echo -e "${BLUE}🔍 MCP SERVICES STATUS CHECK${NC}"
echo "==============================="
echo -e "Timestamp: $(date)"
echo ""

# Function to check service status
check_service_status() {
    local service_name="$1"
    local check_command="$2"
    local expected_pattern="$3"
    
    echo -n "Checking ${service_name}... "
    
    if eval "$check_command" | grep -q "$expected_pattern"; then
        echo -e "${GREEN}✅ RUNNING${NC}"
        return 0
    else
        echo -e "${RED}❌ FAILED${NC}"
        return 1
    fi
}

# Function to test API endpoint
test_api() {
    local name="$1"
    local url="$2"
    local expected_code="$3"
    
    echo -n "Testing ${name} API... "
    
    local response_code
    response_code=$(curl -k -s -o /dev/null -w "%{http_code}" "$url")
    
    if [[ "$response_code" -eq "$expected_code" ]]; then
        echo -e "${GREEN}✅ ${response_code}${NC}"
        return 0
    else
        echo -e "${RED}❌ ${response_code}${NC}"
        return 1
    fi
}

# Counter for failed services
FAILED_COUNT=0

echo "📊 DOCKER SERVICES:"
echo "-------------------"

# Check Chatwoot services
if check_service_status "Chatwoot App" "docker ps" "chatwoot_chatwoot_app"; then
    if $VERBOSE; then
        docker ps --format "table {{.Names}}\t{{.Status}}" | grep chatwoot_app
    fi
else
    ((FAILED_COUNT++))
fi

if check_service_status "Chatwoot Worker" "docker ps" "chatwoot_sidekiq"; then
    if $VERBOSE; then
        docker ps --format "table {{.Names}}\t{{.Status}}" | grep sidekiq
    fi
else
    ((FAILED_COUNT++))
fi

if check_service_status "Redis Cache" "docker ps" "chatwoot_redis"; then
    if $VERBOSE; then
        docker ps --format "table {{.Names}}\t{{.Status}}" | grep redis
    fi
else
    ((FAILED_COUNT++))
fi

# Check MCP services
echo ""
echo "⚡ MCP SERVERS:"
echo "--------------"

if check_service_status "N8N MCP" "ps aux" "n8n-mcp"; then
    if $VERBOSE; then
        ps aux | grep n8n-mcp | grep -v grep | head -1
    fi
else
    ((FAILED_COUNT++))
fi

if check_service_status "Supabase MCP" "docker ps" "mcp-supabase"; then
    if $VERBOSE; then
        docker ps --format "table {{.Names}}\t{{.Status}}" | grep supabase
    fi
else
    ((FAILED_COUNT++))
fi

# Check Monitoring
echo ""
echo "📊 MONITORING:"
echo "--------------"

if check_service_status "Grafana" "docker ps" "monitoring_grafana"; then
    if $VERBOSE; then
        docker ps --format "table {{.Names}}\t{{.Status}}" | grep grafana
    fi
else
    ((FAILED_COUNT++))
fi

# API Tests
echo ""
echo "🌐 API HEALTH CHECKS:"
echo "--------------------"

# Chatwoot API Test
if test_api "Chatwoot" "https://devchatwood.opemagency.com/api/v1/profile" "401"; then
    # Test with valid token
    echo -n "Testing Chatwoot Auth... "
    if curl -k -s -H "api_access_token: Yi7WA8G6vFXN5QAHMZd631KY" https://devchatwood.opemagency.com/api/v1/profile | grep -q "SuperAdmin"; then
        echo -e "${GREEN}✅ AUTHENTICATED${NC}"
    else
        echo -e "${RED}❌ AUTH FAILED${NC}"
        ((FAILED_COUNT++))
    fi
else
    ((FAILED_COUNT++))
fi

# Grafana API Test  
if test_api "Grafana" "https://devgrafana.opemagency.com/api/health" "200"; then
    true # Already handled
else
    ((FAILED_COUNT++))
fi

# Summary
echo ""
echo "📋 SUMMARY:"
echo "----------"

TOTAL_SERVICES=8
WORKING_SERVICES=$((TOTAL_SERVICES - FAILED_COUNT))

if [[ $FAILED_COUNT -eq 0 ]]; then
    echo -e "${GREEN}🎉 ALL SYSTEMS OPERATIONAL (${WORKING_SERVICES}/${TOTAL_SERVICES})${NC}"
    exit 0
elif [[ $FAILED_COUNT -lt 3 ]]; then
    echo -e "${YELLOW}⚠️  SOME ISSUES DETECTED (${WORKING_SERVICES}/${TOTAL_SERVICES} working)${NC}"
    exit 1
else
    echo -e "${RED}🚨 CRITICAL FAILURES (${WORKING_SERVICES}/${TOTAL_SERVICES} working)${NC}"
    exit 2
fi