# CardioAI Colombia — Product Requirements Document

**Versión:** 0.1.0  
**Fecha:** 2026-07-19  
**Estado:** Fase 0 — Planificación

---

## 1. Problema

Colombia registró 29,538 errores de medicación en 2018–2019 sobre 8.5M de pacientes ambulatorios.  
El 24.8% de eventos adversos medicamentosos son prevenibles. El 7% de hospitalizaciones están relacionadas con errores de medicación.

El paciente hipertenso promedio en Colombia enfrenta:
- Analfabetismo de dosificación: no entiende "tomar 12.5 mg" vs "tomar media tableta"
- Incapacidad de leer la pantalla del tensiómetro y transcribirla correctamente
- Ausencia de seguimiento entre consultas (meses de gap)
- Resistencia al tratamiento no detectada hasta hospitalización

## 2. Solución

Sistema inteligente que transforma tensiómetros convencionales en dispositivos predictivos mediante:

1. **OCR automático** — el celular lee la pantalla del tensiómetro con la cámara
2. **Gestor de adherencia** — traduce prescripciones a instrucciones prácticas con recordatorios
3. **Predicción LSTM** — anticipa picos hipertensivos por patrones circadianos
4. **Alerta clínica** — conecta con especialista cuando detecta patrones peligrosos

## 3. Usuarios Objetivo

| Segmento | Perfil | Canal |
|----------|--------|-------|
| Paciente B2C | 45-70 años, hipertenso crónico, bajo nivel tecnológico | App móvil freemium |
| EPS/Aseguradora B2B | Gestión de riesgo cardiovascular en afiliados | API + dashboard web |
| Médico/Especialista | Seguimiento remoto pacientes de alto riesgo | Web dashboard |

## 4. Alcance MVP (Meses 1-6)

### Incluido
- Captura OCR de tensiómetro vía cámara
- Registro manual de presión como fallback
- Gestor de medicamentos con recordatorios push
- Historial de lecturas con gráfica de tendencia
- Alertas básicas (presión > 140/90)
- Auth con teléfono celular (OTP)

### Excluido del MVP
- Modelo LSTM predictivo (requiere dataset de 500+ pacientes)
- Integración directa con EPS/HIS
- Text-to-speech
- Dashboard médico web

## 5. Métricas de Éxito

| Métrica | Meta MVP | Meta 12 meses |
|---------|----------|---------------|
| Precisión OCR | >90% | >98.5% (req. INVIMA) |
| Retención 30 días | >40% | >60% |
| Errores de medicación reportados | baseline | -30% |
| Pacientes piloto | 50 | 500 |

## 6. Restricciones Críticas

- **La IA no prescribe**: nunca instruir al paciente a modificar dosis; solo recomendar consulta médica
- **Regulatorio INVIMA**: clasificación SaMD Clase IIa/IIb requiere validación antes de comercialización
- **Privacidad**: datos de salud bajo Ley 1581/2012 + cifrado AES-256 obligatorio
- **Precisión OCR**: mínimo 98.5% para certificación INVIMA; MVP puede operar a >90% en modo beta

## 7. Modelo de Negocio

| Tier | Precio | Características |
|------|--------|-----------------|
| Freemium | $0 | Historial 30 días, 1 medicamento |
| Personal | $15,000 COP/mes | Historial ilimitado, alertas, hasta 5 medicamentos |
| B2B EPS | Negociación | API, dashboard, reportes poblacionales |
