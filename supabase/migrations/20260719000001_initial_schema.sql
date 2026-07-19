-- CardioAI Colombia — Schema inicial
-- Migración: 20260719000001_initial_schema

-- Extensiones
create extension if not exists "uuid-ossp";

-- ─── READINGS ──────────────────────────────────────────────────────────────
create table public.readings (
  id            uuid primary key default uuid_generate_v4(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  sistolica     smallint not null check (sistolica between 50 and 300),
  diastolica    smallint not null check (diastolica between 30 and 200),
  frecuencia    smallint check (frecuencia between 30 and 250),
  metodo        text not null check (metodo in ('ocr', 'manual')) default 'manual',
  confianza_ocr numeric(4,3) check (confianza_ocr between 0 and 1),
  notas         text,
  medido_at     timestamptz not null default now(),
  created_at    timestamptz not null default now()
);

-- ─── MEDICATIONS ────────────────────────────────────────────────────────────
create table public.medications (
  id            uuid primary key default uuid_generate_v4(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  nombre        text not null,
  dosis_mg      numeric(8,2),
  dosis_texto   text not null, -- "1 tableta", "media tableta", etc.
  frecuencia_h  smallint not null, -- cada cuántas horas
  hora_inicio   time not null,
  activo        boolean not null default true,
  created_at    timestamptz not null default now()
);

-- ─── DOSES ──────────────────────────────────────────────────────────────────
create table public.doses (
  id              uuid primary key default uuid_generate_v4(),
  user_id         uuid not null references auth.users(id) on delete cascade,
  medication_id   uuid not null references public.medications(id) on delete cascade,
  scheduled_at    timestamptz not null,
  taken_at        timestamptz,
  status          text not null check (status in ('pending', 'taken', 'missed', 'late')) default 'pending',
  created_at      timestamptz not null default now()
);

-- ─── ALERTS ─────────────────────────────────────────────────────────────────
create table public.alerts (
  id              uuid primary key default uuid_generate_v4(),
  user_id         uuid not null references auth.users(id) on delete cascade,
  reading_id      uuid references public.readings(id) on delete set null,
  tipo            text not null check (tipo in ('hipertension_critica', 'hipertension_alta', 'prediccion_riesgo')),
  severidad       text not null check (severidad in ('warning', 'critical')),
  mensaje         text not null,
  notificado_at   timestamptz,
  accion_tomada   text,
  created_at      timestamptz not null default now()
);

-- ─── ROW LEVEL SECURITY ─────────────────────────────────────────────────────
alter table public.readings    enable row level security;
alter table public.medications enable row level security;
alter table public.doses       enable row level security;
alter table public.alerts      enable row level security;

-- Políticas: solo el propio usuario accede a sus datos
create policy "readings_own" on public.readings
  using (auth.uid() = user_id);

create policy "medications_own" on public.medications
  using (auth.uid() = user_id);

create policy "doses_own" on public.doses
  using (auth.uid() = user_id);

create policy "alerts_own" on public.alerts
  using (auth.uid() = user_id);

-- ─── ÍNDICES ────────────────────────────────────────────────────────────────
create index idx_readings_user_medido    on public.readings(user_id, medido_at desc);
create index idx_doses_user_scheduled   on public.doses(user_id, scheduled_at);
create index idx_doses_medication       on public.doses(medication_id, scheduled_at);
create index idx_alerts_user_created    on public.alerts(user_id, created_at desc);
