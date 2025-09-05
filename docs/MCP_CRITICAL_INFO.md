# 🚨 **MCP CRITICAL INFO - ACCESO RÁPIDO**
*Última actualización: 2025-09-04*

---

## 🔑 **CREDENCIALES ACTIVAS**

### **CHATWOOT (PRIORITARIO)**
- **API Token:** `Yi7WA8G6vFXN5QAHMZd631KY`
- **URL:** `https://devchatwood.opemagency.com/api/v1/`
- **Status:** ✅ SuperAdmin Verified
- **Test:** `curl -k -s -H "api_access_token: Yi7WA8G6vFXN5QAHMZd631KY" https://devchatwood.opemagency.com/api/v1/profile`

### **GRAFANA**
- **URL:** `https://devgrafana.opemagency.com/`
- **User:** `admin`
- **Pass:** `OpemagencyGrafana2024!`
- **Status:** ✅ Active

### **N8N MCP**
- **Process ID:** `2511507`
- **Nodes:** 534 total (268 AI tools)
- **Status:** ✅ Running
- **Test:** `ps aux | grep n8n-mcp`

### **SUPABASE MCP**
- **Container:** `mcp-supabase_mcp-supabase.1.l14r50jb6svdffm1hmmg7r5u8`
- **URL:** `http://supabase_kong:8000`
- **Status:** ✅ Active

---

## 🎯 **SERVICIOS CRÍTICOS STATUS**

| Servicio | Container/Process | Status | Port | Health Check |
|----------|-------------------|--------|------|-------------|
| Chatwoot App | `chatwoot_chatwoot_app.1.cdrsncnbs8w8n01z3zqt38nsx` | ✅ | 3000 | API Token Valid |
| Chatwoot Worker | `chatwoot_chatwoot_sidekiq.1.tc46p1nzt23hytsjosxk4nihh` | ✅ | - | Process Active |
| Chatwoot Redis | `chatwoot_chatwoot_redis.1.f92foiayyy8cko6va4ydpulql` | ✅ | 6379 | Connection OK |
| N8N MCP | PID: 2511507 | ✅ | - | MCP Functions OK |
| Supabase MCP | `mcp-supabase_mcp-supabase.1.*` | ✅ | 8000 | Container Running |
| Grafana | `monitoring_grafana.1.*` | ✅ | 3000 | Login OK |

---

## ⚠️ **DATOS SENSIBLES - FACEBOOK/INSTAGRAM**

### **TOKENS ACTIVOS:**
- **FB Page:** `EAAVRBz0RNZAsBPW2d3eWSudVXHcqYqPup9cDJrAgA5be1NadkCQiSyBUx`
- **IG Access:** `IGAAVTRUCUenJBZAE85bm1jdVROZA0RYRG5sZAV9qUDB1YlBkY3dnakcxMnBZAU`
- **Verify Token:** `chatwoot_fb_token`
- **Secret Key:** `1de6b8bd5707ce874c82e66ffc97b0a2`

---

## 🚀 **QUICK ACTIONS**

### **Health Check All:**
```bash
# Check all critical services
docker ps | grep -E "(chatwoot|grafana|supabase)" && ps aux | grep n8n-mcp | head -1
```

### **API Test:**
```bash
# Test Chatwoot API
curl -k -s -H "api_access_token: Yi7WA8G6vFXN5QAHMZd631KY" https://devchatwood.opemagency.com/api/v1/profile | jq '.type'
```

### **Emergency Restart:**
```bash
# Restart Chatwoot stack
docker service update --force chatwoot_chatwoot_app
```

---

## 📞 **SUPPORT CONTACTS**

- **SuperAdmin Users:**
  - `agencyopem@gmail.com` (ID: 1)
  - `juamnoze@gmail.com` (ID: 2)

---

*🔒 CONFIDENCIAL - Solo acceso autorizado*