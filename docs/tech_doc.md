# CardioAI Colombia — Documentación Técnica

**Versión:** 0.1.0  
**Fecha:** 2026-07-19

---

## 1. Requisitos del Entorno

### Mobile (apps/mobile)
- Node.js 20+
- Expo CLI (`npm install -g expo-cli`)
- Android Studio (emulador) o dispositivo físico
- iOS: Xcode 15+ (solo macOS)

### Backend (backend/)
- Python 3.12+
- uv (gestor de paquetes recomendado)
- PostgreSQL 15+ (vía Supabase)

### Infraestructura
- Cuenta Supabase (free tier suficiente para MVP)
- Cuenta GitHub

## 2. Variables de Entorno

### Mobile (.env en apps/mobile/)
```
EXPO_PUBLIC_SUPABASE_URL=
EXPO_PUBLIC_SUPABASE_ANON_KEY=
EXPO_PUBLIC_API_URL=
```

### Backend (.env en backend/)
```
SUPABASE_URL=
SUPABASE_SERVICE_ROLE_KEY=
DATABASE_URL=
SECRET_KEY=
ENVIRONMENT=development
```

## 3. Comandos Principales

```bash
# Mobile
cd apps/mobile
npm install
npx expo start

# Backend
cd backend
uv sync
uv run uvicorn app.main:app --reload

# Tests
cd backend && uv run pytest
cd apps/mobile && npx jest
```

## 4. Migraciones Supabase

```bash
# Crear nueva migración
supabase migration new nombre_migracion

# Aplicar en local
supabase db reset

# Push a producción
supabase db push
```

## 5. Convenciones de Código

### Python (backend)
- PEP 8 + Black formatter
- Type hints obligatorios en todas las funciones
- Pydantic v2 para schemas de API
- SQLAlchemy 2.0 ORM (async)

### TypeScript (mobile)
- ESLint + Prettier
- Props tipadas con TypeScript estricto
- Custom hooks para lógica de negocio
- Feature-driven: cada feature tiene su carpeta en `src/features/`

## 6. Flujo OCR — Detalle Técnico

```
Camera Frame (React Native Vision Camera)
    │
    ▼
Google ML Kit Text Recognition (on-device)
    │
    ▼
RegEx Parser: /(\d{2,3})\s*\/\s*(\d{2,3})/
    │
    ├── Confianza >= 0.85 → Confirmar automático
    └── Confianza < 0.85  → Solicitar confirmación manual
    │
    ▼
POST /api/v1/readings
    │
    ▼
Supabase → tabla readings
    │
    ▼
Trigger alert check (Edge Function)
```

## 7. Modelo LSTM — Especificación (Fase 2)

- **Input shape**: `(14, 5)` — 14 lecturas × [sistolica, diastolica, fc, adherencia_dia, hora_del_dia]
- **Arquitectura**: LSTM(64) → Dropout(0.2) → Dense(32) → Dense(1, sigmoid)
- **Output**: probabilidad de evento hipertensivo en 24h
- **Dataset mínimo**: 500 pacientes × 90 días = 45,000 lecturas
- **Métricas target**: AUC-ROC > 0.82, Sensibilidad > 0.78

## 8. Regulatorio INVIMA — Checklist Técnico

- [ ] Precisión OCR validada ≥ 98.5% en dataset de 1,000+ imágenes
- [ ] Trazabilidad completa de lecturas (audit log)
- [ ] Sin modificación de dosis por parte de la IA (verificado en código)
- [ ] Cifrado AES-256 demostrable
- [ ] Plan de gestión de riesgos ISO 14971
- [ ] Documentación de algoritmo (explicabilidad)
