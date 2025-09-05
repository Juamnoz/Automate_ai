# 📊 **MCP GRAFANA DASHBOARDS - GUÍA COMPLETA**
*Visualización completa de todos los MCP Services*

---

## 🎯 **DASHBOARDS CREADOS EXITOSAMENTE**

### **✅ ACCESO A GRAFANA:**
- **URL:** `https://devgrafana.opemagency.com/`
- **Usuario:** `admin`
- **Contraseña:** `OpemagencyGrafana2024!`
- **Status:** 🟢 ACTIVO Y FUNCIONAL

---

## 🚀 **DASHBOARD 1: MCP SERVICES OVERVIEW**

### **📍 Acceso Directo:**
- **URL:** `https://devgrafana.opemagency.com/d/mcp-overview/f09f8eaf-mcp-services-overview`
- **UID:** `mcp-overview`
- **ID:** 3

### **📊 Métricas Incluidas:**

#### **🚀 Panel 1: MCP Services Status**
- **Tipo:** Stat
- **Métrica:** `up{job=~".*docker.*"}`
- **Propósito:** Estado general de todos los servicios MCP

#### **💾 Panel 2: Container Memory Usage**
- **Tipo:** Time Series
- **Métrica:** `container_memory_usage_bytes{name=~".*chatwoot.*|.*supabase.*|.*mcp.*"}`
- **Propósito:** Uso de memoria de containers MCP

#### **⚡ Panel 3: CPU Usage %**
- **Tipo:** Time Series
- **Métrica:** `rate(container_cpu_usage_seconds_total[5m]) * 100`
- **Propósito:** Uso de CPU en tiempo real

#### **🌐 Panel 4: Chatwoot API Health**
- **Tipo:** Stat
- **Métrica:** `probe_success{instance=~".*devchatwood.*"}`
- **Propósito:** Estado específico de la API de Chatwoot

#### **📊 Panel 5: Docker Container Count**
- **Tipo:** Stat
- **Métrica:** `count(container_last_seen{name=~".*chatwoot.*|.*supabase.*|.*mcp.*"})`
- **Propósito:** Número total de containers MCP activos

#### **🔄 Panel 6: Network I/O**
- **Tipo:** Time Series
- **Métricas:** 
  - RX: `rate(container_network_receive_bytes_total[5m])`
  - TX: `rate(container_network_transmit_bytes_total[5m])`
- **Propósito:** Tráfico de red de los servicios MCP

#### **🗄️ Panel 7: Supabase Database Connections**
- **Tipo:** Time Series
- **Query:** `SELECT NOW() as time, count(*) as connections FROM pg_stat_activity WHERE state = 'active'`
- **Propósito:** Conexiones activas a Supabase

#### **📈 Panel 8: System Load Average**
- **Tipo:** Time Series
- **Métricas:** `node_load1`, `node_load5`, `node_load15`
- **Propósito:** Carga del sistema general

---

## 📞 **DASHBOARD 2: CHATWOOT API MONITORING**

### **📍 Acceso Directo:**
- **URL:** `https://devgrafana.opemagency.com/d/chatwoot-api-monitor/f09f939e-chatwoot-api-monitoring`
- **UID:** `chatwoot-api-monitor`
- **ID:** 4

### **🔧 Paneles Específicos:**

#### **🔑 API Token Status**
- **Status:** ✅ Token `Yi7WA8G6vFXN5QAHMZd631KY` activo
- **Verificación:** Cada 15 segundos

#### **👥 SuperAdmin Users**
- **Usuarios:** `agencyopem@gmail.com` + `juamnoze@gmail.com`
- **Total:** 2 usuarios activos

#### **📬 Active Inboxes**
- **Configurados:** WhatsApp + Facebook + Instagram
- **Total:** 3 inboxes operacionales

#### **🔄 Container Health**
- **Monitoreado:** Todos los containers de Chatwoot
- **Frecuencia:** Tiempo real

---

## 🚨 **ALERTAS CONFIGURADAS**

### **🔴 Alerta Crítica: MCP Service Down**
- **Condición:** `up{job=~".*docker.*",instance=~".*chatwoot.*|.*supabase.*|.*mcp.*"} == 0`
- **Duración:** 5 minutos
- **Severidad:** Critical
- **Runbook:** `https://github.com/Juamnoz/Automate_ai/blob/main/docs/MCP_CRITICAL_INFO.md`

