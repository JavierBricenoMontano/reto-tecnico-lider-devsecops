// Configuración ESLint optimizada para Node.js/Express - MiBanco
// Este archivo se usa automáticamente en el template SAST

module.exports = {
  env: {
    node: true,
    es2021: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:security/recommended',
    'plugin:@microsoft/sdl/recommended'
  ],
  plugins: [
    'security',
    'node-security',
    '@microsoft/sdl'
  ],
  parserOptions: {
    ecmaVersion: 2021,
    sourceType: 'module',
  },
  rules: {
    // Reglas de seguridad críticas para Node.js
    'security/detect-object-injection': 'error',
    'security/detect-eval-with-expression': 'error',
    'security/detect-unsafe-regex': 'error',
    'security/detect-buffer-noassert': 'error',
    'security/detect-new-buffer': 'error',
    'security/detect-no-csrf-before-method-override': 'error',
    'security/detect-disable-mustache-escape': 'error',
    
    // Reglas importantes específicas para Express.js
    'security/detect-child-process': 'warn',
    'security/detect-non-literal-fs-filename': 'warn',
    'security/detect-non-literal-regexp': 'warn',
    'security/detect-non-literal-require': 'warn',
    'security/detect-possible-timing-attacks': 'warn',
    'security/detect-pseudoRandomBytes': 'error',
    
    // Reglas específicas de Node.js security
    'security/detect-bidi-characters': 'error',
    
    // Reglas Microsoft SDL
    '@microsoft/sdl/no-html-method': 'error',
    '@microsoft/sdl/no-insecure-url': 'error',
    '@microsoft/sdl/no-unsafe-alloc': 'error',
    
    // Reglas adicionales de seguridad para APIs REST
    'no-eval': 'error',
    'no-implied-eval': 'error',
    'no-new-func': 'error',
    'no-script-url': 'error',
    'no-proto': 'error',
    
    // Prevención de inyecciones en plantillas
    'no-template-curly-in-string': 'warn',
    
    // Validación de entrada para Express
    'no-param-reassign': ['warn', { 
      props: true, 
      ignorePropertyModificationsFor: ['req', 'request', 'res', 'response', 'app'] 
    }],
    
    // Prevención de exposición de información sensible
    'no-console': 'warn', // Evitar logs accidentales en producción
    'no-debugger': 'error',
    'no-alert': 'error',
    
    // Reglas específicas para microservicios
    'no-process-env': 'off', // Permitir process.env para configuración
    'no-process-exit': 'warn', // Controlar uso de process.exit()
  },
  overrides: [
    {
      // Configuración específica para archivos de test (si los hay)
      files: ['**/*.test.js', '**/*.spec.js', '**/test/**/*.js', '**/tests/**/*.js'],
      rules: {
        'security/detect-non-literal-fs-filename': 'off',
        'security/detect-child-process': 'off',
        'no-console': 'off'
      }
    },
    {
      // Configuración específica para archivos de configuración
      files: ['**/*.config.js', '.eslintrc.*.js'],
      rules: {
        'security/detect-non-literal-require': 'off',
        'no-console': 'off'
      }
    }
  ]
};