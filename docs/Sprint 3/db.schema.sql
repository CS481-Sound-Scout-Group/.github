CREATE TABLE IF NOT EXISTS supported_cities (
  city_id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  city_name      TEXT NOT NULL,
  state          TEXT,
  country        TEXT DEFAULT 'USA',
  is_active      BOOLEAN NOT NULL DEFAULT TRUE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (city_name, state, country)
);

CREATE TABLE IF NOT EXISTS classifiable_sounds (
  sound_id       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  label          TEXT NOT NULL UNIQUE,
  description    TEXT,
  is_active      BOOLEAN NOT NULL DEFAULT TRUE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS audio_sources (
  source_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source_type    TEXT NOT NULL,
  device_id      TEXT,
  city_id        UUID REFERENCES supported_cities(city_id),
  latitude       DOUBLE PRECISION,
  longitude      DOUBLE PRECISION,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS classification_results (
  result_id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source_id      UUID REFERENCES audio_sources(source_id),
  sound_id       UUID REFERENCES classifiable_sounds(sound_id),
  confidence     REAL CHECK (confidence >= 0 AND confidence <= 1),
  model_version  TEXT,
  captured_at    TIMESTAMPTZ,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  metadata       JSONB
);

CREATE INDEX IF NOT EXISTS idx_results_created_at 
ON classification_results(created_at DESC);

CREATE INDEX IF NOT EXISTS idx_results_source_id 
ON classification_results(source_id);

CREATE INDEX IF NOT EXISTS idx_results_sound_id 
ON classification_results(sound_id);
