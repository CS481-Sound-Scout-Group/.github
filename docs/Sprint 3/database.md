# Database Design – Sound Scout

## Overview

The Sound Scout database is a normalized PostgreSQL relational schema designed to support sound classification results and associated metadata.

---

## Tables

### supported_cities

Stores supported geographic regions for sound capture.

| Column        | Type        | Description |
|--------------|------------|-------------|
| city_id      | SERIAL PK  | Unique city identifier |
| city_name    | TEXT       | City name |
| state        | TEXT       | State or region |
| country      | TEXT       | Default 'USA' |
| is_active    | BOOLEAN    | Active status flag |
| created_at   | TIMESTAMP  | Record creation time |

---

### classifiable_sounds

Stores supported sound labels.

| Column        | Type        | Description |
|--------------|------------|-------------|
| sound_id     | SERIAL PK  | Unique sound identifier |
| label        | TEXT       | Sound label (unique) |
| description  | TEXT       | Description of sound |
| is_active    | BOOLEAN    | Active status |
| created_at   | TIMESTAMP  | Record creation time |

---

### audio_sources

Stores metadata about where audio originated.

| Column        | Type        | Description |
|--------------|------------|-------------|
| source_id    | SERIAL PK  | Unique source identifier |
| source_type  | TEXT       | Device or input type |
| device_id    | TEXT       | Device identifier |
| city_id      | INT FK     | References supported_cities |
| latitude     | DOUBLE     | Latitude coordinate |
| longitude    | DOUBLE     | Longitude coordinate |
| created_at   | TIMESTAMP  | Record creation time |

---

### classification_results

Stores model predictions.

| Column         | Type         | Description |
|---------------|-------------|-------------|
| result_id     | BIGSERIAL PK| Unique result identifier |
| source_id     | INT FK      | References audio_sources |
| sound_id      | INT FK      | References classifiable_sounds |
| confidence    | REAL        | Confidence score (0–1) |
| model_version | TEXT        | Model version used |
| captured_at   | TIMESTAMP   | Timestamp of capture |
| created_at    | TIMESTAMP   | Record creation time |
| metadata      | JSONB       | Flexible additional data |

---

## Relationships

- `audio_sources.city_id` → `supported_cities.city_id`
- `classification_results.source_id` → `audio_sources.source_id`
- `classification_results.sound_id` → `classifiable_sounds.sound_id`