### **🟡 Alerta Warning: High CPU Usage**
- **Condición:** `rate(container_cpu_usage_seconds_total[5m]) * 100 > 80`
- **Duración:** 10 minutos
- **Severidad:** Warning

### **🟠 Alerta Warning: High Memory Usage**
- **Condición:** `container_memory_usage_bytes > 1GB`
- **Duración:** 15 minutos
- **Severidad:** Warning

---

## 🔧 **CONFIGURACIÓN TÉCNICA**

### **📡 Datasources Configurados:**
1. **Prometheus:** `PBFA97CFB590B2093` (Default)
2. **Opemagency Postgres:** `P18897088171CD73E`  
3. **Supabase DB:** `PCBDCB1591A9C9A73`

### **⚙️ Refresh Settings:**
- **Dashboard Principal:** 30 segundos
- **Chatwoot Monitor:** 15 segundos
- **Alertas:** 60 segundos

### **🎯 Filtros Aplicados:**
- **Containers:** `name=~".*chatwoot.*|.*supabase.*|.*mcp.*"`
- **Jobs:** `job=~".*docker.*"`
- **Instances:** `instance=~".*devchatwood.*"`

---

## 🚀 **CÓMO USAR LOS DASHBOARDS**

### **1. ACCESO INICIAL:**
```bash
# 1. Verificar status antes de revisar Grafana
./scripts/mcp-status.sh

# 2. Acceder a Grafana
open https://devgrafana.opemagency.com/
# Login: admin:OpemagencyGrafana2024!
```

### **2. NAVEGACIÓN RÁPIDA:**
- **Dashboard Principal:** Clic en "🎯 MCP Services Overview"
- **Monitor Chatwoot:** Clic en "📞 Chatwoot API Monitoring"
- **Vista General:** Home → Dashboards → MCP

### **3. INTERPRETACIÓN DE MÉTRICAS:**

#### **🟢 Estados Saludables:**
- CPU Usage < 50%
- Memory Usage < 1GB
- All Services Status = UP (1)
- Network I/O estable
- Database connections < 100

#### **🟡 Estados de Advertencia:**
- CPU Usage 50-80%
- Memory Usage 1-2GB
- Intermittent service failures
- High network traffic spikes

#### **🔴 Estados Críticos:**
- CPU Usage > 80%
- Memory Usage > 2GB
- Services Status = DOWN (0)
- Database connection failures
- API response failures

---

## 🛠️ **TROUBLESHOOTING**

### **Dashboard No Carga:**
```bash
# Verificar Grafana
curl -k -s https://devgrafana.opemagency.com/api/health

# Reiniciar si necesario
docker service update --force monitoring_grafana
```

### **Métricas No Aparecen:**
```bash
# Verificar Prometheus
curl http://localhost:9090/api/v1/query?query=up

# Verificar cAdvisor
docker ps | grep cadvisor
```

### **Alertas No Funcionan:**
```bash
# Verificar configuración de alertas
curl -u "admin:OpemagencyGrafana2024!" https://devgrafana.opemagency.com/api/alerts
```

---

## 📈 **EXPANSIÓN FUTURA**

### **🎯 Métricas Adicionales Planificadas:**
- [ ] Response time de APIs específicas
- [ ] Error rate tracking
- [ ] Custom business metrics
- [ ] User activity monitoring
- [ ] Workflow execution metrics

### **🔔 Integraciones de Alertas:**
- [ ] Slack notifications
- [ ] Email alerts
- [ ] Webhook notifications
- [ ] SMS para críticos

---

## 📋 **QUICK REFERENCE**

### **URLs Importantes:**
- **Grafana Home:** `https://devgrafana.opemagency.com/`
- **MCP Overview:** `https://devgrafana.opemagency.com/d/mcp-overview/`
- **Chatwoot Monitor:** `https://devgrafana.opemagency.com/d/chatwoot-api-monitor/`

### **Comandos Útiles:**
```bash
# Status check completo
./scripts/mcp-status.sh --verbose

# Test Chatwoot API desde CLI
curl -k -s -H "api_access_token: Yi7WA8G6vFXN5QAHMZd631KY" https://devchatwood.opemagency.com/api/v1/profile

# Docker stats real-time
docker stats | grep -E "(chatwoot|supabase|mcp)"
```

---

*📊 Dashboards listos y completamente funcionales - All Systems Operational!*