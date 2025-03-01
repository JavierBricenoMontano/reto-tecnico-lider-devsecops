# Microservicio Mibanco

Un microservicio simple que responde con "Hola Mibanco" desarrollado para un challenge de DevOps.

## Estructura del Proyecto

```
/
├── src/                      # Código fuente de la aplicación
├── kubernetes/               # Manifiestos de Kubernetes
├── .github/workflows/        # Workflows de GitHub Actions
├── Dockerfile                # Instrucciones para construir la imagen
└── ...
```

## Características

- Microservicio NodeJS con Express
- Despliegue automatizado en AKS mediante GitHub Actions
- Manifiesto de Kubernetes para deployment, servicio, HPA e ingress
- Integración con Azure Container Registry (ACR)

## Requisitos

- Node.js 18+
- Docker
- Kubernetes (AKS)
- Azure CLI
- Acceso a Azure Container Registry

## Configuración local

1. Instalar dependencias:

   ```
   npm install
   ```

2. Ejecutar localmente:

   ```
   npm start
   ```

3. El servicio estará disponible en http://localhost:3000

## Despliegue

El despliegue se realiza automáticamente mediante GitHub Actions cuando se hace push a la rama main.

### Secretos requeridos

Configura los siguientes secretos en tu repositorio GitHub:

- `AZURE_CREDENTIALS`: Credenciales de Azure Service Principal
- `ACR_USERNAME`: Usuario para Azure Container Registry
- `ACR_PASSWORD`: Contraseña para Azure Container Registry

## Endpoints

- `GET /`: Retorna el mensaje "Hola Mibanco"
- `GET /health`: Endpoint de verificación de salud
