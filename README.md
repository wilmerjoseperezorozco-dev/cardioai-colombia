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

---

## 🌐 Overview · Resumen

<table>
<tr>
<td width="50%">

### 🇬🇧 English

**AI-powered hypertension monitoring and medication verification for Colombia** — on-device OCR, LSTM risk prediction, no prescription, no misdiagnosis.

**What it solves:** Colombia records ~29,500 outpatient medication errors per year. The average hypertensive patient cannot reliably read their blood pressure monitor, does not understand their dosage, and has no follow-up between clinic visits. This system closes the gap between appointments with tools that work on an ordinary smartphone.

**At maturity:**
1. **Automatic OCR** — phone camera reads the blood pressure monitor screen, eliminating manual transcription errors
2. **Medication adherence** — smart reminders in plain language, adapted to the patient's literacy level
3. **Risk prediction** — an LSTM model (Phase 2) anticipates hypertensive peaks before they occur
4. **Clinical alert** — connects to a specialist when dangerous patterns are detected

> **The AI never prescribes.** The system does not instruct the patient to modify doses under any circumstance. Regulatory classification: SaMD Class IIa/IIb (INVIMA).

**Quick start:**
```bash
# Backend
cd backend && uv sync
uv run uvicorn app.main:app --reload

# Mobile
cd apps/mobile && npm install
npx expo start
```

**Status:** Phase 0 complete · Phase 1 in progress (infrastructure + core API). Stack: React Native + Expo · Google ML Kit (on-device OCR) · FastAPI · PyTorch LSTM · Supabase.

</td>
<td width="50%">

### 🇨🇴 Español

**Monitoreo inteligente de hipertensión y verificación de medicamentos para Colombia** — OCR en el dispositivo, predicción LSTM de riesgo, sin prescripción, sin diagnóstico erróneo.

**Qué resuelve:** Colombia registra ~29.500 errores de medicación anuales en pacientes ambulatorios. El paciente hipertenso promedio no puede leer correctamente su tensiómetro, no entiende sus dosis y no tiene seguimiento entre consultas. Este sistema cierra la brecha entre citas médicas con herramientas que funcionan en un smartphone corriente.

**En fase madura:**
1. **OCR automático** — la cámara del celular lee la pantalla del tensiómetro, eliminando errores de transcripción manual
2. **Adherencia farmacológica** — recordatorios inteligentes en lenguaje simple, adaptados al nivel de alfabetización del paciente
3. **Predicción de riesgo** — un modelo LSTM (Fase 2) anticipa picos hipertensivos antes de que ocurran
4. **Alerta clínica** — conecta con un especialista cuando se detectan patrones peligrosos

> **La IA no prescribe.** El sistema nunca instruye al paciente a modificar dosis bajo ninguna circunstancia. Clasificación regulatoria: SaMD Clase IIa/IIb (INVIMA).

**Inicio rápido:**
```bash
# Backend
cd backend && uv sync
uv run uvicorn app.main:app --reload

# Móvil
cd apps/mobile && npm install
npx expo start
```

**Estado:** Fase 0 completa · Fase 1 en progreso (infraestructura + API núcleo). Stack: React Native + Expo · Google ML Kit (OCR en dispositivo) · FastAPI · PyTorch LSTM · Supabase.

</td>
</tr>
</table>
