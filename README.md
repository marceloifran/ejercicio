# Webhook Processing Service (Technical Test)

Este es un servicio backend desarrollado en Ruby utilizando el framework **Sinatra**. El servicio expone un endpoint de webhook que procesa mensajes entrantes y responde según la lógica de negocio definida.

## 🚀 Características

- **Sinatra:** Framework web ligero y rápido.
- **Arquitectura Limpia:** Separación de responsabilidades entre el punto de entrada, servicios y modelos.
- **Procesamiento de Mensajes:** Lógica centralizada en `MessageProcessor`.
- **Persistencia en Memoria:** Los mensajes se almacenan durante la ejecución en `MessageStore`.
- **Dockerizado:** Listo para desplegar en cualquier entorno.
- **Tests con RSpec:** Suite de pruebas automatizadas para asegurar la calidad.

## 📁 Estructura del Proyecto

```text
.
├── app.rb                # Punto de entrada de la aplicación Sinatra
├── services/
│   └── message_processor.rb # Lógica de procesamiento de mensajes
├── models/
│   └── message_store.rb     # Almacenamiento en memoria (Singleton)
├── spec/                 # Suite de pruebas (RSpec)
├── Dockerfile            # Configuración para contenedor Docker
├── Gemfile               # Dependencias del proyecto
└── config.ru             # Configuración para servidores Rack (Puma)
```

## 🛠️ Requisitos Previos

- Ruby 3.x (si se ejecuta localmente)
- Bundler (`gem install bundler`)
- Docker (si se prefiere ejecutar en contenedor)

## 🏃 Cómo ejecutar localmente

1. Instalar dependencias:
   ```bash
   bundle install
   ```

2. Ejecutar la aplicación:
   ```bash
   ruby app.rb
   ```
   El servidor iniciará en `http://localhost:4567`.

## 🐳 Cómo ejecutar con Docker

1. Construir la imagen:
   ```bash
   docker build -t ruby-webhook .
   ```

2. Ejecutar el contenedor:
   ```bash
   docker run -p 4567:4567 ruby-webhook
   ```

## 🧪 Ejecutar Tests

Para validar el funcionamiento del sistema, utiliza RSpec:

```bash
bundle exec rspec
```

## 📡 Ejemplo de Request

### Solicitud de Información

**Request:**
`POST /webhook`
```json
{
  "phone": "123456789",
  "message": "Hola, necesito información"
}
```

**Response (200 OK):**
```json
{
  "response": "Gracias por tu interés. En breve te contactaremos."
}
```

### Solicitud de Precio

**Request:**
`POST /webhook`
```json
{
  "phone": "123456789",
  "message": "¿Cuál es el precio?"
}
```

**Response (200 OK):**
```json
{
  "response": "Nuestros precios comienzan desde 29€ al mes."
}
```

### Validaciones (Error)

**Request (Falta campo):**
`POST /webhook`
```json
{
  "phone": "123456789"
}
```

**Response (400 Bad Request):**
```json
{
  "error": "Invalid request"
}
```

## 💡 Decisiones Técnicas

1. **Sinatra vs Rails:** Se eligió Sinatra por su ligereza, ideal para microservicios y pruebas técnicas donde no se requiere el overhead de un framework completo como Rails.
2. **Arquitectura de Modelos:** Se introdujo una clase `Message` para representar la entidad de datos, promoviendo un código más tipado y estructurado en lugar de manejar hashes planos.
3. **MessageProcessor (Service Pattern):** Se separó la lógica de negocio de la capa de transporte (HTTP) siguiendo el patrón de servicio, lo que facilita los tests unitarios y la escalabilidad.
4. **MessageStore (Singleton):** Para cumplir con el requisito de persistencia en memoria, se utilizó el patrón Singleton asegurando un único punto de verdad durante la ejecución.
5. **Validaciones y Seguridad:** Se implementó una verificación estricta de campos obligatorios y manejo de errores JSON. Además, se incluyeron archivos de configuración `.gitignore` y `.dockerignore` para seguir estándares profesionales de desarrollo.
