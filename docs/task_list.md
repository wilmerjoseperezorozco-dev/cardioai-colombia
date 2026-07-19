# CardioAI Colombia — Lista de Tareas

**Actualizado:** 2026-07-19

---

## Fase 0 — Planificación ✅

- [x] PRD v0.1
- [x] Arquitectura del sistema
- [x] Documentación técnica
- [x] Estructura de carpetas
- [x] README inicial
- [x] .gitignore
- [x] GitHub Actions CI básico
- [x] Schema SQL inicial (migrations)

---

## Fase 1 — Infraestructura Base

### Backend
- [ ] Inicializar proyecto FastAPI con uv
- [ ] Configurar Supabase local con supabase CLI
- [ ] Crear migrations: users, readings, medications, doses, alerts
- [ ] Aplicar RLS policies en todas las tablas
- [ ] Endpoint de health check `/api/v1/health`
- [ ] Auth middleware con Supabase JWT
- [ ] Tests de infraestructura (conexión DB, auth)

### Mobile
- [ ] Inicializar Expo con TypeScript template
- [ ] Instalar dependencias: supabase-js, expo-camera, react-navigation
- [ ] Configurar variables de entorno con expo-constants
- [ ] Pantalla de splash + onboarding básico
- [ ] Flujo de auth OTP (teléfono → SMS → verificar)
- [ ] Navegación bottom tab: Inicio / Medicamentos / Historial / Perfil

---

## Fase 2 — Estados Vacíos + E2E

### OCR Feature
- [ ] Integrar react-native-vision-camera
- [ ] Integrar @react-native-ml-kit/text-recognition
- [ ] Parser regex para patrón sistólica/diastólica
- [ ] UI de cámara con overlay de guía
- [ ] Confirmación de lectura antes de guardar
- [ ] Fallback input manual

### Adherencia Feature
- [ ] CRUD medicamentos (nombre, dosis, frecuencia, horario)
- [ ] Generación automática de eventos de dosis
- [ ] Notificaciones push con expo-notifications
- [ ] Registro de toma (tomada/omitida/tarde)
- [ ] Índice de adherencia semanal

### Historial Feature
- [ ] Lista de lecturas paginada
- [ ] Gráfica de tendencia (react-native-svg / victory-native)
- [ ] Filtro por rango de fechas

### Alertas Feature
- [ ] Reglas estáticas: PA >160/100
- [ ] Modal de alerta en app
- [ ] Notificación push de alerta
- [ ] Disclaimer legal anti-prescripción

---

## Fase 3 — Pre-entrega Piloto (500 pacientes)

- [ ] Validación OCR: dataset 1,000 imágenes tensiómetros colombianos
- [ ] Onboarding UX optimizado para usuario 45-70 años
- [ ] Modo offline (lecturas manuales sin conexión, sync al reconectar)
- [ ] Política de privacidad y términos de uso
- [ ] Preparación dossier INVIMA

---

## Fase 4 — Iteración + LSTM

- [ ] Recolección de 45,000+ lecturas (piloto)
- [ ] Entrenamiento modelo LSTM v1
- [ ] Validación clínica con médicos
- [ ] Integración predicción en alertas
- [ ] Dashboard web para médicos (Next.js)
- [ ] API B2B para EPS
