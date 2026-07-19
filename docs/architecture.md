# CardioAI Colombia — Arquitectura del Sistema

**Versión:** 0.1.0  
**Fecha:** 2026-07-19

---

## 1. Visión General

```
┌─────────────────────────────────────────────────────────┐
│                     CLIENTE MÓVIL                       │
│          React Native + Expo (iOS / Android)            │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │  OCR Cam │  │Adherencia│  │ Historial│             │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘             │
└───────┼─────────────┼─────────────┼─────────────────────┘
        │             │             │  HTTPS / REST + WS
        ▼             ▼             ▼
┌─────────────────────────────────────────────────────────┐
│                  BACKEND API (FastAPI)                   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐             │
│  │OCR Service│  │Med Service│ │Alert Svc │             │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘             │
│       │             │              │                    │
│  ┌────┴─────────────┴──────────────┴─────┐             │
│  │           ML Engine (LSTM)            │             │
│  └───────────────────────────────────────┘             │
└─────────────┬───────────────────────────────────────────┘
              │  Supabase Client
              ▼
┌─────────────────────────────────────────────────────────┐
│                    SUPABASE                             │
│  PostgreSQL │ Auth │ Storage │ Realtime │ Edge Functions │
└─────────────────────────────────────────────────────────┘
```

## 2. Stack Tecnológico

| Capa | Tecnología | Justificación |
|------|-----------|---------------|
| Mobile | React Native + Expo | Cámara nativa, notificaciones push, cross-platform |
| OCR | Google ML Kit (on-device) | Funciona offline, privacidad, latencia ~200ms |
| Backend API | FastAPI (Python 3.12) | Ecosistema ML/PyTorch nativo, async, tipado |
| ML/LSTM | PyTorch + scikit-learn | Modelos ligeros para predicción de series temporales |
| Base de datos | Supabase (PostgreSQL) | Auth integrado, RLS, realtime, Storage para imágenes |
| Notificaciones | Expo Push Notifications | Recordatorios de medicamentos |
| CI/CD | GitHub Actions | Deploy automático |
| Hosting backend | Railway / Render | Costo bajo para MVP |

## 3. Módulos del Sistema

### 3.1 Feature: OCR
- Captura frame de video en tiempo real
- Ejecuta Google ML Kit Text Recognition (on-device)
- Parsea patrón `XXX/YY` (sistólica/diastólica) + FC
- Fallback: entrada manual con teclado numérico
- Confianza mínima 0.85 para aceptar lectura automática

### 3.2 Feature: Adherencia Farmacológica
- CRUD de medicamentos con dosis, frecuencia, horario
- Motor de reglas: genera eventos de dosis desde prescripción
- Notificaciones push en horarios configurados
- Registro de toma: tomada / omitida / tomada tarde
- Cálculo de índice de adherencia (%)

### 3.3 Feature: Predicción (Fase 2)
- Modelo LSTM entrenado sobre serie temporal: PA + adherencia + hora
- Input: últimas 14 lecturas + adherencia 7 días
- Output: probabilidad de evento >160/100 en próximas 24h
- Umbral de alerta: P > 0.70

### 3.4 Feature: Alertas
- Reglas estáticas MVP: PA sistólica >160 o diastólica >100
- Regla dinámica (post-LSTM): predicción de riesgo alto
- Canal: notificación push + modal en app
- Escalada: sugerencia de llamar al médico (nunca modificar dosis)

### 3.5 Feature: Auth
- OTP por SMS vía Supabase Auth + Twilio
- Sin contraseña: reduce abandono en usuario mayor
- RLS: cada usuario solo accede a sus datos

## 4. Seguridad y Privacidad

- Cifrado AES-256 en reposo (Supabase managed)
- TLS 1.3 en tránsito
- Row Level Security en todas las tablas
- No se almacenan imágenes de tensiómetro post-procesamiento (solo resultado)
- Política de retención: datos se eliminan a solicitud del usuario (Ley 1581/2012)
- Sin tracking publicitario

## 5. Modelo de Datos (Esquema Principal)

```sql
users          -- gestionado por Supabase Auth
readings       -- lectura PA: sistolica, diastolica, fc, timestamp, metodo(ocr|manual), confianza_ocr
medications    -- nombre, dosis_mg, frecuencia, hora_inicio, hora_fin, activo
doses          -- medicamento_id, scheduled_at, taken_at, status(taken|missed|late)
alerts         -- reading_id, tipo, severidad, notificado_at, accion_tomada
```
