# CardioAI Colombia

Sistema inteligente de monitoreo de hipertensión y verificación de medicamentos para el contexto colombiano.

> **Estado:** Fase 0 — Planificación completada | Fase 1 en progreso

## El problema

Colombia registra ~29,500 errores de medicación anuales en pacientes ambulatorios. El paciente hipertenso promedio no puede leer su tensiómetro correctamente, no entiende sus dosis, y no tiene seguimiento entre consultas.

## La solución

1. **OCR automático** — el celular lee la pantalla del tensiómetro sin error humano
2. **Adherencia farmacológica** — recordatorios inteligentes traducidos a lenguaje simple
3. **Predicción de riesgo** — modelo LSTM anticipa picos hipertensivos (Fase 2)
4. **Alerta clínica** — conecta con especialista ante patrones peligrosos

## Stack

| Capa | Tecnología |
|------|-----------|
| Mobile | React Native + Expo |
| OCR | Google ML Kit (on-device) |
| Backend | FastAPI (Python 3.12) |
| ML | PyTorch (LSTM) |
| Base de datos | Supabase (PostgreSQL) |

## Estructura del Proyecto

```
cardioai-colombia/
├── apps/mobile/          # App React Native + Expo
├── backend/              # API FastAPI + modelos ML
│   ├── app/
│   │   ├── api/          # Endpoints REST
│   │   ├── models/       # Modelos SQLAlchemy / Pydantic
│   │   └── services/     # Lógica de negocio
│   └── ml/               # Modelos LSTM
├── supabase/             # Migraciones y config local
│   └── migrations/
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
└── docs/                 # PRD, arquitectura, docs técnicos
```

## Inicio Rápido

```bash
# Clonar
git clone https://github.com/[usuario]/cardioai-colombia.git
cd cardioai-colombia

# Backend
cd backend
pip install uv
uv sync
cp .env.example .env  # configurar variables
uv run uvicorn app.main:app --reload

# Mobile
cd apps/mobile
npm install
cp .env.example .env
npx expo start
```

## Documentación

- [PRD](docs/PRD.md) — Requisitos del producto
- [Arquitectura](docs/architecture.md) — Diseño del sistema
- [Docs técnicos](docs/tech_doc.md) — Setup y convenciones
- [Tareas](docs/task_list.md) — Roadmap de implementación

## Regulatorio

Software clasificado como dispositivo médico SaMD (Clase IIa/IIb según INVIMA).  
**La IA no prescribe.** El sistema nunca instruye al paciente a modificar dosis.

## Licencia

Propietario — © 2026 Wilmer Pérez Orozco / Tubará Labs
