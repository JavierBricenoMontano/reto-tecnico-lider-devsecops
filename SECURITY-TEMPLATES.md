# 🛡️ Plantillas de Seguridad GHAS para MiBanco

Este repositorio contiene plantillas completas para análisis de seguridad utilizando GitHub Advanced Security (GHAS), específicamente diseñadas para el microservicio de MiBanco.

## 📋 Índice

- [Descripción General](#descripción-general)
- [Componentes](#componentes)
- [Configuración](#configuración)
- [Uso](#uso)
- [Tipos de Análisis](#tipos-de-análisis)
- [Resultados y Reportes](#resultados-y-reportes)
- [Troubleshooting](#troubleshooting)

## 🎯 Descripción General

Las plantillas implementan un flujo de seguridad completo que incluye:

- **SAST (Static Application Security Testing)**: Análisis de código fuente para detectar vulnerabilidades
- **SCA (Software Composition Analysis)**: Análisis de dependencias para detectar vulnerabilidades conocidas
- **Análisis de Licencias**: Verificación de compatibilidad de licencias de dependencias
- **Security Gates**: Bloqueo automático de despliegues inseguros

## 🔧 Componentes

### Workflows Principales

1. **`security-analysis.yml`** - Workflow principal que orquesta todos los análisis
2. **`security-sast-template.yml`** - Template reutilizable para análisis SAST
3. **`security-sca-template.yml`** - Template reutilizable para análisis SCA

### Archivos de Configuración

4. **`.github/codeql/codeql-config.yml`** - Configuración de CodeQL para SAST
5. **`.github/dependency-review-config.yml`** - Configuración de revisión de dependencias
6. **`.eslintrc.security.js`** - Reglas ESLint específicas de seguridad

## ⚙️ Configuración

### Prerrequisitos

1. **Repositorio Público**: Los workflows están optimizados para repositorios públicos donde GHAS es gratuito
2. **Permisos**: Asegurar que GitHub Actions tiene permisos de escritura en `security-events`
3. **Secrets (Opcionales)**:
   - `SNYK_TOKEN`: Token de Snyk para análisis SCA adicional
   - `SEMGREP_APP_TOKEN`: Token de Semgrep para análisis SAST adicional

### Configuración de GHAS

Habilitar en el repositorio:

1. Ir a **Settings** > **Security & analysis**
2. Habilitar **Dependency graph**
3. Habilitar **Dependabot alerts**
4. Habilitar **Dependabot security updates**
5. Habilitar **Code scanning alerts**

## 🚀 Uso

### Ejecución Automática

Los análisis se ejecutan automáticamente en:

```yaml
# Pull Requests hacia develop/release
pull_request:
  branches: [develop, release, main]

# Push a develop/release
push:
  branches: [develop, release]

# Análisis semanal programado
schedule:
  - cron: "0 2 * * 0" # Domingos 2 AM UTC
```

### Ejecución Manual

```bash
# Desde la interfaz de GitHub
1. Ir a Actions tab
2. Seleccionar "Security Analysis Workflow"
3. Click en "Run workflow"
4. Configurar opciones:
   - ✅ Ejecutar análisis SAST
   - ✅ Ejecutar análisis SCA
   - Ruta del microservicio (opcional)
```

### Integración en otros Workflows

```yaml
# Ejemplo de uso en workflow de deployment
jobs:
  security_check:
    uses: ./.github/workflows/security-analysis.yml
    with:
      microservice_path: "mibanco-microservice"
    secrets: inherit

  deploy:
    needs: security_check
    # El deployment solo ocurre si pasa el security gate
    runs-on: ubuntu-latest
    steps:
      # ... pasos de deployment
```

## 🔍 Tipos de Análisis

### SAST (Static Application Security Testing)

**Herramientas utilizadas:**

- **GitHub CodeQL**: Análisis semántico profundo del código
- **Semgrep**: Reglas de seguridad de OWASP Top 10
- **ESLint Security**: Reglas específicas para Node.js

**Detecta:**

- Inyecciones SQL
- Cross-Site Scripting (XSS)
- Inyecciones de comandos
- Manejo inseguro de datos
- Criptografía débil
- Timing attacks

### SCA (Software Composition Analysis)

**Herramientas utilizadas:**

- **GitHub Dependency Review**: Análisis nativo de GitHub
- **Dependabot**: Alertas automáticas de vulnerabilidades
- **NPM Audit**: Análisis específico para Node.js
- **OWASP Dependency Check**: Análisis universal
- **Snyk**: Análisis avanzado (opcional)

**Detecta:**

- Vulnerabilidades conocidas (CVEs)
- Dependencias desactualizadas
- Licencias incompatibles
- Dependencias de alto riesgo

## 📊 Resultados y Reportes

### En Pull Requests

Los análisis generan comentarios automáticos con:

```markdown
## 🔍 SAST Analysis Summary

**Security Score:** 85/100
**Vulnerabilities Found:**

- 🚨 Critical: 0
- ⚠️ High: 2

## 📦 SCA Analysis Results

**Dependencies Security Status:**

- 🚨 Total Vulnerabilities: 3
- ⚠️ High Risk Dependencies: 1
- 📄 License Issues: 0
```

### En GitHub Security Tab

- **Code Scanning Alerts**: Resultados de CodeQL y Semgrep
- **Dependabot Alerts**: Vulnerabilidades de dependencias
- **Security Advisory**: CVEs detectados

### Artefactos Descargables

Cada ejecución genera artefactos con:

- Reportes detallados en JSON
- Resúmenes ejecutivos en Markdown
- Logs de análisis completos
- Reportes de licencias

## 🚪 Security Gates

### Criterios de Fallo

El workflow **bloquea el merge** si:

- **SAST**: Vulnerabilidades críticas > 0
- **SCA**: Dependencias de alto riesgo > 5
- **SCA**: Total de vulnerabilidades > 20 (warning, no bloqueo)

### Bypass de Security Gate

⚠️ **Solo en casos excepcionales:**

```yaml
# En el workflow principal, comentar esta línea:
# needs: [sast_analysis, sca_analysis]

# O crear un issue de excepción documentando:
# - Razón del bypass
# - Medidas de mitigación implementadas
# - Fecha de revisión programada
```

## 🔧 Troubleshooting

### Problemas Comunes

#### Error: "No CodeQL languages detected"

```bash
# Solución: Verificar que hay código fuente en microservice_path
ls -la mibanco-microservice/src/
```

#### Error: "npm audit failed"

```bash
# Solución: Verificar package-lock.json existe
cd mibanco-microservice && npm install
```

#### Error: "Permission denied to upload SARIF"

```bash
# Solución: Verificar permisos en workflow
permissions:
  security-events: write
  contents: read
```

### Configuración de Debugging

Habilitar logs detallados:

```yaml
env:
  ACTIONS_RUNNER_DEBUG: true
  ACTIONS_STEP_DEBUG: true
```

### Falsos Positivos

Para suprimir falsos positivos:

1. **CodeQL**: Usar `// lgtm[rule-id]` en el código
2. **Semgrep**: Usar `# nosemgrep: rule-id`
3. **ESLint**: Usar `// eslint-disable-next-line security/rule-name`

## 📞 Soporte

Para issues con las plantillas de seguridad:

1. **Verificar logs** en Actions tab
2. **Revisar configuración** de GHAS en el repositorio
3. **Consultar documentación** de [GitHub Advanced Security](https://docs.github.com/en/code-security)
4. **Crear issue** con logs y contexto del error

## 🔄 Actualizaciones

Las plantillas se actualizan regularmente para:

- Nuevas reglas de seguridad
- Mejores prácticas de la industria
- Nuevas herramientas y versiones
- Feedback del equipo de desarrollo

**Revisar actualizaciones:** Primer domingo de cada mes

---

_Última actualización: Septiembre 2025_
_Versión de plantillas: v1.0_
