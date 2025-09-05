# 🎯 **MCP ARCHITECTURE - QUICK ACCESS GUIDE**

*Guía de acceso rápido para la arquitectura MCP optimizada*

---

## 🚀 **ANTES DE HACER CUALQUIER CAMBIO:**

### **1. CHECK STATUS RÁPIDO:**
```bash
./scripts/mcp-status.sh
```

### **2. REVISAR INFO CRÍTICA:**
```bash
cat docs/MCP_CRITICAL_INFO.md
```

### **3. CONSULTAR ARQUITECTURA:**
```bash
cat docs/MCP_SERVICES_MAP.md
```

---

## 📚 **ESTRUCTURA DE DOCUMENTACIÓN**

| Archivo | Propósito | Cuándo Usar |
|---------|-----------|-------------|
| `MCP_CRITICAL_INFO.md` | Credenciales y status | **SIEMPRE PRIMERO** |
| `MCP_SERVICES_MAP.md` | Arquitectura y dependencias | Cambios de infraestructura |
| `MCP_WORKFLOWS_INDEX.md` | Workflows activos | Desarrollo/Deploy |
| `MCP_CHANGE_LOG.md` | Historial de cambios | After every change |

---

## ⚡ **COMANDOS CRÍTICOS**

### **Health Check Completo:**
```bash
# Status de todos los servicios
./scripts/mcp-status.sh --verbose

# Test API Chatwoot
curl -k -s -H "api_access_token: Yi7WA8G6vFXN5QAHMZd631KY" https://devchatwood.opemagency.com/api/v1/profile

# Check N8N MCP  
ps aux | grep n8n-mcp
```

### **Restart Servicios:**
```bash
# Chatwoot Stack
docker service update --force chatwoot_chatwoot_app

# Grafana
docker service update --force monitoring_grafana
```

---

## 🔑 **ACCESOS CRÍTICOS**

- **Chatwoot API:** `Yi7WA8G6vFXN5QAHMZd631KY`
- **Grafana:** `admin:OpemagencyGrafana2024!`
- **N8N MCP:** PID 2511507
- **Supabase:** Kong on port 8000

---

## 🎯 **PROTOCOLO DE TRABAJO**

### **✅ ANTES DE ACTUAR:**
1. Leer `MCP_CRITICAL_INFO.md`
2. Ejecutar `./scripts/mcp-status.sh`
3. Verificar dependencias en `MCP_SERVICES_MAP.md`
4. Planificar rollback

### **✅ DURANTE LOS CAMBIOS:**
1. Documentar cada paso
2. Monitorear health checks
3. Probar APIs inmediatamente
4. No hacer cambios concurrentes

### **✅ DESPUÉS DE CAMBIOS:**
1. Status check completo
2. Actualizar documentación
3. Commit a Git
4. Entrada en `MCP_CHANGE_LOG.md`

---

## 🚨 **EMERGENCY CONTACTS**

- **Superadmin:** `agencyopem@gmail.com`
- **Secondary:** `juamnoze@gmail.com`
- **Repository:** `https://github.com/Juamnoz/Automate_ai`

---

**🔒 PRINCIPIO:** Nunca hacer cambios sin revisar primero el contexto completo**